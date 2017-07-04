From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: fix missed asd bo free when hw_fini
Date: Tue, 4 Jul 2017 09:20:31 +0200
Message-ID: <0bf8a0f7-8a47-483e-3b5d-a6eaf1b37b78@amd.com>
References: <1499148650-22409-1-git-send-email-ray.huang@amd.com>
 <1499148650-22409-2-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1499148650-22409-2-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>

QW0gMDQuMDcuMjAxNyB1bSAwODoxMCBzY2hyaWViIEh1YW5nIFJ1aToKPiBTaWduZWQtb2ZmLWJ5
OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgNSArKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwo+
IGluZGV4IDE0NjllNmQuLjdiNDNjNjAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3BzcC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5jCj4gQEAgLTQ0Niw2ICs0NDYsMTEgQEAgc3RhdGljIGludCBwc3BfaHdfZmlu
aSh2b2lkICpoYW5kbGUpCj4gICAJCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmcHNwLT5mZW5jZV9i
dWZfYm8sCj4gICAJCQkJICAgICAgJnBzcC0+ZmVuY2VfYnVmX21jX2FkZHIsICZwc3AtPmZlbmNl
X2J1Zik7Cj4gICAKPiArCWlmIChwc3AtPmFzZF9zaGFyZWRfYm8pCj4gKwkJYW1kZ3B1X2JvX2Zy
ZWVfa2VybmVsKCZwc3AtPmFzZF9zaGFyZWRfYm8sCj4gKwkJCQkgICAgICAmcHNwLT5hc2Rfc2hh
cmVkX21jX2FkZHIsCj4gKwkJCQkgICAgICAmcHNwLT5hc2Rfc2hhcmVkX2J1Zik7Cj4gKwoKR29v
ZCBjYXRjaCwgYnV0IGFnYWluIHBsZWFzZSByZW1vdmUgdGhlICJpZiIuCgpXaXRoIHRoYXQgZml4
ZWQgdGhlIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIAo8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPi4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4gICAJa2ZyZWUocHNwLT5j
bWQpOwo+ICAgCXBzcC0+Y21kID0gTlVMTDsKPiAgIAoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
