From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 09/15] dri2: Don't allow flipping when using a
 dedicated scanout buffer
Date: Wed, 21 Sep 2016 18:50:48 +0900
Message-ID: <20160921095054.28302-9-michel@daenzer.net>
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
ZXJ2ZXIKR2l0IG1hc3Rlci4KCihQb3J0ZWQgZnJvbSBhbWRncHUgY29tbWl0IGRlY2FiZDU3NGY5
MGQzZGYzOTdjODBlYzkzMWIzZmRlOGE0YWZiNDkpCgpTaWduZWQtb2ZmLWJ5OiBNaWNoZWwgRMOk
bnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBzcmMvcmFkZW9uX2RyaTIuYyB8IDUg
KysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9zcmMvcmFkZW9uX2RyaTIuYyBiL3NyYy9yYWRlb25fZHJpMi5jCmluZGV4IDY5
ZmQwZWEuLjEyMDZiMmEgMTAwNjQ0Ci0tLSBhL3NyYy9yYWRlb25fZHJpMi5jCisrKyBiL3NyYy9y
YWRlb25fZHJpMi5jCkBAIC03MjMsNyArNzIzLDEwIEBAIGNhbl9leGNoYW5nZShTY3JuSW5mb1B0
ciBwU2NybiwgRHJhd2FibGVQdHIgZHJhdywKIAogICAgIGZvciAoaSA9IDA7IGkgPCB4Zjg2X2Nv
bmZpZy0+bnVtX2NydGM7IGkrKykgewogCXhmODZDcnRjUHRyIGNydGMgPSB4Zjg2X2NvbmZpZy0+
Y3J0Y1tpXTsKLQlpZiAoY3J0Yy0+ZW5hYmxlZCAmJiBjcnRjLT5yb3RhdGVkRGF0YSkKKwlkcm1t
b2RlX2NydGNfcHJpdmF0ZV9wdHIgZHJtbW9kZV9jcnRjID0gY3J0Yy0+ZHJpdmVyX3ByaXZhdGU7
CisKKwlpZiAoY3J0Yy0+ZW5hYmxlZCAmJgorCSAgICAoY3J0Yy0+cm90YXRlZERhdGEgfHwgZHJt
bW9kZV9jcnRjLT5zY2Fub3V0WzBdLmJvKSkKIAkgICAgcmV0dXJuIEZBTFNFOwogICAgIH0KIAot
LSAKMi45LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
