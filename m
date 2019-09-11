From: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix build error without CONFIG_HSA_AMD (V2)
Date: Wed, 11 Sep 2019 06:52:51 +0000
Message-ID: <1568184761-20949-1-git-send-email-shirish.s@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "S,
 Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

SWYgQ09ORklHX0hTQV9BTUQgaXMgbm90IHNldCwgYnVpbGQgZmFpbHM6Cgpkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLm86IEluIGZ1bmN0aW9uIGBhbWRncHVfZGV2aWNl
X2lwX2Vhcmx5X2luaXQnOgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmM6MTYyNjogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgc2NoZWRfcG9saWN5JwoKVXNlIENPTkZJ
R19IU0FfQU1EIHRvIGd1YXJkIHRoaXMuCgpGaXhlczogMWFiYjY4MGFkMzcxICgiZHJtL2FtZGdw
dTogZGlzYWJsZSBnZnhvZmYgd2hpbGUgdXNlIG5vIEgvVyBzY2hlZHVsaW5nIHBvbGljeSIpCgpW
MjogZGVjbGFyZSBzY2hlZF9wb2xpY3kgaW4gYW1kZ3B1LmggYW5kIHJlbW92ZSBjaGFuZ2VzIGlu
IGFtZGdwdV9kZXZpY2UuYwoKU2lnbmVkLW9mZi1ieTogU2hpcmlzaCBTIDxzaGlyaXNoLnNAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCB8IDQgKysrKwog
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1LmgKaW5kZXggMTAzMGNiMy4uNmZmMDJiYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1LmgKQEAgLTE2OSw3ICsxNjksMTEgQEAgZXh0ZXJuIGludCBhbWRncHVfZGlzY292ZXJ5Owog
ZXh0ZXJuIGludCBhbWRncHVfbWVzOwogZXh0ZXJuIGludCBhbWRncHVfbm9yZXRyeTsKIGV4dGVy
biBpbnQgYW1kZ3B1X2ZvcmNlX2FzaWNfdHlwZTsKKyNpZmRlZiBDT05GSUdfSFNBX0FNRAogZXh0
ZXJuIGludCBzY2hlZF9wb2xpY3k7CisjZWxzZQorc3RhdGljIGNvbnN0IGludCBzY2hlZF9wb2xp
Y3kgPSBLRkRfU0NIRURfUE9MSUNZX0hXUzsKKyNlbmRpZgogCiAjaWZkZWYgQ09ORklHX0RSTV9B
TURHUFVfU0kKIGV4dGVybiBpbnQgYW1kZ3B1X3NpX3N1cHBvcnQ7Ci0tIAoyLjcuNAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
