Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80328C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 20:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00C9A10F3EF;
	Fri, 21 Aug 2026 19:35:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QZpNypMr";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C5B10F3EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5Pw0Jg5VYE0pZT7NpcQiDQs/7pmiw6MyZtaOd0kBRkXfh8zwSpWlLj3dEd8E57Kbzf0hXc8O8amidTIRl0qhEcJutRMqx8JwhN5mZ6t6UnDjYkVv51X3iQpnUKeBOObrWKL+mGSE08QEJ0JmJF5ixW8tbFekVM0GbMnmHCPBqcoouG4LDKguv6yWyLiAdV+pdVeKzMrCojfMKwOGoH965jSJy/kyShlJiuTqQXQ/cjaG/rWEZh8mb2LUYPGT9aoDzlh/nCUxiAA8VHYnmwTfEvEexSNH4/SvgeqZRkOkzpYz8VCZIa2hXqt+0LMShdY0PcylT1yEqm30gfUkGoO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfnPsP0cQsPu+niL/GDySybevOhEOZFGjF2ZAp+hEQY=;
 b=IWdSGW4hxOmVH/hQ9UwKhFtR7TvnH1IZauFPM7oCMWV24btH/T6pI97yGbhLYUxIB+5J4wl39ZgTxH/5/jFczm85IsmWa/gD+tSPg55FyJmzAuZGj1zUmFDK7xq01um5dNZ+yIFJ0OsxQXPV2h7Cc710H81AWJi7iLyWSRBpB8W0Mi/KnzwwIrzvshyNaaFW2ocyM/D6oCQHtD6QBQlFNwMQMt9x78W76+mpXHyyxAPwOx3O5EWfJ7t3umWnuR4J3CQW4pG7nDZyNiL++LTI9OAG5J+12F4BAPbAN8BF1VfccYMbjn9Z77O9D1BrpQMNWhwTPKfGib1/Bz3d3ljKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfnPsP0cQsPu+niL/GDySybevOhEOZFGjF2ZAp+hEQY=;
 b=QZpNypMrjC5eRJOyQRj/NK9IJCoE9AijVBrVyXs2uztDwmI5X4yWEF/uyLl7V9ZMb8D1e6iiSqKC++TKTjAABrrgd6UgKp6NRdi8xDYKi4pyoWLbEzY4uAiPCf8rNJH+3eJgRqVvaAjIjWBgfHqEStm1WPkuDVlNOfsGm0FqfgY=
Received: from CH5P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::26)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:30 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::a5) by CH5P222CA0011.outlook.office365.com
 (2603:10b6:610:1ee::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:25 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/95] drm/amdgpu: Add a new NPA Address space
