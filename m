Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9629C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 02:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CA8C10E23A;
	Wed, 13 Dec 2023 02:48:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1640410E030
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 02:48:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsqAfIgli5Ll/jI18K8c7ZZHJDZSmCrXUaaQjrkHww6g+4XdFRyca4OFrFlyrrYIhrGObd0KhadgobRkgiakW/SrcOrRp+cnjJwoyGzH5Qktu8Lc/Z7mcK6GxIeH1IL2f4/BvVOIKL4i/bn4ZHqOfjDANLHE4aX8P9AYwbutOHGeV2FFJLJ1nEwm657u0tWKG/tpPCUsXOodBcRnq5APgXG6YRNgBicjEFCFsppOEttEGMrwpU92F6K20v94zYG3h0SNEi3IkIOiBNrmEc4vWSoseKSTzhuMlnEi2Fx5aXp9066PfphX2/rzHnqUrekQXPGr1MYzWN37q4HbAvxGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Eje4GdGOLRbj3YI/PP20LvaktERNdD+b7pANM8b1ow=;
 b=k3SfOBcz79olX9+6jXwUrb0RShASMdrs3l4EhWJrlOarbrKhJEGhEhdXEP0wLSxOy56WMRjghLTqW5Tv0VzjioBsBb4UnvmOHXXWO5sjARFxtVz6DyNHws44inR61Ej/bK77HCXfzhxLao4orNEGWsE7MNJGtE1VPySt0iKCCepOkepn1BnimYWVHEz1Gnh05tneH1Cl3rv+EEPXQXuQt6NO2FmGjUYvqHR80ciq7tbovMYoPgHBJ7ypoBo+5ErqB6iJP3RbXhPmbel6Zz8H8SBCHAjuI8YPYXJ8YYiBhUktAHSl4+zMUk2CFlYHo3GnrgeFhCN0avxpM5ixcP7Mbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Eje4GdGOLRbj3YI/PP20LvaktERNdD+b7pANM8b1ow=;
 b=4uUuhE/ILIuWeFCChehjKk2acFDI5v1EYsXRIvAd2oqAC7EB5RWrsv0ZILUgM90BDp5q7h/YZqS5FeunJnT1RuSL4uYj09WbbEPyUkP8Cj4piEOtE8w44N8g7BGKE1moZsBqbdjD/Xvr5bFEowBQLZ836TFnL+btifgUwClQpWk=
