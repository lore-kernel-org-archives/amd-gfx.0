From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/sriov: reject kms open if TDR not finished or
 failed
Date: Fri, 27 Apr 2018 10:22:57 +0200
Message-ID: <fc3f05cd-ed48-c04e-cfcb-59ed5ab224e2@daenzer.net>
References: <1524638384-31977-1-git-send-email-Emily.Deng@amd.com>
 <5bede6f6-24b2-8a3a-d3d8-9a37ac6d13c8@daenzer.net>
 <CY4PR12MB11254FFDBB4FCCF91CBDE9758F8E0@CY4PR12MB1125.namprd12.prod.outlook.com>
 <e7756d73-aa65-b351-2b1a-81ceea1e013f@daenzer.net>
 <CY4PR12MB112547536CD27B7FE2C330F38F8E0@CY4PR12MB1125.namprd12.prod.outlook.com>
 <9d56b1c3-1e51-f3f1-17d6-c1615dea0a05@daenzer.net>
 <CY4PR12MB1125653A73D8A22533FB3FBE8F8D0@CY4PR12MB1125.namprd12.prod.outlook.com>
 <77a5af30-0371-4816-fcf5-0bbcffa4395c@daenzer.net>
 <CY4PR12MB11253279D4404CF482FD7CF08F8D0@CY4PR12MB1125.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB11253279D4404CF482FD7CF08F8D0-rpdhrqHFk07v2MZdTKcfDgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-CA
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
To: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wNC0yNyAxMDoxNSBBTSwgRGVuZywgRW1pbHkgd3JvdGU6Cj4gTm8sIEkgbWVhbiBk
dXJpbmcgR1BVIHJlc2V0LCB0aGUgYXBwIHdpbGwgZmFpbCwgaXQgaXMgcmVhc29uYWJsZS4KCkkg
dW5kZXJzdGFuZCwgYnV0IEkgZG9uJ3QgYWdyZWUgdGhhdCBpdCdzIHJlYXNvbmFibGUuIDopCgoK
LS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAg
ICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAg
ICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
