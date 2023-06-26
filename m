Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130A7EB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 07:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58DC10E160;
	Mon, 26 Jun 2023 07:47:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1DB210E160
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 07:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5/IIKGMR0kcFBZ5OvELBbLj26FeB7+AYUyJiES1hA791BwOCD255HfPq2tLIX/89y4V7rOvdjMJcnJlM3646nmvbrQOM2IeJ4aK/qYrHuXV8CJqzbtuWYAJ5BhTk5Nab/PIItjNX5J9ZKMGq7dBYvlHhE41Jcea+Q8AckUYwnI2491iPicFJfuxJbWI78zhDACoBtGrpBiRCvrFltYaXHCp7O5r9uYsTc4rDOKmNVsin4b+F5dA8y7W8IGOKrx0OGY1FpwbdjjuKBWyFNKtZXwJQJxQpW1Zk6jXrdZbCvdgTC/c/0aQsQm4zTUt2A6JdHXQJU6agutaWGAhjEd2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AxDC8h+ZPyvfDcDJhWbh1blFt7F+ySMCMcCJhOoCfY=;
 b=DQQ7T6YgXY8vexJcJ/y0ASac5kpOE3/GTaS3m5py22TbKu0o5qvLqdd2Rxiih8JklSOVE4OrKQbHD6/YFTsZuTPaRNTyOABMSKT8LXTgHDIBsM8RAGLzrZDnRtSblMeqOTMNslgOZWocv8NiwprQyiYsl/2auvHebY1Z0531SJEwoVKxQ2HhFGZPhqE9YPNHWUOfZLDOSZNuB2dieOPSzt6wB9TTtMIQBLi4OuesKEfh2QrOVjeCGzaseW3fjPrPOutpbPoegFryQ1KQfQB+wr2Y2vD3QoPaH0NWMn8kEn9N3rxbdFgmZZ/6Nc8MO2UYh6oX6k3CLh98lY4gOoMS3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AxDC8h+ZPyvfDcDJhWbh1blFt7F+ySMCMcCJhOoCfY=;
 b=dEPKCFT3T1Nw2jNbasctADKtxtVE0QOryC0zniN19z9ppCu6CVmx3WJwsk3iTcqSuS1kFNt++FyO3We7OKngFX0Y8Jyu/QFyYnCRtuOlpFCRmZYfpxiXUujXRTNzkbH4KVO/DfBeK60rRI/xgkOlWFBtJatb5bopC39Wd1A+GNM=
Received: from BN1PR12CA0001.namprd12.prod.outlook.com (2603:10b6:408:e1::6)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 07:47:40 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::8a) by BN1PR12CA0001.outlook.office365.com
 (2603:10b6:408:e1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 07:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 07:47:39 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 02:47:35 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: expose swctf threshold setting for legacy
 powerplay
Date: Mon, 26 Jun 2023 15:47:12 +0800
Message-ID: <20230626074713.27397-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: b989c204-19f4-46a4-e139-08db76199df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XqirF9vmIg3W+bOU6TBjw5k0gA3eLA3DOvCb0Vz0c3zc29ssR6Iz7wNFvArWqidwXNB+lCLTC0u47WBveiemNVMixbxIcBoZM9D5K3bwzPfDxeUi6cDXQwZVBit/F8n25ty7sJkRFjRMJx4B5glVX1mC7kMlGOxFRWpb1kI/atTkioiiE7pCU/onIAl+xk23vEAKErl40wvgpjpc0ITip0lzcA3Nfz/bXakBai/AdFOdRzeC90NdRgxbPw84R36Pbq61SixwNGDifYljwWZE4zbRgALfknFPAwWqxvVKCXGrzuVpB48/PDOphKQwEnBgzIujcwR6Imo4RmThizRZCBxHFsAnlPRWWfZ7QQhfofhOBUA3Ehxla5xt+PHbjp2Db/GsMd/+GNMHaNen7z8L9E7cffUAxBuRmUBDj1sVqIb0ILDB51rS/dfLA5TnhcLpaYN+SjXBNBEIIL2Ji6r9Nqvy89zl2VdUvFB85a6EN4r72GZRrifTXgwK4kF5ufDKaTbcZStskwqOi7Uc4AcWbc3b6VnOQHFnxRWm/m4Iujup/CILJie3CYRT7PZ3CCkmOd2ov7v9p/jz6dl6BYd7U39zghaOtXgxBg4M1yaO4kx6MiCQKdAXuIa0e6vcIKfy0O3dNwCwNE2acGxTs8yRBsNnroIklTK3MVb9hc+m7GVdR4ZyfCwsF9s3scLQV5ptQton4ixBEgMvkJMbBYp3IkMm5EIX7iHOIBXKTv30+rUkcM/GghTy069jOgLIvaX684m9aBkLKeWMG16YqUg/BA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(356005)(81166007)(82740400003)(40480700001)(86362001)(1076003)(5660300002)(44832011)(2616005)(26005)(16526019)(70586007)(186003)(2906002)(478600001)(6916009)(70206006)(54906003)(4326008)(8676002)(8936002)(316002)(6666004)(7696005)(41300700001)(426003)(336012)(47076005)(83380400001)(36860700001)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 07:47:39.9181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b989c204-19f4-46a4-e139-08db76199df8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Preparation for coming optimization which eliminates the influence of
GPU temperature momentary fluctuation.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h                |  2 ++
 .../gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c   |  4 +++-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  2 ++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  | 10 ++++++++++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  |  4 ++++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |  4 ++++
 drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h     |  1 +
 7 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index a9161f3da8b5..7faad759a6cc 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -90,6 +90,8 @@ struct amdgpu_dpm_thermal {
 	int                max_mem_crit_temp;
 	/* memory max emergency(shutdown) temp */
 	int                max_mem_emergency_temp;
+	/* SWCTF threshold */
+	int                sw_ctf_threshold;
 	/* was last interrupt low to high or high to low */
 	bool               high_to_low;
 	/* interrupt source */
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
index 981dc8c7112d..90452b66e107 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
@@ -241,7 +241,8 @@ int phm_start_thermal_controller(struct pp_hwmgr *hwmgr)
 		TEMP_RANGE_MAX,
 		TEMP_RANGE_MIN,
 		TEMP_RANGE_MAX,
-		TEMP_RANGE_MAX};
+		TEMP_RANGE_MAX,
+		0};
 	struct amdgpu_device *adev = hwmgr->adev;
 
 	if (!hwmgr->not_vf)
