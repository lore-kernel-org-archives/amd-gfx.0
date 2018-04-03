From: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/8] Revert "Revert "drm/amdgpu/uvd7: add
 emit_reg_write_reg_wait ring callback""
Date: Tue, 3 Apr 2018 17:07:57 +0800
Message-ID: <1522746482-31353-4-git-send-email-Emily.Deng@amd.com>
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

VGhpcyByZXZlcnRzIGNvbW1pdCAxNjI0OTliZWQwNGU0YzUxZGQwZmNiZmExNTE1ZjliMDQ0Zjg5
MjVlLgpUaGUgdmVnYTEwIHNyaW92IHN0aWxsIG5lZWQgdGhlc2UgcGF0Y2hlcy4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjdfMC5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91
dmRfdjdfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y3XzAuYwppbmRleCBl
ZGRjNTdmLi4yODBjMDgyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91
dmRfdjdfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92N18wLmMKQEAg
LTE3MDIsNiArMTcwMiw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3Mg
dXZkX3Y3XzBfZW5jX3Jpbmdfdm1fZnVuY3MgPSB7CiAJLmVuZF91c2UgPSBhbWRncHVfdXZkX3Jp
bmdfZW5kX3VzZSwKIAkuZW1pdF93cmVnID0gdXZkX3Y3XzBfZW5jX3JpbmdfZW1pdF93cmVnLAog
CS5lbWl0X3JlZ193YWl0ID0gdXZkX3Y3XzBfZW5jX3JpbmdfZW1pdF9yZWdfd2FpdCwKKwkuZW1p
dF9yZWdfd3JpdGVfcmVnX3dhaXQgPSBhbWRncHVfcmluZ19lbWl0X3JlZ193cml0ZV9yZWdfd2Fp
dF9oZWxwZXIsCiB9OwogCiBzdGF0aWMgdm9pZCB1dmRfdjdfMF9zZXRfcmluZ19mdW5jcyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
