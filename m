Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115FBF53D89
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 19:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A640F10E023;
	Mon, 16 Mar 2026 19:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xeVgROXa";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013023.outbound.protection.outlook.com
 [40.93.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71A6510E023
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 19:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbQYnPbZTR/lPB2MnBNvh+x0ebBAKWMnydBNrkPOxkQaH2nSAsaEaLMa0aMnG6ruBeL65o93/8fXQKq779IEDvxYA+HYnRdkqv1O5ASR5Q3Gj6og83lylETmMtVzmEPpuNrJDGRUHuDUaEuLsv9gGwXXXJyz6U3VyDSK4elx4yXuE4XhOYu37PuJ8OW7a5NVV2AzpDsb2E5qQeRm1Wh7AIstm4MS6eLgUKDSlDWddhdOOanqwhZIZDUIObgpcJtoGHJukggtdTxYJJnSlYr1fgWkH5l1GzWk14uZPy3qUtR0l3e1tsKUuKahJB/X2+CpH5LFjWHtUdw6jkmYRdRrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbxyQGMbDpB2rkeOEDQhWYFCSfYdL/L8X5PE4Zvc1gM=;
 b=fx12lqcH4GW2LBpW0atryBcppgSIJXo/FphM/XWNCbBreOE8l/PhaDMNd7scoqYJkeP1qHSeDNs9KRpXtvAWuhiMJ9RJwoDcnrLadsH4KkQmsxSF/YCeU6FAUg2lKHnC0Oxvy4n3sn4m0qiw2/DwjX0Od71dC0sggQGuRoeBSh2sIYUsYVbKgPdOdqz/M2LimESoZCDk0Wfev1xE8whUfAE39qkuqdThgm9pz8j4AKAzaVsjwpdMXhjdk6XzJQ58cq85QEc+nugDjp+EpxHIUBX91cPHE6REM6+jxjfVw7xesg3+Uo0ZACC8lTLqGI6qT+4/HKaiZ7Kd8WAcIE7VQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbxyQGMbDpB2rkeOEDQhWYFCSfYdL/L8X5PE4Zvc1gM=;
 b=xeVgROXaFT7hcazkD29VvEx6LOXSNzDANAEhNpCCvGDtjfQVsVD0ZrzTBeb6cwZmw5XbK8aftUuYIgkDxoWlWgHHs282O+p16aog5PBSI0KPAPLgpBcVNTX4x4rOMvokQeOsU2g2gqCqtHqyiEIP/pyqxjSTRD3OQM16ovXjieQ=
Received: from SJ0PR03CA0117.namprd03.prod.outlook.com (2603:10b6:a03:333::32)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 19:15:39 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::90) by SJ0PR03CA0117.outlook.office365.com
 (2603:10b6:a03:333::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 19:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 19:15:39 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 16 Mar 2026 14:15:37 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdgpu: prevent PASID reuse until poll is exhausted
Date: Mon, 16 Mar 2026 15:15:07 -0400
Message-ID: <20260316191507.288273-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: ba1f6650-aa76-49b4-e3e9-08de839068f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4zVP3fF1ViM57hPovBO3lOe0EgRB57Jgxzfx8DAbzdo2r6yMGRw6DfAGlX247TBkgtX4JUPrNuwjWCn01hTpV5kad5+mGFd6fxlctu9yop4+PMVzdWGCU3uXXLpTWukCix/LOnLU3BeMZsMnbPx+rX5fm9BWhCzctaAwEIxtcCFM7hATzxBD9u2NQtLCMFPZ1sgnmoKK7lE+Ta92AIm8Re6ugI5zM5FqPd9odVQs+kWZu1YdmS2u4p8PDOkMXMrZi839tSvlKBM/QHjUzDfDtP7O/CDu59APqWrqFrV/0s0GCJtQizJlDwsl6L5urEkq8LNDIui1M6dPwGbZfgiSmfZYb3oR1OOe0tiQVZgGosTFEFNXbH2segP+8of+fnHQJwqJYuOlAAnbYQjwT+zLe3lDqfnzljTzB+82veLxwoogvzieV7l/20Pu/4PLHQjOda8ehzKiDG3MbeI35YwUZ54MhnvCxIc6y1zA1CTQG9njfhhWlBbGtlzsbcTLt1z9ub1TEm90JbbSoL26lhNRMdRalg0AfkK5l5STeGZJfpV+oBtzhjRn5foNP8H9SwsB185r7R16WrTSv5gV+echWBVe8ci1SxEPo6zT4jZSc2AVnUKsZBEZZHXmqEvt/7bNDIfHx1lGfQd0zCNRngq0asPslBERkeQ3MGNieqTMMBi7vHzq7Cru/XF1WDj/ftQSHlCmqtwX5wmTOTzGSbVEYd8MwJ0MtbBaDQlyXDzSy6Qao/SwRXrBNP6Zx1NDunlRm9yN568ggbidTLoHkevmKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B1NkoQIhJ53Xp9D8XMEWKfn7PKc0z/dTygvmmYAKbeplPMBh9Ig67R7S4tLIGn7nWgY2Sl16p9hvUrrnNzJP2PVEdyqcW5DSt3PG6g/kmwXA9YN6zzA+Z3B+hLFdJzovceYV5yeAF508ohnZuTwdxQhoNKySKqa4iiVJahuztpYNMB4yWM/71HJ2vi4mtuX18VsjA98vHjKBwPbQdRBXsZ2tARAMiYbQAc1JW1VOSvhcaXJEiEmb9sxr0/Xn7y5D4yScMaYQGLPlLyjvSTkQ+myHjZXMHvvvgIMh8hncJiFA0JWpZyE66cn0IUA5gwbO3onCiAjctW6hk8XLDGvX3A6RpgpDICl5uqP4ACO7jt0I4NDw8mlAgPpD5d5CtwrWPa8UskhH78tXHpVuLZTaAH0LrSjaodnci8+fI5oiMHRjI+XjH04ocmcidDM1Ubov
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 19:15:39.1751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1f6650-aa76-49b4-e3e9-08de839068f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258
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
introduces a freed list to store used ids to provid maximum
safety avoiding resue.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 87 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  1 +
 3 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 9cab36322c16..0443b05ddb1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -40,6 +40,21 @@
  */
 static DEFINE_IDA(amdgpu_pasid_ida);
 
+/*
+ * Freed PASID pool - PASIDs are stored here after being freed and only
+ * reused when no fresh PASIDs are available from the main allocator.
+ * This prevents immediate PASID reuse and gives hardware time to flush
+ * all references (caches, IOMMU TLBs and firmware state).
+ */
+struct amdgpu_pasid_freed {
+	struct list_head list;
+	u32 pasid;
+};
+
+static bool mpool_exhausted = false;
+static LIST_HEAD(amdgpu_pasid_freed_list);
+static DEFINE_SPINLOCK(amdgpu_pasid_freed_lock);
+
 /* Helper to free pasid from a fence callback */
 struct amdgpu_pasid_cb {
 	struct dma_fence_cb cb;
@@ -51,7 +66,8 @@ struct amdgpu_pasid_cb {
  * @bits: Maximum width of the PASID in bits, must be at least 1
  *
  * Allocates a PASID of the given width while keeping smaller PASIDs
- * available if possible.
+ * available if possible. Prefers to allocate fresh PASIDs from the
+ * main pool. Only reuses freed PASIDs when the main pool is exhausted.
  *
  * Returns a positive integer on success. Returns %-EINVAL if bits==0.
  * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
@@ -61,13 +77,34 @@ int amdgpu_pasid_alloc(unsigned int bits)
 {
 	int pasid = -EINVAL;
 
-	for (bits = min(bits, 31U); bits > 0; bits--) {
+	/* First, try to allocate a fresh PASID from the main pool */
+	for (bits = min(bits, 31U); bits > 0 && !mpool_exhausted; bits--) {
 		pasid = ida_alloc_range(&amdgpu_pasid_ida, 1U << (bits - 1),
 					(1U << bits) - 1, GFP_KERNEL);
 		if (pasid != -ENOSPC)
 			break;
 	}
 
+	if (pasid == -ENOSPC && !mpool_exhausted)
+		mpool_exhausted = true;
+
+	/* If main pool is exhausted, try to reuse a freed PASID */
+	if (pasid < 0) {
+		struct amdgpu_pasid_freed *entry;
+
+		spin_lock(&amdgpu_pasid_freed_lock);
+		if (!list_empty(&amdgpu_pasid_freed_list)) {
+			entry = list_first_entry(&amdgpu_pasid_freed_list,
+						 struct amdgpu_pasid_freed, list);
+			pasid = entry->pasid;
+			list_del(&entry->list);
+			spin_unlock(&amdgpu_pasid_freed_lock);
+			kfree(entry);
+		} else {
+			spin_unlock(&amdgpu_pasid_freed_lock);
+		}
+	}
+
 	if (pasid >= 0)
 		trace_amdgpu_pasid_allocated(pasid);
 
@@ -75,13 +112,34 @@ int amdgpu_pasid_alloc(unsigned int bits)
 }
 
 /**
- * amdgpu_pasid_free - Free a PASID
+ * amdgpu_pasid_free - Free a PASID to the freed pool
  * @pasid: PASID to free
+ *
+ * Add the PASID to the freed list instead of immediately returning it
+ * to the allocator. This PASID will only be reused when the main pool
+ * is exhausted, providing maximum delay before reuse and allowing time
+ * for hardware caches, IOMMU TLBs, and firmware to clear all references.
  */
 void amdgpu_pasid_free(u32 pasid)
 {
+	struct amdgpu_pasid_freed *entry;
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry) {
+		/* Fallback: free directly to IDA if allocation fails */
+		trace_amdgpu_pasid_freed(pasid);
+		ida_free(&amdgpu_pasid_ida, pasid);
+		mpool_exhausted = false;
+		return;
+	}
+
+	entry->pasid = pasid;
+
+	spin_lock(&amdgpu_pasid_freed_lock);
+	list_add_tail(&entry->list, &amdgpu_pasid_freed_list);
+	spin_unlock(&amdgpu_pasid_freed_lock);
+
 	trace_amdgpu_pasid_freed(pasid);
-	ida_free(&amdgpu_pasid_ida, pasid);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
@@ -616,3 +674,24 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
 		}
 	}
 }
+
+/**
+ * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
+ *
+ * Free all PASIDs from the freed list back to the IDA pool.
+ * This should be called during driver cleanup.
+ */
+void amdgpu_pasid_mgr_cleanup(void)
+{
+	struct amdgpu_pasid_freed *entry, *tmp;
+
+	spin_lock(&amdgpu_pasid_freed_lock);
+	list_for_each_entry_safe(entry, tmp, &amdgpu_pasid_freed_list, list) {
+		list_del(&entry->list);
+		/* Return PASID to the IDA pool during cleanup */
+		ida_free(&amdgpu_pasid_ida, entry->pasid);
+		kfree(entry);
+	}
+	spin_unlock(&amdgpu_pasid_freed_lock);
+	mpool_exhausted = false;
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

