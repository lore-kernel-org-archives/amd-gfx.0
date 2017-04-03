From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH libdrm 3/3] amdgpu: add REPLACE and CLEAR checking for VA op
 (v2)
Date: Mon,  3 Apr 2017 10:27:20 +0200
Message-ID: <20170403082720.13166-3-nhaehnle@gmail.com>
References: <20170403082720.13166-1-nhaehnle@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170403082720.13166-1-nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

RnJvbTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgoKdjI6IGZpeCBpbmRlbnQK
ClNpZ25lZC1vZmYtYnk6IEp1bndlaSBaaGFuZyA8SmVycnkuWmhhbmdAYW1kLmNvbT4KUmV2aWV3
ZWQtYnk6IE5pY29sYWkgSMOkaG5sZSA8bmljb2xhaS5oYWVobmxlQGFtZC5jb20+ClJldmlld2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogYW1k
Z3B1L2FtZGdwdV9iby5jIHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYW1kZ3B1L2FtZGdwdV9iby5jIGIvYW1kZ3B1
L2FtZGdwdV9iby5jCmluZGV4IGY3MjViZmQuLjhiYzFlYmQgMTAwNjQ0Ci0tLSBhL2FtZGdwdS9h
bWRncHVfYm8uYworKysgYi9hbWRncHUvYW1kZ3B1X2JvLmMKQEAgLTY5NiwyMSArNjk2LDIzIEBA
IGludCBhbWRncHVfYm9fdmFfb3BfcmF3KGFtZGdwdV9kZXZpY2VfaGFuZGxlIGRldiwKIAkJCWFt
ZGdwdV9ib19oYW5kbGUgYm8sCiAJCQl1aW50NjRfdCBvZmZzZXQsCiAJCQl1aW50NjRfdCBzaXpl
LAogCQkJdWludDY0X3QgYWRkciwKIAkJCXVpbnQ2NF90IGZsYWdzLAogCQkJdWludDMyX3Qgb3Bz
KQogewogCXN0cnVjdCBkcm1fYW1kZ3B1X2dlbV92YSB2YTsKIAlpbnQgcjsKIAotCWlmIChvcHMg
IT0gQU1ER1BVX1ZBX09QX01BUCAmJiBvcHMgIT0gQU1ER1BVX1ZBX09QX1VOTUFQKQorCWlmIChv
cHMgIT0gQU1ER1BVX1ZBX09QX01BUCAmJiBvcHMgIT0gQU1ER1BVX1ZBX09QX1VOTUFQICYmCisJ
ICAgIG9wcyAhPSBBTURHUFVfVkFfT1BfUkVQTEFDRSAmJiBvcHMgIT0gQU1ER1BVX1ZBX09QX0NM
RUFSKQorCiAJCXJldHVybiAtRUlOVkFMOwogCiAJbWVtc2V0KCZ2YSwgMCwgc2l6ZW9mKHZhKSk7
CiAJdmEuaGFuZGxlID0gYm8gPyBiby0+aGFuZGxlIDogMDsKIAl2YS5vcGVyYXRpb24gPSBvcHM7
CiAJdmEuZmxhZ3MgPSBmbGFnczsKIAl2YS52YV9hZGRyZXNzID0gYWRkcjsKIAl2YS5vZmZzZXRf
aW5fYm8gPSBvZmZzZXQ7CiAJdmEubWFwX3NpemUgPSBzaXplOwogCi0tIAoyLjkuMwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
