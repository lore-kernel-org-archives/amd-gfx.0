Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03B2C44500
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 06:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E8F310F627;
	Fri,  3 Jul 2026 06:19:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QMhECaTe";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4117C10F627
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 06:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vx10cPvX3zBOQXrrh7McFjLrzndzn7xa8iRqs6Kmk16dTuTqndxf2q5o9h2F8llcR+Qr28rnXGdqC23i/+zwVJ4tzY9K5SfBpWUic7sDptih+7WXzfT5K96QpwT7toccq13gOSw6USsTP0G86gWCKj4hqCw0a4Q5Z4vhFz5j2eiQoxUqQwZXQAHP1QG+gDVOOGvx2+1rz76S9QvZk3Kd+nCYgMqAU9bsMssLav5EDkbP1R14NaeFbsqwfqJDM93esBAiKGf+uYftqUh3K4bl2Oqn0xaahXO8CpaazMn5FGq5oMdIGfzIimkCXZ2LfcTHu3c1TEl5wGfYLvByM+bApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNfLbjggcWf8RGbw9l8RQi5RDyaM0jAzJyVfZ+hgOhw=;
 b=QCwVkooABLrEYEK4Kh0DWcGSoBDrfvnNqc0y3VdiHeFd0yw/DLwu8u/YGBBFUFvMUZ1kYyR/hKbULSvt2wDxGCv9Gn7MnxHk/1ai5dK8Clngbj8iUQ7Zn5xMgFDc/RJcIU+oOQV4PG0repx3xxkNDMf1f/XfDhxHkdQb5X+NJXKWoByflvULO17sfyEvy3scYxdiT7m3SYGloR/Tru0uNd01QSOiLla21PkQJWKr/6/41xV7MUIWEw23blpzASGs4NyiEB70RtAqBlz1lsXB0/fyF9XRiqNT1xFEFjdQjo6lBiAT6VDmY0kdArFRV2thqvJ/AwML+rOwiRRx6kKg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNfLbjggcWf8RGbw9l8RQi5RDyaM0jAzJyVfZ+hgOhw=;
 b=QMhECaTeBA4KJkt/PGAXRs6xuBhTna3Vr4Lkq0H0KXQWBOFGPWVKlHA5te3zVF0kOeN7mMkrCdFsv6vizbqYnkxXzgWTGBb+M99OpPEfpGGQtdiRtdFm6mZKkY0rQsM2CJrJ22JQw8oQELWGyRcM6/lI3ufkNblaj3S4XYkuT4c=
Received: from MN2PR15CA0054.namprd15.prod.outlook.com (2603:10b6:208:237::23)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 3 Jul 2026
 06:18:58 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::89) by MN2PR15CA0054.outlook.office365.com
 (2603:10b6:208:237::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 06:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 06:18:57 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 3 Jul 2026 01:18:54 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 1/3] drm/amdgpu: Allow PASID allocator to store fpriv owner
Date: Fri, 3 Jul 2026 11:48:31 +0530
Message-ID: <20260703061833.3163913-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703061833.3163913-1-srinivasan.shanmugam@amd.com>
References: <20260703061833.3163913-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5996ed-cce4-4673-7e9d-08ded8caf759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: G5SAF0MIHPoBrgL7toVKGGjyQ3rXBOjH3g4kLP0jqtbYqX7ukOYMA414u5tgzACxJuFCIHp8wfKvUv6EwpTGHMg3wj/3zJ/xBo4whtz+sFeE6PoaG0+za6dLUmyfWog9Q5piTSXB+v/QfP96mHp2lNWZHwSSp3UBd49B1HPcwM5Gi0qPRcqDW4fsE2rCmj1+iWyHX5kVDHN5BeqaeR5HHTdY43rhY2aAgB3um8+qyD9Vj1Dxbp2rKZwo8yuLPqnin5zH1Umf/WH5thoNFaHVNxzZRj7wOEzuJV3qZrzSmYl7PqzXUmsqncNTuiY67x4McGiCYbEkt9LDQKcFkcRB6j17ir6H8U6zQv5LDrH5Hqt70HiYZPyAbm8QXRY9c7SFushbTk/gEDlqLTlJ3STowcbNr1I0cXnAXbnzr3/4BxaekcpSRkgtwqVdWhOjgu4H9Wak29unIQkHcIpawayIMQbyHeJJzzw9lId5OnhMg1CGY9wCDKMrWC43JThGAvXkKEeatkkXOGyYFlDW8aS6tphwKPy2ZXEImKEjALXLuf7QiORxr7nGeX0irfQ3HdJgPoZ2H/zfJKCXabGi1VSuhLrki4kLwmcHPv4Ce2XA3L4OhKBpN6J8u29ftkyrmv92Hynq2TBAd7zkL8Ad2HNBCM8EQSEa2ktO+0y+o/dNgvYiqHzllF6pQ4oYhHVQZR3NWd3e0BjKcx7oky1yp+terQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JtaO+59CgukXr2rSPcEY3UJ239C+E91XTgyTuQXo76PU4Kum+LSEDtFmC9s46GlciGrm9jLhlJHo0p974o0P/epUfOC2p4ubu/1Jxl84lffCbUV0sMKyQTPfONOJyvxRzDflH1CL+j2I/IcL9UkvqeK6xUYmcVXAJKKN/pQsG6f20yRLbC94Z2AwtHV3S/ex3FBDDWfGgEd4Z9qn2+jQYVJdYMTLs5OtBxhiqh7MzDJuvHTm5rVqjJvu9gf3nqpX3qMYb5k4p6Z/Y0Lavqbl6w8UMMDpsV6JrtUd3m3jHvx8n8MJfspf06NDmdSVvW2/PGNIubfXyXn9Q1JIL6c+TKfVfntzhVBxU8u3C9OC2twY1cGjq+izq4E/Mhg8Uxx9AE3CwmNuA4kWMtRHsNgR1RMQfPnbm6uQ3Lg8jummOQSSUOfFEo08rU7ssDNxrUut
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 06:18:57.7600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5996ed-cce4-4673-7e9d-08ded8caf759
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628
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

