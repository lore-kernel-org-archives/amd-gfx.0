Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10032FF8861
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 792FA10E604;
	Mon, 27 Apr 2026 08:35:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jUTiahk3";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012014.outbound.protection.outlook.com
 [40.93.195.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D36810E604
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 08:35:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYwyZN+ezDIGHHdjW9/LrwCw0wjfo9ckqxaxnz4/Wwou9J6Qv2tr99Y3hafcHsspx5sgDkzsIu4Uf9/D7ZIIrPg2vAibeMSxKjHosYTvXdGDSglsoVTFCH2/tLJ46QMgG7tWwob9Gg0smH1qpJbj4clftjiuNeEFDM/n1OAALWz9lf9lBF+5B2wHiNOn+Rx/BK3sBUo98+eIurEn9rWgzsjeg2L48G6QZJ+t9iEqFrHnQe7x1mz/enLFc3wOBpHc1muVHc5lnHiytXZO1X06YjXZOIZadiLQxHH0NZaJd/vogCEmPAog+DD1SWGruz1vfoWuPBUFKco8f1WwaQSyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZqb5hFUkIWujIkEtGvVgDoE1M3jR/Plk0/LZl33uvw=;
 b=vKTXJYFvi2V+1ciz8nxLQtBFxKUqO8aeA5aEXb20CBOm6iZTwBTwyIefb6k6sjzyQOdd/yBNamfmvq/ldgVPWTcUuJu6LEooyn1dJq1G5K4NNYeLaYTCFBf3mJkMyRdWIaeHWYNtgcEQULW1y6OH5vxCEYNpymMAsUTsSQO4YaN1rK3sqzB1w51s6Ady/gTOwMfvqJJGSW+FH3IcYCZWQO9mQvQIC5ni9l7KwcBEm1qWV8otDjfYxwGHBAgHoPyfrBBr5Vpd/+rikmvkRNJZGHWPc1YTwUGi/pJiPpsY2nh8aJIyZF6IxskEagk40c7H2UZXurMnEGtG8SDmP2jPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZqb5hFUkIWujIkEtGvVgDoE1M3jR/Plk0/LZl33uvw=;
 b=jUTiahk3RbbL7lqKP04ky5Fr8Nhx1bPfWFHqITFqkEHvFhfZwkvrz6ujp01sCykdj+1h8YF8WRliY1UbvlzbqQcMUFLRBZ9TCKDZ7reWeZgYS4v7KjyfqYnGat0RdAGRM12yAf2ZjxKefavz7y8npArYAPboySJTfpGQYE3U3AM=
Received: from CH5PR05CA0002.namprd05.prod.outlook.com (2603:10b6:610:1f0::8)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 08:35:53 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::a) by CH5PR05CA0002.outlook.office365.com
 (2603:10b6:610:1f0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 08:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 08:35:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 03:35:52 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 03:35:45 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 02/11] drm/amdgpu/userq: route SDMA UMQ doorbells through
 the kernel pool
