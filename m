Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5276C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3219910E181;
	Fri, 31 May 2024 06:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TuCFL8bA";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7697810E181
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:43:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVgf/CMegPXtgy/QxvEEA6M3CY6fqBoE2uLwZeYI1FYKjyrFJ1eOvFqPMR5GksmzhUxxHfzV/yPgJqnMVKQXV7PytIYUwhG343CsqtfXMf07GHZEN+651B/ICDB5RvKYCdkpxJZD1PUpBqscJ6149HbU1MYC7huKj7msA2NUho0SUqPcqVf4vQyINf5FUMAr4BMFqalqKnlDOKzC/mEonvpVEVR9Q4i+R4maa48mOIQbvRKR7rOHxApocU2g7KLrHa3Bmt/fm9dr1ZfzURJOewPTOoZrAj0x+Vo0Ps3Jyrp8Yr2IE+LuXHoHBDQChpdV/BBWHhMVQM0LtnESwXbitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYfAOaCmuPVsjCPlNCO9EfSBMHEcSkQcMpCbyXygsPM=;
 b=TIMfDtE2gBWvBAlD36LbQUhkW53PO9eTUIKCspuIVR4RkZ+ijttKBJC68m6h/dvuyl26HfS1B7FCm1Mn1AgpMupNRib2O8KevVO9bi9fa+4n+0d+Dl6jWy8VJx9TLPxm58VQE3dPOCeS1BQLK6pX3dotLfMrRN45XVxKvsGSyzTFwPA2l9fWlc1rNNGCWw7odcsrZX6LbWysm6Ld8idML/dAFo85np6GFjRhq0iEQWV+DuRYtVOZWKmq9EtfSC3QnNwKQ/bWtzt3l0IqVpq34h0tjh+n+uYNjQKJQjj84PmGBM52AZuO7TllkAzdE4Iy7vOy1xpn5EiUFfiFzxQ/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYfAOaCmuPVsjCPlNCO9EfSBMHEcSkQcMpCbyXygsPM=;
 b=TuCFL8bAqXtRzWZpqx4iOsxteBsnptkmVuJS8kCYS4Fud2zoccfVQkN9cThUoLXFPtZ/N02QNDPp+74a5hN1axLYZ4DrvLgQDbhMxHwqoo14JYtKvhq1/oKislVbLtJ+bZNoS2SiyqTJYLXrhOxvTNV1JR96Ghwdu3lPaYBPasE=
