Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BB9CA1009
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 08:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59A9D10E4F6;
	Wed,  3 Sep 2025 08:39:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uKhuF4Ib";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4982210E4F6
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 08:39:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdMf1i6IptCNp9gZeyV8AnuLodWHzNO3eSk0fV52ZEAREjCrAEgr1jitP8fCL8NVNTDuaYYVW2ls9xa9wlYHKxFwcJNI1ogLZmqvwzLEo29cZCX6PkT7V6YYxtCKXFNNDqpph2mWn1dHpP+ssnpH8j+lTnn3o6Ma6oBlRoRVqVVJTXoeTlpNC4LxB75fbS8equV+vbLtZx5yBwBNq6MYq0VK2wenfCZgY9ezXldyKgp9yTbgOWZ6l8YNsyIjm03voxcWzHJZiijh8HNjDLDaSY+lWdIO3xpBypSJ66fA1QXA+hbRkADH3Ax8tW4JToOs5w+u1sWvK5JzgOcUPZ4dww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbQMHr0CGdXCDyUtpyJD9uCzZPpJ2ZW0V9dvQzkftb0=;
 b=b0rEtqGQawgPYXygwvVhv/p8gUZZRiho255s9LbM+pwObiFLonjG5prL7qUkMT9LnYIMFFJG+kT973y5tdfA7ax6H1ZynIMRqrwa/GmD67gCImDv3fVWQqtTnbWeH99uUoejpbg0o7zQgi5c3z9F7yl2MyOCvahyxYcxGGQtnoeKlbwF4pdSSh8UoldgEiLOH+EoviMQwnf2W9nGV8wIOQpB9OEVG/oh0i97f24msXonIp4itmry4BxvHWGsUYr5fpaQhL0gEv63D4nT1E3iDO94BDt4GvLTsk1Ridq+rItWYlzHaY/1zBJMbhG2QZZCvBHZTJxWXUxbjnnwLE9dgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbQMHr0CGdXCDyUtpyJD9uCzZPpJ2ZW0V9dvQzkftb0=;
 b=uKhuF4IbcGrjb0rXPgJOO3OH+d4BRRk8TnCYdMHbxQawE3GPwNMKQTDPltIFK+jN8/dbVVJHQsp1RcVQoOhbGAV7Ag/Wk47ROpAYONCBkvU91/vdfjVFHRsB4tc+0/o9olgqyT+ybaiNXp1ZGAoJ+/lgvYNKTdrTogoOS66VT/A=
Received: from SA1P222CA0035.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::10)
 by SA5PPFD8C5D7E64.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Wed, 3 Sep
 2025 08:39:29 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::26) by SA1P222CA0035.outlook.office365.com
 (2603:10b6:806:2d0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 08:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 08:39:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 03:39:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 01:39:28 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 03:39:21 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v14 02/11] drm/amdgpu: adjust MES API used for suspend and resume
