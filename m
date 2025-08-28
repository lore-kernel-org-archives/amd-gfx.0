Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B1ACA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E7810E95B;
	Thu, 28 Aug 2025 09:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KkakUj6O";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 167D610E950
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yi0YFC9wm0xitdetOUHWHyL57nOb226cxwFFBFUle7bKPt9jXnXYZfF5aD9D31NLbLMABuvc4bPpsfzB9rTWtM2KpR8u8DX0Z1cAa0VsQx+Pm2nbu6zvY8DbvSfHIgt4rBrXBIOqqfz5NcjQmQl5q9MA9Cy1i4pVgsxTLLoPi/OMerPoeTQJ38Wk8MwoJP8W9G9R0+521uEPY1ze2gienGczaQ68x6PybSjs37jsa08zDOtjj+Y2YG1TyC5AoNQTJMidppfQw5gAWBdbwJtiBH8zDNpotLOKW9fPBmKB+DoiORmz2/8i0842fjXCQzvF42hwJAZZbbrEneMPLfUXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbQMHr0CGdXCDyUtpyJD9uCzZPpJ2ZW0V9dvQzkftb0=;
 b=HCL05U6hOkJunof7dqYaHu5V2fLLrWNWU87AshfCaVBuh9i7PUngFr7o/HNv/OA6WgGwoUMceh7DaJ7tlKq9gQZZLRWD7/KzGReKSU18E63A/2pLf5Aag4NnJ5bvgdEK+4GZH1bQu8uiVhS5krwbhSD7erkZyJKXjKN4ln+cdyMUD0UJztd61LO6E9zQcdii+5hoUbmZTNliMX9PMuJgvXfOUU1RStOI8yOnUs31Z/a5cTupXrGEoaIxzxcQKBhz8zjewXzoGuiaJFwgCKSLxrF7JgKjxq9LYPdn2owFZyaC9ipzO18KTuaU/iGlDYacch7gUZk8n4UbsUU70LAjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbQMHr0CGdXCDyUtpyJD9uCzZPpJ2ZW0V9dvQzkftb0=;
 b=KkakUj6OLLqqXM0UNWQSUc0y60J2GfqpAfpQdF1BQ4en4NZY+3zeuMkAlVJ+ooF9QVJCN/GEVrR1UbmFOk0E+5tn9a2ZrSTNiZbYw7N2k20XfsiDy5/bTAORVtEd7sNpd6/1mSD3v/RQk1NKZ3Lm4byFGjdUQSGe74l0gO+JBZ4=
Received: from BN1PR13CA0022.namprd13.prod.outlook.com (2603:10b6:408:e2::27)
 by DS7PR12MB9042.namprd12.prod.outlook.com (2603:10b6:8:ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 09:22:33 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::b9) by BN1PR13CA0022.outlook.office365.com
 (2603:10b6:408:e2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.6 via Frontend Transport; Thu,
 28 Aug 2025 09:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 09:22:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 03:45:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 03:45:10 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Aug 2025 03:45:04 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v12 02/11] drm/amdgpu: adjust MES API used for suspend and resume
