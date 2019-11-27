From: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 06/10] drm/amdgpu: add condition to enable baco for xgmi/ras
 case
Date: Wed, 27 Nov 2019 17:15:25 +0800
Message-ID: <1574846129-4826-5-git-send-email-le.ma@amd.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1574846129-4826-1-git-send-email-le.ma-5C7GfCeVMHo@public.gmane.org>
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
Cc: guchun.chen-5C7GfCeVMHo@public.gmane.org, tao.zhou1-5C7GfCeVMHo@public.gmane.org, Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>, alexander.deucher-5C7GfCeVMHo@public.gmane.org, dennis.li-5C7GfCeVMHo@public.gmane.org, hawking.zhang-5C7GfCeVMHo@public.gmane.org

QXZvaWQgdG8gY2hhbmdlIGRlZmF1bHQgcmVzZXQgYmVoYXZpb3IgZm9yIHByb2R1Y3Rpb24gY2Fy
ZCBieSBjaGVja2luZwphbWRncHVfcmFzX2VuYWJsZSBlcXVhbCB0byAyLiBBbmQgb25seSBuZXcg
ZW5vdWdoIHNtdSB1Y29kZSBjYW4gc3VwcG9ydApiYWNvIGZvciB4Z21pL3JhcyBjYXNlLgoKQ2hh
bmdlLUlkOiBJMDdjM2U2ODYyYmUwM2UwNjg3NDVjNzNkYjhlYTcxZjQyOGVjYmE2YgpTaWduZWQt
b2ZmLWJ5OiBMZSBNYSA8bGUubWFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zb2MxNS5jIHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29j
MTUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKaW5kZXggOTUxMzI3Zi4u
NjIwMjMzMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCkBAIC01NzcsNyArNTc3LDkg
QEAgc29jMTVfYXNpY19yZXNldF9tZXRob2Qoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJ
CQlzdHJ1Y3QgYW1kZ3B1X2hpdmVfaW5mbyAqaGl2ZSA9IGFtZGdwdV9nZXRfeGdtaV9oaXZlKGFk
ZXYsIDApOwogCQkJc3RydWN0IGFtZGdwdV9yYXMgKnJhcyA9IGFtZGdwdV9yYXNfZ2V0X2NvbnRl
eHQoYWRldik7CiAKLQkJCWlmIChoaXZlIHx8IChyYXMgJiYgcmFzLT5zdXBwb3J0ZWQpKQorCQkJ
aWYgKChoaXZlIHx8IChyYXMgJiYgcmFzLT5zdXBwb3J0ZWQpKSAmJgorCQkJICAgIChhbWRncHVf
cmFzX2VuYWJsZSAhPSAyIHx8CisJCQkgICAgYWRldi0+cG0uZndfdmVyc2lvbiA8PSAweDI4MzQw
MCkpCiAJCQkJYmFjb19yZXNldCA9IGZhbHNlOwogCQl9CiAJCWJyZWFrOwotLSAKMi43LjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
