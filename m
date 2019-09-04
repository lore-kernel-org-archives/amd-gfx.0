From: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 01/10] drm/amdkfd: add renoir cache info for CRAT
Date: Wed, 4 Sep 2019 15:48:26 +0000
Message-ID: <20190904154803.5102-2-ray.huang@amd.com>
References: <20190904154803.5102-1-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190904154803.5102-1-ray.huang-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

UmVub2lyJ3MgY2FjaGUgaW5mbyBzaG91bGQgYmUgdGhlIHNhbWUgd2l0aCByYXZlbiBhbmQgY2Fy
cml6bydzLgoKU2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jIHwgNCArKysrCiAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2NyYXQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0
LmMKaW5kZXggYTg0YzgxMC4uMmE0MjhjOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2NyYXQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
Y3JhdC5jCkBAIC0xMzgsNiArMTM4LDcgQEAgc3RhdGljIHN0cnVjdCBrZmRfZ3B1X2NhY2hlX2lu
Zm8gY2Fycml6b19jYWNoZV9pbmZvW10gPSB7CiAvKiBUT0RPIC0gY2hlY2sgJiB1cGRhdGUgVmVn
YTEwIGNhY2hlIGRldGFpbHMgKi8KICNkZWZpbmUgdmVnYTEwX2NhY2hlX2luZm8gY2Fycml6b19j
YWNoZV9pbmZvCiAjZGVmaW5lIHJhdmVuX2NhY2hlX2luZm8gY2Fycml6b19jYWNoZV9pbmZvCisj
ZGVmaW5lIHJlbm9pcl9jYWNoZV9pbmZvIGNhcnJpem9fY2FjaGVfaW5mbwogLyogVE9ETyAtIGNo
ZWNrICYgdXBkYXRlIE5hdmkxMCBjYWNoZSBkZXRhaWxzICovCiAjZGVmaW5lIG5hdmkxMF9jYWNo
ZV9pbmZvIGNhcnJpem9fY2FjaGVfaW5mbwogCkBAIC02NjgsNiArNjY5LDkgQEAgc3RhdGljIGlu
dCBrZmRfZmlsbF9ncHVfY2FjaGVfaW5mbyhzdHJ1Y3Qga2ZkX2RldiAqa2RldiwKIAljYXNlIENI
SVBfUkFWRU46CiAJCXBjYWNoZV9pbmZvID0gcmF2ZW5fY2FjaGVfaW5mbzsKIAkJbnVtX29mX2Nh
Y2hlX3R5cGVzID0gQVJSQVlfU0laRShyYXZlbl9jYWNoZV9pbmZvKTsKKwljYXNlIENISVBfUkVO
T0lSOgorCQlwY2FjaGVfaW5mbyA9IHJlbm9pcl9jYWNoZV9pbmZvOworCQludW1fb2ZfY2FjaGVf
dHlwZXMgPSBBUlJBWV9TSVpFKHJlbm9pcl9jYWNoZV9pbmZvKTsKIAljYXNlIENISVBfTkFWSTEw
OgogCQlwY2FjaGVfaW5mbyA9IG5hdmkxMF9jYWNoZV9pbmZvOwogCQludW1fb2ZfY2FjaGVfdHlw
ZXMgPSBBUlJBWV9TSVpFKG5hdmkxMF9jYWNoZV9pbmZvKTsKLS0gCjIuNy40CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
