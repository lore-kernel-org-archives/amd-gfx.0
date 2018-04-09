From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] drm/amdgpu: remove AMDGPU_GEM_CREATE_NO_FALLBACK handling
 from CS again
Date: Mon,  9 Apr 2018 12:19:00 +0200
Message-ID: <20180409101900.2790-3-christian.koenig@amd.com>
References: <20180409101900.2790-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180409101900.2790-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

VGhhdCBzaG91bGQgcHVyZWx5IGJlIGhhbmRsZWQgYnkgcHJlZmVycmVkL2FsbG93ZWQgZG9tYWlu
cy4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyB8IDMgKy0t
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwppbmRleCA2OGFmMmY4NzhiYzkuLmUxNzU2YjY4
YTE3YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKQEAgLTM4NSw4ICsz
ODUsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jc19ib192YWxpZGF0ZShzdHJ1Y3QgYW1kZ3B1X2Nz
X3BhcnNlciAqcCwKIAkgICAgYW1kZ3B1X2JvX2luX2NwdV92aXNpYmxlX3ZyYW0oYm8pKQogCQlw
LT5ieXRlc19tb3ZlZF92aXMgKz0gY3R4LmJ5dGVzX21vdmVkOwogCi0JaWYgKHVubGlrZWx5KHIg
PT0gLUVOT01FTSkgJiYgZG9tYWluICE9IGJvLT5hbGxvd2VkX2RvbWFpbnMgJiYKLQkgICAgIShi
by0+ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9OT19GQUxMQkFDSykpIHsKKwlpZiAodW5saWtl
bHkociA9PSAtRU5PTUVNKSAmJiBkb21haW4gIT0gYm8tPmFsbG93ZWRfZG9tYWlucykgewogCQlk
b21haW4gPSBiby0+YWxsb3dlZF9kb21haW5zOwogCQlnb3RvIHJldHJ5OwogCX0KLS0gCjIuMTQu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
