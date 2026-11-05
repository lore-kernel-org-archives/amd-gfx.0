Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789DB606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5eWApL22
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2F910FB3F;
	Thu,  5 Nov 2026 03:06:46 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1EE110F3C5
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXsUNQADsGxncbGmeJzCHUFkw81C3ArA7z3dnBPGgxA2FLtWoYbDalOlXnb7bHUJq+MB7AurWIaqUkK6OKzuOIQj31h87H9jWjQAZPeyX0K8sv75tnMlzua8wcaWzwxwlnX7fBQNxMU943sDQp2BSIhPS95ioiW90du+21O0MVcmGrGobaYQDvK9U8vVfYgKaqCPoi4kbc4KiLXzarJ2E4SFpfB3GZ5EeXt8N9kPilObt1eHiFU3sut7GdGPHbumv9NxXVG1b3K7LRcnBYyKgEbCPcZO0d1q2yaxCGdv3EPGYnqixTWz5aZzppQmf5B8Hgd337ps8Aer6Fp/u+EAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN22fptu5cHrPXefvb0E88h5ttbrNuKlgNsfIW2bv8I=;
 b=DCEjQn4yTc5l2VW+Egiky2+aFL8xUg48HkXNpgoTJ23seILEKN6cesqZ5uxT7tUDpV8hXTdMQuZjGu+/nTruP4ghshnQaAAhATpWVVFSi8tUabEsa7VWzDQMX7Gg5l9ObGOuDpqK+uM1bCpvc3YNkG8pZZB0WHL8aj3JHG2GBEDNH5HUqwkD4QVGU3OWllmBH+A6bd+8W1Txjht8HKfURARMspD317DhT4NYzMD9zycZn4H9CcJvTb2kwnH5CPooZDa3ZAqWVniASau4iGPORSmJaum818eRM3e+zfdi1WYBoomydTnKncyv7G0sJIzFjVUHw9ZjpOjYZi/rvVUU9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN22fptu5cHrPXefvb0E88h5ttbrNuKlgNsfIW2bv8I=;
 b=5eWApL22U0VxXXsk2TFts+TcKzEyHGjgPRX/Ie1afmUrarc0dLSr7p+KRLoBoCc/Bhcl8q5vLz9LL0iWsPs6mfRMlalacjamzdcqBBOWW3GcQgmW3DbWP9J+yPRC51ZhnqVmHXZ9594kB6aKz6wA6UEZ4s6C5v37NXkYy9tO6rI=
Received: from CH2PR14CA0040.namprd14.prod.outlook.com (2603:10b6:610:56::20)
 by LV0PR12MB768130.namprd12.prod.outlook.com (2603:10b6:408:3df::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 03:06:37 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::3b) by CH2PR14CA0040.outlook.office365.com
 (2603:10b6:610:56::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 03:06:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 03:06:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:33 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 21:06:31 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v4 08/13] drm/amdgpu/userq: add helpers to keep the user
 queues of one engine across a reset
