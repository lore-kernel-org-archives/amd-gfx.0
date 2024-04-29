Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19EFC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 07:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD0E10F802;
	Mon, 29 Apr 2024 07:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UrTALS0c";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FAE910EC3C
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 07:58:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyIISXE+fLMLDKboyfiGEvf5tAhFihQKXXWAycWuV0xhofrQcDQ5uXVRubuvg9/rbzVedJOfgf7DG38wMALCBzsyzKDsDFSnkoGJSvwC4K9b5FqZccOnTo8FZTiK6fRO6vrg+ondFZ1mJCvchuWxSx7AK7mpl4dXsTgghRylmaNeVF+jnTUPfhei/3sNjNIf062hHbuK5rW2j7wZ8g2SHhRt17a2ybEMBXj3lacVE8xHGUdQtwD276diFhhu5DD8J4PdumpYS9oXqA2lrxMt+kdRsJxp2XcT8jcabbnvtJPU11ah3CV5cBcR6Q94iFMqHHRavbyWEB21Uf/hd7k8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuStmeOmOZY4hINwbtJnJsLyXUKmmk4FaSibYSRvNNQ=;
 b=gAv2FDIewMeiZhaQxF5yMz5WZ+o9vTmXgpHipDDugjR0X9SKKttIPzSd4KSl5ryMotbon3reRwS6DC6RQgOlV5XJXQBMJaXMHY/vIThhzpqWzm6CCSzJbiCcrs4Q7KWayh0BEsUNKYYA/pJxrKZtmGhIhxATUZglg3hLjhvNneuvbE6OpvTtHO/oOf3WdAo+LDLvGPe6/Q6mHPn7nNL+f+U0q7K5il8MaOtBgdrOZk6WcflyQ0tnS1hug6SfH2YgeRU543Tq2aKJwRFiTYW9Kpf7J5jGwEOL2M3m5WFWTXbiZl61OA5Pf83xtDxf3Y9TULOjqlWkrLHvHPCI8VzMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuStmeOmOZY4hINwbtJnJsLyXUKmmk4FaSibYSRvNNQ=;
 b=UrTALS0cswqI2ZQT9stxNh8Ik1oxzOVlhQu3c6BZMAubaQQ3fdix/oqSuzRwc64IEYBgUQjKR8BxwYVWKfvWQDocaHVNPcF1OirDBcaTJzuRdXUUeVyTMMiLyHDLZOSU7UvpvaITQfdZhkO28jbJ6gDJtXyKOZNEocx39yBHftg=
