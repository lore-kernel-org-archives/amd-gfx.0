From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH v2 0/3] A DRM API for adaptive sync and variable refresh
 rate support
Date: Fri, 12 Oct 2018 10:26:36 +0200
Message-ID: <ac5b5865-6bb0-08e8-d83c-26893e75b11e@daenzer.net>
References: <20180924181537.12092-1-nicholas.kazlauskas@amd.com>
 <20181001071525.GJ11082@phenom.ffwll.local>
 <CAHbf0-HhjG2xc1sAjHBR=Ep11LzumO6tdyzBcKSZ8h82H28Zbg@mail.gmail.com>
 <814b9eae-8c17-4eb7-2bb7-a6ec1f0fab41@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <814b9eae-8c17-4eb7-2bb7-a6ec1f0fab41@amd.com>
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
To: Harry Wentland <harry.wentland@amd.com>, Mike Lothian <mike@fireburn.co.uk>, Daniel Vetter <daniel@ffwll.ch>
Cc: nicolai.haehnle@amd.com, Marek.Olsak@amd.com, dri-devel@lists.freedesktop.org, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, manasi.d.navare@intel.com, amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, Christian.Koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOC0xMC0xMSA5OjQ0IHAubS4sIEhhcnJ5IFdlbnRsYW5kIHdyb3RlOgo+IE9uIDIwMTgt
MTAtMDMgMDQ6MjUgQU0sIE1pa2UgTG90aGlhbiB3cm90ZToKPj4gCj4+IEknbSBjdXJpb3VzIHRv
IGtub3cgd2hldGhlciB0aGlzIHdpbGwvY291bGQgd29yayBvdmVyIFBSSU1FCj4gCj4gSSBkb24n
dCBzZWUgd2h5IHRoaXMgc2hvdWxkbid0IHdvcmsgb3ZlciBQUklNRSBhcyBsb25nIGFzIHRoZQo+
IHByZXNlbnRpbmcgR1BVIHN1cHBvcnRzIHRoZSBuZXcgdmFyaWFibGUgcmVmcmVzaCByYXRlIEFQ
SSwgYnV0IEkga25vdwo+IHZlcnkgbGl0dGxlIGFib3V0IHByaW1lLCBzbyBtYXliZSBzb21lb25l
IGVsc2UgY2FuIGNoaW1lIGluIGFuZCBnaXZlCj4gYSBiZXR0ZXIgb3Bpbmlvbi4KCkl0IHdvbid0
IHdvcmsgZm9yIGRpc3BsYXlzIGNvbm5lY3RlZCB0byBhIHNlY29uZGFyeSBHUFUsIGJlY2F1c2Ug
dGhvc2UKYXJlbid0IGhvb2tlZCB1cCB0byB0aGUgUHJlc2VudCBleHRlbnNpb24gZGlyZWN0bHku
CgpJdCBjYW4gdGhlb3JldGljYWxseSB3b3JrIHdpdGggcmVuZGVyIG9mZmxvYWRpbmcsIGlmIHRo
ZSBwcmltYXJ5IEdQVSBjYW4Kc2NhbiBvdXQgZGlyZWN0bHkgZnJvbSB0aGUgc2hhcmVkIHBpeG1h
cC4gVGhpcyBpcyBvbmx5IHBvc3NpYmxlIHdpdGgKY3VycmVudCBBTUQgQVBVcyB3aGljaCBzdXBw
b3J0IHNjYXR0ZXIvZ2F0aGVyIHNjYW5vdXQgKENhcnJpem8gYW5kCm5ld2VyPykuIE9uZSBnb3Rj
aGEgaXMgdGhhdCB4Zjg2LXZpZGVvLWFtZGdwdSBjdXJyZW50bHkgZG9lc24ndCBhbGxvdwpmbGlw
cGluZyBiZXR3ZWVuIGJ1ZmZlcnMgd2l0aCBkaWZmZXJlbnQgdGlsaW5nIHBhcmFtZXRlcnMgKEJU
VyBIYXJyeSwKZG9lcyB0aGF0IHdvcmsgd2l0aCBEQz8pLCBidXQgdGhhdCBzaG91bGQgYmUgZWFz
eSB0byBmaXguCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFz
dCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
