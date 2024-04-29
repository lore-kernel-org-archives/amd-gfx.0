Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E592C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 06:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55792112AEE;
	Mon, 29 Apr 2024 06:44:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qOIheiwg";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEBC110F4B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 06:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XC74z0VaycPN6q1hWStYhhco4+/eo3fh4yOhdY6Hee3lsPIfRlYM06Z9MTT8RxM0KiTlUqLiCZ+aW4B6ZWG1QiULut7dFXIgdG3Twvpko8FD1F6WR2LWpVakg8Ff7RjAOLt+HTC5ICtZa0sy1uo5/l4GMvhjKei27zNsv4HWSSPvxfjSjBrGQB+scQWsfNs8NpecY0DExi/6NHE1C0QLmJPbelVhNRQf2Hn5DfWt5FOfXSwMzVEnaWNqRiO1/kUVNAjDGDUCc2i9kEVo5l6QBwWMBY/FWc0O9h/WuEKq6fsb6WuljSj4M/qk8oaCvcs1apovJaknOnvBEo4trIQkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsqScozvKDm/uOlrAOquiV5Y0pfjhRNxCpQ7iUg772Q=;
 b=m7AMJuK4hiue8KMqZcPpUQhvDdT32aasEgZdndIHSkpulHN47jdvfXa3OUF/8V7nON8lYR3VIEF2rUJxM5fD0yYz/l7c8obT5CMmgxa0VBibpA+gPCuI1Tz8mwa6Jb6Y+qRY/n1p6hOa8GwmzIaR6efGJNewBV8ZaWom0uW1XyRtjkp0xSi9ehFAcHsaNlRmdFoeP0G/CJ6aw9lWMaSI8aFcEv0DBVrjEh3FEulAQ6G/q0L2xubSrfxJ2gpgwyBA9MwMltwRvbY1yAHJj1s21/osA5scu71TfmHptFvck6rkGo+lGdcD7d4ljcov7Xt+XXigSIKDBfveCpY1Qz1VOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsqScozvKDm/uOlrAOquiV5Y0pfjhRNxCpQ7iUg772Q=;
 b=qOIheiwgBt3+7nsFJrhKjcTszrP74dnZSOLYwMjPn4Z+c6lqZhSPFRqDIo4PbAzH6Wg3iAqqsUW3FgeL/7WMTj+9gRiJ0LfLRMMHRpofIOUSqzgY14w++fIqdpv9OonsQM/lHgmlQnLXRJOo0/D1nmsQlWvNa9BKDD1r3C4lvfQ=
Received: from DS7PR03CA0155.namprd03.prod.outlook.com (2603:10b6:5:3b2::10)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 06:44:33 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::ba) by DS7PR03CA0155.outlook.office365.com
 (2603:10b6:5:3b2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 06:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 29 Apr 2024 06:44:33 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 01:44:31 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v9 5/5] drm/amdgpu: Enable userq fence interrupt support
