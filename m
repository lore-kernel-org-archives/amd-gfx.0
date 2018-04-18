From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: RFC for a render API to support adaptive sync and VRR
Date: Wed, 18 Apr 2018 09:39:02 +0200
Message-ID: <CAKMK7uFMKEe24-cFuNx8N=JZsCG2qCZHn3orE5Aqyc8mXnuu2A@mail.gmail.com>
References: <c79421ce-9408-5cd6-5de3-0fa521146e4b@amd.com>
 <435ebd04-0435-5a6a-9f1e-e4c4fc629aa9@amd.com>
 <20180409214554.GB13967@intel.com>
 <1e8d1857-faba-85da-0136-ea7c29ec1b84@amd.com>
 <b75e31f7-ce59-de97-5445-cb4c03ff7336@daenzer.net> <87o9ihyxl1.fsf@keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <87o9ihyxl1.fsf@keithp.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Keith Packard <keithp@keithp.com>
Cc: =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle@amd.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@amd.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, Manasi Navare <manasi.d.navare@intel.com>, dri-devel <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBBcHIgMTgsIDIwMTggYXQgNTo1OCBBTSwgS2VpdGggUGFja2FyZCA8a2VpdGhwQGtl
aXRocC5jb20+IHdyb3RlOgo+IE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+IHdy
aXRlczoKPj4gVGltZS1iYXNlZCBwcmVzZW50YXRpb24gc2VlbXMgdG8gYmUgdGhlIHJpZ2h0IGFw
cHJvYWNoIGZvciBwcmV2ZW50aW5nCj4+IG1pY3JvLXN0dXR0ZXIgaW4gZ2FtZXMgYXMgd2VsbCwg
Q3JvdGVhbSBkZXZlbG9wZXJzIGhhdmUgYmVlbiByZXNlYXJjaGluZwo+PiB0aGlzLgo+Cj4gQm90
aCB0aGUgVnVsa2FuIEdPT0dMRV9kaXNwbGF5X3RpbWluZyBleHRlbnNpb24gYW5kIFgxMSBQcmVz
ZW50Cj4gZXh0ZW5zaW9uIG9mZmVyIHRoZSBhYmlsaXR5IHRvIHNwZWNpZnkgdGhlIGRlc2lyZWQg
ZGlzcGxheSB0aW1lIGluCj4gc2Vjb25kcy4KPgo+IFNpbWlsYXJseSwgSSdkIHN1Z2dlc3QgdGhh
dCB0aGUgbWluL21heCBkaXNwbGF5IHJlZnJlc2ggcmF0ZSB2YWx1ZXMgYmUKPiBhZHZlcnRpc2Vk
IGFzIHRpbWUgYmV0d2VlbiBmcmFtZXMgcmF0aGVyIHRoYW4gZnJhbWVzIHBlciBzZWNvbmQuCj4K
PiBJJ2QgYWxzbyBlbmNvdXJhZ2UgdXNpbmcgYSBzaW5nbGUgdW5pdCBmb3IgYWxsIG9mIHRoZXNl
IHZhbHVlcywKPiBwcmVmZXJhYmx5IG5hbm9zZWNvbmRzLiBBYnNvbHV0ZSB0aW1lcyBzaG91bGQg
YWxsIGJlIHJlZmVyZW5jZWQgdG8KPiBDTE9DS19NT05PVE9OSUMuCgorMSBvbiBldmVyeXRoaW5n
IEtlaXRoIHNhaWQuIEkgZ290IHNvbWVob3cgZHJhZ2dlZCBpbiBraHIgdmsKZGlzY3Vzc2lvbnMg
YXJvdW5kIHByZXZlbnRpbmcgbWljcm8tc3R1dHRlcmluZywgYW5kIGNvbnNlbnN1cyBzZWVtcyB0
bwpiZSB0aGF0IHRpbWVzdGFtcHMgZm9yIHNjaGVkdWxpbmcgZnJhbWVzIGlzIHRoZSB3YXkgdG8g
Z28sIG1vc3QgbGlrZWx5CmFic29sdXRlIG9uZXMgKG5vdCBldmVyeXRoaW5nIGlzIHJ1bm5pbmcg
TGludXggdW5mb3J0dW5hdGVseSwgc28gY2FuJ3QKZ28gb3V0cmlnaHQgYW5kIGNsYWltIGl0J3Mg
Z3VhcmFudGVlZCB0byBiZSBDTE9DS19NT05PVE9OSUMpLgotRGFuaWVsCi0tIApEYW5pZWwgVmV0
dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgorNDEgKDApIDc5IDM2NSA1
NyA0OCAtIGh0dHA6Ly9ibG9nLmZmd2xsLmNoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2RyaS1kZXZlbAo=
