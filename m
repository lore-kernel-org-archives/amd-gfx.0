Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB7BC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 19:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5231110E1B9;
	Mon,  6 Jul 2026 19:19:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="twRZ6uGe";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012014.outbound.protection.outlook.com
 [40.107.200.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6652A10EA6D
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 19:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYdotd5KVcwCU2Dz0hJ4gdqCakXWYsqU6LyxvaCNQsJUlGjp64ypJAfwBR41voT0j8hqYc9uhXFiFTJjz37V5QKNMYK1UPfW9pib49YN0a7nVq7U90EAE+NIWEoUJ+7thVZ5ex+nmFVhBZdLJlOWmfDYRlZiLWboqUWUaxhb2SJkJRwKFzxs5Haz7sZhm9Ln+ZFhBAi9iHZZ96fvY+i+2bkDWEQvwq+Lu9FIn1r9NhJMsfyLdp3YFIS9/chJWytLWNSEmszOm3es2MrBkVKWL9r6rBrgNErPrnbDLTbjAZV0fhVS+Wp8Yex0vCifr1D6ETg932KRaj0wUA7pU0O9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8H++sOMLq3hNd6OKyrS14yHRNawssIc0ofP/7a1qZM=;
 b=RNH66wbD/pJ4yKRYHNUZA0Cwf4/p9owH+kWf2wZvnH9xFLKUuDThwIDFnnyYZ+Y+WrQARjxrgtQVVyNMB6N9UstmSX3omqFsmpspaLiJRVDwC9wMsq3DI0cyxatBwkW3Q0+Ry+rWknv5Rph9Ity6h83O0AMz1FB0flQl6jzchvQGrtgtI40mrI7MIjdasJzAI3ss1Ef73W0Tx/1+8bkdTtIzlwKMUtd2vNxDrpXhtChFTv+9gU6HhhSuRk3mMaNt11eXfgcRj+wzDGMLuiPNFHTsvLcryAQhv7vpLJfMprEt2q6o2pXlvpNtQVp2VpaRr4UP0+K8TWCbd9vjMU7kpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8H++sOMLq3hNd6OKyrS14yHRNawssIc0ofP/7a1qZM=;
 b=twRZ6uGeMDXMxzQIrWVkER/Wr+yhDC9HoatvTsgY91X0lQIKwroHqVOQyiYWjoYL4+f5hiGmQj4LA2DQDUEb/MZ9jhDC+6HpVOGMPXLYBcXQy67QWFvD/puSM+FUkUv7P0xMD0ygwQkpBhZ6fCVuD4B84wMWBLGy1z19Pou52KU=
Received: from DS7P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::16) by
 IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Mon, 6 Jul 2026 19:19:37 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::88) by DS7P220CA0011.outlook.office365.com
 (2603:10b6:8:1ca::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 19:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 19:19:36 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 6 Jul 2026 14:19:36 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: fix 32-bit overflow in CWSR total size calculation
Date: Mon, 6 Jul 2026 15:18:52 -0400
Message-ID: <20260706191852.2077498-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 70fbbccd-cdcf-4794-cad4-08dedb9384de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: n5BCHOiv2ScQbSsLD5QlqALOgj2UHbTYRCRkpiEWSNafcUDWS6rRKM4clSuErHafxvAZzb9E1kt0qXcbsObX+odkO6VMa+glIl9NcD33Mm0sqd895S/CcOz+pJCkvfpNlk1Lz4q8IzDfM0G0inwQ5pKuW9Pb7lPdchTd30V3SzVQpaVZZ2Xr5ihTQZVrli5Uqzu8uODWyEasJnJv9TItKwl4ct7xfbna1EIdthFcgJGLgQ9dArMBpGVHAanJg48bNLwIPNM18nz/tjeZMieWPBrehfOHALJB1eCtvltsA1m1iZQ0HRo+1oxTuQN/DWvFpnnjJN3Za+lUW73uVLqd+hJ6STstfJuvaSp4rJhKYUSDxGEy9KJgZQVQ+hvsWWfZpTLw3mIyZ0PZN+/1VtEy/jfU+5Z2Sfmx6r/RKdHJICxuptfY6Y4KIEar1bZywfzIATzZGOGCKDAHHU8TuVE0Ni+ZzRrxfk2gNXx/hjmXkw+NUsNigC79IbrJSex/HohybVS6+2F56cm2FnzRrcwqlYo8beDj4KfrihZ+FRnOC5h+UzL7IuNjJ5dOF1z3BonFFVysDPWPZUC7jmKCUtIrfDvxR8cpy69NEJH1KiR4BzKaOa5/DLE0QTSgyfXnABBGNAwVhkNmiRlrbX8pdsd+sE0boEGHgDQpdZdd8ID6ZYHpZmQpX+MDaT6UoVIigjAnX71cNsiW/GoJODcgaPWXYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WjOlO5KiGqWLsnt7F+jOT7SSnkAiE0whswOWhHimzlY6PpC2Q8ZLVKocngum/7pE8uEhpy0wvPdhB7eT23hbr5dSUKyYHd4QZQiQYnRTYCEmKMr1QC5pg7gZUcqOwUUmr4iCChBNDgPpUlZ5q6JNj5eXxq8K1O8Wevy7/LjP1BRBfZUeDjdkpfvTBNwaZrC0uXo1VlBR3rmHFCwvdGCNeHvNekapqTkHXAdbhwTZ+apMleR/pEg/N7t+GCK2dM9s0W9AngkTDQIgJAWaPppZ/hjGrpHqzqiVBaPyVtSxFK8+kYGMitjFr9UwZJQhM5uH3xqFVj8YiutCFKfcXWH0Ye8sdS6816bIYJm9M4IGTHVuPbDrpo0U8x/iBxoj0nN9xk3KuBsdaV5XGAMnnJRSajrRpdWkKUanYWqgbM4NAQhq88MXKQPHs6eQkf8YtilX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 19:19:36.8389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fbbccd-cdcf-4794-cad4-08dedb9384de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
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

total_cwsr_size was computed in 32-bit before being used as a BO/SVM
allocation size.
With large ctx_save_restore_area_size and debug_memory_size
multiplied by the XCC count, the product can wrap,
yielding an undersized CWSR save area that firmware later overruns.

Promote total_cwsr_size to u64 and use check_add_overflow()/
check_mul_overflow() in both kfd_queue_acquire_buffers() and
kfd_queue_release_buffers().

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 9d4838461168..4b1c1e379244 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -23,6 +23,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/overflow.h>
 #include "kfd_priv.h"
 #include "kfd_topology.h"
 #include "kfd_svm.h"
@@ -235,7 +236,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 	struct kfd_topology_device *topo_dev;
 	u64 expected_queue_size;
 	struct amdgpu_vm *vm;
-	u32 total_cwsr_size;
+	u64 total_cwsr_size;
 	int err;
 
 	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
@@ -308,8 +309,15 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 		goto out_err_unreserve;
 	}
 
