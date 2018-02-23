From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: insist on 32-bit DMA for Cedar on
 PPC64/PPC64LE
Date: Fri, 23 Feb 2018 08:45:39 +0100
Message-ID: <28f30742-6da6-4bd1-8ba0-3e5eb1677586@gmail.com>
References: <20180221234154.6877-1-bcrocker@redhat.com>
 <20180222215713.4052-1-bcrocker@redhat.com>
 <92431e86-a247-b7d3-6a45-10d23acb2ae7@daenzer.net>
 <CALk+eRew=1nHZXRtXR430eFStOiQFUDgrp8VfsBAfcp8W9qAOA@mail.gmail.com>
 <1bcf5b27-aa25-deb6-85e9-161dd038276b@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1bcf5b27-aa25-deb6-85e9-161dd038276b-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Ben Crocker <bcrocker-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMjIuMDIuMjAxOCB1bSAxODo1NiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDItMjIgMDY6MzcgUE0sIEJlbiBDcm9ja2VyIHdyb3RlOgo+PiBPbmUgb2YgbXkgY29sbGVhZ3Vl
cyBkaWQgZGlzY292ZXIgYSAiUmFkZW9uIEhHIDU0NTAgUENJIiBmcm9tIEZlYnJ1YXJ5Cj4+IDIw
MTAgd2hpY2ggZGlkLCBhcHBhcmVudGx5LCBoYXZlIGEgQ2VkYXIgR1BVIGFuZCB2ZXJ5IGRlZmlu
aXRlbHkgaGFkIGEKPj4gKHBsYWluIG9sZCkgUENJIGNvbm5lY3Rvci4KPiBUaGVyZSBtdXN0IGJl
IGEgUENJZS10by1QQ0kgYnJpZGdlIG9uIHRoYXQgYm9hcmQuIFRoZSBHUFUgaXRzZWxmIGlzCj4g
YWx3YXlzIFBDSWUsIGFuZCB0cmVhdGVkIGFjY29yZGluZ2x5IGJ5IHRoZSBkcml2ZXIuCgpCZW4s
IGp1c3QgYW4gZWR1Y2F0ZWQgZ3Vlc3MgYnV0IGlzIHRoaXMgb25lIHRoZSBvbmUgd2hpY2ggaXMg
ZmFpbGluZyB0byAKd29yayBjb3JyZWN0bHk/CgpDYXVzZSB0aGUgUENJZSBidXMgaW50ZXJmYWNl
IGlzIHByZXR0eSBtdWNoIGlkZW50aWNhbCBvdmVyIGFsbCAKZ2VuZXJhdGlvbnMgb2YgdGhlIGxh
c3QgZGVjYWRlIG9yIHNvLiBPbmx5IHRoZSBuZXdlc3QgVmVnYTEwIGdlbmVyYXRpb24gCmlzIGEg
Yml0IGRpZmZlcmVudC4KClNvIEkgc3Ryb25nbHkgdGhpbmcgdGhhdCB0aGlzIGlzbid0IHJlbGF0
ZWQgdG8gdGhlIGRldmljZSBiZWluZyBhIENlZGFyIAphdCBhbGwsIGJ1dCByYXRoZXIgdGhhdCB5
b3UgaGF2ZSBhIGJyaWRnZSBhYm92ZSBpdCB3aGljaCBkb2Vzbid0IApjb3JyZWN0bHkgaGFuZGxl
IDY0Yml0IHRyYW5zZmVycy4KCkNhbiB5b3UgcGxlYXNlIHNlbmQgYW5kICJsc3BjaSAtdCIgb2Yg
Ym90aCB0aGUgd29ya2luZyBhbmQgdGhlIApwcm9ibGVtYXRpYyBkZXZpY2VzPwoKVGhhbmtzLApD
aHJpc3RpYW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
