Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95C8C33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E6392075A
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4gj9I1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6392075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFECC6E484;
	Mon,  6 Jan 2020 15:03:45 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 956236E483
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 15:03:44 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z3so49984613wru.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2020 07:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=R3fSzdbt1cDYaiK2OUJNHINaVy9gKx6uKwT8+y2OlOY=;
 b=i4gj9I1WBRHsCM5+f92v83kDlkFP6c3pDe4W9e2M9qr61Fha5qpRIOzNgod2zF3csR
 USK4JP/OJtrL3ywy4CE6H8PBs0KGelV0OS9u4nzGAzPLZiAbr/0m6T8iCUup2JPcE0nQ
 PfLKG34ZQRaaoPLgFvJmHwrWIsS1zNy6bQ2h9mOvCjaqo7+SbllD6E36Jp7trdDVuOBx
 l5H1MAdiPPZqi8wAeNzYowXYM2e7Izb7mja7z5LSqdoEBRObrxQdSTQWi+qc1oJUQC4B
 qdg+SE48X55Agz1AahYzOZC9kGWuBca6GWdAtHDFV+ogl+5z6Z/AIfIAvxqgHuLrFV2D
 hVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R3fSzdbt1cDYaiK2OUJNHINaVy9gKx6uKwT8+y2OlOY=;
 b=mBJxSsrSFZBBM0SzQrrFhbzV7pNZmQRYpZe3ZWqVNzOuSxztFz6JJ33jpyCJJbG8Yz
 KnTaY0l25YiNKQcRlBzB7pSv87igMiGmbxGfBLm6kMpRSgYA37BgTl1LUXPA8xkUweED
 jmoFY1x75szKSjzmLtg5799WtRXL4vh8LjqTXos3jokC6IZEgt88RCrRR2zrG1Pt+6Un
 I7fRC777Me+OKiBDZ2uiOF8PVjSA2ux2bayMwKg7se3AF1TVj6mzDj+xnOeguzSVqoVR
 PFt/aC8pvQffH/+phqaYTZ/lwrUZMzUwLNp/8CUo5aPnVdS+UTAzGTpRr+6JwSenRHix
 V/DQ==
X-Gm-Message-State: APjAAAWiDhNEMcPg5S3FTYwYYvnD43vTljgxtXnD5YvYG+91Gszyrqsy
 T2Z51kUBbPxL8M4ayBehDqj1zESv
X-Google-Smtp-Source: APXvYqyp5T818wCUxET1M/4to9LGCPWYsP5LdJAwJR5xAsr1CPr+QzmocQVxtJAskOaYxQKOVrAuzg==
X-Received: by 2002:a05:6000:1241:: with SMTP id
 j1mr109507519wrx.26.1578323023339; 
 Mon, 06 Jan 2020 07:03:43 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:ece2:ff95:11ee:3e72])
 by smtp.gmail.com with ESMTPSA id b17sm70307444wrp.49.2020.01.06.07.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 07:03:43 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alex.Sierra@amd.com, Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/12] drm/amdgpu: explicitly sync VM update to PDs/PTs
Date: Mon,  6 Jan 2020 16:03:28 +0100
Message-Id: <20200106150335.1738-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106150335.1738-1-christian.koenig@amd.com>
References: <20200106150335.1738-1-christian.koenig@amd.com>
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

RXhwbGljaXRseSBzeW5jIFZNIHVwZGF0ZXMgdG8gdGhlIG1vdmluZyBmZW5jZSBpbiBQRHMgYW5k
IFBUcy4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fY3B1LmMg
IHwgNyArKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5j
IHwgNSArKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX2NwdS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX2NwdS5jCmluZGV4IDczZmVjN2EwY2VkNS4uNjhi
MDEzYmUzODM3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm1fY3B1LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX2NwdS5j
CkBAIC04Niw2ICs4NiwxMyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9jcHVfdXBkYXRlKHN0cnVj
dCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcCwKIHsKIAl1bnNpZ25lZCBpbnQgaTsKIAl1aW50
NjRfdCB2YWx1ZTsKKwlpbnQgcjsKKworCWlmIChiby0+dGJvLm1vdmluZykgeworCQlyID0gZG1h
X2ZlbmNlX3dhaXQoYm8tPnRiby5tb3ZpbmcsIHRydWUpOworCQlpZiAocikKKwkJCXJldHVybiBy
OworCX0KIAogCXBlICs9ICh1bnNpZ25lZCBsb25nKWFtZGdwdV9ib19rcHRyKGJvKTsKIApkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMKaW5kZXggMTliN2Y4MDc1
OGYxLi40YmJkOGZmNzc4ZWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bV9zZG1hLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtX3NkbWEuYwpAQCAtMjA4LDYgKzIwOCwxMSBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9zZG1h
X3VwZGF0ZShzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnAsCiAJdWludDY0X3QgKnB0
ZTsKIAlpbnQgcjsKIAorCS8qIFdhaXQgZm9yIFBEL1BUIG1vdmVzIHRvIGJlIGNvbXBsZXRlZCAq
LworCXIgPSBhbWRncHVfc3luY19mZW5jZSgmcC0+am9iLT5zeW5jLCBiby0+dGJvLm1vdmluZywg
ZmFsc2UpOworCWlmIChyKQorCQlyZXR1cm4gcjsKKwogCWRvIHsKIAkJbmR3ID0gcC0+bnVtX2R3
X2xlZnQ7CiAJCW5kdyAtPSBwLT5qb2ItPmlicy0+bGVuZ3RoX2R3OwotLSAKMi4xNy4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
