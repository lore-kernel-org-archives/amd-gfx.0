From: sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: Re: [PATCH 01/35] drm/amd/display: Use udelay when waiting between
 aux retries
Date: Fri, 1 Feb 2019 20:08:30 +0000
Message-ID: <20190201200830.GA7069@freedom>
References: <20190201152847.11151-1-Bhawanpreet.Lakha@amd.com>
 <20190201152847.11151-2-Bhawanpreet.Lakha@amd.com>
 <20190201173141.GA3838@freedom>
 <fda8f6ec-5a75-6456-3034-f3714b304b77@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <fda8f6ec-5a75-6456-3034-f3714b304b77-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Cc: "Barberiz, John" <John.Barberiz-5C7GfCeVMHo@public.gmane.org>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCBGZWIgMDEsIDIwMTkgYXQgMDc6MTY6MTdQTSArMDAwMCwgV2VudGxhbmQsIEhhcnJ5
IHdyb3RlOgo+IE9uIDIwMTktMDItMDEgMTI6MzEgcC5tLiwgc3lsdmFpbi5iZXJ0cmFuZEBnbWFp
bC5jb20gd3JvdGU6Cj4gPiBPbiBGcmksIEZlYiAwMSwgMjAxOSBhdCAxMDoyODoxM0FNIC0wNTAw
LCBCaGF3YW5wcmVldCBMYWtoYSB3cm90ZToKPiA+PiBGcm9tOiBKb2huIEJhcmJlcml6IDxKb2hu
LkJhcmJlcml6QGFtZC5jb20+Cj4gPj4gW0hvd10KPiA+PiBtc2xlZXAgaXMgaW5hY2N1cmF0ZSBm
b3Igc21hbGwgdmFsdWVzLiBVc2VkIHVkZWxheQo+ID4+IGluc3RlYWQgZm9yIGFjY3VyYWN5Lgo+
ID4gCj4gPiBIaSwKPiA+IAo+ID4gU2hvdWxkIGl0IGJlIHRoZSBjYXNlIGZvciBub24tREMgZGlz
cGxheXBvcnQgY29kZSB0b28/Cj4gPiAKPiAKPiBJIGRvbid0IHRoaW5rIHdlJ3JlIGFjdHVhbGx5
IHVzaW5nIHRoaXMgY29kZSBvbiBMaW51eC4gSXQncyBwYXJ0IG9mIHRoZSBzaGFyZWQgY29kZWJh
c2Ugd2l0aCBXaW5kb3dzLiBBcHBhcmVudGx5IHRoZXJlIG1zbGVlcCB3b3VsZCBvZnRlbiBzbGVl
cCBsb25nZXIgdGhhbiAxbXMuCj4gCj4gZHJtX2RwX2RwY2RfYWNjZXNzIGFscmVhZHkgaGFzIGEg
dGlnaHRlciBib3VuZCBvbiB0aGUgc2xlZXAgYmV0d2VlbiByZXRyaWVzICg1MDAtNjAwIHVzKSwg
c28gSSBpbWFnaW5lIHdlJ3JlIGZpbmUgdGhlcmUuCgpEbyB5b3UgbWVhbiBub24tREMgZGlzcGxh
eXBvcnQgcmVsYXRlZCBjb2RlIGlzIGFscmVhZHkgdXNpbmcgdWRlbGF5IGluc3RlYWQgb2YgbXNs
ZWVwIG9uIGxpbnV4PwoKLS0gClN5bHZhaW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
