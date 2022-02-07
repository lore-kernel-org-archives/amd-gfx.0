Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F28C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 19:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE87010E25D;
	Mon,  7 Feb 2022 19:53:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B7D10E23A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 19:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBtWczbTd7HNuYTd2JdDg1HWEw+0CPaoEVQ/kP8pFpWserCrNRvYmbRC5T+ytGLltUfIzqO0lqRxHDyOVy6MDEZdsNErAZDoOlf+e5a65h5wxZxEANhEzJHCT9RupSexkYGTGTisKk50WK+RK6B8iuqaVMJk+ho/r4UyJ/MX8QMvqRyw82/E6GpGQDL9uegD8XqaTwVmc3FD79GKQWmcnIxZ50KOF2m2NG556Q6ODLIq6sJvmU52ZI+TgCfNfO++2fO4Jqq8cgpWdKB+Q4zP/EkVjNTsCeY4gMh10uGb57wvziMePlSQy3rpBqsx7MpMQDq7B4Z11YmDfYpAEQtUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeKBC5q/62UVnlNuJKfOPFw3jKdcSUJHchzxe14mxIU=;
 b=ci3fUXzjl2a9CsAEAMizPXo+vN3bQKoT0ZC8CbRLhNoNFKS0byvwD6b4MW+J5yH11focSFPaL536y1dxGSpfniF0QIgbisO9m+zx9nrd9MZhyxB7UBQhxVWjYJAK+YhAc/Fwoh5LyeommRdtoFrWp2TuFPUh0hrfna8W4AA2GFn9KyuFyN2LmIvlb8STK75JsdlmrJn2grWYNnvQhQG7BwKNch1t0BJf38ukijoS+M0PDqsn6l9ERKY08yEbzYhWt/B4UYMnzFahxaLJ0vvkFY24A6OJEOqjP925VE/66lWaBthDCs3FXWb+eyVdee8y27zntuDfjAzyTeA9igOziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeKBC5q/62UVnlNuJKfOPFw3jKdcSUJHchzxe14mxIU=;
 b=kaV5e9idV/N5/tMmm8/hwkU9KfuAfQU/2Q4kYWyIib1UcoPoidEm5jkhXZK0u7mhz/l6MMX61RLuMh4AGAJaZ0imlV+3UA9R4aJcWBTZyCdbf5me9Fwiqu+ydRCK2fVkt3X3kDZTtnLShmT51UNTDOcolff17x0hxbHVZTjFD2w=
Received: from DM5PR06CA0046.namprd06.prod.outlook.com (2603:10b6:3:5d::32) by
 DM5PR12MB1482.namprd12.prod.outlook.com (2603:10b6:4:a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Mon, 7 Feb 2022 19:52:57 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::87) by DM5PR06CA0046.outlook.office365.com
 (2603:10b6:3:5d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Mon, 7 Feb 2022 19:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 19:52:57 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Feb
 2022 13:52:56 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCHv2 1/3] drm/amdkfd: Fix TLB flushing in KFD SVM with no HWS
Date: Mon, 7 Feb 2022 14:52:35 -0500
Message-ID: <20220207195237.11605-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9670a8f5-6845-40b9-4446-08d9ea73700e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1482:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB14828CDB6AC2A48DEE3B8D95EE2C9@DM5PR12MB1482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /sVS7/0FkSgwPqMo9lz33xPss0EL9lZTTwZP6pLLUUEHVDK3EMIL5MIcv9JkFZTZ/ncYTA7crpP09sAknQrw0pP8/rd9Qd0Es8fhf3e97/7zuXrAqfQLskJUTivwHv44O+Zc1z/eeDsLb5nneAk5QyyI/jRgqgYO1NOTFKxUYdi6NuOIIBtchDKUBn+DEow0KkCwUT+aU7jvQigRyQPFSFjyG9LomsiAkM6vWlxr+bS/6nMQ1dmc5SpCkxT6IatJnWG6tpo5GkSwi13kOerJeEf02EQI2aBEs+Jsjy4VCnzt7e9TU4GBR9e0ryTSJQpI/aTMmP+IRwDjn/WJ1HsFCJmfl8FrzlLSVE2ABBOy0LmU7fi/Knyp+JKLVMUBHi3K8U78i+PShNvoXtCbdWk5grwzapEED+QSRmlws+Q2wEFoo/cNno8TgJA5f0i0Q5ygSGk1giOObJ77H17B4Mo0l6dxMhlpzYxDk1Bzc32M97RKpDQ8PIp0YO/ziaPvdv0LgWfZA88OcbA5P9LpePoVNBef9ktFLHKv8dHz/bKiUX/KXll0iqLCPggn863wmPNo3ZrBk6RR4ZpR5cUePO1PCwzPHLlWze9vzxsY0UXdv4J5Zon9bVqWprL+55nMi2T+hm3m4RtQ7p/VwqnKYVenS1hXHYXZohJ8ti46kNvA2WUCk1uvMkUSmJ2K/dPxPH12itbU2AMpLhZ5udMrbKVGzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6666004)(7696005)(36860700001)(83380400001)(54906003)(316002)(4326008)(86362001)(26005)(356005)(5660300002)(70206006)(81166007)(2906002)(70586007)(36756003)(44832011)(508600001)(8936002)(8676002)(82310400004)(336012)(1076003)(426003)(47076005)(6916009)(16526019)(40460700003)(186003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 19:52:57.0663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9670a8f5-6845-40b9-4446-08d9ea73700e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1482
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com,
 Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With no HWS, TLB flushing will not work in SVM code.
Fix this by calling kfd_flush_tlb() which works for both
HWS and no HWS case.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
---
v1->v2:
- Don't pass adev to svm_range_map_to_gpu().
 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 41f03d165bad..058f85b432b0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1229,18 +1229,17 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			if (r)
 				break;
 		}
-		amdgpu_amdkfd_flush_gpu_tlb_pasid(pdd->dev->adev,
-					p->pasid, TLB_FLUSH_HEAVYWEIGHT);
+		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
 	}
 
 	return r;
 }
 
 static int
-svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		     struct svm_range *prange, unsigned long offset,
-		     unsigned long npages, bool readonly, dma_addr_t *dma_addr,
-		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
+svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
+		     unsigned long offset, unsigned long npages, bool readonly,
+		     dma_addr_t *dma_addr, struct amdgpu_device *bo_adev,
+		     struct dma_fence **fence)
 {
 	bool table_freed = false;
 	uint64_t pte_flags;
@@ -1248,6 +1247,8 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int last_domain;
 	int r = 0;
 	int64_t i, j;
+	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
+	struct amdgpu_device *adev = pdd->dev->adev;
 
 	last_start = prange->start + offset;
 
@@ -1305,12 +1306,8 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (fence)
 		*fence = dma_fence_get(vm->last_update);
 
-	if (table_freed) {
-		struct kfd_process *p;
-
-		p = container_of(prange->svms, struct kfd_process, svms);
-		amdgpu_amdkfd_flush_gpu_tlb_pasid(adev, p->pasid, TLB_FLUSH_LEGACY);
-	}
+	if (table_freed)
+		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
 out:
 	return r;
 }
@@ -1351,8 +1348,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 			continue;
 		}
 
-		r = svm_range_map_to_gpu(pdd->dev->adev, drm_priv_to_vm(pdd->drm_priv),
-					 prange, offset, npages, readonly,
+		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
 					 prange->dma_addr[gpuidx],
 					 bo_adev, wait ? &fence : NULL);
 		if (r)
-- 
2.33.1

