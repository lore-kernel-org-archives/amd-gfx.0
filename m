From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 16/81] drm/amd/display: Enabling VSR on 4K display causes
 black screen
Date: Tue, 25 Jul 2017 09:53:36 -0400
Message-ID: <1500990881-6100-17-git-send-email-sunpeng.li@amd.com>
References: <1500990881-6100-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1500990881-6100-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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

RnJvbTogQ2hhcmxlbmUgTGl1IDxjaGFybGVuZS5saXVAYW1kLmNvbT4KCkNoYW5nZS1JZDogSTc4
M2FhNzdlNzM1NjhjNjc2OTc4MjI2ZjMwZGJlY2FjNGZlMTZjMWYKU2lnbmVkLW9mZi1ieTogQ2hh
cmxlbmUgTGl1IDxjaGFybGVuZS5saXVAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEFudGhvbnkgS29v
IDxBbnRob255Lktvb0BhbWQuY29tPgpBY2tlZC1ieTogSGFycnkgV2VudGxhbmQgPEhhcnJ5Lldl
bnRsYW5kQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEw
L2RjbjEwX2h3X3NlcXVlbmNlci5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjbjEwL2RjbjEwX2h3X3NlcXVlbmNlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h3X3NlcXVlbmNlci5jCmluZGV4IGY0MDRlNGUuLmNjNjc3
MDcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24x
MF9od19zZXF1ZW5jZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNu
MTAvZGNuMTBfaHdfc2VxdWVuY2VyLmMKQEAgLTE4MTksNyArMTgxOSw3IEBAIHN0YXRpYyB2b2lk
IHByb2dyYW1fYWxsX3BpcGVfaW5fdHJlZSgKIAkJcGlwZV9jdHgtPnRnLT5mdW5jcy0+c2V0X2Js
YW5rKHBpcGVfY3R4LT50ZywgIWlzX3BpcGVfdHJlZV92aXNpYmxlKHBpcGVfY3R4KSk7CiAJfQog
Ci0JaWYgKHBpcGVfY3R4LT5zdXJmYWNlLT5wdWJsaWMudmlzaWJsZSkgeworCWlmIChwaXBlX2N0
eC0+c3VyZmFjZSAhPSBOVUxMKSB7CiAJCWRjbjEwX3Bvd2VyX29uX2ZlKGRjLCBwaXBlX2N0eCwg
Y29udGV4dCk7CiAJCXVwZGF0ZV9kY2h1YnBfZHBwKGRjLCBwaXBlX2N0eCwgY29udGV4dCk7CiAJ
fQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