Date: Wed, 3 Sep 2025 16:34:20 +0800
Message-ID: <20250903083914.2604482-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
References: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SA5PPFD8C5D7E64:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab80b97-e819-43cc-8806-08ddeac56586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cm2iXC5IgXuzwAmC/intHqxPK6GE33kduY2AhNjPs4AF5RK/Dp8lNko6IudR?=
 =?us-ascii?Q?fyMrG7/Gt2GY2VfeswaYdfTnWvadUsZER2TutZYRTffG5Q5f4amskOtoH/jW?=
 =?us-ascii?Q?W45CbnPDaMUU1XkUGQ1Jjhsn08DLzRP+9OlQc93Rxm5gG+mE5lyJUc+yCXbf?=
 =?us-ascii?Q?9JoBSRm1Zh6FRQPduAQb8cQ7u9QqQGpPQWG0n7/LoOQ6DuVn2f1BvGyMJzJr?=
 =?us-ascii?Q?gvfiEZ7bGMfI5fyZ2AD973gM3YGRxo9IAeyv8lDFqusEc78YaMvcFrE7jaZq?=
 =?us-ascii?Q?h8PDLm9b2Zn/y1kT0ysA8zCr7vpphAoUoZj4daH3kQOdQS+T0ItrwdiBzz+x?=
 =?us-ascii?Q?/j/WD4iEygY7O9RDPuJb77r+/LEkMVEo3d0v6POkJMTqbTIxz52q+MWw1kUz?=
 =?us-ascii?Q?aFpjwkQE3v1Th2/OYpc1R2INSnOGCKeSMCvc5dAJe45wdOnWx7/4orWYUufV?=
 =?us-ascii?Q?saYuhw8MzJ3Zn0ZAcuOLaAeerx/LrlLdJ5yswtAUBPEz2EdcWO+3ejk7I2X8?=
 =?us-ascii?Q?o4bTQF1KTSd5uO2N7w85OPdukYNqDbiTRKK9jX73lBz5km9SKtFnn5SS26W5?=
 =?us-ascii?Q?7A6EwnpIw6Wr+TDq5w9o7m+F3ozZQlhlxrUhafArAg97EHdx1c9VJhwYt/YG?=
 =?us-ascii?Q?jWMQLeHfEUuo7sjjhDWJltVdCbDHGWt4I8CXwD8ShlV8wyXLjBG4BSTpXp2H?=
 =?us-ascii?Q?cvGyY2ObCpsFOxLnQoCEZki71k+2PJgPOH+ycC8sfNG8LqopuORjM4NIyV2L?=
 =?us-ascii?Q?rmYDODUV5SHTX8OU8tDk2NiLO1khsRxjsHcZvfProSdr7l64aYU5Xj/E8ePJ?=
 =?us-ascii?Q?PJeTQYVn3lVW9BGhKPs1Nqsy3d8Lw772/POMQVGySA/fOslMcR/atYlwyMfJ?=
 =?us-ascii?Q?O0ggL2Z5sz7xDZISxdFkehhaPT8jPWbuX2VOtea6vTZ5Qfxv0k53cBDvK1qP?=
 =?us-ascii?Q?6dUJqOy2F8c3hTnEPa6mBU9B83bmWfdMJfd5DcWkXu5fSRJjZqkk2kEOh/Kk?=
 =?us-ascii?Q?qOx+HvlAbg/oqIn2dREOCBk+tbmaXjnjiydT32VTDeCGPihaVrbifYPFt9UA?=
 =?us-ascii?Q?s0GlUJ257N/wPTjOe/yMMMp6FmQTzyRv2b2jwymnkJzMDKI24yoCQc8m6ZX2?=
 =?us-ascii?Q?CC3DhfMig2T6336V4DSq9kfNPhgVZr5U6UopmbyNHzwvZxKE0+VqCPZNhJZN?=
 =?us-ascii?Q?x5kbYCQBjHJ0TSbEzt1xs6Jr4yl9Uy3IMAfThdyqiS8AK0MJJAFSBZZSXS7g?=
 =?us-ascii?Q?AsyGXx2tZViqeewWUOFLH9RH1/iPjbwUIhA85OIdeEJ2DSk7Zrv1EMkg8G9R?=
 =?us-ascii?Q?94uyI12yvMNjuT23QX9+4l5iDTOnjz6iDuYdBUFTynGxwioCb2VPDzazgsWG?=
 =?us-ascii?Q?VRT9fMDNm+V0Ql9iTatHGzkQXfvO/QjNHL83n0OOYXjzsI/kIWtCe8SNj5w0?=
 =?us-ascii?Q?Qg4EuoDWBMTNZD7Hxg0P+vC/PpDQVtXxG3KY1qE8EDjkRw3WBld2cG640Gjb?=
 =?us-ascii?Q?NuCgtlmznsVQh2zpNVVcZMf5bq4eTMWmMQJ+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:39:28.8611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab80b97-e819-43cc-8806-08ddeac56586
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD8C5D7E64
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

