Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2DECA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 08:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EFFA10EA9B;
	Fri, 22 Aug 2025 08:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dwd5c9Xi";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E4D10EA9B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 08:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHDUFur4vMMM37ZvY7xflno5Vov+5ZBsjfcH4mm3LIylqnuo87APuQZZYwktLCN76LTEAd965zyyCi4BgyTY3Rb+cCdFAjkvHPnYGAC3pzMufqJrZ3ymCk/7zrQUlTfjDuCkQAaBgs4eRy5ZqIy3J3but4skmaRX7CtxAvkdCPWbKRH00qfHPyz6g7GctwaoI0ay1ZJo0FD9V81zVcMNzV5wQ4XtcGDHJ2IBxnCLy13gdMn/mrKuopPIhqgIFHfgnOrLeij3X7Zcz8NCL7nNZmEQZ4rbMbvc7UwkUdxQi8rC0EU2iToM+D1uHcUteQoLKuDjTELQBVu/548bzGJbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3022l9/pNRPuJkrY+QylewQkuPaVGTlugs9SoGO8n8=;
 b=Y20HQ8qGKdgbU05NsK2ZRpF51MeKvHTXM2XK0ZC7wnjI7BGMgoXj/AKF5QR2doQjdKTepCbJRKikMuDDfXJcBags2bHioZZNVzeWjt9TH6s7DYnUY0IxgrWtDsrK68+gaEoNgl3Zm7ZCPoAD2mbfz1pdNJpfghvAndshXcoSdxDqDvwkvka1SAsbVCAKiEHzoqFfa0SE4cG0nR49yUk0IvFxkDuW2UqDXONpWLA/ZzIM8hM5enX9vH5PxpHmIBAUs+9piHEX6VKlmeAdfufxG3/ISgziVZ9jzC+jrPejIfYMRXL45Y3SWq672YKlrhOuDAak8DI+l7QnjuRLaZuYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3022l9/pNRPuJkrY+QylewQkuPaVGTlugs9SoGO8n8=;
 b=Dwd5c9Xietxtoi6WSqiqy+xJSw2qiURyxruyqozUGAZtbHDtlOpmfy1uqc7iBkpVzN+PtxU5XsoXOjRnHwbSCptPLBsg0W0Z+SkW1O2owLMy7gKqjcyB+htgP9ZEESIFXVWeF+ozTVhxrFg2SPVszBjyCwucnkkWgnSXveDrJTI=
Received: from CH0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:610:b0::34)
 by SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.20; Fri, 22 Aug
 2025 08:54:49 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::56) by CH0PR03CA0029.outlook.office365.com
 (2603:10b6:610:b0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 08:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 08:54:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 03:54:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 03:54:48 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 03:54:42 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v10 02/11] drm/amdgpu: adjust MES API used for suspend and resume
Date: Fri, 22 Aug 2025 16:51:05 +0800
Message-ID: <20250822085434.970798-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250822085434.970798-1-Jesse.Zhang@amd.com>
References: <20250822085434.970798-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|SJ2PR12MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: f38f53ee-5113-4189-088f-08dde1598d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/NFr+d2tI/OWuZmRiVdrmZXbKIEMm3A0VLT2jG2Jjcnb37UduMFtG9NEi23m?=
 =?us-ascii?Q?j5nuT1TNVsDtHguy7SAyM/8do6ZxhnvkLteE4D7KD8Di5E+iOID4ktfPcwtY?=
 =?us-ascii?Q?s68hT5YAdiwqCAiBRg32nvODduAi3WZBzgZbDAlnn7ISqGzOYaa06cthO05k?=
 =?us-ascii?Q?4e8UeoIUOA4KhwWY23uVw332H1TMzaQOr7x5L7AIgfOjTIORH7i5awa9yLtn?=
 =?us-ascii?Q?FGppd1LrlgtihqGSzusp3+ORJNgNpRDrMDSKnwJ9fCQNjrQb9KuJGKuuWD4I?=
 =?us-ascii?Q?+8PHWdEZARYgUTcjYbQhyHaTwHiGq7yaWGK+t9JT8VEwP4wp+MxggCZ5ymuh?=
 =?us-ascii?Q?alWTtSNYFSNJy2FopiMSbT5GNsG6lDkN5D8mLzNFcSnn8iuRlgJ/CvyKSx73?=
 =?us-ascii?Q?fU4mdWDTmOwI8OgQ/34A+DH4BLKsUtA03BYBBpbumHoRDgUxXE7sz7SDTozj?=
 =?us-ascii?Q?7D43/177XAWjMoXAEFjIhVqOckGVHcYzIuMDyNtR02AnL9pAAL/LPCymq5Wm?=
 =?us-ascii?Q?KvKXvrDTBSktfj+Jf6XSLsqI8fqN6aLjh7koHQdckwONyuaCFa6fuX7XBdlX?=
 =?us-ascii?Q?R9Jk0+rLwTVbf9j1HRkfsX5I1taxTvwXwYhy8iwGMtjPRSE4s2u7vuT5rDRb?=
 =?us-ascii?Q?UMv9SemPpChGFupGnVZ6Y85pnPhVqJivDZOdx+EG8gCn/R4i+aGMbnozCSLJ?=
 =?us-ascii?Q?fkEvt11HUShTS0iinsDcZfsR4AU7s7lyZP3gg8CmfMSjML9i9if82u/60+wN?=
 =?us-ascii?Q?RP/uGBnSShHr1kusRoMDs18j5w0qsJ5TsdDOCoaW2iJz8qSL95z9D6mqrpAB?=
 =?us-ascii?Q?Rth6WLHtRzbzECY5Yosy8L0HKPZmOA2+Ip4l9Oa2MUGgMoKWx/GJjmCsU83o?=
 =?us-ascii?Q?Ug/TSbdO1RMGAdAk5B9f9aApWyb0Qjhxp7g7jDcaW473Y4H5ocoa+IDsZw3U?=
 =?us-ascii?Q?PW8Hbsz+VoYHMjAyFOlutFS2+/5SoqXWh8vS+gjBbMB9CwKmxhgUThyDtajT?=
 =?us-ascii?Q?O5e3mnIyTwbaxGvgq2H6vGqFHp1besg5TdXep6ATGZfIEqOUVHh1PrUQwTXV?=
 =?us-ascii?Q?NDxFbAKrB2cMhGjtdfEvxDF3w6Ovg0NzRFMab94VI+ypWXzzGz9RlABlijGM?=
 =?us-ascii?Q?xBNbcH3ER1zRgn/IHAXxYPGT7T3rPOCgLLz6ns3yWT4jQu6qSWWRvvkd+41V?=
 =?us-ascii?Q?xTJAHbr4yW8xzHPRD2VENm49dMNEUdhei+og+hqOfNRP0pHTmQQkNowmWcpn?=
 =?us-ascii?Q?m8p8H6XWNK9HmvXDfNK1tnIQ7M1t4SjSWKWMcma1KTWe2VRT+lfqrX2QZJjM?=
 =?us-ascii?Q?4v5XlIT5HW3dT4CE1JekpCz/3vaLPHHd97xsKkZJu/BkLC18O/NyGQGDFO/H?=
 =?us-ascii?Q?oz3bPbmybN/21NAfYnda78EpG3yHy6pzIVYjTP0a3oCrnid5u/0zAozA8tSn?=
 =?us-ascii?Q?8IICtaA4sOCzSisQZYY7RBnz6dMummenWB+FDuBZg9AYIiNJo6IrSWq2vnFL?=
 =?us-ascii?Q?+AE9GU0SZFVEAOw9TNzb2jgFpXb1ZYA0eSiI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 08:54:49.1818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f38f53ee-5113-4189-088f-08dde1598d1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848
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

