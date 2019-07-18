From: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdkfd: Add DID for Navi12
Date: Thu, 18 Jul 2019 15:17:14 +0000
Message-ID: <1563463027-1201-1-git-send-email-shaoyun.liu@amd.com>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>

QWRkIGRldmljZSBpZCBmb3IgS0ZECgpDaGFuZ2UtSWQ6IEk0NGU4ZTg4NGQwZGM4NjIwOWRlN2Mw
YjZmNDc4NGQwNmVlMzcxMDc5ClNpZ25lZC1vZmYtYnk6IHNoYW95dW5sIDxzaGFveXVuLmxpdUBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyB8IDMg
KysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2RldmljZS5jCmluZGV4IDI1MTQyNjMuLmNiNmJkM2EgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMKQEAgLTQ1OCw2ICs0NTgsOSBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGtmZF9kZXZpY2VpZCBzdXBwb3J0ZWRfZGV2aWNlc1tdID0gewogCXsgMHg3MzE4
LCAmbmF2aTEwX2RldmljZV9pbmZvIH0sCS8qIE5hdmkxMCAqLwogCXsgMHg3MzFhLCAmbmF2aTEw
X2RldmljZV9pbmZvIH0sCS8qIE5hdmkxMCAqLwogCXsgMHg3MzFmLCAmbmF2aTEwX2RldmljZV9p
bmZvIH0sCS8qIE5hdmkxMCAqLworCS8qIE5hdmkxMiAqLworCXsgMHg3MzYwLCAmbmF2aTEwX2Rl
dmljZV9pbmZvIH0sCS8qIE5hdmkxMiAqLworCXsgMHg2OWIwLCAmbmF2aTEwX2RldmljZV9pbmZv
IH0sCS8qIE5hdmkxMiAqLwogfTsKIAogc3RhdGljIGludCBrZmRfZ3R0X3NhX2luaXQoc3RydWN0
IGtmZF9kZXYgKmtmZCwgdW5zaWduZWQgaW50IGJ1Zl9zaXplLAotLSAKMi43LjQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
