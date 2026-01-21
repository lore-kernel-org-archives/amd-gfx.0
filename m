Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F42C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 22:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E9710E899;
	Wed, 21 Jan 2026 22:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vBLZo1M7";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 913FA10E89C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 22:33:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQagR5xnyf7TLJePUAB/5wiQ5cvl4/1cC9U51kKtSkhtEpH+ylxWgRHOkLam08wuG3nNuBKTz1j9TmgDz8KtEQlu1wxawvy4TPEZEJsFBwVxHtU6bnG3+7Af9tpboWXppidCz2FyngncFvSyT77Dh8r2mXDZQpsChdPp41BODTsHMcvyroX/Pm9ykKkiJPniucCr+4NNLwJ/17VsVjMgNmbstBq3/8pH+RPRlSZ+XIYMeRdmARYVk8RqQlTmhGIjPqo5R/EoNQfLY/1gP6sPHYesulBKvpe4KtBRmb4E+BdbkHAVAo7ZzPi0wR0HmPpqqK/E/on1ta+W4+kOeXki1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsZPt59N2rzdfPdbRwfPx4RWnI80/kTJZY/OMKPFTzc=;
 b=PNmjsptEW0AtD/ulNF2ng5dbD+j08nMoiwYcH122USLVp7YeO0rxrW1ZRuVqG4fmMJg4xwle5MZtyPnghaHpsetUzJi6afc7tuiCyJXVwSwjade27x4w68IC9BTUE8OL4mvoutMHZgcETN/sWE1tBgmHFikeIr6JgW8F1ML9ZekM2Ydms3eDecXM7MCNMiQHau7WvJnOcspDUFxwIJdYImIax77BfFVP3iPyGeTkBnxNTi4MzGLTiUt0DtEBOK7Y6pMBXh4APrUCrt86XGO4552UeDlOyo6D/dC4jpBgOK+IRFUbNdB5KqezValUiYjTRaMmOOXKx/0PzqlTk0ka3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsZPt59N2rzdfPdbRwfPx4RWnI80/kTJZY/OMKPFTzc=;
 b=vBLZo1M7v78smMq50YlPIO13qWSXyFuwBopAN1uyhBjPVqGi1GEPxYu9ayqi+Dm/+zN7ybTwx/HY4x7BMKmlwfS173nbiY8un8iE4QB33QT6qtQaq+wDeci0byeLBXRPIbWyByXROtrxTGIrsDoLHOg5NAqQSLWQ8XQgK0VfdwQ=
Received: from SA1PR02CA0021.namprd02.prod.outlook.com (2603:10b6:806:2cf::20)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:33:15 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::b3) by SA1PR02CA0021.outlook.office365.com
 (2603:10b6:806:2cf::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 22:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:33:14 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 16:33:10 -0600
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 21 Jan 2026 14:33:09 -0800
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Muaaz Nisar <muanisar@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 10/13] drm/amd/display: mouse event trigger to boost RR when
 idle
