Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C47EC25B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 08:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C899810E1E1;
	Wed, 29 May 2024 08:30:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E/2aAQVv";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB5010E1E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 08:30:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdyGwIEPoLnn9A9xqzdfGY8gUyn3+pvD+Wjgzhv/7Uzu0we0O4OxpfPKzyCQCfI+rvZPqK44COm4MHZfYAo/Vit69AbhM2IA6Bcpa2XN5VfMtvEBA/ZU5Eh0EZIbc7abCkNbWpXUUqh0cRXqtj7SiJPYdVa+U5yN4meAspiWqHhrjRdbrBzJmN3lz4v4xIlkxL0Wnmb1qTsWMPkIWRKgMeXM0sjEE7AO6yYmHX9ticQt+eHoDie1+qBb3hgv1GnuYSrlZbKdmEMrSRMBO6Xpf00b24HwOv6tJqVfyVmjmQkAyvKkXEh8MWT5YxBgoUHzsNzAJhk9BFN2jFbocRv6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTPUs61uk4qQQgDyZHuLxoED7JBLzSmD5C7AKTwkTVU=;
 b=lomoKwfxbU7afflhx6ybY1OVNKgez/ino6C/Ak98icLgCbiETshtCAIzdtDczGJd7XhKVtLH+Ir6qyeI9ohXOnv7h2ve4OvvqjMyLzO6J9uuVPGVxWBWu3I83Ld0c4AXls9+DXTB3W85SDuAWTU3xa4UNMnC7UQQot8UGXEMuVqb40YiGGBKxMqSLGAu89v/A3mfI2Vi2YbZO3vd8I+h749gw7QknLHNlRLejC+SnbA+oMGCyq9nmO/XffjdCMssJd02juE0YORwE4sskjLxoHqf8UveUSpsh/X2FxjGp+VhhXSJbYXwcB7f9mNKs1h1edfczLBLlkGQc7E50lRvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTPUs61uk4qQQgDyZHuLxoED7JBLzSmD5C7AKTwkTVU=;
 b=E/2aAQVvDWVw7QiFF9ii0xFRA+KoufuC74bbUIox3NccyZlZdFZKujb45xEvL+5NFBf5qOb1qTcqk6Uvi0K8aDdc9Er/HMYziU0FvGbVAsmB8cgdMAzrWwYmVKshN7ZwLVhTIOn01VM4djN7UsQqP3/2RW6HmcJ80EPs1aXjg2I=
