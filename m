Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3A7C678DB
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Mar 2023 23:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C96F310E05F;
	Sat,  4 Mar 2023 23:45:28 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACCA810E05F
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Mar 2023 23:45:26 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id i9so8180149lfc.6
 for <amd-gfx@lists.freedesktop.org>; Sat, 04 Mar 2023 15:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1677973525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3yLK0XTeDWpVK2ZzznVyMabq/y4vJTMP6Hb1/1uKVxw=;
 b=Umb+r74g8oTnbaFXv4ed+mBTw14f7O/lBjKTGBIcxhC+8KmMptxp0WwV1cb3wYr/Yg
 YTDFnmXWdMKBN75UrEQuU9nMGsABSzZI3Mll8xMq9LRDvTLpoPG9uRrSoYOzDO3CuN7k
 WKaoFXJcVhLplPKW/RmeOA4B6xOXAV0TVkxGjfU8B/2rAx3YYqfxle9oSeedVs4KFecy
 +oEBCgbOCaM6Bsgi+NaP3+Pk6FeW0oJ4BpPMe1J5fnnDez9mY48lWChytTdUoLOeK7f8
 4Co6qghbD5rfsHwCzxiRaO+roFGyEjm2v8oUepEo3igdWoO9A/N4k7t8ezgsCtpUJ0Lh
 YxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677973525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3yLK0XTeDWpVK2ZzznVyMabq/y4vJTMP6Hb1/1uKVxw=;
 b=WhpNgP3ODY+xMprKEG4RSlqZWGVLsUM2R1wKNs7f+iiVbKnoNZ993CwuDAs6baQcMS
 9n0SvRuDTCjFS4pFV4UfH7aMMO/yZQikdppMt1Jik4G/TBukmtlywAoj6Gv9Tt/KFwhA
 AT4/00ij+j0nBlKo3MO3ro4AOma8n0durlkrWxTjHL2IYtjKepBPl+AyBZvbGqUsQFC9
 T5x7QUwRacsordcI+z4d2l1oG6GRoS1Npce/G7LmYeHBGdRqfF2MTHZ6xdK8k19r3KEM
 Si7ji1HftQIgHdVnW4J3E8GUE9V68Ks6VYgdh3oTqjA/NaRtFKFMHjEIqJbxvY4xEgK8
 cISg==
X-Gm-Message-State: AO0yUKVCr72rQdJlIJqsf7skngXf1WliWoCUUrrgBLBnBHxULAk4EdcL
 buVCIFV3QHEFiMoCnxqPBLjaMIJ49p8Emg==
X-Google-Smtp-Source: AK7set8bRFTil2r6F4srMuI6MeM8mAoeIlvBQmcnGEHojywFV3c73JfJSDmedt+UTLtUKOwE6M5JRQ==
X-Received: by 2002:ac2:533c:0:b0:4dd:9aec:e468 with SMTP id
 f28-20020ac2533c000000b004dd9aece468mr1925684lfh.58.1677973524721; 
 Sat, 04 Mar 2023 15:45:24 -0800 (PST)
Received: from localhost.localdomain (pc-201-96-67-156-static.strong-pc.com.
 [156.67.96.201]) by smtp.gmail.com with ESMTPSA id
 a12-20020ac2520c000000b004db4f2f08f7sm982756lfl.28.2023.03.04.15.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Mar 2023 15:45:24 -0800 (PST)
From: =?UTF-8?q?B=C5=82a=C5=BCej=20Szczygie=C5=82?= <mumei6102@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amd/pm: Fix sienna cichlid incorrect OD volage after
 resume
Date: Sun,  5 Mar 2023 00:44:31 +0100
Message-Id: <20230304234431.29507-1-mumei6102@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230304142035.37615-1-mumei6102@gmail.com>
References: <20230304142035.37615-1-mumei6102@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?q?B=C5=82a=C5=BCej=20Szczygie=C5=82?= <mumei6102@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Always setup overdrive tables after resume. Preserve only some
user-defined settings in user_overdrive_table if they're set.

Copy restored user_overdrive_table into od_table to get correct
values.

Signed-off-by: Błażej Szczygieł <mumei6102@gmail.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 43 ++++++++++++++-----
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 697e98a0a20a..75f18681e984 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2143,16 +2143,9 @@ static int sienna_cichlid_set_default_od_settings(struct smu_context *smu)
 		(OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
 	OverDriveTable_t *user_od_table =
 		(OverDriveTable_t *)smu->smu_table.user_overdrive_table;
+	OverDriveTable_t user_od_table_bak;
 	int ret = 0;
 
-	/*
-	 * For S3/S4/Runpm resume, no need to setup those overdrive tables again as
-	 *   - either they already have the default OD settings got during cold bootup
-	 *   - or they have some user customized OD settings which cannot be overwritten
-	 */
-	if (smu->adev->in_suspend)
-		return 0;
-
 	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE,
 				   0, (void *)boot_od_table, false);
 	if (ret) {
@@ -2163,7 +2156,23 @@ static int sienna_cichlid_set_default_od_settings(struct smu_context *smu)
 	sienna_cichlid_dump_od_table(smu, boot_od_table);
 
 	memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
-	memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
+
+	/*
+	 * For S3/S4/Runpm resume, we need to setup those overdrive tables again,
+	 * but we have to preserve user defined values in "user_od_table".
+	 */
+	if (!smu->adev->in_suspend) {
+		memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
+		smu->user_dpm_profile.user_od = false;
+	} else if (smu->user_dpm_profile.user_od) {
+		memcpy(&user_od_table_bak, user_od_table, sizeof(OverDriveTable_t));
+		memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
+		user_od_table->GfxclkFmin = user_od_table_bak.GfxclkFmin;
+		user_od_table->GfxclkFmax = user_od_table_bak.GfxclkFmax;
+		user_od_table->UclkFmin = user_od_table_bak.UclkFmin;
+		user_od_table->UclkFmax = user_od_table_bak.UclkFmax;
+		user_od_table->VddGfxOffset = user_od_table_bak.VddGfxOffset;
+	}
 
 	return 0;
 }
@@ -2373,6 +2382,20 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
 	return ret;
 }
 
+static int sienna_cichlid_restore_user_od_settings(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	OverDriveTable_t *od_table = table_context->overdrive_table;
+	OverDriveTable_t *user_od_table = table_context->user_overdrive_table;
+	int res;
+
+	res = smu_v11_0_restore_user_od_settings(smu);
+	if (res == 0)
+		memcpy(od_table, user_od_table, sizeof(OverDriveTable_t));
+
+	return res;
+}
+
 static int sienna_cichlid_run_btc(struct smu_context *smu)
 {
 	int res;
@@ -4400,7 +4423,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.set_default_od_settings = sienna_cichlid_set_default_od_settings,
 	.od_edit_dpm_table = sienna_cichlid_od_edit_dpm_table,
-	.restore_user_od_settings = smu_v11_0_restore_user_od_settings,
+	.restore_user_od_settings = sienna_cichlid_restore_user_od_settings,
 	.run_btc = sienna_cichlid_run_btc,
 	.set_power_source = smu_v11_0_set_power_source,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-- 
2.39.2

