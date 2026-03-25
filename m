Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25276FEA834
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 08:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B28DB10E7DE;
	Wed, 25 Mar 2026 08:44:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5pyp0+lq";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6199910E7DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 08:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DD6jHufXPvVXvKN6dhe1CAdIqXK8vyNtOzvIbbYLCHoIECOP2i1X2FOk7SfdIf5l/sXbVS8cmZjT2oiJBKp65OOXB1Id4uoZFi1bOA8YAnn543HF8l39NrIw77kwz4K1tYemASTrp+dPhGCq2Uges9wxJvc02vpvDvl+1j+50Q3AerlQqtqY87JHsCc6ytaaHX1rxAefolIF/9Tf8KHAecnoHkUiE3VfBblJQPnFQl8/j3rdGhPm0zetedhXrpk7u9ShncSgchmZQCz+ZjJ+vfIRnR809wiGW3bnvn77tdjHfuIDDm+9dtnr33rYvhR0Cd2wc7QzPtBAbFK8iQ4PYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcogZ/o2hIb5JYB1wSSWAC889ZeNeTX3LHJmledmdRQ=;
 b=aYEPmsA+i+zduujiLMLyHa4w5Jb6mvpI3am521XRlptXHQOvtawzQa1TE6Pq0BR5yAIdB1/LqTO+l/EXUxoeRcqHDNwpcdywhWcXW4ksA8rNmGkKEU8RoJuW9hQ0xgza/A4wroEwxiCRpmNyDI+jBnSxJdhemWYBmsMBsnZpcAGq3TuIVEH+Y5DRBpEpSjSznGbdyLgJoKKvIweYU1jqVw5201CX+ccOo13GVtoOLQyaBoWC3GFLjbUonR8CUaX9fSkUkBHwy0IiVHfghBH9TySDX+0yvaPXY/Od1naVCRIQJEKupHDhy8NlYih7jCHRWA+eQKh9IBd/Hfie2dlyQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcogZ/o2hIb5JYB1wSSWAC889ZeNeTX3LHJmledmdRQ=;
 b=5pyp0+lqaolzj2IT58cc1R1mVG9Erhyfz0T/NExi5sdNtbCYlUk7KOT6gMfG5WP3qMhCXE1hVVmLNmw37PItldqU5tWcN9TJnd/CMP9Fx4BkIpx5zIg2BUqHI0/EammFVPhQ9/59Ioz59322JEy2buF7d/8dUu0CShs/cxDaccg=
Received: from CH2PR04CA0001.namprd04.prod.outlook.com (2603:10b6:610:52::11)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 08:44:24 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::f6) by CH2PR04CA0001.outlook.office365.com
 (2603:10b6:610:52::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 08:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 08:44:23 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 03:44:21 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: fix PTs flush race with pending TLB fence in
 vm_fini
Date: Wed, 25 Mar 2026 16:44:13 +0800
Message-ID: <20260325084413.3359504-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a5d287-0942-479e-99f2-08de8a4ab717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 9HGT6+R6zjtMzjPtRwLApsJDdBlo2WFWIPw1OQIIzMTm9/1SXk5WoKVuFWdWIKFDG1gmANhHju4bJsY1LkquV8pfZ6bX/OUhEGupE2OnNEFIwi2nXyn3swlu8GxoevdE99+IkaHTPxwxCOuRA6yctFRpXcjpZEmCTcpkyjVdQoYIGmLWsU61BpbCaZ2ugDOvN5csK5NoEu2PB0cg03E2OpaB86dM0m8fzgGdhE1Cs5gvVa98poMHKe6QJSRnnKgvxrR16DE5qJLjTwvSPV1hqs8qzsYgwIeRVKNDT59+0u8ktH2W8ZgBd/P3rT3q6iOH1jRmv36nOa8QQlD4UdvNkM4QUZHvFP2o4Qu+mwHE29RKMTkCsP/yL8rd6QCYafDLm+25zaskNoEwj1PN+rtFW/lM2+aM/vwylVbeFRbQL0aDT/kV4qX+UeJmExu4k3To0H5lSqvn8dF+3zi/bYmJN192b/ccwisM5bbBhXegI/PxPygEQ48SVeBkSOCZKqK8blg0Z/AdyJo+VFHueWfy1DYx79ZS36qqnwWGpqSV4de4xI9/gwzBsRPqcCVy4uiDzrN8t5Wv/tyXcyK7eXDcunFHoVFODhytUSzYFP64Aivi/dguvtVxJKZwgMMe0p5mE8/rL1HV953qUZTNIt42yZ1Jq4dKVCOD2eaMqREKkatRgCnt71jIkvyAacr7gG1DxEoMm3VKBj86OSL6bmlW5nw4ueCV1ARnNPmlqQuMyAHQDoN2C2Q2huSqRoLvvv9zKXH3/cRd2eooGmi3QRbRUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4bYsPznob5zi0gYMm3rakn1slB68KKyNZhEj+Fw/NsilhrZsjGOBsSpzVo+CzbpGQiSzUJipIaH/WNozjYvaT07+GdurtwMEHfucTFL5KuDuj/zaHscWjCbdesVEdhZcSA9EU1JvWk9EYyKcgk/gblsof8pDfyhpkInUxyhBbvwyS4cUNFacAaNNVl0KKia21Q8OKbbshPxvToTNzQ9zZtYL3wKJYLjXE9dbbMPu2U85IwXVcL6ZJ6bfLBLB7ALSIX+qI7yrWHGSuRVn8RgSJA+rDO/oOFQrPK8kfcHQ82w1Yc36oPhZjxUuJL5mggWGN+QYoc/UcsdKQSm66wE9U9ajGvSvdIVJmhnqTfFNIx7x/x6dZ4TbMnjctiTF6EhKNlgUmDg+ZDhrHP31A4xwm8kYCQMmY4nf2+WAfA/HflKHLtnRl0uOXdPtWzVgdrSx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 08:44:23.6641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a5d287-0942-479e-99f2-08de8a4ab717
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441
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

amdgpu_vm_fini() relies on vm->last_tlb_flush to wait for TLB activity
to complete before calling amdgpu_vm_pt_free_root(). Because
vm->last_tlb_flush tracks only the vm commit fence and never the TLB
fence itself, so fini() may proceed to free page tables while the TLB fence
work item is still running amdgpu_gmc_flush_gpu_tlb_pasid().

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 937a6dd3a4b5..53d0ac8bf98f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1093,6 +1093,13 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	if (!params->unlocked && vm->need_tlb_fence) {
 		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
 
+		/*
+		 * Update last_tlb_flush to the TLB fence so that
+		 * amdgpu_vm_fini() waits for the actual TLB flush to
+		 * complete, not just its commit fence.
+		 */
+		dma_fence_put(vm->last_tlb_flush);
+		vm->last_tlb_flush = dma_fence_get(*fence);
 		/* Makes sure no PD/PT is freed before the flush */
 		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
 				   DMA_RESV_USAGE_BOOKKEEP);
-- 
2.34.1

