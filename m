Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B81C44501
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 15:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A5510F168;
	Wed,  8 Jul 2026 15:27:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O61AR3bz";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010020.outbound.protection.outlook.com
 [40.93.198.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3760E10F168
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 15:27:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0cSmQ1VnElhxvVdj1d68Rh6c2gzqVJKHVFi/ipl6Ter196HJ5RJ1jXdvu+1BrzO7RvuaNo/x2cD1qXkFcuPamXLdSn0V2zSwCJWgVHFirSjg8cvKV11BzpvWfpkI0MUOVeQ3cfJo9goz9K7aPrdHjTDdqVpVnyqWYszW67Zn9i09dtJIZ5wWYDiH6YO5QffyJHjpmT5ImZqFbtHdcbgGnC7FQhaAoXqPD9d1dPpWogrffi5P/SGmrA3/MpIk68oiBq4JcJYXouW/Ewi9z8XegLWX+Zl/HbSVEmlYrJ18or6etdYRyY64rp99/uNHKt0anQF9dPJOiG3s+lOwIiLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCgssmL87vFGOd1F0WdRczANnWL9eV+zyB0uZIHvg5w=;
 b=b+rGY2/Y1Yqwc0FAU0OxULC6OvpruSQURM6fuEA3QOVfLy0sYdvPVQ0NfFVn17cViOBmVR37+pVaYDj3dVbnlHiCTGIIdDHoO4dEfReegrRiWVFV4pbgjwKZekyd+4b8uoIhzBgS0t/DaRI5LAmbqrXb8AjQ7LCxKrfr6d1eRsSWuNnoGJc5zTwp+nqysHo2Ou5H7kyGWQW4nM3hBc5MeBMspEvFK5sA6/QmT42TBjV72EP2WfiZJm8EjImT49Ro4CulQYFRUOssQDKeUgX1OEGzm7GuWtU6RZVH0V8OOcGBpdUrlVrq2mDVpWPV5e//bU+reB+4dP1/MAwmChlYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCgssmL87vFGOd1F0WdRczANnWL9eV+zyB0uZIHvg5w=;
 b=O61AR3bztWkz5ELeJYoN5TPASNbZvQgidE91zGPdjm30fK0d12MX55YPiVcNa+EZkcTxJhK0Qt5r61SKQWIJr5WlOvLIm4e14XIi3ybXobY94mxv7TzV4c4prEL1tM6ciHCmJuc9oxeKxVvLDUzCVvMmgwtubv+PaDQKfXo9fSY=
Received: from BN9PR03CA0435.namprd03.prod.outlook.com (2603:10b6:408:113::20)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 15:27:47 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::2e) by BN9PR03CA0435.outlook.office365.com
 (2603:10b6:408:113::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 15:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 15:27:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 8 Jul 2026 10:27:45 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 1/3] drm/amdgpu: Allow PASID allocator to store fpriv owner
