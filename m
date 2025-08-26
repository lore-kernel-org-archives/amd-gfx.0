Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEC2CA0FED
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 07:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C3D10E5FE;
	Tue, 26 Aug 2025 07:47:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NrX56tJx";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B71E10E5FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:47:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLR3Cwchs/WEFsWqfIeXyejPN4BHdr79NUmTPSg4uVsK8UsPG6gt2B3zluoCDlbE3o3cEG47hWwN22pp8o9I2lVn15GyBqh3KHM+R4HngWoCHUrE2fhT9MWy98/fo6IWCqqz4ayk8YTsm5UouSI/E6HnDFmgZGp81Tc3tv2u2bieUWwlYIWE4nzQp05+jJD0PrhzTe61IOkcamNFixMbDjskKmkZQNqlTMUTuRDRjqb6d2TaY4Kx0ufUKc9KdSTfbcIH7gTAyn8TmcdTHsjmmMTpMmnshinNTRYfPDw4nt9NVTGwL9GvHO9tcMZqUoOLBp/Owx9/GFzmagDsiQKJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMW8teXAY2TFXtZyHBUp1SmNfUddQAqmFXDqIjA+dtE=;
 b=LwrRFlMzJPvJVy5CxhaS1DQKdBZfIcNs2ztjUZdOQ0Tv0g399I8AGPxhsviJBmqssgtCH9N0ll5m+3UlZBK3fpm++ciScjCaF6z/vtkfZy4B6j+DmuDBXgLaGYfbaPz3ZcDNTyYM36/rzWTRkFH4rKPCLvyhc9+YUZtZ5j1AV/v2cwxdjSZBUi2We+RTqufm8uYDMFIsX1WbUmajreLUpHkDVbLePD8xvYaFUq152HyigNxA3Tky92HGMif9cLwB7J79eVzgedv7yFfFDLQHPQNgAjsYuUS+sVKWnTqo1NeWCgClMJiMxFPFTxmFU1ZhVauHbSX1UP6maolpLIZhgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMW8teXAY2TFXtZyHBUp1SmNfUddQAqmFXDqIjA+dtE=;
 b=NrX56tJxAq6/RJNyo6/6MHA17oFyD/cbRJj2nIwj5WRGIuUbhppe3+biTMr492RLY+JwLt7cPQyIEeNFkkakssFOmXyLsMAtunjPdRHhKcA6k15G+897VRE24OSEc9Z5RaFZDMElJvKruIhaAc0jtIjAGPRKLujA2atFlrQ0wxY=
Received: from BL1P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::28)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 07:47:21 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::62) by BL1P222CA0023.outlook.office365.com
 (2603:10b6:208:2c7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 07:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 07:47:20 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 02:47:18 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v9 14/14] drm/amdgpu: validate userq va for GEM unmap
