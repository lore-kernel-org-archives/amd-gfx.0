From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu] Revert "Guard against pAMDGPUEnt == NULL in
 AMDGPUFreeRec"
Date: Wed, 14 Feb 2018 19:08:49 +0100
Message-ID: <20180214180849.6069-1-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpUaGlzIHJldmVy
dHMgY29tbWl0IGEyM2QxZmY3MDBkNDg2MTM4YzYyNGMyMDIzZDhkMjUxYzczNzA5YWYuCgpwQU1E
R1BVRW50IGNhbm5vdCBiZSBOVUxMIGFueW1vcmUgaGVyZSBub3cgdGhhdCB3ZSBubyBsb25nZXIg
Y2FsbApBTURHUFVGcmVlUmVjIGRpcmVjdGx5IGZyb20gQU1ER1BVUHJlSW5pdF9LTVMuCgpTaWdu
ZWQtb2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBz
cmMvYW1kZ3B1X2ttcy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2FtZGdwdV9rbXMuYyBiL3NyYy9hbWRncHVf
a21zLmMKaW5kZXggZjU4NzRkM2FmLi4xNWFkYjI5MzggMTAwNjQ0Ci0tLSBhL3NyYy9hbWRncHVf
a21zLmMKKysrIGIvc3JjL2FtZGdwdV9rbXMuYwpAQCAtMTM3LDcgKzEzNyw3IEBAIHN0YXRpYyB2
b2lkIEFNREdQVUZyZWVSZWMoU2NybkluZm9QdHIgcFNjcm4pCiAKIAlwUHJpdiA9IHhmODZHZXRF
bnRpdHlQcml2YXRlKHBFbnQtPmluZGV4LCBnQU1ER1BVRW50aXR5SW5kZXgpOwogCXBBTURHUFVF
bnQgPSBwUHJpdi0+cHRyOwotCWlmIChwQU1ER1BVRW50ICYmIHBBTURHUFVFbnQtPmZkID4gMCkg
eworCWlmIChwQU1ER1BVRW50LT5mZCA+IDApIHsKIAkJRGV2VW5pb24gKnBQcml2OwogCQlBTURH
UFVFbnRQdHIgcEFNREdQVUVudDsKIAkJcFByaXYgPSB4Zjg2R2V0RW50aXR5UHJpdmF0ZShwU2Ny
bi0+ZW50aXR5TGlzdFswXSwKLS0gCjIuMTYuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
