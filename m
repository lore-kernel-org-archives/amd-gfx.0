Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1F2C88E50
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 08:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30A0310F573;
	Fri, 11 Sep 2026 08:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WftgF4jg";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE8E510F572
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 08:23:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9VlrWoQXwO1DepXyiIegZLJPDOTG4BBKWahDew/hK61A1oh8vgFTnJUjdwssd1ghwMnxz2WuWF1v/o/Ouz82VXjxCZ0YzzwCaWm7GfB05K7/QrCNCNR5BAZPMiq1wo814h8s0JFkR3evtfOIycLPObm2n6KAITmLuzEUG3UJqnkxyvHbjozXB77pt8iEWSiaIkAkJvTi/2LxrUbEgtYxFMCEZXVkldiBGi8RSZq3rjxlMc21Vxn6GtL2D9nHUByQqARXVNfO7tTGU6A+LkvFhuhTRYyiZiGaE5eZ4RxtOlNt02guAvPt8NmFfdEemWymQVGzhleZeOrwvQNKflQjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NN5CrO9dCpHoGKfxDqeeGXi5w3QZVQH8k78G0wGGW0M=;
 b=g/LwEMGYQvhqSSGllLcSJyYWXolnvORbmzVreWWYtEPxBoW0j1KxTGnIaIR1R0IN9rQkFvFhHkxaZ3RillrgUV2C7jp8YRCDawPepEQw8YKkL9LKeb9IqWLrKmE/BpJa9OcBnPss56xK125NHuP6MmyCb5sMZIwHv0A8Em55Eqwf4vcZJMzuxd3JOZlKvKgKZB3o64Th8Y+jxCQIBQSY3a0SzzloYQDlztYcflrTnqdhL7X0brzsRynQ4K8Ib+yVxpsXwhVA92umDsgueSfiBhKwRCWRmbkvDldh6kIngJBZVgwyYvHBUPQggu5Ce3DvKwVizrUSUJpGYGQLjin8ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NN5CrO9dCpHoGKfxDqeeGXi5w3QZVQH8k78G0wGGW0M=;
 b=WftgF4jggiDN3erCkxQf19NUhZTh7gdqqnpTjhQrIMr4tLpCIBZOKvqxipbJKVjICEq9vDxpwqyidwfKzpEYJJ9O9FdROIgajTIrZpbYhlYRTDEqhV8Um/41JEW+Y8IA4xfbCOxxW9LD42NzZwz8NYjTXsXKdSMOlqwCAPlfuqQ=
