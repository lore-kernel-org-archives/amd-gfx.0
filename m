Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41FFC282D9
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A52D10E6DA;
	Wed,  5 Mar 2025 05:16:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XxNlY+70";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC7AF10E6E7
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFr3Ehs09KjQ5I2tamZ7DxztplN39G894tO5eW4ILtaT6eKcOUJGVtEY1mp7HpeK0N+osN4m7K780BHL3/erSn+njXl9fslXTYB6XePnovENWkD2OsFrTwpMxIYOsjrtZ8ZtOnwXKvnEt5P6WWA7Ywnl30/Yldm2gpZNW2vnSGsVKZBjNnMJuDAQjtTubg/L5Xh7yFP7JkiybQTK/mOr2tgec7KnkZUhufx+EfZc4krWsMR/n85UUQI09fHlZCvvitFKlBp3cykwh+xBZyYv3S+lDuCcg53OCpHtuuNG+GyueZRb+sdYLLsy8zl6pvMLKKilbZb6ceK/Z8SW53EY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tscpGdB1+Ddbc9fip90tk4Fg2O76J0fnZQpxY0wHw6c=;
 b=qPKViA6ILcEe8iwzj54s+YPfOFUvEj3cf5MCHyQlvRRlbXc9QiTJ9jBtFKU2jTiTxNSACrgUz5O1Rjq1+ORnhZKPsjCK7I7A1pO3IMQ+NIU3nLDnv0RRhI/vdbmbhFnn09HNYRx8mHuOCchcSpvlBW9opCMkRQJzWqprSJMFY0TJX0QE56kEutnCpj0sCt0qBS/mGCsWqPqamKB+s8sKTcmyDtLR6OPzO3IN4tbbuDvJyeSQsYBSBDlPbruCIiUSrGOh5PXwu4/zaCKM2yFJ8iLXmJl0thYsps58ILvlpDYRP8czPaF5Yo1vyAPvuPJb+lTWyzgNxI7/u2mXazouEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tscpGdB1+Ddbc9fip90tk4Fg2O76J0fnZQpxY0wHw6c=;
 b=XxNlY+70oyGv9e6GaWXcVF4cik0dWAQvBjzBloq2co+2LoKhOfsjlWfg68WgueJliud8ScjTwB8UEePVJxO2ubDVncMKNzxltFfC/sCimtl6TG2vtw1UdzhXBRsDjGUDcPhFD6wnnGj6WEOJUCqitD7ahu5oT1fjmayMViUI2FM=
Received: from BN9PR03CA0628.namprd03.prod.outlook.com (2603:10b6:408:106::33)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:16:17 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::d5) by BN9PR03CA0628.outlook.office365.com
 (2603:10b6:408:106::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:16:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:16:16 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:16:12 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Leo Zeng <Leo.Zeng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 14/22] drm/amd/display: Fix visual confirm color not updating