Date: Wed, 21 Jan 2026 17:31:46 -0500
Message-ID: <20260121223247.186241-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121223247.186241-1-aurabindo.pillai@amd.com>
References: <20260121223247.186241-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f1fc6e-9ee7-4e24-57ce-08de593d1108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RTIDMHM+g0rcn7ZWy07FRp0s7HR4sfzzQAQ8+Te1O3Gn7icno9AbUWjIeBdY?=
 =?us-ascii?Q?ZL9htKXRfkND5MKDEhVXfaWkHn0EQB4eR4eDI2Ik0u0Yaf7pgF+jOc/MMHLT?=
 =?us-ascii?Q?5kGSCj3UV92zrZjSiKq6z9JI8ID6COKytdc1C/Mnu7shLmedbOtLvalN2g0A?=
 =?us-ascii?Q?L3wca9N6h444qZgFJZLrmmR8qLBYTMuxFSn0Yit3ddC5W0Xm6vHiGEP4bpi1?=
 =?us-ascii?Q?4RnoDp3AXqWIw5ovxuJWOltb+06MpCdHEEh1qKcP+LDijnkwy1ew0H0IWOpl?=
 =?us-ascii?Q?lInGT6jKYTokBH60ldtv6SZJJVUMb72bw3N1kBHt/OyiW0mWZ0LR9RdmnSLx?=
 =?us-ascii?Q?+X0z3GfplXfDo81nUMLw6TYfSM5Tg6pao9OgzDKbTCz61JWT6n5qO8WhMp9B?=
 =?us-ascii?Q?i2rq4Cq1GaQu6R6wgu6QkUmhE38XiDGLJJ/iDl7NzYepxLeObhdbTKEu5Ule?=
 =?us-ascii?Q?Yp62e8/NkQaBtVojk81SHHHkgrt73YJYPcKERufSPNgpIZEcysEXPDVgp0Vg?=
 =?us-ascii?Q?PdvMHnIj9/GkhUCogld2uPQrKOr1ttr1EMmJVhSyH+wEASZ+PPw4nwZnK885?=
 =?us-ascii?Q?b+wozT3MJ8lW0UgbxIdbgJZt+7gyt1LFzFWisZb89wNIGoM+StAHBRHsQ7bv?=
 =?us-ascii?Q?SlFEbbIesnfedhDqrGmmV+8lAAmE+6A5ajAQ0IOrTN/Kv7Eiha743ZIzNpOt?=
 =?us-ascii?Q?Fr+4wQNRg2yM6X9cEzzJEOWZr4Y2BwmlELtxfvXVZ/na9Qao0XIM8l8lwERR?=
 =?us-ascii?Q?6nHYhOtbbjMfJ9bLdZvupPd5LHYlQaabA537+usz/W9xwjbwJ6S9GayujH/d?=
 =?us-ascii?Q?7oePTc4goYrtiw1jcGM2VqaK0gq4GWhNTzVmywJfdy5UivEkne2Z3NoyO1/T?=
 =?us-ascii?Q?gOYwmqRe8oed9IXE/apfxExlSWlQY6k5vd/AUmP9UPcC86aewf2Na8HJHvVE?=
 =?us-ascii?Q?S3jj0V9WkSfZKWwQEYtrhffSZxa66gavCOxyppNidU9TAyJCS3H1WM3ejb+W?=
 =?us-ascii?Q?c7tY0uUMdB2ikwdynnyAl1cMtpUtb0AmlX6Wg2tI0K7B2N0sDkvVneNe/j/H?=
 =?us-ascii?Q?60hox028Qir54l26q14pwQHzGCbbH6Ugzg3+oGzEHRFWyLHoT278TIhEVyzB?=
 =?us-ascii?Q?55xvGkmTFHMLKHt0jhJuClmC1PDU74jts8jjs0K7BqeWuSYsuARPrnniMIOo?=
 =?us-ascii?Q?hBlzMTZr4Suaxp8fCtQf4ZdlSKA25fzYWa9mymx4+hN1vCbcXCxY4e7uIMyW?=
 =?us-ascii?Q?Z4o0RNabOQIkUCWCuLb2J3pyySENjLD8jU8zTP4mRzhJHOWUqT/Zo0JhrnZk?=
 =?us-ascii?Q?GSFQd6w7+LNsK1JowFy7++Ib6Hg/pOfQNMVocT3HpAVO2VswAhMObEK+fpMT?=
 =?us-ascii?Q?t1dPteC3qXztUtG3zofZIkgPJVjgrRc4wlh9N4RZSZhOsKw+0lVxp/n4xD4X?=
 =?us-ascii?Q?lwAYEGIPueyiWXLJwGM7PR+Jp+a3dkx/cssK+SAVYSLWjQyAYxqCW+B9lAHW?=
 =?us-ascii?Q?P0RcTK21IPiA/GS1O2oCkCca9ndi3gCtOkgMm1Ox8bLESiYOC6u6lWiUC8qK?=
 =?us-ascii?Q?Khbp4kuTAIQW5K96v0ph5DkJpkEhoM/GOgu3C5IuLXHmWqPnluG01kH4bqRp?=
 =?us-ascii?Q?gk2aiqiwu3ZpUdBxSwjuCGb+RdERRNU9Pt1CKCK6Lmz2kAUOfd0BQThcHDng?=
 =?us-ascii?Q?MWEnXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:33:14.6479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f1fc6e-9ee7-4e24-57ce-08de593d1108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
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

From: Muaaz Nisar <muanisar@amd.com>

[WHY+HOW]
Add trigger event to boost refresh rate on mouse movement.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Muaaz Nisar <muanisar@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 9349cccc8438..f59020f1a722 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -515,6 +515,19 @@ bool dc_stream_program_cursor_position(
 			}
 		}
 
+		/* apply manual trigger */
+		int i;
+
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+
+			/* trigger event on first pipe with current stream */
+			if (stream == pipe_ctx->stream) {
+				pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
+				break;
+			}
+		}
+
 		return true;
 	}
 
-- 
2.52.0

