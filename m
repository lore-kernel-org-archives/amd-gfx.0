From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] drm/radeon: use drm_gem_private_object_init
Date: Fri, 16 Feb 2018 10:26:35 +0100
Message-ID: <20180216092635.64271-2-christian.koenig@amd.com>
References: <20180216092635.64271-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180216092635.64271-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

V2UgdXNlIG91ciBvd24gYmFja2luZyBzdG9yZSBhbmQgZG9uJ3QgbmVlZCB0aGUgc2htZW0gZmls
ZS4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9vYmplY3QuYyB8IDYgKy0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDUgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fb2JqZWN0LmMgYi9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9vYmplY3QuYwppbmRleCAxNTQwNGFmOWQ3NDAuLmMzOGZl
YTM3YTY3ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fb2JqZWN0
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fb2JqZWN0LmMKQEAgLTIwNCwx
MSArMjA0LDcgQEAgaW50IHJhZGVvbl9ib19jcmVhdGUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJk
ZXYsCiAJYm8gPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgcmFkZW9uX2JvKSwgR0ZQX0tFUk5FTCk7
CiAJaWYgKGJvID09IE5VTEwpCiAJCXJldHVybiAtRU5PTUVNOwotCXIgPSBkcm1fZ2VtX29iamVj
dF9pbml0KHJkZXYtPmRkZXYsICZiby0+Z2VtX2Jhc2UsIHNpemUpOwotCWlmICh1bmxpa2VseShy
KSkgewotCQlrZnJlZShibyk7Ci0JCXJldHVybiByOwotCX0KKwlkcm1fZ2VtX3ByaXZhdGVfb2Jq
ZWN0X2luaXQocmRldi0+ZGRldiwgJmJvLT5nZW1fYmFzZSwgc2l6ZSk7CiAJYm8tPnJkZXYgPSBy
ZGV2OwogCWJvLT5zdXJmYWNlX3JlZyA9IC0xOwogCUlOSVRfTElTVF9IRUFEKCZiby0+bGlzdCk7
Ci0tIAoyLjE0LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
