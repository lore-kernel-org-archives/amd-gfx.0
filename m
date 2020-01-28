Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5C1C2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 22:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84712467E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 22:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MccrCbKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84712467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C1C6F443;
	Tue, 28 Jan 2020 22:37:43 +0000 (UTC)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 171896F443
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 22:37:42 +0000 (UTC)
Received: by mail-io1-xd43.google.com with SMTP id m25so16343535ioo.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 14:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding;
 bh=KiGCGpTD9TbjcTKvYFRKnFLFI85eYX9RCbbtDcravmU=;
 b=MccrCbKDMgdEUP7v2M/FXa1ZUs/Fee/eexf4sYK3lOSWV/2zoLclrf0CVHsHcbcVFt
 SPda3KDFEWppACtMpNZ2z914pfBxqNfr3Iis2KUNRmtE80JhdsBkjThSkuYBK5P1brvk
 939x4KgXpWJ2IGChGsPnzlJd91ijIHDjGPYNzb/UcLyAIHusOv8uAsqVJTq2gYixmkVu
 0xnkqEdtZx7spy4rU7LMaUxbawhR5yoMJ6nwWLzKlmOfpFvknC2KREnPMBPBHo0wYDdn
 GEytjjm8hs8bElXFfrAD+KdK+KegR6rLwl8yW5+ssUulBU5CPqYpYpIl51XRJzfbB0ty
 LgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:reply-to:mime-version:content-transfer-encoding;
 bh=KiGCGpTD9TbjcTKvYFRKnFLFI85eYX9RCbbtDcravmU=;
 b=jY+QPTG3PJGkJ3WFAfgnLF+AKfGhOUu3iqurNMB6kSw3HZOWrj1XvoNBT1hj1d+/2r
 /9EymrflfqM51RxsdFMNUO8sffwFSqIrq7vBNaT01CtvImFiRyz1vHRbpOS6EMH5h2YA
 sQYHAbE9vAcyb2HLAsJmxuJUaxHrwFaNZlqAwNHfakCgqBH8Iv94OHC44YcxtuvX4L8v
 AQe8PC7UOUAwVlDpuCIUtEUH7RpPCEzRjdFj3BiYD34SVX5D4YOpMtFjw+4s2tA8X+yW
 AxQ2fimJAtvcFJjbPOPO6cRrI6wEJfZJ/uOYd82s8JnLgcKKTgLzS2GUlMl2M29DbsHU
 W+dg==
X-Gm-Message-State: APjAAAXcrlKX2ZsIRqKp0QAAFb0kYxpMmE3fHrrHwHzxbe7m1pr5VMrH
 zvmHSiGPrNefhvVN08cDL9w=
X-Google-Smtp-Source: APXvYqxFYsAbXFJLxCYzsVkUzrsOCqvCv9oDjk4atPzXb2oEStN1BdpdSMvMqUcSG+4BCF4NTnlVrg==
X-Received: by 2002:a5e:920a:: with SMTP id y10mr19020419iop.292.1580251061472; 
 Tue, 28 Jan 2020 14:37:41 -0800 (PST)
Received: from mcoffin-dev-tower.ec2.internal
 ([2602:ae:10d1:b00:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id r10sm22417iot.28.2020.01.28.14.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 14:37:41 -0800 (PST)
From: Matt Coffin <mcoffin13@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amdgpu/smu_v11_0: Correct behavior of restoring default
 tables
Date: Tue, 28 Jan 2020 15:37:18 -0700
Message-Id: <20200128223718.155252-1-mcoffin13@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <CADnq5_MEByspseDhv=ca0X7XhTDz_Uh4w6WfMovDtEydJ0snRA@mail.gmail.com>
References: <CADnq5_MEByspseDhv=ca0X7XhTDz_Uh4w6WfMovDtEydJ0snRA@mail.gmail.com>
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
Reply-To: Matt Coffin <mcoffin13@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Matt Coffin <mcoffin13@gmail.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Previously, the syfs functionality for restoring the default powerplay
table was sourcing it's information from the currently-staged powerplay
table.

This patch adds a step to cache the first overdrive table that we see on
boot, so that it can be used later to "restore" the powerplay table

Signed-off-by: Matt Coffin <mcoffin13@gmail.com>
---
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  9 +++---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  6 ++++
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c    | 28 ++++++-------------
 4 files changed, 19 insertions(+), 25 deletions(-)

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
index f60762f9b143..26cfccc57331 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2064,12 +2064,11 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
 		od_table->UclkFmax = input[1];
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
 		navi10_dump_od_table(od_table);
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
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
