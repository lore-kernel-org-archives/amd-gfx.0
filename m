From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/3] drm/amdgpu: set Vega20 LBPW as disabled at default
Date: Wed, 7 Nov 2018 09:37:38 +0800
Message-ID: <20181107013738.12616-3-evan.quan@amd.com>
References: <20181107013738.12616-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181107013738.12616-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

Rm9yIFZlZ2EyMCwgTEJQVyBmZWF0dXJlIGlzIGRpc2FibGVkIGF0IGRlZmF1bHQuCgpDaGFuZ2Ut
SWQ6IEkxODQ1MjBjYmIwM2FiOGNiYTkzMjFjZDk0ZDFkZWIwY2UzOGI3ZTE3ClNpZ25lZC1vZmYt
Ynk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y5XzAuYyB8IDE0ICsrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCmluZGV4
IGRjZjFmNzlhYjM0Ny4uNWJiMGNjYTViNzFmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92OV8wLmMKQEAgLTI1MDMsNiArMjUwMywyMCBAQCBzdGF0aWMgaW50IGdmeF92OV8wX3JsY19y
ZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCQlyZXR1cm4gcjsKIAl9CiAKKwlp
ZiAoYW1kZ3B1X2xicHcgPT0gLTEpIHsKKwkJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKKwkJ
Y2FzZSBDSElQX1JBVkVOOgorCQkJYW1kZ3B1X2xicHcgPSAxOworCQkJYnJlYWs7CisJCWNhc2Ug
Q0hJUF9WRUdBMjA6CisJCQlhbWRncHVfbGJwdyA9IDA7CisJCQlicmVhazsKKwkJZGVmYXVsdDoK
KwkJCWFtZGdwdV9sYnB3ID0gMDsKKwkJCWJyZWFrOworCQl9CisJfQorCiAJaWYgKGFkZXYtPmFz
aWNfdHlwZSA9PSBDSElQX1JBVkVOIHx8CiAJICAgIGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZF
R0EyMCkgewogCQlpZiAoYW1kZ3B1X2xicHcgIT0gMCkKLS0gCjIuMTkuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
