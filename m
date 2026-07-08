Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F75C43602
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 16:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A84610E62B;
	Wed,  8 Jul 2026 16:44:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JVT0Iaww";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D215A10E62B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 16:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcOSk8K7YYQFeLgzKlLeuStJA9jOYYgBJUTy6qKe+uOOW760/ibHwQ53UtXs6o9j2ASK6HyrcDhUycEA1f1LMNwEvuqT9QaG2PmfbVUz8+CIPIFZfbmrSs+KrjtZ7WXayLL2+GDJjvypI/H0P6b9X+EFdCkZ+lbUf/qb1SotPxk6W0Ecx7wzDNRVR5pDN1xd4D8uCEQZRNzaZr+EGYSMUkYLDR7HHVfKg5IQOjjQBL6KZV7Jesb0Ab+Cd9xzaqolGUwK8UrMNDPjvb3JErtk7Yw4BxnddoqZdLcqqaJAiBx8ZjO1zIUbFfB9v/LLH7mDEe4KtTx918KKRkuqGY8UCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoZjcj7ZlV9SG0wBOVkUBtkjTuw2HX4nKTN0K2sJ9Jw=;
 b=KJiGQWUnD2h9bU668n8JtQmSvj+UUZIJlotSO4WSasK6wszkN6qaGA/KvRRXU4orgnetFBNv0pE4pJ2/VCb+U3/vpuhQcsZSaKpa+2NX4DM3xy212am748jh56/lPkXutMCzgV3r9eqcVx6SVEi23a1j6gB8t5eVi/brqQ3+h3ngBgFJUeiqVkNvREPgEyHNjDNlfpiC1CCqJGJ7LLzv2fztADzh/LR6665wwHboDnJ5QFn6EgQ1WSmexuUGe+BZMjyOA5cmX/PBNbbwG7R0kHcoI+Y3pxXoyfnzzPUuQEp0d+JbLEPNA68r+PiQAKMxnJMw6dMgPsQTSvGIb3v2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoZjcj7ZlV9SG0wBOVkUBtkjTuw2HX4nKTN0K2sJ9Jw=;
 b=JVT0Iaww7JM1zN1x3hMZ/N85HvBwu27ZAPqYbdXMzYxLAf7FL72K/cnrWjR3qLSoppvzMB7DBFuQDun0JC77huUU5WHxmub81PkJ7be4cR+koL893roy0jG8B4L1bWiK9XLklPMCOZPPieY611kw+PHKXMV7FRP6Rq71OEX646o=
