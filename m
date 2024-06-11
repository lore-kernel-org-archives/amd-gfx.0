Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1EFC25B76
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 04:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0BE010E086;
	Tue, 11 Jun 2024 04:25:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uNEUtsOJ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B770710E086
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 04:25:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HA4euzp/3g5a/gB/AOyrpa9DiO9E8qm8YByXUNmgB6ndl1VKn2TJhbf9kwH7c+F8/RXXKC9TssVHSEQO+lgYyvA2ZCAmPpaZmtlx9wTfDuViGV30Z/WOxZro7J+jFiZiVsNEF7GcYYFwta+8w3K5m1BwMuxwkACUC7s+ys05ga7ZubbYBXKSTsSP1VeHHf3PNEEeUKSniidsVFvQgxfB6VezDDtf6gQF6+yQdgDAjSnWb7WOK3DGuTw9LBPQXykvosLY+XCizrjmPR5jNqWXzulFtBopGmFCDXPT+9Uxwp7bbetOB6hvJmAHxCDZlmq4il1Yif5aWMFVh2Jb+bGGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGZiI+aAxDfzgN/Hc36c3RV6bPUsGXhfJcWwcBGnO3c=;
 b=kVGCJYSNus5z6u5ihe65feozKtVPRmiCSmDySz3bxyX/+NpafTU5EKTTJUuq0975uIXCjYBZI+zTjgFQQiyaBxa4tE3RrPYuEeFkLxqH897k5gPz1T9oktZ1R8+C/NxYgWzdyaKIgKeCx4enZko6XDeX3GqMY5c5bFRIdfnarX0d7osTwHx97hKB61Nle305P9irlBMfl7aHmW3N0mMmWLqua34Vuv6NlhP6k4IEqQDQpNprTpUfbe1n5J7igDwwxl6FG/ouWl9EXdkRkWTPZ4eKezCNJtxoliy2Itd5PPw2x8Je9o0iecCbKELI4Eab7rUUEhshT1M+K/i6VnUiuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGZiI+aAxDfzgN/Hc36c3RV6bPUsGXhfJcWwcBGnO3c=;
 b=uNEUtsOJERwORnHncXi2xfzis1P56T8FbHDo4JpTz2Z4nc11thZ8Vwy6TnGxnOYaDNn6AcFLs/Il+LO06fgaP8tePvf80EoE0VLydfC9Q+tZcAacdHF610i92j7F/mJxMIQK5zjVrHfm0LvDRnTF+fth1/Iwe+CmvQflPqB255U=
