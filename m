Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E7BC982D0
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 10:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EEC310E6B1;
	Thu, 17 Sep 2026 10:04:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gx4VvHyh";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B5110E6B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 10:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCdTivDtYkoRyCPIfPhujc9UDWcRwpYu6mmKrSv/horVY6bGTt/86vIHIG3cv44wyNuZNHESPqc0385o2WIDyy9bMglYrcs96teYCWVv5YuLseqqGplQj5uq9fKvXew1FuyLnd9RCSDehEM2sEhb/bMw0Ok61/WR61BVAFKJxBWNy14zQIYMsb7u86kxsrL8Xm9cp0UZgkSgSEcRdfDIOKTeeLxnscdBW/k72KwCuXx//Scb6p+oZf15E8J/2I9JkY5IJeVcRMxsfCR97UBvZ9GuveJ2uIl6h6pZhUiCnaug+TMN/HEadPrFudNdbbr/Xdugab0w26Yi0eQc5VmelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQIy0bmv+xY00/NhFhBEwNmCCcIWjrIsWYzY/0dZkbI=;
 b=wl5JWA8W6S+OR/C/Ijbi3uZSwIBS9ep39Q1oXpMtANOMunXVLgel6KWaIOXbOLV5zttGXzJ+ggQpd5oxcyoxsUi+Os6jlY0yXQmm4QjdeF/08Xg/OyFZZyLYEytk1C4Mtx2LrtN6xXf7z/rDF8X7yFx12L4QDg9tmpZAjKuVjwxSFOsbD21S+RK+mMyZ04kgXK/lgwBT72cNPpb16HErG56c3Iz3Uuwif8qEHDwmoq/oLzMaUvfbjjvOsnyhaAY2P4nzgc8aBGxVl7GHhkvH9xG3vdGsy1QX3ImVsOHtFkRYxXnArPi9/U2cJgyK/n36wmR4nK5A2CeVkmgbFoTFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQIy0bmv+xY00/NhFhBEwNmCCcIWjrIsWYzY/0dZkbI=;
 b=gx4VvHyhf7MlFsTNBaxiwWmOrDO5gOi1zIVIU9k3t7E2c2G5M7DwSiBPXWYbJZGZlEPJ+eCwsPl/qDI9ljgM9CGQ8faunAJPqMq7qeVNv7UGS8wnQe7Bvw9GcNgcYtQYP56QSTJpqgj+T4Y1qzb8seFqNopDcM9mOzw+kejhptM=
Received: from BN0PR04CA0101.namprd04.prod.outlook.com (2603:10b6:408:ec::16)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 10:04:34 +0000
Received: from BN2PEPF0000A98F.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::4) by BN0PR04CA0101.outlook.office365.com
 (2603:10b6:408:ec::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 10:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A98F.mail.protection.outlook.com (10.167.248.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 10:04:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 05:04:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 05:04:32 -0500
Received: from jenkins-5800x.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 05:04:31 -0500
From: Horatio Zhang <hongkun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Le.Ma@amd.com>, Horatio Zhang
 <hongkun.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: skip the PASID TLB fence for the UALink NPA VM
Date: Thu, 17 Sep 2026 18:04:30 +0800
Message-ID: <20260917100430.217954-1-hongkun.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A98F:EE_|IA1PR12MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 77569d0c-303e-4414-277a-08df14a3128c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: jJiJmCZTLmVWgHDx8l3IajZH1cC0MAnjAsTAZOSDL15jEG49EwkRv5yZfNNOajP07+1wlRsiHguEhHINO4JktllaPKEP94q46fbfHfiAxqM9Pn2N2MYcLnYmuhLOVKUwGopnabieNycW/U2nda4UAo9WIKsoQmmUCp4PIk3fxAgvvLjUI8uCRXbqnGqzjJ3VQakFJxsiTrnJgP+Liyy5z19mPfD3EtN0el+aF2TxxcfMp2l7xwzOl4Mtf6cPeCcgPBq92mwQvbx9zoC8wEgzYBjwLD1wfGxgmlJ66g5LEcmnUkaxYKpFkYs2lEb0ibo8KF4TuOM3fhuP57yAzuhbq/RG8tR1k2cJL4P2OLQ+p7BVYLUce2u1G/4HzdZVZDTK3mPGGZjOVZ1MmKacy4D2GiZrF+RYUCK8bS7bU92pu3pN17QzHgEiMKcsg89FOGOZYKfsGF+uBI+DxwlzNtTxGeRIO9nYqQ4HZWbaJfu0NeRqrT215FQ72WfrV2Y1MnTpTiJuBsSI6EO0rNPHhPEX6R3HVvGO6Bz6VApEgqHTtYyfX/ygjwnM7C81ACNWAh4BLmPrA1vo/y73uGhUs/j65vFdWJrMDbV1MbtYyxENi5jCbPE3+Ryzxib/jD0Q3TS2KLfY36tT4qMVZqDwygo6+kxkyBTQAHupKoOWPLsyqpYN70DN/V7VvzEMs6vOZIY3RYlE6PXcEf9nSI1j2AKWjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hsqv5vVFfzw9SQppa6KkWnrzPa/huaFyNyz+3EtGRQmaOb45ivvFFuwTnnqfBslD/936Pj7HoBpe8htKF2TMy78VxA47SUG9d92sy6gmdRIeV3sofz6USqoVbf0uDABFwRparCSItGNCWuginmPqGK1ze7ZJI9rBOGh3H+ObciMbji0iTSyz6yOR14jOIf/3Pz5I4z2aAE3sC6ArmkydQk2lbqgG41l/8XOlE15bFZwE4AoZkZOXsSppVEa2vqtZtQUo1tTgBu2IDqKk5qAyBie7yhL3qVc0X0N5qOH+tX91cW0Nvua/5azjtRnS5g+igC3Cq56OqANTvCsO30VNs86OPz6fy+ardURhMHk1+EjMT+yvSQxF1tztlPQZ/VHCCTS5PkjohVKp7+n3GAG2/pay7EBlXjsKl5c6eVsrfitf5LxpwytknzuR4XmW3cl1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:04:33.2874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77569d0c-303e-4414-277a-08df14a3128c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A98F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531
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

amdgpu_vm_make_npa() builds the UALink NPA VM on top of
amdgpu_vm_make_compute(), which unconditionally sets need_tlb_fence.
That flag makes amdgpu_vm_tlb_flush() queue an asynchronous PASID based
TLB invalidation after every page table update.

The NPA VM is created by the driver itself in
amdgpu_ualink_manager_start() and never gets a PASID assigned, so
vm->pasid stays 0, which MES cannot resolve on the MMHUB. The invalidation
never completes and MES stays unresponsive for the rest of the probe:

  amdgpu: MES(0, 0) failed to respond to msg=INVALIDATE_TLBS

The invalidation is not needed in the first place. An NPA VM is bound to
the reserved NPA VMID and amdgpu_ualink_flush_tlb() already invalidates
that VMID on the MMHUB after every mapping change. Clear need_tlb_fence
for NPA VMs.

Fixes: aac13f6eded6 ("drm/amdgpu: Pin page tables in NPA VMs")
Signed-off-by: Horatio Zhang <hongkun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 68d668dfe4f8..e255b5100362 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2793,6 +2793,7 @@ int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		return r;
 
 	vm->is_npa = true;
+	vm->need_tlb_fence = false;
 
 	return 0;
 }
-- 
2.43.0

