Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4936DC4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A66020767
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXk8WhBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A66020767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D127C6E20E;
	Fri, 20 Mar 2020 18:27:58 +0000 (UTC)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE916EB4A
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 18:27:56 +0000 (UTC)
Received: by mail-pj1-x1043.google.com with SMTP id v13so2880151pjb.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 11:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C4mDazLGVR/Bl+O30p+KaF8++0MH2XyP+um5+TUv0XU=;
 b=lXk8WhByaFNvfCN+K717epGRSjKqPr35jj5JrIgmZ90EhyNu7NOJhd+3DRDkV0XYMl
 7AO3TFlbygvNRkAZYkCG0PyOPzDDL3/dCkYUzLTN2KOv7SdOJqnXEobsE8Hht1qk4yDy
 eIIFQi1wzHWS/fqKD7xTwGE/Tmvof0eBmby5UtTkQFBnV+uBIwC11xm2yDDjzm0FkTwF
 IYW2+VkPy/vqs6afUPhEuMWCKYPT97qOZ69f64aYAaXTNfA2OCIUNIMuWenY38JS5Lgu
 vIkGVQ90Dprtz/bC5HXl1s+RK2gXNnaxZv/5RLy4SBY2ycEm7G5jAjRmiYgvITNBfHxb
 0VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C4mDazLGVR/Bl+O30p+KaF8++0MH2XyP+um5+TUv0XU=;
 b=RwKlAcmQuG8iUuqwPKpz/bxTnUPxw8sgnrFniadFduAc33kuPZgN3UYWzXnQVUpJtl
 lOaj75W/shH+54y1P+93oK72TSen2CVRjkaTT6KuJXU/cyiuxtuJJAHsnE65xhr38MxJ
 Abi0Nmm/bT+7FOHFJSZwOAG52FPnG09qD2jqDSsTq+kW6S7dGnOoD36WuH1/7GNJdI03
 gEPH1CRpCUmwFO4vZnqcd91W5G+mgPp2NwkkSzc4UBCehkknQTT8wPBaAzCu/2Nq/iqN
 A00Hwf/xmBKIi3ShogOdUWl3Spmitjn61fm6Hm+LXQzXvE+bTxXxgpXBY8cKzogRTDeZ
 Pm8g==
X-Gm-Message-State: ANhLgQ3QcxV+1YBTrWfJR2mAAEkJNCAbGhQ2KdiQffPzDPWFepdPshP+
 iqBdJQlaDlzEUhf8qXIuj2UmJk4D
X-Google-Smtp-Source: ADFU+vvI5Nj91RfAPfzMDUL+wpe5KehdqFOdggjI4aqzJNeKy3SexhexRW2cbi+p+RSJbZW0fl6pYg==
X-Received: by 2002:a17:902:a411:: with SMTP id
 p17mr9797783plq.157.1584728876254; 
 Fri, 20 Mar 2020 11:27:56 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id v185sm6233850pfv.32.2020.03.20.11.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 11:27:55 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] drm/amdgpu/swSMU: set AC/DC mode based on the current
 system state
Date: Fri, 20 Mar 2020 14:27:24 -0400
Message-Id: <20200320182727.3805-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320182727.3805-1-alexander.deucher@amd.com>
References: <20200320182727.3805-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mcoffin13@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check of the pointer exists and we are actually on AC power.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 2cfb911ab370..54d156bbc0f3 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1155,15 +1155,15 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 			}
 		}
 
-		if (adev->asic_type >= CHIP_NAVI10 &&
-		    adev->asic_type <= CHIP_NAVI12) {
+		if (smu->ppt_funcs->set_power_source) {
 			/*
 			 * For Navi1X, manually switch it to AC mode as PMFW
 			 * may boot it with DC mode.
-			 * TODO: should check whether we are indeed under AC
-			 * mode before doing this.
 			 */
-			ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
+			if (adev->pm.ac_power)
+				ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
+			else
+				ret = smu_set_power_source(smu, SMU_POWER_SOURCE_DC);
 			if (ret) {
 				pr_err("Failed to switch to AC mode!\n");
 				return ret;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
