# 쥬라기원시전2 CHR추출기

쥬라기원시전2의 유닛 데이터 파일(CHR)은 능력치와 그래픽, 사운드, 팔레트를 통째로 품고 있는 묶음 파일이다. 헤더 구조를 분석하고, 그 결과를 바탕으로 CHR 안의 리소스를 낱개 파일로 꺼내는 추출기다. 헤더를 읽어 개수와 길이를 해석하므로 유닛마다 다른 구성에도 맞춰 동작한다.

분석 결과는 [docs/chr-format.ko.md](docs/chr-format.ko.md) 에 정리해뒀다.

<p>
  <img src="docs/screenshots/screenshot-1.png" width="306" alt="추출 화면">
</p>


## 사용 방법

Releases에서 받아 압축을 풀고 실행한 뒤 추출 버튼을 누르면 파일 선택창이 뜬다. 추출할 `.chr` 파일을 고르고, 그다음 뜨는 폴더 선택창에서 결과를 저장할 위치를 정하면 알아서 진행된다.

저장 폴더에는 이렇게 나온다.

| 경로 | 내용 |
|---|---|
| `<파일명>.cei` | 유닛 능력치 |
| `spr/j00_m0.pnt` | 팔레트 |
| `spr/*.spz` | 유닛 이미지, 애니메이션 종류별로 이름이 붙는다 |
| `sound/*.wav` | 유닛 사운드 |

저장 폴더에 같은 이름의 파일이 이미 있으면 뒤 번호를 올려 새로 만든다.


## 구현 원리

**여러 바이트짜리 헤더 필드를 읽는 함수를 하나 만들어 돌려썼다.** 위치와 바이트 수를 넘기면 그만큼을 뒤에서부터 읽어 리틀엔디언으로 조립한다. 값을 받을 변수도 이름을 문자열로 넘겨서 `variable_local_set` 으로 채우게 했다. 헤더에 개수 필드가 스무 개 넘게 흩어져 있어서 한 줄씩 호출하는 방식이 간단하다.

```gml
// sk_load_data(변수명, 위치, 파일, 바이트수)
file_bin_seek(argument2, argument1)
for(v=argument3-1; v!=-1; v-=1)
{
  file_bin_seek(argument2, argument1+v)
  variable_local_set(argument0,
    variable_local_get(argument0) + sk_hex_conversion(file_bin_read_byte(argument2)))
}
variable_local_set(argument0, sk_dec_conversion(variable_local_get(argument0)))
```

```gml
sk_load_data("rmax", 8720, files, 4)   // 이미지 전체 개수
sk_load_data("rmg",  8724, files, 4)   // 경계
sk_load_data("rmm",  8728, files, 4)   // 이동
sk_load_data("rma",  8732, files, 4)   // 공격
...
```

위 오프셋은 소스에 10진수로 쓰여 있다. 분석 자료([docs/chr-format.ko.md](docs/chr-format.ko.md))의 16진수와 같은 값이다.

**애니메이션 종류별 개수를 카운터로 깎아서 파일 이름을 붙인다.** 헤더는 어느 스프라이트가 어느 동작인지를 따로 적어두지 않고 종류별 개수만 적어둔다. 대신 순서가 항상 같아서, 개수를 하나씩 깎아가며 지금 차례가 어느 동작인지 되돌려주는 함수를 만들었다. 그래서 추출된 파일이 `m0000.spz` 처럼 동작 이름을 달고 나온다.

```gml
// sk_spr_name()
if real(rmg)>0{rmg=string(real(rmg)-1); return "g"}
else if real(rmm)>0{rmm=string(real(rmm)-1); return "m"}
else if real(rma)>0{rma=string(real(rma)-1); return "a"}
...
```

**추출은 알람으로 단계를 끊어 돌린다.** 게임메이커는 한 이벤트가 오래 돌면 창이 멈춘다. 그래서 `progress` 변수로 단계를 나누고 알람이 울릴 때마다 한 단계씩 진행하게 했다. 덕분에 단계 사이에 화면을 다시 그릴 틈이 생겨서 "spz추출중" 같은 진행 상태를 띄울 수 있다.

| 단계 | 하는 일 |
|---|---|
| 0 | 헤더의 개수 필드를 전부 읽는다 |
| 1 | 고정 구간인 CEI와 PNT를 잘라낸다 |
| 2 | SPZ를 하나씩 꺼낸다 |
| 3 | WAV를 하나씩 꺼낸다 |
| 4 | 마지막 알람에서 완료 메시지를 띄우고 처음 화면으로 돌아간다 |

**SPZ와 WAV는 길이가 제각각이라 항목마다 헤더를 다시 읽는다.** 시작 위치에서 조금 떨어진 자리에 그 항목의 길이가 적혀 있다. 그 값을 읽어 그만큼 잘라내고, 커서를 그만큼 밀어 다음 항목으로 넘어간다. 개수를 다 소진할 때까지 반복한다.

```gml
while(real(rmax) > 0)
{
  sk_load_data("goto", susk+24, files, 4); goto = string(real(goto)+32)
  ...
  file_bin_seek(files, susk)
  repeat(real(goto)){ file_bin_write_byte(files2, file_bin_read_byte(files)) }
  susk += real(goto)
}
```


## 파일

| 경로 | 내용 |
|---|---|
| `source/jw2-chr-extractor.gmk` | 원본 프로젝트 파일 |
| `source/split/` | GmkSplitter로 분해한 텍스트 트리 |
| `docs/chr-format.ko.md` | CHR 헤더 오프셋 분석 자료 |
| `docs/screenshots/` | 스크린샷 |
| Releases | 실행 파일과 사용 설명 |


## 크레딧

한글 출력 스크립트(`source/split/Scripts/한글드로우/`)는 게임메이커 커뮤니티의 김게맛(sodium031)님이 만든 것이다.


## 라이선스

zlib 라이선스다. 자세한 내용은 [LICENSE](LICENSE) 에 있다. 함께 들어 있는 것 중 다른 사람이 만든 라이브러리는 각자의 라이선스를 따른다.
