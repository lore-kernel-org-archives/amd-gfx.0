Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B09FFF885D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 10:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE5F10EAEA;
	Tue, 28 Apr 2026 10:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LGyJjLWY";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012058.outbound.protection.outlook.com
 [40.93.195.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5065310EAEA
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 10:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymhIPLq/aL5WYZhk32MYN4fhuU57ShOF/zOb1QH99MQu2wm+y7ch0ttW3Qbim7SgRwpfra9KBBIu8nXFSmlVRJGeNM2QIOHskqG/ACJQXWbKcAaYQRbSOdyaj/KrnW51xB+MG4vTZDWECl0jIDTxJbomCuDVhB/PXZMXnVeZ70eGrDqz9SdOZQ8IRUgW1bnk+gE+JWTkcemTMqeWwByAUFcU9McOGhVM6vTFq21mGXYRVVubrHZFk3C81N3pLAhndOUv2sUb7lp17F0s5nAOIQUCzkCG9R3NI2fuxHzGkbTD+ODcDKvgEt9Gxp18Lip2Oi2DRZrmyJ6f0t7MwFGyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bJCNG38Ca5nIQSbdhXGSx7gZxlRMyZk5MiYo9PcKoQ=;
 b=bLgRl0gSL2/8s5QK/K8ByDoaO5r9u9Xnn97feMgez5cZL0OkfMNhQ+75KzOtYci59naZ8OsRnNpHZgGABZ1DRZNDelQqwuDOhghWSjbK521Lk98SaCZGTDnonm+ssZDbB9LV17W4Mpc+QZp3ysqfBeCyUCnz0C+eCHCOavtQ+JuFrlUJ0sNdHFEUOlXUY3NLKZDpJ+/YOcTHWpm7iPuFESe6fH4u4MIzUUBQxqkIuNDapWVFSPvIzH5Fk+aqs8pDwMH5LdbKm2X33cq9YTqc5B17WSlVeMP9gokucXWbOBairD3v9Ov8pzi8LXCvkWGyhYtTIoNsITwR6jMPXW+47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bJCNG38Ca5nIQSbdhXGSx7gZxlRMyZk5MiYo9PcKoQ=;
 b=LGyJjLWYuyM+JWiSOAclLaDcY60N04/GTe1a3wj1sAzjUG1n2QJrEnuKYFWB5a13NxJ6q/6yl84aTUAsy51x0w26KIILOg6otnG8hXbOPCZAixEpsbD4a9KXMrDvOpgA/MdIecbLdWTJg4IJtOfqh5syUAFh7KFZGTvbFqSeOmM=
Received: from CH0PR03CA0338.namprd03.prod.outlook.com (2603:10b6:610:11a::10)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 10:02:50 +0000
Received: from DS2PEPF000061C4.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::17) by CH0PR03CA0338.outlook.office365.com
 (2603:10b6:610:11a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Tue,
 28 Apr 2026 10:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C4.mail.protection.outlook.com (10.167.23.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 10:02:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Apr
 2026 05:02:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Apr
 2026 05:02:48 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Apr 2026 05:02:42 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 02/11] drm/amdgpu/userq: route SDMA UMQ doorbells through
 the kernel pool
Date: Tue, 28 Apr 2026 17:58:43 +0800
Message-ID: <20260428100239.1609179-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
References: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C4:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: a28d8196-6be8-4be2-b5d4-08dea50d4db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: e7GSBgMXsWxASOyVl95m8zVpchHiBXEQLTn4Pu/lNm5bdZtVTDobzJSr0CWee1sGeKToVdKqQbKb4a9Tbax1V8ku5iMLYi8VJWta3UomZUq1EeCYrM1w3qChlgPM7ZVOOIM1OAJzQxaCJnmyYw8K02kOcUte8TBlpIM3rOwYwjp9yqHkuuUfhOMxiJXrJYSLbVhvzmJJQGS5DRk9Z6mUQnj3C58FQlX1+j/kWbwceZL4R8Xxx83Scd+qXIp2QyQ7CxRWnQ1W46H0aW1JlkKDnaboNeLhiWXVDkM7/xNU0bcWQU9j5ryRwsEd8x/VHhB7+HtjcV7NhU9wNPVRzcccworu8jpNWuYMezHvwu2yzTLGyXizeYVpxHBTGhPJ146ZroA7lpRnZpkjPClwKde6gKuyXIgxy9C6eJ6f1xHoXjxYUCnGSj0FyOOnu3he9EMe5emnOOSFlEZYeFl0YMEqEEangFy+EmJEjNfgDhfHzooFykVMU2J8W6bNRPuwy/qBY3iYwtYf+MYK0W+km2J41KEr4Brjd0kpm7G+C2+jjn5hqeHR3zM3km6C6uQUWB+Zo5IV5e0pOkahNDvXzlRdBGZ3OQxYOULLb4keLUC7j4Uvt/ibaykWRKSZqChhjc1Zb9jU8EQG7MmA5yjLXY88G/l+LrBVDQsfAEA/mk+OHCDe9UdcHBeDxHS/osNLi5HNyiUOtJIkklsGbRxlY6uW9quzPpww5BhdUJjwg27ucIVyxQnBFQPkMS5H65cQKG8BX4YQRpSIFV11UK4HclskVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MIgnThwFJnTUtgVBVaglFhS3vejJDUSCtRFGpPQxT6qu03I7TKJ60Q+3YaQtvucomibZMm5H1EmL4DswodnNNicki7wXvvXpm+AumxebjxOlsfxRiYZCtEX5CbDhWLpf9n0xsYaXNfj42vFmea9c+y28mLqUOB6VjIUMcqw/76Isbn61SrW6QHQn1/ZID+NYUw4boVtqwddg1LberVtnJkmGr5uKAcPXuO9AtBwHB4RCRyuBph8ssXNbvdRPvZ3tkzdHLv6zI7Ih80BfzseeQtgGaTsXmE+5SHzzYNbB394Ej6ZMlo2xjTbMnt0MJKxu7a+iMWZqvKxM4XkQiZJXuP0uSXYM1Gh4DZI54/7PW9H66XpgM24kKaSTIErkRMwdYe7s3QSe0olyb4ZM1U3WUos8x/uUay1f+Vw14raY4Tq2gpDhMNAJLcylZAIeoa6z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:02:48.9486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a28d8196-6be8-4be2-b5d4-08dea50d4db5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

User-allocated DOORBELL BOs land at BAR offsets outside the
firmware-managed NBIO SDMA decode window and cannot reach the SDMA
back-end.  For AMDGPU_HW_IP_DMA queues, ignore the user-supplied
doorbell index and allocate one from the per-device pool added in the
previous patch.  Track the assigned slot id on the queue so it can be
returned to the bitmap on destroy.

Add a new sdma_doorbell_offset_bytes field to drm_amdgpu_userq_out
that tells userspace where its kernel-allocated qword slot lives
inside the SDMA doorbell window.  Userspace gets the window's mmap
offset/size from the AMDGPU_INFO_USERQ_DOORBELL ioctl added later in
this series and mmap()s the drm fd at that offset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 46 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  7 ++++
 include/uapi/drm/amdgpu_drm.h             |  8 ++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8f48520cb822..94ec686049ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -662,6 +662,10 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	amdgpu_bo_unpin(queue->wptr_obj.obj);
 	amdgpu_bo_unreserve(queue->wptr_obj.obj);
 	amdgpu_bo_unref(&queue->wptr_obj.obj);
+
+	if (queue->sdma_userq_db_slot >= 0)
+		amdgpu_sdma_userq_doorbell_free(adev,
+					(u32)queue->sdma_userq_db_slot);
 	kfree(queue);
 
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -762,6 +766,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->sdma_userq_db_slot = -1;
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -792,6 +797,38 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto clean_mapping;
 	}
 
