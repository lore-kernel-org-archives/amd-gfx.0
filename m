Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CF1EB64DB
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 17:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E232610E2FF;
	Tue, 20 Jun 2023 17:16:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF78710E2FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 17:16:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjfCorUN/3LGfWNsfEhsHxjna2QFIlHHEtnd4/9gJMpZMQIul0F40WEqD+F3fWYVdvk0mPCLJIGdFkoZsWdvpDJQndMo4AuIR0i28hkeyB3hhFRos+bkZo9ROMTxLivqkBxdNCVVbENDagCAuYjuc8vn9AN+BRz2wtEv3SdWJOoqHX+2odxbcyuDfw31SwS14tcIYjRoPLpTPwC2mMvp9w5Zbq7bSa7Djaaqrm4nivWq/SnuKz8VnpQiye3IIZyJ0yWP9iSz11qwIKHVRQsZUx8XvtnwrTxUfnOP5imz9R4ET2C529Rhqa/SkRE7e3/OFLTzIrXPzJWZwSn1ximxpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1dz5Eo2N93vzc35XA3cngyO7rqgdvRr4pm2JCdhdnY=;
 b=JfAFm7/vtcoA9wBpxigF7lYRF9RS1nIHm0xkx7o48RqSPWRFAfMyTE7kL9CgNvsnHRvZKj2gieD56P5S2vFAoqvbZJuxEWqx+YEDSuWvcOcNDH2bez0sl1iVSxYhu+mukFMleJw9GgLZz0hf+sDlJrbWGqXC2Zs4XS5Hf0HQ6vkTCRDeOUQaJnHEevDhrIi4auU+ed+AP3n1M7CZ/DSbrKHxQT/v3VvdKFL6O8rKhyvo45OQZ4xeXLk8TT3UpWSR8V20U9vdt3HAHw2jPxiLXn0ktP1qw6+PC7bQzr9eK6E3vk3UB2Sdezsh72jCItSYouxjkir9OJULhM/EI8Sl/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1dz5Eo2N93vzc35XA3cngyO7rqgdvRr4pm2JCdhdnY=;
 b=v1L4NCx5MjNA6Cg8P4NDXf8C57Wh0Vs8xNLuzWs1r3VzVbkkII2ozg3xp6FgIop1NPDWk9u9uQ6hRfOtBLixmqw9jbOoV3JEdQcsbw4S3dwnd2B4QzCVhkpeiI9xdIWhPSha8hihM/XWhuMFK9E87duuped6TbMAnnWPeNE+4Pg=
Received: from BYAPR07CA0056.namprd07.prod.outlook.com (2603:10b6:a03:60::33)
 by CH3PR12MB7498.namprd12.prod.outlook.com (2603:10b6:610:143::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:16:30 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:60:cafe::1d) by BYAPR07CA0056.outlook.office365.com
 (2603:10b6:a03:60::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 17:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 17:16:30 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 12:16:28 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 04/12] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Date: Tue, 20 Jun 2023 19:16:00 +0200
Message-ID: <20230620171608.2131-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230620171608.2131-1-shashank.sharma@amd.com>
References: <20230620171608.2131-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|CH3PR12MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 93fa5e9c-9e1a-41c6-53a2-08db71b216d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: quunYjvWKH93XtcdEHWsnhcBlP85qCRhjvp/h7H4/QpaaBs+JjVy2DjMTyxLHA4B22rcyrUmgoyLxM4Vl3+XolzK1KFfKff7Xp2U6F8/gSFbWVRoeOPyPmb1AZwGj9hR5z3URGcSsZQ+LFxnqdy6sl76s4VywujvLHePijpiuB267T9OKw7Z07C7s0KQ0Svm7os4MRr7IAxg8pqZjzLTwZoxKgGic22AhGZsLxZ+0+Hgzh5yHzDCaSxXTjDv/vfZMgjFF5ucQmdE2yYIyHDEBvqEWF9ujoo/vUhs67FDF3JPg6NspIEMW7DKB4bv9SfmRRrxs2lk8S1WFk5Pv/yYCbk5sj6ebOgrP60+48GgIMhm/oaA9+wn+QxKFClRG1jw3lGkxs0RgCVQ3v9cMAhzRj6iGshkaVaJTOVG5EILn6ly7PNaUnGPjST+Kto8JJhaowlVcx+aXmNwRUqYQ8tVtciAUKRunLzOnvvqED2Y5KTcAfnxoCWTxlS7m79ys5f2kKjs+6x8KqQMDD/zbCKlc6EiaQAM221RoXJ1BRfJCqzP+qe3jUnfNFmX8X9aKvmrnwsBbpRgh60cEUraKBM6zlhiwvxJGZXTp2u6gYvy0LYe/yscUBllmKUYZ8CakjCpip/PBevUTHvabK+0NXwCq+KFZUEbAfmV+qvzbv59ZcfZQ0sUXKHwtm2jxWB4uYId7jfGTNrLn8E+dIalMUFzeYhewkqEJRhTJhIFbxk67tRzpNzP0ToWQLHNEBtLP2QAVS7fRTxxpbgbCyTGK7QC+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(478600001)(40480700001)(2906002)(40460700003)(54906003)(7696005)(6666004)(2616005)(81166007)(356005)(47076005)(426003)(86362001)(336012)(82310400005)(186003)(26005)(16526019)(1076003)(8936002)(8676002)(70206006)(70586007)(36756003)(5660300002)(316002)(44832011)(36860700001)(6916009)(82740400003)(4326008)(83380400001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:16:30.3210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fa5e9c-9e1a-41c6-53a2-08db71b216d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7498
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
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This patch adds changes:
- to accommodate the new GEM domain DOORBELL
- to accommodate the new TTM PL DOORBELL

in order to manage doorbell pages as GEM object.

V2: Addressed reviwe comments from Christian
    - drop the doorbell changes for pinning/unpinning
    - drop the doorbell changes for dma-buf map
    - drop the doorbell changes for sgt
    - no need to handle TTM_PL_FLAG_CONTIGUOUS for doorbell
    - add caching type for doorbell

V3: - Removed unrelated empty line (Christian)
    - Add PL_DOORBELL in mem_type_to_domain() as well (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     | 11 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h     |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h        |  1 +
 5 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 3b225be89cb7..6c743b03d182 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -148,6 +148,14 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 		c++;
 	}
 
+	if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
+		places[c].fpfn = 0;
+		places[c].lpfn = 0;
+		places[c].mem_type = AMDGPU_PL_DOORBELL;
+		places[c].flags = 0;
+		c++;
+	}
+
 	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
 		places[c].fpfn = 0;
 		places[c].lpfn = 0;
