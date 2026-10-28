Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BCD606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YNnmV6JE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0E3810FA83;
	Wed, 28 Oct 2026 08:58:15 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 994F410FA88
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 08:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+WWfUNaZnQRh8M0DrK80QB/fHLsMnlLmz+ZZ8cNMjiybLMUWehapNkHgJg+zSMvOcoNf7552fxLksWd3RJ6tcxEMvu/0wWQZpviVJj67R4feztkULMhL4WwroGpTB5/13795zNMThtSmRld+M1SMdIGzNoT3SIT7gBkWNeFToIA6eioJzbLOTgmPx/1PGXK/PP/GAh2i8XmUyMhcK/7yJfKVvr7LFST604McTaSo3pyNknDvmd5tURhCFCUw87XHiL2JlIB8wV7NQVwt4fnTcVIm/OL0lUrFAqwkTeOTAHwMrPM1UOf12HDn2lvtbAcejCLGJQrh/p7xwX50zVn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CwAaY/BbCGvUiITbWSCm24fBZp0ME+Gy6avkH8cGEo=;
 b=mQytlEZirzgTtFcBvATKMYZsqh7vjPGEF9h3EuqbCnlPVdNiJii72iAkUbYh6IZFuEpQOn1lxeV0TLPDMOsTgjh6NPtHnSXUAYYJfWEvpmBUt2beX4/ZWYIxUA6FkTWQN4uy5jR3KQPZTiZwmphXWVT7E/s1z0IF2PkYC1aoZEgCtMZQpkzmurHm4aY7IG8va4ALbCNpvu/8BIJ6WDQjwlUd3jsNDxGaFWyRx9lAdVo0lGpSvz9XhGiou6VmMR9u+9MQoO30niLhELSSNuNZ6RAANKqo+wfnorrgTY+hVJwfL5Awzt42veeFYwiZxZCJR5k1mpM+mdZ4yTI6S35T1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CwAaY/BbCGvUiITbWSCm24fBZp0ME+Gy6avkH8cGEo=;
 b=YNnmV6JEshyTKjfXdyVhzIpXeeSKU7mDq1Xvavw0IYW7uxMpitRxYj6pdUA7AY8tYlp5qqvcGaL51VXk6rkTvqSGTx9kMp+OZfxV9Qat3nSNfPHhqtOls7p2vNHoZsg+UeGom31I21earpO2t384GKAMImG0zq2bU6pOtivWYVg=
Received: from MW3PR06CA0010.namprd06.prod.outlook.com (2603:10b6:303:2a::15)
 by DS5PR12MB741834.namprd12.prod.outlook.com (2603:10b6:8:47c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 08:58:05 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::99) by MW3PR06CA0010.outlook.office365.com
 (2603:10b6:303:2a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 08:58:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 08:58:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:58:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:58:04 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 03:58:02 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v3 11/15] drm/amdgpu/userq: add helpers to keep the user
 queues of one engine across a reset
