Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1446EC77B6F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 16:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B16110E8A6;
	Wed, 12 Apr 2023 16:26:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A572A10E87F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 16:26:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bq1KS5PHjj9yR12usP+jh6QuZkHnKucbMWnsmT9vIET+6C2Acvmz7mAO9rCDDEDfs6NN0u5teHmLF1f19XY7fpcYWgpgLvw0EmU42NWqNIIXoQVPOI2fEsXjcfr6utw199HE2DgSHRhZCtWCsY/6L18M8GH13j8UEmaJv/vhi7zem3IAG/qUc3kF4+aSMDfGL3TnsRRdsiQvgm0Uq96OWSv9ybFzuqiiglT+LsQcxyROaTkZe04JrM0l2jPMuaXfyaP6QAVHfTbEt39lcxw2eQpVx3m61D7+H812HWtyxe0zVuhroVSKNgD8CX+uIwpKWVUPqixEjuIgqt+nZOP7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DA36wLeT5NiDN5UUiWqpLQn0khdrUoohAOTjk8/2MS8=;
 b=eQE5OjPjN6UdORHukrVQ/8J1/3gRYQVRA7amxmPJdiLJwopSe0i4/obCxo9HQ9uE/bMDq2y/cfPFFqbFauQYBv60N3wp2N5GtSLAGsLCnBZeXUURIRZNB1/FqGZI0A0Cn0BQePrbP6SIN6e1v3npOSmXy1ot8tXQnx/rR0N9MPGgAmxUCJe0J4DEmzBqQJBjfScr7wWLsCrNxqa5SayIoFgoN2ZcWRuRabWI88HXwOWByvXTfI59AfHBLmjo5P6OcsijUi2jLFqHgZnTHj6jwUTVKZYmtc4WErboIE+BL+eOulF+r0YKIAM80HE87h8DRBXEs0X8vCafChuyn0qj7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DA36wLeT5NiDN5UUiWqpLQn0khdrUoohAOTjk8/2MS8=;
 b=rPSea0zFi4JI5251J+4aHQ/ABWsEZ7F3xnOjmQvef0R/FlY+v0MuZazdFkRRVR6mEqu5OAnZ640EiFCzUsbWX2uPGRsZ4CtYIc2/nMybcqvRzCHIhPcN+ZALk/gtRvXpZkr3owrMrfl62Dek9DyvWNzfhQBJmJJVGM9ZfsJAI+I=
Received: from BN9PR03CA0427.namprd03.prod.outlook.com (2603:10b6:408:113::12)
 by PH0PR12MB7838.namprd12.prod.outlook.com (2603:10b6:510:287::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 16:26:29 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::a9) by BN9PR03CA0427.outlook.office365.com
 (2603:10b6:408:113::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.31 via Frontend
 Transport; Wed, 12 Apr 2023 16:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Wed, 12 Apr 2023 16:26:29 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 11:26:26 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 04/12] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Date: Wed, 12 Apr 2023 18:25:28 +0200
Message-ID: <20230412162537.1357-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230412162537.1357-1-shashank.sharma@amd.com>
References: <20230412162537.1357-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|PH0PR12MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: e08e7afa-d465-4c20-61e7-08db3b72ab6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ClKjXwxEBc67wnB3507op1RckU1ovROdGpUC8avu1R8LPxaQNaZ/1VJTXUgrTjg1+IfxVN1WWMZQmyuNjLPNb5f8n1moCmExUTR/n8vG7CTUEW+UXYRGe5xXIWaxdWF5os2VvPPUHv5P5DQ4eXPc9NfNXFA2UOc/czssG9dHuvZAvZyYvEcErOknXdlgP+nzWCPd9Np7CesABpwutW3EsnXzxPHxBV/haS8Ba4uXJwj1ro0I8Q9cbHhHnOobDz0xyunzpbme+QQL4Zx6Hy+XXMfHapLVXAs2hjTAT61ALOrkEi9Z1yTKvn3dv8lLax6fjAtyvW58/NYu7yeBE+pRnebXzKb/8v5vvPoBS9+n+5t82lzmauEbvSlb2lPv7sJ+NJPyRzaYPuqkyRxkVNdCE4YVcg5JnwoBjTLGw9DjxCV/iqBTIDQKmRYKTD5tkqBUrI+43sFgc96OY9i66fA128CBxYJQA3nvpxRT7U90jI2D/5bSL7o+09+nbMN4Sz4MBmfRdTA+9jJlCMy2wcFO8Ykdc44CK7pXuHC3kHqXTtxhX6lN8DUVEwJm9Z5vIyNy3fGMbjcBjFDEek7J3bn39xdn7CljVtlxqss971b5iJQozEwR955GFbzdAg0wGxIPGqIvx/OV8174HHklLkS7HRQaXIBnt/LEar7qEaEldlMN4kmyPJ2o2dcEzMGfPMi0Bx1bCpQlA44xm9TagFkl2pnCPlUfya/n269r4tAIDA0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(86362001)(336012)(426003)(2616005)(44832011)(8936002)(6916009)(4326008)(5660300002)(8676002)(316002)(70206006)(83380400001)(47076005)(2906002)(40480700001)(70586007)(82740400003)(36860700001)(356005)(36756003)(26005)(54906003)(81166007)(82310400005)(186003)(1076003)(40460700003)(16526019)(7696005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:26:29.0971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e08e7afa-d465-4c20-61e7-08db3b72ab6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7838
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
Cc: mukul.joshi@amd.com, Shashank Sharma <shashank.sharma@amd.com>,
 arvind.yadav@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
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
index 4e684c2afc70..b0fb2e1706f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -147,6 +147,14 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
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
@@ -466,7 +474,7 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 		goto fail;
 	}
 
-	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
+	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU, _DOMAIN_DOORBELL */
 	return true;
 
 fail:
@@ -1013,6 +1021,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
 	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
 		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
 	}
+
 }
 
 static const char *amdgpu_vram_names[] = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 93207badf83f..f546b403053f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -152,6 +152,8 @@ static inline unsigned amdgpu_mem_type_to_domain(u32 mem_type)
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
index 55e0284b2bdd..6f61491ef3dd 100644
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
@@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
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
@@ -586,6 +589,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
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
@@ -600,6 +609,10 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
 
 	amdgpu_res_first(bo->resource, (u64)page_offset << PAGE_SHIFT, 0,
 			 &cursor);
+
+	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL)
+		return ((uint64_t)(adev->doorbell.base + cursor.start)) >> PAGE_SHIFT;
+
 	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
 }
 
@@ -1267,6 +1280,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
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
2.40.0

