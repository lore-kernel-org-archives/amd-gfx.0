Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED953FEDA0D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 18:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8030810E415;
	Tue, 17 Mar 2026 18:58:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pxxBfFbB";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F112610E363
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 18:58:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjKTwcbixUjr00CT6mkOKCEtA7g6ArQ0jhJGGs4rFoyw6YDs6s1yAR5LGIHA3TJZRxDPR/6Nl4F0En7XcZ5d523ds2N0Udevhkj2dTg5nmXxGPDJV4niW9L9UCd8p2uyLtDW7hej2dlI5aDXdirpZ2N2qopai85weLN9MOuaBQww1muvY83cWGdfHFxhvU2XxRU4sq0hhP4EdMFc2sCPjHMPu2Wr2ViaBzV9I4QxI6MbsqJcaD7J/Wg2Nvn5d3JZxz2GZoi+En2LUk75ZKcwivIYzjJugBq36h3GNYExDpPOIPJyU8QRTT/CNNgX5k8sdjnEnE1g7mrbx13hNz8udA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9LpZ2/Dd6MF3GhzBwZugv3B3X+dzdzABfYbn+Uy1W4=;
 b=rJof1627Iz0Q9tg0Eahe30u3BAPcKgSV1fMWQ2gnkR+TkhBhbx8923E9VGEA9iAGbBHRssqhNEGenm3uL93PM1UoTpshyJcLFusWbiRcMjjDQ6evlzvpafaoPqgUrO72qx3oV295aR1SOgL5s7Eer9fJi8JCOVvex2gn0/ouWC0vITPU7zXfXkhy0sweTg+2XQyotJ+KD7P/MYxPlY90dml2hh30Jj0v0WQtTFNXQFOUdJbymjERO9/R5DuGs18QkdMr84QHSDTPRmXrxtL+rYdjM/QlqyO/mTlFh0U3yyEpzAVdo6Xthw5OgMmkPLYoZIlX1zvhVK9DzmY7nLCPmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9LpZ2/Dd6MF3GhzBwZugv3B3X+dzdzABfYbn+Uy1W4=;
 b=pxxBfFbBdwgJMn0B3ASuzDXU88sPQYnKcfyjYst8dUaNfSr32kGRSgP7rXHB+4TzS/PbL5+ZG47INofCptkE4pPD08WGo/30N/F5tTb7feTnZxjYLgRf2yMcR17ypoYMYKFLI07kB+Z6YggUeMlew7C+PmpY1p+mRAZENjHppjs=
