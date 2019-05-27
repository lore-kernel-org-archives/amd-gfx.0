From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Don't need to call csb_vram_unpin
Date: Mon, 27 May 2019 13:02:21 +0200
Message-ID: <e15ac75c-fb1a-2a05-b857-d3761f5c905e@gmail.com>
References: <1558946487-18034-1-git-send-email-Emily.Deng@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1558946487-18034-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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
To: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjcuMDUuMTkgdW0gMTA6NDEgc2NocmllYiBFbWlseSBEZW5nOgo+IEFzIGl0IHdpbGwgZGVz
dHJveSBjbGVhcl9zdGF0ZV9vYmosIGFuZCBhbHNvIHdpbGwKPiB1bnBpbiBpdCBpbiB0aGUgZ2Z4
X3Y5XzBfc3dfZmluaSwgc28gZG9uJ3QgbmVlZCB0bwo+IGNhbGwgY3NiX3ZyYW0gdW5waW4gaW4g
Z2Z4X3Y5XzBfaHdfZmluaSwgb3IgaXQgd2lsbAo+IGhhdmUgdW5waW4gd2FybmluZy4KPgo+IHYy
OiBGb3Igc3VzcGVuZCwgc3RpbGwgbmVlZCB0byBkbyB1bnBpbgo+Cj4gU2lnbmVkLW9mZi1ieTog
RW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyB8IDMgKystCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OV8wLmMKPiBpbmRleCA1ZWI3MGU4Li41YjFmZjQ4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jCj4gQEAgLTMzOTUsNyArMzM5NSw4IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5
XzBfaHdfZmluaSh2b2lkICpoYW5kbGUpCj4gICAJZ2Z4X3Y5XzBfY3BfZW5hYmxlKGFkZXYsIGZh
bHNlKTsKPiAgIAlhZGV2LT5nZngucmxjLmZ1bmNzLT5zdG9wKGFkZXYpOwo+ICAgCj4gLQlnZnhf
djlfMF9jc2JfdnJhbV91bnBpbihhZGV2KTsKPiArCWlmIChhZGV2LT5pbl9zdXNwZW5kKQo+ICsJ
CWdmeF92OV8wX2NzYl92cmFtX3VucGluKGFkZXYpOwoKVGhhdCBkb2Vzbid0IGxvb2tzIGxpa2Ug
YSBnb29kIGlkZWEgdG8gbWUuCgpXaHkgZG8gd2UgaGF2ZSB1bnBpbiBib3RoIGluIHRoZSBzd19m
aW5pIGFzIHdlbGwgYXMgdGhlIGh3X2ZpbmkgY29kZSBwYXRocz8KClJlZ2FyZHMsCkNocmlzdGlh
bi4KCj4gICAKPiAgIAlyZXR1cm4gMDsKPiAgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