AMDGPU already has a global PASID xarray used by the PASID allocator.

Allow amdgpu_pasid_alloc() to optionally store the owning DRM
file-private object directly.

Initial callers pass NULL and keep the current dummy allocation marker
behavior. A later patch in this series passes the DRM file-private
object for DRM PASIDs.

This prepares for using:

	PASID -> fpriv -> VM

instead of:

	PASID -> VM

Also clear any stored owner from amdgpu_pasid_free_delayed() before
waiting for fences, so PASID lookups cannot observe a stale fpriv while
the PASID number itself is still pending delayed release.

v4: (per Christian)
- Add fpriv as an optional parameter to amdgpu_pasid_alloc().
- Drop separate amdgpu_pasid_set_fpriv()/clear_fpriv() helpers.
- Clear PASID owner from amdgpu_pasid_free_delayed().

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 82 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  |  2 +-
 4 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 684f40fce73f..669d0fff8cbc 100644
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
@@ -60,17 +61,19 @@ struct amdgpu_pasid_cb {
  * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
  * memory allocation failure.
  */
-int amdgpu_pasid_alloc(unsigned int bits)
+int amdgpu_pasid_alloc(unsigned int bits, struct amdgpu_fpriv *fpriv)
 {
 	u32 pasid;
 	int r;
+	void *entry;
 
 	if (bits == 0)
 		return -EINVAL;
 
-	r = xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
-			    XA_LIMIT(1, (1U << bits) - 1),
-			    &amdgpu_pasid_xa_next, GFP_KERNEL);
+	entry = fpriv ? fpriv : xa_mk_value(0);
+	r = xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, entry,
+				XA_LIMIT(1, (1U << bits) - 1),
+				&amdgpu_pasid_xa_next, GFP_KERNEL);
 	if (r < 0)
 		return r;
 
@@ -78,6 +81,75 @@ int amdgpu_pasid_alloc(unsigned int bits)
 	return pasid;
 }
 
+/**
+ * amdgpu_pasid_clear_owner - Remove the owner associated with a PASID
+ * @pasid: PASID whose owner should be cleared
+ *
+ * Restore a PASID entry back to the allocation marker while keeping the
+ * PASID itself allocated.
+ *
+ * This is used by the delayed PASID free path so that future PASID
+ * lookups cannot resolve a stale DRM file-private object while the PASID
+ * is still waiting for outstanding fences before being released.
+ */
+static void amdgpu_pasid_clear_owner(u32 pasid)
+{
+	unsigned long flags;
+	void *entry;
+
+	if (!pasid)
+		return;
+
+	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
+	entry = xa_load(&amdgpu_pasid_xa, pasid);
+	if (entry && !xa_is_value(entry))
+		__xa_store(&amdgpu_pasid_xa, pasid, xa_mk_value(0),
+			   GFP_ATOMIC);
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
+	void *entry;
+
+	entry = xa_load(&amdgpu_pasid_xa, pasid);
+	if (!entry || xa_is_value(entry))
+		return NULL;
+
+	return entry;
+}
+
 /**
  * amdgpu_pasid_free - Free a PASID
  * @pasid: PASID to free
@@ -121,6 +193,8 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
 	struct dma_fence *fence;
 	int r;
 
+	amdgpu_pasid_clear_owner(pasid);
+
 	r = dma_resv_get_singleton(resv, DMA_RESV_USAGE_BOOKKEEP, &fence);
 	if (r)
 		goto fallback;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index a57919478d3b..c2be6f81d680 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -38,6 +38,7 @@ struct amdgpu_vm;
 struct amdgpu_ring;
 struct amdgpu_sync;
 struct amdgpu_job;
+struct amdgpu_fpriv;
 
 struct amdgpu_vmid {
 	struct list_head	list;
@@ -70,8 +71,11 @@ struct amdgpu_vmid_mgr {
 	bool			reserved_vmid;
 };
 
-int amdgpu_pasid_alloc(unsigned int bits);
+int amdgpu_pasid_alloc(unsigned int bits, struct amdgpu_fpriv *fpriv);
 void amdgpu_pasid_free(u32 pasid);
+void amdgpu_pasid_lock(unsigned long *flags);
+void amdgpu_pasid_unlock(unsigned long flags);
+struct amdgpu_fpriv *amdgpu_pasid_get_fpriv_locked(u32 pasid);
 void amdgpu_pasid_free_delayed(struct dma_resv *resv,
 			       u32 pasid);
 void amdgpu_pasid_mgr_cleanup(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index cacdc99b3ad6..4610d6889e9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1487,7 +1487,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto out_suspend;
 	}
 
-	pasid = amdgpu_pasid_alloc(16);
+	pasid = amdgpu_pasid_alloc(16, NULL);
 	if (pasid < 0) {
 		dev_warn(adev->dev, "No more PASIDs available!");
 		pasid = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index f7d5879c6e44..65b824144a2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -2293,7 +2293,7 @@ static int mes_v12_1_self_test(struct amdgpu_device *adev, int xcc_id)
 	u64 meta_gpu_addr, ctx_gpu_addr;
 	int size, i, r, pasid;
 
-	pasid = amdgpu_pasid_alloc(16);
+	pasid = amdgpu_pasid_alloc(16, NULL);
 	if (pasid < 0)
 		pasid = 0;
 
-- 
2.34.1

