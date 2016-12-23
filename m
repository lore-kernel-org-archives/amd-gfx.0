From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 01/14] drm/amd/display: add pitch to cursor attributes
Date: Fri, 23 Dec 2016 10:57:53 -0500
Message-ID: <20161223155806.12043-2-harry.wentland@amd.com>
References: <20161223155806.12043-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161223155806.12043-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>

RnJvbTogVG9ueSBDaGVuZyA8dG9ueS5jaGVuZ0BhbWQuY29tPgoKQ2hhbmdlLUlkOiBJYzlhM2M3
ZDYwNmI2ZTQ4OTY3ZGE1OTc0NmNhM2VjNGMyMTc1NjVhZgpTaWduZWQtb2ZmLWJ5OiBUb255IENo
ZW5nIDx0b255LmNoZW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBZb25ncWlhbmcgU3VuIDx5b25n
cWlhbmcuc3VuQGFtZC5jb20+CkFja2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8SGFycnkuV2VudGxh
bmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfaHdfdHlw
ZXMuaCB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX2h3X3R5cGVzLmggYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfaHdfdHlwZXMuaAppbmRleCBiZDYwMzM3NGEzYzkuLjQ5
OWY2YjJhMzFmOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
X2h3X3R5cGVzLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX2h3X3R5
cGVzLmgKQEAgLTQwNyw2ICs0MDcsNyBAQCB1bmlvbiBkY19jdXJzb3JfYXR0cmlidXRlX2ZsYWdz
IHsKIAogc3RydWN0IGRjX2N1cnNvcl9hdHRyaWJ1dGVzIHsKIAlQSFlTSUNBTF9BRERSRVNTX0xP
QyBhZGRyZXNzOworCXVpbnQzMl90IHBpdGNoOwogCiAJLyogV2lkdGggYW5kIGhlaWdodCBzaG91
bGQgY29ycmVzcG9uZCB0byBjdXJzb3Igc3VyZmFjZSB3aWR0aCB4IGhlaWdoICovCiAJdWludDMy
X3Qgd2lkdGg7Ci0tIAoyLjkuMwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
