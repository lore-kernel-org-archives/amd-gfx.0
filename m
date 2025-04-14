Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E52C369B5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 10:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40B0010E573;
	Mon, 14 Apr 2025 10:48:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aCDB4jCG";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A8EB10E56B
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 10:48:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEEmmnmFOlSv+/ixO0wB1OgcR3jkGiN8C5j5YkQmW1qQnP4ALK3TDp47rrncIBEw4OAmni4mjk4BdG+NwowksnHG2Fi8oIgxa26a+LV8qVYHclG7IndAASatVoU+W9CgA57Vvrwkx7jVPnzR+dQH5MEi/PYhJ3j8SXFNB680UbxV97oLpPrSFgzs2haXXc5ySs+alIcwaBLrMF9LsATJhNfxaR7zBN8WcD3x0Zq98adyzRq08zunCCBNeQIQfNuWgDx+rD0oXZX5P/owZT7PwGGSC3Zy8KVBqjOxYXASGaWw1aPDz2XNbv8/zX1/ArTstWhnAyzEAZU08+kmkdBuYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/P4sFSRiDjdpw6QKS1IdciixSFdCOXoHKEpps7CyCc=;
 b=enpyTa5fkcL1Qt+YaS1ubzHYfPIgHeCvc1Unq4YTQcmlk71L2N1qTIPx9GpK9vacs5TisYb6CgoFSgFZ8jNWN+keoJcdktdPzya0brdnFKgMCrhhJhDmQtz5I+IlGu2tb6PW8ejroIJit4Hj0irpWTqtuqScc42UjuK5ud+6pXIVsg10onrlqX2pyT7K+gJG8E8F9NrroIYYjjGTVMkzBhXT0UZKrGSd6643RhyD8RaUk55XxNg2Zqy3A4VlhVF8Dk+cYgGM41BO56guetsFMWfxtfSMX8mQuCQqLca9icg8PHZoWJuOi1Gl1n4Myt4NDg1JzycbaZ0sADKOdquljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/P4sFSRiDjdpw6QKS1IdciixSFdCOXoHKEpps7CyCc=;
 b=aCDB4jCGGUZfLzT3NemzGb+N1h8coz76ZFCjAKcs5JL7qf/trIk88HowvEfP+UJKJstpX1R696DJGTxy3D1nsvBdFVUOyy4gyYECRGrQWuAnyZuPD2v5PtfD/+wPIyyyKC9Q6nou4M0zR74Pr66QYwqGBbIG2NTsW3SfLOw0cis=
