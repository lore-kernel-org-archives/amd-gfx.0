Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1579CC369D3
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA20310E982;
	Fri, 25 Apr 2025 18:39:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gtBcyLdJ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57FD110E33A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:39:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhJeaSovFxyO3FJz79nfKBQNvd5QHK+hm2UN3mXZnfMqOAM5VevzgWf6oWS6f6UFRHg/ta27YtxlGkY8+G2g+zZGax433kHu0Q/9UXOE4BC5f0dBVpBtENdiGV4iIjZujDG3YcRDkYuqcXJf6Shr8YEqXm+oYXpmVAcGkqALvH6TL12+VB/NAzn87vUSgMgI/mntCiVE99Dr4MBw718Lqv0hx4O2mHbhU/T0eNOG/AZsgEBiUCOOw/RYLsb8pGRn+HajOyxzLqlrrJ9DFyrqGBNtD1AXB6Bx6E/qhAmoEJbR9pWqVoAzr2Gk1Ig1eXv7C9Uio5s5ieV1unAEbcCP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RM7oIioaqIiHhstObjZY2xGv5tfNJdOxYujX6oViPBI=;
 b=CvcDJ1PZ0QJBKC3LIOFAZHIr/cZrMqPG+uQC76Q0/q97nkmx8TtDV8ixb+PFNXWlj9AWWahkNHOO9VSrLU+F/xApTHJvrKzjHjGddQiZt2Lx/yu7pr6WwAdzT+iRfJjNLaMvb3aRHEFEN83B81cxMzVLObRHJv//KsKrN2hQE6Ahji8zbikkx7eMvrOpm6AX7Uk0+MMnf2XnRHk2T7M+9Jr317IK6kjAsDvpqYEfChuKv7oOg52vWfCGm7cVggBQwiFhGsw6wDb6S0HVgIqIq57BisRldyuoCqX3swSK2ufY/L2u9TsXBFNRhmZOdmCSGxVTCxVarTqj4GJhBXjD+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RM7oIioaqIiHhstObjZY2xGv5tfNJdOxYujX6oViPBI=;
 b=gtBcyLdJYtIQJT7bU25WG/9bdm6rOLxR5UmdrJkfnrHTA4Iymq+IEFo6vPyRhQfkci4quD7BEfse1LrN3n3TbFM6SYk9KaQ01gGlFTggxKc0EZx5JnH16Wg1tU9xJXQ7ZTEiFHo+hrpY16IUChj1T/kVlIm6+rYAcPcYCzlx2oU=
Received: from DS7PR03CA0309.namprd03.prod.outlook.com (2603:10b6:8:2b::7) by
 IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 18:39:08 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::1b) by DS7PR03CA0309.outlook.office365.com
 (2603:10b6:8:2b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Fri,
 25 Apr 2025 18:39:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:39:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:39:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/9] drm/amdgpu/mes: remove more unused functions