Date: Wed, 8 Jul 2026 20:57:27 +0530
Message-ID: <20260708152729.3209550-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708152729.3209550-1-srinivasan.shanmugam@amd.com>
References: <20260708152729.3209550-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c1e402-08c1-430a-9434-08dedd057713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cDM31aC1FLbweX19v89JINPaA6/Q4iihucjFtRRnotZ0Ne9QGYZVpNJ51uQsvaAF8Pgr1/3p+dsogG6HynzoQ2qIl9LxluoCjvCkm65hX3Mm1vRLcG9o6dwz5QbhDzvdhqggBxChmqb0Z1xjBeDY3UQqdtTWMp90Hh/Om2tDHmvAIKEMn7+eK6sN8ha730E16I2qiPULYn4ERlKtCPovhRelowdSvRlal3AhsMbXw3vXRaxTMQ/71HeqfhKGsJn3XT7DLTuqeIltMksR2LvA6tiSsbVWYUkT1TvR7iOe+rTZleaLOFSP0JjpddV6dv4t8NOZURiC1Xdk6T6l3OlEgXxqE/euR7OMwi7ftuV1m3CyIYEGbX8IkibFXrmRhBgNDhx96ASDGWJrU4jyOCrd1IoCetjLkTWTQAf5XBKpdohS+eri5kwflZy4JQoTam7zL0fovjG0yrHkkhuIUwLc2RgG7S7l1r1CZ967HzSc6L2BYVxdH5WZh6h36UO8c0B9u447SY45/UkQgzPXDLZRL54FgvqHVMul+pcrYUmtuerxenePTbkGhglhgwTWutxfv8QcRTFz7pOZsZC9KpJQTpIvv/flaSukezSgOPtTJgjkQ4VvCvGzbnVakLF79vH0Z8/0BGqDnzX/l3wc/odQyd8VYsaNzC49TUwpfgWte3PhJXFYe/A8Dx7FnYAHy1wgr47nj+ayO6MH3RKbRnTQ5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oJHk+LJ1aUORhUq031qKKL4PcKYCGD/lICB4z6Zw3PGi9+HczzESkE8UJDMSLgII9PryDJ0FjNt9dUnhU67wdvT2LXI/QvFFa0+lTwElW6OUv1G1jyZyPb6y6PmA646Lpb/V5JupUwHKRMPQJ0noTs6IhXTb0f9z82D3oyzVpUyCvjN+m4cBKiJn2Z3kLTlZzqNFVykzqcIsmXv/qlUewCM8AxyUoh/lf6UcwjXO2RJr9AxEAMhdfwTEtUNwDA3MyzcD80K1jJUcd2IcPePZ+/hqKM+zRlf4naQaLmnRMQL5U6VPLRHRfmPdSTnFK9OEjc8/zycUpiT5/zWv7kkftJ3/YxlOXYOzLUoPOJT9uCNdQR1JEZBqJzn2cRC6JBJ/jwnAeKvD+UHXc80jK2v4mm7MB9iaYxxHP09cGJKDeb+XTKf+p+b8bBibNgp/dMGQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:27:47.5098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c1e402-08c1-430a-9434-08dedd057713
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712
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

AMDGPU already has a global PASID xarray used for PASID allocation.

Allow amdgpu_pasid_alloc() to optionally store the owning DRM
file-private object directly.

Initial callers pass NULL. A later patch in this series passes the DRM
file-private object for DRM PASIDs.

This prepares for using:

	PASID -> fpriv -> VM

instead of:

	PASID -> VM

Clear the stored owner from amdgpu_pasid_free_delayed() before waiting
for outstanding fences so PASID lookups cannot observe a stale fpriv
while the PASID itself is pending delayed release.

v5:
- Store NULL instead of xa_mk_value(0) for ownerless PASIDs.
- Simplify owner clearing by unconditionally storing NULL.

v4:
- Add fpriv as an optional parameter to amdgpu_pasid_alloc().
- Drop separate amdgpu_pasid_set_fpriv()/clear_fpriv() helpers.
- Clear PASID owner from amdgpu_pasid_free_delayed().

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 69 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  6 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  2 +-
 3 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 684f40fce73f..d41601aab3c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -52,6 +52,7 @@ struct amdgpu_pasid_cb {
 /**
  * amdgpu_pasid_alloc - Allocate a PASID
  * @bits: Maximum width of the PASID in bits, must be at least 1
+ * @fpriv: optional DRM file-private owner
  *
  * Uses kernel's IDR cyclic allocator (same as PID allocation).
  * Allocates sequentially with automatic wrap-around.
@@ -60,7 +61,7 @@ struct amdgpu_pasid_cb {
  * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
  * memory allocation failure.
  */
-int amdgpu_pasid_alloc(unsigned int bits)
+int amdgpu_pasid_alloc(unsigned int bits, struct amdgpu_fpriv *fpriv)
 {
 	u32 pasid;
 	int r;
@@ -68,9 +69,9 @@ int amdgpu_pasid_alloc(unsigned int bits)
 	if (bits == 0)
 		return -EINVAL;
 
-	r = xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
-			    XA_LIMIT(1, (1U << bits) - 1),
-			    &amdgpu_pasid_xa_next, GFP_KERNEL);
+	r = xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, fpriv,
+				XA_LIMIT(1, (1U << bits) - 1),
+				&amdgpu_pasid_xa_next, GFP_KERNEL);
 	if (r < 0)
 		return r;
 
