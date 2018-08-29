From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 1/2] Handle ihandle == -1 in
 amdgpu_set_shared_pixmap_backing
Date: Wed, 29 Aug 2018 17:38:36 +0200
Message-ID: <20180829153837.31421-1-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpJdCBtZWFucyB0
byBzdG9wIHVzaW5nIHRoZSBzaGFyZWQgcGl4bWFwIGJhY2tpbmcuCgooUG9ydGVkIGZyb20gcmFk
ZW9uIGNvbW1pdCAxNzk5NjgwZjdiZDg0ZTA2MThmMzRmNGM3NDg2Nzk5NTIxZGRhZjgzKQoKU2ln
bmVkLW9mZi1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Ci0tLQog
c3JjL2FtZGdwdV9ib19oZWxwZXIuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvc3JjL2FtZGdwdV9ib19oZWxwZXIuYyBiL3NyYy9hbWRncHVf
Ym9faGVscGVyLmMKaW5kZXggOThlYjA0YTY0Li42ZmQ2ODg0NmYgMTAwNjQ0Ci0tLSBhL3NyYy9h
bWRncHVfYm9faGVscGVyLmMKKysrIGIvc3JjL2FtZGdwdV9ib19oZWxwZXIuYwpAQCAtNDAwLDYg
KzQwMCw5IEBAIEJvb2wgYW1kZ3B1X3NldF9zaGFyZWRfcGl4bWFwX2JhY2tpbmcoUGl4bWFwUHRy
IHBwaXgsIHZvaWQgKmZkX2hhbmRsZSkKIAl1aW50MzJfdCBzaXplID0gcHBpeC0+ZGV2S2luZCAq
IHBwaXgtPmRyYXdhYmxlLmhlaWdodDsKIAlCb29sIHJldDsKIAorCWlmIChpaGFuZGxlID09IC0x
KQorCQlyZXR1cm4gYW1kZ3B1X3NldF9waXhtYXBfYm8ocHBpeCwgTlVMTCk7CisKIAlpZiAoaW5m
by0+Z2JtKSB7CiAJCXN0cnVjdCBhbWRncHVfYnVmZmVyICpibzsKIAkJc3RydWN0IGdibV9pbXBv
cnRfZmRfZGF0YSBkYXRhOwotLSAKMi4xOC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