Date: Wed, 28 Oct 2026 16:56:42 +0800
Message-ID: <20261028085736.3808569-11-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|DS5PR12MB741834:EE_
X-MS-Office365-Filtering-Correlation-Id: c37f9f19-8409-4077-6305-08df34d1948b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|11063799006|56012099006|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261021121427099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: o0z3rvNzR+XHEYN0Hp2levoE6sivmXBFj9V47chbTlxKOn8+jZAaem2sER5z6Y8o6ArhuxjfL8cCifvbYIvC2HFCkUBmIcNadZNLeEjwJievbYXhnEKdZjrn7J8IgBpHdVJm8vtc4+yRg/UduGw0XspOKP1bhsmDyeXi3r48+1vI8kMEDQXlG23fHt1DiR4YJrrkrEevALrQil0NAUxLS7ClbT1N649nVxjYteGI0bX0jNC1EwmPlG90eKPtbZesU3RS1EJY0Ml6buJz+5+wFCZt/JGwWqb4OTC1OjY3elc/PTX7D9XorJ8SXM4TeIQihW2ZlnxgCSE+FYv3IHEwwykNnJSaJpaATrRzAKJJg7V3HVXdJewUHlgnBN5jnAeX/8r4HkUa1SSm+kGtQTbDZ6XiUWGbujKKMgcbCIUVMG39MEKqDOArPoNrzPeQgph6s77V70YU7LW29fIsoEKc43Omjj1GhjbpXm02GlivsTUTqT2wqSlNc/eIhw5UgFSesrhRjPMfiF1rkRfgD8cZjD7UlL06HiwnLKhKrrO/wALL9EriR2uVXOwCyqhNntD2AOaGs4MamIvFFYrr5Goy61MqDKdoyKqqwP9mdbJryMAADydXLHEbUNa0dD0yIiM9NVuGms9MODaMcTxSRM8vnp9u1DzZLZLQ2rOc9wuLjbMI+6N4bRR4HzwwGIamdSVkLLKOyFwTEV+OCPLU/D7o4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0UR5fj4HPdtUDyfEyEr8fCbZCBBmZNWuMK7FZy1pLd7v8+dBrA74C1fBbkthGWogJB1zVjl1XLe8gTKWO3W/sQs7wlsiwMZtQt93SHTzOCjS9eb7mzssixZA2yp4WKRmcCrJEztbG4MsO7WXP2aWFY/cpSbZSPN5cff1U3S+XdqKN9OhejXYzNrY62JAiKRMtXWWyC3T1NtCBBBQ3l5tzGnyJBc4K/hVsuHiIeinXGX4nrbV60lIv6wbzBV2c8Hs8uhhks/sRrgZm/ZYvrs0qWr+E8VwqZIFIRPgqHl0j63wwUml+ckE5VePASVjehrLJhNbmlM3T7r44rL4Xpoyra3Q0nXDIxQxboaIkYaXsifewl7MATtPnhWx2D0u1jNh/MopvK6Rh0Bqp1N3HdE8F9hRMPlwD/Wq+zRP+KTuC9XsbCJQv/RF7DFWJOPOr/gp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:58:05.4237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c37f9f19-8409-4077-6305-08df34d1948b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR12MB741834
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

- amdgpu_userq_pre_engine_reset(), called after the MES suspend, saves
  the ring state of the mapped queues still on a HQD: the reset clears
  their HQD, and MES couldn't preempt them into their MQD. The queues
  MES preempted have their state in their MQD already.
- amdgpu_userq_post_engine_reset(), called after the reset but before
  MES resumes, unmaps those queues, puts the saved ring state in their
  MQD and maps them again: MES doesn't map a queue whose HQD the reset
  cleared again on its own. The queues keep their state and their work,
  except the one the pipe executed: its work in flight depends on pipe
  state the reset cleared, it is dropped and its fences signaled. The
  queue that hung, if any, is unmapped and hung.
- amdgpu_userq_cancel_engine_reset() drops the saved ring state for the
  full reset that follows a failed engine reset.

The helpers walk the queues and unmap and map them as
amdgpu_userq_pre_reset() and amdgpu_userq_post_reset() do. The saved
ring state is kept in the gfx IP, per HQD, and matched to a queue by its
doorbell and MQD address.

v2: Drop the user queue reset lock and the walk over the queues of one
    type (Christian).

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 108 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   5 +
 3 files changed, 116 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f750b11f4ad4..6bbf53359a49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -518,6 +518,9 @@ struct amdgpu_gfx {
 
 	/* reset mask */
 	uint32_t 			gfx_supported_reset;
+	/* ring state of the gfx user queues on a HQD, saved by an engine reset */
+	struct amdgpu_gfx_hqd_ptrs	engine_reset_hqds[AMDGPU_MAX_GFX_QUEUES];
+	u32				num_engine_reset_hqds;
 	uint32_t 			compute_supported_reset;
 
 	/* gfx off */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1a2aa85c504e..353c5f7cfcdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1597,3 +1597,111 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 
 	return ret;
 }
