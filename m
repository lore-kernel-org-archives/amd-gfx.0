From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/3] drm/amdgpu: Remove wrong fw loading type warning
Date: Wed, 10 Oct 2018 21:28:15 +0800
Message-ID: <1539178095-24356-3-git-send-email-Rex.Zhu@amd.com>
References: <1539178095-24356-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1539178095-24356-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

UmVtb3ZlIHRoZSB3YXJuaW5nIG1lc3NhZ2U6CiItMSBpcyBub3Qgc3VwcG9ydGVkIG9uIFZJIgp0
aGUgLTEgaXMgdGhlIGRlZmF1bHQgZncgbG9hZCB0eXBlLCBtZWFuIGF1dG8uCgpTaWduZWQtb2Zm
LWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Vjb2RlLmMgfCAyIC0tCiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5jCmluZGV4IDk3MTU0
OWYuLmQ5MWYzNzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV91Y29kZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5j
CkBAIC0yOTcsOCArMjk3LDYgQEAgZW51bSBhbWRncHVfZmlybXdhcmVfbG9hZF90eXBlCiAJY2Fz
ZSBDSElQX1BPTEFSSVMxMToKIAljYXNlIENISVBfUE9MQVJJUzEyOgogCWNhc2UgQ0hJUF9WRUdB
TToKLQkJaWYgKGxvYWRfdHlwZSAhPSBBTURHUFVfRldfTE9BRF9TTVUpCi0JCQlwcl93YXJuaW5n
KCIlZCBpcyBub3Qgc3VwcG9ydGVkIG9uIFZJXG4iLCBsb2FkX3R5cGUpOwogCQlyZXR1cm4gQU1E
R1BVX0ZXX0xPQURfU01VOwogCWNhc2UgQ0hJUF9WRUdBMTA6CiAJY2FzZSBDSElQX1JBVkVOOgot
LSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
