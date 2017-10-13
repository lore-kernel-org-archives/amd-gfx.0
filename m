From: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/4] drm/amdgpu: report preemption fence via amdgpu_fence_info
Date: Fri, 13 Oct 2017 16:26:19 +0800
Message-ID: <1507883180-5626-4-git-send-email-Pixel.Ding@amd.com>
References: <1507883180-5626-1-git-send-email-Pixel.Ding@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1507883180-5626-1-git-send-email-Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
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
Cc: pding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>, Bingley.Li-5C7GfCeVMHo@public.gmane.org

RnJvbTogcGRpbmcgPFBpeGVsLkRpbmdAYW1kLmNvbT4KCk9ubHkgcmVwb3J0IGZlbmNlIGZvciBH
RlggcmluZy4gVGhpcyBjYW4gaGVscCBjaGVja2luZyBNQ0JQIGZlYXR1cmUuCgpTaWduZWQtb2Zm
LWJ5OiBwZGluZyA8UGl4ZWwuRGluZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9mZW5jZS5jIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2ZlbmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYwppbmRl
eCAwOWQ1YTVjLi4yMDQ0NzU4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZmVuY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZmVuY2UuYwpAQCAtNjQ1LDYgKzY0NSwxMyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZWJ1Z2ZzX2Zl
bmNlX2luZm8oc3RydWN0IHNlcV9maWxlICptLCB2b2lkICpkYXRhKQogCQkJICAgYXRvbWljX3Jl
YWQoJnJpbmctPmZlbmNlX2Rydi5sYXN0X3NlcSkpOwogCQlzZXFfcHJpbnRmKG0sICJMYXN0IGVt
aXR0ZWQgICAgICAgIDB4JTA4eFxuIiwKIAkJCSAgIHJpbmctPmZlbmNlX2Rydi5zeW5jX3NlcSk7
CisKKwkJaWYgKHJpbmctPmZ1bmNzLT50eXBlICE9IEFNREdQVV9SSU5HX1RZUEVfR0ZYKQorCQkJ
YnJlYWs7CisKKwkJc2VxX3ByaW50ZihtLCAiTGFzdCBwcmVlbXB0ZWQgICAgICAweCUwOHhcbiIs
CisJCQkgICBsZTMyX3RvX2NwdSgqKHJpbmctPmZlbmNlX2Rydi5jcHVfYWRkciArIDIpKSk7CisK
IAl9CiAJcmV0dXJuIDA7CiB9Ci0tIAoyLjkuNQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
