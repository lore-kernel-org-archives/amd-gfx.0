Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF65ACD128A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 08:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B6E910EF53;
	Thu, 11 Apr 2024 08:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KU1YU81o";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5837810EF53
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 08:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOp457euNayFFlX4bWd96oXKh1U1H5fzqoBINqP+uQUIHYTwgSvXp4D6f1xFCtHDWY+0Y820zWgBlTUuEtX+8Nkxj+t+mxqO96EotVQbGc5uNdX6gfapIPrAKmV2gXHvQn6Vba2PgQ5ygCnogMn7EXQjwMLui4hwNBtB4AQQy0K18ZvW0HZrBQqz9f7H45juinxuJAjIhwOqLnEVzCJ3wotg5Q1KOrnwwtJMZaOWxjFC+1dxGFVeWzdXaDhOhWOjyrvcsUrJVz4wLnpNzqb9g0+XOzt2ajMPT78haJQRNJ09Pyy3DyTV6X5cKlmVi3ftzgMREtzr19cseCP7QFDq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IKbod0cjNUSKLd5h6FMVnhtfH0ttokWt7YCFDhG0pE=;
 b=FAti/nsPonqzBZqdRrNAXwWnE0sNFybsEOwIgoUW4gptwMuQQwa6ZKX1WI/CzKykr8hR43vz5HykT2jo7o8sDtKt0VgfA5HqWWdoaZEFkIkYb53f28RIwfpZ0A92SAk5fab0urbQoiRyl/k8mOt0AAgtFW1ILqsToj4N4iDg/ObLXGCrB3vwhsYvWFFS90g0c747Q596wI4eCEUZ401kCV7jb9mk8ddz6R/Q3ckEvomk4MaVkiYNkhfwmIvWYlyub8hSgLUpx7vbQhToSEYHlIN7dMs27bvZWCZ5eoXBbXVXfktqt8H4DWt2RBrvAFeJwWf8pgSnbTDQLkpW2Bz6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IKbod0cjNUSKLd5h6FMVnhtfH0ttokWt7YCFDhG0pE=;
 b=KU1YU81oEseFMJdy5EGzooZVYWx3c4QW7rgOGctdfitG1udJ+WngJIijecDuaKt//KiUrp+x6Q7MU+9zs/gKq0N7yMBrL0qy3VyiclIpZcD/n54GUMNCWWEcyZ0eSzVgpba2KwNuupUKHqtSPxZMnZr9wGsuTT2xzBvJGahKWi0=
