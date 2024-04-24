Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FD0C10F16
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E99D10EE1F;
	Wed, 24 Apr 2024 08:34:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3U1STPeg";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C559E113909
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:34:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ewue4YGKWH7DvvWHi2LlXFlirVyBzIEIciT91UhFnIwKqItYk6N2C0YqbedAuHa70mJw7ecpbg2Z0dguNWTP2KyPE2mwiGeXu6FdWz2ojAV0zQwXQFFmTQF4Pkgp6yBuz26s9szbFhVzaB3nmUUBjY+RSMHx7nZz31YmKsV1eqIq17dYS0RoPbG3BbDOTDQQ4VNlfcICfnixKnzejPLDE7WbjIF40GLdzR0Lxej+RCL5yYRABdY/kA4kbQO6PiuoIn0zlMi9Qa7t6GkeyV3UPURV5kH8oSmeQguH6jjWpB/20A0HuWMbVnenxtVpR5IzIedxO9QpP0hgg3QA8sBimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+i2dCe3zX8D3e0nHDsAupAiae4PrgZ9xOamSyk0XOc=;
 b=e/fFXUYt36v8wOQJ38EOxLvngsBE77NSzhfRqGo4swWxFrsD5BLjztCO35XLzEZaHiIfL7gyt/GGdwq7eFJPClw0Xlya+9eyKt/3MjtlGF1YxUtsw4BppUNct24Kjv9KmCyUeF1c6zVJ7xkBFZaL5ECLkbsDDH74dqzfr6qK9KD3yXjFiv/gaZEVRhSTWexLg4Z5eQaUzvnf8BcuGK/ZnNORxAQvfl4RvNsfrW7hHwieTMALs2zNJrq7zfMLmy8vo9OuMJ7wFOGifApJbbFYEk71jMDicEU7AwKr+xA5hLRfJadZ3zC8++CDq5egrHAtSgVubhcihIh/HwwSkWuwiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+i2dCe3zX8D3e0nHDsAupAiae4PrgZ9xOamSyk0XOc=;
 b=3U1STPeg+m9sPfl+i8L1bq93UX3ePSvl4gVL5qd6qvO+TeElmE2n8yKob1A0/JxT6+tq8K436gB0g193rYL65uPt/f8QF3KAvcq0K5Othrsa81siULxGgOUjndkCLGGI4stC9rqLN6SEa8Z91QPFOE4Th7dwKwOa2DUP0h9E29s=
Received: from MN2PR04CA0006.namprd04.prod.outlook.com (2603:10b6:208:d4::19)
 by MN0PR12MB6248.namprd12.prod.outlook.com (2603:10b6:208:3c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:34:10 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:d4:cafe::af) by MN2PR04CA0006.outlook.office365.com
 (2603:10b6:208:d4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:34:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:34:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:34:09 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:34:05 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 03/46] drm/amd/display: Add NULL pointer check for kzalloc
