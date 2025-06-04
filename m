Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D381C5B552
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC5610E7CD;
	Wed,  4 Jun 2025 19:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H8+2Pa/b";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A99D10E7CD
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:39:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaXrMDZrOZhmLtKBk/NCgd7M9p4qwWgUA7zJS6sUmUACRIkJQSc+TtwV+2wYiZ1Cghqak570idld9hIdmyAPVFmlj6+O+BklJg2iM4L/8PPZZ2w3HBWSOEbPblmJ6scpMFyrnzM+/UNoWI8YAz/RLlxNSrfE4PX7DaPmM40DdIlO50pq/wQkXQZyrtbgIXTyhrvPgc/3aciDVll8YzHox83zIOG4gFIL8AYMVt+ru6IIe0Rnf3iVCs5v+dgzFtzEb0h/Ed0QHBHnC26m0qAnQ6N4fMuQBKgwQfIjHxnLPy6dwD97lWPeDz6Vi24tLHkr7V/4oyjo3IsCHXbMaWsecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4v3pAPIK5jeSjGXilL28gO6sXchuckIXdm3Wp5QN7g=;
 b=jGUsuSp+trrL7F7OeRLIsBy0Bs74giSvMiwT7FYweX8EkYCyxwbpZzVKxTTuOknbJ9YPXHSmavPc6bDaaFyvuBiZSFvcdv7YYKjFlHKAQtENVXVErjOW1aOA5PkV+NX0uyU8kuVH9hYhZq8caTRqltjmbZ5MR07y0hFSTQZTafz8/XIgmKXSTn4GOKMrTVYir92llWWSy9V6tRpC5q1NrmQeDCHXiMQ0uwtXHW8ct3bjFwyh4S4IgXIe5bOgBanEf5Te5woTn32Vj09KjU3XlBKZSl/bhSVYL+jAxvTaIFCAys4MX4fNTP3Ldcy7SFspn1RG6SvbG9IgOn81jPpyzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4v3pAPIK5jeSjGXilL28gO6sXchuckIXdm3Wp5QN7g=;
 b=H8+2Pa/bGIojXXELFAJa9rUyMEt3PIF7PAghcuNvddv/ue8Ghw1I1qPm74QaosCQoisSmmxIzzIngfv3PaifVPgLo7FigBkU/ZrMsXtkRIZGamLLDsZAOA98fPt864lxD4a7kZQew1OAyh/g+bjrKBDd+NYb2WiuonCEkMAnpWo=
