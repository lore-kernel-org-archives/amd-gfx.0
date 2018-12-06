From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Skip ring soft recovery when fence was NULL
Date: Thu, 6 Dec 2018 10:31:49 +0100
Message-ID: <f8e8e438-cffa-db99-a693-a97abe88576f@gmail.com>
References: <1544064170-12834-1-git-send-email-Wentao.Lou@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1544064170-12834-1-git-send-email-Wentao.Lou-5C7GfCeVMHo@public.gmane.org>
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
To: wentalou <Wentao.Lou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDYuMTIuMTggdW0gMDM6NDIgc2NocmllYiB3ZW50YWxvdToKPiBhbWRncHVfcmluZ19zb2Z0
X3JlY292ZXJ5IHdvdWxkIGhhdmUgQ2FsbC1UcmFjZSwKPiB3aGVuIHNfZmVuY2UtPnBhcmVudCB3
YXMgTlVMTCBpbnNpZGUgYW1kZ3B1X2pvYl90aW1lZG91dC4KPiBDaGVjayBmZW5jZSBmaXJzdCwg
YXMgZHJtX3NjaGVkX2h3X2pvYl9yZXNldCBkaWQuCj4KPiBDaGFuZ2UtSWQ6IEliYjA2MmUzNmZl
YjRlMjUyMmE1OTY0MWZlMGQyZDc2Yjk3NzNjZGE3Cj4gU2lnbmVkLW9mZi1ieTogV2VudGFvIExv
dSA8V2VudGFvLkxvdUBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmluZy5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3JpbmcuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
aW5nLmMKPiBpbmRleCA1Yjc1YmRjLi4zMzVhMGVkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmluZy5jCj4gQEAgLTM5Nyw3ICszOTcsNyBAQCBib29sIGFtZGdwdV9y
aW5nX3NvZnRfcmVjb3Zlcnkoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCB1bnNpZ25lZCBpbnQg
dm1pZCwKPiAgIHsKPiAgIAlrdGltZV90IGRlYWRsaW5lID0ga3RpbWVfYWRkX3VzKGt0aW1lX2dl
dCgpLCAxMDAwMCk7Cj4gICAKPiAtCWlmICghcmluZy0+ZnVuY3MtPnNvZnRfcmVjb3ZlcnkpCj4g
KwlpZiAoIXJpbmctPmZ1bmNzLT5zb2Z0X3JlY292ZXJ5IHx8ICFmZW5jZSkKPiAgIAkJcmV0dXJu
IGZhbHNlOwo+ICAgCj4gICAJYXRvbWljX2luYygmcmluZy0+YWRldi0+Z3B1X3Jlc2V0X2NvdW50
ZXIpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
