Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A3FC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 07:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 284DC10E1D1;
	Thu, 16 May 2024 07:56:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="31TFJ8+N";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D2110E1D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 07:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=br7xvcmTFloY2CCNuP4v+NbqnD32YmZcYf89FQYbnEU4HqWvzkKChoHQDNDMmnQtB0G464EzncFEQMCWDuFJXZSGhs4Gbuja/5DgExfsW75cl0X7/157hcNX0yAYk9vttIcrPmfAkhdBZhWI9hEd2q/ztx5RVEQ9zQt4a6EWlI6sEVFeleOnwSbDlUEQIOXX0/G+TRGYWp4g7owDD+G/8+iIQE5br/J7vOQWhvHg2r1PKqt7CukXmggskeKgbc6Vh3iDPK1unSq55wT2qnZW2/z+ea+29Drm6+0JfSdGJh+NO5aykPAS7X+WuncPgMLQj404S3gxcSbvkRlDKvuwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbzskAIrDu7l/NpwKDoIdMx8ACUINyOhModaRz0klCw=;
 b=WUooANTMuEHqABeUyiKUXb9WPX2U+K3DOi5PdlocGKNNZ0PK+wD9aQEhfYxTFPbapFJ1p7bQTYL7FjOwpNfRe5ScNRqvn+kV6Ctd5vhVuxjL2Bd96e6mwzJvO+KJ/h8pPwvaXTVDMi8aV0aHSx8VDyZzq6DoZw64PMvtJL0AwM9AJs2c3gkDUDGdUwUgs7D+MZNwPaP449p4Z7YDXHCqqw29c9h27hCfpKkF/PZkmEhFWy2xNap2W0oR0Fh/hMk58OmE8zMN1CF6hVbrXB2CPrO3qUUIsS5itq55FVFHMxL0B3okYQW2XkjuMKRah1di6P3d2kvMMWvIq6XjjDolMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbzskAIrDu7l/NpwKDoIdMx8ACUINyOhModaRz0klCw=;
 b=31TFJ8+ND7IXLVT7O3GFtEYaURdhQFqJN78qsqTAeI40TAvcfx/CBef0cj0+Rai0ICx+0qEODYyCr07bkpcA1gCP9EHhgZU+uErrnazZmz9Dj19Dq2B7IQAuMxSyJl6vA8Gblk0oNCb2Z81G6+ech7/T8oH3yTY7AHNWgAOvD9s=
