From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay/polaris10_smumgr: Mark expected
 switch fall-through
Date: Mon, 18 Feb 2019 16:48:11 -0600
Message-ID: <9e973389-d995-4063-9fec-7c41b27238a3@embeddedor.com>
References: <20190215170253.GA30719@embeddedor>
 <CADnq5_OtPhhES1gm=0CZBPYYJqCpQccjYrmwTTftw8gwVSL30w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CADnq5_OtPhhES1gm=0CZBPYYJqCpQccjYrmwTTftw8gwVSL30w@mail.gmail.com>
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
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

CgpPbiAyLzE4LzE5IDQ6NDAgUE0sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBPbiBGcmksIEZlYiAx
NSwgMjAxOSBhdCAxOjUwIFBNIEd1c3Rhdm8gQS4gUi4gU2lsdmEKPiA8Z3VzdGF2b0BlbWJlZGRl
ZG9yLmNvbT4gd3JvdGU6Cj4+Cj4+IEluIHByZXBhcmF0aW9uIHRvIGVuYWJsaW5nIC1XaW1wbGlj
aXQtZmFsbHRocm91Z2gsIG1hcmsgc3dpdGNoCj4+IGNhc2VzIHdoZXJlIHdlIGFyZSBleHBlY3Rp
bmcgdG8gZmFsbCB0aHJvdWdoLgo+Pgo+PiBXYXJuaW5nIGxldmVsIDMgd2FzIHVzZWQ6IC1XaW1w
bGljaXQtZmFsbHRocm91Z2g9Mwo+Pgo+PiBUaGlzIHBhdGNoIGlzIHBhcnQgb2YgdGhlIG9uZ29p
bmcgZWZmb3J0cyB0byBlbmFibGUKPj4gLVdpbXBsaWNpdC1mYWxsdGhyb3VnaC4KPj4KPj4gU2ln
bmVkLW9mZi1ieTogR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4K
Pj4gLS0tCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvcG9sYXJpczEw
X3NtdW1nci5jIHwgMSArCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPj4KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9wb2xhcmlz
MTBfc211bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvcG9sYXJp
czEwX3NtdW1nci5jCj4+IGluZGV4IDUyYWJjYTA2NTc2NC4uOTJkZTFiYmIyZTMzIDEwMDY0NAo+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvcG9sYXJpczEwX3Nt
dW1nci5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9wb2xh
cmlzMTBfc211bWdyLmMKPj4gQEAgLTIzMzAsNiArMjMzMCw3IEBAIHN0YXRpYyB1aW50MzJfdCBw
b2xhcmlzMTBfZ2V0X29mZnNldG9mKHVpbnQzMl90IHR5cGUsIHVpbnQzMl90IG1lbWJlcikKPj4g
ICAgICAgICAgICAgICAgIGNhc2UgRFJBTV9MT0dfQlVGRl9TSVpFOgo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gb2Zmc2V0b2YoU01VNzRfU29mdFJlZ2lzdGVycywgRFJBTV9MT0df
QlVGRl9TSVpFKTsKPj4gICAgICAgICAgICAgICAgIH0KPj4gKyAgICAgICAgICAgICAgIC8qIGZh
bGwgdGhyb3VnaCAqLwo+IAo+IFRoZXNlIHNob3VsZCBiZSBicmVha3MsIGFsdGhvdWdoIEkgZG9u
J3QgdGhpbmsgd2UgZXZlciBjdXJyZW50bHkgaGl0Cj4gdGhpcyBjYXNlLiAgSSd2ZSBzZW50IG91
dCBhIHBhdGNoIHRvIGZpeCBpdCBhbmQgYXBwbGllZCB0aGUgcmVzdCBvZgo+IHRoZSByYWRlb24g
YW5kIGFtZGdwdSBwYXRjaGVzLiAgVGhhbmtzIQo+IAoKQXdlc29tZSEKClRoYW5rcywgQWxleC4K
Ci0tCkd1c3Rhdm8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