Date: Mon, 27 Apr 2026 16:34:28 +0800
Message-ID: <20260427083543.1328533-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
References: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ba2cd3-f2c7-49c8-70b1-08dea437fe34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: BEuUz3cNQy4/VTZHUFCMAXXpTTYVYKXwKZgu2q1AqcZavCqyxmyowQc5NGqKvCc32h6Ij2o5ht3qnmnlCMsz3k0pufyVCkNj3nSPL3XOKxKHNyXvL8WCxRxuQNmLK65hSoKije2egcaEVsEt4uM0IAGe1AKBdapuUUm90P5oOR5q9mP8RP9lpFJz4gMhCOLjalpneAWQKae9GzWjmSoOYd9wRin7eWRTv5Dj725dSsWh43QlCsHlF3AKF6hyya9UuVJ+BRr2YQ88L6IY+S1hdX9fe71OJ0fMrCVRQk2E1dV4ZITolCS0YrSyaQZNDfVuOSMgfQD8qoWV6G3Q9D/ZF8MPpAkymOn7htS6essqPx0QOqI3Q4xLDEp5hI/pk/TDi2qgckiBMoqXYGLkXvo8RjRQnaWVN4MgcT/QKAR8kbkf4Dug8VLv7s96m0RATYyBZ7bmdX4ddBcW7jpUJzSHAxL1GiSzZofG3fxLaiWco2YmKStxyBTcfkoEGl0tNBpgogv327X98a13ZPmML6cRX862ILBqT0UONEkgM6/j4gWdRJR/E22zSSXUomZdYVkouT6d6Nb0UukAbPoeYzUfXvcCof52l/d/nU6AXFUgKSB/56c5EdBczCAiRTK9HoBodHaVRAiwmrnhDgYq9sURWKRFlSZYKFamuW5gbs6I1/cRUXSDsnLrig1YX1MN5vba06EhM5HlexWxVbYaZAQSjVgk5HFkf6klDdbquHfh331w7zdgngdTyjiuADIZMavnY9R1d9MZ6vKz19f9o06lPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s+MSJeYfZBzBL8J7P5FsDtpMYeAqVpe1dBqY+Sk9C03zj16JcwFykjPlWpSmdN6FMYVj27GkmkYwFAr+/4xJHPrkV5UdIJnq/QsDPZByYLGy92wC/576/Fu4splL4CQDqnfLCqqpn/7cNpeW/NlRA4HqNtYztqTqyB8g4gVLFfq4rl3+66BlQcYdClGhaN1gMtaiA/w/CCaKJ49XHSTaLp1DSqDVeK/QndP88uIFTSebG43add8fiIpca+IlcS8GMH1+l+WlpwBEMcPnLnw6yqrfsAdmsioSW5X1JGIAiCeqcJH2l2mSK1r12dOhUQmT3w9Zp2Olbzmvp0+Iot2SO3vElAuY/hr5mzda+dsOr62fDWwYmbTqkbsgJ4Dy7a8El/BjUUVGDx9Y3IY+rqJ0zv7i6allJlqe23M1GDDOAGJzF3JbmM7P//sSWRIL/6P7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:35:52.7668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ba2cd3-f2c7-49c8-70b1-08dea437fe34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789
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
inside the BO it will mmap (the BO handle comes from the
AMDGPU_INFO_SDMA_USERQ_DOORBELL ioctl added later in the series).

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 47 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  7 ++++
 include/uapi/drm/amdgpu_drm.h             |  8 ++++
 3 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8f48520cb822..cea0f9cb59d0 100644
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
+	 * sdma.userq_db_obj BO that sits inside the routable window.
+	 * Userspace fetches a GEM handle for that BO via
+	 * AMDGPU_INFO_SDMA_USERQ_DOORBELL and mmap()s it through the
+	 * standard GEM_MMAP path; sdma_doorbell_offset_bytes (returned in
+	 * args->out) tells userspace where inside that mapping its slot
+	 * lives.
+	 */
+	if (queue->queue_type == AMDGPU_HW_IP_DMA &&
+	    adev->sdma.userq_db_obj) {
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
@@ -851,6 +888,16 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	amdgpu_userq_init_hang_detect_work(queue);
 
 	args->out.queue_id = qid;
+	if (queue->sdma_userq_db_slot >= 0) {
+		/*
+		 * Tell userspace where inside its mmap of the SDMA UMQ
+		 * doorbell BO (handle returned by
+		 * AMDGPU_INFO_SDMA_USERQ_DOORBELL) the assigned qword slot
+		 * lives.
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
+	 * kernel from the per-device pool (see AMDGPU_INFO__USERQ_DOORBELL),
+	 * this field carries the byte offset of the assigned slot inside
+	 * the routable doorbell window so userspace can write there.
+	 * 0 means the kernel did not override the user's doorbell.
+	 */
+	__u64	sdma_doorbell_offset_bytes;
 };
 
 union drm_amdgpu_userq {
-- 
2.49.0

