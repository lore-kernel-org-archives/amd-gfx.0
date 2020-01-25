Return-Path: <SRS0=ij9B=3O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C932C2D0DB
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Jan 2020 18:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A1C20716
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Jan 2020 18:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quuxkYWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A1C20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 974576E8E4;
	Sat, 25 Jan 2020 18:48:54 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A68A6E8E4
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Jan 2020 18:48:53 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id d10so5624277qke.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Jan 2020 10:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SKL2sqi2EL4mq8psKYKolWdZLh6vJTuTy7MFp7cI8oM=;
 b=quuxkYWEPbDTiSxbBbkgJaQARN8ty8YXg7/Zr7X6XezArVKbYbfdN0GPLhf5xU8Wwl
 zAyvdCGKsC7VG76yYcdrc1FutdrVLORlzbMQ8cI27hbLsztbhirUZChoXrfbzG7oQAoA
 4tuY277SOyGFTpu8u4sgyvmUe80ALLlWrzmI/ESo2RaXFtxF0isssqIbVCDaiZR/pAFa
 iEV+byaRhUf5oEsJbUOULQTu6FDzkHEPjGkQflbbMf7SnFvGL+nrMMTiHKHULnYk2zAw
 UQF/JFZ1chGGtGXbpdxL1c4Ee/TStxnp22SrfE8kql9LhZksHQaGKxGcjO4TL44v6SXF
 ddDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SKL2sqi2EL4mq8psKYKolWdZLh6vJTuTy7MFp7cI8oM=;
 b=D9JNIJmIsqGH5sBYCml3izupiMpNliP5U75hv6sH7XoSrqR2x6vyQ936Z5P1E1Ua3Z
 MIqLLs5hkg4cwP5w0IP7mQ6I7nuOROR/eJKPVc9A+3PcGjmNJCas5RW78Sa8BwUutS6M
 5fV+uaTCD4XpXVN1U5gpcCQH+imEmm0z8eMpVtF6+16Kzbf7tV30mLbU0SdFLSp8zpWq
 pCoC8xND5+CagexNeeRAzd9UX1VQLaKsBh8xhhTWgiOPDRYluBJbJKRtJcov9sZUKGom
 XEJfbcuLaZ8bjwFBeklmeqpU7vdhWgTOyoka7fzMQlD/cHE+eVKcDTcjhkZTcBlNtC3K
 Tn8Q==
X-Gm-Message-State: APjAAAXmGOekh51f73WwlvGf/jhuhUy8VNB2AEG6G3OKeTFvKbqREcHE
 AiHf4Je21xJt478rHAw+ynwy/HxE
X-Google-Smtp-Source: APXvYqy9NMLBVv8NbQyh/I3uBjkjgI1btNKPjY03Ixrk21bOArtsTZIRoSmZZhsWxoDzo62aXCHU2A==
X-Received: by 2002:a05:620a:23a:: with SMTP id
 u26mr8830272qkm.426.1579978132615; 
 Sat, 25 Jan 2020 10:48:52 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id z6sm5565118qkz.101.2020.01.25.10.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2020 10:48:52 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu/navi: fix index for OD MCLK
Date: Sat, 25 Jan 2020 13:48:43 -0500
Message-Id: <20200125184845.4233-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

You can only adjust the max mclk, not the min.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/1020
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index f1b27fc20c19..c8f09874c2ec 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -843,7 +843,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_UCLK_MAX))
 			break;
 		size += sprintf(buf + size, "OD_MCLK:\n");
-		size += sprintf(buf + size, "0: %uMHz\n", od_table->UclkFmax);
+		size += sprintf(buf + size, "1: %uMHz\n", od_table->UclkFmax);
 		break;
 	case SMU_OD_VDDC_CURVE:
 		if (!smu->od_enabled || !od_table || !od_settings)
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
