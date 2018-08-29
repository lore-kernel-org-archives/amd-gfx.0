From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 1/3] Always delete entry from list in
 drm_queue_handler
Date: Wed, 29 Aug 2018 18:56:46 +0200
Message-ID: <20180829165648.1977-1-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpXZSBsZWZ0IGVu
dHJpZXMgd2l0aG91dCBhIGhhbmRsZXIgaG9vayBpbiB0aGUgbGlzdCwgc28gdGhlIGxpc3QgY291
bGQKa2VlcCB0YWtpbmcgbG9uZ2VyIHRvIHByb2Nlc3MgYW5kIHVzZSB1cCBtb3JlIG1lbW9yeS4K
ClNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgot
LS0KIHNyYy9hbWRncHVfZHJtX3F1ZXVlLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvYW1kZ3B1X2RybV9xdWV1
ZS5jIGIvc3JjL2FtZGdwdV9kcm1fcXVldWUuYwppbmRleCBiMTNkMjgwMTQuLmY5ZGI4MWMwOCAx
MDA2NDQKLS0tIGEvc3JjL2FtZGdwdV9kcm1fcXVldWUuYworKysgYi9zcmMvYW1kZ3B1X2RybV9x
dWV1ZS5jCkBAIC04Miw3ICs4Miw3IEBAIGFtZGdwdV9kcm1fcXVldWVfaGFuZGxlcihzdHJ1Y3Qg
eG9yZ19saXN0ICpzaWduYWxsZWQsIHVuc2lnbmVkIGludCBmcmFtZSwKIAl4b3JnX2xpc3RfZm9y
X2VhY2hfZW50cnlfc2FmZShlLCB0bXAsICZhbWRncHVfZHJtX3F1ZXVlLCBsaXN0KSB7CiAJCWlm
IChlLT5zZXEgPT0gc2VxKSB7CiAJCQlpZiAoIWUtPmhhbmRsZXIpIHsKLQkJCQllLT5hYm9ydChl
LT5jcnRjLCBlLT5kYXRhKTsKKwkJCQlhbWRncHVfZHJtX3F1ZXVlX2hhbmRsZV9vbmUoZSk7CiAJ
CQkJYnJlYWs7CiAJCQl9CiAKLS0gCjIuMTguMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
