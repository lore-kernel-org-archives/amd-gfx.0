From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH 1/3] drm/dp: Use non-cyclic idr
Date: Tue, 23 Apr 2019 17:49:22 +0300
Message-ID: <20190423144922.GS1747@intel.com>
References: <1555977388-14203-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1555977388-14203-1-git-send-email-sunpeng.li@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: sunpeng.li@amd.com
Cc: jerry.zuo@amd.com, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBBcHIgMjIsIDIwMTkgYXQgMDc6NTY6MjZQTSAtMDQwMCwgc3VucGVuZy5saUBhbWQu
Y29tIHdyb3RlOgo+IEZyb206IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgo+IAo+IEluIHBy
ZXBhcmF0aW9uIGZvciBhZGRpbmcgYXV4IGRldmljZXMgZm9yIERQIE1TVCwgbWFrZSB0aGUgSURS
Cj4gbm9uLWN5Y2xpYy4gVGhhdCB3YXksIGhvdHBsdWcgY3ljbGluZyBNU1QgZGV2aWNlcyB3b24n
dCBuZWVkbGVzc2x5Cj4gaW5jcmVtZW50IHRoZSBtaW5vciB2ZXJzaW9uIGluZGV4Lgo+IAo+IFNp
Z25lZC1vZmYtYnk6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgoKSSBkb24ndCByZWNhbGwg
YW55IHNwZWNpZmljIHJlYXNvbiBmb3IgdGhlIGN5Y2xpYyB2YXJpYW50LCBzbwpSZXZpZXdlZC1i
eTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4KCj4gLS0t
Cj4gIGRyaXZlcnMvZ3B1L2RybS9kcm1fZHBfYXV4X2Rldi5jIHwgMyArLS0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vZHJtX2RwX2F1eF9kZXYuYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHBf
YXV4X2Rldi5jCj4gaW5kZXggMGU0ZjI1ZC4uNmQ4NDYxMSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vZHJtX2RwX2F1eF9kZXYuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHBf
YXV4X2Rldi5jCj4gQEAgLTgwLDggKzgwLDcgQEAgc3RhdGljIHN0cnVjdCBkcm1fZHBfYXV4X2Rl
diAqYWxsb2NfZHJtX2RwX2F1eF9kZXYoc3RydWN0IGRybV9kcF9hdXggKmF1eCkKPiAgCWtyZWZf
aW5pdCgmYXV4X2Rldi0+cmVmY291bnQpOwo+ICAKPiAgCW11dGV4X2xvY2soJmF1eF9pZHJfbXV0
ZXgpOwo+IC0JaW5kZXggPSBpZHJfYWxsb2NfY3ljbGljKCZhdXhfaWRyLCBhdXhfZGV2LCAwLCBE
Uk1fQVVYX01JTk9SUywKPiAtCQkJCSBHRlBfS0VSTkVMKTsKPiArCWluZGV4ID0gaWRyX2FsbG9j
KCZhdXhfaWRyLCBhdXhfZGV2LCAwLCBEUk1fQVVYX01JTk9SUywgR0ZQX0tFUk5FTCk7Cj4gIAlt
dXRleF91bmxvY2soJmF1eF9pZHJfbXV0ZXgpOwo+ICAJaWYgKGluZGV4IDwgMCkgewo+ICAJCWtm
cmVlKGF1eF9kZXYpOwo+IC0tIAo+IDIuNy40CgotLSAKVmlsbGUgU3lyasOkbMOkCkludGVsCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
