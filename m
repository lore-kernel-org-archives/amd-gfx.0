Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35ECED4415C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 13:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50D310E2AD;
	Tue, 19 Nov 2024 13:23:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DYIpIRwf";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFEC010E636
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 13:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddFs+SamcF/npZ3HOhdMWwkk0yzfLqKmcqUIt5DnJPLxFBjJQetKzwrxeqe1Al0qPi/yv5ei6obJElCoMIbl6pbk7pMO9JouYuQ2CxeDrabgsSAUmV5ituFMfxj1OenkgCMfTGx1zD34+uOLjNDGimQNp4+8LdEohVrpYPVCANXH/y7MZ6jWGXh+of3jkHyjmz6GcL2Kkz5eOXzxahCAq1QjmSRKAG6mVe/Pa3dH2PWOZYX5QC4jfkEWw3UTXz5jKsb1YrwSNbznV86muXqV1L4bqPh3zjd1ApzpB+iVdlqsP30fnFM+5kumfQSa4Qa0ZxqLyDlu+T8LstpuGv/cjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/N/MJ56S1fnpHEgN1nCGri6z4G1mdQ8ebj9+/aTCb4=;
 b=MeuCl4sFzRBDAW8jxM4kh7QkTSAyrJTUF3aEQ/UupuIn4zm9z+tmUgHCXbCaBpvteru9m9PDkvyXn0QqJjYGfHnvh4ubbZkHKdZhC7Zk0v+fjTWDJzD+MqDxQ60Fg/iiS/SOZ1El7JaGouX88pJ6mFBNdvn24IUwRao3P1kaFxzYraa6WWV5cYOsccfdXszp3h5yu1d54UjhdOBd/NOYeOgc7i4mHTvypJiof/fpjDS3bUZ0hft9mqrABfsZ0/1kOVapRGWqHmKI6eTJCbCMkAdfRBCIXtC/lKg47QgAO9nmncSt+9yFL7fYZH/YZtyWQU0rr9d89rxvnt2lvy/y0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/N/MJ56S1fnpHEgN1nCGri6z4G1mdQ8ebj9+/aTCb4=;
 b=DYIpIRwfzOlxDVaGkbyfPhewKb9kDoaFiXQw+uahB6hMLhmlhv0P5wZAw6d/tdTUX9b3PB91h7XEb6BN4Ta9Oowy0p56Lpd6nEc2bVSjpkI6njTF7oZae+qbmqy+4i76IiLMOSHJNoKO1eo6sPChI2d3bGG1h39M9hDjlBgqKb8=
