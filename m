From: Guchun Chen <guchun.chen-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm] amdgpu: add mmhub ras inject unit test
Date: Fri, 16 Aug 2019 19:04:01 +0800
Message-ID: <20190816110401.11069-1-guchun.chen@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Hawking.Zhang-5C7GfCeVMHo@public.gmane.org, Dennis.Li-5C7GfCeVMHo@public.gmane.org, flora.cui-5C7GfCeVMHo@public.gmane.org, Tao.Zhou1-5C7GfCeVMHo@public.gmane.org
Cc: Candice.Li-5C7GfCeVMHo@public.gmane.org, Guchun Chen <guchun.chen-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJYTc2Yjk1MTYyZjVmNmY0MTlmNzBiNTNlZjQ0M2JjZWFmMmUwOTJlMApTaWdu
ZWQtb2ZmLWJ5OiBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4KLS0tCiBkYXRhL2Ft
ZGdwdV9yYXMuanNvbiB8IDEwICsrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZGF0YS9hbWRncHVfcmFzLmpzb24gYi9kYXRhL2FtZGdwdV9y
YXMuanNvbgppbmRleCAyNmZkOTQ2NS4uNDg0ZjEyZjIgMTAwNjQ0Ci0tLSBhL2RhdGEvYW1kZ3B1
X3Jhcy5qc29uCisrKyBiL2RhdGEvYW1kZ3B1X3Jhcy5qc29uCkBAIC0xMjEsNiArMTIxLDkgQEAK
ICAgICAgICAgICAgICAgICAidXRjX2F0Y2wyX2NhY2hlXzRrX2JhbmsiOiAxMTEKICAgICAgICAg
ICAgIH0KICAgICAgICAgfSwKKyAgICAgICAgIm1taHViIjogeworICAgICAgICAgICAgImluZGV4
IjogMworICAgICAgICB9LAogICAgIH0sCiAgICAgInR5cGUiOiB7CiAgICAgICAgICJwYXJpdHki
OiAxLApAQCAtMjYzLDUgKzI2NiwxMiBAQAogICAgICAgICAgICAgImFkZHJlc3MiOiAwLAogICAg
ICAgICAgICAgInZhbHVlIjogMAogICAgICAgICB9LAorICAgICAgICB7CisgICAgICAgICAgICAi
bmFtZSI6ICJyYXNfbW1odWIuMS4wIiwKKyAgICAgICAgICAgICJibG9jayI6ICJtbWh1YiIsCisg
ICAgICAgICAgICAidHlwZSI6ICJzaW5nbGVfY29ycmVjdGFibGUiLAorICAgICAgICAgICAgImFk
ZHJlc3MiOiAwLAorICAgICAgICAgICAgInZhbHVlIjogMAorICAgICAgICB9LAogICAgIF0KIH0K
LS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