Received: from SN7PR04CA0109.namprd04.prod.outlook.com (2603:10b6:806:122::24)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 04:25:02 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::ed) by SN7PR04CA0109.outlook.office365.com
 (2603:10b6:806:122::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 04:25:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 04:25:02 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 23:24:59 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <yifan1.zhang@amd.com>, Li Ma <li.ma@amd.com>, Tim Huang <Tim.Huang@amd.com>
Subject: [PATCH] drm/amd/swsmu: add MALL init support workaround for
 smu_v14_0_1
Date: Tue, 11 Jun 2024 12:24:40 +0800
Message-ID: <20240611042440.1988379-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a671a4-c3d9-4538-568a-08dc89ce76b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/ldBOGdBHJwQ+8eL3rSOxSZA5wetYcDh3M3yX8d8QMlIovBqOh4q8A20Cplr?=
 =?us-ascii?Q?QMdnQu8vI1689n7JtTW6QImJ/LKuDJq69YMYiSiaj/CxhXcsPueOO8oYZjBu?=
 =?us-ascii?Q?l3TdSPfZkmvARWqHV/ec66iWJ6MmtJQfOSH3KWsD2oOmbiBMgRxocRNaDGMi?=
 =?us-ascii?Q?YgeOF8bcr+/XmHziWZFOb6m+yCNEhziRtjonRmiP7tVU0kvgytETShjXoI1z?=
 =?us-ascii?Q?UAhawRogRnu6/VIGrX3nyfXUq8oygyXoLUInx5nnsOrl4VEG7MtOG5fQCEuZ?=
 =?us-ascii?Q?oySsx1c/ltUaL/n6f8Zzrq3gBqR+LGNanPRaBxGhpDKIK/woqk8Qc+AWrFpd?=
 =?us-ascii?Q?fLoNsH321TjpXwQPXh9e5DJNtVx0+KlpeljudVvFrgQYTNck+9Nroo5DyGns?=
 =?us-ascii?Q?D7vE0v/wCiUUfBWpOOunbVn5nwxQ8xeEgmYj0QOJPip+g2I8583WXCeiUsdx?=
 =?us-ascii?Q?8xsYP584CcntU0BXbKLGgkMohDULB/SlTHXxFnFiyGLi3wZPUo/ppzJsF5JN?=
 =?us-ascii?Q?3Ka6/zyAVHZ6eaAdXeSXZ1PQ6aVxh08pVoOsPbobjAQCRanHV/fEJRQyofPQ?=
 =?us-ascii?Q?obTLyZcZPFzD93RVg4xNc5QJpYn+WYn38JN/nGNYN0gCRQ/hs/qdQDcSPXGX?=
 =?us-ascii?Q?SCK4/djED649q6fBxa1W6S+W+dHsBtlRYKZkgEs6CpoHlFzgNhsl/OZZJShQ?=
 =?us-ascii?Q?Sk5//meBaKcdpCW73JHA3hWRHogcRsOPwNxLScHdjaksmxnCn9nqb4PyxnDI?=
 =?us-ascii?Q?fbBrV9JtHydPNcWOBnmZAA4fjG5i/kbCHzz1vBVQN+V8oQrHPKXokArdxyfA?=
 =?us-ascii?Q?5IVN+YY1v1NyU0EaK9LT6p0xkbP2BhwX6Idr5uZg+bB8K1/BT322v4omyyJc?=
 =?us-ascii?Q?Wc5gAzNEXNupaH8lh/b6NT191LP8cOz12LQ/iQi4q1DQlk9EhAscyM4wvkbA?=
 =?us-ascii?Q?e8MH8Ca3eiCWJOgwV/23WniQ8turD8CZhirO7NlBtD1+HnZoT9E/UD5+QQ7s?=
 =?us-ascii?Q?2ajOATRv/j4iND3zdR+YCARMk414qtLaljy3p/2eOCO6CkaEzGaENASJyiNK?=
 =?us-ascii?Q?0oan+BKi4lhcAx0V1JuDait1OKqTb31qlp9IaJMwbnqXiAgzXCD4xB6/YLt4?=
 =?us-ascii?Q?I0CtOJ6kJnJqaRSKqEiOMnquF+h8e92uT+arYLxceUg5uLMP49XWxfKLlZzJ?=
 =?us-ascii?Q?eYuWZE/4kN/ODx/j70FNvJm5abvFfl7Fn8qRrSocQU5+mfPRcBu/yFN0OYZ6?=
 =?us-ascii?Q?i52pg21YpdIGUt+5q5oK17pWHiytneS5eUJVkghfKsAQQvGtVynF2G/+ztQG?=
 =?us-ascii?Q?Qk+24aA5aKDux7eayoRaIWRmc6JTq69eLR6oCIZQK229m+W6CbEa7W18EABl?=
 =?us-ascii?Q?ZWLSI5cA88GrqwXJ9vz6RN0ju7CZq/gEu0B0Tr23T0oQPARClA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 04:25:02.6784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a671a4-c3d9-4538-568a-08dc89ce76b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
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

[Why]
SMU firmware has not supported MALL PG.

[How]
Disable MALL PG and make it always on until SMU firmware is ready.

Signed-off-by: Li Ma <li.ma@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 13 ++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 ++
 .../pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h  |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  4 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 73 +++++++++++++++++++
 5 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6f742d88867d..8e694b576d1c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -325,6 +325,18 @@ static int smu_dpm_set_umsch_mm_enable(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_set_mall_enable(struct smu_context *smu)
+{
+	int ret = 0;
+
+	if (!smu->ppt_funcs->set_mall_enable)
+		return 0;
+
+	ret = smu->ppt_funcs->set_mall_enable(smu);
+
+	return ret;
+}
+
 /**
  * smu_dpm_set_power_gate - power gate/ungate the specific IP block
  *
@@ -1804,6 +1816,7 @@ static int smu_hw_init(void *handle)
 		smu_dpm_set_jpeg_enable(smu, true);
 		smu_dpm_set_vpe_enable(smu, true);
 		smu_dpm_set_umsch_mm_enable(smu, true);
+		smu_set_mall_enable(smu);
 		smu_set_gfx_cgpg(smu, true);
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3f94c33df7b7..a34c802f52be 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1408,6 +1408,11 @@ struct pptable_funcs {
 	 */
 	int (*dpm_set_umsch_mm_enable)(struct smu_context *smu, bool enable);
 
+	/**
+	 * @set_mall_enable: Init MALL power gating control.
+	 */
+	int (*set_mall_enable)(struct smu_context *smu);
+
 	/**
 	 * @notify_rlc_state: Notify RLC power state to SMU.
 	 */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
index c4dc5881d8df..e7f5ef49049f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
@@ -106,8 +106,8 @@
 #define PPSMC_MSG_DisableLSdma                  0x35 ///< Disable LSDMA
 #define PPSMC_MSG_SetSoftMaxVpe                 0x36 ///<
 #define PPSMC_MSG_SetSoftMinVpe                 0x37 ///<
-#define PPSMC_MSG_AllocMALLCache                0x38 ///< Allocating MALL Cache
-#define PPSMC_MSG_ReleaseMALLCache              0x39 ///< Releasing MALL Cache
+#define PPSMC_MSG_MALLPowerController           0x38 ///< Set MALL control
+#define PPSMC_MSG_MALLPowerState                0x39 ///< Enter/Exit MALL PG
 #define PPSMC_Message_Count                     0x3A ///< Total number of PPSMC messages
 /** @}*/
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index dff36bd7a17c..12a7b0634ed5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -273,7 +273,9 @@
 	__SMU_DUMMY_MAP(GetMetricsVersion), \
 	__SMU_DUMMY_MAP(EnableUCLKShadow), \
 	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold),\
-	__SMU_DUMMY_MAP(SelectPstatePolicy),
+	__SMU_DUMMY_MAP(SelectPstatePolicy), \
+	__SMU_DUMMY_MAP(MALLPowerController), \
+	__SMU_DUMMY_MAP(MALLPowerState),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index e4419e1561ef..18abfbd6d059 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -52,6 +52,19 @@
 #define mmMP1_SMN_C2PMSG_90			0x029a
 #define mmMP1_SMN_C2PMSG_90_BASE_IDX		    0
 
+/* MALLPowerController message arguments (Defines for the Cache mode control) */
+#define SMU_MALL_PMFW_CONTROL 0
+#define SMU_MALL_DRIVER_CONTROL 1
+
+/*
+ * MALLPowerState message arguments
+ * (Defines for the Allocate/Release Cache mode if in driver mode)
+ */
+#define SMU_MALL_EXIT_PG 0
+#define SMU_MALL_ENTER_PG 1
+
+#define SMU_MALL_PG_CONFIG_DEFAULT SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
@@ -66,6 +79,12 @@
 	FEATURE_MASK(FEATURE_GFX_DPM_BIT)	| \
 	FEATURE_MASK(FEATURE_VPE_DPM_BIT))
 