Received: from MW4PR04CA0172.namprd04.prod.outlook.com (2603:10b6:303:85::27)
 by BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Tue, 19 Nov
 2024 13:23:30 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:303:85:cafe::f4) by MW4PR04CA0172.outlook.office365.com
 (2603:10b6:303:85::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend Transport; Tue,
 19 Nov 2024 13:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.0 via Frontend Transport; Tue, 19 Nov 2024 13:23:29 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 07:23:26 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add mqd support for userq compute queue
Date: Tue, 19 Nov 2024 18:51:13 +0530
Message-ID: <20241119132114.163314-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241119132114.163314-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241119132114.163314-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: f30c1c2f-d0ad-4b4d-843b-08dd089d5bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6aRyWgURBsnxdjPu+ITy4CyLtOrOF0rTc8cL/bAfMFXCO3TFhYpJDcXgXB8l?=
 =?us-ascii?Q?XFKEsDenn5+6eZ9ft3UJ1UFQqWG4z374pY658jJPnJNtRlW4k1x9YHs5RUON?=
 =?us-ascii?Q?xpuMnAE/A1RaFx3XcYkE8ndmm/hk2YysYzca9fS9Vt+S1DX1AjQcp6G6nq84?=
 =?us-ascii?Q?mnjVsH2diQqU8AEBPyKHHlYsvwaIKOj1/8U5oNlHuibec9433VChsZIE+m36?=
 =?us-ascii?Q?+uKlt/ismjzZPP1utNJBpzKzl+2PvNs39RqPITIS5Bg6jKKlM3o4GBr4JkoE?=
 =?us-ascii?Q?0uEmmVp4G4vEqa71ClthZ/0WCQ9N9fEH8ukiuknw5hDyF/mX8ZUFZh6FVn9u?=
 =?us-ascii?Q?pJNKt29czk7vR0iLVceBvR2dYay6tHTrv2+dxCFKRTrpxhItDoIY4rE8+yWj?=
 =?us-ascii?Q?TTYvG4VHSrBLNrIxCo7feCYeBLc0jNcUBZpoxmrLZ+Sth65DZeoTcDi/HTEM?=
 =?us-ascii?Q?lGfPNPVOd1OzslY8dqAVSCmVOlOuxVRxPUwrIz8/vFFwdMpG1Cab4fqSqnMJ?=
 =?us-ascii?Q?9oUsv09RTTV+ATBuaA9mR6lyUQAGkoRr2GGFiLCzbMSDVOT5FxtcKfZ+8bIm?=
 =?us-ascii?Q?osxTiSM6PpOzOxnLVHUvPfyBrSIV7cH4zwdVvlxHZCzW8Q0HjYj7FPZ2wzJ5?=
 =?us-ascii?Q?V3Crf6ohbUFXrr5NfbxAKc6kiUqIxf4C6EM1DIwNjPiUP+52S9iqZ2cJDBGG?=
 =?us-ascii?Q?s0sAc0sOiRGDCRmRTJRCUR6/xF/I+lBy+76x7vnwIW7HDZ64mY2NEeYn2lNZ?=
 =?us-ascii?Q?k7Bd0yPkyCmGNnpS3S7RpwiyxQTqeGGyAr76CxVvfJ7t5dx7feXeqdo1mamB?=
 =?us-ascii?Q?S5zlUCIw6aNsFEh65rnCkVkKFRq7Y9G3du86/tGbNDSSaCFgIHPH5vcdW/PZ?=
 =?us-ascii?Q?kHlwwzlRyfZcm9Ce/0STtzWg3TyDQ+7DOrzgZvFlVvbfra5Ws3HIsgBtwLBq?=
 =?us-ascii?Q?gioehX2O1KYu8/CLKs4ppnK24oQGaHhcFMdqsO/WsRzeTsuX0UorVEl5MGkh?=
 =?us-ascii?Q?4qZILgdlYUOGAXNYujSrfm6MYyQO3ygoYTR2kJEweBzS5pT/VRxudADOLAbE?=
 =?us-ascii?Q?Qrlcb0F3I8ulGSWrU55LB+gb0blTAYkH5m+DlKwUsQOQA514TmfFAsPa4Gj8?=
 =?us-ascii?Q?UlWYcB6xcn0RVQXG9STbFjqn3t8sAvgBQA5vsXNDbNpDYgtx3AA30H+/NQsn?=
 =?us-ascii?Q?QAFHdWz9lq82nuiv8JnqgXM8TMp4MoDDCcshzs0s/5mWTiyjHdWwO6/nKLcP?=
 =?us-ascii?Q?uTMLQBqmCKiwgqF7MeZDtxAMCuiaAyBlrxngYEr6wCflkYfM+NZXvGXrCQxs?=
 =?us-ascii?Q?6oaq2CFwEHotO36pX24SKW68YTvVvswgCSHURNO2eE4ehYa16bDbbliW6u50?=
 =?us-ascii?Q?O/RX5agC7IBcLBje23jKul8yZ29do/MIXQ1XQ/q+wTuHM0Mtiw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 13:23:29.6491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f30c1c2f-d0ad-4b4d-843b-08dd089d5bb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
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

Add mqd support for userq compute queue.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c | 13 ++++++++++---
 drivers/gpu/drm/amd/include/v11_structs.h        |  4 ++--
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index fe4efe5ba6ac..3d9be36a9f0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -232,10 +232,17 @@ static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 
 static void mes_v11_0_userq_set_fence_space(struct amdgpu_usermode_queue *queue)
 {
-	struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
+	if (queue->queue_type == AMDGPU_HW_IP_GFX) {
+		struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
+
+		mqd->fenceaddress_lo = lower_32_bits(queue->fence_drv->gpu_addr);
+		mqd->fenceaddress_hi = upper_32_bits(queue->fence_drv->gpu_addr);
+	} else if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
+		struct v11_compute_mqd *mqd = queue->mqd.cpu_ptr;
 
-	mqd->fenceaddress_lo = lower_32_bits(queue->fence_drv->gpu_addr);
-	mqd->fenceaddress_hi = upper_32_bits(queue->fence_drv->gpu_addr);
+		mqd->fenceaddress_lo = lower_32_bits(queue->fence_drv->gpu_addr);
+		mqd->fenceaddress_hi = upper_32_bits(queue->fence_drv->gpu_addr);
+	}
 }
 
 static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/amd/include/v11_structs.h
index 797ce6a1e56e..beef3d203f3c 100644
--- a/drivers/gpu/drm/amd/include/v11_structs.h
+++ b/drivers/gpu/drm/amd/include/v11_structs.h
@@ -1118,8 +1118,8 @@ struct v11_compute_mqd {
 	uint32_t reserved_443; // offset: 443  (0x1BB)
 	uint32_t reserved_444; // offset: 444  (0x1BC)
 	uint32_t reserved_445; // offset: 445  (0x1BD)
-	uint32_t reserved_446; // offset: 446  (0x1BE)
-	uint32_t reserved_447; // offset: 447  (0x1BF)
+	uint32_t fenceaddress_lo; // offset: 446  (0x1BE)
+	uint32_t fenceaddress_hi; // offset: 447  (0x1BF)
 	uint32_t gws_0_val; // offset: 448  (0x1C0)
 	uint32_t gws_1_val; // offset: 449  (0x1C1)
 	uint32_t gws_2_val; // offset: 450  (0x1C2)
-- 
2.25.1

