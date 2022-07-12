Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DAFCCA47B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 02:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 299348F96A;
	Tue, 12 Jul 2022 02:55:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E018E47C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 02:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLSVDz3F0Q418NrQs1kovdci//AEkTHG6tiRpTYs5WWrOBnzUDZAR86HddW8Zi8Fa/h3rrlQN6xsZus4vzVBARF//r7tD+vikybEL4gjoJeZuyaJHkwapdl6MoOJeOIGZvbUPGsNxcoPlWrAOWVYGGGCgi0WfPYGap9eOHBmHYMWXRsYhzum9Y2JvZo1LzY9CQN3KuOyuuhrKNkZsBoVgK/oVZQMuyFTS1s4BP4RFa7hnqvGyknY1xkK9vTrFpiD8KKiire/ET1HYQC8LtkmGg+Vl0EF+HoUNedLf/kb7bZF1fIBG25qxWi+0KMgyjkDXIvgIjcZXYkXZ/jv4nE5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyHpD7GTb+vLc7qo4m1FBUfWpf/M1UqaVJEBeMkS1iw=;
 b=OhYzehETGRhlFRl6IIVxDYHEZ3qmxTOoF1gOqhAfREWYig4JzXy8Wd2eqv5gCOLoq/y+6mSprPp2vbNVMZL1AW8QR04vVdxJbuQej+QemgraYr9UEXPKxe3Gp0zqap5tVCWU69HRGIa6RyLaUd2+8estDgEfYV6ZqWZuE9S2FrWkfR/ltuQ3IxooLXD6MAF4qpVE7+9Q7RJpUclMs5tmBS7RZoFI/mOuimbqsQrZ1wLC3C1g7olP0P79ZDnJ0ombu9l02PDtn8OPFu0ZxpnlUMA8EXZMGVYZkaeHC6fMJsUBukYhO9LIfkR61bkE8z9+ld7AacjdPjgbZR55e7JUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyHpD7GTb+vLc7qo4m1FBUfWpf/M1UqaVJEBeMkS1iw=;
 b=1+GCbQcyWalyXBCBj7Ofyk6AZOLLh8ItRhH6Wvq1ZIAJhJldnhapapfoJBtUcQqb8bpIpVx7GGSD3cG8JzocJuGIzUwyhrGyY9g9okvKIuMTR8OWFLL+p6D95ViCWp4jQzjQKRDWBGMHD+IK6xQ3T/RtnmC9jYMD2CopKYUSn3E=
Received: from BN9PR03CA0323.namprd03.prod.outlook.com (2603:10b6:408:112::28)
 by DM5PR12MB1801.namprd12.prod.outlook.com (2603:10b6:3:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 02:55:24 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::9f) by BN9PR03CA0323.outlook.office365.com
 (2603:10b6:408:112::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Tue, 12 Jul 2022 02:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 02:55:24 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 21:55:23 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu/mes: ring aggregatged doorbell when mes queue
 is unmapped
Date: Tue, 12 Jul 2022 10:54:59 +0800
Message-ID: <20220712025501.2083086-3-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712025501.2083086-1-Jack.Xiao@amd.com>
References: <20220712025501.2083086-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 536a67cd-38dc-442d-daf8-08da63b1f7ec
X-MS-TrafficTypeDiagnostic: DM5PR12MB1801:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rBTvoAXnF6dzIVgKgp//zgrMvm+dpYtwI7z0qGY7Q4W2kVSKIIeFpSegrOBPK5zpAG3ifXddd0/S05MylGmf4tSoWs/7t2JlFBVFk335UIfmdWLUh5P6oCCobPMaPErHX9fJph4pCYB9gYLzSamvOq7y2M/rxM6ajaCYBG2ZpW8snFjVTFTazzV+VJzgdaQCouEaaFtW5BR5npvDIi+bo4Rjq15ENlLWKe949smsAKQvQKMLqxe5Hn9Cd+eNd0fIn1tzOhjVqYbfPsvpTfeRjFN01Dx47YKXO85KTkTLrDxakU187/7rJsQOevbBMAlkfjC4djNP51OjZHxEZXv8hIta3Yjb23FKtRADAjijwY0kLhRiqyecYYPyGu72LGD+qnnqrdsiw10I+x5P14D4bvPRn4pexfdErxVFSTJiGfqBcuEnyO2CLtyTGufxKWf4jvCFwQYzRwaqVcCfY7M4BkMW9me5zUkqfwU9zhMqclFyhNfuzE6jjcPTPNspAX9BhmbDcLfWXUw3A1xTWYI29dUcKFFSbWEai9qS8PF7MbMp6Z91HHsa7Rf2TXrr+il0BxopNv1mD5WMYdC1ss6A1x9ZP/3Vyd3SWM4YniqkTsupx5TxIabdeplIl3NHFXEgjInEU312x6CLbh39dW9zE2hqRMK6LVjhciAnAwYxj4GjGdDhmotIRNO+AMwleExbU8EOH4rSpzZz4W1HFbnaV1tZwtdcD1xeXt37fxCYLsLm61inhHKjB1MdJdUKYSNBgCkLGfJ4t5w+Jm78TMusfo7+tGqZgY1QsSXPu5WQBVaegE8hY9Br2+i02hZftC2IVMBIWNgHFi4lYIkEU6tfaifC1tYdTbzYAUeQAhSRe1bNSZDwt1XgtGnBjyCKTAVc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(40470700004)(36840700001)(83380400001)(8676002)(4326008)(478600001)(70586007)(70206006)(86362001)(6916009)(356005)(316002)(82740400003)(36860700001)(336012)(426003)(47076005)(16526019)(2616005)(186003)(1076003)(7696005)(41300700001)(6666004)(81166007)(26005)(40460700003)(5660300002)(82310400005)(40480700001)(8936002)(36756003)(2906002)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 02:55:24.5577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 536a67cd-38dc-442d-daf8-08da63b1f7ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1801
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
Cc: Le Ma <le.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Ring aggregated doorbel to make unmapped queue scheduled in mes firmware.

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 82 +++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c  | 79 +++++++++++++++++-------
 4 files changed, 137 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e664f714e4ba..9a4c4c905eab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -725,6 +725,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	queue->queue_type = qprops->queue_type;
 	queue->paging = qprops->paging;
 	queue->gang = gang;
+	queue->ring->mqd_ptr = queue->mqd_cpu_ptr;
 	list_add_tail(&queue->list, &gang->queue_list);
 
 	amdgpu_mes_unlock(&adev->mes);
@@ -1081,6 +1082,12 @@ void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
 	kfree(ring);
 }
 
