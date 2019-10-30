Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51247CA9ECE
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 17:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9ED2173E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 17:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9ED2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8FFE6EAE9;
	Wed, 30 Oct 2019 17:32:35 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A620F6EAE9
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 17:32:34 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id t26so4326881qtr.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 10:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hk/ZG30OzpKkx0nkDC2P3USlwjVghPnD3eVKo3RS4a0=;
 b=TkSQfp0ypSKYXvb0jdV375JJI9jfT2nK0xwgvF7xQWENqFJcyI9s/yA0tjwTZGp+Dq
 ysRtVzAvPy6Y5gp4/5HNF8MJN6WFzHtBSyimVtOswBgQBQwLZDDtTTL22/IJ0/tnLcFL
 1ULmpHUwu2RH+7oTRmW47QYK9gq+t/rioaQm91yHRNltZwsION2WHX5HEPhOiwSsQ888
 NOzg+S4Iy5HV+DHZBqPbmu81sj405/Z0cT4IRJ1byfs/Vcp9xwEDcD3NQjyOFmPk/7DT
 Tt+0wb+tx2ijUzwcQ/lguedKhQh3OWXDbS0SqQ8pk1ctIKf1E4Yk77qd0DWW97DpdS2r
 geAQ==
X-Gm-Message-State: APjAAAUYSpH9KmBDdhEoj0WOuzDhpgCpvk0M5XL6E1pKhltzriBR6kiZ
 z/a+fMc5HzycESiNed50ZfW0Me/6
X-Google-Smtp-Source: APXvYqwOyUqHbvnTbgC2lOKIoAMfb5IeNkqe3WLET8dbApeVfBGpaiB+6NBhL98honC9SERJfbZq7Q==
X-Received: by 2002:a0c:b446:: with SMTP id e6mr200958qvf.159.1572456753214;
 Wed, 30 Oct 2019 10:32:33 -0700 (PDT)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id v186sm357728qkb.42.2019.10.30.10.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2019 10:32:32 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/arcturus: properly set BANK_SELECT and
 FRAGMENT_SIZE
Date: Wed, 30 Oct 2019 13:32:25 -0400
Message-Id: <20191030173225.243413-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hk/ZG30OzpKkx0nkDC2P3USlwjVghPnD3eVKo3RS4a0=;
 b=NlIw8hGzfjjYkddAX60tiObroS1e/FSr6FwuiYY1/9rAK3QS5jXW1GRI3i5yJrXtp9
 TdAbvgXK9Rgxa3tzqsPDDLBNBK3E5F8B0p1yJS4nZtYq1PgK+9K3G4cnT79Fg6IoA0pG
 0jWMgGcLNan6+WFPT30wGwOJjZrVoyPXtRapwuSbQ7pDcxG+85VdZMwXNwbURSURORTU
 Uu7HpOGMPtLIZ74Tfq7sbvXbKUt5GSMCKt4u9suqpo3GZOnT5m4l/SFCWDTmX/zSpO7m
 n5sfnUPcPoMxiiAp6waChgoOp9m6vBFdu7x1fdVfGyUOD48vIaRSMaVZ18oN3HBxa0eH
 rlhw==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030173225.X_KdDDBYivLIoiFlou5FlroT8KwLrFlNpPNDFRdnZFo@z>

VGhlc2Ugd2VyZSBub3QgYWxpZ25lZCBmb3Igb3B0aW1hbCBwZXJmb3JtYW5jZSBmb3IgR1BVVk0u
CgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jIHwgOSArKysrKysr
KysKIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9tbWh1Yl92OV80LmMKaW5kZXggNjU3OTcwZjllYmZiLi4yYzVhZGZlODAzYTIgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMKQEAgLTIxOSw2ICsyMTksMTUgQEAg
c3RhdGljIHZvaWQgbW1odWJfdjlfNF9pbml0X2NhY2hlX3JlZ3Moc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIGludCBodWJpZCkKIAkJCSAgICBodWJpZCAqIE1NSFVCX0lOU1RBTkNFX1JFR0lT
VEVSX09GRlNFVCwgdG1wKTsKIAogCXRtcCA9IG1tVk1MMlBGMF9WTV9MMl9DTlRMM19ERUZBVUxU
OworCWlmIChhZGV2LT5nbWMudHJhbnNsYXRlX2Z1cnRoZXIpIHsKKwkJdG1wID0gUkVHX1NFVF9G
SUVMRCh0bXAsIFZNTDJQRjBfVk1fTDJfQ05UTDMsIEJBTktfU0VMRUNULCAxMik7CisJCXRtcCA9
IFJFR19TRVRfRklFTEQodG1wLCBWTUwyUEYwX1ZNX0wyX0NOVEwzLAorCQkJCSAgICBMMl9DQUNI
RV9CSUdLX0ZSQUdNRU5UX1NJWkUsIDkpOworCX0gZWxzZSB7CisJCXRtcCA9IFJFR19TRVRfRklF
TEQodG1wLCBWTUwyUEYwX1ZNX0wyX0NOVEwzLCBCQU5LX1NFTEVDVCwgOSk7CisJCXRtcCA9IFJF
R19TRVRfRklFTEQodG1wLCBWTUwyUEYwX1ZNX0wyX0NOVEwzLAorCQkJCSAgICBMMl9DQUNIRV9C
SUdLX0ZSQUdNRU5UX1NJWkUsIDYpOworCX0KIAlXUkVHMzJfU09DMTVfT0ZGU0VUKE1NSFVCLCAw
LCBtbVZNTDJQRjBfVk1fTDJfQ05UTDMsCiAJCQkgICAgaHViaWQgKiBNTUhVQl9JTlNUQU5DRV9S
RUdJU1RFUl9PRkZTRVQsIHRtcCk7CiAKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4
