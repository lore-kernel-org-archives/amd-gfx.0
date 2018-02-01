From: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Set the bit of ip_block_mask correspond to the IP
 block define
Date: Thu,  1 Feb 2018 15:10:30 -0500
Message-ID: <1517515830-27767-1-git-send-email-Shaoyun.Liu@amd.com>
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

Q2hhbmdlLUlkOiBJNGJkYzZkYmNkODJmMzI0MTZmNjVlMGEzOGZiOWMzY2I1ODA2ODRiZgpTaWdu
ZWQtb2ZmLWJ5OiBTaGFveXVuIExpdSA8U2hhb3l1bi5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAzICsrLQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCAyMWJlNWU1Li4wNWJmOWI2IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0xMjk3LDcgKzEyOTcsOCBA
QCBzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfaXBfZWFybHlfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIAl9CiAKIAlmb3IgKGkgPSAwOyBpIDwgYWRldi0+bnVtX2lwX2Jsb2Nrczsg
aSsrKSB7Ci0JCWlmICgoYW1kZ3B1X2lwX2Jsb2NrX21hc2sgJiAoMSA8PCBpKSkgPT0gMCkgewor
CQlpZiAoKGFtZGdwdV9pcF9ibG9ja19tYXNrICYKKwkJCSgxIDw8IGFkZXYtPmlwX2Jsb2Nrc1tp
XS52ZXJzaW9uLT50eXBlKSkgPT0gMCkgewogCQkJRFJNX0VSUk9SKCJkaXNhYmxlZCBpcCBibG9j
azogJWQgPCVzPlxuIiwKIAkJCQkgIGksIGFkZXYtPmlwX2Jsb2Nrc1tpXS52ZXJzaW9uLT5mdW5j
cy0+bmFtZSk7CiAJCQlhZGV2LT5pcF9ibG9ja3NbaV0uc3RhdHVzLnZhbGlkID0gZmFsc2U7Ci0t
IAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
