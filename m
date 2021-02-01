Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BB0C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 14:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F6960C41
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 14:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F6960C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9451F6E5C5;
	Mon,  1 Feb 2021 14:34:12 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4AB66E5C5
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 14:34:11 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id r12so24675899ejb.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Feb 2021 06:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N6dAr10FwkioC7U11IMjOISybbRki2H6RgK1TY0Y1jY=;
 b=vRmKYKU6BGmuhzQ2eO2TSsQmRDQ8H8tCvTX7egqoOvOvw1ond1YzD3k2PYuGSKAQ14
 7qgl/6VmnrImfHWTUsixIgxC3xHsEx3Smn5ogbhbl3RH+EBW3Lf2usLJalklJ/CktGcm
 dsrni63AvFf5WyPkCbpLmQGg8vn79buuxMmyqnTwlQ1KG/5HihiScv1iawVZqNTNmEdL
 93zTMdfSkIPhfRbVz5jUD1AToFGUtEICYwLRVFDHCamYWPT9gy3aUcTeoK4/tDEhCGLk
 jEc5FatEAvJPlyUJNxFBz8Lm1bfZCYJG8FLtXn+uApHBYLLEX65JO2FApKclSwLnLpxH
 Vssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N6dAr10FwkioC7U11IMjOISybbRki2H6RgK1TY0Y1jY=;
 b=jTtw4UBw7qmz66zy9DBNUIMa90yxRSL24zKepSJ+lPlPujBEakJMCFTpkUYYu0muEI
 dhqBJ85+D5w/PReL1PMnc/6fvbL5jm7RRT5vWSWB66xK+KyEt3C5Y9+WqSsxyGrXzzT5
 +XSbIjL6xm+QU1KQeNu11KwhsAy3nQbvHVRo5Xyg4WMuSswJX7afqs6Z6fwlNlCjVoDF
 2R+v9bT631HcCHLgyf2s+wQ1cXxmOWmPUJ8et9g4x366+Sx9ip0aD6QxGIAR8foUUCsV
 MVownxyLk7a7u2oS3HnvTLeWD7zN99GgSgPO37zXloXQQajR+8So9fReQu8xb+MvCenq
 rQeg==
X-Gm-Message-State: AOAM532L+t30n5ssEP18BVl1eIJjLf0ozXiGs6uxBQtMvAd/VD/iK9sN
 Gp7S9NvRIsMBG5m/C41IJ9XMwGva5f0=
X-Google-Smtp-Source: ABdhPJwJ0uMPHdzfUsvMedumAu42DXIkSGy+mkE/CyiaPizws/6JF9YZt+ZvmLxviVpeYjRotxyW6g==
X-Received: by 2002:a17:907:9810:: with SMTP id
 ji16mr17498005ejc.394.1612190050048; 
 Mon, 01 Feb 2021 06:34:10 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:5339:66ca:31c4:4009])
 by smtp.gmail.com with ESMTPSA id p16sm8618788edw.44.2021.02.01.06.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 06:34:09 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable freesync for A+A configs
