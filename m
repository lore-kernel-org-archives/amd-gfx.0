Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF04C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 08:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2793F10E3F0;
	Wed, 25 May 2022 08:43:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B1910E531
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 08:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPZY9IXqRncylzRQalgdf1C+Poe3N6Zpd0LfcFQ5vvF9bsNUAZIbc24fwkgGx9qjfTf5kjS17ZSXtFtfG2H0OlfFyp8Jr0ebXHasEHtbvimIvNvrBKjFuEcM+2OmLr9P57o2iyjL0ao1b29ViWDfAG0C7Ug8MrxetdIWVVyYBVJt/lpbaMe771/Tebg3xvBfcHCqHVT6DzhVE7AlC7bFIETEBMMow2aVRkUiURu7qrb4gtaVzqsVWk3u4EZ45ztPfxOzbXzOaIgMdsmLR8xb5HVDsaPuYqUsNnZdSgPGFnjFBMD0TYBuI91+KHRIe3Cm2f+kFtv95gBBIVDjMbEFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcYV/S9VeBY9uxUZhCbi1Q6NRLCi6S2C5FdOBDpqc34=;
 b=EWy5y7sTMH5Vx7pF98xlTqDo151VzEEwP/x6pfpzFVXSbHDZCCRXs9Cg2vCJiFrzFBlQ1assa51mkcPh0pm91KZOIoask0fBO5kVglSl+fkmpP3gvz36HPaMqqfvqXgv5TgozpwWP3AzsKr2j1X8h4OFt0fNj8T5kwKCMSORrq4ch64dvMOsjxQVFXjSpucswLS2GBx31AMbtPVnjBNknB/QxAWAdrERSyX9LRSnWcQU5HxAwulDrn94SObcz6DMzhAkb/Sm/F+xepha8wsQCnvhMMsxx/4zehl5VVbKnAOWRr4LaTl5CNhpO2HwlOZJxgjmEKY8Mhb7GUX0dQhHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcYV/S9VeBY9uxUZhCbi1Q6NRLCi6S2C5FdOBDpqc34=;
 b=UZ/eWpRPpK7PmfWVqsL/A8txQ3bzcTpaHVw0XTsFnNfEP7Tr8dPD9Mk47tqtpImkF0/h0oWORFcv/C0gt5T3CG2OFNSHlfjVdMREcsRX1SwZefzfjNCmEwfeb9WSc2d14XhlaO0c+IEf6wMDIfSGch8Qje4LGS8vZjXLPhtBmIE=
Received: from BN9P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::28)
 by CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Wed, 25 May
 2022 08:43:40 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::60) by BN9P221CA0005.outlook.office365.com
 (2603:10b6:408:10a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 08:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 08:43:39 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 03:43:37 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: don't add DOORBELL and MMIO BOs to validate list
Date: Wed, 25 May 2022 16:43:24 +0800
Message-ID: <20220525084324.1354886-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c17f4cb-35e3-4f9d-3a80-08da3e2aaa9c
X-MS-TrafficTypeDiagnostic: CY5PR12MB6479:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB64797A8A6F7821B5A37D4768FBD69@CY5PR12MB6479.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1aMJ11Av5CqqqIVTf/KI0hmKUdg1qx8uxxCIuaq6OUfAYmA7iOSc87J8sQ6oh59R+0MryBi2/ahTreWvUylrVg26kiCSGPY1YGMg1bGycnajb9RHOuXF2G+tWuhnEZ8TFMXraFJfT8bgyo4yiBLO0Aqz3xkreHl6ZtYoxNCJKJjIVVALVMbfoSNp7cpEQc4OMYa9oEEd8J/Kvl0iwvlnt9tJ1dPRncknogVO6+fdIvMJX6r3TuK7mlcxhs8hy56QyBb+p5KKJBXg2+SxqRlrlSlzTPJAa9pRQ+z3N4dPczj+1I7tgylilIpqmV/xgMXAYaEtq3l8gxoaMm2Prkd7A3DgOlEdssuFXyO5kwjarX6L+HhJYCXQvqjhmeL1h2EDySBIiz9tdI3LKKjZHn0JB4s1NZ5oi4ROdPBn2bY7xJdr1VXx5l1OTfFXV6wBo4KtHLTP/vD6KB97LuVicxJMzVfoXtgdUb04MWw0x6Q0JCImR8i+AD+uPm2BFkkojbN0RQtWD8+bH1IBoBwnPQDbu5Fpn530J1vhneqgefKIC0Ei8mezVnoZ2RzvJwIS2iy/NBZzUORjB7b3JFoYnIHEwnyv1ugGYOsZRdPpKz9kbKfNBO+ecVB/uMdnTLAOlBq6INIR+tC01vQtEMEZW87Kb72KPSqYh4eH2sU+6PjMfasKq0PGtrXOf7qHHNTCGOlPHrx8ahHyVSEJzIM6jblsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(5660300002)(2906002)(1076003)(15650500001)(70206006)(508600001)(6666004)(36756003)(36860700001)(4326008)(16526019)(40460700003)(82310400005)(8676002)(83380400001)(86362001)(2616005)(186003)(70586007)(7696005)(6916009)(81166007)(26005)(316002)(356005)(8936002)(336012)(47076005)(426003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 08:43:39.7635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c17f4cb-35e3-4f9d-3a80-08da3e2aaa9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DOORBELL and MMIO BOs never move once created.
No need to validate them after that.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 34ba9e776521..45de9cadd771 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -808,6 +808,10 @@ static void add_kgd_mem_to_kfd_bo_list(struct kgd_mem *mem,
 	struct ttm_validate_buffer *entry = &mem->validate_list;
 	struct amdgpu_bo *bo = mem->bo;
 
+	if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
+		return;
+
 	INIT_LIST_HEAD(&entry->head);
 	entry->num_shared = 1;
 	entry->bo = &bo->tbo;
@@ -824,6 +828,10 @@ static void remove_kgd_mem_from_kfd_bo_list(struct kgd_mem *mem,
 {
 	struct ttm_validate_buffer *bo_list_entry;
 
+	if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
+		return;
+
 	bo_list_entry = &mem->validate_list;
 	mutex_lock(&process_info->lock);
 	list_del(&bo_list_entry->head);
@@ -1649,7 +1657,6 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	unsigned long bo_size = mem->bo->tbo.base.size;
 	struct kfd_mem_attachment *entry, *tmp;
 	struct bo_vm_reservation_context ctx;
-	struct ttm_validate_buffer *bo_list_entry;
 	unsigned int mapped_to_gpu_memory;
 	int ret;
 	bool is_imported = false;
@@ -1677,10 +1684,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	}
 
 	/* Make sure restore workers don't access the BO any more */
-	bo_list_entry = &mem->validate_list;
-	mutex_lock(&process_info->lock);
-	list_del(&bo_list_entry->head);
-	mutex_unlock(&process_info->lock);
+	remove_kgd_mem_from_kfd_bo_list(mem, process_info);
 
 	/* No more MMU notifiers */
 	amdgpu_mn_unregister(mem->bo);
-- 
2.25.1

