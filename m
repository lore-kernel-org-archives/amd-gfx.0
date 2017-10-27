From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 15/17] drm/amdkfd: increase IH num entries to 8192
Date: Fri, 27 Oct 2017 19:35:32 -0400
Message-ID: <1509147334-16281-16-git-send-email-Felix.Kuehling@amd.com>
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
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Andres Rodriguez <andres.rodriguez-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQW5kcmVzIFJvZHJpZ3VleiA8YW5kcmVzLnJvZHJpZ3VlekBhbWQuY29tPgoKQSBsYXJn
ZXIgYnVmZmVyIHdpbGwgbGV0IHVzIGFjY29tbW9kYXRlIGFwcGxpY2F0aW9ucyB3aXRoIGEgbGFy
Z2UgYW1vdW50Cm9mIHNlbWktc2ltdWx0YW5lb3VzIGV2ZW50IHNpZ25hbHMuCgpTaWduZWQtb2Zm
LWJ5OiBBbmRyZXMgUm9kcmlndWV6IDxhbmRyZXMucm9kcmlndWV6QGFtZC5jb20+ClNpZ25lZC1v
ZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpBY2tlZC1ieTog
T2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfaW50ZXJydXB0LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfaW50ZXJydXB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
aW50ZXJydXB0LmMKaW5kZXggZmZiYjkxYS4uYTE0NzI2OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludGVycnVwdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9pbnRlcnJ1cHQuYwpAQCAtNDUsNyArNDUsNyBAQAogI2luY2x1ZGUgPGxp
bnV4L2tmaWZvLmg+CiAjaW5jbHVkZSAia2ZkX3ByaXYuaCIKIAotI2RlZmluZSBLRkRfSUhfTlVN
X0VOVFJJRVMgMTAyNAorI2RlZmluZSBLRkRfSUhfTlVNX0VOVFJJRVMgODE5MgogCiBzdGF0aWMg
dm9pZCBpbnRlcnJ1cHRfd3Eoc3RydWN0IHdvcmtfc3RydWN0ICopOwogCi0tIAoyLjcuNAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
