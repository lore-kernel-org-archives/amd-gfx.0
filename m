From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 050/102] drm/amdgpu: Set VM_L2_CNTL.PDE_FAULT_CLASSIFICATION
 to 0 for MMHUB 9.4
Date: Mon, 15 Jul 2019 16:23:45 -0500
Message-ID: <20190715212437.31793-48-alexander.deucher@amd.com>
References: <20190715212437.31793-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190715212437.31793-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>

RnJvbTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNvbT4KClNpZ25lZC1vZmYtYnk6IFlvbmcg
WmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9t
bWh1Yl92OV80LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92
OV80LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMKaW5kZXggN2Y3
OWZhNGI2YWQxLi42YjdjZGFhZGJkNzAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L21taHViX3Y5XzQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1
Yl92OV80LmMKQEAgLTE5NSw3ICsxOTUsNyBAQCBzdGF0aWMgdm9pZCBtbWh1Yl92OV80X2luaXRf
Y2FjaGVfcmVncyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgaW50IGh1YmlkKQogCXRtcCA9
IFJFR19TRVRfRklFTEQodG1wLCBWTUwyUEYwX1ZNX0wyX0NOVEwsCiAJCQkgICAgTDJfUERFMF9D
QUNIRV9UQUdfR0VORVJBVElPTl9NT0RFLCAwKTsKIAl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwg
Vk1MMlBGMF9WTV9MMl9DTlRMLAotCQkJICAgIFBERV9GQVVMVF9DTEFTU0lGSUNBVElPTiwgMSk7
CisJCQkgICAgUERFX0ZBVUxUX0NMQVNTSUZJQ0FUSU9OLCAwKTsKIAl0bXAgPSBSRUdfU0VUX0ZJ
RUxEKHRtcCwgVk1MMlBGMF9WTV9MMl9DTlRMLAogCQkJICAgIENPTlRFWFQxX0lERU5USVRZX0FD
Q0VTU19NT0RFLCAxKTsKIAl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgVk1MMlBGMF9WTV9MMl9D
TlRMLAotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
