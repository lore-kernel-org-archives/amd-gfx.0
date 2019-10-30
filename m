From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/radeon: fix si_enable_smc_cac() failed issue
Date: Wed, 30 Oct 2019 10:22:41 -0400
Message-ID: <20191030142241.1575786-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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

TmVlZCB0byBzZXQgdGhlIGR0ZSBmbGFnIG9uIHRoaXMgYXNpYy4KClBvcnQgdGhlIGZpeCBmcm9t
IGFtZGdwdToKNWNiODE4Yjg2MWJlMTE0MTQ4ZThkYmViNDI1OTY5ODE0ODAxOWRkMQoKU2lnbmVk
LW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jCmluZGV4IDQ2MGZkOThlNDBhNy4uYTBi
MzgyYTYzN2E2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMKQEAgLTE5NTgsNiArMTk1OCw3IEBA
IHN0YXRpYyB2b2lkIHNpX2luaXRpYWxpemVfcG93ZXJ0dW5lX2RlZmF1bHRzKHN0cnVjdCByYWRl
b25fZGV2aWNlICpyZGV2KQogCQljYXNlIDB4NjgyQzoKIAkJCXNpX3BpLT5jYWNfd2VpZ2h0cyA9
IGNhY193ZWlnaHRzX2NhcGVfdmVyZGVfcHJvOwogCQkJc2lfcGktPmR0ZV9kYXRhID0gZHRlX2Rh
dGFfc3VuX3h0OworCQkJdXBkYXRlX2R0ZV9mcm9tX3BsMiA9IHRydWU7CiAJCQlicmVhazsKIAkJ
Y2FzZSAweDY4MjU6CiAJCWNhc2UgMHg2ODI3OgotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
