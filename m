Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2837C8303F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 05:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44CEC10EB3F;
	Fri, 29 Aug 2025 05:54:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h4CO+3nt";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7260810EB38
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 05:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjmLWqvaRV2SscIEIwjCDT+QmAedzGqtKs9WX4UqCH2bOPhdn9yWZ8YlJYLqh8bQfd4UPLakkXgBs5BvVjA7ukmwtshL8lN5NudDNBZ3f+dqqRiHcmNXFgF/BSviZ3rBBXDjlc3BwIZCx/Y+Ei+pCQzqZjgz4BWSsGpmaogz6WtVukhxVoXVV7KRi2Y6U0SkA4Dg1NSrVYt3XIMCjpGqNHQIqlTxUvQLCjSQ0XBlTaQmtgchI2Ktf6MpbTLqsU55wg7WA0QNzTjZLR3x7P77KF4SOdF3ua7a043PLHU7x2etpINhgJbvNVvE/DtVS4qTCPVU8bQtABwKdUYxdwu9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH7bfYD2ZqI1qCg3IhEdVoijuxi8EssPmSOJfQ+WWMA=;
 b=T2N6s/r7fuwdRqRfAVBdBAZ6s3wkRj2mTGbY4UW/eCjN67VfTz409RfksYa6vSkxfj0cvbnyqN4tLEdgOpqacks1SNa4zbxs6E0RUwMnGSgcbeBPsNT5uLJYlS3wn0xTtpK5OA01cBo6IiDyC2g83mbbodyGRacjAqHgGpd2CM35oKKKBDca+D267Sr3roHRHQHceZ7ZHVNtzSJzmo3HG/7kwmN4REz1UpN3zQE8QcQdnkPnLd2Lh8ha/9CPsHSuxupy70J7CPrU47OeQkuQks50JhP/+N1ulpM7i2QttaGzqe1bBKvcr7h1lp98jb4K1l/Ps0pPsWyWDEPid209AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH7bfYD2ZqI1qCg3IhEdVoijuxi8EssPmSOJfQ+WWMA=;
 b=h4CO+3nt9bbLjQ9QdUtrGOVhcfVyeoYhsosy6YFf0aQGzvsXPfuXOofeoDQd+oSX47jp2pZaIEJHs8p7S5gD1IXfd5oVZC+hpvBwSwPpB0Cn20SNo/4fREuDKHn8cmZufV105yIfmFhZq9/Q5/rntRRAa2ETYSaaBAnH+fAePxk=
Received: from DS7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::17) by
 DS5PPFE52C859EE.namprd12.prod.outlook.com (2603:10b6:f:fc00::666)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 05:54:46 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::6) by DS7P220CA0003.outlook.office365.com
 (2603:10b6:8:1ca::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.20 via Frontend Transport; Fri,
 29 Aug 2025 05:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 05:54:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 00:54:45 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 22:54:43 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 6/9] drm/amdgpu: Implement TTM handling for MMIO_REMAP
 placement
