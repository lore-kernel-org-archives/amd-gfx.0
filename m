Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C11C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 03:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FFC310E03C;
	Fri,  9 Dec 2022 03:49:17 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6536810E221
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 03:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux3l19QHqIEsNIZc9NGLGUMwdiqcSLIeUHZiHhUEYNpbIndPBQOztUMQxH0Il5YzEVrxpgr8500mhqzi84a9A10hzp/W6ECNpb6W4091vAdzk+W/RYO6to/fRhF/Acb9XNGWim0lTTA+wiYodQM4ECY4HQZf7JlQJ/ishQ18KSNLw4fjK4Cm77JKcU5os42yyz+SAvf8oEffIj4OAHAwe/xAQss8zZAxRjuE5ViRhafynabGgzWtr0CZvqzY2WSdLDLAwBQZwsQt+xGzSCthn3C7PSgitt2TbVtag6Yz7i1kYpj13ZPGPFWn/G5t8qXCAwWUfL6b91jYtsTr0D1Abg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQn2VnnsAF/hhP6DTFg2J+Kv5TgGoacdPP91LIaqTMo=;
 b=aQFw6ux0sMbdz7X3JJZMfSQlN2b39lN2ZFVfd6GcV3Jb4oQg0AVHAVrODRl6/P1JJnAlY6aNC30csPsdhKN48VUSKGQPhafrC0viQXB7MNDHR1K2scJI4lqEIbZal1kwW37u8V84vQD3fL5Ey+qIifFko1AJzUT1H8pIIZWuguA+lndo1bQN4NkdLszD+ARuVtsll4vBXAfWnFJXSxiC+/d6F8BS/3APf6YwlTElzlK+n6pAI/suyXYW9PLkqkyIIG+pb++S5WFHoEafpW2UIs3MUQhPSK6pjA9NiF4pf7cEpE9AX7otyEWWrv1mAYuIqm1WXegzW5jVP6AC/eJrmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQn2VnnsAF/hhP6DTFg2J+Kv5TgGoacdPP91LIaqTMo=;
 b=GuhOK/7DWIGKpp3AWzobrc1vb+FIRAjW1SGUmVjdCIYEtAnQs22twJf4GTJ7ADmK2MzG+ip4V7LEjajmhAhPjhpn7nervDwuDLyiXyPi09hk26vqJk1yk6wZkbyAtSPjiuISeFo+XC3X12i3/oDzVHVIs5csNZMrY9maperlEg0=
Received: from BN8PR16CA0009.namprd16.prod.outlook.com (2603:10b6:408:4c::22)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 03:49:10 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::26) by BN8PR16CA0009.outlook.office365.com
 (2603:10b6:408:4c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Fri, 9 Dec 2022 03:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 03:49:09 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 21:48:50 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/10] drm/amd/pm: fulfill powerplay peak profiling mode
 shader/memory clock settings
