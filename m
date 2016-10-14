From: Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: used cached gca values for
 vi_read_register
Date: Fri, 14 Oct 2016 10:02:43 +0100
Message-ID: <58009F33.9090003@gmail.com>
References: <1476115696-29640-1-git-send-email-alexander.deucher@amd.com>
 <1476115696-29640-4-git-send-email-alexander.deucher@amd.com>
 <57FCD5F9.6050809@gmail.com>
 <CY4PR12MB1768837F1247030A2662183EF7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <BN6PR12MB17643865565D007D3629FDADF7DA0@BN6PR12MB1764.namprd12.prod.outlook.com>
 <57FCE4DB.5020404@gmail.com>
 <CY4PR12MB1768C25486E504D61CBD8C24F7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <CY4PR12MB176874BB07B5252C2279D724F7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <57FD7A3E.5030501@gmail.com>
 <CADnq5_MOQ2_B-wKfNxpeNV0cP=qUzh_c7=znc2ZsdQYpLRLC6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_MOQ2_B-wKfNxpeNV0cP=qUzh_c7=znc2ZsdQYpLRLC6g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QWxleCBEZXVjaGVyIHdyb3RlOgo+IE9uIFR1ZSwgT2N0IDExLCAyMDE2IGF0IDc6NDggUE0sIEFu
ZHkgRnVybmlzcyA8YWRmLmxpc3RzQGdtYWlsLmNvbT4gd3JvdGU6Cj4+IFRoZSBib290IHZjZS91
dmQgaXNzdWUgaXMgZml4ZWQgaW4gNC45LXdpcCBub3csIHNvIEkgY2FuIGJvb3QgbGF0ZXN0IGJ1
dCAtCj4+Cj4+IFRoZSBzZWdmYXVsdCBvbiBzdGFydHggaXMgc3RpbGwgdGhlcmUuCj4KPiBGaXhl
ZCBpbiB2Mi4KClllYSwgYWxsIE9LIG5vdy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
