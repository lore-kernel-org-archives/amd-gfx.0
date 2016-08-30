From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 04/14] drm/amdgpu: remove useless functions of si dpm
Date: Tue, 30 Aug 2016 19:50:01 +0800
Message-ID: <1472557811-8015-5-git-send-email-ray.huang@amd.com>
References: <1472557811-8015-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472557811-8015-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Hui Yu <Hui.Yu-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJZTVmMDc4MDc5ZDY3MzJjYjg3NWYzMWM5ZWI2MmEwNDVmM2NjNDBmMwpTaWdu
ZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jIHwgMyAtLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMKaW5kZXggMDc2ZjZjZC4uYjA2
YzU4MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMKQEAgLTE4MjgsOSArMTgyOCw2
IEBAIHN0cnVjdCBldmVyZ3JlZW5fcG93ZXJfaW5mbyAqZXZlcmdyZWVuX2dldF9waShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldik7CiBzdHJ1Y3QgbmlfcG93ZXJfaW5mbyAqbmlfZ2V0X3BpKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKIHN0cnVjdCAgc2lfcHMgKnNpX2dldF9wcyhzdHJ1
Y3QgYW1kZ3B1X3BzICpycHMpOwogCi1leHRlcm4gaW50IHNpX21jX2xvYWRfbWljcm9jb2RlKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKLWV4dGVybiB2b2lkIHZjZV92MV8wX2VuYWJsZV9t
Z2NnKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBib29sIGVuYWJsZSk7Ci0KIHN0YXRpYyBp
bnQgc2lfcG9wdWxhdGVfdm9sdGFnZV92YWx1ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwK
IAkJCQkgICAgIGNvbnN0IHN0cnVjdCBhdG9tX3ZvbHRhZ2VfdGFibGUgKnRhYmxlLAogCQkJCSAg
ICAgdTE2IHZhbHVlLCBTSVNMQU5EU19TTUNfVk9MVEFHRV9WQUxVRSAqdm9sdGFnZSk7Ci0tIAoy
LjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
