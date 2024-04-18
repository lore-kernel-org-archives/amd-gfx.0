Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B04DC04FF8
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 13:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E521E113CAD;
	Thu, 18 Apr 2024 13:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xo2O/opj";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1CD5113CAA
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 13:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlASXzXI5hkZmmxDUJrQ7gs7GyaqABbrrp/gTrZzhohV65QIiXkUomILXW/X6YZl1Rj317BEjhnzXog8QaDV4zz9OBUMaYK3vjdDpUnu3hCYgDHJlynGGxMG84yyWtYVD6pN810Mozu+KqkEADI39oQk+xk6Sg/anzp2F8yDIKMkhsT278Vbo8nGnpFJ5PiRXMMuNvaLoOSJQvnHQmLbmCxqwEF3CAdDC+I5CQa+hf+8ri9B0zHV8+DBK9W7zjvIGpCi50xzuUmvDgg1crS3YexF4+VbA5Mk1T4NQerHn4Q+nM6DSAm+zbcQMD2DJnstvb8TF9wO10CcOjE6fwsvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaWcIq+F7+dtCyd44eKBgWqqz2bP9wq/mpvGCO5UN6U=;
 b=oDR4hOrHrt7ALYE+APJhnr+xw1dlMbuREWtoa7TWZkrkDVqlJsnXVp+xdmbUJy4MTmCHFiYi+ieyNIX71jehUria/Jl+A7cTcxB2en5Zu7Rom4JAHDhvYxpkK2r7Te1FUCqOLolnfNfTrJvgFMpTOtE9E7wQBjk9jbftsZqoGTFfqhikJALkuzoDe7Ur0x+CJHqQ7l2Kz6yDWuldSnG8WUsBVxFbU67cYAozp8bojmRrS6rIhO1V3xcx3Snqs0URb1FBa2GaBbVEsBjiuPdZFZptyqmUC0CJG6QBCJqN/IaOPHaHGG3ThU6MaXI3f13sj6S28x0tEmB1+nYPPsDQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaWcIq+F7+dtCyd44eKBgWqqz2bP9wq/mpvGCO5UN6U=;
 b=xo2O/opj2giSMUO+jLmWsPh2Og5z2QwxpiSD13cj1pY87lEhqr352hGuDsVQgPB0s8QfjPfqgbutak+BZCD5/LCmQ+UHOf4j+pIrlhhQoP/xKLHPUZY7gwKI9RVLU2425lZDz2W3rDZi9iamA4GA4IIc58KLWq/h/Tq0tJ09nWk=
Received: from BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 13:58:38 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::be) by BLAPR03CA0027.outlook.office365.com
 (2603:10b6:208:32b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Thu, 18 Apr 2024 13:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 13:58:37 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 08:58:35 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 1/6] drm/amdgpu: Support contiguous VRAM allocation
Date: Thu, 18 Apr 2024 09:57:58 -0400
Message-ID: <20240418135803.17365-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240418135803.17365-1-Philip.Yang@amd.com>
References: <20240418135803.17365-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: 87fd7edb-8d2c-4558-2760-08dc5fafa581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sYu2LdZM3AL9uth/w1mfb3Zhx0J9bnKl//HjxYpLLmH4DAyKkZ3EbXnVNXtsXhOFYqCiAmD0uqovvdZl5YjEhZwz/xrwKdjqLpS6IA//HEN/AIwZwEhmbM2ifVbi69kkrAqFrPqOWf37Go/DqvwWPtSL74CjLN8aXAwiByZMXcABvzrWdhZfQrSm9aG6u+HzhL6DW9/0LpbsXK8V1jiVLFikiReanucnMB+tVYpO/MOFPNjmL6Qys+4Z77hH7JV68J3lUk2FHhSaj9+EFIPIKwWSVYfw70kU8s/CR+qdEGFZVe3PSB9+TiunxsqxamSHkVYsjKXio8atYdr9Dt4ZBA++me50j444EjqGAqzygcIBZHZdm1tORwm7ZVFB2oUuislsMchBESNBJQVWBv23lEi+lk6uYlM0Ofks7e7A+wTps42j2R8BdcYkCQnOh594TeAna8ZrchZ0yh3bhJnqOkU5HHQIGjBTB2qNqEaeOhjs53IvqLyqIU9fJ8p97VB+KxsxDA5eBEqElIqzn3I6+U4fXxGqfAxw9wPW6N9HMWLvTKu6qSdNEutki9VHEirQaAGjnawuvW9kEpalD5pBIklps8XweWz9TTt6I0/Ga0QYbZRxBUBFNGieOePDe4/DyMThdaC0E4ohf2FEQEFFTwODCXaQLayWVLQk5yRcEBRFzgliCeHob0++/gMV0nBlkAv79kPy0oQfsmA0yw3z7rg1qNNDPEdAOjpbfQ4TzG5iyj6QsLeF/x/h3AltpPp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:58:37.8356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fd7edb-8d2c-4558-2760-08dc5fafa581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
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

RDMA device with limited scatter-gather ability requires contiguous VRAM
buffer allocation for RDMA peer direct support.

Add a new KFD alloc memory flag and store as bo alloc flag
AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS. When pin this bo to export for RDMA
peerdirect access, this will set TTM_PL_FLAG_CONTIFUOUS flag, and ask
VRAM buddy allocator to get contiguous VRAM.

Remove the 2GB max memory block size limit for contiguous allocation.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c     | 9 +++++++--
 include/uapi/linux/kfd_ioctl.h                   | 1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0ae9fd844623..ef9154043757 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1712,6 +1712,10 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
 			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
 			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
+
+			/* For contiguous VRAM allocation */
+			if (flags & KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT)
+				alloc_flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 		}
 		xcp_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ?
 					0 : fpriv->xcp_id;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 4be8b091099a..2f2ae7177771 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -532,8 +532,13 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 
 		BUG_ON(min_block_size < mm->chunk_size);
 
-		/* Limit maximum size to 2GiB due to SG table limitations */
-		size = min(remaining_size, 2ULL << 30);
+		if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
+			size = remaining_size;
+		else
+			/* Limit maximum size to 2GiB due to SG table limitations
+			 * for no contiguous allocation.
+			 */
+			size = min(remaining_size, 2ULL << 30);
 
 		if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
 				!(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 2040a470ddb4..c1394c162d4e 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -407,6 +407,7 @@ struct kfd_ioctl_acquire_vm_args {
 #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT	(1 << 26)
 #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED	(1 << 25)
 #define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT	(1 << 24)
+#define KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT	(1 << 23)
 
 /* Allocate memory for later SVM (shared virtual memory) mapping.
  *
-- 
2.43.2

