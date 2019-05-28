From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 09/10] drm/amdgpu: create GDS, GWS and OA in system domain
Date: Tue, 28 May 2019 18:25:56 +0200
Message-ID: <20190528162557.1280-9-christian.koenig@amd.com>
References: <20190528162557.1280-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190528162557.1280-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: David1.Zhou-5C7GfCeVMHo@public.gmane.org, Marek.Olsak-5C7GfCeVMHo@public.gmane.org, Prike.Liang-5C7GfCeVMHo@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW5kIG9ubHkgbW92ZSB0aGVtIGluIG9uIHZhbGlkYXRpb24uIFRoaXMgYWxsb3dzIGZvciBiZXR0
ZXIgY29udHJvbAp3aGVuIG11bHRpcGxlIHByb2Nlc3NlcyBhcmUgZmlnaHRpbmcgb3ZlciB0aG9z
ZSByZXNvdXJjZXMuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29i
amVjdC5jIHwgNiArKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
b2JqZWN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKaW5k
ZXggOTNiMmM1YTQ4YTcxLi4zMDQ5MzQyOTg1MWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfb2JqZWN0LmMKQEAgLTQ5NSw3ICs0OTUsMTEgQEAgc3RhdGljIGludCBhbWRn
cHVfYm9fZG9fY3JlYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogI2VuZGlmCiAKIAli
by0+dGJvLmJkZXYgPSAmYWRldi0+bW1hbi5iZGV2OwotCWFtZGdwdV9ib19wbGFjZW1lbnRfZnJv
bV9kb21haW4oYm8sIGJwLT5kb21haW4pOworCWlmIChicC0+ZG9tYWluICYgKEFNREdQVV9HRU1f
RE9NQUlOX0dXUyB8IEFNREdQVV9HRU1fRE9NQUlOX09BIHwKKwkJCSAgQU1ER1BVX0dFTV9ET01B
SU5fR0RTKSkKKwkJYW1kZ3B1X2JvX3BsYWNlbWVudF9mcm9tX2RvbWFpbihibywgQU1ER1BVX0dF
TV9ET01BSU5fQ1BVKTsKKwllbHNlCisJCWFtZGdwdV9ib19wbGFjZW1lbnRfZnJvbV9kb21haW4o
Ym8sIGJwLT5kb21haW4pOwogCWlmIChicC0+dHlwZSA9PSB0dG1fYm9fdHlwZV9rZXJuZWwpCiAJ
CWJvLT50Ym8ucHJpb3JpdHkgPSAxOwogCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