Date: Fri, 25 Apr 2025 14:38:47 -0400
Message-ID: <20250425183855.165199-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: 2edb9c16-0cb3-40f1-f716-08dd84287699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yd+KeT+4rcMcOEdSdS4cgbCeKd3UnOMrd1et+YfeWU7xwWd+ebreOiHkxAMe?=
 =?us-ascii?Q?hA9qy2lqm6j1rhCbQh5U4yaSaUdnl8ewkweCU+SYw1HX6512CXtirC6dpdD4?=
 =?us-ascii?Q?n0E5pjw/xsuKzltKWrk3+D5JaLatR/sdq9VulmsfLr46tq6xF5auzy+uA0aS?=
 =?us-ascii?Q?71DYZHraDXYI8bymhZOHWTaIASVo5X5+K1lTucYjJ3n+I+H0mY5j7yFBpMNS?=
 =?us-ascii?Q?kck7yRUrpVplG6ibw3NKLwEH3s6e2BR3FdfJyxxJ8fvit58t1ct2w168dbSS?=
 =?us-ascii?Q?iyRN6lpIMIT1dex0fdiwIFLhvk5GboAbf9gc13h4hfGJ2IvRdmpZp+jUmXun?=
 =?us-ascii?Q?mXYzZcJDinhHO2STKAwhh2Faxjku0u+rmamlNXKY0jSsZ+26jhCGpg4yw6fA?=
 =?us-ascii?Q?Po+gZ35aAD6eht464QLZmFfeSZ2h+mqpsEtKBsrrJEbzzHvFDgD78jCVmDfN?=
 =?us-ascii?Q?PXbS4wEgruIqFcDwm43tAd8UuEk3ISE6bZW/4l9k29OdA/QOckVB+IhFLUOF?=
 =?us-ascii?Q?ib01gm5kvpcsDeDkJ/tWPICuzCuQKeH5zUpBsRjz+ifClxdADXR6hYfbwBOv?=
 =?us-ascii?Q?XZFS1UUpGbMKHtBwtUPElVs8SH+MkUA171QO3yWDPUaLd0tFnBmYJRRbDpsw?=
 =?us-ascii?Q?+IzEMWwtfKCgo5AQmGy243yc2WHd+jxJRDl30VXpJKFUiKMA9Xr+zntWKDOr?=
 =?us-ascii?Q?9sngIRbKVap5OX6Tr04ygvVkbWbeo7j1Ky+CP9RZVMMtpVv7yC5As4mtb6Cd?=
 =?us-ascii?Q?UgcSBe7Y0cTAN1iF9o4AbF608vtkh3AztbzEdptMklP/rXtoaIRP4Zp+CoJz?=
 =?us-ascii?Q?H5H1ORGU0eGUCR/0lU3f42K2N+4XIGshQSqbGCC/l2Q8lI6T2CAupXTcznFo?=
 =?us-ascii?Q?JHzz/WLyLdWvddy1goH73oR7GtiABeG1MwYMozgzWajcAZIDh0f9ygL4f3if?=
 =?us-ascii?Q?fIidvLasAA9Nke2yFCQ9H9FIASNSFulHrmoFuiCLjwUjC3Xch/zRfUY+MVtF?=
 =?us-ascii?Q?LmB8TsSay7DXNBciAnrCIt14WEuu2zTwXIYwzpDM32yOD+9s+leuNsiXrPyh?=
 =?us-ascii?Q?+NoVO6YAId14v2qkzsFimgkvBCnEL3Vl1G9D0SYk8Jp2VCo4mTMyQUAzkWOO?=
 =?us-ascii?Q?shB2cJSKYzvcKmD3GuU/9075+mzFJCgrqzmBIePLEQ/95swnJxM3PqZfGwBa?=
 =?us-ascii?Q?wb0lG6TbqQJCgqz8c4/VO92mZe6WwoQBikQA7RrVIrA76bfXdy+MX64ohpD7?=
 =?us-ascii?Q?GHsGfVijVzXunH1A3rTp01LKM4PLDZtuXRsdZACLHzGP9xbX8dH8LLUp7V+E?=
 =?us-ascii?Q?tyygIc+BTzVYckE/YuGHide4m4SgfU7fisf1Gompg8cjMaXNQXHgEtlELa7C?=
 =?us-ascii?Q?cGcKDLgRlsnSyfHxJO3idSx5JhqyQDLp3M5To5cvRBsXk/u1cwKkKv6bz+WR?=
 =?us-ascii?Q?KVmelG6RL5dkR9JRyUSwB92dxVX4Kbevqb6hZpDTwRukJIieVKyH4lPXcQKg?=
 =?us-ascii?Q?u+c7C5uxy/Q2JaH4Rnf+05kRlnhJ6vVCqqM5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:39:07.9057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edb9c16-0cb3-40f1-f716-08dd84287699
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029
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

These were leftover from mes bring up and are unused.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 62 -------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 19 --------
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 26 -----------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 27 -----------
 4 files changed, 134 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 38ea64d87a0ac..b5a7e2ae72aff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -285,68 +285,6 @@ int amdgpu_mes_resume(struct amdgpu_device *adev)
 	return r;
 }
 
