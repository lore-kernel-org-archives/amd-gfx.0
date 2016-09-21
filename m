From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/i915: Before pageflip, also wait for shared dmabuf
 fences.
Date: Thu, 22 Sep 2016 00:28:54 +0900
Message-ID: <57a90c09-14f4-f741-2628-fa5f341708f0@daenzer.net>
References: <1473293683-6247-1-git-send-email-mario.kleiner.de@gmail.com>
 <20160908063038.GB28919@nuc-i3427.alporthouse.com>
 <9e28ae2e-ed2f-ef0e-8690-1f78f5aed18b@gmail.com>
 <20160908162346.GA5479@nuc-i3427.alporthouse.com>
 <abccc8ac-10c6-ab22-c59d-f43ee48ba78d@daenzer.net>
 <bdd0653d-e4d6-fbbe-89f1-b1104682bf02@vodafone.de>
 <20160913093945.GA25204@nuc-i3427.alporthouse.com>
 <9c0f86d0-eb23-7110-c663-01859132ac83@vodafone.de>
 <7aafce92-8bcf-1c5c-45de-9e8ecda85239@daenzer.net>
 <554f660d-cc8d-295e-42aa-c374e95bdc8a@vodafone.de>
 <f0e034f9-db22-6577-97c7-dd8d3e851226@daenzer.net>
 <b433cd8c-40fc-eaed-3df8-27eb5bd60649@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <b433cd8c-40fc-eaed-3df8-27eb5bd60649@vodafone.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>, Chris Wilson <chris@chris-wilson.co.uk>, Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMjIvMDkvMTYgMTI6MjEgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjEuMDku
MjAxNiB1bSAxNzoxMyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+PiBPbiAyMS8wOS8xNiAwNzoz
MCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEFtIDIxLjA5LjIwMTYgdW0gMTE6NTYg
c2NocmllYiBNaWNoZWwgRMOkbnplcjoKPj4+PiBGV0lXLCB3ZSBzZWVtIHRvIGhhdmUgdGhlIHNh
bWUgaXNzdWUgd2l0aCByYWRlb24gdnMuIGFtZGdwdTogcmFkZW9uCj4+Pj4gb25seQo+Pj4+IHNl
ZW1zIHRvIHdhaXQgZm9yIGV4Y2x1c2l2ZSBmZW5jZXMsIHNvIGUuZy4gcnVubmluZyBYb3JnIG9u
IGFtZGdwdSBhbmQKPj4+PiB1c2luZyBQUklNRSBzbGF2ZSBzY2Fub3V0IG9uIHJhZGVvbiBsZWF2
ZXMgYXJ0aWZhY3RzLgo+Pj4gWWVhaCwgSSBrbm93LiBTZWUgcmFkZW9uX2Rpc3BsYXkuYyByYWRl
b25fZmxpcF93b3JrX2Z1bmMoKS4KPj4+Cj4+PiBXZSBwcmV0dHkgbXVjaCBuZWVkIHRoZSBzYW1l
IHBhdGNoIGhlcmUgSSd2ZSBkb25lIGZvciBhbWRncHUgYXMgd2VsbC4KPj4gQWN0dWFsbHksIHRo
ZSBQUklNRSBzbGF2ZSBjYW4ndCBzY2FuIG91dCBmcm9tIHRoZSBzaGFyZWQgQk9zIGRpcmVjdGx5
Cj4+IChyZWNhbGwgdGhlIHJlY2VudCBkaXNjdXNzaW9uIHdlIGhhZCBhYm91dCB0aGF0IHdpdGgg
TWFyaW8pLCBidXQgaGFzIHRvCj4+IGNvcHkgZnJvbSB0aGUgc2hhcmVkIEJPIHRvIGEgZGVkaWNh
dGVkIHNjYW5vdXQgQk8uIFRoZXNlIGNvcGllcyBuZWVkIHRvCj4+IGJlIHN5bmNocm9uaXplZCB3
aXRoIHRoZSBwcmltYXJ5IEdQVSdzIGNvcGllcyB0byB0aGUgc2hhcmVkIEJPLgo+IAo+IFllYWgs
IHRoYXQgdGhvdWdodCBjYW1lIHRvIG15IG1pbmQgYmVmb3JlIGFzIHdlbGwuCj4gCj4gQnVmZmVy
IG1pZ3JhdGlvbnMgYnkgdGhlIGtlcm5lbCBjYXVzZWQgYnkgYSBwcmltZSBleHBvcnQgYWN0dWFs
bHkgc2V0Cj4gdGhlIGV4Y2x1c2l2ZSBmZW5jZS4KPiAKPiBTbyB0aGlzIHNob3VsZG4ndCBiZSBh
biBpc3N1ZSBpbiBwcmFjdGljZSB3aGVuIHRoZSBkaXNwbGF5aW5nIEdQVSBuZWVkcwo+IHRvIGNv
cHkgZnJvbSB0aGUgQk8gYWdhaW4gYW55d2F5Lgo+IAo+IFRoZSBvbmx5IGNhc2UgSSBjYW4gc2Vl
IHdoZW4gdGhpcyBjYW4gaGFwcGVuIGlzIHdoZW4gdGhlIEJPIGlzIGNvbXBvc2VkCj4gZGlyZWN0
bHkgaW4gc3lzdGVtIG1lbW9yeSBieSB0aGUgZW5naW5lcyBhbmQgbm90IG1pZ3JhdGVkIHRoZXJl
LgoKVGhlcmUgaXMgbm8gbWlncmF0aW9uIGdvaW5nIG9uIGluIHRoZSBzdGVhZHkgc3RhdGUsIGp1
c3QgdGhlIHByaW1hcnkgR1BVCndyaXRpbmcgdG8gdGhlIHNoYXJlZCBCTyBhbmQgdGhlIHNsYXZl
IEdQVSByZWFkaW5nIGZyb20gaXQuIElmIHRob3NlCm9wZXJhdGlvbnMgYXJlbid0IHByb3Blcmx5
IHN5bmNocm9uaXplZCwgdGhlcmUgaXMgYXQgbGVhc3QgaW50ZXJtaXR0ZW50CnRlYXJpbmcsIGJ1
dCB0aGVyZSBjYW4gZXZlbiBiZSBhcnRpZmFjdHMgd2hpY2ggc3RheSB1bnRpbCB0aGF0IGFyZWEg
aXMKdXBkYXRlZCBhZ2Fpbi4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBl
bnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
