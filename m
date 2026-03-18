Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914AC103E198
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 15:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28E4810E856;
	Wed, 18 Mar 2026 15:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l7r2wFHG";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60D0910E856
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 15:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCX7v66XU8VBJF0cgB/bHKwDdUHWAwc0NdAj9MeRQS2hClXTRGhc+iMmO7XanRDOX6FOxulWLZKSdAUgLE8qc/xrJ/AxM22OmFDwU9cgGGW7gnNPoGbeQL60sb6hBw/jquXBUF2F37zhZ7kOkGSSnJNThpHkpwnPA0ns+qJsJDJwl1MvaYYIOJFpcJv9zDSGZQnX6HxrvZqAfZFWwNUOqFpc5aqm6TsRuNDuDSq2xjdUPL9jQdq7ZTh8O/2javBADdkDgGIyysHzE9wzLoAA0gfB1gF/F1n05GP28um6c1NjqgwvUPHtq19bSS4N7ei8cuRpGP1p1yr1M3EnLSJGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0o0qeOHs8m6g70/wgEzfaBkOP5IlMNtaBQzt+Y3ih2o=;
 b=WuYC+f+oRvwMHL0nPsOaR6SgZ1ax9NvKZhkMbr3jKgtgtxtlkX0IuUV5NMftuIm1eg3LkZYVQFPeJfxlFWK+9hChc846iR/5EHBFVUFRiMf0tHHNjynBrgHgP3IDL1aqo/01AKFcQzvmTPnEp18SJsRXla7S2CaW1vuksN6p6oqQTfGulkYYRObIjZfwmfHsFFOlS7XSF+vBJdikX99CuWAFa2OfHskAXJTY6ioL8tY4McRkzi0fLr7+bbz1f1l7abYOMrEkuaz1g6G1u6M70WAtsNluMGKsMdcUHmB5WDWlZW01ws0CUO7UFtRtc78+EZCf8uAq33Mb70n2WX0clA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0o0qeOHs8m6g70/wgEzfaBkOP5IlMNtaBQzt+Y3ih2o=;
 b=l7r2wFHG6N64PMRtMzT/UzBJqyl7A0H9r16EesJ8nygxhqrVRI2RRkmVbRmS1fnxAWExn/XYCYQoqZBlARzI++rB61aF4Oj5RiTbJMLbVZrUL2o91f7xxuyCqp4zdM+SfC25uC2rxw7DK5MnhkwxZj/DZf8naHwiRVaZhM1mgNU=
Received: from PH7P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::24)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 15:08:31 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::65) by PH7P221CA0027.outlook.office365.com
 (2603:10b6:510:32a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 15:08:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 15:08:28 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 18 Mar 2026 10:08:27 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, Eric Huang
 <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdgpu: prevent immediate PASID reuse case
Date: Wed, 18 Mar 2026 11:08:14 -0400
Message-ID: <20260318150814.48340-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DS0PR12MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f67d8d-e0e2-46b4-9363-08de85003609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: LWwt7DP3XLrA1blT8dneKtE7FaPS3+6bPC0XkD9Q42HPN5hSvogmZec1tKyA3Wt/4hdYR3yM8XYZ0mUImfvbhxkFhE5MXO1Onm7iQg1188YyBN2iJodxJ+j+JxqyRhGTWAktRTPemwWz1h/y+kYz2pLI5hmMk5XYwY2Rf1cebtKuYiyE3hMl9vL/55SqArdEZAAkSy2MFM1Ca6XMzGY4U5eiSwbzAgHWP5e2Ny0dPIw3YOG5YxQirOjKGcV9SgxGwzd3/flx7r0rqE/Dv7dPy01Xv3x8VHIHyrQjXOQaA2EZhrVpCfzQ3EKYIADaV8etsZC2XT68BjY6863jfA3B8p580fRs2q4l85mpXxkF7JccKCLK7KUagPkaEhn5My6cLdrP6UlatssFOTDiR8neicUgoraoMnY47TCauFAHaFSmoz98xvLgGuVy7Jayz3ek+xA0MsW+2x/XB57iPieOYmQ24s5F3wxH7Xer2rGVIch6es2ymecP7Fc+Z9udlLPHzDlho5q5RnobxPY+zJNCWuaQxiY+pVR7fYKVITO1eNG7SkejkuU7og+JdrOYhfooeE9O7+3OLnRUFWmFqgTh2HTRls85e/+HAzy7CfBGTkL4giZD8uQP1bosP6kfp/OFzbyCvjNkmhe2fBlif7Xhrdcvfw1MA560gKorX1XPSTmCgfM4fJoIZik0hy1KhAe00gmOW21P5V3tLLLr/j6hl10YnvLnc9RuU9W+99pv7kzP+waO/1kx5SQqTBFB/Pjkzrf+SC6JND7xzBccZ8N/Lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yBzVjlnbCLWBiPUlOQyTA6VIcwmdR8YbCc34Uz1jW/fQyYX9pfNHOlPQnvgYqxxNcE+DuW9HFy7WQEgQ+R6pOX8Ff8ZnLrdK6ImjmcXXEAyA8jjp59XDb+jl9GyiJZOcI6/xAr/8tRfbVD51nqn+vNEUKUP+k+EJQVftICDZreYpzeAFyubftJjzTjw3C7rzj7jN8IQlAHIPWmbYsFxsnW0pvRWk7vD41ldZHhBNvRNX4jpK1g9BwA7jvvbQvbcJkPrJw2+bUa5ksKHUJL1d0XkJvwG+fEIvNvWSi9wPX0ssvt7DdqOj1GoGpREJJUXQxFN4CBJRP8rWbrIGytg3MT/yO/xeuxs8vODWk/+8EaYtLlmAH6pVYRDHFnVJP5i9tLNlRo6chupqYPW4tJ28UlanRy1WHsqjCHMQkKH5wZxS+eBLJwDWrXDH+VYZupCI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 15:08:28.5861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f67d8d-e0e2-46b4-9363-08de85003609
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606
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

PASID resue could cause interrupt issue when process
immediately runs into hw state left by previous
process exited with the same PASID, it's possible that
page faults are still pending in the IH ring buffer when
the process exits and frees up its PASID. To prevent the
case, it uses idr cyclic allocator same as kernel pid's.

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