Date: Tue, 26 Aug 2025 15:46:46 +0800
Message-ID: <20250826074646.1775241-14-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826074646.1775241-1-Prike.Liang@amd.com>
References: <20250826074646.1775241-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 495488c2-0ce7-4bcb-8488-08dde474c9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHVDQm1tUElFN1lXbCtPOTJHNjZiaHJKYld5aDg1ZWNaUlJ0bzBnVExyQWly?=
 =?utf-8?B?SUordmlNcG5yc0tmTmJ6bksxdjdNdHNBMHAxKzR1TUc2dCsyMEZUWFNvSnM0?=
 =?utf-8?B?S2lSRTkyd3RhZHBiUE9YWWpiVy9pVCtsZ1ZFTHREQ1E3SnljTExhYlRraUFu?=
 =?utf-8?B?SEVmTUwvN0RGalNsbngwd04zZUtkWUwxK2lDamtvRmlIS1Uzek5mNWRydGhz?=
 =?utf-8?B?TlRaVlVDUk12R01BbzlYYmdDcUZtUXdBMXBNbHlmUHVsd1lKeWdHdEd1VGNN?=
 =?utf-8?B?alIwRm90MzF1LzBWaHF2SStXQWhHWVhhVHdkSEptUEsrN3ZNa0RmMmh5T083?=
 =?utf-8?B?azU3amxzUUxrTkllb2R6dU9rckVxalp2cUNqTVZqbmFwcFdwRTNZZXRnTlFm?=
 =?utf-8?B?R3lBZi9CRFQwSUgwdzN0Z2pydTBUZkd2YkpMMTNBanliRU1FVXljeUVYbEto?=
 =?utf-8?B?NUY0UXJEVkFzdlNjMWVrZHV2RHF3bForWml6c1dOQUNqMGRxTkpxVFE0YzNH?=
 =?utf-8?B?Zmx5TzFDNVVrZWpvWWlQS2tZQTBTdldhNGpHWmRQbkEzM085SHRVVjJlbU1H?=
 =?utf-8?B?RXhQcUtDd0N5NzRJZDk2c3VRL1crMFkzT2JZcDNreFM3L2xKc3NYeVF2ODYv?=
 =?utf-8?B?TklNNTQrTmJIUXJ3TWlQYlQvZDZBanVNZGlvUFdrZHhFR3d2V3U0d01PbE9K?=
 =?utf-8?B?eHVxS29ZOVhXQVpwQUpPKzRJNE5BUnJNc21RcTh3a3pxVDkwOTJ0akkxekFx?=
 =?utf-8?B?R2QwT0Z0c25Vc0tmUyt6OHI5K3FUOW9wUDZzZDBmcnQwQXFKdGMveVVsV01h?=
 =?utf-8?B?WElQQnAvTFhKMmhPRHhkUkV1R0ttYnkyMm1BQTNpYkpMUFNpYXlOZGtnemZF?=
 =?utf-8?B?VHNtaTEzM2Y4akhpbzBldUVhYjh6Y291eDRYWHVyZVFGeWpkbGZJRzJRNytG?=
 =?utf-8?B?WE05NTByTnhWT0R3T1YyWWk3UCtKK1pDYmZRNktkSXdDMUYvcStPazZvV2Zw?=
 =?utf-8?B?TzZBSEhLbDkwZHlZa25OZjhmNnhGRURrZUxXZXRqK1cvdkN5ZTFkUTFpaEZS?=
 =?utf-8?B?TVRVcW5mREc0bXhxeEt5dENUWi8relZaRFl5Q1VsL0lDZzFsNmJGZVJUUFl4?=
 =?utf-8?B?Z0UrK2srTEZnTzl4T2tQcG1vOTRHVGFBTmI5YWhQQXBvQ3poalBMblR3dXEy?=
 =?utf-8?B?WWZYRHZEQ3dqakpXZFNjUkZtVVdXVTR0L3ljVFFSNEV6cHVybkVuNmtJWnVk?=
 =?utf-8?B?aEc1YVRBSEo1TTEvdm85a0tLVnJJL0x5TXltM0l6WEJkL08wZU0zNkVrOXBI?=
 =?utf-8?B?eUZNbzNGL0IrNERrR2pOSHpOU1ZmSVZuWDMwR3BmYmhqdjBMWW1XNXVwcnBU?=
 =?utf-8?B?dzlnTWNZNERVbzQ0ZzNuSmhQSWh5bnVjU0lxa20zWWNOZS9DQ2hzZDB1WWI2?=
 =?utf-8?B?cVlvcDFqWXZhc3NCSVU4U1RWRVVwUTNPQStlRXdBSVBhTHE1NWhGY2xIMVNw?=
 =?utf-8?B?OExid21jek8xUm5pYlFkcVUwaHcyclg0MHFycGtvNWpPSWVqdDJod0hBeTlv?=
 =?utf-8?B?ZXh0NjVaQ1FTaVdlcjA1eFUveUhSRUxGSmQ2WmZvai9GcTVNNnRIYWV2THFi?=
 =?utf-8?B?S3B5b3N4KytMSU5TQnQ5WHJZUHhxaE02Nm5PR29FYVlLU1Brb1RaWG5vQVdw?=
 =?utf-8?B?MmlIazN5WU5JVTNycTZHYm4ramh6S2RXQzJreVUvR1R0SFFKMFVjb1lEMjg2?=
 =?utf-8?B?UGJna1FDMVhobjFUK3VEbGxSN3RkcEtqZWhwNWVhTTJvbDAwYzd1ekhUajJP?=
 =?utf-8?B?SUg0MFQzUlEwbTdVVHg5dzlNUnJVVk5qYjRxc2RSeHU5ZytFK1o3bjE4cENo?=
 =?utf-8?B?Z0Z5WUdiYTZxemg2dy8raHB4OFh5VGd1K1NzbENmSCtaNW5sd09ZNjhXN20w?=
 =?utf-8?B?T29WNXNTNHhZNXNyZm9vY0YvMFl5bm90enpGQ0taRTV6VlFzWHlRRG15ckFD?=
 =?utf-8?B?V1cwUjZ4R1JGSzFtRmtqU2NqSHorOHdQVGNHcUZNR1VDYUZ2MlpQOHgvUzM1?=
 =?utf-8?Q?y5qJAA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:47:20.9659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 495488c2-0ce7-4bcb-8488-08dde474c9d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039
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

This change validates the userq to see whether can be
unmapped prior to the userq VA GEM unmap. The solution
is based on the following idea:
1) Find out the GEM unmap VA belonds to which userq,
2) Check the userq fence fence whether is signaled,
3) If the userq attached fences signal failed, then
   mark it as illegal VA opt and give a warning message
   for this illegal userspace request.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 119 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  11 ++
 3 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 771f57d09060..af4a1857ea98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -676,7 +676,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		}
 	}
 
-
 	args->out.queue_id = qid;
 
 unlock:
