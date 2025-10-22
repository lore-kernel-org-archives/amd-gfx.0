Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974FCCCD1BC
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D7510E6E6;
	Wed, 22 Oct 2025 07:31:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4rAq2kOE";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012056.outbound.protection.outlook.com
 [40.93.195.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E616E10E6E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vu4vWfpPwiTsg5U5XDpRvfDDlMGcIczKiUOmDS2OagMJHbwBjkeoF/0+/IrXaoTz/RixEbQwJMbz/3JADyFGrjJsbFf/CqBRUlJB7aOiemXDCdpaRkpaSISiyQREoXvEs1338Q5zv6bHDncoOTtApot0I520uuF9DGbNxHQkUYNyZ9DI/QEBdKTjeg5xfJFil5KmspdHrTU8cGgxRRZkkqy6aWoRB7+TQTYB3SpmsXmTLxNjtC2MegRFVSM0q8Wmxy0z6pfuIpQxX3osWvDgAdJ7xX2OnK/RAj4FwOA8hLA1nTBnSF13cqDGt0D0ExvNRe9UoBGJPmIint44dhNVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpuOT87mGRJkr3LUk+Pf0bO90r3kzEP/FFchV6JhHhQ=;
 b=P9610GuteWmnfSKCmstqZFVR/CyrnRuRjRne8rQLfjghuxpH4/CFIzfP4VmNsQ6GmgkMx0MLU/433C843rbGf4FzGdlZK1xIYofuhBk1l8/MOc447hjCT/wd3l23WlRtUIhx/rC9R9XvXcZBQbLSFPAmqoDXdy3Wzk+2GjVqM3BQhVOp4Hg+tE1ktQksc1KtqCNWs8+Nv9yEycheJxx3EF4pO6Tagh5vY23GIpMAjWBEk2RVp5wxSBSQ2ImzBFGWGIjglu1yveBPM6EsDUwKHQaApmMLnbNwxbU2OIYPFoQdJ5RLuC0cmDwv2EAgCOdVNRnKTkHYi3z7QHNiBpVuPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpuOT87mGRJkr3LUk+Pf0bO90r3kzEP/FFchV6JhHhQ=;
 b=4rAq2kOEioLdCaeDk57tFFbI5J7GrGs+KUyyldvyi2OBYBjeU0FUliPr1wTu4GUdlxhagTEqJC47zA30TUgxX9DGHNfbl1hjr04doz1MkDpvox24xrJTa/JLLvI5zBObV56wpdLMBcfIdgOycL+FcG1TnExkYBfG6kvQUD5O8rE=
Received: from SJ0PR05CA0107.namprd05.prod.outlook.com (2603:10b6:a03:334::22)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:31:38 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::8c) by SJ0PR05CA0107.outlook.office365.com
 (2603:10b6:a03:334::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.9 via Frontend Transport; Wed,
 22 Oct 2025 07:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:37 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:35 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 16/18] amdkfd: fence handler evict and restore a kfd
 process by its context id
