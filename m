Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E692C021BE
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 04:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C172C10EA1B;
	Thu, 27 Feb 2025 04:03:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AulZwL1W";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0389810EA1B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 04:02:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jH/NCLeq/g1rWVLQQtpzfNk6FA895FJzCWyu7t1khW5iJm8WyX/V5mSyo5ud6xRWVe3q1PLMTj9U6+fNvNLGw9OQCPkNQoVCQ685JsDoZneju+urfD5DKqCJpo56YnQEIGQvYbpOHY37Kdq0klwHvtMad8cYI8AFIQUCc6My49mnXKtNor1eRVIdD4BdMLoXzyi3cqSXrjMtEfA8MZb10xrqi4V8oXx4IJrGVdk5yq9dwgev6mUTPoNaRtXBiUcyYnJJBm6UnwU3PCKTiRkb6F5vporO/fDcIukus6iqB5gBjecwGpHKv4kbrCVXq8YfZX0QHfUnkR47EKW99k7nBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXLWp7dCjFqD40BqDKkEa8an5AUqeg2tevDxBrFzObg=;
 b=FG09YR3phM9iDhZVHkIAMa+bQookp2EpxvTs/glFgxYnPa6ZbW3rJeDcQs45cqHhjoGVNI3UR/FkDG6aGAKqQ+19LSqUHXgG/h/5m1W9Fr6jabLv9ogx+tHqDY4s0kDYxBWklh6ukgyHFuVtvlqLe6zn8ioD6TSlM86qHnWSCUZk4r3ezyX+dvoNPAI9IEUxuYahQHS/Fg42yfZRm+hD2p6BX/cMZmQpIGj9X7QC3/6KvelJ84rhnLmMc+/MQrLPOhADV579AeXMZkuR46xWNAEIrbQlm0Ofw7r40TxQ9WqFdmLGP1ky93MAdvDD5Q3cV2QShYCoU2Rsv1ej2sEtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXLWp7dCjFqD40BqDKkEa8an5AUqeg2tevDxBrFzObg=;
 b=AulZwL1Wys3k3idxpDqP1OCKRngAoUuyJeuX3KHFSreYw+t2F9FE41HYv4+y/4qxeSE3fx6dTQGNBUKko3SXgqX632ZWHR/R1GG4E+T5R05mTgVni/BTnC4v7D3m2ZxX8WSai6+thqGN/Tstnjj3mNPbnidbABReOQE/cXzZkVg=
