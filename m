Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95227C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D481130D0;
	Wed,  1 May 2024 07:20:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="36oIYIQi";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B76051130D0
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+zgaMTSjXCuXzqpkzFsYKuD2c6ZeiD82zshIJVyN9CV3bLP6qv1mB6Le+At4bSah1K6n8N8zh6AQcLVdUJOalTkoN001cRB1zROEL9vXJjOeQBzq2lSj6rqVODpcPZscU3FZ9NuKoB9hwDRyQSl+s1htsvxOIe4x7y2S+zYD08ag9+cxDPjPxHWHgCIBkghB1VAtXoNUgCDYN+zpkdnL0vul4YonZa6460H6VFYo/iq0YKQ/7mrhdLDTCXCD3KBZ8tG4VDaNk9haRlClgldfl4wXGQ3OanaS6SZX61txvfXEUydeKGKddJt/FeR9WQ2E8THJeM49RdWpIdWbe4LqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6jujFRZs0KfB44SXWqqnAfki93D70/yo93XUZPQKrI=;
 b=d/lvx19EeGxpdhl0SK/8dbtmU9w6zXeWlk+jNSftbuu/Wbh3Wa9Egik07Y7N5eGyeXwN8hwjp52eZU4YuqSGQaFYqkhJTj7qLmuoOKPjm/zOCwLib+ZMxdlxj1mfDXXuY+6HqEn4AumCDB0csHDeskAjT+ZBpsfWj9kUUOVHFv708HkpS+agV2rPApRBuewp/jvzLUZSzk+WaHniA+0rsg9jcLQPYXPa8joCnW3YqlIuT2ufYN3VtkffBWqvEGfOy6ev1h8yW4aFkEGfEakHQU1Mmb+Rcx2yMeqK43YztBKKmdc8tlheSHrDS7jeEJTR+ewRU5dr0anNJKVwdaJkAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6jujFRZs0KfB44SXWqqnAfki93D70/yo93XUZPQKrI=;
 b=36oIYIQiJdyvnQFsMylUjYe4KWyif8VFPYeT43qzgeMbqT5U2Ix9OvccsXi8P9fxLj1gN9U9IHB4/mquG7geEB2oB0XTgLJJnG+JtzOEhZijCaELGuLzhoLf8oMNv1YP3VEclpLx1+TMySacUBS2Ak1/rKkuJL0NyQmkT+00hYg=
