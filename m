From: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: correct condition check for psp rlc autoload
Date: Mon, 23 Sep 2019 21:30:43 +0800
Message-ID: <1569245443-27318-2-git-send-email-le.ma@amd.com>
References: <1569245443-27318-1-git-send-email-le.ma@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1569245443-27318-1-git-send-email-le.ma-5C7GfCeVMHo@public.gmane.org>
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
Cc: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJYTkxZDBmYjcxNzlmNjk0NDIxNGU4OTJmMzcwZDdlZjNkNmI3ZDMwZQpTaWdu
ZWQtb2ZmLWJ5OiBMZSBNYSA8bGUubWFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcHNwLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3Au
YwppbmRleCBkMzU5ZjFkLi4yYWExYWU2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcHNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jCkBAIC0xMDgwLDcgKzEwODAsOCBAQCBzdGF0aWMgaW50IHBzcF9ucF9md19sb2Fk
KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCQkJcmV0dXJuIHJldDsKIAogCQkvKiBTdGFydCBy
bGMgYXV0b2xvYWQgYWZ0ZXIgcHNwIHJlY2lldmVkIGFsbCB0aGUgZ2Z4IGZpcm13YXJlICovCi0J
CWlmICh1Y29kZS0+dWNvZGVfaWQgPT0gQU1ER1BVX1VDT0RFX0lEX1JMQ19SRVNUT1JFX0xJU1Rf
U1JNX01FTSkgeworCQlpZiAocHNwLT5hdXRvbG9hZF9zdXBwb3J0ZWQgJiYgdWNvZGUtPnVjb2Rl
X2lkID09CisJCQlBTURHUFVfVUNPREVfSURfUkxDX1JFU1RPUkVfTElTVF9TUk1fTUVNKSB7CiAJ
CQlyZXQgPSBwc3BfcmxjX2F1dG9sb2FkKHBzcCk7CiAJCQlpZiAocmV0KSB7CiAJCQkJRFJNX0VS
Uk9SKCJGYWlsZWQgdG8gc3RhcnQgcmxjIGF1dG9sb2FkXG4iKTsKLS0gCjIuNy40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
