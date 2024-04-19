Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2F4C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 16:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05DBF10F97F;
	Fri, 19 Apr 2024 16:24:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F7mmK4PB";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14AAB10F8E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 16:24:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfdDUGhdYuUdKdGMLfJ033Zr324Eoxm086IlGasUATm7P80bOI06eMc+VOKt7MREtz4YLJEqoKnoizAGZ2MR8V6zvhNetsNvVOBvuM0n9MpGdxeExzdSwclx+kKPU8k1t58hKuGPGG23H9pj42kke61XoAYRF5RPTLRw0zWpAZzZ3sEJo5yMeHrASsIVp2xbJ5RYXKgo7XuoEcJFUeFlup+MdYL1ebdYoytOmfbo99Np2/VEPUJla4lDb7zOOzPvVHGPz6Y6xNAWwnQIBNnD2i72S3x3d06UApp7J5jy5gw6TP6L4/JPaM5s+SF4mP/vQg1d0Rg+xEf7OzYEad9jXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWIkI9FmDc6SFiJS/iMV34i/Jm1/SjBdqQIWCZ3P+PA=;
 b=nBOE7TqQjlkgHpwbIcMB8XI46pNbSdNy7Ci3KS2EzidD+lADhY1q2kH3e3gNHUaemjD1R+TutbmBuGZMSLuiW5TYoJVunRYetF7HqRPrGYJRytn0RS5uq1tJt7Zw/Ef8UZ78vrVhGFKZAPQ+MkAZlET49xnBkxHJ2zMO52L8uUFXoeBrUvxZi0yZATewRQERI8dx6/rU9o71qtc9HIgDrKIrSFCfl49rWEB6sWPpe7lbNVYwRuEpbTxA2tfqP5eUwGTOSI/TJXMGOka7IbVipAxlqwMWetmK6mAmsI8on48mN/BhVTBNMY3GvBv4HYtjZWvpVLgF3JtKWAE3Fq3kJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWIkI9FmDc6SFiJS/iMV34i/Jm1/SjBdqQIWCZ3P+PA=;
 b=F7mmK4PBjmG1dudAlbjTtNqH5v9x3KHXIEV3d3sg8buhiBVE3+Cr4F05U7K07EEF50FLnsRX4jcOh4FkYtaDauhxbzYUKGIrxMfkgFLTMxDIyWVe/FJNit7aYwKSSKyTqKogMBCuta49ijXmGaMxbTjdS4t3SuThbXYkvFkTuVU=
Received: from MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Fri, 19 Apr
 2024 16:24:47 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::98) by MW4PR03CA0041.outlook.office365.com
 (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.26 via Frontend
 Transport; Fri, 19 Apr 2024 16:24:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 16:24:47 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 11:24:46 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdkfd: Add VRAM accounting for SVM migration
Date: Fri, 19 Apr 2024 12:23:50 -0400
Message-ID: <20240419162350.1284651-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b24e4c4-fd13-478d-b3a5-08dc608d3b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1eOJu3QldfeEIh/HZoNZoIgVmuJpLkY8tQY+4KvUg/6yJ6Xyna2qqiszcFkJ5EMQS8d/RFGNLvNAgqR0kghfIs7sW4wJKAAWNtaAwp2O95HOPKfjGCZT1iI0QEh83U8bzWvY+nOELjnBfjm59g+kibsT4oA8jpis0VpW0AvXIu8zM+xZ0qK8L0shIWActutkChyXxsYOcf6o1l7EI3eyeqDp8EcDg+NrQ/d2EGPB6P+j9zPvMaIYt811vm38EGslkCfZSVP6utvtnJC0fWn/gsifAxIupo9FYMmUBlvaqYMoCB0Y3pqxfqYs208t6ytzqs2/4lvsXqekntfVMIDKR3pq20TQjwCa05nZZFROORWsLMVrYW9h/ULrvldUZwHtpUKlJXml9wF8zXzaak9VfNFbC4Xa6iAR/jXgSWQTCkhluIUzepWkol/ReaakY6tnzwrgZn3DuMusFMsA+OhntT+q0tBfcjZn97BR7KWCShQY1TucQqN+w+ZN7Z7N1hdmBsp3QxoOvvlBXuvuSKXT7O6zs/z5zgUfpWwsc8ejJNB9ALzay3nJgtON3qyBo9ykOwqBBlc2EKTgmTSoDzKzQdouidEH+6VHrTzzT1TugyElyVrZIs9A66OCAHCCOZk+k+2i/CKk2m6p7FTE73rMjL1vVe/0bv/BT5GY3+TwIamKLwssZ3ujFBIXsKt44CyJ9G5aUZjpbfPn0iVcwJ1svKxx5ygoBqLxHlBco1P5sIVkqF2ZkyXMJWTg9J9tLOv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 16:24:47.4964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b24e4c4-fd13-478d-b3a5-08dc608d3b0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108
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

Do VRAM accounting when doing migrations to vram to make sure
there is enough available VRAM and migrating to VRAM doesn't evict
other possible non-unified memory BOs. If migrating to VRAM fails,
driver can fall back to using system memory seamlessly.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  2 +-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index bdc01ca9609a..a6bfc00c0310 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -509,10 +509,19 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	start = start_mgr << PAGE_SHIFT;
 	end = (last_mgr + 1) << PAGE_SHIFT;
 
+	r = amdgpu_amdkfd_reserve_mem_limit(node->adev,
+					prange->npages * PAGE_SIZE,
+					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
+					node->xcp ? node->xcp->id : 0);
+	if (r) {
+		dev_dbg(node->adev->dev, "failed to allocate VRAM, size exceeds VRAM limit\n", r);
+		return -ENOSPC;
+	}
+
 	r = svm_range_vram_node_new(node, prange, true);
 	if (r) {
 		dev_dbg(node->adev->dev, "fail %ld to alloc vram\n", r);
-		return r;
+		goto out;
 	}
 	ttm_res_offset = (start_mgr - prange->start + prange->offset) << PAGE_SHIFT;
 
@@ -545,6 +554,11 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 		svm_range_vram_node_free(prange);
 	}
 
+out:
+	amdgpu_amdkfd_unreserve_mem_limit(node->adev,
+					prange->npages * PAGE_SIZE,
+					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
+					node->xcp ? node->xcp->id : 0);
 	return r < 0 ? r : 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f7d75b432cc6..bfab16b43fec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3426,7 +3426,7 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 				mm, KFD_MIGRATE_TRIGGER_PREFETCH);
 	*migrated = !r;
 
-	return r;
+	return 0;
 }
 
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence)
-- 
2.35.1

