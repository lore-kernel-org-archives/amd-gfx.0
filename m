Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47ADCC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Nov 2022 01:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 190A010E258;
	Mon, 14 Nov 2022 01:42:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64C2A10E258
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 01:42:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SC2EGCWXsRrWIWZEWamrvpo9CJBg8AOkw2EjxDImGcVoxyI24g/4oyxz0X8LZrC5XwyE+OO1AOinAm+JlQSFrr4H3MMaWiKLKm1gjPufjAR+1uTn37K0o+Vewv4i/0BS8QX4Pv8mC0JJFfv2onjXdJwgL+gHQ8tz47KpE9SdGytQEMrUSkvlfm5kJzP408YSBTs91z12S7xh7CJ+I2MZvsS68+dSZhf8so6N4z/whf+ZnxmlbsJe8tqPvPbRZj5XX2igKWSopD0IX1nCDJUrCdLgwwENsvLZRkzRKxts2ncN261GGOCjZe2t7ZHRyBp35C2/LuOaTOeq+iOp8DwKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yE1xd8C3jMmQsX9K9Cts47K2FlUDxT36v0A8TaBhl8o=;
 b=Mec5GDRNQ82QVSlhIddknJzJSqe7q1UaVujZsigKjeTg9hUTqVes7V76zVxa6TQpOWg2pH0jN/br+bq5OiCSMCocAiPlNVBcMKGM1c48CLqnhHeI37F+BRGkj6wkm4i0pLbxmcRguTvOO1mKx+1sS+nD5yVjucD7WXkZWGtcV31PqoegvbLCuF5uiIPoX7p9orxCEK9PxUcfl1G1MebkchTMT5Gi2bIGhEXuRoWLQ7x2juMmdi9cvx1ZZl9t7XsfDQGk89ZYqE1lHNKemXZLm4lBHysTGe40d9nCHMEdW2DBAG+1Iryn2Ca6kHzk3aJGb7V25kyNwi6KHrSfQWh97w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE1xd8C3jMmQsX9K9Cts47K2FlUDxT36v0A8TaBhl8o=;
 b=avo71M40iRMIkVBOvHBjF4pfo3O8qQZ9ypomRyqRk/TElilMr4RlrQfiuZ/GqfIUsNRd5nAc0wpDmWas5X07Lfd9fW/f735gDfwiFPEgr4E5YGWKd3iSTFqXq3dURC9ntXWa7E7byA6JhcfSzOYbIOOMKBI/BUb88iaFr7KMVG8=
Received: from DM5PR08CA0039.namprd08.prod.outlook.com (2603:10b6:4:60::28) by
 CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Mon, 14 Nov 2022 01:42:47 +0000
