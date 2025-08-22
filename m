Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026AFCA0EEB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 08:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2CE210EA9C;
	Fri, 22 Aug 2025 08:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eFWtcOmQ";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B20610EAC0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 08:55:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdqeJjn8wojV1Seqthirm/MUVua5m5WyDwPW6VcxtoCA13vgInMXFWaFRk320G0WWU1rc10famuvHqHk6Zjl2MDqcqHNabxL9kal5ayygA0MoMNsjXf60wSxbbU2NRrpvFTLIz5XOL/8B0s44mYjS3QmVl2ruBpWNpNvChWI5EZnBU+6Gxn0ZumLOYoIqRjdPsnNwd2EnOILSfPBhJ1IaLSZtl/XG+7Mxf18JDj0GE0HRWs4Zlrym0y694FtHQy3aubWKQZcuB4x/oWPhViSiE0MJbj5Y0GWNNQoF/mqLj0xYzCfELpnkDD2Frm3ZEPcBYjuRuoBeMTjKRbqkZBivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/0r1It3pNJketkQgWMjmPFkcNP6PKxl6I++NRwLBWo=;
 b=lZJLyj+E+9ZVb1ltYzTmoI5qgFAgps6OfDuvhAtJ05ahfk4/EvZ3jAcyw+VDsdk/HOwG9xoyttmimrXbtRxCUXm46LrYaopR9e5Etrh3ijXKrjX4trSwhLfhAsmyiEBIDJ5z56lendQt+Ymap9v2WbOrltfD8Z23cRL0hE4769IC6XOXAIwj8qi7lPnpmxfUPJWolxXomqm+rLYwcHPbRP2TgizR3oSrE405wcW7odnbAWy2Qq/WoOROk4d7d9PUyAS5aHhkvOon0u4WFWAogXS9fgcDU7sw5tXXdtdXkqlGT6XukpQmltEt8w9fOwU//30VCZH76rtMntjjhNylnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/0r1It3pNJketkQgWMjmPFkcNP6PKxl6I++NRwLBWo=;
 b=eFWtcOmQ6tuQl3fIH/T6ji6EzTQWW+ECI5UNO6jamX68Kf1ockP/Wuaaay8xn4NDjDhU293uTrlBsWOwRU71NKXxpTTHjwi9lbZljxLWxZxi5dyThdLHVHbJVtcS/MPaWrTW9C0tovP17SZqHNp1DlA9prec/ncnHeEUQSoJJ1g=
Received: from CH2PR05CA0011.namprd05.prod.outlook.com (2603:10b6:610::24) by
 LV9PR12MB9784.namprd12.prod.outlook.com (2603:10b6:408:2ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 08:55:44 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::fd) by CH2PR05CA0011.outlook.office365.com
 (2603:10b6:610::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.9 via Frontend Transport; Fri,
 22 Aug 2025 08:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 08:55:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 03:55:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 03:55:42 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 03:55:36 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v10 10/11] drm/amdgpu: Switch user queues to use preempt/restore for
 eviction
