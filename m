From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 10/10] Always allow DRI2 page flipping with
 TearFree
Date: Wed, 16 Aug 2017 16:57:25 +0900
Message-ID: <20170816075725.9566-11-michel@daenzer.net>
References: <20170816075725.9566-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170816075725.9566-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpFdmVuIGlmIFRl
YXJGcmVlIGlzIGVuYWJsZWQgZm9yIHRoZSBDUlRDIHdlJ3JlIHN5bmNocm9uaXppbmcgdG8uCgpT
aWduZWQtb2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0t
CiBzcmMvcmFkZW9uX2RyaTIuYyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3NyYy9yYWRlb25fZHJpMi5jIGIvc3JjL3JhZGVvbl9kcmkyLmMKaW5k
ZXggYTBkZWI2YmFlLi43M2FkYmU5MTAgMTAwNjQ0Ci0tLSBhL3NyYy9yYWRlb25fZHJpMi5jCisr
KyBiL3NyYy9yYWRlb25fZHJpMi5jCkBAIC03NjAsOCArNzYwLDYgQEAgY2FuX2ZsaXAoeGY4NkNy
dGNQdHIgY3J0YywgRHJhd2FibGVQdHIgZHJhdywKICAgICBmb3IgKGkgPSAwLCBudW1fY3J0Y3Nf
b24gPSAwOyBpIDwgY29uZmlnLT5udW1fY3J0YzsgaSsrKSB7CiAJaWYgKGRybW1vZGVfY3J0Y19j
YW5fZmxpcChjb25maWctPmNydGNbaV0pKQogCSAgICBudW1fY3J0Y3Nfb24rKzsKLQllbHNlIGlm
IChjb25maWctPmNydGNbaV0gPT0gY3J0YykKLQkgICAgcmV0dXJuIEZBTFNFOwogICAgIH0KIAog
ICAgIHJldHVybiBudW1fY3J0Y3Nfb24gPiAwICYmIGNhbl9leGNoYW5nZShwU2NybiwgZHJhdywg
ZnJvbnQsIGJhY2spOwotLSAKMi4xNC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
