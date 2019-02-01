From: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 01/35] drm/amd/display: Use udelay when waiting between
 aux retries
Date: Fri, 1 Feb 2019 19:16:17 +0000
Message-ID: <fda8f6ec-5a75-6456-3034-f3714b304b77@amd.com>
References: <20190201152847.11151-1-Bhawanpreet.Lakha@amd.com>
 <20190201152847.11151-2-Bhawanpreet.Lakha@amd.com>
 <20190201173141.GA3838@freedom>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190201173141.GA3838@freedom>
Content-Language: en-US
Content-ID: <F66DEE123FEE2C4DAFDF881B3F28763E-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Cc: "Barberiz, John" <John.Barberiz-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wMi0wMSAxMjozMSBwLm0uLCBzeWx2YWluLmJlcnRyYW5kQGdtYWlsLmNvbSB3cm90
ZToNCj4gT24gRnJpLCBGZWIgMDEsIDIwMTkgYXQgMTA6Mjg6MTNBTSAtMDUwMCwgQmhhd2FucHJl
ZXQgTGFraGEgd3JvdGU6DQo+PiBGcm9tOiBKb2huIEJhcmJlcml6IDxKb2huLkJhcmJlcml6QGFt
ZC5jb20+DQo+PiBbSG93XQ0KPj4gbXNsZWVwIGlzIGluYWNjdXJhdGUgZm9yIHNtYWxsIHZhbHVl
cy4gVXNlZCB1ZGVsYXkNCj4+IGluc3RlYWQgZm9yIGFjY3VyYWN5Lg0KPiANCj4gSGksDQo+IA0K
PiBTaG91bGQgaXQgYmUgdGhlIGNhc2UgZm9yIG5vbi1EQyBkaXNwbGF5cG9ydCBjb2RlIHRvbz8N
Cj4gDQoNCkkgZG9uJ3QgdGhpbmsgd2UncmUgYWN0dWFsbHkgdXNpbmcgdGhpcyBjb2RlIG9uIExp
bnV4LiBJdCdzIHBhcnQgb2YgdGhlIHNoYXJlZCBjb2RlYmFzZSB3aXRoIFdpbmRvd3MuIEFwcGFy
ZW50bHkgdGhlcmUgbXNsZWVwIHdvdWxkIG9mdGVuIHNsZWVwIGxvbmdlciB0aGFuIDFtcy4NCg0K
ZHJtX2RwX2RwY2RfYWNjZXNzIGFscmVhZHkgaGFzIGEgdGlnaHRlciBib3VuZCBvbiB0aGUgc2xl
ZXAgYmV0d2VlbiByZXRyaWVzICg1MDAtNjAwIHVzKSwgc28gSSBpbWFnaW5lIHdlJ3JlIGZpbmUg
dGhlcmUuDQoNCkhhcnJ5DQoNCj4gcmVnYXJkcywNCj4gDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
