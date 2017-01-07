From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 8/8] drm/amd/display: Don't fail validation for
 SIGNAL_TYPE_VIRTUAL
Date: Fri, 6 Jan 2017 19:22:30 -0500
Message-ID: <20170107002230.19725-9-harry.wentland@amd.com>
References: <20170107002230.19725-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170107002230.19725-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>

RnJvbTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgoKQ2hhbmdlLUlkOiBJ
YzhjODE0ZmNiOGExOGFhZjM0YjhkYTg3YWJiY2M4NTI5YjZjYjAyZQpTaWduZWQtb2ZmLWJ5OiBZ
b25ncWlhbmcgU3VuIDx5b25ncWlhbmcuc3VuQGFtZC5jb20+CkFja2VkLWJ5OiBIYXJyeSBXZW50
bGFuZCA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGNlL2RjZV9saW5rX2VuY29kZXIuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjZS9kY2VfbGlua19lbmNvZGVyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNlL2RjZV9saW5rX2VuY29kZXIuYwppbmRleCBjMDgzMzc2OTZjZjguLjkzMGFlMTM3N2Fi
NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfbGlu
a19lbmNvZGVyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2Vf
bGlua19lbmNvZGVyLmMKQEAgLTEwNTMsNiArMTA1Myw5IEBAIGJvb2wgZGNlMTEwX2xpbmtfZW5j
b2Rlcl92YWxpZGF0ZV9vdXRwdXRfd2l0aF9zdHJlYW0oCiAJCWlzX3ZhbGlkID0gZGNlMTEwX2xp
bmtfZW5jb2Rlcl92YWxpZGF0ZV9kcF9vdXRwdXQoCiAJCQllbmMxMTAsICZzdHJlYW0tPnB1Ymxp
Yy50aW1pbmcpOwogCWJyZWFrOworCWNhc2UgU0lHTkFMX1RZUEVfVklSVFVBTDoKKwkJaXNfdmFs
aWQgPSB0cnVlOworCQlicmVhazsKIAlkZWZhdWx0OgogCQlpc192YWxpZCA9IGZhbHNlOwogCWJy
ZWFrOwotLSAKMi45LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
