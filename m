From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 02/39] drm/amd/dal: Add missing return to bios helper
Date: Wed, 23 Nov 2016 21:02:31 -0500
Message-ID: <20161124020308.28124-3-harry.wentland@amd.com>
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
Cc: Jordan Lazare <Jordan.Lazare-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSm9yZGFuIExhemFyZSA8Sm9yZGFuLkxhemFyZUBhbWQuY29tPgoKQ2hhbmdlLUlkOiBJ
Y2YxNWE2YmQ5OGMyYWZkNDEyMTY3MGUzYzJiYjA4NTU5Y2YwMzQ4YQpTaWduZWQtb2ZmLWJ5OiBK
b3JkYW4gTGF6YXJlIDxKb3JkYW4uTGF6YXJlQGFtZC5jb20+CkFja2VkLWJ5OiBIYXJyeSBXZW50
bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rh
bC9kYy9iaW9zL2Jpb3NfcGFyc2VyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rh
bC9kYy9iaW9zL2Jpb3NfcGFyc2VyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9iaW9z
L2Jpb3NfcGFyc2VyLmMKaW5kZXggN2ZkY2U5YjYyZjFkLi42N2VjYmNhOTljNzkgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGFsL2RjL2Jpb3MvYmlvc19wYXJzZXIuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9iaW9zL2Jpb3NfcGFyc2VyLmMKQEAgLTM2NjUsNyAr
MzY2NSw3IEBAIHN0YXRpYyB2b2lkIGJpb3NfcGFyc2VyX3Bvc3RfaW5pdChzdHJ1Y3QgZGNfYmlv
cyAqZGNiKQogc3RhdGljIGJvb2wgYmlvc19wYXJzZXJfaXNfYWNjZWxlcmF0ZWRfbW9kZSgKIAlz
dHJ1Y3QgZGNfYmlvcyAqZGNiKQogewotCWJpb3NfaXNfYWNjZWxlcmF0ZWRfbW9kZShkY2IpOwor
CXJldHVybiBiaW9zX2lzX2FjY2VsZXJhdGVkX21vZGUoZGNiKTsKIH0KIAogLyoqCi0tIAoyLjEw
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
