From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu] Enable HW cursor support with PRIME slave
 output & Xorg > 1.18.99.901
Date: Thu, 13 Oct 2016 18:47:11 +0900
Message-ID: <20161013094711.16975-1-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpTdXBwb3J0ZWQg
c2luY2UgWG9yZyAxLjE4Ljk5LjIsIGJ1dCBidWdneSB1bnRpbCAxLjE4Ljk5LjkwMS4KClNpZ25l
ZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgotLS0KIHNy
Yy9kcm1tb2RlX2Rpc3BsYXkuYyB8IDUgKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2RybW1vZGVfZGlzcGxheS5j
IGIvc3JjL2RybW1vZGVfZGlzcGxheS5jCmluZGV4IGZiNDE5NzUuLmYyOTFmNmQgMTAwNjQ0Ci0t
LSBhL3NyYy9kcm1tb2RlX2Rpc3BsYXkuYworKysgYi9zcmMvZHJtbW9kZV9kaXNwbGF5LmMKQEAg
LTYxMSw4ICs2MTEsOSBAQCBkcm1tb2RlX2Nhbl91c2VfaHdfY3Vyc29yKHhmODZDcnRjUHRyIGNy
dGMpCiAJCXJldHVybiBGQUxTRTsKICNlbmRpZgogCi0jaWZkZWYgQU1ER1BVX1BJWE1BUF9TSEFS
SU5HCi0JLyogSFcgY3Vyc29yIG5vdCBzdXBwb3J0ZWQgeWV0IHdpdGggUmFuZFIgMS40IG11bHRp
aGVhZCAqLworI2lmIGRlZmluZWQoQU1ER1BVX1BJWE1BUF9TSEFSSU5HKSAmJiBcCisJWE9SR19W
RVJTSU9OX0NVUlJFTlQgPD0gWE9SR19WRVJTSU9OX05VTUVSSUMoMSwxOCw5OSw5MDEsMCkKKwkv
KiBIVyBjdXJzb3Igbm90IHN1cHBvcnRlZCB3aXRoIFJhbmRSIDEuNCBtdWx0aWhlYWQgKi8KIAlp
ZiAoIXhvcmdfbGlzdF9pc19lbXB0eSgmY3J0Yy0+c2Nybi0+cFNjcmVlbi0+cGl4bWFwX2RpcnR5
X2xpc3QpKQogCQlyZXR1cm4gRkFMU0U7CiAjZW5kaWYKLS0gCjIuOS4zCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
