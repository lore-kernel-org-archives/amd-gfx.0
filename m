From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/ttm: once more fix ttm_bo_bulk_move_lru_tail
Date: Fri, 14 Sep 2018 11:22:16 +0200
Message-ID: <4bf23786-ffdb-ee6e-1446-9dbc8d8ed5d6@daenzer.net>
References: <20180912192355.2359-1-christian.koenig@amd.com>
 <20180913083135.GA21669@hr-amur2>
 <c2471ef9-1bc7-517e-27f6-a00236a9b40b@gmail.com>
 <20180914082247.GA31097@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180914082247.GA31097@hr-amur2>
Content-Language: en-CA
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wOS0xNCAxMDoyMiBhLm0uLCBIdWFuZyBSdWkgd3JvdGU6Cj4gT24gVGh1LCBTZXAg
MTMsIDIwMTggYXQgMDc6MzI6MjRQTSArMDgwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4g
QW0gMTMuMDkuMjAxOCB1bSAxMDozMSBzY2hyaWViIEh1YW5nIFJ1aToKPj4+IE9uIFdlZCwgU2Vw
IDEyLCAyMDE4IGF0IDA5OjIzOjU1UE0gKzAyMDAsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+
Pj4gV2hpbGUgY3V0dGluZyB0aGUgbGlzdHMgd2Ugc29tZXRpbWVzIGFjY2lkZW50YWxseSBhZGRl
ZCBhIGxpc3RfaGVhZCBmcm9tCj4+Pj4gdGhlIHN0YWNrIHRvIHRoZSBMUlVzLCBlZmZlY3RpdmVs
eSBjb3JydXB0aW5nIHRoZSBsaXN0Lgo+Pj4+Cj4+Pj4gUmVtb3ZlIHRoZSBsaXN0IGN1dHRpbmcg
YW5kIHVzZSBleHBsaWNpdCBsaXN0IG1hbmlwdWxhdGlvbiBpbnN0ZWFkLgo+Pj4gVGhpcyBwYXRj
aCBhY3R1YWxseSBmaXhlcyB0aGUgY29ycnVwdGlvbiBidWcuIFdhcyBpdCBhIGRlZmVjdCBvZgo+
Pj4gbGlzdF9jdXRfcG9zaXRpb24gb3IgbGlzdF9zcGxpY2UgaGFuZGxlcnM/Cj4+Cj4+IFdlIHNv
bWVob3cgZGlkIHNvbWV0aGluZyBpbGxlZ2FsIHdpdGggbGlzdF9jdXRfcG9zaXRpb24uIEkgaGF2
ZW4ndCAKPj4gbmFycm93ZWQgaXQgZG93biB0aWxsIHRoZSBlbmQsIGJ1dCB3ZSBlbmRlZCB1cCB3
aXRoIGxpc3RfaGVhZHMgZnJvbSB0aGUgCj4+IHN0YWNrIHRvIHRoZSBscnUuCj4gCj4gSSBhbSBj
b25mdXNlZCwgaW4gdGhlb3J5LCBldmVuIHdlIGRvIGFueSBtYW5pcHVsYXRpb24gd2l0aCBsaXN0
IGhlbHBlciwgaXQKPiBzaG91bGQgbm90IHRyaWdnZXIgdGhlIGxpc3QgY29ycnVwdGlvbi4gVGhl
IHVzYWdlIG9mIHRob3NlIGhlbHBlcnMgc2hvdWxkCj4gZW5zdXJlIHRoZSBsaXN0IG9wZXJhdGlv
biBzYWZlbHkuLi4KClRoZXJlJ3Mgbm90aGluZyB0aGUgaGVscGVycyBjYW4gZG8gYWJvdXQgYmVp
bmcgcGFzc2VkIGluIHBvaW50ZXJzIHRvCnN0YWNrIG1lbW9yeS4gSXQncyBhIGJ1ZyBpbiB0aGUg
Y29kZSB1c2luZyB0aGUgaGVscGVycy4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0
d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZl
bG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
