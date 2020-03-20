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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB30C4332E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ABE920767
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlEf+ZIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABE920767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3451B6EB53;
	Fri, 20 Mar 2020 18:27:59 +0000 (UTC)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FD0B6EB53
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 18:27:58 +0000 (UTC)
Received: by mail-pf1-x442.google.com with SMTP id h72so1501270pfe.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C5MeYhnRNYP/JIkR8V1kPS6Np0qTCzWadRIkL5In0Zc=;
 b=GlEf+ZIwHfg8spn3iZq3+pZGTXn2aUGt3E1JyN6isjwUTDUd8owFE/cwYpDGW+IePJ
 nbobo1adyvJJnIOysKkIBAqYplDCIhvpz9q9tOfaexDT08jB5Msk8IZ0UqQ5ccb7W+pk
 T2Api+U9YXbFbXGk5CkM3HalYfdDZUH+N2pfxzZBxSxUJnLB2Me9YEEFVr3mmJpOE5jy
 G49C7SfgF2nbyjnsbfoG4I6oYsy3jNtI6QaCWV9aYtyHKztxdlp3WisJHfoAW3BPsDE3
 rFFuVljdzmubgT1Qh3j6YBWYsDKEkmeV28E7ZHwhRf5W9950ZU8gLVqlGYrnibx0jjjU
 Tw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C5MeYhnRNYP/JIkR8V1kPS6Np0qTCzWadRIkL5In0Zc=;
 b=rm/iCLO52cyzLqhdgX+HRurnu/9N8w3a/nP9AL/mtrvIi3V4rxj33DQyBkUrdEUYQI
 6hcnam3bSS+KbWu3iwte28YYKNFVr4jQdchztxSBVZ5g+LgPHl6s9nQx61iZkiTsLKuY
 Lw1qDnKM0V5NfTG7irP0gVeJsT/p6uT0DOUy8mYONdLGQecbX1qWjbCGh6cGzcg1GxFj
 6BjijU908GwDNGrxOQUzWxmbD7EOtydyXM8X2TCt4aTnAYQ/L0fxHAaCguOiFRAVNKXc
 vu4RDMVRnLVKuuai31HmKRCJ1LmDsBuD8dpuR2OCO22ojCji6EyhL0Ki39qCrvzU955d
 O+vQ==
X-Gm-Message-State: ANhLgQ3mr8egTEOISJFBq4M3mZV6GiWAeK+94K1AKjkCFD0v9/5IZjqT
 ngNqfo7+Wp29z1Omca22XDvbh+6l
X-Google-Smtp-Source: ADFU+vvtGYKTjoA4GutFZ4hzpXg/CQQGlMEOrNDJ2JyJRfvxhyY5tiFpPcBVPkijEJ+oFe6CdTDQzg==
X-Received: by 2002:a63:3187:: with SMTP id x129mr9569779pgx.180.1584728877639; 
 Fri, 20 Mar 2020 11:27:57 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id v185sm6233850pfv.32.2020.03.20.11.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 11:27:57 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] drm/amdgpu/swSMU: handle DC controlled by GPIO for navi1x
Date: Fri, 20 Mar 2020 14:27:25 -0400
Message-Id: <20200320182727.3805-6-alexander.deucher@amd.com>
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

Check the platform caps in the vbios pptable to decide
whether to enable automatic AC/DC transitions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c     | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 323e7e61493b..18172dfec947 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -408,6 +408,7 @@ struct smu_context
 	uint32_t smc_if_version;
 
 	bool uploading_custom_pp_table;
+	bool dc_controlled_by_gpio;
 };
 
 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index a23eaac28095..9c60b38ab53a 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -347,7 +347,6 @@ navi10_get_allowed_feature_mask(struct smu_context *smu,
 				| FEATURE_MASK(FEATURE_DS_DCEFCLK_BIT)
 				| FEATURE_MASK(FEATURE_FW_DSTATE_BIT)
 				| FEATURE_MASK(FEATURE_BACO_BIT)
-				| FEATURE_MASK(FEATURE_ACDC_BIT)
 				| FEATURE_MASK(FEATURE_GFX_SS_BIT)
 				| FEATURE_MASK(FEATURE_APCC_DFLL_BIT)
 				| FEATURE_MASK(FEATURE_FW_CTF_BIT)
@@ -391,6 +390,9 @@ navi10_get_allowed_feature_mask(struct smu_context *smu,
 	if (smu->adev->pg_flags & AMD_PG_SUPPORT_JPEG)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_JPEG_PG_BIT);
 
+	if (smu->dc_controlled_by_gpio)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ACDC_BIT);
+
 	/* disable DPM UCLK and DS SOCCLK on navi10 A0 secure board */
 	if (is_asic_secure(smu)) {
 		/* only for navi10 A0 */
@@ -525,6 +527,9 @@ static int navi10_store_powerplay_table(struct smu_context *smu)
 
 	table_context->thermal_controller_type = powerplay_table->thermal_controller_type;
 
+	if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_HARDWAREDC)
+		smu->dc_controlled_by_gpio = true;
+
 	mutex_lock(&smu_baco->mutex);
 	if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_BACO ||
 	    powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_MACO)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
