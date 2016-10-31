From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: cleanup amdgpu_cs_ioctl to make code
 logicality clear
Date: Mon, 31 Oct 2016 16:58:07 +0800
Message-ID: <20161031085807.GA3927@hr-amur2>
References: <1477879680-21488-1-git-send-email-ray.huang@amd.com>
 <54bf14e1-8a3c-2710-df52-0f9d82f91a90@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54bf14e1-8a3c-2710-df52-0f9d82f91a90-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCBPY3QgMzEsIDIwMTYgYXQgMDM6NTM6NTJQTSArMDgwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAzMS4xMC4yMDE2IHVtIDAzOjA4IHNjaHJpZWIgSHVhbmcgUnVpOgo+ID4g
U2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPiAKPiBMb29rcyBn
b29kIHRvIG1lLCBwYXRjaCBpcyBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyAKPiA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KPiAKPiBCVFc6IGFtZGdwdV9jc19oYW5kbGVfbG9ja3Vw
KCkgaXMgYSBsZWZ0b3ZlciBmcm9tIHJhZGVvbiBhbmQgY2FuIGJlIAo+IHJlbW92ZWQuIFdvdWxk
IGJlIG5pY2UgaWYgeW91IGNhbiB0YWtlIGNhcmUgb2YgdGhpcyBhcyB3ZWxsLgo+IAoKU3VyZS4g
YW1kZ3B1X2NzX2hhbmRsZV9sb2NrdXAgYWN0dWFsbHkgd2lsbCB0cmlnZ2VyIGEgZ3B1IHJlc2V0
IHdoZW4gciA9PQotRURFQURMSy4gSSdtIG5vdCB2ZXJ5IGNsZWFyIHdpdGggd2h5IHdlIG5lZWRu
J3QgZ3B1IHJlc2V0IG9uIHRoYXQgY2FzZQp5ZXQsIGNvdWxkIHlvdSBleHBsYWluPwoKVGhhbmtz
LApSdWkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
