From: Mikhail Gavrilov via amd-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: "ring gfx timeout" with Vega 64 on mesa 19.0.0-rc2 and kernel
 5.0.0-rc6 (GPU reset still not works)
Date: Tue, 12 Feb 2019 20:49:53 +0500
Message-ID: <CABXGCsMMOx+Ay7Dkjfy1bKcvnsqEE0v2XnZzLNVM3ygM4G2PWg@mail.gmail.com>
References: <CABXGCsOakru4=RMrhpocLhN99LwKp4q1-UfFJrEUh7q4UeKJ_g@mail.gmail.com>
 <47477f0a-76dd-2f33-ff38-01f8216cffcc@amd.com>
Reply-To: Mikhail Gavrilov <mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <47477f0a-76dd-2f33-ff38-01f8216cffcc-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVHVlLCAxMiBGZWIgMjAxOSBhdCAyMDoyMywgR3JvZHpvdnNreSwgQW5kcmV5CjxBbmRyZXku
R3JvZHpvdnNreUBhbWQuY29tPiB3cm90ZToKPgo+IEl0IHNob3VsZCByZWNvdmVyIHlvdSAtIHNv
IHRoaXMgbG9va3MgbGlrZSBhIGJ1Zy4gSSBub3RpY2VkIGluIG9uZSBvZgo+IHRoZSBjYWxsIHRy
YWNlcyB0aGlzIC0gZHJtX2F0b21pY19oZWxwZXJfc3VzcGVuZCB3aGljaCBwb2ludHMgdG8gc3lz
dGVtCj4gZ29pbmcgaW50byBzbGVlcCBtb2RlLCBpcyBpdCB3aGF0IGhhcHBlbmVkLCBkaWQgaXQg
aGFuZyB3aGVuIHN5c3RlbQo+IHRyaWVkIHRvIHNsZWVwID8KPgoKSXQncyB3ZWlyZCBiZWNhdXNl
IHRoZSBjb21wdXRlciB3YXMgbm90IGVudGVyIGluIHNsZWVwIG1vZGUuIEkgYW0gc3VyZS4KU3Rl
cHMgZm9yIHJlcHJvZHVjZToKMS4gTGF1bmNoIFNoYWRvdyBvZiBUaGUgdG9tYiBSaWRlciBvbiBQ
cm90b24KMi4gV2FpdCBzb21lIHRpbWUgdW50aWwgbW91c2Ugc3RvcCByZXNwb25kCjMuIER1bXAg
Z2Z4LCB3YXZlcyBhbmQgYWxsIG90aGVyIGR1bXBzIGluY2x1ZGluZyBkbWVzZwoKQW5kIG9mIGNv
dXJzZSB0aGUgcG93ZXIgYnV0dG9uIChidXR0b24gd2hpY2ggZW50ZXIgaW4gc2xlZXAgbW9kZSkg
d2FzCm5vdCBwcmVzc2VkLgoKU28gdGhlIG5ldyBkdW1wcyBoYXMgYW55IG5ldyB1c2VmdWwgaW5m
bz8gT3IgdGhleSBhcmUgcG9pbnRsZXNzPwotLQpCZXN0IFJlZ2FyZHMsCk1pa2UgR2F2cmlsb3Yu
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