Date: Wed, 22 Oct 2025 15:30:41 +0800
Message-ID: <20251022073043.13009-17-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022073043.13009-1-lingshan.zhu@amd.com>
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|MW4PR12MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 992343fd-ca68-484b-bb31-08de113d092b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?58Ul2tNDvx7Wqp9fFV3ciKM0+Ubicx/HRR4lZgl4Z59GroT4JGdpg80ySS2r?=
 =?us-ascii?Q?YOPVBTjHqHqMieI+PpDPvVxN3d1Fn67lWbJTEQpANAAPalqDDsIWcs5KiDmx?=
 =?us-ascii?Q?CfUntatz1IfVssTR8glN5yBTuXDZjsOhpnoygQJ7yvUhf2pVK60XlSNadtDT?=
 =?us-ascii?Q?OHWWFSr4sG3X+2s7/wKgfHbz9iiVIOtQUdNX3WW41uKHp6lJzfcgg4kCJMFG?=
 =?us-ascii?Q?0TP6W3OchXKsBQzRIw3/Z3Ph4hgR7Ph7mRL+YvZ2w4h27Ksk5blxa9jN68c1?=
 =?us-ascii?Q?Svbb6UY0QvOp1RNuaWBSFBka60Ewt5nvaFX9EtI/hk3EoTQy9boYGpRNz989?=
 =?us-ascii?Q?XEWeopODWNTTkSUZDjSbOO2w1Iy/S4d2crdmu41pdZpQOfLlMIYPm1153TI4?=
 =?us-ascii?Q?HAYAzUnC9Y1tbcIOKBwmP9Mzx3qEB3EdDWndouUb8F7daNYaVaWPSsc5OQUS?=
 =?us-ascii?Q?BapRk/oPsNfV7+5KIy8YxN0CwULLugNGJYMoZR3eo2WPo61bjKzAQWgFcMC3?=
 =?us-ascii?Q?SAEoA2D6RRZVF0zR4AshZbuiKPHf6XztKU0x/xN/0tNJLQdG9Gr9NkrVrVcY?=
 =?us-ascii?Q?vAz1jaM9KFXm7u3lnJ2GMmXpOA3eaJv1iU+Nxz2AK91pIM76LPjNaVtefxvB?=
 =?us-ascii?Q?EJ+1BGp78WVJMkxsZEaSPghyxYl+7wiYZVvQPkGw2wlZwSr0flbI25LWaI+D?=
 =?us-ascii?Q?W/SZ3hRolvz1B74QtU6WguBoh+7ksAkqgZe6VpqLWt3wyPNrbkTI8T9QJhZb?=
 =?us-ascii?Q?LJwmR92fH+BrrmaKjHrO50yysOeJWFfJck/gnjQt88Rk9RxYR0aHTKCtE06Y?=
 =?us-ascii?Q?8mIF7rn1ZG7/EKlU7nb9x5N2pXQjiSHorxyTue6wRJmILI9AqP1jvnjIG+XR?=
 =?us-ascii?Q?j1ZaQqoFcuIWrX4wVQnpA6orVZODEX7T9X86w8C10o5m3pfaTE7A6VgQytN8?=
 =?us-ascii?Q?S0AUcknePqYx9uGfwSsxmZzgZsnQ5CW8TzuUK8DvXAqnwa1TMxVr75/zgBye?=
 =?us-ascii?Q?4p/YnosD4dC6u8HEmchFrN9y7yJltchb+0BOTuoLnSNKNwfSzqF9YysAyMo3?=
 =?us-ascii?Q?Rr5Gui0exszZDIAqDpM+2d6QP34mqLrA3pm8wk0efwWaf7h9YZvdc0lc31TV?=
 =?us-ascii?Q?qOxnKOBDRpOaixGdCtF9ROpEpk8jij3KMt3E/qgLrqQxfB+25X3TTzKXkHcN?=
 =?us-ascii?Q?hQA2cdzD2Q3wPebmU0rBHHUrqooXbpmsEVKq9EJNx4xjJFJW8U++nNVZ5sWL?=
 =?us-ascii?Q?Hz7bCtctxQ8aVWdKn26qbhJ6GoBgynD6U9ZhVx3ZMsz1uKpNafzpyyLUwKcZ?=
 =?us-ascii?Q?yJ9JY6lezo2v2WUBHbf+RlNxeWnHlEP2r/jLcuHQcPez6QGJnWg2s5cRe2JP?=
 =?us-ascii?Q?EroIkQNV4oorbYgTccyLGGI9CdK4SG3qUywCaeOR2anhe2mb/iXcgfOr+LBz?=
 =?us-ascii?Q?GLe71MXJ4zM+dFSV9udMIGLSfqHq9YpKoyanZ14bLRcLxPAFzY0KfZUvRvCS?=
 =?us-ascii?Q?GbJRNADZImHiB83HZpMXlQpaxLyCbS+/zsqZxIgFXmchxrtmgNQK6AcFCD1v?=
 =?us-ascii?Q?THrUYWITRQ0vuxQIFJw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:37.6383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 992343fd-ca68-484b-bb31-08de113d092b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827
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

In fence enable signaling handler, kfd evicts
and restores the corresponding kfd_process,
this commit helps find the kfd_process by
both its mm and context id.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 6 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c          | 7 ++++---
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 087e8fe2c077..321cbf9a1528 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -411,7 +411,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 int kgd2kfd_quiesce_mm(struct mm_struct *mm, uint32_t trigger);
 int kgd2kfd_resume_mm(struct mm_struct *mm);
 int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
-						struct dma_fence *fence);
+					       u16 context_id, struct dma_fence *fence);
 #if IS_ENABLED(CONFIG_HSA_AMD)
 int kgd2kfd_init(void);
 void kgd2kfd_exit(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 4119d0a9235e..193ed8becab8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -128,8 +128,12 @@ static bool amdkfd_fence_enable_signaling(struct dma_fence *f)
 	if (dma_fence_is_signaled(f))
 		return true;
 
+	/* if fence->svm_bo is NULL, means this fence is created through
+	 * init_kfd_vm() or amdgpu_amdkfd_gpuvm_restore_process_bos().
+	 * Therefore, this fence is amdgpu_amdkfd_fence->eviction_fence.
+	 */
 	if (!fence->svm_bo) {
-		if (!kgd2kfd_schedule_evict_and_restore_process(fence->mm, f))
+		if (!kgd2kfd_schedule_evict_and_restore_process(fence->mm, fence->context_id, f))
 			return true;
 	} else {
 		if (!svm_range_schedule_evict_svm_bo(fence))
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e9cfb80bd436..0b9a3c198c14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1202,12 +1202,13 @@ int kgd2kfd_resume_mm(struct mm_struct *mm)
  *   prepare for safe eviction of KFD BOs that belong to the specified
  *   process.
  *
- * @mm: mm_struct that identifies the specified KFD process
+ * @mm: mm_struct that identifies a group of KFD processes
+ * @context_id: an id that identifies a specific KFD context in the above kfd process group
  * @fence: eviction fence attached to KFD process BOs
  *
  */
 int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
-					       struct dma_fence *fence)
+					       u16 context_id, struct dma_fence *fence)
 {
 	struct kfd_process *p;
 	unsigned long active_time;
@@ -1219,7 +1220,7 @@ int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
 	if (dma_fence_is_signaled(fence))
 		return 0;
 
-	p = kfd_lookup_process_by_mm(mm);
+	p = kfd_lookup_process_by_id(mm, context_id);
 	if (!p)
 		return -ENODEV;
 
-- 
2.51.0

