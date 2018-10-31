From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/6] drm/amdgpu: Add fence flag AMDGPU_FENCE_FLAG_CLEAR_PREEMPT
Date: Wed, 31 Oct 2018 20:25:31 +0800
Message-ID: <1540988736-14311-1-git-send-email-Rex.Zhu@amd.com>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

d2hlbiBlbWl0IGZlbmNlIHdpdGggdGhpcyBmbGFnLCBkcml2ZXIgd2lsbCBkZS1hc3NlcnQKSUJf
UFJFRU1QVElPTgoKU2lnbmVkLW9mZi1ieTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmggfCAxICsKIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yaW5nLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmluZy5oCmluZGV4IGE0YjZlZmYuLmE5ZGRiMGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3JpbmcuaApAQCAtNDMsNiArNDMsNyBAQAogI2RlZmluZSBBTURHUFVfRkVOQ0Vf
RkxBR182NEJJVCAgICAgICAgICgxIDw8IDApCiAjZGVmaW5lIEFNREdQVV9GRU5DRV9GTEFHX0lO
VCAgICAgICAgICAgKDEgPDwgMSkKICNkZWZpbmUgQU1ER1BVX0ZFTkNFX0ZMQUdfVENfV0JfT05M
WSAgICAoMSA8PCAyKQorI2RlZmluZSBBTURHUFVfRkVOQ0VfRkxBR19DTEVBUl9QUkVFTVBUICAg
KDE8PDMpCiAKICNkZWZpbmUgdG9fYW1kZ3B1X3JpbmcocykgY29udGFpbmVyX29mKChzKSwgc3Ry
dWN0IGFtZGdwdV9yaW5nLCBzY2hlZCkKIAotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