Date: Thu, 28 Aug 2025 16:42:08 +0800
Message-ID: <20250828084457.1999535-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
References: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DS7PR12MB9042:EE_
X-MS-Office365-Filtering-Correlation-Id: 10cf4e30-5d71-405e-b2e7-08dde6146b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+pRgYHy0hFnodD6wSBnr0ETctI2lIut963ambA2i5QhaE76XLW2Ll83EYGtx?=
 =?us-ascii?Q?KaDDsgR+3PnxR9q0mWar+rMD8XFfphEsbmaR6z1QYrmuJcRtUsLeakimK1Tc?=
 =?us-ascii?Q?AE6BDST/1gMLaeU/O1bJU3Zizd30Lquj+5OI4o+oGtmNarHf9HsLNlkzEvoI?=
 =?us-ascii?Q?gkvXS57r+sIijsAoEtm8MF4+IWfRXk6lwTjmvygoyzeRXXMIJxZsSWayZZt1?=
 =?us-ascii?Q?MBmn8lHNr7EQKU4UDVNrKcwZXYNylVK2mehLNaqpoXOAzEbo2PbfE0u2qw74?=
 =?us-ascii?Q?ifjALr8xRJuv3Mrkd8c31tNzfj7/IlE8yXgYVxNUO66AoSlrSSQeb/kQP3dU?=
 =?us-ascii?Q?puvCgjgikG6WQD4Cw0xJcs8UjXAWSvwvuEkUXiK1NsGBYOq88k0RGk10s8am?=
 =?us-ascii?Q?jF2Nf400EYxPmdhMSgoR+oXsVfy6wD+steC0XFTScyVCld0HIIDzHNuCijeZ?=
 =?us-ascii?Q?myBKIazyRwmcGgtnMpHpQZsGNzD0LszwR+FzK9FjcNjPKU6JPuZ8jM52C4Pv?=
 =?us-ascii?Q?eLPLqUS0WtTCHDyRwkqqarrS4+n28CaL9hYgE6hniu74dDJ0s0tdGEDyiuKr?=
 =?us-ascii?Q?3OSblXMwCcFsgG27twrOLOTzOYJVlagrVWirVLkG7oa3BDZzdvHUSKXH/3qq?=
 =?us-ascii?Q?ObbFYZsxG/KR43OnYiZECGyA9KTBm3glwX5lrqCxUU5J/rZTyM+OA4+UT5wX?=
 =?us-ascii?Q?i7xj8tRrEXEy8AobpJH5jHJ70xjlJQaEa5hrz2cnBZsMbmcvwTNEwLpgW4x3?=
 =?us-ascii?Q?sQ48xeDKjyHlar3tnoYmSLLF+5sGi8TQTPhuwbmiLeGaWj1bMfxropSH7KPX?=
 =?us-ascii?Q?fnoXF76DyOqYyj3uju/i7uY9AFaa+4YIMuzW2S0BEK6Tbfoyrqwm7SQOVHb5?=
 =?us-ascii?Q?u3BsEWRIK7S2hK4wG59DXfNS9AFC6goP3rLgkuFmS58+kTQr31KLCt59MqCC?=
 =?us-ascii?Q?oTLuFIlpbnCBLUWgFf8zI9WgEzqQ+GLMSZrVMoWpByqlCSOjUUITKNMzo4a2?=
 =?us-ascii?Q?F2spYPobP8gS0L7TlP4bdXKlAPc3HUmL1IeG55yn1Pix2j0oiW2N8MK4YN7O?=
 =?us-ascii?Q?tAdfV/p9vnWtw3FmR+GrqD64UGxxfg1sWqbgksnjrH9qaUw+zoOTp98G1u8w?=
 =?us-ascii?Q?wCmFy+sjAeWzDqPpwvXfd5CSBoROOFec0eF6kH22x62+qMgLpNqu1Da5ni4p?=
 =?us-ascii?Q?4eTt0uYf6Z3wC43PuMPFRtBdSzUeP1MAhNrRX+4yyHCGUSzUfT0jlDrmPgPl?=
 =?us-ascii?Q?d4xdfcoPJGKVv4x2kl5XeEppU3/r034/1fyCtr+h5GjSrn32WS4EJSakufCv?=
 =?us-ascii?Q?YKCVgjy9oBbgd9J4ln+TtWS+ujo8RL9L2aZFNRMnNIrzZu2yTamCyF0NWiCT?=
 =?us-ascii?Q?gyuTQHI5fnJ5I6Z6v/9jXBNqOrHZoe7PXOP/M46LCO3iZC3mpCABJ5PNTrqy?=
 =?us-ascii?Q?1NsAOULVRZfBEbOfzMViOMlMYR8w7ndVTH7PHCOcYb2Uh5QdBCGMf0gyEfii?=
 =?us-ascii?Q?Sq/LN9iOmGYizAfhkLLMmYMBRhImlDnG5Jdz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:22:33.2404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cf4e30-5d71-405e-b2e7-08dde6146b70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9042
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

