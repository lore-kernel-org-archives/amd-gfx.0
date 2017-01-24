From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 02/11] drm/amd/display: Remove power gating debug flags
Date: Tue, 24 Jan 2017 09:25:18 -0500
Message-ID: <20170124142527.8025-3-harry.wentland@amd.com>
References: <20170124142527.8025-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170124142527.8025-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

VGhleSdyZSBub3QgdXNlZCBhbnl3aGVyZQoKQ2hhbmdlLUlkOiBJNjA3MDQ1YTMyZWMxYWY0YmI4
MDJhOTBiMjYzMDFlMzI4ZWY3ZjMwNgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kYy5oIHwgMiAtLQogMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGMuaAppbmRleCBlMDE0M2Y5ZjA0MjEuLjMzMmVjZjhiMTE1NyAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgKQEAgLTE0NSw4ICsxNDUsNiBAQCBzdHJ1Y3Qg
ZGNfZGVidWcgewogCWJvb2wgZGlzYWJsZV9zdHV0dGVyOwogCWJvb2wgZGlzYWJsZV9kY2M7CiAJ
Ym9vbCBkaXNhYmxlX2Rmc19ieXBhc3M7Ci0JYm9vbCBkaXNhYmxlX2RwcF9wb3dlcl9nYXRlOwot
CWJvb2wgZGlzYWJsZV9odWJwX3Bvd2VyX2dhdGU7CiAJYm9vbCBkaXNhYmxlX2Nsb2NrX2dhdGU7
CiAJYm9vbCBkaXNhYmxlX2RtY3U7CiAJYm9vbCBkaXNhYmxlX2NvbG9yX21vZHVsZTsKLS0gCjIu
OS4zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
