Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C900DCD37AC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 21:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C4E10E13D;
	Wed, 13 May 2026 21:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FKcChGfE";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A9010E13D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 21:58:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJeuuDQnZbXYiH9ldbxgKgW87RsVcpFBEGxfTxOPT4UuCIR1EQ/kqzIh4gaW6emujugn/sYyC4ahwG7J430ahGH07xYW1gTOIr0osrzuIkOU2J1ksEo0XQ+/FdkHyGS6+CBYy7Rdqm4aUsJ4pwI/rHTxpwOceozOk8UC0hPjJrVMJUzZXCZ0qlbTLVJmU6LxtGbTzmHJfjRGTPHL7sb7vw8ebmv26xJt7TLeAZWn0BvuUlas3SEcL2LS2KQp2jTILlD+TZz0vgkHd6Tn5QzhPXwXm+MJlNyAEz553GdhPlDBG+/+Yq/KfarH+xkctYh2vlHDYI5LpmOykc+bBCmKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eOK56oVnzCVDOURinSzQIeu0PBH+RHIjLCOzuPqQeA=;
 b=k6vYehFGAzSWYi14L93kS3v0uQq/m+MOZLBaXzw+urM/I+tny2u5XGzN44RNXWRFFwlGsv/X1toWy4U4/G0o5jDLJur9UG4ttQxMt0QeeK9n7sj7fgALTWomJ9E+0MIAdewo2UZb0LFWjc2WP0oatPUdIgTl+L+M1AW7nEannuzITnwV3T6/6O6Q5X1Ni0rGFc9RR1kaL+Qv7uMJ5B7x6UsQJ0wK6KvFr6SWIQ98fAW3YtLvyKov9nG5yNmMl642CyQpc6kArykLmJaAfRQZXLoeJfUGCgrOvU7g6XhMEurgPo1oa144LyPmibAakry+qb+GJtHaN8Diu6vWmL+2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eOK56oVnzCVDOURinSzQIeu0PBH+RHIjLCOzuPqQeA=;
 b=FKcChGfEhXaz/0siVF+sK3JjdPF/JDBsCrB0weYHPi4A+9csAa86GpiF4xEx507dMxxOn7VC9dP8Vd+gJLytQ82ZVn8coTYWD/KvvTSBLjyVKtAlXWP7yYN3PNwy9NDvdjdjEsPKj6nI11XrG2IrmeSZMC++kxBmgeMC+i6bIxI=
Received: from DS7PR05CA0065.namprd05.prod.outlook.com (2603:10b6:8:57::10) by
 DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Wed, 13 May 2026 21:58:44 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::32) by DS7PR05CA0065.outlook.office365.com
 (2603:10b6:8:57::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 21:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 21:58:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 13 May
 2026 16:58:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 May
 2026 16:58:43 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 16:58:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: check if dml21_add_phantom_plane() is
 successful
Date: Wed, 13 May 2026 17:58:36 -0400
Message-ID: <20260513215836.40154-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DS0PR12MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 36cd51ab-75f2-4247-12bc-08deb13acd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|13003099007|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: OmqY1g7Lv8xpRXXqUIhJClwnzptuEA7lr6ks8wmf96HDN1jvM56/mI6qYf7THkA7UQ+EpAGrYL3yjUE5bq/5SlVF9rRHsLBR9svzlk3Uu2d0ZkfYwn4AZfHp1lsOno7vfQiqxbXP1DDzJs39D65JjFFglN+3E5U3K5L2csTxb4qrRfcLkzf+V2IDnA4NZVi3MUJwa+y1M247iORGRgwepyvVV7jlGBjN0WDSPrhWlPasc7CrMVxcAuGluDxHoke2bvQrDsfn0mVbSC8AmcGK1fCfHuT+FUfpUMXEXABmZl168TH/dLVeQoZ2pviE3b4M88d1tRSzYjWeB0iHyvES409YVAZAHEbNePGulIikhwFAYnVsJjDuOwHYIiwBmIAUD0uGuhFvPBMpB0TCmXdGh9dF6Qk3I7nLm7TbhcqK0bODfY5/84ozudzWy2RTQxTezi4ndb58zve3nqPoIg+spOBl38w7p77a+rUIAR0NVgsdCQU3MEO8YXHTQwW1/weQQkOKcAx2mn6lyT0rQk7qtwJnwaEPdlPATU71Y2ISRXP9vKSyDzOpWY5IXj7IdjbnM2ViFvR6M6870+hI7Rzf4/tGMF9bixellcg4nFFx52CwOEqFoj4jMFzShNmMYJV5eTZRZw9TrPZ96HfL41jcIhcX8TfVRgX+xq1nW7iFR6CvaezZMw7sjw4VaoMEK2X1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(13003099007)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y4XJdfX26+GcXR8tHAHLaPyqx59R2p+vs5VzDvtQGgpfdgxl0MS7JjjHP8yQ0dt6+J5RitoRChCzmr6hIXOiyVOEB78YsaiRQ9xv2ebU1k/Trf/RG4YmuNmpBFDZn9HeA+z00wFqCwzrHYnHktLigk/t+RXKHvYcwh3YrYjwZvN1COXyzwsHDYYGqbhADDFPyIo8xBu60qs0gliQEJ6gIe8ocrxbD0Ukok2AyV3BakMpfd9p9zreccSzYGhXikUtmker75Mp11bm6rT1sx0OjKz9ORvYXfHBRtNhkbVfVUwVURuJ6NPB5Mp6s9R/znrZ1nso7J00eW+evgb0T1E9obqay3Tq491JJ+ZwsAP3Cs15JEgdbY2XkzNk09XMMBsQTatu0TaADpQnWoY/4IuA/BCteGJwWv6n/usRzrp5bgK+pzx+BzckZemu3w99ca4N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 21:58:43.8764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cd51ab-75f2-4247-12bc-08deb13acd0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276
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

Verify that the phantom plane was allocated to avoid a later
segfault.

Fixes: 70839da63605 ("drm/amd/display: Add new DCN401 sources")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4970
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
index 835fece1d46a6..50e445275b14c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
@@ -359,14 +359,13 @@ void dml21_handle_phantom_streams_planes(const struct dc *dc, struct dc_state *c
 					main_plane = main_stream_status->plane_states[dc_plane_index];
 
 					/* create phantom planes for subvp enabled plane */
-					dml21_add_phantom_plane(dml_ctx,
-							dc,
-							context,
-							phantom_stream,
-							main_plane,
-							&dml_ctx->v21.mode_programming.programming->plane_programming[dml_plane_index]);
-
-					phantoms_added = true;
+					if (dml21_add_phantom_plane(dml_ctx,
+								    dc,
+								    context,
+								    phantom_stream,
+								    main_plane,
+								    &dml_ctx->v21.mode_programming.programming->plane_programming[dml_plane_index]))
+						phantoms_added = true;
 				}
 			}
 		}
-- 
2.54.0