Received: from DM6PR21CA0026.namprd21.prod.outlook.com (2603:10b6:5:174::36)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 10:48:40 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::27) by DM6PR21CA0026.outlook.office365.com
 (2603:10b6:5:174::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12 via Frontend Transport; Mon,
 14 Apr 2025 10:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 10:48:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 05:48:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 05:48:38 -0500
Received: from hjbog17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 14 Apr 2025 05:48:32 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <emily.deng@amd.com>,
 <guoqing.zhang@amd.com>, Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Date: Mon, 14 Apr 2025 18:46:53 +0800
Message-ID: <20250414104655.336497-5-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250414104655.336497-1-guoqing.zhang@amd.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 81dad8ee-1a72-4505-c6d5-08dd7b41ead4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RXWPC3/Jk3UE7U7zk/LeaN6/ykCYl/9NSVMTyfs+VDd5xKiN/Yi8fB4SAo1g?=
 =?us-ascii?Q?SmTiBcI/SySv7HKlGY9EwOkUnIGPOsrV+uGNgdr4HtmbuANhLuZtgB7F+YNc?=
 =?us-ascii?Q?vzVZvbm4eCN9kaxuNIx4Purkv9oDhe5+FkVpYD+5ffz10W7iG2QPk+QmAplT?=
 =?us-ascii?Q?8UyBx9DkcBmqrkEZW9Y/azx8BXgxuomUsrA948g9TtEWjWgKo/eDQCEfJBqq?=
 =?us-ascii?Q?JBxDU/hnM+m9ZfbOjJmtAoWv/Hm+9du6HFrCLPE2BMZYR/sxxmTmU1bcXj0V?=
 =?us-ascii?Q?ipw45mnHo46LQUNr2TzDDGjlN8nTwJ6XYm5bJkeIVaIgRvDQ/WYs+r/uhaGA?=
 =?us-ascii?Q?ExUHHBgrInYlOfEwltDvUL722EiDp7omT1U/VKmfOkqxJNmcjzNaf3/fngRt?=
 =?us-ascii?Q?4Yv8Ly8UKUEM4eHFCPzA+AvhKP2d8ugOZIcLmtCnzRxvOFJQ1GPiWehmPL0f?=
 =?us-ascii?Q?diLvlpa3cdthb0lvk6t+PAv83KqBWdUzZ27o6zaudlQE7MUS8tvrG3Yx5E/5?=
 =?us-ascii?Q?VZfkIS9InLEUqp0YqaYCl+geHz+XRAoy//svzj5O2C2J8nlRXWgCwe0hvyIZ?=
 =?us-ascii?Q?eIcFueiK4zK5Vkcg9CqL2wYGmI3vvJ5dP48V/Kh90380L3ewag8OeeYnpTsc?=
 =?us-ascii?Q?NG92jHodbMJmynniiUgi8wOuEtddBh2MQBMUEts9wQf40YgXWur00/A5rb5q?=
 =?us-ascii?Q?W1lGfuQEgFIWUO3+khCbEFL+zwgG6MOLowdZ1C35XXhY08G1mEf/S5q9Cd98?=
 =?us-ascii?Q?YIvb+9IUl7a1QRA1M0ILBFQg/nUaQb3Ot4cEbh9D9Qm/q8YMvNMEm8t8ZGtm?=
 =?us-ascii?Q?0PZ71tUzcVws+yuMStILzxw+FJi/VqOAP7Q/75Q3UKAfPoLu2wSr57tczNpJ?=
 =?us-ascii?Q?mAVqyKZYeAbd5tyYK+9aHZ6rhrFjBFLJkWgwFcvqKIgr3seCL1CxRjHBlGq3?=
 =?us-ascii?Q?ZLI/XIsVUg905BqdAZbs5hFUYyqosyC3hq7fudT83zWt+CVBY06VxmnwuoMN?=
 =?us-ascii?Q?SNcIzyalQbXJIIJ8f8z+Jh57NjvSbvKomJLqnLpfjItwq4HsTQ6dBllyLQY8?=
 =?us-ascii?Q?ELV0R8FGWjkKu9E3l3oRFVpjoveQoaiWJwrSJaLXt/Kp+Go/CuhT6CbE0tVf?=
 =?us-ascii?Q?Dq+Feg2uxhvJ7XXoGCLfOn7pUlQDnPdYRcNLQ084wrOkVhkitQGWJKzJxo8R?=
 =?us-ascii?Q?4igKkzNb9tR+hU7iwxg4zQcDj8l3cLl8BlWo+yKokonUzZUjbRW1mIBxHY3x?=
 =?us-ascii?Q?MQ2f7GfUrGjsuLr7Ie1B3J1zxwMVlMXCxSKIbq2VJtqsS6+jyp88DGddNsiP?=
 =?us-ascii?Q?iSRy06kQPbPxHfjVu1ebu9kZ16LMFZdBCvs7VU2mthoH7LTIi5mZA3I9HLsJ?=
 =?us-ascii?Q?0JJmGpHNYaE8NdnEBRhlCdsS18zc/vsrY20gomn34xb7RnAu2rjLWFBbZQPH?=
 =?us-ascii?Q?B7Ar+13srTIYMlTWJcMbHQlFAwvORIsH3ooW8IwVOnJzuRp0ueiWVSXbJIVS?=
 =?us-ascii?Q?vUZl4qu2vdgpkfDAQb3B8NRsk+shA8sRQhfe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 10:48:39.8600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dad8ee-1a72-4505-c6d5-08dd7b41ead4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342
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

When switching to new GPU index after hibernation and then resume,
VRAM offset of each VRAM BO will be changed, and the cached gpu
addresses needed to updated.

This is to enable pdb0 and switch to use pdb0-based virtual gpu
address by default in amdgpu_bo_create_reserved(). since the virtual
addresses do not change, this can avoid the need to update all
cached gpu addresses all over the codebase.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
Change-Id: I2b20b9b94f1e41820a013ce5d05bb3fa96859b21
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 43 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  8 +++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 29 +++++++++------
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    | 30 ++++++++++++---
 6 files changed, 82 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 5b60d714e089..e706afcb7e95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -248,18 +248,25 @@ void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
 {
 	u64 hive_vram_start = 0;
-	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
-	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
-	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
+	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes;
+
+	hive_vram_end = ALIGN(hive_vram_end, (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21) - 1;
+
+	if (!mc->vram_start) {
+		mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
+		mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
+		dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
+			mc->mc_vram_size >> 20, mc->vram_start,
+			mc->vram_end, mc->real_vram_size >> 20);
+	}
+
 	mc->gart_start = hive_vram_end + 1;
 	mc->gart_end = mc->gart_start + mc->gart_size - 1;
 	mc->fb_start = hive_vram_start;
 	mc->fb_end = hive_vram_end;
-	dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
-			mc->mc_vram_size >> 20, mc->vram_start,
-			mc->vram_end, mc->real_vram_size >> 20);
-	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
-			mc->gart_size >> 20, mc->gart_start, mc->gart_end);
+
+	dev_info(adev->dev, "FB 0x%016llX - 0x%016llX, GART: %lluM 0x%016llX - 0x%016llX\n",
+			mc->fb_start, mc->fb_end, mc->gart_size >> 20, mc->gart_start, mc->gart_end);
 }
 
 /**
@@ -677,8 +684,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 				     &job);
 	if (r)
 		goto error_alloc;
-
-	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
+	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ?
+							adev->gmc.pdb0_bo :
+							adev->gart.bo);
 	job->vm_needs_flush = true;
 	job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
 	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
@@ -1041,8 +1049,9 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	 */
 	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
 	u64 pde0_page_size = (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21;
-	u64 vram_addr = adev->vm_manager.vram_base_offset -
+	u64 vram_addr_first = adev->vm_manager.vram_base_offset -
 		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
+	u64 vram_addr = adev->vm_manager.vram_base_offset;
 	u64 vram_end = vram_addr + vram_size;
 	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
 	int idx;
@@ -1056,11 +1065,19 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
 	flags |= AMDGPU_PDE_PTE_FLAG(adev);
 
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		vram_addr = vram_addr_first;
+		vram_end = vram_addr + vram_size;
+	}
+
 	/* The first n PDE0 entries are used as PTE,
 	 * pointing to vram
 	 */
