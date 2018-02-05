From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH umr] use correct MM hub for SDMA IB packets
Date: Mon,  5 Feb 2018 14:09:52 -0500
Message-ID: <20180205190952.20830-1-tom.stdenis@amd.com>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIHNy
Yy9saWIvcmluZ19kZWNvZGUuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9zcmMvbGliL3JpbmdfZGVjb2RlLmMgYi9zcmMvbGliL3JpbmdfZGVj
b2RlLmMKaW5kZXggZjg3ZDQzZTA3N2EyLi5iMTg5NDhkMjZiNWYgMTAwNjQ0Ci0tLSBhL3NyYy9s
aWIvcmluZ19kZWNvZGUuYworKysgYi9zcmMvbGliL3JpbmdfZGVjb2RlLmMKQEAgLTEzMzEsNiAr
MTMzMSw4IEBAIHN0YXRpYyB2b2lkIHByaW50X2RlY29kZV9zZG1hKHN0cnVjdCB1bXJfYXNpYyAq
YXNpYywgc3RydWN0IHVtcl9yaW5nX2RlY29kZXIgKmRlCiAJCQkJCWJyZWFrOwogCQkJCWNhc2Ug
NDogLy8gSU5ESVJFQ1QKIAkJCQkJZGVjb2Rlci0+c2RtYS5uZXh0X2liX3N0YXRlLmliX3ZtaWQg
PSAoaWIgPj4gMTYpICYgMHhGOworCQkJCQlpZiAoYXNpYy0+ZmFtaWx5ID49IEZBTUlMWV9BSSkK
KwkJCQkJCWRlY29kZXItPnNkbWEubmV4dF9pYl9zdGF0ZS5pYl92bWlkIHw9IFVNUl9NTV9IVUI7
CiAJCQkJCXByaW50ZigiLCBWTUlEOiAlcyV1JXMiLCBCTFVFLCBkZWNvZGVyLT5zZG1hLm5leHRf
aWJfc3RhdGUuaWJfdm1pZCwgUlNUKTsKIAkJCQkJZGVjb2Rlci0+c2RtYS5uX3dvcmRzID0gNjsK
IAkJCQkJYnJlYWs7Ci0tIAoyLjE0LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
