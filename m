From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 10/10] drm/amdgpu: update version for timeline syncobj support
 in amdgpu
Date: Tue,  4 Dec 2018 12:59:48 +0100
Message-ID: <20181204115948.15202-10-christian.koenig@amd.com>
References: <20181204115948.15202-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181204115948.15202-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

RnJvbTogQ2h1bm1pbmcgWmhvdSA8ZGF2aWQxLnpob3VAYW1kLmNvbT4KClNpZ25lZC1vZmYtYnk6
IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZHJ2LmMKaW5kZXggOTBmNDc0Zjk4YjZlLi4zMTZiZmMxYTZhNzUgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKQEAgLTcxLDkgKzcxLDEwIEBACiAgKiAtIDMuMjUuMCAt
IEFkZCBzdXBwb3J0IGZvciBzZW5zb3IgcXVlcnkgaW5mbyAoc3RhYmxlIHBzdGF0ZSBzY2xrL21j
bGspLgogICogLSAzLjI2LjAgLSBHRlg5OiBQcm9jZXNzIEFNREdQVV9JQl9GTEFHX1RDX1dCX05P
VF9JTlZBTElEQVRFLgogICogLSAzLjI3LjAgLSBBZGQgbmV3IGNodW5rIHRvIHRvIEFNREdQVV9D
UyB0byBlbmFibGUgQk9fTElTVCBjcmVhdGlvbi4KKyAqIC0gMy4yOC4wIC0gQWRkIHN5bmNvYmog
dGltZWxpbmUgc3VwcG9ydCB0byBBTURHUFVfQ1MuCiAgKi8KICNkZWZpbmUgS01TX0RSSVZFUl9N
QUpPUgkzCi0jZGVmaW5lIEtNU19EUklWRVJfTUlOT1IJMjcKKyNkZWZpbmUgS01TX0RSSVZFUl9N
SU5PUgkyOAogI2RlZmluZSBLTVNfRFJJVkVSX1BBVENITEVWRUwJMAogCiBpbnQgYW1kZ3B1X3Zy
YW1fbGltaXQgPSAwOwotLSAKMi4xNC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
