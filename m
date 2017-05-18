From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Enable raven gpu_info firmware
Date: Thu, 18 May 2017 10:09:44 -0400
Message-ID: <9a86fde8-3ad5-9301-ccbc-d7296107e3da@amd.com>
References: <20170518120004.12416-1-tom.stdenis@amd.com>
 <DM2PR12MB05396EB212B80394725FB63FFCE40@DM2PR12MB0539.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM2PR12MB05396EB212B80394725FB63FFCE40-nhZl9fRSQ+m5jHZ/JRvxbAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTgvMDUvMTcgMTA6MDcgQU0sIFpoYW5nLCBIYXdraW5nIHdyb3RlOgo+IElJUkMgSXQncyBh
bHJlYWR5IGluIGFtZC1zdGFnaW5nLTQuOSBicmFuY2guIEFueXdheSwgdGhlIHBhdGNoIGlzCj4g
Cj4gUmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KCkl0
IG11c3QgaGF2ZSBnb25lIG1pc3Npbmcgd2hlbiBBbGV4IChEZXVjaGVyKSBtYWRlIHRoZSA0LjEx
IGJyYW5jaC4KClRoYW5rcyBmb3IgdGhlIFItYiBidXQgcGVyaGFwcyB3ZSBzaG91bGQgY2hlcnJ5
LXBpY2sgdGhlIHBhdGNoIGZyb20gNC45IAppZiBpdCdzIHNtYWxsIGVub3VnaC4KCkxvb2tzIGxp
a2UgaXQgaXMgc2ltcGx5IHRoaXMgY29tbWl0Cgpjb21taXQgM2I1MTUxOWNjOGViYjZhMjVhODY1
MjJlY2NjOTcwOGFmZDRkYzMzYgpBdXRob3I6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KRGF0ZTogICBUdWUgTWF5IDkgMTI6Mjc6MzUgMjAxNyAtMDQwMAoKICAgICBk
cm0vYW1kZ3B1OiBhZGQgcmF2ZW4gZ3B1X2luZm8gc3VwcG9ydAoKICAgICBBZGQgc3VwcG9ydCBm
b3IgcGFyc2luZyB0aGUgZ3B1IGluZm8gdGFibGUgb24gcmF2ZW4uCiAgICAgVGhpcyBpcyByZXF1
aXJlZCB0byBnZXQgdGhlIGdwdSBjb25maWcgZGF0YSBmb3IgcmF2ZW4uCgogICAgIFNpZ25lZC1v
ZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCkknbGwgY2hl
cnJ5LXBpY2sgdGhhdCBvdmVyIGFuZCBwdXNoIGl0IG91dCBtb21lbnRhcmlseSAoc2luY2UgQWxl
eCBpcyBvbiAKdmFjYXRpb24pLgoKVG9tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
