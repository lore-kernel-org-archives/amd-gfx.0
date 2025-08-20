Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6485BCA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 11:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0996710E6FD;
	Wed, 20 Aug 2025 11:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sXSwXHCP";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CABB810E6FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 11:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuBpXEIShcyW0EQ69tcczqZJ0ALYnJTjGQpGbwTOdqYRqXjtnkPaJkM0OGpdR7KRj+zMfy592qxQP9RFdU5YALGbKZugvmWD+ote8vjdwWP/YQEHrCfet2CAG+LItzsdOLsOulw4SdwPGGPwoyk6TSxN8tMdGV/W3ll1h1gUBebYuYZPDp/mrE8PCoxFbFnrJAK5q/rOxQtJ0fJGcoWq/8Slte71YRjV0rx46ugm2rBeryZtGXATEPDqQHfAQ6Jgv0q2FOsYZPOLoiUEeYCnm6mfxeFsOaaFfGu0is083i+4aP9z/C1kyt+pu8tD3VIOIpUb/J25+/S7oWctGSevUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnsLJZW5dWx3+LmR41LdzDH50xzopkUzrf0hqLyofvM=;
 b=JUzYGHCnvcYzFZJoaG02Lc6CJ24u3qlG+S66+62vldgJqEQc6lunqkYCKpYx8o2Y4m6AZrEqht1jtdnHvch5fNF4e49WuOuR1vPhrBHgxDUj5mIXAnvH/D6o9x5piJYvA6wJ57V3wgMmsPAJTPvil80zNTCRsgRZaRz+1DGp7AMyKJhzMbswE1ozUGhSlnQ9RgxpOEukYpHw6g7V6EpPOJXxYtQD2Sh+uqzTeSD9g1GQCKLk5ixnk2aJq7U9ZG+pGsiAya8GILa2IrsEFIoNLPAow3f9WfsQVSqJxplBqgrGvGUldEEiLt0WLKGATYhVJcQAk/oAD/yk8EEcZDXsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnsLJZW5dWx3+LmR41LdzDH50xzopkUzrf0hqLyofvM=;
 b=sXSwXHCPEWk48r+Eb66WZFjYaxWnkvLEYsqW6ysYPAuaa16wbJSxCYPQyXh18KOMST+QEbQ4439CDIVFv3Bmn68c1jb9yK4sP2Aiv78GzOQUExFA44sDEm/kqM1BR2lJ47v6AdlEwYLBchsdFsXYdsIPar0i7ajnV2jIGnBzL4o=
Received: from DS0PR17CA0024.namprd17.prod.outlook.com (2603:10b6:8:191::29)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 11:33:33 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::58) by DS0PR17CA0024.outlook.office365.com
 (2603:10b6:8:191::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 11:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 11:33:33 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Aug 2025 06:33:31 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 6/7] drm/amdgpu: Create Singleton MMIO_REMAP BO and
 Initialize its pool
