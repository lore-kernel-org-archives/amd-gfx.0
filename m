From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 3/4] EXA: Handle ihandle == -1 in
 RADEONEXASharePixmapBacking
Date: Fri, 24 Aug 2018 11:02:43 +0200
Message-ID: <20180824090244.16520-3-michel@daenzer.net>
References: <20180824090244.16520-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180824090244.16520-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpTaWduZWQtb2Zm
LWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBzcmMvcmFk
ZW9uX2V4YS5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvcmFkZW9uX2V4YS5jIGIvc3JjL3JhZGVvbl9leGEu
YwppbmRleCA5M2MyZjA1NmMuLjI2ODE1NWVkNyAxMDA2NDQKLS0tIGEvc3JjL3JhZGVvbl9leGEu
YworKysgYi9zcmMvcmFkZW9uX2V4YS5jCkBAIC0yOTYsMTEgKzI5NiwxMiBAQCBCb29sIFJBREVP
TkVYQVNoYXJlUGl4bWFwQmFja2luZyhQaXhtYXBQdHIgcHBpeCwgU2NyZWVuUHRyIHNsYXZlLCB2
b2lkICoqZmRfaGFuZAogQm9vbCBSQURFT05FWEFTZXRTaGFyZWRQaXhtYXBCYWNraW5nKFBpeG1h
cFB0ciBwcGl4LCB2b2lkICpmZF9oYW5kbGUpCiB7CiAgICAgc3RydWN0IHJhZGVvbl9leGFfcGl4
bWFwX3ByaXYgKmRyaXZlcl9wcml2ID0gZXhhR2V0UGl4bWFwRHJpdmVyUHJpdmF0ZShwcGl4KTsK
KyAgICBpbnQgaWhhbmRsZSA9IChpbnQpKGxvbmcpZmRfaGFuZGxlOwogCiAgICAgaWYgKCFyYWRl
b25fc2V0X3NoYXJlZF9waXhtYXBfYmFja2luZyhwcGl4LCBmZF9oYW5kbGUsICZkcml2ZXJfcHJp
di0+c3VyZmFjZSkpCiAJcmV0dXJuIEZBTFNFOwogCi0gICAgZHJpdmVyX3ByaXYtPnNoYXJlZCA9
IFRSVUU7CisgICAgZHJpdmVyX3ByaXYtPnNoYXJlZCA9IGloYW5kbGUgIT0gLTE7CiAgICAgcmV0
dXJuIFRSVUU7CiB9CiAKLS0gCjIuMTguMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
