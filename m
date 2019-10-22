From: "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/vcn: Enable VCN2.5 encoding
Date: Tue, 22 Oct 2019 14:49:06 +0000
Message-ID: <1571755708-12173-1-git-send-email-James.Zhu@amd.com>
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
Cc: "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>

QWZ0ZXIgVkNOMi41IGZpcm13YXJlIChWZXJzaW9uIEVOQzogMS4xICBSZXZpc2lvbjogMTEpLApW
Q04yLjUgZW5jb2RpbmcgY2FuIHdvcmsgcHJvcGVybHkuCgpTaWduZWQtb2ZmLWJ5OiBKYW1lcyBa
aHUgPEphbWVzLlpodUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zj
bl92Ml81LmMgfCAzIC0tLQogMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMKaW5kZXggZDI3MGRmOC4uZmY2Y2M3NyAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jCkBAIC0yNjUsOSArMjY1LDYgQEAgc3RhdGlj
IGludCB2Y25fdjJfNV9od19pbml0KHZvaWQgKmhhbmRsZSkKIAogCQlmb3IgKGkgPSAwOyBpIDwg
YWRldi0+dmNuLm51bV9lbmNfcmluZ3M7ICsraSkgewogCQkJcmluZyA9ICZhZGV2LT52Y24uaW5z
dFtqXS5yaW5nX2VuY1tpXTsKLQkJCS8qIGRpc2FibGUgZW5jb2RlIHJpbmdzIHRpbGwgdGhlIHJv
YnVzdG5lc3Mgb2YgdGhlIEZXICovCi0JCQlyaW5nLT5zY2hlZC5yZWFkeSA9IGZhbHNlOwotCQkJ
Y29udGludWU7CiAJCQlyID0gYW1kZ3B1X3JpbmdfdGVzdF9oZWxwZXIocmluZyk7CiAJCQlpZiAo
cikKIAkJCQlnb3RvIGRvbmU7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
