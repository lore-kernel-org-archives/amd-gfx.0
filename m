From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 1/4] Free pRADEONEnt memory in RADEONFreeRec
Date: Fri, 20 Oct 2017 17:28:17 +0200
Message-ID: <20171020152820.14545-1-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpXZSB3ZXJlIGxl
YWtpbmcgaXQuCgooSW5zcGlyZWQgYnkgYW1kZ3B1IGNvbW1pdCA5ZDg0OTM0MzA5ZTRjY2Q5YTQz
YzczZDk1OGI4ZmYxMGVmMmZjOTkwKQoKU2lnbmVkLW9mZi1ieTogTWljaGVsIETDpG56ZXIgPG1p
Y2hlbC5kYWVuemVyQGFtZC5jb20+Ci0tLQogc3JjL3JhZGVvbl9rbXMuYyB8IDMgKystCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
c3JjL3JhZGVvbl9rbXMuYyBiL3NyYy9yYWRlb25fa21zLmMKaW5kZXggOWVmNTE2OTNhLi5kZjQz
ODc2OGMgMTAwNjQ0Ci0tLSBhL3NyYy9yYWRlb25fa21zLmMKKysrIGIvc3JjL3JhZGVvbl9rbXMu
YwpAQCAtMjE4LDcgKzIxOCw4IEBAIHN0YXRpYyB2b2lkIFJBREVPTkZyZWVSZWMoU2NybkluZm9Q
dHIgcFNjcm4pCiAgICAgICAgICAgICAgICAgICAgIHBSQURFT05FbnQtPnBsYXRmb3JtX2Rldi0+
ZmxhZ3MgJiBYRjg2X1BERVZfU0VSVkVSX0ZEKSkKICNlbmRpZgogICAgICAgICAgICAgICAgIGRy
bUNsb3NlKHBSQURFT05FbnQtPmZkKTsKLSAgICAgICAgICAgIHBSQURFT05FbnQtPmZkID0gMDsK
KyAgICAgICAgICAgIGZyZWUocFByaXYtPnB0cik7CisgICAgICAgICAgICBwUHJpdi0+cHRyID0g
TlVMTDsKICAgICAgICAgfQogICAgIH0KIAotLSAKMi4xNC4yCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
