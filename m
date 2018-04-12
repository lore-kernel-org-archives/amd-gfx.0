From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 09/11] drm/amdgpu: counter for every bo creation
Date: Thu, 12 Apr 2018 18:09:38 +0800
Message-ID: <20180412100940.25039-10-david1.zhou@amd.com>
References: <20180412100940.25039-1-david1.zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180412100940.25039-1-david1.zhou-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Kai.Guo-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

Q2hhbmdlLUlkOiBJODc3YjJkNWM1NGIzZTQ3YjY2ZjJkNTg0NTRkY2YxZTVmNWE2ODk3MgpTaWdu
ZWQtb2ZmLWJ5OiBDaHVubWluZyBaaG91IDxkYXZpZDEuemhvdUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8IDIgKysKIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfb2JqZWN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
b2JqZWN0LmMKaW5kZXggN2JiNmVlNzc3MDY3Li5kNTRhYmJhNGUwMTcgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKQEAgLTYyMiw4ICs2MjIsMTAgQEAgc3Rh
dGljIGludCBhbWRncHVfYm9fZG9fY3JlYXRlMShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwg
dW5zaWduZWQgbG9uZyBzaXplLAogCWlmICh0eXBlID09IHR0bV9ib190eXBlX2tlcm5lbCkKIAkJ
Ym8tPnRiby5wcmlvcml0eSA9IDE7CiAJYm8tPnRiby5wcm9jZXNzID0gcHJvY2VzczsKKwliby0+
dGJvLmluZGV4ID0gKHU2NClhdG9taWM2NF9pbmNfcmV0dXJuKCZwcm9jZXNzLT5ib19pbmRleCk7
CiAKIAliby0+dGJvLmJkZXYgPSAmYWRldi0+bW1hbi5iZGV2OworCVJCX0NMRUFSX05PREUoJmJv
LT50Ym8ubm9kZSk7CiAJYW1kZ3B1X3R0bV9wbGFjZW1lbnRfZnJvbV9kb21haW4oYm8sIGRvbWFp
bnMpOwogCXIgPSB0dG1fYm9faW5pdF9yZXNlcnZlZCgmYWRldi0+bW1hbi5iZGV2LCAmYm8tPnRi
bywgc2l6ZSwgdHlwZSwKIAkJCQkgJmJvLT5wbGFjZW1lbnQsIHBhZ2VfYWxpZ24sICZjdHgsIGFj
Y19zaXplLAotLSAKMi4xNC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