@@ -467,7 +475,7 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 		goto fail;
 	}
 
-	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
+	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU, _DOMAIN_DOORBELL */
 	return true;
 
 fail:
@@ -1012,6 +1020,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
 	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
 		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
 	}
+
 }
 
 static const char *amdgpu_vram_names[] = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 35b8106816a1..710bbcbaf98b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -173,6 +173,8 @@ static inline unsigned amdgpu_mem_type_to_domain(u32 mem_type)
 		return AMDGPU_GEM_DOMAIN_GWS;
 	case AMDGPU_PL_OA:
 		return AMDGPU_GEM_DOMAIN_OA;
+	case AMDGPU_PL_DOORBELL:
+		return AMDGPU_GEM_DOMAIN_DOORBELL;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
index 5c4f93ee0c57..3c988cc406e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
@@ -90,6 +90,7 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
 		cur->node = block;
 		break;
 	case TTM_PL_TT:
+	case AMDGPU_PL_DOORBELL:
 		node = to_ttm_range_mgr_node(res)->mm_nodes;
 		while (start >= node->size << PAGE_SHIFT)
 			start -= node++->size << PAGE_SHIFT;
@@ -152,6 +153,7 @@ static inline void amdgpu_res_next(struct amdgpu_res_cursor *cur, uint64_t size)
 		cur->size = min(amdgpu_vram_mgr_block_size(block), cur->remaining);
 		break;
 	case TTM_PL_TT:
+	case AMDGPU_PL_DOORBELL:
 		node = cur->node;
 
 		cur->node = ++node;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2cd081cbf706..29066e9a3439 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 	case AMDGPU_PL_GDS:
 	case AMDGPU_PL_GWS:
 	case AMDGPU_PL_OA:
+	case AMDGPU_PL_DOORBELL:
 		placement->num_placement = 0;
 		placement->num_busy_placement = 0;
 		return;
@@ -496,9 +497,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	if (old_mem->mem_type == AMDGPU_PL_GDS ||
 	    old_mem->mem_type == AMDGPU_PL_GWS ||
 	    old_mem->mem_type == AMDGPU_PL_OA ||
+	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
 	    new_mem->mem_type == AMDGPU_PL_GDS ||
 	    new_mem->mem_type == AMDGPU_PL_GWS ||
-	    new_mem->mem_type == AMDGPU_PL_OA) {
+	    new_mem->mem_type == AMDGPU_PL_OA ||
+	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
 		/* Nothing to save here */
 		ttm_bo_move_null(bo, new_mem);
 		goto out;
@@ -582,6 +585,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
 		mem->bus.offset += adev->gmc.aper_base;
 		mem->bus.is_iomem = true;
 		break;
+	case AMDGPU_PL_DOORBELL:
+		mem->bus.offset = mem->start << PAGE_SHIFT;
+		mem->bus.offset += adev->doorbell.base;
+		mem->bus.is_iomem = true;
+		mem->bus.caching = ttm_uncached;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -596,6 +605,10 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
 
 	amdgpu_res_first(bo->resource, (u64)page_offset << PAGE_SHIFT, 0,
 			 &cursor);
+
+	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL)
+		return ((uint64_t)(adev->doorbell.base + cursor.start)) >> PAGE_SHIFT;
+
 	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
 }
 
@@ -1263,6 +1276,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
 		flags |= AMDGPU_PTE_VALID;
 
 	if (mem && (mem->mem_type == TTM_PL_TT ||
+		    mem->mem_type == AMDGPU_PL_DOORBELL ||
 		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
 		flags |= AMDGPU_PTE_SYSTEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index e2cd5894afc9..761cd6b2b942 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -33,6 +33,7 @@
 #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
 #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
 #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
+#define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
 
 #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
-- 
2.40.1

