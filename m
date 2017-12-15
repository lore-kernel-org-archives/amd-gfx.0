From: Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: restore uvd fence seq in uvd resume
Date: Fri, 15 Dec 2017 15:32:55 +0800
Message-ID: <1513323175-9063-2-git-send-email-Jim.Qu@amd.com>
References: <1513323175-9063-1-git-send-email-Jim.Qu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1513323175-9063-1-git-send-email-Jim.Qu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>

b3RoZXJ3aXNlLCB1dmQgYmxvY2sgd2lsbCBiZSBuZXZlciBwb3dlcmVkIHVwIGluIHJpbmcgYmVn
aW5fdXNlKCkKY2FsbGJhY2suIHV2ZCByaW5nIHRlc3Qgd2lsbCBiZSBmYWlsIGluIHJlc3VtZSBp
biBydW10aW1lIHBtLgoKQ2hhbmdlLUlkOiBJYzYyM2U3ODljYzY4MmVhMDdhZjIyODg5OGY5YWFm
MjI1MTFiYmUyMApTaWduZWQtb2ZmLWJ5OiBKaW0gUXUgPEppbS5RdUBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYyB8IDIgKysKIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdXZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZk
LmMKaW5kZXggODlkNTlmZC4uZTQ0NDg0NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3V2ZC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91dmQuYwpAQCAtMzQ2LDYgKzM0Niw4IEBAIGludCBhbWRncHVfdXZkX3Jlc3VtZShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJCXB0ciArPSBsZTMyX3RvX2NwdShoZHItPnVjb2Rl
X3NpemVfYnl0ZXMpOwogCQl9CiAJCW1lbXNldF9pbyhwdHIsIDAsIHNpemUpOworCQkvKiB0byBy
ZXN0b3JlIHV2ZCBmZW5jZSBzZXEgKi8KKwkJYW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21w
bGV0aW9uKCZhZGV2LT51dmQucmluZyk7CiAJfQogCiAJcmV0dXJuIDA7Ci0tIAoxLjkuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
