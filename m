Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D292FC76196
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Apr 2023 05:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D11E10E79A;
	Fri,  7 Apr 2023 05:39:15 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 161C710E286
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Apr 2023 05:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPKb1OoBJG4g+pzpy67QTlhtrpzlomXQ/DUilff/WpetOs7qP3o10VV4Xe7B6TsLkncDKbsEvrnNGFTfw3r6ZXhDMeWkYFC/nFmaAdn9ogK25WINs5UDOz5U/SOiVs1nl8ZnAPJyO1qEoxEK5EU9tyBmfv5TR3fww+o6fTdiroABNIIP5JsSOD+/frJEyYtSv2oZxA5jc8V5NV2HNoBEwDpb2d8z7VjY3e9T5UwUYTBltVnz+XC6efCzQwGHRledWFphKqZS9Y3P/bbUbXkg6TLs1Zn+59tl5QJqLm2zFOvEiEmPewk4wjv7h95X/jnxlhGWZHl8apX9Q1UgXvJOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljq61GlM1Go8PJbmZVbXzmgUg8/zzhETewcQs+mdq4c=;
 b=eIbuyZj9p0qY4Yywd9yzNnwRlldUAZGByH5ZYC7zuE9CFDQzAFxJlYkd5ttHUzgoPJaLZONx5mZOdU6nk/N4PcPFoEwZ70hqETNMLwCQOy7c6F1QhtE7oZAxAMXIdKE3TWa2qd2JdHxowX0unAhO+Z5r4bOjICUPPui92u9Qykp5DGiMyyKZ1TqwPuZfgcFjqRvk6XKP+uQhx+mjsvd0m5B5VnJMffAH+JLR2wJN4huFkcw0SC2n5ZykB2JANHzZLykY9Qhx6T0xU2cSaEi5VnKb1W1Mb+4kDEBa6QJ+Fcu9+GD6PQSbNvIq7oJZnbuYIeAeS/GaRtkYWK50UXFMHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljq61GlM1Go8PJbmZVbXzmgUg8/zzhETewcQs+mdq4c=;
 b=BLvgFXJF43C3H/1h01bVPEF9assze1HbsMuINFSxgaQKJ9y7B42y/IKIPgdMbBnmNxgDREyHbqVVcAE005TlDc8ZPGUcMRpy1i1UVzWvT31n7M5sKJ3RiEJUPlZkA2JJ2nZfw2kU6reAop1BgOUc4rSi1kcTJzXrpzVphihRROQ=
