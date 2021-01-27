Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA68C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 02:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8A2206C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 02:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8A2206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB57899BC;
	Wed, 27 Jan 2021 02:57:13 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A757899BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 02:57:11 +0000 (UTC)
Received: by mail-qk1-x730.google.com with SMTP id l27so489619qki.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 18:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=U0KOVhh1bStw7nx1wCaJKiE0qqvzycc0jtFl7HZroJs=;
 b=eUxIPXD6HIQdDp6jdkhgcCArHLvR5nybGw8n3mYMEe63hDevDPRZJtmV5FPG1IuqfB
 /P7meOlAfsowDUN0NuXWS29UN6+dpaeaaNQF06MXxDB9XkYR1jmpnHYuR0+vvgObvyta
 XVokkAwCACBFp2EzrOj5ZLchhO/6U/JKBeZR7LU27D+Dgwj9wFbVhVXLLdtys3ycrgXJ
 SNiPCzUQjP/+rafIRS6D+JaOgoi9EWGxupSZOFqzAHUNQPjzllRu7miRyVjV2lqwUE+v
 ol+dnpx9NIef+j70IAbNQNBW0Cncib6dFj+s0FhmPsoFyYWlZNA5VgF5ZflxSVjcOP5S
 myQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=U0KOVhh1bStw7nx1wCaJKiE0qqvzycc0jtFl7HZroJs=;
 b=mMt0p0V6xC8723jcIzxsJJQzRNoUr0tpI2RKBRh5+EUeij1mfKDhChHbC0R4rwEE0T
 3uILNzo6/gtGHwKDUb8YyIKTOnunW/4fiBhqwe1HSicl3ifgbCcdeT0So872GMWISLgU
 +c6RudRxahG2m2nhDjS1ZA4nwaI8qy0xFhdwjYruB7C2v1/H/p7jUdwVbYK26l+VVw6V
 KFUEQvG0yskPC1+KbdymTbzcgww3pfU94Xyd9z5GWruciTexWRjD8KCIfo1QsDwO0kWd
 UWp2WrgKISYcAWCftjZGnld1Ame+VlDMV+D1L+DN7IBwFm7fc3jTwxzy6c+I/goZFdH9
 cW1A==
X-Gm-Message-State: AOAM5306uBhaip8AdfUrF6Cd99ZoURCXOSUHO57ZyTMZMe9tzq2tt/Cq
 5HvuFaLZzsUBsa5NFMK7WdVnUbyjZvU=
X-Google-Smtp-Source: ABdhPJyPdNQf/q49iKp1H4NvDLmQM+v2/Y/soHDJaOdLCGCVp2tvPfMQ/eB2PctDWh4cBGKKtWslBw==
X-Received: by 2002:a05:620a:158e:: with SMTP id
 d14mr8729558qkk.111.1611716230587; 
 Tue, 26 Jan 2021 18:57:10 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id p23sm520157qtu.4.2021.01.26.18.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jan 2021 18:57:10 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: disable gpu reset on Vangogh for now
Date: Tue, 26 Jan 2021 21:57:00 -0500
Message-Id: <20210127025700.162347-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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

Until the issues in the SMU firmware are fixed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 drivers/gpu/drm/amd/amdgpu/nv.c            | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9ae0f2d68281..51bea409e513 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4211,7 +4211,6 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 		case CHIP_NAVI12:
 		case CHIP_SIENNA_CICHLID:
 		case CHIP_NAVY_FLOUNDER:
-		case CHIP_VANGOGH:
 			break;
 		default:
 			goto disabled;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index b9722282d1b8..66279f0c6808 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -411,6 +411,10 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 	int ret = 0;
 	struct smu_context *smu = &adev->smu;
 
+	/* skip reset on vangogh for now */
+	if (adev->asic_type == CHIP_VANGOGH)
+		return 0;
+
 	switch (nv_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_BACO:
 		dev_info(adev->dev, "BACO reset\n");
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
