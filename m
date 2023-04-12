Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19ADC77B6E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 16:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56FD810E8B0;
	Wed, 12 Apr 2023 16:26:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1640110E8AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 16:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoizAjW/sqBHF+6uKVQVswCFmgeRG+qOJEAqznBJT0cQMnf7Cm8Gyst8PgfBle2JGXsWm6PMKXgV08xkvnnhfbmRraJ/kJE7I9UpNtlfroIVynp1YU0wYN/Rs6L0RvV2JQcP0x2JYF8yzWfQQx0vP0R9/0YPl8Oo9KnRrLRABKIuBFbSk8LGwVL/YKt35XwqSdvWYJPjHs/1EDj3U6/G5CylLoSKUoSuxcNRv/05RGQ/mC4SZi/xrjag3k0IJzRlyx835W+RgYPG3FZVbLC2pmXN+ozngmtNn0186S4WtvccPyeInL9kvTTKSwbmZvYcAeowk44AWc4RboZLigZfSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eStyFlDZ/qsbcxZL9yjYbmBEb+o1RvQ1IZZRkRAdgd4=;
 b=RlCVq64A8g3ldh81w0yksWrNZOamoPxV6GFL5eDuEvoGUfuYKbCpYpDbGdx+N2wZCuW9dhZomvPb8QW1NJcgqXGJoZa2kcBWeqAJvpShFn/vGigoU7A/HVaY1isFXWSoZEG+s8HzoGb7d7eRt+h2buOZyEA2vxWWoDdgLyqKyQuY0xjVS3VC4OxOddMOWJ5GZ77lpW10VNCrHW9UVkldBV/3s8A/2aTpJrHJpWWItyu8K8c6/a3VxCrsiWVTYn63JcO4sPpFl0TKAnaE9JiYEZD+qK5CoDbhRlUHukOZ4UhY78FY5djRL2T80iVq31Q84L3/Ig2Ag44ybsvmL7O7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eStyFlDZ/qsbcxZL9yjYbmBEb+o1RvQ1IZZRkRAdgd4=;
 b=lPhVywzoNwvYd/nA+RBxc9T+NDid4FUt/h9tdIeQ7VCwHTCS+nSyqA5xS7lTzvIO+0xxhs+2ioSMDGA2qkwHJ5AS5Srod9WKPGRjh0+f/Wm6Fcoxh1dBWb6EDgnUZhiGsGuwY+1GD6MHMqsMMqQoK4stYG5z96mmYMwJlevgK7Q=
Received: from BL1PR13CA0080.namprd13.prod.outlook.com (2603:10b6:208:2b8::25)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Wed, 12 Apr
 2023 16:26:41 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::ac) by BL1PR13CA0080.outlook.office365.com
 (2603:10b6:208:2b8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28 via Frontend
 Transport; Wed, 12 Apr 2023 16:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Wed, 12 Apr 2023 16:26:40 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 11:26:39 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 11/12] drm/amdgpu: use doorbell mgr for MES kernel doorbells
Date: Wed, 12 Apr 2023 18:25:35 +0200
Message-ID: <20230412162537.1357-12-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230412162537.1357-1-shashank.sharma@amd.com>
References: <20230412162537.1357-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: a92603cf-2c43-42c6-358a-08db3b72b27a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EnHBtuYw6a/8ZWMIcgGMoSpfKsHIHB4msva24UO4TWjhvXBNZG+z8JWNDeQ2xzFsFa73AEQiMUPYd0OEsqVLVkMuNTAwdteU1VDcUDlL+SQNTwn13bFE/JGQJr3miUMqXsFSIMUW8n6u50x0tY/ajDvwVt6cuNOeT2VrEEgbK8BP42Y6qPtvnXVj4tazbeBVDjWurzQxTErQJTkKTIdeF4WvBZLfCpJKp3/TIuUqSz86AyXaQtAoozra4RukhsCmMS5eRIMqUnd3kqm/qA35sXW7Wy5l/UA7RMWcZZx3haoZ7ZTY7Es4dxj6uNT8lsmwqBZvqvZ7Qbr3aFW3yx2J5NhIwZBEKtuh+N/0dJB7IOVqYln+4Ob7Qhwrqh833GNDKsSQAQjJ6ArKarP6X3Efo2Kyn6oW9b59ehuVxrlvQpmbXUd/P2wG6A2fedosPTCFYk6Ye125l4Uhb/9c9aWX6CDby58+b3czxgJMBng52zrpb2gFMtjNFwnd3UWmPDLXNdxUeQPSRZnTZ6QKismofbCfPGpKsQe00T11Gh+0kaFoa40oB9ndLhxJPi1yiryWcnTkWUUcHLwU0E2gvo+pdcP716duscD+k4m0URZVhP8I2XNdmudbXzc+0Hx1l9QdbP/lRK3aRh7W+vBCsMVUGC+TBCOWTXUnpiFXT5gRFO6riAFBigiJGDf7wpsi0v9On9TKzOIc9NzyVA1HoKwzdM+vPaBXQ3BDFJYe0IfsdeU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(478600001)(7696005)(26005)(1076003)(54906003)(186003)(5660300002)(16526019)(40480700001)(44832011)(2906002)(6666004)(70586007)(4326008)(70206006)(41300700001)(82310400005)(8676002)(8936002)(6916009)(316002)(356005)(81166007)(82740400003)(36756003)(47076005)(83380400001)(426003)(336012)(2616005)(36860700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:26:40.9252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a92603cf-2c43-42c6-358a-08db3b72b27a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734
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
Cc: mukul.joshi@amd.com, Shashank Sharma <shashank.sharma@amd.com>,
 arvind.yadav@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 94 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +
 2 files changed, 40 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 0c546245793b..cd3ee851f0a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -65,91 +65,70 @@ unsigned int amdgpu_mes_get_doorbell_dw_offset_in_bar(
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
@@ -248,6 +227,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
 	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
 	amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
+	amdgpu_mes_doorbell_free(adev);
 
 	idr_destroy(&adev->mes.pasid_idr);
 	idr_destroy(&adev->mes.gang_id_idr);
@@ -677,7 +657,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	*queue_id = queue->queue_id = r;
 
 	/* allocate a doorbell index for the queue */
-	r = amdgpu_mes_queue_doorbell_get(adev, gang->process,
+	r = amdgpu_mes_kernel_doorbell_get(adev, gang->process,
 					  qprops->queue_type,
 					  &qprops->doorbell_off);
 	if (r)
@@ -735,7 +715,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	return 0;
 
 clean_up_doorbell:
-	amdgpu_mes_queue_doorbell_free(adev, gang->process,
+	amdgpu_mes_kernel_doorbell_free(adev, gang->process,
 				       qprops->doorbell_off);
 clean_up_queue_id:
 	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
@@ -790,7 +770,7 @@ int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id)
 			  queue_id);
 
 	list_del(&queue->list);
-	amdgpu_mes_queue_doorbell_free(adev, gang->process,
+	amdgpu_mes_kernel_doorbell_free(adev, gang->process,
 				       queue->doorbell_off);
 	amdgpu_mes_unlock(&adev->mes);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 8880f3e3702e..b04225585757 100644
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
2.40.0

