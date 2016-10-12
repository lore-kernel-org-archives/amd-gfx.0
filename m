From: Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: used cached gca values for
 vi_read_register
Date: Wed, 12 Oct 2016 15:36:29 +0100
Message-ID: <57FE4A6D.1000003@gmail.com>
References: <1476115696-29640-1-git-send-email-alexander.deucher@amd.com>
 <1476115696-29640-4-git-send-email-alexander.deucher@amd.com>
 <57FCD5F9.6050809@gmail.com>
 <CY4PR12MB1768837F1247030A2662183EF7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <BN6PR12MB17643865565D007D3629FDADF7DA0@BN6PR12MB1764.namprd12.prod.outlook.com>
 <57FCE4DB.5020404@gmail.com>
 <CY4PR12MB1768C25486E504D61CBD8C24F7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <CY4PR12MB176874BB07B5252C2279D724F7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <57FD7A3E.5030501@gmail.com>
 <CANOLnOP-r1R8uGchUHsL=G1KG70LAd2kj11vOW2_-kgTgr3Vuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CANOLnOP-r1R8uGchUHsL=G1KG70LAd2kj11vOW2_-kgTgr3Vuw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

R3JhenZ5ZGFzIElnbm90YXMgd3JvdGU6Cj4gT24gV2VkLCBPY3QgMTIsIDIwMTYgYXQgMjo0OCBB
TSwgQW5keSBGdXJuaXNzIDxhZGYubGlzdHNAZ21haWwuY29tPiB3cm90ZToKPj4KPj4gSSBzdGls
bCBjYW4ndCBzaHV0ZG93bi9yZWJvb3QKPj4gYXMgaW4gaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9w
Lm9yZy9zaG93X2J1Zy5jZ2k/aWQ9OTgyMDAKPj4gd2hpY2ggaXMgZml4ZWQgZm9yIHJhZGVvbiwg
YnV0IGFwcGFyZW50bHkgbm90IChmb3IgbWUgYXQgbGVhc3QpIHdpdGggYW1kZ3B1Lgo+Cj4gWW91
IHByb2JhYmx5IG5lZWQgYTk1MWVkODVhYmQ0NiB0aGF0IHdlbnQgdG8gNC44LWZpeGVzIGFuZCBp
cyBub3QgcGFydAo+IG9mIDQuOS13aXAuCgpUaGFua3MsIGl0J3MgT0sgd2l0aCB0aGF0LgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
