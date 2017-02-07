From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 2/2] Don't destroy current FB if drmModeAddFB
 fails
Date: Tue,  7 Feb 2017 18:47:37 +0900
Message-ID: <20170207094737.13109-2-michel@daenzer.net>
References: <20170207094737.13109-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170207094737.13109-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpJdCB3b3VsZCBw
cm9iYWJseSByZXN1bHQgaW4gYSBibGFjayBzY3JlZW4uCgpTaWduZWQtb2ZmLWJ5OiBNaWNoZWwg
RMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBzcmMvZHJtbW9kZV9kaXNwbGF5
LmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL3NyYy9kcm1tb2RlX2Rpc3BsYXkuYyBiL3NyYy9kcm1tb2RlX2Rpc3Bs
YXkuYwppbmRleCBiNjRiZTQ2MmQuLmMzOWIzMjU1OCAxMDA2NDQKLS0tIGEvc3JjL2RybW1vZGVf
ZGlzcGxheS5jCisrKyBiL3NyYy9kcm1tb2RlX2Rpc3BsYXkuYwpAQCAtMjk0OSw3ICsyOTQ5LDgg
QEAgZmxpcF9lcnJvcjoKIAkJICAgc3RyZXJyb3IoZXJybm8pKTsKIAogZXJyb3I6Ci0JaWYgKGZs
aXBkYXRhICYmIGZsaXBkYXRhLT5mbGlwX2NvdW50IDw9IDEpIHsKKwlpZiAoZmxpcGRhdGEgJiYg
ZmxpcGRhdGEtPmZsaXBfY291bnQgPD0gMSAmJgorCSAgICBkcm1tb2RlLT5mYl9pZCAhPSBmbGlw
ZGF0YS0+b2xkX2ZiX2lkKSB7CiAJCWRybU1vZGVSbUZCKGRybW1vZGUtPmZkLCBkcm1tb2RlLT5m
Yl9pZCk7CiAJCWRybW1vZGUtPmZiX2lkID0gZmxpcGRhdGEtPm9sZF9mYl9pZDsKIAl9Ci0tIAoy
LjExLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
