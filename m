Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58275C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C9B10E8C3;
	Wed, 10 Jul 2024 19:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EKoiLPaO";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E481A10E8C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JniBLgtPYtTF2Ks4hJpqKFRx69CMcwM6D3KPTQrMGNImZXi7EFbzSODXqcyVYrLKlQmb+DFAt9aXrHPhyYmyDJGC6fYKypY2QFE6+BGeCrLHKXoIN25epQqfOgbTQYx+4BPE8H5mgTzMqzLFWf0c1uQyXiOtPjaJtPmTOG9Mo3J5N9y8T/FqfuAKei/UtolJ0ME5wTMESbcQbT79ViEa3hPjVL8vT7scGGexHFTWHaWn6vmvZg1t42P8u0DHayd6SByeA5aIpGsrQOJ2862vNZj31Q2Htz5/t9EvGGRqLTpxRbLytHMPhTcEoVPYu3jCUli9y9tb6geT9PhR/egZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbubEbc4/fq0rGkWcyr0DSBn5ALTfVNNEnjoNc2NJmE=;
 b=Pupw/UMWgNbwXmkD/0DVp3CzEOC5NnLb100daL2pZuTp8wR4oM4ITSZT5KjinWEgr1S0K72oO72Amfc8f0LasbAN5Ea42ZI11xyZlIdxHB1nv9FL8RdJUCNdzMkcYimMv+fJQmxkiGjDEL1R+ITSzcXhmP1dvwLr5mqlEkc1dc1TXo8QEFOwcIRJ+U08ZG93SAmyw+s3VTvFAUBsVtn56XtxCdw/H0xCE/Im+6cP2b3SAdO5O13o2V4lYfbMuBeJPeT9a4XnQhJpezYHybzsEyiMbKf+O9HnvLK575qKzRHkOHnCSe7kdVPemkxiwOgDlCckuWZYD72qdzXJxTyTbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbubEbc4/fq0rGkWcyr0DSBn5ALTfVNNEnjoNc2NJmE=;
 b=EKoiLPaOZJiCYv54BAgsbh44+XjUVA7AEdNYy5Z/23OpGDmW6l7Sad4zI0P9uZLCEML6Xw50O9hU3F0bAAAuczpMKJOi4Mbqni6Yfwov2iM3giI0daIhKBoMt5zeiPqxH/K6hRlkUJFHHQP04F84gRZ4HIb9CSKkbXujy4jZudA=
Received: from MN2PR08CA0019.namprd08.prod.outlook.com (2603:10b6:208:239::24)
 by CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Wed, 10 Jul
 2024 19:39:49 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::8f) by MN2PR08CA0019.outlook.office365.com
 (2603:10b6:208:239::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:39:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:47 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:39:42 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 35/50] drm/amd/display: Check link_res->hpo_dp_link_enc before
 using it
