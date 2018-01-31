From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 03/27] drm/amd/display: Remove return when no EDID read.
Date: Wed, 31 Jan 2018 10:59:02 -0500
Message-ID: <20180131155926.11161-4-harry.wentland@amd.com>
References: <20180131155926.11161-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180131155926.11161-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Martin Tsai <martin.tsai-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTWFydGluIFRzYWkgPG1hcnRpbi50c2FpQGFtZC5jb20+CgpTaWduZWQtb2ZmLWJ5OiBN
YXJ0aW4gVHNhaSA8bWFydGluLnRzYWlAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IFRvbnkgQ2hlbmcg
PFRvbnkuQ2hlbmdAYW1kLmNvbT4KQWNrZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50
bGFuZEBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2Rj
X2xpbmsuYyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYwppbmRleCAwMDIzNzU0ZTAz
NGIuLmE2NzhmYzAxMjk3NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGNfbGluay5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9j
b3JlL2RjX2xpbmsuYwpAQCAtNjc4LDggKzY3OCw2IEBAIGJvb2wgZGNfbGlua19kZXRlY3Qoc3Ry
dWN0IGRjX2xpbmsgKmxpbmssIGVudW0gZGNfZGV0ZWN0X3JlYXNvbiByZWFzb24pCiAJCWNhc2Ug
RURJRF9OT19SRVNQT05TRToKIAkJCWRtX2xvZ2dlcl93cml0ZShsaW5rLT5jdHgtPmxvZ2dlciwg
TE9HX0VSUk9SLAogCQkJCSJObyBFRElEIHJlYWQuXG4iKTsKLQkJCXJldHVybiBmYWxzZTsKLQog
CQlkZWZhdWx0OgogCQkJYnJlYWs7CiAJCX0KLS0gCjIuMTQuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
