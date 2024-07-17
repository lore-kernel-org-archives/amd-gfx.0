Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A03C3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B38E410E3BD;
	Wed, 17 Jul 2024 19:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="19x39aEn";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFCE610E3BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkDxnsvJzrnpEFSLKy3+4OhO+PQ1Gd8zabSTNcPJzI0H3trEivHfmqP402G0Srd5R8ScknyxrB9vWesVaMRt4vZtMlx5rm6NSD7d0c7+lOS5fhHbqQxlmWSgqEhLmw23YoQAM8g3sHw8gGq2hUEIbBIeozIUBP5CeZT4hYMTRV13/jlEgZMpWvFUayvNz/5/T1w1u/nqJeX9c0p/LfYcyk3bFCEckfrjW+s8+UiLowcNJTlVvBB0uFuzZNozjBJJVuohDw59MJeUH7RUrXKg16IyP8qwy8Lx2L9yc12MftvH/aQSnhuv7ias46OVkObZmY+hfeL+MBfzT4bExklsVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwGggXfi7eo20z1IDV01zFKh3xuFZKgB23hfqhoU3Oc=;
 b=xPTxcE+KkB1GCkXi3FoB7BMJrGW5Ih33lPaiYLJOzJSL3BW+vi2RyL+cNeVBjdSFhOuJrZ8CZwBYvNU2tY9rlQEDBaLL3IE2+js2jnQ1lJvEcpzI/8s0+fhgWV1E35gzKqK7Axjbrk+hV+6RTpL/Pzya4cl2lyxCoUYUSGLKv970C/39wQGzgYXRA0rXcScCXlTUKYyRmWj8zHSjYdGrrkXzmUkdCCJLoCgTm2M5jB++HtgsEQxQANDOc0GnY5+u4B/JgTaHOMcN4xA7oGvDERU8Y9rka21tkvF0k2JSeITd9QybDCx7tn7W8FWQOuGsAdEma9Gg4aqQeG88qON6rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwGggXfi7eo20z1IDV01zFKh3xuFZKgB23hfqhoU3Oc=;
 b=19x39aEng8BlY6jIysm4qJysy5xKsfpjeLHe4md/xV0FsPrqtKnOwPDOyCTZ4KXtOGqqPD8K4jfCmoTclzTn7dhSCN6zKSSO+VteWcyFq88Dbnx3jQrqEESOQAOBDe37Ry2MewSrmOeYe9FkvERheEOKwCuopStwB/RcPxukds8=
Received: from DM6PR07CA0131.namprd07.prod.outlook.com (2603:10b6:5:330::19)
 by CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 19:41:01 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::c2) by DM6PR07CA0131.outlook.office365.com
 (2603:10b6:5:330::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Wed, 17 Jul 2024 19:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:41:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:41:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:41:00 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:40:50 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 16/22] drm/amd/display: Add MST debug message when link
 detection fails
