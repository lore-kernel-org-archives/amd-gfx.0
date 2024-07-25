Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C8DC3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 02:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035C810E134;
	Thu, 25 Jul 2024 02:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kFvkoIOj";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0965110E1FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 02:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umhcg6z0Oy/eUn3U0ngsp4Dqc+Y/tJ6Fjm/l2rocZJeO0xtMSU1TFF6jwdSRhfncM/XdBTMGkIaMumsp5iI4mmAffjjg3lvmnTDqHvUNXAAf/csF0tuyUOUn4ujidlF0avXv9M1WbDgiszo7bNgelNTmtKbTOiqn4/bSzN3ON3Y6fvufM/TRiVpJtA+wjKG3oMP4Lxi+DLqRRr66jxh+qYjGzfOngESeGclvNofCv2yfgZcbulmvPAcE9CUFhFEzNDpgX1fjT6Dy2b0gTvPJSl5EN4YLzHrivC6gi4ob43IOUM8mDEvIT6Y1b8QIqUrubirrzz3YexNDI3/ekb47Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REXWMKvIbxdseDHuvaadkD4Ns6QmymiA0aJh4UQ/VRk=;
 b=I6PWqDHizbWbC+pPqRcApwXzVWS4jzBC19Xkm5x5XjH0/TEVIUrqU7TkYVy1Km1/sYTfrFyAfTx47lDBhXRiZzPCRqTuex9ovit+xDNP8IQMWiqbG8y5jG1gPlhJn4b4No95LcbHxzQO6LDMFJ3r6LECx+5h3m0Nbjzb6cnEdqBjUHpObYeJplws52xxbvBJyUEZJl01Sd6NYw925JQKBYYWS1Ih3DIR0R7WYWT+hyy3Qo2CN5sighKVWpxDVEW3G7HpQPPDP++uixk2aA3yCzASl+EfonB1maM0/iOWzHOosK91BTP8TrnRIIffAuLu5a+xpwbAQ7kgrK0+fb6Ozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REXWMKvIbxdseDHuvaadkD4Ns6QmymiA0aJh4UQ/VRk=;
 b=kFvkoIOjtvIkQhiw1T6M5F1No2SkHl9xwR2EUoxLJAREvoaMPE+HzKjCJejpX5SAQE6jAooYaLqwBGXyzanfElKi+kzjPM2Fr+U1Otkzh8+IMzhQCTR/sqLiYCCM6GS3age+3szFpvO40Oe+tQ/nPXktR+Yg2I3Qqv0qliFSP/k=
