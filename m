From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay/cz: print message if smc message fails
Date: Thu, 22 Jun 2017 18:28:37 -0400
Message-ID: <1498170518-17360-1-git-send-email-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

SGVscGZ1bCBpbiBkZWJ1Z2dpbmcuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
c211bWdyL2N6X3NtdW1nci5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvc211bWdyL2N6X3NtdW1nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211
bWdyL2N6X3NtdW1nci5jCmluZGV4IDM5YzcwOTEuLjY1MmFhYTQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9jel9zbXVtZ3IuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvY3pfc211bWdyLmMKQEAgLTcyLDcgKzcyLDcg
QEAgc3RhdGljIGludCBjel9zZW5kX21zZ190b19zbWNfYXN5bmMoc3RydWN0IHBwX3NtdW1nciAq
c211bWdyLAogCXJlc3VsdCA9IFNNVU1fV0FJVF9GSUVMRF9VTkVRVUFMKHNtdW1nciwKIAkJCQkJ
U01VX01QMV9TUkJNMlBfUkVTUF8wLCBDT05URU5ULCAwKTsKIAlpZiAocmVzdWx0ICE9IDApIHsK
LQkJcHJfZXJyKCJjel9zZW5kX21zZ190b19zbWNfYXN5bmMgZmFpbGVkXG4iKTsKKwkJcHJfZXJy
KCJjel9zZW5kX21zZ190b19zbWNfYXN5bmMgKDB4JTA0eCkgZmFpbGVkXG4iLCBtc2cpOwogCQly
ZXR1cm4gcmVzdWx0OwogCX0KIAotLSAKMi41LjUKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
