Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ACFEE57C0
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 16:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F2110EA5B;
	Wed, 11 Sep 2024 16:25:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VLKONYcx";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B73D10EA5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 16:25:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0OGekstUFO0741Nz8o9PLhzcOGLMDEyF0etOEPd26PFOuyv2QmPJl7XRmDru/KiLMUGqQsSfdpB5Ryl1xDXiOtuKBq41qvdnfDBbwHKEHWcMphwl1nQGe/JbZtFFV4YjO8nFyzV0uchKB1EQJhMFeMcV4RyU8Z0MYdRMbs/Z2pgy0qwQnkM+3yRUY1JZWJEBeL+FWi63s2Fir06egDZjrSMDHl/6b3slme5kKNERAz5vma3KyKmIPZ6+QCYqpd7C36iFiZUO9PCnc/72d/DGT63sa/Rk+wzMkQB8Zjxyx5NXPqtapMwbUboU1t3ofg+MtomZ3ETW2ee+03bAac2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KU0+fNKVjdKvjw2S2kUpgInU9Xqee+df0/RnvD8prw=;
 b=I8ORytq1Fv6SzlvRgSBVyRPkGEHOD3q6FppsX4uY7KUwbB/JfXrSkSV0otSJmv5XY5ORDY8bs5euVwRsf89rH96qbYR9rExkWqEQ3GXSkw9ogFoJk1PPyr5BwtYZuZmZ4Ki7/8iPhRGe+QCTGyEiWhiRAuD+B5fwwYNjXTxc8/nskNjWiSBf59hPuZDjoOsOBEWdSE1N+ZEbYP5rBvQ46B7OX0T2l3JZBxHkInxnf6DjO9MN2jXEJmfIOUKJb+KhQ/TrGHSKhuRKxzLP24UVIBrDSsSpEHtU2bePRSvPGAvsHseEoSm0V9dsbEr85vwU5celt2YehSYU4/ji+34HmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KU0+fNKVjdKvjw2S2kUpgInU9Xqee+df0/RnvD8prw=;
 b=VLKONYcxiQL0Y6XoeT9aYrzRVOYhBAS7gUwRDc5ZLLx45YZ4LXjPmOuuTTnVVPSLlwcjr/YSG/IFpLsOzJwjXVLfNOrVjzwBecQ274fCaMIJyNztnFJubsDs5mdSjWgOrMfzE1b2482h5yqDEbmFdY8gw6KmCR618IQeD0F+gBI=
Received: from CH2PR11CA0027.namprd11.prod.outlook.com (2603:10b6:610:54::37)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 16:25:33 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::a8) by CH2PR11CA0027.outlook.office365.com
 (2603:10b6:610:54::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 16:25:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:25:33 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:25:31 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 17/23] drm/amd/display: Remove always-false branches
