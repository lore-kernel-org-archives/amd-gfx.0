Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873CFC001DB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 14:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A7A110E18F;
	Tue, 15 Aug 2023 14:29:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA80D10E18F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 14:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T72tjJjNVRL7Q98gw2BbJi8vgg0maWnRPJ1ssXzGjIrf+ZuPnxeFVTynuupl70n2VJgD7wVQMKozu+9MPMlETIs0j+UhoFWbSbEFDmkBcAOKdEQIjjjL8g+h2mQnnaP4Ovad66rYvFXPFjtEax227HrCAllK2I+Yq9ukJC4pBGsjAHC3Q/5ZOrK9mfMeatHDstAULNjtv2DYCkxPw6gh5Xq4qeJaIXF59PCI9EOaYmJV/o2vEwLutgcUO9HA4EvsdOPvYwipkciKiO58k44muDZ/AUGH7A5FufkWDu3abYu2Q0afWC0RtwV0P2Ejvxw9HuBgWXukn9B8VOuXaXAtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfQwNNuNddhlP62kQYa7aJ1//ZPT8rjeeKk/S1RKkF0=;
 b=WATMqHNJGJnJ9cUhup0Crrirk4Ai4/46WgYKLQrn4T48DHqxdCrk2dPQDhVom1e61cfSft57T/N1RhSzM/2J1zYiYNqqoTNp2tN12mXJyEWgtOZ6MtoL5qzRrUs7BUCdebpP5hiIhsW56O2LzyNoXmMs+9fN/vUsA+xlqteneusAu7+YgDCNnff/3MDRS2SFM9HyjK/lGCD94GoXlFGaLpwLAUWEY5/crLdrQUtBSvf+o9IyLIM5xdWF44fIBDgEqeEEOaUfi6+oVNqeVsxcUJyAdD+jHuoOpe0XvHMPOvR+UPz9vyk00OryOqH5MU1otlWexaukZ57CCBQoahpQng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfQwNNuNddhlP62kQYa7aJ1//ZPT8rjeeKk/S1RKkF0=;
 b=cE6sICyciQWDO4NuXaa8Bv0ijrieTJcsuvkAfU2MkzwFITdpAuMf37iwcNEciBfyr4WdnPhxUs/jEQG3bMviYoLOLyc384Kd0bCSHeqAlgkOrs2VJsscyN77Ik7HqN2HywPWvIpTHEV/XUYLQw9KatTJ4cbSWYy1qiwKeEktUF0=
Received: from SA9PR13CA0176.namprd13.prod.outlook.com (2603:10b6:806:28::31)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 14:29:31 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:28:cafe::ea) by SA9PR13CA0176.outlook.office365.com
 (2603:10b6:806:28::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 15 Aug 2023 14:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 14:29:30 +0000
Received: from navi32bu-james.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 09:29:28 -0500
From: Bokun Zhang <bokun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/pm: Add notification function for no DC support
Date: Tue, 15 Aug 2023 10:29:07 -0400
Message-ID: <20230815142907.196429-1-bokun.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c18d42a-c921-4136-7fe8-08db9d9c09db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xa3cIdZNVwyWc59ozXHtD6H1c7qjF03gJgq4HruWb2S3mWTqnN/RqrS5FzRJIC5yScZWeIJ1hm0TvgeBX2l+JZVNsX24nhUpgZrzx2dJHNtVSWC2ZF1IVS2stR3qivGh+GgKXqawrsJGiQB8wSVVxa06LQL+nM8k1rohYI2sWsFW2C6dOttMDqCLCUXZwJ4Ll7VNIUawgr47+Xmch9InLy6ixSbZu+RAZqnMyg7tFNj2ao3DIqSwgQC4R2u+UKoDS/LGhPax79QvHwL22DPiw3Bawo34al819puXXB2G8z3/lSm+ITj1nez2SDtw04oRMAVEssiv6QIJVqlCY3Vpeu6O6joeVbF0mHdtbzK+hfJqEuXWVdUdP8UqNyNtySW/Z0MUsK3N7RIzQs0+BTBkbzo18xtd/UOreKtk4tlVBB/IlnmR20OVFvD/p8MTGqiFtA/+sKSp5nZPs1DxWdz2UTGqcepgnbojDwQUgM+FS5uee6C3rhXGvkrwhNwPmjEOPJGDpQiIcYlAmgigjBxGfBTVzgOiiy37v41IVDekdkQPMGn2OkYAMQYkTaZFLs6rxLjw1vgm2uABNRRnEtK91Ob+DKFAvxD2wOm3FK50QUoLfte4FDMQyQHsoeT96E/7YyPpJOfOC32cvhsSZre6VMTh/dOZylEsIaFLw+IZ5evgylYqm1k8woYXsV7E8aG1uKMGi4Ua2T0UkxYzPJBHbkr5EG6/SpXMu/lB8pJ7BvUBWNUOaNawppXZz/uHJkflEcIh8adIwBtnBlwrr9x+nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199024)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(8936002)(5660300002)(6916009)(54906003)(478600001)(16526019)(2906002)(26005)(44832011)(2616005)(1076003)(7696005)(36756003)(86362001)(47076005)(70586007)(70206006)(4326008)(36860700001)(40460700003)(15650500001)(82740400003)(356005)(6666004)(40480700001)(81166007)(41300700001)(316002)(426003)(83380400001)(336012)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 14:29:30.8271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c18d42a-c921-4136-7fe8-08db9d9c09db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
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
Cc: Bokun Zhang <bokun.zhang@amd.com>, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- There is a DPM issue where if DC is not present,
  FCLK will stay at low level.
  We need to send a SMU message to configure the DPM

Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                  | 6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h              | 5 +++++
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h   | 5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h               | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c       | 7 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h                | 1 +
 6 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f005a90c35af..274c6ba534b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1410,6 +1410,12 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
