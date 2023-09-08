Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932DAEE57E4
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 08:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FC6B10E885;
	Fri,  8 Sep 2023 08:39:27 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2517310E88A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 08:39:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5dTSphNWqMvhoznp3xsM7ChyFq+2liJbk/d0tKJMEb0FbPu/2BZ2BvzUkebRr8mUf6pmrvM+eync64h0uZrejUKjnWIxMDq+51WwinpaY0nBGlxbR9k3ndoqc1Vend98BtWK5+miuTK1GnzZ8rpEE84lwoljcbmXLjGRIksu+s2p6o5lErAjF4k3l8sAzdEQrQYMDpd7VKhmZSWREzW+UfPfrpz2vrhmvojPzc6rLffKxHR9I82a3nGU+dwHCdrFFNafYM7yzs5tQz87RxxZTUCCRvg2XX5nkwxAZFNQPIuqp2ptSztLe2qtVwCm0heF5Fi+TRq2HPav0vfQ+e1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUjXjrdJHB+Em8qlLwK+SVjGXYuqFbu7hFD1Nc7hH4A=;
 b=C4lYbXo2F87nCLrDD3xKSsYNv/G8kbVAAOB034BgT1yuhc7XNayl+aczzov/q9is/CYEfrniRFRigvUzns+ZbHjy7AADMzs81sPlFR3xDsJ6QP3aVR5ESBkSVzwfa0jLR1Tf/Rck54q1KwkAE59HxgnMk72WRxPv2qxv/5ofZGiOaT151HZrfESx5562lVv9s0lLrvyleQEVZURsU5e3RMeaI4z8MPF6Ldr2t2EgQMnjGQ2u7Jzcx7OILF6RRmDa4lRiyMyXXga7AJOOTmEOMP6RMkIqlJyLAGUOvMwQAYexx4aujcarcyGN5BTAhQY1kAB+IsMt2bDW5rAq8fk6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUjXjrdJHB+Em8qlLwK+SVjGXYuqFbu7hFD1Nc7hH4A=;
 b=VFPfUgVs52M5UaLCw/DnVWCrilhXZv/qLxOtVVjMfjMXV7p1BSKXYY0L/VFNagixiTnrYG31Y0s/clp55BbAXk8fh1tAVItuQ3MoEICpsI81K2+mirDgtop4aop8kUgjDNCUIqXxzrMykijxod8tJeEf8o4mLSI9TDQawWTA9FQ=
