Return-Path: <SRS0=Rejl=EY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA56C5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 13:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 774E820DD4
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 13:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="st+tVSSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774E820DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCC606E419;
	Wed, 18 Nov 2020 13:20:44 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB8066E419
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 13:20:42 +0000 (UTC)
Received: by mail-ed1-x544.google.com with SMTP id k4so1993275edl.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 05:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+/pezVcEp4QiQieBfSJJXDuzTTqlwN0fgm/fDY+4zOg=;
 b=st+tVSSyBGCdkzl2qIdP9KHecijaj2RLvd3UXOjl/OF4kvtojUr1rb6nhkJUECRHU/
 bZUnB/Byu5kvAXJit1xw4Z1AgHbdkhjVkbxtDIpFkvi0b+LtOEc6htKcw25WfM3ZGTP+
 OQAMUVgRiQaWUe+JbuBJumhtg/GWYdM0ujp6fWnzP162+MajbQQv59Payex9IXzIEr0m
 /9tjwYhNUrXM5BVWNo6k8drlmX4cPtbf2FRQdEqdiH7xM6dEyMRpNBhoklzUJSFBfCDn
 arSOAy7qdjWalSmALC8ye6485+UydzIEUZ61cTSvnJ2HLVMJIn5cgE4Bdue2+MdPfLvQ
 XH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+/pezVcEp4QiQieBfSJJXDuzTTqlwN0fgm/fDY+4zOg=;
 b=ch6r+qofpr39EkKYiQcIywyolmwb8SYZ29js11YKibxg4nOTNHCTWp3p/InJsQAvKl
 57HE/6aZ7q+wPSF80BcyMzOnKItnOdxn3TJFshcmISeIK+3HPt8xzdTqsgnH2MKDOwzJ
 TgR6+fRvhU/+8nfAHNukhtxNuRsoPQozPedgEnfnUEXo5tLZTntXiyx05zLPZ0CA7rFG
 88444bqJ4g40a8roO5g35/RfnR/OpymwnuN5/e/eLlwcT14CbgaMNGo0eync+CFXOgMU
 Lgoon1too5B+KX13la9H0NlO+i/QYYefMN6VV9buV+FSpaVAONei8PpKW7tNqc68KSH2
 tRYw==
X-Gm-Message-State: AOAM533LkOUVa0kh2w9yiIUfimsgx8t+gYwW9lICu0URahvdVLWNPRvh
 S2O8N681eZityvN6ktU12e4=
X-Google-Smtp-Source: ABdhPJy4lme9z/k1x6lrMSX59J42CdzkCRdn3CiyGof4BiUzR20uUyBQMMjyfPPmzDsMx+nsjVRZnQ==
X-Received: by 2002:aa7:c916:: with SMTP id b22mr15259054edt.267.1605705641445; 
 Wed, 18 Nov 2020 05:20:41 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:7fd8:369:71e3:1677])
 by smtp.gmail.com with ESMTPSA id k12sm12986128ejz.48.2020.11.18.05.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2020 05:20:40 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Pierre-eric.Pelloux-prayer@amd.com, Marek.Olsak@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: unpack dma_fence_chain containers during sync
