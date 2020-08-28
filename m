Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B4AC433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 17:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453822098B
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 17:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5dqjmc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453822098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18AA46E503;
	Fri, 28 Aug 2020 17:59:05 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A83246E503
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 17:59:03 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id k18so101874qtm.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 10:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tYr+CuIqMACsGLjRgUJ8fDfNmHqZqhp4YW8uDoEnrjM=;
 b=l5dqjmc4lASr2kbhg5OzOoxetrNw5gHYqZ4YfRbs7nCMJn3NuBHsn6sw7PiFTyd9xy
 jjJCCWPjmdKCHV+/88wC87ALjBCr/xZT4nUuzzcVvTTySaCopQk7z3i9mXglcvjJfM/w
 dX8fsqwcrOXttRF0QFfWgnIsvOvIfdlAwK6DEOyyFP0u/5rdNNz5A/f4zuonco/1bbXW
 aRqnv9sUApvJBpQ+Bj66Agu1u1O/K1TCoS9evJm5mVdBYWVlJRWGbxtyyo0VzNKoT6bw
 RozYW1ualJH2/umzOKUHkcLXCNSwrQev90r3e3ym1+S7NthWx9WyReSHNhwgBF23S6mB
 TUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tYr+CuIqMACsGLjRgUJ8fDfNmHqZqhp4YW8uDoEnrjM=;
 b=coC9jnE+fbjRCGeN4zUic6/MFwMRZDNrFPcB1SzFzchwGVkwrKZx1hUG4m+UMi1bhW
 HIrDh1UEp9Mwc07r0q9z1dX80dDaftuqa78FY49oquEnv9Qyq3k3OS8S8mZ0gUDKyfMq
 4avpr6mNvy0+xPZFTMq0JB5eMsduGE1aAJ9nWOhFqOcIVp/uOZEYRl0AymhRro9RMhsN
 QgBoxheKFK6jkM6DOff0EwhQvgVBEVA2zkg62DSRbS8BfgmgGV1MMpovfIyhy7l/YGnJ
 MYU6VZQC2LSv8ValDeXicuw2p9b8PLN1Dyk8rZMD2BCE4w7WWH/zHyFqVfQySEG2W7sa
 d9SA==
X-Gm-Message-State: AOAM530NMRysLvfI7aeNZWSyBVUgz0bME145f730QyWWdCys+MJIjE8v
 rhJouCyyeFcQHs9PsJKodw/u9Sdt/zM=
X-Google-Smtp-Source: ABdhPJzKZDpLcC/qoYHaL80j2uadozCipHLYQTM9xY0rFDitgciJxCQmAJvZpxdtJ832X9kTHT5AUA==
X-Received: by 2002:aed:2907:: with SMTP id s7mr2480868qtd.321.1598637542612; 
 Fri, 28 Aug 2020 10:59:02 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id x28sm1278129qki.55.2020.08.28.10.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:59:02 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amdgpu/swsmu: add new callback for getting fan
 parameters
Date: Fri, 28 Aug 2020 13:58:48 -0400
Message-Id: <20200828175853.2378523-1-alexander.deucher@amd.com>
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

To fetch the max rpm from pptable.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     | 4 ++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c   | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 4c5c041af4ee..787fc682e0a5 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -452,6 +452,9 @@ struct smu_context
 
 	struct work_struct throttling_logging_work;
 	atomic64_t throttle_int_counter;
+
+	unsigned fan_max_rpm;
+	unsigned manual_fan_speed_rpm;
 };
 
 struct i2c_adapter;
@@ -598,6 +601,7 @@ struct pptable_funcs {
 	int (*enable_mgpu_fan_boost)(struct smu_context *smu);
 	int (*gfx_ulv_control)(struct smu_context *smu, bool enablement);
 	int (*deep_sleep_control)(struct smu_context *smu, bool enablement);
+	int (*get_fan_parameters)(struct smu_context *smu);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8462b30f4fe3..114e85613e24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -504,6 +504,8 @@ static int smu_late_init(void *handle)
 
 	smu_get_unique_id(smu);
 
+	smu_get_fan_parameters(smu);
+
 	smu_handle_task(&adev->smu,
 			smu->smu_dpm.dpm_level,
 			AMD_PP_TASK_COMPLETE_INIT,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index c88f8fab1bae..38c10177ed21 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -94,6 +94,7 @@
 #define smu_set_pp_feature_mask(smu, new_mask)				smu_ppt_funcs(set_pp_feature_mask, 0, smu, new_mask)
 #define smu_gfx_ulv_control(smu, enablement)				smu_ppt_funcs(gfx_ulv_control, 0, smu, enablement)
 #define smu_deep_sleep_control(smu, enablement)				smu_ppt_funcs(deep_sleep_control, 0, smu, enablement)
+#define smu_get_fan_parameters(smu)					smu_ppt_funcs(get_fan_parameters, 0, smu)
 
 #endif
 #endif
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
