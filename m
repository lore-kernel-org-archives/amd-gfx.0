From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/si: fix ring size for compute
Date: Thu, 15 Sep 2016 19:43:04 +0200
Message-ID: <0da6f390-cafa-a8f0-be85-2ded7750baf4@vodafone.de>
References: <1473955531-10233-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1473955531-10233-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

QW0gMTUuMDkuMjAxNiB1bSAxODowNSBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBXZSBzd2l0Y2hl
ZCB0aGUgb3RoZXIgYXNpY3MsIGJ1dCBtaXNzZWQgdGhpcy4KPgo+IFNpZ25lZC1vZmYtYnk6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+LgoKPiAtLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92Nl8wLmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjZfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y2XzAuYwo+IGluZGV4IGExNDg0YjguLjk2OTc5OTQgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y2XzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92Nl8wLmMKPiBAQCAtMjc3OSw3ICsyNzc5LDcgQEAgc3RhdGljIGlu
dCBnZnhfdjZfMF9zd19pbml0KHZvaWQgKmhhbmRsZSkKPiAgIAkJcmluZy0+cXVldWUgPSBpOwo+
ICAgCQlzcHJpbnRmKHJpbmctPm5hbWUsICJjb21wICVkLiVkLiVkIiwgcmluZy0+bWUsIHJpbmct
PnBpcGUsIHJpbmctPnF1ZXVlKTsKPiAgIAkJaXJxX3R5cGUgPSBBTURHUFVfQ1BfSVJRX0NPTVBV
VEVfTUVDMV9QSVBFMF9FT1AgKyByaW5nLT5waXBlOwo+IC0JCXIgPSBhbWRncHVfcmluZ19pbml0
KGFkZXYsIHJpbmcsIDEwMjQgKiAxMDI0LAo+ICsJCXIgPSBhbWRncHVfcmluZ19pbml0KGFkZXYs
IHJpbmcsIDEwMjQsCj4gICAJCQkJICAgICAweDgwMDAwMDAwLCAweGYsCj4gICAJCQkJICAgICAm
YWRldi0+Z2Z4LmVvcF9pcnEsIGlycV90eXBlLAo+ICAgCQkJCSAgICAgQU1ER1BVX1JJTkdfVFlQ
RV9DT01QVVRFKTsKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
