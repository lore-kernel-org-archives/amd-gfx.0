From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 25/28] drm/amd/display: Disable cursor on video surface.
Date: Wed, 3 May 2017 17:13:48 -0400
Message-ID: <20170503211351.3520-26-harry.wentland@amd.com>
References: <20170503211351.3520-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170503211351.3520-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>

RnJvbTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgoKU2lnbmVkLW9mZi1i
eTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgpBY2tlZC1ieTogSGFycnkg
V2VudGxhbmQgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENoZW5n
IDxUb255LkNoZW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2NvcmUvZGNfc3RyZWFtLmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19z
dHJlYW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3N0cmVhbS5j
CmluZGV4IDk5YjZhMTY5NWYyNi4uNGJhNDQ2ZGU0ZDAwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19zdHJlYW0uYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19zdHJlYW0uYwpAQCAtMjUwLDYgKzI1MCwxMCBAQCBi
b29sIGRjX3N0cmVhbV9zZXRfY3Vyc29yX3Bvc2l0aW9uKAogCQkJCSFwaXBlX2N0eC0+aXBwIHx8
ICFwaXBlX2N0eC0+c3VyZmFjZSkKIAkJCWNvbnRpbnVlOwogCisJCWlmIChwaXBlX2N0eC0+c3Vy
ZmFjZS0+cHVibGljLmFkZHJlc3MudHlwZQorCQkJCT09IFBMTl9BRERSX1RZUEVfVklERU9fUFJP
R1JFU1NJVkUpCisJCQlwb3NfY3B5LmVuYWJsZSA9IGZhbHNlOworCiAJCWlmIChwaXBlX2N0eC0+
dG9wX3BpcGUgJiYgcGlwZV9jdHgtPnN1cmZhY2UgIT0gcGlwZV9jdHgtPnRvcF9waXBlLT5zdXJm
YWNlKQogCQkJcG9zX2NweS5lbmFibGUgPSBmYWxzZTsKIAotLSAKMi4xMS4wCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
