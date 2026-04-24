Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA39FFB44C4
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 08:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F4910F42D;
	Fri, 24 Apr 2026 08:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="01BjCS0W";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A522010F42C
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 08:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sg5gHdoKPjfp0Jr9BLQ1GBoiUgx5hWRiFYbHbFOnSkpgiYNhHyZH9CMhWEZxiVeUrGrEB8hovxAwtEYZLNjNhh1UnSgIlZsaJ7S02d550CfU65afauESV30yRMy8Ff2m4tCI9ZXWsiSEWvvdQlxZ/jQJnLzxhNsEJrx/JgiKjc3/tyL1t0vLX87M2z+cCLUyaaXOLparAdbdlnUOYoBM7uLJ+vOWOmUoqZBngcKm10uOpjWoH58k5QvHU0mFrl8bIWInPToPe/NvCLZIg2yN+cz4jOgImhTmZb13MouTNJhZWIweHbO5h0vXvC4/6eMePk0oUkSZjifwE16vv4x+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESlLt5eC4/oj1gVbtDBKHxKWRzjq8JcKOmVRpa3QCWg=;
 b=W1vdQ+AxB13SNRip4OaqiiXPtYg7nBskTvbVoib47LstLrCcS7NF8oO2CLjHYweVWVzI+umyG7BZ620Fp1oVMkrXOlD8rXVsiEDvvyJOukty4P1oYFFOeptYS/MfKebpZUPqIRMtYSRQ8dL297YE804WlL68+BgB4MH97D57hywn8aOzOv71FZ3V5Qn3J6V0SNMZKCj+0eXeuqbe8FIPOQghAwwu/zzEXwwKvgNov4kGsfkHZx3bXsRYDXRwgvhEidZ14UWwhKWim6QEgOoqygko5ZxM2fOqzp+lm10eQzZB5lTNyZJbGQXZHwLNnUA5gZfEcZo6agY/eNX0ODipDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESlLt5eC4/oj1gVbtDBKHxKWRzjq8JcKOmVRpa3QCWg=;
 b=01BjCS0WIB4wlyATwvBYMmXVYInA7p/UGVobNCsTgSv3v7Fp/+ouB1qm6USSk4BGaX1XBw6DoaQL6oisKNF2o5p/kjl2DQsKjICF8S8HsMEalifABnNri5KPEz7OocP63/jz7s31PBNPVCxvSF8HqyFefgZLGHzadh1nfYv3AsQ=
Received: from SJ0PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:33b::9)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 08:21:05 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::4f) by SJ0PR05CA0004.outlook.office365.com
 (2603:10b6:a03:33b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 08:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 08:21:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 03:21:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 03:21:03 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 24 Apr 2026 03:20:57 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 10/10] drm/amdgpu/userq_fence: wake gangs-out SDMA UMQs via
 NOTIFY