From: Alex Deucher <alexander.deucher@amd.com>

Use the suspend and resume API rather than remove queue
and add queue API.  The former just preempts the queue
while the latter remove it from the scheduler completely.
There is no need to do that, we only need preemption
in this case.

V2: replace queue_active with queue state
v3: set the suspend_fence_addr
v4: allocate another per queue buffer for the suspend fence, and  set the sequence number.
    also wait for the suspend fence. (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 96 ++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 5111d7dce86f..d58cf48b456b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -65,6 +65,8 @@ struct amdgpu_usermode_queue {
 	struct dma_fence	*last_fence;
 	u32			xcp_id;
 	int			priority;
+	struct amdgpu_userq_obj suspend_fence;
+	uint64_t suspend_fence_seq;
 };
 
 struct amdgpu_userq_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d6f50b13e2ba..ce5ac8c2f7e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -28,6 +28,8 @@
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
+#define AMDGPU_USERQ_SUSPEND_FENCE_SZ PAGE_SIZE
+#define AMDGPU_USERQ_FENCE_TIMEOUT (1000000000)
 
 static int
 mes_userq_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
@@ -347,9 +349,103 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
 
+static int mes_userq_wait_fence(struct amdgpu_userq_mgr *uq_mgr,
+                               struct amdgpu_userq_obj *fence_obj,
+                               uint64_t fence_value,
+                               uint64_t timeout)
+{
+       /* This would typically involve polling the fence value in memory
+        * until it matches the expected value or timeout occurs
+        */
+       uint64_t start_time = ktime_get_ns();
+       uint64_t *fence_addr = fence_obj->cpu_ptr;
+
+       while (*fence_addr != fence_value) {
+               if (ktime_get_ns() - start_time > timeout) {
+                       return -ETIMEDOUT;
+               }
+               udelay(10);
+       }
+       return 0;
+}
+
+static int mes_userq_preempt(struct amdgpu_userq_mgr *uq_mgr,
+                            struct amdgpu_usermode_queue *queue)
+{
+       struct amdgpu_device *adev = uq_mgr->adev;
+       struct mes_suspend_gang_input queue_input;
+       struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+       int r;
+
+       if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
+               return 0;
+       if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)
+               return 0;
+
+       /* Allocate suspend fence buffer if not already allocated */
+       if (!queue->suspend_fence.obj) {
+               r = amdgpu_userq_create_object(uq_mgr, &queue->suspend_fence, AMDGPU_USERQ_SUSPEND_FENCE_SZ);
+               if (r) {
+                       DRM_ERROR("Failed to allocate suspend fence buffer\n");
+                       return r;
+               }
+               queue->suspend_fence_seq = 0;
+       }
+
+       memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
+       queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+       queue_input.suspend_fence_addr = queue->suspend_fence.gpu_addr;
+       queue_input.suspend_fence_value = ++queue->suspend_fence_seq;
+       amdgpu_mes_lock(&adev->mes);
+       r = adev->mes.funcs->suspend_gang(&adev->mes, &queue_input);
+       amdgpu_mes_unlock(&adev->mes);
+
+       if (r) {
+               DRM_ERROR("Failed to suspend gang: %d\n", r);
+               return r;
+       }
+
+       /* Wait for suspend fence to be signaled */
+       r = mes_userq_wait_fence(uq_mgr, &queue->suspend_fence,
+                               queue_input.suspend_fence_value,
+                               AMDGPU_USERQ_FENCE_TIMEOUT);
+       if (r) {
+               DRM_ERROR("Suspend fence timeout\n");
+               return r;
+       }
+
+       return 0;
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
+	.preempt = mes_userq_preempt,
+	.restore = mes_userq_restore,
 };
-- 
2.49.0

