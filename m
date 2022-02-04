Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A349AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 23:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3404B10E765;
	Fri,  4 Feb 2022 23:45:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E79310E75E
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 23:45:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwPUIUQo/8LF9uMdeKBRvxHBMOm5kZS+XWOivUD6lj2GTvlCa8FQ0WUAKpkHIkth16bhm4m/tzri7xLyHsUOckXAZpJk6J1FWZ6FGLEA0ccfpA0lKdXtiZ+DhvgpbfHZlhHHc8x59oP/xQNcaDq4dv03QmiJlzQuihKGLdD4Z//kh1LHW8+8DaX6DBTPDhaq+hPT07g7fzxjViE9YSV3wzvluPFvWWh4IDVMbDIaJ5zQMBWKA29AhDZERuyD1teBpdLHvwAE0XOEIQ5VhqxNb9oVKrbblEUl+QzcvLM/YR/3qW+h9sUyizI1EzQ5ANI9oDXPA+5vqARiCymoUpMe8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUmEYJNAygMtglJ9tnsAle3KyFUVjLWAG2fxs8WMY7A=;
 b=a+MsEM62BUgxWuWadUWsK2GsfONV7ytSqVgqotEKoRIW7hXLWz9qwEQVkjB7oPBuhE3mGylOHZ7dYWiSiWPNFfWJMQqfdFMVT039eFFsDl1BFfQ017fIqtaU9LcYwCpfjilmX7q5B33x7nepImZm9ylwCsx423xdENXGwLA+6jsGXjzppiLn14nen3xwgbZAK9Ml2zKBZ+SKICDf23pGRWCY+gTFDGu760jLRgFC+UAsvbYRHMqGJUGbsFt4oFbrE41qEBlUndCBFDPpbM5jhS5jkUv75aPHubQhbmcM541D/ggJDs1rpf0Hj9th3EDa+YhC39NhjhrGV5bft6TkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUmEYJNAygMtglJ9tnsAle3KyFUVjLWAG2fxs8WMY7A=;
 b=0wI48uS15/6Zva2yRIgh/R9HGhg64oDkpaDXRP7j43onHLrPMGloUwXXUPuK3OVBOtGwJ266NOlsH6D3+v4o+n6BDD5z7htK21T1fpeWPJyQqOfR9qb9hKAKJKHnHvWLfdHWzJkBzP3ktegERkmKgy2OAvcmdnuk0BRxWLLv9oA=
Received: from BN9PR03CA0389.namprd03.prod.outlook.com (2603:10b6:408:f7::34)
 by DM5PR12MB1210.namprd12.prod.outlook.com (2603:10b6:3:75::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.20; Fri, 4 Feb 2022 23:45:27 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::51) by BN9PR03CA0389.outlook.office365.com
 (2603:10b6:408:f7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Fri, 4 Feb 2022 23:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 23:45:27 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Feb
 2022 17:45:26 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdkfd: Fix TLB flushing in KFD SVM with no HWS
Date: Fri, 4 Feb 2022 18:45:11 -0500
Message-ID: <20220204234513.11714-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1be8b299-fa15-44b3-738b-08d9e8386bce
X-MS-TrafficTypeDiagnostic: DM5PR12MB1210:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB12104C8319CB6A6AB4F530A4EE299@DM5PR12MB1210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6m8PEFw4GtejTqWlrGV2I2wXNKR2uQGvN8XEgNcB2dZJ5ZL2PvltOLPS0+xhTyEse72no8znzBG9xJ6CCgPAS9+X4lVud3HyN+aPsEqWvXf6k2xKxTkLHvG5zsecMd8tzGK5YCS8IE/Ve973ZCRhKnsrAQYQEpj09P2z2v1AHfMqQzcgQaKEuVerx1fZQDAKlUuvIAnE8+DssfL7yHh19Maq0Ia+5iHjRHrZ3b2267XUk8I5bLdhPjq1eIRfb1wltjZCxycYIRdTID6v3/PD3+kgLLdtNse1Mmy6jYYoqzK0T2GMuYSowdw9ggMYGfRCM0slUjyBlgB28kgrxKffB9JxA82+JFRGiCnv543lD1KXR9Q0ZJXO8epr5XeBxWkd8kZGqRU8t+XfLuvhj+QOx/hSlo9AR3EmST/8Yu7U0HHAKxTKR0PjmRU6z3vy4SMmde+SUwau46pXa/LJov07YP1blkaYJw5M1yjgAsA16GA5VIHSTHI5WiI6KSHDc+z+cxW8xf5FPHlblS7F84dtQHFkGGTNvzMiPibRfoIxt3Ti5vPX24I60sb234NTWXmAw5WmAb0AsELez3IYR/kkwBqgJm0BlaADLDj7Z/lFuvEp5lAUFxgrCseaeQjF41yGdUsbDPZOu0O+5qeh4QealYjDtx5NNuZJ3VDpj3mzttD0A/+w18Hpz1K9zeVrV9+tV2oihJ2HnlhT8Ifh4Jq0tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(8936002)(70586007)(70206006)(508600001)(7696005)(186003)(8676002)(83380400001)(316002)(54906003)(336012)(1076003)(2616005)(6916009)(426003)(6666004)(86362001)(16526019)(26005)(82310400004)(36756003)(356005)(2906002)(36860700001)(40460700003)(81166007)(47076005)(44832011)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 23:45:27.3515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be8b299-fa15-44b3-738b-08d9e8386bce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1210
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With no HWS, TLB flushing will not work in SVM code.
Fix this by calling kfd_flush_tlb() which works for both
HWS and no HWS case.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 41f03d165bad..b1315c97b952 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1229,15 +1229,14 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
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
+svm_range_map_to_gpu(struct amdgpu_device *adev, struct kfd_process_device *pdd,
 		     struct svm_range *prange, unsigned long offset,
 		     unsigned long npages, bool readonly, dma_addr_t *dma_addr,
 		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
@@ -1248,6 +1247,7 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int last_domain;
 	int r = 0;
 	int64_t i, j;
+	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
 
 	last_start = prange->start + offset;
 
@@ -1305,12 +1305,8 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -1351,7 +1347,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 			continue;
 		}
 
-		r = svm_range_map_to_gpu(pdd->dev->adev, drm_priv_to_vm(pdd->drm_priv),
+		r = svm_range_map_to_gpu(pdd->dev->adev, pdd,
 					 prange, offset, npages, readonly,
 					 prange->dma_addr[gpuidx],
 					 bo_adev, wait ? &fence : NULL);
-- 
2.33.1

