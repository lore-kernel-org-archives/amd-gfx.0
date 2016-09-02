From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: prevent command submission failures under
 memory pressure
Date: Fri, 2 Sep 2016 12:33:31 +0200
Message-ID: <CAAxE2A5y=_ScZnroNY5OwhOqctQHMgh4mKO92wMSqbo0vh-mtg@mail.gmail.com>
References: <1472739370-6579-1-git-send-email-deathsimple@vodafone.de>
 <1472739370-6579-2-git-send-email-deathsimple@vodafone.de>
 <MWHPR12MB16940502B576609723CEDD53F7E20@MWHPR12MB1694.namprd12.prod.outlook.com>
 <201fce63-7708-ef92-5ec0-9dae006f2367@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <201fce63-7708-ef92-5ec0-9dae006f2367-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Olsak,
 Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCBTZXAgMiwgMjAxNiBhdCA5OjM4IEFNLCBDaHJpc3RpYW4gS8O2bmlnIDxkZWF0aHNp
bXBsZUB2b2RhZm9uZS5kZT4gd3JvdGU6Cj4gQW0gMDEuMDkuMjAxNiB1bSAxNjozMyBzY2hyaWVi
IERldWNoZXIsIEFsZXhhbmRlcjoKPgo+PiByZXR1cm4gcjsgPiArID4gKyByZXR1cm4gLUVOT01F
TTsgPiArfQo+Cj4gVW5yZWFjaGFibGUgY29kZS4gT3RoZXIgdGhhbiB0aGF0IGxvb2tzIGdvb2Qu
Cj4KPgo+IFVwcywgaW5kZWVkIGp1c3QgYSBtZXJnZSBlcnJvci4KPgo+IFdpdGggdGhhdCBmaXhl
ZDogUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
Pgo+IFRoYW5rcyBmb3IgdGhlIHJldmlldywgSSd2ZSBqdXN0IHB1c2hlZCB0aGUgcmVzdWx0aW5n
IHBhdGNoZXMgdG8KPiBhbWQtc3RhZ2luZy00LjYuCj4KPiBNYXJlayB5b3UgbWlnaHQgd2FudCB0
byB0cnkgYW5kIHJhaXNlIHRoZSBsaW1pdHMgbm93IGhvdyBtdWNoIFZSQU0gY2FuIGJlCj4gdXNl
ZCBieSBhIHNpbmdsZSBjb21tYW5kIHN1Ym1pc3Npb24uIElmIEkgcmVtZW1iZXIgY29ycmVjdGx5
IHRoYXQgd2FzIHJhdGhlcgo+IGNvbnNlcnZhdGl2ZWx5LgoKSSB3b3VsZCBiZWcgdG8gZGlmZmVy
LiBKdXN0IHRvIHNpbXBsaWZ5IHRoZSBjYWxjdWxhdGlvbiwgbGV0J3MgYXNzdW1lCnRoZXJlIGFy
ZSBub3QgYWxsb2NhdGlvbnMgaW4gR1RUIChpbiBwcmFjdGljZSB0aGVyZSBhcmUgdmVyeSBmZXcs
IHNvCml0J3MgdmVyeSBjbG9zZSB0byB0aGUgcmVhbGl0eSkuIElmIHlvdSB0YWtlIHRoZSBtZW1v
cnkgdXNlZCBieSBhbGwKVlJBTSBidWZmZXJzIGluIENTLCB0aGUgbGltaXQgZm9yIHRoYXQgaXMg
IlZSQU0gc2l6ZSArIChHVFQgc2l6ZSAqCjAuNykiLgoKSWYgeW91IGhhdmUgNEdCIFZSQU0gYW5k
IDRHQiBHVFQsIE1lc2EgYWxsb3dzIHBlci1DUyBWUkFNIHVzYWdlIHRvIGJlIDYuOCBHQi4KCklm
IHlvdSBoYXZlIGFueSBHVFQgYnVmZmVycyB0aGVyZSwgeW91IGp1c3Qgc3VidHJhY3QgZnJvbSB0
aGF0LiBGb3IKZXhhbXBsZSwgaWYgeW91IGhhdmUgMTAwTUIgR1RUIHVzYWdlLCB0aGUgVlJBTSBs
aW1pdCBpcyA2LjcgR0IuCgpEb2VzIHRoYXQgc291bmQgY29uc2VydmF0aXZlIHRvIHlvdT8KCkNv
ZGU6Cmh0dHBzOi8vY2dpdC5mcmVlZGVza3RvcC5vcmcvbWVzYS9tZXNhL3RyZWUvc3JjL2dhbGxp
dW0vZHJpdmVycy9yYWRlb24vcjYwMF9jcy5oI24zNgoKTWFyZWsKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
