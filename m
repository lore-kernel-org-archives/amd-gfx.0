Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256D9C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7FBB10EAEE;
	Fri, 21 Feb 2025 16:02:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Iof8RI2M";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0433B10EAEE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQIMYED6i1q38ZB+LqvIvl9nstNetGdKu7a1DBSZfO2Ad8D3cUXF4trXQn06UxZBwAU+Zh3rl61+xYJNk1e1ye1vV75Jigpq6wVR4ZaJD+Qgeg2tEc5KDvsjSIpDWqBepJav7HNHkmHZH/d8IcHDcAy6YUwXSt4Ih4w/EDB7aJfvFszwthDD6Lb1uSxNynHfhiZV4up6yzjqS3vxCqjuwgOmrC/WbvVpUQ/pA2D5k7FQlIH2pdjCvxv1DgUBb8O8NGCLCDjCzjDgZSVyAUKQZYEz33EaLG7RmQeqC7fWyp6RlOQTw7L+MR2A0FHdMizWuO1fsPSK0i9osTU97vBeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kU+17LMwKGsAwaG6z+C14sBCnRNmeUaxTrl2Be0c7I=;
 b=BWYDW2SLmDa9LJqKz8LTn9KBNuL8F6dquIu05LJgE3v6QEEf4B06i4tSaq0/gvcWequx6p5q7H4wUw7hWPFwI8c1FIi6//a+uXVz2zgbMAGZyKh4yIvkzCHt8VCbxD1n/KlZ7EpYBIHlCkE3hPzXRH5HwZY1CgFqFNfsM64hZw2nUXirpnF8IMeM+d9Rv+i/qkVnUv/SjcKb+Agf2xoulKWFlfKwCT3hKiJjNj/IqCMMxa3+CCmSH2++pccV6jYfnsQByJ/9k7r4jk+3LIY11MhXcEY+cjyX+pqJuwDpF1uOX6h5B/zKSsHAvWxyIbGadT8I19hgrFO3XuoOIKf/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kU+17LMwKGsAwaG6z+C14sBCnRNmeUaxTrl2Be0c7I=;
 b=Iof8RI2MoPT9J0CjMsTsYUEXcu+FsD8eZhLKr1//Cg3o3gQuA430fkt20a0fG/WKECplJb7Q7i5Hz1/s0HJt9frWNbtK6zhEc49JH1iJWkG7c9C5qteOJ+Wpysav4fCnUdyJbfYeTTxs8ZgWDgucY5h4LmsP1ijs9JUV7hY2vA4=
