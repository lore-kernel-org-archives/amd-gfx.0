From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/sriov: reject kms open if TDR not finished or
 failed
Date: Thu, 3 May 2018 14:01:21 +0200
Message-ID: <59be85bb-564f-e8dd-67fb-dc9bbe3a82bb@gmail.com>
References: <1524638384-31977-1-git-send-email-Emily.Deng@amd.com>
 <5bede6f6-24b2-8a3a-d3d8-9a37ac6d13c8@daenzer.net>
 <CY4PR12MB11254FFDBB4FCCF91CBDE9758F8E0@CY4PR12MB1125.namprd12.prod.outlook.com>
 <e7756d73-aa65-b351-2b1a-81ceea1e013f@daenzer.net>
 <CY4PR12MB112547536CD27B7FE2C330F38F8E0@CY4PR12MB1125.namprd12.prod.outlook.com>
 <9d56b1c3-1e51-f3f1-17d6-c1615dea0a05@daenzer.net>
 <CY4PR12MB1125653A73D8A22533FB3FBE8F8D0@CY4PR12MB1125.namprd12.prod.outlook.com>
 <77a5af30-0371-4816-fcf5-0bbcffa4395c@daenzer.net>
 <CY4PR12MB11253279D4404CF482FD7CF08F8D0@CY4PR12MB1125.namprd12.prod.outlook.com>
 <fc3f05cd-ed48-c04e-cfcb-59ed5ab224e2@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fc3f05cd-ed48-c04e-cfcb-59ed5ab224e2-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMjcuMDQuMjAxOCB1bSAxMDoyMiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDQtMjcgMTA6MTUgQU0sIERlbmcsIEVtaWx5IHdyb3RlOgo+PiBObywgSSBtZWFuIGR1cmluZyBH
UFUgcmVzZXQsIHRoZSBhcHAgd2lsbCBmYWlsLCBpdCBpcyByZWFzb25hYmxlLgo+IEkgdW5kZXJz
dGFuZCwgYnV0IEkgZG9uJ3QgYWdyZWUgdGhhdCBpdCdzIHJlYXNvbmFibGUuIDopCgpJIGFncmVl
IHdpdGggTWljaGVsIGhlcmUgdGhhdCB0aGlzIGlzIGEgcmVhbGx5IGJhZCBpZGVhLgoKRXZlbiB3
aGlsZSB0aGUgR1BVIGlzIGluIHJlc2V0IGFuIGFwcGxpY2F0aW9uIHNob3VsZCBzdGlsbCBiZSBh
YmxlIHRvIApsb2FkIHVzZXJzcGFjZSBhbmQgb3BlbiB0aGUgZHJpdmVyLgoKSXQgbWlndGggbmVl
ZCB0byByZXNldCBpdCdzIGNvbnRleHQgZXZlbiBpZiBpdCBuZXZlciB1c2VkIHRoZW0sIGJ1dCB0
aGF0IAppcyBhIGNvbXBsZXRlbHkgZGlmZmVyZW50IHN0b3J5LgoKQ2hyaXN0aWFuLgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
