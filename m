Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D96EC87FD2
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 09:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDE4A10E404;
	Mon, 11 Aug 2025 09:59:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QmLjQfQE";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6062010E404
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 09:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFJxP+3WHmHDCcssbjQfMZ/m/Y4VnqnVGvEj7QZsQVb0eXcnDDIT+I7KQWZgVF7Tw67+rpZsnfXSMGbrOBcaRDrIgguNLeFuVvbvBZIoEDFPkv5aOfaEi5zns6c7ljuGedWsOUNrMqmg10cH+o8uUSFawqpvvjbGzuuEGM1Fq6nZTFoQzPGbR84BorjpsS9/Du94yefzNj353ZQSAcc1TwovLNPMSFOkgpUYhf7Ctb4Gp+twCvKmyxPKVtGQklVUv4zh7DWg96j7Q9JizFRGAOji3VYQaBl71rdYCEpptLnpDGe0ZhloFd1BKSG+/pbSW3tU8tNBHxauW70pi8H79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT0XIc2LjAG5yylTVznWq0O0KQm1rdNlB4gsPsqFATw=;
 b=jcNvbGgB1rhza5RsnFDW50ZFI/OpBv4oAC1NXqs/UQRs9lzDEWpieANv8aos6Ztd1baVlPxwrbZxFsTcqRBavQinQnMkSaYBCx1MsGi2+/s0INsDYfWW8beNs4o44H8CPBsqmTyr0clXewly3Ro3J4gLhc9f3PMrCCSdAiqUTWAqOlMxMvGQfREX1peUtRPGyJQ3xF978pLiKaladVQ6n/iZ9jW0N8sUbZcs8J4SKdUE7mtNk4iqFdLMMC+h9wi9hAGfqTwBVLe9fg2LTJUg8WnWzqcDax4yBniLVzHQ2qKH5rW4fqNcaPGYHUzm7ch8XYitdhvMoWG307OThWtPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT0XIc2LjAG5yylTVznWq0O0KQm1rdNlB4gsPsqFATw=;
 b=QmLjQfQEoPbjxDyXeFS90adlZQZZ8ayoLKD00BGHuwvUfJiqr5uPba1o2fou+NpFopZQ0sKguf6ZiRtSpENHafIF3E6G6G6U9/vcznv7mipfAmX/utWAlvh1Y78xB0IaANAFWqiw6uzdGReIg1ydRUmOK/sm9bdZeCCePk+qOrY=
Received: from SJ0PR03CA0233.namprd03.prod.outlook.com (2603:10b6:a03:39f::28)
 by LV5PR12MB9756.namprd12.prod.outlook.com (2603:10b6:408:2fd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 09:59:53 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::b5) by SJ0PR03CA0233.outlook.office365.com
 (2603:10b6:a03:39f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 09:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 09:59:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 04:59:51 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 11 Aug 2025 04:59:45 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v8 02/11] drm/amdgpu: adjust MES API used for suspend and resume