Date: Wed, 24 Apr 2024 16:31:19 +0800
Message-ID: <20240424083202.2647227-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424083202.2647227-1-Wayne.Lin@amd.com>
References: <20240424083202.2647227-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|MN0PR12MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1384d7-703b-4f3c-a26c-08dc6439504e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UyMu+TzlU/wvBTIQxU31Ou/NzOm4QaIdoRBaqH24js68Hi5n+1mk++rRgkBn?=
 =?us-ascii?Q?beo/x5QIy29EoY/kOVL/n5ITeLJUZSlMQCnRISIv8bANUfsmOXZEJtLl5QAE?=
 =?us-ascii?Q?X7/+/kTqZ66P2Jc9xlNc9tH4Y+fmROmN3pn07KZKTKJzCduyXFbGzHATNIbi?=
 =?us-ascii?Q?rVWTtZysv+7RgTvii0/VK6MD+9ZD/SvxEhyzOtdV8CW8Xk92D8l3eKFaMPwf?=
 =?us-ascii?Q?h798TmrblDd8HM0RaMoByVh5+Be7DPYlJEk93rosQvJCyrYZvu20Vh2JERH1?=
 =?us-ascii?Q?+neICXXgkmOT/d7yLczD062Kmbb9kq5fQ5UIKvdxcCXC9d6Lvcs/yHEgEsoq?=
 =?us-ascii?Q?3ixbxPZH69t+3mQIOW4CJ6Zc7Blr9sn/MH0SoF2sdxhI0xaBceeeP8PrBhlZ?=
 =?us-ascii?Q?y8sFD92Q71Ug2xn2cRI4K+fDI+wSqP1iioTHeWSQ+NbcG73nswX5GB1NhGZP?=
 =?us-ascii?Q?XbmJh0P9TQHxylj2L4zjITWs/32UdQBr1+o5ewfmBW/luKnnTgk+1mLiFTQ1?=
 =?us-ascii?Q?N+GV9GKYXNX6cbahzYD4YODTbgd2uHmNebI5hxR0InGerv+rohJhNoblhbNv?=
 =?us-ascii?Q?f3kGiI6niZ6cP9p5asnDVfcDlge2705pfGxhTXosxzNQtCYtY7/ly/q0FVRZ?=
 =?us-ascii?Q?AFuRsE8URSG+gYNBQSG6BtYAqfdJfCoWTB1oRM21FnMfFsgGzfpVUL7keLvE?=
 =?us-ascii?Q?MM9RDeLZhPJ2u1hWm8bLGuILIvYkdIb+NWnpoBN0/p88Vri4nNJ6psIQw1X4?=
 =?us-ascii?Q?9vxDR6zXcYWWYOramxOfT80B/CerLZJUGGzoeVSCLMl63SfG3ewa3DlQFxgN?=
 =?us-ascii?Q?Xd3mP52MH7KiaJs19d4uEPtQKjHJOrCZWu41qOxAPtR4Uf8iYZOk9BaMLeF2?=
 =?us-ascii?Q?RpkgGBxMzfKkUYwwmyxlF+st3I+ooL9Aos2IbWNl6Oozsie4xWZ5Z1ovxf5P?=
 =?us-ascii?Q?qx4PcWfzZ8sX5xZA98G3edno/Py6TBV55R8aRL1u7EVzNfEsSbWWfLArCTvQ?=
 =?us-ascii?Q?AL9geirZh8D3wIftej6Rqd592JsQK82VRIdQRH8zyaogJsD9hXCuXjWxWNZ5?=
 =?us-ascii?Q?sj5Sdb7ogFmrLflKeBaeFa6UhKxnsyWfAngcQx0v9qZOCNj9Q/rgx0/IVcnB?=
 =?us-ascii?Q?2dpcQHg5kzi+dXO+7XIrmTogV0UQgW2GF9zsDZTCQPGyVOkgXcNxKOpRe3Bz?=
 =?us-ascii?Q?7qERoWh1LkejEqjLh/PzYf2gO3l/T6gZXaYR4BI7iwhU73aq3sQd3r208FVd?=
 =?us-ascii?Q?8fHLwVZnZBA52gcSQ/DHfrhb2kP7qqfvlGiMPGTOmyacOBkcyanHYuml6qqz?=
 =?us-ascii?Q?0BaUKX1j/oPFRF6epMfAPx8TWhNWqPpH/peX0qpyE3M8WN9oUOe0ElyIVUlY?=
 =?us-ascii?Q?QFYpHG4loi6l54J4/C2LUbshFhPT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:34:10.2544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1384d7-703b-4f3c-a26c-08dc6439504e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6248
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

From: Hersen Wu <hersenxs.wu@amd.com>

