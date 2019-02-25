From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 01/26] drm/amd/powerplay: debugfs don't check powerplay when
 SW SMU is enabled.
Date: Mon, 25 Feb 2019 20:12:07 +0800
Message-ID: <1551096752-18205-2-git-send-email-ray.huang@amd.com>
References: <1551096752-18205-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1551096752-18205-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>, Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

RnJvbTogS2V2aW4gV2FuZyA8a2V2aW4xLndhbmdAYW1kLmNvbT4KCndoZW4gc3cgc211IGlzIGVu
YWJsZWQsIHRoZSBwb3dlcnBsYXkgaW50ZXJmYWNlIGlzbid0IGltcGxlbWVudGVkLgoKU2lnbmVk
LW9mZi1ieTogS2V2aW4gV2FuZyA8a2V2aW4xLndhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEh1
YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3BtLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCmluZGV4IDQ3
ZDJiYTUuLmNjZGIwZjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9wbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCkBA
IC0yNzQ2LDcgKzI3NDYsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZWJ1Z2ZzX3BtX2luZm8oc3Ry
dWN0IHNlcV9maWxlICptLCB2b2lkICpkYXRhKQogCWlmICAoKGFkZXYtPmZsYWdzICYgQU1EX0lT
X1BYKSAmJgogCSAgICAgKGRkZXYtPnN3aXRjaF9wb3dlcl9zdGF0ZSAhPSBEUk1fU1dJVENIX1BP
V0VSX09OKSkgewogCQlzZXFfcHJpbnRmKG0sICJQWCBhc2ljIHBvd2VyZWQgb2ZmXG4iKTsKLQl9
IGVsc2UgaWYgKGFkZXYtPnBvd2VycGxheS5wcF9mdW5jcy0+ZGVidWdmc19wcmludF9jdXJyZW50
X3BlcmZvcm1hbmNlX2xldmVsKSB7CisJfSBlbHNlIGlmICghaXNfc3VwcG9ydF9zd19zbXUoYWRl
dikgJiYgYWRldi0+cG93ZXJwbGF5LnBwX2Z1bmNzLT5kZWJ1Z2ZzX3ByaW50X2N1cnJlbnRfcGVy
Zm9ybWFuY2VfbGV2ZWwpIHsKIAkJbXV0ZXhfbG9jaygmYWRldi0+cG0ubXV0ZXgpOwogCQlpZiAo
YWRldi0+cG93ZXJwbGF5LnBwX2Z1bmNzLT5kZWJ1Z2ZzX3ByaW50X2N1cnJlbnRfcGVyZm9ybWFu
Y2VfbGV2ZWwpCiAJCQlhZGV2LT5wb3dlcnBsYXkucHBfZnVuY3MtPmRlYnVnZnNfcHJpbnRfY3Vy
cmVudF9wZXJmb3JtYW5jZV9sZXZlbChhZGV2LCBtKTsKLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
