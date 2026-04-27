Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE7DFF8862
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF43410E617;
	Mon, 27 Apr 2026 08:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gnq+YSaw";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B3110E617
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 08:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oc77ozuJWhNSUIPkSuPVlAl8WDHhmwn0p2HOGF2+M98jO6oy3Sk93QbdIQHloqqQPzvKcZeaX0JgnBNeyGY8a6l+czbVR0mfcHurxbRsMkdT1EBDkh+8Joa3l+o35mjC7+Av6LVvZ6kR6+z9KePjIDdk6VYVpZW1t8h9OHTzeDkHg0bqZBmrnkAwibHHwYpTP0QLGBvNtesH4k7DwswCHiA8I/L94jsjFVGWdSdf/IDKRWO/e9bQABlEGrP8z8Ui2+TYzLfoVYZoe82LdCOcpPQa9SpZxjCUcBuaZsbt8ClrxAT085wfS0JfxdTMbBktIcASrgFtm/Yon70f9EFspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESlLt5eC4/oj1gVbtDBKHxKWRzjq8JcKOmVRpa3QCWg=;
 b=ozWPrDqt6fswD6+ILbA3aS0jHWqSoLU7PD+dC3XpSGQEISv13kYjWcRbigH55WF5dbTYvHz6dxckykXstkv8Fd2dQ0QS+n3yL/OqRgcDZeD+iHonz3WNWnYUDFQYiqUWN9TvRYO3avyvAKa/LSexiVAo1xDoS1poYJ4Kn7ckkyHWdlCJyP3eQNpQxd9wgpQRmXL2QsuqIlu45wfQOLl6440yNF/yu2rsD+dYhoWNyZNNPqWsLB46C1m8NQv13ZKPLNYukqc4b2dZtfvBBQOZhEVVXMB6CEgHBWJ0kJDsTQwemk1lC2jh9TKzDOrVNHE27CIHGg4oBIqBKPeY4CWtQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESlLt5eC4/oj1gVbtDBKHxKWRzjq8JcKOmVRpa3QCWg=;
 b=Gnq+YSawG4BEG/2imtCk2yoe8pIjIF+nvJAXIEosGZ1o/M0FQIx5l3N+LAHLC1XD6mytEo9ud517cZxbe7sENMgj1ojVdJ0G7RRCZ2yRcP5V/p7BLm9HzR+LC4WkRmMmn+hM04RrAssHTcdHaqSBJWmKjK6cEYolbBZRHhzGHmI=
Received: from CH5PR05CA0010.namprd05.prod.outlook.com (2603:10b6:610:1f0::22)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 08:36:49 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::e3) by CH5PR05CA0010.outlook.office365.com
 (2603:10b6:610:1f0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 08:36:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 08:36:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 03:36:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 01:36:48 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 03:36:42 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 11/11] drm/amdgpu/userq_fence: wake gangs-out SDMA UMQs via
 NOTIFY
Date: Mon, 27 Apr 2026 16:34:37 +0800
Message-ID: <20260427083543.1328533-11-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
References: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 71baac88-e1f7-45b8-1317-08dea4381fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3pjVrfCjd09UlTNVL82CckQkc62vr4JbJm2J7Gvcf/66KO+tVPC0rkr1VaYJio1lV83pYdF2DxYioE5jTVNnosYlf0lpRqwHCn0llidiNai9kSC5w/IkYgEnHWck6e7pqNM1PfmzD+HIBzenkGMdEienmF8tGb1D9ytpCtIzsDsyvIYEdk1agDqosQuZKomJ/EoUXd9TtWg1Qdt3LVD6H4IciGhw236xhWYHyiYVkxLcEB4BctkWNF70cbsux2vBzHYZNe7oLGdD0KyUoq3eaf1u7Pff07szbBqBsBtIqtRtGRTmqDxOApu/yycMTi9/MuHpM+YYiKiXKTzcUr7iQRhvc6RHL7mL+ok5SV3rTRSHD/y59bEHjXXyztyjcfRI30e4MEZpoKXwJQ9HeiC0qBbU7AvIXeiwbSzH0/1S2PIjwnn5xb4oLl6UUbS/nYxkNNb7NpG2/pY2izaPfEIBtGHWVvKrGmVtnoK4rr5TfcdRjQIElFRdG6V8UAo+FbufQ8BKLBQjkZdBp8rPCb/xKl3e7NjtFs4ndhVYrgBjESSMhkCtqEISTSdVflJupLYRNR5zANP6aYwumdHO9/KSjMikx9SA8elJ5ivMf2YFFUw4YO2fm9M4iFQ+xWoEGEFP6gwN7d28/7WKeP6OxYfTDG+BIA5MQjUe3zoM3e0fGMHvk3ph2aygxneApJgoQcvh6EVMM/qiDcH1VM5NZsKiKuDSvpKymiJ6et5rhPsjgnxjnGHpvE1Je19OcyMwkP8Wo0i+NCEYuyI7bZLpJaYPRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XAUp35MwX28WN33CzDiw0TFeF4XNQzQolokgQvjVVIaWnhTtvetwtzF2ai7QzNOCJv9DmO0f+kBn3e+yNP361WJy7PA6fDSd7KftOUicgMwFiXNN0ZqA+zQoFx0a2I8pgKsO0aKCNDB6rKQZzL9u5900jszvUuATvJMWvJ5IRkoO55kimtvYPhJSRBYqe7YXt7aU7tNc5r8wxajIYyc3FUSmDcBIyzpWadeZDxGyUfdTYb2tjrKy07yuREtaBMGD8e4QdaThDUHWfJPv81cuZ4bv0DKFXx2rKsD0eM0cQB6+538Z82BL1OerwuTL28WOulJ/mNoyxuKhzQc9+LborxBE6FZ0v2y+9VahJKUDmMxP82negygnApN8b6mHQ2fuqOpc1JqH/2xYhLMxllF300dzvbWLMcty+tPTX0wZWaRSO7WfgQJFUnd/1A/Augsw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:36:49.0960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71baac88-e1f7-45b8-1317-08dea4381fc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331
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