[Why & How]
Check return pointer of kzalloc before using it.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  | 8 ++++++++
 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 8 ++++++++
 .../drm/amd/display/dc/resource/dcn30/dcn30_resource.c    | 3 +++
 .../drm/amd/display/dc/resource/dcn31/dcn31_resource.c    | 5 +++++
 .../drm/amd/display/dc/resource/dcn314/dcn314_resource.c  | 5 +++++
 .../drm/amd/display/dc/resource/dcn315/dcn315_resource.c  | 2 ++
 .../drm/amd/display/dc/resource/dcn316/dcn316_resource.c  | 2 ++
 .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 5 +++++
 .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c  | 2 ++
 .../drm/amd/display/dc/resource/dcn35/dcn35_resource.c    | 2 ++
 .../drm/amd/display/dc/resource/dcn351/dcn351_resource.c  | 2 ++
 11 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 4cb0db0ed92f..8083a553c60e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -560,11 +560,19 @@ void dcn3_clk_mgr_construct(
 	dce_clock_read_ss_info(clk_mgr);
 
 	clk_mgr->base.bw_params = kzalloc(sizeof(*clk_mgr->base.bw_params), GFP_KERNEL);
+	if (!clk_mgr->base.bw_params) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 
 	/* need physical address of table to give to PMFW */
 	clk_mgr->wm_range_table = dm_helpers_allocate_gpu_mem(clk_mgr->base.ctx,
 			DC_MEM_ALLOC_TYPE_GART, sizeof(WatermarksExternal_t),
 			&clk_mgr->wm_range_table_addr);
+	if (!clk_mgr->wm_range_table) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 }
 
 void dcn3_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index d7bbb0891398..b9e1f3e0b31d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -1199,11 +1199,19 @@ void dcn32_clk_mgr_construct(
 	clk_mgr->smu_present = false;
 
 	clk_mgr->base.bw_params = kzalloc(sizeof(*clk_mgr->base.bw_params), GFP_KERNEL);
+	if (!clk_mgr->base.bw_params) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 
 	/* need physical address of table to give to PMFW */
 	clk_mgr->wm_range_table = dm_helpers_allocate_gpu_mem(clk_mgr->base.ctx,
 			DC_MEM_ALLOC_TYPE_GART, sizeof(WatermarksExternal_t),
 			&clk_mgr->wm_range_table_addr);
+	if (!clk_mgr->wm_range_table) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 }
 
 void dcn32_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index d9e98abb3640..fa1305f04341 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -2050,6 +2050,9 @@ bool dcn30_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	DC_FP_START();
 	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, true);
 	DC_FP_END();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index ecec3b69bb88..d4c3e2754f51 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1310,6 +1310,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
@@ -1766,6 +1768,9 @@ bool dcn31_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	DC_FP_START();
 	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, true);
 	DC_FP_END();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 3bae606ed700..ff50f43e4c00 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1367,6 +1367,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
@@ -1727,6 +1729,9 @@ bool dcn314_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	if (filter_modes_for_single_channel_workaround(dc, context))
 		goto validate_fail;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 515ba435f759..4ce0f4bf1d9b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1309,6 +1309,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index e808231e8478..5fd52c5fcee4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1305,6 +1305,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index d17241a882bd..022d320be1d5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1305,6 +1305,8 @@ static struct hpo_dp_link_encoder *dcn32_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 #undef REG_STRUCT
 #define REG_STRUCT hpo_dp_link_enc_regs
@@ -1752,6 +1754,9 @@ static bool dml1_validate(struct dc *dc, struct dc_state *context, bool fast_val
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	DC_FP_START();
 	out = dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate);
 	DC_FP_END();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 3816678b044f..e4b360d89b3b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1288,6 +1288,8 @@ static struct hpo_dp_link_encoder *dcn321_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 #undef REG_STRUCT
 #define REG_STRUCT hpo_dp_link_enc_regs
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 25ac450944e7..2df8a742516c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1368,6 +1368,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 #undef REG_STRUCT
 #define REG_STRUCT hpo_dp_link_enc_regs
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index ed98bfd9622a..982526c41d55 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1348,6 +1348,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 #undef REG_STRUCT
 #define REG_STRUCT hpo_dp_link_enc_regs
-- 
2.37.3

