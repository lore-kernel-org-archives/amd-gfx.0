From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] Revert "drm/amdgpu: Add an ATPX quirk for hybrid
 laptop"
Date: Mon, 4 Jun 2018 15:13:26 +0800
Message-ID: <20180604071325.GA4835@hr-amur2>
References: <20180524194636.30588-1-alexander.deucher@amd.com>
 <20180601030732.GB19859@hr-amur2>
 <CADnq5_NZ0H4Qmj=d9_nRZYRcT+yaCKwi004YCsAzzgOQRtMX8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CADnq5_NZ0H4Qmj=d9_nRZYRcT+yaCKwi004YCsAzzgOQRtMX8w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, prike.liang-5C7GfCeVMHo@public.gmane.org, kevin1.wang-5C7GfCeVMHo@public.gmane.org, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCBKdW4gMDEsIDIwMTggYXQgMTA6Mzc6MzNQTSArMDgwMCwgQWxleCBEZXVjaGVyIHdy
b3RlOgo+IE9uIFRodSwgTWF5IDMxLCAyMDE4IGF0IDExOjA3IFBNLCBIdWFuZyBSdWkgPHJheS5o
dWFuZ0BhbWQuY29tPiB3cm90ZToKPiA+IE9uIFRodSwgTWF5IDI0LCAyMDE4IGF0IDAyOjQ2OjM0
UE0gLTA1MDAsIEFsZXggRGV1Y2hlciB3cm90ZToKPiA+PiBUaGlzIHJldmVydHMgY29tbWl0IDEz
YjQwOTM1Y2Y2NGY1OWI5M2NmMWM3MTZhMjAzMzQ4OGU1YTIyOGMuCj4gPj4KPiA+PiBUaGlzIHdh
cyBhIHdvcmthcm91bmQgZm9yIGEgYnVnIGluIHRoZSBIREEgZHJpdmVyIHRoYXQgcHJldmVudGVk
Cj4gPj4gdGhlIEhEQSBhdWRpbyBjaGlwIGZyb20gZ29pbmcgaW50byBydW50aW1lIHBtIHdoaWNo
IHByZXZlbnRlZAo+ID4+IHRoZSBHUFUgZnJvbSBnb2luZyBpbnRvIHJ1bnRpbWUgcG0uCj4gPj4K
PiA+PiBCdWc6IGh0dHBzOi8vYnVncy5mcmVlZGVza3RvcC5vcmcvc2hvd19idWcuY2dpP2lkPTEw
NjU5Nwo+ID4+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KPiA+Cj4gPiBGb3Igc2VyaWVzIGFyZSwKPiA+IFJldmlld2VkLWJ5OiBIdWFuZyBS
dWkgPHJheS5odWFuZ0BhbWQuY29tPgo+IAo+IEp1c3QgYSBoZWFkcyB1cCwgdGhlc2UgcGF0Y2hl
cyBzaG91bGRuJ3QgZ28gaW50byB0aGUgZGttcyBicmFuY2hlcwo+IHVudGlsIGRpc3Ryb3MgcGlj
ayB1cCB0aGlzIHBhdGNoOgo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTAwOWY4YzkwZjU3MWQ4Nzg1
NTkxNGRiYzIwZTZjMGVhMmEzYjE5YWUKPiAKClRoYW5rcyB0byByZW1pbmRlciEKCisgS2V2aW4g
YW5kIFByaWtlLCBwbGVhc2UgZG9uJ3QgY2hlcnJ5LXBpY2sgdGhlc2UgdGhyZWUgcGF0Y2hlcyBp
bnRvIGRrbXMKYnJhbmNoLgoKVGhhbmtzLApSYXkKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
