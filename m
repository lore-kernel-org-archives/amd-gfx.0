From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix a bug that vm size is wrong on Raven
Date: Thu, 14 Dec 2017 09:47:35 +0100
Message-ID: <24c4613c-ed30-2ac3-cca2-4aec5dd707d5@gmail.com>
References: <1513218350-29030-1-git-send-email-yong.zhao@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1513218350-29030-1-git-send-email-yong.zhao-5C7GfCeVMHo@public.gmane.org>
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
To: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

TkFLLCB0aGF0IHJlYWxseSBjaXJjdW12ZW50cyB0aGUgaW50ZW50aW9uIG9mIHRoZSBwYXRjaCB0
byBhZGp1c3QgdGhlIApudW1iZXIgb2YgbGV2ZWxzIGJhc2VkIG9uIHRoZSB2bV9zaXplLgoKQ2hy
aXN0aWFuLgoKQW0gMTQuMTIuMjAxNyB1bSAwMzoyNSBzY2hyaWViIFlvbmcgWmhhbzoKPiBDaGFu
Z2UtSWQ6IElkNTIyYzFjYmFkYjhjMDY5NzIwZjRlNjRhMzFjZmY0MmNkMDE0NzMzCj4gU2lnbmVk
LW9mZi1ieTogWW9uZyBaaGFvIDx5b25nLnpoYW9AYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYwo+IGluZGV4IDcwOTU4N2QuLjNiOWViMWEgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC0yNTM0LDcgKzI1MzQsNyBAQCB2b2lkIGFt
ZGdwdV92bV9hZGp1c3Rfc2l6ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3Qg
dm1fc2l6ZSwKPiAgIAl1aW50NjRfdCB0bXA7Cj4gICAKPiAgIAkvKiBhZGp1c3Qgdm0gc2l6ZSBm
aXJzdCAqLwo+IC0JaWYgKGFtZGdwdV92bV9zaXplICE9IC0xKSB7Cj4gKwlpZiAoYW1kZ3B1X3Zt
X3NpemUgIT0gLTEgJiYgbWF4X2xldmVsID09IDEpIHsKPiAgIAkJdW5zaWduZWQgbWF4X3NpemUg
PSAxIDw8IChtYXhfYml0cyAtIDMwKTsKPiAgIAo+ICAgCQl2bV9zaXplID0gYW1kZ3B1X3ZtX3Np
emU7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