@@ -265,6 +266,7 @@ int phm_start_thermal_controller(struct pp_hwmgr *hwmgr)
 	adev->pm.dpm.thermal.min_mem_temp = range.mem_min;
 	adev->pm.dpm.thermal.max_mem_crit_temp = range.mem_crit_max;
 	adev->pm.dpm.thermal.max_mem_emergency_temp = range.mem_emergency_max;
+	adev->pm.dpm.thermal.sw_ctf_threshold = range.sw_ctf_threshold;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index d82767866ac1..6d887ead2967 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5433,6 +5433,8 @@ static int smu7_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		thermal_data->max = data->thermal_temp_setting.temperature_shutdown *
 			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 
+	thermal_data->sw_ctf_threshold = thermal_data->max;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 6f5161738bf8..d8cd23438b76 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5242,6 +5242,9 @@ static int vega10_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
 	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
+	struct phm_ppt_v2_information *pp_table_info =
+		(struct phm_ppt_v2_information *)(hwmgr->pptable);
+	struct phm_tdp_table *tdp_table = pp_table_info->tdp_table;
 
 	memcpy(thermal_data, &SMU7ThermalWithDelayPolicy[0], sizeof(struct PP_TemperatureRange));
 
@@ -5258,6 +5261,13 @@ static int vega10_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 	thermal_data->mem_emergency_max = (pp_table->ThbmLimit + CTF_OFFSET_HBM)*
 		PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 
+	if (tdp_table->usSoftwareShutdownTemp > pp_table->ThotspotLimit &&
+	    tdp_table->usSoftwareShutdownTemp < VEGA10_THERMAL_MAXIMUM_ALERT_TEMP)
+		thermal_data->sw_ctf_threshold = tdp_table->usSoftwareShutdownTemp;
+	else
+		thermal_data->sw_ctf_threshold = VEGA10_THERMAL_MAXIMUM_ALERT_TEMP;
+	thermal_data->sw_ctf_threshold *= PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 33f31461ea6c..1069eaaae2f8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -2764,6 +2764,8 @@ static int vega12_notify_cac_buffer_info(struct pp_hwmgr *hwmgr,
 static int vega12_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		struct PP_TemperatureRange *thermal_data)
 {
+	struct phm_ppt_v3_information *pptable_information =
+		(struct phm_ppt_v3_information *)hwmgr->pptable;
 	struct vega12_hwmgr *data =
 			(struct vega12_hwmgr *)(hwmgr->backend);
 	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
@@ -2782,6 +2784,8 @@ static int vega12_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	thermal_data->mem_emergency_max = (pp_table->ThbmLimit + CTF_OFFSET_HBM)*
 		PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	thermal_data->sw_ctf_threshold = pptable_information->us_software_shutdown_temp *
+		PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 2a5abac81b4a..ff77a3683efd 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -4207,6 +4207,8 @@ static int vega20_notify_cac_buffer_info(struct pp_hwmgr *hwmgr,
 static int vega20_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		struct PP_TemperatureRange *thermal_data)
 {
+	struct phm_ppt_v3_information *pptable_information =
+		(struct phm_ppt_v3_information *)hwmgr->pptable;
 	struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
 	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
@@ -4225,6 +4227,8 @@ static int vega20_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	thermal_data->mem_emergency_max = (pp_table->ThbmLimit + CTF_OFFSET_HBM)*
 		PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	thermal_data->sw_ctf_threshold = pptable_information->us_software_shutdown_temp *
+		PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h b/drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
index a5f2227a3971..0ffc2347829d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
@@ -131,6 +131,7 @@ struct PP_TemperatureRange {
 	int mem_min;
 	int mem_crit_max;
 	int mem_emergency_max;
+	int sw_ctf_threshold;
 };
 
 struct PP_StateValidationBlock {
-- 
2.34.1

