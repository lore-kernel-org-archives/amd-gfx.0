Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD48C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 14:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2244E207E8
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 14:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCXBwlrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2244E207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE0CA6EA88;
	Thu, 18 Jun 2020 14:24:39 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E536EA6C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 14:24:35 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id r22so4183890qke.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hur4qpjeXkxwDBYRjuSjgh687spPiFEE8PiZCeeJwhI=;
 b=TCXBwlrmVoxomvqTDehMVaTVD//HikiTnEJMn6jUGyoTwSfbbJzsx2U3MuCL7ios6K
 uQxsJznzjdrHRQz95H7AotV8aEGXulcp01+hD80weNifOsSpIB1EB+/QdVHS/R8Db36c
 lZVOv2HXwxLow0P9T5Gn/BrLFsBdPcrYadHqQB0wB05Jnol25LMBYJMyYs/PbK0U/s2v
 Jmd/dggmYjlqOXlD1PmgPYbbo7FVvUERRYQ5aLV6oicUZJn7I6+z4Pa11cQSAP1k+mxh
 J7IB3lFiTP+MOEH5roFdbLvAbm9zQjAkpKtPyhy3XFaVfePNPvvMNVTcYdQxS0WoNAYW
 gv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hur4qpjeXkxwDBYRjuSjgh687spPiFEE8PiZCeeJwhI=;
 b=CyzV0Vtqc4DBMdMt3UebFkIChWdmwGY/THkOoOS+1/Tr2IK8LVy1ufuTpl0O806rsL
 iRsrPBhW7W6/GmDbEB8gt9hytVdxUuAvEdqfHT/AFet7dY8jkrSn2ZMj8CiKJcQ0PeTd
 aOXmQWsqUiWMUgrTG6vgzt8/4oqwhE5CtSqH+JfrHWSx0D6OuJ0DU7sKvSTEd1fOnUOm
 Kc6ejbzrIJ9ax/ar7qwsBMAcPL9uvcKdimtf+9hEGqoW4Wn3BoGl+hkkrVzmYrqGi95y
 hzUangtiA8E4YhD0Jqz7EAqdKMIM2+4pzm+RjXuT8fIy0ONuD/t/3I3p8WGYFoWaqORt
 jjhg==
X-Gm-Message-State: AOAM5324r7O3KqWRtThn3U44M7tWYCY+CkszKgj8vRpjC7tMr4xM7OQ7
 VeD/tcsMVNXPq20A6GpmlHb7n7HqSJ005Q==
X-Google-Smtp-Source: ABdhPJwYoU4wGmt2FNKAEizxCKjJx1ISNEmczPvBWNNHbvpRpIVy473JD/rf5C72Q9DMnWbWiZQjWA==
X-Received: by 2002:a05:620a:102c:: with SMTP id
 a12mr3962885qkk.226.1592490274392; 
 Thu, 18 Jun 2020 07:24:34 -0700 (PDT)
Received: from brihaspati.amd.com
 (p200300c58f2304001ed633024609edb3.dip0.t-ipconnect.de.
 [2003:c5:8f23:400:1ed6:3302:4609:edb3])
 by smtp.gmail.com with ESMTPSA id g4sm3028529qka.97.2020.06.18.07.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 07:24:33 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/powerplay: label internally used symbols as static
Date: Thu, 18 Jun 2020 16:25:41 +0200
Message-Id: <20200618142542.77714-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618142542.77714-1-nirmoy.das@amd.com>
References: <20200618142542.77714-1-nirmoy.das@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, nirmoy.das@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Used sparse(make C=1) to find these loose ends.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c             |  2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c       |  2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c       |  2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c     | 10 +++++-----
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c   |  4 ++--
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c     |  4 ++--
 .../drm/amd/powerplay/hwmgr/vega12_processpptables.c   |  2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c   |  4 ++--
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c     |  6 +++---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c     |  4 ++--
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c       |  2 +-
 drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c    |  2 +-
 12 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index e514f02ca0d1..fe4948aa662f 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1695,7 +1695,7 @@ static int smu_enable_umd_pstate(void *handle,
 	return 0;
 }
 