@@ -106,6 +107,64 @@ static void amdgpu_pasid_free_cb(struct dma_fence *fence,
 	kfree(cb);
 }
 
+/**
+ * amdgpu_pasid_clear_owner - Clear the owner associated with a PASID
+ * @pasid: PASID whose owner should be cleared
+ *
+ * Replace the stored owner with NULL while keeping the PASID allocated.
+ *
+ * This is used by the delayed PASID free path so that future PASID
+ * lookups cannot resolve a stale DRM file-private object while the PASID
+ * is still waiting for outstanding fences before being released.
+ */
+static void amdgpu_pasid_clear_owner(u32 pasid)
+{
+	unsigned long flags;
+
+	if (!pasid)
+		return;
+
+	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
+	__xa_store(&amdgpu_pasid_xa, pasid, NULL, GFP_ATOMIC);
+	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
+}
+
+/**
+ * amdgpu_pasid_lock - acquire the global PASID xarray lock
+ * @flags: storage for interrupt state
+ *
+ * Acquire the global PASID xarray lock with interrupts disabled.
+ * The saved interrupt state must be passed to
+ * amdgpu_pasid_unlock().
+ */
+void amdgpu_pasid_lock(unsigned long *flags)
+{
+	xa_lock_irqsave(&amdgpu_pasid_xa, *flags);
+}
+
+/**
+ * amdgpu_pasid_unlock - release the global PASID xarray lock
+ * @flags: interrupt state returned by amdgpu_pasid_lock()
+ *
+ * Release the global PASID xarray lock and restore the previous
+ * interrupt state.
+ */
+void amdgpu_pasid_unlock(unsigned long flags)
+{
+	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
+}
+
+/**
+ * amdgpu_pasid_get_fpriv_locked - get fpriv from PASID
+ * @pasid: PASID to resolve
+ *
+ * Caller must hold the PASID XA lock.
+ */
+struct amdgpu_fpriv *amdgpu_pasid_get_fpriv_locked(u32 pasid)
+{
+	return xa_load(&amdgpu_pasid_xa, pasid);
+}
+
 /**
  * amdgpu_pasid_free_delayed - free pasid when fences signal
  *
@@ -121,6 +180,8 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
 	struct dma_fence *fence;
 	int r;
 
+	amdgpu_pasid_clear_owner(pasid);
+
 	r = dma_resv_get_singleton(resv, DMA_RESV_USAGE_BOOKKEEP, &fence);
 	if (r)
 		goto fallback;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index a57919478d3b..4b55d0d9703a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -34,6 +34,7 @@
 #define AMDGPU_NUM_VMID	16
 
 struct amdgpu_device;
+struct amdgpu_fpriv;
 struct amdgpu_vm;
 struct amdgpu_ring;
 struct amdgpu_sync;
@@ -70,7 +71,10 @@ struct amdgpu_vmid_mgr {
 	bool			reserved_vmid;
 };
 
-int amdgpu_pasid_alloc(unsigned int bits);
+int amdgpu_pasid_alloc(unsigned int bits, struct amdgpu_fpriv *fpriv);
+void amdgpu_pasid_lock(unsigned long *flags);
+void amdgpu_pasid_unlock(unsigned long flags);
+struct amdgpu_fpriv *amdgpu_pasid_get_fpriv_locked(u32 pasid);
 void amdgpu_pasid_free(u32 pasid);
 void amdgpu_pasid_free_delayed(struct dma_resv *resv,
 			       u32 pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 6b4de2a6c629..0c973a3c73fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1488,7 +1488,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto out_suspend;
 	}
 
-	pasid = amdgpu_pasid_alloc(16);
+	pasid = amdgpu_pasid_alloc(16, NULL);
 	if (pasid < 0) {
 		dev_warn(adev->dev, "No more PASIDs available!");
 		pasid = 0;
-- 
2.34.1