Received: from MW4PR04CA0160.namprd04.prod.outlook.com (2603:10b6:303:85::15)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 08:39:22 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::2e) by MW4PR04CA0160.outlook.office365.com
 (2603:10b6:303:85::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Fri, 8 Sep 2023 08:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Fri, 8 Sep 2023 08:39:21 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 03:39:20 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amd/pm: enable smu_v13_0_6 mca debug mode when UMC
 RAS feature is enabled
Date: Fri, 8 Sep 2023 16:39:04 +0800
Message-ID: <20230908083904.2509460-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908083904.2509460-1-kevinyang.wang@amd.com>
References: <20230908083904.2509460-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 213ceaed-282a-49dc-3edf-08dbb0471983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3M3GhWGsKmVXEjaC7KcIwx3l+nhaTpMTIBZaxTpItxuZ9k1WNDUjMmWEu/oflqmb/Qou2Lyny1JK7L8r6LPtgAOba6vOZLRhG4OmXLZjhejKh4wHVuCxoob/3PKpDUKMgjhFKzLbyUOljc6wI7NOMB8A7DlVLSluU6M/LNAcfq6XdwVlNvIPp8097Ib9ghQZcg6DSVFUEsl5fFjesbwdoyQlAeC0G0Oe1sVC25EdNxfkxC0ssxv9ND4l5Nc6NnE732VQxSZojbJ9dBtN9xidMW604dE9duB7DNbskKcsPtNJEZzMhhNcjH2qOW8rUOYVBH/g3/UzNWJlQ21IUqFE/bLjFHgzodqro0mnfsRTqve2MEvfDT1jgv7SazEmmHL/hMWKTY7NP8N8mExWC74q938a8nL7mNop87Z0HF/d8iEuMeH+I+EYMa5mwvMta3obpP4519RtQEvqVUGPHnR3KMcMDcn51meN9uVLMdoMUGfN1YGwXJyEC73d8tUPJ7ITl5bdk/Zpn+Qz1VEIwJzkcvEKK08fWMqgwvUqJPh/RluT4unfOaw9TwYHUFqVV3meO0uwNgdfNxcZq/rN8jEGqHspwHJ5KE/XOgptvr+dk97CJvRFmTJ2qv/FT/NDm+B333cMp7+xofv6Qu06qmJZnsPWcEZ3sPeUFif/XMxzRyWIIaqf90pcutnN79grgx0gtejENz5IvHVVA57vIrhll4k/OtFu4r+i5oZXjkGlxey/+H3I80vlrEjgjh4EQo8wJP85XPf5a0Xs4aK/mxfLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(82310400011)(451199024)(186009)(1800799009)(46966006)(40470700004)(36840700001)(82740400003)(6666004)(7696005)(2616005)(1076003)(83380400001)(478600001)(426003)(2906002)(26005)(16526019)(336012)(6916009)(70586007)(41300700001)(54906003)(40460700003)(8936002)(8676002)(316002)(4326008)(5660300002)(86362001)(36860700001)(40480700001)(36756003)(47076005)(70206006)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 08:39:21.8849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 213ceaed-282a-49dc-3edf-08dbb0471983
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197
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
Cc: Yang Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v1:
enable smu_v13_0_6 mca debug mode when UMC RAS feature is enabled.

v2:
use amdgpu_ras_is_supported() helper function instead bitmask check.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 26 +++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index ebc789e7a289..f762c01b98a5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -247,7 +247,8 @@
 	__SMU_DUMMY_MAP(Mode2Reset),	\
 	__SMU_DUMMY_MAP(RequestI2cTransaction), \
 	__SMU_DUMMY_MAP(GetMetricsTable), \
-	__SMU_DUMMY_MAP(DALNotPresent),
+	__SMU_DUMMY_MAP(DALNotPresent), \
+	__SMU_DUMMY_MAP(ClearMcaOnRead),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ff58ee14a68f..e69e82deae54 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -133,6 +133,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(SetSoftMaxGfxClk,                    PPSMC_MSG_SetSoftMaxGfxClk,                0),
 	MSG_MAP(PrepareMp1ForUnload,                 PPSMC_MSG_PrepareForDriverUnload,          0),
 	MSG_MAP(GetCTFLimit,                         PPSMC_MSG_GetCTFLimit,                     0),
+	MSG_MAP(ClearMcaOnRead,	                     PPSMC_MSG_ClearMcaOnRead,                  0),
 };
 
 static const struct cmn2asic_mapping smu_v13_0_6_clk_map[SMU_CLK_COUNT] = {
@@ -1393,6 +1394,20 @@ static int smu_v13_0_6_notify_unload(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool enable)
+{
+	uint32_t smu_version;
+
+	/* NOTE: this ClearMcaOnRead message is only supported for smu version 85.72.0 or higher */
+	smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (smu_version < 0x554800)
+		return 0;
+
+	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
+					       enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK | ClearMcaOnRead_CE_POLL_MASK,
+					       NULL);
+}
+
 static int smu_v13_0_6_system_features_control(struct smu_context *smu,
 					       bool enable)
 {
@@ -2182,6 +2197,16 @@ static int smu_v13_0_6_smu_send_hbm_bad_page_num(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_6_post_init(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (!amdgpu_sriov_vf(adev) && amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+		return smu_v13_0_6_mca_set_debug_mode(smu, true);
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = smu_v13_0_6_get_allowed_feature_mask,
@@ -2235,6 +2260,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.i2c_init = smu_v13_0_6_i2c_control_init,
 	.i2c_fini = smu_v13_0_6_i2c_control_fini,
 	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
+	.post_init = smu_v13_0_6_post_init,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

