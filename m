Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F4CC3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 21:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 583AA10EB2B;
	Thu, 18 Jul 2024 21:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K0fJ9w5o";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF00810EB2B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 21:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYCQ40aZlvIAqbTd4BU2KbgefBN4FcinOqLF1oDn5y2E5WeumbPerxIKuWO1fvJWwA4Ey8y9/AsjrH7xI653rvONGEyGuey3UhOIlc+onAazMZLRdMgY/MvOtUZ+bSdPlhaMCuF54ci3ZOVBkf989hZGY0l/y9w8yhH1QfUCMCKq5Zx+N54fsndVgAZDjO90KxPO0ZcM9A1C5yG3jTU4hf9Pku9CBCtF0ZR5zd5oLxkzfJe8+mOs3G/b1HNBVlda37YDjqvqOIPFEvQMDmJdyvDICwxVpw/78pZ/Jcci61Gf6pTEPIetJv8IuWPyI9bl1Q2BTaYB7DS217u6ppT/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAy9KYBPbKFnfadRMEGFtH+a5Toti8/IIKA7wy2OxWI=;
 b=eVRgbBHfgNltrRG2AslNQQoDrJQYoeDYQAiT8ajY+NuOjSTMNxKQFVGLhjgcsq7SFIbcTe2JYPZhNNUxDCoaikRpd2GKhahZ0Ol/L231mKqZBK4iuvB4JYILvyd2D7esRcrzjPZ1BRSAHCZgxQMvEZ/VQwnIMZrQGpPYxgwQQvEi8Uug7KUfqMzgfMoPGbulkLignB/CdP43suEj9McuhP6hu+5l31HyiwpXJ06mn5fW1+gF/0p03DHlN/NPRVJvUoSGKp0NSnZxg6dsJWtVC+agt55mF5d99MPNhgabtnf0YJ4DyWPg2xOm6bg5TNUax1zWX3urobW2bPkTlNbF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAy9KYBPbKFnfadRMEGFtH+a5Toti8/IIKA7wy2OxWI=;
 b=K0fJ9w5oHVJXXCSIRT2nIVTr99afMhi6y3BtD17R7CR85jY3HY55JIbxHYmR8t2rCC16zioXGtAU+FZpbpIbFTLgBUwLUh3DpxC1oZ9Vo+Vw7cmjJZHqrX+aUlye0/ejLefF9/4GCf+VmNiALHQcr/R99C3/UZhWis1dcKDb1sg=
Received: from SA0PR11CA0096.namprd11.prod.outlook.com (2603:10b6:806:d1::11)
 by SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 21:06:17 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::2d) by SA0PR11CA0096.outlook.office365.com
 (2603:10b6:806:d1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 21:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 21:06:17 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 16:06:15 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH v2 9/9] drm/amdkfd: Validate queue cwsr area and eop buffer
 size
