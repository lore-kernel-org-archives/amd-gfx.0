From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: SDMA out-of-bounds write access of tiled surface
Date: Thu, 25 Aug 2016 15:01:25 +0200
Message-ID: <CAAxE2A7ojOJj_8VxPgQBExCGp0iNNoYdxskRwp_Y-XGnMo7isA@mail.gmail.com>
References: <f07d06143d31d6e66ce8e8cf7de9084a@ab3.no>
 <b30cc5f5235fa5745b357d9053b7c9b3@ab3.no>
 <57681305.5070400@gmail.com> <1ba8273c322d606ca6d1904ed462edf1@ab3.no>
 <576835ED.4030601@gmail.com> <bc7f9aa3ec84f59a3aae71135a97cc20@ab3.no>
 <98752b6ecaa89eda9be5efe55baa5cec@ab3.no> <5768EF1E.2040105@gmail.com>
 <63f7121f8782563f2967f6bc36849b08@ab3.no>
 <df89a8f18199b2ef8b89fc8e83e50fea@ab3.no>
 <924e8ef77d0c0c816c01e24439e490d8@ab3.no> <57697A1E.6020902@gmail.com>
 <576A4332.1090409@gmail.com>
 <CAAxE2A60Rf3m764QyWmzwFiiuQAiGMdbmqyNE+pKxwBJJok5YA@mail.gmail.com>
 <CADnq5_M=MZUHCeLB4=Xtykzn-Lzfqw8gbdvi=-tMbwkpoBZmHw@mail.gmail.com>
 <CAAxE2A5=7NYLJWJtcqiY0=eWffhRfHwSvjjXFuJOR4fW=A3hHA@mail.gmail.com>
 <CADnq5_NDv+tMvD1m16WGzLTuvNFoKfXVPiFdapQi7wQyisK5BQ@mail.gmail.com>
 <bfb8e5be88e5a576be454b9996a06212@ab3.no>
 <99b7e94b2b0988c84a1e9e524e89bb0c@ab3.no>
 <CAAxE2A6_1PHyzjwhmCb5V=9yjG+c2BwRWvbM2Q7VnOoU2w3wWA@mail.gmail.com>
 <19f5de02d79aef802e8d1be498f8924d@ab3.no> <5784166D.5020701@gmail.com>
 <48b66a16e2e0f9201447967f504f6d5e@ab3.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <48b66a16e2e0f9201447967f504f6d5e-UV2J4TS9czE@public.gmane.org>
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
To: Mads <mads-UV2J4TS9czE@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

RllJLCBJJ3ZlIGRpc2FibGVkIFNETUEgdGV4dHVyZSBjb3B5aW5nIGZvciBDYXJyaXpvIGluIE1l
c2EuIFRoZSBWTQpmYXVsdHMgc2hvdWxkIG5vIGxvbmdlciBvY2N1ci4KCk1hcmVrCgpPbiBGcmks
IEF1ZyA1LCAyMDE2IGF0IDM6MjIgUE0sIE1hZHMgPG1hZHNAYWIzLm5vPiB3cm90ZToKPiBKdXN0
IHRvIHVwZGF0ZSwgUjYwMF9ERUJVRz1ub2RtYSBpcyBzdGlsbCBuZWVkZWQgd2hlbiB1cGRhdGlu
ZyB0bwo+IHhvcmctc2VydmVyIDEuMTguNCwgcGxhc21hIDUuNy4zIGFuZCBsaW51eCA0LjcuMCwg
YW5kIGxpYmRybSwgbWVzYSBhbmQgbGx2bQo+IGJ1aWx0IGZyb20gbGl2ZSBzb3VyY2VzIGZyb20g
c29tZXRpbWUgdGhpcyB3ZWVrLgo+Cj4gU2hvdWxkIHRoaXMgaW5mbyBiZSBpbiBzb21lIGJ1Z3pp
bGxhIHNvbWV3aGVyZT8KPgo+IC0gTWFkcwo+Cj4KPiBPbiAyMDE2LTA3LTExIDIzOjU4LCBOaWNv
bGFpIEjDpGhubGUgd3JvdGU6Cj4KPj4gVGhlIGN1bHByaXQgU0RNQSBidWZmZXIgd2FzIGFjdHVh
bGx5IHN1Ym1pdHRlZCBieSB0aGUgWCBzZXJ2ZXIsIEkgYmVsaWV2ZS4KPj4KPj4gTmljb2xhaQo+
Pgo+Pj4gT24gMTEuMDcuMjAxNiAyMzo1MiwgTWFkcyB3cm90ZTogWWVzLCBhbHNvIHdpdGggNS43
IHRoZSBjb3JydXB0aW9uCj4+PiBhcHBlYXJzIGlmIEkgc3RhcnQgL3Vzci9iaW4va29uc29sZSBv
cgo+Pj4gL3Vzci9iaW4vZG9scGhpbiAoYW5kIEkgZ3Vlc3MgaXQgd2lsbCBiZSBhcHBhcmVudCB3
aXRoIG1vcmUKPj4+IGFwcGxpY2F0aW9ucywgaWYgeW91IHdhbnQgSSBjb3VsZCB0ZXN0IHNvbWUg
bW9yZSkuIEFsdGhvdWdoLCBJIGhhdmUgbm8KPj4+IHRyb3VibGUgdXNpbmcgY2hyb21pdW0gb3Ig
c3RlYW0sIHBsYXlpbmcgYWxsIHNvcnRzIG9mIGdhbWVzLiBBcyB5b3UgY2FuCj4+PiBzZWUgaWYg
eW91IGxvb2sgdGhyb3VnaCB0aGUgdGhyZWFkLCBpdCBtaWdodCBiZSByZWFzb24gdG8gYmVsaWV2
ZSB0aGF0Cj4+PiBwbGFzbWFzaGVsbCBpdHNlbGYgbWlnaHQgYmUgdGhlIGN1bHByaXQgc2VuZGlu
ZyB0aGUgZGF0YSB0aGF0IGNvcnJ1cHRzCj4+PiB0aGUgc2NyZWVuLgo+Pj4KPj4+IC0gTWFkcwo+
Pj4KPj4+PiBPbiAyMDE2LTA3LTExIDIzOjQyLCBNYXJlayBPbMWhw6FrIHdyb3RlOgo+Pj4+Cj4+
Pj4gQ2FuIHlvdSBzZWUgYW55IGNvcnJ1cHRpb24gb3IgaXMgdGhlcmUganVzdCB0aGUgbWVzc2Fn
ZSBpbiBkbWVzZz8gKEl0Cj4+Pj4gbWlnaHQganVzdCBiZSBhIHBhZ2UgZGlyZWN0b3J5IGZldGNo
IGFuZCBub3QgYSBtZW1vcnkgYWNjZXNzKQo+Pj4+Cj4+Pj4gTWFyZWsKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
