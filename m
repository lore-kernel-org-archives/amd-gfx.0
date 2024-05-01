Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28F5C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DEC610E8A8;
	Wed,  1 May 2024 07:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1uVIXN4g";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0810C10E8A8
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ia+LwgWyGE5Yhma1S43yEz7eqeDf/0oYQXsRa2GDzGhBbMY1vo0IgDMDmQWb2z1xh3MFBdZ/GIg45M+6UI7UTySaIClYIFrzXAxJ4EbttSPgiWK5tjUfojoTuLJdNPzb+Rnpf0tURio4PpyHsc3I28tPEH79WUQSIuAfTGOhF1jsv+ZdYIWtICdePcGwXDFPUwLzaVgOm5FrJIeFsQfvgJILfRNGBaBKeRKMUURKcAu5RxuIt1hJDtHUSH0qTiXtEozFEp66SR/cbXFA8fx+Xow3T79W+UCxEGYr6ub+MKPvs4MWJdAWBYaJHRkIQQZEnZGR2N5oXW8lRDo4gguakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAe2QsVTzBe180jpDI1HiVJAHX6OukdBnJkuap00voc=;
 b=C46B6m43szDmgNOKkZgzILA+VTMpSeD+SFCP0Fy2AIc2nJGSIosSkJTDquIxXW442Aa2M4aRHq9IbGkgjQO3nvUdCdsAUVo/pR32t/ZhuLDEOSuQUyx1loxWGIBP1IIWHboL3cOLU3YAT8FJ8hnZEKSbmRpdU/DmwcZvhb5iJL4sIEZSnxqfjoXVXXlweic8qL+f3roZe4n8V2MeJT9tDQ8yu2hPgadpqSaBKPjDbP68eE2bPfBRQIBnDscCkKR4MMXNpF1Exg/r4irUFkYoudRQDHN+Pjed8uZAbVgI1urcOautZiHmyKceNqr9rrPPJ3ML8ASy3Hzb9RCseFD2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAe2QsVTzBe180jpDI1HiVJAHX6OukdBnJkuap00voc=;
 b=1uVIXN4goQrZfLSDXkqRQ+ZXgWaU6xmVygPkGLdqMfVAgOPpD9HGOfu7x8awefpO47Y1j4fMxQu/+Yptw34WElcPpM+5rX5VSmNrTKO7exUe7H3dOgWlVD8Xf+TJCR3Poa/gwQUgnaoiDO8xcDR4CVV43QlNqzdf7V7FvQ0rJn4=
Received: from PH7PR17CA0063.namprd17.prod.outlook.com (2603:10b6:510:325::27)
 by PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 07:17:45 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::ef) by PH7PR17CA0063.outlook.office365.com
 (2603:10b6:510:325::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Wed, 1 May 2024 07:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:17:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:17:42 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:17:34 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 09/45] drm/amd/display: Ensure array index tg_inst won't be -1
