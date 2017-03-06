From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu] glamor: Don't flush in BlockHandler with
 Xorg >= 1.19
Date: Mon,  6 Mar 2017 18:49:50 +0900
Message-ID: <20170306094950.992-1-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpUaGlzIHdhcyBv
bmx5IG5lY2Vzc2FyeSB3aXRoIG9sZGVyIHZlcnNpb25zIGZvciBkcml2aW5nIHRoZSBGQk8gY2Fj
aGUKZXhwaXJ5IG1lY2hhbmlzbS4KClNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNo
ZWwuZGFlbnplckBhbWQuY29tPgotLS0KIHNyYy9hbWRncHVfa21zLmMgfCAyICsrCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvc3JjL2FtZGdwdV9rbXMuYyBi
L3NyYy9hbWRncHVfa21zLmMKaW5kZXggZDQ4YWQ0ODBhLi4zMWMyZTg2ZjIgMTAwNjQ0Ci0tLSBh
L3NyYy9hbWRncHVfa21zLmMKKysrIGIvc3JjL2FtZGdwdV9rbXMuYwpAQCAtMTAzNSw4ICsxMDM1
LDEwIEBAIHN0YXRpYyB2b2lkIEFNREdQVUJsb2NrSGFuZGxlcl9LTVMoQkxPQ0tIQU5ETEVSX0FS
R1NfREVDTCkKIAkJfQogCX0KIAorI2lmIFhPUkdfVkVSU0lPTl9DVVJSRU5UIDwgWE9SR19WRVJT
SU9OX05VTUVSSUMoMSwxOSwwLDAsMCkKIAlpZiAoaW5mby0+dXNlX2dsYW1vcikKIAkJYW1kZ3B1
X2dsYW1vcl9mbHVzaChwU2Nybik7CisjZW5kaWYKIAogI2lmZGVmIEFNREdQVV9QSVhNQVBfU0hB
UklORwogCWFtZGdwdV9kaXJ0eV91cGRhdGUocFNjcm4pOwotLSAKMi4xMS4wCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
