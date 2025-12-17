Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7708D6409D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 09:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1933B10E175;
	Wed, 17 Dec 2025 09:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lg9HvXeV";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013061.outbound.protection.outlook.com
 [40.107.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2FC910E175
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 09:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5oPsiH5gNHjYrRakt7Zk2G7tXJZujYMP1HgWylX0lpf6qaztH/QGU9paLh4juF9V+yAP18AQeCuZt6hNU7PtpIDZwPMLD7AuNrYoQsNHW+Vcq1E9vvVFIj9xoVFOPy/vlJeQxwXlRC1mXgU6N09y7e+1oelSnbSJg0N8kLUeDjW9TSxb3gBntnR49p89g5NURmrRV4C3M0oA+5WZgoZLCejJSxOvVX0LFfLs1xgTLYEdrPP0aQfLIbzbhwAmtXOLhU2MACKJIhpNsKjodKYOK3plbAJtTkSAZsdMciozyKVTW5FY1gcBlkidkqv6wwhaePsrBS0IgJY6lTZ5QUoAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WD0KUlPsARxW6iDmYMrJOy0DzxONNr9sHi2pkPlmuew=;
 b=wkV3CaWWuysis209H1vS54WypdRbhNszTwLLqaubGDkhF7bDKSUYoE3JAoPWRFrb6DMb0+NycRNzJJK0++FesSNa3w7Su4JOo3RVGuB9s7kmpplEIUAYjmxhaPhiBAr7BaY02mmJrFis8Oh+6/J2OpiNXFfqtDWQgwN4jUGhG/+6Xjma1sD9raCqvt5RqkyyrQC8I6361u/Xx2t4gqV4QKy44lAzc6J1lYqSW3gM3NCrn1D6YA47fRud9CBTD/epkeutYfsBw8Sm1rHlXnrP0f+YYHSH1P5FfbIsuqPsWHdlp2lQoQJEEv72wFOA8xNtWXSOuDEBt60lLVuzr3uzDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WD0KUlPsARxW6iDmYMrJOy0DzxONNr9sHi2pkPlmuew=;
 b=lg9HvXeVQg54hhh0jP/qbC/IyAOnURUV26V2QaJm256DI0ArzkKUJ0jl4tS/skGpjIWmT9p6Ytx2/89qr9+FxyhyWPCTZNEId8P1Q41kx1c3VlPl2z+FciY6FNABM01jg+8OZXciSSrhb1+dbdIY4gZayJWYWWg9KurQH86XYIY=
Received: from SJ0PR13CA0221.namprd13.prod.outlook.com (2603:10b6:a03:2c1::16)
 by BN7PPFD3499E3E3.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 09:22:31 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::39) by SJ0PR13CA0221.outlook.office365.com
 (2603:10b6:a03:2c1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 09:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 09:22:30 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Dec 2025 03:22:27 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Leo Liu <leo.liu@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, David Wu <David.Wu3@amd.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu: Rework MMIO_REMAP BO creation
Date: Wed, 17 Dec 2025 14:51:58 +0530
Message-ID: <20251217092200.703080-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217092200.703080-1-srinivasan.shanmugam@amd.com>
References: <20251217092200.703080-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|BN7PPFD3499E3E3:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8af22b-239a-4eda-ba4a-08de3d4dcdaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXlNei9pd2ZoRCs4Rmw2YTZ6ZXQzU2YwT1lPOEFad01rci9SQ3RsN2JRWHJn?=
 =?utf-8?B?OG9FZ3hvSFBKTTlKN3VWTnNlN3RNV2xHUWI5RERGbm5RaVM3V0ZyUDNHcm5H?=
 =?utf-8?B?bGYvM2RnNXYxc3ZYTmcrWnZLcWtUR24rZGJadGdtTzZKTm91Sms0anVabUNi?=
 =?utf-8?B?UFRCQnoxZWozRjY4YnVJcjIxQUMwemQvRitTZWlkNUpiSndJdCtWNXJobHNh?=
 =?utf-8?B?TmJQeEcxZ3h2Y0ZMSDF6amZLNWZrWTdoYVgwQ1RGa0hhUDJIeEhJZlovaHRq?=
 =?utf-8?B?LzY2V1FncUJENTN1SGJVZ1k1dWc5ckI1Q2RWcHRCTGRVckt3REdZYldKL0VB?=
 =?utf-8?B?c0RDaXRPT0YvMzJycG9EWkdKL2FJM2g4TU41RDZaZFhNaUV5MDVWMkpvZWI2?=
 =?utf-8?B?RGpWOFl0NVBSYlJZMkF5aHcyaUxWbXgvTS9TQi9IQTJwMlpOanYweVY5VkZK?=
 =?utf-8?B?ZEZ3R0FTNHlWdDlVYzR4dlhudVQvdVpVSlZ3dVZlb0MzaXVPM2E3TktZSFpn?=
 =?utf-8?B?RXBhamRwVWdlbUozRHRnRXZTV2kvN0o4YStBR2p0V3pNNlJLWS9jcFhlSFJT?=
 =?utf-8?B?eDFXenNnYURhTkQ5eEpVcnhTYjRjKzR6eWFOYStLeWlBYWRQZFdocDQ1QUlD?=
 =?utf-8?B?aXVhSWFUb3Q5ZzQrOGJGSkRSR2R0NW5UNW0rV0haOWdyaFRhOUhwVU5YdnY2?=
 =?utf-8?B?UHlKZm1zbEsvZVJDdjdSWDN3NnBISEZTbXR6dHg1WHpxZWlWNlZWZ2E0c3Bl?=
 =?utf-8?B?aGh0WDg3UndSZmhkck9QdzBaMXBwd0REOEkxZ3FWYnVidlNnVUtYbndHcC90?=
 =?utf-8?B?VWg2ZkZvYlRmMlhzNlpsS3hxRzZ0QURuSnVzR2gwZFJEZGQvSkQrTlppZHF0?=
 =?utf-8?B?STFzZzQwTUdXNDVLTkZjSVhCMEFlRnB1VEFyeHJkSzMxOHlhemFRekkreW1j?=
 =?utf-8?B?bFA0Z0hOZ3RybitvNzliWm9lUzRWdWszcnZmbllJWlI1N0dMZEcxTncxR3Vt?=
 =?utf-8?B?anJBZGMzT3dPOTRGTnhXV1BMWFBlemJ0UHVaQ09aNmRhNGVXRXJpTE42ZUVK?=
 =?utf-8?B?VjZpNzUweXpaQ2d5MlQzaEhXQStvT0dOUHdzeFozOWJWYWlkL2VObGZvQ3JE?=
 =?utf-8?B?M1ZuTytUYi94amhUa3dqa0REV0l4QTN6WVM3OWlBdUI1YktoY0dhckpzT01M?=
 =?utf-8?B?MzBaQWlRVkI3ZXNXUmR1aE51VWhzNVlPZ2cxRnp3eVlWUDdRaVVHM2E2bzBK?=
 =?utf-8?B?Yy9jTVE2d0NsdTcwNUxYV2VzTFUrOVBydmZQMG1WV1BYSXlBSXR4SkUveUJ0?=
 =?utf-8?B?Nnk0VDIxZ1NVdkVmZlh5SThhSDd0enIxaU84V1BXN3FUSjhVNG9kQUwrdEND?=
 =?utf-8?B?UGVmTDI2cUpRTTdjOWVaMVA1ZGpzM2tmTTRvWWFEdlBWZ2o0REhtNzBNOW9s?=
 =?utf-8?B?bk85YkNjLzVPUmw3Yy85MitCVUU3UTErVm1YaDErN3lLQ0MxeEVKSVFkM1dS?=
 =?utf-8?B?dDYxOG9oUXhjc0w1MmpuUjd6WEI2Y005dE5NOXUxbmFvWkorTjlQb0k3K21p?=
 =?utf-8?B?S3V5Z01MNnlSZElKNnBZcVZkdXpDZFRhNnk5Y01wUU0xZkl4YmZIbVJ4YmZI?=
 =?utf-8?B?WHJQTG9CTW9mVVcwekUwOTVaL054aGRncHY0VzJ1V3JYc0NFb1lwdmZicnF0?=
 =?utf-8?B?V1dZbnBid0NYcjd2aW5kc1hOM2NpSmE2RnFqVHlzQVVyaGt4ak5rclA0amhq?=
 =?utf-8?B?NUd5YXo5d3g5WS93dHVyMWdEMGxkVFVDR3hqMFU1TE5BdWlkcHgxYzZ1Sjlv?=
 =?utf-8?B?azZSamNLdUNka2NYNlpMN0pOVXFjZWNOWUtYaVhqTmNsUHgyT2lXQ1habEhq?=
 =?utf-8?B?aDJxSUxpMm4vTG80SmJoenJTaHBBczRFVFowRDk2VXlleG9MQ0hFV3Y1Sjgz?=
 =?utf-8?B?K2pRd1lYeU1JNXpUTWtDRG1XTG5ZRkgwa2lURDhBOE1mdUl0ZlRFd0JYMnBh?=
 =?utf-8?B?dElSc3BScWtWVTlveVBvK3ZLMkRWWVRpeVJWd05NVVZZVDV1SlFnbVpnRjFX?=
 =?utf-8?B?VmllYkxQTmRyMFd2NGxYK2NHRDByZVpoN1hkbVo1WElMTkhRUmJwTmlueTF5?=
 =?utf-8?Q?0mV8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 09:22:30.4152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8af22b-239a-4eda-ba4a-08de3d4dcdaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD3499E3E3
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

From: Christian König <christian.koenig@amd.com>

Allocate the MMIO_REMAP buffer object as a regular GEM BO and explicitly
move it into the fixed AMDGPU_PL_MMIO_REMAP placement at the TTM level.

This avoids relying on GEM domain bits for MMIO_REMAP, keeps the
placement purely internal, and makes the lifetime and pinning of the
global MMIO_REMAP BO explicit. The BO is pinned in TTM so it cannot be
migrated or evicted.

The corresponding free path relies on normal DRM teardown ordering,
where no further user ioctls can access the global BO once TTM teardown
begins.

Fixes: 2f711aebfa64 ("drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP Singleton")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Leo Liu <leo.liu@amd.com>
Cc: Ruijing Dong <ruijing.dong@amd.com>
Cc: David (Ming Qiang) Wu <David.Wu3@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 75 ++++++++++++++++---------
 1 file changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0f83d140b6ae..10211648d498 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1903,42 +1903,45 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton 4K MMIO_REMAP BO
+ * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton MMIO_REMAP BO
  * @adev: amdgpu device
  *
- * Allocates a one-page (4K) GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP when the
+ * Allocates a global BO with backing AMDGPU_PL_MMIO_REMAP when the
  * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the host
  * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a regular
  * GEM object (amdgpu_bo_create).
  *
- * The BO is created as a normal GEM object via amdgpu_bo_create(), then
- * reserved and pinned at the TTM level (ttm_bo_pin()) so it can never be
- * migrated or evicted. No CPU mapping is established here.
- *
  * Return:
  *  * 0 on success or intentional skip (feature not present/unsupported)
  *  * negative errno on allocation failure
  */
-static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
+static int amdgpu_ttm_alloc_mmio_remap_bo(struct amdgpu_device *adev)
 {
+	struct ttm_operation_ctx ctx = { false, false };
+	struct ttm_placement placement;
+	struct ttm_buffer_object *tbo;
+	struct ttm_place placements;
 	struct amdgpu_bo_param bp;
+	struct ttm_resource *tmp;
 	int r;
 
 	/* Skip if HW doesn't expose remap, or if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE (4K). */
 	if (!adev->rmmio_remap.bus_addr || PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
 		return 0;
 
+	/*
+	 * Allocate a BO first and then move it to AMDGPU_PL_MMIO_REMAP.
+	 * The initial TTM resource assigned by amdgpu_bo_create() is
+	 * replaced below with a fixed MMIO_REMAP placement.
+	 */
 	memset(&bp, 0, sizeof(bp));
-
-	/* Create exactly one GEM BO in the MMIO_REMAP domain. */
-	bp.type        = ttm_bo_type_device;          /* userspace-mappable GEM */
-	bp.size        = AMDGPU_GPU_PAGE_SIZE;        /* 4K */
+	bp.type        = ttm_bo_type_device;
+	bp.size        = AMDGPU_GPU_PAGE_SIZE;
 	bp.byte_align  = AMDGPU_GPU_PAGE_SIZE;
 	bp.domain      = AMDGPU_GEM_DOMAIN_MMIO_REMAP;
 	bp.flags       = 0;
 	bp.resv        = NULL;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
-
 	r = amdgpu_bo_create(adev, &bp, &adev->rmmio_remap.bo);
 	if (r)
 		return r;
@@ -1947,42 +1950,60 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
 	if (r)
 		goto err_unref;
 
+	tbo = &adev->rmmio_remap.bo->tbo;
+
 	/*
 	 * MMIO_REMAP is a fixed I/O placement (AMDGPU_PL_MMIO_REMAP).
-	 * Use TTM-level pin so the BO cannot be evicted/migrated,
-	 * independent of GEM domains. This
-	 * enforces the “fixed I/O window”
 	 */
-	ttm_bo_pin(&adev->rmmio_remap.bo->tbo);
+	placement.num_placement = 1;
+	placement.placement = &placements;
+	placements.fpfn = 0;
+	placements.lpfn = 0;
+	placements.mem_type = AMDGPU_PL_MMIO_REMAP;
+	placements.flags = 0;
+	/* Force the BO into the fixed MMIO_REMAP placement */
+	r = ttm_bo_mem_space(tbo, &placement, &tmp, &ctx);
+	if (unlikely(r))
+		goto err_unlock;
+
+	ttm_resource_free(tbo, &tbo->resource);
+	ttm_bo_assign_mem(tbo, tmp);
+	ttm_bo_pin(tbo);
 
 	amdgpu_bo_unreserve(adev->rmmio_remap.bo);
 	return 0;
 
+err_unlock:
+	amdgpu_bo_unreserve(adev->rmmio_remap.bo);
+
 err_unref:
-	if (adev->rmmio_remap.bo)
-		amdgpu_bo_unref(&adev->rmmio_remap.bo);
+	amdgpu_bo_unref(&adev->rmmio_remap.bo);
 	adev->rmmio_remap.bo = NULL;
 	return r;
 }
 
 /**
- * amdgpu_ttm_mmio_remap_bo_fini - Free the singleton MMIO_REMAP BO
+ * amdgpu_ttm_free_mmio_remap_bo - Free the singleton MMIO_REMAP BO
  * @adev: amdgpu device
  *
  * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
  * amdgpu_ttm_mmio_remap_bo_init().
  */
-static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
+static void amdgpu_ttm_free_mmio_remap_bo(struct amdgpu_device *adev)
 {
-	struct amdgpu_bo *bo = adev->rmmio_remap.bo;
-
-	if (!bo)
-		return;   /* <-- safest early exit */
+	if (!adev->rmmio_remap.bo)
+		return;
 
 	if (!amdgpu_bo_reserve(adev->rmmio_remap.bo, true)) {
 		ttm_bo_unpin(&adev->rmmio_remap.bo->tbo);
 		amdgpu_bo_unreserve(adev->rmmio_remap.bo);
 	}
+
+    /*
+     * At this point we rely on normal DRM teardown ordering:
+     * no new user ioctls can access the global MMIO_REMAP BO
+     * once TTM teardown begins.
+     */
 	amdgpu_bo_unref(&adev->rmmio_remap.bo);
 	adev->rmmio_remap.bo = NULL;
 }
@@ -2163,8 +2184,8 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	/* Allocate the singleton MMIO_REMAP BO (4K) if supported */
-	r = amdgpu_ttm_mmio_remap_bo_init(adev);
+	/* Allocate the singleton MMIO_REMAP BO if supported */
+	r = amdgpu_ttm_alloc_mmio_remap_bo(adev);
 	if (r)
 		return r;
 
@@ -2231,7 +2252,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
 
-	amdgpu_ttm_mmio_remap_bo_fini(adev);
+	amdgpu_ttm_free_mmio_remap_bo(adev);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
-- 
2.34.1