Date: Wed, 18 Nov 2020 14:20:39 +0100
Message-Id: <20201118132039.2336-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBhbGxvd3MgZm9yIG9wdGltaXppbmcgdGhlIENQVSByb3VuZCB0cmlwIGF3YXkuCgpTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgICB8ICAyICstCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jIHwgMjcgKysrKysrKysrKysrKysr
KysrKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5oIHwgIDEg
KwogMyBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwppbmRleCA3OTM0Mjk3NmZhNzYuLjY4Zjlh
NGFkZjVkMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nz
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKQEAgLTEwMTQs
NyArMTAxNCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3N5bmNvYmpfbG9va3VwX2FuZF9hZGRfdG9f
c3luYyhzdHJ1Y3QgYW1kZ3B1X2NzX3BhcnNlciAqcCwKIAkJcmV0dXJuIHI7CiAJfQogCi0JciA9
IGFtZGdwdV9zeW5jX2ZlbmNlKCZwLT5qb2ItPnN5bmMsIGZlbmNlKTsKKwlyID0gYW1kZ3B1X3N5
bmNfZmVuY2VfY2hhaW4oJnAtPmpvYi0+c3luYywgZmVuY2UpOwogCWRtYV9mZW5jZV9wdXQoZmVu
Y2UpOwogCiAJcmV0dXJuIHI7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfc3luYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMu
YwppbmRleCA4ZWE2YzQ5NTI5ZTcuLmQwZDY0YWYwNmY1NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfc3luYy5jCkBAIC0yOCw2ICsyOCw4IEBACiAgKiAgICBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CiAgKi8KIAorI2luY2x1ZGUgPGxpbnV4
L2RtYS1mZW5jZS1jaGFpbi5oPgorCiAjaW5jbHVkZSAiYW1kZ3B1LmgiCiAjaW5jbHVkZSAiYW1k
Z3B1X3RyYWNlLmgiCiAjaW5jbHVkZSAiYW1kZ3B1X2FtZGtmZC5oIgpAQCAtMTY5LDYgKzE3MSwz
MSBAQCBpbnQgYW1kZ3B1X3N5bmNfZmVuY2Uoc3RydWN0IGFtZGdwdV9zeW5jICpzeW5jLCBzdHJ1
Y3QgZG1hX2ZlbmNlICpmKQogCXJldHVybiAwOwogfQogCisvKioKKyAqIGFtZGdwdV9zeW5jX2Zl
bmNlX2NoYWluIC0gdW5wYWNrIGRtYV9mZW5jZV9jaGFpbiBhbmQgc3luYworICoKKyAqIEBzeW5j
OiBzeW5jIG9iamVjdCB0byBhZGQgZmVuY2UgdG8KKyAqIEBmOiBwb3RlbnRpYWwgZG1hX2ZlbmNl
X2NoYWluIHRvIHN5bmMgdG8uCisgKgorICogQWRkIHRoZSBmZW5jZXMgaW5zaWRlIHRoZSBjaGFp
biB0byB0aGUgc3luYyBvYmplY3QuCisgKi8KK2ludCBhbWRncHVfc3luY19mZW5jZV9jaGFpbihz
dHJ1Y3QgYW1kZ3B1X3N5bmMgKnN5bmMsIHN0cnVjdCBkbWFfZmVuY2UgKmYpCit7CisJaW50IHI7
CisKKwlkbWFfZmVuY2VfY2hhaW5fZm9yX2VhY2goZiwgZikgeworCQlpZiAoZG1hX2ZlbmNlX2lz
X3NpZ25hbGVkKGYpKQorCQkJY29udGludWU7CisKKwkJciA9IGFtZGdwdV9zeW5jX2ZlbmNlKHN5
bmMsIGYpOworCQlpZiAocikgeworCQkJZG1hX2ZlbmNlX3B1dChmKTsKKwkJCXJldHVybiByOwor
CQl9CisJfQorCXJldHVybiAwOworfQorCiAvKioKICAqIGFtZGdwdV9zeW5jX3ZtX2ZlbmNlIC0g
cmVtZW1iZXIgdG8gc3luYyB0byB0aGlzIFZNIGZlbmNlCiAgKgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9zeW5jLmgKaW5kZXggN2MwZmUyMGM0NzBkLi5iMTQyMTc1YjY1YjYgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmgKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuaApAQCAtNDgsNiArNDgsNyBA
QCBzdHJ1Y3QgYW1kZ3B1X3N5bmMgewogCiB2b2lkIGFtZGdwdV9zeW5jX2NyZWF0ZShzdHJ1Y3Qg
YW1kZ3B1X3N5bmMgKnN5bmMpOwogaW50IGFtZGdwdV9zeW5jX2ZlbmNlKHN0cnVjdCBhbWRncHVf
c3luYyAqc3luYywgc3RydWN0IGRtYV9mZW5jZSAqZik7CitpbnQgYW1kZ3B1X3N5bmNfZmVuY2Vf
Y2hhaW4oc3RydWN0IGFtZGdwdV9zeW5jICpzeW5jLCBzdHJ1Y3QgZG1hX2ZlbmNlICpmKTsKIGlu
dCBhbWRncHVfc3luY192bV9mZW5jZShzdHJ1Y3QgYW1kZ3B1X3N5bmMgKnN5bmMsIHN0cnVjdCBk
bWFfZmVuY2UgKmZlbmNlKTsKIGludCBhbWRncHVfc3luY19yZXN2KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3N5bmMgKnN5bmMsCiAJCSAgICAgc3RydWN0IGRtYV9y
ZXN2ICpyZXN2LCBlbnVtIGFtZGdwdV9zeW5jX21vZGUgbW9kZSwKLS0gCjIuMjUuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
