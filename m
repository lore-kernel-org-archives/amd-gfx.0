Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1C2CEE351
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 20:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D12DC10E533;
	Tue, 18 Nov 2025 20:34:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dDOcOZek";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E44710E533
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 20:34:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F194nACx3EVZ8gWNaClMfojFofKZenDMQMsCLLuBRGKAfyBRIDQ5U1Qr1lg+CeW4Rb+luwGamDfta/j8Jjprg25lBGeIXR9HLPfl/BKiiJtNrhs/JVsJjPfzb/eCFvM5upDx+6mdgB9w2+OCMhl4pkgb69UR2eoGDEE/83h8KDo5qbdexDynTkC6Uybehz4imlODNrIDeVX0vn8I1Lh2dXG5IyEojqTx8qicwo5l+BhH9l7nWE/P7U8rNBcm7uA6i2+cxet5cFoX9Xv2aFciCw9wy9JVMT2d0mCR6/Q73/l4SaeSWndlKnMFa6dCA52v6+okYqlvMJP/h1/iwNAwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XuVoLPABrxRH6tUflm9dOM8O92bEAmTJyugRB5Toro=;
 b=ugeWc2T89SdZnIZzrxkWbGuuFxJxr7N3ORvY3AFxGwv0HvBkX9Uh0ykcg06t9nZ0TMn2P0dngOqHLGt4fi1dReWZsSt3XHGWxGGgCI4YsFPgakypDGz+z+l52ycPfmJg7rDKfN/SQzaCxgwK7527AXeRE8dWF4m9Zy5k6TJ5MuSwWJuyf/oA7JhydJi+3cSamRJIknm5ypRokRvXGaIdsOk8MSOfVSDV29t/ch6fGJSliRjA1zGpbbJT0+5bRMffbMLzc8k8SMzpQAeoencZMDAJfVDuvfuMX4DtRpCz7Abll6Xf+4J2ojJspXCSiGloQLg5AXRa1SZAbZoVxPvfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XuVoLPABrxRH6tUflm9dOM8O92bEAmTJyugRB5Toro=;
 b=dDOcOZek9ptu8p6E19noupPDTsH0HGH1YTpWVZQZ8icf3zpNnj9FYrWLtQ2zSW85YawzyDxeaPb9d/7XdtiVqs94hcRSbtSb1fy00f+x8iLIQ6SsUqsQVxqc793XR5HijFfJKqrbupRBt4MSTJRE8H+COgp0Ce/WHApl7p7Pov8=
