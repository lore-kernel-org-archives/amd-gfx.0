Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE1AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 21:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E052289B11;
	Mon, 29 Nov 2021 21:24:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA3E989B11
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 21:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ie5UGas9b6iBQcMSV3+Y7ZnzTMULYML7dornt/iLaH6D3SNkGGujaBFFdh2fI80pn+Bj+SM0FKQVpnmme3bjS98h1dfJmWXVhrNn7y6kXAVwoZYfxO+MIb7KfdZku5W7ZVGGZRe7WATgfv/jWds9vFG7M7b0HE2C+g7LnI7reOC3ywoflYqxTEsrop20QyYgG2+IedKQq2M29fSFWlo/OSI2YVbdjmlZC2mQjKuTi7uu4ql1w096m2AlXH25jnePYb/PBymQKInK4BDipAU00wv6WzFyWwpBDKcKAntH/+mLS1/UV4DJm4mLYcwt9EW0UTP9RFcB8WitdHaGBBWRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYwCXLo7yBWZzC0399eQRATldHRF3GnI0UtCNrmGeLk=;
 b=acfA//3mDmHClTlxrfzFlVnSOiYmVY/A3k6Gg7NDBbIec8qlyWOZaVHdM/KjecVJFMvt2/QckQi4CDl2MsIt5KNtVHsYuoWcJ9NIHVqB0JAM2bnyeaM96YsS5QBNgzOTWKhurFnz8lkYV8++WQg4S/BW5/1ZVYMsXLqsqrOYVUBYK/W7wSNguOrOV9A838oa7QDjh5txxe0KCSF1Fwiaug3NisRVxZRLxb9JgmD3E54jQGnoHiB+nz6+vXKj5D959qeD+Zg39q0iGDykECcROOevdwOCCyAlIOCiiI8Y8JfdKyQhJ+TinDywzNI70T2o4ag7usKPXAxo/Z24amhQ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYwCXLo7yBWZzC0399eQRATldHRF3GnI0UtCNrmGeLk=;
 b=T7jSX6JRlOLaFgSToGFe8jsFmBdwl2NTbj/yUPHazGbbQpkLH77Hbp+QxDos5qfhu7ZFKbxyeoEtN0zUP20hBH36XINYz4WCOPmAtSCXIcRv6VzoCY3NHA1WeJC0hCGFyFF9NbXtEykbJShPfxNo+GoWmclD6bU26OsRU1iV+kM=
Received: from DM6PR06CA0051.namprd06.prod.outlook.com (2603:10b6:5:54::28) by
 CY4PR12MB1784.namprd12.prod.outlook.com (2603:10b6:903:11e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 21:24:31 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::87) by DM6PR06CA0051.outlook.office365.com
 (2603:10b6:5:54::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Mon, 29 Nov 2021 21:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 21:24:30 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 29 Nov
 2021 15:24:30 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: err_pin_bo path leaks kfd_bo_list
Date: Mon, 29 Nov 2021 16:23:28 -0500
Message-ID: <20211129212328.19049-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211129212328.19049-1-Philip.Yang@amd.com>
References: <20211129212328.19049-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28f69bd6-ca15-46bf-450d-08d9b37ea1ba
X-MS-TrafficTypeDiagnostic: CY4PR12MB1784:
X-Microsoft-Antispam-PRVS: <CY4PR12MB178411D7146F12775A254F72E6669@CY4PR12MB1784.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oh8eyz5RDNH5UVA+z729rfOU5grhVAXvvswjYzk9xMfN3LFFneFLSSCSeZU9enOO8p9qj4J/xastgZdGo4Wl3QFVL/xqYBVt4QxgP0JCzm6ONb1hlT341j8qkZcxVVyEZBntJ8y8tWWrCDxJ8iYWJ/OR0YyfYShJP+XAe+lUptTD66kdo9AJBp51QGDZEXvaogBlXzC6AowV9Vsc5Keud75ztnY/+re5espw4dzmJ/4mnrd8nBBtcrfIJaMGwgZKGEiLTZojN3uB9eqvp318/jDJ1ZbHIyJ5LiM8YimAWodnZMI9klsk4qNgHEQ8DTCeorFrHFokew9wVsw5ERAOWy1+1H5IFQVswZGQDiF/qohSjR4gH0aBzW/0gAfwu5aGLFSJWuVElCcbOkPESN7q6ggLRhU7KF0BvqbcOYuPD3iPrvDCSbfx3beZO8PG8jbsgqvxU9Qx98rXIoDfZs/2FVFIBOUzf3pWNsC6dZwzQVIYH4Q/w/WZ5pwIKMJIcPqClSvccirxfNEUoVNnxAt9R5ZWUm+jZ2PmCol8TGoa5dhoOtB4nGLOB4PE66gn78w4nhZ1sasJkblAmE2OpJN8qYTfcIWyRP7Nn/kkBJ1hzwqNaS/AAOgknx8dvURFyMeFkJZwB4Vy5gYzHCE+j/jb9k8BvKnhtRZH+fR+LMf3liyRJULR4BBTD/0LZd7A+haXH2BEAphdJKtDRiVrZQ45m+BgVZf0gb5/bsekLoP1Kuc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8676002)(508600001)(5660300002)(6916009)(70206006)(54906003)(4326008)(70586007)(356005)(2616005)(336012)(426003)(36860700001)(36756003)(2906002)(26005)(16526019)(186003)(83380400001)(47076005)(7696005)(81166007)(82310400004)(86362001)(1076003)(316002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 21:24:30.9366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f69bd6-ca15-46bf-450d-08d9b37ea1ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1784
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Refactor userptr and pin_bo path to make it less confusing, move
err_pin_bo label up to remove mem from process_info kfd_bo_list.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 5df89a295177..b8490789eef4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1559,13 +1559,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		ret = init_user_pages(*mem, user_addr);
 		if (ret)
 			goto allocate_init_user_pages_failed;
-	}
-
-	if (offset)
-		*offset = amdgpu_bo_mmap_offset(bo);
-
-	if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
-			KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
+	} else  if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
 		ret = amdgpu_amdkfd_gpuvm_pin_bo(bo, AMDGPU_GEM_DOMAIN_GTT);
 		if (ret) {
 			pr_err("Pinning MMIO/DOORBELL BO during ALLOC FAILED\n");
@@ -1575,11 +1570,14 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
 	}
 
+	if (offset)
+		*offset = amdgpu_bo_mmap_offset(bo);
+
 	return 0;
 
 allocate_init_user_pages_failed:
-	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
 err_pin_bo:
+	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
 	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
 err_node_allow:
 	/* Don't unreserve system mem limit twice */
-- 
2.17.1

