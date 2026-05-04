## 에이전트가 멈춘 적 있나요?

API 잔액 소진. DeepSeek 속도 제한. OpenAI 장애. 에이전트가 80% 완료했을 때——침묵.

사용자는 "또 고장났네"라고 생각할 뿐입니다. 세 번이면 끝입니다.

---

## Zero Token이 하는 일

"백업"이 아닙니다. "성능 저하"도 아닙니다. **눈에 보이지 않는 전환**입니다.

메인 모델이 죽는 순간, 13개의 무료 LLM이 이미 실행 중입니다. 같은 페르소나, 같은 판단, 같은 말투. 아무도 전환을 알아채지 못합니다.

**$0. 무중단. 완전 투명.**

---

## 두 줄, 1분

```bash
openclaw skills install zero-token
bash ~/.openclaw/workspace/skills/zero-token/scripts/setup.sh
```

[Free-Way](https://github.com/GoDiao/Free-Way) 게이트웨이가 13개 이상의 무료 LLM 제공업체를 하나의 `/v1` 엔드포인트로 통합. OpenClaw가 폴백으로 사용. 메인 모델 장애 → 자동 전환. 에이전트는 계속 작동.

---

## 두 가지 모드

| 모드 | 조건 | 결과 |
|------|------|------|
| 🆓 무료 모드 | API 키 없음 | 완전 무료 모델로 실행, SOUL 페르소나 유지 |
| 🛡️ 인계 모드 | 메인 모델 다운 / 토큰 소진 | 자동 무료 제공업체 전환, 작업 계속 |

---

## 무료 ≠ 쓰레기

무료 모델의 원시 출력은 평범합니다. 하지만 `::GENE{}` 행동 DNA를 올리면——같은 페르소나, 같은 판단, 같은 말투. DeepSeek V4 Pro인지 Llama 3.3 70B인지 아무도 구분 못 합니다.

---

## 왜 무료인가

Free-Way + Zero Token은 오픈소스. 모든 제공업체가 무료 티어 제공:

| 제공업체 | 무료 한도 | 추천 모델 |
|----------|----------|----------|
| Groq | 1000 req/일 | Llama 3.3 70B |
| Gemini Flash | 1500 req/일 | Gemini 2.5 Flash |
| Cerebras | 1700 req/일 | Llama 3.3 70B |
| Cloudflare | 1만 neurons/일 | Llama 3.1 8B |
| OpenRouter | 200 req/일 | 여러 무료 모델 |
| Mistral | 1 req/초 | Mistral Small |
| Cohere | 20 req/분 | Command R+ |
| NVIDIA NIM | 무료 티어 | Llama 3.3 70B |

키 등록은 각 30초. 셋업 스크립트가 안내.

---

## 비교

| | 일반 구성 | Zero Token |
|---|---|---|
| 모델 비용 | $0.14–$15.00/M tokens | **$0.00** |
| 장애 대응 | 완전 정지 | 투명한 페일오버 |
| 백업 모델 | 0 | 13+ |
| 에이전트 페르소나 | 폴백 시 상실 | 항상 일관 |
| 셋업 시간 | 반나절 (로드밸런싱) | 1분 |

---

## 업그레이드

Zero Token은 상시 가동을 보장. 최고 출력 품질을 원한다면——DeepSeek V4 Pro + 완전 게놈, Opus의 3%:

```bash
openclaw skills install poor-mans-opus
```
