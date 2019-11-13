From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/7] drm/amdgpu: remove set but not used variable
 'mc_shared_chmap' from 'gfx_v6_0.c' and 'gfx_v7_0.c'
Date: Wed, 13 Nov 2019 14:22:10 -0500
Message-ID: <CADnq5_Pwc9U03+1=tKs2hxKVdqfwXOc14XRD=yeJCsc4=5NJtw@mail.gmail.com>
References: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
 <1573649074-72589-2-git-send-email-yukuai3@huawei.com>
 <ac4566662a04e0c25039df7ed30789d0792885cd.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ac4566662a04e0c25039df7ed30789d0792885cd.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
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
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, yi.zhang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, zhengbin <zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, yu kuai <yukuai3-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "Quan,
 Evan" <evan.quan-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gV2VkLCBOb3YgMTMsIDIwMTkgYXQgMTE6NTYgQU0gSm9lIFBlcmNoZXMgPGpvZUBwZXJjaGVz
LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIDIwMTktMTEtMTMgYXQgMjA6NDQgKzA4MDAsIHl1IGt1
YWkgd3JvdGU6Cj4gPiBGaXhlcyBnY2MgJy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUnIHdhcm5p
bmc6Cj4gPgo+ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y2XzAuYzogSW4gZnVu
Y3Rpb24KPiA+IOKAmGdmeF92Nl8wX2NvbnN0YW50c19pbml04oCZOgo+ID4gZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3Y2XzAuYzoxNTc5OjY6IHdhcm5pbmc6IHZhcmlhYmxlCj4gPiDi
gJhtY19zaGFyZWRfY2htYXDigJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12
YXJpYWJsZV0KPiBbXQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92Nl8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjZfMC5jCj4gW10K
PiA+IEBAIC0xNjc4LDcgKzE2NzgsNiBAQCBzdGF0aWMgdm9pZCBnZnhfdjZfMF9jb25zdGFudHNf
aW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiA+Cj4gPiAgICAgICBXUkVHMzIobW1C
SUZfRkJfRU4sIEJJRl9GQl9FTl9fRkJfUkVBRF9FTl9NQVNLIHwgQklGX0ZCX0VOX19GQl9XUklU
RV9FTl9NQVNLKTsKPiA+Cj4gPiAtICAgICBtY19zaGFyZWRfY2htYXAgPSBSUkVHMzIobW1NQ19T
SEFSRURfQ0hNQVApOwo+Cj4gSSBkbyBub3Qga25vdyB0aGUgaGFyZHdhcmUgYnV0IGZyZXF1ZW50
bHkgaGFyZHdhcmUgbGlrZQo+IHRoaXMgaGFzIHJlYWQgb3JkZXJpbmcgcmVxdWlyZW1lbnRzIGFu
ZCB2YXJpb3VzIHJlZ2lzdGVycwo+IGNhbiBub3QgYmUgcmVhZCBpbiBhIHJhbmRvbSBvcmRlci4K
Pgo+IERvZXMgcmVtb3ZpbmcgdGhpcyByZWFkIGhhdmUgbm8gZWZmZWN0IG9uIHRoZSBoYXJkd2Fy
ZT8KClRoZXJlIGlzIG5vIGRlcGVuZGVuY3kuICBJdCdzIHNhZmUuICBTYW1lIHRoaW5nIGJlbG93
LgoKQWxleAoKPgo+ID4gICAgICAgYWRldi0+Z2Z4LmNvbmZpZy5tY19hcmJfcmFtY2ZnID0gUlJF
RzMyKG1tTUNfQVJCX1JBTUNGRyk7Cj4gPiAgICAgICBtY19hcmJfcmFtY2ZnID0gYWRldi0+Z2Z4
LmNvbmZpZy5tY19hcmJfcmFtY2ZnOwo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y3XzAuYwo+IFtdCj4gPiBAQCAtNDMzNiw3ICs0MzM2LDYgQEAgc3RhdGljIHZvaWQgZ2Z4X3Y3
XzBfZ3B1X2Vhcmx5X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gPiAgICAgICAg
ICAgICAgIGJyZWFrOwo+ID4gICAgICAgfQo+ID4KPiA+IC0gICAgIG1jX3NoYXJlZF9jaG1hcCA9
IFJSRUczMihtbU1DX1NIQVJFRF9DSE1BUCk7Cj4gPiAgICAgICBhZGV2LT5nZnguY29uZmlnLm1j
X2FyYl9yYW1jZmcgPSBSUkVHMzIobW1NQ19BUkJfUkFNQ0ZHKTsKPiA+ICAgICAgIG1jX2FyYl9y
YW1jZmcgPSBhZGV2LT5nZnguY29uZmlnLm1jX2FyYl9yYW1jZmc7Cj4KPiBTYW1lIHF1ZXN0aW9u
Lgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBk
cmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
