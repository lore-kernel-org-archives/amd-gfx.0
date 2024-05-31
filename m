Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D79C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 07:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F09A310F3AC;
	Fri, 31 May 2024 07:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F30bUgnf";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ADB810F3AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 07:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZNC9E6M2C+nby8D5E+JM3OQiJ5JpsArPnXFrRNm9/3p6lrkvVt8iA9Xsj88P1z7xeQa1GC2KYJIt8Ze91e8KuGlaIx3LUzSwMtHwS2RfB11OLg7tRuUSFjNFfbtUa87vaWOspfMIAigdaMSZranmUHyoBdkOySrPDNyS/B3lAYP1UD4oK66kHLIsTJO7O63bMbTVcvPKW8mjPe2LEWn2/0ghrXLx9dhKOtacpn+AaZd5U2toghs68QYpvEXFko8dklNAcCe0Z0lO164pNoBeDdcJ/I35euJkmKNakqo/cLqRWO4vNWAgp9cWll8qf3eeDgix8MX47Qk4XBS6ixndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViLM3XkmycxKIlynzSCcTe2cRenL2FUX/1GUH+FVpmc=;
 b=nrs8GpEE/8y5nzd6jm2eDbel8/665YHyQpt4NjlxvvbXkp5Nteqh+dtJwMvk8Jj57kqIfRnjkXwc8qM/V3kjEUgLz/FvFm6bmyZjKiMiDz1yx1P6WwqxoIV01LhRY03VbKQlYUiRZpiJN/MTV0cKAIqibG8x3fXwhnZo01WB2jPZI03+rLOnUm6Dl4gF8scOBOpmNGgrzxniHXSWFv07zSzvOElumtKwBFYZuNd0S5MldnV8FPwElLReETE2UOv/0S8y+mguR9LANs9KADg0NFTitW6pv8Q0fVUJblZS31+qZ+Ah5smNdQedLGQ3uFi5GUVFzPjldTR/jagmqRVMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViLM3XkmycxKIlynzSCcTe2cRenL2FUX/1GUH+FVpmc=;
 b=F30bUgnfDUwQ2U1cSHLtaeBCqS+9UKQ1/GPuLzynogZQHRkUWMRWp7MchzJYPy78spPNMcbNK3tnAsFmAzB2HesEOe3SUW2YxQ/HwACUDZy/pWuxLf7TzizgGXw6vSuymdD4FjrdwexsGxNBOzkgJZahBt0s2BoAR5Sa38ZMM4A=