Date: Fri, 22 Aug 2025 16:51:13 +0800
Message-ID: <20250822085434.970798-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250822085434.970798-1-Jesse.Zhang@amd.com>
References: <20250822085434.970798-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|LV9PR12MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: dc64b037-7489-4e41-3ca9-08dde159ad52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k80roWJl9AXU2924XL+1vyQfficnIkBKjovD7xNEHJFFdZOJiYdZapRNTkEz?=
 =?us-ascii?Q?V06dN7rBQbE+AoJBnEhuo29QjLu4ZBFnw85FFRnS/kONRw0QhsgbtW/N+Ltr?=
 =?us-ascii?Q?TLQo5psvCkSiO8duphAFNMgjwDzWDXcL1ZBBze7WuvQTQUCf2s/aJ0iTW4uv?=
 =?us-ascii?Q?xXHi9aBHEf8qOfNZA1EAtVOr9CUgJAMcwoInbLUqJltipZJTe2/JcVPaeMhg?=
 =?us-ascii?Q?rWu5pe0ml/BOiAPVa73NoSkbrtqaVa6grVjRjjXSnQkhDJtVcfcKHfFLKNr/?=
 =?us-ascii?Q?IrGX2V4GRuRAYvsTyO2sZEGLEiO8b5jYrfGW2fKK1OcFkD3O0Z4XAHsC7kGJ?=
 =?us-ascii?Q?/9ZpTSQaarZlBCAwje1YyOyOO0wrhmW74QhdRkiEBu3YI+pTnj0PhDLDZcOE?=
 =?us-ascii?Q?75nmLA8vVukf5L+FBrZtxqHQFAxHE2yO3NGIG53JVTIhVMPVf+pA6VLTTKQJ?=
 =?us-ascii?Q?QyB6ze+3cbOwNawLgLw4iwENZktqSAy5ZosTITSzbQRAIEBlMWEOE48wPR7j?=
 =?us-ascii?Q?sEw02ZsLQy0OYHING1RM23fokm7zfNSNh4DB8D+IbLbaKndvDa6m5nRRUAAw?=
 =?us-ascii?Q?K2XPCLa8ZtDkaYolFlzyVuehJeUXkJiIU5Q5RATQB7e63RrW1fZKcGxUI/9z?=
 =?us-ascii?Q?QhbkH6CNt5ljk7J4o09Y8BuSG3ODtZ0UVj4zMKguPKXa79Wj58YRacaQsAhz?=
 =?us-ascii?Q?judskbPDcZ+KxAYRKQaAZnct+sgOYpAvIF3vN/8VREwSFV8eERqTbyu3T3lX?=
 =?us-ascii?Q?fOJQnr9BJfI8YSiMUuUOPDJcOMyW3sivnVDxLIThTCXch0D6qGtFYMvN2WFi?=
 =?us-ascii?Q?a1I5t6iXRVDYvOJ1dfGK+ZSWBUiXdIJhji/ffd4sNFp1SHniWia9JfGodZ25?=
 =?us-ascii?Q?BtuRZX4QDqvysSAYqtjSuzvq+67fhFHedM83JdKmYK4A32QlZpuUTSw59EMC?=
 =?us-ascii?Q?6cr3tNKO/+6lxVssNI85VZWPmqXZcvEx7dT+qoqacq2JNYovh06I52jfQ+1n?=
 =?us-ascii?Q?//VeN+HawKmGe1TPSE7tIa671nAdGMnMhKdptY20y/OwSZ6atFOmTkCBiLN1?=
 =?us-ascii?Q?TOU2GetKele0E2NT76MnKEFWtRni7nIEEt7iTsuFAfm6k48FeRLQLOE4xgMP?=
 =?us-ascii?Q?u0+iYmVjquvhayzUwNP2Z2gbDCOACDoawEJjR2U77MdXodItGa4tn7uqUjc4?=
 =?us-ascii?Q?EATIqAkpLecuKoEKiiv7De74HkN40AJqbhMk1EyiGVU+pzOJbS5vhAmtwgRk?=
 =?us-ascii?Q?XPkR9Bs9DlG5yYyGxa/cy1WiSozAf/FN/L14HrfjRnqcxxjuwG3oKkL7B5/W?=
 =?us-ascii?Q?9gs0RtovwwzXadgQABBhXTLGgsaHR0MXjgO2/Jiz3Fm8MwlvhKsrtBy3DT/k?=
 =?us-ascii?Q?v/FURwycecdTtsxqgATiMKxSLGC54/ESMxEKVq/s4UZ5MeSqTkhwLMMV2h7R?=
 =?us-ascii?Q?kD60BdYFDszlnbXMUcoDbNCZIO1BhZKEYarDhlDInULQs5gRIQtrUYcDepOe?=
 =?us-ascii?Q?msceXk+LAcymroVxJZivRuI6zWlg3sI8c/px?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 08:55:43.2105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc64b037-7489-4e41-3ca9-08dde159ad52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9784
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

From: Jesse Zhang <Jesse.Zhang@amd.com>

This patch modifies the user queue management to use preempt/restore
operations instead of full map/unmap for queue eviction scenarios where
applicable. The changes include:

1. Introduces new helper functions:
   - amdgpu_userqueue_preempt_helper()
   - amdgpu_userqueue_restore_helper()

2. Updates queue state management to track PREEMPTED state

3. Modifies eviction handling to use preempt instead of unmap:
   - amdgpu_userq_evict_all() now uses preempt_helper
   - amdgpu_userq_restore_all() now uses restore_helper

The preempt/restore approach provides better performance during queue
eviction by avoiding the overhead of full queue teardown and setup.
Full map/unmap operations are still used for initial setup/teardown
and system suspend scenarios.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 49 +++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index aac0de86f3e8..decedf8057ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -45,7 +45,7 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 }
 
 static int
-amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
@@ -54,6 +54,49 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		r = userq_funcs->preempt(uq_mgr, queue);
+		if (r) {
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_userqueue_restore_helper(struct amdgpu_userq_mgr *uq_mgr,
+			struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
+		r = userq_funcs->restore(uq_mgr, queue);
+		if (r) {
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_MAPPED;
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+			  struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
+		(queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		r = userq_funcs->unmap(uq_mgr, queue);
 		if (r)
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
@@ -536,7 +579,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_map_helper(uq_mgr, queue);
+		r = amdgpu_userqueue_restore_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
@@ -693,7 +736,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+		r = amdgpu_userqueue_preempt_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
-- 
2.49.0

