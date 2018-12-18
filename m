From: Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Fix crash when page flipping in multi-X-Screen/Zaphod mode
Date: Tue, 18 Dec 2018 20:09:33 +0100
Message-ID: <CAEsyxyjwAcdzXs2bSKdvpjHvffHRF1iO0y0jypb+fx9tyh9E=w@mail.gmail.com>
References: <20181218104035.3708-1-mario.kleiner.de@gmail.com>
 <1458bf4e-e9be-01e1-940a-f45352ce74df@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1458bf4e-e9be-01e1-940a-f45352ce74df-otUistvHUpPR7s880joybQ@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVHVlLCBEZWMgMTgsIDIwMTggYXQgMzo0MiBQTSBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRh
ZW56ZXIubmV0PiB3cm90ZToKPgo+Cj4gR29vZCBjYXRjaCwgdGhhbmtzISBQdXNoZWQgd2l0aAo+
Cj4gRml4ZXM6IDc0MGYwODUwZjFlNCAiU3RvcmUgRkIgZm9yIGVhY2ggQ1JUQyBpbiBkcm1tb2Rl
X2ZsaXBkYXRhX3JlYyIKPiBSZXZpZXdlZC1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVu
emVyQGFtZC5jb20+Cj4KPgo+IERvIHlvdSB3YW50IHRvIG1ha2UgYW4geGY4Ni12aWRlby1hbWRn
cHUgbWVyZ2UgcmVxdWVzdCBhcyB3ZWxsPyBJZiBub3QsCj4gSSBjYW4gdGFrZSBjYXJlIG9mIHBv
cnRpbmcgdGhlIGZpeC4gSWYgeW91IGRvIGl0LCBwbGVhc2UgZW5hYmxlIHRoZQo+ICJBbGxvdyBj
b21taXRzIGZyb20gbWVtYmVycyB3aG8gY2FuIG1lcmdlIHRvIHRoZSB0YXJnZXQgYnJhbmNoIiBj
aGVja2JveAo+IGZvciB0aGUgTVIuCj4KCkhpIE1pY2hlbCwKCnRoYW5rcyBmb3IgdGhlIGZhc3Qg
cmV2aWV3ISBJZiB5b3UgY291bGQgcG9ydCBpdCB0byBhbWRncHUsIHRoYXQgd291bGQgYmUgZ29v
ZC4KSSBmaXJzdCBoYXZlIHRvIGxlYXJuIHRoZSBuZXcgZ2l0bGFiIHdvcmtmbG93IGFuZCBmaW5k
IG91dCBob3cgdGhvc2UKbWVyZ2UgcmVxdWVzdHMgd29yay4KClRoYW5rcywKLW1hcmlvCgo+Cj4g
LS0KPiBFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgaHR0cDovL3d3dy5hbWQuY29tCj4gTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAg
ICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
