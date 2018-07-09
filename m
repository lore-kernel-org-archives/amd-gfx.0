From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu: get VCN start to process in the dpm disabled
 case
Date: Mon,  9 Jul 2018 12:11:37 -0400
Message-ID: <20180709161138.5319-2-leo.liu@amd.com>
References: <20180709161138.5319-1-leo.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180709161138.5319-1-leo.liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>

Rml4ZXM6IDIyY2M2YzVlMTkgKGRybS9hbWRncHU6IEFkZCBydW50aW1lIFZDTiBQRyBzdXBwb3J0
KQoKU2lnbmVkLW9mZi1ieTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92Y24uYwppbmRleCA0YTM0NTcyMzZlODUuLjc2OWM2NzIzYzljYSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwpAQCAtMjI5LDcgKzIyOSw3IEBAIHZvaWQgYW1k
Z3B1X3Zjbl9yaW5nX2JlZ2luX3VzZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCiAJc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2OwogCWJvb2wgc2V0X2Nsb2NrcyA9ICFj
YW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPnZjbi5pZGxlX3dvcmspOwogCi0JaWYgKHNl
dF9jbG9ja3MgJiYgYWRldi0+cG0uZHBtX2VuYWJsZWQpIHsKKwlpZiAoc2V0X2Nsb2Nrcykgewog
CQlpZiAoYWRldi0+cG0uZHBtX2VuYWJsZWQpCiAJCQlhbWRncHVfZHBtX2VuYWJsZV91dmQoYWRl
diwgdHJ1ZSk7CiAJCWVsc2UKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
