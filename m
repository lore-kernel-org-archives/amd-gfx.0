From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 09/11] drm/ttm: convert EDEADLK into EAGAIN
Date: Tue, 14 May 2019 14:31:25 +0200
Message-ID: <20190514123127.1650-9-christian.koenig@amd.com>
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

TGV0IHVzZXJzcGFjZSB0cnkgYWdhaW4gaWYgd2UgcmVhbGx5IHJ1biBpbnRvIGEgZGVhZGxvY2sg
ZHVyaW5nIGV2aWN0aW9uLgoKVGhpcyBoYXMgYSBsb3cgY2hhbmNlIG9mIGxpdmUgbG9ja2luZywg
YnV0IHdpdGggZ3VhcmFudGVlZCBmb3J3YXJkIHByb2Nlc3MuCgpTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fYm8uYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jIGIvZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fYm8uYwppbmRleCBhMzAxYzg3NmFlMzEuLmNlODVjZDhiNDk3MCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
dHRtL3R0bV9iby5jCkBAIC04NzcsNiArODc3LDggQEAgc3RhdGljIGludCB0dG1fbWVtX2V2aWN0
X2ZpcnN0KHN0cnVjdCB0dG1fYm9fZGV2aWNlICpiZGV2LAogCQkJCQkgICAgYWNxdWlyZV9jdHgp
OwogCQlpZiAocmV0KSB7CiAJCQl0dG1fYm9fcHV0KGZpcnN0X2JvKTsKKwkJCWlmIChyZXQgPT0g
LUVERUFETEspCisJCQkJcmV0ID0gLUVBR0FJTjsKIAkJCXJldHVybiByZXQ7CiAJCX0KIAkJc3Bp
bl9sb2NrKCZnbG9iLT5scnVfbG9jayk7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