Date: Thu, 18 Jul 2024 17:05:58 -0400
Message-ID: <20240718210558.26340-10-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240718210558.26340-1-Philip.Yang@amd.com>
References: <20240718210558.26340-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|SA1PR12MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: ee976362-81c5-4672-4381-08dca76d778f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nl8bYIf3gmBSfgBP4uFvcmF1d88tAPmICgsZ7P93vVnUWVmDL8eumtNfGlm0?=
 =?us-ascii?Q?l9PVeZYb5vpwh4c4lYNiGy1AJ5AB8729AEMJG0381VJnC0LW5OM4zPRG41De?=
 =?us-ascii?Q?0hbXsSuFAaArI7AEAKQh9/ln00CsFmV/eCE1yNcZrWOzIo88wSzLGWn9hkrm?=
 =?us-ascii?Q?wQV1Ma5xY2AelWbDytgDj7DxDMc8G9guB/4fY0jH6sBeAG9h6jipv1HpxREg?=
 =?us-ascii?Q?9DXOIV97D17ECJJVkxAgGwgRi2CG4+pOn/bKYxQSkEioQ7PID1k3bkSNaKE0?=
 =?us-ascii?Q?cDuKcKfYv4Io+1A4G2BFIyqCYqU+eBiezanAX0vD4nN/euQfIw5KzvQraBSt?=
 =?us-ascii?Q?+HVzZ27x8nj1W2QFmKxDvOqb9Uw7rLysOAXrxto0Zk+chtwu/kuC49XPgUwf?=
 =?us-ascii?Q?bzyTkuQWY6WCgQvTPw0FbpY3B70RYeGwTV+VBoqeb0YYXLaarx/BB/Kvbl3Z?=
 =?us-ascii?Q?Dl9QuEfjAge8ntVtPF+rn0aRnoB3RoccK9f9q6J08bUT45LxZpQPoMZUHWbV?=
 =?us-ascii?Q?zly0mZwlx7eN0Kq1nJ+fCmkU4oSXXlnefzSoeY4HuJ5dKgxd8ahFd+i+8K1O?=
 =?us-ascii?Q?fgRBmMzwd1YHgXcAYEHkNiP28PNIHKROvY8Gek4naf5eMtvbkBkVXKhPeOv7?=
 =?us-ascii?Q?mqnwSpw/WyhMYEa7dCwoMatBFDHDba2dP8kCFipZN9FqUW8EB1V1kH5krJok?=
 =?us-ascii?Q?3PbVejXdWr31LmMyHyJG4KKJXzjVBECbQiFrGd5iCIti/hYyhnvuhb3SSUrj?=
 =?us-ascii?Q?u5FXPZOAHfJ3FMHLW1QwVrrbP9SSb3jcxN4m2Baqj3tJxCCLy3tQrZhZAd4U?=
 =?us-ascii?Q?+OuO62gJLFcwMuik1LYGRECpFmmCKuI/iL6Dn4eHjRWUqCsEHnCqLZy6wdej?=
 =?us-ascii?Q?LWXsm/Jx3k0xij6/QgV6B3xwo2gJxa8R9RgX9RDiKTiE2v4uvdan3KvUQBBU?=
 =?us-ascii?Q?hPGE0p7mhd4XNLLIt43HL28eReFouzu+TlZbF/u+ugRt2akplxv0utUmFHRQ?=
 =?us-ascii?Q?GVyR5GXmiI+7Ugeti9ERK+AKJgyFkkrKcDXzjsTyyMdsWabsYa0DqD7Va98a?=
 =?us-ascii?Q?nYNtqoHWuH5vwuOxYroK8iersbYnQ3/wvT6zjjPU43Ic5L5AWeqEaO+p5Tbt?=
 =?us-ascii?Q?OfhtcOaQbCw2tp0XE807xGH6EJbN6HB2evKom2vQSmogrzr7LgPktiiJYAPW?=
 =?us-ascii?Q?+OF+MsUusRCsph+SIgE5o4vCjhrh+n8QvWAaeW4idxFaKlgOyXx957uWHWBT?=
 =?us-ascii?Q?1tQfCB2DRfxNUKbVNbIFavNtRra+2h7iJrhD34SgboueIjB/rubNhdAkkfeU?=
 =?us-ascii?Q?L9Rbj9LniGz9vkU5+mDS1kdFcLPkhmDrp0CkqYsnMUincJDypLNSiVpgtiSN?=
 =?us-ascii?Q?sriGdLLPr6NZLHI82cyRw58iumnAfY6Nwe7dzxnzFga8txw2LAqn771WhrH0?=
 =?us-ascii?Q?ionNjY6zwzE1ohPJwF8nYQHWQ+X36kL/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 21:06:17.7981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee976362-81c5-4672-4381-08dca76d778f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002
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

When creating KFD user compute queue, check if queue eop buffer size,
cwsr area size, ctl stack size equal to the size of KFD node
properities.

