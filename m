From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 2/2] glamor: Bail CreatePixmap on unsupported
 pixmap depth
Date: Fri, 18 May 2018 16:21:40 +0200
Message-ID: <20180518142140.20582-2-michel@daenzer.net>
References: <20180518142140.20582-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180518142140.20582-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpGaXhlcyBjcmFz
aCBpbiB0aGF0IGNhc2UuCgpCdWd6aWxsYTogaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy8x
MDYyOTMKU2lnbmVkLW9mZi1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5j
b20+Ci0tLQogc3JjL3JhZGVvbl9nbGFtb3IuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvc3JjL3JhZGVvbl9nbGFtb3IuYyBiL3NyYy9yYWRl
b25fZ2xhbW9yLmMKaW5kZXggN2MwOWFiYmE1Li4xMGQ1MTNlYTkgMTAwNjQ0Ci0tLSBhL3NyYy9y
YWRlb25fZ2xhbW9yLmMKKysrIGIvc3JjL3JhZGVvbl9nbGFtb3IuYwpAQCAtMjE0LDYgKzIxNCw5
IEBAIHJhZGVvbl9nbGFtb3JfY3JlYXRlX3BpeG1hcChTY3JlZW5QdHIgc2NyZWVuLCBpbnQgdywg
aW50IGgsIGludCBkZXB0aCwKIAlzdHJ1Y3QgcmFkZW9uX3BpeG1hcCAqcHJpdjsKIAlQaXhtYXBQ
dHIgcGl4bWFwLCBuZXdfcGl4bWFwID0gTlVMTDsKIAorCWlmICgheGY4NkdldFBpeEZvcm1hdChz
Y3JuLCBkZXB0aCkpCisJCXJldHVybiBOVUxMOworCiAJaWYgKCFSQURFT05fQ1JFQVRFX1BJWE1B
UF9TSEFSRUQodXNhZ2UpKSB7CiAJCWlmIChpbmZvLT5zaGFkb3dfcHJpbWFyeSkgewogCQkJaWYg
KHVzYWdlICE9IENSRUFURV9QSVhNQVBfVVNBR0VfQkFDS0lOR19QSVhNQVApCi0tIAoyLjE3LjAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
