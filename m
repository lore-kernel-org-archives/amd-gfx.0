From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [PATCH 1/6] dma-buf: add dynamic DMA-buf handling v10
Date: Mon, 24 Jun 2019 16:41:05 +0200
Message-ID: <20190624144105.GR12905@phenom.ffwll.local>
References: <20190618115455.1253-1-christian.koenig@amd.com>
 <20190621092022.GB12905@phenom.ffwll.local>
 <46bc08a3-1b84-c819-dbb5-882e95ab23e5@gmail.com>
 <CAKMK7uE6NUujY0ubOYkux-StOxMT-hYhBdAnQJkDsgEkuDjH9g@mail.gmail.com>
 <78db8951-2e62-2a9d-3d87-3b458fbba880@gmail.com>
 <20190621162753.GI12905@phenom.ffwll.local>
 <4d868c4c-cc00-bfa9-b6f5-969b76497cab@amd.com>
 <1d4f3779-8dc8-14ad-4d20-f7ccee7cea53@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1d4f3779-8dc8-14ad-4d20-f7ccee7cea53@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: christian.koenig@amd.com
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBKdW4gMjQsIDIwMTkgYXQgMDM6NTg6MDBQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAyNC4wNi4xOSB1bSAxMzoyMyBzY2hyaWViIEtvZW5pZywgQ2hyaXN0aWFu
Ogo+ID4gQW0gMjEuMDYuMTkgdW0gMTg6Mjcgc2NocmllYiBEYW5pZWwgVmV0dGVyOgo+ID4gCj4g
PiA+IFNvIEkgcG9uZGVyZWQgYSBmZXcgaWRlYXMgd2hpbGUgd29ya2luZyBvdXQ6Cj4gPiA+IAo+
ID4gPiAxKSBXZSBkcm9wIHRoaXMgZmlsdGVyaW5nLiBJbXBvcnRlciBuZWVkcyB0byBrZWVwIHRy
YWNrIG9mIGFsbCBpdHMKPiA+ID4gbWFwcGluZ3MgYW5kIGZpbHRlciBvdXQgaW52YWxpZGF0ZXMg
dGhhdCBhcmVuJ3QgZm9yIHRoYXQgc3BlY2lmaWMgaW1wb3J0ZXIKPiA+ID4gKGVpdGhlciBiZWNh
dXNlIGFscmVhZHkgaW52YWxpZGF0ZWQsIG9yIG5vdCB5ZXQgbWFwcGVkLCBvciB3aGF0ZXZlciku
Cj4gPiA+IEZlZWxzIGZyYWdpbGUuCj4gPiA+IAo+ID4gPiBbU05JUF0KPiA+IFtTTklQXQo+ID4g
Cj4gPiBJIHdpbGwgdGFrZSBhIG1vbWVudCBhbmQgbG9vayBpbnRvICMxIGFzIHdlbGwsIGJ1dCBJ
IHN0aWxsIGRvbid0IHNlZSB0aGUKPiA+IG5lZWQgdG8gY2hhbmdlIGFueXRoaW5nLgo+IAo+IFRo
YXQgdHVybmVkIG91dCBtdWNoIGNsZWFuZXIgdGhhbiBJIHRob3VnaHQgaXQgd291bGQgYmUuIEVz
c2VudGlhbGx5IGl0IGlzCj4gb25seSBhIHNpbmdsZSBleHRyYSBsaW5lIG9mIGNvZGUgaW4gYW1k
Z3B1Lgo+IAo+IEdvaW5nIHRvIHNlbmQgdGhhdCBvdXQgYXMgYSBwYXRjaCBzZXQgaW4gYSBtaW51
dGUuCgpZZWFoIEkgbWVhbiBraW5kYSBleHBlY3RlZCB0aGF0IGJlY2F1c2U6Ci0gZXZlcnl0aGlu
ZydzIHByb3RlY3RlZCB3aXRoIHd3X211dGV4IGFueXdheQotIGltcG9ydGVyIG5lZWRzIHRvIGtl
ZXAgdHJhY2sgb2YgbWFwcGluZ3MgYW53YXlzClNvIHJlYWxseSBhbGwgaXQgbmVlZHMgdG8gZG8g
aXMgbm90IGJlIHN0dXBpZCBhbmQgYWRkIHRoZSBtYXBwaW5nIGl0IGp1c3QKY3JlYXRlZCB0byBp
dHMgdHJhY2tpbmcgd2hpbGUgc3RpbGwgaG9sZGluZyB0aGUgd3dfbXV0ZXguIFNpbWlsYXIgb24K
aW52YWxpZGF0ZS91bm1hcC4KCldpdGggdGhhdCBhbGwgd2UgbmVlZCBpcyBhIGh1Z2Ugbm90ZSBp
biB0aGUgZG9jcyB0aGF0IGltcG9ydGVycyBuZWVkIHRvCmtlZXAgdHJhY2sgb2YgdGhlaXIgbWFw
cGluZ3MgYW5kIGR0cnQgKHdpdGggYWxsIHRoZSBleGFtcGxlcyBoZXJlIHNwZWxsZWQKb3V0IGlu
IHRoZSBhcHByb3ByaWF0ZSBrZXJuZWxkb2MpLiBBbmQgdGhlbiBJJ20gaGFwcHkgOi0pCgpDaGVl
cnMsIERhbmllbAotLSAKRGFuaWVsIFZldHRlcgpTb2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29y
cG9yYXRpb24KaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vZHJpLWRldmVs
