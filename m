From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix fence memory leak in wait_all_fence V2
Date: Fri, 7 Apr 2017 11:14:06 +0200
Message-ID: <1d47c281-ac59-625d-dd9f-7bf7eef025d4@vodafone.de>
References: <1491556073-20459-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1491556073-20459-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDcuMDQuMjAxNyB1bSAxMTowNyBzY2hyaWViIENodW5taW5nIFpob3U6Cj4gVjI6IHJlbW92
ZSAqKmFycmF5IG1ldGhvZCwgZGlyZWN0bHkgZmVuY2VfcHV0IGFmdGVyIGZlbmNlIHdhaXQuCj4K
PiBDaGFuZ2UtSWQ6IElkZGUzZjkyOWNiZTRmZTgwNjNhN2I5MTNlMzYxZDZkOGJjMjc0NWRjCj4g
U2lnbmVkLW9mZi1ieTogQ2h1bm1pbmcgWmhvdSA8RGF2aWQxLlpob3VAYW1kLmNvbT4KClJldmll
d2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJzdGlhbi5rb2VuaWdAYW1kLmNvbT4gYW5kIGdv
b2QgY2F0Y2guCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nz
LmMgfCAxICsKPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPiBpbmRleCBkZTFjNGMzLi5jOTM5Mzc0IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPiBAQCAtMTIzMCw2ICsxMjMw
LDcgQEAgc3RhdGljIGludCBhbWRncHVfY3Nfd2FpdF9hbGxfZmVuY2VzKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAo+ICAgCQkJY29udGludWU7Cj4gICAKPiAgIAkJciA9IGtjbF9mZW5jZV93
YWl0X3RpbWVvdXQoZmVuY2UsIHRydWUsIHRpbWVvdXQpOwo+ICsJCWZlbmNlX3B1dChmZW5jZSk7
Cj4gICAJCWlmIChyIDwgMCkKPiAgIAkJCXJldHVybiByOwo+ICAgCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
