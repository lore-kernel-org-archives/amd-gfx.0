Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC725C2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 20:10:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A761206F0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 20:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4RM1qy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A761206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 345586E124;
	Tue, 28 Jan 2020 20:10:42 +0000 (UTC)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E30089FF7
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 20:10:41 +0000 (UTC)
Received: by mail-io1-xd43.google.com with SMTP id n11so15883996iom.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 12:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding;
 bh=p1KeaQdpt+v7ASDWFKsv5F9vYd8AmhnHjdMnz77NzFs=;
 b=i4RM1qy5KxKdpXstkPS2eP3mwre++cVuaGWZRxZ0cVMfWQmJt+nnOtnRQ3dsbV/5fS
 UG1qFTqWFshKf6AujkBCkqzx7GNnIFGIPv0soFaa1tVMyD9A1nrVAqyB0CoH3O6Yw8nE
 xKFRWKNdRSc8kdytDD1V6Z1Lb4kAf1bvEIfMe9/6rEcnYQgS6IkJsYP5kz8oPe8Rr4G/
 WV8nmDuj+IqmrpuXr8ytetaHKCvR1wTCyLynOX5BbEP6P171YxAtXuDUFcND88P5qTl9
 ko1G1iI/mV3+zEOs7Km3wtAmMBSd7krgUau7Lg0BBBqDt6bMWttfNKX/e3f3k+6rHY85
 KCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:reply-to:mime-version:content-transfer-encoding;
 bh=p1KeaQdpt+v7ASDWFKsv5F9vYd8AmhnHjdMnz77NzFs=;
 b=LHFFMSEFQm4SYtJQ+jpVt9lFTCg9NIBybgL9zQGSghd/c0qolINIdUU6PmLGOREJZg
 4yQdO6Cn/bulvTAfL6//IQxryxdizEiciin3daRryeXGfgR+81i+2JZTWyPcXeowN0Pa
 hv7NYoqpIrlL+yFMDgL74eMqeW0ODqhl0bcnX3idyPYEPSxFwQwNVb/AHXbkCAkKxuCl
 qC54wbmd8GE/bfUVl6M9Xm7ytMt8g19FA4TWpWs77W9hxKLS7P6G5xyBebNSJ+jwHziR
 GquILc/RGrUORsCEgDl3CgCkff8h4uWWDVVgaEJJmrM9eVK/Qx/cOKvzBS+MV4wYyFOU
 hG/Q==
X-Gm-Message-State: APjAAAW1ukNrXsLrst+i/wKjuQCi/cvt82FAFhk8D8+UfHcPyuYu3Kyf
 9vLeAQbswjvqn71TKbzSG4o=
X-Google-Smtp-Source: APXvYqxemM9cDQ10lX/O1ia5ZPOtpsVBHXGxN5PItq9cDISFfJ0CpxdqxIt+SnBTN5W1sNAH96MpFQ==
X-Received: by 2002:a05:6602:2346:: with SMTP id
 r6mr19349081iot.133.1580242240885; 
 Tue, 28 Jan 2020 12:10:40 -0800 (PST)
Received: from mcoffin-dev-tower.ec2.internal
 ([2602:ae:10d1:b00:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id 16sm4658576ioe.84.2020.01.28.12.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 12:10:40 -0800 (PST)
From: Matt Coffin <mcoffin13@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amdgpu/smu_v11_0: Correct behavior of restoring default
 tables
Date: Tue, 28 Jan 2020 13:10:09 -0700
Message-Id: <20200128201009.90607-1-mcoffin13@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <f63fecc3-fd56-55cb-4bcf-178ead1628d6@gmail.com>
References: <f63fecc3-fd56-55cb-4bcf-178ead1628d6@gmail.com>
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
