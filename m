From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2 00/15] drm/amdgpu/si: Make SI DPM workable
Date: Tue, 6 Sep 2016 17:33:42 +0900
Message-ID: <4008603d-6ab6-1124-bfe8-b34898f64a08@daenzer.net>
References: <1472621007-17578-1-git-send-email-ray.huang@amd.com>
 <CAAxE2A6D3hAP1D3i0py3G4erMGNq8-5LjypVA_PnEQQSUjEshQ@mail.gmail.com>
 <20160906023553.GA5814@hr-amur2>
 <CAAxE2A46-75NBq1Bn0o6-EsmsRS6yYOqacfL973SSSVexgwPpA@mail.gmail.com>
 <20160906081650.GA6111@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160906081650.GA6111@hr-amur2>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Yu,
 Hui" <Hui.Yu-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wang,
 Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

T24gMDYvMDkvMTYgMDU6MTYgUE0sIEh1YW5nIFJ1aSB3cm90ZToKPiBPbiBUdWUsIFNlcCAwNiwg
MjAxNiBhdCAwNDowNDoxMFBNICswODAwLCBNYXJlayBPbMWhw6FrIHdyb3RlOgo+PiBPbiBUdWUs
IFNlcCA2LCAyMDE2IGF0IDQ6MzUgQU0sIEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+IHdy
b3RlOgo+Pj4gT24gVHVlLCBTZXAgMDYsIDIwMTYgYXQgMDM6MzE6NDZBTSArMDgwMCwgTWFyZWsg
T2zFocOhayB3cm90ZToKPj4+PiBIaSBSdWksCj4+Pj4KPj4+PiBEbyB5b3UgaGF2ZSBUYWhpdGkg
TEUgaW4gdGhlIG9mZmljZT8gSXQgbWlnaHQgYmUgd29ydGggdGVzdGluZyBpdCB0bwo+Pj4+IHNl
ZSBpZiBpdCB3b3Jrcy4gVGhlcmUgd2VyZSBzb21lIGlzc3VlcyB3aXRoIGl0IGluIHRoZSBwYXN0
Lgo+Pj4+Cj4+Pgo+Pj4gSSB1c2VkIFRhaGl0aSBYVCBbRGV2aWNlIElEIDY3OThdLCBkbyB5b3Ug
a25vdyB0aGUgZGV2aWNlIGlkIG9mIFRhaGl0aSBMRT8KPj4KPj4gTm8sIEkgb25seSBrbm93IHRo
YXQgVGFoaXRpIExFIGlzIFJhZGVvbiBIRCA3ODcwIFhULiBJdCB3YXMgbWFkZSBieQo+PiBTYXBw
aGlyZSBhbmQgUG93ZXJjb2xvci4KPj4KPiAKPiBPSywgbXkgY2FyZCBpcyBSYWRlb24gSEQgNzk3
MCBYVC4gSXQgd29ya3Mgd2VsbC4gRG8geW91IGtub3cgd2hhdCBraW5kIG9mCj4gaXNzdWVzLCBh
bnltb3JlIGluZm8/CgpTZWUgaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5j
Z2k/aWQ9NjA4NzkgLiBUaGUgUENJIElEIGlzCjB4Njc5ZS4KCgotLSAKRWFydGhsaW5nIE1pY2hl
bCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNv
bQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVz
YSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
