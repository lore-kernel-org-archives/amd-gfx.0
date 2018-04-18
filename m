From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 1/3] Ignore AMDGPU_DRM_QUEUE_ERROR (0) in
 amdgpu_drm_abort_entry
Date: Wed, 18 Apr 2018 12:37:38 +0200
Message-ID: <20180418103740.13148-1-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpUaGlzIGFsbG93
cyBhIGZvbGxvd2luZyBjaGFuZ2UgdG8gYmUgc2xpZ2h0bHkgc2ltcGxlci4KClNpZ25lZC1vZmYt
Ynk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgotLS0KIHNyYy9hbWRn
cHVfZHJtX3F1ZXVlLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL3NyYy9hbWRncHVfZHJtX3F1ZXVlLmMgYi9zcmMvYW1kZ3B1X2RybV9xdWV1
ZS5jCmluZGV4IDJhYTIxZTA0ZC4uZDE0NTZjYTg0IDEwMDY0NAotLS0gYS9zcmMvYW1kZ3B1X2Ry
bV9xdWV1ZS5jCisrKyBiL3NyYy9hbWRncHVfZHJtX3F1ZXVlLmMKQEAgLTE1MCw2ICsxNTAsOSBA
QCBhbWRncHVfZHJtX2Fib3J0X2VudHJ5KHVpbnRwdHJfdCBzZXEpCiB7CiAJc3RydWN0IGFtZGdw
dV9kcm1fcXVldWVfZW50cnkgKmUsICp0bXA7CiAKKwlpZiAoc2VxID09IEFNREdQVV9EUk1fUVVF
VUVfRVJST1IpCisJCXJldHVybjsKKwogCXhvcmdfbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGUs
IHRtcCwgJmFtZGdwdV9kcm1fcXVldWUsIGxpc3QpIHsKIAkJaWYgKGUtPnNlcSA9PSBzZXEpIHsK
IAkJCWFtZGdwdV9kcm1fYWJvcnRfb25lKGUpOwotLSAKMi4xNy4wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
