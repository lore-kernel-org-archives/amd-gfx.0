From: Tiecheng Zhou <Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/sriov: sriov won't support gfx off
Date: Mon, 13 Aug 2018 14:03:22 +0800
Message-ID: <1534140202-1939-1-git-send-email-Tiecheng.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Tiecheng Zhou <Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogVGllY2hlbmcgWmhvdSA8VGllY2hlbmcuWmhvdUBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYyB8IDIgKysKIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ2Z4LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z2Z4LmMKaW5kZXggNzkwZmQ1NC4uZTY3YWIyNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9nZnguYwpAQCAtMzg5LDYgKzM4OSw4IEBAIHZvaWQgYW1kZ3B1X2dmeF9jb21wdXRl
X21xZF9zd19maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCiB2b2lkIGFtZGdwdV9n
Znhfb2ZmX2N0cmwoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGJvb2wgZW5hYmxlKQogewor
CWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpCisJCXJldHVybjsKIAlpZiAoIShhZGV2LT5wb3dl
cnBsYXkucHBfZmVhdHVyZSAmIFBQX0dGWE9GRl9NQVNLKSkKIAkJcmV0dXJuOwogCi0tIAoyLjcu
NAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