+	if (!amdgpu_device_has_dc_support(adev)) {
+		ret = smu_notify_no_dc(smu);
+		if (ret)
+			dev_warn(adev->dev, "Failed to notify no dal support, driver may not reach best performance\n");
+	}
+
 	/*
 	 * Set min deep sleep dce fclk with bootup value from vbios via
 	 * SetMinDeepSleepDcefclk MSG.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 6e2069dcb6b9..c8fdc3d0aa25 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1356,6 +1356,11 @@ struct pptable_funcs {
 	 * @init_pptable_microcode: Prepare the pptable microcode to upload via PSP
 	 */
 	int (*init_pptable_microcode)(struct smu_context *smu);
+
+	/**
+	 * @notify_no_dal: Notify SMU that there is no display and SMU should control DPM
+	 */
+	int (*notify_no_dc)(struct smu_context *smu);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
index 10cff75b44d5..e2ee855c7748 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
@@ -138,7 +138,10 @@
 #define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A
 #define PPSMC_MSG_SetPriorityDeltaGain           0x4B
 #define PPSMC_MSG_AllowIHHostInterrupt           0x4C
-#define PPSMC_Message_Count                      0x4D
+
+#define PPSMC_MSG_DALNotPresent                  0x4E
+
+#define PPSMC_Message_Count                      0x4F
 
 //Debug Dump Message
 #define DEBUGSMC_MSG_TestMessage                    0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 297b70b9388f..f71fc99447f2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -245,7 +245,8 @@
 	__SMU_DUMMY_MAP(AllowGpo),	\
 	__SMU_DUMMY_MAP(Mode2Reset),	\
 	__SMU_DUMMY_MAP(RequestI2cTransaction), \
-	__SMU_DUMMY_MAP(GetMetricsTable),
+	__SMU_DUMMY_MAP(GetMetricsTable), \
+	__SMU_DUMMY_MAP(DALNotPresent),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 48b03524a52d..41412cf891a7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -160,6 +160,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
 	MSG_MAP(AllowIHHostInterrupt,		PPSMC_MSG_AllowIHHostInterrupt,       0),
 	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt,       0),
+	MSG_MAP(DALNotPresent,		PPSMC_MSG_DALNotPresent,       0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
@@ -2601,6 +2602,11 @@ static ssize_t smu_v13_0_0_get_ecc_info(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_0_notify_no_dc(struct smu_context *smu)
+{
+	return smu_cmn_send_smc_msg(smu, SMU_MSG_DALNotPresent, NULL);
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
@@ -2680,6 +2686,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.send_hbm_bad_channel_flag = smu_v13_0_0_send_bad_mem_channel_flag,
 	.gpo_control = smu_v13_0_gpo_control,
 	.get_ecc_info = smu_v13_0_0_get_ecc_info,
+	.notify_no_dc = smu_v13_0_0_notify_no_dc,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index bcc42abfc768..9b9a13fdcef8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -97,6 +97,7 @@
 #define smu_get_default_config_table_settings(smu, config_table)	smu_ppt_funcs(get_default_config_table_settings, -EOPNOTSUPP, smu, config_table)
 #define smu_set_config_table(smu, config_table)				smu_ppt_funcs(set_config_table, -EOPNOTSUPP, smu, config_table)
 #define smu_init_pptable_microcode(smu)					smu_ppt_funcs(init_pptable_microcode, 0, smu)
+#define smu_notify_no_dc(smu)						smu_ppt_funcs(notify_no_dc, 0, smu)
 
 #endif
 #endif
-- 
2.25.1

