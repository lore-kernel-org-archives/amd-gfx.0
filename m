From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix a vm_flush fence leak
Date: Mon, 24 Oct 2016 12:11:02 -0400
Message-ID: <CADnq5_PQyCjLPs1Aip5EVOQM4PWZQoJxd7banEC0Ly3fAmOQNA@mail.gmail.com>
References: <1477247507-11378-3-git-send-email-notasas@gmail.com>
 <580D72CA.6040802@amd.com> <b6af3c14-655f-195c-5d15-b84ad38d6d84@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <b6af3c14-655f-195c-5d15-b84ad38d6d84@vodafone.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBPY3QgMjQsIDIwMTYgYXQgNTowNyBBTSwgQ2hyaXN0aWFuIEvDtm5pZwo8ZGVhdGhz
aW1wbGVAdm9kYWZvbmUuZGU+IHdyb3RlOgo+IEFtIDI0LjEwLjIwMTYgdW0gMDQ6MzIgc2Nocmll
YiB6aG91Y20xOgo+Pgo+Pgo+Pgo+PiBPbiAyMDE25bm0MTDmnIgyNOaXpSAwMjozMSwgR3JhenZ5
ZGFzIElnbm90YXMgd3JvdGU6Cj4+Pgo+Pj4gTG9va3MgbGlrZSAubGFzdF9mbHVzaCByZWZlcmVu
Y2UgaXMgbGVmdCBhdCB0ZWFyZG93bi4KPj4+IExlYWsgcmVwb3J0ZWQgYnkgQ09ORklHX1NMVUJf
REVCVUcuCj4+Pgo+Pj4gRml4ZXM6IDQxZDllYjJjNWEyYSAoImRybS9hbWRncHU6IGFkZCBhIGZl
bmNlIGFmdGVyIHRoZSBWTSBmbHVzaCIpCj4+PiBTaWduZWQtb2ZmLWJ5OiBHcmF6dnlkYXMgSWdu
b3RhcyA8bm90YXNhc0BnbWFpbC5jb20+Cj4+Cj4+IFJldmlld2VkLWJ5OiBDaHVubWluZyBaaG91
IDxkYXZpZDEuemhvdUBhbWQuY29tPgo+Cj4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KPgo+Pj4gLS0tCj4+PiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMSArCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYwo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYwo+Pj4gaW5kZXggZGVkNTdkZC4uZDZjMjgzOSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4gQEAgLTE3NzQsNSArMTc3NCw2IEBAIHZvaWQgYW1k
Z3B1X3ZtX21hbmFnZXJfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZQo+Pj4gKmFkZXYpCj4+PiAg
ICAgICAgICAgZmVuY2VfcHV0KGFkZXYtPnZtX21hbmFnZXIuaWRzW2ldLmZpcnN0KTsKPj4+IGFt
ZGdwdV9zeW5jX2ZyZWUoJmFkZXYtPnZtX21hbmFnZXIuaWRzW2ldLmFjdGl2ZSk7Cj4+PiAgICAg
ICAgICAgZmVuY2VfcHV0KGlkLT5mbHVzaGVkX3VwZGF0ZXMpOwo+Pj4gKyAgICAgICAgZmVuY2Vf
cHV0KGlkLT5sYXN0X2ZsdXNoKTsKPj4+ICAgICAgIH0KPj4+ICAgfQoKQXBwbGllZC4gIFRoYW5r
cyEKCkFsZXgKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