Received: from BN0PR07CA0016.namprd07.prod.outlook.com (2603:10b6:408:141::21)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 08:11:16 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::4c) by BN0PR07CA0016.outlook.office365.com
 (2603:10b6:408:141::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.22 via Frontend
 Transport; Thu, 11 Apr 2024 08:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 11 Apr 2024 08:11:15 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 11 Apr
 2024 03:11:14 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Christian Koenig <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, Lang Yu <Lang.Yu@amd.com>
Subject: [PATCH v2] drm/amdkfd: make sure VM is ready for updating operations
Date: Thu, 11 Apr 2024 16:11:01 +0800
Message-ID: <20240411081101.3883715-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9166f7-f701-4ea4-555a-08dc59fef5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSzNw2w8mftLYN7eXn32Ab2wPPQ5oCA87oc0agggzVJollA+9ozHa7g/KJVE2n6EUIyaleE7P3PvNML0DpQg+WzrzreMskUIEzHaBnniEcMLWYcA34d5Ke1WrrwknmZBKP6m82xbhifL8ilP+bbzXv2zFmXhmF6aj7vbDpcjFz2lg047Q2bSITwoAvgfbhBzDMyEqFOhpp2txSHR69kUC4nP05rPivbn2l17kd9EjLgYSIOxJQvgOGNjzT4bxX6rykBNOOzjVuIgDuQjAMvr1G25MBWSGetL2Fgg+/gBg9tlNmxI/jCHgMRvUfAp7cUCSKY77jCHT+2cdZ7gMDM6/jKXJHABC70cif0XK+gLz9ByxC0ruvp5xzarWPxwl2SN2964it9p/ZVeprAlF6I0ODDf94Uz/CdjjK6akBJvqMYh6rav88A9arfJ1AUN15Kdj6N+zFCdzS3Fclj4QamsQTMaji+sh5CQJAIldqHEctddI1gFL9wt9M9FeYVSfRz3pgW3Xqg43ggfCfABCq2FAEK1MLk3kKXwu3klbG3nh5Itm/BbmPDcdMca3eXcwYcbIy6hWNRW5xKoNMAh78O33VrBxeM4BIHpP8Mm/YG9JJcGD3OOtk2HCbmcFqsNA11BtiscGodb/mRlZW7vJo5QaD8faXQmocV3XgfToXEHjG0fO71kHJ/l/feqWqUUWbMfANOCMjYL8wFnCQ4xreVzSscCecH1jHLV0+SDy104Ntekx5gP9/z/bk8wwCq2dS7Y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 08:11:15.7445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9166f7-f701-4ea4-555a-08dc59fef5aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953
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

When page table BOs were evicted but not validated before
updating page tables, VM is still in evicting state,
amdgpu_vm_update_range returns -EBUSY and
restore_process_worker runs into a dead loop.

v2: Split the BO validation and page table update into
two separate loops in amdgpu_amdkfd_restore_process_bos. (Felix)
  1.Validate BOs
  2.Validate VM (and DMABuf attachments)
  3.Update page tables for the BOs validated above

Fixes: 2fdba514ad5a ("drm/amdgpu: Auto-validate DMABuf imports in compute VMs")

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 34 +++++++++++--------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0ae9fd844623..e2c9e6ddb1d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2900,13 +2900,12 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 
 	amdgpu_sync_create(&sync_obj);
 
-	/* Validate BOs and map them to GPUVM (update VM page tables). */
+	/* Validate BOs managed by KFD */
 	list_for_each_entry(mem, &process_info->kfd_bo_list,
 			    validate_list) {
 
 		struct amdgpu_bo *bo = mem->bo;
 		uint32_t domain = mem->domain;
-		struct kfd_mem_attachment *attachment;
 		struct dma_resv_iter cursor;
 		struct dma_fence *fence;
 
@@ -2931,6 +2930,25 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 				goto validate_map_fail;
 			}
 		}
+	}
+
+	if (failed_size)
+		pr_debug("0x%lx/0x%lx in system\n", failed_size, total_size);
+
+	/* Validate PDs, PTs and evicted DMABuf imports last. Otherwise BO
+	 * validations above would invalidate DMABuf imports again.
+	 */
+	ret = process_validate_vms(process_info, &exec.ticket);
+	if (ret) {
+		pr_debug("Validating VMs failed, ret: %d\n", ret);
+		goto validate_map_fail;
+	}
+
+	/* Update mappings managed by KFD. */
+	list_for_each_entry(mem, &process_info->kfd_bo_list,
+			    validate_list) {
+		struct kfd_mem_attachment *attachment;
+
 		list_for_each_entry(attachment, &mem->attachments, list) {
 			if (!attachment->is_mapped)
 				continue;
@@ -2947,18 +2965,6 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 		}
 	}
 
-	if (failed_size)
-		pr_debug("0x%lx/0x%lx in system\n", failed_size, total_size);
-
-	/* Validate PDs, PTs and evicted DMABuf imports last. Otherwise BO
-	 * validations above would invalidate DMABuf imports again.
-	 */
-	ret = process_validate_vms(process_info, &exec.ticket);
-	if (ret) {
-		pr_debug("Validating VMs failed, ret: %d\n", ret);
-		goto validate_map_fail;
-	}
-
 	/* Update mappings not managed by KFD */
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			vm_list_node) {
-- 
2.25.1

