From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Avoid leaking PM domain on driver unbind
Date: Tue, 23 Jan 2018 15:53:48 +0100
Message-ID: <20180123145348.GA20456@wunner.de>
References: <8cbcbe7f57f72bc1d4e36c9cfaf670140e311da9.1516538481.git.lukas@wunner.de>
 <CADnq5_PrAtz=rO1E_Tkg0+n880FwOAyowMW2WampSpVx+69CLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CADnq5_PrAtz=rO1E_Tkg0+n880FwOAyowMW2WampSpVx+69CLA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "David (ChunMing) Zhou" <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCBKYW4gMjIsIDIwMTggYXQgMTE6MjI6NThQTSAtMDUwMCwgQWxleCBEZXVjaGVyIHdy
b3RlOgo+IE9uIFN1biwgSmFuIDIxLCAyMDE4IGF0IDc6NDYgQU0sIEx1a2FzIFd1bm5lciA8bHVr
YXNAd3VubmVyLmRlPiB3cm90ZToKPiA+IGFtZGdwdV9kZXZpY2VfaW5pdCgpIGNhbGxzIHZnYV9z
d2l0Y2hlcm9vX2luaXRfZG9tYWluX3BtX29wcygpIGVpdGhlcgo+ID4gaWYgdGhlIGRldmljZSBo
YXMgdGhlIFBvd2VyWHByZXNzIGZsYWcgc2V0IG9yIGlmIHRoZSB1c2VyIGhhcyBzZXQgdGhlCj4g
PiAicnVucG0iIG1vZHVsZSBwYXJhbSB0byAxLgo+ID4KPiA+IEhvd2V2ZXIgYW1kZ3B1X2Rldmlj
ZV9maW5pKCkgY2FsbHMgdmdhX3N3aXRjaGVyb29fZmluaV9kb21haW5fcG1fb3BzKCkKPiA+IG9u
bHkgdW5kZXIgdGhlIGZpcnN0IG9mIHRob3NlIHR3byBjb25kaXRpb25zLgo+IAo+IEdvb2QgY2F0
Y2guICBGb3JjaW5nIHJ1bnBtPTEgZG9lc24ndCBkbyBhbnl0aGluZyB1c2VmdWwgYW55d2F5IHNv
IGp1c3QKPiByZW1vdmUgaXQgaW4gZGV2aWNlX2luaXQoKS4gIFNlZSB0aGUgYXR0YWNoZWQgcGF0
Y2guCgpPaywgYWNrLgoKTHVrYXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
