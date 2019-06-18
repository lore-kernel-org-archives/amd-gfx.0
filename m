From: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm 3/4] libdrm/amdgpu: add new vram type (GDDR6) for navi10
Date: Tue, 18 Jun 2019 19:40:32 +0800
Message-ID: <1560858033-1499-3-git-send-email-Hawking.Zhang@amd.com>
References: <1560858033-1499-1-git-send-email-Hawking.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1560858033-1499-1-git-send-email-Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPgoKQU1ER1BVX1ZSQU1fVFlQRV9HRERS
NiBpcyBhIG5ldyB2cmFtIHR5cGUgZm9yIG5hdmkxMAoKQ2hhbmdlLUlkOiBJNjc4OTIzMGY4Zjdm
NWJkY2IwYWVjODJjYzc2NGQxMGQ3MmM0Y2JhOApTaWduZWQtb2ZmLWJ5OiBUYW8gWmhvdSA8dGFv
Lnpob3UxQGFtZC5jb20+ClJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5n
QGFtZC5jb20+Ci0tLQogaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oIHwgMSArCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9hbWRncHVfZHJt
LmggYi9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmgKaW5kZXggYjBjNzU1NS4uMDE1YmQ5ZiAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oCisrKyBiL2luY2x1ZGUvZHJtL2FtZGdw
dV9kcm0uaApAQCAtOTEzLDYgKzkxMyw3IEBAIHN0cnVjdCBkcm1fYW1kZ3B1X2luZm9fZmlybXdh
cmUgewogI2RlZmluZSBBTURHUFVfVlJBTV9UWVBFX0hCTSAgIDYKICNkZWZpbmUgQU1ER1BVX1ZS
QU1fVFlQRV9ERFIzICA3CiAjZGVmaW5lIEFNREdQVV9WUkFNX1RZUEVfRERSNCAgOAorI2RlZmlu
ZSBBTURHUFVfVlJBTV9UWVBFX0dERFI2IDkKIAogc3RydWN0IGRybV9hbWRncHVfaW5mb19kZXZp
Y2UgewogCS8qKiBQQ0kgRGV2aWNlIElEICovCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
