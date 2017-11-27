From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/7] drm/amdgpu: allow non pot VM size values
Date: Mon, 27 Nov 2017 17:02:15 +0100
Message-ID: <20171127160217.4010-5-christian.koenig@amd.com>
References: <20171127160217.4010-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171127160217.4010-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

VGhlIFZNIHNpemUgYWN0dWFsbHkgZG9lc24ndCBuZWVkIHRvIGJlIGEgcG93ZXIgb2YgdHdvLgoK
U2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDYgLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKaW5kZXggMjg1ZGFhODExMjIzLi5lZDBhZGE1NDlmOWYg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTExODQs
MTIgKzExODQsNiBAQCBzdGF0aWMgdm9pZCBhbWRncHVfY2hlY2tfdm1fc2l6ZShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKIAlpZiAoYW1kZ3B1X3ZtX3NpemUgPT0gLTEpCiAJCXJldHVybjsK
IAotCWlmICghaXNfcG93ZXJfb2ZfMihhbWRncHVfdm1fc2l6ZSkpIHsKLQkJZGV2X3dhcm4oYWRl
di0+ZGV2LCAiVk0gc2l6ZSAoJWQpIG11c3QgYmUgYSBwb3dlciBvZiAyXG4iLAotCQkJIGFtZGdw
dV92bV9zaXplKTsKLQkJZ290byBkZWZfdmFsdWU7Ci0JfQotCiAJaWYgKGFtZGdwdV92bV9zaXpl
IDwgMSkgewogCQlkZXZfd2FybihhZGV2LT5kZXYsICJWTSBzaXplICglZCkgdG9vIHNtYWxsLCBt
aW4gaXMgMUdCXG4iLAogCQkJIGFtZGdwdV92bV9zaXplKTsKLS0gCjIuMTEuMAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
