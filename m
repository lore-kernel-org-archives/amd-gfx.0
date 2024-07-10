Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9984C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CCBA10E8A9;
	Wed, 10 Jul 2024 19:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BAxXP7uB";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D266810E8A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9e8SsWcfM5fmkm4s/d1KaTWWNjkc6c3+0tZ1XirOwQZh5jfLCkxOQ7ih1KFTb1EVTxNYXR21/dxaJdvTDcKrQ6h18e+4nBc3ET0GgK8AN9qpRzP/HdXSz/xe9sF/owjiZJtbTBJGjyx1bj/TKyDJrXcImZzjQIidFDCK1HeKGvcex7MvuGQ/n5p1ioRV25pk2sXh9IdHOFrwL5Wb95LK9WIpHX4eQpkbCOFO0PUoJtM6fTiZs05tr4SwPmCVTM02+V2yOlKhCwEkyzL+Gzt4yZX9j2y7krVLHbrEUG3w4W6Z3u1eomZI3NTQXJHV/CEtD2vWiyuTBLmrtfIlb88oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnEhx2D9Ej/rVPem/f9mzeU5mtP5OPVt0WFrEgk9LcA=;
 b=WMeRUU8eGXP9wCBfjUOhupfnaqLJps30bDyPpTDJJE/2/Ao1rE4vBiV0cSM5kTe0tlo0pxw/QSpP0B0btJfvc4QkgyZMy9L9Ac6OQiebi72jNufThWLrhkBzAd+2Lwl496rg00Tls5LRN39DtUIDorWx/mrD25aDW+v0tEmw7FQrYGxa4ewAtS85h79MnrVIlyfqehQcVN42zRsqf7a0CiYHVNTTTZZh6KW26XWMUYnHLVoNqeG7fN8h/Yuqs84WslMNshviygSnEClXGjOpIcozmEhRncubqKjuiQ+IOTFSCPjpNqTWvm9JAGzTOE6kSgl7viP8ifcuydPH55oWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnEhx2D9Ej/rVPem/f9mzeU5mtP5OPVt0WFrEgk9LcA=;
 b=BAxXP7uBkvqnqA58RZ9XMvo4QtYT596HFn+ZVkC4xWIG/xByCZGul5qijQ8ViXeUtPV57Ushd+YenIxLmyfVvWHwMT28baV2ffUZReo684YjZvAc9YmKtiGRqFmEp3KGZWJe1aNzGvkQyo6bK8UjlFsW2lERniwQB+n6kLN0dG4=
Received: from BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Wed, 10 Jul
 2024 19:38:13 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::c2) by BLAPR03CA0027.outlook.office365.com
 (2603:10b6:208:32b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21 via Frontend
 Transport; Wed, 10 Jul 2024 19:38:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:38:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:09 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:38:08 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Sridevi Arvindekar <sarvinde@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 12/50] drm/amd/display: Add option to allow transition when
 odm is forced
