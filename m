From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/4] locking/ww_mutex: add ww_mutex_is_owned_by function v3
Date: Tue, 20 Feb 2018 16:21:58 +0100
Message-ID: <20180220152158.GH25201@hirez.programming.kicks-ass.net>
References: <20180220125829.27060-1-christian.koenig@amd.com>
 <20180220131253.GF25314@hirez.programming.kicks-ass.net>
 <8fd80334-4d0e-8ed0-8a09-02a7e36a0eae@gmail.com>
 <20180220135709.GD25201@hirez.programming.kicks-ass.net>
 <b625cbca-c05a-afd1-fe97-a7a0760383c1@amd.com>
 <20180220145413.GF25201@hirez.programming.kicks-ass.net>
 <2dac8ec9-c54a-7dd1-af4e-62f2bc1a959c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <2dac8ec9-c54a-7dd1-af4e-62f2bc1a959c@gmail.com>
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
Cc: dev@mblankhorst.nl, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBGZWIgMjAsIDIwMTggYXQgMDQ6MDU6NDlQTSArMDEwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAyMC4wMi4yMDE4IHVtIDE1OjU0IHNjaHJpZWIgUGV0ZXIgWmlqbHN0cmE6
Cj4gPiBPbiBUdWUsIEZlYiAyMCwgMjAxOCBhdCAwMzozNDowN1BNICswMTAwLCBDaHJpc3RpYW4g
S8O2bmlnIHdyb3RlOgo+ID4gPiA+IE9LLCBidXQgbmVpdGhlciBjYXNlIHdvdWxkIGluIGZhY3Qg
bmVlZCB0aGUgIWN0eCBjYXNlIHJpZ2h0PyBUaGF0J3MganVzdAo+ID4gPiA+IHRoZXJlIGZvciBj
b21wbGV0ZW5lc3Mgc2FrZT8KPiA+ID4gVW5mb3J0dW5hdGVseSBub3QuIFRUTSB1c2VzIHRyeWxv
Y2sgdG8gbG9jayBCT3Mgd2hpY2ggYXJlIGFib3V0IHRvIGJlCj4gPiA+IGV2aWN0ZWQgdG8gbWFr
ZSByb29tIGZvciBhbGwgdGhlIEJPcyBsb2NrZWQgd2l0aCBhIGN0eC4KPiA+ID4gCj4gPiA+IEkg
bmVlZCB0byBiZSBhYmxlIHRvIGRpc3RpbmN0IGJldHdlZW4gdGhlIEJPcyB3aGljaCBhcmUgdHJ5
bG9ja2VkIGFuZCB0aG9zZQo+ID4gPiB3aGljaCBhcmUgbG9ja2VkIHdpdGggYSBjdHguCj4gPiA+
IAo+ID4gPiBXcml0aW5nIHRoaXMgSSBhY3R1YWxseSBub3RpY2VkIHRoZSBjdXJyZW50IHZlcnNp
b24gaXMgYnVnZ3ksIGNhdXNlIGV2ZW4KPiA+ID4gd2hlbiB3ZSBjaGVjayB0aGUgbXV0ZXggb3du
ZXIgd2Ugc3RpbGwgbmVlZCB0byBtYWtlIHN1cmUgdGhhdCB0aGUgY3R4IGluIHRoZQo+ID4gPiBs
b2NrIGlzIE5VTEwuCj4gPiBIdXJtLi4uIEkgY2FuJ3QgcmVtZW1iZXIgd2h5IHRyeWxvY2tzIGJl
aGF2ZSBsaWtlIHRoYXQsIGFuZCBpdCBzZWVtcwo+ID4gcmF0aGVyIHVuZm9ydHVuYXRlIC8gaW5j
b25zaXN0ZW50Lgo+IAo+IEFjdHVhbGx5IGZvciBtZSB0aGF0IGlzIHJhdGhlciBmb3J0dW5hdGUs
IGNhdXNlIEkgbmVlZCB0byBkaXN0aW5jdCBiZXR3ZWVuCj4gdGhlIGxvY2tzIGFjcXVpcmVkIHRo
cm91Z2ggdHJ5bG9jayBhbmQgbG9jay4KCkkgc3VwcG9zZSB0aGF0IHdvdWxkIGFsd2F5cyBiZSBw
b3NzaWJsZSB1c2luZzoKd3dfbXV0ZXhfdHJ5bG9jayguY3R4PU5VTEwpLCBhbmQgaXQgY291bGQg
YmUgdGhhdCB0aGVyZSBzaW1wbHkgd2VyZW4ndAphbnkgaW1tZWRpYXRlIHVzZXMgZm9yIGEgIU5V
TEwgdHJ5bG9jayBhbmQgaXQgd2FzIHRodXMgbm90IGltcGxlbWVudGVkLgoKQnV0IHRoYXQgaXMg
YWxsIHZlcnkgbG9uZyBhZ28uLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
ZHJpLWRldmVsCg==
