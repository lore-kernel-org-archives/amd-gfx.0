Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95863C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 12:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C216206E3
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 12:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C216206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA1F08930A;
	Wed, 22 Jul 2020 12:38:15 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 79CDD892F0;
 Wed, 22 Jul 2020 12:38:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 461DC2A6042;
 Wed, 22 Jul 2020 14:38:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id rv523GJNm0Vp; Wed, 22 Jul 2020 14:38:14 +0200 (CEST)
Received: from kaveri (212.174.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.174.212])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 115042A6016;
 Wed, 22 Jul 2020 14:38:13 +0200 (CEST)
Received: from daenzer by kaveri with local (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1jyE0j-0031aS-A2; Wed, 22 Jul 2020 14:38:13 +0200
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Leo Li <sunpeng.li@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH] drm/amdgpu/dc: Simplify drm_crtc_state::active checks
Date: Wed, 22 Jul 2020 14:38:13 +0200
Message-Id: <20200722123813.721041-1-michel@daenzer.net>
X-Mailer: git-send-email 2.28.0.rc0
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTWljaGVsIETDpG56ZXIgPG1kYWVuemVyQHJlZGhhdC5jb20+Cgpkcm1fYXRvbWljX2Ny
dGNfY2hlY2sgZW5mb3JjZXMgdGhhdCA6OmFjdGl2ZSBjYW4gb25seSBiZSB0cnVlIGlmCjo6ZW5h
YmxlIGlzIGFzIHdlbGwuCgpTaWduZWQtb2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWRhZW56ZXJA
cmVkaGF0LmNvbT4KLS0tCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMgICAgfCAxNiArKystLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAxMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwppbmRleCAzMTJjNTQzYjI1OGYuLmRhYmVmMzA3YTc0
ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRn
cHVfZG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbS5jCkBAIC0zNDE1LDIxICszNDE1LDEyIEBAIHN0YXRpYyBib29sIG1vZGVzZXRfcmVxdWly
ZWQoc3RydWN0IGRybV9jcnRjX3N0YXRlICpjcnRjX3N0YXRlLAogCQkJICAgICBzdHJ1Y3QgZGNf
c3RyZWFtX3N0YXRlICpuZXdfc3RyZWFtLAogCQkJICAgICBzdHJ1Y3QgZGNfc3RyZWFtX3N0YXRl
ICpvbGRfc3RyZWFtKQogewotCWlmICghZHJtX2F0b21pY19jcnRjX25lZWRzX21vZGVzZXQoY3J0
Y19zdGF0ZSkpCi0JCXJldHVybiBmYWxzZTsKLQotCWlmICghY3J0Y19zdGF0ZS0+ZW5hYmxlKQot
CQlyZXR1cm4gZmFsc2U7Ci0KLQlyZXR1cm4gY3J0Y19zdGF0ZS0+YWN0aXZlOworCXJldHVybiBj
cnRjX3N0YXRlLT5hY3RpdmUgJiYgZHJtX2F0b21pY19jcnRjX25lZWRzX21vZGVzZXQoY3J0Y19z
dGF0ZSk7CiB9CiAKIHN0YXRpYyBib29sIG1vZGVyZXNldF9yZXF1aXJlZChzdHJ1Y3QgZHJtX2Ny
dGNfc3RhdGUgKmNydGNfc3RhdGUpCiB7Ci0JaWYgKCFkcm1fYXRvbWljX2NydGNfbmVlZHNfbW9k
ZXNldChjcnRjX3N0YXRlKSkKLQkJcmV0dXJuIGZhbHNlOwotCi0JcmV0dXJuICFjcnRjX3N0YXRl
LT5lbmFibGUgfHwgIWNydGNfc3RhdGUtPmFjdGl2ZTsKKwlyZXR1cm4gIWNydGNfc3RhdGUtPmFj
dGl2ZSAmJiBkcm1fYXRvbWljX2NydGNfbmVlZHNfbW9kZXNldChjcnRjX3N0YXRlKTsKIH0KIAog
c3RhdGljIHZvaWQgYW1kZ3B1X2RtX2VuY29kZXJfZGVzdHJveShzdHJ1Y3QgZHJtX2VuY29kZXIg
KmVuY29kZXIpCkBAIC04MTA4LDggKzgwOTksNyBAQCBzdGF0aWMgaW50IGRtX3VwZGF0ZV9jcnRj
X3N0YXRlKHN0cnVjdCBhbWRncHVfZGlzcGxheV9tYW5hZ2VyICpkbSwKIAkgKiBXZSB3YW50IHRv
IGRvIGRjIHN0cmVhbSB1cGRhdGVzIHRoYXQgZG8gbm90IHJlcXVpcmUgYQogCSAqIGZ1bGwgbW9k
ZXNldCBiZWxvdy4KIAkgKi8KLQlpZiAoIShlbmFibGUgJiYgYWNvbm5lY3RvciAmJiBuZXdfY3J0
Y19zdGF0ZS0+ZW5hYmxlICYmCi0JICAgICAgbmV3X2NydGNfc3RhdGUtPmFjdGl2ZSkpCisJaWYg
KCEoZW5hYmxlICYmIGFjb25uZWN0b3IgJiYgbmV3X2NydGNfc3RhdGUtPmFjdGl2ZSkpCiAJCXJl
dHVybiAwOwogCS8qCiAJICogR2l2ZW4gYWJvdmUgY29uZGl0aW9ucywgdGhlIGRjIHN0YXRlIGNh
bm5vdCBiZSBOVUxMIGJlY2F1c2U6Ci0tIAoyLjI4LjAucmMwCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
