From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/ttm: once more fix ttm_bo_bulk_move_lru_tail
Date: Fri, 14 Sep 2018 12:46:38 +0200
Message-ID: <b432d6f9-2469-9a1f-6a87-634126f1e1da@amd.com>
References: <20180912192355.2359-1-christian.koenig@amd.com>
 <20180913083135.GA21669@hr-amur2>
 <c2471ef9-1bc7-517e-27f6-a00236a9b40b@gmail.com>
 <20180914082247.GA31097@hr-amur2>
 <4bf23786-ffdb-ee6e-1446-9dbc8d8ed5d6@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4bf23786-ffdb-ee6e-1446-9dbc8d8ed5d6-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTQuMDkuMjAxOCB1bSAxMToyMiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDktMTQgMTA6MjIgYS5tLiwgSHVhbmcgUnVpIHdyb3RlOgo+PiBPbiBUaHUsIFNlcCAxMywgMjAx
OCBhdCAwNzozMjoyNFBNICswODAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMTMu
MDkuMjAxOCB1bSAxMDozMSBzY2hyaWViIEh1YW5nIFJ1aToKPj4+PiBPbiBXZWQsIFNlcCAxMiwg
MjAxOCBhdCAwOToyMzo1NVBNICswMjAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+PiBX
aGlsZSBjdXR0aW5nIHRoZSBsaXN0cyB3ZSBzb21ldGltZXMgYWNjaWRlbnRhbGx5IGFkZGVkIGEg
bGlzdF9oZWFkIGZyb20KPj4+Pj4gdGhlIHN0YWNrIHRvIHRoZSBMUlVzLCBlZmZlY3RpdmVseSBj
b3JydXB0aW5nIHRoZSBsaXN0Lgo+Pj4+Pgo+Pj4+PiBSZW1vdmUgdGhlIGxpc3QgY3V0dGluZyBh
bmQgdXNlIGV4cGxpY2l0IGxpc3QgbWFuaXB1bGF0aW9uIGluc3RlYWQuCj4+Pj4gVGhpcyBwYXRj
aCBhY3R1YWxseSBmaXhlcyB0aGUgY29ycnVwdGlvbiBidWcuIFdhcyBpdCBhIGRlZmVjdCBvZgo+
Pj4+IGxpc3RfY3V0X3Bvc2l0aW9uIG9yIGxpc3Rfc3BsaWNlIGhhbmRsZXJzPwo+Pj4gV2Ugc29t
ZWhvdyBkaWQgc29tZXRoaW5nIGlsbGVnYWwgd2l0aCBsaXN0X2N1dF9wb3NpdGlvbi4gSSBoYXZl
bid0Cj4+PiBuYXJyb3dlZCBpdCBkb3duIHRpbGwgdGhlIGVuZCwgYnV0IHdlIGVuZGVkIHVwIHdp
dGggbGlzdF9oZWFkcyBmcm9tIHRoZQo+Pj4gc3RhY2sgdG8gdGhlIGxydS4KPj4gSSBhbSBjb25m
dXNlZCwgaW4gdGhlb3J5LCBldmVuIHdlIGRvIGFueSBtYW5pcHVsYXRpb24gd2l0aCBsaXN0IGhl
bHBlciwgaXQKPj4gc2hvdWxkIG5vdCB0cmlnZ2VyIHRoZSBsaXN0IGNvcnJ1cHRpb24uIFRoZSB1
c2FnZSBvZiB0aG9zZSBoZWxwZXJzIHNob3VsZAo+PiBlbnN1cmUgdGhlIGxpc3Qgb3BlcmF0aW9u
IHNhZmVseS4uLgo+IFRoZXJlJ3Mgbm90aGluZyB0aGUgaGVscGVycyBjYW4gZG8gYWJvdXQgYmVp
bmcgcGFzc2VkIGluIHBvaW50ZXJzIHRvCj4gc3RhY2sgbWVtb3J5LiBJdCdzIGEgYnVnIGluIHRo
ZSBjb2RlIHVzaW5nIHRoZSBoZWxwZXJzLgoKQWN0dWFsbHkgSSdtIG5vdCAxMDAlIHN1cmUgb2Yg
dGhhdC4gVG8gbWUgaXQgbG9va3MgbGlrZSB3ZSBoaXQgYSBjb3JuZXIgCmNhc2UgbGlzdF9jdXRf
cG9zaXRpb24gZG9lc24ndCBzdXBwb3J0LgoKT3Igd2UgaW5kZWVkIGhhZCBhIGxvZ2ljIGVycm9y
IGluIGhvdyB3ZSBjYWxsZWQgaXQsIGFueXdheSB0aGUgZXhwbGljaXQgCmltcGxlbWVudGF0aW9u
IG9ubHkgdXNlcyA2IGFzc2lnbm1lbnRzIGFuZCBzbyBpcyBtdWNoIGVhc2llciB0byBoYW5kbGUu
CgpDaHJpc3RpYW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
