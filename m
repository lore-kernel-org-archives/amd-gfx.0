From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 36/43] drm/amd/display: Add is_tiling_rotated flag to
 plane_state
Date: Thu, 23 Nov 2017 14:53:09 -0500
Message-ID: <20171123195316.8366-37-harry.wentland@amd.com>
References: <20171123195316.8366-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171123195316.8366-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Eric Murphy-Zaremba <Eric.Murphy-zaremba-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRXJpYyBNdXJwaHktWmFyZW1iYSA8RXJpYy5NdXJwaHktemFyZW1iYUBhbWQuY29tPgoK
U2lnbmVkLW9mZi1ieTogRXJpYyBNdXJwaHktWmFyZW1iYSA8RXJpYy5NdXJwaHktemFyZW1iYUBh
bWQuY29tPgpSZXZpZXdlZC1ieTogQXJpYyBDeXIgPEFyaWMuQ3lyQGFtZC5jb20+CkFja2VkLWJ5
OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaCB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAppbmRleCBlZThhZjlmYTY2Zjgu
LjI2OWQ1NjM0ZTZlZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgKQEAgLTQ0MCw2
ICs0NDAsNyBAQCBzdHJ1Y3QgZGNfcGxhbmVfc3RhdGUgewogCWVudW0gZGNfcm90YXRpb25fYW5n
bGUgcm90YXRpb247CiAJZW51bSBwbGFuZV9zdGVyZW9fZm9ybWF0IHN0ZXJlb19mb3JtYXQ7CiAK
Kwlib29sIGlzX3RpbGluZ19yb3RhdGVkOwogCWJvb2wgcGVyX3BpeGVsX2FscGhhOwogCWJvb2wg
dmlzaWJsZTsKIAlib29sIGZsaXBfaW1tZWRpYXRlOwotLSAKMi4xNC4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
