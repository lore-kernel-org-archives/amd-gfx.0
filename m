From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 1/2] Guard against pAMDGPUEnt == NULL in
 AMDGPUFreeRec
Date: Tue, 13 Feb 2018 19:12:38 +0100
Message-ID: <20180213181239.11065-1-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpUaGlzIGNhbiBo
YXBwZW4gaWYgUHJlSW5pdCBmYWlscyBlYXJseS4KClNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6Ru
emVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgotLS0KIHNyYy9hbWRncHVfa21zLmMgfCAyICst
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9zcmMvYW1kZ3B1X2ttcy5jIGIvc3JjL2FtZGdwdV9rbXMuYwppbmRleCA3ZGM5ZTIyYTku
LjQzYzE4ZDQyNiAxMDA2NDQKLS0tIGEvc3JjL2FtZGdwdV9rbXMuYworKysgYi9zcmMvYW1kZ3B1
X2ttcy5jCkBAIC0xMzcsNyArMTM3LDcgQEAgc3RhdGljIHZvaWQgQU1ER1BVRnJlZVJlYyhTY3Ju
SW5mb1B0ciBwU2NybikKIAogCXBQcml2ID0geGY4NkdldEVudGl0eVByaXZhdGUocEVudC0+aW5k
ZXgsIGdBTURHUFVFbnRpdHlJbmRleCk7CiAJcEFNREdQVUVudCA9IHBQcml2LT5wdHI7Ci0JaWYg
KHBBTURHUFVFbnQtPmZkID4gMCkgeworCWlmIChwQU1ER1BVRW50ICYmIHBBTURHUFVFbnQtPmZk
ID4gMCkgewogCQlEZXZVbmlvbiAqcFByaXY7CiAJCUFNREdQVUVudFB0ciBwQU1ER1BVRW50Owog
CQlwUHJpdiA9IHhmODZHZXRFbnRpdHlQcml2YXRlKHBTY3JuLT5lbnRpdHlMaXN0WzBdLAotLSAK
Mi4xNi4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
