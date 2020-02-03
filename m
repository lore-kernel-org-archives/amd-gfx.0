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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11355C35247
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 20:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32F020658
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 20:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E53k/Nu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32F020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EBAF6ECF2;
	Mon,  3 Feb 2020 20:36:27 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA776ECF2
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2020 20:36:26 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id g3so7055956qka.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Feb 2020 12:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5rgOkcwzEaZ40Q36bhItmGF2l+ZVk1RhYnO96yLcFfk=;
 b=E53k/Nu1aaN7c63OwMVGrp3juzzMngo753Kgn60SxWhps75azqCG5fhEKV5lYnEcPn
 aCEPvKCXoWNLbUz+vHyB512WRC8WVYbWZjjBOjQjE2xZ1QdGDApOVFq00rSS7mqlfLAd
 xu7agCEP5UiR4iaGWnQ4D5KbTBbtRcmt4V3eeaJoGJFO+1OmAxnxd5ogpHvouOv/if7X
 S7m/ElKQDoV9AjP33J6adjcCmXeFC0wZVSVjhe8vcfLDmp2YsVXplf8T4LAPPsqwg6c9
 ZUq/7XFMlj9r2PDMq9i2f/vOJf3xWBMDRETZSLiCvZiuVKmpknrDcWcmPUXMwHK/Gv1i
 fBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5rgOkcwzEaZ40Q36bhItmGF2l+ZVk1RhYnO96yLcFfk=;
 b=fRs6c9igLXE0aGg+TtUDXtFsJyjn/vxcXgLIeCIU4Uot0vHCg9BjY0es5/rlJC5Gll
 1w8qYA7tdlOa0Sr+w+c8xD9CNkehu3By7mXsebN0bIp2dREw0y0wFIqfajwAFZ7S1fXv
 Hn8VgcH8RfvIEiNJnvXEKawjhLUlPiRmQELhU4bpHqhw39nLAGuyYA/klA8OT02WB7Em
 +l3Hwcnled1d89zKPZ406eupvBCGIMXl7F0OMRcvCajYteC86egoHFNQY2eDqdbFtsM0
 3IqrHY3NH/0aj8y1ridzhGXsBTqk1mHknnPAO4ez9pmR9gq8KSrePqKgMq4yTUo3Dd/j
 iaUA==
X-Gm-Message-State: APjAAAUbXiG56L/j0/Opg+XSnkr5o5/62tzStajZa5HoAJgF2TwuLu8s
 uzqye6q/esAuEpIY04FXYI2OVK5E
X-Google-Smtp-Source: APXvYqwnbLK0bwP7YU2mefaC7yJL0RgGvTQb8Rwn6NxcrrSg0bN3hxr/bO16eYvaxNreUO91gdZLcw==
X-Received: by 2002:a05:620a:1001:: with SMTP id
 z1mr23081011qkj.99.1580762185291; 
 Mon, 03 Feb 2020 12:36:25 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id y5sm3938951qki.123.2020.02.03.12.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 12:36:24 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fetch default VDDC curve voltages (v2)
Date: Mon,  3 Feb 2020 15:36:17 -0500
Message-Id: <20200203203617.23887-1-alexander.deucher@amd.com>
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

v2: only update if the original values are 0

Bug: https://gitlab.freedesktop.org/drm/amd/issues/1020
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 50 +++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 26cfccc57331..a1c1257cf2cb 100644
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
@@ -1958,16 +1982,40 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali
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
+			if (!od_table->GfxclkVolt1) {
+				ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
+										&od_table->GfxclkVolt1,
+										od_table->GfxclkFreq1);
+				if (ret)
+					od_table->GfxclkVolt1 = 0;
+			}
+
+			if (!od_table->GfxclkVolt2) {
+				ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
+										&od_table->GfxclkVolt2,
+										od_table->GfxclkFreq2);
+				if (ret)
+					od_table->GfxclkVolt2 = 0;
+			}
 
+			if (!od_table->GfxclkVolt3) {
+				ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
+										&od_table->GfxclkVolt3,
+										od_table->GfxclkFreq3);
+				if (ret)
+					od_table->GfxclkVolt3 = 0;
+			}
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
