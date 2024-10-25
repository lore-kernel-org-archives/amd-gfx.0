Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A46D0C5FB
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 11:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B2610EA88;
	Fri, 25 Oct 2024 11:29:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CoZu3klt";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33B5510EA83
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 11:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJ09eBGRKiZnfWI65K8aCL0BlHUzm19rUecNEoMy41IsADYR9dv3AWAvgIv1GOTyqumpjRTxlX6b4UP8MRQ0OtNS/TPLm9HPM4wyq4iE6Lj4m6geV959v4yBoODz0aQNKEmkDtQNZ0jqiK5yM8WZhTu5mSwQthPs2sUUfAh3e0PjGpDD/JZfGU6aXm+PrSUReVg1oXF0C5WY7ueYPZiQcD3z/LkMw5Eg5dF8ojitqgDGhLSSKnpzfowPb3XwirqHxxhw2C4OJP1CUJ+6Y682sq0FD+540jBgwtM+7jLyRSHHzXpfIF1Uo0wxj7HLFkY1NHF+NXgbY9vB/R99OGYMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOkQFgheVlzJf8d7jpTpGgkglacu6sxxCOu6CtubsSM=;
 b=YRhZj8m1ZbmRpAR6I5w9ioGWY4yhGFQk3fXNzGzJFSmMueO+fBrAsYJekz1on5ISKgMX2MIFevYdPp+rajyfPXHAgeReIW0pd1afpjTRkzrzmOhuFinNCW+yoUOnusSxmgnE7vYdD8t9YzTXQRsquhDvm6QN8RE4emiEzrA6O8J/C6/m3bQAvwb7elTr1dzL58AI/5N2ZEpSBmxb0ykZYDOLGxdTRKUtVIqgvKZ3p5ytdKD/htoMXLQW85okTH3Rck7WCzDWI4Z42tbqcNJi0r4Fqxci1lN8vio1nOR07v6lF+cuUevqk8Uyc7CtMJM9B8s5UYIPat0q74jQODKpow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOkQFgheVlzJf8d7jpTpGgkglacu6sxxCOu6CtubsSM=;
 b=CoZu3kltHyFY42njcej+wYKXRUe/v46PrC5hDUXTICpK8iyqiMgSRzLYJoIErsMQ30fY9R6aAEx7IIk4kf27GMSfVd3umL4EkMtIfJM59TLv+9JNUoLQ91Q90TlxIEEZNmSYtdkZXOqTcJNelzkVdAaxX05zl+iQBAErWNI8O1w=
