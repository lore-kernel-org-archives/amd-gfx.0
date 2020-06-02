Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5E4C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 19:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5497206E2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 19:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwKJ5BIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5497206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 732256E456;
	Tue,  2 Jun 2020 19:10:22 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 594886E456
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 19:10:21 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id w1so13667693qkw.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aXJOXizLm8sM6eic15c19KlFV1U2t6ZFHD8yw28Aqtg=;
 b=NwKJ5BIA9c00zjwLrzK+GU44e3iWNL+npntmGXpY5GbDZxiZMdmE3EdfjG3ZGsQezx
 QW/YGGWt6AWMyVHlxmyXZbLoLt1OC7XRSOUYHCcRxHc9VxsdRIbkHhtmMI+UN2YLcOgJ
 qw6Xred/exLuW79q36zTXUa+/xOa+VEX9WmI9/HQbEevWmNfLrm16gr9PMIxf/ufJ6H0
 NIMIhTOCY6okTQWPGQ0XMBK4zBURdKStyabFbZRHfPNWghI9IEm3Cf40fRAifYu8wV2f
 p2ueMpwI/ZjW/mQFtGluTpKCD+AQuFQ8D24yr90g10dxCk4eIFbBSobLgTewsKMLRKjf
 qQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aXJOXizLm8sM6eic15c19KlFV1U2t6ZFHD8yw28Aqtg=;
 b=ntDQVhyCGC2ar6a5wN7pl6tL42o/7sYAFzidNc2R5aBmBIUciF6NSHKJ250mAOtPxz
 fkZpNsOQHy7n3GkhzRj8KyZ8g4W0XeCW/Xg+MdcpbALpnxRPAp3am3ySV/YafOp3GgE2
 DvusrzQhPFC2O5g9T2VfNSh1W8/ni2Zz8vfw3HDfexkW9UCNXVX3VBNLwqAe1f0XSS9N
 P3+qIXkU3PjABORMGA9f6B++aAjyKFp6aaT/vdfT3s77OkghfPXqIObM9Xkkxsbub+cp
 nITim24F2NWCCUzRXnIDmbo6l9+NiOwARa6w922TQpmdULZVVhS9we1cw5YZozEURoj+
 qxgA==
X-Gm-Message-State: AOAM532p2VnnpB8kXzPYSOdx2QoJIhwqLY3Sywp372ETERwCyKz5HWNo
 arqHUKdDZ0gF+lFgrtW7TsUqF5a7
X-Google-Smtp-Source: ABdhPJxAce/pqv3YACMUR19sEtlNftC0n+RexqJv4nx9Q6wyM8405fSlbO5ixBGXEHW/NR/Hn+BlQw==
X-Received: by 2002:a37:9d4d:: with SMTP id g74mr25178808qke.159.1591125020179; 
 Tue, 02 Jun 2020 12:10:20 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id k17sm3692356qtb.5.2020.06.02.12.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 12:10:19 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/[radeon|amdgpu]: Replace one-element array and
 use struct_size() helper"
Date: Tue,  2 Jun 2020 15:10:13 -0400
Message-Id: <20200602191013.1346247-1-alexander.deucher@amd.com>
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

This reverts commit 4dea25853a6c0c16e373665153bd9eb6edc6319e.

This changes structs used by the hardware and breaks dpm on some cards.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si_dpm.c       | 5 +++--
 drivers/gpu/drm/amd/amdgpu/sislands_smc.h | 2 +-
 drivers/gpu/drm/radeon/si_dpm.c           | 5 +++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
index 0fc56c5bac08..c00ba4b23c9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -5715,9 +5715,10 @@ static int si_upload_sw_state(struct amdgpu_device *adev,
 	int ret;
 	u32 address = si_pi->state_table_start +
 		offsetof(SISLANDS_SMC_STATETABLE, driverState);
+	u32 state_size = sizeof(SISLANDS_SMC_SWSTATE) +
+		((new_state->performance_level_count - 1) *
+		 sizeof(SISLANDS_SMC_HW_PERFORMANCE_LEVEL));
 	SISLANDS_SMC_SWSTATE *smc_state = &si_pi->smc_statetable.driverState;
-	size_t state_size = struct_size(smc_state, levels,
-					new_state->performance_level_count);
 
 	memset(smc_state, 0, state_size);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sislands_smc.h b/drivers/gpu/drm/amd/amdgpu/sislands_smc.h
index a089dbf8f7a9..d2930eceaf3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sislands_smc.h
+++ b/drivers/gpu/drm/amd/amdgpu/sislands_smc.h
@@ -186,7 +186,7 @@ struct SISLANDS_SMC_SWSTATE
     uint8_t                             levelCount;
     uint8_t                             padding2;
     uint8_t                             padding3;
-    SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
+    SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[1];
 };
 
 typedef struct SISLANDS_SMC_SWSTATE SISLANDS_SMC_SWSTATE;
diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index bab01ca864c6..a167e1c36d24 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -5253,9 +5253,10 @@ static int si_upload_sw_state(struct radeon_device *rdev,
 	int ret;
 	u32 address = si_pi->state_table_start +
 		offsetof(SISLANDS_SMC_STATETABLE, driverState);
+	u32 state_size = sizeof(SISLANDS_SMC_SWSTATE) +
+		((new_state->performance_level_count - 1) *
+		 sizeof(SISLANDS_SMC_HW_PERFORMANCE_LEVEL));
 	SISLANDS_SMC_SWSTATE *smc_state = &si_pi->smc_statetable.driverState;
-	size_t state_size = struct_size(smc_state, levels,
-					new_state->performance_level_count);
 
 	memset(smc_state, 0, state_size);
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
