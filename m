Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE4DCCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 12:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F046210E5E1;
	Tue, 14 Oct 2025 12:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ASi7dPWS";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D6CC10E4A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 16:30:47 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b00a9989633so839123066b.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760373045; x=1760977845; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/gjdRxaKOwWl6c9IdRI2S0StBtsnAiZuf94qwIBeiCU=;
 b=ASi7dPWS/PBQVzc7CtEpUNKbbpB59+i/o4DSX9xEVsWmIWHqrkPwE2uxn3/vLVunH0
 nKHQrzPuFycDBc+c+r57YJ8fHThg+wecLfYpRXEU70P0rLhe7s5g1UbQe2gz4gPg08wh
 lUgLHVyPJc5lixViTKypZG4XC7t5gWFJP9SuTHUTS9xa8PP7gSDozM2aZpwAtxPDseWD
 jUSmGsf7a7+F7IVbcKNe5QLqTVQlUGCmb3CgeBhKj8JFKv4cRHF3C4ITwaXG/zLcz+ON
 Oj0GarmzCGjomNo28q9aiFo0BdgbIp8IpM4Lnfi4PdWI2vv42J/anrx/Qzjude2CKr5p
 GJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760373045; x=1760977845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/gjdRxaKOwWl6c9IdRI2S0StBtsnAiZuf94qwIBeiCU=;
 b=DeHDj8uictcp/jFEVUmmnRva6gLhK5dXO12oH86LcOMu5HjzvCd0KmkomVW2vOvvlr
 SFSdFIhh3VgpRsanfSxfrYnb9fJrHsMzclpLFfzrQuOID0tStes1TpbgXBmWU5AUJU5A
 8PSGJ3ufz2RX+XUWCDqwoOtHUyif80WtlmPE8bdxmKF2SjImjk6DautHqMcjqGWqQeqF
 8rsizUCCbDDX57/CEWlJseiMyKbfmNfEewROY5uck/K538jCPCN2zRcRB07pxf85G1Rp
 6TBL+BFPBE8M6EqzG0MlGbU91YfiaYq4Pj+ZPYtbC3sGLwkQzmA2j4XuWIVwPOwFSVCo
 22DQ==
X-Gm-Message-State: AOJu0YxhQfktA2U+GMg97s5MICh6TB0z8gGxM2pNWUffMInPv1jY1amz
 QNupPF3SP2L+XMiaHieocATlc6eiAPI9BPYD0CvARmWHnO3zGPof7NzrHdDlOyM3
X-Gm-Gg: ASbGncsdFq4JljYL3YBiUeC2Vb9AQuVJpVKhfZlWTjbFSWG0kBv5SQ9JWQPRSCUm3+1
 0dU9fMJCwnL3HfBmV8RTsLH3zRKV8p0cXR0Yq7PAV6a3OU6pXGtB02Att29SdP+X3xc/9EarmkW
 MN8TH7jHjqEo+BhEylkiRuwP/qEZMAXz8H5NlW4D8By0FDrvy+FTQg2nOOviU7nvkGh+f98n2wB
 MmafJ6EnLj2bJ1KD10FscFfospJ1wTIMXc1Dw+on71A2AAdgOlUfs/s2k9fYzdjb+oA1qYWWwr5
 kYDMRW3K9PQHDBA+yAqoJM+GkftCKaSpL3bBnZKgjDWBX7RAhHSQm5XyQVTUD2g7I8yJo2s1zIG
 QC7KsXfwOp1VbHJzwWua4OGZdPQ4DTB96S0J+6ZU76aB6dn+oOG8or1k1HpqTmA+8MZHWapG0OG
 JwMr0+iSyaLmILpATTVRDa623cnzbolQ==
X-Google-Smtp-Source: AGHT+IEYEvIK6Ca1Sst9Mu9PHdcECAem7VGTh/WGA3BiEPhM01089fj3SLlb3vqxxPNAQ/C0Ltj2+g==
X-Received: by 2002:a17:907:94c1:b0:afe:159:14b1 with SMTP id
 a640c23a62f3a-b50bd049ba7mr2420694266b.9.1760373044961; 
 Mon, 13 Oct 2025 09:30:44 -0700 (PDT)