Received: from PH7PR17CA0062.namprd17.prod.outlook.com (2603:10b6:510:325::23)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 07:20:14 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::88) by PH7PR17CA0062.outlook.office365.com
 (2603:10b6:510:325::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25 via Frontend
 Transport; Wed, 1 May 2024 07:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:20:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:20:13 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:20:10 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Samson Tam <samson.tam@amd.com>
Subject: [PATCH 32/45] Revert "drm/amd/display: Only program P-State force if
 pipe config changed"
Date: Wed, 1 May 2024 15:16:38 +0800
Message-ID: <20240501071651.3541919-33-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7c3e6f-c9d8-4b82-1d89-08dc69af24ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l6xHvlhWsw99CHmdLpejuUByhNppzy+/RjdVbc8QPOIMvEBFWsE6zVUWK0BE?=
 =?us-ascii?Q?9ebfkryOFW2u6GNTLU4IgsxUJXRa+R7ZUeJPoO3Rv5LzgsSmxxbcxh1FCihZ?=
 =?us-ascii?Q?0pqF2XZlfzqQVr1YXZlwyX5U5fVQfcY4MiTSOgbTeXqv3f11NmyuSBROU3fp?=
 =?us-ascii?Q?ImQoIbtj5mumZlkoa/Fi1jCniDcxhS7q1ZD6wsX6KHRirD8OePP+Y+kFevVs?=
 =?us-ascii?Q?sN36YllH61pwCPz4nksCO1YBLxLMjgATojVSn2mdvzztHE/mGltpzz/bPktC?=
 =?us-ascii?Q?h7/Dqr4xIxERhm2KqzqTx4YCP80sPA/8nUmEPX1Xo3M5Cb2Lt+JrJsE+TqWR?=
 =?us-ascii?Q?CoCiyPSlssTKdHBtSWQq1CAuT+Zf+mHQ3tQ1b0ky54ZZsvR8xWdR6WQ4dwjj?=
 =?us-ascii?Q?bhjDL9T1n6aDILfB6zXe/iU4WN/YfRH+3GoOAyoZufU5nIfGTmls96NwMy5n?=
 =?us-ascii?Q?/hYNNtaMhKJcHzV+ybIkHrHpjS53FsPWqM1ieG1sBm8mXrioXc/UoOjo8aG3?=
 =?us-ascii?Q?u4rCRncXV9Cobcwck3AnxuMGryM5wkg+EQSFE1IxFqDRcgdqQX8bzyklCTWe?=
 =?us-ascii?Q?GhQ4qB8DMzywiAGBdse5gInLNNX2uDABQBlyqIQsizI2JrKQj5skjdQeHpbH?=
 =?us-ascii?Q?GWEJmtJU3YrJMpJxFN7dUhUaaiX1T17xgnLHzZHsRX/W/3rCFeQvcYvfolxQ?=
 =?us-ascii?Q?FdUFClCS8VQSqpnCezGLueT6u5XnhxZ8FhywE4+eeOj1ZFAcdXwMLx0pSc/T?=
 =?us-ascii?Q?S7A/enBqrgInXZBDjx3YydnFNKM2EOW2Ts+p6DZpPido8ZKX9iTmIitcp6OQ?=
 =?us-ascii?Q?Xy0ZFo19QImRTNNUPTOgjiKbWZBfoU65ssW5+spNILccwyLN6MDHBciEjOMG?=
 =?us-ascii?Q?NbUaSJOKHoJU2afkEe6GKVpYR7Qqh4KLI0X1B4cxn7kmn6vITXnM14WXd5oC?=
 =?us-ascii?Q?TQnuxxA6o3VmJjGA4Gx2uJFf9qY8CrarOXIsFi05DtoLKzptg+LQo9IL1zk5?=
 =?us-ascii?Q?6nW2JIbGbqCcsYtWDpE/sOi15bUUwmFR7Q+03ffSglE5kqvNTDSAUpTpl2zr?=
 =?us-ascii?Q?yTKBMuVvJVJDCpODjGu9a3f/NoaYFcqQIH0nOPgNr+RZyrA7yeE4dO5IO/3y?=
 =?us-ascii?Q?XD79IJ/gOm9QTquX345+Roa0i1oVBZO7X5Tq27KBQERLef3qZa9r9eaudvCA?=
 =?us-ascii?Q?As6/wFa4h2Xb9cpgX4R9oIm/awFz7lunTJpfJD68HYhb59Q++Y4gbwZQzEi7?=
 =?us-ascii?Q?tH9FjqeGOVpMQM8wnSRSTmdVtU0mGLUcp0Vui+fCsiXxbRlaj6iKlwzJUeii?=
 =?us-ascii?Q?Er72Rnz+6erRGP4/YLLaJm7DYipDKgDfYoT1QgmYRu9JRYwDYsVVAH+7yTR7?=
 =?us-ascii?Q?XAN23SxOosB5esiIidmu70c58CLU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:20:13.6667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7c3e6f-c9d8-4b82-1d89-08dc69af24ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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

From: Alvin Lee <alvin.lee2@amd.com>

This reverts commit 2147d93a90cc ("drm/amd/display: Only program P-State force if pipe config changed")
Which causes regression.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c    | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 901e3b531a12..ba4b2786f440 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -614,26 +614,10 @@ void dcn32_update_force_pstate(struct dc *dc, struct dc_state *context)
 	 */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 		struct hubp *hubp = pipe->plane_res.hubp;
 
-		/* Today for MED update type we do not call update clocks. However, for FPO
-		 * the assumption is that update clocks should be called to disable P-State
-		 * switch before any HW programming since FPO in FW and driver are not
-		 * synchronized. This causes an issue where on a MED update, an FPO P-State
-		 * switch could be taking place, then driver forces P-State disallow in the below
-		 * code and prevents FPO from completing the sequence. In this case we add a check
-		 * to avoid re-programming (and thus re-setting) the P-State force register by
-		 * only reprogramming if the pipe was not previously Subvp or FPO. The assumption
-		 * is that the P-State force register should be programmed correctly the first
-		 * time SubVP / FPO was enabled, so there's no need to update / reset it if the
-		 * pipe config has never exited SubVP / FPO.
-		 */
 		if (pipe->stream && (dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_MAIN ||
-				pipe->stream->fpo_in_use) &&
-				(!old_pipe->stream ||
-				(dc_state_get_pipe_subvp_type(context, old_pipe) != SUBVP_MAIN &&
-				!old_pipe->stream->fpo_in_use))) {
+				pipe->stream->fpo_in_use)) {
 			if (hubp && hubp->funcs->hubp_update_force_pstate_disallow)
 				hubp->funcs->hubp_update_force_pstate_disallow(hubp, true);
 			if (hubp && hubp->funcs->hubp_update_force_cursor_pstate_disallow)
-- 
2.34.1

