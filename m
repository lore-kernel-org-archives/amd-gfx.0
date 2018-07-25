From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu] glamor: Set AMDGPU_CREATE_PIXMAP_DRI2 for
 DRI3 pixmaps
Date: Wed, 25 Jul 2018 18:38:33 +0200
Message-ID: <20180725163833.21476-1-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpOb3QgZG9pbmcg
dGhpcyByZXN1bHRlZCBpbiBmYWxsaW5nIGJhY2sgdG8gc29mdHdhcmUgZm9yIERSSTMgY2xpZW50
CnByZXNlbnRhdGlvbiBvcGVyYXRpb25zIHdpdGggU2hhZG93UHJpbWFyeS4KClNpZ25lZC1vZmYt
Ynk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgotLS0KIHNyYy9hbWRn
cHVfZHJpMy5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1n
aXQgYS9zcmMvYW1kZ3B1X2RyaTMuYyBiL3NyYy9hbWRncHVfZHJpMy5jCmluZGV4IDg3ZTNkODVj
MS4uODRhMDNkYzM2IDEwMDY0NAotLS0gYS9zcmMvYW1kZ3B1X2RyaTMuYworKysgYi9zcmMvYW1k
Z3B1X2RyaTMuYwpAQCAtMTY4LDYgKzE2OCw3IEBAIHN0YXRpYyBQaXhtYXBQdHIgYW1kZ3B1X2Ry
aTNfcGl4bWFwX2Zyb21fZmQoU2NyZWVuUHRyIHNjcmVlbiwKIAogCQkJaWYgKHByaXYpIHsKIAkJ
CQlhbWRncHVfc2V0X3BpeG1hcF9wcml2YXRlKHBpeG1hcCwgcHJpdik7CisJCQkJcGl4bWFwLT51
c2FnZV9oaW50IHw9IEFNREdQVV9DUkVBVEVfUElYTUFQX0RSSTI7CiAJCQkJcmV0dXJuIHBpeG1h
cDsKIAkJCX0KIAotLSAKMi4xOC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
