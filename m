From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix a typo
Date: Mon, 26 Jun 2017 05:48:59 +1000
Message-ID: <CAPM=9tzXrih9qpkOY+OGC1TF8nD0ZmwNnxXiRbMtcO7tR1-m1Q@mail.gmail.com>
References: <1498099356-31332-1-git-send-email-AlexBin.Xie@amd.com>
 <5ff65f82-9d15-4606-7e25-e4f75c172aed@vodafone.de>
 <DM5PR12MB1257B1FCC981D29A6D4045CDF2DB0@DM5PR12MB1257.namprd12.prod.outlook.com>
 <CAAxE2A7ic2YLmnkzM0Faa3bO9-GwWRTHRc0EUVej5UU7Yhs4Qg@mail.gmail.com>
 <efc2289a-382d-8443-8419-da2d0cadfd77@amd.com>
 <e23f64c3-6abf-ff65-2300-5c44d242f4df@amd.com>
 <CAAxE2A61KqM9gr=Zoo5PHFNb8gWp74RG9KOs=efWzf1dMKBwSA@mail.gmail.com>
 <7134d81f-a60f-7093-d2a3-70edde23cdb2@amd.com>
 <3436ae97-39b1-4a3f-bb73-2991adad5715@vodafone.de>
 <594CBEBC.5010703@amd.com> <0d847baf-8296-f3ce-7a8d-8823f33e392e@vodafone.de>
 <594CD8E0.3080702@amd.com> <594CDA92.1060809@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <594CDA92.1060809-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, axie <axie-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Xie,
 AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

PiBEbyB5b3Ugbm90IHVzZSBibyBsaXN0IGF0IGFsbCBpbiBtZXNhPyByYWR2IGFzIHdlbGw/CgpD
dXJyZW50bHkgcmFkdiBpcyBjcmVhdGluZyBhIGJvIGxpc3QgcGVyIGNvbW1hbmQgc3VibWlzc2lv
bi4gcmFkdiBkb2VzCm5vdCB1c2UgYW4gb2ZmbG9hZCB0aHJlYWQgdG8gZG8gY29tbWFuZCBzdWJt
aXNzaW9uLCBhcyBpdCBzZWVtcyBwcmV0dHkKdW4tdnVsa2FuIHRvIHVzZSBhIHRocmVhZCBmb3Ig
dGhlIHF1ZXVlIHN1Ym1pc3Npb24gdGhyZWFkIHRoZSBnYW1lCnVzZXMuCgpJIGhhdmUgY29uc2lk
ZXJlZCBpbnZlc3RpZ2F0aW5nIHRoaXMsIGJ1dCB3aXRoIHZ1bGthbiBpdCdzIHByb2JhYmx5Cm9w
dGltaXNpbmcgZm9yIHRoZSBzaW5nbGUgdGhyZWFkZWQgY2FzZSB3aGljaCBpc24ndCB3aGVyZSBh
cHBzIHNob3VsZApyZWFsbHkgYmUuCgpBdCB0aGUgbW9tZW50IHdlIHJlZ2VuZXJhdGUgdGhlIGJv
IGxpc3Qgb24gZXZlcnkgQ1MgaW9jdGwsIHdlIHByb2JhYmx5CmNhbiBkbyBhIGxvdCBiZXR0ZXIs
IEkga25vdyBCYXMgaGFzIGxvb2tlZCBpbnRvIHRoaXMgYXJlYSBhIGJpdCBtb3JlCnRoYW4gSS4K
CkRhdmUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
