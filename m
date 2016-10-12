From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: used cached gca values for
 vi_read_register
Date: Wed, 12 Oct 2016 13:00:09 +0300
Message-ID: <CANOLnOP-r1R8uGchUHsL=G1KG70LAd2kj11vOW2_-kgTgr3Vuw@mail.gmail.com>
References: <1476115696-29640-1-git-send-email-alexander.deucher@amd.com>
 <1476115696-29640-4-git-send-email-alexander.deucher@amd.com>
 <57FCD5F9.6050809@gmail.com>
 <CY4PR12MB1768837F1247030A2662183EF7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <BN6PR12MB17643865565D007D3629FDADF7DA0@BN6PR12MB1764.namprd12.prod.outlook.com>
 <57FCE4DB.5020404@gmail.com>
 <CY4PR12MB1768C25486E504D61CBD8C24F7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <CY4PR12MB176874BB07B5252C2279D724F7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <57FD7A3E.5030501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <57FD7A3E.5030501-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gV2VkLCBPY3QgMTIsIDIwMTYgYXQgMjo0OCBBTSwgQW5keSBGdXJuaXNzIDxhZGYubGlzdHNA
Z21haWwuY29tPiB3cm90ZToKPgo+IEkgc3RpbGwgY2FuJ3Qgc2h1dGRvd24vcmVib290Cj4gYXMg
aW4gaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9OTgyMDAKPiB3
aGljaCBpcyBmaXhlZCBmb3IgcmFkZW9uLCBidXQgYXBwYXJlbnRseSBub3QgKGZvciBtZSBhdCBs
ZWFzdCkgd2l0aCBhbWRncHUuCgpZb3UgcHJvYmFibHkgbmVlZCBhOTUxZWQ4NWFiZDQ2IHRoYXQg
d2VudCB0byA0LjgtZml4ZXMgYW5kIGlzIG5vdCBwYXJ0Cm9mIDQuOS13aXAuCgpHcmHFvnZ5ZGFz
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
