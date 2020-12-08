Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67D6C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 17:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A111123B17
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 17:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A111123B17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64FD689F06;
	Tue,  8 Dec 2020 17:31:04 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E287E89F06
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 17:31:02 +0000 (UTC)
Received: by mail-ed1-x542.google.com with SMTP id c7so18394862edv.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Dec 2020 09:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2/R/A3AChvU79VrNfh6D20cK+taKq5aSAi8aRBeMemQ=;
 b=LNtcP+plJnD5gJ1EdFZS9hU2KPbxZV8Q4MFqPxiGkGRS+9T/3LeVbvImx7tDgAUWVm
 IIqTD/Gt29126n2H9U39SppSFqlT3zcCjhAbCaCgV89TzBPzcFGCb6uP75eBLmsStwCf
 qc8UPvlBOS3sqWvK/5vcir5m3dqSFthLkS2pv6JrpU2n2AgrNZCYE2MAiJBgkIQnq8uH
 nkz43lJW4etSBs+cruJnAzrGLNhOdpWKfUMCIl7wkXiSftCcge7/kowUK5Kb30o4vuLS
 1fzAr60bIc5n2AdjdPTG2jG6ecbadYvWTQQk8Y00sqsolVN2okKuOEdL0cAsNnup47Bt
 4h7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2/R/A3AChvU79VrNfh6D20cK+taKq5aSAi8aRBeMemQ=;
 b=uCD3N+oyt4/tTN9mc5IAQD8IEHRnBsMcUFb0f/Yu2QunsboYwX3RSXYp57BOIJyuse
 JxMgmKNVFqj1ZFpSqyg6PiqPvNgMMJ2H3RfQ6hnYLGkEjEC32TFYEjYHDr1f/M999QYL
 nLpcr3NgHFj5TFo7siOHR0hbJ/f73pPufAdL6GhmbofBjhXx7i7deFGp2TPCobZ5BG3x
 +zk2/25OLlM0ZC2IO5e16X21FoJXJKIt6gzItTjED0Z2LOEsJ9CNI1162mI+TumD5wh9
 Du+rzXJnGMzPq7morFAVy03EG4vhRhKhlJlvTldQagEZgXFqVJs5hb7xmvUPk7GjuF08
 PskQ==
X-Gm-Message-State: AOAM5313XmYmdTqv9JFlyvb+QzyJHm0Hvrke2ocl1cJypSFpVn68FRjH
 VSMAWtWAtyXZ+km5uGUycL6xbP9I6N8=
X-Google-Smtp-Source: ABdhPJx9BgpHdKUDJoZtwwANTwNjySM6Uwza6XqbpZnVMv97Xm/hHeTxmCfvR6gSlWH0gpdXICD4lQ==
X-Received: by 2002:a05:6402:3074:: with SMTP id
 bs20mr25705114edb.365.1607448661322; 
 Tue, 08 Dec 2020 09:31:01 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:2901:b870:7284:302d])
 by smtp.gmail.com with ESMTPSA id ck27sm16494868edb.13.2020.12.08.09.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 09:31:00 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: limit the amdgpu_vm_update_ptes trace point
Date: Tue,  8 Dec 2020 18:30:59 +0100
Message-Id: <20201208173059.11076-1-christian.koenig@amd.com>
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

VGhlIHRleHQgb3V0cHV0IHNob3VsZCBub3QgYmUgbW9yZSB0aGFuIGEgcGFnZSwgc28gb25seSBw
cmludCB0aGUgZmlyc3QKMzIgcGFnZSB0YWJsZSBlbnRyaWVzLgoKSWYgd2UgbmVlZCBhbGwgb2Yg
dGhlbSB3ZSBjYW4gc3RpbGwgbG9vayBpbnRvIHRoZSBiaW5hcnkgdHJhY2UuCgpTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmggfCA1ICsrKy0tCiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKaW5kZXggZWU5NDgwZDE0Y2JjLi4xMWIxYjExMjJj
MzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5o
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCkBAIC0zNTgs
MTAgKzM1OCwxMSBAQCBUUkFDRV9FVkVOVChhbWRncHVfdm1fdXBkYXRlX3B0ZXMsCiAJCQl9CiAJ
KSwKIAlUUF9wcmludGsoInBpZDoldSB2bV9jdHg6MHglbGx4IHN0YXJ0OjB4JTAxMGxseCBlbmQ6
MHglMDEwbGx4LCIKLQkJICAiIGZsYWdzOjB4JWxseCwgaW5jcjolbGx1LCBkc3Q6XG4lcyIsIF9f
ZW50cnktPnBpZCwKKwkJICAiIGZsYWdzOjB4JWxseCwgaW5jcjolbGx1LCBkc3Q6XG4lcyVzIiwg
X19lbnRyeS0+cGlkLAogCQkgIF9fZW50cnktPnZtX2N0eCwgX19lbnRyeS0+c3RhcnQsIF9fZW50
cnktPmVuZCwKIAkJICBfX2VudHJ5LT5mbGFncywgX19lbnRyeS0+aW5jciwgIF9fcHJpbnRfYXJy
YXkoCi0JCSAgX19nZXRfZHluYW1pY19hcnJheShkc3QpLCBfX2VudHJ5LT5ucHRlcywgOCkpCisJ
CSAgX19nZXRfZHluYW1pY19hcnJheShkc3QpLCBtaW4oX19lbnRyeS0+bnB0ZXMsIDMydSksIDgp
LAorCQkgIF9fZW50cnktPm5wdGVzID4gMzIgPyAiLi4uIiA6ICIiKQogKTsKIAogVFJBQ0VfRVZF
TlQoYW1kZ3B1X3ZtX3NldF9wdGVzLAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
