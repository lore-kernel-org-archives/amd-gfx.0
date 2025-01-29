Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F03C0218A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 03:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D63B10E730;
	Wed, 29 Jan 2025 03:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O26JxW35";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF3B10E730
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 03:06:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tY+tSaaoF1/0LLLzod5q3rK2WDJ/luzZAjQqP99gPWP1coe9I0wxOoGEBcuNB8/SZk4Er9uPT6sAEvZ+rVdUxFBnWdx9DOpx1tIGM1kkE3kVYB9l38ekdJo7m28isiVRQcaobH9q4qEABZAcCYcvzAzXemQ3ejyiExDtnpDFXXmwQ8SGbWq8/TBDR3ZOEolPmG2EExhCfiV7Asdqq38JWX8GAwaqwJHoF2LsROCl1rkOkMHTE17m75kTxL2HJFsuCeSc0Vz0fxo0YTCnZsnw73a1zAmMsf0qXmWy0s193gxEpyQCk1OGtTqYacyhIVHR7RajW1LKZoNhOStUO8l0qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WylRgdXbBGD3T9uLXcnlu2T1B9bgEcpll69bUA2A61M=;
 b=lo1WXn+mAKqxwQ1EcLr5BHQNLqWPyVaU3tQhOdXide3Iaby2lVJKndEiC73B2z7y1CX+0kAgIU78m4+QLqCk7TNtl14LcfJSQwvtkIHd9OokNiLsWp5ELCdTPqI+fSJlk25jdQRm4/eC9aieurP6KxdEixzJK7DUDNwvp9ToIkKTtPIu/lDtPes+gwEPiF7DRxUooRvrdSAHvZTrM9r2FitvX5jPcu8qjXcuA7QNQvW2Qix0tlFy42/8R1vOe+IHYB8PC5C7eqLiFCbnF76XitxawAXOB3oHPJwMQsqgiSO6ZLsDiO4sIedaHL9Nn5FU4IAMGSDtV9YHc3A2jgxnhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WylRgdXbBGD3T9uLXcnlu2T1B9bgEcpll69bUA2A61M=;
 b=O26JxW3558TK9cSQNbKacDkaqyFU6N+j5bEGlnzL77T3YiJ83+a0aZ9Vg/rubjDxwkCMbA/SS3kAIpCPcJKv+a9ZDSZhK4gXtCgOUlR0YDFeZ2JaiYezaxKA9TglPnRPAMgcP+ndC+3lCbfl4ashqa6EFBQk5O1zM/ss1h3iLMY=
Received: from MW4PR03CA0058.namprd03.prod.outlook.com (2603:10b6:303:8e::33)
 by MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 03:06:44 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::57) by MW4PR03CA0058.outlook.office365.com
 (2603:10b6:303:8e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Wed,
 29 Jan 2025 03:06:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 03:06:43 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 21:06:41 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Aric Cyr
 <Aric.Cyr@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 08/10] drm/amd/display: Request HW cursor on DCN3.2 with SubVP
