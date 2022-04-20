Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F9CC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 00:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F14C10E181;
	Wed, 20 Apr 2022 00:48:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3004F10E181
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 00:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCPBFqcPr/TaQdEzbybKuMKurU4iUdEEn/nBN0kH5WUlcbihuV26HdGk2RKquXMBG7XJRxLfBTzuvPOmox7GRMT1VBjeJABq10jP+jb3uTldJCJI4HLml8aeZXXlDplwdSajeZxt1l93X2vfWbkdxqPKXWIaAWMnBNvJJRZzj0P0RcvTaYjgjqBGeUQCEr3nAY5ZQroWwujd0eNySDo5W0CB0uKXHetshtvvTg1akn98jt8JRfludrW0MF40cSq57Waeqd89SenVCNYBCE6ozCufOJja90Y9a7mwkRp+g4TLL3PaihTE1UOgPMn+V9PiK1gj6KfeKd2bzivh6VI6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxEFxmxPOvm+IetagwvFl6WQu6nvifXai80LchPgbbs=;
 b=e/3z+QgAPbnv+CZHaGlUq14QegfZDDPjH1/kITSb5oj1cYYFJbO8gakZUj0sRhsSHPlOTNNZNPJ+XATXzW2kCAVilrKEPDpbXyyt+EdluROcVKcWOEDWwj1Qk+D/8TCDQiKImGEoqYQ+dGyLW6ssVlTrbVtzYQ8mZi2M6P5qDjTzmc72FetfyEDZ/wspBItCDU/RjVvm34nNUHU3R/650h7M/ADRRON5bCA4tKttLfmv/tTBL1Vfy7AiXMGvGZVjmof34EMm6zWT1ydhiDYeQUz3Y0nvUfcDWeSB/PnH8vcvJ26XgJSLQBgTKhbzMF//dHzP7YVfzSNhy+jQwHZddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxEFxmxPOvm+IetagwvFl6WQu6nvifXai80LchPgbbs=;
 b=eTZmyj1jE8OMURve0QO5t0rQw258Ra1pWIG2Dbi57SxeAh/3vqHmsN4+BYAHa5UAiVU67ecXFm8bYaxilVQQiK9YkIfnUjllvGOuc1liSrUCOScjMBadNy0rHOWzYksvzSM4Rr77G8Udm3HmZgWmiadnG8tAjdSeIfMdZJdenbk=
Received: from BN8PR16CA0034.namprd16.prod.outlook.com (2603:10b6:408:4c::47)
 by DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 00:48:09 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::bd) by BN8PR16CA0034.outlook.office365.com
 (2603:10b6:408:4c::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.21 via Frontend
 Transport; Wed, 20 Apr 2022 00:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 00:48:08 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Apr
 2022 19:48:08 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: Add SVM range mapped_to_gpu flag
Date: Tue, 19 Apr 2022 20:47:41 -0400
Message-ID: <20220420004742.8780-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e249f0b3-46a6-46aa-1f1f-08da2267707b
X-MS-TrafficTypeDiagnostic: DM8PR12MB5478:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB54780F85609AF08AE942B92EE6F59@DM8PR12MB5478.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BsGgs8fGkmexmKGc25tEXaHq2Bglcc6PWLJdNKxH2PjoMHPSkBM1m3FIfbwhlfcIO07wPqsM/QGwKDshmx4sN99WfYWOo62ZKOdyHoGYpkhRX+qEd99xG0QHDIKiS4IvjcWjpY+Yr6l8jMw+MDciDmMUF1K9/zKmglbBlGAZB6V9MRPdnq/DJPxCs9R0rUfn9Xg2OxAHWMAcZkmi0ftYeh7qxu39Nz2Oq2wWiVp4QteS3C6Ni1Ic7LULVOaJQ8OTb6Pb88dKfuuHYEAl3tqJCK9vxm0xecsFsNMmyUUjkM1SWox7USNTmU9PKC+7XXYGyWMErxCY4JP1RBCPmVsh6BHRImmiXNuuX0MvdQB5xW4gtZNFGFH7uqzds2xDjrR0U6wuaJ4ovTqmwC6c1FUXhRFECzwmmW6MPqYbWZxPySXiObQzA7Q6WBUxHfOTtsPtXQBoCtywL2nokMk/NVWcAcGFFpy+qgN3JuiIhZti9g3nI5g+DJGIkyctA3NUSSl7HDvmyP3U/hFl8fsprckRfxWGzM+rJc7pa4F0CEZid6zWpHO8fM34WRD9XvGZJnn1UzTib0MthSSdgv00lIrVu2NeabNK7GzUpXPUmLWOGqqZNkAyGHoBfugfc9y/1MktKBt+SpnDQIeuun9mGeORRepZJRvIapjPAaiPCt7vTsECxDp4QF5GCZyuBCTXSvxSfRgGKpQQRofvRjlg/UmgKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(26005)(86362001)(6916009)(2616005)(6666004)(7696005)(2906002)(8936002)(16526019)(36756003)(70586007)(508600001)(70206006)(1076003)(426003)(356005)(36860700001)(336012)(82310400005)(186003)(47076005)(54906003)(40460700003)(4326008)(83380400001)(5660300002)(316002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 00:48:08.9970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e249f0b3-46a6-46aa-1f1f-08da2267707b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5478
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

To avoid unnecessary unmap SVM range from GPUs if range is not mapped on
GPUs when migrating the range. This flag will also be used to flush TLB
when updating the existing mapping on GPUs.

It is protected by prange->migrate_mutex and mmap read lock in MMU
notifier callback.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 5afe216cf099..6be1695f3a09 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -951,6 +951,7 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 	new->prefetch_loc = old->prefetch_loc;
 	new->actual_loc = old->actual_loc;
 	new->granularity = old->granularity;
+	new->mapped_to_gpu = old->mapped_to_gpu;
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
 
@@ -1204,6 +1205,17 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 	uint32_t gpuidx;
 	int r = 0;
 
+	if (!prange->mapped_to_gpu) {
+		pr_debug("prange 0x%p [0x%lx 0x%lx] not mapped to GPU\n",
+			 prange, prange->start, prange->last);
+		return 0;
+	}
+
+	if (prange->start == start && prange->last == last) {
+		pr_debug("unmap svms 0x%p prange 0x%p\n", prange->svms, prange);
+		prange->mapped_to_gpu = false;
+	}
+
 	bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
 		  MAX_GPU_INSTANCE);
 	p = container_of(prange->svms, struct kfd_process, svms);
@@ -1590,8 +1602,10 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		addr = next;
 	}
 
-	if (addr == end)
+	if (addr == end) {
 		prange->validated_once = true;
+		prange->mapped_to_gpu = true;
+	}
 
 unreserve_out:
 	svm_range_unreserve_bos(&ctx);
@@ -1822,6 +1836,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	new->prefetch_loc = old->prefetch_loc;
 	new->actual_loc = old->actual_loc;
 	new->granularity = old->granularity;
+	new->mapped_to_gpu = old->mapped_to_gpu;
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 66c77f00ac3e..2d54147b4dda 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -133,6 +133,7 @@ struct svm_range {
 	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
 	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
 	bool				validated_once;
+	bool				mapped_to_gpu;
 };
 
 static inline void svm_range_lock(struct svm_range *prange)
-- 
2.35.1

