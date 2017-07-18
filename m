From: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/3] drm/amd: Pass mqd as parameter in hqd_destroy for kfd2kgd
 interface
Date: Tue, 18 Jul 2017 17:41:41 -0400
Message-ID: <1500414101-5108-1-git-send-email-Shaoyun.Liu@amd.com>
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
Cc: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMTE1MjI5NjUyODc2MjJiZjU3N2ZjYTJhYTVkZWUyYWFmNzkxYTc3ZgpTaWdu
ZWQtb2ZmLWJ5OiBTaGFveXVuIExpdSA8U2hhb3l1bi5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2luY2x1ZGUva2dkX2tmZF9pbnRlcmZhY2UuaCB8IDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2Rfa2ZkX2ludGVyZmFjZS5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9pbmNsdWRlL2tnZF9rZmRfaW50ZXJmYWNlLmgKaW5kZXggMTA3OTRiMy4uMGFiMjkz
NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2tnZF9rZmRfaW50ZXJm
YWNlLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2tnZF9rZmRfaW50ZXJmYWNl
LmgKQEAgLTMwNiw3ICszMDYsNyBAQCBzdHJ1Y3Qga2ZkMmtnZF9jYWxscyB7CiAJYm9vbCAoKmhx
ZF9pc19vY2N1cGllZCkoc3RydWN0IGtnZF9kZXYgKmtnZCwgdWludDY0X3QgcXVldWVfYWRkcmVz
cywKIAkJCQl1aW50MzJfdCBwaXBlX2lkLCB1aW50MzJfdCBxdWV1ZV9pZCk7CiAKLQlpbnQgKCpo
cWRfZGVzdHJveSkoc3RydWN0IGtnZF9kZXYgKmtnZCwgdWludDMyX3QgcmVzZXRfdHlwZSwKKwlp
bnQgKCpocWRfZGVzdHJveSkoc3RydWN0IGtnZF9kZXYgKmtnZCwgdm9pZCAqbXFkLCB1aW50MzJf
dCByZXNldF90eXBlLAogCQkJCXVuc2lnbmVkIGludCB0aW1lb3V0LCB1aW50MzJfdCBwaXBlX2lk
LAogCQkJCXVpbnQzMl90IHF1ZXVlX2lkKTsKIAotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
