From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: 'buf' pointer in ttm_bo_vm_access_kmap()
Date: Fri, 26 Jan 2018 12:01:05 -0500
Message-ID: <10fd5e35-d563-adb4-fad3-c5590f1bc42e@amd.com>
References: <d3f92e9e-d0aa-1861-df8b-78320be94483@amd.com>
 <b7b27f3c-8b8e-1ead-f00c-c118f86b71fc@gmail.com>
 <eb4c173e-69ea-991e-2263-a06c7ab23702@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <eb4c173e-69ea-991e-2263-a06c7ab23702-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wMS0yNiAwOTo0MCBBTSwgVG9tIFN0IERlbmlzIHdyb3RlOgo+IE9uIDI2LzAxLzE4
IDA5OjM4IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAyNi4wMS4yMDE4IHVtIDE1
OjMxIHNjaHJpZWIgVG9tIFN0IERlbmlzOgo+Pj4gSGkgYWxsLAo+Pj4KPj4+IEluIHRoZSBmdW5j
dGlvbiB0dG1fYm9fdm1fYWNjZXNzX2ttYXAoKSBpdCBkb2Vzbid0IHNlZW0gdG8gbWUgbGlrZQo+
Pj4gdGhlICdidWYnIHBvaW50ZXIgaXMgaW5jcmVtZW50ZWQuwqAgVGhhdCBzZWVtcyBsaWtlIGEg
YnVnIG5vPwo+Pgo+PiBZZWFoLCBsb29rcyBzdXNwaWNpb3VzIHRvIG1lIGFzIHdlbGwuIEJ1dCBU
VE0gcXVlc3Rpb25zIHNob3VsZCBDQyB0aGUKPj4gZHJpIGxpc3QgYXMgd2VsbC4KPj4KPj4gQW5k
IGluIHRoaXMgcGFydGljdWxhciBjYXNlIEkgdGhpbmsgRmVsaXggd2FzIHRoZSBhdXRob3IgdGhh
dCBmdW5jdGlvbi4KPj4KPgo+IEhpIENocmlzdGlhbiwKPgo+IEknbSBhdXRob3JpbmcgYSBzZXQg
b2YgbW9zdGx5IE5GQyBwYXRjaGVzIGZvciBUVE0gYW5kIGFscmVhZHkgY3JhZnRlZAo+IGEgZml4
IGZvciB0aGlzIGluIHRoZSBwcm9jZXNzLgo+Cj4gSWYgdGhlIGZpeCAod2hpY2ggaXMgbGl0ZXJh
bGx5ICJidWYgKz0gYnl0ZXMiIGF0IHRoZSBlbmQgb2YgdGhlIHdoaWxlCj4gbG9vcCkgZG9lc24n
dCBnZXQgTkFLJ2VkIEknbGwgc3VibWl0IGl0IGFzIHBhcnQgb2YgbXkgY2xlYW51cCBwYXRjaGVz
LgoKVGhhbmtzIGZvciBjYXRjaGluZyB0aGF0LiBUaGUgZml4IHNvdW5kcyByZWFzb25hYmxlLiBT
aW5jZSBidWYgaXMgYSB2b2lkCnBvaW50ZXIsIHlvdSBtYXkgbmVlZCB0byBjYXN0IGl0IHRvICh1
aW50OF90ICopIG9yIChjaGFyICopIGZvciBzYW5lCnBvaW50ZXIgYXJpdGhtZXRpY3MuCgpJJ2xs
IHVwZGF0ZSBLRkRUZXN0IHRvIGluY2x1ZGUgcHRhY2Ugc3lzdGVtIG1lbW9yeSBhY2Nlc3NlcyBh
Y3Jvc3MgcGFnZQpib3VuZGFyaWVzLiBJIGRpZCBhIHNpbWlsYXIgdGhpbmcgZm9yIHRoZSBWUkFN
IHRlc3QgY3Jvc3NpbmcKbm9uLWNvbnRpZ3VvdXMgVlJBTSBib3VuZGFyaWVzLgoKUmVnYXJkcywK
wqAgRmVsaXgKCj4KPiBDaGVlcnMsCj4gVG9tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
