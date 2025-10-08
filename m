Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82637CCD184
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC55A10E8AA;
	Wed,  8 Oct 2025 18:49:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4gHLVRcF";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013010.outbound.protection.outlook.com
 [40.93.196.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4174910E8A2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBcHEEqCdX3goIoDBwhGzP85xkNOqVa82kpBUJ/TQsmOeH19CsR+cQ/lo1ZlbLCfDywr8WL9N/ymQ/eSLDhlyQ7v/VLFjXtXmVXPvWQ8ATheaw0cP/wIxmNugrF1Hr8UTEk94xY3oVgcBBLAtMGUwi5yo22HXHu12cvfjszXaLxyWIzAR1D2le/wncpaQUi/GCjh5D7Q65kozbibRnsUHET71INmsrVyNo97TJ66/VRUMjGNzgAstB0oRtGe4yHK9f0bAaOyjh/U4DHRziDL9/ERHoAefpDrcjnPopyaD5m9/FVWiEoYw0TePfiH3IUvu9JW9rxdIfZHShrO1E2KKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t/UUGRY+AiirkIPzqspn73JpBnr9HicMKikIYQCB40=;
 b=Yv8ME/65+qFvDkbxKMBw+g8beFdBWrgBXTMpQV3vds2OWctGECatkVixePOSmlkyS/SiSR4341BsdkyXpV7SFnVgVR6oWlo6Inau5fPY8DN8vYZcmuL+lFzuNMd5dWefIeeWD+caPalItIVA73kqUENDS4L410rVIee2ZFnPPEqVBnZRqc3Hz1hH9uUHuEb1bq1ekAk3w9M0nKUGmrHk+40uB7b1kCf9/D9ixxRls9F0sMWZgoCGWL28nI8sziXJDWooWJpOni9wS3i45LnHRhEScrfXU+tsRla493K+iWNYx6hoggufsPqLMbsjkYXZZWGr+g9mSR9/oKGd+3Dgpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+t/UUGRY+AiirkIPzqspn73JpBnr9HicMKikIYQCB40=;
 b=4gHLVRcFFFDkblRUPvHzqlB/T40Lz/LRJA7qSq/cw05VH2VWdrrQ7c4jKkHQuaLa6v0gkQGHz0QLY2whukVVs/fyyb8G8riYyauuEP8pYPXR6mTTUnOHjDWT7vqkEMc3EwAbBB/kyinVkvs+y3cuemchlLuDlPx0utQRCbW2p20=
Received: from BY5PR17CA0014.namprd17.prod.outlook.com (2603:10b6:a03:1b8::27)
 by LV8PR12MB9184.namprd12.prod.outlook.com (2603:10b6:408:18f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 18:48:59 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::38) by BY5PR17CA0014.outlook.office365.com
 (2603:10b6:a03:1b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 18:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 18:48:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:44 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:44 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:43 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Yihan Zhu
 <yihan.zhu@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 06/22] drm/amd/display: add dccg dfs mask def
Date: Wed, 8 Oct 2025 14:47:00 -0400
Message-ID: <20251008184839.78916-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|LV8PR12MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: 330ddcdc-315e-4aed-f159-08de069b5764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6JeXolrnsMF+cB1NOalsmttiDNyD4HWRNE4MDd+xTd4XqkWQRaMK1cJF5lAc?=
 =?us-ascii?Q?XKwHzW4I798Zo7zfn7t1Mhbh7Dht1QMhUuZSL2yV5dUUb+QigOX6T8MKx1rl?=
 =?us-ascii?Q?dulQjEIV22I//vCfJPQzAvXtZ5gXljczYM5lN/BQ/qMZhD2NQcS+23qwJ2lm?=
 =?us-ascii?Q?L1I5AEu9l0yCEQSBeTKLAoYldrzJmAeCLM4akkHsIxoUnPzwqT9y+xDcdeT/?=
 =?us-ascii?Q?T3d3oL0QoGV40M8TvacLKcUN8NSGOgxPBWQNFKR6lJargryvl+ZugP6jNcTV?=
 =?us-ascii?Q?a7ztPBpUwTeszWuAnnBfR1uP/SURM3hsCTi7yR4ij/8nJXxQFvpr9O1b5/05?=
 =?us-ascii?Q?AGeDuG88e3zlir8m5puS59zK2rLiXdV7Ho5vUP0Qj0Cz5x3u7jqTxNjLVNOp?=
 =?us-ascii?Q?/H2mp5TwX78M/CqYCFBk7+Ss67iSwwBOxJRCFqPaeBDEKBoNAxjKM5AOwC7P?=
 =?us-ascii?Q?k9lq1vf4C2nXh4lSv9H8NVFo2YvrUVaBLRHJXftL+x0EezToH113EhbLbHVQ?=
 =?us-ascii?Q?23aekE+Har5mld783W9y5pv8zYjKR12EvMIEqT8gUY2p1y1iK4YY9HY3oJuk?=
 =?us-ascii?Q?yVX+hvHATUnZuCHJPam7DT1OozsMZmtUjNS42nfPnq2GHCJmNmRPQQELJ1Vi?=
 =?us-ascii?Q?wt/b7W1Ebd8nS5FL+J8ANGk9kU9ZYx7ZQUoE7Rbylh9WOVDVv5XGgP7F5qJQ?=
 =?us-ascii?Q?SKjrIhR2F3FhCy/x0poi4AdQhaeFgh1LFADYevTveLKIUlC6bw4xcgl1gs38?=
 =?us-ascii?Q?7dARyLOv11FtetVsOerIJJ3MrEJwqsQoLVOtEMHp+6NrLyYbEHjszk1Q2pdq?=
 =?us-ascii?Q?I7xsSv6XWpx6k29NQnAdZn4Ur+IeLQ4MCzSV2umQqH78VjoF0TvIuWQen/b2?=
 =?us-ascii?Q?cAj/GrVjAJvQyR4qPxQEDGlAwZEBvXePOw5WCUQO/XHzPOjlb2aG3jUbvloX?=
 =?us-ascii?Q?E8vjHMd7/845PWN+Q0nZOU9Lxf/eCs56sxLdNexXDiFSTxnDrIFqBZEeSUqC?=
 =?us-ascii?Q?54iagvtMaDvBuliT8yTqXmyhF91Nzg+Ld1CtowvFCOaA2cgSwDOZylBxNl6F?=
 =?us-ascii?Q?2YNUhvZ5M2zy6mClqaZvVQ3eXMULwtJxFYSVdcttoJXIbqOACDadIISCWFh6?=
 =?us-ascii?Q?Zk/bjT7fP+JsNLd8UsV1mXQ2gTX+FnzopHPDpdQ8Ct4s4gdtC190hvBhVcQf?=
 =?us-ascii?Q?e6k4tVNEe3uOxAJozhl6pXmNtM/4qT4lqYB3bHWJMrU3g66shfjpkXteAZSh?=
 =?us-ascii?Q?Tv0wQmyb/bjFU2CKNlP9pZXUgc/ZLKg3TmcwjY7X5DRRQqAqIheUdbHmvqDu?=
 =?us-ascii?Q?4Nmehbc0GTYh3uOmMnbNE+0yonPfLOk7WLMZHrrbUfFCq1lWcPtPnGLf5h5y?=
 =?us-ascii?Q?VlzMuGL1EHPZXFF8bl+HuiF7WoXYh2S4zlI5rGkc4T9zdVOxiycIp6yvrall?=
 =?us-ascii?Q?fmFb/q1pZ4DfLyCCcqjm/PJQ0faBDZhuCNIDSU1GiV+B/VuT9u86X9rz6kIy?=
 =?us-ascii?Q?AcZUyfAJ8sppHMcm6MhZ9PG747rm5comPmCRIgZrQfKVuHDWTqMKi08RtB9W?=
 =?us-ascii?Q?ymcGLnjvEwVkZyet0gg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:48:58.7789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 330ddcdc-315e-4aed-f159-08de069b5764
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9184
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
add some register masks for DCCG

Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
index 51f98c5c51c4..ad7a5850d31b 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
@@ -231,6 +231,14 @@
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK1_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK2_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK3_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_STEP_DELAY, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_STEP_SIZE, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_FREQ_RAMP_DONE, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_MAX_ERRDET_CYCLES, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DCCG_FIFO_ERRDET_RESET, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DCCG_FIFO_ERRDET_STATE, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DCCG_FIFO_ERRDET_OVR_EN, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_CHG_FWD_CORR_DISABLE, mask_sh),\
 
 struct dccg *dccg35_create(
 		struct dc_context *ctx,
-- 
2.51.0

