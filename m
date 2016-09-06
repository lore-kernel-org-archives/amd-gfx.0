From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/7] drm/amd/amdgpu: Allow calling si_dpm_fini at any point
Date: Tue,  6 Sep 2016 12:18:39 -0400
Message-ID: <20160906161844.21370-3-tom.stdenis@amd.com>
References: <20160906161844.21370-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160906161844.21370-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

QWxsb3cgY2FsbGluZyBmaW5pIGV2ZW4gaWYgcHMgYXJyYXkgaXMgbm90IGFsbG9jYXRlZC4KClNp
Z25lZC1vZmYtYnk6IFRvbSBTdCBEZW5pcyA8dG9tLnN0ZGVuaXNAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
c2lfZHBtLmMKaW5kZXggZTkwYmI0NDIzY2M3Li4yYTcyYjJiNTgwMWQgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NpX2RwbS5jCkBAIC03NTE5LDkgKzc1MTksOSBAQCBzdGF0aWMgdm9pZCBzaV9k
cG1fZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAlpbnQgaTsKIAotCWZvciAo
aSA9IDA7IGkgPCBhZGV2LT5wbS5kcG0ubnVtX3BzOyBpKyspIHsKLQkJa2ZyZWUoYWRldi0+cG0u
ZHBtLnBzW2ldLnBzX3ByaXYpOwotCX0KKwlpZiAoYWRldi0+cG0uZHBtLnBzKQorCQlmb3IgKGkg
PSAwOyBpIDwgYWRldi0+cG0uZHBtLm51bV9wczsgaSsrKQorCQkJa2ZyZWUoYWRldi0+cG0uZHBt
LnBzW2ldLnBzX3ByaXYpOwogCWtmcmVlKGFkZXYtPnBtLmRwbS5wcyk7CiAJa2ZyZWUoYWRldi0+
cG0uZHBtLnByaXYpOwogCWtmcmVlKGFkZXYtPnBtLmRwbS5keW5fc3RhdGUudmRkY19kZXBlbmRl
bmN5X29uX2Rpc3BjbGsuZW50cmllcyk7Ci0tIAoyLjkuMwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
