Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BBACCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 21:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AB2D10E698;
	Tue, 14 Oct 2025 21:17:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SybRfnF8";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C3810E20D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 21:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYSQEMajkqI9WIxBaJBL2C/v8yToPp6aCLUqyo31wvEbLIYHbRXJ9LdyWYtAruEFyLwjp4cCCjTY9aY/aFoXXYxMK9YaSRRVXnQNyAfVajSLkfIuS03cpTLAybKfNXjAfHFvOvw7kRMdavsmbxNIsLDLmYlOEcj9/B1qUo0UAX7TSFIJ5/1e/fMKZR9o+tufn34wJcZoZ5gflPcqM3MUbjMHsIod65B+yKBiaMZ422REt7K7pmr+YsfU1FJ/b8extHGg2+d9IJvjcuf2bGalXI5e8HRW2jPaLudTTa8BH9J4eVlTNGbfPUxW4fJ6aT1NPyeAipXcnus+vLBjCKFbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNDqdpax606VBpmRD0JLwhI4PfUbYoKR/FtoeHt9EXg=;
 b=yLjmZ3d/tOE5eMQV4UZ6E7+5zQAVKIOSpCd9o3T+al5i/2BLWkhu/cR4cxNZ4vQ2w4cChjaPGcHSKfV5KxnDn/Dg+1SloHDAqrfsX+BC7zGgkd3Qc0+goX3tMPW1UeFpW2TaTG7gw2tVi1Q336t/+hpet7wxqHBPBJNjRoF0SsOPCyJEt7HNeW7QpKqtLiabup+Ey8mmK2ZEig9nUOn9WQZCneT4UEX6Kb91ONULndMm0+otO1cl7Cy6q7Xfw2201t3n8XN4iO5uvRElRoo0Ae/DlarH7Ak7Y87fY6Tjj9OyutHz7GHO+QpZxJOUXLd2CEo8CctVXdDOGzsxolVZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNDqdpax606VBpmRD0JLwhI4PfUbYoKR/FtoeHt9EXg=;
 b=SybRfnF8/tjbWPvLOIcdQZOa5J4GAKC6f5dSL50LExwBTXHD2Bsx9D7gKAE83G7tbcXpfnrxJqV5dtxyZwUx68+2Ckx01G9ikPD6Yx3Uj1QiLYPj3FlQP8qqSLdvwmbAQSqs3dSmaLWkQF9+yJnjIuSGjnpH5r3ebha31VnKEN8=