Received: from MW4PR03CA0154.namprd03.prod.outlook.com (2603:10b6:303:8d::9)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 02:47:59 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::9e) by MW4PR03CA0154.outlook.office365.com
 (2603:10b6:303:8d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Wed, 13 Dec 2023 02:47:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 02:47:59 +0000
Received: from Peytolee-HPDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 20:47:57 -0600
From: Peyton Lee <peytolee@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: support return vpe clock table
Date: Wed, 13 Dec 2023 10:49:08 +0800
Message-ID: <20231213024909.1384762-1-peytolee@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 9206f939-e7ef-4221-779e-08dbfb85eb18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQaeG/e1llJSyglh9+41Sd44qmSjn2yTNUjH/OaRb1UHnZhV2tsq5BPcKTT12yJWgNnrnzBaT0v0UoFk75/qQxMzqZGK51JpuD+kJ4GpXitjUXTefsQ/YR5mL79qwnjbNdTa6EaNw4BGBb+xA49/gPrzqz6mxA18KnEmlFIcmFhg/izp5mxpwaxzBaHmf8BXKZvpBfDLWSgA5/E71eC/rLGQAhX0V+Ekkxe3cWVRJ0H140PGdZkQ3B1MOKlPRgHbK/Wxdn4QTvY/NbQe7e8MtGBmLYz7w2m5Fa+9B+AQbtKtUCX4f2K+2t48fC0NKPzOwdFhHl+KaxU8MgX4bie2UoU8J8KaflJLZmSAyZUOkAp52AwzUQ44Tmo2R7idF/O0w2PsIOmOmj01iKRJeKx3WPoDRko5EFdz/ZtmsOxElFNQuXhMAi+jQBlxTtmERxKUsXCMPTXZ2PieFuULmm5yRPO7GJXC/FlphKUADBrTL2PxSwve4JSz1RMx8DRbt6c2IvoV6jW6AeNxla7iQdtAFZjSm2hEpENrrCRYwcAB7plPEvA6nPzU71ZAmzMo1R4cHRWatooIt2g1Eer0Sm9ygpzICV12+DDu1JPZXDVg4W/NRCDV7kR0GNCmKFdgG9iUer/Uq6xtTTSTDjr75OGeNJTgzjTcf5Yp85eUdnOdNmvRfLFE2ACMoByJOY7l0iXv/6t05Ilhse8VEgimZCYRybFJA+CNnYFZ35RztJS9xA/d6F94wxafRW5+jykM2JqegrPNmAWP2/Ynzok1GYe8Rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(36860700001)(82740400003)(356005)(81166007)(2906002)(8676002)(6666004)(7696005)(8936002)(4326008)(6916009)(54906003)(316002)(70206006)(70586007)(478600001)(5660300002)(47076005)(2616005)(336012)(426003)(1076003)(16526019)(26005)(83380400001)(41300700001)(40480700001)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 02:47:59.4966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9206f939-e7ef-4221-779e-08dbfb85eb18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Peyton Lee <peytolee@amd.com>,
 Lang Yu <lang.yu@amd.com>, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

pm supports return vpe clock table and soc clock table

Signed-off-by: Peyton Lee <peytolee@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h    |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 10 ++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 20 +++++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h b/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
index 4440d08743aa..bd7ba0a25198 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
@@ -247,6 +247,7 @@ struct pp_smu_funcs_nv {
 #define PP_SMU_NUM_MEMCLK_DPM_LEVELS  4
 #define PP_SMU_NUM_DCLK_DPM_LEVELS    8
 #define PP_SMU_NUM_VCLK_DPM_LEVELS    8
+#define PP_SMU_NUM_VPECLK_DPM_LEVELS  8
 
 struct dpm_clock {
   uint32_t  Freq;    // In MHz
@@ -262,6 +263,7 @@ struct dpm_clocks {
 	struct dpm_clock MemClocks[PP_SMU_NUM_MEMCLK_DPM_LEVELS];
 	struct dpm_clock VClocks[PP_SMU_NUM_VCLK_DPM_LEVELS];
 	struct dpm_clock DClocks[PP_SMU_NUM_DCLK_DPM_LEVELS];
+	struct dpm_clock VPEClocks[PP_SMU_NUM_VPECLK_DPM_LEVELS];
 };
 
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 97b40c5fa1ff..6627ee07d52d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -616,6 +616,16 @@ void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable)
 			  enable ? "enable" : "disable", ret);
 }
 
+void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable)
+{
+	int ret = 0;
+
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VPE, !enable);
+	if (ret)
+		DRM_ERROR("Dpm %s vpe failed, ret = %d.\n",
+			  enable ? "enable" : "disable", ret);
+}
+
 int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_version)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index d76b0a60db44..3047ffe7f244 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -445,6 +445,7 @@ void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev);
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
+void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable);
 int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_version);
 int amdgpu_dpm_handle_passthrough_sbr(struct amdgpu_device *adev, bool enable);
 int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 94ccdbfd7090..47fdbae4adfc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1085,6 +1085,25 @@ static int smu_v14_0_0_set_umsch_mm_enable(struct smu_context *smu,
 					       0, NULL);
 }
 
+static int smu_14_0_0_get_dpm_table(struct smu_context *smu, struct dpm_clocks *clock_table)
+{
+	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+	uint8_t idx;
+
+	/* Only the Clock information of SOC and VPE is copied to provide VPE DPM settings for use. */
+	for (idx = 0; idx < NUM_SOCCLK_DPM_LEVELS; idx++) {
+		clock_table->SocClocks[idx].Freq = (idx < clk_table->NumSocClkLevelsEnabled) ? clk_table->SocClocks[idx]:0;
+		clock_table->SocClocks[idx].Vol = 0;
+	}
+
+	for (idx = 0; idx < NUM_VPE_DPM_LEVELS; idx++) {
+		clock_table->VPEClocks[idx].Freq = (idx < clk_table->VpeClkLevelsEnabled) ? clk_table->VPEClocks[idx]:0;
+		clock_table->VPEClocks[idx].Vol = 0;
+	}
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.check_fw_status = smu_v14_0_check_fw_status,
 	.check_fw_version = smu_v14_0_check_fw_version,
@@ -1115,6 +1134,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.set_gfx_power_up_by_imu = smu_v14_0_set_gfx_power_up_by_imu,
 	.dpm_set_vpe_enable = smu_v14_0_0_set_vpe_enable,
 	.dpm_set_umsch_mm_enable = smu_v14_0_0_set_umsch_mm_enable,
+	.get_dpm_clock_table = smu_14_0_0_get_dpm_table,
 };
 
 static void smu_v14_0_0_set_smu_mailbox_registers(struct smu_context *smu)
-- 
2.34.1

