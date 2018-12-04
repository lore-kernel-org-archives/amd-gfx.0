From: "Zhang, Jerry(Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/powerplay: fix mclk switch limit on polaris
Date: Tue, 4 Dec 2018 10:38:07 +0800
Message-ID: <4d74cd9a-935e-f609-23e0-cff5d2517c58@amd.com>
References: <20181203162106.2910-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181203162106.2910-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

T24gMTIvNC8xOCAxMjoyMSBBTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IFVwZGF0ZSBzd2l0Y2gg
bGltaXQgb24gbmV3ZXIgcG9sYXJpcyB2YXJpYW50cy4gIFRoaXMgbWF5IGZpeAo+IGZsaWNrZXJp
bmcgd2l0aCBoaWdoIHJlZnJlc2ggcmF0ZXMgd2l0aCBtY2xrIHN3aXRjaGluZyBlbmFibGVkLgo+
Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
PgpSZXZpZXdlZC1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgoKPiAtLS0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYyB8IDUg
KysrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU3
X2h3bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdy
LmMKPiBpbmRleCA1ZGNkMjFkMjlkYmYuLjFmMTJmYzdlYTdjOSAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdyLmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdyLmMKPiBAQCAtMjg1OSw3
ICsyODU5LDEwIEBAIHN0YXRpYyBpbnQgc211N192YmxhbmtfdG9vX3Nob3J0KHN0cnVjdCBwcF9o
d21nciAqaHdtZ3IsCj4gICAJY2FzZSBDSElQX1BPTEFSSVMxMDoKPiAgIAljYXNlIENISVBfUE9M
QVJJUzExOgo+ICAgCWNhc2UgQ0hJUF9QT0xBUklTMTI6Cj4gLQkJc3dpdGNoX2xpbWl0X3VzID0g
ZGF0YS0+aXNfbWVtb3J5X2dkZHI1ID8gMTkwIDogMTUwOwo+ICsJCWlmIChod21nci0+aXNfa2lj
a2VyKQo+ICsJCQlzd2l0Y2hfbGltaXRfdXMgPSBkYXRhLT5pc19tZW1vcnlfZ2RkcjUgPyA0NTAg
OiAxNTA7Cj4gKwkJZWxzZQo+ICsJCQlzd2l0Y2hfbGltaXRfdXMgPSBkYXRhLT5pc19tZW1vcnlf
Z2RkcjUgPyAxOTAgOiAxNTA7Cj4gICAJCWJyZWFrOwo+ICAgCWNhc2UgQ0hJUF9WRUdBTToKPiAg
IAkJc3dpdGNoX2xpbWl0X3VzID0gMzA7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
