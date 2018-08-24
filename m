From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 2/4] Handle ihandle == -1 in
 radeon_set_shared_pixmap_backing
Date: Fri, 24 Aug 2018 11:02:42 +0200
Message-ID: <20180824090244.16520-2-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpJdCBtZWFucyB0
byBzdG9wIHVzaW5nIHRoZSBzaGFyZWQgcGl4bWFwIGJhY2tpbmcuCgpGaXhlcyBjcmFzaCB3aGVu
IGNoYW5naW5nIFBSSU1FIHNsYXZlIG91dHB1dCBjb25maWd1cmF0aW9uLgoKU2lnbmVkLW9mZi1i
eTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Ci0tLQogc3JjL3JhZGVv
bl9ib19oZWxwZXIuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvc3JjL3JhZGVvbl9ib19oZWxwZXIuYyBiL3NyYy9yYWRlb25fYm9faGVscGVy
LmMKaW5kZXggNzllOGZmMWJkLi4xYTZkNTRiMTEgMTAwNjQ0Ci0tLSBhL3NyYy9yYWRlb25fYm9f
aGVscGVyLmMKKysrIGIvc3JjL3JhZGVvbl9ib19oZWxwZXIuYwpAQCAtNDU0LDYgKzQ1NCw5IEBA
IEJvb2wgcmFkZW9uX3NldF9zaGFyZWRfcGl4bWFwX2JhY2tpbmcoUGl4bWFwUHRyIHBwaXgsIHZv
aWQgKmZkX2hhbmRsZSwKICAgICB1aW50MzJfdCBzaXplID0gcHBpeC0+ZGV2S2luZCAqIHBwaXgt
PmRyYXdhYmxlLmhlaWdodDsKICAgICBCb29sIHJldCA9IEZBTFNFOwogCisgICAgaWYgKGloYW5k
bGUgPT0gLTEpCisJcmV0dXJuIHJhZGVvbl9zZXRfcGl4bWFwX2JvKHBwaXgsIE5VTEwpOworCQog
ICAgIGJvID0gKHN0cnVjdCByYWRlb25fYnVmZmVyICopY2FsbG9jKDEsIHNpemVvZihzdHJ1Y3Qg
cmFkZW9uX2J1ZmZlcikpOwogICAgIGlmICghYm8pCiAJZ290byBlcnJvcjsKLS0gCjIuMTguMAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
