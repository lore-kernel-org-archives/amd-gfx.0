Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721A6C44536
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 22:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0398F10E893;
	Wed, 21 Jan 2026 22:33:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yLBr7na9";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56E1A10E893
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 22:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGxV4KCu20HqNaoUQ58/gbNrhAV80KNrfmZkXcpvnLT6Bmg0tL7F53GBmlo99HoFoz2t6ZebI9tstrWUHNyBOehxzqv4dzYZVrRiMsPxQp+10WwufeV/epz4kujP7mTcFhvgGL35/RnFGGBtj6caQzGyQ4aSHyCLRX+0vcBysVVr56XS6wa9Lxwf1uqlH9Y/V9FgN5UcZndlb5ISLYs8rdqPnyULQKevFbkpO0T57AKPri+fcUohDDvUK8Zk5ju29L5LDuW7wAg7jqnX8OsS8cT11GO6+886CiGTN6MWzYcbrqcFJyP6LkYYUsN1T1Q9/jzF1+NIXMUv9MTxFEVN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N98xpKRyqKteQSFtanITzVlgfmnGccjSO8Dx06ibovo=;
 b=oh1HgPZhfPNWqUDyg6CwtTqikQ7c3o9cZ4iC/kTQiitC+3oveWuf9wcaPPyDqtwPSPEhWQw2njpFXYKOvdCgcgubQm/PUMWpC25Tv1GimcD8OHFzPWzz449BhwQFGuJ9tjsDhnPPP7CxlHA3mMgMClM4WPK3JEnLLMAEPCPH3C853f5utTp7/4dhKxG3U66nSjd6JFmHtzFLujAaML3dhAs1HkPXPDc+rQPOCBbPYDbhOGL4zj7XcPr6KSMb9m5BMM2pb3GMI39QHSc5KmFvVY78KcLfZyR/E6WVpiVIEqzaFCduVjbhnoZ3WWCzHQWF3kskgiJ4mN+1YgeTZ7CRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N98xpKRyqKteQSFtanITzVlgfmnGccjSO8Dx06ibovo=;
 b=yLBr7na97IjY7cp1YYMhW2sCVin0BWgh32hDtErG3bSjsUOQJL/8y0WQD2VRAtgEC4wwCIp+8iEdWElSOenzC54F4wrpuju0n3/odw1tPM6QrPhxlYF6BheCb5RPuBBSex/fO4hX9jDtAZEqzggOIjaX0Ve0YaF6okDP+HssEB4=
Received: from SN7PR04CA0083.namprd04.prod.outlook.com (2603:10b6:806:121::28)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:33:09 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::f4) by SN7PR04CA0083.outlook.office365.com
 (2603:10b6:806:121::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 22:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:33:08 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 16:33:01 -0600
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 21 Jan 2026 14:33:01 -0800
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 05/13] drm/amd/display: perform clear update flags for all DCN
 asics
