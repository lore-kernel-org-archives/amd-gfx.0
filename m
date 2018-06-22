From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: band aid validating VM PTs
Date: Fri, 22 Jun 2018 08:52:10 +0800
Message-ID: <5B2C483A.3000305@amd.com>
References: <20180619125700.55218-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180619125700.55218-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDYvMTkvMjAxOCAwODo1NyBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbHdheXMg
dmFsaWRhdGluZyB0aGUgVk0gUFRzIHRha2VzIHRvIG11Y2ggdGltZS4gT25seSBhbHdheXMgdmFs
aWRhdGUKPiB0aGUgcGVyIFZNIEJPcyBmb3Igbm93Lgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogSnVud2Vp
IFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYwo+IGluZGV4IDgxOTk0OTQxODQ5NS4uN2MzMDQ1MWJhODk3IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtMTA4Miw3ICsxMDgyLDcgQEAgaW50IGFt
ZGdwdV92bV91cGRhdGVfZGlyZWN0b3JpZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4g
ICAJCQkJCSAgIHN0cnVjdCBhbWRncHVfdm1fYm9fYmFzZSwKPiAgIAkJCQkJICAgdm1fc3RhdHVz
KTsKPiAgIAkJYm9fYmFzZS0+bW92ZWQgPSBmYWxzZTsKPiAtCQlsaXN0X21vdmUoJmJvX2Jhc2Ut
PnZtX3N0YXR1cywgJnZtLT5pZGxlKTsKPiArCQlsaXN0X2RlbF9pbml0KCZib19iYXNlLT52bV9z
dGF0dXMpOwo+Cj4gICAJCWJvID0gYm9fYmFzZS0+Ym8tPnBhcmVudDsKPiAgIAkJaWYgKCFibykK
PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
