From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 00/15] drm/amdgpu/si: Make SI DPM workable
Date: Tue, 6 Sep 2016 16:16:51 +0800
Message-ID: <20160906081650.GA6111@hr-amur2>
References: <1472621007-17578-1-git-send-email-ray.huang@amd.com>
 <CAAxE2A6D3hAP1D3i0py3G4erMGNq8-5LjypVA_PnEQQSUjEshQ@mail.gmail.com>
 <20160906023553.GA5814@hr-amur2>
 <CAAxE2A46-75NBq1Bn0o6-EsmsRS6yYOqacfL973SSSVexgwPpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAxE2A46-75NBq1Bn0o6-EsmsRS6yYOqacfL973SSSVexgwPpA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Marek =?utf-8?B?T2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Yu,
 Hui" <Hui.Yu-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wang,
 Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

T24gVHVlLCBTZXAgMDYsIDIwMTYgYXQgMDQ6MDQ6MTBQTSArMDgwMCwgTWFyZWsgT2zFocOhayB3
cm90ZToKPiBPbiBUdWUsIFNlcCA2LCAyMDE2IGF0IDQ6MzUgQU0sIEh1YW5nIFJ1aSA8cmF5Lmh1
YW5nQGFtZC5jb20+IHdyb3RlOgo+ID4gT24gVHVlLCBTZXAgMDYsIDIwMTYgYXQgMDM6MzE6NDZB
TSArMDgwMCwgTWFyZWsgT2zFocOhayB3cm90ZToKPiA+PiBIaSBSdWksCj4gPj4KPiA+PiBEbyB5
b3UgaGF2ZSBUYWhpdGkgTEUgaW4gdGhlIG9mZmljZT8gSXQgbWlnaHQgYmUgd29ydGggdGVzdGlu
ZyBpdCB0bwo+ID4+IHNlZSBpZiBpdCB3b3Jrcy4gVGhlcmUgd2VyZSBzb21lIGlzc3VlcyB3aXRo
IGl0IGluIHRoZSBwYXN0Lgo+ID4+Cj4gPgo+ID4gSSB1c2VkIFRhaGl0aSBYVCBbRGV2aWNlIElE
IDY3OThdLCBkbyB5b3Uga25vdyB0aGUgZGV2aWNlIGlkIG9mIFRhaGl0aSBMRT8KPiAKPiBObywg
SSBvbmx5IGtub3cgdGhhdCBUYWhpdGkgTEUgaXMgUmFkZW9uIEhEIDc4NzAgWFQuIEl0IHdhcyBt
YWRlIGJ5Cj4gU2FwcGhpcmUgYW5kIFBvd2VyY29sb3IuCj4gCgpPSywgbXkgY2FyZCBpcyBSYWRl
b24gSEQgNzk3MCBYVC4gSXQgd29ya3Mgd2VsbC4gRG8geW91IGtub3cgd2hhdCBraW5kIG9mCmlz
c3VlcywgYW55bW9yZSBpbmZvPwoKVGhhbmtzLApSdWkKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
