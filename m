From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Autodetect libdrm path (v2)
Date: Wed, 8 Feb 2017 09:48:40 +0900
Message-ID: <bffcd08d-4855-4d98-84f8-192b9bd8e8c7@daenzer.net>
References: <20170205222447.19945-1-tom.stdenis@amd.com>
 <CACvgo5230Use5sk8dm5jBbLqiJeSkgB6cDikz-N4omx-4Jgy9A@mail.gmail.com>
 <CY4PR12MB17689AEC15DEF9662A16DEA3F7400@CY4PR12MB1768.namprd12.prod.outlook.com>
 <CY4PR12MB1768AED537A0253EB70B1E4BF7400@CY4PR12MB1768.namprd12.prod.outlook.com>
 <CACvgo537ciLvg=Q6enktu6ndMSEuSCM+RpmniJdgYNgZDQjUeQ@mail.gmail.com>
 <13f9479c-1a5c-8887-858e-dadf819a7140@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <13f9479c-1a5c-8887-858e-dadf819a7140-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMDcvMDIvMTcgMDg6MzAgUE0sIFRvbSBTdCBEZW5pcyB3cm90ZToKPiBPbiAwNy8wMi8xNyAw
NjowMiBBTSwgRW1pbCBWZWxpa292IHdyb3RlOgo+PiBPbiA2IEZlYnJ1YXJ5IDIwMTcgYXQgMjI6
MzksIFN0RGVuaXMsIFRvbSA8VG9tLlN0RGVuaXNAYW1kLmNvbT4gd3JvdGU6Cj4+Pgo+Pj4gQXBw
YXJlbnRseSBJIG1pc3NlZCB0aGUgYm90dG9tIG9mIHlvdXIgcmVwbHkgKGFsbCBvZiB0aGUgY2xp
ZW50cyBJCj4+PiBoYXZlIG91dGxvb2svZ21haWwgZG8gdG9wIHBvc3Qgb25seSAuLi4pCj4+IEJv
dGggT3V0bG9vayBhbmQgR21haWwgY2FuIGRvIGlubGluZSByZXBsaWVzIGFuZCBwbGFpbiB0ZXh0
LiBUaGVyZQo+PiBtaWdodCBiZSBzb21lIG1hZ2ljIHJlcXVpcmVkIGZvciB0aGUgZm9ybWVyIHRo
b3VnaCA6LVwKPj4gSSB3b3VsZCBraW5kbHkgc3VnZ2VzdCB1c2luZyBpbmxpbmUvdGV4dCB3aGVu
IHBvc3NpYmxlLgo+IAo+IFlvdSdsbCBiZSBwbGVhc2VkIHRvIG5vdGUgSSBkaXNjb3ZlcmVkIChh
dCBzb21lIHBvaW50KSB0aGF0IEFNRCBoYXMKPiByZS1lbmFibGVkIGltYXAgc3VwcG9ydAoKRldJ
VywgSSd2ZSBhbHdheXMgdXNlZCBJTUFQIGZvciBBTUQgZS1tYWlsLCBpdCB3YXMgbmV2ZXIgZGlz
YWJsZWQgcGVyIHNlLgoKCj4gYW5kIEkgY2FuIG5vdyB1c2UgYSBtb3JlIHNlbnNpYmxlIGNsaWVu
dC4uLgo+IAo+IDotKQoKQW55d2F5LCB0aGF0J3MgZ3JlYXQuCgoKLS0gCkVhcnRobGluZyBNaWNo
ZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5j
b20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1l
c2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
