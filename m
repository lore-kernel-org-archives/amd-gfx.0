From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: bump driver version for some new features
Date: Wed,  8 Mar 2017 18:18:56 -0500
Message-ID: <1489015136-7376-2-git-send-email-alexander.deucher@amd.com>
References: <1489015136-7376-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1489015136-7376-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

V2UgYWRkZWQgbmV3IGdlbSBpb2N0bCBmbGFncyBhbmQgdGhlIG5ldyBmZW5jZXMgaW9jdGwsIGJ1
dCBmb3Jnb3QKdG8gYnVtcCB0aGUgdmVyc2lvbi4KClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZHJ2LmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwpp
bmRleCA3NWZjMzc2Li5mN2FkYmFjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZHJ2LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2Rydi5jCkBAIC01OSw5ICs1OSwxMCBAQAogICogLSAzLjcuMCAtIEFkZCBzdXBwb3J0IGZvciBW
Q0UgY2xvY2sgbGlzdCBwYWNrZXQKICAqIC0gMy44LjAgLSBBZGQgc3VwcG9ydCByYXN0ZXIgY29u
ZmlnIGluaXQgaW4gdGhlIGtlcm5lbAogICogLSAzLjkuMCAtIEFkZCBzdXBwb3J0IGZvciBtZW1v
cnkgcXVlcnkgaW5mbyBhYm91dCBWUkFNIGFuZCBHVFQuCisgKiAtIDMuMTAuMCAtIEFkZCBzdXBw
b3J0IGZvciBuZXcgZmVuY2VzIGlvY3RsLCBuZXcgZ2VtIGlvY3RsIGZsYWdzCiAgKi8KICNkZWZp
bmUgS01TX0RSSVZFUl9NQUpPUgkzCi0jZGVmaW5lIEtNU19EUklWRVJfTUlOT1IJOQorI2RlZmlu
ZSBLTVNfRFJJVkVSX01JTk9SCTEwCiAjZGVmaW5lIEtNU19EUklWRVJfUEFUQ0hMRVZFTAkwCiAK
IGludCBhbWRncHVfdnJhbV9saW1pdCA9IDA7Ci0tIAoyLjUuNQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
