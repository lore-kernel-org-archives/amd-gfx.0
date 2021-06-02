Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB0FC4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 09:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9AC46101C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 09:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AC46101C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 819C46EA6A;
	Wed,  2 Jun 2021 09:53:08 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 348536EA6A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 09:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 72CE720201C;
 Wed,  2 Jun 2021 11:53:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id Cy9X5tyyQ7ln; Wed,  2 Jun 2021 11:53:06 +0200 (CEST)
Received: from kaveri (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 341F220201A;
 Wed,  2 Jun 2021 11:53:06 +0200 (CEST)
Received: from daenzer by kaveri with local (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1loNYf-000AvB-BA; Wed, 02 Jun 2021 11:53:05 +0200
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Use drm_dbg_kms for reporting failure to get a
 GEM FB
Date: Wed,  2 Jun 2021 11:53:05 +0200
Message-Id: <20210602095305.41936-1-michel@daenzer.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
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
Cc: Mark Yacoub <markyacoub@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTWljaGVsIETDpG56ZXIgPG1kYWVuemVyQHJlZGhhdC5jb20+Cgpkcm1fZXJyIG1lYW50
IGJyb2tlbiB1c2VyIHNwYWNlIGNvdWxkIHNwYW0gZG1lc2cuCgpGaXhlczogZjI1ODkwN2ZkZDgz
NWUgImRybS9hbWRncHU6IFZlcmlmeSBibyBzaXplIGNhbiBmaXQgZnJhbWVidWZmZXIKICAgICAg
ICAgICAgICAgICAgICAgICBzaXplIG9uIGluaXQuIgpTaWduZWQtb2ZmLWJ5OiBNaWNoZWwgRMOk
bnplciA8bWRhZW56ZXJAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGlzcGxheS5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kaXNwbGF5LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGlzcGxheS5jCmluZGV4IDgxNzBlMjRjZTM3ZC4uMmE0Y2Q3ZDM3N2JmIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMKQEAgLTEwNTgsNyArMTA1OCw3IEBA
IGludCBhbWRncHVfZGlzcGxheV9nZW1fZmJfaW5pdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LAog
CiAJcmV0dXJuIDA7CiBlcnI6Ci0JZHJtX2VycihkZXYsICJGYWlsZWQgdG8gaW5pdCBnZW0gZmI6
ICVkXG4iLCByZXQpOworCWRybV9kYmdfa21zKGRldiwgIkZhaWxlZCB0byBpbml0IGdlbSBmYjog
JWRcbiIsIHJldCk7CiAJcmZiLT5iYXNlLm9ialswXSA9IE5VTEw7CiAJcmV0dXJuIHJldDsKIH0K
QEAgLTEwOTYsNyArMTA5Niw3IEBAIGludCBhbWRncHVfZGlzcGxheV9nZW1fZmJfdmVyaWZ5X2Fu
ZF9pbml0KAogCiAJcmV0dXJuIDA7CiBlcnI6Ci0JZHJtX2VycihkZXYsICJGYWlsZWQgdG8gdmVy
aWZ5IGFuZCBpbml0IGdlbSBmYjogJWRcbiIsIHJldCk7CisJZHJtX2RiZ19rbXMoZGV2LCAiRmFp
bGVkIHRvIHZlcmlmeSBhbmQgaW5pdCBnZW0gZmI6ICVkXG4iLCByZXQpOwogCXJmYi0+YmFzZS5v
YmpbMF0gPSBOVUxMOwogCXJldHVybiByZXQ7CiB9Ci0tIAoyLjMxLjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
