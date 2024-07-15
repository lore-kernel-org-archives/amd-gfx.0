Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C1BC3DA59
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 19:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB42B10E4E8;
	Mon, 15 Jul 2024 19:12:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="geIaixEl";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 699FB10E4E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 19:12:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMXVfkLKVwpE2K24blEmWLao/pqSfXM3V1Jv0+0asR9YlSWPL5CX+EC/ZKvxAiofLwcSLC76NsjwscPx+XCHTRHRpaCm/yWx5XVIG28vLOq14TIjBc1bWWdvp5sOLpPo0w7RYTWFppYv/0hZtw7FFLDTaR004zYo5Z6RVSGK0rgje3EBIlpeDoIUvqsfF0VfZ5XnwOSEnYYl3R5fTDBYbbDCjSp//DQbkZ8ls/kheTpbO24uNdj43OLCeMwKAd0Q+3u9l2LS6K07+oiZ2dHE6APvqgd1T74Zgvooh58We3oDSZO3Z9M8EnhzHNmz3vl/cF0+TiDzBRSKuT9CsljCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcBbBte1tsJ2STyfmuK80cKqOUiqFTWYeWCB8qG7iZE=;
 b=gFhcgpGzlqNmwyZV9QrEuNUyFj+lbcsa2lEs7xjMFoTiI7aKXEkgSGIZqMl3HawdI5v69zaocS+pb1rO4q3mlQReo3/Ien5B84ZMSTBEA/9RigMcOjKqa3JGjyGp2+6Qw/5d17lFrG74nGNCHQhvYqX8QjpgshJSpzOQgAEEzCxPjym5ADT1yD2lojZULWixcn/+ZYm9o3ZB4Dlx2XERyZp2thIVpxJXur+0tPT4GLTtQhGq58abD4plEXKegz+AhU3q4vzyLVXb3Ekt7IBOc7ZOq/RA40oLqQ9ErFs3x866kkTqWtNd5h0Huntb/F3zrVWVhHNk8DItnHlsNjZ7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcBbBte1tsJ2STyfmuK80cKqOUiqFTWYeWCB8qG7iZE=;
 b=geIaixElpwIMcWrN1twHrViYU7dHrjJ0zwmATm0FO8eGs/7glO3D4ekEw5K3lzJ7O7c7OmeZiR5X93j3QPXJVblHuiPyf2GNGgZbSLDcxgLk5K4kkfWO4/56QYO0uWQtqRZxRrky+NbZRLBAnymzU3C+nB4ATsIIHAxoxnql7U4=
