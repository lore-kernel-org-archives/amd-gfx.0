From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: KASAN: use-after-free in amdgpu_ttm_tt_pte_flags
Date: Wed, 13 Jun 2018 18:55:34 +0800
Message-ID: <20180613105533.GA26944@hr-amur2>
References: <16e44e90-b7b5-0c7c-9ed6-3bf666d385a0@daenzer.net>
 <5f35a853-8d82-2db0-ee81-f347e5d722e5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5f35a853-8d82-2db0-ee81-f347e5d722e5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCBKdW4gMDgsIDIwMTggYXQgMDg6MTU6MjZQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBHb2luZyB0byB0YWtlIGEgbG9vayBvbiBNb25kYXkuCj4gCgpDaHJpc3RpYW4s
IGhhdmUgeW91IGxvb2tlZCBhdCB0aGlzIGlzc3VlPyBJZiBub3QsIGNhbiBJIHZvbHVudGVlciB0
byBsb29rIGF0Cml0PwoKTWljaGVsLCBtYXkgSSBrbm93IHdoaWNoIHRlc3Qgb2YgcGlnbGl0IHRy
aWdnZXIgdGhpcyBpc3N1ZT8gSSB0cmllZCB0byBydW4Kd2l0aCBxdWljay5weSwgYnV0IGRpZG4n
dCByZXByb2R1Y2UgaXQuCgpUaGFua3MsClJheQoKPiBUaGFua3MsCj4gQ2hyaXN0aWFuLgo+IAo+
IEFtIDA4LjA2LjIwMTggdW0gMTY6MDcgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPiA+S0FTQU4g
cGlja2VkIHVwIHNvbWV0aGluZyBkdXJpbmcgdG9kYXkncyBwaWdsaXQgcnVuIG9uCj4gPmFtZC1z
dGFnaW5nLWRybS1uZXh0LCBzZWUgYXR0YWNoZWQuIEkndmUgbmV2ZXIgc2VlbiB0aGlzIG9uZSBi
ZWZvcmUuCj4gPgo+ID4KPiA+Cj4gPgo+ID5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+ID5hbWQtZ2Z4IG1haWxpbmcgbGlzdAo+ID5hbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+ID5odHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngKPiAKCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
