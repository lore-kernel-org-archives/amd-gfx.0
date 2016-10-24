From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Subject: Re: [PATCH] drm/amdgpu: fix a vm_flush fence leak
Date: Mon, 24 Oct 2016 11:07:50 +0200
Message-ID: <b6af3c14-655f-195c-5d15-b84ad38d6d84@vodafone.de>
References: <1477247507-11378-3-git-send-email-notasas@gmail.com>
 <580D72CA.6040802@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <580D72CA.6040802@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: zhoucm1 <david1.zhou@amd.com>, Grazvydas Ignotas <notasas@gmail.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjQuMTAuMjAxNiB1bSAwNDozMiBzY2hyaWViIHpob3VjbTE6Cj4KPgo+IE9uIDIwMTblubQx
MOaciDI05pelIDAyOjMxLCBHcmF6dnlkYXMgSWdub3RhcyB3cm90ZToKPj4gTG9va3MgbGlrZSAu
bGFzdF9mbHVzaCByZWZlcmVuY2UgaXMgbGVmdCBhdCB0ZWFyZG93bi4KPj4gTGVhayByZXBvcnRl
ZCBieSBDT05GSUdfU0xVQl9ERUJVRy4KPj4KPj4gRml4ZXM6IDQxZDllYjJjNWEyYSAoImRybS9h
bWRncHU6IGFkZCBhIGZlbmNlIGFmdGVyIHRoZSBWTSBmbHVzaCIpCj4+IFNpZ25lZC1vZmYtYnk6
IEdyYXp2eWRhcyBJZ25vdGFzIDxub3Rhc2FzQGdtYWlsLmNvbT4KPiBSZXZpZXdlZC1ieTogQ2h1
bm1pbmcgWmhvdSA8ZGF2aWQxLnpob3VAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+LgoKPj4gLS0tCj4+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAxICsKPj4gICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jCj4+IGluZGV4IGRlZDU3ZGQuLmQ2YzI4MzkgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jCj4+IEBAIC0xNzc0LDUgKzE3NzQsNiBAQCB2b2lkIGFtZGdwdV92
bV9tYW5hZ2VyX2Zpbmkoc3RydWN0IAo+PiBhbWRncHVfZGV2aWNlICphZGV2KQo+PiAgICAgICAg
ICAgZmVuY2VfcHV0KGFkZXYtPnZtX21hbmFnZXIuaWRzW2ldLmZpcnN0KTsKPj4gYW1kZ3B1X3N5
bmNfZnJlZSgmYWRldi0+dm1fbWFuYWdlci5pZHNbaV0uYWN0aXZlKTsKPj4gICAgICAgICAgIGZl
bmNlX3B1dChpZC0+Zmx1c2hlZF91cGRhdGVzKTsKPj4gKyAgICAgICAgZmVuY2VfcHV0KGlkLT5s
YXN0X2ZsdXNoKTsKPj4gICAgICAgfQo+PiAgIH0KPgo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2RyaS1kZXZlbAo=
