From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Remove unused flip_flags from amdgpu_crtc
Date: Thu, 31 Aug 2017 21:19:35 -0400
Message-ID: <20170901011935.5230-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, michel-otUistvHUpPR7s880joybQ@public.gmane.org, andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

Tm8gbW9yZSBuZWVkIHNpbmNlIEFuZHJleSdzIGNoYW5nZSB0byB1c2UgZHJtX2NydGMncyB2ZXJz
aW9uCgpTaWduZWQtb2ZmLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW9kZS5oIHwgMSAtCiAx
IGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9tb2RlLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfbW9kZS5oCmluZGV4IGNiMTczNjc4ZjdkZi4uMjc4MGM4NDg5MmFjIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW9kZS5oCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tb2RlLmgKQEAgLTQ0MSw3ICs0NDEsNiBAQCBzdHJ1
Y3QgYW1kZ3B1X2NydGMgewogCWVudW0gYW1kZ3B1X2ludGVycnVwdF9zdGF0ZSB2c3luY190aW1l
cl9lbmFibGVkOwogCiAJaW50IG90Z19pbnN0OwotCXVpbnQzMl90IGZsaXBfZmxhZ3M7CiAJLyog
QWZ0ZXIgU2V0IE1vZGUgc3RyZWFtIHdpbGwgYmUgbm9uLU5VTEwgKi8KIAljb25zdCBzdHJ1Y3Qg
ZGNfc3RyZWFtICpzdHJlYW07CiAJc3RydWN0IGRybV9wZW5kaW5nX3ZibGFua19ldmVudCAqZXZl
bnQ7Ci0tIAoyLjExLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