Date: Wed, 21 Jan 2026 17:31:41 -0500
Message-ID: <20260121223247.186241-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121223247.186241-1-aurabindo.pillai@amd.com>
References: <20260121223247.186241-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a98ebd0-d2e4-4b48-f77d-08de593d0da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x/UnTMV+T1fRFOJ6MNiFVKyZ2gNnN37+Qctz1zSFEtYIr8AdVLvkz3UO3SNK?=
 =?us-ascii?Q?IynA/HeBaNQbkpd2ZzEYSjjVfMoy9frJlCJZIMZe+c51gazUntDHJVgP4tID?=
 =?us-ascii?Q?fExkY2GbvZUM4vEwuFLHrq2pYnwY9u4c/OBr+qaVL5AjBmAiNljgcpACiRUq?=
 =?us-ascii?Q?14fT+lm9BFrH89xlpAMnyjl8C4T/tqyJ8QOtVHuWKcPZx3B89ix1pSg1o58o?=
 =?us-ascii?Q?Su4TNMeJv5k+YUk0KgYM/5pglMVjim4T4DAE0pvjrHV249ubvgY7ay/BWeed?=
 =?us-ascii?Q?mAKUXgV+d718mmuGWhPVfCsQgU0JubTXqkOAgKJd4NI8S7QSJFX23lbAAVQy?=
 =?us-ascii?Q?ikTcIr+IifKngZGewQQTf2WG7T7cMx1EMmwcO5n+obxs7p3ZZ7T3/2nTJWpb?=
 =?us-ascii?Q?HQail0tICzQ4V3C+ENczFrfz3qpLZoSHlcJn0IJoZ4MKwTY80w7rclcp7XFh?=
 =?us-ascii?Q?57b019ht8yjJtMKVkCqC71pGkDfGbIdhH383K1NiHaCh4i7mE0tnvVz7z3wg?=
 =?us-ascii?Q?I+ltR/3SzGAEPSS0EOwFM9DZ9344GJE56tZ66CQu2gPT1xCMcq2hP3TN1a6A?=
 =?us-ascii?Q?CmCFe9m4okpjR9J9804qQFV2UwiZ5dC8cTwZbcFlDGKc4z/Kd6T2Ykf4bxY/?=
 =?us-ascii?Q?MkiFr9zzxXaKDb3ZoGGL6A5rdcIMH0fCC1lvCabK6pYN+iCARsB1n2RpbOCa?=
 =?us-ascii?Q?2u/LIdFB/MPs0fMcUpUTbegS6X5rcZwhA/6WWAzMAgzYB5jP/eaecZFLGDee?=
 =?us-ascii?Q?AWbiXr/inHRuv1kzMG6MmPvJ0rcYqjgGIxVbUHJLcZWtakbZBb98Gpk8hDwE?=
 =?us-ascii?Q?0B5+SoaYhunYsUAiVRMgaSbTbHug24SX5qSd01E8MJ/Y3/BW8Gw3l0tpemWX?=
 =?us-ascii?Q?FlpUVEy1AHqnDv2SzmhRGo4jriEnL/vfGs22Tk69E3jHesy+t5zz16vacQ/q?=
 =?us-ascii?Q?03C+26UFRyJr+wRApwcj/YfCWDmS/epCV3H5tpZNh5YO/SOFsQwxLCvX+rE5?=
 =?us-ascii?Q?mZMJ3nOtuzATfNdJZA2DVMetDSkLrm+xnvyLup7AxBlnFpzb9+KQNgDBFgqL?=
 =?us-ascii?Q?vin4NQOHQh2O5s7uhOajYCCw0uddmJ0421VjjvfGNUJa1R+0fu1Du2f8Cxro?=
 =?us-ascii?Q?ozA54lG/IZlidnZu2qSKNEZNpZg0z18/v7v7gBeBulAkNnPDkxEw0v4bpPKg?=
 =?us-ascii?Q?ONrxaRKUOq7uOZ++o7VnwqMfVEbLg7PRfYULFfJNTPhvryEY1zUUsXZcWAlW?=
 =?us-ascii?Q?S5FeN3/qjK1GkQayF7w72zH5CaQJG8NE74kZFQwgC9Xp61+GTbe3Kku7DLni?=
 =?us-ascii?Q?cSlm3xhdxKl0563tALTg4VJD1iCGaTvtrZQkSRmq8LMRWIkGr7zg2uMmc683?=
 =?us-ascii?Q?fDSYpgyxAs3P5Y8rGw9nbai8GJO/FwUknIEYdxJlHqCaVY3rl+KzH4ZgGIBs?=
 =?us-ascii?Q?xK1+1LQwpBiVL0Jm6hJlaVCj7DFf3+KpYslCCCaSqekfyMUBUDKUBM1Pq9Ja?=
 =?us-ascii?Q?oLCUveG5Z1ZiFazwLIBGYsfMzCNK44vWBPjRJqQJgdNUWLcs969kXFvXH/5B?=
 =?us-ascii?Q?mw8f5VZCvmcUhAk4as6mp5yxMaX8tAtAo0cO0LTPfbpViG++m6Et3UB9wBug?=
 =?us-ascii?Q?9D0XJ3eKlQuPuJkXGaa/YJ1xRUW7MPPbXE3jcFEqWEyTABM1m5pvbP205w5Y?=
 =?us-ascii?Q?U3HClQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:33:08.9494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a98ebd0-d2e4-4b48-f77d-08de593d0da6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443
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

Existing version check that limits the sequence to clear update flags
should be performed for all asics. Exclude DCE asics for now.

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ad8ce46ce310..cb85b7ac2697 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -7506,7 +7506,7 @@ struct dc_update_scratch_space *dc_update_planes_and_stream_init(
 		.stream = stream,
 		.stream_update = stream_update,
 		.update_v3 = version >= DCN_VERSION_4_01 || version == DCN_VERSION_3_2 || version == DCN_VERSION_3_21,
-		.do_clear_update_flags = version >= DCN_VERSION_3_2 || version == DCN_VERSION_3_01,
+		.do_clear_update_flags = version >= DCN_VERSION_1_0,
 	};
 
 	return scratch;
-- 
2.52.0

