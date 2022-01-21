Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68693C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 07:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7512F10E942;
	Fri, 21 Jan 2022 07:45:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 204A410E916
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 07:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+iqbv1tVft7BtxKwoRYdUobbyz3TOqJWBscuUlQCgA0hNDbKrx80ONjFIQlPDZLjisQcnLniBf3Tv70b0QWSLD6jdaOQZatXc5QDnP/JR/30EQuju1zbigiqA70LAsEQl/16sgq1WlNeCvwG6Ac2yb540pXvTHzCpSgvGK+6KzqLM93GZ35TG4fQrISlsMu/D6kUBs28NPsXbs7L3uroATsdfLD8hB7KUuyxl07ZYhjA7dIxD291VcMKxYL4S9UX/i8/bvSjyu5PwRwqC2k9S0LNBepmFdt6/QjqoUPITLHSXKf++4hCy77/6CdYZbjNjOr5VRd/clpe+f6UlXCZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6idPYM+r5k7WnZGzkl6Ac4MkLzzTwLN4hYVU8Rc2Xc=;
 b=bWyT1EKnBcynr711V0CdTagWSB27rI1ZGEkNgfki9uthciS++/xo3umOIEBiPfKv122ioBmLh1bNF6EkpC8Cc/SsTe3m+MS0xt6wj/6uaAOqE3XFrNU6NLSY4zL9zHUDNQckR9SdwKh/9mSVw6BT6vYTfBsubBzSBiF6DqSTkW6DPTRn/PYP/d4zipIHPJd1dOewF/1fOu4n8ar7rBuUnPM+9Aqb92+q8OHiuNlW4WGnVmOMNyNVMDwLjcrjAvgF8/e07EmVJY+UPqX9mh4IMsPPZj6I32ox4Tajz7YOMV+T6WkBqoKQgureX5cjmqQXjQ26jhZxc0e28ddABDrTyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6idPYM+r5k7WnZGzkl6Ac4MkLzzTwLN4hYVU8Rc2Xc=;
 b=rk6m5X+4WZKI8KpNGP3uSFDFxNIMMSjKdVL2oi+F1T78ie0pqyzvX4nRfTYpHiEk3+OJbjQu00eACD7xNC1EZ92uoG+veDpf6QuklG1ZPWboo9ekkRWJw6iuWNeFRD3eV5xf+Z3TYiJUbfFYNfdibUTUYFcI10VkHysf09Gzvi0=
