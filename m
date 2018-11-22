From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd: add the checking to avoid NULL pointer
 dereference
Date: Thu, 22 Nov 2018 12:21:40 +0100
Message-ID: <a01557a3-96e4-37b1-0746-8976c5e19e1d@gmail.com>
References: <20181122023610.22058-1-Deepak.Sharma@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181122023610.22058-1-Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>
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
To: "Sharma, Deepak" <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMjIuMTEuMTggdW0gMDM6MzYgc2NocmllYiBTaGFybWEsIERlZXBhazoKPiB3aGVuIHJldHVy
bmVkIGZlbmNlIGlzIG5vdCB2YWxpZCBtb3N0bHkgZHVlIHRvIHVzZXJzcGFjZSBpZ25vcmVkCj4g
cHJldmlvdXMgZXJyb3IgY2F1c2VzIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZQoKTkFLLCB3aGVu
IHRoZSBmZW5jZSBpcyBOVUxMIHRoZW4gdGhpcyBtZWFucyBpdCBpcyBhbHJlYWR5IHNpZ25hbGVk
IGFuZCAKbm8gbG9uZ2VyIGluIHRoZSBjb250YWluZXIuCgpJbiBvdGhlciB3b3JkcyB0aGlzIGlz
IGEgbm9ybWFsIGNhc2UgYW5kIHRoZSBmb2xsb3dpbmcgZnVuY3Rpb25zIG5lZWQgdG8gCmJlIGFi
bGUgdG8gaGFuZGxlIHRoYXQuCgpDaHJpc3RpYW4uCgo+Cj4gU2lnbmVkLW9mZi1ieTogRGVlcGFr
IFNoYXJtYSA8RGVlcGFrLlNoYXJtYUBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgfCAyICsrCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2NzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+IGluZGV4
IDAyNGRmYmQ4N2YxMS4uYzg1YmIzMTNlNmRmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2NzLmMKPiBAQCAtMTQyMCw2ICsxNDIwLDggQEAgaW50IGFtZGdwdV9jc19mZW5j
ZV90b19oYW5kbGVfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwKPiAg
IAlmZW5jZSA9IGFtZGdwdV9jc19nZXRfZmVuY2UoYWRldiwgZmlscCwgJmluZm8tPmluLmZlbmNl
KTsKPiAgIAlpZiAoSVNfRVJSKGZlbmNlKSkKPiAgIAkJcmV0dXJuIFBUUl9FUlIoZmVuY2UpOwo+
ICsJaWYgKCFmZW5jZSkKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiAgIAo+ICAgCXN3aXRjaCAoaW5m
by0+aW4ud2hhdCkgewo+ICAgCWNhc2UgQU1ER1BVX0ZFTkNFX1RPX0hBTkRMRV9HRVRfU1lOQ09C
SjoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
