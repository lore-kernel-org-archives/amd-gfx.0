From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [patch] drm/radeon: remove some dead code
Date: Wed, 8 Feb 2017 09:43:58 +0900
Message-ID: <579e36be-400f-19b0-9cb6-3de0af62b447@daenzer.net>
References: <20170207131604.GA27416@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170207131604.GA27416@mwanda>
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
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDcvMDIvMTcgMTA6MTYgUE0sIERhbiBDYXJwZW50ZXIgd3JvdGU6Cj4gSWYgInJkZXYtPmJp
b3MiIGlzIE5VTEwgdGhlbiB3ZSBkb24ndCBuZWVkIHRvIGZyZWUgaXQuCj4gCj4gU2lnbmVkLW9m
Zi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPgo+IAo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9iaW9zLmMgYi9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9iaW9zLmMKPiBpbmRleCAwMGNmYjVkMjg3NWYuLjA0YzBlZDQx
Mzc0ZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9iaW9zLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9iaW9zLmMKPiBAQCAtNjM4LDEw
ICs2MzgsOCBAQCBzdGF0aWMgYm9vbCByYWRlb25fYWNwaV92ZmN0X2Jpb3Moc3RydWN0IHJhZGVv
bl9kZXZpY2UgKnJkZXYpCj4gIAkJCQkJICAgICB2aGRyLT5JbWFnZUxlbmd0aCwKPiAgCQkJCQkg
ICAgIEdGUF9LRVJORUwpOwo+ICAKPiAtCQkJaWYgKCFyZGV2LT5iaW9zKSB7Cj4gLQkJCQlrZnJl
ZShyZGV2LT5iaW9zKTsKPiArCQkJaWYgKCFyZGV2LT5iaW9zKQo+ICAJCQkJcmV0dXJuIGZhbHNl
Owo+IC0JCQl9Cj4gIAkJCXJldHVybiB0cnVlOwoKQ291bGQgYmUgc2ltcGxpZmllZCBmdXJ0aGVy
IHRvCgoJCQlyZXR1cm4gcmRldi0+YmlvcyAhPSBOVUxMOwoKb3IgbWF5YmUKCgkJCXJldHVybiAh
IXJkZXYtPmJpb3M7CgpFaXRoZXIgd2F5LAoKUmV2aWV3ZWQtYnk6IE1pY2hlbCBEw6RuemVyIDxt
aWNoZWwuZGFlbnplckBhbWQuY29tPgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3
YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVs
b3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
