From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] drm/amdgpu/gmc6: use amdgpu_asic_flush_hdp for gart
 tlb invalidations
Date: Fri, 5 Jan 2018 10:14:16 +0100
Message-ID: <dfda78a6-dbd4-c958-1d38-d88435e482c1@gmail.com>
References: <20180105043026.9348-1-alexander.deucher@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180105043026.9348-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMDUuMDEuMjAxOCB1bSAwNTozMCBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBVc2UgdGhlIGNh
bGxiYWNrIHJhdGhlciB0aGFuIG9wZW4gY29kaW5nIGl0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKSSB3b3VsZCByYXRoZXIgcHJl
ZmVyIGlmIHRoZSBjYWxsZXIgb2YgZmx1c2hfZ3B1X3RsYiBjYWxscyAKYW1kZ3B1X2FzaWNfZmx1
c2hfaGRwKCkuCgpJSVJDIHdlIGhhdmUgZXhhY3RseSBvbmUgd2hpY2ggY2FsbHMgdGhpcyBhbmQg
dGhlIG90aGVyIG9uZSBhY3R1YWxseSAKd2FudHMgdG8gY2FsbCBhbWRncHVfYXNpY19mbHVzaF9o
ZHAoKSBvbmx5LgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dtY192Nl8wLmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nbWNfdjZfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y2
XzAuYwo+IGluZGV4IDhlMjgyNzBkMWVhOS4uZTQ3YTFiYTU3YWFlIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192Nl8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjZfMC5jCj4gQEAgLTM1OSw3ICszNTksNyBAQCBzdGF0aWMgaW50
IGdtY192Nl8wX21jX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICBzdGF0aWMg
dm9pZCBnbWNfdjZfMF9nYXJ0X2ZsdXNoX2dwdV90bGIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsCj4gICAJCQkJCXVpbnQzMl90IHZtaWQpCj4gICB7Cj4gLQlXUkVHMzIobW1IRFBfTUVNX0NP
SEVSRU5DWV9GTFVTSF9DTlRMLCAwKTsKPiArCWFtZGdwdV9hc2ljX2ZsdXNoX2hkcChhZGV2KTsK
PiAgIAo+ICAgCVdSRUczMihtbVZNX0lOVkFMSURBVEVfUkVRVUVTVCwgMSA8PCB2bWlkKTsKPiAg
IH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