Date: Mon,  1 Feb 2021 15:34:08 +0100
Message-Id: <20210201143408.81475-1-christian.koenig@amd.com>
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
Cc: shashank.sharma@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U29tZSBuZXdlciBBUFVzIGNhbiBzY2Fub3V0IGRpcmVjdGx5IGZyb20gR1RULCB0aGF0IHNhdmVz
IHVzIGZyb20KYWxsb2NhdGluZyBhbm90aGVyIGJvdW5jZSBidWZmZXIgaW4gVlJBTSBhbmQgZW5h
YmxlcyBmcmVlc3luYyBpbiBzdWNoCmNvbmZpZ3VyYXRpb25zLgoKU2lnbmVkLW9mZi1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMgfCA4ICsrKysrKy0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgIHwgMiArLQogMiBmaWxlcyBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMKaW5kZXggYTYzODcwOWU5YzkyLi44MjNiYzI1ZDg3ZGUg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYwpAQCAtOTMw
LDggKzkzMCwxMCBAQCBhbWRncHVfZGlzcGxheV91c2VyX2ZyYW1lYnVmZmVyX2NyZWF0ZShzdHJ1
Y3QgZHJtX2RldmljZSAqZGV2LAogCQkJCSAgICAgICBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGVfcHJp
diwKIAkJCQkgICAgICAgY29uc3Qgc3RydWN0IGRybV9tb2RlX2ZiX2NtZDIgKm1vZGVfY21kKQog
ewotCXN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqOwogCXN0cnVjdCBhbWRncHVfZnJhbWVidWZm
ZXIgKmFtZGdwdV9mYjsKKwlzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iajsKKwlzdHJ1Y3QgYW1k
Z3B1X2JvICpibzsKKwl1aW50MzJfdCBkb21haW5zOwogCWludCByZXQ7CiAKIAlvYmogPSBkcm1f
Z2VtX29iamVjdF9sb29rdXAoZmlsZV9wcml2LCBtb2RlX2NtZC0+aGFuZGxlc1swXSk7CkBAIC05
NDIsNyArOTQ0LDkgQEAgYW1kZ3B1X2Rpc3BsYXlfdXNlcl9mcmFtZWJ1ZmZlcl9jcmVhdGUoc3Ry
dWN0IGRybV9kZXZpY2UgKmRldiwKIAl9CiAKIAkvKiBIYW5kbGUgaXMgaW1wb3J0ZWQgZG1hLWJ1
Ziwgc28gY2Fubm90IGJlIG1pZ3JhdGVkIHRvIFZSQU0gZm9yIHNjYW5vdXQgKi8KLQlpZiAob2Jq
LT5pbXBvcnRfYXR0YWNoKSB7CisJYm8gPSBnZW1fdG9fYW1kZ3B1X2JvKG9iaik7CisJZG9tYWlu
cyA9IGFtZGdwdV9kaXNwbGF5X3N1cHBvcnRlZF9kb21haW5zKGRybV90b19hZGV2KGRldiksIGJv
LT5mbGFncyk7CisJaWYgKG9iai0+aW1wb3J0X2F0dGFjaCAmJiAhKGRvbWFpbnMgJiBBTURHUFVf
R0VNX0RPTUFJTl9HVFQpKSB7CiAJCWRybV9kYmdfa21zKGRldiwgIkNhbm5vdCBjcmVhdGUgZnJh
bWVidWZmZXIgZnJvbSBpbXBvcnRlZCBkbWFfYnVmXG4iKTsKIAkJcmV0dXJuIEVSUl9QVFIoLUVJ
TlZBTCk7CiAJfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCmlu
ZGV4IDU2ODU0YTNlZTE5Yy4uMGJkMjJlZDFkYWNmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X29iamVjdC5jCkBAIC05MDAsNyArOTAwLDcgQEAgaW50IGFtZGdwdV9ib19w
aW5fcmVzdHJpY3RlZChzdHJ1Y3QgYW1kZ3B1X2JvICpibywgdTMyIGRvbWFpbiwKIAkJcmV0dXJu
IC1FSU5WQUw7CiAKIAkvKiBBIHNoYXJlZCBibyBjYW5ub3QgYmUgbWlncmF0ZWQgdG8gVlJBTSAq
LwotCWlmIChiby0+cHJpbWVfc2hhcmVkX2NvdW50KSB7CisJaWYgKGJvLT5wcmltZV9zaGFyZWRf
Y291bnQgfHwgYm8tPnRiby5iYXNlLmltcG9ydF9hdHRhY2gpIHsKIAkJaWYgKGRvbWFpbiAmIEFN
REdQVV9HRU1fRE9NQUlOX0dUVCkKIAkJCWRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX0dUVDsK
IAkJZWxzZQotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
