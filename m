From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/5] drm/amdgpu: fix test for shadow page tables
Date: Wed, 20 Dec 2017 14:21:25 +0100
Message-ID: <20171220132128.4852-2-christian.koenig@amd.com>
References: <20171220132128.4852-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171220132128.4852-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

VGhleSBkb24ndCB3b3JrIDEwMCUgY29ycmVjdGx5IGF0IHRoZSBtb21lbnQuCgpTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIHwgNiArKysrKy0KIDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKaW5kZXggNGZlZWU5OTI3YmNlLi41YzRjM2Uw
ZDUyN2IgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKQEAg
LTQyLDcgKzQyLDExIEBAIHN0YXRpYyBib29sIGFtZGdwdV9uZWVkX2JhY2t1cChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKIAlpZiAoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKQogCQlyZXR1
cm4gZmFsc2U7CiAKLQlyZXR1cm4gYW1kZ3B1X2dwdV9yZWNvdmVyeTsKKwlpZiAoYW1kZ3B1X2dw
dV9yZWNvdmVyeSA9PSAwIHx8CisJICAgIChhbWRncHVfZ3B1X3JlY292ZXJ5ID09IC0xICAmJiAh
YW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSkKKwkJcmV0dXJuIGZhbHNlOworCisJcmV0dXJuIHRydWU7
CiB9CiAKIHN0YXRpYyB2b2lkIGFtZGdwdV90dG1fYm9fZGVzdHJveShzdHJ1Y3QgdHRtX2J1ZmZl
cl9vYmplY3QgKnRibykKLS0gCjIuMTEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
