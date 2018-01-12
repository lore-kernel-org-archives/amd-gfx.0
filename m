From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: only allow scatter/gather display with DC
Date: Fri, 12 Jan 2018 22:02:50 +0100
Message-ID: <c10fed9d-fdd0-ff5e-7b3b-8cc9ffe809d2@gmail.com>
References: <20180112195811.15372-1-alexander.deucher@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180112195811.15372-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

QW0gMTIuMDEuMjAxOCB1bSAyMDo1OCBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBDaGVjayBpZiBE
QyBpcyBlbmFibGVkIGJlZm9yZSBhbGxvd2luZyBzY2Fub3V0IGJ1ZmZlcnMKPiB0byBiZSBwaW5u
ZWQgaW4gc3lzdGVtIG1lbW9yeS4KPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyB8IDUgKysrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rpc3BsYXkuYwo+IGluZGV4IDhlZGUyNjQ1YTA2Yy4uODU5OTQyNTUyZTlmIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jCj4gQEAg
LTUwNyw5ICs1MDcsMTIgQEAgdWludDMyX3QgYW1kZ3B1X2Rpc3BsYXlfZnJhbWVidWZmZXJfZG9t
YWlucyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIHsKPiAgIAl1aW50MzJfdCBkb21h
aW4gPSBBTURHUFVfR0VNX0RPTUFJTl9WUkFNOwo+ICAgCj4gKyNpZiBkZWZpbmVkKENPTkZJR19E
Uk1fQU1EX0RDKQo+ICAgCWlmIChhZGV2LT5hc2ljX3R5cGUgPj0gQ0hJUF9DQVJSSVpPICYmIGFk
ZXYtPmFzaWNfdHlwZSA8IENISVBfUkFWRU4gJiYKPiAtCSAgICBhZGV2LT5mbGFncyAmIEFNRF9J
U19BUFUpCj4gKwkgICAgYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVICYmCj4gKwkgICAgYW1kZ3B1
X2RldmljZV9hc2ljX2hhc19kY19zdXBwb3J0KGFkZXYtPmFzaWNfdHlwZSkpCj4gICAJCWRvbWFp
biB8PSBBTURHUFVfR0VNX0RPTUFJTl9HVFQ7Cj4gKyNlbmRpZgo+ICAgCj4gICAJcmV0dXJuIGRv
bWFpbjsKPiAgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
