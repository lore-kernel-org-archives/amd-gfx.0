Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B97CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F94C112DBC;
	Mon,  1 Jun 2026 05:51:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XVvbuksy";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A159C112DBC
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:51:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzRhgq+zYiUJzVkGA/XW9NJykUdBQO4sTtYzCOV1RqAYtl7yJUQ/3Nm3zq/jRwXDLZx9B9exjF7xFelxecv7oV3qgPg8gsgr8AbbzsLgTJltfYkwD1OW4ZsmcS5lz+IRNCe2za5C0OqoH1SKXYmux4DlpmWonX8IGz3LwrN78aD33SiDDwYjL3LE6wrp9GH3ucX2aZtAdaV9OzHHYS1Sg0yoNH8lsT1WvUuCFmDkvHvyIAR2IrBIm61OKJAJtDqSrXqAzG+UfBIMbUClNGT82kQ6HkQEja3MjQ/uUdibYycrgiBmpI0Amw+H5heapMYRT8+XpSAjVkcdn/mSgis2Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gn6m5M6sce6lD7L0aWtyai4X9s911pxtfyMwd+ol7GU=;
 b=GLFPmqdCmeN0PuftV35HS95oJww0Ff1K5LljGrYQ/3zNQ2nrzQCdcebzeb6WVQMxBUGBpcGxFnlI5Ue6MXD6/Vcut1vfOl3H+JDOHJ+Qexbjf9XQILd7chk4NqVGAvuRcLL3Qu0ZanG41jNFr1OZFw1E4Z4gWZXJSMAWcSpEGjx2wJzjtF5+FUdkC1hMFomd12ou64zUW5yaBuNQ0pPWorJTP4U6oKOFr8FyOX1h4nSyrQP1CipkwKxPjwaIHOUMn9ydlqlH/VcZ6rr+q0rqkDFOHG5Gi1QnbtcLCol01smb14engdkn8Z+Af8ODwONGvXBAQh4YwuuSPoQPbJdI/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gn6m5M6sce6lD7L0aWtyai4X9s911pxtfyMwd+ol7GU=;
 b=XVvbuksyuY5wd0rBZ0t+hAEW0j0jWxMzZibJJFvJc9vzNQGdFQrEls9EyG1Q5TxLC3EG+Dxi5tgVb5sttiVYjgdHHvp2bEvBSl0QC3ia0bV7UoOGvtLEwqeWG/DrJM4yuc2BZFndZ0cyFJER1o8kW3wubL6BRLgb+Q37HDmwMsk=
Received: from MN2PR08CA0012.namprd08.prod.outlook.com (2603:10b6:208:239::17)
 by IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 05:51:04 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::49) by MN2PR08CA0012.outlook.office365.com
 (2603:10b6:208:239::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:51:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:51:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:51:01 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:50:55 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 04/42] drm/amdgpu/fence: add helper to extract the guilty
 fence
Date: Mon, 1 Jun 2026 13:48:50 +0800
Message-ID: <20260601055034.3700921-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|IA0PR12MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: da5dd7d3-ebe4-4d90-0aa6-08debfa1c40b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|3023799007|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cf6zkN8V35uiyhxycfszlXEUeCWATtuJWd1ZnVCtADCjquKAIljJfi6+a/jknu055xUgg4bB197BML60mvvuTF3ifFXYfCq83ecJZJRr+JUJiGStBvLJpwd5gab3CU1YH6K7paijfWOsoxQME9I5kr9POPt/AeR6H5wwiVB4MOkwOFNcSOCroEM+V9Hd1tPmDp+k2l5ORgUm05nB9NB6oihecWvAqikUiAG2bN9OCSipE41T1ln4GWF/bawztnpb6570IoRYRVV2zoQ2lIp9960aNuJzFlQmzzoWujNSt+s4hK4EcBXF+7GUZN5jCSi3YwMbPbD3/6XkgGLnVbw+GqUkRq1X3jb/DH2TmwPOX+MpXBd1KQmmRrxdiwlnX2ueIFG8UTx9p6n2q2ead76YimemukXFTN+RqfwRZWpB5YiohqngAwa5mvYK4SiQRLSsekSPJPPlaXzirDvW0Pwd+rBWMAZ+uAw3xyziGaB3XtsX0rsDS9d5A00i8cEuP4jtp9x980fynoeo+YpzzDi0CX6GaOE3/63I31OGGZ8ydWSkS12FemU82WubCibFEy+EfAcjyvmOywhYS1A8nUp6s34HQCey6dWTn3yyy4JSGjywkbLjJe0H91cGfHbhOSRq/R3oLUyuvjGUTiHkNOgLaZdZfQznlVr2bsexfo/KdPKlHBaJMW2D6e8ljvKedEJAz4YNYmFSF7SGwOH58WxsPoIqgykIrUPYNme6QeIE7gI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lr4DTGV4q/Mi+87u4T5+VS0swIyZ5rtkQ9t++pgdDraF35Guif+jVUI3l7RGPnvDjGiBUombik8c9VNqLWwAebL8W/DwowGW9DEDMJuywTmbbL7eTTxXAOGaruz0SMeoeT1jCxaNh+OSfCVhRdtGKZJk3OJz/nY3XhinTa6U0/qg0pTMn0YXAGhCTa9u83zwPIfcrq89epeA+WBW69ChoqeoG+YCDPjqbjOT/m+7LosOUX2/ER7dz0jIaD7VP7+fazOfrNagXa9N6Skg1NJCpj1t5AotoGPa8MBz8zLOpfm71huQM1Fpvkd2djLcDNR7x9UonGj/fmzPsxIHJm0PTrYJBlpTgT3x/lS7jA55dxGLEJ6Etjc9SqGqt375Q1kyceKf/DeWtmKerjqvPIZ/9l6JRtu91EBcQ2yOIlgPfWd7CyGQmUn+MjgnYushmBuy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:51:03.2330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da5dd7d3-ebe4-4d90-0aa6-08debfa1c40b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723
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

From: Alex Deucher <alexander.deucher@amd.com>

Add a helper to extract the first amdgpu_fence which has
not yet signalled and is thus guilty or at least collateral
damage.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 31 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index a7a6db0bc694..733e9b668ed8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -831,6 +831,37 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 	} while (last_seq != seq);
 }
 
+struct amdgpu_fence *
+amdgpu_ring_find_guilty_fence(struct amdgpu_ring *ring)
+{
+	struct dma_fence *unprocessed;
+	struct dma_fence __rcu **ptr;
+	struct amdgpu_fence *fence;
+	u32 seq, last_seq;
+
+	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
+	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
+	ring->ring_backup_entries_to_copy = 0;
+
+	do {
+		last_seq++;
+		last_seq &= ring->fence_drv.num_fences_mask;
+
+		ptr = &ring->fence_drv.fences[last_seq];
+		rcu_read_lock();
+		unprocessed = rcu_dereference(*ptr);
+
+		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
+			fence = container_of(unprocessed, struct amdgpu_fence, base);
+			rcu_read_unlock();
+			return fence;
+		}
+		rcu_read_unlock();
+	} while (last_seq != seq);
+
+	return NULL;
+}
+
 /*
  * Common fence implementation
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 9276a3bb69de..71cd9bb12f75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -589,6 +589,8 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
 bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
 void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 					     struct amdgpu_fence *guilty_fence);
+struct amdgpu_fence *
+amdgpu_ring_find_guilty_fence(struct amdgpu_ring *ring);
 void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence);
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
-- 
2.49.0

