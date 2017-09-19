From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix iova debugfs for non-iommu case
Date: Tue, 19 Sep 2017 17:38:44 -0400
Message-ID: <df37f22f-ee32-977a-0d44-2dd35fcac95b@amd.com>
References: <20170919153042.9994-1-tom.stdenis@amd.com>
 <e9302f12-3f26-5176-79d1-5d837e44ebd5@amd.com>
 <1e817718-572a-6d77-f948-ef3ed5eeef0c@gmail.com>
 <5fbdcf5d-3be9-5af9-2321-8c59ebac4bb3@amd.com>
 <73bfce43-eeb2-f30a-21be-f59e1a9eb509@amd.com>
 <d6fb88bd-0742-29c4-f091-091ea466d599@amd.com>
 <cffc4608-454c-7ef5-c231-77e6b31d660c@amd.com>
 <a0abde86-0700-3155-9410-a14332836b95@amd.com>
 <bb94f775-ecd9-7752-9fc7-41a1a7a1c11d@amd.com>
 <eb89afe7-469a-c298-fba1-eb1d2c4c725d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <eb89afe7-469a-c298-fba1-eb1d2c4c725d-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTkvMDkvMTcgMDI6MzMgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFtyb290QGNh
cnJpem8gfl0jIHh4ZCAtbCAxMDI0IC1zIDB4QzAwMDAgCj4+IC9zeXMva2VybmVsL2RlYnVnL2Ry
aS8wL2FtZGdwdV9pb3ZhCj4gCj4gQWN0dWFsbHkgMHhDMDAwMCBpcyBhIHNwZWNpYWwgYWRkcmVz
cywgZS5nLiB2aWRlbyBCSU9TIGlmIEknbSBub3QgCj4gY29tcGxldGVseSBtaXN0YWtlbi4KCk5v
dCBzdXJlICB3aHkgdGhhdCB3b3VsZCBiZSBtYXBwZWQgYnkgdGhlIGRyaXZlciBidXQgSSBjYW4g
YWxzbyByZWFkIHRoZSAKa2VybmVsJ3MgYnNzIHNlY3Rpb24gd2l0aCB0aGlzLi4uCgokIHh4ZCAt
bCAxMDQ4NTc2IC1zIDB4MDFlNGMwMDAgIC9zeXMva2VybmVsL2RlYnVnL2RyaS8wL2FtZGdwdV9p
b3ZhCgouLi48c25pcD4uLi4KMDFlNmE0MzA6IDRjNjkgNmU3NSA3ODIwIDc2NjUgNzI3MyA2OTZm
IDZlMjAgMzQyZSAgTGludXggdmVyc2lvbiA0LgowMWU2YTQ0MDogMzEzMyAyZTMwIDJkNzIgNjMz
NSAyYjIwIDI4NzIgNmY2ZiA3NDQwICAxMy4wLXJjNSsgKHJvb3RACjAxZTZhNDUwOiA2MzYxIDcy
NzIgNjk3YSA2ZjI5IDIwMjggNjc2MyA2MzIwIDc2NjUgIGNhcnJpem8pIChnY2MgdmUKMDFlNmE0
NjA6IDcyNzMgNjk2ZiA2ZTIwIDM2MmUgMzMyZSAzMTIwIDMyMzAgMzEzNiAgcnNpb24gNi4zLjEg
MjAxNgowMWU2YTQ3MDogMzEzMiAzMjMxIDIwMjggNTI2NSA2NDIwIDQ4NjEgNzQyMCAzNjJlICAx
MjIxIChSZWQgSGF0IDYuCjAxZTZhNDgwOiAzMzJlIDMxMmQgMzEyOSAyMDI4IDQ3NDMgNDMyOSAy
OTIwIDIzMzMgIDMuMS0xKSAoR0NDKSkgIzMKMDFlNmE0OTA6IDMxMjAgNTM0ZCA1MDIwIDU0NzUg
NjUyMCA1MzY1IDcwMjAgMzEzOSAgMSBTTVAgVHVlIFNlcCAxOQowMWU2YTRhMDogMjAzMCAzNzNh
IDMxMzggM2EzMyAzMTIwIDQ1NDQgNTQyMCAzMjMwICAgMDc6MTg6MzEgRURUIDIwCjxzbmlwPgoK
VGhhdCdzIHBhcnQgb2YgdGhlIGRtZXNnIGJ1ZmZlciBhcHBhcmVudGx5LgoKSSBwb2ludGVkIGl0
IGF0IGFsbCBzb3J0cyBvZiBhZGRyZXNzIChiaW9zL3N5c3RlbSByYW0vZXRjKSBpdCBwcmV0dHkg
Cm11Y2ggd2lsbCByZWFkIGFueXRoaW5nLgoKVG9tCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