Received: from MN2PR20CA0058.namprd20.prod.outlook.com (2603:10b6:208:235::27)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 11:29:35 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::22) by MN2PR20CA0058.outlook.office365.com
 (2603:10b6:208:235::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 11:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 11:29:34 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 06:29:33 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Fix dummy_read_page overlapping mappings
Date: Fri, 25 Oct 2024 19:29:22 +0800
Message-ID: <20241025112922.59046-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 9384f1f8-9d9c-45bc-fb11-08dcf4e84d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHFSclVGMWVhbkoxYkpqbmlIbkhSQTVNS3gyS1Y5V29LQVZNRnU5d1d5ajRm?=
 =?utf-8?B?K3dFTHF3QnlDa1JERmQvRnpFMmtLaWsrcjB1c3phVC9UUUV4UlV2d21GcUkz?=
 =?utf-8?B?VlJlaGE3M3VEbm5IalovN24vZmJGczlUMENLeXFqamR5MHJQSjk4M1J3S0Vr?=
 =?utf-8?B?WTZUU0tlSXBQOUp5MUNwTkpmeGkzbGVmV2xzZzc1ekp5MC9xNzNobklOQlpk?=
 =?utf-8?B?ZTRUWmJmeGJJS1doYmhvVFhEN3k4R2U4bEphbnFob3dZazdPVWdHR2tvSk8v?=
 =?utf-8?B?TnZ4L1A4a0EvaC94MkI3azZZeEFNZ2E5dUZmY2Fjd0VZR1N0Qkt3aWswd1A3?=
 =?utf-8?B?a0YzL1VpbEpoVW1nZG5ILzBtSTNlbGtHMCs1ZnZPQk9ZRTZ3Vk0wUlJFTkdo?=
 =?utf-8?B?Z0lpak0wMkc1NUhQcEpkL2V2V01LRlNYT1Q3UU1oaGdNd003L3F6cEgwMUJr?=
 =?utf-8?B?ZURPMGZ0c3RWWGJVbUN1MGQ5MWU5NFhycXlpQ1BWU2M5VDQxZGowV0FPUXFw?=
 =?utf-8?B?QllOQlgyV3I0M3o0MkJnTW9HR1VSb0Vqc1VUeEZMKzgxWk5UM1NLYnk2NjRC?=
 =?utf-8?B?YndxdkZvd1lFcnVpZnNYUzJJeGlrczJVS2k2Mlo2dHVnNlZJdXhXS2h0NWJk?=
 =?utf-8?B?VW44aTBCMzdBRktUMGRsdmFpQUNZUGNmMU84VDhiZGVVMUJqYmpiOWp4Mlc0?=
 =?utf-8?B?emdOT3BoWCtxNzlKOGpneG42UUdRL1JPYmJpQmZQMEFTQ2hwK09CSUFrZHho?=
 =?utf-8?B?NjFkRkU4MmJlcTVyVDlKZ2IwVVd5bTl0RnVWQnlJeUdaZFYwb3RFUkFtUjBk?=
 =?utf-8?B?cTFON2pLek9NaEFQTzRwSklVcFRMKzNTdGgyODAwdFlEcTZSS0JoTmRXb3hJ?=
 =?utf-8?B?YUNLODdvVkh0aEIwbVJDdUFKY2xSbkFvSlVZeG9MYURGdnNBbk1sTU1WUllM?=
 =?utf-8?B?Y205NUhCajEvNDJYd3dXYURkTVdtYlN1N05hRkpIUE9IclVpV2hSL0Rwc0ZE?=
 =?utf-8?B?MEJFQkxVeHlKTGhXSWlnMUhFVmhkSkhFTDdBU2N3UU5JM0RjdjQzaXQwKzkv?=
 =?utf-8?B?VGQrNGMzWENOd1IyREltZ3lXOHhYMXNjTzU3UXd1Z2pLUHVKd0NBYmcwNThP?=
 =?utf-8?B?Ulp0NEJwRUVEa0FBWjl1bG42WjNRSHFzT1p1bkJRWVBaUnY3S0hqTm1IVVFh?=
 =?utf-8?B?ZllDcFViNVA4eEJCREFpSVoxVE4rYkNBNzhpSWxKWkFRaVdYR3dic2d0U29z?=
 =?utf-8?B?c1lXMUxDMndYTGVKQWRWR2hSaTZNeGFYZFZTUHRBbktyRGFqdU5DUlBBaWNN?=
 =?utf-8?B?ZkprVGF0dk5jSlR5VXBXZlFOS2dnNHhiZFE5dXBCelgxTWZEVnIyK0x2SVFY?=
 =?utf-8?B?T0lFaTJSZDU4QU5IaVR4WFpEb0Rhb1VoNFg3clFHcGZPZDN4T1NPcU5XUmNU?=
 =?utf-8?B?V1lDSlVkOTFhOU5xMDl6eTdZWURBc1E0U1pxRUdtZXEycFVIeTAxdzVyNThv?=
 =?utf-8?B?UVFpUndxNTNBdGVueUc3ZitTbWw2Mk9HZUlET1VKQi9GOHlINTFuRFFzT1ZB?=
 =?utf-8?B?ZmF6M1Z6U1hFUVNlV1hwSlFyc2dycHRrQS8yRmJPOGFyVFgyaUYvbVplZlkr?=
 =?utf-8?B?NzJCNlJoekV4OGkycXFDQlY2Z2xHL1I3ZWdoYnJwTHpxampadUF5Sml0aUJF?=
 =?utf-8?B?M3JJVVlmWElSQWpZZDZ3UEJjTG1SanY0MG1sSFpqdm0vSFRIalZuMitwWStv?=
 =?utf-8?B?WllXTWh1ZkF6VWdxSm1Zb29OMkVnMWdWdW9waWNwRUg1bzllSGgzZ1lxTXFK?=
 =?utf-8?B?cnZaWGtCZHE5VDEvdUdmYXNBYkFvSlJqQ1RINmN2WWFEbFB1SUdFNmNKOW03?=
 =?utf-8?B?Um5ydEFCNjc1ODJTM3lOSml2alBaeXY5RS9uU2Zoei9ncFE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:29:34.9490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9384f1f8-9d9c-45bc-fb11-08dcf4e84d87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274
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

Use the dma_map_page_attrs() with DMA_ATTR_SKIP_CPU_SYNC
attribute setting to handle the dummy page overlapping
mappings.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 256b95232de5..b2033f8352f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -78,8 +78,9 @@ static int amdgpu_gart_dummy_page_init(struct amdgpu_device *adev)
 
 	if (adev->dummy_page_addr)
 		return 0;
-	adev->dummy_page_addr = dma_map_page(&adev->pdev->dev, dummy_page, 0,
-					     PAGE_SIZE, DMA_BIDIRECTIONAL);
+	adev->dummy_page_addr = dma_map_page_attrs(&adev->pdev->dev, dummy_page, 0,
+							PAGE_SIZE, DMA_BIDIRECTIONAL,
+							DMA_ATTR_SKIP_CPU_SYNC);
 	if (dma_mapping_error(&adev->pdev->dev, adev->dummy_page_addr)) {
 		dev_err(&adev->pdev->dev, "Failed to DMA MAP the dummy page\n");
 		adev->dummy_page_addr = 0;
@@ -99,8 +100,9 @@ void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
 {
 	if (!adev->dummy_page_addr)
 		return;
-	dma_unmap_page(&adev->pdev->dev, adev->dummy_page_addr, PAGE_SIZE,
-		       DMA_BIDIRECTIONAL);
+	dma_unmap_page_attrs(&adev->pdev->dev, adev->dummy_page_addr, PAGE_SIZE,
+				DMA_BIDIRECTIONAL,
+				DMA_ATTR_SKIP_CPU_SYNC);
 	adev->dummy_page_addr = 0;
 }
 
-- 
2.34.1

