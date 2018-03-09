From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: save/restore backlight level in legacy dce
 code
Date: Fri, 9 Mar 2018 09:44:34 +0100
Message-ID: <f7b2d0c0-fd9a-46bb-d39d-609740f3866b@daenzer.net>
References: <20180308202156.16314-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180308202156.16314-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wMy0wOCAwOToyMSBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IFNhdmUvcmVzdG9y
ZSB0aGUgYmFja2xpZ2h0IGxldmVsIHNjcmF0Y2ggcmVnaXN0ZXIgaW4gUzMvUzQgc28gdGhlCj4g
YmFja2xpZ2h0IGxldmVsIGNvbWVzIGJhY2sgYXQgdGhlIHByZXZpb3VzbHkgcmVxdWVzdGVkIGxl
dmVsLgo+IAo+IEJ1ZzogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9p
ZD0xOTkwNDcKPiBGaXhlczogNGVjNmVjZjQ4YzY0ZCAoZHJtL2FtZGdwdTogZHJvcCBzY3JhdGNo
IHJlZ3Mgc2F2ZSBhbmQgcmVzdG9yZSBmcm9tIFMzL1M0IGhhbmRsaW5nKQo+IFNpZ25lZC1vZmYt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCkFja2VkLWJ5OiBN
aWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KCk1pZ2h0IGJlIG5pY2UgdG8g
Z2V0IEhhcnJ5IG9yIHNvbWVvbmUgZWxzZSBmcm9tIHRoZSBkaXNwbGF5IHRlYW0gdG8gdGFrZQph
IGxvb2sgYXMgd2VsbC4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRo
dXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
