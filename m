From: James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 14/18] drm/amdgpu/vcn:Add SPG mode Register XX check
Date: Wed, 10 Oct 2018 14:42:04 -0400
Message-ID: <1539196928-28890-15-git-send-email-James.Zhu@amd.com>
References: <1539196928-28890-1-git-send-email-James.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1539196928-28890-1-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: james.zhu-5C7GfCeVMHo@public.gmane.org

QWRkIFN0YXRpYyBQb3dlciBHYXRlIG1vZGUgUmVnaXN0ZXIgWFggY2hlY2sKClNpZ25lZC1vZmYt
Ynk6IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmNuX3YxXzAuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jCmluZGV4IDMyNzVlYWYuLmFm
YjE3NGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYwpAQCAtODQwLDYgKzg0
MCwxMCBAQCBzdGF0aWMgaW50IHZjbl92MV8wX3N0YXJ0X3NwZ19tb2RlKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQogCiAJdmNuX3YxXzBfbWNfcmVzdW1lX3NwZ19tb2RlKGFkZXYpOwogCisJ
V1JFRzMyX1NPQzE1KFVWRCwgMCwgbW1VVkRfUkVHX1hYX01BU0ssIDB4MTApOworCVdSRUczMl9T
T0MxNShVVkQsIDAsIG1tVVZEX1JCQ19YWF9JQl9SRUdfQ0hFQ0ssCisJCVJSRUczMl9TT0MxNShV
VkQsIDAsIG1tVVZEX1JCQ19YWF9JQl9SRUdfQ0hFQ0spIHwgMHgzKTsKKwogCS8qIHRha2UgYWxs
IHN1YmJsb2NrcyBvdXQgb2YgcmVzZXQsIGV4Y2VwdCBWQ1BVICovCiAJV1JFRzMyX1NPQzE1KFVW
RCwgMCwgbW1VVkRfU09GVF9SRVNFVCwKIAkJCVVWRF9TT0ZUX1JFU0VUX19WQ1BVX1NPRlRfUkVT
RVRfTUFTSyk7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