Date: Wed, 10 Jul 2024 15:36:29 -0400
Message-ID: <20240710193707.43754-13-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 9699f21e-da00-4b46-f60f-08dca117d681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XanrFZeXZqpNl6JlQh6Q/4LAR1u/ER9rlYOjdH+dw51Nf1V2YGqV8NbfwYvW?=
 =?us-ascii?Q?yjjgJ11in4I5vr8kMp86wwKv4Z0knijSCzqg/ixRziuOSmD+Jea5DOFsgKJq?=
 =?us-ascii?Q?OxQ18aHyRFELd2Cr3+49lmi1RSF9A/M65/R3LoWWIGq1VERIsi1XjYDt0a3x?=
 =?us-ascii?Q?Y9JHGl9KWPqctpAVoSXDznhJ5NpL879SkuEfbmHDqiIES8RruLpnpvifgEPU?=
 =?us-ascii?Q?fK0MyaJQMc8NoGoUNlv4erfZ43WcVJs2a1tezUxXRxOCNF2/lO/SEpAZTe49?=
 =?us-ascii?Q?uOzQuh1+3wqFn0GN7jhxm+DT4cSJvRLOYyAEdTrfp59gBOiTuF3zwFc3nXJ1?=
 =?us-ascii?Q?WSq4eKRWqways36KwkRMLrEnC82rD/MJdQOPq4tsXHcoxqwQgr6W1BEWiMV+?=
 =?us-ascii?Q?o35F4eT+0ByEFBMvC3iJls9qNW6tQHivwSgbXJBoE99O5BV+FVI9UZpsoihf?=
 =?us-ascii?Q?H7i1+MhMmRhgEJ5V13IsN4b8PhfJs4xZrZt7iK+f6ezVqwituKwXUF9VLNY8?=
 =?us-ascii?Q?Mhj+Liq5svkTTYEsQK4G7SvjAsn4KKBpIXNZzknug5LIn0K+/09a1nC4gkIY?=
 =?us-ascii?Q?HjTsCfAIitjzGN00nJajO/VO5V6ugohLDz8cZqbPr2CbPjxrePc335ivNLoa?=
 =?us-ascii?Q?4Z0fFRB9SxVfDxq+EcPQx0VnJxA6zQ8q6Jmtg2CI8KGvMGtua8BdqfQX6oEY?=
 =?us-ascii?Q?RO1kLK44bYwdpxBMDEycOfpY+lYf7tz21gAntgABOlHh7LO3YkfexS5uvofD?=
 =?us-ascii?Q?YZBkegLQ9kFsifTX19QqI4TKBWd2oejHbtPHHmEy9FSyJaU6fyqVtYdLS7Sv?=
 =?us-ascii?Q?Tkw0LKF/F7wOomo1QL+ELe8aCO7KIuE6Ag+dRJ6xK6McV7S22jLCdfAj2G6E?=
 =?us-ascii?Q?n1KIrYRZ8Zo2znOblibVKI/GD/9tDK24z4/dhRCibyrSjraqT6RkbagS52BE?=
 =?us-ascii?Q?hj3CnNpfUgWW2ggiSmq1Ip11ZxHqo0P/aCy3ihJM/kj9e5aQC6bLK2sS0mGU?=
 =?us-ascii?Q?2DgEE7mNTEARLgfupSE2fBNmOfpOoqgF/3j5d/0GIdlnlmVmJ8HYgqWLXGx5?=
 =?us-ascii?Q?ihjnI+YBtoZDiyr3dmSj45tyg6lHhVXcUUFtPyRnTICW6QMqkpezDCqzvX3Q?=
 =?us-ascii?Q?Tf4Kcw6//vpVZK87sFDbiiYb3BFtA12jssKWrxufjiVFb1TIHc7wT/hj5hoT?=
 =?us-ascii?Q?vm4Jj2rC//ruCV2J2irAebGYXpl/FWfE30wTeGeZ7PXavSaJ3iAE63nLLXfy?=
 =?us-ascii?Q?rsqqPAfabjhuIclTAB+OJBjGc/TbuXZqm6J6Gj8ozri4ExHgrkNv/lpB04kN?=
 =?us-ascii?Q?3iEejdnAQqaH/4fhubf2yXrKUmQ7gSlEGrKPlENcp5o+KfP1Pz12ShqaQmyt?=
 =?us-ascii?Q?z7mHmg9RH3nl3dn0qapsWBxzRSfz8sobMXsw3oV4DykpAqMLHuAXwcWlStN7?=
 =?us-ascii?Q?7Jt4aI2ZN1r/lSp14TE1b4gzj6zsYbWb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:38:13.2428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9699f21e-da00-4b46-f60f-08dca117d681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
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

From: Sridevi Arvindekar <sarvinde@amd.com>

Added option to allow transition for forced odm.
Add the variation to the nightly run.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Sridevi Arvindekar <sarvinde@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c   | 3 ++-
 drivers/gpu/drm/amd/display/dc/dc_stream.h | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 387b392f4c0d..c35029c65223 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4338,7 +4338,8 @@ static void backup_and_set_minimal_pipe_split_policy(struct dc *dc,
 	dc->debug.force_disable_subvp = true;
 	for (i = 0; i < context->stream_count; i++) {
 		policy->force_odm[i] = context->streams[i]->debug.force_odm_combine_segments;
-		context->streams[i]->debug.force_odm_combine_segments = 0;
+		if (context->streams[i]->debug.allow_transition_for_forced_odm)
+			context->streams[i]->debug.force_odm_combine_segments = 0;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 8ebd7e9e776e..3d9ee4da7056 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -159,6 +159,12 @@ struct test_pattern {
 
 struct dc_stream_debug_options {
 	char force_odm_combine_segments;
+	/*
+	 * When force_odm_combine_segments is non zero, allow dc to
+	 * temporarily transition to ODM bypass when minimal transition state
+	 * is required to prevent visual glitches showing on the screen
+	 */
+	char allow_transition_for_forced_odm;
 };
 
 #define LUMINANCE_DATA_TABLE_SIZE 10
-- 
2.34.1

