Return-Path: <SRS0=fmWI=3S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766F5C2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2020 18:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E0C206D4
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2020 18:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atywVzkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E0C206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC7926F621;
	Wed, 29 Jan 2020 18:18:03 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09CD26F620
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2020 18:18:02 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id s7so127150qvn.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2020 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5AXPKfHbVUx1xLagrAMEhZSVXTYnY+jajIWQrKyhubQ=;
 b=atywVzkpLdgV8R84h/cPehXMbf27Z1ujEqHUbIgNM0yPrBLs1MqpULiweAyGm2Du7N
 GHwzNHmWYdplusTJ7hUAvPUBPhOyrG2HKv9bgPSD81ObsCV+OejIkd6KUfag3zygOg+r
 NKBoIp3YvdsNygPs79PcIY5kT5F50x7aaEbzEBC5cdWRdOTSk4C0XP4XLLmx9UWEm2Un
 LLI59F+a0KhAfmogOSsf9LEf/FSHJKjoKyhZTUwOzuNouRopSwnNUXAC6u4mscrUP0jc
 FLpBsBkHwPt2k4KAc2pcvRthWlsHOamd+sQlurFi//DHqiwkEKvWJLL9I4Tl188bi6qp
 IxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5AXPKfHbVUx1xLagrAMEhZSVXTYnY+jajIWQrKyhubQ=;
 b=pG0pA80cLwnz6fV3k7lygA/AD7eva74/DNEiXtu4+96JEIWqGrFrzXp12ODA0UsdVP
 syNaiKihef+3W+ai7/dFeoNMhvfmEYl7wf3bX5feQUle9T90I94NTXN7mOnzKBx3Mu+O
 jVpGF7p8hunYXt2ueT5y5TJHrMq1T6dbDL3BMbxuYwg4lHZqB8Rpu+vw/6GV984Vhy+2
 uDgXtvXH7RxAE2rbU0BGBQRO74/b2RDG1jlCqad5YUlrUs74OcRyQipQLfGNiExrsRIm
 /nBjLo6CuUxNsBSHFjCNQqbQ9D9YRbTymtWsL83DUlyBYNSGev0eqKjqnQy35A2aGIwj
 LSQA==
X-Gm-Message-State: APjAAAUUF6pt7r3rnU5i/FxrydX77hd+BPBFhEJpvE2vhRxS9RHETECR
 KOHBj7yD3u5P5ecOJEsr/K1/A06V
X-Google-Smtp-Source: APXvYqwnHcGTMHCXtzooTxHkz9vm3AXy0Z8kYqbZ0KSq/NAbKRAguThcbuuwP4mkFTTm1nbsbk3qcA==
X-Received: by 2002:ad4:4e34:: with SMTP id dm20mr284980qvb.163.1580321880960; 
 Wed, 29 Jan 2020 10:18:00 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id v55sm1510114qtc.1.2020.01.29.10.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 10:18:00 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu/smu_v11_0: Correct behavior of restoring
 default tables (v2)
Date: Wed, 29 Jan 2020 13:17:52 -0500
Message-Id: <20200129181752.609344-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129181752.609344-1-alexander.deucher@amd.com>
References: <20200129181752.609344-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Matt Coffin <mcoffin13@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Matt Coffin <mcoffin13@gmail.com>

Previously, the syfs functionality for restoring the default powerplay
table was sourcing it's information from the currently-staged powerplay
table.

This patch adds a step to cache the first overdrive table that we see on
boot, so that it can be used later to "restore" the powerplay table

v2: sqaush my original with Matt's fix

Bug: https://gitlab.freedesktop.org/drm/amd/issues/1020
Signed-off-by: Matt Coffin <mcoffin13@gmail.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  7 +++++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  6 ++++
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c    | 28 ++++++-------------
 4 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index b0591a8dda41..1e33c3e9b98d 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -273,6 +273,7 @@ struct smu_table_context
 	uint8_t                         thermal_controller_type;
 
 	void				*overdrive_table;
+	void                            *boot_overdrive_table;
 };
 
 struct smu_dpm_context {
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index d2d45181ae23..26cfccc57331 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2063,6 +2063,13 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
 			return ret;
 		od_table->UclkFmax = input[1];
 		break;
+	case PP_OD_RESTORE_DEFAULT_TABLE:
+		if (!(table_context->overdrive_table && table_context->boot_overdrive_table)) {
+			pr_err("Overdrive table was not initialized!\n");
+			return -EINVAL;
+		}
+		memcpy(table_context->overdrive_table, table_context->boot_overdrive_table, sizeof(OverDriveTable_t));
+		break;
 	case PP_OD_COMMIT_DPM_TABLE:
 		navi10_dump_od_table(od_table);
 		ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, true);
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 02f8c9cb89d9..0dc49479a7eb 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1882,6 +1882,12 @@ int smu_v11_0_set_default_od_settings(struct smu_context *smu, bool initialize,
 			pr_err("Failed to export overdrive table!\n");
 			return ret;
 		}
+		if (!table_context->boot_overdrive_table) {
+			table_context->boot_overdrive_table = kmemdup(table_context->overdrive_table, overdrive_table_size, GFP_KERNEL);
+			if (!table_context->boot_overdrive_table) {
+				return -ENOMEM;
+			}
+		}
 	}
 	ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, true);
 	if (ret) {
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 38febd5ca4da..4ad8d6c14ee5 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -1706,22 +1706,11 @@ static int vega20_set_default_od_settings(struct smu_context *smu,
 	struct smu_table_context *table_context = &smu->smu_table;
 	int ret;
 
-	if (initialize) {
-		if (table_context->overdrive_table)
-			return -EINVAL;
-
-		table_context->overdrive_table = kzalloc(sizeof(OverDriveTable_t), GFP_KERNEL);
-
-		if (!table_context->overdrive_table)
-			return -ENOMEM;
-
-		ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
-				       table_context->overdrive_table, false);
-		if (ret) {
-			pr_err("Failed to export over drive table!\n");
-			return ret;
-		}
+	ret = smu_v11_0_set_default_od_settings(smu, initialize, sizeof(OverDriveTable_t));
+	if (ret)
+		return ret;
 
+	if (initialize) {
 		ret = vega20_set_default_od8_setttings(smu);
 		if (ret)
 			return ret;
@@ -2778,12 +2767,11 @@ static int vega20_odn_edit_dpm_table(struct smu_context *smu,
 		break;
 
 	case PP_OD_RESTORE_DEFAULT_TABLE:
-		ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, false);
-		if (ret) {
-			pr_err("Failed to export over drive table!\n");
-			return ret;
+		if (!(table_context->overdrive_table && table_context->boot_overdrive_table)) {
+			pr_err("Overdrive table was not initialized!\n");
+			return -EINVAL;
 		}
-
+		memcpy(table_context->overdrive_table, table_context->boot_overdrive_table, sizeof(OverDriveTable_t));
 		break;
 
 	case PP_OD_COMMIT_DPM_TABLE:
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
