Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F391C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD0F2077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvCB4S8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD0F2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA466E286;
	Mon,  1 Jun 2020 18:03:49 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CAFD6E28E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:47 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id z9so437423qvi.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3PpJ1h94fZBn6KpSE2N6e1JAcrrTM66QSq7NPMVTW9Y=;
 b=OvCB4S8ENXtLNge1doFWE6bLmbr10vsPgJqUIJhOlnLxDUAyud/u1DoJDnTMH7si8H
 vlNV2r7PJ59NEQk/otUjnN/dn16AaP0xC78w4hBAZ2yZJLO3S+x8aSepzD1VRRhd52i7
 m0U9pxpr75QzCVj3GpmJvzDkXA7N46jjbCep9d4sbW333ZV+kRSo6wPM1k9AE9vHuASw
 sXOkX3/3SooFtE6cu0yrDGPZ+hWt8LjseYIw6f6WE0aJA4rP3u3F025+E0mokFLyp8EM
 lv39QvMw2y8bpoxtS1pQfuX+hJStyXqiXeI0jUQrC6/bAS28ywz/A0o82SQb57pinYsF
 I7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3PpJ1h94fZBn6KpSE2N6e1JAcrrTM66QSq7NPMVTW9Y=;
 b=SvVCn4J7v3vptsFtG/6pBv/iQ3jlDTTcEdavf2Iu5nKe+xukM5yU1Ie8x0mJBnO1QE
 XJTTmhh3CSNVdqrPcnuXYN+3b6KQYiWTLTKZiHDWKabHIFYvE7T84eLdajJ49sMFmJRS
 eMmsl+KGgUMoueK4qPiVuAEuHx+LzafHNuKU+oavM2Np35bp9dJPXxdPAVzSt4k7h5Rr
 tiZNz2Jz/Njtl+q1RyhpgBZz0LmZSi0cP7/Hp/WhXu5Bo46qMdrNR6bumDRdvESuWBV1
 l0/u5ON5wDxG9Lhn5c24WyLl94/XJTxuI2Fu2Ul8CTVos3BzFrd5rgqU7K+XTwmpjuOn
 Ricg==
X-Gm-Message-State: AOAM532ijZrVuIkWqBDSogzhFPrmua1ORhmg1rJSP5mjNmhNZ8/n85/3
 nZxPcwKm7KSIE/t2KyMYDTKFqVWN
X-Google-Smtp-Source: ABdhPJy92txHWK0gEuZNMIFvB7j5KYK1BgXoX5FTt4avt47HuOVNKz6/4o3CfQokdlYsxTluOW5Qpw==
X-Received: by 2002:ad4:4c0d:: with SMTP id
 bz13mr22847157qvb.164.1591034626454; 
 Mon, 01 Jun 2020 11:03:46 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:46 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 042/207] drm/amd/powerplay: support to get power index for
 sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:54 -0400
Message-Id: <20200601180239.1267430-39-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add function to get smu power index for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 21 +++++++++++++++++++
 .../drm/amd/powerplay/sienna_cichlid_ppt.h    |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 5e98f471297b..8b59b2aba94a 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -176,6 +176,11 @@ static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_table_map[SMU_TABLE_COUNT
 	TAB_MAP(PACE),
 };
 
+static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
+	PWR_MAP(AC),
+	PWR_MAP(DC),
+};
+
 static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT,	WORKLOAD_PPLIB_DEFAULT_BIT),
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,		WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
@@ -246,6 +251,21 @@ static int sienna_cichlid_get_smu_table_index(struct smu_context *smc, uint32_t
 	return mapping.map_to;
 }
 
+static int sienna_cichlid_get_pwr_src_index(struct smu_context *smc, uint32_t index)
+{
+	struct smu_11_0_cmn2aisc_mapping mapping;
+
+	if (index >= SMU_POWER_SOURCE_COUNT)
+		return -EINVAL;
+
+	mapping = sienna_cichlid_pwr_src_map[index];
+	if (!(mapping.valid_mapping)) {
+		return -EINVAL;
+	}
+
+	return mapping.map_to;
+}
+
 static int sienna_cichlid_get_workload_type(struct smu_context *smu, enum PP_SMC_POWER_PROFILE profile)
 {
 	struct smu_11_0_cmn2aisc_mapping mapping;
@@ -2185,6 +2205,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_smu_clk_index = sienna_cichlid_get_smu_clk_index,
 	.get_smu_feature_index = sienna_cichlid_get_smu_feature_index,
 	.get_smu_table_index = sienna_cichlid_get_smu_table_index,
+	.get_smu_power_index = sienna_cichlid_get_pwr_src_index,
 	.get_workload_type = sienna_cichlid_get_workload_type,
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.h b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.h
index bc04ae326990..8078886e4cbc 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.h
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.h
@@ -23,6 +23,12 @@
 #ifndef __SIENNA_CICHLID_PPT_H__
 #define __SIENNA_CICHLID_PPT_H__
 
+typedef enum {
+  POWER_SOURCE_AC,
+  POWER_SOURCE_DC,
+  POWER_SOURCE_COUNT,
+} POWER_SOURCE_e;
+
 extern void sienna_cichlid_set_ppt_funcs(struct smu_context *smu);
 
 #define smnPCIE_LC_SPEED_CNTL                   0x11140290
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
