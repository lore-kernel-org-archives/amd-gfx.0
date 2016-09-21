From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 08/15] present: Don't allow flipping when using
 a dedicated scanout buffer
Date: Wed, 21 Sep 2016 18:50:47 +0900
Message-ID: <20160921095054.28302-8-michel@daenzer.net>
References: <20160921095054.28302-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160921095054.28302-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpGaXhlcyBpc3N1
ZXMgd2hlbiBtaXhpbmcgcm90YXRpb24gYW5kIHBhZ2UgZmxpcHBpbmcgd2l0aCBjdXJyZW50IHhz
ZXJ2ZXIKR2l0IG1hc3Rlci4KCihQb3J0ZWQgZnJvbSBhbWRncHUgY29tbWl0IDNlZDI4Y2U3Y2Qy
NmY4OTk2OTYxN2JhOTAxZmYyNTMwOTFkMGQ0NjkpCgpTaWduZWQtb2ZmLWJ5OiBNaWNoZWwgRMOk
bnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBzcmMvcmFkZW9uX3ByZXNlbnQuYyB8
IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvc3JjL3JhZGVvbl9wcmVzZW50LmMgYi9zcmMvcmFkZW9uX3ByZXNlbnQuYwpp
bmRleCA5M2MxOGE4Li5mZjQwNDVhIDEwMDY0NAotLS0gYS9zcmMvcmFkZW9uX3ByZXNlbnQuYwor
KysgYi9zcmMvcmFkZW9uX3ByZXNlbnQuYwpAQCAtMjY1LDcgKzI2NSw4IEBAIHJhZGVvbl9wcmVz
ZW50X2NoZWNrX2ZsaXAoUlJDcnRjUHRyIGNydGMsIFdpbmRvd1B0ciB3aW5kb3csIFBpeG1hcFB0
ciBwaXhtYXAsCiAJaWYgKCFjb25maWctPmNydGNbaV0tPmVuYWJsZWQpCiAJICAgIGNvbnRpbnVl
OwogCi0JaWYgKCFkcm1tb2RlX2NydGMgfHwgZHJtbW9kZV9jcnRjLT5yb3RhdGUuYm8gIT0gTlVM
TCkKKwlpZiAoIWRybW1vZGVfY3J0YyB8fCBkcm1tb2RlX2NydGMtPnJvdGF0ZS5ibyB8fAorCSAg
ICBkcm1tb2RlX2NydGMtPnNjYW5vdXRbMF0uYm8pCiAJICAgIHJldHVybiBGQUxTRTsKIAogCWlm
IChkcm1tb2RlX2NydGMtPnBlbmRpbmdfZHBtc19tb2RlID09IERQTVNNb2RlT24pCi0tIAoyLjku
MwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
