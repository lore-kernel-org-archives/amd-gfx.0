Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B092C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 10:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E614A10E843;
	Thu, 22 Aug 2024 10:29:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l26864JJ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831AD10E846
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 10:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhALacVZqbNa23s4V4B5aa/URvOLnmXZKw2XzfwVVEVTopIVgytRT4FFqHaHSaM0oeI51vywg0iJ9SdGF4Z00xO8Yd4dt8XLvFA7Mr0Ro4nlaXwjkGEZW8GmSkWZOsaKMoz+SbWxCSrV5gMFJMSdxx6XgX+aFmBTBDtJwg2dWMNgMwSjrTjvPt2Berzxhf+ZVH0/Wj4fYQa1HyKnJ27u44rCU0cvfTlS+3pfKtYJl6ajRAq3UfK+ts9l4/4t77X14VGyymRpK3H3nkUAvDuGjF6bPygrI2ysYLm8e9uyOs31+FDjlD63l6XY6R0SBT/qOFgMigkqRHvB/Go1XiREpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4bVat7GBK2mZ5rQH2iY7d0Hf0KMhenFoX8QlapeHqc=;
 b=a5jo1yYoPKF7UgCPFSqxbm9teyt5gZ7brqaEYsmDztliObehkaR/OihsBJc0KLPsqgp1+dmEyW1zahs91Dijb1AltVzj8UKq65hdn3e/wht/eYanOJuKOw2mjXA9Hs+eVhGvsLF7N9S30U/tMZpDzO+YiBuo0N9bM6+nXLrH499isvEwZndLALpUlEBElkqRMSZmh+K7lFW3nw8NrSle/uAXp4XKfuFm5KT/Y37s5VOtk6voVx9OC/cV146u01SjtBzmri1apqapggZtqvE1ooGn1AXg8t+jRCYFOi8/2wFMBcMqAR7kSZlaWZmaPyHhlPNiqKUvmCQd3DCpZat1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4bVat7GBK2mZ5rQH2iY7d0Hf0KMhenFoX8QlapeHqc=;
 b=l26864JJTfUUoiwERk6KNpbCWwAODotx+4E8SzmbFoyGjAQgA5pJcST4DsVypk8BDcORllkLc1gk8I3gTr0WpEL6CMPge9MPkjeK3M8MoyY+64cg2QKJBcxBRlrLhcVUiwPdh/RZzhZSncvL1pRBj4tNtKGJnoYLIkICOTyMAnE=
