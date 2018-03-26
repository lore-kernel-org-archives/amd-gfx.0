From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [PATCH] dma-buf: use parameter structure for dma_buf_attach
Date: Mon, 26 Mar 2018 17:16:54 +0200
Message-ID: <20180326151654.GV14155@phenom.ffwll.local>
References: <20180325113451.2425-1-christian.koenig@amd.com>
 <20180326083638.GS14155@phenom.ffwll.local>
 <0242b504-87cd-2c80-ad86-868622c3c681@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0242b504-87cd-2c80-ad86-868622c3c681-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

T24gTW9uLCBNYXIgMjYsIDIwMTggYXQgMTI6NDc6MDFQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAyNi4wMy4yMDE4IHVtIDEwOjM2IHNjaHJpZWIgRGFuaWVsIFZldHRlcjoK
PiA+IE9uIFN1biwgTWFyIDI1LCAyMDE4IGF0IDAxOjM0OjUxUE0gKzAyMDAsIENocmlzdGlhbiBL
w7ZuaWcgd3JvdGU6Cj4gW1NOSVBdCj4gPiA+IC0JYXR0YWNoLT5kZXYgPSBkZXY7Cj4gPiA+ICsJ
YXR0YWNoLT5kZXYgPSBpbmZvLT5kZXY7Cj4gPiA+ICAgCWF0dGFjaC0+ZG1hYnVmID0gZG1hYnVm
Owo+ID4gPiArCWF0dGFjaC0+cHJpdiA9IGluZm8tPnByaXY7Cj4gPiBUaGUgLT5wcml2IGZpZWxk
IGlzIGZvciB0aGUgZXhwb3J0ZXIsIG5vdCB0aGUgaW1wb3J0ZXIuIFNlZSBlLmcuCj4gPiBkcm1f
Z2VtX21hcF9hdHRhY2guIFlvdSBjYW4ndCBsZXQgdGhlIGltcG9ydGVyIHNldCB0aGlzIG5vdyB0
b28sIHNvIG5lZWRzCj4gPiB0byBiZSByZW1vdmVkIGZyb20gdGhlIGluZm8gc3RydWN0Lgo+IAo+
IENyYXAsIGluIHRoaXMgY2FzZSBJIG5lZWQgdG8gYWRkIGFuIGltcG9ydGVyX3ByaXYgZmllbGQg
YmVjYXVzZSB3ZSBub3cgbmVlZAo+IHRvIG1hcCBmcm9tIHRoZSBhdHRhY2htZW50IHRvIGl0J3Mg
aW1wb3J0ZXIgb2JqZWN0IGFzIHdlbGwuCj4gCj4gVGhhbmtzIGZvciBub3RpY2luZyB0aGlzLgoK
TWF5YmUgYWRkIHRoZSBpbXBvcnRlcl9wcml2IGZpZWxkIG9ubHkgaW4gdGhlIHNlcmllcyB0aGF0
IGFjdHVhbGx5IGFkZHMKaXQsIG5vdCBpbiB0aGlzIHByZXAgcGF0Y2guIFlvdSBjYW4gbWVudGlv
biBhbGwgdGhlIGZpZWxkcyB5b3UgbmVlZCBoZXJlCmluIHRoZSBjb21taXQgbWVzc2FnZSBmb3Ig
anVzdGlmaWNhdGlvbi4KLURhbmllbAotLSAKRGFuaWVsIFZldHRlcgpTb2Z0d2FyZSBFbmdpbmVl
ciwgSW50ZWwgQ29ycG9yYXRpb24KaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
