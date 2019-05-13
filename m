From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amd/powerplay: drop redundant smu call
Date: Mon, 13 May 2019 15:53:01 +0800
Message-ID: <20190513075302.10731-2-evan.quan@amd.com>
References: <20190513075302.10731-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190513075302.10731-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

c211X2dldF9jbGtfaW5mb19mcm9tX3ZiaW9zKCkgd2FzIGNhbGxlZCByZXBlYXRlZGx5LiBJdApz
ZWVtcyBhIG1lcmdlIGVycm9yLgoKQ2hhbmdlLUlkOiBJY2UyMmExNzFjYmI5NzZkMGFlYmQ2NjA5
MzQ0YTEwYjAwOGQxOGYxNApTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyB8IDQg
LS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCmluZGV4IGVkODg0MDAyNmU1OS4uYjExOWEyNzZhOTc3
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCkBAIC02MzYs
MTAgKzYzNiw2IEBAIHN0YXRpYyBpbnQgc211X3NtY190YWJsZV9od19pbml0KHN0cnVjdCBzbXVf
Y29udGV4dCAqc211LAogCQkgKiBjaGVjayBpZiB0aGUgZm9ybWF0X3JldmlzaW9uIGluIHZiaW9z
IGlzIHVwIHRvIHBwdGFibGUgaGVhZGVyCiAJCSAqIHZlcnNpb24sIGFuZCB0aGUgc3RydWN0dXJl
IHNpemUgaXMgbm90IDAuCiAJCSAqLwotCQlyZXQgPSBzbXVfZ2V0X2Nsa19pbmZvX2Zyb21fdmJp
b3Moc211KTsKLQkJaWYgKHJldCkKLQkJCXJldHVybiByZXQ7Ci0KIAkJcmV0ID0gc211X2NoZWNr
X3BwdGFibGUoc211KTsKIAkJaWYgKHJldCkKIAkJCXJldHVybiByZXQ7Ci0tIAoyLjIxLjAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