-int smu_adjust_power_state_dynamic(struct smu_context *smu,
+static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 				   enum amd_dpm_forced_level level,
 				   bool skip_display_settings)
 {
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 753cb2cf6b77..2c9cac8c170c 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -1487,7 +1487,7 @@ static int smu7_update_avfs(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
-int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
+static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
 {
 	int tmp_result, result = 0;
 
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
index a6c6a793e98e..35ed47ebaf09 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
@@ -1879,7 +1879,7 @@ static int smu8_enable_disable_uvd_dpm(struct pp_hwmgr *hwmgr, bool enable)
 	return 0;
 }
 
-int smu8_dpm_update_uvd_dpm(struct pp_hwmgr *hwmgr, bool bgate)
+static int smu8_dpm_update_uvd_dpm(struct pp_hwmgr *hwmgr, bool bgate)
 {
 	struct smu8_hwmgr *data = hwmgr->backend;
 	struct phm_uvd_clock_voltage_dependency_table *ptable =
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 675c7cab7cfc..c378a000c934 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -90,7 +90,7 @@ typedef enum {
 
 static const ULONG PhwVega10_Magic = (ULONG)(PHM_VIslands_Magic);
 
-struct vega10_power_state *cast_phw_vega10_power_state(
+static struct vega10_power_state *cast_phw_vega10_power_state(
 				  struct pp_hw_power_state *hw_ps)
 {
 	PP_ASSERT_WITH_CODE((PhwVega10_Magic == hw_ps->magic),
@@ -100,7 +100,7 @@ struct vega10_power_state *cast_phw_vega10_power_state(
 	return (struct vega10_power_state *)hw_ps;
 }
 
-const struct vega10_power_state *cast_const_phw_vega10_power_state(
+static const struct vega10_power_state *cast_const_phw_vega10_power_state(
 				 const struct pp_hw_power_state *hw_ps)
 {
 	PP_ASSERT_WITH_CODE((PhwVega10_Magic == hw_ps->magic),
@@ -2330,7 +2330,7 @@ static int vega10_acg_disable(struct pp_hwmgr *hwmgr)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
 
-	if (data->smu_features[GNLD_ACG].supported && 
+	if (data->smu_features[GNLD_ACG].supported &&
 	    data->smu_features[GNLD_ACG].enabled)
 		if (!vega10_enable_smc_features(hwmgr, false,
 			data->smu_features[GNLD_ACG].smu_feature_bitmap))
@@ -3905,7 +3905,7 @@ static void vega10_notify_smc_display_change(struct pp_hwmgr *hwmgr,
 			NULL);
 }
 
-int vega10_display_clock_voltage_request(struct pp_hwmgr *hwmgr,
+static int vega10_display_clock_voltage_request(struct pp_hwmgr *hwmgr,
 		struct pp_display_clock_request *clock_req)
 {
 	int result = 0;
@@ -4672,7 +4672,7 @@ static int vega10_display_configuration_changed_task(struct pp_hwmgr *hwmgr)
 	return result;
 }
 
-int vega10_enable_disable_uvd_dpm(struct pp_hwmgr *hwmgr, bool enable)
+static int vega10_enable_disable_uvd_dpm(struct pp_hwmgr *hwmgr, bool enable)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
 
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
index 7783c7fd7ccb..468bdd6f6697 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
@@ -499,7 +499,7 @@ int vega10_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr)
 * @param    Result the last failure code
 * @return   result from set temperature range routine
 */
-int vega10_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
+static int vega10_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
 {
 	int ret;
 	struct vega10_hwmgr *data = hwmgr->backend;
@@ -602,7 +602,7 @@ int vega10_enable_mgpu_fan_boost(struct pp_hwmgr *hwmgr)
 * @param    Result the last failure code
 * @return   result from set temperature range routine
 */
-int vega10_thermal_start_smc_fan_control(struct pp_hwmgr *hwmgr)
+static int vega10_thermal_start_smc_fan_control(struct pp_hwmgr *hwmgr)
 {
 /* If the fantable setup has failed we could have disabled
  * PHM_PlatformCaps_MicrocodeFanControl even after
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
index f4d1692cccf3..a678a67f1c0d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
@@ -1436,7 +1436,7 @@ static int vega12_notify_smc_display_change(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
-int vega12_display_clock_voltage_request(struct pp_hwmgr *hwmgr,
+static int vega12_display_clock_voltage_request(struct pp_hwmgr *hwmgr,
 		struct pp_display_clock_request *clock_req)
 {
 	int result = 0;
@@ -2404,7 +2404,7 @@ static int vega12_display_configuration_changed_task(struct pp_hwmgr *hwmgr)
 	return result;
 }
 
-int vega12_enable_disable_uvd_dpm(struct pp_hwmgr *hwmgr, bool enable)
+static int vega12_enable_disable_uvd_dpm(struct pp_hwmgr *hwmgr, bool enable)
 {
 	struct vega12_hwmgr *data =
 			(struct vega12_hwmgr *)(hwmgr->backend);
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_processpptables.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_processpptables.c
index 9817f7a5ed29..195d8539fbb4 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_processpptables.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_processpptables.c
@@ -263,7 +263,7 @@ static int init_powerplay_table_information(
 	return result;
 }
 
-int vega12_pp_tables_initialize(struct pp_hwmgr *hwmgr)
+static int vega12_pp_tables_initialize(struct pp_hwmgr *hwmgr)
 {
 	int result = 0;
 	const ATOM_Vega12_POWERPLAYTABLE *powerplay_table;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c
index c85806a6f62e..c15b9756025d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c
@@ -251,7 +251,7 @@ int vega12_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr)
 * @param    Result the last failure code
 * @return   result from set temperature range routine
 */
-int vega12_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
+static int vega12_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
 {
 	int ret;
 	struct vega12_hwmgr *data = (struct vega12_hwmgr *)(hwmgr->backend);
@@ -274,7 +274,7 @@ int vega12_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
 * @param    Result the last failure code
 * @return   result from set temperature range routine
 */
-int vega12_thermal_start_smc_fan_control(struct pp_hwmgr *hwmgr)
+static int vega12_thermal_start_smc_fan_control(struct pp_hwmgr *hwmgr)
 {
 	/* If the fantable setup has failed we could have disabled
 	 * PHM_PlatformCaps_MicrocodeFanControl even after
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 9ff470f1b826..3b8839641770 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -1981,7 +1981,7 @@ static int vega20_upload_dpm_max_level(struct pp_hwmgr *hwmgr, uint32_t feature_
 	return ret;
 }
 
-int vega20_enable_disable_vce_dpm(struct pp_hwmgr *hwmgr, bool enable)
+static int vega20_enable_disable_vce_dpm(struct pp_hwmgr *hwmgr, bool enable)
 {
 	struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
@@ -2253,7 +2253,7 @@ static int vega20_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 	return ret;
 }
 
-int vega20_display_clock_voltage_request(struct pp_hwmgr *hwmgr,
+static int vega20_display_clock_voltage_request(struct pp_hwmgr *hwmgr,
 		struct pp_display_clock_request *clock_req)
 {
 	int result = 0;
@@ -3589,7 +3589,7 @@ static int vega20_display_configuration_changed_task(struct pp_hwmgr *hwmgr)
 	return result;
 }
 
-int vega20_enable_disable_uvd_dpm(struct pp_hwmgr *hwmgr, bool enable)
+static int vega20_enable_disable_uvd_dpm(struct pp_hwmgr *hwmgr, bool enable)
 {
 	struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 769e031d489a..0957957a2cf5 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1805,7 +1805,7 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 	return 0;
 }
 
-int sienna_cichlid_get_dpm_ultimate_freq(struct smu_context *smu,
+static int sienna_cichlid_get_dpm_ultimate_freq(struct smu_context *smu,
 				enum smu_clk_type clk_type,
 				uint32_t *min, uint32_t *max)
 {
@@ -1821,7 +1821,7 @@ int sienna_cichlid_get_dpm_ultimate_freq(struct smu_context *smu,
 	return ret;
 }
 
-int sienna_cichlid_set_soft_freq_limited_range(struct smu_context *smu,
+static int sienna_cichlid_set_soft_freq_limited_range(struct smu_context *smu,
 				      enum smu_clk_type clk_type,
 				      uint32_t min, uint32_t max)
 {
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
index 56923a96b450..02159ca29fa2 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
@@ -183,7 +183,7 @@ static int ci_program_jump_on_start(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
-bool ci_is_smc_ram_running(struct pp_hwmgr *hwmgr)
+static bool ci_is_smc_ram_running(struct pp_hwmgr *hwmgr)
 {
 	return ((0 == PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device,
 			CGS_IND_REG__SMC, SMC_SYSCON_CLOCK_CNTL_0, ck_disable))
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
index 398e7e3587de..4bfadb49521b 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
@@ -1083,7 +1083,7 @@ static int tonga_populate_single_memory_level(
 	return result;
 }
 
-int tonga_populate_all_memory_levels(struct pp_hwmgr *hwmgr)
+static int tonga_populate_all_memory_levels(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 	struct tonga_smumgr *smu_data =
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
