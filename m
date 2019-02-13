From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 14/35] drm/amd/display: Add disable triple buffering DC debug
 option
Date: Wed, 13 Feb 2019 15:05:30 -0500
Message-ID: <1550088351-19449-15-git-send-email-sunpeng.li@amd.com>
References: <1550088351-19449-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1550088351-19449-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: Charlene Liu <charlene.liu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQ2hhcmxlbmUgTGl1IDxjaGFybGVuZS5saXVAYW1kLmNvbT4KCkFkZGVkIGEgImRpc2Fi
bGVfdHJpX2J1ZiIgREMgZGVidWcgb3B0aW9uLiBXaGVuIHNldCB0byAxICBmZWF0dXJlIHdpbGwK
YmUgb2ZmLgoKU2lnbmVkLW9mZi1ieTogQ2hhcmxlbmUgTGl1IDxjaGFybGVuZS5saXVAYW1kLmNv
bT4KUmV2aWV3ZWQtYnk6IERteXRybyBMYWt0eXVzaGtpbiA8RG15dHJvLkxha3R5dXNoa2luQGFt
ZC5jb20+CkFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaCB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAppbmRleCAxYTdmZDZhLi4x
YjhlYWY1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaApAQCAtMjU3LDYgKzI1Nyw3
IEBAIHN0cnVjdCBkY19kZWJ1Z19vcHRpb25zIHsKIAlib29sIHNraXBfZGV0ZWN0aW9uX2xpbmtf
dHJhaW5pbmc7CiAJdW5zaWduZWQgaW50IGZvcmNlX29kbV9jb21iaW5lOyAvL2JpdCB2ZWN0b3Ig
YmFzZWQgb24gb3RnIGluc3QKIAl1bnNpZ25lZCBpbnQgZm9yY2VfZmNsa19raHo7CisJYm9vbCBk
aXNhYmxlX3RyaV9idWY7CiB9OwogCiBzdHJ1Y3QgZGNfZGVidWdfZGF0YSB7Ci0tIAoyLjcuNAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
