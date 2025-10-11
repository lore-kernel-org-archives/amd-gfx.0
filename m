Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208C4CCD18E
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 07:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3B8210E3E2;
	Mon, 13 Oct 2025 07:35:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N/+UaXey";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A326510E308
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 13:48:21 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-634a3327ff7so6061395a12.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760190500; x=1760795300; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PebmmdCfBWk7RgAMCUAjCzl0inAHP/W0+pRTkKWcC/I=;
 b=N/+UaXey82ea1gK+zE0uecX5Sj+roeA++N225hUqqBojrBl8+ofFm6nK7XvLG4u5R4
 yi4jgTI1aXcAdW2JWXa5V56zJM2rZayEGBZdkE4KOHm0Li4JQuU9gccC+ICoxWxLmCV2
 w+1BXQqWFp5onz/GyfywxSD+aQhUppUo9XLS5mLuDSUDD0M9gHgrGZjpix107xlFzF8X
 ot6oHADuI5ZyNw+BiAbFcJc44F0I2Syz8CtJRFUHwANHkPjSH/yhsTleUNQ+xetKOgcW
 1Rhkj/XjlXqy3XX4wcCqpyaA+8i5xcrVeNDT46rQD2AkMusUh1tu/2BE4o6t4YmWMhBN
 20Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760190500; x=1760795300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PebmmdCfBWk7RgAMCUAjCzl0inAHP/W0+pRTkKWcC/I=;
 b=WVI5e9rSHsoMJvochF6mQmPu1ab2oFrGFt9VGBp5/Se8e0SGEXV3pmin/POnANLMKL
 8jSvrTGNotBqO1mhFwrF9fbpYoAlZgcNf5atzbcILFk7n4WurxE6QBX97h4V9q0k/eo9
 D5yKHUpHniEBoas7dfkQGt9KD6wdGc4BkV9m81AADTXBhR84VRsQl+FYPUeA3E+0+r28
 2UCMEehtc3aghyaet9xSZeTCuc5m+gAx8TXRzUxvlQEZALXCqbhgjbgXIWSxrLrjEudf
 P65jtBAweZmZDixaLJQzLYDbVqoZeW1+CaA7xAoWc5bIZK3As+Hotyc2QaGvLD3ZRbHo
 INow==
X-Gm-Message-State: AOJu0YzXarTe5kW9QV7dvmHIrSAlIj/S8iubWeE6V49uDzfrekHLIjs2
 QOHcSra6i+uO2gqZHGUxqUn89oZnUEsqk7NHrsThXzRMWNiNkH/Qw0UfaI6vJw==
X-Gm-Gg: ASbGncvmXTikm+sNoRC8OGrRw5yXmP1X8H0ip6EtNJNcqAhBUgTrcJg3/dwcdXXlT7q
 HeyYDIMmwNnm/sSzcx0fvvVvpC3tY/LXdTSvx7gyMXk3GaybKBlvx65B7QPxWPVpF2i9sM6jsW+
 HRFKd7CSIddzNXOdFyp8OrvJNt+SnCwTATypJdPvADW3IVz+Um4V1a8PCvLT7NOZq/HW82JnBUd
 E1mlwfvid+S9qHH06ewHtf89CFiFzlZ9/miBYJ/MtS/gebDjpgds2Z03gpOM2ej5xROB6hmAPXc
 Ds7CeFoDESgMEtcsxNAp/Aax67XhadARxyppCQFZ11KWaWoIcWOGd8kHjwEBmRnkTt4yqa956og
 ZPQ1TV9usDuPavLcYgojleGJM8O/qjlzz6Y9VAgVXWmcgsYex8+lJTgvLTC7PmVWqphOVXOZFML
 mxEnhmTYwyGyiZ/3QgbEM=
X-Google-Smtp-Source: AGHT+IFBuDi/TjemREjWpURnrWYjHFJjFDlBFYDSPOUm56/rvKAOtHo+cge82QezWikb3Dt6FQJ77A==
X-Received: by 2002:a05:6402:274a:b0:62f:3436:a396 with SMTP id
 4fb4d7f45d1cf-639d5c5a403mr13332347a12.31.1760190499787; 
 Sat, 11 Oct 2025 06:48:19 -0700 (PDT)
Received: from hyron-desktop (host-176-36-64-50.b024.la.net.ua. [176.36.64.50])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a52b0f358sm4788016a12.10.2025.10.11.06.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 06:48:19 -0700 (PDT)
From: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>
Subject: [PATCH 2/2] drm/amd/pm: Avoid writing nulls into `pp_od_clk_voltage`
 (SMU13/SMU14)
Date: Sat, 11 Oct 2025 16:47:16 +0300
Message-ID: <20251011134716.83214-3-ilya.zlobintsev@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251011134716.83214-1-ilya.zlobintsev@gmail.com>
References: <20251011134716.83214-1-ilya.zlobintsev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Oct 2025 07:35:45 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 5 +++--
 7 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index c1062e5f0393..993ab66911fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1195,11 +1195,12 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 	struct smu_13_0_dpm_table *single_dpm_table;
 	struct smu_13_0_pcie_table *pcie_table;
 	uint32_t gen_speed, lane_width;
