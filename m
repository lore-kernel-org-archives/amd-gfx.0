From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 3/4] Call TimerFree for timer created in
 LeaveVT
Date: Thu, 19 Oct 2017 18:05:35 +0200
Message-ID: <20171019160536.6569-3-michel@daenzer.net>
References: <20171019160536.6569-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171019160536.6569-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpXZSB3ZXJlIGxl
YWtpbmcgdGhlIG1lbW9yeSBhbGxvY2F0ZWQgYnkgVGltZXJTZXQuCgpTaWduZWQtb2ZmLWJ5OiBN
aWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBzcmMvYW1kZ3B1X2tt
cy5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9z
cmMvYW1kZ3B1X2ttcy5jIGIvc3JjL2FtZGdwdV9rbXMuYwppbmRleCA3ZDU4MjA5NWIuLmNiMGZi
M2I1NyAxMDA2NDQKLS0tIGEvc3JjL2FtZGdwdV9rbXMuYworKysgYi9zcmMvYW1kZ3B1X2ttcy5j
CkBAIC0xNjI0LDYgKzE2MjQsNyBAQCBDQVJEMzIgY2xlYW51cF9ibGFja19mYihPc1RpbWVyUHRy
IHRpbWVyLCBDQVJEMzIgbm93LCBwb2ludGVyIGRhdGEpCiAJCWRybW1vZGVfZmJfcmVmZXJlbmNl
KHBBTURHUFVFbnQtPmZkLCAmZHJtbW9kZV9jcnRjLT5mYiwgTlVMTCk7CiAJfQogCisJVGltZXJG
cmVlKHRpbWVyKTsKIAlyZXR1cm4gMDsKIH0KIAotLSAKMi4xNC4yCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
