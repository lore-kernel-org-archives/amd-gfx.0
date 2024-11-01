Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5DCE6B278
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A9110E166;
	Fri,  1 Nov 2024 13:50:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ya8CQwgV";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D44A10E166
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSJxS62ZRVKr33to/6GC3lmklSGrYPwYPON/jk+vOeTaAKK7mdlQkXBO2UJn1gVshNTDIyWAKQwU8RWWJbsE+nIrta9l98ivyEFMGXRsSCm2wYVHTTGLSwgcVTum3x41L1jHfZ8u7BsuiQXNBnQjdWhFiN7jCUJan/pnsMhbAAyJ1EMDiOKl7MTHw+qIF9x+0mNEGkwptJaTyWfGWprhPZNXI3X1mZE74CBzMMh41gH3BYHKfpXK/1YsOodNyim0yNlLDCpz+XKRU+pFxZj0ztnVJ+Akdt4sH/vKAPgOYK96HAPnc4IWDN38SjIHRNMOnGDrXv3J8Nj68LWR6uk9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjFSRrcN37Agy302TlXZVWW2Zrja4GWRyh7XpAG+few=;
 b=nCvSFBYO71XAs6HoKKLiRUGkMzBOge5+E8RjRnhVFoF0tpJDlUzm3OuwAbTX3sFWPTAEMMOLhxncDGcJ1xGApSLV94JUa8iI0fDMkuzOAyZxsA3BlokbyM998nh3fBnCJ7ztp5Z6yWyRRll/aAFY9VMTxhXsUhRKVMH5ylYPERGrqg/bAA4A3ljJuZzS2RZFgv5D+0Msl0Z76Bak2XNy/LiyrPBwZG24L3gOCK4Bou0GQTNjduoER6Zy302TI+TGnMTm+Q87/ftJNxiP8+37eZvqz3+Shw4szBi7DvYUjqpYW1TLUOcAc5/0Hl+zc45X07+j9uD4SDE/Jgwu55EwdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjFSRrcN37Agy302TlXZVWW2Zrja4GWRyh7XpAG+few=;
 b=Ya8CQwgVZUAaxQhPzICyONCBbke/BKkZTJC+SHhVp6V3q2m0Wn9ZFJv8jYMu2rMRGaxyQvPG9oyea36mxtAMyYFpJ2EUy0ZS6XkVj7Kt7sz6tnwL4mhqWVuyNsSwxppBt/tRryAVIwvW7rhUtJTtY04tnBC6G4VcgfnDv7ZjQic=
Received: from BN0PR02CA0024.namprd02.prod.outlook.com (2603:10b6:408:e4::29)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 13:50:08 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::85) by BN0PR02CA0024.outlook.office365.com
 (2603:10b6:408:e4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.27 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:07 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:05 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 02/17] drm/amd/display: avoid divided by zero
