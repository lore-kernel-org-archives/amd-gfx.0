From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 13/17] drm/amdkfd: increase limit of signal events to 4096 per
 process
Date: Fri, 27 Oct 2017 19:35:30 -0400
Message-ID: <1509147334-16281-14-git-send-email-Felix.Kuehling@amd.com>
References: <1509147334-16281-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1509147334-16281-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>

RnJvbTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGFtZC5jb20+CgpTaWduZWQtb2ZmLWJ5OiBP
ZGVkIEdhYmJheSA8b2RlZC5nYWJiYXlAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEJlbiBHb3ogPGJl
bi5nb3pAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhs
aW5nQGFtZC5jb20+Ci0tLQogaW5jbHVkZS91YXBpL2xpbnV4L2tmZF9pb2N0bC5oIHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS91YXBpL2xpbnV4L2tmZF9pb2N0bC5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2tm
ZF9pb2N0bC5oCmluZGV4IDI2MjgzZmUuLjczMWQwZGYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFw
aS9saW51eC9rZmRfaW9jdGwuaAorKysgYi9pbmNsdWRlL3VhcGkvbGludXgva2ZkX2lvY3RsLmgK
QEAgLTE2OSw3ICsxNjksNyBAQCBzdHJ1Y3Qga2ZkX2lvY3RsX2RiZ193YXZlX2NvbnRyb2xfYXJn
cyB7CiAjZGVmaW5lIEtGRF9JT0NfV0FJVF9SRVNVTFRfVElNRU9VVAkJMQogI2RlZmluZSBLRkRf
SU9DX1dBSVRfUkVTVUxUX0ZBSUwJCTIKIAotI2RlZmluZSBLRkRfU0lHTkFMX0VWRU5UX0xJTUlU
CQkJMjU2CisjZGVmaW5lIEtGRF9TSUdOQUxfRVZFTlRfTElNSVQJCQk0MDk2CiAKIHN0cnVjdCBr
ZmRfaW9jdGxfY3JlYXRlX2V2ZW50X2FyZ3MgewogCV9fdTY0IGV2ZW50X3BhZ2Vfb2Zmc2V0Owkv
KiBmcm9tIEtGRCAqLwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