Received: from MW4PR02CA0027.namprd02.prod.outlook.com (2603:10b6:303:16d::32)
 by PH7PR12MB7355.namprd12.prod.outlook.com (2603:10b6:510:20e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Fri, 7 Apr
 2023 05:39:10 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::a) by MW4PR02CA0027.outlook.office365.com
 (2603:10b6:303:16d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31 via Frontend
 Transport; Fri, 7 Apr 2023 05:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.31 via Frontend Transport; Fri, 7 Apr 2023 05:39:10 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 7 Apr
 2023 00:39:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 22:38:32 -0700
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 7 Apr 2023 00:38:29 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <evan.quan@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH v6 2/2] drm/amd/pm/vangogh: Send SMT enable message to PMFW
Date: Fri, 7 Apr 2023 13:38:22 +0800
Message-ID: <20230407053822.157046-3-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407053822.157046-1-WenYou.Yang@amd.com>
References: <20230407053822.157046-1-WenYou.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|PH7PR12MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: edd8b01d-3faf-4611-7cb9-08db372a69bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6/fsXPjP+wS/nFU4Sqjebj46tBevERYYFNDMbtfzbC/Ft+JbBg34dZJi5WPY4AZ700+kB9+5A3+bIhdIPtX5X09Pt+gCcC9LS31XEXTZZMTVu0RySkx1CQMuQCslX9Dmm2DgccM5SS4eAsLXDYcagyAlTBixC/iH3PjAj7rvCW8S0FjHjq8GXXsn64MaIO1UqLURuPdtIi2VLwd7iond0gyPTNKgqFgdw74ylvAUHwV1BUZZr6cKvb7xoOXTNoJzvFPiR1XrHjfOah8sWQYl1gLBAUU7zPvqfK3pRfYeNeVvLYDa4DTIXLtpeE/CI/6baFtdTiZI/ZYdRTTxyDJNJQGCY1sn4LUUr/jIz/cJUGXZKWBs3Ihp5r8aosyRfqfOLXbjVFBd+H29U4KfxmCzlSPc9Zi79O9ghWo/xq1lIITzlKzownAc0DWiq50snPkRZAAoulUkwY9m0mXOE2Z4jXRVmXfyHNOhoQJDorklBZcgYAHagjqWBM50t1+7lIEEUuYsRCurDgHgiL9mvrfb/s2gNFS5neZ2y2APycUGESvjTZgAAvHGhyzpLdHlv14t/2dM6sLNexrMJ0/wBEtZVFNR7yHLtac8uOyYGd8Iei/Z1CbMNrW6HQJNxZatMItO6OhxYtBDju3oJ6cR4y8GTqJuefq+q4WXFaWeYa3HmMN4wTg0l9sSTLmoL1DK6rDZLFwr++UNaMWA3RvcEHL1vaZmAFmdGrvL78me9Yn1RU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(316002)(478600001)(54906003)(40460700003)(82740400003)(6636002)(110136005)(4326008)(5660300002)(8936002)(36756003)(2906002)(82310400005)(15650500001)(40480700001)(356005)(8676002)(86362001)(70206006)(41300700001)(336012)(426003)(26005)(6666004)(81166007)(186003)(1076003)(70586007)(47076005)(2616005)(83380400001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 05:39:10.3962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edd8b01d-3faf-4611-7cb9-08db372a69bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7355
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
Cc: weiyuan2@amd.com, ying.li@amd.com, amd-gfx@lists.freedesktop.org,
 Wenyou Yang <WenYou.Yang@amd.com>, kunliu13@amd.com, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the SMT state is changed on the fly, sent the SMT enable
message to the PMFW to notify it that the SMT state changed.

Add the support to send PPSMC_MSG_SetCClkSMTEnable(0x58) message
to the PMFW for Vangogh.

Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 32 ++++++++++++++++++-
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
index 7471e2df2828..a6bfa1912c42 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
@@ -111,7 +111,8 @@
 #define PPSMC_MSG_GetGfxOffStatus		       0x50
 #define PPSMC_MSG_GetGfxOffEntryCount		       0x51
 #define PPSMC_MSG_LogGfxOffResidency		       0x52
-#define PPSMC_Message_Count                            0x53
+#define PPSMC_MSG_SetCClkSMTEnable		       0x58
+#define PPSMC_Message_Count                            0x59
 
 //Argument for PPSMC_MSG_GfxDeviceDriverReset
 enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 297b70b9388f..820812d910bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -245,7 +245,8 @@
 	__SMU_DUMMY_MAP(AllowGpo),	\
 	__SMU_DUMMY_MAP(Mode2Reset),	\
 	__SMU_DUMMY_MAP(RequestI2cTransaction), \
-	__SMU_DUMMY_MAP(GetMetricsTable),
+	__SMU_DUMMY_MAP(GetMetricsTable), \
+	__SMU_DUMMY_MAP(SetCClkSMTEnable),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 7433dcaa16e0..cda5a8ee2aeb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -141,6 +141,7 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(GetGfxOffStatus,		    PPSMC_MSG_GetGfxOffStatus,						0),
 	MSG_MAP(GetGfxOffEntryCount,		    PPSMC_MSG_GetGfxOffEntryCount,					0),
 	MSG_MAP(LogGfxOffResidency,		    PPSMC_MSG_LogGfxOffResidency,					0),
+	MSG_MAP(SetCClkSMTEnable,		    PPSMC_MSG_SetCClkSMTEnable,						0),
 };
 
 static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -460,6 +461,7 @@ static int vangogh_allocate_dpm_context(struct smu_context *smu)
 
 static int vangogh_init_smc_tables(struct smu_context *smu)
 {
+	uint32_t smu_version;
 	int ret = 0;
 
 	ret = vangogh_tables_init(smu);
@@ -477,9 +479,30 @@ static int vangogh_init_smc_tables(struct smu_context *smu)
 	smu->cpu_core_num = 4;
 #endif
 
+	if (!smu->adev->pm.fw_version) {
+		ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+		if (ret)
+			return ret;
+
+		smu->adev->pm.fw_version = smu_version;
+	}
+
+	if (smu->adev->pm.fw_version >= 0x063F0600)
+		smu_smt_timer_init(smu);
+
 	return smu_v11_0_init_smc_tables(smu);
 }
 
+static int vangogh_fini_smc_tables(struct smu_context *smu)
+{
+	if (smu->adev->pm.fw_version >= 0x063F0600)
+		smu_smt_timer_fini(smu);
+
+	smu_v11_0_fini_smc_tables(smu);
+
+	return 0;
+}
+
 static int vangogh_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 {
 	int ret = 0;
@@ -2428,12 +2451,18 @@ static u32 vangogh_get_gfxoff_entrycount(struct smu_context *smu, uint64_t *entr
 	return ret;
 }
 
+static int vangogh_set_cpu_smt_enable(struct smu_context *smu, bool enable)
+{
+	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetCClkSMTEnable,
+					       enable ? 1 : 0, NULL);
+}
+
 static const struct pptable_funcs vangogh_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.init_smc_tables = vangogh_init_smc_tables,
-	.fini_smc_tables = smu_v11_0_fini_smc_tables,
+	.fini_smc_tables = vangogh_fini_smc_tables,
 	.init_power = smu_v11_0_init_power,
 	.fini_power = smu_v11_0_fini_power,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
@@ -2474,6 +2503,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.get_power_limit = vangogh_get_power_limit,
 	.set_power_limit = vangogh_set_power_limit,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
+	.set_cpu_smt_enable = vangogh_set_cpu_smt_enable,
 };
 
 void vangogh_set_ppt_funcs(struct smu_context *smu)
-- 
2.39.2

