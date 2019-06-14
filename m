From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/13] drm/amdgpu: introduce and honour DRM_FORCE_AUTH
 workaround
Date: Fri, 14 Jun 2019 17:25:56 +0100
Message-ID: <20190614162556.GD32412@arch-x1c3>
References: <20190527081741.14235-1-emil.l.velikov@gmail.com>
 <20190614120927.GA32412@arch-x1c3>
 <9dbdda6c-8916-e5ae-1676-86828b9890e7@amd.com>
 <20190614155325.GC32412@arch-x1c3>
 <84b3337c-0cdc-44d4-02c6-c56bd729ed47@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <84b3337c-0cdc-44d4-02c6-c56bd729ed47-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS8wNi8xNCwgS29lbmlnLCBDaHJpc3RpYW4gd3JvdGU6Cj4gQW0gMTQuMDYuMTkgdW0g
MTc6NTMgc2NocmllYiBFbWlsIFZlbGlrb3Y6Cj4gPiBPbiAyMDE5LzA2LzE0LCBLb2VuaWcsIENo
cmlzdGlhbiB3cm90ZToKPiA+PiBBbSAxNC4wNi4xOSB1bSAxNDowOSBzY2hyaWViIEVtaWwgVmVs
aWtvdjoKPiA+Pj4gT24gMjAxOS8wNS8yNywgRW1pbCBWZWxpa292IHdyb3RlOgo+ID4+PiBbU05J
UF0KPiA+Pj4gSGkgQ2hyaXN0aWFuLAo+ID4+Pgo+ID4+Pgo+ID4+PiBJbiB0aGUgZm9sbG93aW5n
LCBJIHdvdWxkIGxpa2UgdG8gc3VtbWFyaXNlIGFuZCBlbXBoYXNpemUgdGhlIG5lZWQgZm9yCj4g
Pj4+IERSTV9BVVRIIHJlbW92YWwuIEkgd291bGQga2luZGx5IGFzayB5b3UgdG8gc3BlbmQgYSBj
b3VwbGUgb2YgbWludXRlcwo+ID4+PiBleHRyYSByZWFkaW5nIGl0Lgo+ID4+Pgo+ID4+Pgo+ID4+
PiBUb2RheSBEUk0gZHJpdmVycyogZG8gbm90IG1ha2UgYW55IGRpc3RpbmN0aW9uIGJldHdlZW4g
cHJpbWFyeSBhbmQKPiA+Pj4gcmVuZGVyIG5vZGUgY2xpZW50cy4KPiA+PiBUaGF0IGlzIGFjdHVh
bGx5IG5vdCAxMDAlIGNvcnJlY3QuIFdlIGhhdmUgYSBzcGVjaWFsIGNhc2Ugd2hlcmUgYSBEUk0K
PiA+PiBtYXN0ZXIgaXMgYWxsb3dlZCB0byBjaGFuZ2UgdGhlIHByaW9yaXR5IG9mIHJlbmRlciBu
b2RlIGNsaWVudHMuCj4gPj4KPiA+IENhbiB5b3UgcHJvdmlkZSBhIGxpbms/IEkgY2Fubm90IGZp
bmQgdGhhdCBjb2RlLgo+IAo+IFNlZSBhbWRncHVfc2NoZWRfaW9jdGwoKS4KPiAKPiA+Pj4gVGh1
cyBmb3IgYSByZW5kZXIgY2FwYWJsZSBkcml2ZXIsIGFueSBwcmVtaXNlIG9mCj4gPj4+IHNlcGFy
YXRpb24sIHNlY3VyaXR5IG9yIG90aGVyd2lzZSBpbXBvc2VkIHZpYSBEUk1fQVVUSCBpcyBhIGZh
bGxhY3kuCj4gPj4gWWVhaCwgdGhhdCdzIHdoYXQgSSBhZ3JlZSBvbi4gSSBqdXN0IGRvbid0IHRo
aW5rIHRoYXQgcmVtb3ZpbmcgRFJNX0FVVEgKPiA+PiBub3cgaXMgdGhlIHJpZ2h0IGRpcmVjdGlv
biB0byB0YWtlLgo+ID4+Cj4gPiBDb3VsZCBoYXZlIGJlZW4gY2xlYXJlciAtIEknbSB0YWxraW5n
IGFib3V0IERSTV9BVVRIIHwgRFJNX1JFTkRFUl9BTExPVwo+ID4gaW9jdGxzLgo+ID4KPiA+IFRo
YXQgYXNpZGUsIGNhbiB5b3UgcHJvcG9zZSBhbiBhbHRlcm5hdGl2ZSBzb2x1dGlvbiB0aGF0IGFk
ZHJlc3NlcyB0aGlzCj4gPiBhbmQgdGhlIHNlY29uZCBwb2ludCBqdXN0IGJlbG93Pwo+IAo+IEdp
dmUgbWUgYSBmZXcgZGF5cyB0byB3b3JrIG9uIHRoaXMsIGl0J3MgYWxyZWFkeSBGcmlkYXkgNnBt
IGhlcmUuCj4gCkdyZWF0IHRoYW5rcy4gRndpdyBJIHdhcyBhc2tpbmcgZm9yIGEgaWRlYXMvcHJv
cG9zYWwsIHdhcyBub3QgZXhwZWN0aW5nIHlvdQp0byB3cml0ZSB0aGUgcGF0Y2hlcyA7LSkKCkVt
aWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