Date: Wed, 20 Aug 2025 17:02:53 +0530
Message-ID: <20250820113254.3864753-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c9d2b6-9a71-4486-c4b4-08dddfdd64f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjdLcTNOclhkQkxVV0E2dCt5dkU1MTlOL3oyeFA0OEdmRDlaQ0xjek1tWU5P?=
 =?utf-8?B?NXRlamZsSnJGcmluUEVXTGxJNEswS2U0V1l1WXhuRGl3a1Z6K0R6djBNWG80?=
 =?utf-8?B?QVZMb3ZGc2c0aG9wMGxmbW9kRWt5RUd5UnE3dHo3S3pDUTJiaVRPVUYxQUlF?=
 =?utf-8?B?QlJhNTZTbWZKWXVFbzhNUEVlTEtVZFZuMUM0eWRtZXkwUXB3QmI5eGhWelZj?=
 =?utf-8?B?a2JoYlV1MzlJZzVHSXo2SUZnYlY3akpQZzVMTS9MRDRuSXprWFJ2MzA4WmI5?=
 =?utf-8?B?dlpFdmtyVHZ6eGVmcURnQjF4T1RZOG1PV3VaN0NFb0lSQm1GMUFraFNQdmZR?=
 =?utf-8?B?RGNrdk03WncxUWhJWEtGOHVDMnhZcXlwNENYNFVrQzgrTFpNWEoxTUVJOXFm?=
 =?utf-8?B?K21memJEL1dXVFhsUEdLNlZFSXo3VWE2K0dadFJCaGExYVBac3pOSUhyUnRQ?=
 =?utf-8?B?YU5ySGY3dzYzZEo4cERLUWJmSnVheXFMNUNDSm91NWxxVDhYN0ZJQTVnQjVJ?=
 =?utf-8?B?bWtFWERFTGhYMXpuckhmRHVSV2VRaDBJSTdZNzVBQnBrNkpxUnNWRGtlckor?=
 =?utf-8?B?dFE5VkdyT1ZkUmVrdkdKdStIOGd5dXU5Z3lmSHNCMGNOaG9WVGFVeE9pWVlI?=
 =?utf-8?B?bkVLeDRQNnlBUXNmcFpjREF1S0tEUzNiMzBEMjNWQVhYekNMcHVJWFNSQWxa?=
 =?utf-8?B?UWJCdFVrakhXaC8xNWpiRTZSYkZ4TWREUUYxMit5YVJuLzkyOUo0MDFsb2o3?=
 =?utf-8?B?OUtYcWtOQ1F3NG9UdlczQXJJblRaSjUzY0hiTWZkLzVQd3p6ZjA4Q3lzekVU?=
 =?utf-8?B?QlRtWk1zUjJ5Y20rVVhxdzZkUXZVaUowZEdyT1JCL1ZzVDVoQWZOSGNQNWs2?=
 =?utf-8?B?clJ4Vjl6Q0xrWGthbDVSTVdidGFZbURnOThoQm11cXQyckFEUVpOWk9neWpB?=
 =?utf-8?B?VTlzQ2dtZGt1ZVhHa0Rja3Z4RnM1OVdpcVBzVlZxcTZpSjhsRW5nNHNuQXA1?=
 =?utf-8?B?WXlrZVJ4Z3RjU0dmK0ppN1prYUJaZ0Q1bVlWei9CVm9vR2NPZjRUVElMemlZ?=
 =?utf-8?B?YWNyTFUyL2F0WjdDdmpLbDh6cVVTeGY3bFdoYWV4RXRiSGdmbzYxTEw4dHB4?=
 =?utf-8?B?djZYMkVIY05MWFRnUHIrNlVyV3ZkOU9TRDNSV3llNnhhaUxhNU5nUmxGS0o0?=
 =?utf-8?B?VGl0Z2lGTDRoa2U0dkZJc0VtSGpWUE4wRUhCbHNNUmNDZDZ4QXNzNUd3Q1Bh?=
 =?utf-8?B?ZzNlNFAzcXpCTWVEUzhheml5MHdDa240TzJ1QU1EZzBjUCs2SlU4OE05dFdH?=
 =?utf-8?B?QStvanVZUHB3T2dxQTNKMmN3cFdLd0l2SnRlZ09lcjJRdk5Va0xidk5SN0Rz?=
 =?utf-8?B?T0FFRFltM3Y5UG81eWRUejNnYmlVTGtPdk16allFZFdiZU1NYlZIMmN1alVZ?=
 =?utf-8?B?Z0JpV01xMVFTMGxVRXMyNVRhS0dRNXY4QkZoWSs1ai8xalJFTmg0NkpoK3JJ?=
 =?utf-8?B?bFdJZ3c1WXZ6enFCcHpiWVpZK0wyTGNCbGVrNGFxRU8ybDlVNVRvTXlkbmts?=
 =?utf-8?B?OVJsNzlZQ0p2YkJiV0JNYWpvMDNtZ2tuMUZuejBCYmJ2NnF0Y2R4SjBoSzBG?=
 =?utf-8?B?MUY4bmZycmtWK0pvc3hXeWRqMlJyV2ptcGJoMzR0OCtGaHR0d3lWRWcyWTdK?=
 =?utf-8?B?dENVNWxiWFJYUy9WeUNzZ0k3VFNuaGoyQmwzdlFZeTVGNWhLN1llWWNJN0Mz?=
 =?utf-8?B?clVZT2RZY1VHME5ocG9uZVFCbVhMekcxQmM0cEVQZUw3OFdiYmZsS1JnckNw?=
 =?utf-8?B?czRKazdoN2w0cFVDTmE2UzgwbHp2Vlp5QzRWZk5pbVBjZFAvemN4VGx6aW9M?=
 =?utf-8?B?dkVCYTNFR2FBckU3eHBSZExMMm40a1NOSWp0eCtwTk4vL1ZOOS9LMSt5WUlx?=
 =?utf-8?B?cGZmb3Z6T1NEUzhQRzJRWnNERWl6ekVFZ3FzcXhwZjAwUU1zVHZjOGlOYUV6?=
 =?utf-8?B?ZFFjQ3hZMzJWYkhRclYySStlWStoT3gxS0dkVFZ5V29UMC9SeDJFWFYzVmpS?=
 =?utf-8?Q?hnWJmW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:33:33.0535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c9d2b6-9a71-4486-c4b4-08dddfdd64f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
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