@@ -1214,3 +1213,121 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+static bool amdgpu_userq_va_in_mapping_range(uint64_t va, struct amdgpu_bo_va_mapping *mapping)
+{
+	va = (va & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
+
+	if (va >= mapping->start && va < mapping->last)
+		return true;
+	return false;
+}
+
+/**
+ * amdgpu_userq_gem_va_unmap_queue_retrieve - find out userq by gem unmap va
+ * @queue: destinated userq for finding out from unmap va
+ * @mapping: the GEM unmap VA mapping
+ * Find out the corresponding userq by comparing
+ * the GEM unmap VA mapping with userq VAs.
+ */
+static bool amdgpu_userq_gem_va_unmap_queue_retrieve(struct amdgpu_usermode_queue *queue,
+                                                struct amdgpu_bo_va_mapping *mapping)
+{
+	switch (queue->queue_type) {
+	case AMDGPU_HW_IP_GFX:
+		if (amdgpu_userq_va_in_mapping_range(queue->queue_va, mapping) ||
+		    amdgpu_userq_va_in_mapping_range(queue->rptr_va, mapping) ||
+		    amdgpu_userq_va_in_mapping_range(queue->wptr_va, mapping) ||
+		    amdgpu_userq_va_in_mapping_range(queue->shadow_va, mapping) ||
+		    amdgpu_userq_va_in_mapping_range(queue->csa_va, mapping))
+			return true;
+		break;
+	case AMDGPU_HW_IP_COMPUTE:
+		if (amdgpu_userq_va_in_mapping_range(queue->queue_va, mapping) ||
+		    amdgpu_userq_va_in_mapping_range(queue->rptr_va, mapping) ||
+		    amdgpu_userq_va_in_mapping_range(queue->wptr_va, mapping) ||
+		    amdgpu_userq_va_in_mapping_range(queue->eop_va, mapping))
+			return true;
+		break;
+	case AMDGPU_HW_IP_DMA:
+		if (amdgpu_userq_va_in_mapping_range(queue->queue_va, mapping) ||
+		    amdgpu_userq_va_in_mapping_range(queue->rptr_va, mapping) ||
+		    amdgpu_userq_va_in_mapping_range(queue->wptr_va, mapping) ||
+		    amdgpu_userq_va_in_mapping_range(queue->csa_va, mapping))
+			return true;
+		break;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
+				struct amdgpu_bo_va_mapping *mapping)
+{
+	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+	int ret;
+
+	if (!ip_mask)
+		return 0;
+
+	/**
+	 * validate the unmap va sequence:
+	 * 1) Find out the GEM unmap VA belonds to which userq,
+	 * 2) Check the userq fence whether is signaled,
+	 * 3) If the userq attached fences signal failed, then
+	 *    mark as invalid va opt and give a warning message
+	 *    for this illegal userspace request.
+	 */
+
+	if (mutex_trylock(&adev->userq_mutex)) {
+		list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+
+			if (!mutex_trylock(&uqm->userq_mutex))
+				continue;
+
+			idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+
+				if (!amdgpu_userq_gem_va_unmap_queue_retrieve(queue, mapping)) {
+					dev_dbg(uqm->adev->dev, "mapping: 0x%p not belond to queue id: %d\n",
+						mapping, queue_id);
+					continue;
+				}
+
+				if (queue->last_fence && !dma_fence_is_signaled(queue->last_fence)) {
+					drm_file_err(uqm->file, "an illegal VA unmap for the userq\n");
+					queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+					ret = -ETIMEDOUT;
+					goto err;
+				}
+				/*
+				 * At here can't evict/unmap the HW userq directly since here just one kind of
+				 * VA unmapped, and some other VAs of userq may still be mapped. As to
+				 * this case, we might need to wait the userq fence signal, but the evict fence
+				 * is not bound to the queue since it may attach some other queue obj as well,
+				 * so here may always fail to wait the eviction signal.
+				 * FIXME: Here may need to unmap the userq to prevent the queue further used,
+				 * but there still requires debugging on the hang-up issue after unmapping the
+				 * HW queue here.
+				 */
+				/*amdgpu_userq_unmap_helper(uqm, queue);*/
+			}
+			mutex_unlock(&uqm->userq_mutex);
+		}
+	} else {
+			/* Maybe we need a try lock again before return*/
+			return -EBUSY;
+	}
+
+	mutex_unlock(&adev->userq_mutex);
+	return 0;
+err:
+	mutex_unlock(&uqm->userq_mutex);
+	mutex_unlock(&adev->userq_mutex);
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index cf35b6140a3d..767e8562a7a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -149,4 +149,6 @@ bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
 int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
 int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
 			struct amdgpu_usermode_queue *queue);
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
+				struct amdgpu_bo_va_mapping *mapping);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f042372d9f2e..97952396d0e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1929,6 +1929,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	bool valid = true;
+	int r;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
 
@@ -1949,6 +1950,16 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 			return -ENOENT;
 	}
 
+	/* It's unlikely to happen that the mapping userq hasn't been idled
+	 * during user requests GEM unmap IOCTL except for forcing the unmap
+	 * from user space.
+	 */
+	if (bo_va->queue_refcount) {
+		r = amdgpu_userq_gem_va_unmap_validate(adev, mapping);
+		if (unlikely(r && r != -EBUSY))
+			dev_warn(adev->dev, "Here should be an improper unmap request from user space\n");
+	}
+
 	list_del(&mapping->list);
 	amdgpu_vm_it_remove(mapping, &vm->va);
 	mapping->bo_va = NULL;
-- 
2.34.1