+	/*
+	 * SDMA UMQ doorbell override:  user-allocated DOORBELL BOs land at
+	 * BAR offsets outside the firmware-managed NBIO SDMA decode window
+	 * and cannot reach the SDMA back-end.  Replace the user-supplied
+	 * doorbell index with one allocated from the per-device
+	 * sdma.userq_db pool that sits inside the routable window.
+	 * Userspace fetches the mmap offset for that pool via
+	 * AMDGPU_INFO_USERQ_DOORBELL with AMDGPU_HW_IP_DMA and mmap()s the
+	 * drm fd at that offset (no GEM handle); sdma_doorbell_offset_bytes
+	 * (returned in args->out) tells userspace where inside that mapping
+	 * its slot lives.
+	 */
+	if (queue->queue_type == AMDGPU_HW_IP_DMA &&
+	    adev->sdma.userq_db) {
+		u32 slot_id;
+
+		r = amdgpu_sdma_userq_doorbell_alloc(adev, &slot_id);
+		if (r) {
+			drm_file_err(uq_mgr->file,
+				     "SDMA UMQ doorbell pool exhausted (err=%d)\n",
+				     r);
+			goto clean_mapping;
+		}
+		/*
+		 * Slot id is a qword index inside the routable window;
+		 * convert to absolute BAR dword index.
+		 */
+		index = (u64)(adev->doorbell_index.sdma_engine[0] << 1) +
+			(u64)slot_id * 2;
+		queue->sdma_userq_db_slot = (int)slot_id;
+	}
+
 	queue->doorbell_index = index;
 	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
 	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
@@ -851,6 +888,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	amdgpu_userq_init_hang_detect_work(queue);
 
 	args->out.queue_id = qid;
+	if (queue->sdma_userq_db_slot >= 0) {
+		/*
+		 * Tell userspace where inside its mmap of the SDMA UMQ
+		 * doorbell BO (handle returned by AMDGPU_INFO_USERQ_DOORBELL with
+		 * AMDGPU_HW_IP_DMA) the assigned qword slot lives.
+		 */
+		args->out.sdma_doorbell_offset_bytes =
+			(u64)queue->sdma_userq_db_slot * sizeof(u64);
+	}
 	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
 	mutex_unlock(&uq_mgr->userq_mutex);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 675fe6395ac8..cdfced627dec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -59,6 +59,13 @@ struct amdgpu_usermode_queue {
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
 	uint64_t		flags;
+	/*
+	 * For SDMA UMQs whose doorbell came from the kernel-managed pool
+	 * (amdgpu_sdma_userq_doorbell_alloc), record the slot id so it can
+	 * be returned to the bitmap on queue destroy.  -1 means the queue
+	 * is using a user-supplied doorbell BO.
+	 */
+	int			sdma_userq_db_slot;
 	struct amdgpu_mqd_prop	*userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_vm	*vm;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9f3090db2f16..79e8bbda046b 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -421,6 +421,14 @@ struct drm_amdgpu_userq_out {
 	 */
 	__u32	queue_id;
 	__u32 _pad;
+	/**
+	 * For SDMA usermode queues whose doorbell was assigned by the
+	 * kernel from the per-device pool (see AMDGPU_INFO_SDMA_USERQ_DOORBELL),
+	 * this field carries the byte offset of the assigned slot inside
+	 * the routable doorbell window so userspace can write there.
+	 * 0 means the kernel did not override the user's doorbell.
+	 */
+	__u64	sdma_doorbell_offset_bytes;
 };
 
 union drm_amdgpu_userq {
-- 
2.49.0

