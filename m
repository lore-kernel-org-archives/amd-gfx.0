From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Correct the ndw of bo update mapping.
Date: Fri, 8 Jun 2018 09:40:44 +0200
Message-ID: <737d83c2-6db9-d9d9-0f5d-465a8ad61fe4@gmail.com>
References: <1528436076-27796-1-git-send-email-Emily.Deng@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1528436076-27796-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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
To: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDguMDYuMjAxOCB1bSAwNzozNCBzY2hyaWViIEVtaWx5IERlbmc6Cj4gRm9yIGJ1ZmZlciBv
YmplY3QgdGhhdCBoYXMgc2hhZG93IGJ1ZmZlciwgbmVlZCB0d2ljZSBjb21tYW5kcy4KPgo+IFNp
Z25lZC1vZmYtYnk6IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdAYW1kLmNvbT4KCkdvb2QgY2F0Y2gs
IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
LgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNSAr
KysrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCBiMGViMmY1Li5k
ODg2ODdiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAt
MTMyNCw3ICsxMzI0LDEwIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5n
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCQluZHcgKz0gbmNtZHMgKiAxMDsKPiAg
IAo+ICAgCQkvKiBleHRyYSBjb21tYW5kcyBmb3IgYmVnaW4vZW5kIGZyYWdtZW50cyAqLwo+IC0J
CW5kdyArPSAyICogMTAgKiBhZGV2LT52bV9tYW5hZ2VyLmZyYWdtZW50X3NpemU7Cj4gKwkJaWYg
KHZtLT5yb290LmJhc2UuYm8tPnNoYWRvdykKPiArCQkgICAgICAgIG5kdyArPSAyICogMTAgKiBh
ZGV2LT52bV9tYW5hZ2VyLmZyYWdtZW50X3NpemUgKiAyOwo+ICsJCWVsc2UKPiArCQkgICAgICAg
IG5kdyArPSAyICogMTAgKiBhZGV2LT52bV9tYW5hZ2VyLmZyYWdtZW50X3NpemU7Cj4gICAKPiAg
IAkJcGFyYW1zLmZ1bmMgPSBhbWRncHVfdm1fZG9fc2V0X3B0ZXM7Cj4gICAJfQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
