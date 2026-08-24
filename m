Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA823C61DC3
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A24BB10E877;
	Mon, 24 Aug 2026 22:14:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y1MslsRH";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010052.outbound.protection.outlook.com
 [52.101.193.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9D2F10E86B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4R30r3Uu+GjjjB9vu3A09DWas+7pUxdna2LeM2HzHMQh8/Klpk3Bt6V1H8NJozqkuyvY52fJvp/rlPD0pYGoKEB/bUbbH4O/hP63rPAvrgTYdiz4Yj1Yup0OCNT7yfghLQiFLVIxI6SEsO0a0l7cWp3CNh2RwB4a4XhKVGAGmxVp2Y1jGReKJPuVn0K5mjJUYtWCCMvUOS03kimiZjYF0pVPA9Mk/JKcSoedweZXZR16DVS5efKu8BNoyCnji13Yn56xbUb2sweKktHEFTCGgB8qroe7IozB4LSsGRRFy4K06c2AXwFft6c4jY7ROklyYOAlYPkEKRHqrQ4ZMii4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=El3hYpMhTzo6K8vFpcD8Dzs2kzlTq9yJSbRUViReiK8=;
 b=jiiHq0QkMjmK/yDwJnT3sNONbRqMi/CbwgHlwYX6FgD+pH1i3Cg9GR6ZaHy+KEw3naCmGlon19Bt7l4idjErVe3uN71thq10iLcstrPY7x4owwTKsp2vuhtGo0+UpnJ05JcdQUgiTA5Lk+vMLbXnSNIysa7QdjWlJEY8HQGQf+L9/O+fFG1uRkFpwmzr9YRgbr3cFE9rQwqzsLELZBcRphWPnoN6LlgkJXB8c16+vF+1RTgjlNOtbkwZTF+VWThVACEntdbqfaXlSeUcv398yeHhmPa0jiasvF6aqbMf1iCgpMEcph5ltHFRrRw1Mups4ghi/OS//Ye3WMhXKNkwyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El3hYpMhTzo6K8vFpcD8Dzs2kzlTq9yJSbRUViReiK8=;
 b=Y1MslsRHiH5zXM551wzh4UJTR3cMksJQlcFUepnNgwJuUEJAFQFeRj/+9eXjJCKVxYMJm83bUpcv0/FDZsGIikv02GyX3E4sB4p+SjVHw8aHkoUpHTZ8PkzsUe9sDmnphyVLEtQ/xBP9qPHAQZY2Ij0oZC2sIvXfEYbBV7GOiIA=
Received: from PH0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::29)
 by IA0PPF80FB91A80.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:18 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::d) by PH0P220CA0024.outlook.office365.com
 (2603:10b6:510:d3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/30] drm/amdgpu: uplevel reset check in
 amdgpu_gmc_flush_gpu_tlb_gart()
Date: Mon, 24 Aug 2026 18:13:40 -0400
Message-ID: <20260824221352.1793542-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|IA0PPF80FB91A80:EE_
X-MS-Office365-Filtering-Correlation-Id: 768e2d2b-4a79-4d5e-b8b8-08df022d0a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: o0Yb8Kg6YajDJXMeF+9jDpi0TvHis9nFknZB/J4QBHhb9zW1a5xd0ekmp6vn1FTD1Gs6hfpVJITAVkLQmQYFFJ2qzyjdFuUyBWF7ew1sCxY2qx7mhxUDSfHv7CAawYYTMOM92S7a/JMGXae1LVAblZPl1+WU6O53WzEd8GPfJ0URZQyRngg7hqE5xVg9D7rM5dHLq3gwN7XBF4jELFUGF00ftlIgx73yEcPo6GCVGgqawq11aC7atkkcjgZonuEfE1fkY5lAr+VyRymgZzbG7/xVpHzavUu9j2ni8co6unlSCpriLHYO4tuMy1ViUmZ9hlFNIJ49LL91CB4dpeGHsv8GNJHwBYgu72qMnm3IDH5JtEgl9/KafZN9lgBf+YmsHX5NAusqeDTKyUWOGSZZh1GfyCUGPX15SLdTth18worqEQUJbzE6G986/x6fgCMTlTu+jSeUMhU9ea2Ec6ZAbtZq7b3atameA/QcxCujGZSJd/DjmulSKdSJ0mSKI+EPe/4rVCp/e6oANvwHAVlnBFYzXqn2yquc70uRtTAjZlZqSoX/FwvkUGDdvyxxf6+Ah9SVr34WyBsEOxa/qw9m9s5R9AQqRt6AMVocfnA5g4u/nY/OXe1lYen9BG3aRlkBOUmw5IagQGLUmwI9Qi+InsTdpDVoq5b6ollWtIuW8T8dQ3CoGX1ZLCwxRzx9VUUwpAgOezjYJyApVXK2/DAqhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AsccZvY8KKYzk4OmZHwG31RBT2suP3QvetSkBzeJd7npWsST1zSTCj6VNR0UU+PuXFeHgzSnlL0AP4T9FkXH17J3O1iIrM3Nqlamm2UAKkM7Mz5Zrjlh8exx+Pm9DvGnmZF2/SIPxuk2Sx4Tf6pNrEfepGh4oM+7lvK1AIAt57xgkJZkw7SdEYhmo4CwPDuHLoiuXQSaj+r21Y2ofw3RazYZ32DvNcWOdBeq1GJkTpcAK0bwrZZfaVllPe8GRj86cEwgLZsO8voQ+N1b8FX937U9HT59kpdh5jEAEdLjnRxN0I41YBU4bssvcuy7n6ZrS1RbIg+X0oWDQqfWrDiYugPAbC3T6LKUp3juqWFbvowSW+62iFXJA5fTVha8ySjwDtBkgLO9ZgnWQrlyaODDc6UvK25ubrJcXiy30fB69fulC1wD6A4h1TcdBU7tCzLw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:17.8034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 768e2d2b-4a79-4d5e-b8b8-08df022d0a40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF80FB91A80
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

Check for both the MMIO and SDMA pathes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 779f9b0974d2e..8a975eddd75c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -724,6 +724,13 @@ void amdgpu_gmc_flush_gpu_tlb_gart(struct amdgpu_device *adev,
 	struct amdgpu_job *job;
 	int r;
 
+	/*
+	 * A GPU reset should flush all TLBs anyway, so no need to do
+	 * this while one is ongoing.
+	 */
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return;
+
 	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
 
 	switch (adev->gmc.gart_inv_method) {
@@ -738,13 +745,6 @@ void amdgpu_gmc_flush_gpu_tlb_gart(struct amdgpu_device *adev,
 
 	if (!adev->mman.buffer_funcs_enabled ||
 	    !adev->ib_pool_ready || !ring->sched.ready || use_mmio) {
-		/*
-		 * A GPU reset should flush all TLBs anyway, so no need to do
-		 * this while one is ongoing.
-		 */
-		if (!down_read_trylock(&adev->reset_domain->sem))
-			return;
-
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
 			adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0,
 							   vmhub, 2);
@@ -778,11 +778,13 @@ void amdgpu_gmc_flush_gpu_tlb_gart(struct amdgpu_device *adev,
 
 	dma_fence_wait(fence, false);
 	dma_fence_put(fence);
+	up_read(&adev->reset_domain->sem);
 
 	return;
 
 error_alloc:
 	mutex_unlock(&adev->mman.default_entity.lock);
+	up_read(&adev->reset_domain->sem);
 	dev_err(adev->dev, "Error flushing GPU TLB using the SDMA (%d)!\n", r);
 }
 
-- 
2.55.0

