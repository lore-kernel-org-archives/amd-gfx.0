From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gmc9: clarify GPUVM fault error message
Date: Wed, 25 Jul 2018 14:49:21 +0800
Message-ID: <5B581D71.9000702@amd.com>
References: <20180724165414.24442-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180724165414.24442-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

T24gMDcvMjUvMjAxOCAxMjo1NCBBTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IFRoZSBhZGRyZXNz
IHByaW50ZWQgaXMgdGhlIGFjdHVhbCBhZGRyZXNzLCBub3QgdGhlIHBhZ2UuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CiAgUmV2aWV3
ZWQtYnk6IEp1bndlaSBaaGFuZyA8SmVycnkuWmhhbmdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dtY192OV8wLmMKPiBpbmRleCA5ZGY5NGI0NWQxN2QuLjM5OWE1ZGIyNzY0OSAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+IEBAIC0yNjksNyArMjY5LDcgQEAg
c3RhdGljIGludCBnbWNfdjlfMF9wcm9jZXNzX2ludGVycnVwdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwKPiAgIAkJCWVudHJ5LT5zcmNfaWQsIGVudHJ5LT5yaW5nX2lkLCBlbnRyeS0+dm1p
ZCwKPiAgIAkJCWVudHJ5LT5wYXNpZCwgdGFza19pbmZvLnByb2Nlc3NfbmFtZSwgdGFza19pbmZv
LnRnaWQsCj4gICAJCQl0YXNrX2luZm8udGFza19uYW1lLCB0YXNrX2luZm8ucGlkKTsKPiAtCQlk
ZXZfZXJyKGFkZXYtPmRldiwgIiAgYXQgcGFnZSAweCUwMTZsbHggZnJvbSAlZFxuIiwKPiArCQlk
ZXZfZXJyKGFkZXYtPmRldiwgIiAgYXQgYWRkcmVzcyAweCUwMTZsbHggZnJvbSAlZFxuIiwKPiAg
IAkJCWFkZHIsIGVudHJ5LT5jbGllbnRfaWQpOwo+ICAgCQlpZiAoIWFtZGdwdV9zcmlvdl92Zihh
ZGV2KSkKPiAgIAkJCWRldl9lcnIoYWRldi0+ZGV2LAo+Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