Received: from CY4PEPF0000B8ED.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::40) by DM5PR08CA0039.outlook.office365.com
 (2603:10b6:4:60::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 14 Nov 2022 01:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8ED.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Mon, 14 Nov 2022 01:42:46 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 13 Nov
 2022 19:42:44 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd/pm: enable runpm support over BACO for SMU13.0.0
Date: Mon, 14 Nov 2022 09:42:11 +0800
Message-ID: <20221114014213.1118084-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8ED:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: bc689d3f-e0fa-448a-ea7a-08dac5e18808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WsjGhN1GIVX8gDmFP7JcKUgFBz7/bfKpQfQi07GPrtx12zR64YxFa0N7XGLM9P97mFdtLB2lqoPnDleLXg0Urag7raxdO+0CM1DeQoGN059Hj1h6b5a0HUIFTg0Ta27dd0U23HBFBQrIAJGFdAzlpGLQKJ491wowCXR8LcC4kcUI9bKpFVfUCBaPTiegwCe8yc0B6Zg8ikQw+ulLzx3GcJojhrFyxB15J80WkzywR5qixrueajnIqNvM/edWmwoG+K+MqHawcRhvtPkQfITjv/HA0YN32k5q5xg6dQzK/PLNBMWBBh1EO44if1kPlTpZ3rR9bSsRh7bHDumNhtp3M4oW+6P2nmm6gMv4i1myppqNzJoaRMihjwkwmq/d9m8FRwIO0tl3U+oWAxepPfVGDVe1VmVSkpGFDYWLCc+F/TNzg4Sypima9YKeSKLG5YFFISBQ2M5YFWldwHPwhfeeV0t4HNB4J/MoOi+gLqCgXgWIAMJhVFl0xmAQZ7z9/GecWVYkjuP40zE3EplRXEhvFvcs8luWjMRgv5BblMgehCvi8EWcfNcYGyZRqjhlszyjZIkk+7quP/Cbt/OY4CNqveVurm/bU6OEBcfH9KycfYegG7EFYGaknNzneJmvDxaB+AI2z7D7iYlHtVDeYZMLrzVievd5lyhMWTh6DSX4NweeUC6lDOn52Rpti2qFGmA6N+BBuws+GdajzcKrtSf7ghLt1XwLeYlfK3NVj+2jxIPuHOreo0Pdx4SZ/YVfigXbWz7KyqkxLAlp9LSGvxo9DRwg61PKyagGP7noJiTCIEA2iKa3nsnpMb9ZwL7oFc73
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(356005)(81166007)(36756003)(82740400003)(86362001)(40460700003)(70586007)(70206006)(6916009)(54906003)(2906002)(44832011)(41300700001)(8676002)(4326008)(5660300002)(8936002)(83380400001)(47076005)(426003)(36860700001)(6666004)(82310400005)(316002)(478600001)(7696005)(336012)(1076003)(186003)(2616005)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 01:42:46.5852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc689d3f-e0fa-448a-ea7a-08dac5e18808
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Feifei Xu <FeifeiXu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable SMU13.0.0 runpm support.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Feifei Xu <Feifei Xu@amd.com>
Change-Id: Ic40041119ef52b1949cd35291fff59f189486786
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  8 +++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  | 10 +------
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  | 11 ++-----
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  9 ++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 30 +++++++++++++++++--
 6 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 1bc26e93a83c..44bbf17e4bef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1392,6 +1392,14 @@ enum smu_cmn2asic_mapping_type {
 	CMN2ASIC_MAPPING_WORKLOAD,
 };
 
+enum smu_baco_seq {
+	BACO_SEQ_BACO = 0,
+	BACO_SEQ_MSR,
+	BACO_SEQ_BAMACO,
+	BACO_SEQ_ULPS,
+	BACO_SEQ_COUNT,
+};
+
 #define MSG_MAP(msg, index, valid_in_vf) \
 	[SMU_MSG_##msg] = {1, (index), (valid_in_vf)}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
index a9215494dcdd..d466db6f0ad4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -147,14 +147,6 @@ struct smu_11_5_power_context {
 	uint32_t	max_fast_ppt_limit;
 };
 
-enum smu_v11_0_baco_seq {
-	BACO_SEQ_BACO = 0,
-	BACO_SEQ_MSR,
-	BACO_SEQ_BAMACO,
-	BACO_SEQ_ULPS,
-	BACO_SEQ_COUNT,
-};
-
 #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3)
 
 int smu_v11_0_init_microcode(struct smu_context *smu);
@@ -257,7 +249,7 @@ int smu_v11_0_baco_enter(struct smu_context *smu);
 int smu_v11_0_baco_exit(struct smu_context *smu);
 
 int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
-				      enum smu_v11_0_baco_seq baco_seq);
+				      enum smu_baco_seq baco_seq);
 
 int smu_v11_0_mode1_reset(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 80fb583b18d9..b7f4569aff2a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -124,14 +124,6 @@ struct smu_13_0_power_context {
 	enum smu_13_0_power_state power_state;
 };
 
-enum smu_v13_0_baco_seq {
-	BACO_SEQ_BACO = 0,
-	BACO_SEQ_MSR,
-	BACO_SEQ_BAMACO,
-	BACO_SEQ_ULPS,
-	BACO_SEQ_COUNT,
-};
-
 #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3)
 
 int smu_v13_0_init_microcode(struct smu_context *smu);
@@ -218,6 +210,9 @@ int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu);
 int smu_v13_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 					       struct pp_smu_nv_clock_table *max_clocks);
 
+int smu_v13_0_baco_set_armd3_sequence(struct smu_context *smu,
+				      enum smu_baco_seq baco_seq);
+
 bool smu_v13_0_baco_is_support(struct smu_context *smu);
 
 enum smu_baco_state smu_v13_0_baco_get_state(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index dccbd9f70723..70b560737687 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1576,7 +1576,7 @@ int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu)
 }
 
 int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
-				      enum smu_v11_0_baco_seq baco_seq)
+				      enum smu_baco_seq baco_seq)
 {
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_seq, NULL);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 43fb102a65f5..89f0f6eb19f3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2230,6 +2230,15 @@ int smu_v13_0_gfx_ulv_control(struct smu_context *smu,
 	return ret;
 }
 
+int smu_v13_0_baco_set_armd3_sequence(struct smu_context *smu,
+				      enum smu_baco_seq baco_seq)
+{
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_ArmD3,
+					       baco_seq,
+					       NULL);
+}
+
 bool smu_v13_0_baco_is_support(struct smu_context *smu)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 969a5e80a74c..0855d35daebf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -140,6 +140,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(Mode1Reset,			PPSMC_MSG_Mode1Reset,                  0),
 	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         0),
 	MSG_MAP(DFCstateControl,		PPSMC_MSG_SetExternalClientDfCstateAllow, 0),
+	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
@@ -1586,6 +1587,31 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 					       NULL);
 }
 
+static int smu_v13_0_0_baco_enter(struct smu_context *smu)
+{
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
+		return smu_v13_0_baco_set_armd3_sequence(smu,
+				smu_baco->maco_support ? BACO_SEQ_BAMACO : BACO_SEQ_BACO);
+	} else
+		return smu_v13_0_baco_enter(smu);
+}
+
+static int smu_v13_0_0_baco_exit(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
+		/* Wait for PMFW handling for the Dstate change */
+		msleep(10);
+		return smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
+	} else {
+		return smu_v13_0_baco_exit(smu);
+	}
+}
+
 static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1876,8 +1902,8 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.baco_is_support = smu_v13_0_baco_is_support,
 	.baco_get_state = smu_v13_0_baco_get_state,
 	.baco_set_state = smu_v13_0_baco_set_state,
-	.baco_enter = smu_v13_0_baco_enter,
-	.baco_exit = smu_v13_0_baco_exit,
+	.baco_enter = smu_v13_0_0_baco_enter,
+	.baco_exit = smu_v13_0_0_baco_exit,
 	.mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_0_mode1_reset,
 	.set_mp1_state = smu_v13_0_0_set_mp1_state,
-- 
2.34.1

