From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 2/3] glamor: Bail CreatePixmap on
 unsupported pixmap depth
Date: Tue, 10 Jul 2018 18:34:50 +0200
Message-ID: <20180710163451.3583-2-michel@daenzer.net>
References: <20180710163451.3583-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180710163451.3583-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpGaXhlcyBjcmFz
aCBpbiB0aGF0IGNhc2UuCgpCdWd6aWxsYTogaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy8x
MDYyOTMKKFBvcnRlZCBmcm9tIHJhZGVvbiBjb21taXQgNjVjOWRmZWE0ZTg0MWI3ZDZmNzk1Yzc0
ODlmZWRlNThjNWU5NjMxZikKClNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwu
ZGFlbnplckBhbWQuY29tPgotLS0KIHNyYy9hbWRncHVfZ2xhbW9yLmMgfCAzICsrKwogMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NyYy9hbWRncHVfZ2xhbW9y
LmMgYi9zcmMvYW1kZ3B1X2dsYW1vci5jCmluZGV4IDQ0Y2RiY2ZmNy4uOGI4MzkxMDVlIDEwMDY0
NAotLS0gYS9zcmMvYW1kZ3B1X2dsYW1vci5jCisrKyBiL3NyYy9hbWRncHVfZ2xhbW9yLmMKQEAg
LTE4NSw2ICsxODUsOSBAQCBhbWRncHVfZ2xhbW9yX2NyZWF0ZV9waXhtYXAoU2NyZWVuUHRyIHNj
cmVlbiwgaW50IHcsIGludCBoLCBpbnQgZGVwdGgsCiAJc3RydWN0IGFtZGdwdV9waXhtYXAgKnBy
aXY7CiAJUGl4bWFwUHRyIHBpeG1hcCwgbmV3X3BpeG1hcCA9IE5VTEw7CiAKKwlpZiAoIXhmODZH
ZXRQaXhGb3JtYXQoc2NybiwgZGVwdGgpKQorCQlyZXR1cm4gTlVMTDsKKwogCWlmICghQU1ER1BV
X0NSRUFURV9QSVhNQVBfU0hBUkVEKHVzYWdlKSkgewogCQlpZiAoaW5mby0+c2hhZG93X3ByaW1h
cnkpIHsKIAkJCWlmICh1c2FnZSAhPSBDUkVBVEVfUElYTUFQX1VTQUdFX0JBQ0tJTkdfUElYTUFQ
KQotLSAKMi4xOC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