Date: Thu, 5 Nov 2026 11:05:50 +0800
Message-ID: <20261105030612.726542-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105030612.726542-1-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|LV0PR12MB768130:EE_
X-MS-Office365-Filtering-Correlation-Id: 21be1163-6938-4cfb-d20d-08df3ae9ce66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|22082099003|18002099003|10067099003|11063799006|261021121427099003|261028144727099003|261026121527099003|261102123227099003|261026140227099003|261009223027099003|56012099006|261022105027099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: mn5mYE+KH7vyGOJioob1jgHfHZgOaoiD1TfG1oOSGOaD8pfJhHdMPZhyle9oKJLZkM32qoH+yF0qfVnmURx3RobTL+7G86nHwo4MyHpcdD/oyCAeq2eEmUqKBanOi5/npix1D5M72scXbax7WZeR+vQ8u7MiPgHBzeLJwhRqE5EK5s51ptQnPjV3TPC+IM2V94Fm4UWLoN0Ps0+l2+00HI3vt2+sO1HsMD3ILsZUIaLR2ZtoA3XMSXLBdxLJ4jCKFR7wkMEILEjxpKG7fCS1c7ATJJsA5UR3CpjyoXI2TV1Sr5v9m/ilQqNPn+H9T7GJhStP6SMrv30XDvI59dAPY4nLrZFcoUyrzEnFlz6c/rIZQpKI4hXV82moyZDug5qtrFC4Ll4UIXLb2TSyBKb7SL20CWYirNl8sfzWBpP+izebchriTSGPmTlSj6Vgi3QMKC/INq0z5qWyTtj11pOyZd4e8qFlP51NfNindpP/sbuW8Cn3mvWD3WlPvcVy3/KUpUF8Wa8vIrshIlQ6IcElsM2biHvzjtZtEQpS8X02FlL08F7r+OrFi70xBLkhNrhk5SBL5TI8EMVHxSUgokyrDRF4YInb/PqANAUfoeEtZzMXCaMgi+lUKzagLNF9Fe7/Nq1cMoxObq3lm+SEps3gwjL+WuYUo2lf+o8HesRvdP9HVnnhB9hvveinw2w+ep109GvyDf5IpJ/hptFD1GLZ0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(261021121427099003)(261028144727099003)(261026121527099003)(261102123227099003)(261026140227099003)(261009223027099003)(56012099006)(261022105027099003)(260925021311599003)(260925021911599003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: noE4rtot8t5nb37/kUDudJZWjBRsXVayPzCtlw3GXePoGTgh4IrSqK00wKXV+dKvj2UflAVLuRW893CB5e8jGIcqIUQLJkHNwL4Zh/upY4rN6Zt1Bd9FxGKFhePsSrkQFm8ZB6vNHll5c0G8VeFJaHva0Dg6Hy0KO66dgTs3LjUgdQGgrFiCyLZS7WfcExC280K8zG4eWS7FzcOl3Pnc1ukaopEE2kcs0cUl8KgdN5/4supckAFtFMo7WjdWDMNIiJHSFmbY0Gxj2G1kUGfWTh695tpEpqL1uojMyfybfWefWPdDo7QAn8MJTq9LYKrQYnpgg4t+gCB7CMYMPV//j4SkrZAUouOUPTzl3GgENEbbV3FgoZaKk0qkd6+lxWhQ3cjYcpMu5FRbrK2wrWB5TEwgyRF6gCyBfb6fjsSn/nySBj1LmOLCiVED9bsj1NyG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:06:37.4042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21be1163-6938-4cfb-d20d-08df3ae9ce66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB768130
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An engine reset, eg. of the gfx engine, only resets the queues of one
engine of the GFX IP; the queues of the other engines aren't reset.
amdgpu_userq_pre_reset() and amdgpu_userq_post_reset() handle all the
user queues for a full reset. Add separate helpers for the queues of one
engine, which keep them in the state they had:

- amdgpu_userq_save_hqds(), called after the MES suspend, saves the HQD
  of the mapped queues still on a HQD: the reset clears their HQD, and
  MES couldn't preempt them into their MQD. The queues MES preempted
  have their state in their MQD already.
- amdgpu_userq_restore_hqds(), called after the reset but before MES
  resumes, unmaps those queues, writes the saved HQD into their MQD and
  maps them again: MES doesn't map a queue whose HQD the reset cleared
  again on its own. The queues keep their state and their work, except
  the one the pipe executed: its work in flight depends on pipe state
  the reset cleared, it is dropped and its fences signaled. The queue
  that hung, if any, is unmapped and hung.
- amdgpu_userq_clear_hqds() drops the saved HQDs for the full reset that
  follows a failed engine reset.

The helpers walk the queues and unmap and map them as
amdgpu_userq_pre_reset() and amdgpu_userq_post_reset() do. The saved
HQDs are kept in the gfx IP, in saved_gfx_hqds[], and matched to a queue
by its doorbell and MQD address.

v2: Drop the user queue reset lock and the walk over the queues of one
    type (Christian).
v4: Rename the helpers and the saved HQD array (Timur).

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 107 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   4 +
 3 files changed, 114 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 1c23e97fd04d..79cb6be75329 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -515,6 +515,9 @@ struct amdgpu_gfx {
 
 	/* reset mask */
 	uint32_t 			gfx_supported_reset;
+	/* HQDs of the gfx user queues, saved by an engine reset */
+	struct amdgpu_gfx_saved_hqd	saved_gfx_hqds[AMDGPU_MAX_GFX_QUEUES];
+	u32				num_saved_gfx_hqds;
 	uint32_t 			compute_supported_reset;
 
 	/* gfx off */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ccf0ff490ac2..7d0c4e8795b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1594,3 +1594,110 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 
 	return ret;
 }
+
+/**
+ * amdgpu_userq_save_hqds - save the HQDs of the user queues before an engine reset
+ * @adev: amdgpu device
+ * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset engine
+ */
+void amdgpu_userq_save_hqds(struct amdgpu_device *adev, u32 queue_type)
+{
+	struct amdgpu_gfx_saved_hqd hqd;
+	struct amdgpu_usermode_queue *queue;
+	unsigned long queue_id;
+
+	adev->gfx.num_saved_gfx_hqds = 0;
+	if (!adev->gfx.funcs->save_hqd)
+		return;
+
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		if (adev->gfx.num_saved_gfx_hqds >= AMDGPU_MAX_GFX_QUEUES)
+			break;
+		if (queue->queue_type != queue_type ||
+		    queue->state != AMDGPU_USERQ_STATE_MAPPED)
+			continue;
+		if (adev->gfx.funcs->save_hqd(adev, queue->doorbell_index, &hqd) &&
+		    hqd.on_hqd)
+			adev->gfx.saved_gfx_hqds[adev->gfx.num_saved_gfx_hqds++] = hqd;
+	}
+}
+
+static struct amdgpu_gfx_saved_hqd *
+amdgpu_userq_find_saved_hqd(struct amdgpu_device *adev,
+			    struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_gfx_saved_hqd *hqd;
+	u32 i;
+
+	for (i = 0; i < adev->gfx.num_saved_gfx_hqds; i++) {
+		hqd = &adev->gfx.saved_gfx_hqds[i];
+		/* Check the MQD too: a new queue may reuse the doorbell. */
+		if (hqd->doorbell_index == queue->doorbell_index &&
+		    hqd->mqd_addr == queue->mqd.gpu_addr)
+			return hqd;
+	}
+	return NULL;
+}
+
+/**
+ * amdgpu_userq_restore_hqds - restore the user queues after an engine reset
+ * @adev: amdgpu device
+ * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset engine
+ * @guilty: the queue that hung, or NULL
+ *
+ * MES doesn't map a queue whose HQD the reset cleared again on its own: unmap
+ * it from MES, restore its MQD, and map it again.
+ */
+void amdgpu_userq_restore_hqds(struct amdgpu_device *adev, u32 queue_type,
+			       struct amdgpu_usermode_queue *guilty)
+{
+	const struct amdgpu_userq_funcs *userq_funcs = adev->userq_funcs[queue_type];
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_gfx_saved_hqd *hqd;
+	unsigned long queue_id;
+	int r;
+
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		if (queue->queue_type != queue_type ||
+		    queue->state != AMDGPU_USERQ_STATE_MAPPED)
+			continue;
+
+		if (queue == guilty) {
+			userq_funcs->unmap(queue);
+			amdgpu_userq_fence_driver_force_completion(queue);
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			continue;
+		}
+
+		hqd = amdgpu_userq_find_saved_hqd(adev, queue);
+		if (!hqd)
+			continue;
+
+		userq_funcs->unmap(queue);
+		if (adev->gfx.funcs->restore_hqd(adev, queue->mqd.cpu_ptr,
+						 queue->userq_prop->queue_size,
+						 hqd))
+			amdgpu_userq_fence_driver_force_completion_with_seqno(queue,
+									      hqd->wptr);
+		r = userq_funcs->map(queue);
+		if (r) {
+			dev_err(adev->dev, "Failed to remap user queue %llu: %d\n",
+				queue->doorbell_index, r);
+			amdgpu_userq_fence_driver_force_completion(queue);
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		}
+	}
+	adev->gfx.num_saved_gfx_hqds = 0;
+}
+
+/**
+ * amdgpu_userq_clear_hqds - drop the saved HQDs after a failed engine reset
+ * @adev: amdgpu device
+ * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset engine
+ */
+void amdgpu_userq_clear_hqds(struct amdgpu_device *adev, u32 queue_type)
+{
+	adev->gfx.num_saved_gfx_hqds = 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 488dc21d7c81..b5195031877d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -181,6 +181,10 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 void amdgpu_userq_reset_work(struct work_struct *work);
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
+void amdgpu_userq_save_hqds(struct amdgpu_device *adev, u32 queue_type);
+void amdgpu_userq_restore_hqds(struct amdgpu_device *adev, u32 queue_type,
+			       struct amdgpu_usermode_queue *guilty);
+void amdgpu_userq_clear_hqds(struct amdgpu_device *adev, u32 queue_type);
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
 void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
 
-- 
2.50.1

