From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Subject: Re: [PATCH 2/2] drm/amdgpu: Implement ttm_bo_driver.access_vram
 callback
Date: Mon, 17 Jul 2017 19:04:15 +0200
Message-ID: <78d35e79-0c59-321a-7753-9bc2117a1c17@vodafone.de>
References: <1499980105-7721-1-git-send-email-Felix.Kuehling@amd.com>
 <1499980105-7721-2-git-send-email-Felix.Kuehling@amd.com>
 <c25a37a9-8fae-11f0-cce6-59ca13412801@vodafone.de>
 <ff877e3e-8ccf-5c41-d555-313f7dd1990d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <ff877e3e-8ccf-5c41-d555-313f7dd1990d@amd.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Felix Kuehling <felix.kuehling@amd.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMTQuMDcuMjAxNyB1bSAyMTo0NCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IE9uIDE3LTA3
LTE0IDA2OjA4IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAxMy4wNy4yMDE3IHVt
IDIzOjA4IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+IFtTTklQXQo+Pj4gKyAgICAgICAgcmVz
dWx0ICs9IGJ5dGVzOwo+Pj4gKyAgICAgICAgYnVmID0gKHVpbnQ4X3QgKilidWYgKyBieXRlczsK
Pj4+ICsgICAgICAgIHBvcyArPSBieXRlczsKPj4+ICsgICAgICAgIGxlbiAtPSBieXRlczsKPj4+
ICsgICAgICAgIGlmIChwb3MgPj0gKG5vZGVzLT5zdGFydCArIG5vZGVzLT5zaXplKSA8PCBQQUdF
X1NISUZUKSB7Cj4+PiArICAgICAgICAgICAgKytub2RlczsKPj4+ICsgICAgICAgICAgICBwb3Mg
PSAobm9kZXMtPnN0YXJ0IDw8IFBBR0VfU0hJRlQpOwo+IC4uLiBIZXJlIEkgaGFuZGxlIGNyb3Nz
aW5nIGEgbm9kZSBib3VuZGFyeS4gWWVzLCBJIGFjdHVhbGx5IGFkZGVkIHRoaXMKPiBjYXNlIHRv
IG15IGtmZHRlc3QgdW5pdCB0ZXN0IGFuZCBtYWRlIHN1cmUgaXQgd29ya3MsIGFsb25nIHdpdGgg
YWxsIG9kZAo+IGFsaWdubWVudHMgdGhhdCB0aGUgY29kZSBhYm92ZSBoYW5kbGVzLgoKQWgsIEkg
c2VlLiBTb3JyeSB0b3RhbGx5IG1pc3NlZCB0aGF0IGNodW5rLiBJbiB0aGlzIGNhc2UgdGhlIHBh
dGNoIGlzIApBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+IFJlZ2FyZHMsCj4gICAgRmVsaXgKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