+uint32_t amdgpu_mes_get_aggregated_doorbell_index(struct amdgpu_device *adev,
+						   enum amdgpu_mes_priority_level prio)
+{
+	return adev->mes.aggregated_doorbells[prio];
+}
+
 int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
 				   struct amdgpu_mes_ctx_data *ctx_data)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 9b011a40906b..f4691b6c3939 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -346,6 +346,9 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
 			    struct amdgpu_ring *ring);
 
+uint32_t amdgpu_mes_get_aggregated_doorbell_index(struct amdgpu_device *adev,
+						   enum amdgpu_mes_priority_level prio);
+
 int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
 				   struct amdgpu_mes_ctx_data *ctx_data);
 void amdgpu_mes_ctx_free_meta_data(struct amdgpu_mes_ctx_data *ctx_data);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index abf2bf7f1a79..5820c3f0e215 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8525,14 +8525,45 @@ static u64 gfx_v10_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
 static void gfx_v10_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
+	uint32_t *wptr_saved;
+	uint32_t *is_queue_unmap;
+	uint64_t aggregated_db_index;
+	uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_GFX].mqd_size;
+	uint64_t wptr_tmp;
 
-	if (ring->use_doorbell) {
-		/* XXX check if swapping is necessary on BE */
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
-		WDOORBELL64(ring->doorbell_index, ring->wptr);
+	if (ring->is_mes_queue) {
+		wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
+		is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
+					      sizeof(uint32_t));
+		aggregated_db_index =
+			amdgpu_mes_get_aggregated_doorbell_index(adev,
+			AMDGPU_MES_PRIORITY_LEVEL_NORMAL);
+
+		wptr_tmp = ring->wptr & ring->buf_mask;
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, wptr_tmp);
+		*wptr_saved = wptr_tmp;
+		/* assume doorbell always being used by mes mapped queue */
+		if (*is_queue_unmap) {
+			WDOORBELL64(aggregated_db_index, wptr_tmp);
+			WDOORBELL64(ring->doorbell_index, wptr_tmp);
+		} else {
+			WDOORBELL64(ring->doorbell_index, wptr_tmp);
+
+			if (*is_queue_unmap)
+				WDOORBELL64(aggregated_db_index, wptr_tmp);
+		}
 	} else {
-		WREG32_SOC15(GC, 0, mmCP_RB0_WPTR, lower_32_bits(ring->wptr));
-		WREG32_SOC15(GC, 0, mmCP_RB0_WPTR_HI, upper_32_bits(ring->wptr));
+		if (ring->use_doorbell) {
+			/* XXX check if swapping is necessary on BE */
+			atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
+				     ring->wptr);
+			WDOORBELL64(ring->doorbell_index, ring->wptr);
+		} else {
+			WREG32_SOC15(GC, 0, mmCP_RB0_WPTR,
+				     lower_32_bits(ring->wptr));
+			WREG32_SOC15(GC, 0, mmCP_RB0_WPTR_HI,
+				     upper_32_bits(ring->wptr));
+		}
 	}
 }
 
@@ -8557,13 +8588,42 @@ static u64 gfx_v10_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 static void gfx_v10_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
+	uint32_t *wptr_saved;
+	uint32_t *is_queue_unmap;
+	uint64_t aggregated_db_index;
+	uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size;
+	uint64_t wptr_tmp;
 
