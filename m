Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C85C28B30
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 08:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD7E910E52D;
	Tue, 11 Mar 2025 08:33:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kd/C/6G5";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B541910E52D
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 08:33:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjGU8n6qsTZTnzh5I7SjusnaawtdBX7N+DGDEDfWwu5QRzEKu2jwtO5hT2rtx51QO7QTQy1N4mQ+5usVEcpy6LUoiuxCqVMwlcJCLsdVr6l+9vf/jWkrURcTGuZHczoZh5fX2CAAST9VqEFBnnPYvv1XQAb2Q+j/4zt+MRI+ZSnrmwoyd1JO+ii45i2B4z2D6z0fN6UJKdZGi9P5mDxx5kvXDSXZ7JJtaq3Jvbm9UN98hyPD77uyuGS3pBqXtJf+iZzMhsqFpmPn0owHke+HF14+FnrxhzDQX1SSm3I5isSbUtJ5yM4fKAzvY2HAcMUaApEspCIbNUnE1G2+7FOkvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGNHisXCpa8/dC8dPi8qkXy0T+Z9TQl+2JGLmiS1RlY=;
 b=RBC0IzhlUcnkIbUBS3lJVy9DTWGERnLpNeYnqWobzk23CeWpODKirpS8Z4UNMoJdaIEsqEbdbtuJLuz38HjHp2s8KJ0eBHaVxzJUtWtZHlS5jTOfq9N8uI7Eo9eFjhCYA60uNnPsWSrBmnqy22kx7niJaJ4tYcz8H1ynlDAIfRjPSueTGVGch33nKlY7PvZJ82hB1xCjp5LmM00ivks/yklDAzy0a4N0Kq/c9wOxvOP0npceFQa2oQr8nGej3NWs2YU2k38OVOCCZF1xTgW929NxCP8URaQV/zPbPM4GAQnjqWjNEKgk/en+WgGEIiKl//7rO7LdvXoSEaUPIv2moQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGNHisXCpa8/dC8dPi8qkXy0T+Z9TQl+2JGLmiS1RlY=;
 b=kd/C/6G5uLBw3k8MpZJ1N+i5mSpnMbbvIntm6vg8+MNs02sXghUg88ryf9Ky/3Suse/uuZgi+tvBwou5uBwg5KhpR5TuVMqwQbFIK5ZUqg0MKYvYPsxq+48FLlTZHRs4qTRkIxoF3V1x8oE4NRFm57VLpYo8QqCqmw16CJ7adY8=
