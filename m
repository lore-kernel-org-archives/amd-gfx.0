From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: access stolen VRAM directly on KV/KB
Date: Tue, 8 Nov 2016 16:31:31 +0900
Message-ID: <8372afd6-8a51-1102-99a3-28a719088fa6@daenzer.net>
References: <1478510481-1768-1-git-send-email-deathsimple@vodafone.de>
 <9d218698-d588-090a-eb47-d0142cfdb623@daenzer.net>
 <7be5b56d-fae3-d71b-485f-01227172859d@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7be5b56d-fae3-d71b-485f-01227172859d-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMDcvMTEvMTYgMDY6MzMgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMDcuMTEu
MjAxNiB1bSAxMDoyOSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+PiBPbiAwNy8xMS8xNiAwNjoy
MSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEZyb206IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4+Cj4+PiBXZSBkb24ndCBuZWVkIHRvIHVzZSB0
aGUgUENJIEJBUiBvbiBBUFVzLiBUaGlzIGFsbG93cyB1cyB0byBhY2Nlc3MKPj4+IHRoZSBmdWxs
IFZSQU0gZGlyZWN0bHkgd2l0aG91dCBiZWluZyBsaW1pdGVkIGJ5IHRoZSBCQVIgc2l6ZS4KPj4+
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cj4+IFRoZSBzZXJpZXMgaXMKPj4KPj4gUmV2aWV3ZWQtYnk6IE1pY2hlbCBEw6RuemVy
IDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgo+Pgo+Pgo+PiBXZSBjb3VsZCBhbHNvIGRyb3AgdGhl
IEhEUCBmbHVzaGVzIC8gaW52YWxpZGF0ZXMgaW4gdGhpcyBjYXNlLCByaWdodD8KPiBDb3VsZCBi
ZSwgYnV0IEknbSBub3QgMTAwJSBzdXJlIGhvdyB0aG9zZSBhcmUgYWN0dWFsbHkgd2lyZWQgdXAg
b24gQVBVcy4KPiAKPiBNaWdodCBiZSB0aGF0IHRoZXkgYXJlIE5PUHMgYW55d2F5LCBidXQgY291
bGQgYmUgdGhhdCBhdCBsZWFzdCB0aGUKPiBmbHVzaGVzIGFyZSBzdGlsbCB2aXRhbC4KCk15IGFz
c3VtcHRpb24gaXMgdGhhdCBzaW5jZSBDUFUgYWNjZXNzIHRvIFZSQU0gZG9lc24ndCBnbyB0aHJv
dWdoIHRoZQpIRFAgYXQgYWxsIHdpdGggdGhpcyBjaGFuZ2UsIEhEUCBmbHVzaGVzIC8gaW52YWxp
ZGF0ZXMgY2FuJ3QgaGF2ZSBhbnkKdXNlZnVsIGVmZmVjdC4KCgotLSAKRWFydGhsaW5nIE1pY2hl
bCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNv
bQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVz
YSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
