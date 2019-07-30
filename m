From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [RFC PATCH 0/3] Propose new struct drm_mem_region
Date: Tue, 30 Jul 2019 16:33:12 +0200
Message-ID: <CAKMK7uGhwWcJ_PzHF_7uVMP+=3fLug4FfB2k6Q4Dy2C+z2Ae9g@mail.gmail.com>
References: <20190730003225.322-1-brian.welty@intel.com>
 <951e9e42-96bc-fc8d-0153-3ca7ac5f1e74@amd.com>
 <20190730093847.GP15868@phenom.ffwll.local>
 <ee600bcd-d880-7199-21d0-df6e51f5adfa@amd.com>
 <CAKMK7uHrGgn7FqSBD+qDYYHxyPLvv5OqzwLTACWuqbjANKFuQA@mail.gmail.com>
 <743ab99e-95cb-f6fa-6903-5556d5050f6d@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <743ab99e-95cb-f6fa-6903-5556d5050f6d@daenzer.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Brian Welty <brian.welty@intel.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBKdWwgMzAsIDIwMTkgYXQgNDozMCBQTSBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRh
ZW56ZXIubmV0PiB3cm90ZToKPiBPbiAyMDE5LTA3LTMwIDEyOjQ1IHAubS4sIERhbmllbCBWZXR0
ZXIgd3JvdGU6Cj4gPiBPbiBUdWUsIEp1bCAzMCwgMjAxOSBhdCAxMjoyNCBQTSBLb2VuaWcsIENo
cmlzdGlhbgo+ID4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4gPj4gQW0gMzAu
MDcuMTkgdW0gMTE6Mzggc2NocmllYiBEYW5pZWwgVmV0dGVyOgo+ID4+PiBPbiBUdWUsIEp1bCAz
MCwgMjAxOSBhdCAwODo0NTo1N0FNICswMDAwLCBLb2VuaWcsIENocmlzdGlhbiB3cm90ZToKPiA+
Cj4gPj4+Pj4gKyNkZWZpbmUgRFJNX01FTV9TWVNURU0gICAgIDAKPiA+Pj4+PiArI2RlZmluZSBE
Uk1fTUVNX1NUT0xFTiAgICAgMQo+ID4+Pj4gSSB0aGluayB3ZSBuZWVkIGEgYmV0dGVyIG5hbWlu
ZyBmb3IgdGhhdC4KPiA+Pj4+Cj4gPj4+PiBTVE9MRU4gc291bmRzIHdheSB0byBtdWNoIGxpa2Ug
c3RvbGVuIFZSQU0gZm9yIGludGVncmF0ZWQgR1BVcywgYnV0IGF0Cj4gPj4+PiBsZWFzdCBmb3Ig
VFRNIHRoaXMgaXMgdGhlIHN5c3RlbSBtZW1vcnkgY3VycmVudGx5IEdQVSBhY2Nlc3NpYmxlLgo+
ID4+PiBZdXAgdGhpcyBpcyB3cm9uZywgZm9yIGk5MTUgd2UgdXNlIHRoaXMgYXMgc3RvbGVuLCBm
b3IgdHRtIGl0J3MgdGhlIGdwdQo+ID4+PiB0cmFuc2xhdGlvbiB0YWJsZSB3aW5kb3cgaW50byBz
eXN0ZW0gbWVtb3J5LiBOb3QgdGhlIHNhbWUgdGhpbmcgYXQgYWxsLgo+ID4+Cj4gPj4gVGhvdWdo
dCBzby4gVGhlIGNsb3Nlc3QgSSBoYXZlIGluIG1pbmQgaXMgR1RULCBidXQgZXZlcnl0aGluZyBl
bHNlIHdvcmtzCj4gPj4gYXMgd2VsbC4KPiA+Cj4gPiBXb3VsZCB5b3VyIEdQVV9NQVBQRUQgYWJv
dmUgd29yayBmb3IgVFQ/IEkgdGhpbmsgd2UnbGwgYWxzbyBuZWVkCj4gPiBTVE9MRU4sIEknbSBl
dmVuIGhlYXJpbmcgbm9pc2VzIHRoYXQgdGhlcmUncyBnb2luZyB0byBiZSBzdG9sZW4gZm9yCj4g
PiBkaXNjcmV0ZSB2cmFtIGZvciB1cyAuLi4KPgo+IENvdWxkIGk5MTUgdXNlIERSTV9NRU1fUFJJ
ViBmb3Igc3RvbGVuPyBPciBpcyB0aGVyZSBvdGhlciBoYXJkd2FyZSB3aXRoCj4gc29tZXRoaW5n
IHNpbWlsYXI/CgpJIGRvbid0IHRoaW5rIGl0IG1hdHRlcnMgbXVjaCB3aGF0IHdlIG5hbWUgaXQg
Li4uIF9QUklWIHNvdW5kcyBhcyBnb29kCmFzIGFueXRoaW5nIGVsc2UuIEFzIGxvbmcgYXMgd2Ug
bWFrZSBpdCBjbGVhciB0aGF0IHVzZXJzcGFjZSBibyBhbHNvCm1pZ2h0IGVuZCB1cCBpbiB0aGVy
ZSBJIHRoaW5rIGl0J3MgYWxsIGdvb2QuCi1EYW5pZWwKLS0gCkRhbmllbCBWZXR0ZXIKU29mdHdh
cmUgRW5naW5lZXIsIEludGVsIENvcnBvcmF0aW9uCis0MSAoMCkgNzkgMzY1IDU3IDQ4IC0gaHR0
cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVs
