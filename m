From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/4] locking/ww_mutex: add ww_mutex_is_owned_by function v3
Date: Tue, 20 Feb 2018 15:54:13 +0100
Message-ID: <20180220145413.GF25201@hirez.programming.kicks-ass.net>
References: <20180220125829.27060-1-christian.koenig@amd.com>
 <20180220131253.GF25314@hirez.programming.kicks-ass.net>
 <8fd80334-4d0e-8ed0-8a09-02a7e36a0eae@gmail.com>
 <20180220135709.GD25201@hirez.programming.kicks-ass.net>
 <b625cbca-c05a-afd1-fe97-a7a0760383c1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <b625cbca-c05a-afd1-fe97-a7a0760383c1@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: dev@mblankhorst.nl, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBGZWIgMjAsIDIwMTggYXQgMDM6MzQ6MDdQTSArMDEwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiA+IE9LLCBidXQgbmVpdGhlciBjYXNlIHdvdWxkIGluIGZhY3QgbmVlZCB0aGUg
IWN0eCBjYXNlIHJpZ2h0PyBUaGF0J3MganVzdAo+ID4gdGhlcmUgZm9yIGNvbXBsZXRlbmVzcyBz
YWtlPwo+IAo+IFVuZm9ydHVuYXRlbHkgbm90LiBUVE0gdXNlcyB0cnlsb2NrIHRvIGxvY2sgQk9z
IHdoaWNoIGFyZSBhYm91dCB0byBiZQo+IGV2aWN0ZWQgdG8gbWFrZSByb29tIGZvciBhbGwgdGhl
IEJPcyBsb2NrZWQgd2l0aCBhIGN0eC4KPiAKPiBJIG5lZWQgdG8gYmUgYWJsZSB0byBkaXN0aW5j
dCBiZXR3ZWVuIHRoZSBCT3Mgd2hpY2ggYXJlIHRyeWxvY2tlZCBhbmQgdGhvc2UKPiB3aGljaCBh
cmUgbG9ja2VkIHdpdGggYSBjdHguCj4gCj4gV3JpdGluZyB0aGlzIEkgYWN0dWFsbHkgbm90aWNl
ZCB0aGUgY3VycmVudCB2ZXJzaW9uIGlzIGJ1Z2d5LCBjYXVzZSBldmVuCj4gd2hlbiB3ZSBjaGVj
ayB0aGUgbXV0ZXggb3duZXIgd2Ugc3RpbGwgbmVlZCB0byBtYWtlIHN1cmUgdGhhdCB0aGUgY3R4
IGluIHRoZQo+IGxvY2sgaXMgTlVMTC4KCkh1cm0uLi4gSSBjYW4ndCByZW1lbWJlciB3aHkgdHJ5
bG9ja3MgYmVoYXZlIGxpa2UgdGhhdCwgYW5kIGl0IHNlZW1zCnJhdGhlciB1bmZvcnR1bmF0ZSAv
IGluY29uc2lzdGVudC4KCkNocmlzLCBNYWFydGVuLCBkbyBlaXRoZXIgb25lIG9mIHlvdSByZW1l
bWJlcj8KCkknbSB0aGlua2luZyB0aGF0IGlmIHdlIGRvIGFjcXVpcmUgdGhlIHRyeWxvY2ssIHRo
ZSB0aGluZyBzaG91bGQgam9pbgp0aGUgY3R4IHN1Y2ggdGhhdCBhIHN1YnNlcXVlbnQgY29udGVu
ZGluZyBtdXRleF9sb2NrKCkgY2FuIHd3IHJpZ2h0LgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9kcmktZGV2ZWwK
