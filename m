Return-Path: <SRS0=wWp/=3X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF02FC35247
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 20:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3AD120721
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 20:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOvUMfQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3AD120721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C93E6ECEE;
	Mon,  3 Feb 2020 20:26:54 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B9456ECEE
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2020 20:26:52 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id u10so7486261qvi.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Feb 2020 12:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xfZhLXVM8tSucbfAIml3OwmWMVOzwebeI/E9tivSAL8=;
 b=LOvUMfQceKiMdubKjFn61eD+7zy8UJzC20m29zHjIV1pc5SysMaMv60wyack8Gjld7
 GvrPos+KlwIsO8yxukgu3eBenw5PqZ+qiJ19G0G01nzMknOtNxiG/VE90GeQnoqx5Khu
 SmrcFLIRH8lvbumWkbhG4chp0PE3DbK0vb7OOC1+PB1WPjiLB3L+eG+mqgIdXX9IhHW4
 5SKLC9s8pXajOyeFsLVl8nbT2vV4JVx7167BCs5Cnquzgcm4zeTKMqto69uyshNCT1Uf
 oPD4cmnGM6Mx31p2TmS0PlYpupgeX07KDqQTgan47sIgok5UgDKxBdlSqsyx74hgRrh+
 QgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xfZhLXVM8tSucbfAIml3OwmWMVOzwebeI/E9tivSAL8=;
 b=FDFPlqHcUEhVS/HWP/chCQ8SqaiIwqhUC8Jr2Mb4XYz6sCfBlpVbdBldqpvzabjBb/
 JvChwFXgzx9nu6I+i5KCKbB7lfsCTT9wqt99YqFu8LcWofn853DVVyRjnH/uf3NXrIXg
 /Ap2zFbCCsgn2c9RVpGgOtKMsJ7MVo2evGBj6urDUW8j+Rmpx31x3PKIVjB0FLMVrs1Q
 pFkBHkutwB66ry8ZASZSaXrq3Z4bgkX6xPtORNzdX0QI6flF/ZlqRMZrVCANeDUIRXvM
 umxeoM/4Z9I0a7Xl3PaVJJsi7k0VktO5/8e0hQZQMyo0pSMz/MruET8LZPhaIrlLFAN9
 mPYQ==
X-Gm-Message-State: APjAAAXYTKfaX4JNVH47lN/LooFAan0dDxPSGNe2alUsH7cxFNY92K23
 LDNwRcIhdnZMORxlrZhbvODl36S7
X-Google-Smtp-Source: APXvYqwcaT+Fl1kKRV7gZMMrYCZIg/pEv81tkvfwTgbHI9JsnRxjT4HeP4ulsEayQ9YMZ9AUdBpZ2w==
X-Received: by 2002:ad4:4e46:: with SMTP id eb6mr24753380qvb.64.1580761611861; 
 Mon, 03 Feb 2020 12:26:51 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id k29sm10512938qtu.54.2020.02.03.12.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 12:26:51 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fetch default VDDC curve voltages
Date: Mon,  3 Feb 2020 15:26:44 -0500
Message-Id: <20200203202644.3808-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

Ask the SMU for the default VDDC curve voltage values.  This
properly reports the VDDC values in the OD interface.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/1020
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 44 +++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 26cfccc57331..48db28ddd1d7 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -119,6 +119,8 @@ static struct smu_11_0_cmn2aisc_mapping navi10_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(PowerDownJpeg,		PPSMC_MSG_PowerDownJpeg),
 	MSG_MAP(BacoAudioD3PME,		PPSMC_MSG_BacoAudioD3PME),
 	MSG_MAP(ArmD3,			PPSMC_MSG_ArmD3),
+	MSG_MAP(GetVoltageByDpm,		     PPSMC_MSG_GetVoltageByDpm),
+	MSG_MAP(GetVoltageByDpmOverdrive,	     PPSMC_MSG_GetVoltageByDpmOverdrive),
 };
 
 static struct smu_11_0_cmn2aisc_mapping navi10_clk_map[SMU_CLK_COUNT] = {
@@ -1932,6 +1934,28 @@ static int navi10_od_setting_check_range(struct smu_11_0_overdrive_table *od_tab
 	return 0;
 }
 
+static int navi10_overdrive_get_gfx_clk_base_voltage(struct smu_context *smu,
+						     uint16_t *voltage,
+						     uint32_t freq)
+{
+	uint32_t param = (freq & 0xFFFF) | (PPCLK_GFXCLK << 16);
+	uint32_t value = 0;
+	int ret;
+
+	ret = smu_send_smc_msg_with_param(smu,
+					  SMU_MSG_GetVoltageByDpm,
+					  param);
+	if (ret) {
+		pr_err("[GetBaseVoltage] failed to get GFXCLK AVFS voltage from SMU!");
+		return ret;
+	}
+
+	smu_read_smc_arg(smu, &value);
+	*voltage = (uint16_t)value;
+
+	return 0;
+}
+
 static int navi10_setup_od_limits(struct smu_context *smu) {
 	struct smu_11_0_overdrive_table *overdrive_table = NULL;
 	struct smu_11_0_powerplay_table *powerplay_table = NULL;
@@ -1958,16 +1982,34 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali
 	if (ret)
 		return ret;
 
+	od_table = (OverDriveTable_t *)smu->smu_table.overdrive_table;
 	if (initialize) {
 		ret = navi10_setup_od_limits(smu);
 		if (ret) {
 			pr_err("Failed to retrieve board OD limits\n");
 			return ret;
 		}
+		if (od_table) {
+			ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
+									&od_table->GfxclkVolt1,
+									od_table->GfxclkFreq1);
+			if (ret)
+				od_table->GfxclkVolt1 = 0;
+
+			ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
+									&od_table->GfxclkVolt2,
+									od_table->GfxclkFreq2);
+			if (ret)
+				od_table->GfxclkVolt2 = 0;
 
+			ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
+									&od_table->GfxclkVolt3,
+									od_table->GfxclkFreq3);
+			if (ret)
+				od_table->GfxclkVolt3 = 0;
+		}
 	}
 
-	od_table = (OverDriveTable_t *)smu->smu_table.overdrive_table;
 	if (od_table) {
 		navi10_dump_od_table(od_table);
 	}
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
