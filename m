From: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu: Add invalidate tlb for all hub bit field
 define
Date: Fri,  7 Jul 2017 13:21:43 -0400
Message-ID: <1499448103-12407-1-git-send-email-Shaoyun.Liu@amd.com>
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
Cc: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJNTY0NzViNzJhYzlmOWE4ZTI3MDFjNThjNWIxMGUxZjI5MzBhZjdjZApTaWdu
ZWQtb2ZmLWJ5OiBTaGFveXVuIExpdSA8U2hhb3l1bi5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNWQuaCB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTVk
LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNWQuaAppbmRleCAyOThlZjRlLi4z
MTMwYWY4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNWQuaAor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNWQuaApAQCAtMjY5LDYgKzI2OSw3
IEBACiAKICNkZWZpbmUJUEFDS0VUM19JTlZBTElEQVRFX1RMQlMJCQkJMHg5OAogIyAgICAgICAg
ICAgICAgZGVmaW5lIFBBQ0tFVDNfSU5WQUxJREFURV9UTEJTX0RTVF9TRUwoeCkgICAgICgoeCkg
PDwgMCkKKyMgICAgICAgICAgICAgIGRlZmluZSBQQUNLRVQzX0lOVkFMSURBVEVfVExCU19BTExf
SFVCKHgpICAgICAoKHgpIDw8IDQpCiAjICAgICAgICAgICAgICBkZWZpbmUgUEFDS0VUM19JTlZB
TElEQVRFX1RMQlNfUEFTSUQoeCkgICAgICAgKCh4KSA8PCA1KQogI2RlZmluZSBQQUNLRVQzX1NF
VF9SRVNPVVJDRVMJCQkJMHhBMAogLyogMS4gaGVhZGVyCi0tIAoxLjkuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
