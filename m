From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Bring bo creation in line with radeon driver
Date: Mon, 23 Jan 2017 16:38:22 -0500
Message-ID: <CADnq5_OsNkhBmGp5UfBM2tZWj3eeWQYBcy9cvbahZn77i3-xrA@mail.gmail.com>
References: <20170122191527.GA3125@tisys.org>
 <854d801c-cf4d-9ea7-a23c-f2d3399dd270@daenzer.net>
 <3632c484-020b-d494-4373-04032d305385@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3632c484-020b-d494-4373-04032d305385-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Nils Holland <nholland-iI9p2NPcQ/rYtjvyW6yDsg@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCBKYW4gMjMsIDIwMTcgYXQgNToyOSBBTSwgQ2hyaXN0aWFuIEvDtm5pZwo8ZGVhdGhz
aW1wbGVAdm9kYWZvbmUuZGU+IHdyb3RlOgo+IEFtIDIzLjAxLjIwMTcgdW0gMDM6NDYgc2Nocmll
YiBNaWNoZWwgRMOkbnplcjoKPj4KPj4gT24gMjMvMDEvMTcgMDQ6MTUgQU0sIE5pbHMgSG9sbGFu
ZCB3cm90ZToKPj4+Cj4+PiAgRnJvbSBkNDRhYzExNTdmZGI4NmU2NzgyMmI2NTM4YWU2MTEzYzhk
NjIwNDEyIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQo+Pj4gRnJvbTogTmlscyBIb2xsYW5kIDxu
aG9sbGFuZEB0aXN5cy5vcmc+Cj4+PiBEYXRlOiBTdW4sIDIyIEphbiAyMDE3IDEzOjI0OjUyICsw
MTAwCj4+PiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IEJyaW5nIGJvIGNyZWF0aW9uIGlu
IGxpbmUgd2l0aCByYWRlb24gZHJpdmVyCj4+Pgo+Pj4gQWRkIHRoZSBibyBjcmVhdGlvbiBjaGFu
Z2VzIHRoYXQgaGF2ZSBiZWVuIGRvbmUgdG8gdGhlIHJhZGVvbiBkcml2ZXIgaW4KPj4+IHJlY2Vu
dCB0aW1lcywgZS5nLiBkaXNhYmxlIEdUVCBXQyBvbiAzMiBiaXQgYmVjYXVzZSBpdCBpcyBicm9r
ZW4gdGhlcmUsCj4+PiBhbmQgYWxzbyBkaXNhYmxlIGl0IGdlbmVyYWxseSAoYW5kIHByaW50IGEg
d2FybmluZyBtZXNzYWdlKSB3aGVuCj4+PiBDT05GSUdfWDg2X1BBVCBpcyBub3Qgc2V0Lgo+Pj4K
Pj4+IFNpZ25lZC1vZmYtYnk6IE5pbHMgSG9sbGFuZCA8bmhvbGxhbmRAdGlzeXMub3JnPgo+Pgo+
PiBMb29rcyBncmVhdCwgdGhhbmtzIE5pbHMhCj4+Cj4+IFJldmlld2VkLWJ5OiBNaWNoZWwgRMOk
bnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KPgo+Cj4gUmV2aWV3ZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gYXMgd2VsbC4KPgoKQXBwbGllZC4g
IHRoYW5rcyEKCkFsZXgKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
