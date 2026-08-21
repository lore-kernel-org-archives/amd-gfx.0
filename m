Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14232C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8186810F352;
	Fri, 21 Aug 2026 16:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gbf4/IcC";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ABB610F352
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:07:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPLe3EzDEBF1CZHAZgHBNQhAexPyR4TI45Td/AJfkfgqX8HqEDvdzVQJaoQWbFoaL0GHrcY58fI2d5wypjeEQA0fVPEfiadXum1/yHmVQs+nCMmNfnS9ubRVjii2CJme6haXSPCRotZIXLc2u/bMeaj+ChYAtdOH3BX08V20tyGKNNmaK8ONrl0wUlf6ki2VASIs10f10h3ZfNrcV5k5IkvGu/jSSB3PISINvF+ObjU5SWgZiokmmUACnfz1+mBumll/IKjm8cxN6vg9D2GgOj9+f005x2Br450ya4i0m1Jx7qOqc41fUaDUmCNKnaRTB9lwUluf+Z4lVvSeSSruCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vUMLefOyLxBJuqfRzl8SAtRZIiTk4JS/qgjA9c3zYI=;
 b=MdrP5LpXs78PVqFIaVLzCjcp676XiIJHfy3+m0Gli3rPz7cvNOC0Gg7uD9lLQEhtJX3UPrSQdINu+pk73TIu2fHbl9AqnHiFDBvWMYmxVsJqTmrCnBVqO74SO/AQ+AIxEnPTAP9EdBzS+EJKiUAOrc9YEK1k1DkUrkI//NpHcB7NfTs7GhVN60SMzp7OF+K/alkVRBJqMu7LXewrTMaWVd1pMfzDfA+JomyCSJsXcbnE3Q1Frye9okRqXYRLjy6po+IURuW3WkD8w00dwm+zPjGBNHqSv1y3K4YCa/x8Ris1k+fkLdKfgjplxiV3i9wRRyJqHRZg6PZ06F8zGn0Mdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vUMLefOyLxBJuqfRzl8SAtRZIiTk4JS/qgjA9c3zYI=;
 b=gbf4/IcCCSDVxqmT2R5u8LAPOm5jUKG6CLFJqG/1ui/FW2VAcgntnNdirEMTug0Xfd7ocArRV+PNjz3VvOfzOc1cCjhs+Z/JPCqrYZC6tmNCuv3eVdfuBiDZmrHgVvV/Va41h8dH5G1zqp2kj3ZPHMCJXVjUeeXVpy9szKYeLuw=
Received: from MW4PR04CA0374.namprd04.prod.outlook.com (2603:10b6:303:81::19)
 by CH1PR12MB9718.namprd12.prod.outlook.com (2603:10b6:610:2b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:07:27 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::56) by MW4PR04CA0374.outlook.office365.com
 (2603:10b6:303:81::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:07:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:25 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shiwu Zhang <shiwu.zhang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/15] drm/amdgpu: retire get_gb_add_config for gfx_v12_1_0
