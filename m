From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix integer overflow test in
 amdgpu_bo_list_create()
Date: Fri, 10 Aug 2018 13:50:32 +0300
Message-ID: <20180810105032.cltqjuv7tqfud7n6@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Bas Nieuwenhuizen <basni-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Cihangir Akturk <cakturk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>

V2UgYWNjaWRlbnRhbGx5IGxlZnQgb3V0IHRoZSBzaXplIG9mIHRoZSBhbWRncHVfYm9fbGlzdCBz
dHJ1Y3QuICBJdApjb3VsZCBsZWFkIHRvIG1lbW9yeSBjb3JydXB0aW9uIG9uIDMyIGJpdCBzeXN0
ZW1zLiAgWW91J2QgaGF2ZSB0bwpwaWNrIHRoZSBhYnNvbHV0ZSBtYXhpbXVtIGFuZCBzZXQgIm51
bV9lbnRyaWVzID09IDU5NjUyMzIzIiB0aGVuIHNpemUKd291bGQgd3JhcCB0byAxNiBieXRlcy4K
CkZpeGVzOiA5MjA5OTBjYjA4MGEgKCJkcm0vYW1kZ3B1OiBhbGxvY2F0ZSB0aGUgYm9fbGlzdCBh
cnJheSBhZnRlciB0aGUgbGlzdCIpClNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5j
YXJwZW50ZXJAb3JhY2xlLmNvbT4KCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYm9fbGlzdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2JvX2xpc3QuYwppbmRleCBkNDcyYTJjODM5OWYuLmI4MDI0M2QzOTcyZSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JvX2xpc3QuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYm9fbGlzdC5jCkBAIC02Nyw3ICs2Nyw4IEBAIGlu
dCBhbWRncHVfYm9fbGlzdF9jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVj
dCBkcm1fZmlsZSAqZmlscCwKIAl1bnNpZ25lZCBpOwogCWludCByOwogCi0JaWYgKG51bV9lbnRy
aWVzID4gU0laRV9NQVggLyBzaXplb2Yoc3RydWN0IGFtZGdwdV9ib19saXN0X2VudHJ5KSkKKwlp
ZiAobnVtX2VudHJpZXMgPiAoU0laRV9NQVggLSBzaXplb2Yoc3RydWN0IGFtZGdwdV9ib19saXN0
KSkKKwkJCQkvIHNpemVvZihzdHJ1Y3QgYW1kZ3B1X2JvX2xpc3RfZW50cnkpKQogCQlyZXR1cm4g
LUVJTlZBTDsKIAogCXNpemUgPSBzaXplb2Yoc3RydWN0IGFtZGdwdV9ib19saXN0KTsKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