+
+/**
+ * amdgpu_userq_pre_engine_reset - save the ring state of the user queues
+ * @adev: amdgpu device
+ * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset engine
+ */
+void amdgpu_userq_pre_engine_reset(struct amdgpu_device *adev, u32 queue_type)
+{
+	struct amdgpu_gfx_hqd_ptrs ptrs;
+	struct amdgpu_usermode_queue *queue;
+	unsigned long queue_id;
+
+	adev->gfx.num_engine_reset_hqds = 0;
+	if (!adev->gfx.funcs->read_gfx_hqd_ptrs)
+		return;
+
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		if (adev->gfx.num_engine_reset_hqds >= AMDGPU_MAX_GFX_QUEUES)
+			break;
+		if (queue->queue_type != queue_type ||
+		    queue->state != AMDGPU_USERQ_STATE_MAPPED)
+			continue;
+		if (adev->gfx.funcs->read_gfx_hqd_ptrs(adev, queue->doorbell_index,
+						       &ptrs) && ptrs.on_hqd)
+			adev->gfx.engine_reset_hqds[adev->gfx.num_engine_reset_hqds++] = ptrs;
+	}
+}
+
+static struct amdgpu_gfx_hqd_ptrs *
+amdgpu_userq_engine_reset_hqd(struct amdgpu_device *adev,
+			      struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_gfx_hqd_ptrs *ptrs;
+	u32 i;
+
+	for (i = 0; i < adev->gfx.num_engine_reset_hqds; i++) {
+		ptrs = &adev->gfx.engine_reset_hqds[i];
+		/* Check the MQD too: a new queue may reuse the doorbell. */
+		if (ptrs->doorbell_index == queue->doorbell_index &&
+		    ptrs->mqd_addr == queue->mqd.gpu_addr)
+			return ptrs;
+	}
+	return NULL;
+}
+
+/**
+ * amdgpu_userq_post_engine_reset - restore the user queues after an engine reset
+ * @adev: amdgpu device
+ * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset engine
+ * @guilty: the queue that hung, or NULL
+ *
+ * MES doesn't map a queue whose HQD the reset cleared again on its own: unmap
+ * it from MES, restore its MQD, and map it again.
+ */
+void amdgpu_userq_post_engine_reset(struct amdgpu_device *adev, u32 queue_type,
+				    struct amdgpu_usermode_queue *guilty)
+{
+	const struct amdgpu_userq_funcs *userq_funcs = adev->userq_funcs[queue_type];
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_gfx_hqd_ptrs *ptrs;
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
+		ptrs = amdgpu_userq_engine_reset_hqd(adev, queue);
+		if (!ptrs)
+			continue;
+
+		userq_funcs->unmap(queue);
+		if (adev->gfx.funcs->restore_gfx_mqd_ring(adev, queue->mqd.cpu_ptr,
+							  queue->userq_prop->queue_size,
+							  ptrs))
+			amdgpu_userq_fence_driver_force_completion_with_seqno(queue,
+									      ptrs->wptr);
+		r = userq_funcs->map(queue);
+		if (r) {
+			dev_err(adev->dev, "Failed to remap user queue %llu: %d\n",
+				queue->doorbell_index, r);
+			amdgpu_userq_fence_driver_force_completion(queue);
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		}
+	}
+	adev->gfx.num_engine_reset_hqds = 0;
+}
+
+/**
+ * amdgpu_userq_cancel_engine_reset - give up an engine reset
+ * @adev: amdgpu device
+ * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset engine
+ */
+void amdgpu_userq_cancel_engine_reset(struct amdgpu_device *adev,
+				      u32 queue_type)
+{
+	adev->gfx.num_engine_reset_hqds = 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 488dc21d7c81..e07c71cd5af5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -181,6 +181,11 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 void amdgpu_userq_reset_work(struct work_struct *work);
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
+void amdgpu_userq_pre_engine_reset(struct amdgpu_device *adev, u32 queue_type);
+void amdgpu_userq_post_engine_reset(struct amdgpu_device *adev, u32 queue_type,
+				    struct amdgpu_usermode_queue *guilty);
+void amdgpu_userq_cancel_engine_reset(struct amdgpu_device *adev,
+				      u32 queue_type);
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
 void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
 
-- 
2.50.1

