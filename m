Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF236C3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A0E810E89C;
	Wed, 10 Jul 2024 19:37:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HvNVCqCQ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B9710E89C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HODX5ENF44veg87FQZSvdpYZyMs0DEOTnDzrf03DcbxpUwkBhKeWyIzfKtmxuJNva1cvtwYXKLujb2wAMyQ6wkmyKkFCE6qBE2A1dige0/tuthbEa3EhLlsS3tlDDIGzQ1H0poElR1LWRk7i9pDtGQWujOecoT5hgzO2Pugw4RxNiO00c6r2JK/ltNsw1Wjzw5ZeMuNrctO4ydz1lv5Js4Rd3gpj890XH45CsDFEYs1rOlk+JrNJP4khT0IW0VCGlLIbviboRG2JzHOvv2/Lj45ASz/JxNWSvlA7cqWc9Xgvb6E9WQYeaFmMp+ExN/ydwYOiZ5X8oYg6/7GiaUuuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4umm93IWrAGxFVofi13OV/piZ9Cnt7PDyQRRvoF7lqs=;
 b=F56QRhS28/SZa5BNo8WF9HgqlcVsqOvogf6GDiTD4FLHFG4cOwirJWmp6pB7HY9wgyMcsQ0RLI/eiAY9UURficL1o8X8BdZPmeYABml547aCBAT7HTcs1Uk4xUvxfJ/Wtrr6VcdcAwSFUUFf+VocyXekAb0j0qIByhbmlNrUY64k3dfCAa/e26aHIaXOP8wpWuHsqPvhWl4/hzKemELyWZI6skW9W7Vl1fxDY6kQdUekcqj/ihVaZw1Ph+pnl8FsH0a9h1KHnSvhnI3OO/OTiNc2V8cIo9N2ZkQhc6tfUXsEdlff6M2SvOeqNQgrwS7hkQPYDwLZ3DYKAYa8tigRHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4umm93IWrAGxFVofi13OV/piZ9Cnt7PDyQRRvoF7lqs=;
 b=HvNVCqCQ4vt/w1RwSNPlm2FqhN5Ms5NOjpu6iytEmUHpu7UKFs4JDjaV3udDau74CKpDCZGQ8QJiKaRtYgQnzbrYkpmbAZxOgNmO9VtqiM7EZLVqUE9ZIk0zMbsjIoGOM4iiURE/ajUhrYt3VK7ApF3QVGe/6AZq1g/pKvopMQo=