Date: Fri, 21 Aug 2026 15:33:46 -0400
Message-ID: <20260821193458.808626-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SJ0PR12MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a10bdd8-d450-4481-ac5d-08deffbb5c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info: Px/BBGyaijM0bSPhJINzDKYP53oV4iW9zQmf69uJAm/qYxTg0tIwgriVwFLRsajUkCQLFipyOMKigLoa2Fi/f3brcPrskP8Uxy19w8bud7S3IqWO2oyuDhOaTJsiyF6nCF2IN3HJvUlnXSpEOrOTmQqIPNrPD2lVxWNHlSiz6oP05wuS7nBKtWUuZQSYY+3XbBuBEHtoeVbafcpF3yz8aDU369ZGDz6c7ZnAIH3UYdKUQmSpd0deuaWhtTDi5RQ65LDiM3BmGgu1RFTVBdN1PYhx8V/RAxH+RYEeY5mvFX4OfH3Z4hPY9WM/maxah21w47Yk+pDsbc9HWcliu6GQi72kxMeg6FwEcVigTJMqUW0UDMzOAEXNTJBTTiP+2HTD6CRB3G33daK7ptZBTYmryWBwsxFy8VYk5nKoZ87xymq+fMXlcTA1mIDmBACDeVaK1K7tq/O6mmiC2zT0vsQu9qMMUNLAq/EbY2Af7Lb39Y47BOvq52Ixr6+cVVVrd0QOoks6MRFkkQj5E8zofq1kV8rJsjT5SB3RHq7VmYhmNKfWRT/I6FZn+hFiVWC2DbfXLqjUrd0zUoeHnb2srOZB7/uXp70xZfwxkm+2NquOa1U4/lk4zM1S4RIm8Y/tPqTvLSX16IgtDvDNsdEQuel1W+9N+Fac6nwI6iuIC7sk4mAD+M6nNJo7b4R/6UEjITF+rI5i1bCw84Fc5wqghvqnKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PW7TJYyLd39dfD+696O0tEKaarNoUkW2yqrriOb47mMKRE8TJI1Ibpv+lqYOYYPZRv2f+lYl0OCbgzVz9+fn9iA1jF2cgqKIfL/SDz2h/gVluD+2dK0HQE8nFs+DjziPaPGoAfAO8jrimLGG79AwdBGjFoONvcF3eVkWvOR+7CNCUXHXIZUqjV2QEayotKr1eKBaFYAPAN7QwnBTOuhFY9JtX0Sg4EOcFQz43HlvFVUETX8nuYx603m/hILcrHYaq8mi6/j+0YzjOSvzIsjH0AKbXBss5LLcu8Kq7vrgFz9fNnqGzcM+e/uRqnW8xTzM/eYvLIxmIP0/D9LQr0ytURXb3VToUdC1YyNkbCobVJTJUuM3qvmCxeAq1rud36oodu3j8J2vdEoh+An0TX/iRwSza80MUWqd0F9cklb2mtZOF2HQIDXW2/iyP8yjAcH2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:30.2231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a10bdd8-d450-4481-ac5d-08deffbb5c1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add a new address space for NPA address management.
This is needed for sharing buffer objects across GPUs
with each running their own OS. The NPA address space
size can change across different HW generations so the
size is initialized during early init of the driver boot
up process.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     |  5 +++++
 include/drm/ttm/ttm_resource.h             |  2 +-
 include/uapi/drm/amdgpu_drm.h              |  6 ++++++
 8 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 5d9d137209b6f..fc6d3fa62d794 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -204,6 +204,14 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 		c++;
 	}
 
+	if (domain & AMDGPU_GEM_DOMAIN_NPA) {
+		places[c].fpfn = 0;
+		places[c].lpfn = 0;
+		places[c].mem_type = AMDGPU_PL_NPA;
+		places[c].flags = 0;
+		c++;
+	}
+
 	if (!c) {
 		places[c].fpfn = 0;
 		places[c].lpfn = 0;
@@ -1663,6 +1671,9 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 			case AMDGPU_PL_MMIO_REMAP:
 				placement = "MMIO REMAP";
 				break;
+			case AMDGPU_PL_NPA:
+				placement = "NPA";
+				break;
 			case TTM_PL_SYSTEM:
 			default:
 				placement = "CPU";
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index ff11a09034997..b41767c7913ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -169,6 +169,8 @@ static inline unsigned amdgpu_mem_type_to_domain(u32 mem_type)
 		return AMDGPU_GEM_DOMAIN_OA;
 	case AMDGPU_PL_DOORBELL:
 		return AMDGPU_GEM_DOMAIN_DOORBELL;
+	case AMDGPU_PL_NPA:
+		return AMDGPU_GEM_DOMAIN_NPA;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7a46a26a5fd34..bf575b05a4124 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -129,6 +129,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 	case AMDGPU_PL_OA:
 	case AMDGPU_PL_DOORBELL:
 	case AMDGPU_PL_MMIO_REMAP:
+	case AMDGPU_PL_NPA:
 		placement->num_placement = 0;
 		return;
 
@@ -580,11 +581,13 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	    old_mem->mem_type == AMDGPU_PL_OA ||
 	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
 	    old_mem->mem_type == AMDGPU_PL_MMIO_REMAP ||
+	    old_mem->mem_type == AMDGPU_PL_NPA ||
 	    new_mem->mem_type == AMDGPU_PL_GDS ||
 	    new_mem->mem_type == AMDGPU_PL_GWS ||
 	    new_mem->mem_type == AMDGPU_PL_OA ||
 	    new_mem->mem_type == AMDGPU_PL_DOORBELL ||
-	    new_mem->mem_type == AMDGPU_PL_MMIO_REMAP) {
+	    new_mem->mem_type == AMDGPU_PL_MMIO_REMAP ||
+	    new_mem->mem_type == AMDGPU_PL_NPA) {
 		/* Nothing to save here */
 		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
@@ -2277,6 +2280,16 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		dev_err(adev->dev, "Failed initializing oa heap.\n");
 		return r;
 	}
