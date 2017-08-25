From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Add sysfs file for VBIOS
Date: Fri, 25 Aug 2017 08:57:52 -0400
Message-ID: <22c4b9e2-67e2-bd0a-1147-6e896843783e@amd.com>
References: <1503511940-645-1-git-send-email-kent.russell@amd.com>
 <1e64a642-411e-ea58-1639-390e4c3cd75d@vodafone.de>
 <BN6PR1201MB01801A32C06AE0DA6634F440859A0@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <CADnq5_PD3s8HHPtr49ZJ3DXPVXgP5xyvFZj_YTzsGCi=cnOUKA@mail.gmail.com>
 <BN6PR1201MB018010027CA78E203F629BA7859A0@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <DM5PR1201MB023503F29269CEC80DC7DAD8929A0@DM5PR1201MB0235.namprd12.prod.outlook.com>
 <CADnq5_Piyp7mtHi+4GZ0pUw1kMNT68ZVyA6jp1TR4VhbCjWAOA@mail.gmail.com>
 <BN6PR1201MB01804846B5629D28766FDFA0859A0@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <fa2dddb4-5ceb-87f3-6305-fb5f6e6e5c2d@vodafone.de>
 <BN6PR1201MB0180502DC4720A3C33D642DB859A0@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <4cec0dad-502e-68f2-68c9-b5d0103d7093@amd.com>
 <BN6PR1201MB01803DD5EBD0049397F4E9F0859B0@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <0a3d4d07-e3cd-6216-466b-30bc60c8a26a@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0a3d4d07-e3cd-6216-466b-30bc60c8a26a-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjUvMDgvMTcgMDg6NTYgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gSGkgS2VudCwK
PiAKPiBhZ3JlZSBvbiB0aGUgVkJJT1MgZHVtcCBmaWxlLCB0aGF0IGNsZWFybHkgYmVsb25ncyB0
byBkZWJ1Z3NmLgo+IAo+IFRoZSBwb3dlciB1c2FnZSBzdHVmZiBJIGNhbid0IHNheSBtdWNoIGFi
b3V0IGNhdXNlIEknbSBub3QgZGVlcGx5IGludG8gCj4gdGhpcywgYnV0IGtlZXAgaW4gbWluZCB0
aGUgcmVzdHJpY3Rpb24gZm9yIHN5c2ZzOgo+IDEuIEl0J3MgYSBzdGFibGUgaW50ZXJmYWNlLiBT
byBpdCBtdXN0IGJlIHZlcnkgd2VsbCBkZXNpZ25lZC4KPiAyLiBPbmx5IG9uZSB2YWx1ZSBwZXIg
ZmlsZS4gSSB0aGluayB0aGUgcG93ZXIgc3R1ZmYgZG9lc24ndCBmdWxmaWxsIHRoYXQgCj4gcmVx
dWlyZW1lbnQgYXQgdGhlIG1vbWVudC4KCldoYXQgInBvd2VyIiBzdHVmZiBhcmUgd2UgdGFsa2lu
ZyBhYm91dD8gIFRoZSBzZW5zb3JzIGludGVyZmFjZSBvciB0aGUgCnBtX2luZm8gb3Igc29tZXRo
aW5nIGVsc2U/CgpLZWVwIGluIG1pbmQgdW1yIHVzZXMgdGhlIHNlbnNvcnMgZGVidWdmcyBmaWxl
IGluIC0tdG9wIG1vZGUuCgpUb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