Received: from MWHPR12CA0057.namprd12.prod.outlook.com (2603:10b6:300:103::19)
 by DM6PR12MB4909.namprd12.prod.outlook.com (2603:10b6:5:1ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 07:45:13 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::e3) by MWHPR12CA0057.outlook.office365.com
 (2603:10b6:300:103::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Fri, 21 Jan 2022 07:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 07:45:13 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 01:45:08 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amd/pm: drop the redundant 'supported' member of
 smu_feature structure
Date: Fri, 21 Jan 2022 15:44:39 +0800
Message-ID: <20220121074443.639392-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220121074443.639392-1-evan.quan@amd.com>
References: <20220121074443.639392-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d003f5e-2954-4708-11ae-08d9dcb1f57f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4909:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4909198ED7EC213A94E91D89E45B9@DM6PR12MB4909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFEtf8vXWGHLRDB8+KLNrrTtqRBHUelf5btSHzk9YsDQSOElqhHSt1mhTjcGXOIIOrfHZttujcXfzKxobme1kPyjD9LLZMBHwHhZHea24p1B9lORIqkGEkty8aHH+y8G+tyL/ofJhKALalGXC4yfnBsB13YNMTAQVSwebW9IkTkZi2+OWhvAxWNtjzcoYowclgVxfwwFDs0ANxfsEhuBdkbXdkQf6PLA8V6mXDbtTCwSzEYARWhcDtyiBLbS2AybJap+YeQDMB6gx4ZL9SfT/bB6+nGMgGRpdpigItfpiRE7cKr9+DS5Sa4Y3mYwwmzIIiMwnJAbeTIYnp7HqGs2vtDBtPvsBIMdemcGE8FPbq+GAkqmatyFoGbt17v5rsjgkzapMpJQDsD1fATaX3MZA+AdrFKMXB2N5AnmSvnzcELC+OLwSBcNpvyaWGj0hSg2nCAVryKYSgUSrXGGgUSIF/nmKaTQ9cSnWXOwhZyZJICSq1tkus0Chd+fUTZKGNXU0NkMzBtYrdikkIcehZxhupt5ws65bo8QHVvCRHNkY7NBHgtPnUlNEV+8iXMHZVqTb8hDRKztyh9qTDWWNibGAUOqEaCW6zYo/xvqhwpYTNfljXb8yKLVzqk4J/DIwOM/zzrrQ9fZWsSUsmyJHQkiNorKh6z9V+ad17hzi/k0zm2KDJa88nYa1WDDmyDl9zf0wFAbJPkfCG6v4BKxxRYXvezKKks7CSUEOFrCRsaFyTrXrZ/qur+DIivYF252bL9FShNOHSerx0OwBOFIpJo0L758WuqsuHBKpnk9r1JnMIw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(82310400004)(40460700001)(4326008)(186003)(81166007)(86362001)(336012)(316002)(6916009)(30864003)(5660300002)(47076005)(426003)(6666004)(508600001)(356005)(16526019)(2906002)(7696005)(8676002)(70206006)(36860700001)(70586007)(83380400001)(44832011)(26005)(54906003)(36756003)(1076003)(8936002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 07:45:13.4141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d003f5e-2954-4708-11ae-08d9dcb1f57f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4909
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, ray.huang@amd.com,
 Evan Quan <evan.quan@amd.com>, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As it has exactly the same value as the 'enabled' member and also do
the same thing.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I07c9a5ac5290cd0d88a40ce1768d393156419b5a
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 -
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  8 ++++----
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 10 +++++-----
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 19 ++++++++-----------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  5 +----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  5 +----
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  3 ---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 17 -----------------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 ---
 10 files changed, 19 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5ace30434e60..d3237b89f2c5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -949,7 +949,6 @@ static int smu_sw_init(void *handle)
 
 	smu->pool_size = adev->pm.smu_prv_buffer_size;
 	smu->smu_feature.feature_num = SMU_FEATURE_MAX;
-	bitmap_zero(smu->smu_feature.supported, SMU_FEATURE_MAX);
 	bitmap_zero(smu->smu_feature.enabled, SMU_FEATURE_MAX);
 	bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 18f24db7d202..3c0360772822 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -388,7 +388,6 @@ struct smu_power_context {
 struct smu_feature
 {
 	uint32_t feature_num;
-	DECLARE_BITMAP(supported, SMU_FEATURE_MAX);
 	DECLARE_BITMAP(allowed, SMU_FEATURE_MAX);
 	DECLARE_BITMAP(enabled, SMU_FEATURE_MAX);
 };
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 84834c24a7e9..9fb290f9aaeb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1625,8 +1625,8 @@ static int navi10_display_config_changed(struct smu_context *smu)
 	int ret = 0;
 
 	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
-	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
-	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
+	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
+	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
 						  smu->display_config->num_display,
 						  NULL);
@@ -1864,13 +1864,13 @@ static int navi10_notify_smc_display_config(struct smu_context *smu)
 	min_clocks.dcef_clock_in_sr = smu->display_config->min_dcef_deep_sleep_set_clk;
 	min_clocks.memory_clock = smu->display_config->min_mem_set_clock;
 
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		clock_req.clock_type = amd_pp_dcef_clock;
 		clock_req.clock_freq_in_khz = min_clocks.dcef_clock * 10;
 
 		ret = smu_v11_0_display_clock_voltage_request(smu, &clock_req);
 		if (!ret) {
-			if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
+			if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
 				ret = smu_cmn_send_smc_msg_with_param(smu,
 								  SMU_MSG_SetMinDeepSleepDcefclk,
 								  min_clocks.dcef_clock_in_sr/100,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 651fe748e423..d568d6137a00 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1281,8 +1281,8 @@ static int sienna_cichlid_display_config_changed(struct smu_context *smu)
 	int ret = 0;
 
 	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
-	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
-	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
+	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
+	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 #if 0
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
 						  smu->display_config->num_display,
@@ -1521,13 +1521,13 @@ static int sienna_cichlid_notify_smc_display_config(struct smu_context *smu)
 	min_clocks.dcef_clock_in_sr = smu->display_config->min_dcef_deep_sleep_set_clk;
 	min_clocks.memory_clock = smu->display_config->min_mem_set_clock;
 
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		clock_req.clock_type = amd_pp_dcef_clock;
 		clock_req.clock_freq_in_khz = min_clocks.dcef_clock * 10;
 
 		ret = smu_v11_0_display_clock_voltage_request(smu, &clock_req);
 		if (!ret) {
-			if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
+			if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
 				ret = smu_cmn_send_smc_msg_with_param(smu,
 								  SMU_MSG_SetMinDeepSleepDcefclk,
 								  min_clocks.dcef_clock_in_sr/100,
@@ -3752,7 +3752,7 @@ static int sienna_cichlid_gpo_control(struct smu_context *smu,
 	int ret = 0;
 
 
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_GFX_GPO_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFX_GPO_BIT)) {
 		ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b58a4c2823c2..b69c2ecc8e25 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -808,7 +808,6 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 		return ret;
 
 	bitmap_zero(feature->enabled, feature->feature_num);
-	bitmap_zero(feature->supported, feature->feature_num);
 
 	if (en) {
 		ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
@@ -817,8 +816,6 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 
 		bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
 			    feature->feature_num);
-		bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
-			    feature->feature_num);
 	}
 
 	return ret;
@@ -1186,7 +1183,7 @@ smu_v11_0_auto_fan_control(struct smu_context *smu, bool auto_fan_control)
 {
 	int ret = 0;
 
-	if (!smu_cmn_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT))
+	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT))
 		return 0;
 
 	ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT, auto_fan_control);
@@ -1607,7 +1604,7 @@ bool smu_v11_0_baco_is_support(struct smu_context *smu)
 		return false;
 
 	/* Arcturus does not support this bit mask */
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT) &&
 	   !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
 		return false;
 
