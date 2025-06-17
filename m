Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03E7C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 08:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9364910E514;
	Tue, 17 Jun 2025 08:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rt54G9Ra";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4B710E534
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 08:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QARGIg0d47pPgcmipOVE9mqbLO3qkxTC6jx+BGfAwY71IiEjs3f7aIsfu/3BVPpiJD2XSSPvsTRxxh3CciQ8ybHOo4DVoTXKs2mLlGrzIQM+ag2h2W7RKSHV2UKRXcOIgm8NKVuLER72T5Ux7djYi2VvLhzUymisDR/7u3/kh3ArXu0Lxw472jkF+zzd3GQ4VZ743QLK7km7T7IWPmI5Uf7vWJMhDPAP4gSRuWgqI7Ll+EfJ95F3RWBw2zeYnWLYEkexYsLj3e+5zX1zwIsWUF/UtxocSUanIALPWGwAh6PipqZxiuzTSR63kt5nljSesNF3+69u+cNsGg5NE076yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vtOBNkcA7hO8J12Fjmg4yrc12hxLWYlLnuXrj2dWNU=;
 b=n4uvlPfDH3jrBn7lFHW+nJ2WWpq4cWCHNCTS/WI8CzfQ7aJC4iunTAUVcH5jbh07/tD5MoygXWnKIfG8LdrnZJvcA9Rv7QUpjGiOoM2TkNW0fIRYXDyhuWnB23Y/TMKPZTdZOR/nTY7axH2MyP2nWWTSKiJjzVhI/BHyc1SmZbaKVi2oeATIVgQ7r38iTz0PhXjzDIJAw/O7DgdaDLxRuKB+VEjuEcubMukmhe1kHDNNPp7psvAxjOA7+9ODzV5dzex4JPtZ7tT+ua+C3/WLfZwuvoy+zwkKlVpeGy+RYtUXKL/W06C7QK80kbp2MSLicJkmD0wDG6rdnVaoFV+fjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vtOBNkcA7hO8J12Fjmg4yrc12hxLWYlLnuXrj2dWNU=;
 b=Rt54G9RaqJvjLdcRE2jTJ1p30wUPMSRwg8RuBNQT1Qi9Lzt8lEzhVHiAzBw9chmNqllGlupEulojro5REWXf1aRGB7lLAT5J84m8UJ+YivwltHcHpdus8A79AichdJYWVBeuBEyLELb2u3aB1MLJRzYNQiCkGGPRWUzabpkm+NI=
Received: from SJ0PR03CA0181.namprd03.prod.outlook.com (2603:10b6:a03:2ef::6)
 by LV8PR12MB9690.namprd12.prod.outlook.com (2603:10b6:408:296::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 08:02:18 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::ac) by SJ0PR03CA0181.outlook.office365.com
 (2603:10b6:a03:2ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Tue,
 17 Jun 2025 08:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 08:02:18 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 03:02:15 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 04/11] drm/amdgpu: validate userq buffer virtual address
 and size
