Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249A7E77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 16:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C80CC10E8F9;
	Wed,  8 Jan 2025 16:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y5nmFttc";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C3610E8F9
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 16:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B40zf5Clu9mqVW44NLQGs6yXlLj3RMBTTdl8CEecL5pV37qNORD0T8wKaY1/AYC3GZPN2PevCuf5hcbJNc8rRtt8TckLZesAIRoJYkegG5SbNSE1QLFD9XsUC/57eyvaXZZyDxkAeLf4C6gP5hDyQrntoOvy5rSaNqRdNJ4ZTS3Zc5GJCdt8yda5PPnw9gnrIDdEBOg8WiiuGVtsUIEbIXyumehiGDlhlkBqOKGcWxya9DmcDP90v/d7aCuY7najBiD20HYmvz21F34++hRxqaZjK59nkdJ/DaiJZ4DlA8Fvmsp/ogtlnnEe1PCd/W5ERo5MzPOs069p/46ySFClUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHAHtkZnySVGaRG3g00zuDSgQmm/27tYHpKGrmpr2W4=;
 b=T9cEpbIvxIF7kGO7FHLLJRd1iar56DSkRguvitwJmh2z/YpVEosGLAZcCRBN0HYENH18lmR0rJN8SR9NS4IQGBVC89rTP6qLZgE3n4ETHik3NKkRnO2nn2arFmmTmpWZgOtNsXUA5GQqhpwobUJSF6Y3DIUV0LT7CSG/OSMWP1qOPkj88LRX6jK9Odz4t/H+Goepmi7wsWK6v4kfaLi4tUTn5wowXlGtCHy0cjqKYkehRZSp+SnKyIykqNnGGNF87rLB59GuhOUjlk18zFyvU+6/tEJCzhyi8aGcvE6YURF6EdokkF+RXE3xgcI2BPCjkTJC0oJrzIZWCAQirs94tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHAHtkZnySVGaRG3g00zuDSgQmm/27tYHpKGrmpr2W4=;
 b=Y5nmFttc1YZ7uSWq7svqUF0c3Ajtl+kwH3TIdP9GneSJpcKfhgqk7oaVSjyh5VU0bSj7AgoPuvBxhXU6kxigItYTwNU8d0tu47YssLtmgPh/aNzoVVYllMN+GWqqPj8qGxKEqBzKe2KmR7zlEfX8GosKqlBDncb5ALtl/44Q+oM=
Received: from BN9PR03CA0929.namprd03.prod.outlook.com (2603:10b6:408:107::34)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 15:17:55 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:107:cafe::d8) by BN9PR03CA0929.outlook.office365.com
 (2603:10b6:408:107::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Wed,
 8 Jan 2025 15:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.0 via Frontend Transport; Wed, 8 Jan 2025 15:17:54 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 09:17:53 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] Mark debug KFD module params as unsafe