Received: from PH0PR07CA0117.namprd07.prod.outlook.com (2603:10b6:510:4::32)
 by MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 07:56:47 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::15) by PH0PR07CA0117.outlook.office365.com
 (2603:10b6:510:4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 07:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 07:56:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 02:56:46 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 02:56:44 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: <Tim.Huang@amd.com>, <jesse.zhang@amd.com>, Bob Zhou <bob.zhou@amd.com>
Subject: [PATCH] drm/amd/pm: add return check for
 cast_const_phw_vega10_power_state
Date: Thu, 16 May 2024 15:56:43 +0800
Message-ID: <20240516075643.352304-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: bob.zhou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|MW6PR12MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: c3597175-eafd-4095-bb14-08dc757dbc37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nSrplfvygZNE+//V7gYyygVXm9uKTJjzibA6vWQS3EUueFVqOymtXCa6thMn?=
 =?us-ascii?Q?dzUX2CgctMu7DwuTza18//aRUN0IqWdPtliNC4Ek2j1GFO6hrnCRUwPmCswj?=
 =?us-ascii?Q?2YurwtajE1Nnrscrxc5OUfm+D5AoNjAojjeZQkb5ofnPtfpfgXYMPTyy18Q8?=
 =?us-ascii?Q?tukaSQE51Q+rwHyuwwIxNuelMLvyduXEZPyDLHePok0h1XFNuMsl+QQKRved?=
 =?us-ascii?Q?cQId1wHzbSWsj2xdL1u0SuzM21Hd2hU/j/ZkA0KQuE6RQOoF9sE3qH45BaRa?=
 =?us-ascii?Q?aLDY/nAi9n+qnjf3w6/mQx08Rj1F1uh7t/uVlche5oOikpRqcI+giXANTCTe?=
 =?us-ascii?Q?6ns5TfFSgB8gjOoAFX0VxosdeQoiie7blWDLns2KIN7LmczB4omLG0/8HERJ?=
 =?us-ascii?Q?3P9RofL69dGKtnpapAfJ++Gmz6SufeJU1NH2KSdMDjF5a4DaNG39eXZmn+0a?=
 =?us-ascii?Q?FGgrqZ4sfZzQSthxaKxlX3bUa0f+1FZ9gLFIJb8Cw0dGZquYeBXHxN1JGFJx?=
 =?us-ascii?Q?WYsrJng96Hm8ptZFTxDCmaFr05rx4+IacsIOyTsqgCGVJ1w+Bg5lySxw4Y/7?=
 =?us-ascii?Q?m8E4LTmYcyApKcp5TNqeSNrLuoAMjj+78yI+28LgWCVxYiEZmjDW5jIDKuf8?=
 =?us-ascii?Q?sXWAkjlg/LLM7ql9SFFduRzPJv6/zREU4+pooRsqKFiKjxVbdwGwMz8ObP0d?=
 =?us-ascii?Q?wK8ojEqGqHct0UPbHfHzXI224Fqo9dP3wVBHR480IF1OfHAtNje+6EG/M/z/?=
 =?us-ascii?Q?+sxs3oTWuk/KyxT6Sg7puI9IqlPOslNrFRXBWwglwEumxGNZkCU22B3+COx/?=
 =?us-ascii?Q?MUAP83nDd7PDe5nR2L9CWhmirtKRw86TKo5rKzmwPKEhpLcTCTuabVAltKG2?=
 =?us-ascii?Q?gYKyMBjO6lKIyxPduvMcXGSGqtFeMisMLA1fIyTtpmJNOLKcnpH+iZdYiXC8?=
 =?us-ascii?Q?OlfqT3Ka6QbsmE3ZzRVQ2Yb5OrFbC+AAmM11ZyuFkgPXtr5eApX3P9Q7MDK/?=
 =?us-ascii?Q?yA79HlMPLcLUkMqdOQ0e32fVi+F+uyw2+Jj0ZmZ3gxUalPwvGndoBWVCOCX+?=
 =?us-ascii?Q?jcgKvGEYoS/aQGDHSkC0RgXF+CA9ICUq7euPG1+Ds9bueCll6ZWGeytkbkzB?=
 =?us-ascii?Q?zqzkTFMIMbKJJLjUkaDDspO8sav4/fkVxbcADyJqBXdValbKdd0l6cGenhNb?=
 =?us-ascii?Q?nBpEwe0LdcMzFFtplS7AIhgjOElUrpS2cd2SlJqg/XP2yL2Wxu0oeImOoAwO?=
 =?us-ascii?Q?/adlObt3YTh3mOiI7IWqlsdfKWOGNdsejJ5nV9MSM+S/MPIlKqtt4XjBfYvu?=
 =?us-ascii?Q?DFvzV5LEkOsfchvBG7mYJXqOplS9mTP+LvX4hy23Jxmj75GuYAAAyVBPgJvK?=
 =?us-ascii?Q?1dK2wCgh1LnxS18+UDPG5dK6VUEV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 07:56:46.7804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3597175-eafd-4095-bb14-08dc757dbc37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8900
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

To avoid null pointer dereference, add return check and handle null pointer.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 28 +++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 6524d99e5cab..53d98d661af2 100644
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
@@ -5672,6 +5682,8 @@ static int vega10_get_performance_level(struct pp_hwmgr *hwmgr, const struct pp_
 		return -EINVAL;
 
 	vega10_ps = cast_const_phw_vega10_power_state(state);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	i = index > vega10_ps->performance_level_count - 1 ?
 			vega10_ps->performance_level_count - 1 : index;
-- 
2.34.1

