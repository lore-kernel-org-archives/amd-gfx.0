From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix warning on 32 bit
Date: Thu, 27 Jun 2019 15:52:15 +0200
Message-ID: <0c1fdae3-7c81-f49e-859a-b58d0b3de3d9@gmail.com>
References: <20190627135058.10947-1-alexander.deucher@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190627135058.10947-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

QW0gMjcuMDYuMTkgdW0gMTU6NTAgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gUHJvcGVybHkgY2Fz
dCBwb2ludGVyIHRvIGludC4KPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNuX3YyXzAuYyB8IDQgKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS92Y25fdjJfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzAuYwo+
IGluZGV4IGM0NDFlNmNlOTVlYy4uOTg4YzBhZGFjYTkxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92Y25fdjJfMC5jCj4gQEAgLTEwMTAsOCArMTAxMCw4IEBAIHN0YXRpYyBpbnQgdmNu
X3YyXzBfc3RhcnRfZHBnX21vZGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGJvb2wgaW5k
aXJlY3QpCj4gICAKPiAgIAlpZiAoaW5kaXJlY3QpCj4gICAJCXBzcF91cGRhdGVfdmNuX3NyYW0o
YWRldiwgMCwgYWRldi0+dmNuLmRwZ19zcmFtX2dwdV9hZGRyLAo+IC0JCQkodWludDMyX3QpKCh1
aW50NjRfdClhZGV2LT52Y24uZHBnX3NyYW1fY3Vycl9hZGRyIC0KPiAtCQkJKHVpbnQ2NF90KWFk
ZXYtPnZjbi5kcGdfc3JhbV9jcHVfYWRkcikpOwo+ICsJCQkJICAgICh1aW50MzJfdCkoKHVpbnRw
dHJfdClhZGV2LT52Y24uZHBnX3NyYW1fY3Vycl9hZGRyIC0KPiArCQkJCQkgICAgICAgKHVpbnRw
dHJfdClhZGV2LT52Y24uZHBnX3NyYW1fY3B1X2FkZHIpKTsKPiAgIAo+ICAgCS8qIGZvcmNlIFJC
QyBpbnRvIGlkbGUgc3RhdGUgKi8KPiAgIAlyYl9idWZzeiA9IG9yZGVyX2Jhc2VfMihyaW5nLT5y
aW5nX3NpemUpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
