From: zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/7] drm: add syncobj timeline support v8
Date: Fri, 19 Oct 2018 18:45:23 +0800
Message-ID: <69039ffa-425e-81e7-4b08-1d431d8a212f@amd.com>
References: <20181015085553.30656-1-david1.zhou@amd.com>
 <20181015085553.30656-2-david1.zhou@amd.com>
 <20181017080908.GK31561@phenom.ffwll.local>
 <2066a18d-8002-014b-ef3c-a6f6014bdb55@amd.com>
 <2f99da09-7bf7-d5e7-d7c1-fe2e4cf43b40@amd.com>
 <CAKMK7uGxptMKtz-4JzT9us3M2dsLGhTSVuAKduNH+VGCsCSsQw@mail.gmail.com>
 <b08b1f23-d8dc-a294-2176-5125075c9acc@amd.com>
 <bdb5bf27-b543-e308-a121-6bae35854e95@gmail.com>
 <544bca0a-977a-9900-d6dd-92c91ef9337e@amd.com>
 <20181019085509.GZ31561@phenom.ffwll.local>
 <19972bac-f2a9-49ee-592d-85f9eaf06145@amd.com>
 <22a52713-0ab5-80d9-a604-b171f916eedd@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <22a52713-0ab5-80d9-a604-b171f916eedd-5C7GfCeVMHo@public.gmane.org>
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
To: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Rakos,
 Daniel" <Daniel.Rakos-5C7GfCeVMHo@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>, Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org

CltzbmlwXQo+Pj4gV2VudCBib29tOgo+Pj4KPj4+IGh0dHBzOi8vYnVncy5mcmVlZGVza3RvcC5v
cmcvc2hvd19idWcuY2dpP2lkPTEwODQ5MAo+Pj4KPj4+IENhbiB3ZSByZXZlcnQgcGxzPwo+PiBT
b3JyeSBmb3IgYnVnLCBwbGVhc2UuCj4gSW4gZmFjdCwgdGhlIGJ1ZyBpcyBhbHJlYWR5IGNhdWdo
dCBhbmQgZml4ZWQsIGp1c3QgdGhlIGZpeCBwYXJ0IGlzbid0IAo+IGluIHBhdGNoIzEsIGJ1dCBp
biBwYXRjaCMyOgo+Cj4gSGF2ZSB5b3UgcmV2ZXJ0ZWQ/IElmIG5vdCwgSSBjYW4gc2VuZCB0aGF0
IGZpeCBpbiBvbmUgbWludXRlLgo+Cj4KPiBSZWdhcmRzLAo+IERhdmlkIFpob3UKPj4+Cj4+PiBB
bHNvLCBjYW4gd2UgcGxlYXNlIGhhdmUgaWd0cyBmb3IgdGhpcyBzdHVmZiBzbyB0aGF0IGludGVs
LWdmeC1jaSBjb3VsZAo+Pj4gdGVzdCB0aGlzIHByb3Blcmx5IGJlZm9yZSBpdCdzIGFsbCBmaXJl
d29ya3M/CkhpIERhbmllbCBWLAoKQ291bGQgeW91IHBvaW50IG1lIHdoaWNoIHByb2JsZW0gSSBl
bmNvdW50ZXIgd2hlbiBJIHJ1biBzeW5jb2JqX3dhaXQgb2YgaWd0PwoKamVua2luc0BqZW5raW5z
LU1TLTc5ODQ6fi9mcmVlZGVza3RvcC9pZ3QtZ3B1LXRvb2xzL3Rlc3RzJCAuL3N5bmNvYmpfd2Fp
dApJR1QtVmVyc2lvbjogMS4yMy1nOTRlYmQyMSAoeDg2XzY0KSAoTGludXg6IDQuMTkuMC1yYzUt
Y3VzdG9tKyB4ODZfNjQpClRlc3QgcmVxdWlyZW1lbnQgbm90IG1ldCBpbiBmdW5jdGlvbiBpZ3Rf
cmVxdWlyZV9zd19zeW5jLCBmaWxlIApzd19zeW5jLmM6MjQwOgpUZXN0IHJlcXVpcmVtZW50OiBr
ZXJuZWxfaGFzX3N3X3N5bmMoKQpMYXN0IGVycm5vOiAyLCBObyBzdWNoIGZpbGUgb3IgZGlyZWN0
b3J5CgpUaGFua3MsCkRhdmlkIFpob3UKPj4gU2VlbXMgd2UgY2Fubm90IGF2b2lkIGlndCBub3cg
YW5kIHZ1bGthbiBDVFMgaXNuJ3QgZW5vdWdoLCBJIHdpbGwgCj4+IGZpbmQgc29tZSB0aW1lIG5l
eHQgd2VlayB0byBsZWFuIElHVCwgbG9va3MgdjEwIGlzIG5lZWQuCj4+Cj4+IFJlZ2FyZHMsCj4+
IERhdmlkIFpob3UKPj4+Cj4+PiBUaGFua3MsIERhbmllbAo+Pj4KPj4+Pj4gVGhlIHJlc3QgaW4g
dGhlIHNlcmllcyBsb29rcyBnb29kIHRvIG1lIGFzIHdlbGwsCj4+Pj4gQ2FuIEkgZ2V0IHlvdXIg
UkIgb24gdGhlbSBmaXJzdD8KPj4+Pgo+Pj4+PiBidXQgSSBjZXJ0YWlubHkgd2FudCB0aGUgcmFk
di9hbnYgZGV2ZWxvcGVycyB0byB0YWtlIGEgbG9vayBhcyAKPj4+Pj4gd2VsbCBhcwo+Pj4+PiBE
YW5pZWwgc3VnZ2VzdGVkLgo+Pj4+IFBpbmcgQERhdmUvQmFzL0phc29uIG9yIG90aGVyIHJhZHYv
YW52IGRldmVsb3BlcnMsIENvdWxkIGFueW9uZSBvZiAKPj4+PiB5b3UgdGFrZQo+Pj4+IGEgbG9v
ayB0aGUgcmVzdCBvZiBzZXJpZXMgZm9yIHUvayBpbnRlcmZhY2U/IFNvIHRoYXQgd2UgY2FuIG1v
dmUgdG8gCj4+Pj4gbmV4dAo+Pj4+IHN0ZXAgZm9yIGxpYmRybSBwYXRjaGVzPwo+Pj4+Cj4+Pj4g
VGhhbmtzLAo+Pj4+IERhdmlkCj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4KPj4+Pj4+IFRoYW5rcywK
Pj4+Pj4+IERhdmlkIFpob3UKPj4+Pj4+Cj4+Pj4+Pj4gLURhbmllbAo+Pj4+Pj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+Pj4+IGFtZC1nZnggbWFp
bGluZyBsaXN0Cj4+Pj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4+Pj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cj4+Cj4+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGFtZC1n
ZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+Cj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1h
aWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
