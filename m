Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE38C982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 16:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB14F10E02B;
	Tue, 22 Sep 2026 16:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="la94bd2A";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E038510E02B
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 16:15:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yun8OgfxIOGBxWMruDIoIuM7umBop2wNPbf3I9u+yGfXncCWRIfX642KLVOwj0drhwdnkqNX36gIbA2zUlr+quYIwv1OUJEgn+aqCfcKIzdFIlNoD29HNDtmtesfd9voZn90MfuJQfwGGKy4WVcCyx54ZIbeeFEyyiuHhbQfR29GXABhukoSB5boQVRlnnzIg9MizLndTUBcP1IRVOJJiQX9i7qNFh1pxqRDQbDOoxsH20VDvpCxFFKqbNAGN34ugP2jCS/OQJXFysrKApcZGHCrpN9IUFiPZXYoin0IUbcyjMh1Yy0Dpb4b8VLI1aFc99+CtA+NsnPeixfBLcFu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3o3+RcjWKznG5eUi12LUsIkNBCAWFpWAWGsXrK38XZA=;
 b=upJ4ZiRE0I8UEODGkTXLCHjRN2q/0OrojhjgBQoBx2hfgz72IvItTFRuHAuNBcx4y1m9JWAcfsPEeI6Qsgs/gqFpz3Hck5dni+Jcbzfei+R/hrQjeoTJaYlXmqW63nWOO4QtMZQY3Q11L1uZIT9oJ/KDg8c4fxrPU1hTlrJz64P7nO2+bOqIM6R73JQmUTrASiQ2Dc/WgcSei8pGOg6bOiw6MNi1/MmSSyQmoKnSIm6yIlo/2SDWzUypPNDeTvukCuXb8DH8KcnvYyf2cLNPCtCGe0tyS7jOlvExzRGAucQb0Z5m9NwjsumQilgxHRkeCDE7xTZkNU9zcfqQDpqv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3o3+RcjWKznG5eUi12LUsIkNBCAWFpWAWGsXrK38XZA=;
 b=la94bd2ArOJIDDoKU3Prfd9kS4So6THoj2UPlh3nsitJix3F4ryY92Pz52p46fpDprQk9MklmsABSAY/sPfCnJgKbwPEUxLwZj+IZrLM5xEFetJpDXjD1Dm6fJ2VbM1OEPnLU9yMfkABkYJhg8uK65IMSMuZD0NMrdAVllAZayQ=
Received: from MN2PR22CA0016.namprd22.prod.outlook.com (2603:10b6:208:238::21)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 16:15:39 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::28) by MN2PR22CA0016.outlook.office365.com
 (2603:10b6:208:238::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 16:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 16:15:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 11:15:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 11:15:38 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 11:15:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Horatio Zhang
 <hongkun.zhang@amd.com>, <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: drop userq callback assignment for sdma 7.1
Date: Tue, 22 Sep 2026 12:15:29 -0400
Message-ID: <20260922161529.2179060-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dee7c55-52dc-4cc7-cd90-08df18c4be2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|10067099003|11063799006|7136999003|6133799003|18002099003|56012099006|11062099010;
X-Microsoft-Antispam-Message-Info: MgwyYD4+Cpqlva9GZDZiVDNhmeFzvX34m4XQFaVuZ7WOH7vFAkU+PU5RiWY7o6dMv0/whSDVFsVHurgf+c5aJ5Jgs2QmBpPBSTXqREFba1XFvpMyPlE1MDydSMIr6Ln9YudDA4xgaHWW5tiKq8ekNuXaTrc303R5rCdfnu5VXZIri/5LkXaJGxlrbtn53I646KoPVpWyIPLksxMPnqOo9sR2sOP1xig+sKyrJgXfU966l5BmbJeXRszUyAGXY2fjgBDb5RFHgavizcm5p9ZD2PVYmo7ygD1fsUFD9pOcq8m6abkxRu8fOerksOrnhHFDxK5DWFPvF8kIjmJTuINro+ez0Y916g/GNEJnmTpc+/GcLgAZ1+GJyH3+jUAoUSCkCusomjrSBLUMyoC6o2yWUCQAJZHlnsOrcTpTzkCswQoi08lVHZGI46dty7q7GXF2K6FplhmU7eHbVUA2KIpmkKqPrbnVEKPDmxXBQo2ltvolPkDqW76gQL/aOYdfCHyJtPgXKyxpybmuVC6KPFGCXEfM2Jj8lZ3phI2pbmuoDzcOm1l6oA+ODUnf2GnNobou+jX0gzNrkSGCNIeCbXBWXQ6L1exrF71Y+bCTqOfxfjc+V6wv0es57Ru0vyPQuuYgOQo7LbZa0Rc7ZTVlDLmBZLEXoZLse+hyrGaKpt4WgcwkGUCdDuPATgVvgkXNcg0MEyA7DLv0+MYfE2T36gxtwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(10067099003)(11063799006)(7136999003)(6133799003)(18002099003)(56012099006)(11062099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LIc13ZCLrtMuPwpLCrFdwPxu8pjRh2wYFaYKlxiAD9h2PnGKVFXxGGYgxXbrfE22eVdDvSEST9HTM4IWrpzw10hqWxKrNJWJntVUYde8ckESMuDLjlhCdqehBYIhZMDVq9pIASOtUum6FZ8ONQWveWfnvYi7rkM3WxDlQGI9TSwIAD4b3VsRFLIMCyv7ia46f+QiwXRroFykI4hm0XMJlfjLzOQrW6dcDlJy+WqViF/K6+hPDLIwFjPqgJ720BoP6Fy8lqOl4Xl6XPOx1FtiWxUW/haa6Rd7AvnoRapqJ7EEsarI30sMv6Eh/aAS9bmZwcVgPxmZGyxgQjprhgKLEZ82JI/P/9rlHgKtvrqdvWQNwMKBDIAZgfd/0YkkMGztFqtdvVFiIf3E/1PKBCHn7exDu2XLPaIRCHEy7X37L+u7RtMocqAEcdIxfBTvjQmD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:15:39.2868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dee7c55-52dc-4cc7-cd90-08df18c4be2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371
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

Not enabled in 7.1 so drop the assignment.

Cc: Horatio Zhang <hongkun.zhang@amd.com>
Cc: Hawking.Zhang@amd.com
Fixes: 4ed5116aacf6 ("drm/amdgpu: Add sdma v7_1_0 support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index fcbab7f05d08c..4a4382f2b7562 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1347,10 +1347,6 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
-	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
-#endif
-
 	return r;
 }
 
-- 
2.55.0

