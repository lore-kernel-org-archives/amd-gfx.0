From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 02/21] Do not export the DriverRec RADEON
Date: Wed, 11 Jul 2018 19:27:47 +0200
Message-ID: <20180711172806.22849-3-michel@daenzer.net>
References: <20180711172806.22849-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180711172806.22849-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogRW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KClVudXNlZCBl
eHRlcm5hbGx5IGFuZCBzaG91bGQgbm90IGJlIGV4cG9ydGVkLgoKU2lnbmVkLW9mZi1ieTogRW1p
bCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KKFBvcnRlZCBmcm9tIGFtZGdw
dSBjb21taXQgN2ZiOGI0OTg5NWUyMjViMzkwOGM4YmQxODY1MzlkZTIzYWZlOTFkMSkKU2lnbmVk
LW9mZi1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Ci0tLQogc3Jj
L3JhZGVvbl9wcm9iZS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3JhZGVvbl9wcm9iZS5jIGIvc3JjL3JhZGVv
bl9wcm9iZS5jCmluZGV4IDE5Mjk1ZjAwYy4uMDRmOWU1NTkwIDEwMDY0NAotLS0gYS9zcmMvcmFk
ZW9uX3Byb2JlLmMKKysrIGIvc3JjL3JhZGVvbl9wcm9iZS5jCkBAIC0yNzgsNyArMjc4LDcgQEAg
cmFkZW9uX3BsYXRmb3JtX3Byb2JlKERyaXZlclB0ciBwRHJpdmVyLAogfQogI2VuZGlmCiAKLV9Y
X0VYUE9SVCBEcml2ZXJSZWMgUkFERU9OID0KK0RyaXZlclJlYyBSQURFT04gPQogewogICAgIFJB
REVPTl9WRVJTSU9OX0NVUlJFTlQsCiAgICAgUkFERU9OX0RSSVZFUl9OQU1FLAotLSAKMi4xOC4w
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
