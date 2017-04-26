From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 3/6] drm: fourcc byteorder: add bigendian support to
 drm_mode_legacy_fb_format
Date: Wed, 26 Apr 2017 18:21:10 +0900
Message-ID: <8f91cc58-16dc-5899-66b6-06d430a18801@daenzer.net>
References: <20170424062532.26722-1-kraxel@redhat.com>
 <20170424062532.26722-4-kraxel@redhat.com>
 <3b872a56-80b5-0c44-712f-a9517489eb24@daenzer.net>
 <1493185990.23739.7.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1493185990.23739.7.camel@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel Vetter <daniel.vetter@intel.com>, dri-devel@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMjYvMDQvMTcgMDI6NTMgUE0sIEdlcmQgSG9mZm1hbm4gd3JvdGU6Cj4gT24gRGksIDIwMTct
MDQtMjUgYXQgMTI6MTggKzA5MDAsIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+PiBPbiAyNC8wNC8x
NyAwMzoyNSBQTSwgR2VyZCBIb2ZmbWFubiB3cm90ZToKPj4+IFJldHVybiBjb3JyZWN0IGZvdXJj
YyBjb2RlcyBvbiBiaWdlbmRpYW4uICBEcml2ZXJzIG11c3QgYmUgYWRhcHRlZCB0bwo+Pj4gdGhp
cyBjaGFuZ2UuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJl
ZGhhdC5jb20+Cj4+Cj4+IEp1c3QgdG8gcmVpdGVyYXRlLCB0aGlzIHdvbid0IHdvcmsgZm9yIHRo
ZSByYWRlb24gZHJpdmVyLCB3aGljaCBwcm9ncmFtcwo+PiB0aGUgR1BVIHRvIHVzZSAoZWZmZWN0
aXZlbHksIHBlciB0aGUgY3VycmVudCBkZWZpbml0aW9uIHRoYXQgdGhlc2UgYXJlCj4+IGxpdHRs
ZSBlbmRpYW4gR1BVIGZvcm1hdHMpIERSTV9GT1JNQVRfWFJHQjg4ODggd2l0aCBwcmUtUjYwMCBh
bmQKPj4gRFJNX0ZPUk1BVF9CR1JYODg4OCB3aXRoID49IFI2MDAuCj4gCj4gSG1tLCBvaywgaG93
IGRvZXMgYmlnZW5kaWFuIGZiZGV2IGVtdWxhdGlvbiB3b3JrIG9uIHByZS1SNjAwIHRoZW4/CgpV
c2luZyBhIEdQVSBieXRlIHN3YXBwaW5nIG1lY2hhbmlzbSB3aGljaCBvbmx5IGFmZmVjdHMgQ1BV
IGFjY2VzcyB0bwp2aWRlbyBSQU0uCgoKPj4+ICsjaWZkZWYgX19CSUdfRU5ESUFOCj4+PiArCXN3
aXRjaCAoYnBwKSB7Cj4+PiArCWNhc2UgODoKPj4+ICsJCWZtdCA9IERSTV9GT1JNQVRfQzg7Cj4+
PiArCQlicmVhazsKPj4+ICsJY2FzZSAyNDoKPj4+ICsJCWZtdCA9IERSTV9GT1JNQVRfQkdSODg4
Owo+Pj4gKwkJYnJlYWs7Cj4+Cj4+IEJUVywgZW5kaWFubmVzcyBhcyBhIGNvbmNlcHQgY2Fubm90
IGFwcGx5IHRvIDggb3IgMjQgYnBwIGZvcm1hdHMuCj4gCj4gSSBjb3VsZCBtb3ZlIHRoZSA4IGJw
cCBjYXNlIG91dCBvZiB0aGUgI2lmZGVmIHNvbWVob3csIGJ1dCBjb2RlCj4gcmVhZGFiaWxpdHkg
d2lsbCBzdWZmZXIgdGhlbiBJIHRoaW5rIC4uLgoKSG93IHNvPwoKQXQgbGVhc3QgaXQgd291bGQg
bWFrZSBjbGVhcmVyIHdoaWNoIGZvcm1hdHMgYXJlIGFmZmVjdGVkIGJ5IGVuZGlhbm5lc3MKYW5k
IHdoaWNoIGFyZW4ndC4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRo
dXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
