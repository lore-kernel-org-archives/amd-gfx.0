From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 27/39] drm/amd/dal: remove unused function
Date: Wed, 23 Nov 2016 21:02:56 -0500
Message-ID: <20161124020308.28124-28-harry.wentland@amd.com>
References: <20161124020308.28124-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161124020308.28124-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKQ2hhbmdlLUlk
OiBJZTcxYWZmZTIxYmE0ZjhjYzI5ZjUxZTc3MjU5NTZlYTk1ZTNiNGQ4ZQpTaWduZWQtb2ZmLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkFja2VkLWJ5OiBIYXJy
eSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2RhbC9kYy9iaW9zL2Jpb3NfcGFyc2VyLmMgfCA2IC0tLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMv
Ymlvcy9iaW9zX3BhcnNlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvYmlvcy9iaW9z
X3BhcnNlci5jCmluZGV4IDYyYzJmYzVmYzIxNC4uZWJkMmU0MTlmOGYyIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9iaW9zL2Jpb3NfcGFyc2VyLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kYWwvZGMvYmlvcy9iaW9zX3BhcnNlci5jCkBAIC0zNjYxLDEyICszNjYx
LDYgQEAgc3RhdGljIHZvaWQgYmlvc19wYXJzZXJfcG9zdF9pbml0KHN0cnVjdCBkY19iaW9zICpk
Y2IpCiAJcHJvY2Vzc19leHRfZGlzcGxheV9jb25uZWN0aW9uX2luZm8oYnApOwogfQogCi1zdGF0
aWMgYm9vbCBiaW9zX3BhcnNlcl9pc19hY2NlbGVyYXRlZF9tb2RlKAotCXN0cnVjdCBkY19iaW9z
ICpkY2IpCi17Ci0JcmV0dXJuIGJpb3NfaXNfYWNjZWxlcmF0ZWRfbW9kZShkY2IpOwotfQotCiAv
KioKICAqIGJpb3NfcGFyc2VyX3NldF9zY3JhdGNoX2NyaXRpY2FsX3N0YXRlCiAgKgotLSAKMi4x
MC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
