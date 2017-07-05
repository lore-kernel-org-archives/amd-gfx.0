From: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Free resources of bo_list when idr_alloc fails
Date: Wed,  5 Jul 2017 18:27:03 -0400
Message-ID: <1499293623-24544-1-git-send-email-AlexBin.Xie@amd.com>
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
Cc: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogQWxleCBYaWUgPEFsZXhCaW4uWGllQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JvX2xpc3QuYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ib19saXN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYm9fbGlzdC5jCmluZGV4IGVmYTY5MDMuLmRjODc5NjIgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ib19saXN0LmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JvX2xpc3QuYwpAQCAtODMsNyArODMsNyBA
QCBzdGF0aWMgaW50IGFtZGdwdV9ib19saXN0X2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwKIAlyID0gaWRyX2FsbG9jKCZmcHJpdi0+Ym9fbGlzdF9oYW5kbGVzLCBsaXN0LCAxLCAw
LCBHRlBfS0VSTkVMKTsKIAltdXRleF91bmxvY2soJmZwcml2LT5ib19saXN0X2xvY2spOwogCWlm
IChyIDwgMCkgewotCQlrZnJlZShsaXN0KTsKKwkJYW1kZ3B1X2JvX2xpc3RfZnJlZShsaXN0KTsK
IAkJcmV0dXJuIHI7CiAJfQogCSppZCA9IHI7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