+
+	if (adev->ualink.npa_size) {
+		r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_NPA,
+					    adev->ualink.npa_size);
+		if (r) {
+			dev_err(adev->dev, "Failed initializing NPA heap.\n");
+			return r;
+		}
+	}
+
 	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
 				AMDGPU_GEM_DOMAIN_GTT,
 				&adev->mman.sdma_access_bo, NULL,
@@ -2330,6 +2343,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_MMIO_REMAP);
+	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_NPA);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized = false;
 	dev_info(adev->dev, " ttm finalized\n");
@@ -2712,6 +2726,7 @@ int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type)
 	case AMDGPU_PL_GWS:
 	case AMDGPU_PL_GDS:
 	case AMDGPU_PL_OA:
+	case AMDGPU_PL_NPA:
 		man = ttm_manager_type(&adev->mman.bdev, mem_type);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index af1e7fcc71756..adb6cfae50527 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -37,7 +37,9 @@
 #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
 #define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
 #define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
-#define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
+#define AMDGPU_PL_NPA		(TTM_PL_PRIV + 6)
+#define __AMDGPU_PL_NUM		(TTM_PL_PRIV + 7)
+
 
 #define AMDGPU_GTT_MAX_TRANSFER_SIZE	(1ULL << 22)
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 1cdf670673573..fe05e584b82e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -129,6 +129,7 @@ struct amdgpu_ualink_connection {
 };
 
 struct amdgpu_ualink_mgr {
+	u64 npa_size;
 	u32 psp_if_ver;
 	struct amdgpu_ualink_info *info;
 	struct amdgpu_ualink_ppod_setup *setup;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index b4570bb276d1d..cc4e939cb3f37 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -3190,6 +3190,11 @@ static int gfx_v12_1_early_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_init_rlc_reg_funcs(adev);
 
+	/* Set NPA address size here as its needed in amdgpu_ttm_init().
+	 * NPA address space is 52 bits or 2^40 pages long.
+	 */
+	adev->ualink.npa_size = 1ULL << 40;
+
 	return gfx_v12_1_init_microcode(adev);
 }
 
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index a5d386583fb6e..f5d1ad7a4efc7 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -35,7 +35,7 @@
 #include <drm/ttm/ttm_kmap_iter.h>
 
 #define TTM_MAX_BO_PRIORITY	4U
-#define TTM_NUM_MEM_TYPES 9
+#define TTM_NUM_MEM_TYPES 10
 
 struct dentry;
 struct dmem_cgroup_device;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 0a113529bdcbc..d6d5402a1e789 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -115,6 +115,12 @@ extern "C" {
 #define AMDGPU_GEM_DOMAIN_GWS		0x10
 #define AMDGPU_GEM_DOMAIN_OA		0x20
 #define AMDGPU_GEM_DOMAIN_DOORBELL	0x40
+#define AMDGPU_GEM_DOMAIN_MMIO_REMAP	0x80
+#define AMDGPU_GEM_DOMAIN_NPA		0x100
+
+/* User-mode is not allowed to allocate NPA space. As a result,
+ * we don't add AMDGPU_GEM_DOMAIN_NPA in the DOMAIN_MASK below.
+ */
 #define AMDGPU_GEM_DOMAIN_MASK		(AMDGPU_GEM_DOMAIN_CPU | \
 					 AMDGPU_GEM_DOMAIN_GTT | \
 					 AMDGPU_GEM_DOMAIN_VRAM | \
-- 
2.55.0

