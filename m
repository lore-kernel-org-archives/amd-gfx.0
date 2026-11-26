Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5761606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Zy7IO4Oy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5428112227;
	Thu, 26 Nov 2026 09:34:52 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E5DA112212
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZUR8cbz+HtAeZ0mB8rO16fzhh796iYV+in2/KJ//PlMfNM7QmyVjhxDajbQljnc4iM3AqoEju3GeSp4GxB5CWSMM4ALvfkmyfzNG6CkYzM5qdEUjLXszsPXa5YZ4UHLqw7gdQkAnWeqP7MxPuLfLmbF/otUYqF16HGP7MIDoSCO6C6Q7oHhuq3mfK90qmUXwUGOXmR5+Y03DT6F7QBlctaUI9mx4YvKgc/7H1rbTjndRczTBOUQ++TfG/j9EOTFi6r24CdKFIYwjj5Lr4nGCGlTWwAPEI5BBGaoQivfQ1+x3QWCkVGhnzOuhZoPYCHhUL2Kn852dogP+u0gxykFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDRh2Igq2GAHaH3OtjVsZ94/7dz9Bc3wpTg+dM8JLag=;
 b=cm3KYN1QlRFIlpNTEvibgmDXY7Lf2rvtjpkZPc/rFNvdUL6vXSvhws+gpaFlOxnSbodOB6beFoVdspYnu2zC152ecQvoA9q+9ydNXV9W08OsOT3s2H2GH2c30VZ58zVLKr+72gujC94euzV3AQ/S8dLTdV6pW8nI8+2Qa1R1X1BeHEF4yc51gBroOCITOw8ee8Ngn1/6Dob8RMnFE7G6kMZaGHxjjH82/eV7+e7Qy/OdSckqdtavfnovJgeUvgdGptLbHJazA51vApwg1fJOWkCv3ZV+YCvQy6A8Bz/rSXG0PTqIZ3C1wJm9063m71N1eiys4oLubnWG+JlYP7v1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDRh2Igq2GAHaH3OtjVsZ94/7dz9Bc3wpTg+dM8JLag=;
 b=Zy7IO4Oy8EVsKjZHr2eHZYWiPECNNzpFcNqhOB+1faB0JhP0N5/PyoyF55oezjoGPUly36bO1QLBCm4KV94QWKVJt6kQj4R1SU6mcfhAiJQTrHbkuC9Zl18sPq7xRmNWmh0bcscat4wT18oIyip1Ei0GIzv78+KCDg09Up7YxPk=
Received: from CH5PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:1f4::17)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 09:34:44 +0000
Received: from CH7PEPF00000019.namprd21.prod.outlook.com
 (2603:10b6:610:1f4:cafe::59) by CH5PR04CA0017.outlook.office365.com
 (2603:10b6:610:1f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 09:34:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH7PEPF00000019.mail.protection.outlook.com (10.167.244.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Thu, 26 Nov 2026 09:34:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 03:34:43 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 03:34:43 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 03:34:41 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v5 08/15] drm/amdgpu/userq: add helpers to keep the user
 queues of one engine across a reset
Date: Thu, 26 Nov 2026 17:33:44 +0800
Message-ID: <20261126093417.192538-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126093417.192538-1-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000019:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 4035732c-6de0-4e9c-d980-08df4ba080d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|261026140227099003|261022105027099003|10067099003|261026121527099003|261102123227099003|261028144727099003|261021121427099003|261009223027099003|6133799003|22082099003|18002099003|56012099006|260925021911599003|260925021311599003|260925022911599003|11063799006;
X-Microsoft-Antispam-Message-Info: abIFKnb7Apt4NxY9XK1+zi76IMNOMdJKuvgy03E+rfacdpe/PgJF7YGwWibgclXjEOf6H75EXQdMIJYeCx8mnuu8G879id8DHuE4QBKrU/9EzCdp/ohYQ1agh4pvEw3mju9x5a+AG8MJn/1VJldbeEGv+csdtqnm9GPTZiwi9f+CvQsWz8VZAWmewoSTCDaqyd2olIlOEvhvo+2xSAxnvaSEf265QgMmeYkWcbzWMQXY+ix3ZaolqWKtYWt0Yz38iDtALQZaIvrhH+GotFwcmD7RBneOD/xNNsoIPuRI6Ek4zPrTMUiiH9Pbk3DExJXzB2pfxpeC9AtFCfDB3VRE3HZ5zj9euo4GahdnS5Qq3dvNZixlQoYImOYaEKhcGuczwTpgUSaZkAG4xzL7bjfrkKFcW1NJqX4WUj7dfh/utZLD9nOXNUoMYSz3JqOXKfRZ23YBvSKlol7LtHI98K2JqSyH1M3GlGmHA50iO/8aOVgjsFza2sjxKT9ch39CQN8TMkG+e4RA9wsDT4D76iYbyA/3HBF+IN+vOI0vvm8GZYDWR7uJwJkxeZjVzysdOEruOuFxMx+P4AwDoFYygq/FyZQCadevpUv+1a+bQmV+oa+NVSYxtl/EJKNsyJmZW80NA9OQW0MWunUezZB4VCW9txmegwG1K6limUz4jukgs17NQt8h+UMOLspX7iV1+1ih0xDXNbCx7jFc7KfbZxGMNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(261026140227099003)(261022105027099003)(10067099003)(261026121527099003)(261102123227099003)(261028144727099003)(261021121427099003)(261009223027099003)(6133799003)(22082099003)(18002099003)(56012099006)(260925021911599003)(260925021311599003)(260925022911599003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nd5XkbmJb2Q2f16PC09BDqaAjlbXHlDIGQz3+rMyBpMZLsyh0+lUo5arLWvJEHYCwfsFGhydBBBptqGEtDs2bSlO5fEwpV7pr68G3qG+va2ZPRBfo/u1gLkb8WbQwCIxjIXbWTg6B5UjuIJZ6bHvSuAGefQxkkNUBmNwZx97gwcE6i6u0llPhPypAHF88UAIcgU4iG4vF43arYQWnGfJpLuOOL+77lr27rw9mtpFwkkJob8MtXNGWnGF70q3IWCvbrQDpcGJeGJZSWXD7Gfjqf114Ip0+WQwdpAi/QBLj/aR0wcmjS8eORqfBxt9VwhMjYyn7V2HrMQw3yIHv5G6leqWsocNIV6h2TvLAD2R1vk5FAzRE7Tll86JGj3v6gV0c8L4C74s36Y6tT3ZAsNnnBwWDEBliSvBLcr88Xj8WiOvatutSGyAxjqWCyXWAr3E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:34:43.7511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4035732c-6de0-4e9c-d980-08df4ba080d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF00000019.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329
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

Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 107 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   4 +
 3 files changed, 114 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ec77f24db0e2..0d42ada0bc39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -513,6 +513,9 @@ struct amdgpu_gfx {
 
 	/* reset mask */
 	uint32_t 			gfx_supported_reset;
+	/* HQDs of the gfx user queues, saved by an engine reset */
+	struct amdgpu_gfx_saved_hqd	saved_gfx_hqds[AMDGPU_MAX_GFX_QUEUES];
+	u32				num_saved_gfx_hqds;
 	uint32_t 			compute_supported_reset;
 
 	/* gfx off */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ed6f3b67e872..495198ba1b0b 100644
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

