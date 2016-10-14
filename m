From: =?UTF-8?q?Ernst=20Sj=C3=B6strand?= <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] amdgpu: Fix failing boot after support for third vce ring
Date: Fri, 14 Oct 2016 14:49:01 +0200
Message-ID: <1476449341-2673-1-git-send-email-ernstp@gmail.com>
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
Cc: =?UTF-8?q?Ernst=20Sj=C3=B6strand?= <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

TXkgRmlqaSBjbGFzcyBGdXJ5IGZhaWxzIHRvIGJvb3QgYWZ0ZXIgY29tbWl0CjZmMDM1OWZmNzMw
NzY0ODM5MDJkZTBjMTdmOTY0OWJmNTU2NTFlMmEKImRybS9hbWRncHUvdmNlMzogYWRkIHN1cHBv
cnQgZm9yIHRoaXJkIHZjZSByaW5nIgpUaGlzIGNvbW1pdHMgcmV2ZXJ0cyB0aGUgbnVtYmVyIG9m
IHZjZSByaW5ncyBiYWNrIHRvIDIsCmJ1dCBsZWF2ZXMgdGhlIG90aGVyIGNoYW5nZXMgaW50YWN0
LgoKU2lnbmVkLW9mZi1ieTogRXJuc3QgU2rDtnN0cmFuZCA8ZXJuc3RwQGdtYWlsLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjNfMC5jIHwgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3ZjZV92M18wLmMKaW5kZXggM2Y4OTllMy4uNmY1ZWI2NCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92Y2VfdjNfMC5jCkBAIC0zNTgsNyArMzU4LDcgQEAgc3RhdGljIGludCB2Y2VfdjNf
MF9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKIAkgICAgKEFNREdQVV9WQ0VfSEFSVkVTVF9WQ0Uw
IHwgQU1ER1BVX1ZDRV9IQVJWRVNUX1ZDRTEpKQogCQlyZXR1cm4gLUVOT0VOVDsKIAotCWFkZXYt
PnZjZS5udW1fcmluZ3MgPSAzOworCWFkZXYtPnZjZS5udW1fcmluZ3MgPSAyOwogCiAJdmNlX3Yz
XzBfc2V0X3JpbmdfZnVuY3MoYWRldik7CiAJdmNlX3YzXzBfc2V0X2lycV9mdW5jcyhhZGV2KTsK
LS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
