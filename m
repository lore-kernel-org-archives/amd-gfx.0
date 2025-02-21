Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47699C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 14:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA9BB10EA7C;
	Fri, 21 Feb 2025 14:50:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vscGdIt/";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBFA410EA7C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 14:50:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAt+JpJwt2+3+STm12TwSLTxRr7u/jMM/QxEVRM6POS2N+EsAPCBUO9+iMjM83llXWx8+3QBRU4bk01b73F9LHSGA2XhUzCv13POuUkRnfjGCG5r4fMkRjHToR+O2+T4hXXDr9At2uIitJgCZbeeltsfmHcJQUrfkiv61wZSDs+k6b91X9o+rDikJtd/bU79HN5hT/qWezyMOsh9pzuRhtuRvwXmFAq1ssMU6lcSmlNbVILYdKcpcLR4HK9Lx6Ur0VN309+x0ReQF1psURIp6zrZlcimwSBQS9SX6KmfMidY+F4v3D1y7v4XfPGnkbnihHidSxjYUEWW16At7G3YCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXLWp7dCjFqD40BqDKkEa8an5AUqeg2tevDxBrFzObg=;
 b=DcDxTjdosJdeJH/iOmCkwfKEGA02RIrD+QmK6wNgc0zPaLpxTC9X6LwmKScUam6/5sPRXr8YO381iyT6FW9SqOI3razlg7B4phzcZkTW5bzc6vWFmY+Ptw3tV0Gz2m0fjVWDfIJb4U2ythyNa4+dex3oXf9RejLwG3jLWNtCAF5FiDeaqxmhWOGrqx0NxuUNfQuBUt/BrtykRYt8bH8FHw4jhbrSK7aIMxL2I6qTZnWDgpJlX4lcOxmTyt6iDv7nXTwM0pp9wwBAg3OW4vr3QofmFPhZ+gHcmQX6qYSLAXN86vxH32YvvBZW1XffWH0f8PKCltHHCE3cTHnQgdO31w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXLWp7dCjFqD40BqDKkEa8an5AUqeg2tevDxBrFzObg=;
 b=vscGdIt/Am5RVNgof70rI38/ECMJiIQWXSBKdYl5rZBgKiGnOUqpFP61865YWtxPbZS8MH05AYDYeNlir9WjnTloeYxhFrGSdHzfWNZpcOK6IFceep0EgJw8HHsPTtrXavXR7rBr0u20j0X0Pq3doejHMcDaOSWbeZt9IgR5Xfs=
