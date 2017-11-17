From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gmc9: make some ECC messages debug only
Date: Fri, 17 Nov 2017 17:43:41 +0100
Message-ID: <56facc5c-d67e-0688-20e9-082cbd5bd306@gmail.com>
References: <20171117164154.3617-1-alexander.deucher@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171117164154.3617-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

QW0gMTcuMTEuMjAxNyB1bSAxNzo0MSBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBUbyBhdm9pZCBz
cGFtbWluZyB0aGUgbG9ncyBvbiBub24tRUNDIGJvYXJkcy4KPgo+IFNpZ25lZC1vZmYtYnk6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyB8IDQgKystLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y5XzAuYwo+IGluZGV4IDc5OGY3ZmMyZDRlOS4uODUyOTAwNWE1MDIyIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4gQEAgLTU3MSwxMSArNTcxLDEx
IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfZWNjX2F2YWlsYWJsZShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKPiAgIAkJCSAgcmVnX3ZhbCwgZmllbGRfdmFsLCBmdjIpOwo+ICAgCj4gICAJCWlm
ICghZmllbGRfdmFsKSB7Cj4gLQkJCURSTV9FUlJPUigiZWNjOiBXckVjY0VuIGlzIG5vdCBzZXRc
biIpOwo+ICsJCQlEUk1fREVCVUcoImVjYzogV3JFY2NFbiBpcyBub3Qgc2V0XG4iKTsKPiAgIAkJ
CSsrbG9zdF9zaGVlcDsKPiAgIAkJfQo+ICAgCQlpZiAoIWZ2Mikgewo+IC0JCQlEUk1fRVJST1Io
ImVjYzogUmRFY2NFbiBpcyBub3Qgc2V0XG4iKTsKPiArCQkJRFJNX0RFQlVHKCJlY2M6IFJkRWNj
RW4gaXMgbm90IHNldFxuIik7Cj4gICAJCQkrK2xvc3Rfc2hlZXA7Cj4gICAJCX0KPiAgIAl9CgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
