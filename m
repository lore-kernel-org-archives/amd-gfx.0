Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0EAC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B897610EB76;
	Wed, 29 Mar 2023 15:48:51 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3607010EB5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Abi/tfZZVW/G5wKtlqVJbneRqYvbbtlgvimH910lyRqGmWXytCGUlDidj2oOm9JnL86J3qxG5i5nJWtpheuVYl3O0TCOso9tOBmmMoBFaIYpICYrCc+rpmLQhFJfwC187Hem9Y6BHLuAdBFJIF81GQ8cO59JdBx1trsDQHHqa3nV49RgmGqKeCUtf0RTM/bImXKdS+asNocbAp4pAi2skQ81lhTdCm3JbIIBr9+voKWQkhI5iKn13cjJfx8wL+0wU0EYpJzY8bubygMQa3QtHJ0P3vxSMVZuyEoYj5Qe4TgEaWMiiuJ10TkHLMzQoPFahheJCuYXcQyE1/27aRiwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdsMuXooz76wZnIjaE18n9NmCXlNM65kkw/l3x2RXGc=;
 b=VDhXXen+EXdJDMxb/JbHagSajRrXoC7ZXJjfGbK0IyEQi6TMC3VTkJYYGWwTSI+niYd0YXQeOTgH8R+1C7rdK7mEj3fwIKzsjr+qcWKAGpHMrHYhEM8LvFRDG3bRApeS6aqAI0OGWenuADWLL6iangbvbrjx9yeWvPwQRHn0eCUj0IYEtnYdIvuob9Z3wtBDJKsulmH5G9BfhNZKDISfjcLJjck8hiJSgqNvhbii5jADGIYhZ1pbRA4SIT7pk+9xGIWU82XZAnmhmXL4dO0wuAa2xtJWySXJOBzTADO5jOaX5HX/WfBlwzheVwtYkuIndVEnn3OQwPjhDK04KG7qLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdsMuXooz76wZnIjaE18n9NmCXlNM65kkw/l3x2RXGc=;
 b=ncFxthmMhJzQGyWwXSzEBWt3zj8VqOcdMWfx5ZhlEmJMoXoGbkAYZMFyvIxHUWCGhLoYJw7YWvMX6otIZr/aHXzLXW/I1gaBWiCOxrkwUlQRCgXOIJnvMqgctA99RG3pEbDp+IcnITHxdPwlEYAxEokLsFItMjS699zQ11UsD94=
Received: from DM6PR02CA0083.namprd02.prod.outlook.com (2603:10b6:5:1f4::24)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 15:48:40 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::5) by DM6PR02CA0083.outlook.office365.com
 (2603:10b6:5:1f4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:48:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.21 via Frontend Transport; Wed, 29 Mar 2023 15:48:40 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:48:38 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/16] drm/amdgpu: use doorbell mgr for MES kernel doorbells
Date: Wed, 29 Mar 2023 17:47:52 +0200
Message-ID: <20230329154753.1261-16-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329154753.1261-1-shashank.sharma@amd.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 6efb2413-9a5d-40e4-4ecd-08db306d11a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YTWBLc6GzLEatM0AI+J3vRsCSXRbA5/unrNGoAg+bGacdLnbUSxW7peO8MPfWFu0liWEp5qI5aiDMhJS+KTyDQstcVlU6NfjCkdrAVKoRPUjYDK3hGqfhpCzGleLpP+4+8JTIz4MZjmV+y9+1Z6c4Wb1f1cBQRTwlXZ3xNIjppFtI14gTgeZR+iNaFJ7XCYtBhb0Us0hp9lsAAGhtcDZeoSu96NkeWDV++470x0drRVDmjEDATEB44ybiHk0zHuXnSVyotSw0qgQVEtsQw8jKQPiz+T1ryuhGiZmXwu35dND37tpjZdln0NUEjECO9+VUblNWJ7WowV8Yv+IaCKVJDSRCYZzM/oi/W46Ak9qy/dqAO9v89oFRGjkE3GG/C3RvKM1YSBvQHxqGURrqZbY8A6EC4Ds+VxYah1wdYtEcXD2mKMiOO9kYGa4+6WkC/Dtj2SVm1UNuJ2maBzEBACC3+P5p/e3GH6E5aiYZsC3igsl3Wo7tUPMZzr3jQ4fgkBmT8giFXQpAhtpAkd8+Wq1cYrxuDxckgsgwQJdGajhpwIrgXOZi8DIQsgJAMbB77nK2SRZ6d5NVpPVTIi+hpJ4rFjNQlPQWZgWmeeKANjT8ZAebMlqHonr1Axd5V/O2SoPE2pwgBmpishHeeuZ58ec9E5yJUeZb+fTgWb5xvBQSxs91kcx1NWe2g7LQjkdU0oz3gZv4z2kOwEjxCN00YzL4CoxZ60jbhG2we4dJrs8eZY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(83380400001)(2616005)(47076005)(336012)(426003)(16526019)(26005)(1076003)(478600001)(6666004)(7696005)(54906003)(6916009)(316002)(70586007)(186003)(70206006)(8676002)(81166007)(4326008)(356005)(82740400003)(41300700001)(2906002)(8936002)(5660300002)(44832011)(36756003)(82310400005)(86362001)(40460700003)(40480700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:48:40.7825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efb2413-9a5d-40e4-4ecd-08db306d11a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316
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
Cc: Mukul
 Joshi <mukul.joshi@amd.com>, Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch:
- adds a doorbell object in MES structure, to manage the MES
  doorbell requirements in kernel.
- Removes the doorbell management code, and its variables from
  the doorbell_init function, it will be done in doorbell manager
  now.
- creates doorbell pages for MES kernel level needs (doorbells
  for MES self tests)
- current MES code was allocating MES doorbells in MES process context,
  but those were rung using kernel doorbell calls. This patch allocates
  MES kernel doorbells instead for this in add_hw_queue.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 105 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |   5 +-
 2 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 0c546245793b..423cd642647c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -65,91 +65,89 @@ unsigned int amdgpu_mes_get_doorbell_dw_offset_in_bar(
 		doorbell_id * 2);
 }
 