Received: from BYAPR07CA0074.namprd07.prod.outlook.com (2603:10b6:a03:12b::15)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 29 May
 2024 08:30:00 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::1d) by BYAPR07CA0074.outlook.office365.com
 (2603:10b6:a03:12b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 08:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 08:29:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 03:29:58 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 29 May 2024 03:29:57 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Tim.Huang@amd.com>, <jesse.zhang@amd.com>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, Bob Zhou
 <bob.zhou@amd.com>
Subject: [PATCH] drm/amd/pm: Fix the null pointer dereference for vega10_hwmgr
Date: Wed, 29 May 2024 16:29:56 +0800
Message-ID: <20240529082956.94945-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: bob.zhou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4162b6-cee5-4d47-7af5-08dc7fb9877c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5zG/mGhodCWX2nquZ14XIA0wYU9bQnUFmCSOmZFoAcsaPkbeDbFBTVBfy1XR?=
 =?us-ascii?Q?FHY9TRE6iMMXMb14N11LL6NOuGfCGfVBk3XAM9ynvLZxTFdu7SpzwhbWBIhr?=
 =?us-ascii?Q?9UpcvLPT/Uew4SNUeOFjvVgxsH56ds1AabjyaZ7DjGU3qPxWeWFpBDLZMszB?=
 =?us-ascii?Q?QDw3hOnqaLYPmRWpSgk21T8TtlK/DtNtFchLTaDi6GDIpLTi/OQ28+fV4nF2?=
 =?us-ascii?Q?AFWCqsic0dBzghi6b0UiJik1Bj+6cHf3a722+7N6viLo6QvlpzrWEVautl5g?=
 =?us-ascii?Q?LDQRNxY7phgN4jTCkm3ivegM8hgIl024qddC7NrowNkMnHeWkvkOJVkneFTD?=
 =?us-ascii?Q?RVCiWkDOysC9hgq/W/3pI7cdNxpQ8GtkZy9+WmG9p/Ua3HiSRnFYiwDQEjp2?=
 =?us-ascii?Q?Y5qNGfiCgLQtFtcjEKdQiwLJfZaZy9eMdoIegYrPq+P9JBwR+zIAP7+onxT7?=
 =?us-ascii?Q?8MXxtuaGZpwdqf55ptFixXOdo+WmQ3Kss68rp1zF0eHrC1BXD9O8J54lVbrY?=
 =?us-ascii?Q?OSzf/+NQ+nRie2+AiuKcpZCpr1ZNIPe9kCIjt7USgMSvZzYAehxtmHYrjwV9?=
 =?us-ascii?Q?z0DCiUEIoWqOn0v8XHpsYOIgbPQXr+H1n8v2aqX2hLCticumeX68pJD/ZrUE?=
 =?us-ascii?Q?6+KQin5LLfhAbFVm5TdGuz9ECcBY5SEaWRCFpwms0f8tlCwNdCtc6RtZ06jY?=
 =?us-ascii?Q?aDRWGp09mJ6zrZQ02aCYnkANbsJ5fY2aPTiW6ILwz23QhjnS4dWrFSFuDX8t?=
 =?us-ascii?Q?I9rx/QpOeBQQKjfq6nOmlm4R0XrhUlvWk1uwrexg5z8+smoa2Wwdb21jtDjO?=
 =?us-ascii?Q?FGjrpDTAzqMKAvTGbAadWqUHg3uwdKGCilXJ1lU1n448x5bEQiDdX3HnNODI?=
 =?us-ascii?Q?eJ9UxH3Ik9S4p42xfuNRikHFA8obYlvpluNFPgktpsWNuK931aLyX9Pwa7/V?=
 =?us-ascii?Q?p4ODa+iXqpJkWwDZSlzmeNQUmScZizH0uwPejyg3tP1W9PoGNQ5ODm42rXAI?=
 =?us-ascii?Q?VWPuIDoTdbcsW0ATkka+lYFmkNwvOhHPnryXQ8RsvbOnMVPmJABj1F/NtBr7?=
 =?us-ascii?Q?8KIt19idsDt+pXLeDfJDYRIJj9t8REa2uJvJ64MQly6m2w2WPu+QNx8VG0wZ?=
 =?us-ascii?Q?IgGQaMPgiVZizjyTM/BDKILuz7e7tTs/9zd/DK/EJadiMC0KD7snPN6YQweA?=
 =?us-ascii?Q?0hA+pqqeOUc/3vQWfFC/MNDZvVFoKz/x05owRI18XccoxopQ59isfQOnMMla?=
 =?us-ascii?Q?cRgd1tK4yWqKY2Ja81A5nd2fe69dmpfbB91S3f91ReedumWLfSzi9vlW9F3r?=
 =?us-ascii?Q?WLAvnFk0noBF8jcwjdLhpkCToeJUcoU1wPe19d72HNK6zeD66LFOozxksEdm?=
 =?us-ascii?Q?5plDfBGIU4wcx2EGzof/B0LqsNT7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 08:29:59.7120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4162b6-cee5-4d47-7af5-08dc7fb9877c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939
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
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 38 +++++++++++++++----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 6524d99e5cab..0f94564b4adf 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3436,16 +3436,20 @@ static int vega10_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwmgr, co
 	struct vega10_hwmgr *data = hwmgr->backend;
 	const struct phm_set_power_state_input *states =
 			(const struct phm_set_power_state_input *)input;
-	const struct vega10_power_state *vega10_ps =
-			cast_const_phw_vega10_power_state(states->pnew_state);
+	const struct vega10_power_state *vega10_ps;
 	struct vega10_single_dpm_table *sclk_table = &(data->dpm_table.gfx_table);
-	uint32_t sclk = vega10_ps->performance_levels
-			[vega10_ps->performance_level_count - 1].gfx_clock;
 	struct vega10_single_dpm_table *mclk_table = &(data->dpm_table.mem_table);
-	uint32_t mclk = vega10_ps->performance_levels
-			[vega10_ps->performance_level_count - 1].mem_clock;
+	uint32_t sclk, mclk;
 	uint32_t i;
 
+	vega10_ps = cast_const_phw_vega10_power_state(states->pnew_state);
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
@@ -3748,10 +3752,13 @@ static int vega10_generate_dpm_level_enable_mask(
 	struct vega10_hwmgr *data = hwmgr->backend;
 	const struct phm_set_power_state_input *states =
 			(const struct phm_set_power_state_input *)input;
-	const struct vega10_power_state *vega10_ps =
-			cast_const_phw_vega10_power_state(states->pnew_state);
+	const struct vega10_power_state *vega10_ps;
 	int i;
 
+	vega10_ps = cast_const_phw_vega10_power_state(states->pnew_state);
+	if (vega10_ps == NULL)
+		return -EINVAL;
+
 	PP_ASSERT_WITH_CODE(!vega10_trim_dpm_states(hwmgr, vega10_ps),
 			"Attempt to Trim DPM States Failed!",
 			return -1);
@@ -5036,6 +5043,9 @@ static int vega10_check_states_equal(struct pp_hwmgr *hwmgr,
 	vega10_psa = cast_const_phw_vega10_power_state(pstate1);
 	vega10_psb = cast_const_phw_vega10_power_state(pstate2);
 
+	if (vega10_psa == NULL || vega10_psb == NULL)
+		return -EINVAL;
+
 	/* If the two states don't even have the same number of performance levels
 	 * they cannot be the same state.
 	 */
@@ -5168,6 +5178,8 @@ static int vega10_set_sclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 		return -EINVAL;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	vega10_ps->performance_levels
 	[vega10_ps->performance_level_count - 1].gfx_clock =
@@ -5219,6 +5231,8 @@ static int vega10_set_mclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 		return -EINVAL;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	vega10_ps->performance_levels
 	[vega10_ps->performance_level_count - 1].mem_clock =
@@ -5460,6 +5474,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr *hwmgr)
 		return;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return;
+
 	max_level = vega10_ps->performance_level_count - 1;
 
 	if (vega10_ps->performance_levels[max_level].gfx_clock !=
@@ -5482,6 +5499,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr *hwmgr)
 
 	ps = (struct pp_power_state *)((unsigned long)(hwmgr->ps) + hwmgr->ps_size * (hwmgr->num_ps - 1));
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return;
+
 	max_level = vega10_ps->performance_level_count - 1;
 
 	if (vega10_ps->performance_levels[max_level].gfx_clock !=
@@ -5672,6 +5692,8 @@ static int vega10_get_performance_level(struct pp_hwmgr *hwmgr, const struct pp_
 		return -EINVAL;
 
 	vega10_ps = cast_const_phw_vega10_power_state(state);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	i = index > vega10_ps->performance_level_count - 1 ?
 			vega10_ps->performance_level_count - 1 : index;
-- 
2.34.1

