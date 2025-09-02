Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0213FCA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 08:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D7DB10E1B1;
	Tue,  2 Sep 2025 08:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="At/tGfJi";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9828710E1B1
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 08:07:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRnKgm0xuBDnRubvOU4FNFEspol1vGNfoqlnGPQD2z1fmBdjFKXUDGvb/VowXFnQwBvpb52eR+Ny0DbYeCTgsum543UGtE0q46d0Sbzsmw7IJ/lf5cihSjrcsVQFi/47C2ccOgjhreTLWeJNEBj++LNoYsiELmMKbrNXDV1kdWMaV2t3n1G3usE8UqngC15dIU2CgBUi+AG+lvrRGyQwtycobtSQ6ziCracQ07h8sxs+wMVKlbjdiO7gVPnC+2qT61xvaGApQpTrhrbhtadcE7/de8HDbvAF+lqZmKXO20KjA2UyxxmY36dCeW/We+u7mbu8HHiuXJpBX9WSzPjHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qWNXwfjwfOidPzq2OhtMq/FbEbo+fXLtylif62R9cg=;
 b=wv1JJ6GaGhhhRdhSKUpmoU8eurtMjBooYr866o9ZQxVGtu9ChGmAyJdv/bUiB+8ouYg9TSgVc3PS40f2sPLCDvGZR6Gw+TcYlHJq8ceadl/hahoNuCkKLcJGpG6YS4H9+CsBoMY3rd27ki9lH6DBgFjALdJPhib2pKA53LwMFq9RSINVCW+y8cqONebwrqIyfgr99OYPW4fGZT4F/C4q6dOdgeaXYckP0CgGnYicjIcNt+J7vb0hV9YoxOOKS54QAcCowHsyULHZad2a+NacxVE0JjXH4lAm4nIy7KmnCEPDBXj7n3J0e4CvZWJzj0i9OGQxC9tsUR29QtMUJSSdjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qWNXwfjwfOidPzq2OhtMq/FbEbo+fXLtylif62R9cg=;
 b=At/tGfJi7cTJKGwBsh14hBmFQN78FRflxFO/IogbrwWrmPu1pJjP03Jsprc6OcDL4a556SNTpzJ0u2ovKVBARxz7BlS6/jDMYUH0MiLd0bWdu5TQabGEaH9Shy9FdEFh1fRjJl4cVoXeFGlCXLOpiMfbXSmnoTmnxJtQFF20pOg=
Received: from BN6PR17CA0039.namprd17.prod.outlook.com (2603:10b6:405:75::28)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Tue, 2 Sep
 2025 08:07:27 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:405:75:cafe::2c) by BN6PR17CA0039.outlook.office365.com
 (2603:10b6:405:75::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 08:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:07:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:07:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 01:07:26 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 2 Sep 2025 03:07:20 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v13 02/11] drm/amdgpu: adjust MES API used for suspend and resume
