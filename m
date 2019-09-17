From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/ras: use GPU PAGE_SIZE/SHIFT for reserving
 pages
Date: Tue, 17 Sep 2019 10:09:21 +0200
Message-ID: <c233de22-2e5d-385f-6164-e35f51e439e0@gmail.com>
References: <20190916195052.29281-1-alexander.deucher@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190916195052.29281-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

QW0gMTYuMDkuMTkgdW0gMjE6NTAgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gV2UgYXJlIHJlc2Vy
dmluZyB2cmFtIHBhZ2VzIHNvIHRoZXkgc2hvdWxkIGJlIGFsaWduZWQgdG8gdGhlCj4gR1BVIHBh
Z2Ugc2l6ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jhcy5jIHwgMyArKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmFzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKPiBpbmRl
eCBmZjFmYzA4NGZmZTEuLjEzMWM1M2ZhOGVmZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmFzLmMKPiBAQCAtMTQwOSw3ICsxNDA5LDggQEAgaW50IGFtZGdwdV9yYXNf
cmVzZXJ2ZV9iYWRfcGFnZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJZm9yIChp
ID0gZGF0YS0+bGFzdF9yZXNlcnZlZDsgaSA8IGRhdGEtPmNvdW50OyBpKyspIHsKPiAgIAkJYnAg
PSBkYXRhLT5icHNbaV0ucmV0aXJlZF9wYWdlOwo+ICAgCj4gLQkJaWYgKGFtZGdwdV9ib19jcmVh
dGVfa2VybmVsX2F0KGFkZXYsIGJwIDw8IFBBR0VfU0hJRlQsIFBBR0VfU0laRSwKPiArCQlpZiAo
YW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWxfYXQoYWRldiwgYnAgPDwgQU1ER1BVX0dQVV9QQUdFX1NI
SUZULAo+ICsJCQkJCSAgICAgICBBTURHUFVfR1BVX1BBR0VfU0laRSwKPiAgIAkJCQkJICAgICAg
IEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0sCj4gICAJCQkJCSAgICAgICAmYm8sIE5VTEwpKQo+ICAg
CQkJRFJNX0VSUk9SKCJSQVMgRVJST1I6IHJlc2VydmUgdnJhbSAlbGx4IGZhaWxcbiIsIGJwKTsK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
