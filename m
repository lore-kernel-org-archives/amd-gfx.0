Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74983CA9EBD
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 02:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C17010E216;
	Sat, 10 Oct 2026 02:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aEfEQFiy";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013005.outbound.protection.outlook.com
 [40.93.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D52910E216
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2026 02:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9emqU6RjOO27OLLFcbk/k1WIocUGEAuKoVk8sLA92olx5nlxlXPpsKvyQTTDvo1FxhRXAmgL7rDrMYAznXemFRwz0kmvLiSItioK3HOPF/Gc+3JjgHSCx5OwyGQnowYNRT/Se94culKbCQcEvFyAmDOL6V+8QbjDNjsrT1eaVPqHUgGTYj7pXfGdHo//nFELnDdi/5lCJcUdwN9TZ0Zf+OZcjQe+qmx/W5XjmNAr7iPnu3KFe/mzTbpQdi8lQj/SaZyvCslCZoiXuv/WIPE10kfXB7n9yO5A89pvn5kDbuchJxW2zbtoPukpIff2VA3BXeerppA0qyixYvUJSa1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfadzL1LN9CPmI0CHBXyJCPk7T9biBOdFBrsgU9BSUk=;
 b=XH5DeR95bOGPHDWi9IN8IS7Vp1M7CqYiVNkcr83rvZIvbmb6BYMNFKPDqebEXV6eR/etBYmL038YrU0Hv7laMkO8MT+AfZiZvD4gpwd2cMLcsLqpYoMDVHI+IAYemHvRKKukZ8+5taI3DM3+RjvUSAlHZ5Wqvy+SkHpzQQwQE/3jOvaMANlzWRNLrLz7WR3UqJUX3Cq7kuBKO9XQCwsNJePMvgTrpYYzm39LDFs/khhaV/zaWDVbIO74Fyj86ptL5xrBlDUihcny5pYdeHl6sL7BPlsqiHzSvgFEO5KclDdgIXh36pST0ajtSw1Q+HyIhnSIflNFAkGGAIqeVpZm5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfadzL1LN9CPmI0CHBXyJCPk7T9biBOdFBrsgU9BSUk=;
 b=aEfEQFiyHBKJ1ZxVHoIecbCZ3GhsYp0PkDgCMRM3MuhVhopGxTrms51Ppeneg6XrSH8/6QN/QgrXL3FWSVfUR0zxIGvdsoSCygvdPGQIsFHkfREdsV4I5dg+wLHBI+KTezvNrCrof/NH+sTsIO7QAE8ZUmlcE3R6lP4r34P5lUI=
Received: from BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::8)
 by PH8PR12MB7302.namprd12.prod.outlook.com (2603:10b6:510:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 02:54:14 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::58) by BY1P220CA0018.outlook.office365.com
 (2603:10b6:a03:5c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Sat, 10
 Oct 2026 02:54:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sat, 10 Oct 2026 02:54:10 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 21:54:04 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: skip restoring guilty or VRAM-lost queues
Date: Sat, 10 Oct 2026 10:53:53 +0800
Message-ID: <20261010025353.2453951-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|PH8PR12MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df4e32c-7c5e-442d-9ba0-08df2679c2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|261009223027099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Wi4d36EZo15Lb9Y7gyaOP3ODBrw9XA2QNnbHmi1Esq2KCDBcui4LZN1FECVjt6pw0WMmY6mRkDtG783pqx+PSAm9hgboenoK+Yy1XVpjnF7aI6RAAaQSKTSjefKCGvkbgnkDawHYMsA6ozThWegkKYGF0vG9TsZ2eKToeZv3ytpQGUBTAzEkHlnn6HDsjTU9NIrIkTu/OA3V39+R0Rl6Z9GycFpns3ciOk+VXMTNma23qE54pS4Pms+Ok33mA70MuW/bzYeK8/zQXF4nLUMBDR0FY+h83h5n8W9aHIH1LZL+WVRZ2SGr9wq/c0ZELEP+f7LvEbArqc47ZnzADYCpv2ebeUiX/z30eeM/FsmdG9jUzfVihcTttvJI/yVAWeuBukZRLBJu8YK5TOIYo4LMNKh+Y2USbxOB5msP5vz+r0OWnTR6I5k1vedTZbXcahsa+Ik+DC/tYQJZp1C+a++4oNFPkgHb9iS2qgHU85tuhJ6filNUBEsbNYxhCcfCkyy4j1zf1lBc6x5VeahG+Hoa+9B1A+harqpM5W8NLk+N+unuDq9U1OmYItchppZXpi9EN8aZg1T8lkYjKk7pzWg6cUbmzH3LpVI0BjxuQCAyp7S+5YD91fz3gN3o0+rRpo4zdusiBGqyRfTqMHDosItbyZpF2pb5k/WD+2+BIe0CSAzINjFrNltiXj0tJ+lFYwUJAkIMD1V9O2uX0Atx0uEThw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(261009223027099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7y7Nq7Z0O/B/3OFv5ktdE7kJfOI33QzHfocBPUFfBZd37o2jucAEUz+Yz9UYumY/x9UKRTEtzD4M4wb62U0BLfG5oTN8XvUyRVcRkn5vuvPSnBCMRKepj9SQ8tu7K0piHu90QKgPOkQTs8esaS2hwzmcNlHgjbysNdEEaFE+HlGnIE+aSFEVci44N1w6aaaqMA4+4OlXL10J6a957aaiGCAp1AjhwjKs/wV1bzaLPJXTu6FzCFQ6Tg7I8JoAS1xzDR5Ngh/1dGX4aWZY7iIXfB7axaj71W3qJam03yk7vQEZZm0bEwNRQYnMJcdbmLhp5+pqaFO+TtP+ImfRKB9DerzRYFty932QsrU8NbJcb0gEgAd4Gm43ZRhXVA73oc5ZIFuxq46SlVWAJG5/TVq+SEU6jFeyloxYi+InGUoLMTi0Oo+nFRtHzAno8Ffy045X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 02:54:10.9152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df4e32c-7c5e-442d-9ba0-08df2679c2ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7302
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

A hung user queue must not be replayed after reset because its context
may be corrupted. so Skip guilty queues and queues whose VM generation
has changed when mapping or restoring them.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 19 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 6c4743ddf04a..cc212226fb48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -148,6 +148,8 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 		}
 	}
 
