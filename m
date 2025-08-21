Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A48CA0EDC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 01:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28E5210E2B6;
	Thu, 21 Aug 2025 01:41:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fBH+dZQ1";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B22510E2B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 01:41:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qStbP1HHBGxVLZkTzWks8q97FWCNzLw/Z3FBSRbQ5Bv4OgRN3DsTUvD0lxbqtCqZlrN/3LYRr0tNiHaoZ+eHxXHVCbj2NBeVWKP80fE8AQna0wcZmgUNWFwdUaK1+ewXvoHYs10vBBzezkyy4oszjdwyr+V56QiGcbNmqjMv8CDHEk6dBKepiduWtr/BRBxNUeyKEdLxe8iW8Z4JEdyIFsh967RHcDMCBEInFzd8o1GRj5pfwcNYPimVDsTDRyg/iI+LzfNlzUC3zL0b3hJOdX7qtAtXxHsLbPOgEQIZsOFZY9rsx0N3x5DSfE/g3Axzb6kWXRnUZtgxPswRT5djwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT0XIc2LjAG5yylTVznWq0O0KQm1rdNlB4gsPsqFATw=;
 b=hZ1eaHPMH87GrBOfgEH/MWCdOvy1n2hhm99LMrO9RQNtzXlyWHEyPgPUUKdFRViOoa7qbhVA5Gzfa3xqqa4rCSK0lUqKuzbj2MqMcBaCMbgUQOVZ1BVFm5ecpOkk9W1eisVcJ88KwuWTV7GeNtMTBrvjaTPTTvyO9dV2epyRHPx41Zur1c7lnRlPJF79t0jsDJHhL6TS1I9OGHd/MpOB4M5skKOCiNTz+yAQsEb1Ra7rKHq8uJ8DUfWltdADhwFK6wY/5K24KVN3mU6B8mcVszU1nHiKXsTi4lFp/LnWViBfkSFqIAjmXidwrtb6v4BRzOj6GNGmvkMkVaPHDmL+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT0XIc2LjAG5yylTVznWq0O0KQm1rdNlB4gsPsqFATw=;
 b=fBH+dZQ1vfA6LfTovglDIqZ7WZYFdrJJx2X4V2Lg8zLLaLntwfkBmgSHToYlQ5uuNrGgICebszj2Tki8Uk8W8K6o3B4rllFsbdKxeD1MpeRmrnaDpd/MstzQi8US/nq04qfLnoh5mFSgyqilIQExjGE8G+nQ7qF6jktfv3Tdjeg=
Received: from BN9PR03CA0225.namprd03.prod.outlook.com (2603:10b6:408:f8::20)
 by LV8PR12MB9716.namprd12.prod.outlook.com (2603:10b6:408:2a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 01:41:35 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::78) by BN9PR03CA0225.outlook.office365.com
 (2603:10b6:408:f8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Thu,
 21 Aug 2025 01:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 01:41:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 20:41:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 18:41:34 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 20:41:27 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v9 02/11] drm/amdgpu: adjust MES API used for suspend and resume
