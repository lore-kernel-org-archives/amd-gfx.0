From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 1/2] drm/ttm: swap consecutive allocated cached pages
Date: Mon, 4 Dec 2017 12:51:54 +0100
Message-ID: <53e107e3-533a-eb68-26cc-9a764281eb56@daenzer.net>
References: <20171204114224.27712-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20171204114224.27712-1-christian.koenig@amd.com>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>, Hongbo.He@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxNy0xMi0wNCAxMjo0MiBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBXaGVuIHdl
IGRldGVjdCBjb25zZWN1dGl2ZSBhbGxvY2F0aW9uIG9mIHBhZ2VzIHN3YXAgdGhlbSB0byBhdm9p
ZAo+IGFjY2lkZW50YWxseSBmcmVlaW5nIHRoZW0gYXMgaHVnZSBwYWdlLgo+IAo+IFNpZ25lZC1v
ZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAtLS0K
PiAgZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jIHwgOCArKysrKysrKwo+ICAx
IGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2MuYyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3Bh
Z2VfYWxsb2MuYwo+IGluZGV4IGM4MmQ5NGNiYmFiYy4uNjA0MDEzNTBhMDFhIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2MuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2MuYwo+IEBAIC05MjEsNiArOTIxLDE0IEBAIHN0YXRp
YyBpbnQgdHRtX2dldF9wYWdlcyhzdHJ1Y3QgcGFnZSAqKnBhZ2VzLCB1bnNpZ25lZCBucGFnZXMs
IGludCBmbGFncywKPiAgCQkJCXJldHVybiAtRU5PTUVNOwo+ICAJCQl9Cj4gIAo+ICsJCQkvKiBT
d2FwIHRoZSBwYWdlcyBpZiB3ZSBkZXRlY3QgY29uc2VjdXRpdmUgb3JkZXIgKi8KPiArCQkJaWYg
KGkgJiYgcGFnZXNbaSAtIDFdID09IHAgLSAxKSB7Cj4gKwkJCQlzdHJ1Y3QgcGFnZSAqdG1wID0g
cDsKPiArCj4gKwkJCQlwID0gcGFnZXNbaSAtIDFdOwo+ICsJCQkJcGFnZXNbaSAtIDFdID0gdG1w
Owo+ICsJCQl9Cj4gKwoKU2hvdWxkIGJlIChzb21ldGhpbmcgbGlrZSk6CgoJCWlmIChpICYmIHBh
Z2VzW2kgLSAxXSA9PSBwIC0gMSkKCQkJc3dhcChwYWdlc1tpIC0gMV0sIHApOwoKCi0tIApFYXJ0
aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDov
L3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAg
ICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcmktZGV2ZWwK