Date: Wed, 1 May 2024 15:16:15 +0800
Message-ID: <20240501071651.3541919-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|PH7PR12MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bfcf05e-a9e7-4d49-84ff-08dc69aecc5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rWOc8jmjxXEMcDQcZ4CPA14PlAT0zbp6Ly0KDVaHJTUzMFRkTcMRV4NscMcH?=
 =?us-ascii?Q?M1ebNTKJ9wX+nxbkO/xkwUd5R5a8wy9gZ4AEQn7wOjKH8Z5WAYMXHzuyU7iF?=
 =?us-ascii?Q?EiZ3FbqABIsUmJkuE2X1Ogvo/x7u5tcYcgdjRBc2oiFUm1V0kgkXEoWjDyAC?=
 =?us-ascii?Q?KRaLcUVra3FTID7Gws+JhNPPnS0sbKfKR40e0px6nlW80xGfyB2Vsqwx8JBo?=
 =?us-ascii?Q?p7IaR2VqH0mX9OQyILF0I8dTsDLlcJz6F9kYpCxH3/0F9dKzl0ZVDCPoHFhA?=
 =?us-ascii?Q?/gGssuuZKwJTssowkWg6EUYdiKJtPNxrinjhKW5brEIEvjRglMn4pGQCwFR3?=
 =?us-ascii?Q?OJV77hEr03heg27zAj/m2gbyly2C5x4jldjnZkiJNSjqpYEwlgqTN6XRxwrn?=
 =?us-ascii?Q?RgPHVaNZrk7+tCPfSTJKo0ouhCJ4VtE5u6zmL3ZyzuLUAm9l1hEda0mA30Yf?=
 =?us-ascii?Q?nkH+JGwaWkbqoEtgWwsgrrzVh4JhndsTQ9sUd4gBRtEHotl5/brN2nmeUlNh?=
 =?us-ascii?Q?uMkI9RZIi/vwclO0UcEzC0oXOVsjqKkvjZt7SY+YrPviQLbnxqGRNX8AKwqd?=
 =?us-ascii?Q?JVJoVtbI49St3FXmloUTZmA62RVlPoYmqGPZz+zXOIcQxSTpbdEOKv3GsE0r?=
 =?us-ascii?Q?i6rWi8WC6gYKfNnxZ5XJF9KujTKDOvONPvKNEnfUVsgEY330L/tk4qf6cqRC?=
 =?us-ascii?Q?VYxf5qbaNsPIX3Uigw8Glv3eaIgqdz7oFOEZbgx+XZ6Ll552UhOFN2gGfjjV?=
 =?us-ascii?Q?eKN7d1ptXiYHQsNsu/P1a6Vn8w3sEwVDySNLuBbijnP+LcHUcSuI3Jb+H1xH?=
 =?us-ascii?Q?AhK+fROjGrQIQKSwT+dIj4fR3cowTOKlVAh6kuDJ53dcT7Nkzvz70KNQ3163?=
 =?us-ascii?Q?F/vMRboqFr5OQb6R+5r61UInuhA2l/v/X12HvcG5z+L/nsaoHRjG37xO6wN9?=
 =?us-ascii?Q?Iyt5Ls10FqIi9sDyMJecS/ohVf0qF5h3OL4ByEM7MsUAminyHfsKnBeHE5as?=
 =?us-ascii?Q?WwKY8c/gePcy5vDZjQnsdbDQLws3UJ5tsE6mf3jAM6Z24WKBwJvtuZUV846j?=
 =?us-ascii?Q?vpR/nhAHeE21EFfpg4zPSDus6MWKhhh0ffuKI0YfVZjU6QlkmBcBNUQemabG?=
 =?us-ascii?Q?cZqvhwzFK5n1qqbBEpTkb2pg2TD0c7hkTOxHb3eKJrUeqEjBGRa0125LoMI9?=
 =?us-ascii?Q?+R/rzeE3dDrQR72vtwhZcKohjB/mDNBqWGMPuAsDDXcO6jv4Cmrce9esE9fg?=
 =?us-ascii?Q?0qkKVV09l8IOwUenu6oAO2gpZbeSW/tjDv0VrpLXvAZUcnJ2k+q/detkF14q?=
 =?us-ascii?Q?6JEbOe5H9i5UdrYYYR6GZ6xUEMJjH5+vojp4ivxmxhBPaE+D28cADd2S9AGg?=
 =?us-ascii?Q?q7r1Hcg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:17:45.2827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfcf05e-a9e7-4d49-84ff-08dc69aecc5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968
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

[WHY & HOW]
tg_inst will be a negative if timing_generator_count equals 0, which
should be checked before used.

This fixes 2 OVERRUN issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 8dcd7eac4b2b..dbcd34c6338b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3542,7 +3542,7 @@ static bool acquire_otg_master_pipe_for_stream(
 		if (pool->dpps[pipe_idx])
 			pipe_ctx->plane_res.mpcc_inst = pool->dpps[pipe_idx]->inst;
 
-		if (pipe_idx >= pool->timing_generator_count) {
+		if (pipe_idx >= pool->timing_generator_count && pool->timing_generator_count != 0) {
 			int tg_inst = pool->timing_generator_count - 1;
 
 			pipe_ctx->stream_res.tg = pool->timing_generators[tg_inst];
-- 
2.34.1