Date: Fri, 9 Dec 2022 11:48:09 +0800
Message-ID: <20221209034813.2373727-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209034813.2373727-1-evan.quan@amd.com>
References: <20221209034813.2373727-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|DM6PR12MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: b186254f-62a3-4895-c61d-08dad9985452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDwu0388MItZY/g+iQI85/tlTfrnPivMRL0drPcKNbmP3r/CG6l2oaKy24IPQxXIldDH8v2vAjeG6XWLMuPagO6w6AIPN/SsH8MZi2ysUAzwGVO8q97asQrvbxnc9k8x6AXm5Mu/k3+i/DfTXlGFTBofPP52mOflfhjr4Vds6qqI1FzJFVMcgIed5NW8tnPNCyu6pm+h0ajgJfgYiCr+1IJXSfsAgHLNwAgkZ3cVARGoiRrB4psCFjgcEyhncMP9oOW8EK0C7UqZuIpTuxUCKrJtUIZa/eY/VokoQdFjTbHWSNrnu6+aIxEngmANYi6yw2LSnjMJDJ79vfAtPPhVxKTc/otpCRJm8KYRg9s+i7nLPiDnEmPYxB8CeAa8PYCGsH5Yb7zyj/rxmrvjgtOydmU2wk3u4CtabuAwqvXPiesF9Pgz5dhZt5wC1kqOB4N+quR4R9zJT08xNaymTlB4rgfhtu4p3wC6Zs3rZ3EOYXi9otJyGkhoTxC18A43xDdiOAA4pPVLr0/uzM65yUiLeGHf2sAWUqU3HTdkZ1usuD15M/CPL9E5TbffoZE3iWYIxeJthuvDO06JFeDJYTbIcy0f/G/thxyHrnlgAiVB1nmbJa3iY3PUVmpfnWxal1Cd48ihONxWeL98uHV6E+Kc/yRS/2FbtlFr/LQxs34rpU6XvN/iSH0Dl56qfHjsmeMnRdKJP9g4BPRmf0Pd1xmbPqBIwScjg/HfJKacb4yA69w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(426003)(7696005)(6916009)(26005)(54906003)(6666004)(478600001)(36756003)(356005)(40480700001)(86362001)(81166007)(82740400003)(186003)(1076003)(2616005)(336012)(16526019)(83380400001)(47076005)(82310400005)(40460700003)(30864003)(2906002)(5660300002)(70206006)(8676002)(44832011)(4326008)(70586007)(8936002)(41300700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 03:49:09.8688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b186254f-62a3-4895-c61d-08dad9985452
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable peak profiling mode shader/memory clock reporting for powerplay
framework.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ied28f5921c3e72d86d8e769908910f1b11a0100b
---
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 10 ++-
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 16 +++-
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 76 +++++++++++++++----
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 16 +++-
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 31 ++++++--
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 22 ++++++
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 20 ++---
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  2 +
 8 files changed, 155 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 304190d5c9d2..8f2cc6310340 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -769,10 +769,16 @@ static int pp_dpm_read_sensor(void *handle, int idx,
 
 	switch (idx) {
 	case AMDGPU_PP_SENSOR_STABLE_PSTATE_SCLK:
-		*((uint32_t *)value) = hwmgr->pstate_sclk;
+		*((uint32_t *)value) = hwmgr->pstate_sclk * 100;
 		return 0;
 	case AMDGPU_PP_SENSOR_STABLE_PSTATE_MCLK:
-		*((uint32_t *)value) = hwmgr->pstate_mclk;
+		*((uint32_t *)value) = hwmgr->pstate_mclk * 100;
+		return 0;
+	case AMDGPU_PP_SENSOR_PEAK_PSTATE_SCLK:
+		*((uint32_t *)value) = hwmgr->pstate_sclk_peak * 100;
+		return 0;
+	case AMDGPU_PP_SENSOR_PEAK_PSTATE_MCLK:
+		*((uint32_t *)value) = hwmgr->pstate_mclk_peak * 100;
 		return 0;
 	case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
 		*((uint32_t *)value) = hwmgr->thermal_controller.fanInfo.ulMinRPM;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index ede71de2343d..86d6e88c7386 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -375,6 +375,17 @@ static int smu10_enable_gfx_off(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
+static void smu10_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
+{
+	hwmgr->pstate_sclk = SMU10_UMD_PSTATE_GFXCLK;
+	hwmgr->pstate_mclk = SMU10_UMD_PSTATE_FCLK;
+
+	smum_send_msg_to_smc(hwmgr,
+			     PPSMC_MSG_GetMaxGfxclkFrequency,
+			     &hwmgr->pstate_sclk_peak);
+	hwmgr->pstate_mclk_peak = SMU10_UMD_PSTATE_PEAK_FCLK;
+}
+
 static int smu10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -398,6 +409,8 @@ static int smu10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 			return ret;
 	}
 
+	smu10_populate_umdpstate_clocks(hwmgr);
+
 	return 0;
 }
 
@@ -574,9 +587,6 @@ static int smu10_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 
 	hwmgr->platform_descriptor.minimumClocksReductionPercentage = 50;
 
-	hwmgr->pstate_sclk = SMU10_UMD_PSTATE_GFXCLK * 100;
-	hwmgr->pstate_mclk = SMU10_UMD_PSTATE_FCLK * 100;
-
 	/* enable the pp_od_clk_voltage sysfs file */
 	hwmgr->od_enabled = 1;
 	/* disabled fine grain tuning function by default */
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 7ef7e81525a3..588e4b7d75b1 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1501,6 +1501,65 @@ static int smu7_populate_edc_leakage_registers(struct pp_hwmgr *hwmgr)
 	return ret;
 }
 
+static void smu7_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
+{
+	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_dpm_table *golden_dpm_table = &data->golden_dpm_table;
+	struct phm_clock_voltage_dependency_table *vddc_dependency_on_sclk =
+			hwmgr->dyn_state.vddc_dependency_on_sclk;
+	struct phm_ppt_v1_information *table_info =
+			(struct phm_ppt_v1_information *)(hwmgr->pptable);
+	struct phm_ppt_v1_clock_voltage_dependency_table *vdd_dep_on_sclk =
+			table_info->vdd_dep_on_sclk;
+	int32_t tmp_sclk, count, percentage;
+
+	if (golden_dpm_table->mclk_table.count == 1) {
+		percentage = 70;
+		hwmgr->pstate_mclk = golden_dpm_table->mclk_table.dpm_levels[0].value;
+	} else {
+		percentage = 100 * golden_dpm_table->sclk_table.dpm_levels[golden_dpm_table->sclk_table.count - 1].value /
+				golden_dpm_table->mclk_table.dpm_levels[golden_dpm_table->mclk_table.count - 1].value;
+		hwmgr->pstate_mclk = golden_dpm_table->mclk_table.dpm_levels[golden_dpm_table->mclk_table.count - 2].value;
+	}
+
+	tmp_sclk = hwmgr->pstate_mclk * percentage / 100;
+
+	if (hwmgr->pp_table_version == PP_TABLE_V0) {
+		for (count = vddc_dependency_on_sclk->count - 1; count >= 0; count--) {
+			if (tmp_sclk >= vddc_dependency_on_sclk->entries[count].clk) {
+				hwmgr->pstate_sclk = vddc_dependency_on_sclk->entries[count].clk;
+				break;
+			}
+		}
+		if (count < 0)
+			hwmgr->pstate_sclk = vddc_dependency_on_sclk->entries[0].clk;
+
+		hwmgr->pstate_sclk_peak =
+			vddc_dependency_on_sclk->entries[vddc_dependency_on_sclk->count - 1].clk;
+	} else if (hwmgr->pp_table_version == PP_TABLE_V1) {
+		for (count = vdd_dep_on_sclk->count - 1; count >= 0; count--) {
+			if (tmp_sclk >= vdd_dep_on_sclk->entries[count].clk) {
+				hwmgr->pstate_sclk =vdd_dep_on_sclk->entries[count].clk;
+				break;
+			}
+		}
+		if (count < 0)
+			hwmgr->pstate_sclk = vdd_dep_on_sclk->entries[0].clk;
+
+		hwmgr->pstate_sclk_peak =
+			vdd_dep_on_sclk->entries[vdd_dep_on_sclk->count - 1].clk;
+	}
+
+	hwmgr->pstate_mclk_peak =
+		golden_dpm_table->mclk_table.dpm_levels[golden_dpm_table->mclk_table.count - 1].value;
+
+	/* make sure the output is in Mhz */
+	hwmgr->pstate_sclk /= 100;
+	hwmgr->pstate_mclk /= 100;
+	hwmgr->pstate_sclk_peak /= 100;
+	hwmgr->pstate_mclk_peak /= 100;
+}
+
 static int smu7_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 {
 	int tmp_result = 0;
@@ -1625,6 +1684,8 @@ static int smu7_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 	PP_ASSERT_WITH_CODE((0 == tmp_result),
 			"pcie performance request failed!", result = tmp_result);
 
+	smu7_populate_umdpstate_clocks(hwmgr);
+
 	return 0;
 }
 
@@ -3143,15 +3204,12 @@ static int smu7_get_profiling_clk(struct pp_hwmgr *hwmgr, enum amd_dpm_forced_le
 		for (count = hwmgr->dyn_state.vddc_dependency_on_sclk->count-1;
 			count >= 0; count--) {
 			if (tmp_sclk >= hwmgr->dyn_state.vddc_dependency_on_sclk->entries[count].clk) {
-				tmp_sclk = hwmgr->dyn_state.vddc_dependency_on_sclk->entries[count].clk;
 				*sclk_mask = count;
 				break;
 			}
 		}
-		if (count < 0 || level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {
+		if (count < 0 || level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)
 			*sclk_mask = 0;
-			tmp_sclk = hwmgr->dyn_state.vddc_dependency_on_sclk->entries[0].clk;
-		}
 
 		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
 			*sclk_mask = hwmgr->dyn_state.vddc_dependency_on_sclk->count-1;
@@ -3161,15 +3219,12 @@ static int smu7_get_profiling_clk(struct pp_hwmgr *hwmgr, enum amd_dpm_forced_le
 
 		for (count = table_info->vdd_dep_on_sclk->count-1; count >= 0; count--) {
 			if (tmp_sclk >= table_info->vdd_dep_on_sclk->entries[count].clk) {
-				tmp_sclk = table_info->vdd_dep_on_sclk->entries[count].clk;
 				*sclk_mask = count;
 				break;
 			}
 		}
-		if (count < 0 || level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {
+		if (count < 0 || level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)
 			*sclk_mask = 0;
-			tmp_sclk =  table_info->vdd_dep_on_sclk->entries[0].clk;
-		}
 
 		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
 			*sclk_mask = table_info->vdd_dep_on_sclk->count - 1;
@@ -3181,8 +3236,6 @@ static int smu7_get_profiling_clk(struct pp_hwmgr *hwmgr, enum amd_dpm_forced_le
 		*mclk_mask = golden_dpm_table->mclk_table.count - 1;
 
 	*pcie_mask = data->dpm_table.pcie_speed_table.count - 1;
-	hwmgr->pstate_sclk = tmp_sclk;
-	hwmgr->pstate_mclk = tmp_mclk;
 
 	return 0;
 }
@@ -3195,9 +3248,6 @@ static int smu7_force_dpm_level(struct pp_hwmgr *hwmgr,
 	uint32_t mclk_mask = 0;
 	uint32_t pcie_mask = 0;
 
-	if (hwmgr->pstate_sclk == 0)
-		smu7_get_profiling_clk(hwmgr, level, &sclk_mask, &mclk_mask, &pcie_mask);
-
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
 		ret = smu7_force_dpm_highest(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index b50fd4a4a3d1..b015a601b385 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1016,6 +1016,18 @@ static void smu8_reset_acp_boot_level(struct pp_hwmgr *hwmgr)
 	data->acp_boot_level = 0xff;
 }
 
+static void smu8_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
+{
+	struct phm_clock_voltage_dependency_table *table =
+				hwmgr->dyn_state.vddc_dependency_on_sclk;
+
+	hwmgr->pstate_sclk = table->entries[0].clk / 100;
+	hwmgr->pstate_mclk = 0;
+
+	hwmgr->pstate_sclk_peak = table->entries[table->count - 1].clk / 100;
+	hwmgr->pstate_mclk_peak = 0;
+}
+
 static int smu8_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 {
 	smu8_program_voting_clients(hwmgr);
@@ -1024,6 +1036,8 @@ static int smu8_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 	smu8_program_bootup_state(hwmgr);
 	smu8_reset_acp_boot_level(hwmgr);
 
+	smu8_populate_umdpstate_clocks(hwmgr);
+
 	return 0;
 }
 
@@ -1167,8 +1181,6 @@ static int smu8_phm_unforce_dpm_levels(struct pp_hwmgr *hwmgr)
 
 	data->sclk_dpm.soft_min_clk = table->entries[0].clk;
 	data->sclk_dpm.hard_min_clk = table->entries[0].clk;
-	hwmgr->pstate_sclk = table->entries[0].clk;
-	hwmgr->pstate_mclk = 0;
 
 	level = smu8_get_max_sclk_level(hwmgr) - 1;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index c8c9fb827bda..6f5161738bf8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3008,6 +3008,30 @@ static int vega10_enable_disable_PCC_limit_feature(struct pp_hwmgr *hwmgr, bool
 	return 0;
 }
 
+static void vega10_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
+{
+	struct phm_ppt_v2_information *table_info =
+			(struct phm_ppt_v2_information *)(hwmgr->pptable);
+
+	if (table_info->vdd_dep_on_sclk->count > VEGA10_UMD_PSTATE_GFXCLK_LEVEL &&
+	    table_info->vdd_dep_on_mclk->count > VEGA10_UMD_PSTATE_MCLK_LEVEL) {
+		hwmgr->pstate_sclk = table_info->vdd_dep_on_sclk->entries[VEGA10_UMD_PSTATE_GFXCLK_LEVEL].clk;
+		hwmgr->pstate_mclk = table_info->vdd_dep_on_mclk->entries[VEGA10_UMD_PSTATE_MCLK_LEVEL].clk;
+	} else {
+		hwmgr->pstate_sclk = table_info->vdd_dep_on_sclk->entries[0].clk;
+		hwmgr->pstate_mclk = table_info->vdd_dep_on_mclk->entries[0].clk;
+	}
+
+	hwmgr->pstate_sclk_peak = table_info->vdd_dep_on_sclk->entries[table_info->vdd_dep_on_sclk->count - 1].clk;
+	hwmgr->pstate_mclk_peak = table_info->vdd_dep_on_mclk->entries[table_info->vdd_dep_on_mclk->count - 1].clk;
+
+	/* make sure the output is in Mhz */
+	hwmgr->pstate_sclk /= 100;
+	hwmgr->pstate_mclk /= 100;
+	hwmgr->pstate_sclk_peak /= 100;
+	hwmgr->pstate_mclk_peak /= 100;
+}
+
 static int vega10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
@@ -3082,6 +3106,8 @@ static int vega10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 				    result = tmp_result);
 	}
 
+	vega10_populate_umdpstate_clocks(hwmgr);
+
 	return result;
 }
 
@@ -4169,8 +4195,6 @@ static int vega10_get_profiling_clk_mask(struct pp_hwmgr *hwmgr, enum amd_dpm_fo
 		*sclk_mask = VEGA10_UMD_PSTATE_GFXCLK_LEVEL;
 		*soc_mask = VEGA10_UMD_PSTATE_SOCCLK_LEVEL;
 		*mclk_mask = VEGA10_UMD_PSTATE_MCLK_LEVEL;
-		hwmgr->pstate_sclk = table_info->vdd_dep_on_sclk->entries[VEGA10_UMD_PSTATE_GFXCLK_LEVEL].clk;
-		hwmgr->pstate_mclk = table_info->vdd_dep_on_mclk->entries[VEGA10_UMD_PSTATE_MCLK_LEVEL].clk;
 	}
 
 	if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {
@@ -4281,9 +4305,6 @@ static int vega10_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,
 	uint32_t mclk_mask = 0;
 	uint32_t soc_mask = 0;
 
-	if (hwmgr->pstate_sclk == 0)
-		vega10_get_profiling_clk_mask(hwmgr, level, &sclk_mask, &mclk_mask, &soc_mask);
-
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
 		ret = vega10_force_dpm_highest(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index a2f4d6773d45..33f31461ea6c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -1026,6 +1026,25 @@ static int vega12_get_all_clock_ranges(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
+static void vega12_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
+{
+	struct vega12_hwmgr *data = (struct vega12_hwmgr *)(hwmgr->backend);
+	struct vega12_single_dpm_table *gfx_dpm_table = &(data->dpm_table.gfx_table);
+	struct vega12_single_dpm_table *mem_dpm_table = &(data->dpm_table.mem_table);
+
+	if (gfx_dpm_table->count > VEGA12_UMD_PSTATE_GFXCLK_LEVEL &&
+	    mem_dpm_table->count > VEGA12_UMD_PSTATE_MCLK_LEVEL) {
+		hwmgr->pstate_sclk = gfx_dpm_table->dpm_levels[VEGA12_UMD_PSTATE_GFXCLK_LEVEL].value;
+		hwmgr->pstate_mclk = mem_dpm_table->dpm_levels[VEGA12_UMD_PSTATE_MCLK_LEVEL].value;
+	} else {
+		hwmgr->pstate_sclk = gfx_dpm_table->dpm_levels[0].value;
+		hwmgr->pstate_mclk = mem_dpm_table->dpm_levels[0].value;
+	}
+
+	hwmgr->pstate_sclk_peak = gfx_dpm_table->dpm_levels[gfx_dpm_table->count].value;
+	hwmgr->pstate_mclk_peak = mem_dpm_table->dpm_levels[mem_dpm_table->count].value;
+}
+
 static int vega12_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 {
 	int tmp_result, result = 0;
@@ -1077,6 +1096,9 @@ static int vega12_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 	PP_ASSERT_WITH_CODE(!result,
 			"Failed to setup default DPM tables!",
 			return result);
+
+	vega12_populate_umdpstate_clocks(hwmgr);
+
 	return result;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index b30684c84e20..2a5abac81b4a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -1555,26 +1555,23 @@ static int vega20_set_mclk_od(
 	return 0;
 }
 
-static int vega20_populate_umdpstate_clocks(
-		struct pp_hwmgr *hwmgr)
+static void vega20_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
 {
 	struct vega20_hwmgr *data = (struct vega20_hwmgr *)(hwmgr->backend);
 	struct vega20_single_dpm_table *gfx_table = &(data->dpm_table.gfx_table);
 	struct vega20_single_dpm_table *mem_table = &(data->dpm_table.mem_table);
 
-	hwmgr->pstate_sclk = gfx_table->dpm_levels[0].value;
-	hwmgr->pstate_mclk = mem_table->dpm_levels[0].value;
-
 	if (gfx_table->count > VEGA20_UMD_PSTATE_GFXCLK_LEVEL &&
 	    mem_table->count > VEGA20_UMD_PSTATE_MCLK_LEVEL) {
 		hwmgr->pstate_sclk = gfx_table->dpm_levels[VEGA20_UMD_PSTATE_GFXCLK_LEVEL].value;
 		hwmgr->pstate_mclk = mem_table->dpm_levels[VEGA20_UMD_PSTATE_MCLK_LEVEL].value;
+	} else {
+		hwmgr->pstate_sclk = gfx_table->dpm_levels[0].value;
+		hwmgr->pstate_mclk = mem_table->dpm_levels[0].value;
 	}
 
-	hwmgr->pstate_sclk = hwmgr->pstate_sclk * 100;
-	hwmgr->pstate_mclk = hwmgr->pstate_mclk * 100;
-
-	return 0;
+	hwmgr->pstate_sclk_peak = gfx_table->dpm_levels[gfx_table->count - 1].value;
+	hwmgr->pstate_mclk_peak = mem_table->dpm_levels[mem_table->count - 1].value;
 }
 
 static int vega20_get_max_sustainable_clock(struct pp_hwmgr *hwmgr,
@@ -1753,10 +1750,7 @@ static int vega20_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 			"[EnableDPMTasks] Failed to initialize odn settings!",
 			return result);
 
-	result = vega20_populate_umdpstate_clocks(hwmgr);
-	PP_ASSERT_WITH_CODE(!result,
-			"[EnableDPMTasks] Failed to populate umdpstate clocks!",
-			return result);
+	vega20_populate_umdpstate_clocks(hwmgr);
 
 	result = smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GetPptLimit,
 			POWER_SOURCE_AC << 16, &hwmgr->default_power_limit);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 27f8d0e0e6a8..5ce433e2c16a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -809,6 +809,8 @@ struct pp_hwmgr {
 	uint32_t workload_prority[Workload_Policy_Max];
 	uint32_t workload_setting[Workload_Policy_Max];
 	bool gfxoff_state_changed_by_workload;
+	uint32_t pstate_sclk_peak;
+	uint32_t pstate_mclk_peak;
 };
 
 int hwmgr_early_init(struct pp_hwmgr *hwmgr);
-- 
2.34.1