Date: Fri, 1 Nov 2024 09:49:25 -0400
Message-ID: <20241101134940.1426653-3-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: 2131fb08-b6d3-40b2-c9cc-08dcfa7c18c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QNR09G2eMK7ZJt0OofLbry8KLIbo01dzmM/pP2SsIMIM4XOWm0AmvtkVwR9+?=
 =?us-ascii?Q?9bVjuMtivMaAAQZH9kHfiCAO8XGODrcaLZcRGjRJwq36hdLL6f1sQ6n9EMGd?=
 =?us-ascii?Q?oK9VM4HZE59dogS2+VIbSt4iW9xTHNkmYaAkb+6KvGC16RJcSVi8B4BZx1kQ?=
 =?us-ascii?Q?xWsCK3Vfy/k447nHOZthjxNepeCj5iSJszs3Teh/6rdAJpku3WdBr5hoecO2?=
 =?us-ascii?Q?z/biThGEFVFO5R/l7CM5S3usT+0q2EY5n/F73abynxs/e7u4eSKblANt6rCm?=
 =?us-ascii?Q?r8B2K2xiYZY8RNYQTfxgPIN+gRf6QZ7TVviXLrMhNPpPAjt1uQ/0QQYsR3QI?=
 =?us-ascii?Q?5EUAP5Pkg/hSwg7VNVE8pAJq4i+8n7+rsK9ifcw7+f9H0WZr5nISLuxzQynp?=
 =?us-ascii?Q?XWDovH2LHVSrBojLfazWDzUtRkpVa+k5Z2qHoSjsvA0bVtsa38CsD+EfTVY2?=
 =?us-ascii?Q?e7uWNbVwsZ3Ckw/r5mN1h/2WeoxDPOAmM3U1bJbdU92ijRAg4MODeDhn3aeH?=
 =?us-ascii?Q?xZ3puKhSINpx1aSq2ircaCVmmeWU6p7sHm/FPmDm2DVBLtrlc7N7yb1MF/IU?=
 =?us-ascii?Q?lwqmKOBTbTjlbNRCT9rvzw3y+wEarU/FtjNHFN4xxXhtXbmrMPwdiTGYVajm?=
 =?us-ascii?Q?jw0mW/1tdVvN+wZ8DtC0fu/mGziclBcCtjAOnjpmbEMLzxLYAtdVZSGYfDdn?=
 =?us-ascii?Q?0RNuYHGFFngRZMkaCgk6LH1BDo4DMb0ckRe0qjEPHftOONpJzSHY/gHyADnG?=
 =?us-ascii?Q?zXeBq0s5eApRa/dh8G1Gu3whZ/fcqUIsY5ZY4NEqex1ZQSmoCnMCcemYA4cq?=
 =?us-ascii?Q?kfHJPkLA/l3gy7J4Ep6fMiIVdginzw3ltogLgwd/55tFCVvyGsiIHDaRF6DM?=
 =?us-ascii?Q?G6dQyG3rbPW1EJwWfDxTsjrWKbp2A7EnygEc1HF3jhXLGGmyChvDUMEPqcuP?=
 =?us-ascii?Q?Hnzm2fYMYdMYUXA0wWludRWZ/qv4N1bftRJ7co5bCbPMO22UN2TCp3dQ2fNF?=
 =?us-ascii?Q?13zWpAh2p55sPy4X2mRZHEwLPtNu7xlDP9bS5Gs6MhzxUMilQn67A8/YftTO?=
 =?us-ascii?Q?QwXWa1RnzuZDwo6+SdwFLVMJDACo4dToCgFIpN3ymh4XMslfPskVmPT3bWge?=
 =?us-ascii?Q?T+TQSFZrX7ZnbnZr/sp1IlgRBpot8WOSDbrFcRI3t7iXVGuahKjGbkpOSpOb?=
 =?us-ascii?Q?sGkgslrsLNkYtPdf5Ox3ODHLyZUG1U3fVR38mA0Tq6OMiKGbIbI52h4bQrhX?=
 =?us-ascii?Q?l2kyVD091dz92qfH9xOMdI99GCkKllomRAH/ThPZcvpXmQkRUXfJSldYG6Jg?=
 =?us-ascii?Q?JqdxPlxC0I1tQDYSyo7w+LswKAvzPxV+IDXawKMDSf5noiBEBb8bFlW0ljH3?=
 =?us-ascii?Q?QyatprOqrETL2712jesaE/10HcAEVKw40Zjp8ewNsVYpuClUjA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:07.7581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2131fb08-b6d3-40b2-c9cc-08dcfa7c18c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
insert divided by zero protection

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index fc4268729017..f980a84dceef 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -129,6 +129,9 @@ unsigned int mod_freesync_calc_v_total_from_refresh(
 	unsigned int v_total;
 	unsigned int frame_duration_in_ns;
 
+	if (refresh_in_uhz == 0)
+		return stream->timing.v_total;
+
 	frame_duration_in_ns =
 			((unsigned int)(div64_u64((1000000000ULL * 1000000),
 					refresh_in_uhz)));
-- 
2.34.1

