From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/radeon: add header comment for clarification to
 vce_v2_0_enable_mgcg()
Date: Thu, 29 Jun 2017 15:25:19 -0400
Message-ID: <CADnq5_NmU1FTFqRO8Ye+DXZrCAvJ0hOsz8YX7uU9SM+LGiMtWA@mail.gmail.com>
References: <CADnq5_NhSDyBRSTpYEnBnSNG1AC=W_bHew-VcU1MxzaBcAURnQ@mail.gmail.com>
 <20170629173837.GA3397@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170629173837.GA3397@embeddedgus>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVGh1LCBKdW4gMjksIDIwMTcgYXQgMTozOCBQTSwgR3VzdGF2byBBLiBSLiBTaWx2YQo8Z2Fy
c2lsdmFAZW1iZWRkZWRvci5jb20+IHdyb3RlOgo+IEFkZCBmdW5jdGlvbiBoZWFkZXIgY29tbWVu
dCB0byBtYWtlIGl0IGNsZWFyIHRoYXQgbG9jYWwgdmFyaWFibGUgc3dfY2cKPiBpcyB1c2VkIGZv
ciBkZWJ1Z2dpbmcgYW5kIGl0IHNob3VsZCBub3QgYmUgcmVtb3ZlZC4KPgo+IEFkZHJlc3Nlcy1D
b3Zlcml0eS1JRDogMTE5ODYzNQo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWls
LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxnYXJzaWx2YUBlbWJl
ZGRlZG9yLmNvbT4KCkFwcGxpZWQuICB0aGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3ZjZV92Ml8wLmMgfCA0ICsrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vdmNlX3Yy
XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vdmNlX3YyXzAuYwo+IGluZGV4IGZjZTIxNDQu
LmIwYTQzYjYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi92Y2VfdjJfMC5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi92Y2VfdjJfMC5jCj4gQEAgLTEwNCw2ICsx
MDQsMTAgQEAgc3RhdGljIHZvaWQgdmNlX3YyXzBfZGlzYWJsZV9jZyhzdHJ1Y3QgcmFkZW9uX2Rl
dmljZSAqcmRldikKPiAgICAgICAgIFdSRUczMihWQ0VfQ0dUVF9DTEtfT1ZFUlJJREUsIDcpOwo+
ICB9Cj4KPiArLyoKPiArICogTG9jYWwgdmFyaWFibGUgc3dfY2cgaXMgdXNlZCBmb3IgZGVidWdn
aW5nIHB1cnBvc2VzLCBpbiBjYXNlIHdlCj4gKyAqIHJhbiBpbnRvIHByb2JsZW1zIHdpdGggZHlu
YW1pYyBjbG9jayBnYXRpbmcuIERvbid0IHJlbW92ZSBpdC4KPiArICovCj4gIHZvaWQgdmNlX3Yy
XzBfZW5hYmxlX21nY2coc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsIGJvb2wgZW5hYmxlKQo+
ICB7Cj4gICAgICAgICBib29sIHN3X2NnID0gZmFsc2U7Cj4gLS0KPiAyLjUuMAo+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
