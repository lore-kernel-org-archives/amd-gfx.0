Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74433EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 12:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA1610E463;
	Wed, 21 Jun 2023 12:45:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B51910E45D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 12:45:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNooyUGg5aabJ2asgfYsKy0P3mrHjShsrCnS8zqjEJTPsuzl3SFzp57Kkox0Noc6I3oJgqGcMsCG27kFu0L7fBwVI7KhI5eZ7SEbeGWWgU+DdPbUr2lWOOScOZBUgfpLJ1X5UWji6wx02rMjd2NSJV3F+IIJgEv1mumz+As0UPP4+kGxAHx7fXGP/2cMFHbAdyLMp4c9OV/z2Or6ohjj1JBGJs4xCLU2BqJIZ2K5zUXBUmmDsmBaNZgh57sdciL9DHiA76atYpCS9M48+WrOnxSB2XUhzcyLYjj7NCKPsJvX4U0A1kVm1zQ4DBESxebuju4aelkU3qTlaQa4WILjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/MlPY9P0x3cmE79QFyBSvNbsrS+uE57kMOCu6ll9fg=;
 b=LdWV+ADFPGohAZzjR5+AMQVc0acK2BVswg58XZFnDDNaEdxXtvWqOBAnmYdDbDqVijpdhRYXk9IULtK4BpiVkPR1a/4QbgR6lKubvbO6dnix7ZiTI1oVGwcJsJJS/RlJFacsTUn9whlEVsgwwfGadUsJsm41QiR+e20YWFjheiVDzi8y/P7z+515+T0velab9Ik6Ecyx+Legva3I1etP5Sbcjw93BMsdQrE7nbniwJMKC3WX7yw1EL8WIq7vFDuqOJN2l8JBe++PQMqLpkP4rw2iOrXi7JN//vICiQlXAHsgzJcDFrTwh2SEkzmztQ4W21q69/IDWqubl3czD3EHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/MlPY9P0x3cmE79QFyBSvNbsrS+uE57kMOCu6ll9fg=;
 b=5RtAKCCX1dIraf752Hr0b/lIPD6nwHoWAg8J9RP7DSkPIpUhntRgvIrOcXblVtexeL5bEu7wbtnJSEk5yyJ2PRO6qOih+GWVdhMlIYCGzH8jRsKlg+kL3oAe705JOj30YXPMLdRwxq8Vbb5UCxEIFO4t+utTw95/LUKnq4pMToc=
Received: from DS7PR03CA0043.namprd03.prod.outlook.com (2603:10b6:5:3b5::18)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 12:45:21 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::d5) by DS7PR03CA0043.outlook.office365.com
 (2603:10b6:5:3b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 12:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.40 via Frontend Transport; Wed, 21 Jun 2023 12:45:21 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 07:45:19 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 11/12] drm/amdgpu: use doorbell mgr for MES kernel doorbells
