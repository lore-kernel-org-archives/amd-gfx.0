From: Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amd/amdgpu: fix console deadlock if late init failed
Date: Wed, 1 Mar 2017 17:35:38 +0800
Message-ID: <1488360939-5030-2-git-send-email-Jim.Qu@amd.com>
References: <1488360939-5030-1-git-send-email-Jim.Qu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1488360939-5030-1-git-send-email-Jim.Qu-5C7GfCeVMHo@public.gmane.org>
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

Q2hhbmdlLUlkOiBJYTkxNGZhYzA4M2ViYWIzOTYxN2RhZDA0NmQ0YmI5OGFiMWRkZjBhOApTaWdu
ZWQtb2ZmLWJ5OiBKaW0gUXUgPEppbS5RdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDUgKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMKaW5kZXggYzA2NzlkMy4uNmVlZGEyNCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMjE4Niw4ICsyMTg2LDExIEBAIGludCBh
bWRncHVfZGV2aWNlX3Jlc3VtZShzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBib29sIHJlc3VtZSwg
Ym9vbCBmYmNvbikKIAl9CiAKIAlyID0gYW1kZ3B1X2xhdGVfaW5pdChhZGV2KTsKLQlpZiAocikK
KwlpZiAocikgeworCQlpZiAoZmJjb24pCisJCQljb25zb2xlX3VubG9jaygpOwogCQlyZXR1cm4g
cjsKKwl9CiAKIAkvKiBwaW4gY3Vyc29ycyAqLwogCWxpc3RfZm9yX2VhY2hfZW50cnkoY3J0Yywg
JmRldi0+bW9kZV9jb25maWcuY3J0Y19saXN0LCBoZWFkKSB7Ci0tIAoxLjkuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