Date: Tue, 2 Sep 2025 16:04:03 +0800
Message-ID: <20250902080712.2515811-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
References: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c2678c-e414-4601-3359-08dde9f7c1cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8M5BueoXkmamSf5j0BeWD27cKv5zIKuBpvW8TzvWwJqriG92QKnRPreMgdx7?=
 =?us-ascii?Q?qil7/nTaI/ON5FGmJZtN1Sts2ZPdx2hSu8KfZQNcq5uxNt8WWQSH7nVIxa5O?=
 =?us-ascii?Q?HFp9dEdYCvUH2+H43uRZ2Lb3hPUc4KOAjy7wltUlbypZter2UepAjy5m1Smc?=
 =?us-ascii?Q?c741O1NuE0Vm9BQ3oosyUh/CJdHmybiZCfPwau+oVf5jPz9/jCyCRVGe1Y0K?=
 =?us-ascii?Q?CBPSWooU5twTv1wqa5WVCTNttMfbhL7gtQ1AsBaCCJsaibk4vY7wQ+djfbr9?=
 =?us-ascii?Q?3S3+17Toc0paCkCklNJWQoggsfWAgMF4i8BDRC3Lb714ta0NAuMIi9F27XLg?=
 =?us-ascii?Q?fFTR22PqmE2cI/H8hc0Xx+UXPoEUedV52Z5e0obYJcG8VcGpFigjPKcUbjSq?=
 =?us-ascii?Q?DFdmBsTPD3YWCXqsZuBgVJ/tzpG5lGBUU77CvWWubLAoCi4CHRhzblg6jy1A?=
 =?us-ascii?Q?jLKfe9k3XD34m6SiekZTbssbAE+NBIg92Joziw34p7qL1ejhoD38Mf3t9KFs?=
 =?us-ascii?Q?kg45eG5ktqbcgiROwY9WHwQpWtPc6lKPZdC+Ek+TE3XQ0YJ3IJpIkoluiEWr?=
 =?us-ascii?Q?AjS20rKwHRZoeJqnTcunhyGB5qNOUbb/8APQkDIQCJk+m9gt9RA4Q4aDD6Al?=
 =?us-ascii?Q?kdqpyFuyeewpPwVMociU5p7ruql0kEuChraFdvY54udCShIsnzzMp2funTuU?=
 =?us-ascii?Q?do7JOVac0cK3H4daAjdf6ejt27E1x/p6rF/zPBfZmIBqH6+Rr/QExxJaOF0e?=
 =?us-ascii?Q?Ukm6yccdL+xUC3PfrU2Pps2JOfTXEkMUSyUYMiNMMP33CoN4ETtD8xj0bQpU?=
 =?us-ascii?Q?Y0ByNWBqZ5Hq5y9Ll56tgAhKMv1yGPB4Ub91uH8lh06kyg9sw57RhkbEb1Ng?=
 =?us-ascii?Q?Yeu95WyAQ6L469BRglfEOzW3jJCHBHTtNIAWDmDZz0l6v3GIgZPP1uMkqwo0?=
 =?us-ascii?Q?n3yTcTWR21bi/4yJ/9rCO5vlg7/pHGLZE3kb9V1gz+RV7CXi5QZERhOGV9u7?=
 =?us-ascii?Q?BS6D++7vY7TsOENiqxB8PLmkPc+Dh64j0WFwoN/Z6o9Ys1ESvO+veiI6X44P?=
 =?us-ascii?Q?0t8dYq4w6a6b9/jDdm7KEJLf3TnRj2Ald7wHlfgdY/Lip+2/hXcpbf6ltD3g?=
 =?us-ascii?Q?em51F3d5Rq+4R+SjgCUUa3BCDptSS1Gd+yqbS5+X+Ks2LOykluoWWUkXR5dK?=
 =?us-ascii?Q?hai3SCd+vilJM7vPSxgSX2d4cEIYV/1VbpS00Rjs/VHR9Fp8HJUsNnG6MIUU?=
 =?us-ascii?Q?Q+padcaZYqQxX5iBW0Mw/NRoRCexj9/OU/atMPb3cobOYt+vm6Pa7TdeIH3I?=
 =?us-ascii?Q?kgFTmt7cmukdxEQtGnE2RUHGZPsDP4Yl8QvrRcxJppyyQIunKwGH572gDaHJ?=
 =?us-ascii?Q?it/8RM6hHEsCmvp6b5W0HUmQk9iK6TmGKr/VjuvGOEjfyLnYCqQdHJPs4qpO?=
 =?us-ascii?Q?R7i1QwU7TCQnPuhoJlxPYPsiYpQ8xtfO80+LNxijOQ1zNTT7CThMRmY6XJBf?=
 =?us-ascii?Q?qrTBrBAdqGadoMuBcGz05Nsafza+wRtwkVyi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:07:27.3805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c2678c-e414-4601-3359-08dde9f7c1cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182
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
v5: use a wb slot (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d6f50b13e2ba..502fa0a40107 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -347,9 +347,80 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
 
+static int mes_userq_preempt(struct amdgpu_userq_mgr *uq_mgr,
+                            struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_suspend_gang_input queue_input;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
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
+	for (i = 0; i < adev->usec_timeout; i++) {
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
+	.preempt = mes_userq_preempt,
+	.restore = mes_userq_restore,
 };
-- 
2.49.0