Date: Wed, 8 Jan 2025 10:17:44 -0500
Message-ID: <20250108151744.1495237-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 067b3eeb-a110-4e2f-2907-08dd2ff7a056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l/tpjzA6cSuTcj0rOO+OGQYIo4Q2LXtAQNfvWd+oy84CsQPUUuCZDLtJkqcs?=
 =?us-ascii?Q?4pSQPVG+KO2J4v3t26WlP68NEVZWqZ0bkUsZyayYO5DoXkHd3iEIm/k+E66U?=
 =?us-ascii?Q?Apla7HVNtED1FE3D9O3DZ2FDhSi5d8hlKvPwE7bYh+iJOVsAw2Uvvlf39yoE?=
 =?us-ascii?Q?jsPNGTMMsXwKgq+7TcG0x48YFV0/oBXWGB73fyvOxbb+AAvI+TQlqFhar+Kk?=
 =?us-ascii?Q?5BBhP2RquORNudy6m9/APY19VK02kCgTKyTmCmlnFgmUoUpc4MDE5zZYRbgh?=
 =?us-ascii?Q?xCEG4aPK6aMvQxv/fV4tfmRD9fpp2Uwffzl9vfyHCIHU8ONM7vMfSTizGVe2?=
 =?us-ascii?Q?8SS5wjyjb3EJXdQ4IvgVOZ+0nO1Y/ad61kVXHky5bABMulyitsMXZATQopt4?=
 =?us-ascii?Q?9nv/wKu+MYM9mafZhMCR0nfaajv3HF3NDBD5JQZFnGHOgGbxQJBhMTtlSt34?=
 =?us-ascii?Q?KUMXhKGpYVRdg5TjKxY+EP7UgdDb2efM0hDh5HQrcYb+8WYO5SIbO5kTCLq9?=
 =?us-ascii?Q?XPZRv/xWn0qzviJiTHQ/k8x32w4bxyzhDp4S4zawjDpaahjGJ112hXc/igZs?=
 =?us-ascii?Q?3+Hi9+9zIYemHTXOJygABTiq0nri5uJE5ta4RzlIRRlnHpXyvbMpyaZpbXAb?=
 =?us-ascii?Q?GTGDr7CF4aQMt6WRb9lKwENJwVan9LC7mz2dCwcMUX+fInCyTBru3kgYIXDs?=
 =?us-ascii?Q?BN3HLMx48is6mvLpyOM3xUIXCHntDfgN2KVHv+lVwN7x8ycRe/sqvRaAx5IW?=
 =?us-ascii?Q?yvqjq2FoL0JOzcsds0AwPpewe8NEtpeqoJ1nvEnx7kKss+mQr5EdfS62iA2H?=
 =?us-ascii?Q?I7jmkQyqzYKZZ8wsB6GzhHpjMHrmWEmgI3Bf4ENcIiO8TU57I7SHLqIHIeqi?=
 =?us-ascii?Q?3dGJlGh43jD7vtX0m7qCk49uAQLAHnpPeeHynuKZ3rrpvzVuGJ6Goenuq2/E?=
 =?us-ascii?Q?k87B6/vAz/YlP3A6rsxGqo/H+FbBJIGIiSFIL/14cUang/2AWIKIgfGy+1u1?=
 =?us-ascii?Q?EhS3SrKVnW6VxEkKeuvzUr0RrUqnBtvyjg8T51sl6f02jTV00Nbr3NWNvNfP?=
 =?us-ascii?Q?R+VZRFB2nUDVihgSzcryYnpqkvLh3RxY58nWzI2UQrGz/DEHV5lSi4JYTHJO?=
 =?us-ascii?Q?aDcG/TacPiGsxktQOJMhhgZMLbLAb2hEi79vJ1vXR4/0GEFKfobvXeXHOumP?=
 =?us-ascii?Q?BA+X8lYv6cmrHcHcEG2ZQdhLGYMhVE/kpCj7NygN1UK75KNL5zhqArqxOclK?=
 =?us-ascii?Q?zYnjERhlJEYbL7ZJiSQUstQNfddvEvvfEx72ib/fB0STXr6+9gdDhcVVsirE?=
 =?us-ascii?Q?DRTyg2CID60tdTgTwd2PVS6pI/XqdKdDVYlIdgpHN8pg+jjPrUL6DCV+hZad?=
 =?us-ascii?Q?+UZNSns64YZPMu0czJGbR1U8G2HHRplsoxdTK9teTrv/NAxDcmBPxB/jVB3s?=
 =?us-ascii?Q?L9yfzKD6tWYEgY8uTQysuEJxIBxnRosn8UXgblpxX5vzkfkEHGClPHduLek2?=
 =?us-ascii?Q?jFW6+kiD5p8FPsk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 15:17:54.9232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 067b3eeb-a110-4e2f-2907-08dd2ff7a056
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903
X-OriginatorOrg: amd.com
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

Mark options only meant to be used for debugging as unsafe so that the
kernel is tainted when they are used.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index acb9dc3705ac..1371b56beba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -751,7 +751,7 @@ module_param_named(use_xgmi_p2p, amdgpu_use_xgmi_p2p, int, 0444);
  * assigns queues to HQDs.
  */
 int sched_policy = KFD_SCHED_POLICY_HWS;
-module_param(sched_policy, int, 0444);
+module_param_unsafe(sched_policy, int, 0444);
 MODULE_PARM_DESC(sched_policy,
 	"Scheduling policy (0 = HWS (Default), 1 = HWS without over-subscription, 2 = Non-HWS (Used for debugging only)");
 
@@ -801,7 +801,7 @@ MODULE_PARM_DESC(send_sigterm,
  * Setting 1 enables halt on hang.
  */
 int halt_if_hws_hang;
-module_param(halt_if_hws_hang, int, 0644);
+module_param_unsafe(halt_if_hws_hang, int, 0644);
 MODULE_PARM_DESC(halt_if_hws_hang, "Halt if HWS hang is detected (0 = off (default), 1 = on)");
 
 /**
@@ -810,7 +810,7 @@ MODULE_PARM_DESC(halt_if_hws_hang, "Halt if HWS hang is detected (0 = off (defau
  * check says. Default value: false (rely on MEC2 firmware version check).
  */
 bool hws_gws_support;
-module_param(hws_gws_support, bool, 0444);
+module_param_unsafe(hws_gws_support, bool, 0444);
 MODULE_PARM_DESC(hws_gws_support, "Assume MEC2 FW supports GWS barriers (false = rely on FW version check (Default), true = force supported)");
 
 /**
@@ -843,7 +843,7 @@ MODULE_PARM_DESC(no_system_mem_limit, "disable system memory limit (false = defa
  */
 int amdgpu_no_queue_eviction_on_vm_fault;
 MODULE_PARM_DESC(no_queue_eviction_on_vm_fault, "No queue eviction on VM fault (0 = queue eviction, 1 = no queue eviction)");
-module_param_named(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm_fault, int, 0444);
+module_param_named_unsafe(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm_fault, int, 0444);
 #endif
 
 /**
@@ -851,7 +851,7 @@ module_param_named(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm
  */
 int amdgpu_mtype_local;
 MODULE_PARM_DESC(mtype_local, "MTYPE for local memory (0 = MTYPE_RW (default), 1 = MTYPE_NC, 2 = MTYPE_CC)");
-module_param_named(mtype_local, amdgpu_mtype_local, int, 0444);
+module_param_named_unsafe(mtype_local, amdgpu_mtype_local, int, 0444);
 
 /**
  * DOC: pcie_p2p (bool)
-- 
2.43.0

