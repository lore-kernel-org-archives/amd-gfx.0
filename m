From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/sdma5: do not execute 0-sized IBs (v2)
Date: Wed, 23 Oct 2019 09:33:03 +0200
Message-ID: <b3ddc981-c465-b008-705a-d01e44b783e3@gmail.com>
References: <20191022172136.15391-1-pierre-eric.pelloux-prayer@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191022172136.15391-1-pierre-eric.pelloux-prayer-5C7GfCeVMHo@public.gmane.org>
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
To: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMjIuMTAuMTkgdW0gMTk6MjIgc2NocmllYiBQZWxsb3V4LXByYXllciwgUGllcnJlLWVyaWM6
Cj4gVGhpcyBzZWVtcyB0byBoZWxwIHdpdGggaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9z
aG93X2J1Zy5jZ2k/aWQ9MTExNDgxLgo+Cj4gdjI6IGluc2VydCBhIE5PUCBpbnN0ZWFkIG9mIHNr
aXBwaW5nIGFsbCAwLXNpemVkIElCcyB0byBhdm9pZCBicmVha2luZyBvbGRlciBodwo+Cj4gU2ln
bmVkLW9mZi1ieTogUGllcnJlLUVyaWMgUGVsbG91eC1QcmF5ZXIgPHBpZXJyZS1lcmljLnBlbGxv
dXgtcHJheWVyQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192MTBfMC5jIHwgMSArCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCj4gaW5kZXggZmI0ODYyMmMyYWJk
Li42ZTFiMjViZDFmZTcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z21jX3YxMF8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAu
Ywo+IEBAIC0zMDksNiArMzA5LDcgQEAgc3RhdGljIHZvaWQgZ21jX3YxMF8wX2ZsdXNoX2dwdV90
bGIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQsCj4gICAKPiAgIAlq
b2ItPnZtX3BkX2FkZHIgPSBhbWRncHVfZ21jX3BkX2FkZHIoYWRldi0+Z2FydC5ibyk7Cj4gICAJ
am9iLT52bV9uZWVkc19mbHVzaCA9IHRydWU7Cj4gKwlqb2ItPmlicy0+cHRyW2pvYi0+aWJzLT5s
ZW5ndGhfZHcrK10gPSByaW5nLT5mdW5jcy0+bm9wOwo+ICAgCWFtZGdwdV9yaW5nX3BhZF9pYihy
aW5nLCAmam9iLT5pYnNbMF0pOwo+ICAgCXIgPSBhbWRncHVfam9iX3N1Ym1pdChqb2IsICZhZGV2
LT5tbWFuLmVudGl0eSwKPiAgIAkJCSAgICAgIEFNREdQVV9GRU5DRV9PV05FUl9VTkRFRklORUQs
ICZmZW5jZSk7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
