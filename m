Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF39C5DF81
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA4D10E86B;
	Mon, 24 Aug 2026 22:14:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cIBVdmLj";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9621C10E86B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOH0w4X6ZgYy3/NVUpDOlT98De3nHs8HMqnsAspAcIWRuRMPHQI0LjkXnDQKAOItsXJxxgd8bBsmiZ+bxQRDCPbFgsNc0qvFMg2B+ptpaZ0edgSJwEXJG5xsSVHUhB77KA07JZX6J1w+Cde0XrDNGjWVYdRRAzMN0wIul3MVftNr8bZW/thvGwRJ/ot7YUB1PxPGCBuEoaDdZpXwUSgJKTAjEvVWAEIfoDaF6rkImwUHKXm9wmWCWx9STcxUZ3HheDJ6rt2LH1xu2dk/wzHmt+4vUeuGJUffeW6N026WhJzHJJrJE17Y9wP78f6RNP6U26K+wXa3batqtuWrfXUnPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1ChD12/AnHn9mw4BtrXoKaJhie0yfD/EH6kYkFbsw8=;
 b=nAR/8HS7h75OF6doSXuXw2HxuTBa75chnNsUKkUYjwgAn8YZP5EZ67DRAiXyIADmMfAVy0JweoBeF32GhAgz05B5c1SbLLDoybgJxyNQuYue/3rBT+lHTI5dcT61kSa3DGVIpLuc+0Pel+c//YessD11nJVzQtjXtUDqBUuq/X4p2fkhKjo4U9WoW0qCJFLQeSwcG0H4IWZx9aj54JaxMFQet+1bJlrfnvKpoqO1WhHRniRTvmWBdoB8cwvEXF3DAJHKbdEfVoXSjDxZdzW6udcKflIxW9EJO1lfx5qOAdH9DucdO9MOAfd6Z1EZoqahkxpaV4vv3C5Qk1IKKHdQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1ChD12/AnHn9mw4BtrXoKaJhie0yfD/EH6kYkFbsw8=;
 b=cIBVdmLjEikGV2jCbuuvosRYhC97anLSEhCAcTDVLD2fCXM2bZcFxerHXCkKBt+xsHG/IFlegNvq2S8YOI4CKlVssTo3CK/DIfZ1VCUwWssMHiQBJ9e92G0oxYUd0j+jVOIg13nv3JPPzQTrPWpwrm0G6OTILOkAQhxygtJ4e9w=
Received: from MN2PR16CA0037.namprd16.prod.outlook.com (2603:10b6:208:234::6)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:16 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::7) by MN2PR16CA0037.outlook.office365.com
 (2603:10b6:208:234::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/30] drm/amdgpu: simplify amdgpu_gmc_flush_gpu_tlb()
