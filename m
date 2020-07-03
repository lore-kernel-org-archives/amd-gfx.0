Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB38C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 07:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2362073E
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 07:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2362073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4ED96E31C;
	Mon,  6 Jul 2020 07:47:12 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F24006E29D
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 14:29:42 +0000 (UTC)
Received: from hopp.molgen.mpg.de (hopp.molgen.mpg.de [141.14.25.186])
 by mx.molgen.mpg.de (Postfix) with ESMTP id ABAB0206442E7;
 Fri,  3 Jul 2020 16:29:41 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3 2/3] moduleparams: Add hexint type parameter
Date: Fri,  3 Jul 2020 16:29:38 +0200
Message-Id: <20200703142939.28663-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703142939.28663-1-pmenzel@molgen.mpg.de>
References: <20200703142939.28663-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 06 Jul 2020 07:47:09 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rm9yIGJpdG1hc2tzIHByaW50aW5nIHZhbHVlcyBpbiBoZXggaXMgbW9yZSBjb252ZW5pZW50LgoK
UHJlZml4IHdpdGggYDB4YCB0byBtYWtlIGl0IGNsZWFyLCB0aGF0IGl04oCZcyBhIGhleCB2YWx1
ZSwgYW5kIHBhZCBpdApvdXQuCgpVc2luZyB0aGUgaGVscGVyIGZvciBgYW1kZ3B1LnBwZmVhdHVy
ZW1hc2tgLCBpdCB3aWxsIGxvb2sgbGlrZSBiZWxvdy4KCkJlZm9yZToKCiAgICAkIG1vcmUgL3N5
cy9tb2R1bGUvYW1kZ3B1L3BhcmFtZXRlcnMvcHBmZWF0dXJlbWFzawogICAgNDI5NDk1MDkxMQoK
QWZ0ZXI6CgogICAgJCBtb3JlIC9zeXMvbW9kdWxlL2FtZGdwdS9wYXJhbWV0ZXJzL3BwZmVhdHVy
ZW1hc2sKICAgIDB4ZmZmZmJmZmYKCkNjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCkNj
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBQYXVsIE1lbnpl
bCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPgotLS0KIGluY2x1ZGUvbGludXgvbW9kdWxlcGFyYW0u
aCB8ICA3ICsrKysrKy0KIGtlcm5lbC9wYXJhbXMuYyAgICAgICAgICAgICB8IDE3ICsrKysrKysr
Ky0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tb2R1bGVwYXJhbS5oIGIvaW5jbHVkZS9s
aW51eC9tb2R1bGVwYXJhbS5oCmluZGV4IDNlZjkxN2ZmMDk2NC4uY2ZmNzI2MWU5OGJiIDEwMDY0
NAotLS0gYS9pbmNsdWRlL2xpbnV4L21vZHVsZXBhcmFtLmgKKysrIGIvaW5jbHVkZS9saW51eC9t
b2R1bGVwYXJhbS5oCkBAIC0xMTgsNyArMTE4LDcgQEAgc3RydWN0IGtwYXJhbV9hcnJheQogICog
eW91IGNhbiBjcmVhdGUgeW91ciBvd24gYnkgZGVmaW5pbmcgdGhvc2UgdmFyaWFibGVzLgogICoK
ICAqIFN0YW5kYXJkIHR5cGVzIGFyZToKLSAqCWJ5dGUsIHNob3J0LCB1c2hvcnQsIGludCwgdWlu
dCwgbG9uZywgdWxvbmcKKyAqCWJ5dGUsIGhleGludCwgc2hvcnQsIHVzaG9ydCwgaW50LCB1aW50
LCBsb25nLCB1bG9uZwogICoJY2hhcnA6IGEgY2hhcmFjdGVyIHBvaW50ZXIKICAqCWJvb2w6IGEg
Ym9vbCwgdmFsdWVzIDAvMSwgeS9uLCBZL04uCiAgKglpbnZib29sOiB0aGUgYWJvdmUsIG9ubHkg
c2Vuc2UtcmV2ZXJzZWQgKE4gPSB0cnVlKS4KQEAgLTQ0OCw2ICs0NDgsMTEgQEAgZXh0ZXJuIGlu
dCBwYXJhbV9zZXRfdWxsb25nKGNvbnN0IGNoYXIgKnZhbCwgY29uc3Qgc3RydWN0IGtlcm5lbF9w
YXJhbSAqa3ApOwogZXh0ZXJuIGludCBwYXJhbV9nZXRfdWxsb25nKGNoYXIgKmJ1ZmZlciwgY29u
c3Qgc3RydWN0IGtlcm5lbF9wYXJhbSAqa3ApOwogI2RlZmluZSBwYXJhbV9jaGVja191bGxvbmco
bmFtZSwgcCkgX19wYXJhbV9jaGVjayhuYW1lLCBwLCB1bnNpZ25lZCBsb25nIGxvbmcpCiAKK2V4
dGVybiBjb25zdCBzdHJ1Y3Qga2VybmVsX3BhcmFtX29wcyBwYXJhbV9vcHNfaGV4aW50OworZXh0
ZXJuIGludCBwYXJhbV9zZXRfaGV4aW50KGNvbnN0IGNoYXIgKnZhbCwgY29uc3Qgc3RydWN0IGtl
cm5lbF9wYXJhbSAqa3ApOworZXh0ZXJuIGludCBwYXJhbV9nZXRfaGV4aW50KGNoYXIgKmJ1ZmZl
ciwgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJhbSAqa3ApOworI2RlZmluZSBwYXJhbV9jaGVja19o
ZXhpbnQobmFtZSwgcCkgcGFyYW1fY2hlY2tfdWludChuYW1lLCBwKQorCiBleHRlcm4gY29uc3Qg
c3RydWN0IGtlcm5lbF9wYXJhbV9vcHMgcGFyYW1fb3BzX2NoYXJwOwogZXh0ZXJuIGludCBwYXJh
bV9zZXRfY2hhcnAoY29uc3QgY2hhciAqdmFsLCBjb25zdCBzdHJ1Y3Qga2VybmVsX3BhcmFtICpr
cCk7CiBleHRlcm4gaW50IHBhcmFtX2dldF9jaGFycChjaGFyICpidWZmZXIsIGNvbnN0IHN0cnVj
dCBrZXJuZWxfcGFyYW0gKmtwKTsKZGlmZiAtLWdpdCBhL2tlcm5lbC9wYXJhbXMuYyBiL2tlcm5l
bC9wYXJhbXMuYwppbmRleCAxMTFlZWU4MmI5OTkuLjM4MzVmYjgyYzY0YiAxMDA2NDQKLS0tIGEv
a2VybmVsL3BhcmFtcy5jCisrKyBiL2tlcm5lbC9wYXJhbXMuYwpAQCAtMjMzLDE0ICsyMzMsMTUg
QEAgY2hhciAqcGFyc2VfYXJncyhjb25zdCBjaGFyICpkb2luZywKIAlFWFBPUlRfU1lNQk9MKHBh
cmFtX29wc18jI25hbWUpCiAKIAotU1RBTkRBUkRfUEFSQU1fREVGKGJ5dGUsCXVuc2lnbmVkIGNo
YXIsCQkiJWhodSIsCWtzdHJ0b3U4KTsKLVNUQU5EQVJEX1BBUkFNX0RFRihzaG9ydCwJc2hvcnQs
CQkJIiVoaSIsCWtzdHJ0b3MxNik7Ci1TVEFOREFSRF9QQVJBTV9ERUYodXNob3J0LAl1bnNpZ25l
ZCBzaG9ydCwJCSIlaHUiLAlrc3RydG91MTYpOwotU1RBTkRBUkRfUEFSQU1fREVGKGludCwJCWlu
dCwJCQkiJWkiLAlrc3RydG9pbnQpOwotU1RBTkRBUkRfUEFSQU1fREVGKHVpbnQsCXVuc2lnbmVk
IGludCwJCSIldSIsCWtzdHJ0b3VpbnQpOwotU1RBTkRBUkRfUEFSQU1fREVGKGxvbmcsCWxvbmcs
CQkJIiVsaSIsCWtzdHJ0b2wpOwotU1RBTkRBUkRfUEFSQU1fREVGKHVsb25nLAl1bnNpZ25lZCBs
b25nLAkJIiVsdSIsCWtzdHJ0b3VsKTsKLVNUQU5EQVJEX1BBUkFNX0RFRih1bGxvbmcsCXVuc2ln
bmVkIGxvbmcgbG9uZywJIiVsbHUiLAlrc3RydG91bGwpOworU1RBTkRBUkRfUEFSQU1fREVGKGJ5
dGUsCXVuc2lnbmVkIGNoYXIsCQkiJWhodSIsCQlrc3RydG91OCk7CitTVEFOREFSRF9QQVJBTV9E
RUYoc2hvcnQsCXNob3J0LAkJCSIlaGkiLAkJa3N0cnRvczE2KTsKK1NUQU5EQVJEX1BBUkFNX0RF
Rih1c2hvcnQsCXVuc2lnbmVkIHNob3J0LAkJIiVodSIsCQlrc3RydG91MTYpOworU1RBTkRBUkRf
UEFSQU1fREVGKGludCwJCWludCwJCQkiJWkiLAkJa3N0cnRvaW50KTsKK1NUQU5EQVJEX1BBUkFN
X0RFRih1aW50LAl1bnNpZ25lZCBpbnQsCQkiJXUiLAkJa3N0cnRvdWludCk7CitTVEFOREFSRF9Q
QVJBTV9ERUYobG9uZywJbG9uZywJCQkiJWxpIiwJCWtzdHJ0b2wpOworU1RBTkRBUkRfUEFSQU1f
REVGKHVsb25nLAl1bnNpZ25lZCBsb25nLAkJIiVsdSIsCQlrc3RydG91bCk7CitTVEFOREFSRF9Q
QVJBTV9ERUYodWxsb25nLAl1bnNpZ25lZCBsb25nIGxvbmcsCSIlbGx1IiwJCWtzdHJ0b3VsbCk7
CitTVEFOREFSRF9QQVJBTV9ERUYoaGV4aW50LAl1bnNpZ25lZCBpbnQsCQkiJSMwOHgiLCAJa3N0
cnRvdWludCk7CiAKIGludCBwYXJhbV9zZXRfY2hhcnAoY29uc3QgY2hhciAqdmFsLCBjb25zdCBz
dHJ1Y3Qga2VybmVsX3BhcmFtICprcCkKIHsKLS0gCjIuMjYuMgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
