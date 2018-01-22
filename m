From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: lock/unlock mismatch in ttm_bo.c
Date: Mon, 22 Jan 2018 14:42:55 +0800
Message-ID: <57fdd509-5de6-a7d8-9588-cb2c63b8f451@amd.com>
References: <1713476e-c17f-9eea-ebd3-6999c760b678@amd.com>
 <81e40cdf-6869-57fa-6858-eb77dbfb45a8@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <81e40cdf-6869-57fa-6858-eb77dbfb45a8-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAyMDE45bm0MDHmnIgyMOaXpSAwMjoyMywgVG9tIFN0IERlbmlzIHdyb3RlOgo+IE9uIDE5
LzAxLzE4IDAxOjE0IFBNLCBUb20gU3QgRGVuaXMgd3JvdGU6Cj4+IEhpIGFsbCwKPj4KPj4gSW4g
dGhlIGZ1bmN0aW9uIHR0bV9ib19jbGVhbnVwX3JlZnMoKSBpdCBzZWVtcyBwb3NzaWJsZSB0byBn
ZXQgdG8gCj4+IGxpbmUgNTUxIHdpdGhvdXQgZW50ZXJpbmcgdGhlIGJsb2NrIG9uIDUxNiB3aGlj
aCBtZWFucyB5b3UnbGwgYmUgCj4+IHVubG9ja2luZyBhIG11dGV4IHRoYXQgd2Fzbid0IGxvY2tl
ZC4KPj4KPj4gTm93IGl0IG1pZ2h0IGJlIHRoYXQgaW4gdGhlIGNvdXJzZSBvZiB0aGUgQVBJIHRo
aXMgcGF0dGVybiBjYW5ub3QgYmUgCj4+IGV4cHJlc3NlZCBidXQgaXQncyBub3QgY2xlYXIgZnJv
bSB0aGUgZnVuY3Rpb24gYWxvbmUgdGhhdCB0aGF0IGlzIHRoZSAKPj4gY2FzZS4KPgo+Cj4gTG9v
a2luZyBmdXJ0aGVyIGl0IHNlZW1zIHRoZSBiZWhhdmlvdXIgZGVwZW5kcyBvbiBsb2NraW5nIGlu
IHBhcmVudCAKPiBjYWxsZXJzLsKgIFRoYXQncyBraW5kYSBhIG5vLW5vIHJpZ2h0P8KgIFNob3Vs
ZG4ndCB0aGUgbG9jayBiZSAKPiB0YWtlbi9yZWxlYXNlZCBpbiB0aGUgc2FtZSBmdW5jdGlvbiBp
ZGVhbGx5PwpTYW1lIGZlZWxpbmdzCgpSZWdhcmRzLApEYXZpZCBaaG91Cj4KPiAoYWxzbyB0aGVy
ZSBhcmUgYSBoYW5kZnVsIG9mIHN0eWxlIGlzc3VlcyBJJ2xsIHdyaXRlIHVwIHNvbWUgcGF0Y2hl
cyAKPiBmb3Igb24gTW9uZGF5IDotKSkuCj4KPiBDaGVlcnMsCj4gVG9tCj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