Date: Wed, 10 Jul 2024 15:36:52 -0400
Message-ID: <20240710193707.43754-36-Jerry.Zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CY5PR12MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: e6bbfd98-1814-4955-9d1f-08dca1180f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aDUJroi+3YtIgl6YUHgyIhi5x9W75K6d4ChcSqtyZrm2C7GdA2EA6gA6OoRY?=
 =?us-ascii?Q?tfeobSJ2HEQ2Td8RhpgHsxshMCqbV15N+8SR5H5NwBSkmqkbCnjDBzSKRoht?=
 =?us-ascii?Q?BNoO3TSCcDkFGfGrZTJj8sYZlAF+8TDqkL3si0D4pea3O0WqbA3IAl/gtRda?=
 =?us-ascii?Q?N3bF/JlaPuZD5wA4b/zv19/EHlEcvnVh4T+naFVQ8wLjjhg6zfKmCqQQtCGS?=
 =?us-ascii?Q?wuWvsg0A5qAbKMK9hBifhj3xnHF6bU6EaDACeSv8XomUkITNVddRLSh7efAQ?=
 =?us-ascii?Q?Sh6ZEIZRkySkbqdrGWgIXqmm9wk57mo7UovcCkiTzdof3mzwGsqyGVzLc1K1?=
 =?us-ascii?Q?joSWCkF+4wvN+e8GuZZ70TFlSFCDUShFQsNmBWmZF04qBfuNqoyNwbdgPepi?=
 =?us-ascii?Q?E8io2ZRr8RmLa0wBD6mXZeU/vWRetWvR4cIVeqmX1PXn/JVbmQjA5MSi6X2D?=
 =?us-ascii?Q?GW37QdA5wzJ71mSSPcr9hX7406IJObgCvYogi1DE0sM1u6nu/3MnCJYkm+t4?=
 =?us-ascii?Q?hlxrC/Nzd83p2iaUzQZY5EjfyHhW92f2tDmdBiD4P+y5pFkkKkVqs0hAQUxU?=
 =?us-ascii?Q?qUjxXFA0r9Wd6cgNhmsZNnVuvtVGYTtFqq5r6FiPHShsG57Cd0z2hqNeIJX3?=
 =?us-ascii?Q?ID6YEinm6BHgs7YMarb4Tq+SWRcEZpk535ZZy8lto1xclUbRCHb7XdKNmsg7?=
 =?us-ascii?Q?vFdFpYPNbs/AUczaZqCAC4du2gsBTZ7YhyqiEVK3RpwazXStjmjfO3lqGeTD?=
 =?us-ascii?Q?U9PnmOt2cfrB2YclAtz7aE9c3W7+0tFT9fsMbyPaY2OaWZ7i2JJdjDUuvdPB?=
 =?us-ascii?Q?b+VRpaDWcqPOgg9j+eEw+C/tL++6abXiTrxwoGhJbJSPIRULFSOOBpP2LtPh?=
 =?us-ascii?Q?+dk9fi2icvoboA8xbRZhzOAQuweQAGTVKBfyAxT1Vv1kZpZdfIrB+bV/rowq?=
 =?us-ascii?Q?NNPVZLzUPyQv41wn3KJ/yML8dnEq/cT1U8OVocMfE4+1gU5+WLk4vy7qDE1t?=
 =?us-ascii?Q?J9X0YTG3fCkU35k0yjuykDk4OlPBfBs/9DWmG2oCs6fsSWAq1DMQFM5OZ+sb?=
 =?us-ascii?Q?Bqj9iV8s/J2Va1FNPbq86PbeTyypSI3VOl7JowfiFW7NkUFjnuy3h/VBAGUZ?=
 =?us-ascii?Q?lvj/pjr57DZK6r3agGX1QMgLFxfoPsnASsUVg+o3hRX8zMl9fMmohgFusCY8?=
 =?us-ascii?Q?wyhyFqAvPKffymcjgDJQQSR2c8SpmzN5TSP6xk3VYPNnYvwPgXaA2palF7dj?=
 =?us-ascii?Q?zHEHR4tzagSNVPAs+Mcyv4qEMk3qXSv6fcEOAIrFt+PFx5L1PxDM2wEzz46o?=
 =?us-ascii?Q?svsw/HxLQc11d3mKQQmbzPROe8yeOWEsQSAkg5gAjw0CfxN/MnR0BaIQCfOk?=
 =?us-ascii?Q?DZ8cCV5TBcuCg1wWF8+elsAeBhuUmPzvtErbTRYCKePZ4Lg7CcMQXBhsp6Ul?=
 =?us-ascii?Q?BI5K+SINH6YqJMnJl1ykIy8jXVpU4fK+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:39:48.7381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bbfd98-1814-4955-9d1f-08dca1180f68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646
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

[WHAT & HOW]
Functions dp_enable_link_phy and dp_disable_link_phy can pass link_res
without initializing hpo_dp_link_enc and it is necessary to check for
null before dereferencing.

This fixes 2 FORWARD_NULL issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
index e1257404357b..d0148f10dfc0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
@@ -28,6 +28,8 @@
 #include "dccg.h"
 #include "clk_mgr.h"
 
+#define DC_LOGGER link->ctx->logger
+
 void set_hpo_dp_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 		struct fixed31_32 throttled_vcp_size)
 {
@@ -124,6 +126,11 @@ void disable_hpo_dp_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal)
 {
+	if (!link_res->hpo_dp_link_enc) {
+		DC_LOG_ERROR("%s: invalid hpo_dp_link_enc\n", __func__);
+		return;
+	}
+
 		link_res->hpo_dp_link_enc->funcs->link_disable(link_res->hpo_dp_link_enc);
 		link_res->hpo_dp_link_enc->funcs->disable_link_phy(
 				link_res->hpo_dp_link_enc, signal);
-- 
2.34.1