Date: Wed, 17 Jul 2024 19:38:55 +0000
Message-ID: <20240717193901.8821-17-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b44ad70-b779-4ea6-958a-08dca6986380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cRVtJu1A95UatzjdG85n+zdoy340Gllt0DpfMoTXHETi8JBF9yPWGQXjTjdL?=
 =?us-ascii?Q?W5kpUJC8MANLoA1HBVr7otYNyzOJEcb4iI6mMMNhzHf/rTMAnrlaP3T+OiiR?=
 =?us-ascii?Q?Fx9l+GK9JZFVn6KHnEWLkLA67BRA8xe+pMY2YM/C/0oV/m5ExWujLJH9Iq6H?=
 =?us-ascii?Q?fwE9n6hjRlzal/gpjZtgt1/QJ7tkBgxbK+/iU7XldT7m2ojTTh9tGFxfru8s?=
 =?us-ascii?Q?u/Csa8qjPuZu7Yr0fJ7oPPYGFpizC7RGBwmNm5vRye6GTynbFuJFBS6BSEMK?=
 =?us-ascii?Q?KeaHNK4UhBJMd7wiDG2cFsAXLZkRqtmw+AqiSeqKCM63PS0zyGvBoK3yX+3L?=
 =?us-ascii?Q?9Ntn08yQMa/tBBupf0ydMcmiMBOh24QITfzGiSxiqFmcD7viTywZ0YWWYhAe?=
 =?us-ascii?Q?g3ilFhztmTtpXkiH3UGjz9GX+J3O2CWoSkOY6omtbMA5oSN/9kNrbtERWOjC?=
 =?us-ascii?Q?ujHs0nsqT1BSOGJnTKZFDmfU2/Tl/a3tMWN/MxW7T6W3R2OhVPzndzUIKIXF?=
 =?us-ascii?Q?9vAfEe+8MBjs3xKoeW+sgV1FTGlfuiZmT75cvIuGBqCpuD+xk2hhrHHaNtvU?=
 =?us-ascii?Q?JNHFyaVpQroVGG9F9JHwLjCadoNPkQildkdROh1p03VMT2dA2DxpLk2wOUEO?=
 =?us-ascii?Q?/hm0DFkCuxTLQzvZQzdORtKg1eXbGfdBlllc7tIkEYpekPCrC4xVFagYweQ/?=
 =?us-ascii?Q?BjsEaMBvPu/aiVxOx6Qzq8Wv0/lSPWRc6ZM3ldt9kABCVuLIi467VZuht2Wq?=
 =?us-ascii?Q?AeBZCk881bIxP6xvylz79R3joHTSf19dglp9NNzMw+Nw5zuBNw37Cyxej4/j?=
 =?us-ascii?Q?/S9fahFSQcOrQck71Fw7RDaW4mGUWXdh+iVEg97ZCEXV9DWRBPnvk+2Mlb1k?=
 =?us-ascii?Q?YQJI13pICKXic85o0HGJ5KDXwZhTc5TjjLzj9IyisBbFGQB6R8RLQuGAw/6Y?=
 =?us-ascii?Q?WLcCnBvaOYKfwHC7CNeYyNQYJoe3J4aox8GNp9wbDVqLQJ8Z6k/3K9Pm9T8w?=
 =?us-ascii?Q?f2UNaaSgiroom9ohwjD0EVAl8QlberYx5TvOa7ZCASNBbteb0RqO0XWQLjPm?=
 =?us-ascii?Q?NnwApUwQDKZIeXIgQ7wBLhhuEv6VK/akdN9xhzs8LhHb/FLBc2PNQ/pmA0nC?=
 =?us-ascii?Q?xfP2s2QCn7eMKj+vSCBP5RUR0qEbTv0D/2W0FaID9QwZ01ClEgSbsMj8sqsf?=
 =?us-ascii?Q?IP+bik3LbPel8hLCItuidq9rL250YEk5U/DwDIc//QQ8UdVHgoAD3TVt6RKj?=
 =?us-ascii?Q?9poBT8z5+MBvSCPlHwW5+Z3leQtLkdJlwZVEhtowrfEmIfVCm1qVcYct1m8K?=
 =?us-ascii?Q?lCezW6g8yRi2v4Yr3VHWXzSRrIkXA+FVX5J+BelGbTrLTK9jYu/bpzLyE3Ur?=
 =?us-ascii?Q?P5PlsvcHGbkdOjp02Z/Er/GmDQaNxbQEkdayItmJw/kXHHC/Dyr8rj8/K8kb?=
 =?us-ascii?Q?s3ro4gynFxQ0sQChWwqJIfx4LjyRgbNH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:41:01.3441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b44ad70-b779-4ea6-958a-08dca6986380
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546
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

From: Alex Hung <alex.hung@amd.com>

[WHY & HOW]
dc_link_detect returns a boolean value which can be used to print debug
messages when it fails.

This fixes 1 CHECKED_RETURN issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 62cb59f00929..db56b0aa5454 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3804,9 +3804,12 @@ static int trigger_hpd_mst_set(void *data, u64 val)
 			if (aconnector->dc_link->type == dc_connection_mst_branch &&
 			    aconnector->mst_mgr.aux) {
 				mutex_lock(&adev->dm.dc_lock);
-				dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
+				ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
 				mutex_unlock(&adev->dm.dc_lock);
 
+				if (!ret)
+					DRM_ERROR("DM_MST: Failed to detect dc link!");
+
 				ret = drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, true);
 				if (ret < 0)
 					DRM_ERROR("DM_MST: Failed to set the device into MST mode!");
-- 
2.39.2

