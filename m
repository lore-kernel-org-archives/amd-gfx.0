Return-Path: <SRS0=uuOW=AN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4182EC433E1
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 15:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA0720771
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 15:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA0720771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55BE46E084;
	Thu,  2 Jul 2020 15:54:19 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E856E037
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2020 14:01:14 +0000 (UTC)
Received: from hopp.molgen.mpg.de (hopp.molgen.mpg.de [141.14.25.186])
 by mx.molgen.mpg.de (Postfix) with ESMTP id A3423206442DE;
 Thu,  2 Jul 2020 16:01:11 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 1/2] moduleparams: Add hex type parameter
Date: Thu,  2 Jul 2020 16:01:01 +0200
Message-Id: <20200702140102.26129-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 02 Jul 2020 15:54:18 +0000
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
UHJlZml4IHdpdGggMHggKCMpIHRvIG1ha2UgaXQgY2xlYXIsIHRoYXQgaXTigJlzIGEgaGV4IHZh
bHVlLgoKVXNpbmcgdGhlIGhlbHBlciBmb3IgYGFtZGdwdS5wcGZlYXR1cmVtYXNrYCwgaXQgd2ls
bCBsb29rIGxpa2UgYmVsb3cuCgpCZWZvcmU6CgogICAgJCBtb3JlIC9zeXMvbW9kdWxlL2FtZGdw
dS9wYXJhbWV0ZXJzL3BwZmVhdHVyZW1hc2sKICAgIDQyOTQ5NTA5MTEKCkFmdGVyOgoKICAgICQg
bW9yZSAvc3lzL21vZHVsZS9hbWRncHUvcGFyYW1ldGVycy9wcGZlYXR1cmVtYXNrCiAgICAweGZm
ZmZiZmZmCgpDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwpDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9s
Z2VuLm1wZy5kZT4KLS0tCiBpbmNsdWRlL2xpbnV4L21vZHVsZXBhcmFtLmggfCA3ICsrKysrKy0K
IGtlcm5lbC9wYXJhbXMuYyAgICAgICAgICAgICB8IDEgKwogMiBmaWxlcyBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21v
ZHVsZXBhcmFtLmggYi9pbmNsdWRlL2xpbnV4L21vZHVsZXBhcmFtLmgKaW5kZXggM2VmOTE3ZmYw
OTY0Li40MDg5NzhmY2ZlMjcgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbW9kdWxlcGFyYW0u
aAorKysgYi9pbmNsdWRlL2xpbnV4L21vZHVsZXBhcmFtLmgKQEAgLTExOCw3ICsxMTgsNyBAQCBz
dHJ1Y3Qga3BhcmFtX2FycmF5CiAgKiB5b3UgY2FuIGNyZWF0ZSB5b3VyIG93biBieSBkZWZpbmlu
ZyB0aG9zZSB2YXJpYWJsZXMuCiAgKgogICogU3RhbmRhcmQgdHlwZXMgYXJlOgotICoJYnl0ZSwg
c2hvcnQsIHVzaG9ydCwgaW50LCB1aW50LCBsb25nLCB1bG9uZworICoJYnl0ZSwgaGV4LCBzaG9y
dCwgdXNob3J0LCBpbnQsIHVpbnQsIGxvbmcsIHVsb25nCiAgKgljaGFycDogYSBjaGFyYWN0ZXIg
cG9pbnRlcgogICoJYm9vbDogYSBib29sLCB2YWx1ZXMgMC8xLCB5L24sIFkvTi4KICAqCWludmJv
b2w6IHRoZSBhYm92ZSwgb25seSBzZW5zZS1yZXZlcnNlZCAoTiA9IHRydWUpLgpAQCAtNDQ4LDYg
KzQ0OCwxMSBAQCBleHRlcm4gaW50IHBhcmFtX3NldF91bGxvbmcoY29uc3QgY2hhciAqdmFsLCBj
b25zdCBzdHJ1Y3Qga2VybmVsX3BhcmFtICprcCk7CiBleHRlcm4gaW50IHBhcmFtX2dldF91bGxv
bmcoY2hhciAqYnVmZmVyLCBjb25zdCBzdHJ1Y3Qga2VybmVsX3BhcmFtICprcCk7CiAjZGVmaW5l
IHBhcmFtX2NoZWNrX3VsbG9uZyhuYW1lLCBwKSBfX3BhcmFtX2NoZWNrKG5hbWUsIHAsIHVuc2ln
bmVkIGxvbmcgbG9uZykKIAorZXh0ZXJuIGNvbnN0IHN0cnVjdCBrZXJuZWxfcGFyYW1fb3BzIHBh
cmFtX29wc19oZXg7CitleHRlcm4gaW50IHBhcmFtX3NldF9oZXgoY29uc3QgY2hhciAqdmFsLCBj
b25zdCBzdHJ1Y3Qga2VybmVsX3BhcmFtICprcCk7CitleHRlcm4gaW50IHBhcmFtX2dldF9oZXgo
Y2hhciAqYnVmZmVyLCBjb25zdCBzdHJ1Y3Qga2VybmVsX3BhcmFtICprcCk7CisjZGVmaW5lIHBh
cmFtX2NoZWNrX2hleChuYW1lLCBwKSBwYXJhbV9jaGVja191aW50KG5hbWUsIHApCisKIGV4dGVy
biBjb25zdCBzdHJ1Y3Qga2VybmVsX3BhcmFtX29wcyBwYXJhbV9vcHNfY2hhcnA7CiBleHRlcm4g
aW50IHBhcmFtX3NldF9jaGFycChjb25zdCBjaGFyICp2YWwsIGNvbnN0IHN0cnVjdCBrZXJuZWxf
cGFyYW0gKmtwKTsKIGV4dGVybiBpbnQgcGFyYW1fZ2V0X2NoYXJwKGNoYXIgKmJ1ZmZlciwgY29u
c3Qgc3RydWN0IGtlcm5lbF9wYXJhbSAqa3ApOwpkaWZmIC0tZ2l0IGEva2VybmVsL3BhcmFtcy5j
IGIva2VybmVsL3BhcmFtcy5jCmluZGV4IDhlNTZmOGIxMmQ4Zi4uY2VjYTgzOTRkYWM1IDEwMDY0
NAotLS0gYS9rZXJuZWwvcGFyYW1zLmMKKysrIGIva2VybmVsL3BhcmFtcy5jCkBAIC0yNDEsNiAr
MjQxLDcgQEAgU1RBTkRBUkRfUEFSQU1fREVGKHVpbnQsCXVuc2lnbmVkIGludCwJCSIldSIsICAg
a3N0cnRvdWludCk7CiBTVEFOREFSRF9QQVJBTV9ERUYobG9uZywJbG9uZywJCQkiJWxpIiwgIGtz
dHJ0b2wpOwogU1RBTkRBUkRfUEFSQU1fREVGKHVsb25nLAl1bnNpZ25lZCBsb25nLAkJIiVsdSIs
ICBrc3RydG91bCk7CiBTVEFOREFSRF9QQVJBTV9ERUYodWxsb25nLAl1bnNpZ25lZCBsb25nIGxv
bmcsCSIlbGx1Iiwga3N0cnRvdWxsKTsKK1NUQU5EQVJEX1BBUkFNX0RFRihoZXgsCQl1bnNpZ25l
ZCBpbnQsCQkiJSN4IiwgIGtzdHJ0b3VpbnQpOwogCiBpbnQgcGFyYW1fc2V0X2NoYXJwKGNvbnN0
IGNoYXIgKnZhbCwgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJhbSAqa3ApCiB7Ci0tIAoyLjI2LjIK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
