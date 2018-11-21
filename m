From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: disable page queue support for Vega20
Date: Wed, 21 Nov 2018 14:40:30 +0800
Message-ID: <20181121064030.14792-1-evan.quan@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

S2VlcCBpdCBkaXNhYmxlZCB1bnRpbCB3ZSBjb25maXJtIGl0J3MgcmVhZHkuCgpDaGFuZ2UtSWQ6
IEkyZGM0YzBmMTE1NmRkODJmNzA0NjY3MmZlZDZkMjJiOWQxOGMyMDEwClNpZ25lZC1vZmYtYnk6
IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc2RtYV92NF8wLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NkbWFfdjRfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKaW5k
ZXggMGEzYjY4ZGQ0OWEwLi5lNmNiMmMzOTk5NTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NkbWFfdjRfMC5jCkBAIC0xNDU3LDcgKzE0NTcsOCBAQCBzdGF0aWMgYm9vbCBzZG1hX3Y0XzBf
Zndfc3VwcG9ydF9wYWdpbmdfcXVldWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJY2Fz
ZSBDSElQX1ZFR0ExMjoKIAkJcmV0dXJuIGZ3X3ZlcnNpb24gPj0gMzE7CiAJY2FzZSBDSElQX1ZF
R0EyMDoKLQkJcmV0dXJuIGZ3X3ZlcnNpb24gPj0gMTE1OworCQkvL3JldHVybiBmd192ZXJzaW9u
ID49IDExNTsKKwkJcmV0dXJuIGZhbHNlOwogCWRlZmF1bHQ6CiAJCXJldHVybiBmYWxzZTsKIAl9
Ci0tIAoyLjE5LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
