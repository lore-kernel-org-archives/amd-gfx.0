From: Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/3] drm/amd/powerplay: remove mutex lock for smu_handle_task
 when smu late init
Date: Thu, 18 Jul 2019 18:02:16 +0800
Message-ID: <1563444138-23948-1-git-send-email-Jack.Gui@amd.com>
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
Cc: Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

cmVtb3ZlIG11dGV4IGxvY2sgd2hlbiBzbXUgbGF0ZSBpbml0IHRvIGNhbGwgc211X2hhbmRsZV90
YXNrCgpTaWduZWQtb2ZmLWJ5OiBDaGVuZ21pbmcgR3VpIDxKYWNrLkd1aUBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyB8IDIgLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L2FtZGdwdV9zbXUuYwppbmRleCA3ZDFiZDA5Li4xMjI5ODVjIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCkBAIC01NjksMTEgKzU2OSw5IEBAIHN0YXRpYyBp
bnQgc211X2xhdGVfaW5pdCh2b2lkICpoYW5kbGUpCiAKIAlpZiAoIXNtdS0+cG1fZW5hYmxlZCkK
IAkJcmV0dXJuIDA7Ci0JbXV0ZXhfbG9jaygmc211LT5tdXRleCk7CiAJc211X2hhbmRsZV90YXNr
KCZhZGV2LT5zbXUsCiAJCQlzbXUtPnNtdV9kcG0uZHBtX2xldmVsLAogCQkJQU1EX1BQX1RBU0tf
Q09NUExFVEVfSU5JVCk7Ci0JbXV0ZXhfdW5sb2NrKCZzbXUtPm11dGV4KTsKIAogCXJldHVybiAw
OwogfQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
