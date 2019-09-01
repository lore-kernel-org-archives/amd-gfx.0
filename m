From: Petr Cvek <petrcvekcz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [BUG, regression] Dereferencing of NULL pointer in
 radeon_mn_unregister()
Date: Sun, 1 Sep 2019 17:48:36 +0200
Message-ID: <2fc7ef14-e89a-1f2d-381d-1c9b05da02d3@gmail.com>
References: <dad0e51a-0f06-e2b0-cef7-3587207c2045@gmail.com>
 <20190901140409.GA1251@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190901140409.GA1251-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Content-Language: cs
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
To: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "David1.Zhou-5C7GfCeVMHo@public.gmane.org" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org" <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>

RG5lIDAxLiAwOS4gMTkgdiAxNjowNCBKYXNvbiBHdW50aG9ycGUgbmFwc2FsKGEpOgo+IE9uIFN1
biwgU2VwIDAxLCAyMDE5IGF0IDExOjM4OjEwQU0gKzAyMDAsIFBldHIgQ3ZlayB3cm90ZToKPiAK
Pj4gVGhlIGNvZGUgaXM6Cj4+Cj4+IAlzdHJ1Y3QgcmFkZW9uX21uICpybW4gPSBiby0+bW47Cj4+
IAkuLi4KPj4gCW11dGV4X2xvY2soJnJtbi0+bG9jayk7CQkvLzwtY3Jhc2gKPj4KPj4gQSBxdWlj
ayBhc3NlcnQgcHJvdmVzIHRoZSBiby0+bW4gcmV0dXJucyBOVUxMLiBUaGUgY29kZSB3b3JrZWQg
aW4KPj4gNC4xOS1yYyBhbmQgaXQgc2VlbXMgdGhlIHByb2JsZW1hdGljIHBhdGNoIGlzCj4gCj4g
SHVtLCB0aGUgY29kZSB3ZW50IGF3YXkgYmVjYXVzZSB0aGUgbG9ja2luZyBwcm90ZWN0aW5nIHRo
YXQgdmFyaWFibGUKPiB3ZW50IGF3YXkuLiBJdCBtZWFucyB0aGUgY2FsbGVyIGlzIG5vdCBjYXJl
ZnVsIHRvIHBhaXIgcmVnaXN0ZXIgYW5kCj4gdW5yZWdpc3Rlci4KPiAgCj4+IAlkcm0vcmFkZW9u
OiB1c2UgbW11X25vdGlmaWVyX2dldC9wdXQgZm9yIHN0cnVjdCByYWRlb25fbW4KPj4KPj4gYXMg
aXQgcmVtb3ZlcyB0aGUgTlVMTCBjaGVjay4KPj4KPj4gRm9yY2luZyAtRU5PREVWIGluIHRoZSBy
ZWdpc3RlciBmdW50aW9uIChhbmQgaW1tZWRpYXRlIHJldHVybiBpbgo+PiB1bnJlZ2lzdGVyIGFz
IHdpdGhvdXQgQ09ORklHX01NVV9OT1RJRklFUikgd29ya3MuCj4gCj4gSXMganVzdCBhZGRpbmcg
YQo+IAo+ICAgaWYgKCFybW4pCj4gICAgICAgIHJldHJ1bgo+IAo+IFRvIHRoZSB0b3Agb2YgcmFk
ZW9uX21uX3VucmVnaXN0ZXIgZW5vdWdoIHRvIGZpeCBpdD8KClllYWggaXQgc2VlbXMgdG8gd29y
ay4gQSBmdXJ0aGVyIHRlc3Qgd2l0aCBtaW5ldGVzdCB3b3JrcyB0b28uCgpQZXRyIAoKPiAKPiBK
YXNvbgo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
