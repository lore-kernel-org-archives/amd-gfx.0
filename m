Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1A2103E190
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A998510E241;
	Wed, 18 Mar 2026 14:36:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z9dvni7Z";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011048.outbound.protection.outlook.com [52.101.57.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA73310E241
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXfMEwixY+okzgspAp6OklLDsIla2zi2uKNbdJowfvpARzllVuAeIIFXBItXwRGMsaNYuOhwxSuejLn8AACsh6oy+440TKh0P/XzMGnevUTJ5KhOg6M8ENrNtUtI+6zRCvrwutic+PZfbrE1lAr5neOfXA23L4tOVJwdSAUVe6oGR0vQepvhekdrk3Ca0CFWE0bMwLrQPI+qdLBpkzsxLsJ6SlaoTjii8zdy6vjEGSJPdF9Mv8Idy+wmXntRr5U2g1C257en9hikXasRcdFMXSPqm6C/9y3F0vorEiTjtGathr6x4jejOKERsM7PSSprjepoC+Yy6YOH7OZFwCDGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/6ZblJLbqOPXZfVwta5Bi+emtkBpyDZqj7VXX49SlM=;
 b=d3NRQKzTykLpW/ooB5LnLU/dsbo3ziDxupq7YN11NiE+R3Hz0ELlWm/zeZ55KbUlwesqHu9BqQ/yemqQ2YlLUFyjOyfhFRhPV7UbbDHYzZFEcnEx6Ks11ilJGqwr9cNwuID1pMyMA1WSddeGu0VOQinB8ju6EwdVt85Ek5N76aHm8jtuwErDzfc1+lvo9QX8lkAxAsCW44szl49fe5TyGTR/nbA3zQ/W5AL8n2wGwi2zhUFXqJMJp3Fm7v6anyi7IwsXrCJHgTR41QC1PxWJ5McqiVE3FLsPxQ8zEv4vgJ+v+AqvR7P3RUeQqktJUvs+K4PE0WJ/Lj3QcmCJYQLe2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/6ZblJLbqOPXZfVwta5Bi+emtkBpyDZqj7VXX49SlM=;
 b=z9dvni7ZLBXCvH1evzu3QhSnLjsQw1Wfi4i1t8BxFJ5HICua3zVigcrMvSut3RqIzTdHCSihLrRc/fmee381rBHLII7H+e6SYuV04QdN/KTEyNIYQ+xopzJbGdTgduwnYnKfmHVW/1ErSMGp8hVDYN5HgrIobUDrHfzT8t9yfio=
Received: from MN0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::35)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:36:24 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::a4) by MN0P220CA0012.outlook.office365.com
 (2603:10b6:208:52e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:36:23 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 18 Mar 2026 09:36:22 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, Eric Huang
 <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdgpu: prevent immediate PASID reuse case
Date: Wed, 18 Mar 2026 10:35:55 -0400
Message-ID: <20260318143555.34179-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 424e5192-c37e-4911-2416-08de84fbbab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: fhPMH3iroDY0Gn/RjNjHQ31BYpKeVARNrhYlNQoGljhbc4Je3Bob8HdtmeegN/2bydhaYYd9wp4lY6V2fgs4TVY1AtYYK1XDByM/FLsMv8IMrwohc81u+xHFWbwJWvm4vAbtMZ9PThB77UBSJt46tkwn54svDP6h4tdvhsV3DFqdMfHH9cuPrmA/gZNtq+JpTby9nO5hzc4gIzGzCFlkpzgo8dDqBjnBbS2rXLWRsKfpkMKKxRsV8iezLkBpsOQetFAMTFGw8vaBQScf/sNLDZngHNUm+GnNBE5XIIQZHd3LiOLLT3a7QKhz/jpTjTyBZqv7z48vLxMKcwrNB1U3zAOY8w+kGgvbive9nPwCxGsmHD3U7/Q0AENsx8wFy4GJXONBB8lO4CazAJ3yiwUWAmAKxI+Juv/hhGXlwAU7jbSlM6XRMFw1m/sj9A3bC1kDUtyeV9ljRL018s3nMhHwGoXEF/XLm+hm+3n5h6HBUBK44S+e5cf4DhfLrHahWnvGD2NIEI8ov2/lQ8RbH5jbcwjU3ycEP9x9hqqmAtLAv4orjSwjykmOZTpFKRlEhXY1BdO1kwEcPfQdGuWGAvgrutDe2pcE6cnL5SyGGlc5H03SEg0cg0NHKmqRE1Oik29IPzHdLTmgWJNYgEWT5TEyu907PdvJRsxTxHin6sk+4zW3UhPlvtDLSNugWAvmE3ZWgpJ3P0ChEzpE1DlrzfGvrVt/tkELl60jRdnMGX63+mVSJ0wbB3pmAaCVUvfPKfzFh0GN2nTcXyyvNVRJ8t1xUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eWHmvA4aRnz6XIW1zt5UBppiRO2B92hzRyv8MJ5RuaCC9j8MDcekAKIl9HVtYaNlvhlxKoV+fA0AwX8Y2ILiTtc5wswG0KiP012VeR99CYvTa/VCQzY3V7SDkQaGzYvd5sLSCapob9Sz6sQsiiv/qNikgfowKxHk5gNZmshMhX4y1C5sPuE9fn4ym+Y+UgZN758C1irmLIelr6itsjf+vGa+v9QS6/753/JyAHob0TvFQb762M7IcZdc0cqQz4R2TICFo4rAw/PjeDzi+KGvQmd7OGol9oFFo5WjzfWPKEapaiUNqvS5gR8b19PR81NaEZxcP2zuw74u5Gy7pdK6+kmkjquq+xg6NNMuBtGAhKjp/Bs6Sy6NZ5b2gHRnifgAE/xQ1mE5cGb7KNagXl0Ti9sLKOh+Zdt5TGUwIkMja8uRpoZVqB2TnNSi97Z/GtL2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:36:23.6936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 424e5192-c37e-4911-2416-08de84fbbab7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385
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

using idr cyclic allocator same as kernel pid's.

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

