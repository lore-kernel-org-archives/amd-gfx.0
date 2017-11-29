From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH 5/5] drm/radeon: Remove KFD_CIK_SDMA_QUEUE_OFFSET
Date: Wed, 29 Nov 2017 18:24:53 +0100
Message-ID: <20171129172453.4953-6-michel@daenzer.net>
References: <20171129172453.4953-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171129172453.4953-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpMZWZ0b3ZlciBm
cm9tIHJlY2VudGx5IHJlbW92ZWQgYW1ka2ZkIHN1cHBvcnQuCgpTaWduZWQtb2ZmLWJ5OiBNaWNo
ZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL2Npa19yZWcuaCB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrX3JlZy5oIGIvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9jaWtfcmVnLmgKaW5kZXggNGU4ODNmZGM1OWQ4Li4zMTgzNzdkZjA5ZWYg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrX3JlZy5oCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9yYWRlb24vY2lrX3JlZy5oCkBAIC0xNDcsOCArMTQ3LDYgQEAKIAogI2RlZmlu
ZSBDSUtfTEJfREVTS1RPUF9IRUlHSFQgICAgICAgICAgICAgICAgICAgICAweDZiMGMKIAotI2Rl
ZmluZSBLRkRfQ0lLX1NETUFfUVVFVUVfT0ZGU0VUCQkweDIwMAotCiAjZGVmaW5lIFNRX0lORF9J
TkRFWAkJCQkJMHg4REUwCiAjZGVmaW5lIFNRX0NNRAkJCQkJCTB4OERFQwogI2RlZmluZSBTUV9J
TkRfREFUQQkJCQkJMHg4REU0Ci0tIAoyLjE1LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
