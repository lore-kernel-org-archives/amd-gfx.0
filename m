Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755F1C5DF66
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 14:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00FAD10E7D6;
	Mon, 17 Aug 2026 14:00:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qLySLAmh";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFCD810E7D6
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 14:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U822OR+xfsPX9uPKar2aYv0Q5XSoHnXgzD7qD1esmSclebTjjLTwEjKfeiPDCN1Ft3sVzmBhiw1R4Samd9JwKbV8k0Dsix+p1u15Sf+KZJPMglLPRy1todLHG7LX3OS3/chRUhz74nJV2eLlX3g6NIbdhMi2955HzJ05ThZBhVjrLHtmTW78qcWesBgtG3fdtUGEqkpwml8BsnuovOk5njMdz4eXJayPMe9Ybg3KJpGobKUNQwudC83+lduHV3AQqLfmDXaI0bpsr+dOdxb6jaK66xoNWz5Clzhqh9vF/j4NA3yYAWm5v6hLtKKAQXIjA2y2UVi7ItBMgEn0KbgdwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBz5Yerel0jzsEkner89A0lIkSzGkxXNEgy8OBlqZrQ=;
 b=o3m+xKE40ML8ZorYNycQY+IQf7NzRD/OYp9Q8G7pXZoHH+Kptujl1oFStBRKbvkBg3Wl7zwE74dKFP5Z4YP6KKwtTNkD0IcMrpvohqPFtz6YX8354WVrEc1zvtMhaV11m0mA2T9/dWePkAphu1uGe/hBuew1R2DwTXaS5fip2qK6mwnBhbdKO1oeIddOPofhq/Hf+N4bcDQv3QpSrDhmYeoLwakswxzurRDZkNFPH6RS1hfrX/hpRI9iw8mpqjVFAJq5jmQ4lKSvBbU7+cMEQUDpQIphAjiOrBvFiMy6ewnTPsnELOvwA6FfJ/fEYswdXpFHyiSYVcs6JuFslElPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBz5Yerel0jzsEkner89A0lIkSzGkxXNEgy8OBlqZrQ=;
 b=qLySLAmh51MqG3agIbzyFr8ZBUZlGJLe9wmXcUgmooB32wFktWg3NMtod3204r6h2LOHzRqztvCSe9AKRMIiIB/1CB8HjJGOKpQcPLag5YLZqAY1u3o1Rp92RLx79zl3tJRrjsVcqtMGof8jLUIH0HdtCGwmiL+RFgTGSacupWI=
Received: from BN9PR03CA0984.namprd03.prod.outlook.com (2603:10b6:408:109::29)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 14:00:32 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::b) by BN9PR03CA0984.outlook.office365.com
 (2603:10b6:408:109::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 14:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 14:00:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 09:00:31 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45
 via Frontend Transport; Mon, 17 Aug 2026 09:00:31 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH 2/3] drm/amdkfd: Fix the case that vm range is hole at
 svm_migrate_copy_to_vram
