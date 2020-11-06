Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1622FC2D0A3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 14:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F95217A0
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 14:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onB97zM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F95217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A126EA8A;
	Fri,  6 Nov 2020 14:53:56 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B56B6EA8A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 14:53:56 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id b18so1240547qkc.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2020 06:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9lfeQbDk3gaAj10iPKGalXC3zyHXjU3tCr86jbeUuXo=;
 b=onB97zM2KQbSpisoQKU0pIBgph5s7pLO5+HTIdwCF0jtYUPfilRMWIUqiIvF++4vsz
 g3pd6jRfKznE5ayzVjIctH6Ne11W2Cg0npmxfVtGSyNdwWTWZcRmo68HvwK8QzI8Sm3y
 Fi25OfYpaRJSDisMIhWvkOO44oALpSqWu9SRfjwB3PccIb87mYwh7cFsClEeV0XL4y7V
 cdpDc14JK+KrE7yvaGWnYx/GPNbZuQd3fybSpKXyQyDGwRNupcdifI1+a0X/0yxOq6Eu
 6Ewz8bEzawAlfveI9MeZObUjff8adxVScWB9QkZpwU6plF7vICbkmLYkHVwuG7IaEFuj
 rMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9lfeQbDk3gaAj10iPKGalXC3zyHXjU3tCr86jbeUuXo=;
 b=kaWRb2hYfP3LPvgJ8gWjoRf8rhDwT/hSnuEndJ5RFm5IMWtaEHD/mh7E2j9PRZqQBe
 Cuxui3Kv78YIpXVgqDyBRZm9LZvuSU5qCnInmsX/DcR9s3GFclbPXhZgDDZT6tEKw+zN
 56TfeGOpZnYw26pJJepa+ud9aZH/z/Mcq+tScTkd2bNW0O0QNn9G8rNSDjgY2t49tOY4
 kS3pVxISy1KIeHnBu8iV4Cn6c6clQbPJfBsqwHgn9UafPPyAfyF14FClT/cUtpYEf4l4
 fpjIoZrwAdg/bhtcE7RS6A5yKErEcpd7jCfYgwKK34Yhq6aQmTG10hkrFIly68+MOPAR
 6XEg==
X-Gm-Message-State: AOAM532VAnUzTfu4OJiv9x3DidxvxWZ/U2jP9hYqJjk8Ea9AJK+nskWC
 HEPpBH61o6JILj742gXWLqfKEdPQnjQ=
X-Google-Smtp-Source: ABdhPJzNZu1oQRwpwD7hIKgqUhs4Cr6BzHayIVw++A0QCQoOCIWmBHoW7OZdcTeUDCJ4JIbW1vTzrg==
X-Received: by 2002:a37:5002:: with SMTP id e2mr1809136qkb.453.1604674435337; 
 Fri, 06 Nov 2020 06:53:55 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id k15sm655935qtq.11.2020.11.06.06.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 06:53:54 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/pm/smu12: cache smu firmware version
Date: Fri,  6 Nov 2020 09:53:46 -0500
Message-Id: <20201106145347.421966-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So we print the proper SMU firmware version in debugfs, ioctls, etc.
for Renoir.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index 660f403d5770..522d55004655 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -71,6 +71,7 @@ int smu_v12_0_check_fw_status(struct smu_context *smu)
 
 int smu_v12_0_check_fw_version(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
 	uint32_t if_version = 0xff, smu_version = 0xff;
 	uint16_t smu_major;
 	uint8_t smu_minor, smu_debug;
@@ -83,6 +84,8 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
 	smu_major = (smu_version >> 16) & 0xffff;
 	smu_minor = (smu_version >> 8) & 0xff;
 	smu_debug = (smu_version >> 0) & 0xff;
+	if (smu->is_apu)
+		adev->pm.fw_version = smu_version;
 
 	/*
 	 * 1. if_version mismatch is not critical as our fw is designed
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