-	int i, curr_freq, size = 0;
+	int i, curr_freq, size = 0, start_offset = 0;
 	int32_t min_value, max_value;
 	int ret = 0;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
+	start_offset = size;
 
 	if (amdgpu_ras_intr_triggered()) {
 		size += sysfs_emit_at(buf, size, "unavailable\n");
@@ -1534,7 +1535,7 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size;
+	return size - start_offset;
 }
 
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index b081ae3e8f43..728bc9087058 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -497,11 +497,12 @@ static int smu_v13_0_4_get_dpm_level_count(struct smu_context *smu,
 static int smu_v13_0_4_print_clk_levels(struct smu_context *smu,
 					enum smu_clk_type clk_type, char *buf)
 {
-	int i, idx, size = 0, ret = 0;
+	int i, idx, size = 0, start_offset = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min, max;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
+	start_offset = size;
 
 	switch (clk_type) {
 	case SMU_OD_SCLK:
@@ -565,7 +566,7 @@ static int smu_v13_0_4_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size;
+	return size - start_offset;
 }
 
 static int smu_v13_0_4_read_sensor(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 285cf7979693..8e7ba5af9540 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1428,7 +1428,7 @@ static int smu_v13_0_6_print_clks(struct smu_context *smu, char *buf, int size,
 static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 					enum smu_clk_type type, char *buf)
 {
-	int now, size = 0;
+	int now, size = 0, start_offset = 0;
 	int ret = 0;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
 	struct smu_13_0_dpm_table *single_dpm_table;
@@ -1437,6 +1437,7 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 	uint32_t min_clk, max_clk;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
+	start_offset = size;
 
 	if (amdgpu_ras_intr_triggered()) {
 		size += sysfs_emit_at(buf, size, "unavailable\n");
@@ -1575,7 +1576,7 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size;
+	return size - start_offset;
 }
 
 static int smu_v13_0_6_upload_dpm_level(struct smu_context *smu, bool max,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index c96fa5e49ed6..f1ad2fe0cc42 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1184,11 +1184,12 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 	struct smu_13_0_dpm_table *single_dpm_table;
 	struct smu_13_0_pcie_table *pcie_table;
 	uint32_t gen_speed, lane_width;
-	int i, curr_freq, size = 0;
+	int i, curr_freq, size = 0, start_offset = 0;
 	int32_t min_value, max_value;
 	int ret = 0;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
+	start_offset = size;
 
 	if (amdgpu_ras_intr_triggered()) {
 		size += sysfs_emit_at(buf, size, "unavailable\n");
@@ -1523,7 +1524,7 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size;
+	return size - start_offset;
 }
 
 static int smu_v13_0_7_od_restore_table_single(struct smu_context *smu, long input)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 73b4506ef5a8..5d7e671fa3c3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -1041,12 +1041,13 @@ static uint32_t yellow_carp_get_umd_pstate_clk_default(struct smu_context *smu,
 static int yellow_carp_print_clk_levels(struct smu_context *smu,
 				enum smu_clk_type clk_type, char *buf)
 {
-	int i, idx, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0, start_offset = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min, max;
 	uint32_t clk_limit = 0;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
+	start_offset = size;
 
 	switch (clk_type) {
 	case SMU_OD_SCLK:
@@ -1111,7 +1112,7 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 	}
 
 print_clk_out:
-	return size;
+	return size - start_offset;
 }
 
 static int yellow_carp_force_clk_levels(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index fe00c84b1cc6..b1bd946d8e30 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1132,11 +1132,12 @@ static int smu_v14_0_common_get_dpm_level_count(struct smu_context *smu,
 static int smu_v14_0_0_print_clk_levels(struct smu_context *smu,
 					enum smu_clk_type clk_type, char *buf)
 {
-	int i, idx, ret = 0, size = 0;
+	int i, idx, ret = 0, size = 0, start_offset = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min, max;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
+	start_offset = size;
 
 	switch (clk_type) {
 	case SMU_OD_SCLK:
@@ -1202,7 +1203,7 @@ static int smu_v14_0_0_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size;
+	return size - start_offset;
 }
 
 static int smu_v14_0_0_set_soft_freq_limited_range(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 086501cc5213..a5668eb5ee09 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1056,11 +1056,12 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 	struct smu_14_0_dpm_table *single_dpm_table;
 	struct smu_14_0_pcie_table *pcie_table;
 	uint32_t gen_speed, lane_width;
-	int i, curr_freq, size = 0;
+	int i, curr_freq, size = 0, start_offset = 0;
 	int32_t min_value, max_value;
 	int ret = 0;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
+	start_offset = size;
 
 	if (amdgpu_ras_intr_triggered()) {
 		size += sysfs_emit_at(buf, size, "unavailable\n");
@@ -1374,7 +1375,7 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size;
+	return size - start_offset;
 }
 
 static int smu_v14_0_2_force_clk_levels(struct smu_context *smu,
-- 
2.51.0

