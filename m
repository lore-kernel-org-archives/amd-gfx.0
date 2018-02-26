From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 10/22] drm/amdgpu: no need to count emitted for SRIOV
Date: Mon, 26 Feb 2018 13:18:08 +0800
Message-ID: <1519622300-8990-11-git-send-email-Monk.Liu@amd.com>
References: <1519622300-8990-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1519622300-8990-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMzcwOTY2YWNkMGYxOTI1YTk5ZGZkZTg4ODY3OGU2ZTBmZDA5M2IxNQpTaWdu
ZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdXZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdXZkLmMKaW5kZXggMzM3ZGI1Ny4uNWZiNDM1NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV91dmQuYwpAQCAtMTExNywxMSArMTExNywxMyBAQCBzdGF0aWMgdm9pZCBhbWRn
cHVfdXZkX2lkbGVfd29ya19oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIHsKIAlz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9CiAJCWNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSwgdXZkLmlkbGVfd29yay53b3JrKTsKLQl1bnNpZ25lZCBmZW5jZXMgPSBh
bWRncHVfZmVuY2VfY291bnRfZW1pdHRlZCgmYWRldi0+dXZkLnJpbmcpOworCXVuc2lnbmVkIGZl
bmNlczsKIAogCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpCiAJCUJVRygpOwogCisJZmVuY2Vz
ID0gYW1kZ3B1X2ZlbmNlX2NvdW50X2VtaXR0ZWQoJmFkZXYtPnV2ZC5yaW5nKTsKKwogCWlmIChm
ZW5jZXMgPT0gMCkgewogCQlpZiAoYWRldi0+cG0uZHBtX2VuYWJsZWQpIHsKIAkJCWFtZGdwdV9k
cG1fZW5hYmxlX3V2ZChhZGV2LCBmYWxzZSk7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