Received: from BY5PR17CA0010.namprd17.prod.outlook.com (2603:10b6:a03:1b8::23)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 06:43:33 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::7d) by BY5PR17CA0010.outlook.office365.com
 (2603:10b6:a03:1b8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Fri, 31 May 2024 06:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:43:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:43:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:43:31 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 31 May 2024 01:43:29 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Tim.Huang@amd.com>, <jesse.zhang@amd.com>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, Bob Zhou
 <bob.zhou@amd.com>
Subject: [PATCH v2] drm/amd/pm: Fix the null pointer dereference for
 vega10_hwmgr
Date: Fri, 31 May 2024 14:43:28 +0800
Message-ID: <20240531064328.17351-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: bob.zhou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b55d7d8-2cae-4b60-8ce0-08dc813cfd58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hpGmzSOmC+BHfbfrxj3Q7EqZqXTeLiIVj4Qqd47fokOMEtcatYsq6pWE1RDg?=
 =?us-ascii?Q?Uc+bUycLc37uFUKFheStDRgREyZwd5t3at7/kCj9Ehwvf0CW3TPI6M4++kYO?=
 =?us-ascii?Q?Vb91nWtwYg09M+vQtLhLiDdC/8vI2URV6rBixDIL0tbrU/dQeD4989o9bNPp?=
 =?us-ascii?Q?pE69+jTHoIMMi/w4ySc3a5AYrEqJQyXs1If7NFUMlPvEphr8V7jgzhMZPpKa?=
 =?us-ascii?Q?FwEaiDEZbIcadrsuvrcIq0L8KOyzbcIhdVkfUE83HpHktRg0s/D0tSdAPA62?=
 =?us-ascii?Q?tAJ+S68IPtRDrCbWAZHykmGb9wx+udKi5MNGJNhXcJVXEJKcrYbPZbxBYWzZ?=
 =?us-ascii?Q?lHVfrReYkxtU5a9+q8uGSBNn/QriJv1i6rTyjhps3nd6aetznDXuB7MC8UBI?=
 =?us-ascii?Q?bJAwrZbENRskXE5RJz+paqy8yPGIJn1ErxHpitQTtFV98Ls9qcUfiSLGx+h4?=
 =?us-ascii?Q?qmAKeRjoiNDrphKMaJ4FCKiqIU3/g0xoB7fNjBYlmkanD5iVte0Dt1sCvuoi?=
 =?us-ascii?Q?WAKD6Fpw3/POG2eEuCb3RiJ1Kv6ZKKRwF2AazddajLVyM3Qbq0mLCoI/u4qu?=
 =?us-ascii?Q?t0FOQxKMaq8Ye6EsKzuQLnPh3uDNO17dKbZyQ7mIaxUtviOAPG5av/OU6iJ3?=
 =?us-ascii?Q?xHUcz0GIjVopkOnDnWOK/phE3MNqflyELcT6DFS8RTyDPTfd3drSaVJrJXd5?=
 =?us-ascii?Q?YOvEu/4PJaEhC8KQt8to3ifLX+LmNDdaIPcc6nxjC0fXopW8NbIVLBQdhYIl?=
 =?us-ascii?Q?joVKCMRyINQfMnU8c5Bm8fsEAt4u6637ZHSt16gjKKevSBD/wmDV1Ov/lH8/?=
 =?us-ascii?Q?ZntyPAVCVpyLJbYjGEfN0NjCljUueLvo+E0xfSks2NZaxqR9DghtDjUxUewI?=
 =?us-ascii?Q?MELPwvxI3XcT5IupgarSXFZxK9EC3bJrmfrvwXpKtJhgE2Tclle7UUh3yBlz?=
 =?us-ascii?Q?HKmS+5xjLIBKKLi8yuSBbZhRuDHd3Q8wjaKgp5zs7K+FBebK1NnAkyX+gjx1?=
 =?us-ascii?Q?JHz/78lq4dbZOvTtC7cGRNeaOZeTywqXZxEo4x1x1SI8Oa5Aj02hbyoaU59x?=
 =?us-ascii?Q?bgm/Vl/LFMXneZxoiI7j9k5ELuR9nlFDLmYzQLKdQIlLdnX7WYG88Pmy9spp?=
 =?us-ascii?Q?coRok5AV3f3htoFwIQfVC1JsRE6G+3jKuQM43ih/5h+pvJsXfrpFC0YU3FMv?=
 =?us-ascii?Q?QvzChDf2ciwz1t24aefiw4CDEYF91jONiXyUVz1FQrXloFV0i7q9yopArg26?=
 =?us-ascii?Q?HPlKDGUs6fg2kG352cMYNCZL0s9iWJF5dHa6Jf94686T/uZSyAlywuBmOH1h?=
 =?us-ascii?Q?fPNrIw1gZ5ZE0gvfag0GNvxKcEpJSxSlcUNQ2xnlocQ+2mcvFvuDZzHv+Jx1?=
 =?us-ascii?Q?kNJTGCOufbxWMFpLq1PRBhELQRGL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:43:32.6508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b55d7d8-2cae-4b60-8ce0-08dc813cfd58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
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
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 6524d99e5cab..68b93a0c16e4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3438,6 +3438,8 @@ static int vega10_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwmgr, co
 			(const struct phm_set_power_state_input *)input;
 	const struct vega10_power_state *vega10_ps =
 			cast_const_phw_vega10_power_state(states->pnew_state);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 	struct vega10_single_dpm_table *sclk_table = &(data->dpm_table.gfx_table);
 	uint32_t sclk = vega10_ps->performance_levels
 			[vega10_ps->performance_level_count - 1].gfx_clock;
@@ -3752,6 +3754,9 @@ static int vega10_generate_dpm_level_enable_mask(
 			cast_const_phw_vega10_power_state(states->pnew_state);
 	int i;
 
+	if (vega10_ps == NULL)
+		return -EINVAL;
+
 	PP_ASSERT_WITH_CODE(!vega10_trim_dpm_states(hwmgr, vega10_ps),
 			"Attempt to Trim DPM States Failed!",
 			return -1);
@@ -5035,6 +5040,8 @@ static int vega10_check_states_equal(struct pp_hwmgr *hwmgr,
 
 	vega10_psa = cast_const_phw_vega10_power_state(pstate1);
 	vega10_psb = cast_const_phw_vega10_power_state(pstate2);
+	if (vega10_psa == NULL || vega10_psb == NULL)
+		return -EINVAL;
 
 	/* If the two states don't even have the same number of performance levels
 	 * they cannot be the same state.
@@ -5168,6 +5175,8 @@ static int vega10_set_sclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 		return -EINVAL;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	vega10_ps->performance_levels
 	[vega10_ps->performance_level_count - 1].gfx_clock =
@@ -5219,6 +5228,8 @@ static int vega10_set_mclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 		return -EINVAL;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	vega10_ps->performance_levels
 	[vega10_ps->performance_level_count - 1].mem_clock =
@@ -5460,6 +5471,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr *hwmgr)
 		return;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return;
+
 	max_level = vega10_ps->performance_level_count - 1;
 
 	if (vega10_ps->performance_levels[max_level].gfx_clock !=
@@ -5482,6 +5496,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr *hwmgr)
 
 	ps = (struct pp_power_state *)((unsigned long)(hwmgr->ps) + hwmgr->ps_size * (hwmgr->num_ps - 1));
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return;
+
 	max_level = vega10_ps->performance_level_count - 1;
 
 	if (vega10_ps->performance_levels[max_level].gfx_clock !=
@@ -5672,6 +5689,8 @@ static int vega10_get_performance_level(struct pp_hwmgr *hwmgr, const struct pp_
 		return -EINVAL;
 
 	vega10_ps = cast_const_phw_vega10_power_state(state);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	i = index > vega10_ps->performance_level_count - 1 ?
 			vega10_ps->performance_level_count - 1 : index;
-- 
2.34.1

