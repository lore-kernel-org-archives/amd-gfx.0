From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] amdgpu:update IB flags with PREEMPT
Date: Wed, 8 Mar 2017 18:22:47 +0800
Message-ID: <1488968567-7328-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

UFJFRU1QVCBmbGFnIGlzIHVzZWQgZm9yIE1DQlAKCkNoYW5nZS1JZDogSTJkZGYwMDAwMGYzOTEy
YzIxOTY2M2U4MDY4MGY3NmQ2NzFjNzg1NmUKU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsu
TGl1QGFtZC5jb20+Ci0tLQogaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oIHwgNSArKysrLQogMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaCBiL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaAppbmRl
eCBhZDE2MWM0Li5hY2E1NGMyIDEwMDY0NAotLS0gYS9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmgK
KysrIGIvaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oCkBAIC00MDksOSArNDA5LDEyIEBAIHVuaW9u
IGRybV9hbWRncHVfY3MgewogLyogVGhpcyBJQiBzaG91bGQgYmUgc3VibWl0dGVkIHRvIENFICov
CiAjZGVmaW5lIEFNREdQVV9JQl9GTEFHX0NFCSgxPDwwKQogCi0vKiBDRSBQcmVhbWJsZSAqLwor
LyogUHJlYW1ibGUgKi8KICNkZWZpbmUgQU1ER1BVX0lCX0ZMQUdfUFJFQU1CTEUgKDE8PDEpCiAK
Ky8qIFByZWVtcHRpYmxlICovCisjZGVmaW5lIEFNREdQVV9JQl9GTEFHX1BSRUVNUFQgKDE8PDIp
CisKIHN0cnVjdCBkcm1fYW1kZ3B1X2NzX2NodW5rX2liIHsKIAl1aW50MzJfdCBfcGFkOwogCS8q
KiBBTURHUFVfSUJfRkxBR18qICovCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
