From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/8] drm/amdgpu/uvd7: add emit_reg_write_reg_wait ring callback
Date: Tue, 27 Mar 2018 17:32:55 -0500
Message-ID: <20180327223258.10638-5-alexander.deucher@amd.com>
References: <20180327223258.10638-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180327223258.10638-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

VGhpcyBhZGRzIHN1cHBvcnQgZm9yIHdyaXRpbmcgYW5kIHJlYWRpbmcgYmFjayB1c2luZyB0aGUK
aGVscGVyIHNpbmNlIHRoZSBlbmdpbmVzIGRvZXNuJ3QgaGF2ZSBhIG9uZXNob3QgcGFja2V0LgoK
U2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92N18wLmMgfCAxICsKIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3V2ZF92N18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjdfMC5j
CmluZGV4IGVkZGM1N2YzYjcyYS4uMjgwYzA4MjZlMTgzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS91dmRfdjdfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3V2ZF92N18wLmMKQEAgLTE3MDIsNiArMTcwMiw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
YW1kZ3B1X3JpbmdfZnVuY3MgdXZkX3Y3XzBfZW5jX3Jpbmdfdm1fZnVuY3MgPSB7CiAJLmVuZF91
c2UgPSBhbWRncHVfdXZkX3JpbmdfZW5kX3VzZSwKIAkuZW1pdF93cmVnID0gdXZkX3Y3XzBfZW5j
X3JpbmdfZW1pdF93cmVnLAogCS5lbWl0X3JlZ193YWl0ID0gdXZkX3Y3XzBfZW5jX3JpbmdfZW1p
dF9yZWdfd2FpdCwKKwkuZW1pdF9yZWdfd3JpdGVfcmVnX3dhaXQgPSBhbWRncHVfcmluZ19lbWl0
X3JlZ193cml0ZV9yZWdfd2FpdF9oZWxwZXIsCiB9OwogCiBzdGF0aWMgdm9pZCB1dmRfdjdfMF9z
ZXRfcmluZ19mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKLS0gCjIuMTMuNgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
