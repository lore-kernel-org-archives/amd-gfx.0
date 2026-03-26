Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2A7106F2E8
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 07:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B9210E959;
	Thu, 26 Mar 2026 07:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZVDWXiZJ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 106EF10E986
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 07:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xn8+DZxozuZ/BZ5p0zWZaAZlUG6/gDrVuB2dI3kj76M8EAS9HmMyDcEBdaSbq/2WLcCXnuZCQQKEjYa38d2UtGTlrJ/ExyxBV6n1NlX07XGx429hu9RfyQVqOBvvZY452uINxamt7DaLGimYTcAEqJJjt/WyrNAsTcml4GrDl5lIk7JPQLSomxe3aUCCXMra+gtzmfBKZofVeC/5IrFNszM/00ctkvUQbIXXd0meJAwRZeVov8Vqmdx1VvTuPMMl/znAb6CAOYU+Q9EmJ05ibcwf3I4EY3DTuiPvNf5HTM9EIP56mv76A9kDDyWxFBaXPFLak+Am4e2zNyQ5oiAzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BLf3RpP8fp9vjYVwZICJV83AW1JukGuOvFUW5KLSEc=;
 b=NZFzyIdoxtalAOZ+B7TeCd847tKKVMJ1XHIZ1oPc04OCfzzuiEjO+h5/w+paPGgMxjUk2yw5mC35QYp4H+fbXZL3psIL65zDEBEQNpjxWNwKBVM+n8+TmkJJj6JptxmKU9gYQYtZPcbUz7mHy13pe4hK9n+ZWNlFMVH/xZZe4s9jUutr9ZrGUTf9R+SUvVIgT687vJZZ1UHgpBameu5jY3ZG3qylkXYqB/tXgf0dnz6FVenq3C0JM1VYRo+xe/qRgpPhxf9ngux2w89XNCrVzS988rwis3yf1pAHjXkVANrz37uK1UTQFzeM8r8Cq6AgEA2Z8Qo7hUHq1x//qas2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BLf3RpP8fp9vjYVwZICJV83AW1JukGuOvFUW5KLSEc=;
 b=ZVDWXiZJaHHIshoAlPHvEequB1WdahCZ5n6ReI946qacA87FgeVuRfwel40pMJpX++Xwri5hQIgIcx2pJV50gvpY46sppyppubR4Mbr/HoJVhlUwokYy4klOdCYD4OZvtMuZszrOdtAIeA0Q3RH2t0CQ0kx4tJXi+WZiwmx3ML0=
Received: from CH5P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::6)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 07:55:05 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:1f3:cafe::e9) by CH5P223CA0019.outlook.office365.com
 (2603:10b6:610:1f3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 07:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Thu, 26 Mar 2026 07:55:05 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 02:55:01 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 09/14] drm/amdgpu: Add memory training reserve-region
