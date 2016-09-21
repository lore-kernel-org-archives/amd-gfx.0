From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/i915: Before pageflip, also wait for shared dmabuf
 fences.
Date: Wed, 21 Sep 2016 17:21:09 +0200
Message-ID: <b433cd8c-40fc-eaed-3df8-27eb5bd60649@vodafone.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f0e034f9-db22-6577-97c7-dd8d3e851226-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>, Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjEuMDkuMjAxNiB1bSAxNzoxMyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIxLzA5
LzE2IDA3OjMwIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAyMS4wOS4yMDE2IHVt
IDExOjU2IHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+PiBGV0lXLCB3ZSBzZWVtIHRvIGhhdmUg
dGhlIHNhbWUgaXNzdWUgd2l0aCByYWRlb24gdnMuIGFtZGdwdTogcmFkZW9uIG9ubHkKPj4+IHNl
ZW1zIHRvIHdhaXQgZm9yIGV4Y2x1c2l2ZSBmZW5jZXMsIHNvIGUuZy4gcnVubmluZyBYb3JnIG9u
IGFtZGdwdSBhbmQKPj4+IHVzaW5nIFBSSU1FIHNsYXZlIHNjYW5vdXQgb24gcmFkZW9uIGxlYXZl
cyBhcnRpZmFjdHMuCj4+IFllYWgsIEkga25vdy4gU2VlIHJhZGVvbl9kaXNwbGF5LmMgcmFkZW9u
X2ZsaXBfd29ya19mdW5jKCkuCj4+Cj4+IFdlIHByZXR0eSBtdWNoIG5lZWQgdGhlIHNhbWUgcGF0
Y2ggaGVyZSBJJ3ZlIGRvbmUgZm9yIGFtZGdwdSBhcyB3ZWxsLgo+IEFjdHVhbGx5LCB0aGUgUFJJ
TUUgc2xhdmUgY2FuJ3Qgc2NhbiBvdXQgZnJvbSB0aGUgc2hhcmVkIEJPcyBkaXJlY3RseQo+IChy
ZWNhbGwgdGhlIHJlY2VudCBkaXNjdXNzaW9uIHdlIGhhZCBhYm91dCB0aGF0IHdpdGggTWFyaW8p
LCBidXQgaGFzIHRvCj4gY29weSBmcm9tIHRoZSBzaGFyZWQgQk8gdG8gYSBkZWRpY2F0ZWQgc2Nh
bm91dCBCTy4gVGhlc2UgY29waWVzIG5lZWQgdG8KPiBiZSBzeW5jaHJvbml6ZWQgd2l0aCB0aGUg
cHJpbWFyeSBHUFUncyBjb3BpZXMgdG8gdGhlIHNoYXJlZCBCTy4KClllYWgsIHRoYXQgdGhvdWdo
dCBjYW1lIHRvIG15IG1pbmQgYmVmb3JlIGFzIHdlbGwuCgpCdWZmZXIgbWlncmF0aW9ucyBieSB0
aGUga2VybmVsIGNhdXNlZCBieSBhIHByaW1lIGV4cG9ydCBhY3R1YWxseSBzZXQgCnRoZSBleGNs
dXNpdmUgZmVuY2UuCgpTbyB0aGlzIHNob3VsZG4ndCBiZSBhbiBpc3N1ZSBpbiBwcmFjdGljZSB3
aGVuIHRoZSBkaXNwbGF5aW5nIEdQVSBuZWVkcyAKdG8gY29weSBmcm9tIHRoZSBCTyBhZ2FpbiBh
bnl3YXkuCgpUaGUgb25seSBjYXNlIEkgY2FuIHNlZSB3aGVuIHRoaXMgY2FuIGhhcHBlbiBpcyB3
aGVuIHRoZSBCTyBpcyBjb21wb3NlZCAKZGlyZWN0bHkgaW4gc3lzdGVtIG1lbW9yeSBieSB0aGUg
ZW5naW5lcyBhbmQgbm90IG1pZ3JhdGVkIHRoZXJlLgoKQ291bGQgYmUgdGhhdCB3ZSBydW4gaW50
byB0aGlzIGlzc3VlIG1vcmUgb2Z0ZW4gaW4gdGhlIGZ1dHVyZSwgYmVjYXVzZSAKdGhhdCBpcyBw
cmV0dHkgbXVjaCB3aGF0IHdlIHdhbnQgdG8gaGF2ZSBmb3IgNEsgVVZEIGRlY29kZS4KCkNocmlz
dGlhbi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
