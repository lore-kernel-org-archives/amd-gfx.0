Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBC9C25B7B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9092C10EDAE;
	Thu, 16 May 2024 19:27:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JJYShBti";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B416110EDAD
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAiQDzk7UBfrLEJ26PpS82CyHKVXmXz/JcnA9ef4g97AYpG4U3xPIgSMH5/GYZAvDpQS2yQ4VugdquSKFBqYiXY7vRsicPkPk698iTPl3/xVgKikAv2ia4gxrEYTLLsfNARNMTvz/4YIdWz9wNP3pycr96o9isXJ2G/BCW0viHzK6a1MiplTCtz0K67F1GAPEbV/jngLKdtYLQFKaUkDBfuWGsT4CuGzwWHj8eo1FRmsmeyd8Uke824K66CZtzHUMH5VqGlziSJ6HnT/w5PX3x4Ml4K3DH51LQ90b7KVlMeEaFNDZ2YuLcTTFe88IgOfPOz0cjZp2nMClDYBGv3R9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Phh3Cxy1VMbTLsWzGnxWc7WALrwyxPcn5VDLMZ1ee8=;
 b=gsspRTATmkGAXRJckAv5ISGxODC625E8NNjxnBs8oR1dQ1fojUC+ty51CmSQDcbvFfhIfVF8ByXj4NDU0GwjdmEAjDSWvoaq5njlay6HnpvDlKM+pzJJvhqx4Y4i5BzzK3fSxgeGOAuRibJc26kUvmo6zJOAkQptVU83ZfY7C5BzTvf3Ebi9P/oCCRyuVHDLl/KYBnFRHOjHIAo4F/9YaY7L99IfFUechcvFSxiDll5LUeD/a/GIXGHycurYB8DvcZT27hmVZUzxzrZcbHWDOhfn7t1xyuOsh5dSMYFzsWIEF/UGEMzcCb97Wr2hBAdUHS6q9fM0EePjX9fNfvz4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Phh3Cxy1VMbTLsWzGnxWc7WALrwyxPcn5VDLMZ1ee8=;
 b=JJYShBtiENtS094QtAmBko991MpHnJNuprLH2i0Y80JnDzyGMGlkIH8qZ9nsmzZ+5P1VYIvs+NGgMODdtHe4wOaAgN9RoM1VY7YCoOqRMIdM1n0Vy1PFncw+17xoc5mNlViBWCBYVFUWose1MHq224NM5ISUX2FbOlE3Z+EE5qI=
Received: from BN9PR03CA0266.namprd03.prod.outlook.com (2603:10b6:408:ff::31)
 by PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Thu, 16 May
 2024 19:27:03 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::47) by BN9PR03CA0266.outlook.office365.com
 (2603:10b6:408:ff::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25 via Frontend
 Transport; Thu, 16 May 2024 19:27:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:27:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:00 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:26:59 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 09/24] drm/amd/display: Modify HPO pixel clock programming to
 support DPM