Date: Wed, 5 Mar 2025 13:13:54 +0800
Message-ID: <20250305051402.1550046-15-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: d86fdff0-1688-46d8-75de-08dd5ba4db4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T8laVbIZpFffjdjochd5TLpIZvNICW6348i8u4D2S0i1D9k+9ZoQn8225syb?=
 =?us-ascii?Q?k5YTy/TEzeTVbfnaXTLeZQ/Qk+M/ZStc5j5eiiDdGUxnJcX9ywoSJKSHApA6?=
 =?us-ascii?Q?QAT2ZU0dFSoAeHwr6Wd4CKJqVikQwAdRfWiVqual8wxe3btk51e4QvKMSL1D?=
 =?us-ascii?Q?WHaLdgZaiwDVW0kWmc5UPvtI5ZDy6AiMIVT7XP9sv7eQ82C8RhCEX5BfeFJk?=
 =?us-ascii?Q?lLycToV9mXGxN3XXoPmujvxPRvXYsQ6w6xOk93UjJfI0PLatc8HFa+ljkJ9V?=
 =?us-ascii?Q?A18qq/O/d8Uwb89e4QREZ3qGLM5EegUKue6KiPX284m+iqO8y2qiuyMm610U?=
 =?us-ascii?Q?hUFdct1DQpyDrEn42Xjiv3EAuKvUyL9YWy9mEmezWHZQJ0KWBU9rKZ8iJKOf?=
 =?us-ascii?Q?vBkkf42vYGQTyeInvvVHS+P1OdDCrl9K0KjY5Gl/kYlmS1SideiwpOgDBw+C?=
 =?us-ascii?Q?5CVhzvzwcM9zEFKzg5xjujZfsUbITwqYA/JJISeh3zMgXd5hQz1gR5e+S2if?=
 =?us-ascii?Q?iuPFFpkOL1qwiYrq7XiPrahLWeXyWYleK8wx7/JFAIPued8zlOJwkUZfZQPH?=
 =?us-ascii?Q?RUEu38rOGTHa8GUOztMWNC3iTvOI93hK+q3hJlGgSVDvLkaph/6dkYw/RlQt?=
 =?us-ascii?Q?/WY/PMoilm7eVQKP0pLLtNwjtKNxZEUKNDWbSAodym5TnVeZjiHqMvfXrT6X?=
 =?us-ascii?Q?yKgNVeoGZY/wBcqvHyd308yxC7FmLcjKK6j7PyMk+J7JVMccmUuv4vjczXHD?=
 =?us-ascii?Q?CrBHqK7jCc1Ur478BN/8i6DAyOJaRIKEGSskEAFxRzUNSTyplmoZUWdZ6FeU?=
 =?us-ascii?Q?HOMyoGANn4NydrCPujIik63zEjdQlNOHgxsiXJMGVlznFnERsIYa/xjJfe2/?=
 =?us-ascii?Q?alLZY3MAYyc+GpLtkCOAYlAKdCESqbvnRIbYoHtpYYN+fVP6AkYSAQicQ7ub?=
 =?us-ascii?Q?uuiwyfixOj7CRJ2I3udlpq3/bjP/ySii2z7n4k+wv2iBxo/OrNPzYATWArgl?=
 =?us-ascii?Q?am8skWl+r4B7lLscZWpslUC4m8o3r72AMRAbQjSQoYZfvs7L6kedwCycgbdv?=
 =?us-ascii?Q?4R99TCL/g/8sUt5sJWCM01BINaHwm/CfxxdOXc6LpwVvVcxjR7u7lHojankn?=
 =?us-ascii?Q?dBGIf94LqJ4dh8kpK4v/lvJM8fwi46pwU+ZrbRlQEHFkpm3ssT+HPO/wEZPB?=
 =?us-ascii?Q?J9nrsuW+Riz/OeCl5PrG/f0+ocnWELH9XxzuTP62PN050bv7/+9nwvKgk2O0?=
 =?us-ascii?Q?cebPIVdQvkpndWwlcnB/gSHzrhoojC67xyfxLexNdXx/SVxcbTEwgS9av6IL?=
 =?us-ascii?Q?PvefIftqi4O94Ve0VhbJosIoA0w3Q9kV+xvL24xrb7ZllxIKU4h9O3jzwejM?=
 =?us-ascii?Q?ry+0ti2GVN/aBpRLZ4tk1Y7vwpUabllsa5L/hHweZrgaCPciW/MmNyx7UMkK?=
 =?us-ascii?Q?B817PdrZ7QEtdBI7JgB4dL2udGQNZDOr7paMt1qkIW1VoJQGs/vchheij9xL?=
 =?us-ascii?Q?kIA5n7wLKa/jHoM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:16:16.7969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86fdff0-1688-46d8-75de-08dd5ba4db4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972
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

From: Leo Zeng <Leo.Zeng@amd.com>

[WHY]
Sometimes visual confirm color is updated, but the
background color is not changed. This causes visual
confrim to show incorrect colors.

[HOW]
Update background color when visual confirm color changes.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Leo Zeng <Leo.Zeng@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 52ee2225e132..55b32dfbfdd6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -817,7 +817,14 @@ void hwss_build_fast_sequence(struct dc *dc,
 				block_sequence[*num_steps].func = DPP_SET_OUTPUT_TRANSFER_FUNC;
 				(*num_steps)++;
 			}
-
+			if (dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE &&
+				dc->hwss.update_visual_confirm_color) {
+				block_sequence[*num_steps].params.update_visual_confirm_params.dc = dc;
+				block_sequence[*num_steps].params.update_visual_confirm_params.pipe_ctx = current_mpc_pipe;
+				block_sequence[*num_steps].params.update_visual_confirm_params.mpcc_id = current_mpc_pipe->plane_res.hubp->inst;
+				block_sequence[*num_steps].func = MPC_UPDATE_VISUAL_CONFIRM;
+				(*num_steps)++;
+			}
 			if (current_mpc_pipe->stream->update_flags.bits.out_csc) {
 				block_sequence[*num_steps].params.power_on_mpc_mem_pwr_params.mpc = dc->res_pool->mpc;
 				block_sequence[*num_steps].params.power_on_mpc_mem_pwr_params.mpcc_id = current_mpc_pipe->plane_res.hubp->inst;
-- 
2.34.1

