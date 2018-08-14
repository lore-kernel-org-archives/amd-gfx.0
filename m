From: Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH 1/4] drm/scheduler: trivial error handling fix
Date: Tue, 14 Aug 2018 16:23:31 +0800
Message-ID: <20180814082330.GA16613@hr-amur2>
References: <20180814081226.76086-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20180814081226.76086-1-christian.koenig@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBBdWcgMTQsIDIwMTggYXQgMTA6MTI6MjNBTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBSZXR1cm4gLUVOT01FTSB3aGVuIGFsbG9jYXRpbmcgdGhlIHJxX2xpc3QgZmFp
bHMuCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cgo+
IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYyB8IDMgKysr
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL3NjaGVkdWxlci9ncHVfc2NoZWR1bGVyLmMgYi9kcml2ZXJzL2dwdS9kcm0v
c2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYwo+IGluZGV4IGY1NjY0MDVmNDllMy4uODVjMWY5NTc1
MmNjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxl
ci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9ncHVfc2NoZWR1bGVyLmMKPiBA
QCAtMTkxLDYgKzE5MSw5IEBAIGludCBkcm1fc2NoZWRfZW50aXR5X2luaXQoc3RydWN0IGRybV9z
Y2hlZF9lbnRpdHkgKmVudGl0eSwKPiAgCWVudGl0eS0+bnVtX3JxX2xpc3QgPSBudW1fcnFfbGlz
dDsKPiAgCWVudGl0eS0+cnFfbGlzdCA9IGtjYWxsb2MobnVtX3JxX2xpc3QsIHNpemVvZihzdHJ1
Y3QgZHJtX3NjaGVkX3JxICopLAo+ICAJCQkJR0ZQX0tFUk5FTCk7Cj4gKwlpZiAoIWVudGl0eS0+
cnFfbGlzdCkKPiArCQlyZXR1cm4gLUVOT01FTTsKPiArCj4gIAlmb3IgKGkgPSAwOyBpIDwgbnVt
X3JxX2xpc3Q7ICsraSkKPiAgCQllbnRpdHktPnJxX2xpc3RbaV0gPSBycV9saXN0W2ldOwo+ICAJ
ZW50aXR5LT5sYXN0X3NjaGVkdWxlZCA9IE5VTEw7Cj4gLS0gCj4gMi4xNC4xCj4gCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
