Return-Path: <SRS0=ij9B=3O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CDDC2D0DB
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Jan 2020 18:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE7720716
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Jan 2020 18:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWALMzGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE7720716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A9F6E8E8;
	Sat, 25 Jan 2020 18:48:56 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 637986E8E4
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Jan 2020 18:48:54 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id 21so5614929qky.4
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Jan 2020 10:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EbvDApfL7wh2Ah4vedDxdpA31xDUHAgBh2go4J3LL9A=;
 b=MWALMzGUxHoewmoOdQpJ/OX6PZfNUAAkWS3iTcKxqEg24SUjqUSvSglLaW3OjvY5VD
 QdiQXVFmVYqebtkD6ZC6HRsduovpBJex2SAvY2Pj9vhILmx01ov+aGXT4qvUJ1RxwPhQ
 jwrENhCID7IMuy6iCYco7bcuqHpvZZer2KtDzBG2Lk0GZKcssz8BMvP7CO2+HzT31Zgl
 mdlVtA18ZAVb92fQVeZFT3iQCZVkAyr8SoikOCYDMghvJv0umk2MXcU2jVnAPYV+uSgP
 rmqZUl5qs0G/MZ6P7+tJEhKjwOVt2rsTvAEyVNxdraYlHeIhpgMFgs0cMjcmoEOdJRQm
 Mijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EbvDApfL7wh2Ah4vedDxdpA31xDUHAgBh2go4J3LL9A=;
 b=tHjkoJlexPb97l+U1gsWD2b15qtZqqYCcWqXfOrjfkYpfhJAi7GVcsrEHn1vkGA+Vo
 PKtnfDdCzowb61sy0WcBHI+ICGS6IkOPWBCJFu4wDSQsh+/VHSWeT9z76sPXTW12/XFg
 Cyd7YDnBa09CPHkC2H/yqFamoMT93yKHBq3nGKqtTtFa9RdLGP2m8tvNys1mlqc9ygoa
 oDUrAvkNCs7MsTa1UNK3uRNRsfQRLbiMmWAb4c5F5m6pMAk4uTi5q2YbaCFE2b1F6bqq
 LdXtf1bkHe3wKJSESBIQIa+W2uv9vnXpRgPmQXUaJyHcvI/0g3W+nSU9fNsFpXILFhq5
 lVRg==
X-Gm-Message-State: APjAAAUGL4oKAlcwWruJKmbReuMmwV6285nwWQisrFDTliirKzPloRlH
 oJbi2WwkuS6Jtqo5PLhYsGDJnKxO
X-Google-Smtp-Source: APXvYqx1aL8qyEgx7gRJ/XBdJLK0mc8oOqqqLxCIEJkoTaUaRKrTnqPFIpMWozVEGp5DXXOOWSFS+w==
X-Received: by 2002:a05:620a:13e7:: with SMTP id
 h7mr9269062qkl.235.1579978133374; 
 Sat, 25 Jan 2020 10:48:53 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id z6sm5565118qkz.101.2020.01.25.10.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2020 10:48:52 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu/navi10: add OD_RANGE for navi overclocking
Date: Sat, 25 Jan 2020 13:48:44 -0500
Message-Id: <20200125184845.4233-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200125184845.4233-1-alexander.deucher@amd.com>
References: <20200125184845.4233-1-alexander.deucher@amd.com>
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

So users can see the range of valid values.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/1020
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index c8f09874c2ec..d2d45181ae23 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -737,6 +737,15 @@ static inline bool navi10_od_feature_is_supported(struct smu_11_0_overdrive_tabl
 	return od_table->cap[feature];
 }
 
+static void navi10_od_setting_get_range(struct smu_11_0_overdrive_table *od_table,
+					enum SMU_11_0_ODSETTING_ID setting,
+					uint32_t *min, uint32_t *max)
+{
+	if (min)
+		*min = od_table->min[setting];
+	if (max)
+		*max = od_table->max[setting];
+}
 
 static int navi10_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
@@ -755,6 +764,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 	OverDriveTable_t *od_table =
 		(OverDriveTable_t *)table_context->overdrive_table;
 	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
+	uint32_t min_value, max_value;
 
 	switch (clk_type) {
 	case SMU_GFXCLK:
@@ -867,6 +877,55 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 			}
 			size += sprintf(buf + size, "%d: %uMHz @ %umV\n", i, curve_settings[0], curve_settings[1] / NAVI10_VOLTAGE_SCALE);
 		}
+		break;
+	case SMU_OD_RANGE:
+		if (!smu->od_enabled || !od_table || !od_settings)
+			break;
+		size = sprintf(buf, "%s:\n", "OD_RANGE");
+
+		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_GFXCLK_LIMITS)) {
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_GFXCLKFMIN,
+						    &min_value, NULL);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_GFXCLKFMAX,
+						    NULL, &max_value);
+			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
+					min_value, max_value);
+		}
+
+		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_UCLK_MAX)) {
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_UCLKFMAX,
+						    &min_value, &max_value);
+			size += sprintf(buf + size, "MCLK: %7uMhz %10uMhz\n",
+					min_value, max_value);
+		}
+
+		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_GFXCLK_CURVE)) {
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P1,
+						    &min_value, &max_value);
+			size += sprintf(buf + size, "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
+					min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P1,
+						    &min_value, &max_value);
+			size += sprintf(buf + size, "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
+					min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P2,
+						    &min_value, &max_value);
+			size += sprintf(buf + size, "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
+					min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P2,
+						    &min_value, &max_value);
+			size += sprintf(buf + size, "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
+					min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P3,
+						    &min_value, &max_value);
+			size += sprintf(buf + size, "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
+					min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P3,
+						    &min_value, &max_value);
+			size += sprintf(buf + size, "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
+					min_value, max_value);
+		}
+
 		break;
 	default:
 		break;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
