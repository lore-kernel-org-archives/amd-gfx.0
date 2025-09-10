Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D14CCA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 08:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2203810E2C5;
	Wed, 10 Sep 2025 08:16:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xiTfRuOg";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00BDD10E2C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 08:16:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpPVSZuMvhFegtGOT502JSKC+6osF4pE5t2UOoF3AvTvo3+MqeaVX8AZ0dVIJmzai0RUha4Yxb+7RIuF4fRZ814yDJGdTU+DTvieDPhNZVn8QeAnKjGx20qLjA3/Uc5ikrdKlqKnF1QsAMOFisd+P51DENri0wnsWcYXPl0XnCIc1Tha66Jees0QdQX2iL338a6+K0+G28uRAIdoR/hcIuljX1URnGa+3+YQ41CpGMZq2HRdXZjiIerOF8RlwT/486cj4IrIy5hjv8y8ySpfPynzIC6GxDYThWxg8Peu9F/8lGUfHVKg6BmHZpjGbxZeJ1g54ChZ/2aVgqSrFwi0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9b3a3DoFwxr104cZo16IuDoW+U7UtLpOMhbcZHWJiw=;
 b=a240nbfZ9JW8rYfZ/8mbXWkrtsI2bISOExx+bScng5F3xhPPCMRDppBw8pwzcfiCybDihzxYCIe623q8cgzGtGXqBTTRkaQjZeWAFXrjk/6CROUSJj5dZDImFrGnfg4MQxoDeK2/9ekwh7OSiGdSM+RTBfdh7PgQpJeJzSx7NWB8+Jjz+3Qi6kwjhQy3BchR7FhtI4FYEYo8sHCD2VOm62mvbTeLKtk4i0fZjiz9EqXDPcDH66VjAREoCPNyR49sdqur1z8gFHsBqCUtad6P2NkHiSATUJSCwxVRB/ftlwzXujQ6y5n/4jmk8jQTWXn5D0gzeLSvAJUNjXosiddZxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9b3a3DoFwxr104cZo16IuDoW+U7UtLpOMhbcZHWJiw=;
 b=xiTfRuOg2ncEaKBqEsLtsdq5oyXLZPMD4IKLAHyfWFTKYvmkVKF72gob2wCXySWNDDLmd1Z7N4kIoONbpuvG8f1M3BNKDg/9ovNmvS1RC/Qy71qVW9DUJtPqtxzM8Sxs2+Mv9jiNtYox+06KkMmqKWnX83XinSTvx9oyoWku6Tg=
