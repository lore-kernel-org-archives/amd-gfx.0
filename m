Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F3DD111A6
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 21:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C79510E6B8;
	Wed, 26 Nov 2025 21:27:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CRNEUwRo";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6732510E6D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 21:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7l/Pqm31seevgaaLu7ELu7NLiolsHnlXUpyReWFqd2MofGcgei/Kg079FUUcQXsEe4fVzbV/qddKy+kRpKdn2EfXNbem0T594FTcTcQFwmjct4aAzLe2XRQQQYQzbmlQzoz/IpAqisxD8JIknAFLn2mEd8MtKTIHCMD1LbB7FdpEzj++ZD/txTyFYixuQY/B5S6advTY+f4Lfb1Qy1sSIzk3Cku3c7ZoVf31nXXmXMdoalDjfPmt83vGu4L5Oh+MFA4aJ1wofaTQjioP7V5os4MeoHLfto6mqpHD6hRID/4H0d7fZ1XbepH58IbtmgdyFtwS7c8RhvhNSZyccL+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0MC9mzJI2LcFKrOOD4SceoYA+Of5Fb1z8d/zEAHThU=;
 b=K6VjbwG1PrMsIxaIWIIdW9BwrkedU4ac1+7Xrf6gxjiZrrU7e4TgKz5gqGwbuR5vejSoTZYM69rZE4+pgCUAVKRSokH/Opmf82cw4HYNEZ4K1X8BsLs+ptC5uCe661mWVaoVgR34njLAybyRK4efTOEAx/W7CUu/G6+1uNbrfurbxs5pPGYrPTs//DGETTcFratU2u8qcwBNoK4jFxyTRBB5QA539J9TNbXH2PzM2ooJ0scaMPKPhpQjCx37m4F0Xla+v40vuP37q50fa1B81glOZLAVtdv47phduUMHwgBpQkckVcgu9fPdTib+dJenCooSMpRSWh474cYKd742ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0MC9mzJI2LcFKrOOD4SceoYA+Of5Fb1z8d/zEAHThU=;
 b=CRNEUwRo6tIK6vZjHkCkTCCgrgm4yOhLBiwCYKQkkAGMrs2ypN6rcQr8ixJ97WKcDOjRpvWf4vTkixjUXr+3K5+rBbwtS/JXmKzZZJ7HS7nFRRFdMu9sK6k8KCQ3lVpyminZp9kOCJ7xg/yPMX/ZQJ9ivxEE5PoUGuxW8QU7byk=
Received: from DS2PEPF00004559.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::512) by DS5PPFDB3A23D1A.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::663) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 21:27:39 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:f:fc00::207) by DS2PEPF00004559.outlook.office365.com
 (2603:10b6:f:fc00::512) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.4 via Frontend Transport; Wed,
 26 Nov 2025 21:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 21:27:39 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 15:27:37 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 2/4] drm/amdkfd: Add domain parameter to alloc kernel BO
