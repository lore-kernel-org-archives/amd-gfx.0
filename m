Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18451C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0DA110E4B8;
	Tue, 30 Jul 2024 07:20:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gMYkB7/u";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12FF710E4B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:20:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2Fin+qQ7mRRjCVJShstV9dmyH65IZGxqfFcpoPziMnytv7FJilqvnsAjE574metVNU3BY3cUkCaiVrQBIpUcpb4o/3ljNnGxPeaKVDh0jlGs2JHAzvMWd8FhxsvMKH8tNwNOwmrEF6M7AqJRL58+ZS08tWBns5hlxfotMYg/BXKJn+xLXlv5cLtMSMOFMIYfeskqOjbyU6DzGwbY5ZZE0zb4VBt+zXgvglEi8ZujRULmD3/P4to/bvDFsp5ylcO7x9uQxQpbylmpKZYP5CXuShX3+VqByPWpFnKXDJ735SRgKXvtRgKJlGAH51+XpJm14QW8guxeeaHdE53LPDStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVZTicinlQ8CYIyzERzdNdGSyA97AwbprYYMyfrhNmU=;
 b=cW42FPa4UfZ4UPFJp0+Yzr8PQazP9ol0jdQKO5TIar4D+ZuxFdwuCjkOGlvsiBAnH7fdHNdMF24Qe7c08iUDu5/JwPrC8ino7v8R1AoXdTDM3fo+ouCe0WFKp56p68EnttPHTGbBzGTCBTogAOcrMaRtTbq/PBu+ny4K3OfD3SWS9jGESvY6h/4PjijR4fyT2LMkQK/vGLI9Y6/P1o1aug3Oot7ablgb13rgF0WxA20DhWPj5jZufQWuzFNsj/nfxqf/JYluGwkpLjAw5y++NNY+TO/cHJaYGu61fYiJJTmVVECm2ov693SxKabnJ7Olsr/Q2Fu7dRxXhAeOPlqrIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVZTicinlQ8CYIyzERzdNdGSyA97AwbprYYMyfrhNmU=;
 b=gMYkB7/uq1o5dCX/sfh4HTtBct4yGFJfxl1DuTisQCcYlLVU/RtQGnlwwu/qE+YVLqOXg4oY0DsTCCzF6EOkweLIEBs4+yDHL2K3GLmh3Kq18MMBQxrqoPHXT9scn7e/XnEFuo0WSQ41La3wSawBkhoHnTyHBGk08jQxAZ2FRoM=
Received: from BN9PR03CA0312.namprd03.prod.outlook.com (2603:10b6:408:112::17)
 by BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 07:20:09 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::4b) by BN9PR03CA0312.outlook.office365.com
 (2603:10b6:408:112::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 07:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:20:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:20:07 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:19:55 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 07/22] drm/amd/display: Fix overlay with pre-blend color
 processing
