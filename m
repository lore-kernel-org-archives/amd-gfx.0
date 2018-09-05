From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/amdgpu: set bulk_moveable to false when a per VM is
 released
Date: Wed,  5 Sep 2018 17:08:26 +0200
Message-ID: <20180905150826.15779-1-christian.koenig@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

T3RoZXJ3aXNlIHdlIG1pZ2h0IHJ1biBpbnRvIGEgdXNlIGFmdGVyIGZyZWUgZHVyaW5nIGJ1bGsg
bW92ZS4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDQg
KysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMKaW5kZXggZWE1ZTI3N2FlMDM4Li5lZDFlNmFiZGEzOTEgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCkBAIC0yNTEzLDggKzI1MTMsMTIgQEAg
dm9pZCBhbWRncHVfdm1fYm9fcm12KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkgICAg
ICBzdHJ1Y3QgYW1kZ3B1X2JvX3ZhICpib192YSkKIHsKIAlzdHJ1Y3QgYW1kZ3B1X2JvX3ZhX21h
cHBpbmcgKm1hcHBpbmcsICpuZXh0OworCXN0cnVjdCBhbWRncHVfYm8gKmJvID0gYm9fdmEtPmJh
c2UuYm87CiAJc3RydWN0IGFtZGdwdV92bSAqdm0gPSBib192YS0+YmFzZS52bTsKIAorCWlmIChi
byAmJiBiby0+dGJvLnJlc3YgPT0gdm0tPnJvb3QuYmFzZS5iby0+dGJvLnJlc3YpCisJCXZtLT5i
dWxrX21vdmVhYmxlID0gZmFsc2U7CisKIAlsaXN0X2RlbCgmYm9fdmEtPmJhc2UuYm9fbGlzdCk7
CiAKIAlzcGluX2xvY2soJnZtLT5pbnZhbGlkYXRlZF9sb2NrKTsKLS0gCjIuMTcuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
