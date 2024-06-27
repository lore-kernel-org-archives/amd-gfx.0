Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95110C3064D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21A3910EB59;
	Thu, 27 Jun 2024 21:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CkplVB+I";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D541410EB59
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbHN48TVsPyC9menwf5sBSXwBoy/Ss3Mra8tXdCKSUlckyV/8aqf8XhBndMYoZXD8wrvygPeaqeMWc7lmvBS8wd7pChg/P5dphSO9N2EiHDGdUL9I2fbm7ao/6bgvB5kATyG/37TISxK4CJnzYVIL1Fi/2l7FiKIJipsCZKgrpMr6Fo0K+mqkJPXZZcrmmaJKR6RU+VphYoQ4e8jobHtFWhgIvmAh4mJbegBLstolvkUU+ZKLqvhQ13x7RTGcvjuczGUYnWDs1p1gAgWcdPXcuanU6dBq2Y1v0tsUuigLqwyLs28FMuzBvXIFrYQypWRh5xMUiiT6DOcKO/zzGZyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n74xOP2Z1aFMOukFNwCFYJb8NUBDjO8g+plslFIqrqk=;
 b=Y+DI+2A6fV865RDLsM4qurKx4AZgz9+J2fW4yWP1b+rt5q4+CvYxTylsdupwKXIY+Tr9vkLX9Rrpa4tsypJ0cf2RNL+sWMeWCtI6WmK91Cg+IrxbbVCJaL7Sc2xUAHIORQUVVY96s0hnV+S63Uys8rj+9Jk8tBjacHDIRkvCIeQWkoqAqyg4P5VOxlJurUHk2nSEScA46zftg8LdHm3QXjGjP9W0+/SVNymYbTwY/jy/q3DGktG0Ni0sb+lbOFI3nYRfwWNoTTqDcEI30lbnm4EBmjNykd7+LyGj/bXIMcXZjEcTGM9ITQ1WtV/w7dKnFlE249egzvkuBORTq5volA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n74xOP2Z1aFMOukFNwCFYJb8NUBDjO8g+plslFIqrqk=;
 b=CkplVB+IYNaQmSwHVdHFixbBRjcr8P6LpEVYExjV6mB0qy2zKkyCqAy6gkVPWdqlGyAmLm5efLn96wqcUSq/VZl9yGbfDiZ60JEwlRTViHWrFDPTG2bE2NimWBEcsuVL1wG0KZrxDjA7FxhMmyXotoE4qtLlmGO5/7a5R9YnqEI=
Received: from DS7PR03CA0196.namprd03.prod.outlook.com (2603:10b6:5:3b6::21)
 by LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 21:14:25 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::64) by DS7PR03CA0196.outlook.office365.com
 (2603:10b6:5:3b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 21:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:14:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:23 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:14:17 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 12/26] drm/amd/display: Check denominator crb_pipes before used
