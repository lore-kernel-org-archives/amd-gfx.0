From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 2/2] Simplify depth 30 "kernel too old" error
 message
Date: Thu, 15 Feb 2018 17:50:24 +0100
Message-ID: <20180215165024.9736-2-michel@daenzer.net>
References: <20180215165024.9736-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180215165024.9736-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpXZSBrbm93IGl0
J3MgZGVwdGggMzAsIG5lZWQgdG8gaGF2ZSB4Zjg2RHJ2TXNnIGZpbGwgaXQgaW4uCgpTaWduZWQt
b2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBzcmMv
cmFkZW9uX2ttcy5jIHwgMyArLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvcmFkZW9uX2ttcy5jIGIvc3JjL3JhZGVvbl9r
bXMuYwppbmRleCBiMjY4ZjdlYTcuLjg1MzkwZTMwNiAxMDA2NDQKLS0tIGEvc3JjL3JhZGVvbl9r
bXMuYworKysgYi9zcmMvcmFkZW9uX2ttcy5jCkBAIC0xNzc4LDggKzE3NzgsNyBAQCBCb29sIFJB
REVPTlByZUluaXRfS01TKFNjcm5JbmZvUHRyIHBTY3JuLCBpbnQgZmxhZ3MpCiAgICAgLyogRGVw
dGggMzAgb25seSBzdXBwb3J0ZWQgc2luY2UgTGludXggMy4xNiAvIGttcyBkcml2ZXIgbWlub3Ig
dmVyc2lvbiAzOSAqLwogICAgIGlmIChwU2Nybi0+ZGVwdGggPT0gMzAgJiYgaW5mby0+ZHJpMi5w
S2VybmVsRFJNVmVyc2lvbi0+dmVyc2lvbl9taW5vciA8IDM5KSB7CiAJeGY4NkRydk1zZyhwU2Ny
bi0+c2NybkluZGV4LCBYX0VSUk9SLAotCQkgICAiR2l2ZW4gZGVwdGggKCVkKSBpcyBub3Qgc3Vw
cG9ydGVkLiBLZXJuZWwgdG9vIG9sZC4gTmVlZHMgTGludXggMy4xNitcbiIsCi0JCSAgIHBTY3Ju
LT5kZXB0aCk7CisJCSAgICJEZXB0aCAzMCBpcyBub3Qgc3VwcG9ydGVkLiBLZXJuZWwgdG9vIG9s
ZC4gTmVlZHMgTGludXggMy4xNitcbiIpOwogCXJldHVybiBGQUxTRTsKICAgICB9CiAKLS0gCjIu
MTYuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