Date: Fri, 21 Aug 2026 12:07:00 -0400
Message-ID: <20260821160710.752459-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160710.752459-1-alexander.deucher@amd.com>
References: <20260821160710.752459-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|CH1PR12MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ffb997-feb1-4706-aaaf-08deff9e4b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NWi9kNVu4YX+lHVe5LLNM7OLphDfCtPvLPu32oER0BXF5LYMqHeYbKMI31lcvk6fk1Fqgt74EXZGjIsCw/7NQcs9DlS760bHl6o08O7cuCTb/0RPuiKLDpSQObeKDpi108btf+Jqh4kONpc7WBbO4JBbknlrIfPIQEHs0SHlrEyfqHfKy0gGFnk7g5og1xFvkQ6yRxH+nR4J7Fwf1xYnkvZi03kzzgK2n7DdsQ8RXL5D5Oc6kMZUN/1t4NiI5njPK2RnDbUDjFKI7RkG0bgyVBM8aZpCA44ZH1VAgidN0g1BJNcpFxxulSW6j4VEQIvwKCaOIUIrQjtv/6K7SLAI1PXHkaRZA0O8OS/ljDtnX5dyaR0dWR/8Se+5Cr7YlE8/yguDabzuXGRRUTPixcyiPufgWHecPtECyRJdku+IzuM4FvGmX0TQfSD6yXdpbuaox8TIm/l6DnwOXs5IQOWxJAZeW/ZUPkS3CdkWYGXdiVBDqFTDZqogOYXMK9Tjlz7mDauP+0oaJny/0/1WQJ0iwFtutmLn2VW9M8eh56eSs8JSNAQUM66V27MMxf7TdXK6phLXNTTi66LkIpwDktGZdMH2xBN2Z67HJldECuLzokAzgzLWEn0avxMMBmeGIoqs1nAdJMG+986R7l+9Fx5Zm9wcTtvVZZApHjun6mQRPCIQZkHy2ZfehAN9Xvenp18fmFfibyZGTyXhDCkPBP+9Tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jf5/nX92cmoeE2l36W1pUFoV1QBNmp9iF85AKGmt0suK4z2iA0eYE6Z/EDKfiImsr2zCmAnMj/lzU/iUKvc90FG/91IUdkn7Dx5+/s7VnjuXV5vO+W36z+mE4PER9qmRgv0QWqLRc2XODK0X2niHgXwrdkHcB3XEzR2oHDbx05DfVJTnj5RpyMapYS7OharZloQSg01v2KvoyYeepP7jRkJfliX+9YCRZAYH1IncS/sKhN+pw+7DpDG0XbNC8XLU/rbv6lbJIPZn7fUelyCbFeGPZzHtV20PrTSRVOcu7sNm9M3+3aAfaI+wXUPmoOJtAuSIQY37EwJ9t2vr1PU0b1k/ZPk6T0LWEgvsCUrFfHqiBTLoWdyXvHgkBIy0YItrIIqRvzMrfRPgFslUE2QYX/gFqgNJVTFAn4LFNPgFt8FZZ/sGM3e2sCKuudQpKlU0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:26.2860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ffb997-feb1-4706-aaaf-08deff9e4b21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9718
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

From: Shiwu Zhang <shiwu.zhang@amd.com>

The GB_ADDR_CONFIG_READ is initialized to zero.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 39 --------------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 93d8aec4a4a10..606106ddf99dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2850,42 +2850,6 @@ static int gfx_v12_1_gfxhub_enable(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int get_gb_addr_config(struct amdgpu_device *adev)
-{
-	u32 gb_addr_config;
-
-	gb_addr_config = RREG32_SOC15(GC, GET_INST(GC, 0), regGB_ADDR_CONFIG_READ);
-	if (gb_addr_config == 0)
-		return -EINVAL;
-
-	adev->gfx.config.gb_addr_config_fields.num_pkrs =
-		1 << REG_GET_FIELD(gb_addr_config, GB_ADDR_CONFIG_READ, NUM_PKRS);
-
-	adev->gfx.config.gb_addr_config = gb_addr_config;
-
-	adev->gfx.config.gb_addr_config_fields.num_pipes = 1 <<
-			REG_GET_FIELD(adev->gfx.config.gb_addr_config,
-				      GB_ADDR_CONFIG_READ, NUM_PIPES);
-
-	adev->gfx.config.max_tile_pipes =
-		adev->gfx.config.gb_addr_config_fields.num_pipes;
-
-	adev->gfx.config.gb_addr_config_fields.max_compress_frags = 1 <<
-			REG_GET_FIELD(adev->gfx.config.gb_addr_config,
-				      GB_ADDR_CONFIG_READ, MAX_COMPRESSED_FRAGS);
-	adev->gfx.config.gb_addr_config_fields.num_rb_per_se = 1 <<
-			REG_GET_FIELD(adev->gfx.config.gb_addr_config,
-				      GB_ADDR_CONFIG_READ, NUM_RB_PER_SE);
-	adev->gfx.config.gb_addr_config_fields.num_se = 1 <<
-			REG_GET_FIELD(adev->gfx.config.gb_addr_config,
-				      GB_ADDR_CONFIG_READ, NUM_SHADER_ENGINES);
-	adev->gfx.config.gb_addr_config_fields.pipe_interleave_size = 1 << (8 +
-			REG_GET_FIELD(adev->gfx.config.gb_addr_config,
-				      GB_ADDR_CONFIG_READ, PIPE_INTERLEAVE_SIZE));
-
-	return 0;
-}
-
 static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev,
 					   int xcc_id)
 {
@@ -3034,9 +2998,6 @@ static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
 
 	adev->gfx.is_poweron = true;
 
-	if (get_gb_addr_config(adev))
-		DRM_WARN("Invalid gb_addr_config !\n");
-
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
 		gfx_v12_1_config_gfx_rs64(adev);
 
-- 
2.55.0