Date: Mon, 11 Aug 2025 17:56:49 +0800
Message-ID: <20250811095937.1978747-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
References: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|LV5PR12MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: a95203ca-d76e-4d51-ee45-08ddd8bdd12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/4Bkrxe/JBATmkCFRSeVwOY+1cu2y1h3rcM4h0+iI8xDNPcSFE1P8MNv1Whb?=
 =?us-ascii?Q?IRMO1YupdBAt9fCzieKa0HHlUyQVzXzwjGRL9yOaK/NfxEtR8VG5bstrVXKJ?=
 =?us-ascii?Q?mrjbcYZz9ivsHauOvvtQgmO6nH9616a5apR4rA4YvYtQynCIMzoCl7++hrOV?=
 =?us-ascii?Q?EYDjtTb5kxxBPMkigNnkziNAqG+Ab1v5dGLxYCvFfscnMFzikLM9j1degPPg?=
 =?us-ascii?Q?fMUuC/+vZIuxTG5RzGqIIJNk+28uUN2yXXXKNRPh3lp7aoRpEGRTEYDz8d/a?=
 =?us-ascii?Q?ZQHlLJfLf7tQysP8BGEqbLTSXvDCgbHRD/dv08FSTTNjM9Nl3zWLX693OIZI?=
 =?us-ascii?Q?8DBDG6C3K6QD/v72e4LAvozgHtcQEVpinCEFjftTW+xO38cPzNkWlEwhU2P3?=
 =?us-ascii?Q?/cVu6WSe3lJpntRZ6xzlta9T4tcu/GEfZuMlC4iBat8Yv0SXgYf4m54kx0lY?=
 =?us-ascii?Q?9Fl7uP262bitcjG6ynIAiINwVsuzqiyEaWhmbvGnodSZBFMFq2Hpb51VtYTp?=
 =?us-ascii?Q?8hYw+iNNBTgYuqM2q0MEpGPE9ZaH0gIPZKDasmF+ejgEK6vvQSzDQGp8zEvx?=
 =?us-ascii?Q?9I+lBrl7cBziBvbjFnAQvB8W48NDNWL+P46TxqauRT2uBXy5F3cFsMNX9sEg?=
 =?us-ascii?Q?rxdXmx4G98Xm5Wxc6TiPC9mYWgQHRPZLbX9EI1YvqRrkdqZ5jWolKeSkJtvQ?=
 =?us-ascii?Q?NLHEpFc8unZ3JuUHdR4SZfyxMNkXa5V8OqMIaKoy9az8yAGlj5vxdU25MNxQ?=
 =?us-ascii?Q?6CcfFmK2H+WeH+Bdy8dDaQ9OUlUEpCeb43PDVspsvgh62zSiWIzaeFOU6A/I?=
 =?us-ascii?Q?bvgA5SCA3klJx4hlab1tQWogiAJ+lERe1+ebEY9cgl4XCC//oAwyRe/v02u3?=
 =?us-ascii?Q?WalRaHdI1HhbBuQTYIzscOlyoVcDm/xHVp/Mjon+Skn35mqw6fzKzea7j85D?=
 =?us-ascii?Q?KMg1nYjTrtSC0ozOOkVmvItwAlG+znjYx5qBkzB5uB27lYintlh/EtZglVuQ?=
 =?us-ascii?Q?8XymLnElIjhk0b34E5MQSZhptKCGTZNcbjoJf+JNzuGaSgRuT9V2++sqPp/5?=
 =?us-ascii?Q?z1Wwzna0gAeA3kYfxLxE59G9LNeYag9rYZImU0mBowImj2s41JNc/wFvuvy8?=
 =?us-ascii?Q?SOHM1QMpmXgxEk/av2nEvDLjcFbbgDiTa6+SEfSTxPUtdxcEND7b4ksIMarv?=
 =?us-ascii?Q?gTUoJbfzOuzemu121CYZeYtDdEmEh+sRsN8BI8I7nRoRdx5Ped8U12SztnQ7?=
 =?us-ascii?Q?k/C+oEStUDF5LpuRGn8WU1gsBkAZFuwuunQlHi+uEnJwyCVJRfyQehLypLoe?=
 =?us-ascii?Q?ZYRyrRjEalou9wqAUA3VSFeRN+yUTgAgHmek/dKATTtMDl3D5SBiIbOStjCQ?=
 =?us-ascii?Q?TDi9BMvIMJzNX+mPlWWFVTbTwyNRNtCpSxCYhWXOWa2sMZvbTs5PmeOlZgKH?=
 =?us-ascii?Q?HICHcwhwNGi5nnX7Nm4OWQO7ygkZnPeP8gR8nB+l4qe0uKqr8uZspr58Gytq?=
 =?us-ascii?Q?hQLqQO9uq8dfxtTxqDFFcz4YnHuz4dTdsN2b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:59:52.5139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a95203ca-d76e-4d51-ee45-08ddd8bdd12f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9756
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d6f50b13e2ba..46b24035e14c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -347,9 +347,60 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
 
+static int mes_userq_preempt(struct amdgpu_userq_mgr *uq_mgr,
+                            struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_suspend_gang_input queue_input;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	int r;
+
+	if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
+		return 0;
+	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)
+		return 0;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
+	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.suspend_fence_addr = queue->fence_drv->gpu_addr;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->suspend_gang(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "Failed to suspend queue, err (%d)\n", r);
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
+	.preempt = mes_userq_preempt,
+	.restore = mes_userq_restore,
 };
-- 
2.49.0

