From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: warn on smu interface version mismatch
Date: Wed, 26 Jun 2019 06:24:19 +0000
Message-ID: <20190626062402.18551-1-xiaojie.yuan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZdWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jIHwgMyArLS0NCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jDQppbmRleCBjM2Y0OGZhZTZmMzIuLjMzOWQw
NjNlMjRmZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92
MTFfMC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYw0K
QEAgLTI3Miw4ICsyNzIsNyBAQCBzdGF0aWMgaW50IHNtdV92MTFfMF9jaGVja19md192ZXJzaW9u
KHN0cnVjdCBzbXVfY29udGV4dCAqc211KQ0KIAkJCSJzbXUgZncgdmVyc2lvbiA9IDB4JTA4eCAo
JWQuJWQuJWQpXG4iLA0KIAkJCXNtdS0+c21jX2lmX3ZlcnNpb24sIGlmX3ZlcnNpb24sDQogCQkJ
c211X3ZlcnNpb24sIHNtdV9tYWpvciwgc211X21pbm9yLCBzbXVfZGVidWcpOw0KLQkJcHJfZXJy
KCJTTVUgZHJpdmVyIGlmIHZlcnNpb24gbm90IG1hdGNoZWRcbiIpOw0KLQkJcmV0ID0gLUVJTlZB
TDsNCisJCXByX3dhcm4oIlNNVSBkcml2ZXIgaWYgdmVyc2lvbiBub3QgbWF0Y2hlZFxuIik7DQog
CX0NCiANCiAJcmV0dXJuIHJldDsNCi0tIA0KMi4yMC4xDQoNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
