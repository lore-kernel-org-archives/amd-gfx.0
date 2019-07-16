From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/psp11: check if prior to navi10 for sram map
Date: Tue, 16 Jul 2019 15:55:15 +0000
Message-ID: <20190716155456.11236-1-xiaojie.yuan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "tao1.zhou-5C7GfCeVMHo@public.gmane.org" <tao1.zhou-5C7GfCeVMHo@public.gmane.org>, "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZdWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYyB8IDQgKystLQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3BzcF92MTFfMC5jCmluZGV4IDg3NTk2YzY5YjIzNS4uYThiNTI2ZGJiNmM2IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYwpAQCAtNTM4LDcgKzUzOCw3IEBAIHBz
cF92MTFfMF9zcmFtX21hcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAogCWNhc2UgQU1E
R1BVX1VDT0RFX0lEX1JMQ19HOgogCQkqc3JhbV9vZmZzZXQgPSAweDIwMDA7Ci0JCWlmIChhZGV2
LT5hc2ljX3R5cGUgIT0gQ0hJUF9OQVZJMTApIHsKKwkJaWYgKGFkZXYtPmFzaWNfdHlwZSA8IENI
SVBfTkFWSTEwKSB7CiAJCQkqc3JhbV9hZGRyX3JlZ19vZmZzZXQgPSBTT0MxNV9SRUdfT0ZGU0VU
KEdDLCAwLCBtbVJMQ19HUE1fVUNPREVfQUREUik7CiAJCQkqc3JhbV9kYXRhX3JlZ19vZmZzZXQg
PSBTT0MxNV9SRUdfT0ZGU0VUKEdDLCAwLCBtbVJMQ19HUE1fVUNPREVfREFUQSk7CiAJCX0KQEAg
LTU1MCw3ICs1NTAsNyBAQCBwc3BfdjExXzBfc3JhbV9tYXAoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsCiAKIAljYXNlIEFNREdQVV9VQ09ERV9JRF9TRE1BMDoKIAkJKnNyYW1fb2Zmc2V0ID0g
MHgwOwotCQlpZiAoYWRldi0+YXNpY190eXBlICE9IENISVBfTkFWSTEwKSB7CisJCWlmIChhZGV2
LT5hc2ljX3R5cGUgPCBDSElQX05BVkkxMCkgewogCQkJKnNyYW1fYWRkcl9yZWdfb2Zmc2V0ID0g
U09DMTVfUkVHX09GRlNFVChTRE1BMCwgMCwgbW1TRE1BMF9VQ09ERV9BRERSKTsKIAkJCSpzcmFt
X2RhdGFfcmVnX29mZnNldCA9IFNPQzE1X1JFR19PRkZTRVQoU0RNQTAsIDAsIG1tU0RNQTBfVUNP
REVfREFUQSk7CiAJCX0KLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
