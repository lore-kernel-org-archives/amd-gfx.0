From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 4/4] Call RADEONFreeRec from
 RADEONFreeScreen_KMS even if info == NULL
Date: Wed, 14 Feb 2018 18:49:30 +0100
Message-ID: <20180214174930.5086-4-michel@daenzer.net>
References: <20180214174930.5086-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180214174930.5086-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpJdCdzIHNhZmUg
bm93LgoKKFBvcnRlZCBmcm9tIGFtZGdwdSBjb21taXQgYzliZDEzOTlhMTNjZWEyZTEzMzFhZjJj
ODI2Y2EwNTRiODhkYjA3MSkKClNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwu
ZGFlbnplckBhbWQuY29tPgotLS0KIHNyYy9yYWRlb25fa21zLmMgfCA1IC0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvcmFkZW9uX2ttcy5jIGIv
c3JjL3JhZGVvbl9rbXMuYwppbmRleCAwNmY3ODgzZTguLjZlNWJmNzgxNCAxMDA2NDQKLS0tIGEv
c3JjL3JhZGVvbl9rbXMuYworKysgYi9zcmMvcmFkZW9uX2ttcy5jCkBAIC0yMjA2LDE0ICsyMjA2
LDkgQEAgc3RhdGljIEJvb2wgUkFERU9OQ2xvc2VTY3JlZW5fS01TKFNjcmVlblB0ciBwU2NyZWVu
KQogCiB2b2lkIFJBREVPTkZyZWVTY3JlZW5fS01TKFNjcm5JbmZvUHRyIHBTY3JuKQogewotICAg
IFJBREVPTkluZm9QdHIgIGluZm8gID0gUkFERU9OUFRSKHBTY3JuKTsKLQogICAgIHhmODZEcnZN
c2dWZXJiKHBTY3JuLT5zY3JuSW5kZXgsIFhfSU5GTywgUkFERU9OX0xPR0xFVkVMX0RFQlVHLAog
CQkgICAiUkFERU9ORnJlZVNjcmVlblxuIik7CiAKLSAgICAvKiB3aGVuIHNlcnZlciBxdWl0cyBh
dCBQcmVJbml0LCB3ZSBkb24ndCBuZWVkIGRvIHRoaXMgYW55bW9yZSovCi0gICAgaWYgKCFpbmZv
KSByZXR1cm47Ci0KICAgICBSQURFT05GcmVlUmVjKHBTY3JuKTsKIH0KIAotLSAKMi4xNi4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
