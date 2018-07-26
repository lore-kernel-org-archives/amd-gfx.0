From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 0/4] drm/ttm: move non-x86 definitions to the common
 header
Date: Thu, 26 Jul 2018 14:12:05 +0200
Message-ID: <37af9c14-8c31-0e43-eff2-dab893bd8e0e@amd.com>
References: <1532605933-26209-1-git-send-email-ray.huang@amd.com>
 <CAC4kW=2cFrK_3aqMpgv0Y-06mizOqkOX-ZZ0T2QGFPGi_emoLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAC4kW=2cFrK_3aqMpgv0Y-06mizOqkOX-ZZ0T2QGFPGi_emoLg@mail.gmail.com>
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
To: Bas Nieuwenhuizen <basni@chromium.org>, Huang Rui <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjYuMDcuMjAxOCB1bSAxMzo1OSBzY2hyaWViIEJhcyBOaWV1d2VuaHVpemVuOgo+IE9uIFRo
dSwgSnVsIDI2LCAyMDE4IGF0IDE6NTIgUE0sIEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+
IHdyb3RlOgo+PiBIaSwKPj4KPj4gQXMgc3VnZ2VzdGVkIGJ5IENocmlzdGlhbiwgd2Ugc2hvdWxk
IG1vdmUgbm9uLXg4NiBkZWZpbml0aW9ucyBpbnRvIG9uZSBjb21tb24KPj4gaGVhZGVyLCBhbmQg
aXQgd2lsbCBtYWtlIHRoZSBjb2RlcyByZWFkYWJsZS4gVGhleSBhcmUgYmFzZWQgb24gdGhlIGlt
cHJvdmVtZW50Cj4+IGZpeCBvZiBCYXMgKGFscmVhZHkgcmViYXNlIEJhcydzIHBhdGNoIHRvIGRy
bS1uZXh0KS4KPj4KPj4gQ2hhbmdlcyBmcm9tIFYxIC0+IFYyOgo+PiAtIGFkZCB0dG1fIHByZWZp
eCBhdCB0aGlzIGhlYWRlci4KPj4gLSB1c2Ugc2V0X3BhZ2VzX3diIGluc3RlYWQgb2Ygc2V0X21l
bW9yeV93Yi4KPiBUaGFua3MhIEZvciB0aGUgc2VyaWVzCgpBZ3JlZWQsIHJlYWxseSBuaWNlIGNs
ZWFudXAuCgo+IFJldmlld2VkLWJ5OiBCYXMgTmlldXdlbmh1aXplbiA8YmFzbmlAY2hyb21pdW0u
b3JnPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4gYXMgd2VsbC4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4+IFRoYW5rcywKPj4gUmF5Cj4+
Cj4+IEJhcyBOaWV1d2VuaHVpemVuICgxKToKPj4gICAgZHJtL3R0bTogTWVyZ2UgaHVnZXBhZ2Ug
YXR0ciBjaGFuZ2VzIGluIHR0bV9kbWFfcGFnZV9wdXQuICh2MikKPj4KPj4gSHVhbmcgUnVpICgz
KToKPj4gICAgZHJtL3R0bTogYWRkIHR0bV9zZXRfbWVtb3J5IGhlYWRlciAodjIpCj4+ICAgIGRy
bS90dG06IGNsZWFuIHVwIG5vbi14ODYgZGVmaW5pdGlvbnMgb24gdHRtX3BhZ2VfYWxsb2NfZG1h
Cj4+ICAgIGRybS90dG06IGNsZWFuIHVwIG5vbi14ODYgZGVmaW5pdGlvbnMgb24gdHRtX3BhZ2Vf
YWxsb2MKPj4KPj4gICBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMgICAgIHwg
IDYyICsrLS0tLS0tLS0tLS0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxs
b2NfZG1hLmMgfCAgNTcgKystLS0tLS0tLS0tLS0KPj4gICBpbmNsdWRlL2RybS90dG0vdHRtX3Nl
dF9tZW1vcnkuaCAgICAgICAgIHwgMTI4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
Pj4gICAzIGZpbGVzIGNoYW5nZWQsIDE0MCBpbnNlcnRpb25zKCspLCAxMDcgZGVsZXRpb25zKC0p
Cj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHJtL3R0bS90dG1fc2V0X21lbW9yeS5o
Cj4+Cj4+IC0tCj4+IDIuNy40Cj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWwK
