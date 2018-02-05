From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/amdgpu: sync the VM PD/PT before clearing it
Date: Mon,  5 Feb 2018 13:28:28 +0100
Message-ID: <20180205122828.3371-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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

T3RoZXJ3aXNlIHdlIG1pZ2h0IG92ZXJ3cml0ZSBzdHVmZiB3aGljaCBpcyBzdGlsbCBpbiB1c2Uu
CgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCA1ICsrKysr
CiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYwppbmRleCAxOGNlNDc2MDhiZjEuLjA1NzJkNjA3MmJhYSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTMyOSw2ICszMjksMTEgQEAgc3RhdGlj
IGludCBhbWRncHVfdm1fY2xlYXJfYm8oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJYW1k
Z3B1X3JpbmdfcGFkX2liKHJpbmcsICZqb2ItPmlic1swXSk7CiAKIAlXQVJOX09OKGpvYi0+aWJz
WzBdLmxlbmd0aF9kdyA+IDY0KTsKKwlyID0gYW1kZ3B1X3N5bmNfcmVzdihhZGV2LCAmam9iLT5z
eW5jLCBiby0+dGJvLnJlc3YsCisJCQkgICAgIEFNREdQVV9GRU5DRV9PV05FUl9VTkRFRklORUQs
IGZhbHNlKTsKKwlpZiAocikKKwkJZ290byBlcnJvcl9mcmVlOworCiAJciA9IGFtZGdwdV9qb2Jf
c3VibWl0KGpvYiwgcmluZywgJnZtLT5lbnRpdHksCiAJCQkgICAgICBBTURHUFVfRkVOQ0VfT1dO
RVJfVU5ERUZJTkVELCAmZmVuY2UpOwogCWlmIChyKQotLSAKMi4xNC4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
