From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: delete duplicated printk info.
Date: Thu, 30 Mar 2017 15:43:05 +0900
Message-ID: <8ee19fae-cb5f-2fb7-8ce5-16670f2d4b7f@daenzer.net>
References: <1490852538-13276-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490852538-13276-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMzAvMDMvMTcgMDI6NDIgUE0sIFJleCBaaHUgd3JvdGU6Cj4gQ2hhbmdlLUlkOiBJNWYzMzZj
YzQxYjE4NjhiOThmMjYzODc0ZmU1YzZlYTIwZTQzMDc0NAo+IFNpZ25lZC1vZmYtYnk6IFJleCBa
aHUgPFJleC5aaHVAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jIHwgMyAtLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0p
Cj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+IGluZGV4
IDU3Y2NhYzQuLmVhZjQ0ZmIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jCj4gQEAgLTIyODgsOSArMjI4OCw2IEBAIGludCBhbWRncHVfZGV2aWNlX3Jl
c3VtZShzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBib29sIHJlc3VtZSwgYm9vbCBmYmNvbikKPiAg
CWlmIChyKQo+ICAJCURSTV9FUlJPUigiYW1kZ3B1X3Jlc3VtZSBmYWlsZWQgKCVkKS5cbiIsIHIp
Owo+ICAKPiAtCWlmIChyKQo+IC0JCURSTV9FUlJPUigiYW1kZ3B1X3Jlc3VtZSBmYWlsZWQgKCVk
KS5cbiIsIHIpOwo+IC0KPiAgCWFtZGdwdV9mZW5jZV9kcml2ZXJfcmVzdW1lKGFkZXYpOwo+ICAK
PiAgCWlmIChyZXN1bWUpIHsKPiAKClJldmlld2VkLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVs
LmRhZW56ZXJAYW1kLmNvbT4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBl
bnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
