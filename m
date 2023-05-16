Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E801C77B7F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 21:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81ABC10E371;
	Tue, 16 May 2023 21:18:30 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A31910E0F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 21:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbnDYLsXZUiICtoP7Qu/ZCc4FKaAi/9QAKgR4CzUXX457z9o6oWoUE88/6Tvlw1WrADEtn7xdfZ2zJfB8edZvMKBXaZO5t4ZW5p27YCOPv8fX2fdGEZwAdYps3vaP45U3N7LCsgGhJCmD7tvcTL2yI0f+SqxMBk9IOeK3M7hCaw9DE1uEGGmSAuToOMi+0v8f3qC+KPvzbwhUd/r+Eaf12K2gL5assz6GsJDSSCVsEBSZW93c/QzLw6l4Q9b7QUJRULHbjiuNrz8/VIOY401sPvvNn3oQHqpKbp6stdSpb0uqhrbsCoheMcRJyElZDfrwBixwj0LG6l/y3JhhBd+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m35F600LnV19bfLmtD4OM+jcHosQqIS4mVjwsgv5H50=;
 b=Kxxow4VSdsr19F0pk5BIPZxPMK8r/5kIFXv39O4ZhHsBWdcmHhdWj0NncZqQmJkZvwI803bDuFMNK1We2YmS/p9yKJZLgfJoXw40SDYwGRb7yVHHwyH8MtGtoHa4d+guMiCYMENnQgR8pbXJsh+uLC4/dizuKkyA3DJIi248a49+6VU8dO0lJtE/RIb66Ag7ELi711RqPg+Exp0gW7UqdmLVZJXaFF4le5DlW0ym18xN6+u3gFLBS0fHbxTelq0gFTyzmnXY449Mp770LtLoGqXbWq3nK1PD51+4IdNDN7DgfAqTH1HgoUn6AOWwzqwPChNTt89TVPJmgK/nmynVBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m35F600LnV19bfLmtD4OM+jcHosQqIS4mVjwsgv5H50=;
 b=zMeTXVxmiZElG6ZWVrfOLW+oDf9Ez3JJugeLVP5B92y6pjYEevtjFw4+O1s1BwraLp86dDKJW73rld1g3HSoiLwd0mkrPy7gaozLU7idR23biee0gdQVH9rWioxahcCEI+FnzgV4o+CZhDXcL3Nukw+nzV8kQSNSCMyjbyHfcuk=
Received: from SJ0PR03CA0216.namprd03.prod.outlook.com (2603:10b6:a03:39f::11)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 21:18:26 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39f:cafe::24) by SJ0PR03CA0216.outlook.office365.com
 (2603:10b6:a03:39f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 21:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Tue, 16 May 2023 21:18:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 16:18:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/gmc9: fix 64 bit division in partition code
Date: Tue, 16 May 2023 17:18:11 -0400
Message-ID: <20230516211811.2979728-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516211811.2979728-1-alexander.deucher@amd.com>
References: <20230516211811.2979728-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT035:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: a88a4035-e730-49e2-f175-08db56531663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cun8QiwZyyGdv/cVjx3x4XRKiudDse9kdr29EaBlgmaVSduT86Sq4pA9Pxd6Ci8Zjkul9hlFu5krvuT09JjOhAMSXUeMKFK2ULhnGdMzr1jOocNeCR33/Z7UzGdfROZUt1qGmvJhxcgonFCr884t22yTUAAeNT8x8BMFkSqwm5O4NZJI0DZO3dxSbBOnLUhbwR8AGsUs2jyvg57uUVxx9L7cVD4nh1b1d6oR6gBOZfsyocejzpJ3whmElEBb0NhDBVZE13uxMRYdgxyrf5PXjXGF7J0dOeKdm7tC8PMtFrkbvz4nsh4at9MS73aTMhvloIXyOENYLkoIIexiySIaqU3eEOO14G7T8cjw8obGGtXYb2Q9iWVxvsqESGH6htkh946pn3yU3xl3SNmN1TANqUM+ElSAVOG3XPCWJaHSPJE/3bDS0Ygq5opgC2rrS+HZrdaAUMRBo/gV1cscIW1fz7rc1LAYmvyts86RJ7YdZF/TGNhjyR0KyJeK0IekSnptHI5gvyAC5W2jLQHJ1I7gCVCZZ+VA0wUc3a6eqDk5+GTOMLb4eNhzzakQE8K5cDoInAcdonPhscAJFrYOpBaWwF3sbBTjjsMh3YO+Saeh+9yIls55nQRpRmAohEKucA6PxVG9ey8OXA7Mf+sccqKiyX3NcJQP2C7hy0T436s2qgRkVs2q6XURuUp6m5mJUhbudtZedJ1l8fusGeW4xbmzmQeqTtddPdxwbwj4nQkRBcHfH/BfaLCoVINLzJZUO/NEUwEVgYtIw5w4qhAfhwXe2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(86362001)(4326008)(478600001)(70206006)(6916009)(7696005)(70586007)(316002)(36756003)(47076005)(83380400001)(16526019)(336012)(1076003)(26005)(36860700001)(426003)(186003)(2616005)(5660300002)(8676002)(41300700001)(8936002)(2906002)(6666004)(82310400005)(81166007)(356005)(40480700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 21:18:26.0198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a88a4035-e730-49e2-f175-08db56531663
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rework logic or use do_div() to avoid problems on 32 bit.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 11 ++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index d5958e8e3c16..76dadf181d4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -818,11 +818,14 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
 	uint64_t total_pages = ttm->num_pages;
 	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
-	uint64_t page_idx, pages_per_xcc = total_pages / num_xcc;
+	uint64_t page_idx, pages_per_xcc;
 	int i;
 	uint64_t ctrl_flags = (flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
 			AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);
 
+	pages_per_xcc = total_pages;
+	do_div(pages_per_xcc, num_xcc);
+
 	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
 		/* MQD page: use default flags */
 		amdgpu_gart_bind(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 938c8dba9057..d559e7bc0f09 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1919,9 +1919,10 @@ gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
 	adev->gmc.num_mem_partitions = num_ranges;
 
 	/* If there is only partition, don't use entire size */
-	if (adev->gmc.num_mem_partitions == 1)
-		mem_ranges[0].size =
-			(mem_ranges[0].size * (mem_groups - 1) / mem_groups);
+	if (adev->gmc.num_mem_partitions == 1) {
+		mem_ranges[0].size = mem_ranges[0].size * (mem_groups - 1);
+		do_div(mem_ranges[0].size, mem_groups);
+	}
 }
 
 static void
@@ -1953,8 +1954,8 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *adev,
 		break;
 	}
 
-	size = (adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT) /
-	       adev->gmc.num_mem_partitions;
+	size = adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT;
+	size /= adev->gmc.num_mem_partitions;
 
 	for (i = 0; i < adev->gmc.num_mem_partitions; ++i) {
 		mem_ranges[i].range.fpfn = start_addr;
-- 
2.40.1