Received: from SJ0PR03CA0285.namprd03.prod.outlook.com (2603:10b6:a03:39e::20)
 by DS5PPF884E1ABEC.namprd12.prod.outlook.com (2603:10b6:f:fc00::658)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 08:22:57 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::2d) by SJ0PR03CA0285.outlook.office365.com
 (2603:10b6:a03:39e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:22:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 08:22:56 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 03:22:49 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: mark queue and process as guilty on resetting
 userq fault
Date: Fri, 11 Sep 2026 16:22:33 +0800
Message-ID: <20260911082233.694414-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911082233.694414-1-Prike.Liang@amd.com>
References: <20260911082233.694414-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|DS5PPF884E1ABEC:EE_
X-MS-Office365-Filtering-Correlation-Id: afb93bde-59fc-4333-104d-08df0fdde22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /X4NX0qxMwyaOgukVmR5RRXK8QCGai5C9nchantkYAzsFyVJ6vRTgReJCcvarMN5TMzaXHTLeAv1khIEj/zdkJBP/TVk19VkgbgYlPu4fsCw0D78jOqaod/uP6IPhQMelp5icjz8n0AID6V33/4l/UxfBosaN3caNoifKsLbDt91BIgSCHb+IpCxZ4w8EYN/vbwqT/7tSfN/vQAoboCBeiim8BbzMnZZnE+N6kNC/FB8te33w5dwkdhrlLHDZfNrzyB3JL1IbuDRuASHN2ajkArdkHURNSp11wh5rZbm4ucQgJ70Z/+GKR9f/MQIAJzmAUJ57Ntx+crzqe65r2kKn0So0PxhD5HP68JsJ8d+ZVbjLstNG+jlPceGnheTuHBzYSy3VY7ydZdOfe+9IoL4iTw2rfnKJZh7z7iGNVCRNXeQ9vgDABqg+WVNLmM9EokH1o2iBBWd6I+G9pbN1m9tUtPXZhELWsQx5F7CsPyX90xCNrWYSbG91CNqiwzKavAZF/VJgKxx9vqyxIkpejATt9H7hKnDT0o5b+QAUu2WpINoyNJmHoIx5+B/MmzEHy6b9vBVLP7b52MEg7Sz5mjrFwHaflGGLpyOxDz8j2NFotaP8jTBMJ9V6JT7bt6PDNfkXhfrh4WdqNGoaRNdj8xbgIxiOtzTKLPQh2bNRzj+NYWK9fIu+NPRyGserhZtnBezraioh76agDO3r10Svj66oQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zYZmPrV0Xx9nNnkTwEVowipQAGPEgKk9NMdmb28cgBIXbcorHUVek40SRDyzzhFeZgAwy3VIAtP92MD+a0M4JhIEQ14NKl7chshwJ3fnGubwZrKUdUYpRN1UTejltokJuazNi2yAwZHn76/7jyzFNTpKDT/V9cv2EouYZ5AO/ej86uD+y5TtwUiovGT+/NmRZuJ+hZHzZ+dRNrl6/0zIZiDKO9s5EgL1Nf/22e59Dw7HMEobBSDAPntwbkBlWWyxZ6FKkIo+a50NjQuIyBJT7kH3jIoZSYiprSs1ckPsZOSperAl4ZEt8Q5sLl2Ow/jhaCmseSPym5yB8j0Ekw2pLtpj2e62PruzoRfkjNty3EdZ7Y9luYd/qa7+405XoV8OTu7O2nEv0BCtIYN7V2dQY/bzoDxvq9RIFSPh/DClgNEPdpAq2543u/3Mr3TUnREX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:22:56.5302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afb93bde-59fc-4333-104d-08df0fdde22b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF884E1ABEC
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

When a queue encounters a reset error and fallback to device reset,
mark both the queue and its owning process as guilty so that userspace
is notified that the offending queue is no longer usable and should
recreate the context before resubmitting work.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 24 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  5 ++++-
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index b15ed4a534f1..038d18faf344 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -589,7 +589,9 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 	if (ctx->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_VRAMLOST;
 
-	if (amdgpu_ctx_guilty(ctx))
+	if (amdgpu_ctx_guilty(ctx) ||
+	   ((out->state.flags & AMDGPU_CTX_QUERY2_FLAGS_RESET) &&
+	   fpriv->userq_mgr.guilty))
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_GUILTY;
 
 	if (amdgpu_in_reset(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 6c92575213c1..7098d550c0ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -173,8 +173,12 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	 * Don't schedule the work here! Scheduling or queue work from one reset
 	 * handler to another is illegal if you don't take extra precautions!
 	 */
-	if (gpu_reset)
+	if (gpu_reset) {
+		/* Block re-map until userspace recreates the queue. */
+		queue->guilty = true;
+		queue->userq_mgr->guilty = true;
 		amdgpu_userq_mgr_reset_work(&queue->userq_mgr->reset_work);
+	}
 }
 
 /*
@@ -389,8 +393,17 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 	int r;
 
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
-		trace_amdgpu_userq_state_start(queue);
 
+		if (queue->guilty) {
+			/*
+			 * A queue that was reset for hanging must not be
+			 * re-mapped: replaying its command stream faults
+			 * again. Leave it unmapped for userspace to recreate.
+			 */
+			return 0;
+		}
+
+		trace_amdgpu_userq_state_start(queue);
 		r = userq_funcs->map(queue);
 		if (r) {
 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
@@ -833,7 +846,8 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 	args->out_qs.flags = 0;
 	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
-	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
+	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm) ||
+	   fpriv->userq_mgr.guilty)
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
 	if (queue->state == AMDGPU_USERQ_STATE_INVALID_VA)
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
@@ -1594,6 +1608,10 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 	int ret = 0, r;
 
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		 /* Guilty queues are not restored; userspace recreates them. */
+		if (queue->guilty)
+			continue;
+
 		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
 			trace_amdgpu_userq_state_start(queue);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 40228c60a1ea..f2eca744a3c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -51,6 +51,8 @@ struct amdgpu_userq_obj {
 struct amdgpu_usermode_queue {
 	int			queue_type;
 	enum amdgpu_userq_state state;
+	/* Reset due to a hang; must not be re-mapped, userspace recreates. */
+	bool			guilty;
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
 	u32			doorbell_offset;
@@ -132,7 +134,8 @@ struct amdgpu_userq_mgr {
 	struct drm_file			*file;
 	struct mutex			proc_ctx_lock;
 	struct amdgpu_userq_obj		proc_ctx_obj;
-
+	/* Set when any queue owned by this process is reset guilty */
+	bool                            guilty;
 	bool				proc_ctx_allocated;
 	uint32_t			proc_ctx_array_index;
 	/**
-- 
2.34.1