+enum smu_mall_pg_config {
+	SMU_MALL_PG_CONFIG_PMFW_CONTROL = 0,
+	SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON = 1,
+	SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_OFF = 2,
+};
+
 static struct cmn2asic_msg_mapping smu_v14_0_0_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,				1),
 	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetPmfwVersion,			1),
@@ -113,6 +132,8 @@ static struct cmn2asic_msg_mapping smu_v14_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(PowerDownUmsch,                 PPSMC_MSG_PowerDownUmsch,			1),
 	MSG_MAP(SetSoftMaxVpe,                  PPSMC_MSG_SetSoftMaxVpe,			1),
 	MSG_MAP(SetSoftMinVpe,                  PPSMC_MSG_SetSoftMinVpe,			1),
+	MSG_MAP(MALLPowerController,            PPSMC_MSG_MALLPowerController,		1),
+	MSG_MAP(MALLPowerState,                 PPSMC_MSG_MALLPowerState,			1),
 };
 
 static struct cmn2asic_mapping smu_v14_0_0_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -1423,6 +1444,57 @@ static int smu_v14_0_common_get_dpm_table(struct smu_context *smu, struct dpm_cl
 	return 0;
 }
 
+static int smu_v14_0_1_init_mall_power_gating(struct smu_context *smu, enum smu_mall_pg_config pg_config)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	if (pg_config == SMU_MALL_PG_CONFIG_PMFW_CONTROL) {
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALLPowerController,
+								SMU_MALL_PMFW_CONTROL, NULL);
+		if (ret) {
+			dev_err(adev->dev, "Init MALL PMFW CONTROL Failure\n");
+			return ret;
+		}
+	} else {
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALLPowerController,
+								SMU_MALL_DRIVER_CONTROL, NULL);
+		if (ret) {
+			dev_err(adev->dev, "Init MALL Driver CONTROL Failure\n");
+			return ret;
+		}
+
+		if (pg_config == SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON) {
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALLPowerState,
+									SMU_MALL_EXIT_PG, NULL);
+			if (ret) {
+				dev_err(adev->dev, "EXIT MALL PG Failure\n");
+				return ret;
+			}
+		} else if (pg_config == SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_OFF) {
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALLPowerState,
+									SMU_MALL_ENTER_PG, NULL);
+			if (ret) {
+				dev_err(adev->dev, "Enter MALL PG Failure\n");
+				return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static int smu_v14_0_common_set_mall_enable(struct smu_context *smu)
+{
+	enum smu_mall_pg_config pg_config = SMU_MALL_PG_CONFIG_DEFAULT;
+	int ret = 0;
+
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
+		ret = smu_v14_0_1_init_mall_power_gating(smu, pg_config);
+
+	return ret;
+}
+
 static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.check_fw_status = smu_v14_0_check_fw_status,
 	.check_fw_version = smu_v14_0_check_fw_version,
@@ -1454,6 +1526,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.dpm_set_vpe_enable = smu_v14_0_0_set_vpe_enable,
 	.dpm_set_umsch_mm_enable = smu_v14_0_0_set_umsch_mm_enable,
 	.get_dpm_clock_table = smu_v14_0_common_get_dpm_table,
+	.set_mall_enable = smu_v14_0_common_set_mall_enable,
 };
 
 static void smu_v14_0_0_set_smu_mailbox_registers(struct smu_context *smu)
-- 
2.25.1

