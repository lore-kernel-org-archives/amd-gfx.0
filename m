From: Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/6] drm/amdgpu: remove the clear of MCA_ADDR
Date: Thu, 1 Aug 2019 14:43:06 +0800
Message-ID: <20190801064311.7307-2-tao.zhou1@amd.com>
References: <20190801064311.7307-1-tao.zhou1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190801064311.7307-1-tao.zhou1-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, hawking.zhang-5C7GfCeVMHo@public.gmane.org, dennis.li-5C7GfCeVMHo@public.gmane.org, guchun.chen-5C7GfCeVMHo@public.gmane.org, xinhui.pan-5C7GfCeVMHo@public.gmane.org
Cc: Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>

Y2xlYXJpbmcgTUNBX1NUQVRVUyBpcyBlbm91Z2ggdG8gcmVzZXQgdGhlIHdob2xlIE1DQSwgd3Jp
dGluZyB6ZXJvIHRvCk1DQV9BRERSIGlzIHVubmVjZXNzYXJ5CgpTaWduZWQtb2ZmLWJ5OiBUYW8g
WmhvdSA8dGFvLnpob3UxQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dW1jX3Y2XzEuYyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS91bWNfdjZfMS5jCmluZGV4IGJmZjFhMTJmMmNjOS4uMDM1ZTRmZWE0
NzJjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjZfMS5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMKQEAgLTIyOSw4ICsyMjks
NiBAQCBzdGF0aWMgdm9pZCB1bWNfdjZfMV9xdWVyeV9yYXNfZXJyb3JfYWRkcmVzcyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwKIAogCQkJLyogY2xlYXIgdW1jIHN0YXR1cyAqLwogCQkJV1JF
RzY0KG1jX3VtY19zdGF0dXNfYWRkciArIHVtY19yZWdfb2Zmc2V0LCAweDBVTEwpOwotCQkJLyog
Y2xlYXIgZXJyb3IgYWRkcmVzcyByZWdpc3RlciAqLwotCQkJV1JFRzY0X1BDSUUoc21uTUNBX1VN
QzBfTUNVTUNfQUREUlQwICsgdW1jX3JlZ19vZmZzZXQgKiA0LCAweDBVTEwpOwogCQl9CiAJfQog
Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
