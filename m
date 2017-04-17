From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu: set kiq irq functions in sriov case for gfx_v9
Date: Mon, 17 Apr 2017 20:05:28 +0800
Message-ID: <1492430729-21807-2-git-send-email-Rex.Zhu@amd.com>
References: <1492430729-21807-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1492430729-21807-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

QXMgdGhlIGtpcSByaW5nIGlzIE5VTEwgaW4gYmFyZW1ldGFsIGNhc2UsCnRoZSBpcnEgZnVuY3Rp
b24gd2lsbCByZXN1bHQgaW4gYSBCVUdfT04gaW4gc29tZSBjYXNlLgoKQ2hhbmdlLUlkOiBJYjQz
YTlhMTAwZmU3YjFjMDNjZTVmYTU5OWU2MzFhM2IyMWNlNmU5YQpTaWduZWQtb2ZmLWJ5OiBSZXgg
Wmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y5XzAuYyB8IDcgKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwppbmRleCBmNmIy
MzI5Li41OTQ2MmU3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKQEAgLTM1
OTAsOSArMzU5MCwxMCBAQCBzdGF0aWMgdm9pZCBnZnhfdjlfMF9zZXRfaXJxX2Z1bmNzKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQogCiAJYWRldi0+Z2Z4LnByaXZfaW5zdF9pcnEubnVtX3R5
cGVzID0gMTsKIAlhZGV2LT5nZngucHJpdl9pbnN0X2lycS5mdW5jcyA9ICZnZnhfdjlfMF9wcml2
X2luc3RfaXJxX2Z1bmNzOwotCi0JYWRldi0+Z2Z4LmtpcS5pcnEubnVtX3R5cGVzID0gQU1ER1BV
X0NQX0tJUV9JUlFfTEFTVDsKLQlhZGV2LT5nZngua2lxLmlycS5mdW5jcyA9ICZnZnhfdjlfMF9r
aXFfaXJxX2Z1bmNzOworCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsKKwkJYWRldi0+Z2Z4
LmtpcS5pcnEubnVtX3R5cGVzID0gQU1ER1BVX0NQX0tJUV9JUlFfTEFTVDsKKwkJYWRldi0+Z2Z4
LmtpcS5pcnEuZnVuY3MgPSAmZ2Z4X3Y5XzBfa2lxX2lycV9mdW5jczsKKwl9CiB9CiAKIHN0YXRp
YyB2b2lkIGdmeF92OV8wX3NldF9ybGNfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