-	total_cwsr_size = (properties->ctx_save_restore_area_size +
-			   topo_dev->node_props.debug_memory_size) * NUM_XCC(pdd->dev->xcc_mask);
+	if (check_add_overflow(properties->ctx_save_restore_area_size,
+			       topo_dev->node_props.debug_memory_size,
+			       &total_cwsr_size) ||
+	    check_mul_overflow(total_cwsr_size,
+			       (u64)NUM_XCC(pdd->dev->xcc_mask),
+			       &total_cwsr_size)) {
+		err = -EINVAL;
+		goto out_err_unreserve;
+	}
 	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
 
 	err = kfd_queue_buffer_get(vm, (void *)properties->ctx_save_restore_area_address,
@@ -344,7 +352,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
 	struct kfd_topology_device *topo_dev;
-	u32 total_cwsr_size;
+	u64 total_cwsr_size;
 
 	kfd_queue_buffer_put(&properties->wptr_bo);
 	kfd_queue_buffer_put(&properties->rptr_bo);
@@ -355,8 +363,13 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
 	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
 	if (!topo_dev)
 		return -EINVAL;
-	total_cwsr_size = (properties->ctx_save_restore_area_size +
-			   topo_dev->node_props.debug_memory_size) * NUM_XCC(pdd->dev->xcc_mask);
+	if (check_add_overflow(properties->ctx_save_restore_area_size,
+			       topo_dev->node_props.debug_memory_size,
+			       &total_cwsr_size) ||
+	    check_mul_overflow(total_cwsr_size,
+			       (u64)NUM_XCC(pdd->dev->xcc_mask),
+			       &total_cwsr_size))
+		return -EINVAL;
 	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
 
 	kfd_queue_buffer_svm_put(pdd, properties->ctx_save_restore_area_address, total_cwsr_size);
-- 
2.43.0