Received: from CH2PR12CA0001.namprd12.prod.outlook.com (2603:10b6:610:57::11)
 by PH7PR12MB7187.namprd12.prod.outlook.com (2603:10b6:510:203::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 04:02:55 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::24) by CH2PR12CA0001.outlook.office365.com
 (2603:10b6:610:57::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.22 via Frontend Transport; Thu,
 27 Feb 2025 04:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 04:02:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 22:02:53 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/userq: handle runtime pm
Date: Wed, 26 Feb 2025 23:02:33 -0500
Message-ID: <20250227040234.235004-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|PH7PR12MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e44be21-cada-44e3-a778-08dd56e39d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Id5X+reuARFsLQxfGH3inUGnolXHaCRzKC6gup/9nQHLR1FkMoIc3HQEwqz2?=
 =?us-ascii?Q?kvFSDWTNawTiGnDK/OFpYkSg4ciizXSo4quyrxV8MBZ9U5R5ZmLNVTeKFybG?=
 =?us-ascii?Q?b6oV8QyDHl+55DPgEaUmqmEW63u30FTnFDlmo2+zFymwXni5O62pAJ5h6wns?=
 =?us-ascii?Q?T6ExGHEc2ZoJgD0GVdJp5OiROddqC3x2/VyebulyAR7yqg/U6qu8y/TTSRSz?=
 =?us-ascii?Q?IdAagSWlHiyu8C5p1lx14xMjXy80cQ4/uD6UH1FUpwVnF1jD6SMkheaKkUf9?=
 =?us-ascii?Q?tno7slXa3fXeH9Es/gSoiH32yIpfrSatYneQCOdtV7L0omxLuCoBY5pX0FSu?=
 =?us-ascii?Q?uay/ytu3pmHCsiUdDn1/XSBWcAAQpuQDFEsg7+CTvSSZaQ+zxgQKmYVVDjlC?=
 =?us-ascii?Q?1l/QTdPVwYJ9mCRNd1omIGSWAlDVvf7m1dcgwGHpOXjf96XYz0K0QtLXmRcc?=
 =?us-ascii?Q?GA5tKhqo4nM2E2K/U6gi9gA50TNLPGBCEkAWy4No+wOeh327TAqS+b/uQ/MD?=
 =?us-ascii?Q?sGZDR9FUZoDLTLJWhxGzFJgACmyfdVgVNHY/mxDy6PWk1ILCSxcStgSWfupq?=
 =?us-ascii?Q?62Mfi8ybuhMQ6jnr4b0IYH9k0HmVBsY+9nqQ7LI6sjmZkXzfYQzBFVcj6wXL?=
 =?us-ascii?Q?WE9F1AjRP4xcx0HK/8fPzouATiHyX866tpmWB3/jKvU+w47lYZJAeMmzIwz3?=
 =?us-ascii?Q?dphiRZoDOoD5ZC9auPPvMpGyspKZ2CUQG/buoiPy7tuwjJQYGlod2RH79tuH?=
 =?us-ascii?Q?dQejhJMNuHRILMX7Sfl4kZHFFuBAkemB5GbRV1g//cB7SjhmuQwmlTzn2XnI?=
 =?us-ascii?Q?0KvdmXYcn0UoXgBG+WeMzuN9XoC/eSQGn9QU0leORaF5EpvschXP5kIcs8K0?=
 =?us-ascii?Q?ZMZYtHm2vvTZJj3DQOm1UPKkg60PkIJV6qXCmWV8Tv1v4CLTC4U8XQvXi+ke?=
 =?us-ascii?Q?diYyVR7pAJZhYO3e4dzGCzCZ+Jv7W6bExWUBAid10a5tH+RmYLjb3W05qahp?=
 =?us-ascii?Q?zLiTW++eGUhfht1bH6mL0rUq8HTXm1DqU1HUiHp5230pYIuPX762q9tE4Q/c?=
 =?us-ascii?Q?hl5Qtu7pF95VF2zYx5ymm0m2N5MgBrCCIy/1v1tcvNOTc6Wt1YVy+aJFDGxB?=
 =?us-ascii?Q?BIqrxYKOJ8Cwi/y9HH6t7FCd648HuMdfnzqO0RukXbn0Fu2tXjJrv06iudO/?=
 =?us-ascii?Q?IwZCAFuoBbRL0xvWUqGm50P7cO0yAi9oHjDqK/aYqWU6gNEZDpovI2TiLo9h?=
 =?us-ascii?Q?tIyDETc1k6sc2fvx+4H+hR8UySL5Dv2+AtfaRZua8GWzXcAPDjBLEwJGMsqH?=
 =?us-ascii?Q?EiFrGP55dVOzRx8RXizfqAIHqZhlC4BC7uuYV99ct52qJoQXc5wyKu8hKvs/?=
 =?us-ascii?Q?XWGfd2fVAb1fkFXoNVtFoGsX/JIBWEZ0fTYlLezf4eXVNvPWMf+cpS6DJ6LU?=
 =?us-ascii?Q?Ynjgrdn/aldSMvldQ8xryBc5CSJyc/17LZOU7X+cvAtpNNc5Ing9HsclvlLH?=
 =?us-ascii?Q?mF2njH/C/0InCKw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:02:54.8220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e44be21-cada-44e3-a778-08dd56e39d10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7187
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

Take a reference when we create a queue and drop it
when we destroy the queue.  We need to keep the device
active while user queues are active.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 9a6a5553bbc3f..3a71d01b54c92 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -26,6 +26,7 @@
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
 #include "v11_structs.h"
+#include <linux/pm_runtime.h>
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
@@ -287,6 +288,10 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 
 	queue->userq_prop = userq_props;
 
+	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
+	if (r)
+		goto free_mqd;
+
 	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
 	if (r) {
 		DRM_ERROR("Failed to initialize MQD for userqueue\n");
@@ -321,6 +326,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 
 free_mqd:
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
+	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 free_props:
 	kfree(userq_props);
@@ -330,14 +337,19 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 
 static void
 mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
-			    struct amdgpu_usermode_queue *queue)
+		      struct amdgpu_usermode_queue *queue)
 {
+	struct amdgpu_device *adev = uq_mgr->adev;
+
 	if (queue->queue_active)
 		mes_userq_unmap(uq_mgr, queue);
 
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
+
+	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 }
 
 static int mes_userq_suspend(struct amdgpu_userq_mgr *uq_mgr,
-- 
2.48.1