Received: from CYZPR10CA0009.namprd10.prod.outlook.com (2603:10b6:930:8a::13)
 by IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 10:28:56 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::3c) by CYZPR10CA0009.outlook.office365.com
 (2603:10b6:930:8a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Thu, 22 Aug 2024 10:28:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 10:28:55 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 05:28:53 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <amworsley@gmail.com>, <marek.olsak@amd.com>, Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes: add mes mapping legacy queue switch
Date: Thu, 22 Aug 2024 18:28:30 +0800
Message-ID: <20240822102830.2277414-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 6acba0e5-6b8b-4d4f-738b-08dcc29539f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TBCi1u+UcPwHxBm4Fj9ZNrPfT8b4/7iD8hJdeNzw6UvKanDXKeQEUAdynRHk?=
 =?us-ascii?Q?Jz0BSeuHhKPxAmHpAR7a6pZop7QKMy4AbvaxuAIXBbt30ttFeAwSkgmiFwnT?=
 =?us-ascii?Q?AT2FwifQSHCAnPWKSGXu0dodXrkUWzdWMjJzwY3q6Zl9TuIHHNbwGcKiqoUG?=
 =?us-ascii?Q?bTeRYIv3hSvnukspYj3ZGrMZlCULIwheiqi3z9Pz/IJafC4MLKiDtdO9DGUy?=
 =?us-ascii?Q?2F33NTqQt44M5hKocO7Nh2URnz1jFcDNJCgU2FmDuLKKmZPWNlc9hRxJQk74?=
 =?us-ascii?Q?nRXWwtkgZY1p0HEE+nWDDFExmMPw+2Nu7RkZWfjdmeFCH+EjxaDUcVzf0DN1?=
 =?us-ascii?Q?R/VamkNlf6Va3fgml231oSJ6mSQ9muTH74H5oLSUOl1VolDo9oqyaVk7uaRY?=
 =?us-ascii?Q?gPPfQszpjNhM9ENMbuf5t2XaYvWrkXcyiiPmGykP8C4WrLdkJajZzT2lpzZV?=
 =?us-ascii?Q?/xk5sLmhpa04nzJq03arTftslRfus+iHGR2W8MTDWoMojbC83pCD1bZd+Nd8?=
 =?us-ascii?Q?fDfMsiPaY+go5nXKTa3SdVO3OKVJF+mqFF1FbhO3AmE+7Eoi1mrzxrN8hu4G?=
 =?us-ascii?Q?LPum6JOvxEmIkzQ9Ue5f05FFBxNS03F1NxvLojaggyQ6EUhPLrQRoPZzzmhf?=
 =?us-ascii?Q?auryM5fkpCU3ewlMb7/+peIr0tEdh4e6wLkOTWMvI7os9gnWA4Oz7yA1RT8I?=
 =?us-ascii?Q?9Q4HrCIRooLk7ewJsqub+ZBrO3y7yBS3G/I33UoY0tSjZBVk/lF8gJUtoq/Q?=
 =?us-ascii?Q?9iOR/ieI2pirQU0HbP7q475N7Y8Y9Wxil+xVKCuHQEyfUx/HLtD3k5YUlcu1?=
 =?us-ascii?Q?Jy+ReqFVX2Mlsr/rRiEnzOtmsLlybpsBsapNkVdKMyJMTzcbOetGvkQrPh2w?=
 =?us-ascii?Q?Rb/aChJ2iyix2petPPV/Dfa9riO7gQocFJj/S6Te/nUvGnrwZmhKj0zZU2dA?=
 =?us-ascii?Q?sk0xI3XHzZkc7Dco9uxOFaDfDIIEsiam6UFZkCbK97ikkMgrB/i7e0nks2dT?=
 =?us-ascii?Q?DKjbgdbPV7J2IiqZ9qqeRizCjw+0fZqLYcgbQqfxgW/4jiDNtQn1RQFVPOLh?=
 =?us-ascii?Q?mFOjmwDHacu9NgLmCbIi41X+3N1V1+r66lHAhDOQ3I9o6iku5K7Ixe3DTStM?=
 =?us-ascii?Q?GxeALAtEXTgW2IGElqDmgka5UKufc1b5kUhJ1M3CcB4xT3cRIzGLF3XBhZoP?=
 =?us-ascii?Q?CxAQPiEIUOwZrvyUg7eQpKJ6P7w6SS1KcY+MMOXyNiC27OXQ9721ISIdIk2r?=
 =?us-ascii?Q?7Uf729eqFFYHNq/rUXLf9Qn1iYNEEnEAvc3QDkIVfN5Qxw0Q6rQrDD4VDs7W?=
 =?us-ascii?Q?GYPYXBQSKH/opwZ0JAxklXS/oId+3+BEL0oGGLt7UhpVQwupamW1i4LQNt6E?=
 =?us-ascii?Q?4H6bT+FRr0wHBC/SeXJ3rLnjTU77LrfaEsntyA5ma6+SwyoqYufZlunRo9mK?=
 =?us-ascii?Q?t4hJKLwBFBh+I4hAwCYZIRR6cLqtHDyM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 10:28:55.6624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acba0e5-6b8b-4d4f-738b-08dcc29539f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279
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

For mes11 old firmware has issue to map legacy queue,
add a flag to switch mes to map legacy queue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 49 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  |  9 +++--
 4 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 9be8cafdcecc..3ff39d3ec317 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -657,7 +657,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 	uint64_t queue_mask = 0;
 	int r, i, j;
 
-	if (adev->enable_mes)
+	if (adev->mes.enable_legacy_queue_map)
 		return amdgpu_gfx_mes_enable_kcq(adev, xcc_id);
 
 	if (!kiq->pmf || !kiq->pmf->kiq_map_queues || !kiq->pmf->kiq_set_resources)
@@ -719,7 +719,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 
 	amdgpu_device_flush_hdp(adev, NULL);
 
-	if (adev->enable_mes) {
+	if (adev->mes.enable_legacy_queue_map) {
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 			j = i + xcc_id * adev->gfx.num_gfx_rings;
 			r = amdgpu_mes_map_legacy_queue(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 548e724e3a75..a509dbed858e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -75,6 +75,7 @@ struct amdgpu_mes {
 
 	uint32_t			sched_version;
 	uint32_t			kiq_version;
+	bool                            enable_legacy_queue_map;
 
 	uint32_t                        total_max_queue;
 	uint32_t                        max_doorbell_slices;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index c0340ee3dec0..dfe51e41504a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -726,6 +726,28 @@ static void mes_v11_0_free_ucode_buffers(struct amdgpu_device *adev,
 			      (void **)&adev->mes.ucode_fw_ptr[pipe]);
 }
 
+static void mes_v11_0_get_fw_version(struct amdgpu_device *adev)
+{
+	int pipe;
+
+	/* get MES scheduler/KIQ versions */
+	mutex_lock(&adev->srbm_mutex);
+
+	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
+		soc21_grbm_select(adev, 3, pipe, 0, 0);
+
+		if (pipe == AMDGPU_MES_SCHED_PIPE)
+			adev->mes.sched_version =
+				RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
+		else if (pipe == AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
+			adev->mes.kiq_version =
+				RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
+	}
+
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void mes_v11_0_enable(struct amdgpu_device *adev, bool enable)
 {
 	uint64_t ucode_addr;
@@ -1095,18 +1117,6 @@ static int mes_v11_0_queue_init(struct amdgpu_device *adev,
 		mes_v11_0_queue_init_register(ring);
 	}
 
-	/* get MES scheduler/KIQ versions */
-	mutex_lock(&adev->srbm_mutex);
-	soc21_grbm_select(adev, 3, pipe, 0, 0);
-
-	if (pipe == AMDGPU_MES_SCHED_PIPE)
-		adev->mes.sched_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
-	else if (pipe == AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
-		adev->mes.kiq_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
-
-	soc21_grbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-
 	return 0;
 }
 
@@ -1353,15 +1363,24 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev)
 
 	mes_v11_0_enable(adev, true);
 
+	mes_v11_0_get_fw_version(adev);
+
 	mes_v11_0_kiq_setting(&adev->gfx.kiq[0].ring);
 
 	r = mes_v11_0_queue_init(adev, AMDGPU_MES_KIQ_PIPE);
 	if (r)
 		goto failure;
 
-	r = mes_v11_0_hw_init(adev);
-	if (r)
-		goto failure;
+	if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x47)
+		adev->mes.enable_legacy_queue_map = true;
+	else
+		adev->mes.enable_legacy_queue_map = false;
+
+	if (adev->mes.enable_legacy_queue_map) {
+		r = mes_v11_0_hw_init(adev);
+		if (r)
+			goto failure;
+	}
 
 	return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 0f1702a78170..f0d58295d31d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1300,6 +1300,7 @@ static int mes_v12_0_sw_init(void *handle)
 	adev->mes.funcs = &mes_v12_0_funcs;
 	adev->mes.kiq_hw_init = &mes_v12_0_kiq_hw_init;
 	adev->mes.kiq_hw_fini = &mes_v12_0_kiq_hw_fini;
+	adev->mes.enable_legacy_queue_map = true;
 
 	adev->mes.event_log_size = AMDGPU_MES_LOG_BUFFER_SIZE;
 
@@ -1456,9 +1457,11 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
 		mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_KIQ_PIPE);
 	}
 
-	r = mes_v12_0_hw_init(adev);
-	if (r)
-		goto failure;
+	if (adev->mes.enable_legacy_queue_map) {
+		r = mes_v12_0_hw_init(adev);
+		if (r)
+			goto failure;
+	}
 
 	return r;
 
-- 
2.41.0

