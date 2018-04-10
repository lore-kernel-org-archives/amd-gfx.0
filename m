From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 03/21] drm/amdgpu: Add GFXv9 TLB invalidation packet definition
Date: Tue, 10 Apr 2018 17:33:00 -0400
Message-ID: <1523395998-31314-4-git-send-email-Felix.Kuehling@amd.com>
References: <1523395998-31314-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1523395998-31314-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Jay Cornwall <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>, Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogU2hhb3l1biBMaXUgPFNoYW95dW4uTGl1QGFtZC5jb20+ClNpZ25lZC1v
ZmYtYnk6IEpheSBDb3Jud2FsbCA8SmF5LkNvcm53YWxsQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6
IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NvYzE1ZC5oIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1
ZC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTVkLmgKaW5kZXggN2Y0MDhmOC4u
ZjIyZjdhOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTVkLmgK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTVkLmgKQEAgLTI2OCw2ICsyNjgs
MTEgQEAKIAkJCSAqIHg9MTogdG16X2VuZAogCQkJICovCiAKKyNkZWZpbmUJUEFDS0VUM19JTlZB
TElEQVRFX1RMQlMJCQkJMHg5OAorIyAgICAgICAgICAgICAgZGVmaW5lIFBBQ0tFVDNfSU5WQUxJ
REFURV9UTEJTX0RTVF9TRUwoeCkgICAgICgoeCkgPDwgMCkKKyMgICAgICAgICAgICAgIGRlZmlu
ZSBQQUNLRVQzX0lOVkFMSURBVEVfVExCU19BTExfSFVCKHgpICAgICAoKHgpIDw8IDQpCisjICAg
ICAgICAgICAgICBkZWZpbmUgUEFDS0VUM19JTlZBTElEQVRFX1RMQlNfUEFTSUQoeCkgICAgICAg
KCh4KSA8PCA1KQorIyAgICAgICAgICAgICAgZGVmaW5lIFBBQ0tFVDNfSU5WQUxJREFURV9UTEJT
X0ZMVVNIX1RZUEUoeCkgICgoeCkgPDwgMjkpCiAjZGVmaW5lIFBBQ0tFVDNfU0VUX1JFU09VUkNF
UwkJCQkweEEwCiAvKiAxLiBoZWFkZXIKICAqIDIuIENPTlRST0wKLS0gCjIuNy40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