Date: Thu, 16 May 2024 15:26:32 -0400
Message-ID: <20240516192647.1522729-10-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 84270390-91cf-49d2-4e60-08dc75de2a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1/uZJ55SYcF5mj4mSozSozO6hBcZ3eR3Ca4TQ1iy91Xw3gp7bGoFHXNVnrqE?=
 =?us-ascii?Q?iiOHtCjUmmAOjgE5QcIU2FIZ05TarfF+/Dchv0VIJLy3W/6mPbD4DutuDBSo?=
 =?us-ascii?Q?z3JB8PxU45qYHIwoos01KGWhUyXtWj7jv9rTwitvbincGqzUyqrHhubJfXHf?=
 =?us-ascii?Q?Oc9/K+jUbKA39epoTzzknYR0SDs6Zdy2nv7/YNlrvvsAO48QkheXXiLj+Rjo?=
 =?us-ascii?Q?TqeMJWcEpx7wDtfCu9pEARtM2qHugT5Z0HJYTDoHZOM238mIIc8pApDiNF5s?=
 =?us-ascii?Q?3yxQIfcqwtCTyXWeTVFyQxx13LR87U0azRysW3niHH7sBDF8IuI7EB7VYLX8?=
 =?us-ascii?Q?NoLcD4dDwHI+Vff+5hoJ682ub5Yk3NB/hmgzg7YL0y36k7yIWcrcoG4N4TTC?=
 =?us-ascii?Q?txrqFuMTtLzlQ9kyIPFl21gvE5Po4VSt3VXLYfMgEvuyffPEHybPpclT5UYO?=
 =?us-ascii?Q?G6KmM1Jhlc6Q6B0jNRZoi19gR3zfXkv+d96B9/uWIJ9TcrlvAc5MjGIevy6L?=
 =?us-ascii?Q?LaDTKkHAKBDIy9x8WYfNgDlpqB70GZdwL7I+aTxcB2HcrVEd7iSo0blqCDMq?=
 =?us-ascii?Q?lfMHBrz0WkCJys6BmxZtfQMvo6WlqCcqhjnVX45z/r9nQJISgJ/EqmKEKdXo?=
 =?us-ascii?Q?yKqEwsgRtboTq+PXjq90KB21HycHdHy1ZbYxV1I2SLj2Y9VPQo9GNwoUNFiH?=
 =?us-ascii?Q?dzBFxqeR8GBUuIzkvFMt3noOhQ2LD8PZI//nLJgtLa4uIrFoXf4T+yGqAxSx?=
 =?us-ascii?Q?KiGhVW/Oly+2E/u9qjHrjDKp1nFUlQP2Xg3xPtCnmmeLhHM2QeeF0bCpgQFg?=
 =?us-ascii?Q?CYNX3AnPvAvgWkD4SYp0anZD5UVp4tPdaf7nc60Fh7SqHHgavPKC5vQnojm2?=
 =?us-ascii?Q?2WYifUtuBKFcHPuVFXR8VfDDsqVmV7oJn3uPu6wqYwHqVqLN5bRf5jp5LPaJ?=
 =?us-ascii?Q?Bmgin74kr0VEmg8NS6eW7u3dhyVbAtN0/hDvNwyQbHQFxTUG9Wq4P7u1eKcd?=
 =?us-ascii?Q?IZ6lct+TG6+W/qaoWEszn/57bT1npHpwGT39vby6IpYDk0Ku2JLvis3z8je9?=
 =?us-ascii?Q?H3CdmGEY401aX9k+2n2tJsQQX0WsqUIxJdr5lVa5RUcBxtht0bKPojkSgYyu?=
 =?us-ascii?Q?6w/b0GVn5noGJ4jCH9FKnD8QzTFAhZ29wH7BVfNBhNEEsuHj9Sd6hBiMFv30?=
 =?us-ascii?Q?w5D0bC3LcsjFVe4R2jaFGijZfDdmAYya9V2RxN1OZLkJG6S4nY/jEi+azGtf?=
 =?us-ascii?Q?h0rPKLcuZ1g00bSE2XCnngBuUxVL/jhGKBqOt+JpsBllKKJQXli3pmova/1e?=
 =?us-ascii?Q?Va1ABWpSujK8CGB1AryCWq0UElZ6WDcIBLCjNiBX5I9P0UQYdx4PeyrZVZk0?=
 =?us-ascii?Q?zzyFy38=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:27:03.2001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84270390-91cf-49d2-4e60-08dc75de2a4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326
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

From: Dillon Varone <dillon.varone@amd.com>

Need to select DTBCLK and DPREFCLK as DTBCLK_p source according to
hardware guidance.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index f39700832639..63deb5b60548 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1082,11 +1082,11 @@ static bool dcn401_program_pix_clk(
 
 	// all but TMDS gets Driver to program DP_DTO without calling VBIOS Command table
 	if (!dc_is_tmds_signal(pix_clk_params->signal_type)) {
-		long long ref_dtbclk_khz = clock_source->ctx->dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(clock_source->ctx->dc->clk_mgr);
-		long long dprefclk_khz = clock_source->ctx->dc->clk_mgr->dprefclk_khz;
 		long long dtbclk_p_src_clk_khz;
-		/* if signal is DP132B128B dtbclk_p_src is DTBCLK else DPREFCLK */
-		dtbclk_p_src_clk_khz = encoding == DP_128b_132b_ENCODING ? ref_dtbclk_khz : dprefclk_khz;
+
+		dtbclk_p_src_clk_khz = clock_source->ctx->dc->clk_mgr->dprefclk_khz;
+		dto_params.clk_src = DPREFCLK;
+
 		if (e) {
 			dto_params.pixclk_hz = e->target_pixel_rate_khz * e->mult_factor;
 			dto_params.refclk_hz = dtbclk_p_src_clk_khz * e->div_factor;
-- 
2.34.1

