From: Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 4/6] drm/udl: Use drm_dev_unregister()
Date: Thu, 7 Feb 2019 16:07:52 -0500
Message-ID: <20190207210752.GF114153@art_vandelay>
References: <20190203154200.61479-1-noralf@tronnes.org>
 <20190203154200.61479-5-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190203154200.61479-5-noralf@tronnes.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: David1.Zhou@amd.com, oleksandr_andrushchenko@epam.com, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, airlied@redhat.com, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

T24gU3VuLCBGZWIgMDMsIDIwMTkgYXQgMDQ6NDE6NThQTSArMDEwMCwgTm9yYWxmIFRyw7hubmVz
IHdyb3RlOgo+IGRybV9kZXZfdW5wbHVnKCkgaGFzIGJlZW4gc3RyaXBwZWQgZG93biBhbmQgaXMg
Z29pbmcgYXdheS4gT3BlbiBjb2RlIGl0cwo+IDIgcmVtYWluaW5nIGZ1bmN0aW9uIGNhbGxzLgo+
IAo+IENjOiBEYXZlIEFpcmxpZSA8YWlybGllZEByZWRoYXQuY29tPgo+IENjOiBTZWFuIFBhdWwg
PHNlYW5AcG9vcmx5LnJ1bj4KClJldmlld2VkLWJ5OiBTZWFuIFBhdWwgPHNlYW5AcG9vcmx5LnJ1
bj4KCj4gU2lnbmVkLW9mZi1ieTogTm9yYWxmIFRyw7hubmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+
Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS91ZGwvdWRsX2Rydi5jIHwgMyArKy0KPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vdWRsL3VkbF9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS91ZGwvdWRs
X2Rydi5jCj4gaW5kZXggMjJjZDJkMTNlMjcyLi4wNjNlOGUxZTI2NDEgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3VkbC91ZGxfZHJ2LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdWRs
L3VkbF9kcnYuYwo+IEBAIC0xMDYsNyArMTA2LDggQEAgc3RhdGljIHZvaWQgdWRsX3VzYl9kaXNj
b25uZWN0KHN0cnVjdCB1c2JfaW50ZXJmYWNlICppbnRlcmZhY2UpCj4gIAlkcm1fa21zX2hlbHBl
cl9wb2xsX2Rpc2FibGUoZGV2KTsKPiAgCXVkbF9mYmRldl91bnBsdWcoZGV2KTsKPiAgCXVkbF9k
cm9wX3VzYihkZXYpOwo+IC0JZHJtX2Rldl91bnBsdWcoZGV2KTsKPiArCWRybV9kZXZfdW5yZWdp
c3RlcihkZXYpOwo+ICsJZHJtX2Rldl9wdXQoZGV2KTsKPiAgfQo+ICAKPiAgLyoKPiAtLSAKPiAy
LjIwLjEKPiAKCi0tIApTZWFuIFBhdWwsIFNvZnR3YXJlIEVuZ2luZWVyLCBHb29nbGUgLyBDaHJv
bWl1bSBPUwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJ
bnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK
