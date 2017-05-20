From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/3] drm/amdgpu: Tweaks for high pressure on CPU visible
 VRAM
Date: Sat, 20 May 2017 18:35:53 +0900
Message-ID: <9a5ba6ea-6e69-c90d-d610-c91f4b6010e8@daenzer.net>
References: <20170518090809.15916-1-michel@daenzer.net>
 <CAAxE2A65deE+hue7oPMQ+=K5s8TEGZE+bJMNVOdp=LQuq_RnMQ@mail.gmail.com>
 <a574c18a-0c21-bf85-963f-5df06a0b192e@daenzer.net>
 <CAAxE2A6ZiNSswhArstqHpYnm30ieoDZj=j_-aFvZz1_ByXLOGA@mail.gmail.com>
 <CAAxE2A4zdgFRh-GDqyDRrXmEWqjSrkfCo=Z41hfo-UNY0E5FhA@mail.gmail.com>
 <CAAxE2A67T3Mhw68thNewFtcdua3ufSP-FDX_RN153x-aLKUh1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A67T3Mhw68thNewFtcdua3ufSP-FDX_RN153x-aLKUh1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAvMDUvMTcgMDY6MjYgUE0sIE1hcmVrIE9sxaHDoWsgd3JvdGU6Cj4gT24gTWF5IDIwLCAy
MDE3IDM6MjYgQU0sICJNaWNoZWwgRMOkbnplciIgPG1pY2hlbEBkYWVuemVyLm5ldAo+IDxtYWls
dG86bWljaGVsQGRhZW56ZXIubmV0Pj4gd3JvdGU6Cj4gCj4gICAgIE9uIDIwLzA1LzE3IDAxOjE0
IEFNLCBNYXJlayBPbMWhw6FrIHdyb3RlOgo+ICAgICA+IEhpIE1pY2hlbCwKPiAgICAgPgo+ICAg
ICA+IEkndmUgYXBwbGllZCB5b3VyIHNlcmllcwo+IAo+ICAgICBUaGFua3MgZm9yIHRlc3Rpbmcg
aXQuCj4gCj4gICAgID4gYW5kIGl0IGRvZXNuJ3QgaGVscCB3aXRoIGxvdyBEaXJ0IFJhbGx5IHBl
cmZvcm1hbmNlIG9uIEZpamkuIEkgc2VlIFRUTQo+ICAgICA+IGJ1ZmZlciBtb3ZlcyBhdCA4MDBN
Qi9zIGFuZCBtYW55IFZSQU0gcGFnZSBmYXVsdHMuCj4gCj4gICAgIERpZCB5b3Ugc2VlIHRoaXM6
Cj4gCj4gICAgID4+IE5vdGUgdGhhdCB0aGVyZSdzIG9ubHkgbGl0dGxlIGlmIGFueSBpbXByb3Zl
bWVudCBvZiB0aGUgYXZlcmFnZQo+ICAgICBmcmFtZXJhdGUKPiAgICAgPj4gcmVwb3J0ZWQsIGJ1
dCB0aGUgbWluaW11bSBmcmFtZXJhdGUgYXMgc2VlbiBvbiB0aGUgSFVEIGdvZXMgZnJvbQo+ICAg
ICB+MTAgZnBzCj4gICAgID4+IHRvIH4xNy4KPiAKPiAgICAgSS5lLiBpdCBtb3N0bHkgYWZmZWN0
cyB0aGUgbWluaW11bSBmcmFtZXJhdGUgYW5kIHNtb290aG5lc3MgZm9yIG1lCj4gICAgIGFzIHdl
bGwuCj4gCj4gCj4gV2l0aG91dCB0aGUgc2VyaWVzLCBJIGdldCA3MCBhdmVyYWdlIGZwcy4gV2l0
aCB0aGUgc2VyaWVzLCBJIGdldCAzMAo+IGF2ZXJhZ2UgZnBzLiBUaGF0IG1pZ2h0IGp1c3QgYmUg
cmFuZG9tIGJhZCBsdWNrLiBJIGRvbid0IGtub3cuIEluIGFueQo+IGNhc2UsIDMwIGZwcyBpcyBy
ZWFsbHkgYmFkLCBzbyBJIGRvbid0IHRoaW5rIHRoZSBzZXJpZXMgZG9lcyB3aGF0IHlvdQo+IHRo
aW5rIGl0IGRvZXMuCgpBaCwgeWVhaCwgc3VyZS4gIkRvZXNuJ3QgaGVscCIgc291bmRlZCBsaWtl
IGl0IGp1c3QgZGlkbid0IGltcHJvdmUKdGhpbmdzLiA6KQoKSG93IGFib3V0IHdpdGggb25seSBw
YXRjaGVzIDEgJiAyPwoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1
c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
