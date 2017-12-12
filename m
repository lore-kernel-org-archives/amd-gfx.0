From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] amdgpu: disable GPU reset if amdgpu.lockup_timeout=0
Date: Tue, 12 Dec 2017 16:02:17 +0100
Message-ID: <CAAxE2A6ZCHrkKM81vLBEubB-fLQCQuBtDYNjmTvDqEDKVLVDgw@mail.gmail.com>
References: <1513027772-32408-1-git-send-email-maraeo@gmail.com>
 <BLUPR12MB04497DB5DEFE7C66CE3E702084340@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB04497DB5DEFE7C66CE3E702084340-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVHVlLCBEZWMgMTIsIDIwMTcgYXQgNDoxOCBBTSwgTGl1LCBNb25rIDxNb25rLkxpdUBhbWQu
Y29tPiB3cm90ZToKPiBOQUssIHlvdSBjaGFuZ2UgYnJlYWsgU1JJT1YgbG9naWM6Cj4KPiBXaXRo
b3V0IGxvY2t1cF90aW1lb3V0IHNldCwgdGhpcyBncHVfcmVjb3ZlcigpIHdvbid0IGdldCBjYWxs
ZWQgYXQgYWxsICwgdW5sZXNzIHlvdXIgSUIgdHJpZ2dlcmVkIGludmFsaWQgaW5zdHJ1Y3QgYW5k
IHRoYXQgSVJRIGludm9rZWQKPiBBbWRncHVfZ3B1X3JlY292ZXIoKSwgYnkgdGhpcyBjYXVzZSB5
b3Ugc2hvdWxkIGRpc2FibGUgdGhlIGxvZ2ljIHRoYXQgaW4gdGhhdCBJUlEgaW5zdGVhZCBvZiBj
aGFuZ2UgZ3B1X3JlY292ZXIoKSBpdHNlbGYgYmVjYXVzZQo+IEZvciBTUklPViB3ZSBuZWVkIGdw
dV9yZWNvdmVyKCkgZXZlbiBsb2NrdXBfdGltZW91dCBpcyB6ZXJvCgpUaGUgZGVmYXVsdCB2YWx1
ZSBvZiAwIGluZGljYXRlcyB0aGF0IEdQVSByZXNldCBpc24ndCByZWFkeSB0byBiZQplbmFibGVk
IGJ5IGRlZmF1bHQuIFRoYXQncyB3aGF0IGl0IG1lYW5zLiBPbmNlIHRoZSBHUFUgcmVzZXQgd29y
a3MsCnRoZSBkZWZhdWx0IHNob3VsZCBiZSBub24temVybyAoZS5nLiAxMDAwMCkgYW5kCmFtZGdw
dS5sb2NrdXBfdGltZW91dD0wIHNob3VsZCBiZSB1c2VkIHRvIGRpc2FibGUgYWxsIEdQVSByZXNl
dHMgaW4Kb3JkZXIgdG8gYmUgYWJsZSBkbyBzY2FuZHVtcHMgYW5kIGRlYnVnIEdQVSBoYW5ncy4K
Ck1hcmVrCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