Date: Fri, 29 Aug 2025 11:24:35 +0530
Message-ID: <20250829055435.3983526-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|DS5PPFE52C859EE:EE_
X-MS-Office365-Filtering-Correlation-Id: 8886dd64-55ac-461b-a699-08dde6c08ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGFUZnZDRzFsMUdKWVFNVnBkekg0Yjh0cUZ2Nm9WOWxLMTM3a1pYd1o2U0hJ?=
 =?utf-8?B?VWt6bGlTb2xhQ2FsVFNoem1XcEo5Q3BJdWoyUmg2NXVyQnQ2dHRBZlBJc2NP?=
 =?utf-8?B?QUtGRTZzRWV2WDVkN1RsM21lNklmOGZEb3BOeHA1ZGc0K2NGUmgyRzAvOXFU?=
 =?utf-8?B?RFBtcUVZSjRnVXRsRFB3OFMxNEhBUitpdmdkMzVzOUoxRHFiczJrSGpqVGJi?=
 =?utf-8?B?cXJQTXhPRTlIRlA0WEt0RVJpek9pVEl2NzJTazBjRXFUVnhka2xTVFlXR3ow?=
 =?utf-8?B?aGJLNUh1dTFHYUw4TTRxYm1oengvWWZaQi9KUzFXU1B1Y1lGYncxK2kzR2RM?=
 =?utf-8?B?NlNkV0VkYkc2eUh2aUR4YXFwajRIeXlVNm5kL0VnYWJkWXhRMVNXbDZtaDhy?=
 =?utf-8?B?QVp5em9xK3JWYXliWWVMYkZJcERUblJLV0FRdGFqUHQ0R1ZQR2xoaStMTEht?=
 =?utf-8?B?QXJ1ZGowRkJpVkRHNEMwcDZEUUhyNlJZNk5mNWZZaVdtbnYvNHExU0JzV2ZB?=
 =?utf-8?B?eXZjYzcyZFk2Z2VGb2dhOE5QM1hUV2RZUUZPZjBYd0hJV2N5NGhackhqV1Zx?=
 =?utf-8?B?SENkWDdJUkZoYlJ2NE0zWFc0eUxTWmV2dGdCQzZZVXV3VUJJOE5xVTRkVkcv?=
 =?utf-8?B?YkMvU1VsZVpHMUE0bElaYm9SdzhTVTd5K0FhdXowcThKRWRaMDcyUWZFc04z?=
 =?utf-8?B?eXZmckxEdWpsNWo0UjNBWlVBSDZvOE4vUlFySm5ydFdLamh3S2xWb05CbnpD?=
 =?utf-8?B?QVJJQWZoemJZZ0pBN3pQSWh4enFVRGlNcmJINm9vWUJlN1NvQnExdkt5WGlj?=
 =?utf-8?B?Q2daT055SnNlREZSeTQwcEVXL2x0clMvVVVlVUdTdWlZRnRWcmlyZkdrUXVt?=
 =?utf-8?B?a1RyNkI3aGUrTVp4ano2bVlIM3hJRWxqZ0dPWG0zc096Ym5wODRKaHRBeENi?=
 =?utf-8?B?Wk9vYWJWWmRKcXI0OWJGVGxJaXFaRWQvSlpIc2kraHBaQzI1eTUxZkFua2lH?=
 =?utf-8?B?ZU1iSW1rVExEQldob3FIaXVQNm1sY0VBMFl6TkUwZVlYSnhLcnhZMlF1Zzh0?=
 =?utf-8?B?VnFyM1Noc1N4NlNlcHpKWWNyVDNlMTluMWVNNDVHVlR0TWI0WWIzb2pkYlJW?=
 =?utf-8?B?MWNPdHRPa3E4ZVY3cGJkcDFWcVFTemN1Y3RHYUhqMGJ5aWZ6NFZnWW81SUR4?=
 =?utf-8?B?SE5MS2NQanJLTldsajlmbUpVNWQrZC95TzY3aDJwdWNpY1ZyTlJmcUVMYkNY?=
 =?utf-8?B?bDdKK2xJQmEvN1lKY0pJRXpTbW1QVU9BYUhoQjdvQTlJZ0JET29YWU5aYmt5?=
 =?utf-8?B?eUdSQjhDbWhnbzczZVlTcGpJaDFybHM1M2l1RHlHcndhcHRtQlV4U0M2STFm?=
 =?utf-8?B?TCtDeVFOSUl4NXJvaHVFcDVob24reUtKYVdSUDk0VHVFZ3I2SXRJUzlMejdW?=
 =?utf-8?B?VnFnUE02S25GQkszSEQ1djRCZ1pXMWNiYU5jTmN0b3k4MlBXQWYyUUFJMEpO?=
 =?utf-8?B?ZWNqd0dtSjl5enFMZ241eERrV3E4QmthTVBHbzdGdjB2WXJBMFl3UlN5UnRr?=
 =?utf-8?B?NGJVYTV2NElNMVoxNVl2cTNXajhoRFJTcFRNb2o2bjZvYjU0OGVNRWkycnZQ?=
 =?utf-8?B?bVZvQVdMUGswRDZsWUpJSmtrQVUvNzZJTUVJZHBWZyt2VVNHQVpDeW5ob3Jv?=
 =?utf-8?B?WnNWY3ZWUnZhUXZ0eTUxYzhCMGsxcVdZcW82akVDREdYdDJndGpGczcwdHJ2?=
 =?utf-8?B?ejl0ZTZ4ZkMwcTVZUGQzZlhKTDlWMmdsUlFkRnp5bUNOL2hFU1RjZ3VURGo3?=
 =?utf-8?B?OUdDUzJjWUdLOGlNak0weGwwbXhmdk9qeFRLV1B3QlE0Q2lmcWU4QkxnVXlF?=
 =?utf-8?B?Z2x3N0lndDlKRjRqN1BGSExheDRSc2Z0NXZRVVFTODV4N2kzM2ZneEorOGZE?=
 =?utf-8?B?RCsvMjRUa2lPekJKYVJlS20rNUsxbTR2YnBuc0tQdnF0Qm5OQ2luOXNKUTJ4?=
 =?utf-8?B?cUNBcWVVZFJOdkxTUyt3bmE2S0MwMU81OStMTkpHOUhDbGZjT2k3TDdsaHBK?=
 =?utf-8?Q?XxAGkb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:54:45.7065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8886dd64-55ac-461b-a699-08dde6c08ea7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFE52C859EE
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