Date: Tue, 17 Jun 2025 16:01:44 +0800
Message-ID: <20250617080151.1093481-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617080151.1093481-1-Prike.Liang@amd.com>
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|LV8PR12MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa80271-cddb-4bd5-f059-08ddad7547ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3hR4ZMuTjT0lsK6PPJ4K55xeyhuc7/Iokcq6xy+28Qvlo4TJ6fBvbiTeOEsn?=
 =?us-ascii?Q?cfZ4Mf+WBPsr19gS9bhICs+BY17iEwcINhpyxHuoWvJoTWmz0VtQmyXIr2mM?=
 =?us-ascii?Q?DYFX7N4yxSBiC1pMcf0TMxoeZaRJ3ld8pZGvtvfM7030lhw8tx8A9nqSDEhY?=
 =?us-ascii?Q?Rtfe7ZUTGXUu9HBgCK63FyvgYgavNiQWK/jFmOSLUa1CszkIRhSl9gIkOfVw?=
 =?us-ascii?Q?pdNsiHsbE7tlbrWqAET2OWdmZSEMyNaOL33y1UIOAtTkJCuALORAYKrz/0vm?=
 =?us-ascii?Q?izwpYH4B4cPSH2s+Z2Pt0kYu9A93xSekKaTaU4GBYsicNWoxLkI6xXl/KkiL?=
 =?us-ascii?Q?rV0Gsd8TyQITNkmfvCAQ4hecZbFhlimzSbbF1gJPyOivCqAHoBYTvjlthVuO?=
 =?us-ascii?Q?M0QV3PxK44QKnVzYzblpoByXZdiWu+1VRdbEVd9hAS7hF94wJquO4mjOgvdv?=
 =?us-ascii?Q?wrRIaNTlu/wVmei2MpR7sljVoi+Cd3eojyrqSmXn8IWnCihb0jH8JQj95NMq?=
 =?us-ascii?Q?qPVnScxCf9ePUApLdSH6VjfzbqrTZ8g2QcidJmMo6G6m+i9XvodtD6ZZj8V5?=
 =?us-ascii?Q?5RblLS7SaVkv+pJWaDy8OCODHEfep/YrPCabaQ2LaJaTGgTAKny4EfruaVrF?=
 =?us-ascii?Q?forKFpE6jQ52ERbe2c6yfv2WRcjBDv/wTWiqqlLmk41T8n0kqF/HmSt/HHZQ?=
 =?us-ascii?Q?DDQwjyczFPoF1DW6zXf3i0saHrJsLg02+Ga44vMRP6Z/0RZoePx/lvg/J4W8?=
 =?us-ascii?Q?GV9rDqSTF0wbYXbK9pMeyDiujkQS0ED5b3vp1dBFdrLzaoCO4ego7/y30TC9?=
 =?us-ascii?Q?73CXtbXZWUhmLxNPSHi2q8OdxHiVtVtf02FtK7siJOh+rjQPcz7m6KvTVZFd?=
 =?us-ascii?Q?yQKe91frU9/HELCJNizScvLJX9ndWH0C+f+RFKZJ38E6e41H3oYXW0eKic81?=
 =?us-ascii?Q?P7lE+IdgwvRZBpQ20iiCPSQ8yt15c5qq4b029o9GCyIuI7YNecML7VMS0SLl?=
 =?us-ascii?Q?MMhFP+/soLQfds2uQVRwYlIl/Vuj2YkCCXbPu2mQarTZwqScy/d5I2PhDoUV?=
 =?us-ascii?Q?/vJpggBfndZv3+QjEapWsQzkj6OuZ8lxQ1jMbY2V3IjiZfFWzcM32SD4Dosh?=
 =?us-ascii?Q?SYdC7+2/KdLoKie9m3zvIfDr73t2K4jeQoVrgeB7dDsdtO46ARrkiq9u38/H?=
 =?us-ascii?Q?WUPbzTVKOWB9HwRdeZo7CWmtdFWDAOD49hKEeZPfM+3tomB/0FJjU+ijTF76?=
 =?us-ascii?Q?advakXKZDt3EzsBVTW3+V4KOei1LCsYpP+5mKgJIIB0cye5mWiT3wXTNJxnH?=
 =?us-ascii?Q?zz9HyxqoERgOzmBKXOJi1lHavovQsgYuBKS2Zk2nxh6T1QUR3Z2ts5DEXyj0?=
 =?us-ascii?Q?6H+LGGbAe5AV0TgYXGPBPXMrQO8a3acVj0mFN8JzgdSugRcuEn0Ak4RxxIxC?=
 =?us-ascii?Q?KNDcOjaLz45/IHGNoIYrA6hzby0B54dMFtords9PDWdGNck8Ja2asgiRRs15?=
 =?us-ascii?Q?L+Je1jWYv+x22UoXZqpVzL2+1QWDOQOkXNib?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 08:02:18.4620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa80271-cddb-4bd5-f059-08ddad7547ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9690
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