Received: from SN7PR04CA0169.namprd04.prod.outlook.com (2603:10b6:806:125::24)
 by LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 08:33:16 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::94) by SN7PR04CA0169.outlook.office365.com
 (2603:10b6:806:125::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Tue,
 11 Mar 2025 08:33:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 08:33:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 03:33:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 03:33:15 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 11 Mar 2025 03:33:08 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add SDMA queue start/stop functions and
 integrate with ring funcs
Date: Tue, 11 Mar 2025 16:33:00 +0800
Message-ID: <20250311083300.2897523-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250311083300.2897523-1-jesse.zhang@amd.com>
References: <20250311083300.2897523-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d271d20-5f1a-466c-669a-08dd60775ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mGBIpFTbKyIomD+jKP89DOVHkJjFWrD/gtFVTVZxk3gplB7h0FdqFcBYbI/d?=
 =?us-ascii?Q?XaW+qsSQL1ZlFNmIWrxKA9I3T0GBvHVxEDFVQTptyh88FhJwPWM0alQ8RBlN?=
 =?us-ascii?Q?IEa+EFXeRnMz7mks1VKPEJz4MIZEsbk9svWj9r4Iln99dnX3or5FGPkadMH6?=
 =?us-ascii?Q?3DnxokoG+qnwDhEv6m2vZOUa4qpP4+BuD7MlSDUmRyCrk1YrZwFbgEzUOlRa?=
 =?us-ascii?Q?c3zuyVQA3z+Zz1p6GKgZ6YDcOOzn1ZUOcxXPuHPCfkaergfeW3kcI95LsFER?=
 =?us-ascii?Q?/lnQr0voswgRbt5koXyPvz+MVrDeY4trVVFxjT6PID9dLdRkpKtD8K2rF4JH?=
 =?us-ascii?Q?po/7QD64I+tWrpHCCjv72BKrW79oiUYCUHyTHcKSSLmbuwRDb9ci0ZimgXeO?=
 =?us-ascii?Q?eTMiZ5pIj6fjv+XgihZCraPh2Uhv0Kbg5qVpz3SoCzy/U14zHxWIGWrMYB8Y?=
 =?us-ascii?Q?1bNkI5p5vNr+84UCI7VSv3iU4cS1uscL+S8pK2R8KZhFxQwJp4zi6MhZ4oH6?=
 =?us-ascii?Q?gTinLno/0eEBZqQ5layqh6MWD6c7UBfF8jvzjKIbr0mvSIvSD+zrI4A+zUQY?=
 =?us-ascii?Q?hY0Lgc8BLpYmK6055aIlqGG7L00Ot33qA86doUjkWgPSihEKpCeKBh93lk6F?=
 =?us-ascii?Q?9DH6I/T4lbr5+sPhmcwVMakKNOSxGzf4GzLjTa1zcvOWO/Lq8L0GyzuYIuMt?=
 =?us-ascii?Q?j9IXeWiOU6jniRxQfkFzOe0VQ6I7HdJso+aT+uv+zoaN/dWVT9YGloan+Svs?=
 =?us-ascii?Q?jNdnzWWmzPo2AKhjS4ufCxzb7Wz5SY4A0MFNtze2yAFHILxENd+H3ibQuDjt?=
 =?us-ascii?Q?Y4hq1XvhGdsvFFgW1aZvdxpCW6c+fHm0RWs+WkmE/+B/G7cGVjLFiJ+WyH5f?=
 =?us-ascii?Q?8vkSKDgk+KpUVIyoAEOq5VbiQL9zCtpfM2YKdAbQHpjDomZ75uGC/mkdmJpG?=
 =?us-ascii?Q?cjmfHRPTy1H+1Y5a63tnTyJPsQJtxPtPhIbWvsUzFAsoyxfyZCxpgHy32APq?=
 =?us-ascii?Q?+pWjJdZBLcekA6+QjBLivCwVNDO4s4kh8NbGICqUlhrB9FBJxo0U+4r7Knio?=
 =?us-ascii?Q?CuyQRf1gRLgsXxdDlIYDeW8iEHOQkwFQDMWhKKMDIsATZQKsLOg2D3vGX0xg?=
 =?us-ascii?Q?ZaNQ2z3G4HVSzYKg0x7mqE6vQvXbsIbf01hlGrJXCSBiZd2wd/oSJ/jilxEE?=
 =?us-ascii?Q?ZgG2N+K/FTlwy2oUYwCX6S2wiXB7H9Wknxo1ejHIdwpfDWYdRUnK+k890fW5?=
 =?us-ascii?Q?tH7bxfbnklY/Om05Tg+TtthC2oBL5g5qVOPsQcVO8xc+VRsQ9AurhpSHzLgJ?=
 =?us-ascii?Q?OFnWWfcXaUQWe3gMJ2cv31Ypzw8HIqoFXVtBd5D+GvL/oEl9kLdFEAHiR9Zl?=
 =?us-ascii?Q?R/hfpxwTqnsTgpuukxHjVIA8/o21sMJxsJlwxoYr2aBgjYEI3nB00m7zJOco?=
 =?us-ascii?Q?wdP4MPl5YK+1cpzCXoWAmYT4SFQaqOOaGnnU010e6M2GeZeI2USbi1AFhN3j?=
 =?us-ascii?Q?UG5lOjc+C6DIlSM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 08:33:16.2386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d271d20-5f1a-466c-669a-08dd60775ebd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch introduces two new functions, `amdgpu_sdma_stop_queue` and
`amdgpu_sdma_start_queue`, to handle the stopping and starting of SDMA queues
during engine reset operations. The changes include:

1. **New Functions**:
   - `amdgpu_sdma_stop_queue`: Stops the SDMA queues and the scheduler's work queue
     for the GFX and page rings.
   - `amdgpu_sdma_start_queue`: Starts the SDMA queues and restarts the scheduler's
     work queue for the GFX and page rings.

2. **Integration with Ring Functions**:
   - The `stop_queue` and `start_queue` callbacks are added to the `amdgpu_ring_funcs`
     structure and implemented for SDMA v4.4.2.

Suggested-by:Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 92 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  2 +
 4 files changed, 97 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index d55c8b7fdb59..ff9aacbdf046 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -351,6 +351,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 		0xffffffffffffffff : ring->buf_mask;
 	/*  Initialize cached_rptr to 0 */
 	ring->cached_rptr = 0;
+	atomic_set(&ring->stop_refcount, 0);
 
 	/* Allocate ring buffer */
 	if (ring->is_mes_queue) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 1c52ff92ea26..7a984dbb48c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -312,6 +312,8 @@ struct amdgpu_ring {
 	unsigned int    entry_index;
 	/* store the cached rptr to restore after reset */
 	uint64_t cached_rptr;
+	/* Reference counter for stop requests */
+	atomic_t stop_refcount;
 
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 39669f8788a7..7cd6dcd6e7f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -30,6 +30,7 @@
 #define AMDGPU_CSA_SDMA_SIZE 64
 /* SDMA CSA reside in the 3rd page of CSA */
 #define AMDGPU_CSA_SDMA_OFFSET (4096 * 2)
+DEFINE_MUTEX(sdma_queue_mutex);
 
 /*
  * GPU SDMA IP block helpers function.
@@ -504,6 +505,97 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 	}
 }
 
+int amdgpu_sdma_stop_queue(struct amdgpu_device *adev, uint32_t instance_id)
+{
+	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
+	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
+	struct amdgpu_ring *page_ring = &sdma_instance->page;
+	int r;
+
+	mutex_lock(&sdma_queue_mutex);
+
+	/* Avoid accidentally unparking the sched thread during GPU reset */
+	r = down_read_killable(&adev->reset_domain->sem);
+	if (r)
+		goto exit;
+
+	/* Increment the reference counter */
+	atomic_inc(&gfx_ring->stop_refcount);
+	if (adev->sdma.has_page_queue)
+		atomic_inc(&page_ring->stop_refcount);
+
+	if (atomic_read(&gfx_ring->stop_refcount) != 1 ||
+	   (adev->sdma.has_page_queue && atomic_read(&page_ring->stop_refcount) != 1)) {
+		up_read(&adev->reset_domain->sem);
+		r = -EBUSY;
+		goto exit;
+	}
+
+	if (!amdgpu_ring_sched_ready(gfx_ring))
+		drm_sched_wqueue_stop(&gfx_ring->sched);
+
+	if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(page_ring))
+		drm_sched_wqueue_stop(&page_ring->sched);
+
+	if (gfx_ring->funcs && gfx_ring->funcs->stop_queue)
+		gfx_ring->funcs->stop_queue(adev, instance_id);
+
+	if (adev->sdma.has_page_queue && page_ring->funcs && page_ring->funcs->stop_queue)
+		page_ring->funcs->stop_queue(adev, instance_id);
+
+	up_read(&adev->reset_domain->sem);
+
+exit:
+	mutex_unlock(&sdma_queue_mutex);
+	return r;
+}
+
+int amdgpu_sdma_start_queue(struct amdgpu_device *adev, uint32_t instance_id)
+{
+	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
+	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
+	struct amdgpu_ring *page_ring = &sdma_instance->page;
+	int r;
+
+	mutex_lock(&sdma_queue_mutex);
+
+	/* Avoid accidentally unparking the sched thread during GPU reset */
+	r = down_read_killable(&adev->reset_domain->sem);
+	if (r)
+		goto exit;
+
+	/* Decrement the reference counter */
+	atomic_dec(&gfx_ring->stop_refcount);
+	if (adev->sdma.has_page_queue)
+		atomic_dec(&page_ring->stop_refcount);
+
+	if (atomic_read(&gfx_ring->stop_refcount) != 0 ||
+	   (adev->sdma.has_page_queue && atomic_read(&page_ring->stop_refcount) != 0)) {
+		up_read(&adev->reset_domain->sem);
+		r = -EBUSY;
+		goto exit;
+	}
+
+	if (gfx_ring->funcs && gfx_ring->funcs->start_queue)
+		gfx_ring->funcs->start_queue(adev, instance_id);
+
+	if (adev->sdma.has_page_queue && page_ring->funcs && page_ring->funcs->start_queue)
+		page_ring->funcs->start_queue(adev, instance_id);
+
+	/* Restart the scheduler's work queue for the GFX and page rings */
+	if (amdgpu_ring_sched_ready(gfx_ring))
+		drm_sched_wqueue_start(&gfx_ring->sched);
+
+	if (amdgpu_ring_sched_ready(page_ring))
+		drm_sched_wqueue_start(&page_ring->sched);
+
+	up_read(&adev->reset_domain->sem);
+
+exit:
+	mutex_unlock(&sdma_queue_mutex);
+	return r;
+}
+
 /**
  * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
  * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 965169320065..a91791fa3ecf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -170,6 +170,8 @@ struct amdgpu_buffer_funcs {
 
 void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs);
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, bool suspend_user_queues);
+int amdgpu_sdma_stop_queue(struct amdgpu_device *adev, uint32_t instance_id);
+int amdgpu_sdma_start_queue(struct amdgpu_device *adev, uint32_t instance_id);
 
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
-- 
2.25.1