Date: Wed, 26 Nov 2025 16:26:30 -0500
Message-ID: <20251126212632.1522315-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126212632.1522315-1-Philip.Yang@amd.com>
References: <20251126212632.1522315-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DS5PPFDB3A23D1A:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ae8aa9-c46c-4d7f-2f13-08de2d32a05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VXhgl5H7kLf0aW8AdDAGL9UwWeD+Wp7l3FAKoy45JHLHMmPfM5/b7Gm5u5Dz?=
 =?us-ascii?Q?RpDt2F6RMan2Js+I3Pwpdc0Ce+Sr8dE6MnF9V1G+P9WtbNYPL3vEaiKyLNUM?=
 =?us-ascii?Q?JTKAY8lxoi7nvB40kBkWovdV24kJrzWUhQw9Bxv/OxK0NsFBybkoNBB9RVBV?=
 =?us-ascii?Q?cpszXIYbC75QL3C94hLmOb7u1KMIS4EtR2B4KrW0q5+I8nCiLPtUD4dlHKdH?=
 =?us-ascii?Q?AsH1HYvvMDd+3bXIwVWey9x/y4rFikCjpFlWzDVfinNvapM+JakEX+MqBUWU?=
 =?us-ascii?Q?a+jvwbEBDUc0n4ONxR44vkCo9tJKSvXWpHT0KmMZsydQANfN6lKM5UfYr3v5?=
 =?us-ascii?Q?1r5CilMqIM6AW9/1SAFJioM2iyj1qHGoxi5Stl0yFZVSMFc+Y/kBuyt+PKHG?=
 =?us-ascii?Q?gZ9ceNNGrDcQvGCF9ndF5z4Jc5B9ORL8Rp+BUXMuzQ7oEHOCHrGa3HQQRPeo?=
 =?us-ascii?Q?kBXDj3BdEUJqVoSOzeRVtq2UimyNwseEDW9rxDBzjF2KSqJ9Psl/3aCGQ2de?=
 =?us-ascii?Q?Mqbhs17NEM2wHtNBdO2ECIgrMRbC4kgS7uIYIL/UhvXf9J5nvzT3eIGz8xLu?=
 =?us-ascii?Q?PjOVtobzEAyRB2SSY3UWhu2xteEnxl5TszOr0Jt4ceO8lMdwN/gNEydRuIsg?=
 =?us-ascii?Q?VnGtV6fWk5d8sjVuQ0UuJG7HKRxKu1rGDXxnyeOmcJ0LU1h79IziXrnP021h?=
 =?us-ascii?Q?NkAdtACSoXbbjF/TCifucE6nZMj20YPidKpYJ362mQvwLWpHLEdP1kWJMyLO?=
 =?us-ascii?Q?tS4xhaPhBjHQtRIN6LIrEKbGy4dRJd4y5KNwVaZ60pzLkoirxV77iCEoPBiu?=
 =?us-ascii?Q?9pZU+iMCd77N9xiYhLQUiq9iaQ/II9hhIoDXEJNUAvI83WW6EczE+ZIwSdCg?=
 =?us-ascii?Q?S9Hfbju481rPEvg9QNqFgH01nQvIVyJ+R8DcjTuCMPIJz+dmx0K7BMaziwQw?=
 =?us-ascii?Q?8L9wGaecuFeu3cKa11GVHAH2wKI1V78aTl+MwMiRxxMZ/Q6VBqX31jzaL5jY?=
 =?us-ascii?Q?Z1uRoxwn+uiSnXggQoQXbUH0EK6FH1pWPo9PkuYROBLGfFOhuv7gN/GjubkZ?=
 =?us-ascii?Q?onqrdmFpHqFThrONuBRenEVdjF8ILUingntXfh/ffGBOKB0tc63vfw/F/d2J?=
 =?us-ascii?Q?LwK03gdnFjSHQpm4OQ3Uo1IML2aPQaz7uFYawPjpWQuGXG5abJVmV9VbRydL?=
 =?us-ascii?Q?bIFNWrYJTenNb9zP9flC/0CakSL34SsdHayZHCCWW7DNM7BGfIixI5TNYA8E?=
 =?us-ascii?Q?J9dukSTbo7IRNjSf7rF2TzBy0pYqgS7l+TdjR+1msPT+RbxmBPBXmaWQbqF7?=
 =?us-ascii?Q?0UPrhLaDsBOzLLcxBiecaT+Lz9GQSgu5PAu3MNgl2PDLiv0EnqjQO+5ZrGDa?=
 =?us-ascii?Q?00Kl+ha1F853Ltxz9SmjKyqVefVPlwWaQcR98+N+ySR+OYYlIgxwrx1PZNR/?=
 =?us-ascii?Q?HSKEoig0WV+xUMuNb3b/Oo/oYa29TskIPcBlhngAqCQue7rafusc7CtAjog7?=
 =?us-ascii?Q?1g2Mk2fHacq5GLpRf0rts5ijeNeE/iDsDbBuHnsrJAUmWdRATPPRmh2xCfEu?=
 =?us-ascii?Q?+ZoPUvJy5r8YhPZtmoI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 21:27:39.4339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ae8aa9-c46c-4d7f-2f13-08de2d32a05b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDB3A23D1A
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

To allocate kernel BO from VRAM domain for MQD in the following patch.
No functional change because kernel BO allocate all from GTT domain.