Check the entire cwsr area which may split into multiple svm ranges
aligned to gramularity boundary.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 46 +++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index adcda9730c9f..9807e8adf77d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -225,9 +225,15 @@ void kfd_queue_buffer_put(struct amdgpu_vm *vm, struct amdgpu_bo **bo)
 
 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
+	struct kfd_topology_device *topo_dev;
 	struct amdgpu_vm *vm;
+	u32 total_cwsr_size;
 	int err;
 
+	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+	if (!topo_dev)
+		return -EINVAL;
+
 	vm = drm_priv_to_vm(pdd->drm_priv);
 	err = amdgpu_bo_reserve(vm->root.bo, false);
 	if (err)
@@ -252,6 +258,12 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 
 	/* EOP buffer is not required for all ASICs */
 	if (properties->eop_ring_buffer_address) {
+		if (properties->eop_ring_buffer_size != topo_dev->node_props.eop_buffer_size) {
+			pr_debug("queue eop bo size 0x%lx not equal to node eop buf size 0x%x\n",
+				properties->eop_buf_bo->tbo.base.size,
+				topo_dev->node_props.eop_buffer_size);
+			goto out_err_unreserve;
+		}
 		err = kfd_queue_buffer_get(vm, (void *)properties->eop_ring_buffer_address,
 					   &properties->eop_buf_bo,
 					   properties->eop_ring_buffer_size);
@@ -259,15 +271,33 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 			goto out_err_unreserve;
 	}
 
+	if (properties->ctl_stack_size != topo_dev->node_props.ctl_stack_size) {
+		pr_debug("queue ctl stack size 0x%x not equal to node ctl stack size 0x%x\n",
+			properties->ctl_stack_size,
+			topo_dev->node_props.ctl_stack_size);
+		goto out_err_unreserve;
+	}
+
+	if (properties->ctx_save_restore_area_size != topo_dev->node_props.cwsr_size) {
+		pr_debug("queue cwsr size 0x%x not equal to node cwsr size 0x%x\n",
+			properties->ctx_save_restore_area_size,
+			topo_dev->node_props.cwsr_size);
+		goto out_err_unreserve;
+	}
+
+	total_cwsr_size = (topo_dev->node_props.cwsr_size + topo_dev->node_props.debug_memory_size)
+			  * NUM_XCC(pdd->dev->xcc_mask);
+	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
+
 	err = kfd_queue_buffer_get(vm, (void *)properties->ctx_save_restore_area_address,
-				   &properties->cwsr_bo, 0);
+				   &properties->cwsr_bo, total_cwsr_size);
 	if (!err)
 		goto out_unreserve;
 
 	amdgpu_bo_unreserve(vm->root.bo);
 
 	err = kfd_queue_buffer_svm_get(pdd, properties->ctx_save_restore_area_address,
-				       properties->ctx_save_restore_area_size);
+				       total_cwsr_size);
 	if (err)
 		goto out_err_release;
 
@@ -286,7 +316,9 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 
 int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
+	struct kfd_topology_device *topo_dev;
 	struct amdgpu_vm *vm;
+	u32 total_cwsr_size;
 	int err;
 
 	vm = drm_priv_to_vm(pdd->drm_priv);
@@ -302,8 +334,14 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
 
 	amdgpu_bo_unreserve(vm->root.bo);
 
-	kfd_queue_buffer_svm_put(pdd, properties->ctx_save_restore_area_address,
-				 properties->ctx_save_restore_area_size);
+	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+	if (!topo_dev)
+		return -EINVAL;
+	total_cwsr_size = (topo_dev->node_props.cwsr_size + topo_dev->node_props.debug_memory_size)
+			  * NUM_XCC(pdd->dev->xcc_mask);
+	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
+
+	kfd_queue_buffer_svm_put(pdd, properties->ctx_save_restore_area_address, total_cwsr_size);
 	return 0;
 }
 
-- 
2.43.2