Date: Mon, 17 Aug 2026 08:59:17 -0500
Message-ID: <20260817135918.228397-2-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817135918.228397-1-xiaogang.chen@amd.com>
References: <20260817135918.228397-1-xiaogang.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c1a83a-ac71-487d-c2f7-08defc67e6ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|18002099003|22082099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: ojsTW94nnp3CnB6ZQg7YJ/3vtioMoOBh1WnDqxSbAHDPSHk5RJMosdqgkkdbppT5dNfoiVDdpr5WY7/4KBzEfdhR9fxXo1XiRgnL2sQYxbnwduDXbciZCaMAj/ir+HHSaiXRgMJoHnkm/1KSNeuxwKmn1Dx2wPVSzwx/OOg8AFTOtHA/Ad4oRGaO4pMV9kJI/EyWt8GfrAUxxA92c0Y6DnfrsFzZ0wM+rZunVsKf/vY3tLcHr2RS5eBYypch7r2c463zYb95xKoFog5vQNN1Z3lbcLBWrggtT2/ZfDV+xkUDHOcKHvBpcl4vf1LYtYiqA43ErrGh7EGn7Ad7nN+1qqnXcnm4GVIyxRk34tndnw+APMdHX3mH/vEmYniV3Pl9pW5CURgAXfjX36yzc3WFnj7Sg9mgLnxDgY5D0LdKdcLJQc+kl8sJtP7cdH9d7jXwn5n72WopwJwYhBPQpSrMLPIIKZr//46CFh0qAq3bSheLsV0Ordlq8+WsIQS2mEzRYgJ0MXiL8q6vu/ce0ZV0/laqunofgaFv/IIZAEW6PKRL2Ap+uCnBr3HMlLk8UIAD2Sf6x1gKIl5YYXrgQKZbJ46+yGK+VQJ/5OX4gr/3Zy4oBfY2TcqBJkBwtnD9FXdFlnzYJFoaskS0pmVU0UypbYyRcYd7GsMZDPcrq1ruYVaphDZtbbrI/FQvhSyJiSVbOb45L8waoyUy7ZFhJjMhAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VY08NylhRowK9Se9g7kdsr1CC419pWu9IW7bt4GrCXZNfzG1oy4U4mzSInWAjGC3lfGFqJsZ4hPrHrZCQmLkOV+gWSDLjRVfV2pCbg2e+W1brGsCYMqUSEPCxamtBDOKWEBcO6d2AbPHlkqi7E1QoXYUAMWjeLcuTS9f2OT8t/VP2jZFKlaLcmB1FIJnnI8QbFUQw8HveTTuU0KYlnCjRGl+3vm9N0Cl2Ny0x8t0BPrm7R9XLa9k9pJwIX09i09roEXaQB9BAYt63D03V2vutT2WvsFpkqEQ9Vd1IwKt2budZe+npUqHZ3s3uTZVisvpoIZj3+NYsFHAHf0Vo2L2CJD7P1RkB/7dsfxOiLu1PH0lcRiahOPnA53KY3Jw2oBWicJFBeIBhFT/11LlMzgTchKSdkU/z1A2L6FM2i0FjwvoZO65gjrnAT5XTZVHOkYK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 14:00:31.6884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c1a83a-ac71-487d-c2f7-08defc67e6ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

When migration vm range is hole at cpu side(MIGRATE_PFN_MIGRATE set +
MIGRATE_PFN_VALID unset) driver still allocates device pages. There is no
dma map of src pages and migration. j is 0 and svm_migrate_copy_memory_gart()
will return an uninitialized r. That can trigger out_free_vram_pages to drop
all VRAM just set up.

Initialize r and only call the last svm_migrate_copy_memory_gart if j > 0.

Current code postponed the last page to the final copy. This patch flushes on
the last page when reach to the end of current drm_buddy_block; avoids another
svm_migrate_copy_memory_gart.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index aea82da5f575..263dae49bb3e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -284,7 +284,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	dma_addr_t *src;
 	u64 *dst;
 	u64 i, j;
-	int r;
+	int r = 0;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%llx]\n", prange->svms, prange->start,
 		 prange->last, ttm_res_offset);
@@ -310,6 +310,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 					      DMA_BIDIRECTIONAL);
 			r = dma_mapping_error(dev, src[i]);
 			if (r) {
+				src[i] = 0;
 				dev_err(dev, "%s: fail %d dma_map_page\n",
 					__func__, r);
 				goto out_free_vram_pages;
@@ -334,7 +335,8 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 		pr_debug_ratelimited("dma mapping src to 0x%llx, pfn 0x%lx\n",
 				     src[i] >> PAGE_SHIFT, page_to_pfn(spage));
 
-		if (j >= (cursor.size >> PAGE_SHIFT) - 1 && i < npages - 1) {
+		/* accumulated j + 1 pages reach end of current drm_buddy_block */
+		if (j + 1 >= (cursor.size >> PAGE_SHIFT)) {
 			r = svm_migrate_copy_memory_gart(adev, src + i - j,
 							 dst + i - j, j + 1,
 							 FROM_RAM_TO_VRAM,
@@ -348,7 +350,8 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 		}
 	}
 
-	r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
+	if (j > 0)
+		r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
 					 FROM_RAM_TO_VRAM, mfence);
 
 out_free_vram_pages:
-- 
2.34.1