Date: Mon, 29 Apr 2024 12:13:51 +0530
Message-ID: <20240429064351.626929-5-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240429064351.626929-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240429064351.626929-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|DM6PR12MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a45174b-dc85-4418-f7ee-08dc6817d471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uKH7MzlFcyScKViOxQ7Y2ls8a0kVYdbJ9UXf/2yO+0k83etIPBKO8q+7WBIA?=
 =?us-ascii?Q?LxvOduSZ2C0GJ1/D1ei/ca08jNEQokiK6CoVBcka7VSEg0DRU0jwDB09pIjA?=
 =?us-ascii?Q?LiZa0GXKfOWFj66MqmvHvsnJf90+gjcyOcTVXjDdqKYABtqV1/8cMLKPCxN7?=
 =?us-ascii?Q?0s7RkFg+BBlj9d0WCdOaZ5J+TS8uI6G1J+aXOSYP0Y/I4S3lNtB6nGEsA8+s?=
 =?us-ascii?Q?b5/P1mVAB6oxGT928CR054wLEgHzXaUtU66fTAsAEtW4ZlxGpkk+V5vCVjpw?=
 =?us-ascii?Q?xN2zb1rEuwB6pfBM94eXyaLStxHHlnobcZ+sGVMTMh5v3dncqnI6DF24g4Yp?=
 =?us-ascii?Q?onv/3bPy/Z8RDIYJ30/DytRGYvdbFuVXDENCDF+xhyW9PeJ1rtG3v280n+Os?=
 =?us-ascii?Q?tJQ3e9JIFm3FMdJqeW+GWRM1deP5sEgRfDBTb7icG9rjysohIUXX5bQcWb8p?=
 =?us-ascii?Q?kjCTSnc0XE4fLm1M16oTJDiwkXHbYZM3GOHvFFxLivWKTb3z3MjD1//eMPGN?=
 =?us-ascii?Q?6GNCX03y01T5WS9FdIOLRQffukNdvop8mxHsAewgx5ct7beID4iWt+yvXqC4?=
 =?us-ascii?Q?2Hq2D0gBWDSDpZq3wB+LLtoVlWnfIghFraQOwgPAB7eSgXddlW/+WjAxV2wJ?=
 =?us-ascii?Q?0pHkY7iw13q6ln6Em4JQYHPtfvazTf9N4v44GTQa2jvnTLhiOAY+8ODGb0Wv?=
 =?us-ascii?Q?sH0t/A+tlDDl0/5gnG973WQtm7zNCykl0Suib8cwz7iUdDpaNIGJ8DJjuU4w?=
 =?us-ascii?Q?SUCIdDh8CUAuofLKLTk/2aS13/pIpL4IhjNNRtjvQ/LpkL6aimsVBktmjzTK?=
 =?us-ascii?Q?JZwyo26XAFJLNqu/QzTu+cRitGOV5hiT20dkJHGni5zlmfdEC3Vgcj616BWr?=
 =?us-ascii?Q?7O9ZoH2ocGoXdFF13rF9/lD8iRbWqjhQJx2a7AzRMMwPz2Jtu7ys94wBNVCA?=
 =?us-ascii?Q?8z9YSAdAJuYTWoRypMtIrSBXVyH+eAmhOm1c87lb9zvvVp581DVgf68PgQa6?=
 =?us-ascii?Q?NPhSM2MBwYLdAYEYJ3MjNfHdKunbYBilzoOm98KDmMFJhZMGXgVhxb5V1iBd?=
 =?us-ascii?Q?QEz6SWQWPu6PFoKnIiE0JWMUOXCeZBOtpukVoGawLu7V7FCHrq4+O5zkmFw5?=
 =?us-ascii?Q?lqGiQ6p9AtKeGsm7m1oI+RE2SsBMnoMxRbRK/luagYsnjwVSTj+jvlj53RSN?=
 =?us-ascii?Q?P9Vjsvvb3VddMSsjsiT7nMpohArqgNkttZHZlP/tWQ1vZlEzMyqvYzfVH/z8?=
 =?us-ascii?Q?xoGSfSNjZi2IZiidEwbx2uDlRM5NMYtpMOZtDkvsQF4XyQLDYTtKzOrVcqWn?=
 =?us-ascii?Q?Nm2ADwdvkG6ORVvmsxpUQ2nqihZj8m2bHYzfPSKSg3TseQb9EtfhPy7JaqYM?=
 =?us-ascii?Q?MEF2uig=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:44:33.6918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a45174b-dc85-4418-f7ee-08dc6817d471
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
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

Add support to handle the userqueue protected fence signal hardware
interrupt.

