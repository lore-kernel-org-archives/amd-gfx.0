From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dmr/amdgpu: Fix compile error with
 CONFIG_DRM_AMDGPU_GART_DEBUGFS
Date: Thu, 15 Aug 2019 11:38:06 +0200
Message-ID: <e7e3b33a-5918-7d4f-a179-2ee344fe3423@gmail.com>
References: <1565812118-25941-1-git-send-email-andrey.grodzovsky@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1565812118-25941-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTQuMDguMTkgdW0gMjE6NDggc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPiBEb3VibGUg
ZGVmaW50aW9uIG9mICdpJwo+Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFu
ZHJleS5ncm9kem92c2t5QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKSSB0aGluayBpbiB0aGUgbG9uZyB0ZXJtIHdlIGNv
dWxkIGFzIHdlbGwgcmVtb3ZlIApDT05GSUdfRFJNX0FNREdQVV9HQVJUX0RFQlVHRlMgYW5kIGRy
b3AgdGhlIGV4dHJhIGRlYnVnIGZ1bmN0aW9uYWxpdHkuCgpDaHJpc3RpYW4uCgo+IC0tLQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuYyB8IDIgKy0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jCj4gaW5kZXggYTY3ZmZmZi4uZjIwNGRiZCAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuYwo+IEBAIC0zMDksNyAr
MzA5LDcgQEAgaW50IGFtZGdwdV9nYXJ0X2JpbmQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
IHVpbnQ2NF90IG9mZnNldCwKPiAgIAkJICAgICB1aW50NjRfdCBmbGFncykKPiAgIHsKPiAgICNp
ZmRlZiBDT05GSUdfRFJNX0FNREdQVV9HQVJUX0RFQlVHRlMKPiAtCXVuc2lnbmVkIGksdCxwOwo+
ICsJdW5zaWduZWQgdCxwOwo+ICAgI2VuZGlmCj4gICAJaW50IHIsIGk7Cj4gICAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
