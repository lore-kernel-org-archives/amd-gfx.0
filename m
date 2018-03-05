From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] drm/amdgpu: remove useless variable
Date: Mon, 5 Mar 2018 13:28:36 -0500
Message-ID: <CADnq5_OpGD0Sq8p0YhCFg1TakP2kOJcFbN3UptbRuCMVQDZ2Hw@mail.gmail.com>
References: <1520222976-18814-1-git-send-email-Monk.Liu@amd.com>
 <1520222976-18814-2-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1520222976-18814-2-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gU3VuLCBNYXIgNCwgMjAxOCBhdCAxMTowOSBQTSwgTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5j
b20+IHdyb3RlOgo+IENoYW5nZS1JZDogSWVjOTZjNzc2MmQ3OTExNjRjNzE5ZWM2NGVjNDEwZTAw
YThjZjVkOTAKPiBTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KCkFs
cmVhZHkgZml4ZWQgaW4gYW1kLXN0YWdpbmctZHJtLW5leHQuCgpBbGV4Cgo+IC0tLQo+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jIHwgMiArLQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYwo+IGluZGV4IDQzY2UyZTUuLjQyYzE0MDEgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMKPiBAQCAtMTQxLDcgKzE0MSw3
IEBAIHVpbnQzMl90IGFtZGdwdV92aXJ0X2tpcV9ycmVnKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LCB1aW50MzJfdCByZWcpCj4gIHsKPiAgICAgICAgIHNpZ25lZCBsb25nIHIsIGNudCA9IDA7
Cj4gICAgICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOwo+IC0gICAgICAgdWludDMyX3QgdmFsLCBz
ZXE7Cj4gKyAgICAgICB1aW50MzJfdCBzZXE7Cj4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2tpcSAq
a2lxID0gJmFkZXYtPmdmeC5raXE7Cj4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcg
PSAma2lxLT5yaW5nOwo+Cj4gLS0KPiAyLjcuNAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