Date: Thu, 26 Mar 2026 13:15:30 +0530
Message-ID: <20260326075412.1378411-10-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326075412.1378411-1-lijo.lazar@amd.com>
References: <20260326075412.1378411-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: a96a3ff3-ed9b-4a80-9593-08de8b0cfe56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +cM7BE+vdYTRd70I5RnFj0IqdUZzUJRmkOvu9Ojh8yVUbHNAh5AxFUFO2f9y3uix1jKPnYp+L/xBGMeuurskRcl5v+6uIlw99sIXzgBhvT4VHtE7yTYoKQ8ywRsFV/LO5K3ii+NEPS40+4xCXwjs4UpyTKCLLQb6a1TZFQXGRuJo+voTxKFvu7H1NfdS+yrmLYqXgfRzcU7cEnO/FxlVp3sHWb9bBoI6p5zopGLw7PsfzgldNi+H/TmcZ46Iw534dI77Rh0KMGidLGdE3M7cEQPgaP0gNQVH/xf9IdPTRMs7ZX1vmH6yIjtE9EEc6GaZ8NmzQdkXkDVZbQMl61uLJyDZr0x6l0+UXVmXTUXIlp7LJBAE5YoEW8Q1kbOFvMFZi+f6L+tXW8XHwf/FPVT+JxPVt/518L18QdrvgdgjeEPLGp6aN6nDTT1h/QJYUs+jVl0Y1pdaX7r2DuZIWHzk9fn48nUzfEXIhYhq7+FIDO4oSvJmA04VSVUYB7ul+xdQz9h6sefHX3w6ByKZ5HZrMxuDFi9PSWsExxKnjVPplwesm3Cn21RiZP0G6nOhbfWkEx51QMPFpWFwmC6vm3ajkKOfjgTPsz13Pdr3wpQsIjcN8onwfY1Bk5/CI1Ue58o6WwqkKfGv1IyQWM0Tqcb38bUq/tFBPAbVyvgbmpkf+GvaRiBZgipEN0WCXNTQSxl8Ms/vcFkNjr6NFRforKsb7Ew72tVEcl/NPyk2dGWDIyxLu9TRHywhxWXKr7TfnDOTqG499RHqkYhlfOAA4sY0uA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lKMy4P5a9ycpPCE+QTDhaH8g2PYhltecEskqWfyMr3BdhilJZekZvPR8TqWqESR5yRl18iT2Oe5NQo7OFg/fX7klYW4AM4/g/PHD46ua8TUJOZ1++WAlSQoyKQBTVUGOGjO8CPnNxXfwfVkQpHSQ3D4nbEC0ejVA7LrkJX+FNkDyKo/0N40X3I2HQChA8r27sc1/gAc8Jaz+4pHOQ2AfIeQYe9tQOOp7p1O22WdL3yOxx+EDuc9bFJ/3iIKs5LZ5n6x0h88zCNtusj6LqosmLLpSfA2BCLnGIYLCcUTdOJe2d6DiFxboP3HEOsWysTrYAyP1nhVKvBLmuF3e3iog8179xsSB9eb/ryidMltVZ2plSiYODHWpleis3QnsIi/Mtmz3aR4HNi9bWwLwGqnLiRNyDX1crb6njLZM7FOsTABOT6rP/ljfObq+xtuIkT9e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:55:05.5594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a96a3ff3-ed9b-4a80-9593-08de8b0cfe56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713
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

Use reserve region helpers for initializing/reserving memory training
region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 15 ++++++---------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 79a49cba8d40..7e94ec11c57e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -277,7 +277,6 @@ struct psp_memory_training_context {
 
 	/*vram offset of the c2p training data*/
 	u64 c2p_train_data_offset;
-	struct amdgpu_bo *c2p_bo;
 
 	enum psp_memory_training_init_flag init;
 	u32 training_cnt;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ed11d854b769..3c1b03d3625a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1751,8 +1751,7 @@ static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device *adev)
 	struct psp_memory_training_context *ctx = &adev->psp.mem_train_ctx;
 
 	ctx->init = PSP_MEM_TRAIN_NOT_SUPPORT;
-	amdgpu_bo_free_kernel(&ctx->c2p_bo, NULL, NULL);
-	ctx->c2p_bo = NULL;
+	amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_MEM_TRAIN);
 
 	return 0;
 }
@@ -1823,14 +1822,12 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	if (mem_train_support) {
 		/* reserve vram for mem train according to TMR location */
 		amdgpu_ttm_training_data_block_init(adev, reserve_size);
-		ret = amdgpu_bo_create_kernel_at(adev,
-						 ctx->c2p_train_data_offset,
-						 ctx->train_data_size,
-						 &ctx->c2p_bo,
-						 NULL);
+		amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_MEM_TRAIN,
+					  ctx->c2p_train_data_offset,
+					  ctx->train_data_size, false);
+		ret = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_MEM_TRAIN);
 		if (ret) {
-			dev_err(adev->dev, "alloc c2p_bo failed(%d)!\n", ret);
-			amdgpu_ttm_training_reserve_vram_fini(adev);
+			dev_err(adev->dev, "memory training region reservation failed(%d)!\n", ret);
 			return ret;
 		}
 		ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
-- 
2.49.0