Date: Tue, 30 Jul 2024 15:18:28 +0800
Message-ID: <20240730071843.880430-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|BL3PR12MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db98ff9-1e2c-499d-930a-08dcb0680b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FKnumc3ogs1+kagtErtkB0yMKr4S1cogm4t36b2PFy3WY47NFqxnmbiqWVwa?=
 =?us-ascii?Q?U4kkdMsMTb3AKf9geWY8z9ddaOpiBaDBIFMzSZUNXQXLTB2kqR5DHpPSujjo?=
 =?us-ascii?Q?M4u24GF3ynh8w/a5AAHgJsIHha2GD3+f6/V9k4vBTlz0wQH/Mv420TLc4xK4?=
 =?us-ascii?Q?FFn4s6cjihICcgbbJAfUmXFJLxdEYbSURoWtjN8g3VscAN6LS9733ZRBqbqC?=
 =?us-ascii?Q?DvWJbBePX+6bugXKna1ZSgSIM6gMv3fKvmvkKFryVe0jjUer3TDHS3xA6zs4?=
 =?us-ascii?Q?GsduQqjmc7JcadDIgs1XuXIu2SR1ZuMwE075zctwGoFNwwJoT8E9kjreNhTA?=
 =?us-ascii?Q?vQLZt0rtJhEcjmlFkqIGoWBy71QbAmj8beAaIrZFPFVS6MqydGD1RECQ3M+Y?=
 =?us-ascii?Q?mqnf92JJjtogB8ePDDdT7D3ixhwj8e7x4BGAyq70ck2FG5KN18vZ/oMDtq1i?=
 =?us-ascii?Q?8J1opz9zlbYU+ycqV8bWaihwF7SHEkmWPv8Nn8i8u3GHSwVzi5IsG+tKsHxY?=
 =?us-ascii?Q?6z+xAImp/KZKGsMlttvcEPQkbReLMJQmF90yboPNwtvSeshlPReYTH42jQSQ?=
 =?us-ascii?Q?sJ4cT2Lhxfl8TjctUfKIKM90glXOYiktuZpt7MN5VKPnnwtpaV4+G+2ibINW?=
 =?us-ascii?Q?DeWDyfloHEQcvIbF8Kreg0yqn/tB8CP8fFFgJwC2WzC6kscd0mzk4QI9ooMC?=
 =?us-ascii?Q?kHxw3N5Z8PjTmqXft9D5UUcI3kDJubGRmyOxgY5LpuWHq8VhLW20OLrhGwu/?=
 =?us-ascii?Q?cxb7lTfDA/3C2SBKytgMp3vgkpt70D1Wxxa6de+qECrr6F8tFPsFeRhUQwe8?=
 =?us-ascii?Q?GHOlB/CrpfB4v0zg6eI28CovGoTJQGKfc8LLHYmF2A8TAiYwBHVbL52gJUjj?=
 =?us-ascii?Q?/SbvcL5Kgxh8xr9Y0MQ/EPoyNqrfXFzKSowCN5In5uQR3k12d8tCJAZcxH0l?=
 =?us-ascii?Q?QyXzggOdp0YpY7ERlvoEasjvEzMMYBgfRk00yWfc01bDHRGQZGuOsgWD7YIS?=
 =?us-ascii?Q?dIskDrsOXIaTB00ekbo5b+eFwAHun8Qu6pDQ0iStF6+kwSYzAEioCjSb6jiV?=
 =?us-ascii?Q?qKRfjORBH7B9+vhJbioS51TPtpUHoVcbeqf5fSaBrF7q13NB3IVG4KaElCs8?=
 =?us-ascii?Q?LLabeCPD7ZCkEfJP6DXPIiaEMB9XboHupH9oK/bg8JZ/+DfRqpmig1ExpTxU?=
 =?us-ascii?Q?sFdVySJky3uq8fuLa9ItB6OPXaxMvtZCRYTs/Us8b1AOemRyprEB2fQG9Uwv?=
 =?us-ascii?Q?HHDdGIVB3MCuUSXKjESWMuT57oPnpX3yMwhdBirrkvSXlU3XOyJGdTNd+Qbi?=
 =?us-ascii?Q?juFWbDmNbx+QcX5ZrFLgcLORFCO/bkQL+Gm2mQ9X5Zm2e8DBPoBFbGEXoX/f?=
 =?us-ascii?Q?P63gqNMbwj8Rba411oJ6CS+8QiQMR6OVmtrtcT5CYvErcNhCgFaih0yuZ3mQ?=
 =?us-ascii?Q?Wa2TSa2iaVeye+jo9FWmGf+DYpeDBiEY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:20:08.9020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db98ff9-1e2c-499d-930a-08dcb0680b24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6474
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Overlay works similarly to MPO, but uses global alpha on both planes and
sets the desktop as the rear plane instead of the front plane

[HOW]
Ensure that top plane isn't overlay by checking global alpha before
applying the previously added MPO fix

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 3cd584419b88..a7b5b25e3f34 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -2586,8 +2586,11 @@ static bool dcn10_is_rear_mpo_fix_required(struct pipe_ctx *pipe_ctx, enum dc_co
 
 			while (top->top_pipe)
 				top = top->top_pipe; // Traverse to top pipe_ctx
-			if (top->plane_state && top->plane_state->layer_index == 0)
-				return true; // Front MPO plane not hidden
+			if (top->plane_state && top->plane_state->layer_index == 0 && !top->plane_state->global_alpha)
+				// Global alpha used by top plane for PIP overlay
+				// Pre-multiplied/per-pixel alpha used by MPO
+				// Check top plane's global alpha to ensure layer_index > 0 not caused by PIP
+				return true; // MPO in use and front plane not hidden
 		}
 	}
 	return false;
-- 
2.37.3