-	for (i = 0; vram_addr < vram_end; i++, vram_addr += pde0_page_size)
-		amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, vram_addr, flags);
+	for (i = 0; vram_addr < vram_end; i++, vram_addr += pde0_page_size) {
+		amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i,
+			(vram_addr >= vram_addr_first + vram_size) ? (vram_addr - vram_size) : vram_addr,
+			flags);
+	}
 
 	/* The n+1'th PDE0 entry points to a huge
 	 * PTB who has more than 512 entries each
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index bd7fc123b8f9..758b47240c6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -307,6 +307,7 @@ struct amdgpu_gmc {
 	struct amdgpu_bo		*pdb0_bo;
 	/* CPU kmapped address of pdb0*/
 	void				*ptr_pdb0;
+	bool enable_pdb0;
 
 	/* MALL size */
 	u64 mall_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d90e9daf5a50..83a3444c69d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -287,8 +287,14 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
 		goto error_unpin;
 	}
 
-	if (gpu_addr)
+	if (gpu_addr) {
 		*gpu_addr = amdgpu_bo_gpu_offset(*bo_ptr);
+		if (!adev->gmc.xgmi.connected_to_cpu && adev->gmc.enable_pdb0) {
+			if ((*bo_ptr)->tbo.resource->mem_type == TTM_PL_VRAM) {
+				*gpu_addr -= amdgpu_ttm_domain_start(adev, TTM_PL_VRAM);
+			}
+		}
+	}
 
 	if (cpu_addr) {
 		r = amdgpu_bo_kmap(*bo_ptr, cpu_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index cb25f7f0dfc1..5ebb92ac9fd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
 		/* In the case squeezing vram into GART aperture, we don't use
 		 * FB aperture and AGP aperture. Disable them.
 		 */
-		if (adev->gmc.pdb0_bo) {
+		if (adev->gmc.pdb0_bo && !amdgpu_sriov_vf(adev)) {
 			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);
 			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
 			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 7c7a9fe6be6d..73ac05b9a1bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1677,6 +1677,10 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
 	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
 
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
+	    adev->gmc.enable_pdb0 = amdgpu_sriov_vf(adev);
 	return 0;
 }
 
@@ -1719,6 +1723,14 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 {
 	u64 base = adev->mmhub.funcs->get_fb_location(adev);
 
+	if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb0) {
+		adev->gmc.vmid0_page_table_depth = 1;
+		adev->gmc.vmid0_page_table_block_size = 12;
+	} else {
+		adev->gmc.vmid0_page_table_depth = 0;
+		adev->gmc.vmid0_page_table_block_size = 0;
+	}
+
 	amdgpu_gmc_set_agp_default(adev, mc);
 
 	/* add the xgmi offset of the physical node */
@@ -1727,7 +1739,10 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 		amdgpu_gmc_sysvm_location(adev, mc);
 	} else {
 		amdgpu_gmc_vram_location(adev, mc, base);
-		amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
+		if (!adev->gmc.enable_pdb0)
+			amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
+		else
+			amdgpu_gmc_sysvm_location(adev, mc);
 		if (!amdgpu_sriov_vf(adev) && (amdgpu_agp == 1))
 			amdgpu_gmc_agp_location(adev, mc);
 	}
@@ -1838,14 +1853,6 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	if (adev->gmc.xgmi.connected_to_cpu) {
-		adev->gmc.vmid0_page_table_depth = 1;
-		adev->gmc.vmid0_page_table_block_size = 12;
-	} else {
-		adev->gmc.vmid0_page_table_depth = 0;
-		adev->gmc.vmid0_page_table_block_size = 0;
-	}
-
 	/* Initialize common gart structure */
 	r = amdgpu_gart_init(adev);
 	if (r)
@@ -1864,7 +1871,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 
-		if (adev->gmc.xgmi.connected_to_cpu)
+		if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb0)
 			r = amdgpu_gmc_pdb0_alloc(adev);
 	}
 
