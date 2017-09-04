From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gfx9: properly set the hdp flush reg for Raven
Date: Mon, 4 Sep 2017 09:53:35 +0800
Message-ID: <59ACB21F.6070004@amd.com>
References: <1504333124-18129-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1504333124-18129-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

T24gMDkvMDIvMjAxNyAwMjoxOCBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IFdhcyBvbmx5IGJl
aW5nIGFzc2lnbmVkIGZvciB2ZWdhMTAuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+ClJldmlld2VkLWJ5OiBKdW53ZWkgWmhhbmcgPEpl
cnJ5LlpoYW5nQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y5XzAuYyB8IDQgKysrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4gaW5k
ZXggNjZmOTJjOC4uN2ZmNjI0MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5
XzAuYwo+IEBAIC0zNTE0LDcgKzM1MTQsOSBAQCBzdGF0aWMgdm9pZCBnZnhfdjlfMF9yaW5nX2Vt
aXRfaGRwX2ZsdXNoKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKPiAgIAl1MzIgcmVmX2FuZF9t
YXNrLCByZWdfbWVtX2VuZ2luZTsKPiAgIAlzdHJ1Y3QgbmJpb19oZHBfZmx1c2hfcmVnICpuYmlv
X2hmX3JlZzsKPgo+IC0JaWYgKHJpbmctPmFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFR0ExMCkK
PiArCWlmIChyaW5nLT5hZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpCj4gKwkJbmJpb19oZl9yZWcg
PSAmbmJpb192N18wX2hkcF9mbHVzaF9yZWc7Cj4gKwllbHNlCj4gICAJCW5iaW9faGZfcmVnID0g
Jm5iaW9fdjZfMV9oZHBfZmx1c2hfcmVnOwo+Cj4gICAJaWYgKHJpbmctPmZ1bmNzLT50eXBlID09
IEFNREdQVV9SSU5HX1RZUEVfQ09NUFVURSkgewo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
