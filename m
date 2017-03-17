From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/sched: add schuduling policy
Date: Fri, 17 Mar 2017 12:30:18 +0900
Message-ID: <ef15805d-c832-e5c7-b253-642085218365@daenzer.net>
References: <1489654849-6031-1-git-send-email-David1.Zhou@amd.com>
 <1489654849-6031-3-git-send-email-David1.Zhou@amd.com>
 <ad692555-8641-2ec7-f90e-eee0e8b97c2c@amd.com> <58CA57B9.4000306@amd.com>
 <4c0f45fa-3f76-d33d-6cd0-83ba1d39a3f3@gmail.com>
 <f99a087f-d479-dcd1-8d00-bdd46df10eae@gmail.com>
 <0da11bd5-d21e-d059-2987-28d650d10463@vodafone.de>
 <55502bc2-c5d5-1636-5bd5-6c385746343a@gmail.com>
 <MWHPR1201MB0206DC9ED4550D01BE31DBAAB4390@MWHPR1201MB0206.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR1201MB0206DC9ED4550D01BE31DBAAB4390-3iK1xFAIwjrUF/YbdlDdgWrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTcvMDMvMTcgMTE6MzUgQU0sIFpob3UsIERhdmlkKENodW5NaW5nKSB3cm90ZToKPiBIaSBD
aHJpc3RpYW4sIEFuZHJlcywKPiAKPiBJIHVuZGVyc3RhbmQgeW91ciBtZWFuLCBlc3BlY2lhbGx5
IGhpZ2ggcHJpb3JpdHkgcXVldWUgZnJvbSBBbmRyZXMgaXMKPiBmb3IgVlIsIHdoaWNoIGlzIGxp
a2luZyBhbiBlbmdpbmUgdG8gaGltc2VsZiwgYnV0IG91ciBzY2hlZHVsZXIgaXMgYQo+IGdlbmVy
aWMgdGhpbmcsIHdoaWNoIGlzIHVzZWQgYnkgbXVsdGlwbGUgY2FzZS4gRnJvbSBzY2hlZHVsZXIK
PiBwZXJzcGVjdGl2ZSwgc2NoZWR1bGluZyBwb2xpY3kgaXMgcG9wdWxhciwgZS5nLiBDUFUgc2No
ZWR1bGVyLCBpdAo+IHByb3ZpZGVzIGRpZmZlcmVudCB0aW1lIHBpZWNlIGZvciBkaWZmZXJlbnQg
cHJpb3JpdHkgcXVldWUsIGhpZ2gKPiBwcmlvcml0eSBoYXMgbG9uZyB0aW1lIHRvIGV4ZWN1dGUs
IGxvdyBoYXMgc2hvcnQgdGltZSwgYnV0IGV2ZXJ5b25lCj4gaGFzIHRoZSBjaGFuY2UgdG8gcnVu
LCBqdXN0IHNvb25lciBvciBsYXRlci4KClRoZSBDUFUgc2NoZWR1bGVyIHN1cHBvcnRzIHRoZSBT
Q0hFRF9GSUZPIHNjaGVkdWxpbmcgcG9saWN5LCB3aGljaApkb2Vzbid0IHByZWVtcHQgYSBydW5u
aW5nIHByb2Nlc3MuIEl0J3Mgb25seSBhdmFpbGFibGUgdG8gcm9vdC4KCgotLSAKRWFydGhsaW5n
IE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cu
YW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
