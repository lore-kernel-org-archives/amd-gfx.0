From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix static checker warning
Date: Fri, 23 Nov 2018 11:36:45 +0100
Message-ID: <dca7c34e-523b-f39a-6c73-2f0bf90e8c18@gmail.com>
References: <1542969136-20300-1-git-send-email-Rex.Zhu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1542969136-20300-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjMuMTEuMTggdW0gMTE6MzIgc2NocmllYiBSZXggWmh1Ogo+IGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9jc2EuYzo0OSBhbWRncHVfYWxsb2NhdGVfc3RhdGljX2NzYSgpCj4g
ZXJyb3I6IHVuaW5pdGlhbGl6ZWQgc3ltYm9sICdwdHInLgo+Cj4gdGhlIHRlc3QgaWYgKCFibykg
ZG9lc24ndCB3b3JrLCBhcyB0aGUgYm8gaXMgYSBwb2ludGVyIHRvIGEgcG9pbnRlci4KPiBzbyBu
ZWVkIHRvIGNoZWNrICEqYm8KPgo+IFNpZ25lZC1vZmYtYnk6IFJleCBaaHUgPFJleC5aaHVAYW1k
LmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzYS5j
IHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzYS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzYS5jCj4gaW5kZXggZmVhNDU1
NS4uZDNhMjUzNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfY3NhLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3NhLmMK
PiBAQCAtNTIsNyArNTIsNyBAQCBpbnQgYW1kZ3B1X2FsbG9jYXRlX3N0YXRpY19jc2Eoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfYm8gKipibwo+ICAgCXIgPSBhbWRn
cHVfYm9fY3JlYXRlX2tlcm5lbChhZGV2LCBzaXplLCBQQUdFX1NJWkUsCj4gICAJCQkJZG9tYWlu
LCBibywKPiAgIAkJCQlOVUxMLCAmcHRyKTsKPiAtCWlmICghYm8pCj4gKwlpZiAoISpibykKPiAg
IAkJcmV0dXJuIC1FTk9NRU07Cj4gICAKPiAgIAltZW1zZXQocHRyLCAwLCBzaXplKTsKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
