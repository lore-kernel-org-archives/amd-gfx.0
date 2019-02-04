From: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/display: Use context parameters to enable FBC
Date: Mon, 4 Feb 2019 09:20:22 +0000
Message-ID: <1549272004-30469-1-git-send-email-shirish.s@amd.com>
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
To: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "S,
 Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

W1doYXRdCkZCQyBmYWlscyB0byBnZXQgZW5hYmxlZCB3aGVuIHN3aXRjaGVkIGJldHdlZW4gTElO
RUFSKGNvbnNvbGUvVlQpCmFuZCBub24tTElORUFSKEdVSSkgYmFzZWQgcmVuZGVyaW5nIGR1ZSB0
byBkZWZhdWx0IHZhbHVlIG9mCnRpbGluZyBpbmZvIHN0b3JlZCBpbiB0aGUgY3VycmVudF9zdGF0
ZSB3aGljaCBpcyB1c2VkIGZvciBkZWNpZGluZwp3aGV0aGVyIG9yIG5vdCB0byB0dXJuIEZCQyBv
biBvciBvZmYuCgpbSG93XQpVc2UgY29udGV4dCBzdHJ1Y3R1cmUncyB0aWxpbmcgaW5mb3JtYXRp
b24gd2hpY2ggaXMgY29oZXJhbnQgd2l0aAp0aGUgc2NyZWVuIHVwZGF0ZXMuCgpTaWduZWQtb2Zm
LWJ5OiBTaGlyaXNoIFMgPHNoaXJpc2guc0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVlbmNlci5jIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfaHdfc2VxdWVuY2VyLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9od19zZXF1ZW5j
ZXIuYwppbmRleCBkYjBlZjQxLi5mZDdjZDViIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9od19zZXF1ZW5jZXIuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9od19zZXF1ZW5jZXIuYwpAQCAt
MjUzNSw3ICsyNTM1LDcgQEAgc3RhdGljIHZvaWQgZGNlMTEwX2FwcGx5X2N0eF9mb3Jfc3VyZmFj
ZSgKIAl9CiAKIAlpZiAoZGMtPmZiY19jb21wcmVzc29yKQotCQllbmFibGVfZmJjKGRjLCBkYy0+
Y3VycmVudF9zdGF0ZSk7CisJCWVuYWJsZV9mYmMoZGMsIGNvbnRleHQpOwogfQogCiBzdGF0aWMg
dm9pZCBkY2UxMTBfcG93ZXJfZG93bl9mZShzdHJ1Y3QgZGMgKmRjLCBzdHJ1Y3QgcGlwZV9jdHgg
KnBpcGVfY3R4KQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
