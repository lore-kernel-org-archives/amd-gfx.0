From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: set gtt size according to system memory
 size only
Date: Wed, 29 Nov 2017 10:34:06 +0100
Message-ID: <553b4e81-7670-c5a1-0821-b6d7a5d04f2a@amd.com>
References: <1511946723-27200-1-git-send-email-Hongbo.He@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1511946723-27200-1-git-send-email-Hongbo.He-5C7GfCeVMHo@public.gmane.org>
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
To: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjkuMTEuMjAxNyB1bSAxMDoxMiBzY2hyaWViIFJvZ2VyIEhlOgo+IENoYW5nZS1JZDogSWI2
MzQzNzViOTBkODc1ZmUwNGE4OTBmYzgyZmIxZTNiNzExMjY3NmEKPiBTaWduZWQtb2ZmLWJ5OiBS
b2dlciBIZSA8SG9uZ2JvLkhlQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDggKysrLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3R0bS5jCj4gaW5kZXggMTdiZjBjZS4uZDA2NjE5MDcgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gQEAgLTEzMzAsMTEgKzEzMzAsOSBAQCBp
bnQgYW1kZ3B1X3R0bV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCQlzdHJ1
Y3Qgc3lzaW5mbyBzaTsKPiAgIAo+ICAgCQlzaV9tZW1pbmZvKCZzaSk7Cj4gLQkJZ3R0X3NpemUg
PSBtaW4obWF4KChBTURHUFVfREVGQVVMVF9HVFRfU0laRV9NQiA8PCAyMCksCj4gLQkJCSAgICAg
ICBhZGV2LT5tYy5tY192cmFtX3NpemUpLAo+IC0JCQkgICAgICAgKCh1aW50NjRfdClzaS50b3Rh
bHJhbSAqIHNpLm1lbV91bml0ICogMy80KSk7Cj4gLQl9Cj4gLQllbHNlCj4gKwkJZ3R0X3NpemUg
PSBtYXgoQU1ER1BVX0RFRkFVTFRfR1RUX1NJWkVfTUIgPDwgMjAsCj4gKwkJCSh1aW50NjRfdClz
aS50b3RhbHJhbSAqIHNpLm1lbV91bml0ICogMy80KTsKPiArCX0gZWxzZQo+ICAgCQlndHRfc2l6
ZSA9ICh1aW50NjRfdClhbWRncHVfZ3R0X3NpemUgPDwgMjA7Cj4gICAJciA9IHR0bV9ib19pbml0
X21tKCZhZGV2LT5tbWFuLmJkZXYsIFRUTV9QTF9UVCwgZ3R0X3NpemUgPj4gUEFHRV9TSElGVCk7
Cj4gICAJaWYgKHIpIHsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
