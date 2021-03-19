Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E77C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 08:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C360A6192D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 08:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C360A6192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 582386E3F4;
	Mon, 22 Mar 2021 08:20:09 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB0A6EB0F
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 23:24:23 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id k10so12234727ejg.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 16:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lZjC5MYRszFKToyjw0wtcbVmRCl1gRLkwMvW9D8FFsM=;
 b=vKozyBbKjc0ZyVzaCQcntN1YrghkSwertT5myBgovjgJsEl3QjHrnw1/+HnbSF40dC
 3zlaPKEJ0j699jJpYIMxqeGvzPbUV+BZq/Gj4wt6nICDvoLIUsU0YnkW2BY/KvC5aaHg
 DYoZuGoUz2LB6yF6/dh0SoaPz4eCeNVrvSBkjZgSBa5y6EZyTUG1eBHuUojvJ7eTna5H
 fUmDV+bKgfU3PgQ+18WfqZPWnQMSHtoFdLVtXrkSS60nZWfwk8Jae+k1nWCFYyf1yBJ/
 vX6mimkHHsefk3oe1mGmJdjR8nMJOaAsmeis3HCPrjPP+luZaw6NrE1PYNtiQa3wt+ux
 324w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lZjC5MYRszFKToyjw0wtcbVmRCl1gRLkwMvW9D8FFsM=;
 b=qwlZ8N8snrbKnCHL6MrLp4sBgeDwmalhoc7+ZntW44ysNwO4TnSOHDndR59hKRp8SN
 I7BS2D3hRGhcqtgPr6n/BJHqUFDLdQLsisAHo+rzLvuAE9fLV7dWLT12TsvdkpE/cAPS
 jmoJFgkFNuzv/pHB9DoM1xmctxRiUvavZGsR9+FXinuyoEgKgaSFosBaVEHxzyeypPE6
 9X0sFD14ctM4Qz/kb+PjsEc/+ArlQ1Jd+j1S+VGsigJeKozPrD/wtRb9RAbuyIsMZ4NM
 K1YObvwzPm/JWbtatc9YehqfUrA6q0leDmJPxPlvaIzI8YZoOsXmAq4ciE6FbqpAKMlU
 SD8g==
X-Gm-Message-State: AOAM533V0yCfGGcwiXR29i3DGJMihCd2KPSm7gyJolugyoP8zPobFgzR
 exNouITQZd32STRaDWKC7aQVD1Lwezs=
X-Google-Smtp-Source: ABdhPJzVv2ocBpWzi6Yz1/pKDkHm6dWoDjiVDzCwnuHuCEWGgWVKKmnAIMPmbUPAOXdxh9iSV46s3w==
X-Received: by 2002:a17:906:d797:: with SMTP id
 pj23mr7126089ejb.367.1616196262220; 
 Fri, 19 Mar 2021 16:24:22 -0700 (PDT)
Received: from localhost ([2001:470:5139::819])
 by smtp.gmail.com with ESMTPSA id lu26sm4329102ejb.33.2021.03.19.16.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Mar 2021 16:24:21 -0700 (PDT)
From: Tobias Jakobi <cubic2k@gmail.com>
X-Google-Original-From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/swsmu: fix typo (memlk -> memclk)
Date: Sat, 20 Mar 2021 00:24:19 +0100
Message-Id: <20210319232419.174234-1-tjakobi@math.uni-bielefeld.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 22 Mar 2021 08:19:58 +0000
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
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- no functional changes

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 6e641f1513d8..66d69c13f915 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1433,7 +1433,7 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
 		size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			2,
-			"MEMLK",
+			"MEMCLK",
 			activity_monitor.Mem_FPS,
 			activity_monitor.Mem_MinFreqStep,
 			activity_monitor.Mem_MinActiveFreqType,
@@ -1493,7 +1493,7 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 			activity_monitor.Soc_PD_Data_error_coeff = input[8];
 			activity_monitor.Soc_PD_Data_error_rate_coeff = input[9];
 			break;
-		case 2: /* Memlk */
+		case 2: /* Memclk */
 			activity_monitor.Mem_FPS = input[1];
 			activity_monitor.Mem_MinFreqStep = input[2];
 			activity_monitor.Mem_MinActiveFreqType = input[3];
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index af73e1430af5..f21679acd9af 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1366,7 +1366,7 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 		size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			2,
-			"MEMLK",
+			"MEMCLK",
 			activity_monitor->Mem_FPS,
 			activity_monitor->Mem_MinFreqStep,
 			activity_monitor->Mem_MinActiveFreqType,
@@ -1429,7 +1429,7 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 			activity_monitor->Fclk_PD_Data_error_coeff = input[8];
 			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[9];
 			break;
-		case 2: /* Memlk */
+		case 2: /* Memclk */
 			activity_monitor->Mem_FPS = input[1];
 			activity_monitor->Mem_MinFreqStep = input[2];
 			activity_monitor->Mem_MinActiveFreqType = input[3];
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
