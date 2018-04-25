From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/radeon: Change the default to PCI on PowerPC
Date: Wed, 25 Apr 2018 11:49:22 +0200
Message-ID: <0d3b4b95-044d-ab4f-950e-85098b81cb5d@daenzer.net>
References: <20180424195512.491-1-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180424195512.491-1-malat@debian.org>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mathieu Malaterre <malat@debian.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOC0wNC0yNCAwOTo1NSBQTSwgTWF0aGlldSBNYWxhdGVycmUgd3JvdGU6Cj4gQUdQIG1v
ZGUgaXMgdW5zdGFibGUgb24gUG93ZXJQQy4gU3ltcHRvbXMgYXJlIGdlbmVyYWxseSBvZiB0aGUg
Zm9ybToKPiAKPiBbIDEyMjguNzk1NzExXSByYWRlb24gMDAwMDowMDoxMC4wOiByaW5nIDAgc3Rh
bGxlZCBmb3IgbW9yZSB0aGFuIDEwMjQwbXNlYwo+IAo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTWF0aGll
dSBNYWxhdGVycmUgPG1hbGF0QGRlYmlhbi5vcmc+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX2Rydi5jIHwgNSArKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Ry
di5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMKPiBpbmRleCBiMjgyODhh
NzgxZWYuLjJhNzk3N2EyM2IzMSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9kcnYuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5j
Cj4gQEAgLTE2OCw3ICsxNjgsMTIgQEAgaW50IHJhZGVvbl9ub193YjsKPiAgaW50IHJhZGVvbl9t
b2Rlc2V0ID0gLTE7Cj4gIGludCByYWRlb25fZHluY2xrcyA9IC0xOwo+ICBpbnQgcmFkZW9uX3I0
eHhfYXRvbSA9IDA7Cj4gKyNpZmRlZiBfX3Bvd2VycGNfXwo+ICsvKiBEZWZhdWx0IHRvIFBDSSBv
biBQb3dlclBDIChmZG8gIzk1MDE3KSAqLwo+ICtpbnQgcmFkZW9uX2FncG1vZGUgPSAtMTsKPiAr
I2Vsc2UKPiAgaW50IHJhZGVvbl9hZ3Btb2RlID0gMDsKPiArI2VuZGlmCj4gIGludCByYWRlb25f
dnJhbV9saW1pdCA9IDA7Cj4gIGludCByYWRlb25fZ2FydF9zaXplID0gLTE7IC8qIGF1dG8gKi8K
PiAgaW50IHJhZGVvbl9iZW5jaG1hcmtpbmcgPSAwOwo+IAoKUHVzaGVkIHRvIGFtZC1zdGFnaW5n
LWRybS1uZXh0LCB0aGFua3MhCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAg
ICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUg
ZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVy
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZl
bCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