Date: Fri, 24 Apr 2026 16:18:55 +0800
Message-ID: <20260424081955.873090-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260424081955.873090-1-Jesse.Zhang@amd.com>
References: <20260424081955.873090-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 1655c9fd-726c-411b-01fd-08dea1da6d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: snMKKxjdW4rrbm5lpo5sfQpsOYdiEz+InxCtUtgP8CGxjXXKS7cKRSdRxz9I7FMz0e1t30Fp6tTgcmDWili4aZx5A0bTxk4lM6tbjtTe+7tJYNRl42jOlASgj1xqkSPxcrgmwpNYZ9jHcuPhXSKnshKnjUJDBjI3kawfk6GINAOfmeL3MFlUDXRi5qBtdESdlU3aSUVqtAf/nqDpmDldmZPhZ2JFxFL39oSlgn+59gX+KNGVeev2iTPwvQ3yMehxsQlIPOyo6T6c15Xiu226tWpC97jIJKPi1ehboCLi7lZvKz6zq6kAx5CAvWolkkn9TXsKu42y0GeAMoMb73i5QilZ/dpo6hQlBl5vx+qmtifv/mAHLOu50vzP1nqeHclft6Tq1SbbShcvVWVdRMOOEwEsLVGTgIn/wy/e6BQNQ0VQcs31OmuvdN0scqqzw6ExebFQzy1LJdhGclTq3cBLAnhVUzg6Fa2SdUgWKIfDwBw1DKi4S3CsNz+nYpzIaSdyEPX/YShPB7g6GjXSIPFJtqX0Xelrv1V3FuJzW0aIKLflItu4mk4OIT3BtWFT2N6Jm9aiZM//Vq8DW03wwbtF4KF7RfocWUNYXjhx/gCRqivJ5GYecXLlDsypDpmtMSh2SLTiBbKAmZMgo/BSN8SPpzDrOncnnWC48LAHkJ82Gl8GUrd9uLYQBtMpROvU+bsQwBI7VvebKc14HvRHX1c4Z+JnR/kAykgklpHKgt6kqV8fSDl8ZeMZRjZlheVxUKFh44L19UXjSBSxv3OQocZ3RQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qva8MlUXVw791SjZVSPwz9t4BfxRXkNzM9dFT3j8cNCkPmUzwAzLBEZT9wdIxAcDOaQ6GKp4/fVoUHNB6jAOZEclclv9KB80fwSOElQOBw3uO8gvJotrbnrREGpuyPkwgFgPrA04Ucv+5OXCzLYK5ClgmaDE4hMGz/nIOL+dBsxALjTuMSGtH6kUBwv2TvkbXwp30zdWDqVTwhwd20XMAD0kZJvrdT+/3nrmKs6o7S3acs6IvJzRNle09Py3Qn2rxp4jHAi8tIcwL//zWnkJzZQXsLPk4/hDjP98/UgkeCa6ll8uRqW952gkRavaggd31eUFs8gP7O5Yd2DPpeKDqJTA34FX922jHyoZjfOmHyeizuBnZ6da5K4GiXDwsuXAuTFv0DpWyeU62MpSBWXcGbdzufTZp9guQ1qx5jOCuWFAfpvo9kx33jiN9leD4RZk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 08:21:04.5832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1655c9fd-726c-411b-01fd-08dea1da6d95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

SDMA has no CP_UNMAPPED_DOORBELL HW intercept, so once MES gangs the
queue out (after the first IB idles it) per-queue doorbell rings from
userspace hit a mapped-out HW slot and are silently dropped: rptr
stops advancing and FENCE IRQ never fires.

After the SDMA UMQ's first IB has actually completed
(fence_drv->cpu_addr != 0), issue
MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE and ring the priority's
aggregated doorbell so MES re-evaluates scheduling and re-maps the
queue for the next IB.  The first submission is intentionally skipped
— the queue is still mapped from MAP_QUEUE then, and an extra notify
would race the initial scheduling.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a58342c2ac44..6ef4cbd5d5da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -598,6 +598,39 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	/* drop the reference acquired in fence creation function */
 	dma_fence_put(fence);
 
+	/*
+	 * SDMA UMQ wake: SDMA has no CP_UNMAPPED_DOORBELL HW intercept, so
+	 * once MES gangs the queue out (after the first IB's PROTECTED_FENCE
+	 * idles the queue), subsequent per-queue doorbell rings hit a
+	 * mapped-out HW slot and are silently ignored — rptr stops
+	 * advancing, FENCE IRQ never fires.  The MES MISC API
+	 * NOTIFY_WORK_ON_UNMAPPED_QUEUE flips MES's hasReadyQueues flag for
+	 * the queue's priority level, which makes MES re-evaluate
+	 * scheduling and re-map our SDMA UMQ for the next IB.
+	 *
+	 * Skip on the very first submission (fence_drv->cpu_addr == 0
+	 * means SDMA hasn't completed any IB yet, so MES still has the
+	 * queue mapped from MAP_QUEUE — calling NOTIFY here would race the
+	 * initial scheduling and starve the first IB).
+	 */
+	if (queue && queue->queue_type == AMDGPU_HW_IP_DMA &&
+	    adev->enable_mes && adev->mes.funcs->misc_op &&
+	    queue->fence_drv && queue->fence_drv->cpu_addr &&
+	    le64_to_cpu(*queue->fence_drv->cpu_addr) != 0) {
+		struct mes_misc_op_input op = { 0 };
+		u32 agg_db = adev->mes.aggregated_doorbells[
+				AMDGPU_MES_PRIORITY_LEVEL_NORMAL];
+
+		op.op = MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE;
+		op.notify_work.priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+		amdgpu_mes_lock(&adev->mes);
+		(void)adev->mes.funcs->misc_op(&adev->mes, &op);
+		amdgpu_mes_unlock(&adev->mes);
+
+		if (agg_db)
+			WDOORBELL64(agg_db, queue->doorbell_index);
+	}
+
 exec_fini:
 	drm_exec_fini(&exec);
 put_gobj_write:
-- 
2.49.0

