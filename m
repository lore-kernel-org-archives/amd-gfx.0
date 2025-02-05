Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7993C0219C
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 18:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A219E10E3B1;
	Wed,  5 Feb 2025 18:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oX9iM1dk";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4809D10E387
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 18:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNRojU9MsZNcjuWrRLTeiaoSModqOHgKLsOev1xOBzxcmZhEYjoNE/uiKCYcRD8XmEY0AifNAQbcxaTIhK23Y/TVVEcQPFMF38H950nsRf9ELqsbR8pyhqBexYrIoN4Xu3PX2qBxF8PB/3Roe2wCnqJQg6YfLB0KQD9KmcIxC4k6rMGqVgl+2dtdcOqJS+j2kexNZiBf9Z86szWQS5P3TqBkT7BTTT/SZOVp+HHXC637FnWj3oPS8/bloA+ImJPZopkWbGzjBIpjuKAuSv8weOVblJZJeiJGj6Er7+2Qnpvf+RN1wg3tdok/WwxagrW1oBOprlayO0PWgOKz9MNc/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziyEHpbL8O21b9KeN2hAyg9OJAlotAxxLImJ5B9HRW8=;
 b=H57GbI6HIGRxY74GE0g05n3h9fooDC8O4DOktZtmAt+cMYb+GHDZbHrR+65waqjzegbTf/5zKt9bvbateSx2Y97wDPUlZpMQtQYobLlpJ9CrKpPWjr9OSD317p0mhaeP6FI7IuRF1d12GOlDImIzPDbwhhHsIUG1ahQJlxJFW1zOwaSrQT2lfKk+z1eo28CHb4FJ3sqDjjNDSpytZrsXZWTGBNx5mvO//cdtxPIjAncCbMvap9yUCkmss5rlcNyyhojEwB8aHFwrpjVGoJV4nY6XKkxiM2AxrQvAwIsx0UsCvqL6zT+zC3v1SM/2JrnwMMQ88tEA22QsvI3nyIo18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziyEHpbL8O21b9KeN2hAyg9OJAlotAxxLImJ5B9HRW8=;
 b=oX9iM1dkq5kBFg1ENlfrUy6i+fh94F2y6avy3Wga3dwNAoDDEIx4GeRL1ml5pFe3v5qxbVSBOxm3pLBF7Lw2BKV+TvvNuO9IIdaaGB7WTr8wHHHAOKzZVD/RYo3nosmGhTLhVV94WOAgYNcW/BcnO3ed8FQX9GLv4pOqSlq62b0=
Received: from MW2PR16CA0053.namprd16.prod.outlook.com (2603:10b6:907:1::30)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 18:41:15 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::c) by MW2PR16CA0053.outlook.office365.com
 (2603:10b6:907:1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Wed,
 5 Feb 2025 18:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 18:41:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:41:04 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:41:04 -0600
Received: from aaurabin-cachy.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 5 Feb 2025 12:41:03 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Brendan Tam
 <Brendan.Tam@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 10/14] drm/amd/display: add workaround flag to link to force
 FFE preset