Received: from hyron-desktop (host-176-36-64-50.b024.la.net.ua. [176.36.64.50])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d8c12b9dsm959166066b.45.2025.10.13.09.30.44
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 09:30:44 -0700 (PDT)
From: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/1] drm/amd/pm: Avoid writing nulls into
 `pp_od_clk_voltage`
Date: Mon, 13 Oct 2025 19:30:42 +0300
Message-ID: <20251013163042.531225-2-ilya.zlobintsev@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013163042.531225-1-ilya.zlobintsev@gmail.com>
References: <20251013163042.531225-1-ilya.zlobintsev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Oct 2025 12:36:26 +0000
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

Calling `smu_cmn_get_sysfs_buf` aligns the
offset used by `sysfs_emit_at` to the current page boundary, which was
previously directly returned from the various `print_clk_levels`
implementations to be added to the buffer position.
Instead, only the relative offset showing how much was written
to the buffer should be returned, regardless of how it was changed
for alignment purposes.

Signed-off-by: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>
---
 .../drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 15 ++++++++-------
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 10 ++++++----
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  7 ++++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  7 ++++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  5 +++--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  5 +++--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  7 ++++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  7 ++++---
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  5 +++--
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  5 +++--
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  7 ++++---
 13 files changed, 52 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 9548bd3c624b..55401e6b2b0b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -291,11 +291,12 @@ static int cyan_skillfish_print_clk_levels(struct smu_context *smu,
 					enum smu_clk_type clk_type,
 					char *buf)
 {
-	int ret = 0, size = 0;
+	int ret = 0, size = 0, start_offset = 0;
 	uint32_t cur_value = 0;
 	int i;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
+	start_offset = size;
 
 	switch (clk_type) {
 	case SMU_OD_SCLK:
@@ -353,7 +354,7 @@ static int cyan_skillfish_print_clk_levels(struct smu_context *smu,
 		return ret;
 	}
 
-	return size;
+	return size - start_offset;
 }
 
 static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 0028f10ead42..bbf09aec9152 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1469,7 +1469,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
 {
 	uint16_t *curve_settings;
-	int i, levels, size = 0, ret = 0;
+	int i, levels, size = 0, ret = 0, start_offset = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t freq_values[3] = {0};
 	uint32_t mark_index = 0;
@@ -1484,6 +1484,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 	uint32_t min_value, max_value;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
+	start_offset = size;
 
 	switch (clk_type) {
 	case SMU_GFXCLK:
@@ -1497,11 +1498,11 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 	case SMU_DCEFCLK:
 		ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
 		if (ret)
-			return size;
+			return size - start_offset;
 
 		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
-			return size;
+			return size - start_offset;
 
 		ret = navi10_is_support_fine_grained_dpm(smu, clk_type);
 		if (ret < 0)
@@ -1511,7 +1512,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
-					return size;
+					return size - start_offset;
 
 				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
 						cur_value == value ? "*" : "");
@@ -1519,10 +1520,10 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		} else {
 			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
 			if (ret)
-				return size;
+				return size - start_offset;
 			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
 			if (ret)
-				return size;
+				return size - start_offset;
 
 			freq_values[1] = cur_value;
 			mark_index = cur_value == freq_values[0] ? 0 :
@@ -1653,7 +1654,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size;
+	return size - start_offset;
 }
 
 static int navi10_force_clk_levels(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 31c2c0386b1f..774283ac7827 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1281,7 +1281,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	struct smu_11_0_7_overdrive_table *od_settings = smu->od_settings;
 	OverDriveTable_t *od_table =
 		(OverDriveTable_t *)table_context->overdrive_table;
-	int i, size = 0, ret = 0;
+	int i, size = 0, ret = 0, start_offset = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t freq_values[3] = {0};
 	uint32_t mark_index = 0;
@@ -1289,6 +1289,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	uint32_t min_value, max_value;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
+	start_offset = size;
 
 	switch (clk_type) {
 	case SMU_GFXCLK:
@@ -1434,7 +1435,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	}
 
 print_clk_out:
-	return size;
+	return size - start_offset;
 }
 
 static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 2c9869feba61..665eee58358d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -565,7 +565,7 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_legacy_t metrics;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	int i, idx, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0, start_offset = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	bool cur_value_match_level = false;
 
@@ -576,6 +576,7 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 		return ret;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
+	start_offset = size;
 
 	switch (clk_type) {
 	case SMU_OD_SCLK:
@@ -658,7 +659,7 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size;
+	return size - start_offset;
 }
 
 static int vangogh_print_clk_levels(struct smu_context *smu,
@@ -666,7 +667,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 {
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_t metrics;
-	int i, idx, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0, start_offset = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	bool cur_value_match_level = false;
 	uint32_t min, max;
@@ -678,6 +679,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 		return ret;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
+	start_offset = size;
 
 	switch (clk_type) {
 	case SMU_OD_SCLK:
@@ -779,7 +781,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size;
+	return size - start_offset;
 }
 
 static int vangogh_common_print_clk_levels(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 3baf20f4c373..eaa9ea162f16 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -494,7 +494,7 @@ static int renoir_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 static int renoir_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
 {
-	int i, idx, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0, start_offset = 0;
 	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
 	SmuMetrics_t metrics;
 	bool cur_value_match_level = false;
@@ -506,6 +506,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 		return ret;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
+	start_offset = size;
 
 	switch (clk_type) {
 	case SMU_OD_RANGE:
@@ -550,7 +551,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 			size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
 					i == 2 ? "*" : "");
 		}
-		return size;
+		return size - start_offset;
 	case SMU_SOCCLK:
 		count = NUM_SOCCLK_DPM_LEVELS;
 		cur_value = metrics.ClockFrequency[CLOCK_SOCCLK];
@@ -607,7 +608,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size;
+	return size - start_offset;
 }
 
 static enum amd_pm_state_type renoir_get_current_power_state(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index c1062e5f0393..677781060246 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1195,15 +1195,16 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
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
-		return size;
+		return size - start_offset;
 	}
 
 	switch (clk_type) {
@@ -1534,7 +1535,7 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size;
+	return size - start_offset;
 }
 
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index b081ae3e8f43..6908f9930f16 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -497,11 +497,12 @@ static int smu_v13_0_4_get_dpm_level_count(struct smu_context *smu,
 static int smu_v13_0_4_print_clk_levels(struct smu_context *smu,
 					enum smu_clk_type clk_type, char *buf)
 {
-	int i, idx, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0, start_offset = 0;
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
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index f5db181ef489..4576bf008b22 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -861,11 +861,12 @@ static int smu_v13_0_5_set_soft_freq_limited_range(struct smu_context *smu,
 static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
 				enum smu_clk_type clk_type, char *buf)
 {
-	int i, idx, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0, start_offset = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min = 0, max = 0;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
+	start_offset = size;
 
 	switch (clk_type) {
 	case SMU_OD_SCLK:
@@ -928,7 +929,7 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
 	}
 
 print_clk_out:
-	return size;
+	return size - start_offset;
 }
 
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 285cf7979693..0e1b225dd875 100644
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
@@ -1437,10 +1437,11 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 	uint32_t min_clk, max_clk;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
+	start_offset = size;
 
 	if (amdgpu_ras_intr_triggered()) {
 		size += sysfs_emit_at(buf, size, "unavailable\n");
-		return size;
+		return size - start_offset;
 	}
 
 	dpm_context = smu_dpm->dpm_context;
@@ -1575,7 +1576,7 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size;
+	return size - start_offset;
 }
 
 static int smu_v13_0_6_upload_dpm_level(struct smu_context *smu, bool max,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index c96fa5e49ed6..a3fc35b9011e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1184,15 +1184,16 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
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
-		return size;
+		return size - start_offset;
 	}
 
 	switch (clk_type) {
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
index 086501cc5213..2cea688c604f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1056,15 +1056,16 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
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
-		return size;
+		return size - start_offset;
 	}
 
 	switch (clk_type) {
@@ -1374,7 +1375,7 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size;
+	return size - start_offset;
 }
 
 static int smu_v14_0_2_force_clk_levels(struct smu_context *smu,
-- 
2.51.0

