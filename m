From: <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 12/18] drm/amdgpu: add vcn jpeg sw finish
Date: Wed, 30 May 2018 16:27:27 -0400
Message-ID: <1527712053-15027-12-git-send-email-boyuan.zhang@amd.com>
References: <1527712053-15027-1-git-send-email-boyuan.zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1527712053-15027-1-git-send-email-boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, Boyuan Zhang <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>, leo.liu-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

RnJvbTogQm95dWFuIFpoYW5nIDxib3l1YW4uemhhbmdAYW1kLmNvbT4KCkFkZCBzb2Z0d2FyZSBm
aW5pc2ggZm9yIHZjbiBqcGVnIHJpbmcuCgp2MjogcmVtb3ZlIHVubmVjZXNzYXJ5IHNjaGVkdWxl
ciBlbnRpdHkuCgpTaWduZWQtb2ZmLWJ5OiBCb3l1YW4gWmhhbmcgPGJveXVhbi56aGFuZ0BhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyB8IDIgKysK
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdmNuLmMKaW5kZXggNmZkNjA2Zi4uNTMwNzQ3NiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92Y24uYwpAQCAtMTE4LDYgKzExOCw4IEBAIGludCBhbWRncHVfdmNu
X3N3X2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJZm9yIChpID0gMDsgaSA8IGFk
ZXYtPnZjbi5udW1fZW5jX3JpbmdzOyArK2kpCiAJCWFtZGdwdV9yaW5nX2ZpbmkoJmFkZXYtPnZj
bi5yaW5nX2VuY1tpXSk7CiAKKwlhbWRncHVfcmluZ19maW5pKCZhZGV2LT52Y24ucmluZ19qcGVn
KTsKKwogCXJlbGVhc2VfZmlybXdhcmUoYWRldi0+dmNuLmZ3KTsKIAogCXJldHVybiAwOwotLSAK
Mi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