Date: Tue, 28 Jan 2025 20:04:47 -0700
Message-ID: <20250129030453.2129085-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129030453.2129085-1-alex.hung@amd.com>
References: <20250129030453.2129085-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a31944-9098-44fa-c290-08dd4011f5c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4euA/exixifT4xAliTPJkEcSCHBdQY74Po4kNvblnyAxiCsX+kIywcUrB00Z?=
 =?us-ascii?Q?RwF1Z+W/p/+8dQh7x7yJtZjlkr9KLLa8nsZiZjAKAAkLVNuNjCikfaSyimig?=
 =?us-ascii?Q?NnIWu6e7/OCy1mpQFS3NJocvPSGmCp+1GjRw+UMLawq82hEj49iJDpK2hPDG?=
 =?us-ascii?Q?BrASxpyT8tTR/ymsQvDW6K3PIf1ZXrTVpBvjtTFgllh4CeH/YJ6SVvmBj2K6?=
 =?us-ascii?Q?eg5TSEI7Weo23y5TUbiNQC7WLlus6YO0E1BWPvIGLlKAn1UdiHZxpYhiCSkG?=
 =?us-ascii?Q?nlvqV1fzkQU5pi8hJmm/Ht+hjoHrZoyoxIwUs5tl2QoPyxwB8Cf/tvd18U2d?=
 =?us-ascii?Q?3Pq1Lma0LMcJHX0ldt1u+pNXT9sYjTx2IxFEbr7wRk5mEvgBHZcORtPODY/t?=
 =?us-ascii?Q?DB17JsL14MorZwb6CacLzZu4gZhrMuhRMf25XIyJ6vKFQvGXXtIaZHh4CTOF?=
 =?us-ascii?Q?z7MnoJptdPwZZ0DRC3+FHXIudaq+eORVFI/3wfi+gjKDdE+qLkQQjcLRob3R?=
 =?us-ascii?Q?Fec8wvqOA+lmDdCHxlDNdP0hrqU0R+DSoloIcE/sXGVgrfS+hcj/r0RS8qg0?=
 =?us-ascii?Q?+s2TzimQ1oSq+W3jsDCczzXHQ7aJlEvnAifTAkhWhnxZJz1qXtnbcCcrEwYY?=
 =?us-ascii?Q?4nfu/OBK1vqzITR7CKBqj6gXkyl2h6VQLaTk3c8lcMBPTwqtbRGhkK8vj3dj?=
 =?us-ascii?Q?riSYhNgYlvnN6D7tc7X5zMTFnEd4rI7U5S2W1xqNmCBxDFQScfrg0Vq6Qipv?=
 =?us-ascii?Q?tfh+g5/BggdMqbKhg8CHxsO0tInfEDPFLlMb7dmQmos+cycGNaDX+RGKuyg2?=
 =?us-ascii?Q?6Id/hg+ouhudTfsO5jFhp5ux+8cjpvFEXRyBVYa4ONE3PirZi1C2YOnnlcJP?=
 =?us-ascii?Q?HkO6El5LUbwU4P71rHasoOFus1sCSw8DJdZCmTFibtSlJW7BwQxZDR1zoX6F?=
 =?us-ascii?Q?L8cdF+gNV304g0JjwSAWxW1LtVbPRcYu0v4WY8O2eZzzrwnIIfVT3rYU4Wa9?=
 =?us-ascii?Q?R2w+FjAUQEeIF/VnkHdkhl9yIbB7g5bNTnqBy/nS/uyw7GcLmwilJrd+Luob?=
 =?us-ascii?Q?DOmZiDAfvIPI8qRiItVhI631NJXd3Qm8hqq1zTClevOKokzHKlqG4DEpd0ft?=
 =?us-ascii?Q?rBFBgp1R9Wgszdb8rT1dXKE2kG/lc8whGLU0bt+ILPbsEzM6ATKwn6vKWw8F?=
 =?us-ascii?Q?XXHOuY18ZJtiHlpl0dSenfuR+qi4uhUWZTdSv5qK4quw3lMbCqSnLpHaJ6L8?=
 =?us-ascii?Q?rO8KSuwLMKhkzav73PwPxZSTiBaYPY6k9t3jj1ffofmN0+plGqmek74tuT38?=
 =?us-ascii?Q?SPTyaSW72yLVMlXsktcvkJggHoFVhJ1jCnbD7/mSKW2UAqyZ9flqeWmc0PoY?=
 =?us-ascii?Q?bhXGGZZgSp3zqzcdGFlgpMMU8iyW8jatcTHzcktB8NvTSOePtIwdWrFXYeXE?=
 =?us-ascii?Q?j7f/Ted7QBfj+6NO1n/4d2wxd18Yoz5KGNctHNdVaga5hJV56C8oXIHLbKMK?=
 =?us-ascii?Q?cfMW7Lq4ZSzswoQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 03:06:43.6588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a31944-9098-44fa-c290-08dd4011f5c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952
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

From: Aric Cyr <Aric.Cyr@amd.com>

[WHY]
When SubVP is active the HW cursor size is limited to 64x64, and
anything larger will force composition which is bad for gaming on
DCN3.2 if the game uses a larger cursor.

[HOW]
If HW cursor is requested, typically by a fullscreen game, do not
enable SubVP so that up to 256x256 cursor sizes are available for
DCN3.2.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 6f490d8d7038..56dda686e299 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -626,6 +626,7 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		 * - Not TMZ surface
 		 */
 		if (pipe->plane_state && !pipe->top_pipe && !pipe->prev_odm_pipe && !dcn32_is_center_timing(pipe) &&
+				!pipe->stream->hw_cursor_req &&
 				!(pipe->stream->timing.pix_clk_100hz / 10000 > DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ) &&
 				(!dcn32_is_psr_capable(pipe) || (context->stream_count == 1 && dc->caps.dmub_caps.subvp_psr)) &&
 				dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_NONE &&
-- 
2.43.0

