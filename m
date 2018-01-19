From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: lock/unlock mismatch in ttm_bo.c
Date: Fri, 19 Jan 2018 13:23:18 -0500
Message-ID: <81e40cdf-6869-57fa-6858-eb77dbfb45a8@amd.com>
References: <1713476e-c17f-9eea-ebd3-6999c760b678@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1713476e-c17f-9eea-ebd3-6999c760b678-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTkvMDEvMTggMDE6MTQgUE0sIFRvbSBTdCBEZW5pcyB3cm90ZToKPiBIaSBhbGwsCj4gCj4g
SW4gdGhlIGZ1bmN0aW9uIHR0bV9ib19jbGVhbnVwX3JlZnMoKSBpdCBzZWVtcyBwb3NzaWJsZSB0
byBnZXQgdG8gbGluZSAKPiA1NTEgd2l0aG91dCBlbnRlcmluZyB0aGUgYmxvY2sgb24gNTE2IHdo
aWNoIG1lYW5zIHlvdSdsbCBiZSB1bmxvY2tpbmcgYSAKPiBtdXRleCB0aGF0IHdhc24ndCBsb2Nr
ZWQuCj4gCj4gTm93IGl0IG1pZ2h0IGJlIHRoYXQgaW4gdGhlIGNvdXJzZSBvZiB0aGUgQVBJIHRo
aXMgcGF0dGVybiBjYW5ub3QgYmUgCj4gZXhwcmVzc2VkIGJ1dCBpdCdzIG5vdCBjbGVhciBmcm9t
IHRoZSBmdW5jdGlvbiBhbG9uZSB0aGF0IHRoYXQgaXMgdGhlIGNhc2UuCgoKTG9va2luZyBmdXJ0
aGVyIGl0IHNlZW1zIHRoZSBiZWhhdmlvdXIgZGVwZW5kcyBvbiBsb2NraW5nIGluIHBhcmVudCAK
Y2FsbGVycy4gIFRoYXQncyBraW5kYSBhIG5vLW5vIHJpZ2h0PyAgU2hvdWxkbid0IHRoZSBsb2Nr
IGJlIAp0YWtlbi9yZWxlYXNlZCBpbiB0aGUgc2FtZSBmdW5jdGlvbiBpZGVhbGx5PwoKKGFsc28g
dGhlcmUgYXJlIGEgaGFuZGZ1bCBvZiBzdHlsZSBpc3N1ZXMgSSdsbCB3cml0ZSB1cCBzb21lIHBh
dGNoZXMgZm9yIApvbiBNb25kYXkgOi0pKS4KCkNoZWVycywKVG9tCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