Received: from BN0PR04CA0166.namprd04.prod.outlook.com (2603:10b6:408:eb::21)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 16:43:53 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:eb:cafe::7a) by BN0PR04CA0166.outlook.office365.com
 (2603:10b6:408:eb::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 16:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Wed, 8 Jul 2026 16:43:51 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 8 Jul 2026 11:43:49 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: fix 32-bit overflow in CWSR total size calculation
Date: Wed, 8 Jul 2026 12:43:36 -0400
Message-ID: <20260708164336.4099991-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d19c459-4c03-4bef-1745-08dedd1017a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: jyfftyisaYLJo2JlTUOvBlFGFTO9Eu/T+AGCEQmoSBMWEqjtafVerw7pdmo9PRhswuxpaj9UEoDK3tTqy4cEfOzqWctc+O3BDi4QsJtFbtbkbuWpDm7qxz2isyG+79K5zFfdlQ7BTB97qRsYK9xr6lxgM/UN1PkrSQZ+Ww6FQmurKfqEFqkefrRthMathryGq+ypXqS7dGZcxqFTf3oTwbqybIysvSTbcYmrH/ONAGsz4Adnf9mXIx9xt7LHOeSZFp7RxLRW6akzEwZAmnp+fxpkyoZgjCke9EcJbGjw9gA7RvWaVo5TJuMAnw7HjencnznmPjmV9dDPAZxYcJr9LtGZtFWkYHA9tG7OGmhynr1MeAM/TS4KXa6S1TFDmwZVunUXZuAWWDcdmJx9v3QXh+OiUMyIMzVvj76xQ5qVALmM+onyfUTLyC6EOhftH9UURlbTEH83YjqSU5QVuaBLZXYTY4yqRa7oI7bPyaJf7BuJuSDcXgSFXxAqQujH2gJQQ66lhxndEPJJLuqoD/EQHlj6cOFZPouG60QWJ6cf9Q4JNU6FuEVeNO+0IY532CR+rw2+tRTPqxBOtCmSy+B3qGSfQhBj8p9hq1oUJFTihQhz0uXGUoHRBQZTaiNyKygZQ+QDqQTEvJK3sj+btll3w7hkRbFBkHHwqwkNHhNm6OZfw6kxYS7eoAc8oCFkbi2hk8RE/56Grsjqr3mzXMTH+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mx9/9wpJ+Cw8Sq39yBSUWUFTefOaFwhRvlp8ccfqjI936c+Gio+2Nw63LH7KepWNyMq9qR9vOh1yojrJh4eeQHca3gxY51/BaIBfdWK17S8L3oACnYI6HB+lO8BRkuZetSRdnFrSJ3tHewaXbHSgVd4JNvsbqqkU+pB/5yuPxjkUIhKkwhc34dAlwBy7Hzq4FZ4L8MFQ2TElEaP5Mene0OhiT77Yzkt4mMYKR54mj6CN7RKcSG2+8DoBL7N56CT3Oo+20mjmIe22DfsvLqqiV5PLYXgaLYyumaGUuK1+1TcYTh3unTtIbG1oRgh5dPXGj+37XW5KwB1MUXXprRWRK4a2My+ArWPwN+Rz+D5LNZ0jqXIpGJwDNIeRnmqQ2G3+NV6HCZA/OR3Z76IHTR4F9Anekb0GQ3M1XPDrfAMzHkH9i09Oy92h3ZaE6Oo5LDC4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 16:43:51.8386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d19c459-4c03-4bef-1745-08dedd1017a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473
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
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 9d4838461168..01e228fc1860 100644
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
@@ -308,8 +309,14 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 		goto out_err_unreserve;
 	}
 
-	total_cwsr_size = (properties->ctx_save_restore_area_size +
-			   topo_dev->node_props.debug_memory_size) * NUM_XCC(pdd->dev->xcc_mask);
+	total_cwsr_size = (u64)properties->ctx_save_restore_area_size +
+			  topo_dev->node_props.debug_memory_size;
+	if (check_mul_overflow(total_cwsr_size,
+			       NUM_XCC(pdd->dev->xcc_mask),
+			       &total_cwsr_size)) {
+		err = -EINVAL;
+		goto out_err_unreserve;
+	}
 	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
 
 	err = kfd_queue_buffer_get(vm, (void *)properties->ctx_save_restore_area_address,
@@ -344,7 +351,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
 	struct kfd_topology_device *topo_dev;
-	u32 total_cwsr_size;
+	u64 total_cwsr_size;
 
 	kfd_queue_buffer_put(&properties->wptr_bo);
 	kfd_queue_buffer_put(&properties->rptr_bo);
@@ -355,8 +362,12 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
 	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
 	if (!topo_dev)
 		return -EINVAL;
-	total_cwsr_size = (properties->ctx_save_restore_area_size +
-			   topo_dev->node_props.debug_memory_size) * NUM_XCC(pdd->dev->xcc_mask);
+	total_cwsr_size = (u64)properties->ctx_save_restore_area_size +
+			  topo_dev->node_props.debug_memory_size;
+	if (check_mul_overflow(total_cwsr_size,
+			       NUM_XCC(pdd->dev->xcc_mask),
+			       &total_cwsr_size))
+		return -EINVAL;
 	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
 
 	kfd_queue_buffer_svm_put(pdd, properties->ctx_save_restore_area_address, total_cwsr_size);
-- 
2.43.0