Received: from SA0PR11CA0032.namprd11.prod.outlook.com (2603:10b6:806:d0::7)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Mon, 15 Jul
 2024 19:12:28 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::b9) by SA0PR11CA0032.outlook.office365.com
 (2603:10b6:806:d0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27 via Frontend
 Transport; Mon, 15 Jul 2024 19:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 19:12:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 14:12:27 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 15 Jul 2024 14:12:26 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexdeucher@gmail.com>, <rodrigo.siqueira@amd.com>, <alex.hung@amd.com>, 
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: fix doc entry for bb_from_dmub
Date: Mon, 15 Jul 2024 15:12:21 -0400
Message-ID: <20240715191221.3463907-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0c7b4d-3d05-48b1-7b97-08dca5021168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JRh1Rp1SdQ/0nxmsxHKJJAqgwkxiRKKHFykQGjCufAYO5fUgqGoUjpDwy6QP?=
 =?us-ascii?Q?JBUXuHWhHTNrlcewstXc6gnm05xTew1q0CH/ofWZltVzM8vrwWEOOYEE5u0k?=
 =?us-ascii?Q?4HSAWmUv76l+4ZR1F8HiwTxHuFbW1DmB2+HFda5F8rrHkl0WdccQK6zy1+/Z?=
 =?us-ascii?Q?hZILrZQODAgyy6JGZzbbIDUaKjODSU8Ipdyu/DRhTVrrUI/hho6m7mLTOTD6?=
 =?us-ascii?Q?Agt7kqWX9gq7FQiZWvSYf7MhTZS13/T8gv3eZR9LOqa53jpTw+6HHAmm5D2A?=
 =?us-ascii?Q?cJTBpDoTN1k5h5fpoptMia8tIdNUeLaQkuydIhEPHhmEUzFmYZWebioliGhQ?=
 =?us-ascii?Q?SnSXLImcN57TrsD/BCqgm6qC8zlyyoCodaR6/XYsRtsfhBDosW5Sx8KOKV57?=
 =?us-ascii?Q?2RNtN3fPeZssxlkbWVMB234s6dVTuLW6IEd/K20TpiD1MrUzzjavDKfARUcS?=
 =?us-ascii?Q?Q5hmyCzHuz5RBdRKiV3CIItsgAAOWS/bMHuMRebzT4gG//F5MkErCVWjX5Tw?=
 =?us-ascii?Q?cDvZPT/sT20ZwPor8JspYT492TioqAUBsB6YLyxFrkjJymbGwXJ/JXaZ0L44?=
 =?us-ascii?Q?QcA6/uapHF9efDLIiOvASGlW1bhL7OgdbjDSLJeQQB+nb9CErfmh6n++NjQ3?=
 =?us-ascii?Q?FelYVYUzd6GGifjTrhm42RJWD63H5Ss2WAJlMvuCyOWJfn8RKh1PflJX53nh?=
 =?us-ascii?Q?HwSwgutf2P4umNY5hj4J0hC8EbiOUJws2/kyd6NozvLj4cZeSNJJ333MMQNs?=
 =?us-ascii?Q?5R4jMUFnvIdHeiYe89Od8eDnsUmbluEtkXswIdo1dhK223qjmCJgpMmCTkKh?=
 =?us-ascii?Q?LcwY2Xp7Qfj769kRFhGAF5cJvO21qHt9I7DJ7Ob2e7yxyOA5jbwKa1KT2Zal?=
 =?us-ascii?Q?WitKistrDnbahQ6aH0m3MdXXcChRkpAfpgR6f4GhCDCh3e7Cnm/6xoeTuFus?=
 =?us-ascii?Q?/5xWnKyT6kujEDdAtjvWxVUeR+i00KRWM2zWSUu4Ktevn+3RWuAzmSUWnEVw?=
 =?us-ascii?Q?nroKf52q6JJIjTVRHnTrWPj+C9syuYwB/RowUcFDZZrLR4v/gFK0uKtACPlT?=
 =?us-ascii?Q?INJ4v8vWaPCFKdxjuTeYF6u0apRmbWPylN7HQx0hyDUvLCaQDbxj5dsXP4hZ?=
 =?us-ascii?Q?KzaoxkaH2N6hOGhIeNAAn97RQOkSkHC4RW+GC+FQDOrWmYq7uvx/xswaolp9?=
 =?us-ascii?Q?2NFozixUnvsb/aVG5Rsm1VtqrvwHHJeQObeyY9XzNp5JToIFRpbfCFBdgi1u?=
 =?us-ascii?Q?ycr9owPCu9kXGomqpOAajgsAUSV1x1W/YiVd7aeaHUs53SwwmDKcrUx1jT4u?=
 =?us-ascii?Q?Ne1gxKwkt4J99zpPfw2FJ3KZHJpEzdGHSbjKwoELgXYUJbcsXxbt2vcUDAVM?=
 =?us-ascii?Q?die67sUcAc+cpvqDlzI+4gotH4/uNy7NDuWp6uNEaCWmMdNP2Wz8e/CMysgr?=
 =?us-ascii?Q?FUAJpAkxWkQcrjgFuQ0gkjVRHscTuSds?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 19:12:27.9095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0c7b4d-3d05-48b1-7b97-08dca5021168
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315
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

Fixes the warning:

Function parameter or struct member 'bb_from_dmub' not described in 'amdgpu_display_manager'

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 5fd1b6b44577..369159c29bbe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -587,7 +587,9 @@ struct amdgpu_display_manager {
 	 */
 	struct mutex dpia_aux_lock;
 
-	/*
+	/**
+	 * @bb_from_dmub:
+	 *
 	 * Bounding box data read from dmub during early initialization for DCN4+
 	 */
 	struct dml2_soc_bb *bb_from_dmub;
-- 
2.45.2