Received: from MW4PR04CA0186.namprd04.prod.outlook.com (2603:10b6:303:86::11)
 by CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 08:16:43 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::6) by MW4PR04CA0186.outlook.office365.com
 (2603:10b6:303:86::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Wed,
 10 Sep 2025 08:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 08:16:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 01:16:42 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 10 Sep 2025 01:16:35 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: adjust MES API used for suspend and resume
Date: Wed, 10 Sep 2025 16:14:35 +0800
Message-ID: <20250910081634.3943981-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|CH2PR12MB4102:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe33a30-4000-4abc-d3f4-08ddf0426042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KRXJDvTLOHDdNjOavGAo2PN4Mpl7ypqlVSmFxQ5RB0NRiwjGAVikGWLn/Z7+?=
 =?us-ascii?Q?jQBQPhB9J9Nckj1ClkuXrLxixI0eQzF73tDmzCMGFc5LciOunUz1uAyni7J4?=
 =?us-ascii?Q?wEB1rJH77PxA8JrbNhAZgLmLoXKXiNiFhRRCEh+c6XjiqTDAnE+lNYb3D/Cw?=
 =?us-ascii?Q?pXqw/xj9z4+YP/AD944dZX8EjWM2DkLbuL0SrCs7fpq9ETVFkW+IK3Jr1x5O?=
 =?us-ascii?Q?imGIPDbPHvELVdt9NMByq9vDyZ29mwa8Ve8aMUR13C2rpcbi4AE9Vaj/MqdJ?=
 =?us-ascii?Q?/Pb2lkhLRTr1JhZPyprXAhSLp8AZddfl1K/9zGgrg8O93hFBTcXNh+N/l9yt?=
 =?us-ascii?Q?RykS60Oh98fbmsN8BiwGNIXudGVtiFLoSOIXT35M2sh3sURtOUGpEKGC0NNd?=
 =?us-ascii?Q?b34gnp9Q2vWTuppArg0S3P+0//ixAeRmE7eoxSZXEbwBv+f7wHYx90XnPKBq?=
 =?us-ascii?Q?RZRGuZZFbQnEncrb5nHGe7xZpjeq5KBk7ajjoo3RddO34KpyEFAlt+lP1P0Y?=
 =?us-ascii?Q?iYG/OXsohRMmkiotLDf9ePD1XPdaJaQKz5f5TaK3iRE51rIjchxnVXk7diPw?=
 =?us-ascii?Q?5vkJSAK8guTZ94mCwJV/d0g3Xo+TjovxOmE1KBv8r+1yyomBzXNHsXQbuRGG?=
 =?us-ascii?Q?3bMn68k/UhSs5Z+O4JZmtNl8mR53uYfQf92jmlHFiyywjmK1v3NAWFDW445U?=
 =?us-ascii?Q?D4IH6XYs1ySYR7IpVJIFpRPM9aUc4BLSU+B/IuegNGvrjxbpJpMsTAS2esAP?=
 =?us-ascii?Q?u89YLzNcTEHGQi/BYdMsDerdS+doTmiv/qZG0JO0OfWL6eNWy2s9XwtfGbig?=
 =?us-ascii?Q?qKTZSfGFwjX6va02zAP4HAYxY8s2J/OkSUO0qRRl8LLtBFVatx+oQqBCvRNC?=
 =?us-ascii?Q?z/ntY6sj6PYj1/mEiU6TutPdwCJzFlGnsY2c6uYWg798s30dLPliQTKEuh25?=
 =?us-ascii?Q?A0UB9eNIdGZelFXsCq3He6/PxGhD/LF6K+qhI/VP/U3OADuEgmSBPJveAhJ4?=
 =?us-ascii?Q?xnnWgS3U8eXeSovDThh3oK7cYt85vg95nr9Mx/9syRzh8yamJ+pgon/tHTRF?=
 =?us-ascii?Q?+grqT8C6L9GUShf1Yc2dNgFlGxsRUhJmirKCanh7NI5q2BPrlPX33Pa6DBMn?=
 =?us-ascii?Q?oMMY7Wfjq5+s3HnMWaU2cocjeo7GW/YdHGVMhU85YP0GhLS3SISfvo0K3bkC?=
 =?us-ascii?Q?D1yQyU7yKDXRw5DhZJh+DnIEPBI25MVqKpZpZ5OJKHhcQJxvqw7x0ixYJom5?=
 =?us-ascii?Q?s0BcqJUWZP+nsDYXS4OxwRMaKwFVUiqkVI2+NVYSbmx7BcpVJtF2liPN8QKm?=
 =?us-ascii?Q?Td+63aGjaqvRv5z60D/zOgsCJS6TUzjaLWdf00L/yob2CSAH9n8w6o/C2pyq?=
 =?us-ascii?Q?z5um1mO4jsR+ebgK0Fd3H3L9Xro5XfBv6pRZQ7+MBqvvA8O914nawxTBFpBO?=
 =?us-ascii?Q?H7c3a8INtKdrHVv7aK3T/Upb9EPdWpOQ0LVFgDDcw596uJy0aOvUay4OErCm?=
 =?us-ascii?Q?9Rsy9JmT1qcdLfau4QzxdSHTUvy8VFCvvbZH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 08:16:42.8637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe33a30-4000-4abc-d3f4-08ddf0426042
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102
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

Use the suspend and resume API rather than remove queue
and add queue API.  The former just preempts the queue
while the latter remove it from the scheduler completely.
There is no need to do that, we only need preemption
in this case.

V2: replace queue_active with queue state
v3: set the suspend_fence_addr
v4: allocate another per queue buffer for the suspend fence, and  set the sequence number.
    also wait for the suspend fence. (Alex)
v5: use a wb slot (Alex)
v6: Change the timeout period. For MES, the default timeout  is  2100000; /* 2100 ms */ (Alex)

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 3a4fd6de08ce..8e771ca67d43 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -404,10 +404,82 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
 
+static int mes_userq_preempt(struct amdgpu_userq_mgr *uq_mgr,
+                            struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_suspend_gang_input queue_input;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	signed long timeout = 2100000; /* 2100 ms */
+	u64 fence_gpu_addr;
+	u32 fence_offset;
+	u64 *fence_ptr;
+	int i, r;
+
+	if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
+		return 0;
+	r = amdgpu_device_wb_get(adev, &fence_offset);
+	if (r)
+		return r;
+
+	fence_gpu_addr = adev->wb.gpu_addr + (fence_offset * 4);
+	fence_ptr = (u64 *)&adev->wb.wb[fence_offset];
+	*fence_ptr = 0;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
+	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.suspend_fence_addr = fence_gpu_addr;
+	queue_input.suspend_fence_value = 1;
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->suspend_gang(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r) {
+		DRM_ERROR("Failed to suspend gang: %d\n", r);
+		goto out;
+	}
+
+	for (i = 0; i < timeout; i++) {
+		if (*fence_ptr == 1)
+			goto out;
+		udelay(1);
+	}
+	r = -ETIMEDOUT;
+
+out:
+	amdgpu_device_wb_free(adev, fence_offset);
+	return r;
+}
+
+static int mes_userq_restore(struct amdgpu_userq_mgr *uq_mgr,
+                           struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_resume_gang_input queue_input;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	int r;
+
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
+		return -EINVAL;
+	if (queue->state != AMDGPU_USERQ_STATE_PREEMPTED)
+		return 0;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
+	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->resume_gang(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "Failed to resume queue, err (%d)\n", r);
+	return r;
+ }
+
 const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_create = mes_userq_mqd_create,
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
 	.detect_and_reset = mes_userq_detect_and_reset,
+	.preempt = mes_userq_preempt,
+	.restore = mes_userq_restore,
 };
-- 
2.49.0