Received: from BN9PR03CA0408.namprd03.prod.outlook.com (2603:10b6:408:111::23)
 by PH7PR12MB6883.namprd12.prod.outlook.com (2603:10b6:510:1b9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 07:58:52 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::58) by BN9PR03CA0408.outlook.office365.com
 (2603:10b6:408:111::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 07:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 07:58:52 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 02:58:50 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, Ma Jun
 <Jun.Ma2@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu/pm: Fix uninitialized variable warning
Date: Mon, 29 Apr 2024 15:58:32 +0800
Message-ID: <20240429075832.168593-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429075832.168593-1-Jun.Ma2@amd.com>
References: <20240429075832.168593-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|PH7PR12MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3b5d50-fa27-4ea5-9be3-08dc682235e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oCUcgjLn41NRSs6V3naojSz0MyGIUACAnSrD7EKA3Lf+foirOyFDxnN81jdP?=
 =?us-ascii?Q?u8ARZuN0BgjFVeeiPlg4Gi4AhlEA6XSQjPGorkoggUCQzB/DK5YpyyDA0waS?=
 =?us-ascii?Q?EZvkTq7NQz9WKNIBHWcb6bqID5+NVmtg32EJwWJ9/0NdOqnloqYLOS+ghogo?=
 =?us-ascii?Q?fqMV4497gIe/IFXOhuk+Oc6BrRlddhyPjfYYpoP2iaIRxJsCXOO+x2n0jZI6?=
 =?us-ascii?Q?s419pchFaz/hSv+3JiSnLGGad6vCQp1ZUH7VgG6ajvl1qGRUx5+1LTUQDWU+?=
 =?us-ascii?Q?/ASGEvfrixYG32qUcSocVa2JnjIkwcMxvN/ZrQrZkbMvOpvym429Y4HHSYmW?=
 =?us-ascii?Q?BMfL+okM4SaA5zYq2SYpmgyhTlvKzLA3d+klXeUv1MpHVm+mUD0sfbwCCRrZ?=
 =?us-ascii?Q?fTkzEMEPwPArtumKoRADt1Y8GAVL0ATCHVpTPu8nvmI8YdVfeqNDMhyxhBl0?=
 =?us-ascii?Q?LebsLus1H5a/Org+GX3+oBYUL+hgLLeZqYxpdT44dLlVJ+3PTgNm2BUy5iVL?=
 =?us-ascii?Q?M0m8oMbbho421FAhzXZIAWOVJvyKOLG/ZvlOJEpcexzb+QtT3QwE4hquInZh?=
 =?us-ascii?Q?iKAu7/ya9oFdBCk8UohL0OP4z9iervPy3fNJR3V9dm/6wgyKia9W5vOuT7oF?=
 =?us-ascii?Q?1ko3i7Q+ipyu9Sha8sHq1i8Ld/vanEBsi9YTbxnLjIprULoe9NUQjtThQDBc?=
 =?us-ascii?Q?HntAILw0KizTJKsw1P+2/T4dcngHqlw3BRswZXeTsH7WDiEPL+G3d1lz/2ss?=
 =?us-ascii?Q?wfdEqQJkg88oCKl9c92rW/NJ93BU6z8ZL5CPzkaqJMBrgKWa/Nki0RGjo815?=
 =?us-ascii?Q?uFFlVBcj4CUnuTjNSgemgxCvALoTXOvG1A/Ln3L0zlfVvhoDpsXqjhZzH4bG?=
 =?us-ascii?Q?pe6H4j6LxKbTD8WmiJRGf1f8C4HrPJuVoeOpi8TKYZZR/eXl30SV7EKySorX?=
 =?us-ascii?Q?DR2OFewu5ElzbrcedHyk+u5Rptae21DAP6FMhU2+WzYuhDAfxkhPUkJfouqx?=
 =?us-ascii?Q?vlFtr0syNg87xEnPge5s/3Xpx2/UbAWjyh1IC2pYu5AnMX8LGajjykGWmEy/?=
 =?us-ascii?Q?7OKuR1pmKCS6fxqgZCk9W0uzmNeBBlz2mD5ppIG1cbOMd9VNv4fDYZCCq1LX?=
 =?us-ascii?Q?vYL45d4PEaYRSj4jo19haXGwexNE0hSpp43q3Tu34L4wDFJQUtmylruX5ZrP?=
 =?us-ascii?Q?LXdSgwk6tYwu/GvhscVRtK5IdeSBvWOqRYAMT1/Pw4e+EbYYiLkAN6/3XJuc?=
 =?us-ascii?Q?FAcZfA9+VtFkDj2Jv3hItQqdIRNYjmimPidO+9vIj0jhpjnCzLH7ywsZJcZ6?=
 =?us-ascii?Q?c1nA07l9HD1gyuvQySBq1A6BCFHzZiQDfM4D8i9bhfaElYqIoN3wC2nOTg4a?=
 =?us-ascii?Q?GJfIeZIgt79T35mMTGdGNsR/U2Nc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 07:58:52.1872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3b5d50-fa27-4ea5-9be3-08dc682235e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6883
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

Check return value of smum_send_msg_to_smc to fix
uninitialized variable varning

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 21 +++++++++++++----
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 20 ++++++++++++----
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 23 ++++++++++++++-----
 3 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 38d5605117ff..a8c732e07006 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1558,7 +1558,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 		}
 
 		if (input[0] == 0) {
-			smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
+			ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
+			if (ret)
+				return ret;
+
 			if (input[1] < min_freq) {
 				pr_err("Fine grain setting minimum sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
 					input[1], min_freq);
@@ -1566,7 +1569,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 			}
 			smu10_data->gfx_actual_soft_min_freq = input[1];
 		} else if (input[0] == 1) {
-			smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
+			ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
+			if (ret)
+				return ret;
+
 			if (input[1] > max_freq) {
 				pr_err("Fine grain setting maximum sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
 					input[1], max_freq);
@@ -1581,10 +1587,15 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 			pr_err("Input parameter number not correct\n");
 			return -EINVAL;
 		}
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
-
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
+		if (ret)
+			return ret;
 		smu10_data->gfx_actual_soft_min_freq = min_freq;
+
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
+		if (ret)
+			return ret;
+
 		smu10_data->gfx_actual_soft_max_freq = max_freq;
 	} else if (type == PP_OD_COMMIT_DPM_TABLE) {
 		if (size != 0) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index c223e3a6bfca..10fd4e9f016c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -293,12 +293,12 @@ static int vega12_set_features_platform_caps(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
-static void vega12_init_dpm_defaults(struct pp_hwmgr *hwmgr)
+static int vega12_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 {
 	struct vega12_hwmgr *data = (struct vega12_hwmgr *)(hwmgr->backend);
 	struct amdgpu_device *adev = hwmgr->adev;
 	uint32_t top32, bottom32;
-	int i;
+	int i, ret;
 
 	data->smu_features[GNLD_DPM_PREFETCHER].smu_feature_id =
 			FEATURE_DPM_PREFETCHER_BIT;
@@ -364,10 +364,16 @@ static void vega12_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	}
 
 	/* Get the SN to turn into a Unique ID */
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
+	if (ret)
+		return ret;
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	if (ret)
+		return ret;
 
 	adev->unique_id = ((uint64_t)bottom32 << 32) | top32;
+
+	return 0;
 }
 
 static int vega12_set_private_data_based_on_pptable(struct pp_hwmgr *hwmgr)
@@ -410,7 +416,11 @@ static int vega12_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 
 	vega12_set_features_platform_caps(hwmgr);
 
-	vega12_init_dpm_defaults(hwmgr);
+	result = vega12_init_dpm_defaults(hwmgr);
+	if (result) {
+		pr_err("%s failed\n", __func__);
+		return result;
+	}
 
 	/* Parse pptable data read from VBIOS */
 	vega12_set_private_data_based_on_pptable(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index f9efb0bad807..bf1b829f9d68 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -328,12 +328,12 @@ static int vega20_set_features_platform_caps(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
-static void vega20_init_dpm_defaults(struct pp_hwmgr *hwmgr)
+static int vega20_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 {
 	struct vega20_hwmgr *data = (struct vega20_hwmgr *)(hwmgr->backend);
 	struct amdgpu_device *adev = hwmgr->adev;
 	uint32_t top32, bottom32;
-	int i;
+	int i, ret;
 
 	data->smu_features[GNLD_DPM_PREFETCHER].smu_feature_id =
 			FEATURE_DPM_PREFETCHER_BIT;
@@ -404,10 +404,17 @@ static void vega20_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	}
 
 	/* Get the SN to turn into a Unique ID */
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
+	if (ret)
+		return ret;
+
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	if (ret)
+		return ret;
 
 	adev->unique_id = ((uint64_t)bottom32 << 32) | top32;
+
+	return 0;
 }
 
 static int vega20_set_private_data_based_on_pptable(struct pp_hwmgr *hwmgr)
@@ -427,6 +434,7 @@ static int vega20_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 {
 	struct vega20_hwmgr *data;
 	struct amdgpu_device *adev = hwmgr->adev;
+	int result;
 
 	data = kzalloc(sizeof(struct vega20_hwmgr), GFP_KERNEL);
 	if (data == NULL)
@@ -452,8 +460,11 @@ static int vega20_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 
 	vega20_set_features_platform_caps(hwmgr);
 
-	vega20_init_dpm_defaults(hwmgr);
-
+	result = vega20_init_dpm_defaults(hwmgr);
+	if (result) {
+		pr_err("%s failed\n", __func__);
+		return result;
+	}
 	/* Parse pptable data read from VBIOS */
 	vega20_set_private_data_based_on_pptable(hwmgr);
 
-- 
2.34.1

