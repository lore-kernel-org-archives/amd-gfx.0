From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 03/21] Ignore RADEON_DRM_QUEUE_ERROR (0) in
 radeon_drm_abort_entry
Date: Wed, 11 Jul 2018 19:27:48 +0200
Message-ID: <20180711172806.22849-4-michel@daenzer.net>
References: <20180711172806.22849-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180711172806.22849-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
cyBhIGZvbGxvd2luZyBjaGFuZ2UgdG8gYmUgc2xpZ2h0bHkgc2ltcGxlci4KKFBvcnRlZCBmcm9t
IGFtZGdwdSBjb21taXQgOGZjYzNhOWI0M2QzOTA3MDUyYTgzYTk2ZTVhMjQyM2FmYWI1YWQzZikK
ClNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgot
LS0KIHNyYy9yYWRlb25fZHJtX3F1ZXVlLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NyYy9yYWRlb25fZHJtX3F1ZXVlLmMgYi9zcmMvcmFk
ZW9uX2RybV9xdWV1ZS5jCmluZGV4IDg2OWY5NWMzMi4uYWM3NzVmODZhIDEwMDY0NAotLS0gYS9z
cmMvcmFkZW9uX2RybV9xdWV1ZS5jCisrKyBiL3NyYy9yYWRlb25fZHJtX3F1ZXVlLmMKQEAgLTE1
MCw2ICsxNTAsOSBAQCByYWRlb25fZHJtX2Fib3J0X2VudHJ5KHVpbnRwdHJfdCBzZXEpCiB7CiAg
ICAgc3RydWN0IHJhZGVvbl9kcm1fcXVldWVfZW50cnkgKmUsICp0bXA7CiAKKyAgICBpZiAoc2Vx
ID09IFJBREVPTl9EUk1fUVVFVUVfRVJST1IpCisJcmV0dXJuOworCiAgICAgeG9yZ19saXN0X2Zv
cl9lYWNoX2VudHJ5X3NhZmUoZSwgdG1wLCAmcmFkZW9uX2RybV9xdWV1ZSwgbGlzdCkgewogCWlm
IChlLT5zZXEgPT0gc2VxKSB7CiAJICAgIHJhZGVvbl9kcm1fYWJvcnRfb25lKGUpOwotLSAKMi4x
OC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