-int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id)
-{
-	unsigned long flags;
-	struct amdgpu_mes_queue *queue;
-	struct amdgpu_mes_gang *gang;
-	struct mes_reset_queue_input queue_input;
-	int r;
-
-	/*
-	 * Avoid taking any other locks under MES lock to avoid circular
-	 * lock dependencies.
-	 */
-	amdgpu_mes_lock(&adev->mes);
-
-	/* remove the mes gang from idr list */
-	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
-
-	queue = idr_find(&adev->mes.queue_id_idr, queue_id);
-	if (!queue) {
-		spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
-		amdgpu_mes_unlock(&adev->mes);
-		DRM_ERROR("queue id %d doesn't exist\n", queue_id);
-		return -EINVAL;
-	}
-	spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
-
-	DRM_DEBUG("try to reset queue, doorbell off = 0x%llx\n",
-		  queue->doorbell_off);
-
-	gang = queue->gang;
-	queue_input.doorbell_offset = queue->doorbell_off;
-	queue_input.gang_context_addr = gang->gang_ctx_gpu_addr;
-
-	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
-	if (r)
-		DRM_ERROR("failed to reset hardware queue, queue id = %d\n",
-			  queue_id);
-
-	amdgpu_mes_unlock(&adev->mes);
-
-	return 0;
-}
-
-int amdgpu_mes_reset_hw_queue_mmio(struct amdgpu_device *adev, int queue_type,
-				   int me_id, int pipe_id, int queue_id, int vmid)
-{
-	struct mes_reset_queue_input queue_input;
-	int r;
-
-	queue_input.queue_type = queue_type;
-	queue_input.use_mmio = true;
-	queue_input.me_id = me_id;
-	queue_input.pipe_id = pipe_id;
-	queue_input.queue_id = queue_id;
-	queue_input.vmid = vmid;
-	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
-	if (r)
-		DRM_ERROR("failed to reset hardware queue by mmio, queue id = %d\n",
-			  queue_id);
-	return r;
-}
-
 int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index be3390d263012..af6e341f6411e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -235,18 +235,6 @@ struct mes_remove_queue_input {
 	uint64_t	gang_context_addr;
 };
 
-struct mes_reset_queue_input {
-	uint32_t	doorbell_offset;
-	uint64_t	gang_context_addr;
-	bool		use_mmio;
-	uint32_t	queue_type;
-	uint32_t	me_id;
-	uint32_t	pipe_id;
-	uint32_t	queue_id;
-	uint32_t	xcc_id;
-	uint32_t	vmid;
-};
-
 struct mes_map_legacy_queue_input {
 	uint32_t                           queue_type;
 	uint32_t                           doorbell_offset;
@@ -377,9 +365,6 @@ struct amdgpu_mes_funcs {
 
 	int (*reset_legacy_queue)(struct amdgpu_mes *mes,
 				  struct mes_reset_legacy_queue_input *input);
-
-	int (*reset_hw_queue)(struct amdgpu_mes *mes,
-			      struct mes_reset_queue_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
@@ -394,10 +379,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev);
 int amdgpu_mes_suspend(struct amdgpu_device *adev);
 int amdgpu_mes_resume(struct amdgpu_device *adev);
 
-int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id);
-int amdgpu_mes_reset_hw_queue_mmio(struct amdgpu_device *adev, int queue_type,
-				   int me_id, int pipe_id, int queue_id, int vmid);
-
 int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring);
 int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 0a5b7a296f08d..5ce62a3f01e7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -475,31 +475,6 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 	return r;
 }
 
-static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
-				    struct mes_reset_queue_input *input)
-{
-	if (input->use_mmio)
-		return mes_v11_0_reset_queue_mmio(mes, input->queue_type,
-						  input->me_id, input->pipe_id,
-						  input->queue_id, input->vmid);
-
-	union MESAPI__RESET mes_reset_queue_pkt;
-
-	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
-
-	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
-	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
-	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
-
-	mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
-	mes_reset_queue_pkt.gang_context_addr = input->gang_context_addr;
-	/*mes_reset_queue_pkt.reset_queue_only = 1;*/
-
-	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
-			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
-}
-
 static int mes_v11_0_map_legacy_queue(struct amdgpu_mes *mes,
 				      struct mes_map_legacy_queue_input *input)
 {
@@ -817,7 +792,6 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.resume_gang = mes_v11_0_resume_gang,
 	.misc_op = mes_v11_0_misc_op,
 	.reset_legacy_queue = mes_v11_0_reset_legacy_queue,
-	.reset_hw_queue = mes_v11_0_reset_hw_queue,
 };
 
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 1f7614dccb005..a3391810c897c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -494,32 +494,6 @@ static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 	return r;
 }
 
-static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
-				    struct mes_reset_queue_input *input)
-{
-	union MESAPI__RESET mes_reset_queue_pkt;
-	int pipe;
-
-	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
-
-	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
-	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
-	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
-
-	mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
-	mes_reset_queue_pkt.gang_context_addr = input->gang_context_addr;
-	/*mes_reset_queue_pkt.reset_queue_only = 1;*/
-
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
-		pipe = AMDGPU_MES_SCHED_PIPE;
-
-	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
-			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
-			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
-}
-
 static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
 				      struct mes_map_legacy_queue_input *input)
 {
@@ -914,7 +888,6 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
 	.reset_legacy_queue = mes_v12_0_reset_legacy_queue,
-	.reset_hw_queue = mes_v12_0_reset_hw_queue,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.49.0