Received: from BL1P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::9)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 25 Jul
 2024 02:55:28 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::6) by BL1P223CA0004.outlook.office365.com
 (2603:10b6:208:2c4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 25 Jul 2024 02:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 02:55:27 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 21:54:38 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Add null check for top_pipe_to_program in
 commit_planes_for_stream
Date: Thu, 25 Jul 2024 08:24:09 +0530
Message-ID: <20240725025409.1507764-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725025409.1507764-1-srinivasan.shanmugam@amd.com>
References: <20240725025409.1507764-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DM4PR12MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: f93abe74-7dcf-464b-4f2d-08dcac553d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PO0wEVz1dcMTWxRk/odw4UxniGOloDhu7Oo0ERGqCTReUz43K0M+s52NFZVw?=
 =?us-ascii?Q?/FaHt4kiKkVfFWr+pavpOS5VQyjiiM5T6mk3Quv7b9hsC35b4keaPzC3AyOP?=
 =?us-ascii?Q?Uws9D/J/3YOQP+HxYYcOPfBU4+vZEsDC16MVFFOrX7N60iIz4Q5HchMrPfYT?=
 =?us-ascii?Q?UpSxPj8vwNUC99e3NvDwqorl7Urr13e9WBtJsxwqhE4vsPitahg84MLlNURh?=
 =?us-ascii?Q?hDfa2WWx0AzeCVKUWzqvnWpZ94pQzOGV24fLszfPn8b/IVdT8gD36XTCSXzD?=
 =?us-ascii?Q?jTcQ2FVrMwF2ckPDUVyvmcqDnYsZqCuaPsUpxUheNOVPsF0wgWv9YNeT73GO?=
 =?us-ascii?Q?MBRk87xtIOB+5+GzUpm+zNw+hJzq4ohZt19kpwpFyy0daeG0gGCNSih/R+6L?=
 =?us-ascii?Q?ZsXC6uybyPi5ZQusAADnvnWnut3XcH65MD5AjAb4U/X2idbfZcm61NgFIuJZ?=
 =?us-ascii?Q?UMTdhaLuo41PVwgeFahm2MWJqheNvchGPQfAlBHAng5hBTZqTbIH3BG+l5HT?=
 =?us-ascii?Q?XpeytMkLkFa26vSzdpBF4dVf9vOqu32qBqH9hoShXsI44qqYZz8RVthugpUI?=
 =?us-ascii?Q?W5+xw2XULt6evyFn8MM4ZFnm8KlaXrC/bD2fWtUd5qYkdr/NRslwJ/PX8BNc?=
 =?us-ascii?Q?Cgn2jcNkUokiAl7MmNAfKNL7/+ZO6Bojcev/tG65jAA9GaQYP9ECQ8l0Twy+?=
 =?us-ascii?Q?vCzPaSy+zoY+1OA43XYqJAQwJSvxnAnrpKU9rACN27pQu6aqJ/WPC4wCMLRT?=
 =?us-ascii?Q?7rqGYxS57TzZt9IvvqcvTpE/qHKByDTnYhfApkXodqp4dji09u9Qrf8lmqCe?=
 =?us-ascii?Q?YRqNqa3F540JYOdSmjS8h32WdbdO18jFrTHdTW4KeRb1ybkH2PHsA3Wdbnzb?=
 =?us-ascii?Q?Wc69pDpxuYrB08hs0qY9nBN8KG5zhSNBfGMDxTt2+QKMKddKG6uhPlfeyX/2?=
 =?us-ascii?Q?RaDnlDMOZTn5Brht3G0IVj4eblHepSrs6G2BQmIEptvFImj8wZT3Ih9yYwTY?=
 =?us-ascii?Q?AQGtvc8m5lJuR+2FF2aydwqQmCJT7gej4kyCrk0/BLjeLyJaVjBhyK+upQJA?=
 =?us-ascii?Q?p5QHsx0NbySmOCskSOc4o2rO7jkYx11lwFyfVH+XmFNoAWRFK7R746FcXhrs?=
 =?us-ascii?Q?nSo9UB+kloTqEfbzbyGP83t82iRr6KbSl5ujYb+3bzICaTZKJEKJ69SpHBnv?=
 =?us-ascii?Q?UV9vouaJJxzFfYUx19IzxZJFWYobFqnLJCD5b21/X4vm3NWtDJFn7CMMZHvY?=
 =?us-ascii?Q?B3TDj/Qcw5fS5fd8fPWhnKVSo7B6UN23x6PBcnPT/0/fUYcm3Juzas73ssNj?=
 =?us-ascii?Q?5/CAB+36CuKIsydQZVvcv/y8tmZy3s9jxNPJxKwK5Bhi3MKisALS6my7cHXR?=
 =?us-ascii?Q?xdnpSYyuXuNvsGSyqGNJ2+Xsc1ysMid2XEz0/eVrWJaigg9Yx4L8nku/le6s?=
 =?us-ascii?Q?J6froV/Jbm7clhPganYyuoImNXbAz1cp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 02:55:27.8178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f93abe74-7dcf-464b-4f2d-08dcac553d34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695
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

This commit addresses a null pointer dereference issue in the
`commit_planes_for_stream` function at line 4140. The issue could occur
when `top_pipe_to_program` is null.

The fix adds a check to ensure `top_pipe_to_program` is not null before
accessing its stream_res. This prevents a null pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:4140 commit_planes_for_stream() error: we previously assumed 'top_pipe_to_program' could be null (see line 3906)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b8a6c062426d..95d6e29d5e47 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4137,7 +4137,8 @@ static void commit_planes_for_stream(struct dc *dc,
 	}
 
 	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
-		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
+		if (top_pipe_to_program &&
+		    top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
 			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
 				top_pipe_to_program->stream_res.tg,
 				CRTC_STATE_VACTIVE);
-- 
2.34.1

