Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F03BC64EC4
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Mar 2023 14:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EE6510E046;
	Sat,  4 Mar 2023 14:22:04 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2E3C10E046
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Mar 2023 14:22:02 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id d36so3979363lfv.8
 for <amd-gfx@lists.freedesktop.org>; Sat, 04 Mar 2023 06:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1677939721;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gP8y+ZGSB3tYy5lkcicAQOotbZtTMnefx+SEzepkXec=;
 b=X9eMRKWtCGyT/OKF2IlOKpJc3PAx+sq5eMluJnaRKccLpkr4oC/azAUUykmPbO+zcV
 xW/pS114kHBwN7eS119IAe7MEbUO2UNhiMVn+x2G1s+e9h4ZV/ZdJA/v59YapH+A9vMe
 6kkH+CPKclMEWwEBZawlbNAzbTi8kSOZvrqYuC9OOYP3WdCK8ng+dValMry1vJeu7otD
 Axyj0cMO7XYsk6CC2wGhmMzWftZGL++kUrBytvl5CU/I/m6eb7FhMAZ5lOHFRX2Rnn5O
 SMyYqkf3S1upXcycZ73dolHNZddLjsiHvEzsU1+yGbui5qB2haXCOjJbBbAfKY21QoF/
 CkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677939721;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gP8y+ZGSB3tYy5lkcicAQOotbZtTMnefx+SEzepkXec=;
 b=LwON0Hp+H2HFsrEo3LBRbDSY4VBJ+UFtWTvQ0jP8rbSHmJbMgxohpbzv+NQxQFU0RD
 Rzrr9MxXByi5VsMD50WScpTEtsQY/xlqwXcs29byNIAs8XD1OD/6WI4DYwW4rRsdqcno
 xHY6pm/uVM2NsejMj0W1PK4dmSdQcrhV6xGArH445jRJeSX0BVvHvJKIJO6I7zzfaRsA
 BBoGq9/H/1FKUIbZl81b9RFQ/Ces1+jHPqwPmAqWqCufqdQDxyMO8gIJhevbLYGyaY3y
 E0tvSusoPufAEqgv14jgIjjmVBTZB3M4oApnQXh1toJe6F68y4oGOeYF3Me5XPTWEYLl
 5NaQ==
X-Gm-Message-State: AO0yUKUPyJeATboZ2DZbaE4iujGTBYBgFzsTaDUo29bVXptG6Wq2ck12
 qERoNBkfbw2lKbGGLgm35KeYzlrgG6s=
X-Google-Smtp-Source: AK7set/CEFfZbimV2nC5jRyei8TYXbJTLGbhuzmq3XA1HdBppmxhgNvt5ueiF/zTEFC05H2G4aEMFQ==
X-Received: by 2002:ac2:5a0f:0:b0:4dc:8192:c5e6 with SMTP id
 q15-20020ac25a0f000000b004dc8192c5e6mr1558182lfn.13.1677939720983; 
 Sat, 04 Mar 2023 06:22:00 -0800 (PST)
Received: from localhost.localdomain (pc-201-96-67-156-static.strong-pc.com.
 [156.67.96.201]) by smtp.gmail.com with ESMTPSA id
 c14-20020ac2530e000000b004db51387ad6sm831261lfh.129.2023.03.04.06.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Mar 2023 06:22:00 -0800 (PST)
From: =?UTF-8?q?B=C5=82a=C5=BCej=20Szczygie=C5=82?= <mumei6102@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: Fix sienna cichlid incorrect OD volage after
 resume
Date: Sat,  4 Mar 2023 15:20:35 +0100
Message-Id: <20230304142035.37615-1-mumei6102@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Signed-off-by: Błażej Szczygieł <mumei6102@gmail.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 697e98a0a20a..e8780ea66067 100644
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
-- 
2.39.2

