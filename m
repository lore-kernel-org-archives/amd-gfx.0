From: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/8] Revert "Revert "drm/amdgpu/vcn1: add
 emit_reg_write_reg_wait ring callback""
Date: Tue, 3 Apr 2018 17:07:59 +0800
Message-ID: <1522746482-31353-6-git-send-email-Emily.Deng@amd.com>
References: <1522746482-31353-1-git-send-email-Emily.Deng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1522746482-31353-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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
Cc: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>

VGhpcyByZXZlcnRzIGNvbW1pdCBiYjg1ZTAxNDA0YWIzOWMwMTc4NmQ2NDMxMmE2MDJkNTU0MGE5
OTQ0LgpUaGUgdmVnYTEwIHNyaW92IHN0aWxsIG5lZWQgdGhlc2UgcGF0Y2hlcy4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
Y25fdjFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYwppbmRleCA4
YzEzMjY3Li5kOWExNTMzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
Y25fdjFfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMKQEAg
LTExMzksNiArMTEzOSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3Mg
dmNuX3YxXzBfZW5jX3Jpbmdfdm1fZnVuY3MgPSB7CiAJLmVuZF91c2UgPSBhbWRncHVfdmNuX3Jp
bmdfZW5kX3VzZSwKIAkuZW1pdF93cmVnID0gdmNuX3YxXzBfZW5jX3JpbmdfZW1pdF93cmVnLAog
CS5lbWl0X3JlZ193YWl0ID0gdmNuX3YxXzBfZW5jX3JpbmdfZW1pdF9yZWdfd2FpdCwKKwkuZW1p
dF9yZWdfd3JpdGVfcmVnX3dhaXQgPSBhbWRncHVfcmluZ19lbWl0X3JlZ193cml0ZV9yZWdfd2Fp
dF9oZWxwZXIsCiB9OwogCiBzdGF0aWMgdm9pZCB2Y25fdjFfMF9zZXRfZGVjX3JpbmdfZnVuY3Mo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
