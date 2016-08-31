From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 05/15] drm/amdgpu: remove unused function forward define
Date: Wed, 31 Aug 2016 13:23:17 +0800
Message-ID: <1472621007-17578-6-git-send-email-ray.huang@amd.com>
References: <1472621007-17578-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472621007-17578-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Hui Yu <Hui.Yu-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

VGhlIGZ1bmN0aW9ucyBkb24ndCBleGlzdHMgYW55IG1vcmUuCgpSZXZpZXdlZC1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBIdWFuZyBS
dWkgPHJheS5odWFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Np
X2RwbS5jIHwgMyAtLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc2lfZHBtLmMKaW5kZXggZDY2NDM1ZC4uZmE1NjE4NCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc2lfZHBtLmMKQEAgLTE4MjgsOSArMTgyOCw2IEBAIHN0cnVjdCBldmVyZ3Jl
ZW5fcG93ZXJfaW5mbyAqZXZlcmdyZWVuX2dldF9waShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dik7CiBzdHJ1Y3QgbmlfcG93ZXJfaW5mbyAqbmlfZ2V0X3BpKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KTsKIHN0cnVjdCAgc2lfcHMgKnNpX2dldF9wcyhzdHJ1Y3QgYW1kZ3B1X3BzICpycHMp
OwogCi1leHRlcm4gaW50IHNpX21jX2xvYWRfbWljcm9jb2RlKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KTsKLWV4dGVybiB2b2lkIHZjZV92MV8wX2VuYWJsZV9tZ2NnKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LCBib29sIGVuYWJsZSk7Ci0KIHN0YXRpYyBpbnQgc2lfcG9wdWxhdGVfdm9s
dGFnZV92YWx1ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCQkgICAgIGNvbnN0IHN0
cnVjdCBhdG9tX3ZvbHRhZ2VfdGFibGUgKnRhYmxlLAogCQkJCSAgICAgdTE2IHZhbHVlLCBTSVNM
QU5EU19TTUNfVk9MVEFHRV9WQUxVRSAqdm9sdGFnZSk7Ci0tIAoyLjcuNAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
