From: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/display: Disable 4k@60 on DP as well for DCE11
Date: Tue, 27 Nov 2018 08:52:27 +0000
Message-ID: <1543308721-7138-1-git-send-email-shirish.s@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "S,
 Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

VGhpcyBwYXRjaCBleHRlbmRzIHRoZSBiZWxvdyBwYXRjaCB0byBhcHBseSBEUCBzaWduYWwgdHlw
ZSwgZm9yIGV4YWN0bHkKdGhlIHNhbWUgcmVhc29ucyBpdCB3YXMgZGlzYWJsZWQgZm9yIEhETUku
CgoiMWEwZTM0OCBkcm0vYW1kL2Rpc3BsYXk6IERpc2FibGUgNGsgNjAgSERNSSBvbiBEQ0UxMSIK
ClNpZ25lZC1vZmYtYnk6IFNoaXJpc2ggUyA8c2hpcmlzaC5zQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfbGlua19lbmNvZGVyLmMgfCA0ICsrKysK
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9saW5rX2VuY29kZXIuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2xpbmtfZW5jb2Rlci5jCmluZGV4IDNlMThlYTgu
LmQ1Nzg4MjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2Uv
ZGNlX2xpbmtfZW5jb2Rlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Y2UvZGNlX2xpbmtfZW5jb2Rlci5jCkBAIC02NjIsNiArNjYyLDEwIEBAIGJvb2wgZGNlMTEwX2xp
bmtfZW5jb2Rlcl92YWxpZGF0ZV9kcF9vdXRwdXQoCiAJY29uc3Qgc3RydWN0IGRjZTExMF9saW5r
X2VuY29kZXIgKmVuYzExMCwKIAljb25zdCBzdHJ1Y3QgZGNfY3J0Y190aW1pbmcgKmNydGNfdGlt
aW5nKQogeworCWlmIChjcnRjX3RpbWluZy0+cGl4X2Nsa19raHogPgorCQllbmMxMTAtPmJhc2Uu
ZmVhdHVyZXMubWF4X2hkbWlfcGl4ZWxfY2xvY2spCisJCXJldHVybiBmYWxzZTsKKwogCWlmIChj
cnRjX3RpbWluZy0+cGl4ZWxfZW5jb2RpbmcgPT0gUElYRUxfRU5DT0RJTkdfWUNCQ1I0MjApCiAJ
CXJldHVybiBmYWxzZTsKIAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
