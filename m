From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 02/24] drm/radeon: Return dword offsets of address watch
 registers
Date: Tue, 15 Aug 2017 23:00:00 -0400
Message-ID: <1502852422-19620-3-git-send-email-Felix.Kuehling@amd.com>
References: <1502852422-19620-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1502852422-19620-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

RHdvcmQgb2Zmc2V0cyBhcmUgd2hhdCBLRkQgcmVhbGx5IG5lZWRzIGFuZCB3aGF0IGFtZGdwdSBh
bHJlYWR5IHJldHVybnMuCgpTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3Vl
aGxpbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rZmQuYyB8
IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa2ZkLmMgYi9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rZmQuYwppbmRleCBhMmFiNmRjLi5jYWI2YzAzIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rZmQuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rZmQuYwpAQCAtNzg1LDcgKzc4NSw4IEBAIHN0YXRpYyB1
aW50MzJfdCBrZ2RfYWRkcmVzc193YXRjaF9nZXRfb2Zmc2V0KHN0cnVjdCBrZ2RfZGV2ICprZ2Qs
CiAJCQkJCXVuc2lnbmVkIGludCB3YXRjaF9wb2ludF9pZCwKIAkJCQkJdW5zaWduZWQgaW50IHJl
Z19vZmZzZXQpCiB7Ci0JcmV0dXJuIHdhdGNoUmVnc1t3YXRjaF9wb2ludF9pZCAqIEFERFJFU1Nf
V0FUQ0hfUkVHX01BWCArIHJlZ19vZmZzZXRdOworCXJldHVybiB3YXRjaFJlZ3Nbd2F0Y2hfcG9p
bnRfaWQgKiBBRERSRVNTX1dBVENIX1JFR19NQVggKyByZWdfb2Zmc2V0XQorCQkvIDQ7CiB9CiAK
IHN0YXRpYyBib29sIGdldF9hdGNfdm1pZF9wYXNpZF9tYXBwaW5nX3ZhbGlkKHN0cnVjdCBrZ2Rf
ZGV2ICprZ2QsIHVpbnQ4X3Qgdm1pZCkKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