Received: from DS7PR07CA0005.namprd07.prod.outlook.com (2603:10b6:5:3af::15)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Fri, 31 May
 2024 07:01:26 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::7e) by DS7PR07CA0005.outlook.office365.com
 (2603:10b6:5:3af::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37 via Frontend
 Transport; Fri, 31 May 2024 07:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 07:01:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 02:01:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 02:01:25 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 31 May 2024 02:01:23 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Tim.Huang@amd.com>, <jesse.zhang@amd.com>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, Bob Zhou
 <bob.zhou@amd.com>
Subject: [PATCH v3] drm/amd/pm: Fix the null pointer dereference for
 vega10_hwmgr
Date: Fri, 31 May 2024 15:01:22 +0800
Message-ID: <20240531070122.18431-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: abdc03ea-0db2-4d10-8214-08dc813f7d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CbJHMGwftCFBj8f9W/9n1xnjUJ6NwDxqsBbWiuLBMB2UhLxBA1U2auN4kIBx?=
 =?us-ascii?Q?69YYqV7dcqn7JxeMIyzzR0f2XIq5BiotXLubOKBKP6gw2gxCBcxiHKK8FPCB?=
 =?us-ascii?Q?gdvqYzAKHbt6i5jBdIOHljDrTqkDr+llNaSKRVSS51NY4RpnlpBAo7ppL4K6?=
 =?us-ascii?Q?S4RirCVyKCgzSzXBpf7Bf5I6dXDc9FZEqOz4aLQR1YLFyLp5maSB6DV9sUzI?=
 =?us-ascii?Q?Ep9+UdFhOe6+4PtwvMTwSgWZ7HnwI2jiVX6O65poIxqfeQRNkzKQA2lm08P2?=
 =?us-ascii?Q?tg09VAnid7Wm8jIFhxDHOPt7FmO2vIlruGDS6QotnZTpNVkC0KYEmRqEI/lz?=
 =?us-ascii?Q?SOqJn+f3/zBElzOzAccMjDD5CcNfj/stGRV3BI4cZWLLlfB6bzHoxr+ZEQeG?=
 =?us-ascii?Q?MkEwvc9miW/OwUxpH1Rl00Nm70fgCICYIpachCtcMT1rWnzQlId1KtkwCOZo?=
 =?us-ascii?Q?R0NKVgn37wiUM6if09PjUKjRLy4QsbWr0xnGwwRu357+PJozqTVE9r09hqax?=
 =?us-ascii?Q?zIymfTzmYNUTXq059LWsx2xOJj8CR1B7IUHrDHs+RsmnPwJl/lL9edVXNgcE?=
 =?us-ascii?Q?bk8DboKYzHu9E6b48LBjxpGPCxqPs0Vg5j90frIISMzGoK8W75AAqCkUH/3L?=
 =?us-ascii?Q?YIBnyzYPyEyQx6RNW9pO0fDUgBhoLP4CJVtZy2KUHMHYb2oDMCAXPnHsC17R?=
 =?us-ascii?Q?dP6U3aUVC8Bs/578JRvYVV6Sx1gn1GTbghu4GQXFSuV2rv2PPonZopxNMGeD?=
 =?us-ascii?Q?cwpuQPi1FBDImhrZipFbkXyDk0WGvztX1TIetTxcdtSGe3BlfgbRzGxbJGQ5?=
 =?us-ascii?Q?sPZ7O5Ocagpc0z/josWATOF60LIeocoUwrUtQRuR50+eLFsk0GbjTGbbHVko?=
 =?us-ascii?Q?/HFIndtjLs89TH+IaDX0MPMVCnAaxjLIfnrK4zfptSNYz17IMpZs6Mh0zxbE?=
 =?us-ascii?Q?zTwLuWaYxXFQN+lkACjb7tPuR6vlRdLr8zuzAAtYZJzRQZAUmObPglOL0a+D?=
 =?us-ascii?Q?uIcuq5cuq0jJsVSqwo9mu5P8FhWUiibRGfPfkjyUnZ+HCF0p5M9Mbd00EQIn?=
 =?us-ascii?Q?YXYD3fUxMeZ7BXb1MsomqLfQkRifBFjTsMrHDgMDWxOl7Dlux8JrIW2xPNk+?=
 =?us-ascii?Q?v2O5K8n6zk+glOM/kmMkJUrUhk6HRNsJS4JhDvKfFbwO9HoIc8b3l1JMmww/?=
 =?us-ascii?Q?NOS7OBUyhehoTZ37BGTfXYZ4/IpKNaff4ziB+XivI5VoILUtl61ZCu1oys5a?=
 =?us-ascii?Q?M7pMuDrBS1blDXbW9St9Vq5lUvU0MTyiu1TR4RC1f7jnhC52mSzlR/svext0?=
 =?us-ascii?Q?u95ojNbJruWsSAFZdAlR7p0584x7DoyhZc+CV2a7AlelEYfq3ShKUrxI3FPX?=
 =?us-ascii?Q?V8Hp44oVSnlQu05PxS6F8uvN2YfS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 07:01:26.6106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abdc03ea-0db2-4d10-8214-08dc813f7d6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248
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

Check return value and conduct null pointer handling to avoid null pointer dereference.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 29 ++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 6524d99e5cab..6e717ddbb029 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3439,13 +3439,17 @@ static int vega10_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwmgr, co
 	const struct vega10_power_state *vega10_ps =
 			cast_const_phw_vega10_power_state(states->pnew_state);
 	struct vega10_single_dpm_table *sclk_table = &(data->dpm_table.gfx_table);
-	uint32_t sclk = vega10_ps->performance_levels
-			[vega10_ps->performance_level_count - 1].gfx_clock;
 	struct vega10_single_dpm_table *mclk_table = &(data->dpm_table.mem_table);
-	uint32_t mclk = vega10_ps->performance_levels
-			[vega10_ps->performance_level_count - 1].mem_clock;
+	uint32_t sclk, mclk;
 	uint32_t i;
 
+	if (vega10_ps == NULL)
+		return -EINVAL;
+	sclk = vega10_ps->performance_levels
+			[vega10_ps->performance_level_count - 1].gfx_clock;
+	mclk = vega10_ps->performance_levels
+			[vega10_ps->performance_level_count - 1].mem_clock;
+
 	for (i = 0; i < sclk_table->count; i++) {
 		if (sclk == sclk_table->dpm_levels[i].value)
 			break;
@@ -3752,6 +3756,9 @@ static int vega10_generate_dpm_level_enable_mask(
 			cast_const_phw_vega10_power_state(states->pnew_state);
 	int i;
 
+	if (vega10_ps == NULL)
+		return -EINVAL;
+
 	PP_ASSERT_WITH_CODE(!vega10_trim_dpm_states(hwmgr, vega10_ps),
 			"Attempt to Trim DPM States Failed!",
 			return -1);
@@ -5035,6 +5042,8 @@ static int vega10_check_states_equal(struct pp_hwmgr *hwmgr,
 
 	vega10_psa = cast_const_phw_vega10_power_state(pstate1);
 	vega10_psb = cast_const_phw_vega10_power_state(pstate2);
+	if (vega10_psa == NULL || vega10_psb == NULL)
+		return -EINVAL;
 
 	/* If the two states don't even have the same number of performance levels
 	 * they cannot be the same state.
@@ -5168,6 +5177,8 @@ static int vega10_set_sclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 		return -EINVAL;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	vega10_ps->performance_levels
 	[vega10_ps->performance_level_count - 1].gfx_clock =
@@ -5219,6 +5230,8 @@ static int vega10_set_mclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 		return -EINVAL;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	vega10_ps->performance_levels
 	[vega10_ps->performance_level_count - 1].mem_clock =
@@ -5460,6 +5473,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr *hwmgr)
 		return;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return;
+
 	max_level = vega10_ps->performance_level_count - 1;
 
 	if (vega10_ps->performance_levels[max_level].gfx_clock !=
@@ -5482,6 +5498,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr *hwmgr)
 
 	ps = (struct pp_power_state *)((unsigned long)(hwmgr->ps) + hwmgr->ps_size * (hwmgr->num_ps - 1));
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return;
+
 	max_level = vega10_ps->performance_level_count - 1;
 
 	if (vega10_ps->performance_levels[max_level].gfx_clock !=
@@ -5672,6 +5691,8 @@ static int vega10_get_performance_level(struct pp_hwmgr *hwmgr, const struct pp_
 		return -EINVAL;
 
 	vega10_ps = cast_const_phw_vega10_power_state(state);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	i = index > vega10_ps->performance_level_count - 1 ?
 			vega10_ps->performance_level_count - 1 : index;
-- 
2.34.1