Received: from PH7P221CA0060.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::16)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 21:17:33 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::70) by PH7P221CA0060.outlook.office365.com
 (2603:10b6:510:33c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Tue,
 14 Oct 2025 21:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 21:17:33 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 14:17:30 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: set default gfx reset masks for gfx6-8
Date: Tue, 14 Oct 2025 17:17:11 -0400
Message-ID: <20251014211712.2524052-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: e92754ef-367a-4f80-0f9d-08de0b671734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FZBtuYe/OkCluJDiX4yLhFhc9OI5jrXbYgcu9UfBThCcQgiJKGDf498TMjaI?=
 =?us-ascii?Q?AN0mcy+9Y8/B7V202OwsLMaC5N2ezOK6/X2aRMZCZTjue8UcGJTA5hnFxiEW?=
 =?us-ascii?Q?ipkmVV8ls26SjQnApPrGmKWX0kfbWIAYT175NTcmdnC2/yMd/4tUwX2DO4rK?=
 =?us-ascii?Q?lPT0YvoVKMWPb7ERsus33msBxilOb9qt1xW//lSVGH+ORG96NjEUNiVdd291?=
 =?us-ascii?Q?OEXXDiUnenxAXkjnp7EpPsNOphkDU/lKUS0fGYq7CCpoFxgZYQzQgebxaqbu?=
 =?us-ascii?Q?Vm7qG0OQOicKcXsciVDMPRc+iZ29ZILeLsHvXKs7d1eY2OmRV8MVP1FTen61?=
 =?us-ascii?Q?gb8JSfzyMfnb4LBts1pmmvfIGXDSotOQp3YcCUNE+cUT9w+pE/Ev9b9CMmRa?=
 =?us-ascii?Q?ZpFWNzieQEMY/sMB5/6s3OU8aXPVYkLAXm7OgMCNQb4wjnNBWNSIMQ6bEx11?=
 =?us-ascii?Q?kF45WD0WY+Isb4VPYhWQcuOg+aoCspl/KU0fAgpMkVN2zbwihx9fGIrLhdhD?=
 =?us-ascii?Q?5sn6E3F5FxeT6V3DybBU0W61Gpq10z6VSu+jb53w8ZKxU5dbwXFTOHTNlJck?=
 =?us-ascii?Q?IaQJ6E0FoP1HGFgiizdXQ5eO5nxyH+3Vodqrkay/7sC4lg7rPWPBMAvc8itv?=
 =?us-ascii?Q?HJAbLlrbjJK0zSF26eAsEor6JpNTmSIlZqULE/KC3AkhsH63NaXYhepbLQnc?=
 =?us-ascii?Q?u9g6+ejZ+i+HIXn49H3vByrwXBFP3JMeFzQ/jB1d0w1H2Iorg/P/bKHNDPmD?=
 =?us-ascii?Q?FnpjuJlRIEmqw3Rb7qNrm8Cfxt/f3826WGuoAsC5IxdXS63RwMduQTomRSYJ?=
 =?us-ascii?Q?JNDKyGpA4An1DhbpwiBDYQNicYUj0m9TvMRjPkbpGdbIYVtyoclFeN7QIjtw?=
 =?us-ascii?Q?6jWbBb5jvPQ7TM2wjjcokeAvPtS5DsmPpbs4T/D14ePYvfJ56XBkgTYan/oK?=
 =?us-ascii?Q?F8zKTHPTFZN8hXCw6QlK7u0vsQr36lLsVuvDwZYXFBHEnQDMrsw/H1ap5qJU?=
 =?us-ascii?Q?54JgwBpKrImcZxGpbnFotFFWgNy+lVnsIbdlWdnMYVLFNB/S5t9jG7To712u?=
 =?us-ascii?Q?9z5aUoJE905N9bNisWG5tDOmUSYT/16X/duxxbtx4GhEAtoRXT67zs+e5PB9?=
 =?us-ascii?Q?/AQFBWfajf4n9UT4yq3IES8g39gkHVdjIpDkEOaUHdO4KqOKj6oQYh5mAlWy?=
 =?us-ascii?Q?aqQXPwSz+j1/ZHs0dk1DR+srwBV29MvvU4WXNJbzvVbdEsv+v+L3awAJwN7y?=
 =?us-ascii?Q?ParLLKXJJPdmiW7SxyviKYzzq2WmMlMJJAvea6UQUwmpDValakLXhjeAo/+B?=
 =?us-ascii?Q?/ubkiIA/aKsitJ3RvYKFaNGRlB95gzB23AxxMjYPZyESQzpA3/aq61qQRHSV?=
 =?us-ascii?Q?YcpQolOSyA71y89gM8RL60SHFpy1J/XoeWk39e9LCAY4gE4dQ4r9sHyIOanu?=
 =?us-ascii?Q?8VVYuZcApPuFm877OSAwwrHiUcMLBTez/JIMNmDrXP2JE2uC0LUhtHv+MX5F?=
 =?us-ascii?Q?xm8S+pp2DTMROYSyrGhrci75bAeWDwuSqnsZKn/tvy3Wzz7dUyWGrAf8Nmmw?=
 =?us-ascii?Q?Gjz9UWAYy9UoP7JhaaQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 21:17:33.1366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e92754ef-367a-4f80-0f9d-08de0b671734
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626
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

These were not set so soft recovery was inadvertantly
disabled.

Fixes: 6ac55eab4fc4 ("drm/amdgpu: move reset support type checks into the caller")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 7693b79534267..80565392313f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3102,6 +3102,11 @@ static int gfx_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	adev->gfx.gfx_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
+	adev->gfx.compute_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 5976ed55d9dbd..2b7aba22ecc19 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4399,6 +4399,11 @@ static int gfx_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v7_0_gpu_early_init(adev);
 
+	adev->gfx.gfx_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
+	adev->gfx.compute_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 0856ff65288c0..8a81713d97aac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -2023,6 +2023,11 @@ static int gfx_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->gfx.gfx_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
+	adev->gfx.compute_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
+
 	return 0;
 }
 
-- 
2.51.0

