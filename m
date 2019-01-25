From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 011/138] drm/amd/powerplay: add interface to init fb
 allocations (v2)
Date: Fri, 25 Jan 2019 18:23:38 +0800
Message-ID: <1548411945-12396-12-git-send-email-ray.huang@amd.com>
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
Cc: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, Kevin Wang <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

VGhpcyBwYXRjaCBhZGRzIGludGVyZmFjZSB0byBpbml0IGZiIGFsbG9jYXRpb25zIGZvciBzbXUu
Ckl0J3MgdG8gYWxsb2NhdGUgdnJhbSBib3MgdG8gc3RvcmUgc21jIHRhYmxlIGNvbnRlbnRzLgoK
djI6IGFkZCBkZXRhaWxlZCBpbmZvIHRvIGRlc2NyaWJlIHRoaXMgZnVuY3Rpb24KClNpZ25lZC1v
ZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jIHwgMTMgKysrKysrKysrKysrKwogMSBmaWxlIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9hbWRncHVfc211LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9h
bWRncHVfc211LmMKaW5kZXggZDdkNDBiZi4uOTMxMzQzYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYwpAQCAtMTMyLDYgKzEzMiwxMiBAQCBzdGF0aWMgaW50
IHNtdV9zd19maW5pKHZvaWQgKmhhbmRsZSkKIAlyZXR1cm4gMDsKIH0KIAorc3RhdGljIGludCBz
bXVfaW5pdF9mYl9hbGxvY2F0aW9ucyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKK3sKKwkvKiBU
T0RPICovCisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBpbnQgc211X3NtY190YWJsZV9od19pbml0
KHN0cnVjdCBzbXVfY29udGV4dCAqc211KQogewogCWludCByZXQ7CkBAIC0xNTMsNiArMTU5LDEz
IEBAIHN0YXRpYyBpbnQgc211X3NtY190YWJsZV9od19pbml0KHN0cnVjdCBzbXVfY29udGV4dCAq
c211KQogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAKKwkvKgorCSAqIGFsbG9jYXRlIHZyYW0g
Ym9zIHRvIHN0b3JlIHNtYyB0YWJsZSBjb250ZW50cy4KKwkgKi8KKwlyZXQgPSBzbXVfaW5pdF9m
Yl9hbGxvY2F0aW9ucyhzbXUpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisKIAlyZXR1cm4g
MDsKIH0KIAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
