From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 08/11] drm/ttm: put new BOs immediately on the LRU
Date: Tue, 14 May 2019 14:31:24 +0200
Message-ID: <20190514123127.1650-8-christian.koenig@amd.com>
References: <20190514123127.1650-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190514123127.1650-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: Marek.Olsak-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org, Prike.Liang-5C7GfCeVMHo@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

VGhpcyB3YXkgdGhleSBhcmUgYXZhaWxhYmxlIGZvciBldmljdGlvbiBpbW1lZGlhdGVseS4KClNp
Z25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jIHwgMTMgKysrKystLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1f
Ym8uYwppbmRleCAyMzNiZmI4NjA2OGIuLmEzMDFjODc2YWUzMSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL3R0bS90dG1fYm8uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5j
CkBAIC0xMzkwLDIxICsxMzkwLDE4IEBAIGludCB0dG1fYm9faW5pdF9yZXNlcnZlZChzdHJ1Y3Qg
dHRtX2JvX2RldmljZSAqYmRldiwKIAkJV0FSTl9PTighbG9ja2VkKTsKIAl9CiAKLQlpZiAobGlr
ZWx5KCFyZXQpKQorCWlmIChsaWtlbHkoIXJldCkpIHsKKwkJc3Bpbl9sb2NrKCZiZGV2LT5nbG9i
LT5scnVfbG9jayk7CisJCXR0bV9ib19hZGRfdG9fbHJ1KGJvKTsKKwkJc3Bpbl91bmxvY2soJmJk
ZXYtPmdsb2ItPmxydV9sb2NrKTsKIAkJcmV0ID0gdHRtX2JvX3ZhbGlkYXRlKGJvLCBwbGFjZW1l
bnQsIGN0eCk7CisJfQogCiAJaWYgKHVubGlrZWx5KHJldCkpIHsKIAkJaWYgKCFyZXN2KQogCQkJ
dHRtX2JvX3VucmVzZXJ2ZShibyk7CiAKIAkJdHRtX2JvX3B1dChibyk7Ci0JCXJldHVybiByZXQ7
Ci0JfQotCi0JaWYgKHJlc3YgJiYgIShiby0+bWVtLnBsYWNlbWVudCAmIFRUTV9QTF9GTEFHX05P
X0VWSUNUKSkgewotCQlzcGluX2xvY2soJmJkZXYtPmdsb2ItPmxydV9sb2NrKTsKLQkJdHRtX2Jv
X2FkZF90b19scnUoYm8pOwotCQlzcGluX3VubG9jaygmYmRldi0+Z2xvYi0+bHJ1X2xvY2spOwog
CX0KIAogCXJldHVybiByZXQ7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