It needs to validate the userq object virtual address whether
it is validated in vm mapping.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 50 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 24 +++++++++++
 3 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index dca0f76c9fce..db47e90b8c83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -31,6 +31,8 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
 
+#define amdgpu_userq_va_align(va) (va & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT
+
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
 	int i;
@@ -44,6 +46,36 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
+int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+				u64 expected_size)
+{
+	struct amdgpu_bo_va_mapping *va_map;
+	u64 user_addr;
+	u64 size;
+	int r;
+
+	user_addr = amdgpu_userq_va_align(addr);
+	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!va_map)
+		goto out_err;
+	/* Only validate the userq whether residen in the VM mapping range */
+	if (user_addr >=  va_map->start &&
+			(size != 0 && user_addr + size - 1 <= va_map->last)) {
+		amdgpu_bo_unreserve(vm->root.bo);
+		return 0;
+	}
+
+out_err:
+	amdgpu_bo_unreserve(vm->root.bo);
+	return -EINVAL;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -391,6 +423,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = -EINVAL;
 		goto unlock;
 	}
+	/* Validate the userq virtual address.*/
+	if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, args->in.queue_size) ||
+			amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, PAGE_SIZE) ||
+			amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, PAGE_SIZE)) {
+		drm_file_err(uq_mgr->file, "Usermode queue input virt address is invalid\n");
+		r = -EINVAL;
+		goto unlock;
+	}
 
 	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
 	if (!queue) {
@@ -501,11 +541,17 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 		}
 
 		if (args->in.queue_va == AMDGPU_BO_INVALID_OFFSET ||
-				args->in.queue_size == 0) {
+				args->in.queue_size == 0 ||
+				!access_ok(u64_to_user_ptr(args->in.queue_va & AMDGPU_GMC_HOLE_MASK),
+					args->in.queue_size)) {
 			drm_file_err(filp, "invalidate userq queue va or size\n");
 			return -EINVAL;
 		}
-		if (!args->in.wptr_va || !args->in.rptr_va) {
+		if (!args->in.wptr_va || !args->in.rptr_va ||
+			!access_ok(u64_to_user_ptr(args->in.wptr_va & AMDGPU_GMC_HOLE_MASK),
+						sizeof(uint64_t)) ||
+			!access_ok(u64_to_user_ptr(args->in.rptr_va & AMDGPU_GMC_HOLE_MASK),
+						sizeof(uint64_t))) {
 			drm_file_err(filp, "invalidate userq queue rptr or wptr\n");
 			return -EINVAL;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..704935ca0c36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -132,4 +132,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
 
+int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+			u64 expected_size);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index c6f7b613e684..6ba051bd3682 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -28,6 +28,8 @@
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
+#define MQD_SHADOW_BASE_SIZE      73728
+#define MQD_FWWORKAREA_SIZE       484
 
 static int
 mes_userq_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
@@ -254,6 +256,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
+		if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
+					max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE))) {
+			drm_file_err(uq_mgr->file, "EOP VA is invalid\n");
+			r = -EINVAL;
+			goto free_mqd;
+		}
+
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
 		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
 		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
@@ -281,6 +290,14 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->csa_addr = mqd_gfx_v11->csa_va;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+
+		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
+					MQD_SHADOW_BASE_SIZE)) {
+			drm_file_err(uq_mgr->file, "shadow VA is invalid\n");
+			r = -EINVAL;
+			goto free_mqd;
+		}
+
 		kfree(mqd_gfx_v11);
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
 		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
@@ -298,6 +315,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
+		if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11->csa_va,
+					MQD_FWWORKAREA_SIZE)) {
+			drm_file_err(uq_mgr->file, "CSA VA is invalid\n");
+			r = -EINVAL;
+			goto free_mqd;
+		}
+
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
 		kfree(mqd_sdma_v11);
 	}
-- 
2.34.1