Received: from BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::13)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Wed, 10 Jul
 2024 19:37:30 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::38) by BL1P221CA0025.outlook.office365.com
 (2603:10b6:208:2c5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:37:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:37:29 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:37:28 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Chaitanya Dhere
 <chaitanya.dhere@amd.com>
Subject: [PATCH 04/50] drm/amd/display: Don't consider cursor for no plane
 case in DML1
Date: Wed, 10 Jul 2024 15:36:21 -0400
Message-ID: <20240710193707.43754-5-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|IA1PR12MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9e8857-294c-4231-2191-08dca117bcd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PIsrrbgPc938ds4S5SPKgaWsFWQw7wL9IOOCcjyHbSc6C+R/matZ9/bft88O?=
 =?us-ascii?Q?WlqGvTiAI77hConQ6Uc5EXv5tZHSO1S3jN0YvYmFiJfa75WG7u40L5hjIOdJ?=
 =?us-ascii?Q?M04WUu1seO4jVZwlptE3HLwNlKdWSrd1fMBTSciht/4Nr+pKqm+tP91YL9qc?=
 =?us-ascii?Q?AW64A5YCdN/VWYC4+UxcUD933swpaWQRwT4z39S2xrKcxs99R2vTYvaElsna?=
 =?us-ascii?Q?m9DBYrjxwJZpssO/PYpYpY9dcf0aiWPtPnDOz700IyTTP5GhWHJ/t/mJZV0c?=
 =?us-ascii?Q?kYxraNSaZ9SHvs853pXkzSZLTbfYd5Menljctx9sbfn954QP4RXUX9wmROCv?=
 =?us-ascii?Q?ambF7WtIPk3GezrHVnXWrAD6zcgLZZG7987ow1HXe9tkdY+Aat6VBpZ0tjYN?=
 =?us-ascii?Q?OV3bL/kdPjdCvEdDo1LWEsvbw9I2J40mZW5/f318okSILuEiGlQ5bcBBjreg?=
 =?us-ascii?Q?lmO86orLDuccQedQjJUb8J1BJ1uK5w1rCjn5vvkZkWyEbEt/yn6J4AO1MWAr?=
 =?us-ascii?Q?34Axb8vtnVxj3jmKJA9UFL89Ih7lFZYxdeqLAY/OVcon96sOptJHzdj/qSv/?=
 =?us-ascii?Q?YT1dkd0rjnUYhDDCXaqveEgjEG2etSI9yPDpZMUXaCGcl6NRdAbLDXhL0HEq?=
 =?us-ascii?Q?pJ17PU76yb/bibG/Hki2abi76bmpcwyUFmjtAsld2Dgm4FZQbK1t4HKAqLrt?=
 =?us-ascii?Q?2p6067Mx5EigKhwO4sd/k8L881fRDsP3pWzp4RWZUdejw1Ze3tMWDO8YjzAc?=
 =?us-ascii?Q?PIwCj1LU60OA5zTT/CBgi/kcFPSJ4zwRU29vkFsWXkaZwiOkL4g4jKdBzemH?=
 =?us-ascii?Q?x+nRK1LkPePNOY4wAKOp0OaFvWflNR2JZfePrqmDRDy3vZGyYcwQjgsDpc8+?=
 =?us-ascii?Q?vq2LLI/oNW30ukRjYy+4/PNIfxSuJ1XEZYzicBtf8AAmkUXlu/Oi+MaFPMRq?=
 =?us-ascii?Q?Xlry1mas258xRT3kf90Ll7d/t06Sz5qBS8xM3aLkd2dSRQcSYVzB4mx5OBqi?=
 =?us-ascii?Q?mq9vchyIgQHpxIg/oyq6cHMprP6u/L+23yef8kHolLZKLknWW7Ze2jGapLM9?=
 =?us-ascii?Q?Silg6EEASaflKwxsvZG+PFo5Tz4HhBiH3/XpeEMyx4SGlRhMCZTsPvc5/zJG?=
 =?us-ascii?Q?eFwhRxr3fDJ1RcQPikM1+W1EkoasNJc9tZx6lR5roMfkR1XDBM2xbT1PowGi?=
 =?us-ascii?Q?fdrDKVvY4seEclwK1AGAoylfRvUKffHwNS/2X/8Ciz1P472pUtToA0lxc0IL?=
 =?us-ascii?Q?kTzUykIwVVGxUJhNDKMYZcKJKND7uIu+lKcWdrOC3M0pQIUmp3mBg1kGDgZo?=
 =?us-ascii?Q?mYzVR1ImGQbtxA3g/73G+ISZEaT7Laox7x0xwwArtMcN0Mg8kcciVvqYnUIZ?=
 =?us-ascii?Q?4fnECG2BztGfWEST7zlZ5sws3cjmwwQuz+9qlNCQsFOfz/5BmW7E3dQNTwHf?=
 =?us-ascii?Q?9VNRoOwVaPVYkdrNIaugtSBoQt8YEyEH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:37:30.1878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9e8857-294c-4231-2191-08dca117bcd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586
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

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
For no plane scenarios we should not consider cursor as there cannot
be any cursor if  there's no planes. This fixes an issue where
dc_commit_streams fails due to prefetch bandwidth requirements
(the display config + dummy planes + cursor causes the prefetch
bandwidth to exceed what is possible).

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 8a8efe408a9d..efe337ebf7c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1562,6 +1562,8 @@ int dcn20_populate_dml_pipes_from_context(struct dc *dc,
 			pipes[pipe_cnt].pipe.src.surface_width_c = pipes[pipe_cnt].pipe.src.viewport_width;
 			pipes[pipe_cnt].pipe.src.data_pitch = ((pipes[pipe_cnt].pipe.src.viewport_width + 255) / 256) * 256;
 			pipes[pipe_cnt].pipe.src.source_format = dm_444_32;
+			pipes[pipe_cnt].pipe.src.cur0_src_width = 0;
+			pipes[pipe_cnt].pipe.src.cur1_src_width = 0;
 			pipes[pipe_cnt].pipe.dest.recout_width = pipes[pipe_cnt].pipe.src.viewport_width; /*vp_width/hratio*/
 			pipes[pipe_cnt].pipe.dest.recout_height = pipes[pipe_cnt].pipe.src.viewport_height; /*vp_height/vratio*/
 			pipes[pipe_cnt].pipe.dest.full_recout_width = pipes[pipe_cnt].pipe.dest.recout_width;  /*when is_hsplit != 1*/
-- 
2.34.1

