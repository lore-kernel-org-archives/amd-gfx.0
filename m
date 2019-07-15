From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 49/87] drm/amd/display: Use helper for determining HDMI signal
Date: Mon, 15 Jul 2019 17:20:11 -0400
Message-ID: <20190715212049.4584-50-sunpeng.li@amd.com>
References: <20190715212049.4584-1-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190715212049.4584-1-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Charlene Liu <Charlene.Liu-5C7GfCeVMHo@public.gmane.org>, Eric Bernstein <eric.bernstein-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRXJpYyBCZXJuc3RlaW4gPGVyaWMuYmVybnN0ZWluQGFtZC5jb20+CgpVc2UgaGVscGVy
IHRvIGRldGVybWluZSBpZiBIRE1JIHNpZ25hbCB3aGVuIHByb2Nlc3NpbmcgYXZtdXRlLgoKU2ln
bmVkLW9mZi1ieTogRXJpYyBCZXJuc3RlaW4gPGVyaWMuYmVybnN0ZWluQGFtZC5jb20+ClJldmll
d2VkLWJ5OiBDaGFybGVuZSBMaXUgPENoYXJsZW5lLkxpdUBhbWQuY29tPgpBY2tlZC1ieTogTGVv
IExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGNfbGluay5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGNfbGluay5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUv
ZGNfbGluay5jCmluZGV4IDg4MDNmNmNjNTQxNC4uMTk0ODNmYmYzMjFiIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jCkBAIC0yODU4LDcgKzI4NTgs
NyBAQCB2b2lkIGNvcmVfbGlua19zZXRfYXZtdXRlKHN0cnVjdCBwaXBlX2N0eCAqcGlwZV9jdHgs
IGJvb2wgZW5hYmxlKQogewogCXN0cnVjdCBkYyAgKmNvcmVfZGMgPSBwaXBlX2N0eC0+c3RyZWFt
LT5jdHgtPmRjOwogCi0JaWYgKHBpcGVfY3R4LT5zdHJlYW0tPnNpZ25hbCAhPSBTSUdOQUxfVFlQ
RV9IRE1JX1RZUEVfQSkKKwlpZiAoIWRjX2lzX2hkbWlfc2lnbmFsKHBpcGVfY3R4LT5zdHJlYW0t
PnNpZ25hbCkpCiAJCXJldHVybjsKIAogCWNvcmVfZGMtPmh3c3Muc2V0X2F2bXV0ZShwaXBlX2N0
eCwgZW5hYmxlKTsKLS0gCjIuMjIuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