@@ -2150,7 +2147,7 @@ int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
 {
 	int ret = 0;
 
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_GFX_ULV_BIT))
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_GFX_ULV_BIT))
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_ULV_BIT, enablement);
 
 	return ret;
@@ -2162,7 +2159,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_GFXCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_GFXCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_GFXCLK_BIT, enablement);
 		if (ret) {
 			dev_err(adev->dev, "Failed to %s GFXCLK DS!\n", enablement ? "enable" : "disable");
@@ -2170,7 +2167,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 		}
 	}
 
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_UCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_UCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_UCLK_BIT, enablement);
 		if (ret) {
 			dev_err(adev->dev, "Failed to %s UCLK DS!\n", enablement ? "enable" : "disable");
@@ -2178,7 +2175,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 		}
 	}
 
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_FCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_FCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_FCLK_BIT, enablement);
 		if (ret) {
 			dev_err(adev->dev, "Failed to %s FCLK DS!\n", enablement ? "enable" : "disable");
@@ -2186,7 +2183,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 		}
 	}
 
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_SOCCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_SOCCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_SOCCLK_BIT, enablement);
 		if (ret) {
 			dev_err(adev->dev, "Failed to %s SOCCLK DS!\n", enablement ? "enable" : "disable");
@@ -2194,7 +2191,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 		}
 	}
 
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_LCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_LCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_LCLK_BIT, enablement);
 		if (ret) {
 			dev_err(adev->dev, "Failed to %s LCLK DS!\n", enablement ? "enable" : "disable");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index b4a3c9b8b54e..e72831aa4859 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1960,7 +1960,6 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
 						      RLC_STATUS_OFF, NULL);
 
 	bitmap_zero(feature->enabled, feature->feature_num);
-	bitmap_zero(feature->supported, feature->feature_num);
 
 	if (!en)
 		return ret;
@@ -1971,8 +1970,6 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
 
 	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
 		    feature->feature_num);
-	bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
-		    feature->feature_num);
 
 	return 0;
 }
@@ -1989,7 +1986,7 @@ static int vangogh_post_smu_init(struct smu_context *smu)
 		adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
 
 	/* allow message will be sent after enable message on Vangogh*/
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
 			(adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
 		if (ret) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1754a3720179..c5d354175675 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -774,7 +774,6 @@ int smu_v13_0_system_features_control(struct smu_context *smu,
 		return ret;
 
 	bitmap_zero(feature->enabled, feature->feature_num);
-	bitmap_zero(feature->supported, feature->feature_num);
 
 	if (en) {
 		ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
@@ -783,8 +782,6 @@ int smu_v13_0_system_features_control(struct smu_context *smu,
 
 		bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
 			    feature->feature_num);
-		bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
-			    feature->feature_num);
 	}
 
 	return ret;
@@ -1071,7 +1068,7 @@ smu_v13_0_auto_fan_control(struct smu_context *smu, bool auto_fan_control)
 {
 	int ret = 0;
 
-	if (!smu_cmn_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT))
+	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT))
 		return 0;
 
 	ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT, auto_fan_control);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index f425827e2361..e9172622c0c4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -204,7 +204,6 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
 
 	bitmap_zero(feature->enabled, feature->feature_num);
-	bitmap_zero(feature->supported, feature->feature_num);
 
 	if (!en)
 		return ret;
@@ -215,8 +214,6 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
 
 	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
 		    feature->feature_num);
-	bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
-		    feature->feature_num);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 50164ebed1cd..49bcabe9d708 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -476,23 +476,6 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 	}
 }
 
-int smu_cmn_feature_is_supported(struct smu_context *smu,
-				 enum smu_feature_mask mask)
-{
-	struct smu_feature *feature = &smu->smu_feature;
-	int feature_id;
-
-	feature_id = smu_cmn_to_asic_specific_index(smu,
-						    CMN2ASIC_MAPPING_FEATURE,
-						    mask);
-	if (feature_id < 0)
-		return 0;
-
-	WARN_ON(feature_id > feature->feature_num);
-
-	return test_bit(feature_id, feature->supported);
-}
-
 int smu_cmn_feature_is_enabled(struct smu_context *smu,
 			       enum smu_feature_mask mask)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 4e34c18c6063..19919182260a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -48,9 +48,6 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 				   enum smu_cmn2asic_mapping_type type,
 				   uint32_t index);
 
-int smu_cmn_feature_is_supported(struct smu_context *smu,
-				 enum smu_feature_mask mask);
-
 int smu_cmn_feature_is_enabled(struct smu_context *smu,
 			       enum smu_feature_mask mask);
 
-- 
2.29.0