Date: Thu, 21 Aug 2025 09:36:04 +0800
Message-ID: <20250821014115.566598-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250821014115.566598-1-Jesse.Zhang@amd.com>
References: <20250821014115.566598-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|LV8PR12MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: cd52e137-fe8f-45cc-62a0-08dde053dcc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JO6x8QXIW7+BehVEFYD+xx6DsWcUdKOFJM29gtB9NZGeMgUeCQZqQCe/XmYV?=
 =?us-ascii?Q?xPGS3XJ5ePHjTLpJEk4wKjApN6iOTaO5LCyGEnm4nyMtK05/KrVfee6LDZ8E?=
 =?us-ascii?Q?0vvh2AC/Mo0Y1e/aKUzsVA9xU0el4uU9oN4oacdDwblr7zsuthiCZChLtLle?=
 =?us-ascii?Q?Si68elMTCUaYj5RtCx6os9i726UH6qNpEkT+C6ngA7FJzhYa3gSAGo5Y6wkO?=
 =?us-ascii?Q?ob6roSW88lSyp6zfs1ylhwwvq5gHQtSUARCjog9R6jv3xThvqOErefycxFTK?=
 =?us-ascii?Q?ZVS4/ckxisarzVF1OZIz/iMJncM3+PTzbhsneA3S6zv1Za0ZltXNvwhZP4y4?=
 =?us-ascii?Q?TPq6foGz8sbJHGZD078zZeIDQHQEH+Lyowsi6AMdzBR5QfnRLI37dx1LHkCz?=
 =?us-ascii?Q?fZ0SFG06YLiak/yoB07JBCtY2YPrngNzwLdUvQBJfqy+L5qXbt8AstvIBoet?=
 =?us-ascii?Q?oNHEO5ZBKosyNNPIuOEfLuEKsROwTBhA8JZx7AiDgrCH9SFEOlHfGjdvzpRU?=
 =?us-ascii?Q?j42FTbhFNmSKPmyObfHANthVL7eMJyQAQ3N5xy0KXVMxmgdmkUZYAnCQe4M0?=
 =?us-ascii?Q?x6Wbkb5Do2YG76nO2ObSgkRRPZXHaPVsfz7FGfFBjD27k333PL1oxLfLcmNO?=
 =?us-ascii?Q?BEVhlpe/HzVkRHKFUQKaiqggroJ4aI0HZRqhwgsTtGgczrPQpLGb9WxR5lKX?=
 =?us-ascii?Q?adSON99ykoSkzpLTIa8PXC7F/s5/dDd8KAsancZ7B/e4mt+5gI2cyYSXemur?=
 =?us-ascii?Q?JKsW8uQ5OHSoLyt4VONyzbpZtzUIA8MERSanaBtK69WiUqgmTiC3tDciKAnH?=
 =?us-ascii?Q?XoqB3SwS4ggdRZfipUHmOCbPH5GWsJE0tcOxdm0lC3IrCvC2pcImaZQRGU1W?=
 =?us-ascii?Q?+0SDR5XFZRMCGptsr1RcGV6oAvcUMDhLORKfHWx+1RjeugnhP1eBKyBSEfHT?=
 =?us-ascii?Q?5kCjHOFximfNCqJzel28AGgbVsP8RD08adbfyITSH5cH2h3L/USriPyRbH7g?=
 =?us-ascii?Q?qqjhYN6dLij+R0O4Z1vqEjPkYyXXWHyOCCjJFuuCEFJPfvVT/JeAWR83ZPl6?=
 =?us-ascii?Q?LqVkoMIb4WZAxzjXPUmT+t/yE0+hALYtxRhLu53d9BVuWnADR9TBQxzQ8S4l?=
 =?us-ascii?Q?t8SXnBJRs4MPVIqvuNRwDrYONBX5ikArwjA8pBKcjeM0byhe82GNay0jRwPS?=
 =?us-ascii?Q?uIOibDJxV5qs2FhYltyxPE2ZceIaJmVDdFdBjccFSPPqa6uHv2RnWB7A0vYb?=
 =?us-ascii?Q?zbZbVb8QCnbNOU5R4JXgLBc3JNdcD0nMZ5HIchc3Yj6+xtlASNDqhE2LpnPK?=
 =?us-ascii?Q?lpXQVbZSML01lsaEdFBN+0DZlraR2M6HPE8fXYSEdJh6MzPDEXmw0s6hwoLU?=
 =?us-ascii?Q?PF2KwZLI3OHoyN1d8q21qCM+BjC5rjlU3RrdRSXJEtPO9qU5qVupIrb4iB3Y?=
 =?us-ascii?Q?+GLATW+jDCtVo58+jg2DWldS5ezOE6veVbUtOigGw1/UBPaleit1Hc/wNNTz?=
 =?us-ascii?Q?3iNTO/0VHAjoQMIR2f3Ku+CxA9X53DeLzw0b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 01:41:34.6885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd52e137-fe8f-45cc-62a0-08dde053dcc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9716
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