Date: Wed, 21 Jun 2023 14:45:07 +0200
Message-ID: <20230621124507.2263-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230620171608.2131-12-shashank.sharma@amd.com>
References: <20230620171608.2131-12-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ec4f1e-c374-4619-1106-08db7255605b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYQ5QmeWt9gNzHUEsiiv6MEKv6M+ptXGlE9QWzBZEZzaXBgFnyb46C6LbVAXEORvshwa7Rn1nygBuoY6oJr986UV/JQdqMJ6saCNqENNiNKBb/l4wrQb/NiFcJTqJHKAC9dgEQCWijFPBH0l6mXlgMyDgXgQw/EwcU09gX4h87PBE2olx9JwZFW7Xh3pKoq+cmxApXHiuVJkABlwfkUrpHvnVGoBHaNfIhhljddRmvzqkJSol4e4LWKRCuxUhBdwHMFt/+PPK2z+Knmg8BpmztaIxBqYXls6Ibfvaf3au9ZZEQWe7zjdRTb/ihGEcLZF/1E+7l3YBlqqpkqlz0mnGm2UHiehtYLM3YkgAy9NzmnIYxB1TxBE5FCig0Bjf1RHYxkHf2R6ht5y03kQGagH5htN2osKMQh6MiyfOC7CkksXVsJgBLlaBbI7wHcStYc+vjQgNPX2gdp7Ch5gIdA93ZOrbHYFlOMjedK39gBDOzs55hw+5wRYsghcZp+qLUD+pfR0iHPQvY8+HHc06VR4WrDubaZvJIGhdMPN9ehOUj2+XDtqI6dP61m9ihEdXGg2EvuYn0KYH5Bhi53AEX/4oWu5nAwsdz1X/tkUDmgNR+v2+KfU/NeJyrqp7xGAChJmLYiN+cFV+RHTiw3KplBn7bTLL55zxjX0jKMbLolJ5lHvyA/D9oqqxvMMpHI2OvgFMCTxhc/nI79MBnRJDcPTdmAk4IfPefOgBLH1mcyqP9JoVGqgVnQp49+jN+PbVdA/d+nVXX5LuHyXGD2iR/N4xA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(40480700001)(426003)(336012)(2616005)(4326008)(316002)(83380400001)(6916009)(16526019)(36860700001)(8676002)(8936002)(41300700001)(47076005)(6666004)(478600001)(7696005)(70586007)(1076003)(186003)(26005)(70206006)(54906003)(40460700003)(2906002)(86362001)(44832011)(36756003)(82740400003)(81166007)(356005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 12:45:21.6643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ec4f1e-c374-4619-1106-08db7255605b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch:
- Removes the existing doorbell management code, and its variables
  from the doorbell_init function, it will be done in doorbell
  manager now.
- uses the doorbell page created for MES kernel level needs (doorbells
  for MES self tests)
- current MES code was allocating MES doorbells in MES process context,
  but those were getting written using kernel doorbell calls. This patch
  instead allocates a MES kernel doorbell for this (in add_hw_queue).

V2: Create an extra page of doorbells for MES during kernel doorbell
    creation (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 94 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  3 +
 3 files changed, 44 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index ba2b2f4cad47..e1599fd72954 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -145,6 +145,10 @@ int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev)
 	/* Reserve first num_kernel_doorbells (page-aligned) for kernel ops */
 	size = ALIGN(adev->doorbell.num_kernel_doorbells * sizeof(u32), PAGE_SIZE);
 
+	/* Allocate an extra page for MES kernel usages (ring test) */
+	adev->mes.db_start_dw_offset = size / sizeof(u32);
+	size += PAGE_SIZE;
+
 	r = amdgpu_bo_create_kernel(adev,
 				    size,
 				    PAGE_SIZE,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index f0f00466b59f..01c3d27512d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -67,91 +67,70 @@ unsigned int amdgpu_mes_get_doorbell_dw_offset_in_bar(
 		doorbell_id * 2);
 }
 
-static int amdgpu_mes_queue_doorbell_get(struct amdgpu_device *adev,
+static int amdgpu_mes_kernel_doorbell_get(struct amdgpu_device *adev,
 					 struct amdgpu_mes_process *process,
 					 int ip_type, uint64_t *doorbell_index)
 {
 	unsigned int offset, found;
+	struct amdgpu_mes *mes = &adev->mes;
 
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
 
-	if (found >= AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS) {
+	found = find_next_zero_bit(mes->doorbell_bitmap, mes->num_mes_dbs, offset);
+	if (found >= mes->num_mes_dbs) {
 		DRM_WARN("No doorbell available\n");
 		return -ENOSPC;
 	}
 
-	set_bit(found, process->doorbell_bitmap);
-
-	*doorbell_index = amdgpu_mes_get_doorbell_dw_offset_in_bar(adev,
-				process->doorbell_index, found);
+	set_bit(found, mes->doorbell_bitmap);
 
+	/* Get the absolute doorbell index on BAR */
+	*doorbell_index = mes->db_start_dw_offset + found * 2;
 	return 0;
 }
 
-static void amdgpu_mes_queue_doorbell_free(struct amdgpu_device *adev,
+static void amdgpu_mes_kernel_doorbell_free(struct amdgpu_device *adev,
 					   struct amdgpu_mes_process *process,
 					   uint32_t doorbell_index)
 {
-	unsigned int old, doorbell_id;
-
-	doorbell_id = doorbell_index -
-		(process->doorbell_index *
-		 amdgpu_mes_doorbell_process_slice(adev)) / sizeof(u32);
-	doorbell_id /= 2;
+	unsigned int old, rel_index;
+	struct amdgpu_mes *mes = &adev->mes;
 
-	old = test_and_clear_bit(doorbell_id, process->doorbell_bitmap);
+	/* Find the relative index of the doorbell in this object */
+	rel_index = (doorbell_index - mes->db_start_dw_offset) / 2;
+	old = test_and_clear_bit(rel_index, mes->doorbell_bitmap);
 	WARN_ON(!old);
 }
 
 static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
 {
-	size_t doorbell_start_offset;
-	size_t doorbell_aperture_size;
-	size_t doorbell_process_limit;
-	size_t aggregated_doorbell_start;
 	int i;
+	struct amdgpu_mes *mes = &adev->mes;
 
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
-
-	adev->mes.doorbell_id_offset = doorbell_start_offset / sizeof(u32);
-	adev->mes.max_doorbell_slices = doorbell_process_limit;
+	/* Bitmap for dynamic allocation of kernel doorbells */
+	mes->doorbell_bitmap = bitmap_zalloc(PAGE_SIZE / sizeof(u32), GFP_KERNEL);
+	if (!mes->doorbell_bitmap) {
+		DRM_ERROR("Failed to allocate MES doorbell bitmap\n");
+		return -ENOMEM;
+	}
 
-	/* allocate Qword range for aggregated doorbell */
-	for (i = 0; i < AMDGPU_MES_PRIORITY_NUM_LEVELS; i++)
-		adev->mes.aggregated_doorbells[i] =
-			aggregated_doorbell_start / sizeof(u32) + i * 2;
+	mes->num_mes_dbs = PAGE_SIZE / AMDGPU_ONE_DOORBELL_SIZE;
+	for (i = 0; i < AMDGPU_MES_PRIORITY_NUM_LEVELS; i++) {
+		adev->mes.aggregated_doorbells[i] = mes->db_start_dw_offset + i * 2;
+		set_bit(i, mes->doorbell_bitmap);
+	}
 
-	DRM_INFO("max_doorbell_slices=%zu\n", doorbell_process_limit);
 	return 0;
 }
 
+static void amdgpu_mes_doorbell_free(struct amdgpu_device *adev)
+{
+	bitmap_free(adev->mes.doorbell_bitmap);
+}
+
 int amdgpu_mes_init(struct amdgpu_device *adev)
 {
 	int i, r;
@@ -250,6 +229,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
 	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
 	amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
+	amdgpu_mes_doorbell_free(adev);
 
 	idr_destroy(&adev->mes.pasid_idr);
 	idr_destroy(&adev->mes.gang_id_idr);
@@ -679,7 +659,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	*queue_id = queue->queue_id = r;
 
 	/* allocate a doorbell index for the queue */
-	r = amdgpu_mes_queue_doorbell_get(adev, gang->process,
+	r = amdgpu_mes_kernel_doorbell_get(adev, gang->process,
 					  qprops->queue_type,
 					  &qprops->doorbell_off);
 	if (r)
@@ -737,7 +717,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	return 0;
 
 clean_up_doorbell:
-	amdgpu_mes_queue_doorbell_free(adev, gang->process,
+	amdgpu_mes_kernel_doorbell_free(adev, gang->process,
 				       qprops->doorbell_off);
 clean_up_queue_id:
 	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
@@ -792,7 +772,7 @@ int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id)
 			  queue_id);
 
 	list_del(&queue->list);
-	amdgpu_mes_queue_doorbell_free(adev, gang->process,
+	amdgpu_mes_kernel_doorbell_free(adev, gang->process,
 				       queue->doorbell_off);
 	amdgpu_mes_unlock(&adev->mes);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index a403418d5eac..2c604e04fd5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -27,6 +27,7 @@
 #include "amdgpu_irq.h"
 #include "kgd_kfd_interface.h"
 #include "amdgpu_gfx.h"
+#include "amdgpu_doorbell.h"
 #include <linux/sched/mm.h>
 
 #define AMDGPU_MES_MAX_COMPUTE_PIPES        8
@@ -130,6 +131,8 @@ struct amdgpu_mes {
 
 	/* MES doorbells */
 	uint32_t			db_start_dw_offset;
+	uint32_t			num_mes_dbs;
+	unsigned long			*doorbell_bitmap;
 
 	/* ip specific functions */
 	const struct amdgpu_mes_funcs   *funcs;
-- 
2.40.1

