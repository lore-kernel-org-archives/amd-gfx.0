Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06495CCD195
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A3B610EB71;
	Fri, 17 Oct 2025 08:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EP6Ymlfg";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012047.outbound.protection.outlook.com
 [40.93.195.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C0E610EB72
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dV62uJH+gkdRkbyYaqvDd6sAgELO3HTvYFr0xn8iWhl77ur4SqAot+Vhg0R0b7k3lTqaCgqPAnHAlYYINGkkekjbEQ/0nv5j5EtkrmMUdItSD58yfWXnM8MhfF5C0oJ6vtpY0KmZrphfKgzlByJo8JK0e2qlxCBfXDJ9/gWqc8g/GokMUUN5V1BJusV9uCNmztPnvgmk5MVBGlvV5ZqH4UvxXBtNkLDGegNgbdjX/U9F5kzAVhj1qt9OzrkXKNapOXtUIkso3PYkt/+kq1FF3F4Se3boqnbw4oLsqdDQqPczFElj5OOsLWlTL87A0RqCQB2zGBYg7PF9fcwlHNFA6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCgn6NEyfdQPfsQiwGHlyjIk6wvHje0Ko4i2Yd+C43g=;
 b=tf60nZDYN5ZXj4S/ofTl9tCrnt8/ca4CH8URx1q7+CGBfHOYJjqrBZSVh2LM/TTZk+kBKCr6KP9L+m3uyGu2H2w8Wguc2/sJaZLRD6w97Haj6WlqrYppp60Kc3ifd1aA1QQARAscyt43SXRHeF0OEcv3V5R5mIRc9hdilY7tvvGU/nqQ3+gRQlNkfdXHHpnOo9B5G+PrnT4ozqXOr6Lia/r88uKQL2xPN6Do57HNY45TrwGxBmZ6WODCSKKMp7DeZ5V1rDqjAgnDSpKsXMraRd79jgQmEQ+GUpXslll9lcaqIwE43Edv3SpfGMzs03XBISFF1rwIfdC9BLrqsjlRVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCgn6NEyfdQPfsQiwGHlyjIk6wvHje0Ko4i2Yd+C43g=;
 b=EP6YmlfgH0k6LZe+Z/z8oyqUH5Wwa7tVek26E9YZaVpSWjpB7C7K/vd8qrWWgme3Jb3f1KgKE5VFCaxiqQrrHnA2LOLwfHEBd+ucu8QLnDsgAh0ir36R5PCgYUj3jwAme3hvr18gBcCjUYqtcWONy+A9U+p0wbwqLva4uQlAkt4=
Received: from DM6PR07CA0097.namprd07.prod.outlook.com (2603:10b6:5:337::30)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 08:43:34 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::96) by DM6PR07CA0097.outlook.office365.com
 (2603:10b6:5:337::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Fri,
 17 Oct 2025 08:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:34 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:32 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 15/18] amdkfd: record kfd context id in amdkfd_fence
