Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAD6FD88E1
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 02:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D0B610E7BB;
	Wed, 11 Mar 2026 02:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G537sDl/";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB0410E7A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 02:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0zXotZVbFWXXZEDCoLQaP2ISHQrcpHuxT6Z2ZzNzbEm65IA+4h8RFv/9Q0ndcq/K9EidPQVLslL/5GKvoa827ZWJW7bezeN6OBn3DaqSxJYYgOdV2zvA6unwz35EuAotOaiiYm05gjzrQFj3D6DwO/m5Hdc714HBDWPhMWjgVEdjHIG9jFe0nlXQXZLV6Iko4o1AMy3ZOlkz4dsiSss5R01Dxn5/Axvf8/TbOXLt3yYUtFuwghotMQPKkZRjOaKoHRgwcLw5z+blmGPiOWgZjCJ2n63DPTpsmxymspzmLzJDtcZcGHC4YYLA2gIbvqThf4pnJT1h23U0rqZWIGAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gT34DG4bucypXFvqJJFM+cIskLlzpK5nkNkSEnl1GoE=;
 b=xQ1GUoK0UOFYK8Zr0s7etCqR0HeYkpo6BWaRtC5pr75ryG7ipz/Y1y9gL1itKgDn0VEeG0lEWi2Nu3JrFehMuPT/PXqfuzpGapw/gqL4fC1A0ia1tOUAAhOwqjgDC5WNVI490teF8Hy/tjsXm1jBx8veYRJwveNE9acnhUww4D0B9Xv7x7xJm8Tl4EOvzfP/G/KxHGJIoF95Xm8ydZpssNhe0b+NW6Hcep1CJN5VfNFjx6Wd5Slpm91nvlq3CeSBksX5kG/7UhmrV0uL02hdTRxMiePDgG+xmm+yQlIMdyEWtR2b0qbG3XFSbjJxeQ5YtG9dOIZkiiFatqp4YW5IKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gT34DG4bucypXFvqJJFM+cIskLlzpK5nkNkSEnl1GoE=;
 b=G537sDl/vvHZjUrnBLQUU9yjROgd80829CiFPVOelrjflXepq7HhvNc8HdBzuYsSqCInU9h48v1Ap+oEcxvB9gzF9QLohYhaQgvyyGL6meD1RdGxTUvqquYJsS+wijPlAT6boROi6brtAM3K2V+PC8TMAgeYoZq3z+/MbDZ63MA=
