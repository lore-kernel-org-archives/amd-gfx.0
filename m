From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: use memcpy_toio for VCE firmware upload
Date: Tue, 23 Aug 2016 11:20:26 +0200
Message-ID: <1471944026-2158-2-git-send-email-deathsimple@vodafone.de>
References: <1471944026-2158-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471944026-2158-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKVHJ5IHRv
IGJlIGNsZWFuIGhlcmUsIGV2ZW4gd2hlbiBpdCdzIGEgbm9vcCBvbiB4ODYuCgpTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jIHwgNCArKy0tCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92Y2UuYwppbmRleCAwNTg2NWNlLi5kYTUyYWYyIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNlLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jCkBAIC0yODIsOCArMjgyLDggQEAgaW50IGFtZGdw
dV92Y2VfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCiAJaGRyID0gKGNvbnN0
IHN0cnVjdCBjb21tb25fZmlybXdhcmVfaGVhZGVyICopYWRldi0+dmNlLmZ3LT5kYXRhOwogCW9m
ZnNldCA9IGxlMzJfdG9fY3B1KGhkci0+dWNvZGVfYXJyYXlfb2Zmc2V0X2J5dGVzKTsKLQltZW1j
cHkoY3B1X2FkZHIsIChhZGV2LT52Y2UuZnctPmRhdGEpICsgb2Zmc2V0LAotCQkoYWRldi0+dmNl
LmZ3LT5zaXplKSAtIG9mZnNldCk7CisJbWVtY3B5X3RvaW8oY3B1X2FkZHIsIGFkZXYtPnZjZS5m
dy0+ZGF0YSArIG9mZnNldCwKKwkJICAgIGFkZXYtPnZjZS5mdy0+c2l6ZSAtIG9mZnNldCk7CiAK
IAlhbWRncHVfYm9fa3VubWFwKGFkZXYtPnZjZS52Y3B1X2JvKTsKIAotLSAKMi41LjAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