-	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
-		WDOORBELL64(ring->doorbell_index, ring->wptr);
+	if (ring->is_mes_queue) {
+		wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
+		is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
+					      sizeof(uint32_t));
+		aggregated_db_index =
+			amdgpu_mes_get_aggregated_doorbell_index(adev,
+			AMDGPU_MES_PRIORITY_LEVEL_NORMAL);
+
+		wptr_tmp = ring->wptr & ring->buf_mask;
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, wptr_tmp);
+		*wptr_saved = wptr_tmp;
+		/* assume doorbell always used by mes mapped queue */
+		if (*is_queue_unmap) {
+			WDOORBELL64(aggregated_db_index, wptr_tmp);
+			WDOORBELL64(ring->doorbell_index, wptr_tmp);
+		} else {
+			WDOORBELL64(ring->doorbell_index, wptr_tmp);
+
+			if (*is_queue_unmap)
+				WDOORBELL64(aggregated_db_index, wptr_tmp);
+		}
 	} else {
-		BUG(); /* only DOORBELL method supported on gfx10 now */
+		/* XXX check if swapping is necessary on BE */
+		if (ring->use_doorbell) {
+			atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
+				     ring->wptr);
+			WDOORBELL64(ring->doorbell_index, ring->wptr);
+		} else {
+			BUG(); /* only DOORBELL method supported on gfx10 now */
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 1f9021f896a1..a019ac92edb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -389,34 +389,67 @@ static uint64_t sdma_v5_0_ring_get_wptr(struct amdgpu_ring *ring)
 static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
+	uint32_t *wptr_saved;
+	uint32_t *is_queue_unmap;
+	uint64_t aggregated_db_index;
+	uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_DMA].mqd_size;
 
 	DRM_DEBUG("Setting write pointer\n");
-	if (ring->use_doorbell) {
-		DRM_DEBUG("Using doorbell -- "
-				"wptr_offs == 0x%08x "
-				"lower_32_bits(ring->wptr << 2) == 0x%08x "
-				"upper_32_bits(ring->wptr << 2) == 0x%08x\n",
-				ring->wptr_offs,
-				lower_32_bits(ring->wptr << 2),
-				upper_32_bits(ring->wptr << 2));
-		/* XXX check if swapping is necessary on BE */
+	if (ring->is_mes_queue) {
+		wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
+		is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
+					      sizeof(uint32_t));
+		aggregated_db_index =
+			amdgpu_mes_get_aggregated_doorbell_index(adev,
+			AMDGPU_MES_PRIORITY_LEVEL_NORMAL);
+
 		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
 			     ring->wptr << 2);
-		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
-				ring->doorbell_index, ring->wptr << 2);
-		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+		*wptr_saved = ring->wptr << 2;
+		if (*is_queue_unmap) {
+			WDOORBELL64(aggregated_db_index, ring->wptr << 2);
+			DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
+					ring->doorbell_index, ring->wptr << 2);
+			WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+		} else {
+			DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
+					ring->doorbell_index, ring->wptr << 2);
+			WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+
+			if (*is_queue_unmap)
+				WDOORBELL64(aggregated_db_index,
+					    ring->wptr << 2);
+		}
 	} else {
-		DRM_DEBUG("Not using doorbell -- "
-				"mmSDMA%i_GFX_RB_WPTR == 0x%08x "
-				"mmSDMA%i_GFX_RB_WPTR_HI == 0x%08x\n",
-				ring->me,
-				lower_32_bits(ring->wptr << 2),
-				ring->me,
-				upper_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR),
-			lower_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI),
-			upper_32_bits(ring->wptr << 2));
+		if (ring->use_doorbell) {
+			DRM_DEBUG("Using doorbell -- "
+				  "wptr_offs == 0x%08x "
+				  "lower_32_bits(ring->wptr) << 2 == 0x%08x "
+				  "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
+				  ring->wptr_offs,
+				  lower_32_bits(ring->wptr << 2),
+				  upper_32_bits(ring->wptr << 2));
+			/* XXX check if swapping is necessary on BE */
+			atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
+				     ring->wptr << 2);
+			DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
+				  ring->doorbell_index, ring->wptr << 2);
+			WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+		} else {
+			DRM_DEBUG("Not using doorbell -- "
+				  "mmSDMA%i_GFX_RB_WPTR == 0x%08x "
+				  "mmSDMA%i_GFX_RB_WPTR_HI == 0x%08x\n",
+				  ring->me,
+				  lower_32_bits(ring->wptr << 2),
+				  ring->me,
+				  upper_32_bits(ring->wptr << 2));
+			WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev,
+					     ring->me, mmSDMA0_GFX_RB_WPTR),
+					lower_32_bits(ring->wptr << 2));
+			WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev,
+					     ring->me, mmSDMA0_GFX_RB_WPTR_HI),
+					upper_32_bits(ring->wptr << 2));
+		}
 	}
 }
 
-- 
2.35.1