-static int amdgpu_mes_queue_doorbell_get(struct amdgpu_device *adev,
+static int amdgpu_mes_kernel_doorbell_get(struct amdgpu_device *adev,
 					 struct amdgpu_mes_process *process,
 					 int ip_type, uint64_t *doorbell_index)
 {
 	unsigned int offset, found;
+	struct amdgpu_doorbell_obj *doorbells = &adev->mes.kernel_doorbells;
 
-	if (ip_type == AMDGPU_RING_TYPE_SDMA) {
+	if (ip_type == AMDGPU_RING_TYPE_SDMA)
 		offset = adev->doorbell_index.sdma_engine[0];
-		found = find_next_zero_bit(process->doorbell_bitmap,
-					   AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS,
-					   offset);
-	} else {
-		found = find_first_zero_bit(process->doorbell_bitmap,
-					    AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS);
-	}
+	else
+		offset = 0;
 
+	found = find_next_zero_bit(doorbells->doorbell_bitmap,
+				   AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS,
+				   offset);
 	if (found >= AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS) {
 		DRM_WARN("No doorbell available\n");
 		return -ENOSPC;
 	}
 
-	set_bit(found, process->doorbell_bitmap);
+	set_bit(found, doorbells->doorbell_bitmap);
 
-	*doorbell_index = amdgpu_mes_get_doorbell_dw_offset_in_bar(adev,
-				process->doorbell_index, found);
+	*doorbell_index = amdgpu_doorbell_index_on_bar(adev, doorbells->bo, found);
 
 	return 0;
 }
 
-static void amdgpu_mes_queue_doorbell_free(struct amdgpu_device *adev,
+static void amdgpu_mes_kernel_doorbell_free(struct amdgpu_device *adev,
 					   struct amdgpu_mes_process *process,
 					   uint32_t doorbell_index)
 {
 	unsigned int old, doorbell_id;
+	struct amdgpu_doorbell_obj *doorbells = &adev->mes.kernel_doorbells;
 
-	doorbell_id = doorbell_index -
-		(process->doorbell_index *
-		 amdgpu_mes_doorbell_process_slice(adev)) / sizeof(u32);
+	/* Find the relative index of the doorbell in this object */
+	doorbell_id = doorbell_index - doorbells->start;
 	doorbell_id /= 2;
 
-	old = test_and_clear_bit(doorbell_id, process->doorbell_bitmap);
+	old = test_and_clear_bit(doorbell_id, doorbells->doorbell_bitmap);
 	WARN_ON(!old);
 }
 
 static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
 {
-	size_t doorbell_start_offset;
-	size_t doorbell_aperture_size;
-	size_t doorbell_process_limit;
-	size_t aggregated_doorbell_start;
-	int i;
-
-	aggregated_doorbell_start = (adev->doorbell_index.max_assignment + 1) * sizeof(u32);
-	aggregated_doorbell_start =
-		roundup(aggregated_doorbell_start, PAGE_SIZE);
-
-	doorbell_start_offset = aggregated_doorbell_start + PAGE_SIZE;
-	doorbell_start_offset =
-		roundup(doorbell_start_offset,
-			amdgpu_mes_doorbell_process_slice(adev));
-
-	doorbell_aperture_size = adev->doorbell.size;
-	doorbell_aperture_size =
-			rounddown(doorbell_aperture_size,
-				  amdgpu_mes_doorbell_process_slice(adev));
-
-	if (doorbell_aperture_size > doorbell_start_offset)
-		doorbell_process_limit =
-			(doorbell_aperture_size - doorbell_start_offset) /
-			amdgpu_mes_doorbell_process_slice(adev);
-	else
-		return -ENOSPC;
+	int i, r;
+	u32 agg_db_start_index, nbits;
+	struct amdgpu_doorbell_obj *mes_doorbells = &adev->mes.kernel_doorbells;
 
-	adev->mes.doorbell_id_offset = doorbell_start_offset / sizeof(u32);
-	adev->mes.max_doorbell_slices = doorbell_process_limit;
+		/* Allocated one page doorbells for MES kernel usages */
+	mes_doorbells->size = PAGE_SIZE;
 
-	/* allocate Qword range for aggregated doorbell */
-	for (i = 0; i < AMDGPU_MES_PRIORITY_NUM_LEVELS; i++)
-		adev->mes.aggregated_doorbells[i] =
-			aggregated_doorbell_start / sizeof(u32) + i * 2;
+	nbits = DIV_ROUND_UP(mes_doorbells->size, sizeof(u32));
+	mes_doorbells->doorbell_bitmap = bitmap_zalloc(nbits, GFP_KERNEL);
+	if (!mes_doorbells->doorbell_bitmap) {
+		DRM_ERROR("Failed to allocate MES doorbell bitmap\n");
+		return -ENOMEM;
+	}
+
+	r = amdgpu_doorbell_alloc_page(adev, mes_doorbells);
+	if (r) {
+		DRM_ERROR("Failed to create MES doorbell object\n, err=%d", r);
+		bitmap_free(mes_doorbells->doorbell_bitmap);
+		return r;
+	}
+
+	/* Get the absolute doorbell index for aggregated doobells */
+	agg_db_start_index = mes_doorbells->start;
+	for (i = 0; i < AMDGPU_MES_PRIORITY_NUM_LEVELS; i++) {
+		adev->mes.aggregated_doorbells[i] = agg_db_start_index + i;
+		set_bit(agg_db_start_index + i, mes_doorbells->doorbell_bitmap);
+	}
 
-	DRM_INFO("max_doorbell_slices=%zu\n", doorbell_process_limit);
 	return 0;
 }
 
+static void amdgpu_mes_doorbell_free(struct amdgpu_device *adev)
+{
+	struct amdgpu_doorbell_obj *mes_doorbells = &adev->mes.kernel_doorbells;
+
+	bitmap_free(mes_doorbells->doorbell_bitmap);
+	amdgpu_doorbell_free_page(adev, mes_doorbells);
+}
+
 int amdgpu_mes_init(struct amdgpu_device *adev)
 {
 	int i, r;
@@ -248,6 +246,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
 	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
 	amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
+	amdgpu_mes_doorbell_free(adev);
 
 	idr_destroy(&adev->mes.pasid_idr);
 	idr_destroy(&adev->mes.gang_id_idr);
@@ -677,7 +676,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	*queue_id = queue->queue_id = r;
 
 	/* allocate a doorbell index for the queue */
-	r = amdgpu_mes_queue_doorbell_get(adev, gang->process,
+	r = amdgpu_mes_kernel_doorbell_get(adev, gang->process,
 					  qprops->queue_type,
 					  &qprops->doorbell_off);
 	if (r)
@@ -735,7 +734,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	return 0;
 
 clean_up_doorbell:
-	amdgpu_mes_queue_doorbell_free(adev, gang->process,
+	amdgpu_mes_kernel_doorbell_free(adev, gang->process,
 				       qprops->doorbell_off);
 clean_up_queue_id:
 	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
@@ -790,7 +789,7 @@ int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id)
 			  queue_id);
 
 	list_del(&queue->list);
-	amdgpu_mes_queue_doorbell_free(adev, gang->process,
+	amdgpu_mes_kernel_doorbell_free(adev, gang->process,
 				       queue->doorbell_off);
 	amdgpu_mes_unlock(&adev->mes);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 97c05d08a551..e7e9dfe44c99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -27,6 +27,7 @@
 #include "amdgpu_irq.h"
 #include "kgd_kfd_interface.h"
 #include "amdgpu_gfx.h"
+#include "amdgpu_doorbell.h"
 #include <linux/sched/mm.h>
 
 #define AMDGPU_MES_MAX_COMPUTE_PIPES        8
@@ -76,7 +77,6 @@ struct amdgpu_mes {
 	uint32_t			kiq_version;
 
 	uint32_t                        total_max_queue;
-	uint32_t                        doorbell_id_offset;
 	uint32_t                        max_doorbell_slices;
 
 	uint64_t                        default_process_quantum;
@@ -128,6 +128,9 @@ struct amdgpu_mes {
 	int                             (*kiq_hw_init)(struct amdgpu_device *adev);
 	int                             (*kiq_hw_fini)(struct amdgpu_device *adev);
 
+	/* MES Kernel doorbells */
+	struct amdgpu_doorbell_obj	kernel_doorbells;
+
 	/* ip specific functions */
 	const struct amdgpu_mes_funcs   *funcs;
 };
-- 
2.40.0

