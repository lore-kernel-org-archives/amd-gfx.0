From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 1/3] dri2: reply to client for WaitMSC request
 in any case
Date: Fri, 14 Jun 2019 11:27:43 +0200
Message-ID: <20190614092745.4488-1-michel@daenzer.net>
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

RnJvbTogRmxvcmEgQ3VpIDxmbG9yYS5jdWlAYW1kLmNvbT4KCm90aGVyd2lzZSBjbGllbnQgd291
bGQgd2FpdCBmb3IgcmVwbHkgZm9yZXZlciBhbmQgZGVza3RvcCBhcHBlYXJzIGhhbmcuCgpTaWdu
ZWQtb2ZmLWJ5OiBGbG9yYSBDdWkgPGZsb3JhLmN1aUBhbWQuY29tPgooUG9ydGVkIGZyb20gYW1k
Z3B1IGNvbW1pdCBmYjA2ZmI4MTQ3MDBhNDc0NjRhYmQ3NTZlMTExMWRjYzc2ZDBkNzc2KQpTaWdu
ZWQtb2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBz
cmMvcmFkZW9uX2RyaTIuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvc3JjL3JhZGVvbl9kcmkyLmMgYi9zcmMvcmFkZW9uX2RyaTIuYwppbmRl
eCBhOWYxNGU4ZDguLjNjMDRlNmZlOSAxMDA2NDQKLS0tIGEvc3JjL3JhZGVvbl9kcmkyLmMKKysr
IGIvc3JjL3JhZGVvbl9kcmkyLmMKQEAgLTExNTYsNiArMTE1Niw5IEBAIHN0YXRpYyBpbnQgcmFk
ZW9uX2RyaTJfc2NoZWR1bGVfd2FpdF9tc2MoQ2xpZW50UHRyIGNsaWVudCwgRHJhd2FibGVQdHIg
ZHJhdywKIG91dF9jb21wbGV0ZToKICAgICBpZiAod2FpdF9pbmZvKQogCXJhZGVvbl9kcmkyX2Rl
ZmVycmVkX2V2ZW50KE5VTEwsIDAsIHdhaXRfaW5mbyk7CisgICAgZWxzZQorCURSSTJXYWl0TVND
Q29tcGxldGUoY2xpZW50LCBkcmF3LCAwLCAwLCAwKTsKKwogICAgIHJldHVybiBUUlVFOwogfQog
Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
