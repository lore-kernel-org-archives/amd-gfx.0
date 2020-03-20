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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF83C4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE5BC20767
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQ+td6ig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5BC20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AA206EB5B;
	Fri, 20 Mar 2020 18:28:01 +0000 (UTC)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAED96EB58
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 18:27:59 +0000 (UTC)
Received: by mail-pl1-x643.google.com with SMTP id h11so2862445plk.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 11:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FIiBbajPtIfeuTXp1G9yc2iN8rglx2tZoLKehUoegGE=;
 b=SQ+td6igrSM3Qm7jY4TpLA+hW7+S1zvEFLyUhGxjtWZGrjsYOMeWA4BWWIKCAFpOfp
 dp37EpMrOEUdkWCwEuxEQLk6+tSttQTT9qnxg3m6XBYyON6zfF2HlvljrwynscNzddCG
 N5xON0xwI2t3BjGeuqGoUGP2KboNoo+0EFe9+j1OtLvOF025QPjxSD8LQb+jJ9EXjNk3
 id8d9WDgavGeU/vLAxHv2QYB5uHVG9gSh06AZiI6Zzpc+8nOB++mBj+uUVr5MZwNrmEw
 InRTmK4AIW+9wB+af74ZXr8HWNYK4cKLsmkFuhGMJ/GRqDgSfs6X2SLcyAu5ql4LipIV
 4hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FIiBbajPtIfeuTXp1G9yc2iN8rglx2tZoLKehUoegGE=;
 b=tGBVNnd0z59Z7wLc8uy78DxTYBOzyaIms54OidVi0UEw8g0+JiGq1bpLo4GK1RmpXb
 fukbmrL4/CusVtvGd9kR5cOZdPcwmQorOD0JUTwNtibFUiUDg2eAJWOFUeqzaS0Hxkn9
 dqfjAZLcHevKf+RYFjS4ZA1nMZ3pq7TBnLsvY81yeHPxQnOc3iVpVKBS+kablZ+5o4WA
 6Ox49zOnNQG/dQ5KeTAOCD8owSh6i+SGjxLSxvi1QCCv5Gres0dpwUHeJ1fsz//K9ZUb
 U5Hdi7i211QBT4CvTGrrad4bJll8PvEiXOm1HZG09B0lIJ6gWWbd4AKUSsQa9Uug90Oy
 0MbQ==
X-Gm-Message-State: ANhLgQ0R0j4ivcY22vtMFA7JiTNlRUA9GVt9r67lMKsz4L2YE91syTun
 eyMiuEayGxSoZZ/NGJXreMN/5Gt6
X-Google-Smtp-Source: ADFU+vsS9pHMJAFgVuYY32mKrYu1WeliVWmL4afkIAHdQBIL2ej2CcZD3HtwuQ3zKqM/7sTOJ/QSXg==
X-Received: by 2002:a17:902:8b8a:: with SMTP id
 ay10mr9979142plb.288.1584728879039; 
 Fri, 20 Mar 2020 11:27:59 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id v185sm6233850pfv.32.2020.03.20.11.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 11:27:58 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/8] drm/amdgpu/swSMU: handle manual AC/DC notifications
Date: Fri, 20 Mar 2020 14:27:26 -0400
Message-Id: <20200320182727.3805-7-alexander.deucher@amd.com>
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

For boards that do not support automatic AC/DC transitions
in firmware, manually tell the firmware when the status
changes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        |  3 +++
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 23 +++++++++++++++++++
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index bc3cf04a1a94..f197f1be0969 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -92,6 +92,9 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 		if (adev->powerplay.pp_funcs->enable_bapm)
 			amdgpu_dpm_enable_bapm(adev, adev->pm.ac_power);
 		mutex_unlock(&adev->pm.mutex);
+
+		if (is_support_sw_smu(adev))
+			smu_set_ac_dc(&adev->smu);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 54d156bbc0f3..6f4015f87781 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2087,6 +2087,29 @@ int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
 	return 0;
 }
 
+int smu_set_ac_dc(struct smu_context *smu)
+{
+	int ret = 0;
+
+	/* controlled by firmware */
+	if (smu->dc_controlled_by_gpio)
+		return 0;
+
+	mutex_lock(&smu->mutex);
+	if (smu->ppt_funcs->set_power_source) {
+		if (smu->adev->pm.ac_power)
+			ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
+		else
+			ret = smu_set_power_source(smu, SMU_POWER_SOURCE_DC);
+		if (ret)
+			pr_err("Failed to switch to %s mode!\n",
+			       smu->adev->pm.ac_power ? "AC" : "DC");
+	}
+	mutex_unlock(&smu->mutex);
+
+	return ret;
+}
+
 const struct amd_ip_funcs smu_ip_funcs = {
 	.name = "smu",
 	.early_init = smu_early_init,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 18172dfec947..ae2c318dd6fa 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -720,6 +720,7 @@ int smu_get_dpm_level_range(struct smu_context *smu, enum smu_clk_type clk_type,
 enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *smu);
 int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level);
 int smu_set_display_count(struct smu_context *smu, uint32_t count);
+int smu_set_ac_dc(struct smu_context *smu);
 bool smu_clk_dpm_is_enabled(struct smu_context *smu, enum smu_clk_type clk_type);
 const char *smu_get_message_name(struct smu_context *smu, enum smu_message_type type);
 const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature_mask feature);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
