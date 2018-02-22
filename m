From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu: Change default value of module parameter
 amdgpu_pp_feature_mask
Date: Thu, 22 Feb 2018 18:26:52 +0800
Message-ID: <1519295213-5754-1-git-send-email-Rex.Zhu@amd.com>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q3VycmVudGx5IGFsbCBwcCBmZWF0dXJlcyBhcmUgZW5hYmxlZCBieSBkZWZhdWx0IGV4Y2VwdApP
VkVSRFJJVkUKCkNoYW5nZS1JZDogSTBjMDQwMGRiOTY2ZmI4ZjJhMTI3OGM0NjdmZDZkMGNjZWY5
NDc0MDcKU2lnbmVkLW9mZi1ieTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kcnYuYwppbmRleCBjNWIzNGYwLi42OWNmNDkwIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rydi5jCkBAIC0xMjEsNyArMTIxLDcgQEAKIHVpbnQgYW1kZ3B1X3Nk
bWFfcGhhc2VfcXVhbnR1bSA9IDMyOwogY2hhciAqYW1kZ3B1X2Rpc2FibGVfY3UgPSBOVUxMOwog
Y2hhciAqYW1kZ3B1X3ZpcnR1YWxfZGlzcGxheSA9IE5VTEw7Ci11aW50IGFtZGdwdV9wcF9mZWF0
dXJlX21hc2sgPSAweDNmZmY7Cit1aW50IGFtZGdwdV9wcF9mZWF0dXJlX21hc2sgPSAweGZmZmZi
ZmZmOwogaW50IGFtZGdwdV9uZ2cgPSAwOwogaW50IGFtZGdwdV9wcmltX2J1Zl9wZXJfc2UgPSAw
OwogaW50IGFtZGdwdV9wb3NfYnVmX3Blcl9zZSA9IDA7Ci0tIAoxLjkuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