Received: from PH7PR17CA0071.namprd17.prod.outlook.com (2603:10b6:510:325::28)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 16:02:39 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::72) by PH7PR17CA0071.outlook.office365.com
 (2603:10b6:510:325::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 16:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:38 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:28 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mike Katsnelson <mike.katsnelson@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>
Subject: [PATCH 21/24] drm/amd/display: stop DML2 from removing pipes based on
 planes
Date: Fri, 21 Feb 2025 11:01:42 -0500
Message-ID: <20250221160145.1730752-22-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: d4fa4832-efbe-4d13-ce94-08dd52912a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TKoJM8O95nEY3A8vMQteJjCzfN+G1tW5bpjh07/2p0icXCvdF+vn6zV/5xnR?=
 =?us-ascii?Q?bVOpyTcOG9GBIJIhtbmUIRccjY+ejKa4gvL1Yrz06NQp3TpX1o9bfNXVXuIB?=
 =?us-ascii?Q?AGtz4VbQ5fUNLIPx8F7IAVmDw7KezPbfzUood2zO2N7nl9xMBCB64UgqFUn7?=
 =?us-ascii?Q?myKLyHDmfQJtu3K/BjWdTdsJWi+kThZ+CFGj3QKMZdHwvkshSkh+airdXy7T?=
 =?us-ascii?Q?1+KMUByqXZihLvEYqsMEj705x+Wq4YfkoiN+XbDFtbVEGIPCnkz88MO29acZ?=
 =?us-ascii?Q?1uqVFRGPrBQ6Cg2p4xrBDb7EDdrGP9+rJEAPhqrWBFNypUayObWBa2K224P7?=
 =?us-ascii?Q?BElcB/ELkthmYEZCsZIKKuIOyKDAFSr6hBbv+7KjOYxO+ZwYIxirUJdFU4FL?=
 =?us-ascii?Q?1SrFhrm2jvSxRYE6PFuS8+xTgEOkpROOhuAHViNRdP99b8v2bgvTy4FB6SwC?=
 =?us-ascii?Q?KPXp8XpajBPERu1gSSVY/h8nl2omwv8L6PWX7ZJmJOxxK1AugdPcexWyO8Nz?=
 =?us-ascii?Q?gdZyZDjQMUY5hua+2zuK48VxEQzQAGa2O1IlNRmOTyoWOfrA8AhoEWqOU9an?=
 =?us-ascii?Q?FHPRcE4Xrmpbz7jZIXCL2OrdZdxFBcF4Dm2QkuG8MwT0Wf7ZVnOVyXuprQEF?=
 =?us-ascii?Q?IDftzqf3q0DjZPhlCkDybuTQj7TVuP/XNvh+EnEhKIKAZRMvE6rwk0f9/yV0?=
 =?us-ascii?Q?OcSAT9lueb+L0//Bc1QufLZfdMlIBaJK6TBbq6y7Ev5vQd+ceT0cSE0LSnJa?=
 =?us-ascii?Q?ed4rGs88sfLMu1/xv7wRdD/5gnarQJFDrz5IvFTq3xN6cKbgc6+FJqOnaU+L?=
 =?us-ascii?Q?J8sbZdknL8X1HdIGylF7RphKAc2mWQW5rnjXvI9qu/h9d82F2DjV5mFAvT2P?=
 =?us-ascii?Q?9j5XlZ3QkZ02vl8stGyqtSSQ8Ox+QGWz/DNGBwTp0HSHOeAWUMjg44N41kst?=
 =?us-ascii?Q?bz2lPiLYx2IfXmyjnZKGACL/QjPbZpgFtJBYZRtKb1UCp1E/ON/plhmnL/BL?=
 =?us-ascii?Q?QnT1kdWG9KM2D+dqMFBsnFqKqNz5RJFxlAkz4Yrtfi5qtpUL/yn/UYf5HI5M?=
 =?us-ascii?Q?8vOSwjGQZQt8TE9gJpwSHP0mKyIj0aFJnltcDkT0f8p3e1ipfKo3D+8Clzmy?=
 =?us-ascii?Q?vbtxzTbB0+Iz2Tw6cLs2gKLmZrDufZC9NoWqTrG3b1arvHioiQ5cwfUCN+He?=
 =?us-ascii?Q?lVxIonmTHsF/DRltB6K0RFgjaoLcHD2e40yhdLDApZRyYct+3h+x5q8l0RFM?=
 =?us-ascii?Q?WwhQDG+USDfuw++5JM848tt2SrYy4+RdRUO37b5SnN5iEdoDHw0b8QMyJZfZ?=
 =?us-ascii?Q?0iUFsWuWAGoIgHp6PTKJzTh+kjmePvY3140cd2rl+kFOrZrlTVb0iaV3BM8I?=
 =?us-ascii?Q?XO23MLFUDlBZovpU9FdeYCSc5fm0LowXxBZfi8uvB2WF5NTDqcBCnXyvgh0f?=
 =?us-ascii?Q?QAkcsm+W9/vLEvPAEmnqw5COfTBIVB+qrnQVadSpU0isSsSUz5oq/kKLAdXX?=
 =?us-ascii?Q?kIr7keG/jKhLWLg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:38.7410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fa4832-efbe-4d13-ce94-08dd52912a3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351
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

From: Mike Katsnelson <mike.katsnelson@amd.com>

[Why]
Transitioning from low to high resolutions at high refresh rates caused grey corruption.
During the transition state, there is a period where plane size is based on low resultion
state and ODM slices are based on high resoultion state, causing the entire plane to be
contained in one ODM slice. DML2 would turn off the pipe for the ODM slice with no plane,
causing an underflow since the pixel rate for the higher resolution cannot be supported on
one pipe. This change stops DML2 from turning off pipes that are mapped to an ODM slice
with no plane. This is possible to do without negative consequences because pipes can now
take the minimum viewport and draw with zero recout size, removing the need to have the
pipe turned off.

[How]
In map_pipes_from_plane(), remove "check" that skips ODM slices that are not covered by
the plane. This prevents the pipes for those ODM slices from being freed.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Mike Katsnelson <mike.katsnelson@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 26 -------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 1ed21c1b86a5..a966abd40788 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -532,26 +532,6 @@ static void calculate_odm_slices(const struct dc_stream_state *stream, unsigned
 	odm_slice_end_x[odm_factor - 1] = stream->src.width - 1;
 }
 
-static bool is_plane_in_odm_slice(const struct dc_plane_state *plane, unsigned int slice_index, unsigned int *odm_slice_end_x, unsigned int num_slices)
-{
-	unsigned int slice_start_x, slice_end_x;
-
-	if (slice_index == 0)
-		slice_start_x = 0;
-	else
-		slice_start_x = odm_slice_end_x[slice_index - 1] + 1;
-
-	slice_end_x = odm_slice_end_x[slice_index];
-
-	if (plane->clip_rect.x + plane->clip_rect.width < slice_start_x)
-		return false;
-
-	if (plane->clip_rect.x > slice_end_x)
-		return false;
-
-	return true;
-}
-
 static void add_odm_slice_to_odm_tree(struct dml2_context *ctx,
 		struct dc_state *state,
 		struct dc_pipe_mapping_scratch *scratch,
@@ -791,12 +771,6 @@ static void map_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state
 	sort_pipes_for_splitting(&scratch->pipe_pool);
 
 	for (odm_slice_index = 0; odm_slice_index < scratch->odm_info.odm_factor; odm_slice_index++) {
-		// We build the tree for one ODM slice at a time.
-		// Each ODM slice shares a common OPP
-		if (!is_plane_in_odm_slice(plane, odm_slice_index, scratch->odm_info.odm_slice_end_x, scratch->odm_info.odm_factor)) {
-			continue;
-		}
-
 		// Now we have a list of all pipes to be used for this plane/stream, now setup the tree.
 		scratch->odm_info.next_higher_pipe_for_odm_slice[odm_slice_index] = add_plane_to_blend_tree(ctx, state,
 				plane,
-- 
2.34.1

