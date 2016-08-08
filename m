From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu/virtual_dce: add case for topaz for disable_dce
Date: Mon,  8 Aug 2016 14:46:39 -0400
Message-ID: <1470682000-4223-2-git-send-email-alexander.deucher@amd.com>
References: <1470682000-4223-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1470682000-4223-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

VGhpcyBhc2ljIGhhcyBubyBEQ0UgYmxvY2suICBBbHNvIGNsYXJpZnkgdGhlIGVycm9yIG1lc3Nh
Z2UKZm9yIHVubWF0Y2hlZCBjaGlwcy4KClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9k
Y2VfdmlydHVhbC5jIHwgNSArKysrLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Rj
ZV92aXJ0dWFsLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdmlydHVhbC5jCmlu
ZGV4IDRjOGNhNTguLjU0OTk2OTMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2RjZV92aXJ0dWFsLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3Zp
cnR1YWwuYwpAQCAtMTI0LDggKzEyNCwxMSBAQCB2b2lkIGRjZV92aXJ0dWFsX3N0b3BfbWNfYWNj
ZXNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCWNhc2UgQ0hJUF9QT0xBUklTMTA6CiAJ
CWRjZV92MTFfMF9kaXNhYmxlX2RjZShhZGV2KTsKIAkJYnJlYWs7CisJY2FzZSBDSElQX1RPUEFa
OgorCQkvKiBubyBEQ0UgKi8KKwkJcmV0dXJuOwogCWRlZmF1bHQ6Ci0JCURSTV9FUlJPUigiVXN1
cHBvcnRlZCBBU0lDIHR5cGU6IDB4JVhcbiIsIGFkZXYtPmFzaWNfdHlwZSk7CisJCURSTV9FUlJP
UigiVmlydHVhbCBkaXNwbGF5IHVuc3VwcG9ydGVkIEFTSUMgdHlwZTogMHglWFxuIiwgYWRldi0+
YXNpY190eXBlKTsKIAl9CiAKIAlyZXR1cm47Ci0tIAoyLjUuNQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