Received: from SA0PR13CA0011.namprd13.prod.outlook.com (2603:10b6:806:130::16)
 by CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 18:58:19 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::3c) by SA0PR13CA0011.outlook.office365.com
 (2603:10b6:806:130::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 18:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 18:58:17 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 17 Mar 2026 13:58:16 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, Eric Huang
 <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdgpu: prevent immediate PASID reuse case
Date: Tue, 17 Mar 2026 14:58:01 -0400
Message-ID: <20260317185801.149610-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e63b831-4ceb-46ae-2c39-08de8457265e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: czAfIeqCgOMoejKdAOC66+0lCuMDf3oKx5sDescc8iDdo9q3rcI0JVNgXj3xfceeD7ZSg48/bm0Se3r4x2woB/pcwy4VisIgZmqXzY6Whe9JsicD3yBTUFp9O2QalQ4sXdPy80sxiwfYk1CM+oMb+OnL3JhAqo8mMU49kIWChwFJzqnSwsBR6suDgTodB/ees0NaqNXKYJUetcyN5olsLnoVp9NBf8IaJUj90yS2kQazM8sQbe10x8ivO3rY8jTYhP78CucsAgUGQYVDsGgjE0BAv4vzDNeLX1mTs4cQDRMmHYYtcsiXKNaLavI/zoL3gcIexKGkWNC9k4BdqL9UExVuYi1mOhHN/Eow6Z0D/+KRolL/aZ0B5Ip2wh189o+2vhKx/FkJQJMc/t8n9tmfUY334HOe3JhQ+Y+k16VrFF19dzQAYYAnFAjcv+iyqyRSNyi4U97uAeyLangsyFbQnyPEvA1K89WsZJkj5dcd0Ht8rHTuHV4cjM5mpoL8yOqbE8vTVWw5bhr+WFhh/0FXSWB8HsOrSc2W/eeZF8uAi+RC7VNQwcNutOiIviiX8qGS5lDntvUlwHfFzt/v5KwuRfwRyIAqouaZKedA4YSNpS2Hps313gjnWRa5Lp3WI/WDVi1OmTZBV5FdrzdsA3JOYSYYRU3mzkwTFN15SCHb0wD3BiBaQLNtJZZ75yh+R4AkUmIMqzLYePLjY2f4mI4At673uvyvx3b8kgeoKhcAiT+NiKlN9D5Fnv9CjGadYN9el4xpvKpqTnTySB8SHsHQIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d7DhRSV2WxvjhwZAYSa3iA9TciwN9BhKYmDT1EA6OUdeMt2GWiq4as/A00BLSyHyZSMg1uSS7lLZ8wWsvkv+vNWq+BvhHcn6x1NXBfLsQGBTOPPGM80QCIClG4ZARmWoFaOghiSBSPlpDtfeVlzTB0DBy+y/Z0NxO8M7aXq3xKQ8a0CinYLr4sU6DqFIs3M9bqSc9Ze0gh2SrEmgSk/gpg1/XX8rIGF2L7BoIjHBR6SICm2MGNMoohD0Ug6KaTSOYo8Yi+Rhu1KWgbqdguKiMZjVwOJIOhsVmSPO0QjWf9m0ATfPHUC+UWwHvx2rTp2uPOS1APfKkd1jTjmhATtQwO60F6RUpAgKIqSQGX6ihPWy0UCPmZTNLAI4YrwR3xzaxk2/A6zyBZdg+ACv/1O5Kiwsjp3W/F2HkNOSMpr+yjhb8HqTAgLatWNJi2n+OPJ4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:58:17.3309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e63b831-4ceb-46ae-2c39-08de8457265e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353
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

PASID resue could cause cache, TLBs and interrupt issues
when process immediately runs into hw states left by previous
process exited with the same PASID, to prevent the case, it
uses the same allocator as kernel pid's.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 45 ++++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  1 +
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 9cab36322c16..0801c023f5a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -35,10 +35,13 @@
  * PASIDs are global address space identifiers that can be shared
  * between the GPU, an IOMMU and the driver. VMs on different devices
  * may use the same PASID if they share the same address
- * space. Therefore PASIDs are allocated using a global IDA. VMs are
- * looked up from the PASID per amdgpu_device.
+ * space. Therefore PASIDs are allocated using IDR cyclic allocator
+ * (similar to kernel PID allocation) which naturally delays reuse.
+ * VMs are looked up from the PASID per amdgpu_device.
  */
-static DEFINE_IDA(amdgpu_pasid_ida);
+
+static DEFINE_IDR(amdgpu_pasid_idr);
+static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
 
 /* Helper to free pasid from a fence callback */
 struct amdgpu_pasid_cb {
@@ -50,8 +53,8 @@ struct amdgpu_pasid_cb {
  * amdgpu_pasid_alloc - Allocate a PASID
  * @bits: Maximum width of the PASID in bits, must be at least 1
  *
- * Allocates a PASID of the given width while keeping smaller PASIDs
- * available if possible.
+ * Uses kernel's IDR cyclic allocator (same as PID allocation).
+ * Allocates sequentially with automatic wrap-around.
  *
  * Returns a positive integer on success. Returns %-EINVAL if bits==0.
  * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
@@ -59,14 +62,15 @@ struct amdgpu_pasid_cb {
  */
 int amdgpu_pasid_alloc(unsigned int bits)
 {
-	int pasid = -EINVAL;
+	int pasid;
 
-	for (bits = min(bits, 31U); bits > 0; bits--) {
-		pasid = ida_alloc_range(&amdgpu_pasid_ida, 1U << (bits - 1),
-					(1U << bits) - 1, GFP_KERNEL);
-		if (pasid != -ENOSPC)
-			break;
-	}
+	if (bits == 0)
+		return -EINVAL;
+
+	spin_lock(&amdgpu_pasid_idr_lock);
+	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
+			         1U << bits, GFP_KERNEL);
+	spin_unlock(&amdgpu_pasid_idr_lock);
 
 	if (pasid >= 0)
 		trace_amdgpu_pasid_allocated(pasid);
@@ -81,7 +85,10 @@ int amdgpu_pasid_alloc(unsigned int bits)
 void amdgpu_pasid_free(u32 pasid)
 {
 	trace_amdgpu_pasid_freed(pasid);
-	ida_free(&amdgpu_pasid_ida, pasid);
+
+	spin_lock(&amdgpu_pasid_idr_lock);
+	idr_remove(&amdgpu_pasid_idr, pasid);
+	spin_unlock(&amdgpu_pasid_idr_lock);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
@@ -616,3 +623,15 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
 		}
 	}
 }
+
+/**
+ * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
+ *
+ * Cleanup the IDR allocator.
+ */
+void amdgpu_pasid_mgr_cleanup(void)
+{
+	spin_lock(&amdgpu_pasid_idr_lock);
+	idr_destroy(&amdgpu_pasid_idr);
+	spin_unlock(&amdgpu_pasid_idr_lock);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index b3649cd3af56..a57919478d3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -74,6 +74,7 @@ int amdgpu_pasid_alloc(unsigned int bits);
 void amdgpu_pasid_free(u32 pasid);
 void amdgpu_pasid_free_delayed(struct dma_resv *resv,
 			       u32 pasid);
+void amdgpu_pasid_mgr_cleanup(void);
 
 bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
 			       struct amdgpu_vmid *id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b89013a6aa0b..5b9bdb79efcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2864,6 +2864,7 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 	xa_destroy(&adev->vm_manager.pasids);
 
 	amdgpu_vmid_mgr_fini(adev);
+	amdgpu_pasid_mgr_cleanup();
 }
 
 /**
-- 
2.34.1

