Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40339C48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 10:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5196115C
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 10:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5196115C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049FD6E563;
	Wed, 16 Jun 2021 10:46:56 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3DE7A6E563
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 10:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 1D02120201B;
 Wed, 16 Jun 2021 12:46:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id Z5qctZ9cY61e; Wed, 16 Jun 2021 12:46:52 +0200 (CEST)
Received: from kaveri (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id CD50B20201A;
 Wed, 16 Jun 2021 12:46:52 +0200 (CEST)
Received: from daenzer by kaveri with local (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1ltT4N-0000nG-Vq; Wed, 16 Jun 2021 12:46:51 +0200
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Call drm_framebuffer_init last for framebuffer
 init
Date: Wed, 16 Jun 2021 12:46:51 +0200
Message-Id: <20210616104651.3004-1-michel@daenzer.net>
X-Mailer: git-send-email 2.32.0
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1kYWVuemVyQHJlZGhhdC5jb20+CgpPbmNlIGRybV9mcmFt
ZWJ1ZmZlcl9pbml0IGhhcyByZXR1cm5lZCAwLCB0aGUgZnJhbWVidWZmZXIgaXMgaG9va2VkIHVw
CnRvIHRoZSByZWZlcmVuY2UgY291bnRpbmcgbWFjaGluZXJ5IGFuZCBjYW4gbm8gbG9uZ2VyIGJl
IGRlc3Ryb3llZCB3aXRoCmEgc2ltcGxlIGtmcmVlLiBUaGVyZWZvcmUsIGl0IG11c3QgYmUgY2Fs
bGVkIGxhc3QuCgpGaXhlczogZjI1ODkwN2ZkZDgzNWUgImRybS9hbWRncHU6IFZlcmlmeSBibyBz
aXplIGNhbiBmaXQgZnJhbWVidWZmZXIgc2l6ZSBvbiBpbml0LiIKU2lnbmVkLW9mZi1ieTogTWlj
aGVsIETDpG56ZXIgPG1kYWVuemVyQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyB8IDEyICsrKysrKystLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYwppbmRleCBjMTM5ODVmYjM1YmUuLjJhNGNkN2QzNzdi
ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXku
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jCkBAIC0x
MDQ3LDExICsxMDQ3LDEyIEBAIGludCBhbWRncHVfZGlzcGxheV9nZW1fZmJfaW5pdChzdHJ1Y3Qg
ZHJtX2RldmljZSAqZGV2LAogCiAJcmZiLT5iYXNlLm9ialswXSA9IG9iajsKIAlkcm1faGVscGVy
X21vZGVfZmlsbF9mYl9zdHJ1Y3QoZGV2LCAmcmZiLT5iYXNlLCBtb2RlX2NtZCk7Ci0JcmV0ID0g
ZHJtX2ZyYW1lYnVmZmVyX2luaXQoZGV2LCAmcmZiLT5iYXNlLCAmYW1kZ3B1X2ZiX2Z1bmNzKTsK
KworCXJldCA9IGFtZGdwdV9kaXNwbGF5X2ZyYW1lYnVmZmVyX2luaXQoZGV2LCByZmIsIG1vZGVf
Y21kLCBvYmopOwogCWlmIChyZXQpCiAJCWdvdG8gZXJyOwogCi0JcmV0ID0gYW1kZ3B1X2Rpc3Bs
YXlfZnJhbWVidWZmZXJfaW5pdChkZXYsIHJmYiwgbW9kZV9jbWQsIG9iaik7CisJcmV0ID0gZHJt
X2ZyYW1lYnVmZmVyX2luaXQoZGV2LCAmcmZiLT5iYXNlLCAmYW1kZ3B1X2ZiX2Z1bmNzKTsKIAlp
ZiAocmV0KQogCQlnb3RvIGVycjsKIApAQCAtMTA3MSw5ICsxMDcyLDYgQEAgaW50IGFtZGdwdV9k
aXNwbGF5X2dlbV9mYl92ZXJpZnlfYW5kX2luaXQoCiAKIAlyZmItPmJhc2Uub2JqWzBdID0gb2Jq
OwogCWRybV9oZWxwZXJfbW9kZV9maWxsX2ZiX3N0cnVjdChkZXYsICZyZmItPmJhc2UsIG1vZGVf
Y21kKTsKLQlyZXQgPSBkcm1fZnJhbWVidWZmZXJfaW5pdChkZXYsICZyZmItPmJhc2UsICZhbWRn
cHVfZmJfZnVuY3MpOwotCWlmIChyZXQpCi0JCWdvdG8gZXJyOwogCS8qIFZlcmlmeSB0aGF0IHRo
ZSBtb2RpZmllciBpcyBzdXBwb3J0ZWQuICovCiAJaWYgKCFkcm1fYW55X3BsYW5lX2hhc19mb3Jt
YXQoZGV2LCBtb2RlX2NtZC0+cGl4ZWxfZm9ybWF0LAogCQkJCSAgICAgIG1vZGVfY21kLT5tb2Rp
ZmllclswXSkpIHsKQEAgLTEwOTIsNiArMTA5MCwxMCBAQCBpbnQgYW1kZ3B1X2Rpc3BsYXlfZ2Vt
X2ZiX3ZlcmlmeV9hbmRfaW5pdCgKIAlpZiAocmV0KQogCQlnb3RvIGVycjsKIAorCXJldCA9IGRy
bV9mcmFtZWJ1ZmZlcl9pbml0KGRldiwgJnJmYi0+YmFzZSwgJmFtZGdwdV9mYl9mdW5jcyk7CisJ
aWYgKHJldCkKKwkJZ290byBlcnI7CisKIAlyZXR1cm4gMDsKIGVycjoKIAlkcm1fZGJnX2ttcyhk
ZXYsICJGYWlsZWQgdG8gdmVyaWZ5IGFuZCBpbml0IGdlbSBmYjogJWRcbiIsIHJldCk7Ci0tIAoy
LjMyLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