+	WRITE_ONCE(queue->guilty, true);
+
 	if (amdgpu_userq_is_reset_type_supported(adev, queue->queue_type,
 						 AMDGPU_RESET_TYPE_PER_QUEUE)) {
 		int r;
@@ -174,7 +176,7 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	 * handler to another is illegal if you don't take extra precautions!
 	 */
 	if (gpu_reset)
-		amdgpu_userq_mgr_reset_work(&queue->userq_mgr->reset_work);
+		amdgpu_userq_mgr_reset_work(&uq_mgr->reset_work);
 }
 
 /*
@@ -338,6 +340,10 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
 		adev->userq_funcs[queue->queue_type];
 	int r = 0;
 
+	if (READ_ONCE(queue->guilty) ||
+	    queue->generation != amdgpu_vm_generation(adev, queue->vm))
+		return 0;
+
 	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
 		trace_amdgpu_userq_state_start(queue);
 
@@ -388,6 +394,10 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 		adev->userq_funcs[queue->queue_type];
 	int r;
 
+	if (READ_ONCE(queue->guilty) ||
+	    queue->generation != amdgpu_vm_generation(adev, queue->vm))
+		return 0;
+
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
 		trace_amdgpu_userq_state_start(queue);
 
@@ -833,6 +843,7 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 	args->out_qs.flags = 0;
 	if (queue->state == AMDGPU_USERQ_STATE_HUNG ||
 	    queue->state == AMDGPU_USERQ_STATE_INVALID_VA ||
+	    READ_ONCE(queue->guilty) ||
 	    queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN;
 	if (amdgpu_in_reset(adev))
@@ -1598,7 +1609,11 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 	int ret = 0, r;
 
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
-		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
+		if (vram_lost || READ_ONCE(queue->guilty) ||
+		    queue->generation != amdgpu_vm_generation(adev, queue->vm))
+			continue;
+
+		if (queue->state == AMDGPU_USERQ_STATE_HUNG) {
 			trace_amdgpu_userq_state_start(queue);
 
 			userq_funcs = adev->userq_funcs[queue->queue_type];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index d1a2e2a45861..69d6ad4e6b11 100644
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
-- 
2.34.1

