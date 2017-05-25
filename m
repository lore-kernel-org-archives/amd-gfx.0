From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/1] amdgpu: move asic id table to a separate file
Date: Thu, 25 May 2017 12:23:54 +0900
Message-ID: <04a6fa8c-1e0f-825d-c3b2-6164015211b0@daenzer.net>
References: <1494449815-10162-1-git-send-email-Samuel.Li@amd.com>
 <DM3PR1201MB10392013EC4407011C4F9B84F5EC0@DM3PR1201MB1039.namprd12.prod.outlook.com>
 <fcbc7ab9-f5f7-c529-9526-d78772c0d830@daenzer.net>
 <CY1PR1201MB1033C872BA2CF7916ED3A369F5ED0@CY1PR1201MB1033.namprd12.prod.outlook.com>
 <1bdcfa4a-6840-796e-1623-2949358a0364@daenzer.net>
 <BN6PR12MB1652CDB93556D5F485159606F7F90@BN6PR12MB1652.namprd12.prod.outlook.com>
 <CY1PR1201MB1033945340C5C5170756A4FAF5FE0@CY1PR1201MB1033.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY1PR1201MB1033945340C5C5170756A4FAF5FE0-JBJ/M6OpXY+2VhmsawAdvGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

T24gMjUvMDUvMTcgMTI6MTAgQU0sIExpLCBTYW11ZWwgd3JvdGU6Cj4+IFRoZXJlJ3Mgbm8gbmVl
ZCBmb3IgYSBzZXBhcmF0ZSByZXBvIHVwc3RyZWFtLiAgSXQncyBwdXJlbHkgdG8gYWlkCj4+IGlu
dGVybmFsIHBhY2thZ2luZy4KPiBBcyBhIGZpcnN0IHN0ZXAsIHdlIGNhbiBwdXQgYSBzbmFwc2hv
dCBpbiBsaWJkcm0gZm9yIG5vdy4gRXh0ZXJuYWwKPiBwYWNrYWdpbmcgIHdpbGwgZmFjZSB0aGUg
c2FtZSBpc3N1ZSB0aG91Z2ggLi4uIHRoZSBwYWNrYWdlcnMgbmVlZCB0bwo+IHB1dCB0aGUgaWRz
IGluIHZhcmlvdXMgdmVyc2lvbnMgb2YgdmFyaW91cyBkaXN0cm9zLgoKVGhleSBjYW4gdGFrZSBh
IHNuYXBzaG90IGZyb20gdGhlIGxpYmRybSByZXBvc2l0b3J5IHRoZSBzYW1lIHdheSB0aGV5CmNv
dWxkIGZyb20gYSBzZXBhcmF0ZSByZXBvc2l0b3J5LiBJIGRvbid0IHNlZSBhbnkgaXNzdWUgdGhl
cmUuCgoKPiBXZSBhbHNvIGxpa2VseSBuZWVkIHRvIGF1dG9tYXRlIHRoZSB1cHN0cmVhbSB1cGRh
dGUgdG8gc2F2ZSBzb21ldGltZQo+IGZvciBvdXJzZWx2ZXMuCgpJJ20gc2tlcHRpY2FsIHRoYXQg
aXQgY2FuIGJlIGF1dG9tYXRlZCwgd2UnbGwgc2VlLiA6KQoKCi0tIApFYXJ0aGxpbmcgTWljaGVs
IETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29t
CkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNh
IGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
