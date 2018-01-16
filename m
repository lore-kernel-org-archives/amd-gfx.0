From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm] drm: fix return value
Date: Tue, 16 Jan 2018 10:54:01 +0800
Message-ID: <20180116025401.18906-1-david1.zhou@amd.com>
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
Cc: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Seth.Zhu-5C7GfCeVMHo@public.gmane.org

b3RoZXJ3aXNlIC1FVElNRSBpcyBtaXNzZWQuCgpDaGFuZ2UtSWQ6IEljNTU4MGE3NGQ4MDI3Y2M0
NjhjNjEzNWY4Y2YyZjgxODE3OTkzNDIzClNpZ25lZC1vZmYtYnk6IENodW5taW5nIFpob3UgPGRh
dmlkMS56aG91QGFtZC5jb20+Ci0tLQogeGY4NmRybS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEveGY4NmRybS5jIGIv
eGY4NmRybS5jCmluZGV4IDhhMzI3MTcwLi4zODgxYmQ5ZiAxMDA2NDQKLS0tIGEveGY4NmRybS5j
CisrKyBiL3hmODZkcm0uYwpAQCAtNDI0MSw3ICs0MjQxLDcgQEAgaW50IGRybVN5bmNvYmpXYWl0
KGludCBmZCwgdWludDMyX3QgKmhhbmRsZXMsIHVuc2lnbmVkIG51bV9oYW5kbGVzLAogCiAJcmV0
ID0gZHJtSW9jdGwoZmQsIERSTV9JT0NUTF9TWU5DT0JKX1dBSVQsICZhcmdzKTsKIAlpZiAocmV0
IDwgMCkKLQkJcmV0dXJuIHJldDsKKwkJcmV0dXJuIC1lcnJubzsKIAogCWlmIChmaXJzdF9zaWdu
YWxlZCkKIAkJKmZpcnN0X3NpZ25hbGVkID0gYXJncy5maXJzdF9zaWduYWxlZDsKLS0gCjIuMTQu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