Date: Fri, 17 Oct 2025 16:42:19 +0800
Message-ID: <20251017084222.54721-16-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017084222.54721-1-lingshan.zhu@amd.com>
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: fc83097e-744f-42f5-6d8c-08de0d59420f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5bj6inpqvhaNttafFulSUt6FfefDvPIbXw+k8Ja5qbz5uU7ImyicjFvTmUiA?=
 =?us-ascii?Q?jqsC/Rz1jqqE1y0xmOeLTVtgsoVVqKMeIhcSpd+iCuxkcnSu9zaig88onc5D?=
 =?us-ascii?Q?sZhG4mv12z/S0/jrdbhBxKisXw9KT8Kv+QvXLAbDsyNHYH1ckC9bvIrbmwkT?=
 =?us-ascii?Q?ZsQ6Blq6Svhi9gKBsLzpw/Cn2lsxYV/qR8YRxRrtN7tuNJP1bweU+kSCFw+4?=
 =?us-ascii?Q?Rer566+bAvE6svzzXlmtALDkxJz/UaII/yW+kEJalg0EBRGGNBd1WXqekvoh?=
 =?us-ascii?Q?DY6NerSfEBB8EN6ULjkWbO5AFBff57cvJoUy+QHaGClMyozxeUcOnExtyEzQ?=
 =?us-ascii?Q?aWRnnhbVCCL6rT1cxdRARs/bU/T7D/kNCC3yyOpQJDHLP1EDFUV/7ekplJ8m?=
 =?us-ascii?Q?9nDlJB54lhuzdtkfe6zr5MCj5RQGf/8kuKrC6KCyPm/bdeHoS7gAroeCvBAy?=
 =?us-ascii?Q?oydL/jlvoTa8bnPawcFV5fKmwkCALfHty5VUhmDFfYI7nr0C5j2uX7RCLSZi?=
 =?us-ascii?Q?k+66WzcseztKdWdS2++hgBwMLT/oGS2VOKbMFiE0LPUwlK1d4dgajJbzq/ZB?=
 =?us-ascii?Q?hPZ11ONbB1SCq4ewXg3PuevB8hAmAyXpkTIrCqOVX01fd7LA65FyYWHBhLPy?=
 =?us-ascii?Q?zRSAl2TV7hgJvh3Geo88n7p3c3BQCSvxxqOZP0kxjVxM1xhoZYJT7TjCj6qS?=
 =?us-ascii?Q?GKHJ5FLLkaTJlnPemCYmdvvxa1a78XIxYwHKFb9kkYWMFpcTmEo6vPnTJjOu?=
 =?us-ascii?Q?RHOOqOqUmMMX8dchbcagV5q3nMTtQXSPlTsUiKczgvss1Xp590h0PaX8zWo1?=
 =?us-ascii?Q?JqcAVuFuh9pX7hVuM9F3YIjbqXs5Lg+gMkpVvQwBA+qzTLInaPifDYqAMtrb?=
 =?us-ascii?Q?TRVhNjg86Zwfoxi9/lOP49i//lsRbL8goedZTz8WctnEmKDAdoJTkNWdXeJj?=
 =?us-ascii?Q?wEnYjNoaPqr2Ov97l+SV1Nju/KSSRRzJ7wI6/x3JaXyj8na7geGvLpLckiOu?=
 =?us-ascii?Q?nogN8D9TkBQI70+dbi46WDLjMkzgkaTi69PCBgykq15tjZ2PFc4jC1c4njAd?=
 =?us-ascii?Q?B+lSjMUwjXVKzGuQxG6tDwZI74nbpiDHFRftKrMknzW5j7po2pZsX811pWEz?=
 =?us-ascii?Q?8Qih8IpGJ+PVAd54kj4rKjmoWnF87fEsqZGK4LYVyaLyQgeyrk2Bg3Z+9n0s?=
 =?us-ascii?Q?upTdAttXvTj3ZtBf9WEdgRlt13se8+ePSqiVMT9lNOQd0+IMG6RQlldipoW4?=
 =?us-ascii?Q?r3vThKW31GCFAtpGrPsViMaoseGqySlI5FY2zXkYjmc2DWu50vqcjdG5gPe2?=
 =?us-ascii?Q?PSLGx7NKWmz3KfrcMSMyJInL45/iF3CRVlETDCX5Cm3bxtDc1dqxApyFVPdi?=
 =?us-ascii?Q?QuJpjy/rWhKVBPpsUk+OCoIT5Dvqwx9xQt75ExpZ8saiBf5Ro9tXTLomxd4F?=
 =?us-ascii?Q?JgC+mprB0jjlDfAdbrS6fnQY650GtWVaWp3HNZCJ8nOJkPEC+bIfCtt6JSDd?=
 =?us-ascii?Q?BtJe6g0OKIqdgZbveFIns1na99gVUAyuF2J0mzb2Zc2BRBANdAa9T+4cv1Rl?=
 =?us-ascii?Q?xRWQx0Ux1jM/csTuhT8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:34.4017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc83097e-744f-42f5-6d8c-08de0d59420f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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

This commit records the context id of the
cooresponding kfd process in amdkfd_fence

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 28b54d7ee1f5..087e8fe2c077 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -98,6 +98,7 @@ struct amdgpu_amdkfd_fence {
 	spinlock_t lock;
 	char timeline_name[TASK_COMM_LEN];
 	struct svm_range_bo *svm_bo;
+	uint16_t context_id;
 };
 
 struct amdgpu_kfd_dev {
@@ -190,7 +191,8 @@ int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
 
 struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 				struct mm_struct *mm,
-				struct svm_range_bo *svm_bo);
+				struct svm_range_bo *svm_bo,
+				u16 context_id);
 
 int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev);
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 1ef758ac5076..4119d0a9235e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -62,7 +62,8 @@ static atomic_t fence_seq = ATOMIC_INIT(0);
 
 struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 				struct mm_struct *mm,
-				struct svm_range_bo *svm_bo)
+				struct svm_range_bo *svm_bo,
+				u16 context_id)
 {
 	struct amdgpu_amdkfd_fence *fence;
 
@@ -76,6 +77,7 @@ struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 	get_task_comm(fence->timeline_name, current);
 	spin_lock_init(&fence->lock);
 	fence->svm_bo = svm_bo;
+	fence->context_id = context_id;
 	dma_fence_init(&fence->base, &amdkfd_fence_ops, &fence->lock,
 		   context, atomic_inc_return(&fence_seq));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0e40cdd8c5ec..58d85149fecf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1405,7 +1405,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 		info->eviction_fence =
 			amdgpu_amdkfd_fence_create(dma_fence_context_alloc(1),
 						   current->mm,
-						   NULL);
+						   NULL, process->context_id);
 		if (!info->eviction_fence) {
 			pr_err("Failed to create eviction fence\n");
 			ret = -ENOMEM;
@@ -3057,7 +3057,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 			amdgpu_amdkfd_fence_create(
 				process_info->eviction_fence->base.context,
 				process_info->eviction_fence->mm,
-				NULL);
+				NULL, process_info->context_id);
 
 		if (!new_fence) {
 			pr_err("Failed to create eviction fence\n");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 9d72411c3379..04582aef1b41 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -585,7 +585,7 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	svm_bo->eviction_fence =
 		amdgpu_amdkfd_fence_create(dma_fence_context_alloc(1),
 					   mm,
-					   svm_bo);
+					   svm_bo, p->context_id);
 	mmput(mm);
 	INIT_WORK(&svm_bo->eviction_work, svm_range_evict_svm_bo_worker);
 	svm_bo->evicting = 0;
-- 
2.51.0