Date: Mon, 24 Aug 2026 18:13:37 -0400
Message-ID: <20260824221352.1793542-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 9453cd63-43a9-46f1-7317-08df022d092e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|11063799006|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: WQqyN35QQ5WdwzYj7CSUEIehDIjjqdxXulyKwlBJVi2MRqYHeeK+jp1WPpSiw0gxakPsRIWOQ5inxG9HTPlRZxH64QKNHBaN+uUoP1IAQB2E9iPH1pOM9uerXp16TGEQrX82ovxq0woqNkwqk49RcmOeP7ZIb8u2tmK1G68wDlvK6DOoKZw/Bp7BbW8QqDjo7uHILdPx4GfG0XvW38yMC+30XqHOyya8WbirVmBfZkwWnqWa0NR2WDlTK9q/yrB9MFDPWQRAdB583ZdOvvRzA526aHvQczAA23FUvM2E8zZl3yI/luSl0M3boN3FvVNwmhmfCWEwV1OzVTVGIQGTwpvANuGwL7585hYSGol3n7jDUuC1X6Zo/664dMh6zKJmqexw5JitbMtr2NHvN/XDNevW3ImM8MJ7khIiMRZtWkz1+cpdznXUUrH2sDygr3ltZIAWWZtsPXZs01NxlvHdVgqJcfhPo48g34YIKkmIaMnaT+bhJTG8UcyzxFWRHEFTR5yCsiamZelNxI/pz2eleVWi+2TNbTSjsK0PNX5rA1eIxbRc/890P7g6XspiMQGsDxx4uwGvRhEgP9EvnpQhOWTxIC1C/674namol8yAnf2K4kKc/dJzYXW5DuESIgKPZjOMwbhJNoyrShhmy70Oho9LQShexjV3vNvwTQlbZ4BlqMfsocKL1XWy5cco/JSp3LroFYq1dWuY6FZsa6eVlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HYMGwUchpaL1tXAsC9Ytc2EyenosV34iFmCb1qIR+DoQjNBWxDa8rOQQv3SLbFmgXqmpEgVYVlsJeVqo4L+PSQv6lHy6Oyyq3Mu/4KEuo50w9WuwFqfTM9bwuv0JhNgC0PlxFh8ZKiF6GiPivfE/Z63GrVn4NLmqIYOS2rEQh1hrIz9DOBTVzM08Mmj+8ErABEw5/GFDaP+lFuZH+YQudhgAdTmx741+ratdA7pvhJyLuwD4ch/vsl4WGGuKHGlhPtfJ1RyN2swrv9otklaeA+TM9ydupaWsdSnVXdIjLxoLztyaMXNx9Wy3rgFU+Oi7xWVKse9fU4lwdzFP1TmKvWT1ew1AISz0gzr/LG4x4PjKVhQirSCP0kXFaQWceFnupbL5gGSePyHH5HPxdmCRsOCUZXZl9dC4p6IuXMglkc53R6P4mMKjtLBBdCW5tMgJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:16.0281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9453cd63-43a9-46f1-7317-08df022d092e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040
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

It's only used for GART TLB flushes so rename it and
remove additional parameters that are never used.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 16 ++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  4 ++--
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index c4c21dbbbdbf8..0db997c8fa03a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -502,7 +502,7 @@ void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
 		up_read(&adev->reset_domain->sem);
 	}
 	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
-		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
+		amdgpu_gmc_flush_gpu_tlb_gart(adev, i);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 2f6d20c00ce29..6af4ed2170b06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -714,8 +714,8 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 	return 0;
 }
 
-void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
-			      uint32_t vmhub, uint32_t flush_type)
+void amdgpu_gmc_flush_gpu_tlb_gart(struct amdgpu_device *adev,
+				   uint32_t vmhub)
 {
 	struct amdgpu_ring *ring;
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
@@ -725,7 +725,7 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
 
-	if (!hub->sdma_invalidation_workaround || vmid ||
+	if (!hub->sdma_invalidation_workaround ||
 	    !adev->mman.buffer_funcs_enabled || !adev->ib_pool_ready ||
 	    !ring->sched.ready) {
 		/*
@@ -736,15 +736,11 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 			return;
 
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
-			adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid,
+			adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0,
 							   vmhub, 2);
 
-		if (adev->gmc.flush_tlb_needs_extra_type_0 && flush_type == 2)
-			adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid,
-							   vmhub, 0);
-
-		adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, vmhub,
-						   flush_type);
+		adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0, vmhub,
+						   0);
 		up_read(&adev->reset_domain->sem);
 		return;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index f8f4df37d5805..23954e3180a8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -441,8 +441,8 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
 				  bool write_fault);
 int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
-void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
-			      uint32_t vmhub, uint32_t flush_type);
+void amdgpu_gmc_flush_gpu_tlb_gart(struct amdgpu_device *adev,
+				   uint32_t vmhub);
 int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 				   uint32_t flush_type, bool all_hub,
 				   uint32_t inst);
-- 
2.55.0