Create the single-page MMIO_REMAP BO and initialize a tiny on-chip
range manager for the new placement:

* add amdgpu_mmio_remap_bo_init()/fini()
* in amdgpu_ttm_init(): initialize AMDGPU_PL_MMIO_REMAP heap and create
  the PAGE_SIZE BO
* in amdgpu_ttm_fini(): drop BO and tear down the range manager

This isolates lifetime management and error paths for the remap BO and
ties them into the TTM bring-up/teardown flow.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 86 +++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 157a5416a826..ab93fbec2a34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1859,6 +1859,73 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
 	adev->mman.ttm_pools = NULL;
 }
 
+/* ================= MMIO remap (HDP flush) singleton BO ================= */
+static int amdgpu_mmio_remap_bo_init(struct amdgpu_device *adev)
+{
+	resource_size_t bar_base, bar_len, bus, off;
+	int r;
+
+	/* The ASIC code should have set this to the absolute bus address
+	 * of the remap page (inside the register BAR).
+	 */
+	bus = adev->rmmio_remap.bus_addr;
+	if (!bus) {
+		dev_dbg(adev->dev, "MMIO_REMAP: no remap bus addr; skipping BO\n");
+		return -ENODEV;
+	}
+
+	/* The register BAR base/size were established in amdgpu_device_init() */
+	bar_base = adev->rmmio_base;
+	bar_len  = adev->rmmio_size;
+
+	/* Sanity: page must lie wholly inside the register BAR */
+	if (bus < bar_base || (bus + PAGE_SIZE) > (bar_base + bar_len)) {
+		dev_err(adev->dev,
+			"MMIO_REMAP: bus 0x%llx not in REG BAR [0x%llx..0x%llx)\n",
+			(unsigned long long)bus,
+			(unsigned long long)bar_base,
+			(unsigned long long)(bar_base + bar_len));
+		return -ERANGE;
+	}
+
+	off = bus - bar_base;
+	if (!IS_ALIGNED(off, PAGE_SIZE)) {
+		dev_err(adev->dev, "MMIO_REMAP: offset 0x%llx not page-aligned\n",
+			(unsigned long long)off);
+		return -EINVAL;
+	}
+
+	/* Create exactly ONE kernel-owned BO in the MMIO_REMAP domain */
+	r = amdgpu_bo_create_kernel(adev,
+				    PAGE_SIZE,                 /* bo_size  */
+				    PAGE_SIZE,                 /* alignment*/
+				    AMDGPU_GEM_DOMAIN_MMIO_REMAP,
+				    &adev->mmio_remap_bo,
+				    NULL, NULL);
+	if (r) {
+		dev_err(adev->dev, "MMIO_REMAP: BO create failed (%d)\n", r);
+		return r;
+	}
+
+	dev_dbg(adev->dev,
+		"MMIO_REMAP: base=0x%llx off=0x%llx size=0x%lx (BO created)\n",
+		(unsigned long long)adev->mmio_remap_base,
+		(unsigned long long)adev->mmio_remap_offset,
+		(unsigned long)adev->mmio_remap_size);
+
+	return 0;
+}
+
+static void amdgpu_mmio_remap_bo_fini(struct amdgpu_device *adev)
+{
+
+	if (adev->mmio_remap_bo)
+		amdgpu_bo_free_kernel(&adev->mmio_remap_bo, NULL, NULL);
+	adev->mmio_remap_bo = NULL;
+
+	return;
+}
+
 /*
  * amdgpu_ttm_init - Init the memory management (ttm) as well as various
  * gtt/vram related fields.
@@ -2026,6 +2093,20 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	/* Initialize MMIO-remap pool (single page) */
+	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_MMIO_REMAP, 1);
+	if (r) {
+		dev_err(adev->dev, "Failed initializing MMIO-remap heap.\n");
+		return r;
+	}
+
+	/* Create the singleton MMIO-remap BO (one page) */
+	r = amdgpu_mmio_remap_bo_init(adev);
+	if (r) {
+		dev_err(adev->dev, "Failed to create MMIO-remap singleton BO.\n");
+		return r;
+	}
+
 	/* Initialize preemptible memory pool */
 	r = amdgpu_preempt_mgr_init(adev);
 	if (r) {
@@ -2088,6 +2169,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	}
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
+
+	/* === Drop the singleton MMIO-remap BO === */
+	amdgpu_mmio_remap_bo_fini(adev);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
@@ -2109,6 +2193,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
+	/* Tear down the tiny range manager for MMIO-remap */
+	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_MMIO_REMAP);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized = false;
 	dev_info(adev->dev, "amdgpu: ttm finalized\n");
-- 
2.34.1

