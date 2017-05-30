From: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/3] drm/amdgpu: clean up code to make it easier to understand
Date: Tue, 30 May 2017 17:47:48 -0400
Message-ID: <1496180868-2617-3-git-send-email-AlexBin.Xie@amd.com>
References: <1496180868-2617-1-git-send-email-AlexBin.Xie@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1496180868-2617-1-git-send-email-AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

IFRoZSBvcmlnaW5hbCBjb2RlIGNvbnZlcnQgcG9pbnRlciBmcm9tIGFtZGdwdV9jcnRjIHRvCiBk
cm1fY3J0YyB0aGVuIGxhdGVyIGNvbnZlcnQgdGhlIHBvaW50ZXIgYmFjay4KIEl0IGlzIGRpZmZp
Y3VsdCB0byB1bmRlcnN0YW5kIHdoeSBpdCB3YXMgd3JpdHRlbgogdGhhdCB3YXkuCgpTaWduZWQt
b2ZmLWJ5OiBBbGV4IFhpZSA8QWxleEJpbi5YaWVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgfCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9rbXMuYwppbmRleCA0ZGQ4M2EzLi43MzE3ZmM5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2ttcy5jCkBAIC0yNTgsOCArMjU4LDcgQEAgc3RhdGljIGludCBhbWRncHVfaW5m
b19pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRhLCBzdHJ1Y3QgZHJtX2Zp
bGUKIAkJZm9yIChpID0gMCwgZm91bmQgPSAwOyBpIDwgYWRldi0+bW9kZV9pbmZvLm51bV9jcnRj
OyBpKyspIHsKIAkJCWNydGMgPSAoc3RydWN0IGRybV9jcnRjICopbWluZm8tPmNydGNzW2ldOwog
CQkJaWYgKGNydGMgJiYgY3J0Yy0+YmFzZS5pZCA9PSBpbmZvLT5tb2RlX2NydGMuaWQpIHsKLQkJ
CQlzdHJ1Y3QgYW1kZ3B1X2NydGMgKmFtZGdwdV9jcnRjID0gdG9fYW1kZ3B1X2NydGMoY3J0Yyk7
Ci0JCQkJdWkzMiA9IGFtZGdwdV9jcnRjLT5jcnRjX2lkOworCQkJCXVpMzIgPSBtaW5mby0+Y3J0
Y3NbaV0tPmNydGNfaWQ7CiAJCQkJZm91bmQgPSAxOwogCQkJCWJyZWFrOwogCQkJfQotLSAKMi43
LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