Date: Wed, 11 Sep 2024 10:20:59 -0600
Message-ID: <20240911162105.3567133-18-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1f1faf-d2e1-4b7a-ee56-08dcd27e5c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UbmLoWIAH62WPoKM9GNjyw/Y/VdH/NkjCyu2g2u+kencX1pswh6Cszd9wrgM?=
 =?us-ascii?Q?ymg4WLCPaz3PWVeE4VJlvTB9Bzz2NTZ7LNdQxb70STpcZv3UO4cqVZkO+w03?=
 =?us-ascii?Q?r1Dfq5d4iFonPWPV/MxKHiBDVDMfJVPt4n3WbH/7bMGeMptGRkg1Mky0P9X5?=
 =?us-ascii?Q?V86p0WfC5Qry/kKI48TqVAPRwrG2d1QLWVE9HtWGQYfKfJ+wlDfR1vRUuAG2?=
 =?us-ascii?Q?Ccdqpt6dKFNcR/rLTSoqJXG/BAPHKo+4xsMTcHB8iD4KLPmYI+/ubGDjQIkA?=
 =?us-ascii?Q?0tQzWH6Trp4DE1GFGwOTBOR7tJZXQrQeoI9WgWBrnvlJJTYeWur0Z3x5Bvl3?=
 =?us-ascii?Q?NEGS7Kl2IVF3WYLRtL5g4xmpvSOdJHWEJ/ofjglbCbauFmcCIp1JU0bqVtcl?=
 =?us-ascii?Q?sPR0cZ3KoZW7xcA8A0wbkgm18AWrjHfFEJAl/mYGrmSgAXD0jUueJfPkl8QF?=
 =?us-ascii?Q?U7HG2byET2mPHGkVAXvnQDE+zx1MNbus8RDZf6e9wdsM9dqhjLpdD951HSai?=
 =?us-ascii?Q?xZmA6Mwp5C4TGWbutsSeYSTGccdVHZPkRy3O5X1SUcZDfOop+dvjkDM7WCeM?=
 =?us-ascii?Q?Bo2ofnZZEz1uXXdgx/4yBdvDDLg7+p/dkgJuX9V4rJ54AKmsGKwFl8p+Ga8j?=
 =?us-ascii?Q?NpM/FgdklR0lZwS7j6HQO5tDPBZKcMpSQ+eDBCrOfpseHEBdVrXdzQDzgsRE?=
 =?us-ascii?Q?qKGzgcZ3aqy2p9lWHAv/XYRc0WFbBChPzcu5ID79aMMbvEpUp8za/zGs1XxR?=
 =?us-ascii?Q?aYHrKm+RyF8pfw9n9RcCUsi2dezV2IXCuKxx07xlksujJVai4O7daoMDk4xI?=
 =?us-ascii?Q?q5gvjFUB+07R44MJrTVFrNDlDIEcCdVzaslpFIOhZ5iWgQR209fEL//k9aDW?=
 =?us-ascii?Q?2639fxROjIvxhMSxW34ZPKS+/HkSEn3ClKfQOIlNOA/Tr0koVvQzxPxJzNFu?=
 =?us-ascii?Q?nVJd6OPK52mye0adVgw/okiN7mwqP40FLpxuzZlhlDR/34guo1fFWuuYAP6w?=
 =?us-ascii?Q?/jgXhombTTT6RJ+CwUXOUwakL0ZsXAXlRYgxPZam1IBdiGNGnu8b1jgANdDa?=
 =?us-ascii?Q?ExVpeXrjOOyquRp8r/lF24BVmUZh4AknRNOnTC5yJ0EPfSJCnZdyzA0SAyEY?=
 =?us-ascii?Q?4aL46rjPHYPU8ndZLyvI/luXrj3vfHkgkaZPI3Cmi/blxOivk7H8pZf//cfY?=
 =?us-ascii?Q?DJiTv55o4gBQTvzykuVhLzsSSbOtbole8a54xdBdidvAn7RZe+OeHu2Okoa0?=
 =?us-ascii?Q?uW+UUu7vQdqhTCbmcHHar0pfjKRa1rY91QHyGXquaHET+IGH0++nTmrL3a0d?=
 =?us-ascii?Q?Ip9wHuCoVoBLW5sv+42m50RpxjIWqoRVdPDqlrylLMHH0W26RUuv5NhT7Drz?=
 =?us-ascii?Q?DV8tfHKC5jc+XVa4LrBwRhdUU+sEcKNkrhhFc7MycoIbGv35rOemVgGV1Rzw?=
 =?us-ascii?Q?KqKjZqz0zgpCCm2UrlpCtH53CkKTCfRT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:25:33.7407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1f1faf-d2e1-4b7a-ee56-08dcd27e5c6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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

[WHAT & HOW]
req128_c is always set to false and its branch is never taken.
Similarly, MacroTileSizeBytes is set to either 256 or 65535 and it is
never 4096 and it's branch is not taken.

Therefore, their branches are removed.

This fixes 3 DEADCODE issues reported by Coverity.

Acked-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c    | 3 ---
 .../amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c  | 3 ---
 .../drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c   | 9 ---------
 3 files changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index e7019c95ba79..4fce64a030b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -313,9 +313,6 @@ static void handle_det_buf_split(struct display_mode_lib *mode_lib,
 
 		if (swath_height_c > 0)
 			log2_swath_height_c = dml_log2(swath_height_c);
-
-		if (req128_c && log2_swath_height_c > 0)
-			log2_swath_height_c -= 1;
 	}
 
 	rq_param->dlg.rq_l.swath_height = 1 << log2_swath_height_l;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
index ae5251041728..3fa9a5da02f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
@@ -313,9 +313,6 @@ static void handle_det_buf_split(struct display_mode_lib *mode_lib,
 
 		if (swath_height_c > 0)
 			log2_swath_height_c = dml_log2(swath_height_c);
-
-		if (req128_c && log2_swath_height_c > 0)
-			log2_swath_height_c -= 1;
 	}
 
 	rq_param->dlg.rq_l.swath_height = 1 << log2_swath_height_l;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 0b132ce1d2cd..2b275e680379 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -1924,15 +1924,6 @@ static unsigned int CalculateVMAndRowBytes(
 		*PixelPTEReqWidth = 32768.0 / BytePerPixel;
 		*PTERequestSize = 64;
 		FractionOfPTEReturnDrop = 0;
-	} else if (MacroTileSizeBytes == 4096) {
-		PixelPTEReqHeightPTEs = 1;
-		*PixelPTEReqHeight = MacroTileHeight;
-		*PixelPTEReqWidth = 8 * *MacroTileWidth;
-		*PTERequestSize = 64;
-		if (ScanDirection != dm_vert)
-			FractionOfPTEReturnDrop = 0;
-		else
-			FractionOfPTEReturnDrop = 7.0 / 8;
 	} else if (GPUVMMinPageSize == 4 && MacroTileSizeBytes > 4096) {
 		PixelPTEReqHeightPTEs = 16;
 		*PixelPTEReqHeight = 16 * BlockHeight256Bytes;
-- 
2.34.1

