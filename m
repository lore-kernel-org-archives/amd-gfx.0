From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 10/10] drm/amd/powerplay: no need to mask workable gfxoff
 feature for vega12
Date: Thu, 5 Jul 2018 17:09:35 +0800
Message-ID: <20180705090935.9638-10-evan.quan@amd.com>
References: <20180705090935.9638-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180705090935.9638-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

R2Z4b2ZmIGZlYXR1cmUgZm9yIHZlZ2ExMiBpcyB3b3JrYWJsZS4gU28sIHRoZXJlIGlzIG5vIG5l
ZWQgdG8KbWFzayBpdCBhbnkgbW9yZS4KCkNoYW5nZS1JZDogSTdlNGQwNWM1YzBhY2MyYWEyYjA3
N2VhYWFmNmYxMzU4OWM4NzExNGIKU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5A
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9od21nci5j
IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvaHdtZ3IuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2h3bWdyLmMKaW5kZXggOWI2NzVk
OWJkMTYyLi44OTk0YWE1YzhjZjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2h3bWdyL2h3bWdyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
aHdtZ3IvaHdtZ3IuYwpAQCAtMTQ3LDEwICsxNDcsMTAgQEAgaW50IGh3bWdyX2Vhcmx5X2luaXQo
c3RydWN0IHBwX2h3bWdyICpod21ncikKIAkJc211N19pbml0X2Z1bmN0aW9uX3BvaW50ZXJzKGh3
bWdyKTsKIAkJYnJlYWs7CiAJY2FzZSBBTURHUFVfRkFNSUxZX0FJOgotCQlod21nci0+ZmVhdHVy
ZV9tYXNrICY9IH5QUF9HRlhPRkZfTUFTSzsKIAkJc3dpdGNoIChod21nci0+Y2hpcF9pZCkgewog
CQljYXNlIENISVBfVkVHQTEwOgogCQljYXNlIENISVBfVkVHQTIwOgorCQkJaHdtZ3ItPmZlYXR1
cmVfbWFzayAmPSB+UFBfR0ZYT0ZGX01BU0s7CiAJCQlod21nci0+c211bWdyX2Z1bmNzID0gJnZl
Z2ExMF9zbXVfZnVuY3M7CiAJCQl2ZWdhMTBfaHdtZ3JfaW5pdChod21ncik7CiAJCQlicmVhazsK
LS0gCjIuMTguMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
