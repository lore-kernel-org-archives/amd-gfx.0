From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display/dc/dce: Fix multiple potential integer
 overflows
Date: Wed, 4 Jul 2018 14:05:18 -0400
Message-ID: <ced95410-1b3c-8344-fe62-7f22f310c86d@amd.com>
References: <20180704011305.GA15742@embeddedor.com>
 <c663121e-1db8-9d7f-6b66-2c41e6a8bb70@daenzer.net>
 <421747e5-e6e0-6680-e3b7-a3a2a5b7b307@amd.com>
 <ab3d5e10-e25b-46a1-d3ab-da3619d8c5b4@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ab3d5e10-e25b-46a1-d3ab-da3619d8c5b4-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
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
To: "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

T24gMjAxOC0wNy0wNCAwMTo1NCBQTSwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToKPiAKPiAK
PiBPbiAwNy8wNC8yMDE4IDEyOjUxIFBNLCBIYXJyeSBXZW50bGFuZCB3cm90ZToKPiBbLi5dCj4+
Pj4gIAo+Pj4+IEBAIC0xNDUsOCArMTQ1LDggQEAgc3RhdGljIGJvb2wgY2FsY3VsYXRlX2ZiX2Fu
ZF9mcmFjdGlvbmFsX2ZiX2RpdmlkZXIoCj4+Pj4gICAqIG9mIGZyYWN0aW9uYWwgZmVlZGJhY2sg
ZGVjaW1hbCBwb2ludCBhbmQgdGhlIGZyYWN0aW9uYWwgRkIgRGl2aWRlciBwcmVjaXNpb24KPj4+
PiAgICogaXMgMiB0aGVuIHRoZSBlcXVhdGlvbiBiZWNvbWVzICh1bGxmZWVkYmFja0RpdmlkZXIg
KyA1KjEwMCkgLyAoMTAqMTAwKSkqLwo+Pj4+ICAKPj4+PiAtCWZlZWRiYWNrX2RpdmlkZXIgKz0g
KHVpbnQ2NF90KQo+Pj4+IC0JCQkoNSAqIGNhbGNfcGxsX2NzLT5mcmFjdF9mYl9kaXZpZGVyX3By
ZWNpc2lvbl9mYWN0b3IpOwo+Pj4+ICsJZmVlZGJhY2tfZGl2aWRlciArPSA1VUwgKgo+Pj4+ICsJ
CQkgICAgY2FsY19wbGxfY3MtPmZyYWN0X2ZiX2RpdmlkZXJfcHJlY2lzaW9uX2ZhY3RvcjsKPj4+
Cj4+PiBUaGlzIHNob3VsZCBiZSA1VUxMLCBhcyB0aGUgY29tbWl0IGxvZyBzYXlzLCBvdGhlcndp
c2UgaXQncyBzdGlsbCBvbmx5Cj4+PiAzMiBiaXRzIG9uIDMyLWJpdCBwbGF0Zm9ybXMuCj4+Pgo+
Pgo+PiBBZ3JlZWQuCj4+Cj4+IE90aGVyd2lzZSB0aGlzIGxvb2tzIGdvb2QuCj4+Cj4+IFdpdGgg
dGhhdCBmaXhlZCB0aGlzIHBhdGNoIGlzCj4+IFJldmlld2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8
aGFycnkud2VudGxhbmRAYW1kLmNvbT4KPj4KPiAKPiBIaSBIYXJyeSwKPiAKPiBJIGFscmVhZHkg
c2VudCB2MjogaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDUwNjg5Ny8KPiAK
ClRoYW5rcy4gTWVyZ2VkLgoKSGFycnkKCj4gVGhhbmtzCj4gLS0KPiBHdXN0YXZvCj4gCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
