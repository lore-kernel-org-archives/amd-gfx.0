From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 049/138] drm/amd/powerplay: update hw fini function to relase
 some memory
Date: Fri, 25 Jan 2019 18:24:16 +0800
Message-ID: <1548411945-12396-50-git-send-email-ray.huang@amd.com>
References: <1548411945-12396-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1548411945-12396-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, Kevin Wang <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGlrdW4gR2FvIDxMaWt1bi5HYW9AYW1kLmNvbT4KClJlbGVhc2UgbWVtb3J5IG9mIHRh
YmxlX2NvbnRleHQtPmRyaXZlcl9wcHRhYmxlIGFuZAp0YWJsZV9jb250ZXh0LT5wcHRfaW5mb3Jt
YXRpb24gd2hlbiBzbXUgaHcgZmluaS4KClNpZ25lZC1vZmYtYnk6IExpa3VuIEdhbyA8TGlrdW4u
R2FvQGFtZC5jb20+ClJldmlld2VkLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgpS
ZXZpZXdlZC1ieTogS2V2aW4gV2FuZyA8S2V2aW4xLldhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgfCA1ICsrKysrCiAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvYW1kZ3B1X3NtdS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1k
Z3B1X3NtdS5jCmluZGV4IGM4NTMxNjYuLmU0ZGE0NjQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9hbWRncHVfc211LmMKQEAgLTQzNCwxMSArNDM0LDE2IEBAIHN0YXRpYyBpbnQg
c211X2h3X2Zpbmkodm9pZCAqaGFuZGxlKQogewogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOwogCXN0cnVjdCBzbXVfY29udGV4dCAq
c211ID0gJmFkZXYtPnNtdTsKKwlzdHJ1Y3Qgc211X3RhYmxlX2NvbnRleHQgKnRhYmxlX2NvbnRl
eHQgPSAmc211LT5zbXVfdGFibGU7CiAJaW50IHJldCA9IDA7CiAKIAlpZiAoYWRldi0+YXNpY190
eXBlIDwgQ0hJUF9WRUdBMjApCiAJCXJldHVybiAtRUlOVkFMOwogCisJaWYgKCF0YWJsZV9jb250
ZXh0LT5kcml2ZXJfcHB0YWJsZSkKKwkJcmV0dXJuIC1FSU5WQUw7CisJa2ZyZWUodGFibGVfY29u
dGV4dC0+ZHJpdmVyX3BwdGFibGUpOworCiAJcmV0ID0gc211X2ZpbmlfZmJfYWxsb2NhdGlvbnMo
c211KTsKIAlpZiAocmV0KQogCQlyZXR1cm4gcmV0OwotLSAKMi43LjQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
