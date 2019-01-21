From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Mon, 21 Jan 2019 19:20:02 +0100
Message-ID: <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org>
 <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org>
 <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
 <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net>
 <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
 <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: David Zhou <David1.Zhou@amd.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>, Junwei Zhang <Jerry.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>, Christian Koenig <christian.koenig@amd.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCAyMSBKYW4gMjAxOSBhdCAxOTowNCwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVu
emVyLm5ldD4gd3JvdGU6Cj4KPiBPbiAyMDE5LTAxLTIxIDY6NTkgcC5tLiwgQXJkIEJpZXNoZXV2
ZWwgd3JvdGU6Cj4gPiBPbiBNb24sIDIxIEphbiAyMDE5IGF0IDE4OjU1LCBNaWNoZWwgRMOkbnpl
ciA8bWljaGVsQGRhZW56ZXIubmV0PiB3cm90ZToKPiA+Pgo+ID4+IE9uIDIwMTktMDEtMjEgNToz
MCBwLm0uLCBBcmQgQmllc2hldXZlbCB3cm90ZToKPiA+Pj4gT24gTW9uLCAyMSBKYW4gMjAxOSBh
dCAxNzoyMiwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPiB3cm90ZToKPiA+
Pj4KPiA+Pj4+IFVudGlsIHRoYXQgaGFwcGVucyB3ZSBzaG91bGQganVzdCBjaGFuZ2UgdGhlIGRy
aXZlciBpZmRlZnMgdG8gZGVmYXVsdAo+ID4+Pj4gdGhlIGhhY2tzIHRvIG9mZiBhbmQgb25seSBl
bmFibGUgdGhlbSBvbiBzZXR1cHMgd2hlcmUgd2UgMTAwJQo+ID4+Pj4gcG9zaXRpdmVseSBrbm93
IHRoYXQgdGhleSBhY3R1YWxseSB3b3JrLiAgQW5kIGRvY3VtZW50IHRoYXQgZmFjdAo+ID4+Pj4g
aW4gYmlnIGZhdCBjb21tZW50cy4KPiA+Pj4KPiA+Pj4gV2VsbCwgYXMgSSBtZW50aW9uZWQgaW4g
bXkgY29tbWl0IGxvZyBhcyB3ZWxsLCBpZiB3ZSBkZWZhdWx0IHRvIG9mZgo+ID4+PiB1bmxlc3Mg
Q09ORklHX1g4Niwgd2UgbWF5IGJyZWFrIHdvcmtpbmcgc2V0dXBzIG9uIE1JUFMgYW5kIFBvd2Vy
IHdoZXJlCj4gPj4+IHRoZSBkZXZpY2UgaXMgaW4gZmFjdCBub24tY2FjaGUgY29oZXJlbnQsIGFu
ZCByZWxpZXMgb24gdGhpcwo+ID4+PiAnb3B0aW1pemF0aW9uJyB0byBnZXQgdGhpbmdzIHdvcmtp
bmcuCj4gPj4KPiA+PiBGV0lXLCB0aGUgYW1kZ3B1IGRyaXZlciBkb2Vzbid0IHJlbHkgb24gbm9u
LXNub29wZWQgdHJhbnNmZXJzIGZvcgo+ID4+IGNvcnJlY3QgYmFzaWMgb3BlcmF0aW9uICh0aGUg
c2NlbmFyaW8gQ2hyaXN0aWFuIGJyb3VnaHQgdXAgaXMgYSB2ZXJ5Cj4gPj4gc3BlY2lhbGl6ZWQg
dXNlLWNhc2UpLCBzbyB0aGF0IHNob3VsZG4ndCBiZSBhbiBpc3N1ZS4KPiA+Pgo+ID4KPiA+IFRo
ZSBwb2ludCBpcyB0aGF0IHRoaXMgaXMgb25seSB0cnVlIGZvciB4ODYuCj4gPgo+ID4gT24gb3Ro
ZXIgYXJjaGl0ZWN0dXJlcywgdGhlIHVzZSBvZiBub24tY2FjaGVkIG1hcHBpbmdzIG9uIHRoZSBD
UFUgc2lkZQo+ID4gbWVhbnMgdGhhdCB5b3UgL2RvLyByZWx5IG9uIG5vbi1zbm9vcGVkIHRyYW5z
ZmVycywgc2luY2UgaWYgdGhvc2UKPiA+IHRyYW5zZmVycyB0dXJuIG91dCBub3QgdG8gc25vb3Ag
aW5hZHZlcnRlbnRseSwgdGhlIGFjY2Vzc2VzIGFyZQo+ID4gaW5jb2hlcmVudCB3aXRoIHRoZSBD
UFUncyB2aWV3IG9mIG1lbW9yeS4KPgo+IFRoZSBkcml2ZXIgZ2VuZXJhbGx5IG9ubHkgdXNlcyBu
b24tY2FjaGVkIG1hcHBpbmdzIGlmCj4gZHJtX2FyY2gvZGV2aWNlX2Nhbl93Y19tZW1vcnkgcmV0
dXJucyB0cnVlLgo+CgpJbmRlZWQuIEFuZCBzbyB3ZSBzaG91bGQgdGFrZSBjYXJlIHRvIG9ubHkg
cmV0dXJuICd0cnVlJyBmcm9tIHRoYXQKZnVuY3Rpb24gaWYgaXQgaXMgZ3VhcmFudGVlZCB0aGF0
IG5vbi1jYWNoZWQgQ1BVIG1hcHBpbmdzIGFyZSBjb2hlcmVudAp3aXRoIHRoZSBtYXBwaW5ncyB1
c2VkIGJ5IHRoZSBHUFUsIGVpdGhlciBiZWNhdXNlIHRoYXQgaXMgYWx3YXlzIHRoZQpjYXNlIChs
aWtlIG9uIHg4NiksIG9yIGJlY2F1c2Ugd2Uga25vdyB0aGF0IHRoZSBwbGF0Zm9ybSBpbiBxdWVz
dGlvbgppbXBsZW1lbnRzIE5vU25vb3AgY29ycmVjdGx5IHRocm91Z2hvdXQgdGhlIGludGVyY29u
bmVjdC4KCldoYXQgc2VlbXMgdG8gYmUgY29tcGxpY2F0aW5nIG1hdHRlcnMgaXMgdGhhdCBpbiBz
b21lIGNhc2VzLCB0aGUKZGV2aWNlIGlzIG5vbi1jYWNoZSBjb2hlcmVudCB0byBiZWdpbiB3aXRo
LCBzbyByZWdhcmRsZXNzIG9mIHdoZXRoZXIKdGhlIE5vU25vb3AgYXR0cmlidXRlIGlzIHVzZWQg
b3Igbm90LCB0aG9zZSBhY2Nlc3NlcyB3aWxsIG5vdCBzbm9vcCBpbgp0aGUgY2FjaGVzIGFuZCBi
ZSBjb2hlcmVudCB3aXRoIHRoZSBub24tY2FjaGVkIG1hcHBpbmdzIHVzZWQgYnkgdGhlCkNQVS4g
U28gaWYgd2UgcmVzdHJpY3QgdGhpcyBvcHRpbWl6YXRpb24gW29uIG5vbi1YODZdIHRvIHBsYXRm
b3Jtcwp0aGF0IGFyZSBrbm93biB0byBpbXBsZW1lbnQgTm9Tbm9vcCBjb3JyZWN0bHksIHdlIG1h
eSBicmVhayBwbGF0Zm9ybXMKdGhhdCBhcmUgaW1wbGljaXRseSBOb1Nub29wIGFsbCB0aGUgdGlt
ZS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