Received: from BN9PR03CA0041.namprd03.prod.outlook.com (2603:10b6:408:fb::16)
 by CH1PPF2EB7CF87B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 14:50:47 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::fe) by BN9PR03CA0041.outlook.office365.com
 (2603:10b6:408:fb::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 14:50:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 14:50:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 08:50:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/userq: handle runtime pm
Date: Fri, 21 Feb 2025 09:50:31 -0500
Message-ID: <20250221145032.3440904-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|CH1PPF2EB7CF87B:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8c7fb2-8654-440e-b625-08dd52871ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xO67HitdnmmM1wwhm2nDUunlvW9LFd4ePoyXdzcyESrRgvdYwaYryStkN2XP?=
 =?us-ascii?Q?cUSeVj96ifx9Zj7KS3XYNGGKqZfgECsYJcsiF7lSvNoJ48bVeMQR5eGO4Uay?=
 =?us-ascii?Q?JNROW0KmQ62SfNksRlpYrD881aPnflx2bMh9/h43giAYMlI55OEzdOJ+aCj0?=
 =?us-ascii?Q?2HNIJaAoXtMGp+olYhzAHpGXJfrWldMPWWV98Ju3kORX/IL92lyxuyFBitEl?=
 =?us-ascii?Q?bLsBFOZbGHQxvT4FX2Sme5uEN7d8ivhAv6nk3CshQkWPZjWiAZ+J8D3MiRlp?=
 =?us-ascii?Q?7cXqEHuqEuwYlfetx55UiD6TEXkyDf43DhpdJsH6oxKfw3k5j0w+ZnmpGfn+?=
 =?us-ascii?Q?FM2iz+agG+PgRRK72EqXLezXpGogynYhxJ8KzOLkO/FRTAGHU4ptfXqo/7s9?=
 =?us-ascii?Q?XuYP3CnVS/HvX3PfrqbNtJzmoqSr7te4tQq2ofGVejbgO7K5TtauTeEeFwtj?=
 =?us-ascii?Q?jRP+DXRrHSH97D5AxcIusu3wxJAdF8dNK81sWwZMMBpcnvfYFrOAGOphQaYs?=
 =?us-ascii?Q?cFB3efGZOarOSO/lJML6kQgbIDuFTroJLCBuaDYIT8lP9bUsW4JDpbpVVBnI?=
 =?us-ascii?Q?xtVNKihdEgDfJVpxLPhZakO1wB7OSbtMKOHQJXA/2bPWL2d5/KLc4TGnNBDH?=
 =?us-ascii?Q?bhiYe/ZdL8oaRu8iyxoAqx+AvMGeY2pOT5F8eZnHxH/TRygcXO4E7kFOmNF0?=
 =?us-ascii?Q?0NMbY329cIcIXREOrslTC1fYKR3zSGoraYgO7Jxh0TjapWKmLSbh9R1MafeU?=
 =?us-ascii?Q?hdKzGwN27XQJ+0+FoAtpTLc5GBCsQnmBAeOzKFRJp+j1j/NVzyQky0uc+DSd?=
 =?us-ascii?Q?i2u1B3zY2J61K88hxd8n1G03W/ImapgtAFuB2ltFtJsotkZhBOeBeg12B5SY?=
 =?us-ascii?Q?fNq54mo3MwYBiY/Amb3HRCgf1KqT9afhCqOGY6NeDxMVk+3/get07NJP/FPA?=
 =?us-ascii?Q?WFjSjUA3xQzCIPnk7s0RrrhRCSJJVXAuj5Z8O02oGUDYLQi90p4vsup8gJOO?=
 =?us-ascii?Q?ufdtQOW6vyw0nMjt7UzmlKykOz5XjRqJJFT7y1l291S0lZaDLZKkoc0Jkuuc?=
 =?us-ascii?Q?nTmBJPYGdTnYt7X10xcRJXGe3TTmZvqQwtzOMXimJSmCsJ9747KAHOQvNhqR?=
 =?us-ascii?Q?V7r5U68yMecFLkGx3PAeZH9C6pwIj9Ad3Ug6kIPh/5eWTJtRIaOH7FuH6Fkt?=
 =?us-ascii?Q?SPdAD61VNeG3Q2oVPolfPttZdH5Qltqo6l5PLJfDaM0WBDoMr1cVgXWfpXK9?=
 =?us-ascii?Q?p0ymhgoe3yIDEoD3S7fE6M0YEz5vZFMd1jOlkmQJ9Apc7cuYvQrKp3e+ktT8?=
 =?us-ascii?Q?DMSZuTBwJtRLPAgmaeVp2NYF9Ni3XGKhIlyIkeB2kOukHxBzZnYhQ2nDAHlL?=
 =?us-ascii?Q?cgG6lLAyAcpAjxOtJto0JKjyn99OugAX5xtUFhnjFO39H9A0XrppGJCBXK00?=
 =?us-ascii?Q?kpOop9FMNsvWNgpFN6thB37isc7oHahcOPcQE+XEzyOh1fnulcfrleBdf0Tc?=
 =?us-ascii?Q?f2ocAsTsYllBTiM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:50:46.5941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8c7fb2-8654-440e-b625-08dd52871ff0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2EB7CF87B
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