Received: from DS7PR05CA0099.namprd05.prod.outlook.com (2603:10b6:8:56::20) by
 CH1PPFC908D89D1.namprd12.prod.outlook.com (2603:10b6:61f:fc00::623)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.39; Wed, 4 Jun
 2025 19:39:11 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::8e) by DS7PR05CA0099.outlook.office365.com
 (2603:10b6:8:56::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Wed,
 4 Jun 2025 19:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:39:10 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:39:08 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Duncan Ma
 <duncan.ma@amd.com>
Subject: [PATCH 08/23] drm/amd/display: Add more checks for DSC / HUBP ONO
 guarantees
Date: Wed, 4 Jun 2025 12:43:19 -0600
Message-ID: <20250604193659.2462225-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: ee76e253-e8a1-4bc7-3e3c-08dda39f7aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AtqotKv0wdNMHdMV1qIWpcFDUoyb07Bxf1ojvL5YVrrMHmKgBPiq5N6OT9gS?=
 =?us-ascii?Q?99g+1gNv1c8C6aJJ1rPdUVqrOD1P7n8wvvCS/Zjjm49TJjs6Qh8MjTaIbhGG?=
 =?us-ascii?Q?vocLdpu+IHfx4w+VIh3FGFd3PCJX1L9qc/stn7rTjWWqLn/Fh55qMehtAUD5?=
 =?us-ascii?Q?J2ezj3fwT5JQtYxgQEECt77fLLYUOEfZwZq4oyW4k2Elqs7kyWTxDr4a0PCO?=
 =?us-ascii?Q?0lqupbQM/SbV1mmutEWPKI52GtShXJqtVR1X+ZIUSfEF+pTfw5BiKVN1p1J/?=
 =?us-ascii?Q?5V7yJ1mX8A8KltU1ecRNzOgbFpkLv/iy5pXPk2HWvNy5lvSJwdDKGgcXB9ys?=
 =?us-ascii?Q?+osMEwlOYjgiThZR6KmdLfYxUPq797JYUXEQMfktKNh/1il9ujiUWoyW8nY0?=
 =?us-ascii?Q?s9Lut6sjAcX0YxTmyoitD6ZoGCvQU30RZvl3Qi5zpT0LhULwLlbQe7Du2dzD?=
 =?us-ascii?Q?wGMblBIfFAJFbrzB8emQ1kd1jCpx8DWtbl5pMFlwkDzb5Y6c76PFCFUU00Mx?=
 =?us-ascii?Q?M3YaG7EIHe5pvPkgKRFhi+HB5g2tpboCWDq5Cuf9AsGpl01MmTjUxkaU7d0g?=
 =?us-ascii?Q?fsf8IbFXcdMHpw7LGvxYwQhDpveKLWBIRLkouG6GhvCrSQlOjn8PZmpBgtV+?=
 =?us-ascii?Q?PH3T9kM2atYXa6C6mHjPdMzk4Fe7IXCOcTlxr9pKtkNmTYQNhVLy0nIOG8Ov?=
 =?us-ascii?Q?XlouoM7A5f/ToP9SU1Tu+PlNPQ2ePaFZw5icZ+LxWgyZXH1k8RjUGzNjOJkO?=
 =?us-ascii?Q?fPJi9WpaYFAIFdVT2aa4YinCnmI+p1r7yAsidm0uoAlaLNebzlb9FJhxfktO?=
 =?us-ascii?Q?H6YWiIRTwb8ag0RY4URbHtHondud5+Y7I9z4REs1PZR4C77UDYl6tqgTSCz5?=
 =?us-ascii?Q?MiuQg2Pd3YjxvrdPYpHeSQT7iRHLYWe9jP7kIBn67OmwuDhIMIN/vllAzDsj?=
 =?us-ascii?Q?/Icw2KrPAS5nrf82SzF0p4bnzUjccnbqirEz0VWC/qO4t6kJgP9snT0LOYnx?=
 =?us-ascii?Q?L4xQtjXIyeL2TmrMoNxItCMODd/bDVm//DARsldTCCAaQy3yExToZpXuSBWp?=
 =?us-ascii?Q?IERGb0vLg0+fzoyZQevoXEfu9tJkVLTucots1F9QbAfnn35rKT6tGmqYLqVk?=
 =?us-ascii?Q?Gpt1gdelXjkOy5S5awodlTtr9yYvj6lfOT09iX1QV80To0gZ91oQDDo+6izh?=
 =?us-ascii?Q?TZMwnUaINmh6oyDSra3zF6D607Fns9UfFLW7ck3eQKOguyRcKuUWbl+RvOMW?=
 =?us-ascii?Q?iQ1E+4rF+J10Ou4BADkISBaSkAxpqw7gKEWskNxDegvsqU/NaRXyBg4FEy3Q?=
 =?us-ascii?Q?rCUEyb08NirTLE0NzHfSuiNgv+Di1vklBd90V9K5tYO2vGfA0dgxVia5rRGi?=
 =?us-ascii?Q?VKyVj1ja5Z7Ds556oHhzIszpxBrm/tVIxMsbz0EX+B43JhcujnWPk6PuiymV?=
 =?us-ascii?Q?Yfs0h5chXybKouPbPZ7fqPao4lumL9ds0PDZ49S1a4md/mFXdqRIfxapmkz/?=
 =?us-ascii?Q?akrclFDIlSE0+PsZz0/NP1WUpX/PK0f8zSgi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:39:10.8385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee76e253-e8a1-4bc7-3e3c-08dda39f7aa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[WHY]
For non-zero DSC instances it's possible that the HUBP domain required
to drive it for sequential ONO ASICs isn't met, potentially causing
the logic to the tile to enter an undefined state leading to a system
hang.

[HOW]
Add more checks to ensure that the HUBP domain matching the DSC instance
is appropriately powered.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index c814d957305a..a267f574b619 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1047,6 +1047,15 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 			if (dc->caps.sequential_ono) {
 				update_state->pg_pipe_res_update[PG_HUBP][pipe_ctx->stream_res.dsc->inst] = false;
 				update_state->pg_pipe_res_update[PG_DPP][pipe_ctx->stream_res.dsc->inst] = false;
+
+				/* All HUBP/DPP instances must be powered if the DSC inst != HUBP inst */
+				if (!pipe_ctx->top_pipe && pipe_ctx->plane_res.hubp &&
+				    pipe_ctx->plane_res.hubp->inst != pipe_ctx->stream_res.dsc->inst) {
+					for (j = 0; j < dc->res_pool->pipe_count; ++j) {
+						update_state->pg_pipe_res_update[PG_HUBP][j] = false;
+						update_state->pg_pipe_res_update[PG_DPP][j] = false;
+					}
+				}
 			}
 		}
 
@@ -1193,6 +1202,25 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 		update_state->pg_pipe_res_update[PG_HDMISTREAM][0] = true;
 
 	if (dc->caps.sequential_ono) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
+
+			if (new_pipe->stream_res.dsc && !new_pipe->top_pipe &&
+			    update_state->pg_pipe_res_update[PG_DSC][new_pipe->stream_res.dsc->inst]) {
+				update_state->pg_pipe_res_update[PG_HUBP][new_pipe->stream_res.dsc->inst] = true;
+				update_state->pg_pipe_res_update[PG_DPP][new_pipe->stream_res.dsc->inst] = true;
+
+				/* All HUBP/DPP instances must be powered if the DSC inst != HUBP inst */
+				if (new_pipe->plane_res.hubp &&
+				    new_pipe->plane_res.hubp->inst != new_pipe->stream_res.dsc->inst) {
+					for (j = 0; j < dc->res_pool->pipe_count; ++j) {
+						update_state->pg_pipe_res_update[PG_HUBP][j] = true;
+						update_state->pg_pipe_res_update[PG_DPP][j] = true;
+					}
+				}
+			}
+		}
+
 		for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
 			if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
 			    update_state->pg_pipe_res_update[PG_DPP][i]) {
-- 
2.43.0