@@ -2361,7 +2368,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (adev->gmc.xgmi.connected_to_cpu)
+	if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb0)
 		amdgpu_gmc_init_pdb0(adev);
 
 	if (adev->gart.bo == NULL) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index fe0710b55c3a..13b229d07ac4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -74,27 +74,47 @@ static void mmhub_v9_4_setup_hubid_vm_pt_regs(struct amdgpu_device *adev, int hu
 static void mmhub_v9_4_init_gart_aperture_regs(struct amdgpu_device *adev,
 					       int hubid)
 {
-	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ? adev->gmc.pdb0_bo : adev->gart.bo);
 
 	mmhub_v9_4_setup_hubid_vm_pt_regs(adev, hubid, 0, pt_base);
 
-	WREG32_SOC15_OFFSET(MMHUB, 0,
+	if (adev->gmc.pdb0_bo) {
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+				    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+				    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
+				    (u32)(adev->gmc.fb_start >> 12));
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+				    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+				    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
+				    (u32)(adev->gmc.fb_start >> 44));
+
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+				    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+				    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
+				    (u32)(adev->gmc.gart_end >> 12));
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+				    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+				    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
+				    (u32)(adev->gmc.gart_end >> 44));
+	} else {
+		WREG32_SOC15_OFFSET(MMHUB, 0,
 			    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
 			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
 			    (u32)(adev->gmc.gart_start >> 12));
-	WREG32_SOC15_OFFSET(MMHUB, 0,
+		WREG32_SOC15_OFFSET(MMHUB, 0,
 			    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
 			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
 			    (u32)(adev->gmc.gart_start >> 44));
 
-	WREG32_SOC15_OFFSET(MMHUB, 0,
+		WREG32_SOC15_OFFSET(MMHUB, 0,
 			    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
 			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
 			    (u32)(adev->gmc.gart_end >> 12));
-	WREG32_SOC15_OFFSET(MMHUB, 0,
+		WREG32_SOC15_OFFSET(MMHUB, 0,
 			    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
 			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
 			    (u32)(adev->gmc.gart_end >> 44));
+	}
 }
 
 static void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
-- 
2.43.5

