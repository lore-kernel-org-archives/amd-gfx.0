From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 3/6] drm: fourcc byteorder: add bigendian support to
 drm_mode_legacy_fb_format
Date: Thu, 27 Apr 2017 09:52:59 +0900
Message-ID: <6bd62182-0de5-a8a7-78c3-029fc73ecc91@daenzer.net>
References: <20170424062532.26722-1-kraxel@redhat.com>
 <20170424062532.26722-4-kraxel@redhat.com>
 <3b872a56-80b5-0c44-712f-a9517489eb24@daenzer.net>
 <1493185990.23739.7.camel@redhat.com>
 <8f91cc58-16dc-5899-66b6-06d430a18801@daenzer.net>
 <1493208671.23739.19.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1493208671.23739.19.camel@redhat.com>
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
Cc: Daniel Vetter <daniel.vetter@intel.com>, amd-gfx@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMjYvMDQvMTcgMDk6MTEgUE0sIEdlcmQgSG9mZm1hbm4gd3JvdGU6Cj4gICBIaSwKPiAKPj4+
PiBKdXN0IHRvIHJlaXRlcmF0ZSwgdGhpcyB3b24ndCB3b3JrIGZvciB0aGUgcmFkZW9uIGRyaXZl
ciwgd2hpY2ggcHJvZ3JhbXMKPj4+PiB0aGUgR1BVIHRvIHVzZSAoZWZmZWN0aXZlbHksIHBlciB0
aGUgY3VycmVudCBkZWZpbml0aW9uIHRoYXQgdGhlc2UgYXJlCj4+Pj4gbGl0dGxlIGVuZGlhbiBH
UFUgZm9ybWF0cykgRFJNX0ZPUk1BVF9YUkdCODg4OCB3aXRoIHByZS1SNjAwIGFuZAo+Pj4+IERS
TV9GT1JNQVRfQkdSWDg4ODggd2l0aCA+PSBSNjAwLgo+Pj4KPj4+IEhtbSwgb2ssIGhvdyBkb2Vz
IGJpZ2VuZGlhbiBmYmRldiBlbXVsYXRpb24gd29yayBvbiBwcmUtUjYwMCB0aGVuPwo+Pgo+PiBV
c2luZyBhIEdQVSBieXRlIHN3YXBwaW5nIG1lY2hhbmlzbSB3aGljaCBvbmx5IGFmZmVjdHMgQ1BV
IGFjY2VzcyB0bwo+PiB2aWRlbyBSQU0uCj4gCj4gVGhhdCBpcyBkb25lIHVzaW5nIHRoZSBSQURF
T05fVElMSU5HX1NXQVBfezE2LDMyfUJJVCBmbGFnIG1lbnRpb25lZCBpbgo+IGFub3RoZXIgdGhy
ZWFkPwoKUmlnaHQuCgoKPiBXaGF0IGFib3V0IGR1bWIgYm9zPyAgWW91J3ZlIG1lbnRpb25lZCB0
aGUgc3dhcCBmbGFnIGlzbid0IHVzZWQgZm9yCj4gdGhvc2UuICBXaGljaCBpbXBsaWVzIHRoZXkg
YXJlIGluIGxpdHRsZSBlbmRpYW4gYnl0ZSBvcmRlciAoYm90aCBncHUgYW5kCj4gY3B1IHZpZXcp
LgoKUmlnaHQsIEFGQUlDVCBmcm9tIGxvb2tpbmcgYXQgdGhlIGNvZGUuCgoKPiBEb2VzIHRoZSBt
b2Rlc2V0dGluZyBkcml2ZXIgd29yayBjb3JyZWN0bHkgb24gdGhhdCBoYXJkd2FyZT8KCk5vdCBz
dXJlLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAg
ICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAg
ICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0
CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
