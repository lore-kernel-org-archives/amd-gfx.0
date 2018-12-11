From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 40/45] drm/amd/display: Don't log error if we have no
 connectors
Date: Tue, 11 Dec 2018 17:57:46 -0500
Message-ID: <1544569071-7114-41-git-send-email-sunpeng.li@amd.com>
References: <1544569071-7114-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1544569071-7114-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: sunpeng.li-5C7GfCeVMHo@public.gmane.org, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CgpbV2h5XQpJbiBj
ZXJ0YWluIGNvbmZpZ3VyYXRpb25zLCBzdWNoIGFzIFBYIGNvbmZpZ3Mgb3Igc29tZSBWZWdhMjAg
cGFydHMKREMgZ2V0cyBjcmVhdGVkIHdpdGhvdXQgY29ubmVjdG9ycy4KCltIb3ddCkRyb3AgdGhl
IGRtX2Vycm9yIHByaW50IHdoZW4gbm8gY29ubmVjdG9ycy4KClNpZ25lZC1vZmYtYnk6IEhhcnJ5
IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpSZXZpZXdlZC1ieTogTmljaG9sYXMg
S2F6bGF1c2thcyA8TmljaG9sYXMuS2F6bGF1c2thc0BhbWQuY29tPgpBY2tlZC1ieTogTGVvIExp
IDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2NvcmUvZGMuYyB8IDQgLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMKaW5kZXggOTNjYTZjYS4uMDUzZmMw
YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCkBAIC0xNTEsMTAg
KzE1MSw2IEBAIHN0YXRpYyBib29sIGNyZWF0ZV9saW5rcygKIAkJcmV0dXJuIGZhbHNlOwogCX0K
IAotCWlmIChjb25uZWN0b3JzX251bSA9PSAwICYmIG51bV92aXJ0dWFsX2xpbmtzID09IDApIHsK
LQkJZG1fZXJyb3IoIkRDOiBOdW1iZXIgb2YgY29ubmVjdG9ycyBpcyB6ZXJvIVxuIik7Ci0JfQot
CiAJZG1fb3V0cHV0X3RvX2NvbnNvbGUoCiAJCSJEQzogJXM6IGNvbm5lY3RvcnNfbnVtOiBwaHlz
aWNhbDolZCwgdmlydHVhbDolZFxuIiwKIAkJX19mdW5jX18sCi0tIAoyLjcuNAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