Date: Wed, 5 Feb 2025 13:39:25 -0500
Message-ID: <20250205184036.2371098-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
References: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 69245d73-96e1-41ce-36e3-08dd4614abc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BHQdxBLByxv/RJR/3TabzG+yyV01Jti9ieMGU73tXh31PPZ5WxJAlslcEHN+?=
 =?us-ascii?Q?ByHkxNpC5Whx4sp3dCBVPVltlZOme0H7tHIxeNLkTgXive9I9GJRZnyEmjCi?=
 =?us-ascii?Q?wKCDe+NcUD9PHriPJqPTldKSxuVJbxGH9HPbwOjcKDWo8V4nsQdnxnukkajw?=
 =?us-ascii?Q?JfS1x2rhGffqukHqCGSG0g5UGWZCtBTwH+Ani3/SezZQBsu5p7rtJBIuFbp2?=
 =?us-ascii?Q?PRKUwzLLLKmYfA62/rZHKiWA0SlHv6R0G2nTkpKowvrm4uLSaRWqRE3Lg07C?=
 =?us-ascii?Q?VD8XVu2lcyTGtKFEUk9rQl8Vm12tC2/ODb5nQ67ZrEt2d07RAv5UtqtnIm3P?=
 =?us-ascii?Q?FD95d4k1k3F6jV/wzn6G96/8QHnwFZuEfSTfuby6dOF6k9q5JIHzS6nalAuG?=
 =?us-ascii?Q?IYrQDHisPCZjPnGqGSxRvb7MBW+/gDZo22d8QRPFnh7dMxsZKj2f4xhnHMyy?=
 =?us-ascii?Q?VtmZjw+jMPzT7bzz7bIWaDsp3CIurANwyGpaEJd3S7JmFK4l5yo0Nj9Of1zJ?=
 =?us-ascii?Q?I42gPEMy0wrjb70PQXMfRuEvxSeigfOGjhGR8uzW/JnB0JT573trfeVNtDTi?=
 =?us-ascii?Q?kZO2z3IFYPlOlnWU1PJot4FpbBjboNjUHIlY3v6NzaKIZe6gbOXD4x+xNEOp?=
 =?us-ascii?Q?CccDIBtYxhb1V+EFCSQELd/JNw3WvHuAiWdSZNF4eJ0zfNXR1tTqZVAVuWc+?=
 =?us-ascii?Q?IMG/Jv1+BSZfeKwye08QkmM7//mHW8BPBPqxwGVf/NSbuy32lf8gH3s+LSqx?=
 =?us-ascii?Q?cgpV95UeStfJMjy33mAy1yTlTu4YpTmj+kxsTM8Lp+u542cvFrTNydPuaxQ/?=
 =?us-ascii?Q?qNPmtVNvMLeuyeG+r8cQyNyJxY/kax3582iLZkdQQrmsGjQ9+qhctpOjyT2F?=
 =?us-ascii?Q?VIeC6tYfSljpg2pnRQkCwQJcW94IhYZ66WYOy6txz3YvkHJADGT1/LPQPhSH?=
 =?us-ascii?Q?/i0UfrVl6PMNPGMGvcnY3Crz9qwTo9Kyla0ceDDGL+MTCo8ibWJF/updYTio?=
 =?us-ascii?Q?jBwpM63m6FdHNLG6gGTp+fWQ4jBPyTwCHRiMpN1RYkmysYPVlW84Ad48QqYB?=
 =?us-ascii?Q?gV8/Po25rwrOfyND7Gf9IkU9jWXmcXs9UeC9Gc7IGEGAMpzjotZfdXUuB8kp?=
 =?us-ascii?Q?xtbVqDZWHOEPr7YOwcbgonDcBCNJAJSD8mrdDiAMoEs1v6ab/jxVAexrJzdo?=
 =?us-ascii?Q?BolfaY+zdcgS6oHCrW9JuUAZcacb7ImX/bIkxcqhet0eOA/TDA3P8QnxMClM?=
 =?us-ascii?Q?nLs/JsCF/NLjrwlbJhQpBtoeV2wPRuR/g7nQ1ZarxAC+aleKobRYu4dUZdcH?=
 =?us-ascii?Q?YFRhEQ7DGHZ56zpc3l3hCc/nSBqagkaYjQx+WoF6G8wIb4PIGxUBBdW6cfx9?=
 =?us-ascii?Q?jt67osyeLkEH3zI1+sAuMq/jW5PuCIHA0pDTV8Yq7LjaPpUSwwbleW+oCOfg?=
 =?us-ascii?Q?xNRV5YM/42cYWY3rZislerNcR/UYXYCel68t8Se1mbRzOuj9ry4yah1x6PQJ?=
 =?us-ascii?Q?f/OOIISJqnQR0y0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:41:14.9500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69245d73-96e1-41ce-36e3-08dd4614abc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
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

From: Brendan Tam <Brendan.Tam@amd.com>

[Why]
There have been instances of some monitors being unable to link train on
their reported link speed using their selected FFE preset. If a different
FFE preset is found that has a higher rate of success during link training
this workaround can be used to force its FFE preset.

[How]
A new link workaround flag is made called force_dp_ffe_preset. The flag is
checked in override_training_settings and will set lt_settings->ffe_preset
which is null if the flag is not set. The flag is then set in
override_lane_settings.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Brendan Tam <Brendan.Tam@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                             | 2 ++
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e1f4f643c364..16cd7833e931 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1792,7 +1792,9 @@ struct dc_link {
 		bool dongle_mode_timing_override;
 		bool blank_stream_on_ocs_change;
 		bool read_dpcd204h_on_irq_hpd;
+		bool force_dp_ffe_preset;
 	} wa_flags;
+	union dc_dp_ffe_preset forced_dp_ffe_preset;
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
 
 	struct dc_link_status link_status;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 88d4288cde0f..751c18e592ea 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -736,6 +736,8 @@ void override_training_settings(
 		lt_settings->pre_emphasis = overrides->pre_emphasis;
 	if (overrides->post_cursor2 != NULL)
 		lt_settings->post_cursor2 = overrides->post_cursor2;
+	if (link->wa_flags.force_dp_ffe_preset && !dp_is_lttpr_present(link))
+		lt_settings->ffe_preset = &link->forced_dp_ffe_preset;
 	if (overrides->ffe_preset != NULL)
 		lt_settings->ffe_preset = overrides->ffe_preset;
 	/* Override HW lane settings with BIOS forced values if present */
-- 
2.48.1