Received: from BY5PR13CA0022.namprd13.prod.outlook.com (2603:10b6:a03:180::35)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 02:46:10 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::1e) by BY5PR13CA0022.outlook.office365.com
 (2603:10b6:a03:180::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 02:46:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 02:46:10 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 21:45:58 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Benjamin Nwankwo <Benjamin.Nwankwo@amd.com>, "Charlene
 Liu" <charlene.liu@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>,
 "Chuanyu Tseng" <chuanyu.tseng@amd.com>
Subject: [PATCH 8/9] drm/amd/display: Clamp dc_cursor_position x_hotspot to
 prevent integer overflow
Date: Wed, 11 Mar 2026 10:40:40 +0800
Message-ID: <20260311024652.2668570-9-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311024652.2668570-1-ChuanYu.Tseng@amd.com>
References: <20260311024652.2668570-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: d87d331b-e16e-431e-c98e-08de7f185a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8aIqqF8+GJqlls8qx4y/qrxraVEy0GG2sGkYmTlPj5XE24TVp5L2Hxb+usJyPgKISObNAZ9vFM9zPdU8ADHSwzpj/MiS2C2KpA3dAHT7Zlqq2UXzRk/KmUwO5i6dTxR8yfLLrShEq7+w7ev+chs79z3d9LIBavjAecoV/tTgnLW/ee34KKAFSRJZTp+RQR/fDrLhr+08573Ed/UqCT6Y0ZtOzU81Hve1NQlihLob33pFCfvc/OgjmGWw1f1bYHduEOVZaMyRgaIRCwgdl6p2kk+L5nufh5SFjjjPdlaEzJn35B9YxZHBTMCOD3CpdWrgMUK4gnZHl+9a1nfLMIoLXN0yQ2tYqJ7cfoKiuj32zh5mKnORAoARgBaagxkyM3VfrGYDop5z+ZkePfBUekW+nOp5ojxvhibgiEOSFOv3TCfi6b+rTPY1NbExnT8q2BEZMK8cPKYBXcu7QPw8bkUQYhoRtO7j6FSuLYoLrG9Rsgo81qyPsDSuztp0xRA2YumEPfLDQxzSUFEl+xnavEzjDQpSj+SEnJft8/TfF8Gp2QGFCRreKORBGTattfywY4Y6K11h3kp9+lgZq8+vx6Ha+mWxWXAgS1a1/qY+A72MRdvAnUmnQvb31Oz8h6fxWWUBCE9l/DHVJSKnm+M4s4ztw6c5nQ5nTBjTskWtBTzxS6i4FbhU1jmfQFhfAX26IJInSsdz2LhiTLRJKz6Y2ugaI6EfijFiH2Dbksv1NF17byR0140JKOK8u09MJJzi2v13gXYO+Tscjs4AXPD9uwx/YQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xlUGESybt/MJkUQ1C2yXjWZq0nBRT8DYYHLHgqH6maon9X75xPd2TR5o1wjVRiXq6eKs7OlovwV/BBmhRBqr2MLLDpY2oEYRwYHMKgJKADsxjhsUv8gyI9G6zfWAyMKpplxAe+f0s3AnazOtK0h1mfqp3l77ImpOmMYuPWCWL1oLlSnTIgJn2aTBG58RIA9CdIdoaIqXfBGSAh8TGLeNX8ilEQ9xlJaP91oKsn5nfhuRbdEXPMk4oQMSBUn/qf6aZomGsz6KR/DXmCT5EywV9xNJFDK9nNOMNdI/O2RlPEf7Lamsoa/s3GBQj9NFHXSDSvkR84IYnYXgIaJv8CUS1LHMqE2yR9mbzOm60QxZVbszLXjuPt/61kFnOVMPUXpkSjyA8EAaDedkVA7Bv1s2Ab+6g9sKpZwBv228A9SnxP/Orz/ZYKWoFfyhXd7hyxQZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 02:46:10.0317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d87d331b-e16e-431e-c98e-08de7f185a27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078
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

From: Benjamin Nwankwo <Benjamin.Nwankwo@amd.com>

why:
Workaround for duplicate cursor. Cursor offsetting via x_hotspot attempts
to write a 32 bit unsigned integer to the 8 bit field CURSOR_HOT_SPOT_X.
This wraps cursor position back into focus if x_hotspot exceeds 8 bits,
making duplicate cursors visible

how:
Clamp x_hotspot before writing to hardware

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Signed-off-by: Benjamin Nwankwo <Benjamin.Nwankwo@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 4985e885952d..263e0c4d34f6 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -812,9 +812,8 @@ void hubp401_cursor_set_position(
 	int x_pos_viewport = 0;
 	int x_hot_viewport = 0;
 	uint32_t cur_en = pos->enable ? 1 : 0;
-
+	uint32_t x_hotspot_clamped = pos->x_hotspot;
 	hubp->curs_pos = *pos;
-
 	/* Recout is zero for pipes if the entire dst_rect is contained
 	 * within preceeding ODM slices.
 	 */
@@ -845,6 +844,8 @@ void hubp401_cursor_set_position(
 
 	ASSERT(param->h_scale_ratio.value);
 
+	if (x_hotspot_clamped > 0xFF)
+		x_hotspot_clamped = 0xFF;
 	if (param->h_scale_ratio.value)
 		dst_x_offset = dc_fixpt_floor(dc_fixpt_div(
 			dc_fixpt_from_int(dst_x_offset),
@@ -865,7 +866,7 @@ void hubp401_cursor_set_position(
 			CURSOR_Y_POSITION, pos->y);
 
 		REG_SET_2(CURSOR_HOT_SPOT, 0,
-			CURSOR_HOT_SPOT_X, pos->x_hotspot,
+			CURSOR_HOT_SPOT_X, x_hotspot_clamped,
 			CURSOR_HOT_SPOT_Y, pos->y_hotspot);
 
 		REG_SET(CURSOR_DST_OFFSET, 0,
-- 
2.43.0

