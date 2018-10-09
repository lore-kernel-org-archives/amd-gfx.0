From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/5] drm/amdgpu: Fix unnecessary warning in dmesg
Date: Tue, 9 Oct 2018 20:43:42 +0800
Message-ID: <1539089023-2360-4-git-send-email-Rex.Zhu@amd.com>
References: <1539089023-2360-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1539089023-2360-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

Rml4IHRoZSB3YXJuaW5nIG1lc3NhZ2U6CiItMSBpcyBub3Qgc3VwcG9ydGVkIG9uIFZJIgp0aGUg
LTEgaXMgdGhlIGRlZmF1bHQgZncgbG9hZCB0eXBlLCBtZWFuIGF1dG8uCgpTaWduZWQtb2ZmLWJ5
OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Vjb2RlLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdWNvZGUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5j
CmluZGV4IGYyNjA0YWMuLmU1YjEzYjIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV91Y29kZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91Y29kZS5jCkBAIC0yOTcsNyArMjk3LDcgQEAgZW51bSBhbWRncHVfZmlybXdhcmVfbG9h
ZF90eXBlCiAJY2FzZSBDSElQX1BPTEFSSVMxMToKIAljYXNlIENISVBfUE9MQVJJUzEyOgogCWNh
c2UgQ0hJUF9WRUdBTToKLQkJaWYgKGxvYWRfdHlwZSAhPSBBTURHUFVfRldfTE9BRF9TTVUpCisJ
CWlmIChsb2FkX3R5cGUgIT0gQU1ER1BVX0ZXX0xPQURfRElSRUNUIHx8IGxvYWRfdHlwZSA9PSBB
TURHUFVfRldfTE9BRF9QU1ApCiAJCQlwcl93YXJuaW5nKCIlZCBpcyBub3Qgc3VwcG9ydGVkIG9u
IFZJXG4iLCBsb2FkX3R5cGUpOwogCQlyZXR1cm4gQU1ER1BVX0ZXX0xPQURfU01VOwogCWNhc2Ug
Q0hJUF9WRUdBMTA6Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