Date: Thu, 27 Jun 2024 17:13:15 -0400
Message-ID: <20240627211329.26386-13-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: beb2ac86-1905-4e67-dd59-08dc96ee1f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4JbkHhdVOCQ3htzwstTxXGD/yqxbxdqN+WiXe5MutMzPqPvCc/uE4PDIomTC?=
 =?us-ascii?Q?ZiaQLX9yGA+7JAOpbl2LL/IWPc+FEToEpQFSMXsR19ePPaxJsUA7Sli8b+FI?=
 =?us-ascii?Q?HfugUvsgvvTXPQhGw9wL2eVVH6HVO/TtHBxBUFTRoUuRR+FoZUVOGsLAq4Ny?=
 =?us-ascii?Q?g0ULMH9Ryi0eAUNtUTpwL7Ix3AixSSH9BmtIAIZ4gIOdumjrs52nynNwFwEQ?=
 =?us-ascii?Q?Ast3C947wBY2vk/pb0u74h7BlkESYQddXkNvT/c6ft4CpeC/T25GvGhGfvXO?=
 =?us-ascii?Q?JDv9MqcmH7nm/BEa7ZVzZZ1t6lDcZHMebj1EtpGFiTxpfxNkgepVdYpmT6SN?=
 =?us-ascii?Q?m3N1lr4A8yDW7yTtR3U9WiW7ooJtxK/tLjuO6wfOxkgAVEqjczswoOk9v+Ne?=
 =?us-ascii?Q?fVLZKkBrjWYD2WjLGiezsz+UpWTi4QeDdIQ7JEUqd4U7lmx4fxGbrhZIICBO?=
 =?us-ascii?Q?qHMpCntX4a4S+v7uK9Ar33dtuCgNLIlUumh/VRe/MpopBr+/n8vW5ckw+FCT?=
 =?us-ascii?Q?oUr3HSqMrFulaVV1qKOw62Z3/BOa/qzi3phQaR1IFBCIRlRsPFvWzTw+x5of?=
 =?us-ascii?Q?V5TLpi6wcKyec5M6GXuh83XdfTa7IcAFBs2B6LnpXKezBy+JunBcETJT7kvx?=
 =?us-ascii?Q?1cXwmr3JD2Z5wFd/peEkRG3Ohnzdt+2/M5XNklFGfGE7oNa7oZ9M2EPmClGt?=
 =?us-ascii?Q?sRHFOixT8NEugBVjMnmzvh2qM55Y7TpJIDNkidNwgz73ZuoJAiYOgsIMOFKt?=
 =?us-ascii?Q?WApgInpjVvXV9nMpOrR7DIzMkJ76DW8K+2saulGrv9oW0/Wb9WecRuFY7Eg4?=
 =?us-ascii?Q?e25FTH9HXawOY5c9VTT2YkJZGi3tEZ+KngdlcmpsU79z5lZRhmg+Nd7FO7un?=
 =?us-ascii?Q?vqAeyjmOHtEGYdv8R3N7tZyY0OKO2bGjWSTMhC/yGagT80tlNStt4zUuR2CO?=
 =?us-ascii?Q?4gJoBlGaRI5zYwsFQOSicsyPVxLndrQM88VrWGmk+80kNHPBPUnwfpRK3vz3?=
 =?us-ascii?Q?RHOOVfOkaV4Aovxc1HmT4pxbwL0rAVkszhL85mmy+BsU0EriZLqN2I2Ll98k?=
 =?us-ascii?Q?5oLykb7dFbTu4QwtIVMQnGRGCsGPEnDpKxJccibbXnZ10surh2fw+4HDtBNt?=
 =?us-ascii?Q?iim//LzW/sZeSYeuYq+OsYdR490cWPMBXiOl8lc3uApJLiOFYFnqr4WsUgpM?=
 =?us-ascii?Q?M1qeOBO16Ke5ALNo8zj4Px4JcGAEg937eE0ALrbhWKLpRAJEcTq/G+f9ggX1?=
 =?us-ascii?Q?rsponlL0ah+3um6FySZro8eDEfkNrXhFmw1WDesyHGn/8J5PGJsHVns3jprr?=
 =?us-ascii?Q?05iFt4sFRDoo8GMHCwCX3mhr89RHzul/qRRhbhJNDdr68zT2JKwgFm6Qral7?=
 =?us-ascii?Q?l7tNZpR2cLh5JzI7wuWri2erFxykfmLh413D7VkHP9YVpfdolhATpHnBxvS9?=
 =?us-ascii?Q?DAbYe22zQV2tf2pGJ2dbW4N9i24NK/OI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:14:24.7173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beb2ac86-1905-4e67-dd59-08dc96ee1f3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
A denominator cannot be 0, and is checked before used.

This fixes 2 DIVIDE_BY_ZERO issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index ad40a657e173..3f4b9dba4112 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1760,7 +1760,7 @@ static int dcn315_populate_dml_pipes_from_context(
 				bool split_required = pipe->stream->timing.pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
 						|| (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
 
-				if (remaining_det_segs > MIN_RESERVED_DET_SEGS)
+				if (remaining_det_segs > MIN_RESERVED_DET_SEGS && crb_pipes != 0)
 					pipes[pipe_cnt].pipe.src.det_size_override += (remaining_det_segs - MIN_RESERVED_DET_SEGS) / crb_pipes +
 							(crb_idx < (remaining_det_segs - MIN_RESERVED_DET_SEGS) % crb_pipes ? 1 : 0);
 				if (pipes[pipe_cnt].pipe.src.det_size_override > 2 * DCN3_15_MAX_DET_SEGS) {
-- 
2.34.1

