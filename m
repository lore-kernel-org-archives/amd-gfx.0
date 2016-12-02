From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [V2 5/6] drm/amdgpu: Don't touch GFX hw during HW fini
Date: Fri, 2 Dec 2016 14:03:47 +0800
Message-ID: <1480658628-24446-6-git-send-email-Xiangliang.Yu@amd.com>
References: <1480658628-24446-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1480658628-24446-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>, shaoyunl <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>

Rm9yIFNSLUlPViBjbGllbnQsIGRyaXZlciBzaG91bGRuJ3QgdG91Y2ggdGhlIEdGWCBodyBkdXJp
bmcgSFcKZmluaSwgb3RoZXJ3aXNlLCBnZnggd2lsbCBmYWlsIHRvIHN0YXJ0IGFmdGVyIHJlYm9v
dGluZyBndWVzdCBvcy4KClNpZ25lZC1vZmYtYnk6IHNoYW95dW5sIDxTaGFveXVuLkxpdUBhbWQu
Y29tPgpTaWduZWQtb2ZmLWJ5OiBYaWFuZ2xpYW5nIFl1IDxYaWFuZ2xpYW5nLll1QGFtZC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyB8IDQgKysrKwogMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djhfMC5jCmluZGV4IGUxYjY2MTQuLjliOGQzZmUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y4XzAuYwpAQCAtNDgyOCw2ICs0ODI4LDEwIEBAIHN0YXRpYyBpbnQgZ2Z4X3Y4XzBfaHdf
ZmluaSh2b2lkICpoYW5kbGUpCiAKIAlhbWRncHVfaXJxX3B1dChhZGV2LCAmYWRldi0+Z2Z4LnBy
aXZfcmVnX2lycSwgMCk7CiAJYW1kZ3B1X2lycV9wdXQoYWRldiwgJmFkZXYtPmdmeC5wcml2X2lu
c3RfaXJxLCAwKTsKKwlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7CisJCXByX2RlYnVnKCJG
b3IgU1JJT1YgY2xpZW50LCBzaG91bGRuJ3QgZG8gYW55dGhpbmcuXG4iKTsKKwkJcmV0dXJuIDA7
CisJfQogCWdmeF92OF8wX2NwX2VuYWJsZShhZGV2LCBmYWxzZSk7CiAJZ2Z4X3Y4XzBfcmxjX3N0
b3AoYWRldik7CiAJZ2Z4X3Y4XzBfY3BfY29tcHV0ZV9maW5pKGFkZXYpOwotLSAKMi43LjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
