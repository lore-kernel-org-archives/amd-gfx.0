Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6785606A885
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=33l4V7UG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B8DC11222A;
	Thu, 12 Nov 2026 16:44:47 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013004.outbound.protection.outlook.com
 [40.107.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B26A1112214
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 16:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsnwtGQR7xeJil+Oi81E7ZmrdIHKXcbf1fK/UgdVNYfjZ2KxNnzuCbbCTqHEVQ48LvkLVYCmhyj7cajLAXFe0gua022jsrAj9e+R7b/06SkY45JqkzUw5sPE+4uAiDLRJyBRFvOWO9lLjGXrDlv5dL6BlMQ/EXyeOMJfgyjDLn/CuuEOdSJRQ6HoWcHv+i+32BOautAzz2lzeFeIEvy86ext+oPDbCbEhV0ArhPoCaX/6Oh/v4F4tdbXJWOMGw3VbPFBccQ1M/5DPL47n4CYgN4nxVJysJMTL4KAfIpzVkRyIDpM56RnpOHQgLs3WBdRNVmFQ8rJl27n6baFaD4RSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2zPn/G0nrxtawFy/b9NobuOOj8g9XWFSdsCxbTHElU=;
 b=FrkeX444ZO4gqTZZiPRmrg2Kl/2WhZqK8hdmgWIwsDjBhB5loiVcT60cKvftsJAo73KBe62AoADLrFBIHfgKSSr+KC8kJ6y4blc+LL0WH5vFuc0LZo2rJPj8Q0qD31nai5jFe2O4pIgZN0HTfRxMWxZ38YqFgtYRwYDBI2l0B1r3eIFkcNUWZijBNHjQ+I4+yxLbOPYcHqh80+LSkSwfLa6ePfpr9nyWIxVcY7cbcxLDZfEiyMsDM9z9pizXOGsVvXNLPODzwHedFxJA401oZlls6myHTOPdfzFzXM+fkEzYyPCeSc9+8gGc8Z2vSBv521kzvXY8bLjM/8nr9dL8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2zPn/G0nrxtawFy/b9NobuOOj8g9XWFSdsCxbTHElU=;
 b=33l4V7UGu1/AelcBkOpidLL145SFYxp1BKqjh6x3SDd1O1c9lJ6DuOqv1DE9k1d5/s2gZgV9LJDbbr0/Tch5kK4fZTas9EORYRj+0t+Cew39l8wibrUSssHIP91ybemKCjLAAol2XX/ycAvWafuLJnqe1MJ9g+h2/Iwmq1ofgQQ=
Received: from MW4PR04CA0175.namprd04.prod.outlook.com (2603:10b6:303:85::30)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 16:44:28 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::79) by MW4PR04CA0175.outlook.office365.com
 (2603:10b6:303:85::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 16:44:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 16:44:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 10:44:26 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 10:44:25 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 10:44:25 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/object: get rid of amdgpu_bo_fence
Date: Thu, 12 Nov 2026 11:44:09 -0500
Message-ID: <20261112164408.1748006-4-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112164408.1748006-1-benjamin.cheng@amd.com>
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
 <20261112164408.1748006-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DS0PR12MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa2208a-efcc-453b-e0a5-08df40dc36b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|4143699003|11063799006|56012099006|261022105027099003|261026140227099003|261021123027099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ft+61H+0A4SQKsQn3RPjYSJ49Zxhgaizv+Ox2Ea6i1y8tABoMM9JiNbsEP/jTKhP2PK3R9CSQloyV0FIjBpcX4E1nD+9weyFmqCjIYk2T/90+H/Bm1N8expunnFq8kHG8DG39aBCzi+AszKOubtXTe/Slqg7gT9tawv8KN7QNTnimF0+D+Wj+vNBfHNAl/NPdTlIeugJFqVPJn2cIAZmaf+9DdPHucEiPtEgj2ut1dqh5ShKtDG2G+vpTC7e1CM4J/vHXpsq8A+AQ/CqrBuU34A6ClLo06RfDwPh8sDwrL/boFyCtYgxagpPxjz0+IjejAl6dRj9e/PJdQ/ACu3zrj4P+aA42iT9Ii2uiK9gXmXKBdP30UL07aO37Jdg+fvZ8dW0pWvN/erhiDRRiS7AIpnux/TXvif9Ncqb2k7l8/dcC1yns9K3aTNLl1V9ZxALR+nk5xZexLVFr1az/GvqlOGtMlmObEg7wXZw+rnGCREfiTRnXUCHj6bu3xGf33Xiow0NKt3+JqAIrec7OsY3nhNGD7VfxTyshJLDJ1u4t/d50a/y0eZf0V0GToGnkoRlaTa33OrPxXokY7/0de/lePYaQ3+vtbRpDdZl/n4rxg/47wQYd485rcydgmr0AZqBP7u9Coq7Q4TRaZVwTP4qHqJbYjbPoHFimOyrM8BYsqCyQuHmrnUumxjhyi2eaa2uEQMpY3lqpOpMlgA+O85hvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261021123027099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Um/NslEXlgFO4v2eofcYuVqOwkLPtpqRNnDarSSXpaZ08lbxGzLtXF7jL2xSA3jzDvkBMTTGpIAZl89/Ms7T770K946fqzFg6ZDB3/ALtIVdNSfOHG73qjnruTbV5YKjA6EzEkYP8VY6+NmmFNCqCTtWj3s3GdXuw4Wg8QXHx16tUCXcvh1HtTo4icnnBZW60tRSCJRqGfexcKeFDJ+UB03jGhIi+e/B5AQHp7/UmBSPt6qLmNU5udQtpYgaDkz+uTWfIamWUXaXP7NeXoQUlz+nus1AZPAKQb/hl2YZYrfBKRl6DskG0FEy7Aho8VjlZkGqIHaj6Gzz0dopqkcJTDfEdctFFu/Vqas2YQ+SKOcFiFhjamWpzW9tpOPmgMzvMaLEmJkbp6jnMdYBMMPMF8BBVbocnuRZ5L8h/NSVJnCmRtB/jxadcx/yXy14OGGf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:44:26.4195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa2208a-efcc-453b-e0a5-08df40dc36b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

All uses of this function have been removed, so we can now get rid of
this function.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 25 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 --
 2 files changed, 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6aa895f63aea..7fc43363ec62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1441,31 +1441,6 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
 	return 0;
 }
 
-/**
- * amdgpu_bo_fence - add fence to buffer object
- *
- * @bo: buffer object in question
- * @fence: fence to add
- * @shared: true if fence should be added shared
- *
- */
-void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
-		     bool shared)
-{
-	struct dma_resv *resv = bo->tbo.base.resv;
-	int r;
-
-	r = dma_resv_reserve_fences(resv, 1);
-	if (r) {
-		/* As last resort on OOM we block for the fence */
-		dma_fence_wait(fence, false);
-		return;
-	}
-
-	dma_resv_add_fence(resv, fence, shared ? DMA_RESV_USAGE_READ :
-			   DMA_RESV_USAGE_WRITE);
-}
-
 /**
  * amdgpu_bo_sync_wait_resv - Wait for BO reservation fences
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 2e6a8e6f577a..3a568ec56c84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -304,8 +304,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 			   struct ttm_resource *new_mem);
 void amdgpu_bo_release_notify(struct ttm_buffer_object *bo);
 vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo);
-void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
-		     bool shared);
 int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
 			     enum amdgpu_sync_mode sync_mode, void *owner,
 			     bool intr);
-- 
2.56.0

