From: "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/6] drm/amdgpu/vcn:Update ring point to JPEG before init JPEG
 wptr
Date: Wed, 12 Dec 2018 20:24:58 +0000
Message-ID: <1544646291-25293-2-git-send-email-James.Zhu@amd.com>
References: <1544646291-25293-1-git-send-email-James.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1544646291-25293-1-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

SXQgaXMgYSBidWcgZml4LgoKU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1IDxKYW1lcy5aaHVAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jIHwgMyArKy0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYwppbmRleCA3NzUyMDQzLi41ZGY2ZWE5IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMKQEAgLTEwODgsNyArMTA4OCw4IEBAIHN0YXRp
YyBpbnQgdmNuX3YxXzBfc3RhcnRfZHBnX21vZGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
CiAJV1JFRzMyX1AoU09DMTVfUkVHX09GRlNFVChVVkQsIDAsIG1tVVZEX1JCQ19SQl9DTlRMKSwg
MCwKIAkJCX5VVkRfUkJDX1JCX0NOVExfX1JCX05PX0ZFVENIX01BU0spOwogCi0JLyogaW5pdGlh
bGl6ZSB3cHRyICovCisJLyogaW5pdGlhbGl6ZSBKUEVHIHdwdHIgKi8KKwlyaW5nID0gJmFkZXYt
PnZjbi5yaW5nX2pwZWc7CiAJcmluZy0+d3B0ciA9IFJSRUczMl9TT0MxNShVVkQsIDAsIG1tVVZE
X0pSQkNfUkJfV1BUUik7CiAKIAkvKiBjb3B5IHBhdGNoIGNvbW1hbmRzIHRvIHRoZSBqcGVnIHJp
bmcgKi8KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