amdgpu_amdkfd_alloc_gtt_mem has many duplicate code as
function amdgpu_bo_create_kernel, with one extra flag MQD_GFX9
to bind MQD and control stack in GART with different mtype,
the duplicate code could be removed in future.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c             | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h             | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c                 | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 ++
 7 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index a2879d2b7c8e..9cd1660b8f60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -317,7 +317,7 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
 }
 
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
-				void **mem_obj, uint64_t *gpu_addr,
+				u32 domain, void **mem_obj, uint64_t *gpu_addr,
 				void **cpu_ptr, bool cp_mqd_gfx9)
 {
 	struct amdgpu_bo *bo = NULL;
@@ -328,7 +328,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 	memset(&bp, 0, sizeof(bp));
 	bp.size = size;
 	bp.byte_align = PAGE_SIZE;
-	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+	bp.domain = domain;
 	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
@@ -351,7 +351,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 		goto allocate_mem_reserve_bo_failed;
 	}
 
-	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+	r = amdgpu_bo_pin(bo, domain);
 	if (r) {
 		dev_err(adev->dev, "(%d) failed to pin bo for amdkfd\n", r);
 		goto allocate_mem_pin_bo_failed;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 335d733751cb..14b5ab6fa051 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -237,7 +237,7 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
 #endif
 /* Shared API */
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
-				void **mem_obj, uint64_t *gpu_addr,
+				u32 domain, void **mem_obj, uint64_t *gpu_addr,
 				void **cpu_ptr, bool mqd_gfx9);
 void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
 int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index ba9a09b6589a..494a563e072e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -359,6 +359,7 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd, bool sq_trap_en)
 	if (!pdd->proc_ctx_cpu_ptr) {
 		r = amdgpu_amdkfd_alloc_gtt_mem(adev,
 			AMDGPU_MES_PROC_CTX_SIZE,
+			AMDGPU_GEM_DOMAIN_GTT,
 			&pdd->proc_ctx_bo,
 			&pdd->proc_ctx_gpu_addr,
 			&pdd->proc_ctx_cpu_ptr,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9f183d27a0ef..b0cfad750919 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -787,7 +787,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	size += 512 * 1024;
 
 	if (amdgpu_amdkfd_alloc_gtt_mem(
-			kfd->adev, size, &kfd->gtt_mem,
+			kfd->adev, size, AMDGPU_GEM_DOMAIN_GTT,
+			&kfd->gtt_mem,
 			&kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
 			false)) {
 		dev_err(kfd_device, "Could not allocate %d bytes\n", size);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index d701c66179cf..6de341dfdf48 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2908,6 +2908,7 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 		NUM_XCC(dqm->dev->xcc_mask));
 
 	retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
+		AMDGPU_GEM_DOMAIN_GTT,
 		&(mem_obj->gtt_mem), &(mem_obj->gpu_addr),
 		(void *)&(mem_obj->cpu_ptr), false);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 2e9b6bcf2704..a489d43d5f64 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -139,6 +139,7 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
 			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
 			NUM_XCC(node->xcc_mask),
+			AMDGPU_GEM_DOMAIN_GTT,
 			&(mqd_mem_obj->gtt_mem),
 			&(mqd_mem_obj->gpu_addr),
 			(void *)&(mqd_mem_obj->cpu_ptr), true);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index fb1aeeacf02d..eca68d2953ac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -266,6 +266,7 @@ static int init_user_queue(struct process_queue_manager *pqm,
 	if (dev->kfd->shared_resources.enable_mes) {
 		retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
 						AMDGPU_MES_GANG_CTX_SIZE,
+						AMDGPU_GEM_DOMAIN_GTT,
 						&(*q)->gang_ctx_bo,
 						&(*q)->gang_ctx_gpu_addr,
 						&(*q)->gang_ctx_cpu_ptr,
@@ -369,6 +370,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	if (!pdd->proc_ctx_cpu_ptr && dev->kfd->shared_resources.enable_mes) {
 		retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
 						     AMDGPU_MES_PROC_CTX_SIZE,
+						     AMDGPU_GEM_DOMAIN_GTT,
 						     &pdd->proc_ctx_bo,
 						     &pdd->proc_ctx_gpu_addr,
 						     &pdd->proc_ctx_cpu_ptr,
-- 
2.50.1

