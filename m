From: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/gfx9: reset compute ring wptr when gpu reset
Date: Tue, 4 Jun 2019 23:44:39 +0800
Message-ID: <1559663079-2448-1-git-send-email-yttao@amd.com>
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
Cc: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>

V2UgbmVlZCByZXNldCBjb21wdXRlIHJpbmcgd3B0ciB0byB6ZXJvIHdoZW4gZ3B1IHJlc2V0Cmlu
IG9yZGVyIHRvIHByZXZlbnQgQ1AgaGFuZy4KClNpZ25lZC1vZmYtYnk6IFlpbnRpYW4gVGFvIDx5
dHRhb0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMg
fCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jCmluZGV4IDJlOWNhYzEuLjI1MjExYmEgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y5XzAuYwpAQCAtMzE3NSw2ICszMTc1LDcgQEAgc3RhdGljIGludCBnZnhf
djlfMF9rY3FfaW5pdF9xdWV1ZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCiAKIAkJLyogcmVz
ZXQgcmluZyBidWZmZXIgKi8KIAkJcmluZy0+d3B0ciA9IDA7CisJCWFtZGdwdV9yaW5nX3NldF93
cHRyKHJpbmcpOwogCQlhbWRncHVfcmluZ19jbGVhcl9yaW5nKHJpbmcpOwogCX0gZWxzZSB7CiAJ
CWFtZGdwdV9yaW5nX2NsZWFyX3JpbmcocmluZyk7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
