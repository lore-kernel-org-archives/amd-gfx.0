From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Limit DCN to x86 arch
Date: Sat, 20 May 2017 06:18:21 +1000
Message-ID: <CAPM=9tzcA8t-ji6qNQhycB0cezz2vH6HMixCgvKQ78cY1Y8fsA@mail.gmail.com>
References: <20170519140121.14296-1-harry.wentland@amd.com>
 <f84c51b6-06f1-b4d2-c472-89265ebb26cb@vodafone.de>
 <7a8b84af-38f7-33d2-5bbb-473f2ea35bb2@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7a8b84af-38f7-33d2-5bbb-473f2ea35bb2-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gMjAgTWF5IDIwMTcgYXQgMDU6MzYsIEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBh
bWQuY29tPiB3cm90ZToKPiBPbiAyMDE3LTA1LTE5IDExOjAyIEFNLCBDaHJpc3RpYW4gS8O2bmln
IHdyb3RlOgo+Pgo+PiBBbSAxOS4wNS4yMDE3IHVtIDE2OjAxIHNjaHJpZWIgSGFycnkgV2VudGxh
bmQ6Cj4+Pgo+Pj4gRENOIGJ3IGNhbGNzIGN1cnJlbnRseSByZWx5IG9uIHRoZSBmb2xsb3dpbmcg
Z2NjIG9wdGlvbnM6Cj4+PiAgICAtbWhhcmQtZmxvYXQgLW1zc2UgLW1wcmVmZXJyZWQtc3RhY2st
Ym91bmRhcnk9NAo+Pgo+Pgo+PiBNaG0sIHByaWNlIHF1ZXN0aW9uOiBXaHkgZG9lcyBEQ04gcmVs
eSBvbiB0aGUgZ2NjIG9wdGlvbnM/Cj4+Cj4KPiBUb255IGFuZCBEbXl0cm8gY2FuIHByb2JhYmx5
IHByb3ZpZGUgbW9yZSBpbmZvIGhlcmUgYnV0IG15IHVuZGVyc3RhbmRpbmcgaXMKPiB0aGF0IERD
TiBiYW5kd2lkdGggY2FsY3MgcmVxdWlyZXMgZmxvYXRpbmcgcG9pbnQgc3VwcG9ydC4gVGhpcyBj
b2RlIGNvbWVzCj4gcHJldHR5IG11Y2ggc3RyYWlnaHQgZnJvbSBoYXJkd2FyZSB0ZWFtcyB3aXRo
IGEgZ3VhcmFudGVlIHRoYXQgdGhlIG91dHB1dCBpcwo+IGdvb2QuCj4KPiBJZiB3ZSB3ZXJlIHRv
IHJld3JpdGUgYmFuZHdpZHRoIGNhbGN1bGF0aW9ucyB0aGF0IGd1YXJhbnRlZSB3b3VsZCBiYXNp
Y2FsbHkKPiBmbHkgb3V0IHRoZSB3aW5kb3csIHdoaWNoIG1lYW5zIHdoZW4gdGhlcmUncyBhIGJh
bmR3aWR0aCBidWcgd2UgY2Fubm90Cj4gZWFzaWx5IGdldCBIVyBzdXBwb3J0IHVubGVzcyB3ZSBj
YW4gcHJvdmUgdGhhdCBvdXIgY2FsY3VsYXRpb25zIHlpZWxkIHRoZQo+IGV4YWN0IHNhbWUgcmVz
dWx0cyBpbiBhbGwgY2FzZXMgYXMgSFdzIGZvcm11bGEuIENvdmVyaW5nIGFsbCBzY2VuYXJpb3Mg
dGhhdAo+IGJhbmR3aWR0aCBjYWxjcyBjb3ZlcnMgd291bGQgYmUgcXVpdGUgYW4gZXh0ZW5zaXZl
IHVuZGVydGFraW5nIGFuZCBJJ20gc3VyZQo+IHdlJ2QgbWlzcyBpbXBvcnRhbnQgY2FzZXMuCgpJ
cyB0aGlzIG9ubHkgZ29pbmcgdG8gaGFwcGVuIGZvciBYODYgQVBVcz8gVXNpbmcgZmxvYXRpbmcg
cG9pbnQgaW4gdGhlCmtlcm5lbCByZXF1aXJlcwphIGxvdCBvZiBjYXJlIHRvIGJlIHRha2VuLCBh
cmUgd2UgZG9pbmcgaXQgcHJvcGVybHk/CgpSZWFsbHkgcmV3cml0aW5nIHRoZSBjYWxjcyBpbiBm
aXhlZCBwb2ludCBpcyB0aGUgYmVzdCBvcHRpb24sIG1heWJlIHB1c2ggYmFjayBvbgp0aGUgaGFy
ZHdhcmUgdGVhbSB0byBoYXZlIGEgZml4ZWQgcG9pbnQgdmVyc2lvbiBjcmVhdGVkLgoKRGF2ZS4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