Implement TTM-level behavior for AMDGPU_PL_MMIO_REMAP so it behaves as a
CPU-visible IO page:

* amdgpu_evict_flags(): mark as unmovable
* amdgpu_res_cpu_visible(): consider CPU-visible
* amdgpu_bo_move(): use null move when src/dst is MMIO_REMAP
* amdgpu_ttm_io_mem_reserve(): program base/is_iomem/caching using
  the device's mmio_remap_* metadata
* amdgpu_ttm_io_mem_pfn(): return PFN for the remapped HDP page
* amdgpu_ttm_tt_pde_flags(): set AMDGPU_PTE_SYSTEM for this mem type

v2:
- Drop HDP-specific comment; keep generic remap (Alex).

v3:
- Fix indentation in amdgpu_res_cpu_visible (Christian).
- Use adev->rmmio_remap.bus_addr for MMIO_REMAP bus/PFN calculations
  (Alex).

v4:
- Drop unnecessary (resource_size_t) casts in MMIO_REMAP io-mem paths
  (Alex)

Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 27ab4e754b2a..5f378f5c9350 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -123,6 +123,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 	case AMDGPU_PL_GWS:
 	case AMDGPU_PL_OA:
 	case AMDGPU_PL_DOORBELL:
+	case AMDGPU_PL_MMIO_REMAP:
 		placement->num_placement = 0;
 		return;
 
@@ -447,7 +448,8 @@ bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
 		return false;
 
 	if (res->mem_type == TTM_PL_SYSTEM || res->mem_type == TTM_PL_TT ||
-	    res->mem_type == AMDGPU_PL_PREEMPT || res->mem_type == AMDGPU_PL_DOORBELL)
+	    res->mem_type == AMDGPU_PL_PREEMPT || res->mem_type == AMDGPU_PL_DOORBELL ||
+	    res->mem_type == AMDGPU_PL_MMIO_REMAP)
 		return true;
 
 	if (res->mem_type != TTM_PL_VRAM)
@@ -538,10 +540,12 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	    old_mem->mem_type == AMDGPU_PL_GWS ||
 	    old_mem->mem_type == AMDGPU_PL_OA ||
 	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
+	    old_mem->mem_type == AMDGPU_PL_MMIO_REMAP ||
 	    new_mem->mem_type == AMDGPU_PL_GDS ||
 	    new_mem->mem_type == AMDGPU_PL_GWS ||
 	    new_mem->mem_type == AMDGPU_PL_OA ||
-	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
+	    new_mem->mem_type == AMDGPU_PL_DOORBELL ||
+	    new_mem->mem_type == AMDGPU_PL_MMIO_REMAP) {
 		/* Nothing to save here */
 		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
@@ -629,6 +633,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
 		mem->bus.is_iomem = true;
 		mem->bus.caching = ttm_uncached;
 		break;
+	case AMDGPU_PL_MMIO_REMAP:
+		mem->bus.offset = mem->start << PAGE_SHIFT;
+		mem->bus.offset += adev->rmmio_remap.bus_addr;
+		mem->bus.is_iomem = true;
+		mem->bus.caching = ttm_uncached;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -646,6 +656,8 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
 
 	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL)
 		return ((uint64_t)(adev->doorbell.base + cursor.start)) >> PAGE_SHIFT;
+	else if (bo->resource->mem_type == AMDGPU_PL_MMIO_REMAP)
+		return ((uint64_t)(adev->rmmio_remap.bus_addr + cursor.start)) >> PAGE_SHIFT;
 
 	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
 }
@@ -1355,7 +1367,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
 
 	if (mem && (mem->mem_type == TTM_PL_TT ||
 		    mem->mem_type == AMDGPU_PL_DOORBELL ||
-		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
+		    mem->mem_type == AMDGPU_PL_PREEMPT || mem->mem_type == AMDGPU_PL_MMIO_REMAP)) {
 		flags |= AMDGPU_PTE_SYSTEM;
 
 		if (ttm->caching == ttm_cached)
-- 
2.34.1