Received: from SN7PR04CA0238.namprd04.prod.outlook.com (2603:10b6:806:127::33)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 20:34:32 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::a3) by SN7PR04CA0238.outlook.office365.com
 (2603:10b6:806:127::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Tue,
 18 Nov 2025 20:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 20:34:31 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 18 Nov 2025 12:34:30 -0800
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrew Martin <andrew.martin@amd.com>
Subject: [PATCH v3] drm/amdkfd: FORWARD NULL
Date: Tue, 18 Nov 2025 15:34:19 -0500
Message-ID: <20251118203419.2528796-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 209a1e92-5827-472c-1206-08de26e1e09f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qUSa3lOygB7+JdKQBnT5Czn7QcANaX3AfHydeks/HzZbzBW4YQF9njNI/7Eh?=
 =?us-ascii?Q?qhqD4zCu9yoTF0fmhZWxY8OkDL1kxXk1IwhQGENTR3NH5r0eN8Qm++YZZxWU?=
 =?us-ascii?Q?i/Lf7TnhLlSDFpgAkdF688XNVDvKbtTl+fn6WqgPETqe7NgwnsKNRnZYCKBf?=
 =?us-ascii?Q?JWRMCHRmFPjcTyC+zgkGESFwSCGd9tmtxXdYTBDhjAZgLHQ+BxfOC0T6LDK9?=
 =?us-ascii?Q?ky+Qk+ePAdpPY4qInDeRkXckpfcd0wInk8DZMYeXRwNirqSKqkwuKi4VdZMJ?=
 =?us-ascii?Q?J9gBCuUjmeWiW0DPcw2yW33pHWT3ITL4zzmYIEHqGHmt88VWmUi2O+AHAaSM?=
 =?us-ascii?Q?L6xEuVOjJxL5WoLbvF4Rlxkx7LhTpuBc4tXZcfFh4nfbxxC627FA0V5QXeMl?=
 =?us-ascii?Q?C3D8iu1wXXPj/hz6AMiPagF5AMRHq6D3Mknn4xHEQzyF1yWRntDgYBIeSMhJ?=
 =?us-ascii?Q?T5U5mAYOWSxf8njlyS6pS45DNZfXZxbZloJ+mMg9rr3P0uGLBFTVwF0oYIfe?=
 =?us-ascii?Q?7NtGw3zAJW90Fl1pdAXziqsY0GI0Ii7r752UflIJ2KOqpbvA6zIxpIRfiiJO?=
 =?us-ascii?Q?X1jjvw3vP6oh6O88WJxoBOs1Gcj8e/WUOILT3ipc5qYYhNGNj/DlJQmGJSVY?=
 =?us-ascii?Q?615ZrgXGc+elp+XOCPSuY5ygMd+ok4VY87wWaqIZK992x/GPFOHxhh9VSH6n?=
 =?us-ascii?Q?nzYVhAI9nGOlCu5+mjJBgClwrDBELwf+eKg/QYXvhM8th1CgzL/xVqc4GLrk?=
 =?us-ascii?Q?omtnH+XdNQHRHFZj7YkGdtGUpAtyZG8XM/PtMFC6NDxgD0Khj+RAJNL/DBeG?=
 =?us-ascii?Q?od6LYsOIHAcWXtxD8nhWGsYO6ok2oyZm5sISmnpIB1ps8ONiDiYKrOZBywl/?=
 =?us-ascii?Q?ucXy/ufkEaYfRRDftKidbN8p9B7K4FB8Gh4rpKpci6sNDYTF2QZybSIB7E3m?=
 =?us-ascii?Q?ormtzqkTJTAJGSZ69aSuFAL/vEoOahxiBACBJcSDXwfcxhnN+VpYw3T8od3q?=
 =?us-ascii?Q?4PngxOe0a4sl23RfRf9DtS65Jo20j4yQLim3VZJf9RZXvNjw2wukHyIlldcn?=
 =?us-ascii?Q?TQwrbmk6eBPO7ymW5Ro2pJpNKuw69nLx99+PYAcyWWfMHDFtXam38i9hOChS?=
 =?us-ascii?Q?dnZyMS/k1cKMPTpJBe2DSMGoeOloTMgPyhIgcs1YFvPMbepzup0I3m2zq/W2?=
 =?us-ascii?Q?nUx5dSUu3nAXxZfYfaF76NMldDS2DMSTb7QUY2ORMbx2i6Skm3Q6aDn01pWF?=
 =?us-ascii?Q?BNpa8C1GaELPrPSBQLjXNHq9TB5K6E0w9Y4RXnGYNdWi4im8846J8geFw4cZ?=
 =?us-ascii?Q?qJ+a+e+ZjlnfAs8ZRaEbpSNqZoILzGUE1A+PKPfyGgBwp0RLq100KJBMozjb?=
 =?us-ascii?Q?qyy4QbwLXoZc2PpqGT5wkDwHNfbClcrpDfnJSsN0aTCs/Az054X17roTWCyX?=
 =?us-ascii?Q?EAfwQ4Wq5mmXt90aqWs5f87CoixmEpnHZv9Z2TTqNRfKGJ0+gghaGk3fxoKC?=
 =?us-ascii?Q?H1IfnOBqFtLQtF8syqQCQ2HMhDuLCK8UitYY+Y5r6g89iOOdBL4Ct8ouXCOE?=
 =?us-ascii?Q?aWFrkIShiTKXxajiqeo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 20:34:31.0609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 209a1e92-5827-472c-1206-08de26e1e09f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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

This patch fixes issues when the code moves forward with a potential
NULL pointer, without checking.

Signed-off-by: Andrew Martin <andrew.martin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c            | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c           | 7 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 3 ---
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 1ef758ac5076..73c5749d4243 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -105,7 +105,7 @@ static const char *amdkfd_fence_get_timeline_name(struct dma_fence *f)
 {
 	struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
 
-	return fence->timeline_name;
+	return fence ? fence->timeline_name : NULL;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 4a7180b46b71..c086a9ed8c89 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2357,6 +2357,8 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	if (kdev->kfd->hive_id) {
 		for (nid = 0; nid < proximity_domain; ++nid) {
 			peer_dev = kfd_topology_device_by_proximity_domain_no_lock(nid);
+			if (!peer_dev)
+				continue;
 			if (!peer_dev->gpu)
 				continue;
 			if (peer_dev->gpu->kfd->hive_id != kdev->kfd->hive_id)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index ba99e0f258ae..11af0c1cddcd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -517,7 +517,10 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_topology_device *topo_dev =
-				kfd_topology_device_by_id(target->pdds[i]->dev->id);
+			kfd_topology_device_by_id(target->pdds[i]->dev->id);
+		if (!topo_dev)
+			return -EINVAL;
+
 		uint32_t caps = topo_dev->node_props.capability;
 
 		if (!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
@@ -1071,6 +1074,8 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
 	for (i = 0; i < tmp_num_devices; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
 		struct kfd_topology_device *topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+		if (!topo_dev)
+			return -EINVAL;
 
 		device_info.gpu_id = pdd->dev->id;
 		device_info.exception_status = pdd->exception_status;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index f5d173f1ca3b..888b1c24c2a6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1685,9 +1685,6 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	struct kfd_node *dev;
 	int ret;
 
-	if (!drm_file)
-		return -EINVAL;
-
 	if (pdd->drm_priv)
 		return -EBUSY;
 
-- 
2.43.0

