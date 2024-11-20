Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97683D44171
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 09:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4931B10E6D6;
	Wed, 20 Nov 2024 09:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bRtj+fWf";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B954A10E6D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 09:26:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6lqwMvw/Sq4nxCldiw7fjW4apCWb3IhDi47R7SKy8wSosb/+UuHifqUnq29aoKmHYUOQaQEwhBMQJect5i3fIMNZZnTwB7Qg1AyIRxIQ5Gxl14AA2OGsn7bRK8xFwYbP80uNGhidGVutltJd6X6wk0MU/Iy3pskdoaxVQZGcclGdGWWLD6cN7Mk3/tEwukEv9gJx9+UXKmo4lMOokXrO7bl/OqylrsnN7sK1f8rxIJ/fSZfweKw77X8jIjYa76dDjyi+TsnGMPrviBErRthQWkGEsjHyv3X2BoWl3Kv5tsQJ9O7DebATaO6H8DMCkuD6zEeLZT30Th5ggp3W/vMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/N/MJ56S1fnpHEgN1nCGri6z4G1mdQ8ebj9+/aTCb4=;
 b=aoLSppj+7GAAV3l5HdZxAJ12q2QCOE6o7HGouB/sn4R2RvuqXNM9UM/ZJiF4MnI6urSKMszikLept0rueZpOysIvAq01rzg2K01lPbUdvGcYZosVmpYFA5rolmaeUOxMbNdfsXmVaG7sm1IhBQ2e6VU/0OZtDSEm8s7mjx8ZmEcrikOXe+utNBm8FrZLZlsPdIuFBcbkF4p52EUE5nHSTnmOut99lwq+ArH/tRNgj0vpYhwrjrhIKl3GSgjmy+68rkZrT1c5KUcp1gIVSwbK3uAjF5Hin3C5qZrOoVwBG1J5zL5bbFdS+njaXy5+MOqfCV/cQNd/sShdDZluiTQVxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/N/MJ56S1fnpHEgN1nCGri6z4G1mdQ8ebj9+/aTCb4=;
 b=bRtj+fWf7L0SuKKNZcrYeeSR5DbjqGmsVOeCOAd66yy8OLuQFSPdIrugGccQRGCdmOBIFEbQ7JXx6+k5fKCorNI2YxN59PjYQ+hRTx3ShkEs8TfRAwYBN+WTvzQQR53sx+d/HMWWEHEZNrF+q3AkyMnNeuM+2domLct5B9/4SWY=
Received: from MW4P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::27)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 09:26:30 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::3e) by MW4P220CA0022.outlook.office365.com
 (2603:10b6:303:115::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Wed, 20 Nov 2024 09:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 09:26:29 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Nov 2024 03:26:26 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add mqd support for userq compute queue
Date: Wed, 20 Nov 2024 14:56:10 +0530
Message-ID: <20241120092611.177202-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241120092611.177202-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241120092611.177202-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: cc56fa4e-6c30-48e2-416d-08dd09456a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pPl4IvtVRPIdYqPoWZ1E9sR7eJ2vHJPprT1BGxGi+m3vagOtCTGY/Nnrsads?=
 =?us-ascii?Q?JmuKRqLh6q7xU6+W64g3ghfYmueTQOFJoMbqKpEhH0XPXCHrt9G8wJwajEjt?=
 =?us-ascii?Q?WYtRiVbIbFzZAzkFcZDr5jjLm9nOTPL7KqJQHOzxRn63Nk+3n2LB9qNiqUGM?=
 =?us-ascii?Q?j1ZF9Men4KEaEAMSsilSTEF4y9U/b2WNkV7FJT1Ry3yFaPOXCtW+Z0JBcXQw?=
 =?us-ascii?Q?wAYJCGtqcgH2x6MUj4noUzvPORm4obRNSeqDBgSnAE65jirHdNlSzNhNQRo1?=
 =?us-ascii?Q?GJRQWcgCV4wuzMvxazwNfUyqQezw9wo3QKF3CUa8DyFmlcDndgjS/DaZ7i8d?=
 =?us-ascii?Q?F7F5wPLeK0M6a4LRAfRb39VAY78UMLdOuuauykKudFMPiKKYK+8sXjJkegi0?=
 =?us-ascii?Q?xXgrOS6Fp+64mQi8zlHj8jtlZV7dSGYuIj/jSE4aVWCbi+U+/FjaGs84zemS?=
 =?us-ascii?Q?W4GZgjR56bV2CxbsVemnGMoRqF3AVqabG1OKc7dWZ79li5zqDAuqq+Ow+23+?=
 =?us-ascii?Q?AIS7vBOFmE+WMAIs/FsWlof+ir8uM0nzSLgLoid280Vel719clfUDDfx+Rjo?=
 =?us-ascii?Q?XD/vJN1Ga63/WHsBr0FCR6ZBra/+RC9m3q6E/QrzcetoVEZe9Y2Np8kzosQk?=
 =?us-ascii?Q?Uou55L7Lgp6XnlwLs24vgE+W8cxtDqCkv/OTXb1DbkdefsERkS1gV2RHj0FQ?=
 =?us-ascii?Q?WYaYkPVpW9MaO7tsv7AYJdGfdzcoCwpI0Xh/7Z8c6dz7MRtPttiE3rluMwot?=
 =?us-ascii?Q?wmRrvdvUZINE7BZBdAVue7AdUgx9YUtEqOGAG+txRqIklNeoieLamLK8BrX1?=
 =?us-ascii?Q?4iE2F7u95SXrUToHkF5J5SjX0DbRI7QFiZqC3I20sp8wiTbm+Q7Bf7wAJ2az?=
 =?us-ascii?Q?wqooUX2dny75uZZ2HAFVmjw+/+R8SWbSBki7PiOjd78K6no/2ysdbstVJtaf?=
 =?us-ascii?Q?BU2/QvSy0pMQgknwuWjmH8C5qP1s2cTnd9oOJy5ldhq/TPtDa8ExaEi4XMsg?=
 =?us-ascii?Q?sL1v8Gm6FMsXu18JqGlMDn67WdHMZWKvds7WI5pLegDgFHQYmJTpm9x9kK5m?=
 =?us-ascii?Q?JSNcp9TkMxwxZrNeJUldv/OoxtP2qhs6NvHFsVlwbdLObWB/T+9l6yS/P+PH?=
 =?us-ascii?Q?BEwInf0Iw2EOw8j1Vvqz73bSDw5p7xO+Ln9cFOMmnJQ1B3nEwPFiA2GQx0Ku?=
 =?us-ascii?Q?kHhBkV+8X7xfK4vhOjCmeTebLCRKbHLIJmnWtJvFBWlfT6/ynbHF/QGB+1sK?=
 =?us-ascii?Q?Vodbh1AswprwPtge993PubabcB0TRDPVoB1TPUxbB6hAvWgXJ1IHqfrT+rfS?=
 =?us-ascii?Q?wgf3Q8mdhR7nIDiCJxP+puPcbR1zqMWvekTYdhzp/Mndd7iAKZ0RbFjf//qP?=
 =?us-ascii?Q?qEvBh5zeZ64LRCY6rIwyjg7s8YZR8iLU/kIax5ao+V199LlaUw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 09:26:29.3413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc56fa4e-6c30-48e2-416d-08dd09456a2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326
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

