From: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Subject: Re: [BUG, regression] Dereferencing of NULL pointer in
 radeon_mn_unregister()
Date: Sun, 1 Sep 2019 14:04:12 +0000
Message-ID: <20190901140409.GA1251@mellanox.com>
References: <dad0e51a-0f06-e2b0-cef7-3587207c2045@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <dad0e51a-0f06-e2b0-cef7-3587207c2045-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Content-ID: <D062E2C23132E1449ED4208B35528D3E-wNKe6lTLrGecE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Petr Cvek <petrcvekcz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "David1.Zhou-5C7GfCeVMHo@public.gmane.org" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org" <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>

T24gU3VuLCBTZXAgMDEsIDIwMTkgYXQgMTE6Mzg6MTBBTSArMDIwMCwgUGV0ciBDdmVrIHdyb3Rl
OgoKPiBUaGUgY29kZSBpczoKPiAKPiAJc3RydWN0IHJhZGVvbl9tbiAqcm1uID0gYm8tPm1uOwo+
IAkuLi4KPiAJbXV0ZXhfbG9jaygmcm1uLT5sb2NrKTsJCS8vPC1jcmFzaAo+IAo+IEEgcXVpY2sg
YXNzZXJ0IHByb3ZlcyB0aGUgYm8tPm1uIHJldHVybnMgTlVMTC4gVGhlIGNvZGUgd29ya2VkIGlu
Cj4gNC4xOS1yYyBhbmQgaXQgc2VlbXMgdGhlIHByb2JsZW1hdGljIHBhdGNoIGlzCgpIdW0sIHRo
ZSBjb2RlIHdlbnQgYXdheSBiZWNhdXNlIHRoZSBsb2NraW5nIHByb3RlY3RpbmcgdGhhdCB2YXJp
YWJsZQp3ZW50IGF3YXkuLiBJdCBtZWFucyB0aGUgY2FsbGVyIGlzIG5vdCBjYXJlZnVsIHRvIHBh
aXIgcmVnaXN0ZXIgYW5kCnVucmVnaXN0ZXIuCiAKPiAJZHJtL3JhZGVvbjogdXNlIG1tdV9ub3Rp
Zmllcl9nZXQvcHV0IGZvciBzdHJ1Y3QgcmFkZW9uX21uCj4gCj4gYXMgaXQgcmVtb3ZlcyB0aGUg
TlVMTCBjaGVjay4KPiAKPiBGb3JjaW5nIC1FTk9ERVYgaW4gdGhlIHJlZ2lzdGVyIGZ1bnRpb24g
KGFuZCBpbW1lZGlhdGUgcmV0dXJuIGluCj4gdW5yZWdpc3RlciBhcyB3aXRob3V0IENPTkZJR19N
TVVfTk9USUZJRVIpIHdvcmtzLgoKSXMganVzdCBhZGRpbmcgYQoKICBpZiAoIXJtbikKICAgICAg
IHJldHJ1bgoKVG8gdGhlIHRvcCBvZiByYWRlb25fbW5fdW5yZWdpc3RlciBlbm91Z2ggdG8gZml4
IGl0PwoKSmFzb24KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
