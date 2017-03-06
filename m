From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 1/3] Don't use pScrn->is_gpu in
 AMDGPUCreateScreenResources_KMS
Date: Mon,  6 Mar 2017 18:33:01 +0900
Message-ID: <20170306093303.32723-2-michel@daenzer.net>
References: <20170306093303.32723-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170306093303.32723-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpMb29rcyBsaWtl
IHRoaXMgc251Y2sgaW4gYWNjaWRlbnRhbGx5LgoKQnJpbmdzIHVzIGJhY2sgaW4gbGluZSB3aXRo
IHRoZSByYWRlb24gZHJpdmVyLCBhbmQgZml4ZXMgdGhlIGJ1aWxkCmFnYWluc3Qgb2xkZXIgdmVy
c2lvbnMgb2YgeHNlcnZlciB3aGljaCBkaWRuJ3QgaGF2ZSB0aGUgaXNfZ3B1IGZpZWxkCnlldC4K
CkZpeGVzOiA2YmFiOGZhYmIzN2UgKCJSZW1vdmUgaW5mby0+ZHJpMi5kcm1fZmQgYW5kIGluZm8t
PmRybW1vZGUtPmZkIikKU2lnbmVkLW9mZi1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVu
emVyQGFtZC5jb20+Ci0tLQogc3JjL2FtZGdwdV9rbXMuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NyYy9hbWRncHVf
a21zLmMgYi9zcmMvYW1kZ3B1X2ttcy5jCmluZGV4IGM1MjA1ZTI1YS4uYmZjMzUzMDk2IDEwMDY0
NAotLS0gYS9zcmMvYW1kZ3B1X2ttcy5jCisrKyBiL3NyYy9hbWRncHVfa21zLmMKQEAgLTI0OCw3
ICsyNDgsNyBAQCBzdGF0aWMgQm9vbCBBTURHUFVDcmVhdGVTY3JlZW5SZXNvdXJjZXNfS01TKFNj
cmVlblB0ciBwU2NyZWVuKQogCQl9CiAJfQogCi0JaWYgKCFkcm1tb2RlX3NldF9kZXNpcmVkX21v
ZGVzKHBTY3JuLCAmaW5mby0+ZHJtbW9kZSwgcFNjcm4tPmlzX2dwdSkpCisJaWYgKCFkcm1tb2Rl
X3NldF9kZXNpcmVkX21vZGVzKHBTY3JuLCAmaW5mby0+ZHJtbW9kZSwgRkFMU0UpKQogCQlyZXR1
cm4gRkFMU0U7CiAKIAlkcm1tb2RlX3VldmVudF9pbml0KHBTY3JuLCAmaW5mby0+ZHJtbW9kZSk7
Ci0tIAoyLjExLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