Create a xarray which maps the doorbell index to the fence driver address.
This would help to retrieve the fence driver information when an userq fence
interrupt is triggered. Firmware sends the doorbell offset value and
this info is compared with the queue's mqd doorbell offset value.
If they are same, we process the userq fence interrupt.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 ++--
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  6 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 25 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c        |  5 ----
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  7 ------
 6 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4ca14b02668b..2d5ef2e74c71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1043,6 +1043,8 @@ struct amdgpu_device {
 	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
 	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
 
+	struct xarray			userq_xa;
+
 	/* df */
 	struct amdgpu_df                df;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7753a2e64d41..fd919105a181 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3982,6 +3982,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	spin_lock_init(&adev->audio_endpt_idx_lock);
 	spin_lock_init(&adev->mm_stats.lock);
 
+	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
+
 	INIT_LIST_HEAD(&adev->shadow_list);
 	mutex_init(&adev->shadow_list_lock);
 
@@ -4719,9 +4721,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	}
 	adev->in_suspend = false;
 
-	if (adev->enable_mes)
-		amdgpu_mes_self_test(adev);
-
 	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
 		DRM_WARN("smart shift update failed\n");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 6fb75cc1d20c..614953b0fc19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -70,6 +70,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq)
 {
 	struct amdgpu_userq_fence_driver *fence_drv;
+	unsigned long flags;
 	int r;
 
 	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
@@ -96,6 +97,11 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	fence_drv->context = dma_fence_context_alloc(1);
 	get_task_comm(fence_drv->timeline_name, current);
 
+	xa_lock_irqsave(&adev->userq_xa, flags);
+	__xa_store(&adev->userq_xa, userq->doorbell_index,
+		   fence_drv, GFP_KERNEL);
+	xa_unlock_irqrestore(&adev->userq_xa, flags);
+
 	userq->fence_drv = fence_drv;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a786e25432ae..d6cdca0a652f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -49,6 +49,7 @@
 #include "gfx_v11_0_3.h"
 #include "nbio_v4_3.h"
 #include "mes_v11_0.h"
+#include "amdgpu_userq_fence.h"
 
 #define GFX11_NUM_GFX_RINGS		1
 #define GFX11_MEC_HPD_SIZE	2048
@@ -5939,25 +5940,25 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 			     struct amdgpu_irq_src *source,
 			     struct amdgpu_iv_entry *entry)
 {
-	int i;
+	u32 doorbell_offset = entry->src_data[0];
 	u8 me_id, pipe_id, queue_id;
 	struct amdgpu_ring *ring;
-	uint32_t mes_queue_id = entry->src_data[0];
+	int i;
 
 	DRM_DEBUG("IH: CP EOP\n");
 
-	if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
-		struct amdgpu_mes_queue *queue;
+	if (adev->enable_mes && doorbell_offset) {
+		struct amdgpu_userq_fence_driver *fence_drv = NULL;
+		struct xarray *xa = &adev->userq_xa;
+		unsigned long index, flags;
 
-		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
+		xa_lock_irqsave(xa, flags);
+		xa_for_each(xa, index, fence_drv)
+			if (doorbell_offset == index)
+				break;
+		xa_unlock_irqrestore(xa, flags);
 
-		spin_lock(&adev->mes.queue_id_lock);
-		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
-		if (queue) {
-			DRM_DEBUG("process mes queue id = %d\n", mes_queue_id);
-			amdgpu_fence_process(queue->ring);
-		}
-		spin_unlock(&adev->mes.queue_id_lock);
+		amdgpu_userq_fence_driver_process(fence_drv);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
 		pipe_id = (entry->ring_id & 0x03) >> 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 4d1121d1a1e7..faa489c75fea 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -1163,11 +1163,6 @@ static int mes_v10_0_early_init(void *handle)
 
 static int mes_v10_0_late_init(void *handle)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	if (!amdgpu_in_reset(adev))
-		amdgpu_mes_self_test(adev);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index feb7fa2c304c..0051e2d6af86 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1276,13 +1276,6 @@ static int mes_v11_0_early_init(void *handle)
 
 static int mes_v11_0_late_init(void *handle)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	/* it's only intended for use in mes_self_test case, not for s0ix and reset */
-	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend &&
-	    (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(11, 0, 3)))
-		amdgpu_mes_self_test(adev);
-
 	return 0;
 }
 
-- 
2.25.1

