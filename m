Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6356AEB64DD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Aug 2023 07:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F2710E0E2;
	Tue,  1 Aug 2023 07:16:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FDD610E0E2
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Aug 2023 07:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IY2BmdalNvyg+qR3ld412XWBFBT0WHC/lNefklHNKbeDcNANMCrXr+H2We88Rc25pMyJf0p0tlnmLDf3Kl0XvE4QkrybfyQJqtw3FokyhfE9L0/L8fNygXDLpEgDPPfU0gMsYwWfRrtQH3IXhMhvW5AjsO5qsUkbvkdfwIqiRAQvg5xRPfe/NMhAXJKMeEMnWIhFotetBrObXXzXF0BCAgnbBlZn6R28+si5Yr3swwamD7q5FhzklJRR//SQl3Ics+4Dk2GFnvDa+vLLlRz3/jJgAiuV5ZerZJ2wQpkV7sLxTeNu0rcAKbDsipwD7+5zhA+esIEew6LYoZIawxDpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOKnG9IVIj95lbECpmVl2V2gix0qVmNi3ejcj/5jCmY=;
 b=kqcsNYfoqaIi49cV0fP0CM7sCEjnJjM/Cpoooju9ZA+9T5PoJbP9trhMQ+1oE2FquxUKblzYoU5OvXYzuk+HcLG8/8pwoDPRSxfyGOB/gBB+vevIzrp/wSeiceZNpYRPzAmqzNgz9PDDj7fchsbti+Z6ctoiHgI3+zlQkwUewIS/IBsjKbK/zCox7gSpULEx1tGJXC2fbbuVwp+wKPU1OwlFa9czm2QZWyJTbwQPcDTVGIbax9xUwrtSRoaGMgCSqaw8YhSBmacqpL7hnGCz1X6BZCqdqVyO4KIDtU0jyyCgQl5Ij6MWr2h6s0V9mB+mz0JrAK9Yzs8/3RVFKUZ8Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOKnG9IVIj95lbECpmVl2V2gix0qVmNi3ejcj/5jCmY=;
 b=Yd9ZC0srEmdMu3YWA8pZw2Mb5T+Dvw8thoJrSFWjywilddnvuoEEs7z5UOAFAlRvYRDkW+g+Vb1KR8QYkatLgG7Ls0pzhNEwdagEsazBF9QW8UE09kwWXTqaLKS6RhTHiaStA9AWHvB7TvUa9ukhyo/NMV253Maxnbssga585eQ=
Received: from DM6PR11CA0067.namprd11.prod.outlook.com (2603:10b6:5:14c::44)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 07:16:41 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::63) by DM6PR11CA0067.outlook.office365.com
 (2603:10b6:5:14c::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Tue, 1 Aug 2023 07:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Tue, 1 Aug 2023 07:16:40 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 02:16:38 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: refine amdgpu_bo_create_kernel_at()
Date: Tue, 1 Aug 2023 15:16:01 +0800
Message-ID: <20230801071601.2124220-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 587da447-187d-42d9-9616-08db925f40c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZeVkB0cCOqJISnx5TbS6J+HqX7k0pNddLJpmFL4GAsNtwB02ymGP2ivO3eKOMMDKtgag16oAo76f0BGTtesDKfQGl11pGFfvuY/SibYLu2hNMqZuY6QOG5RNqa33QQbvHabSPFqJQZrrG2SZbOKIkS5OKvVEgOLUXMVw3ILvZrJhkvXNPtfqo3gLh1cpNylivYDHEt6auYqyfCudNnsqVT/fnHIn5kysGXUxE6PpN+bdoz9zHBG4to75Uv4fSlYpQwsRRD8b4CJ642O73Bb1i2YQkH7ZfIFl7dZ+JafXS2877O4kxR9ygFrqQVUjjdMw5ZSbO1CSg3OJpYttJbPj4maFv64R+0wJPqNKWpi3oyLOZdi1r4EMLaZp3eLbBNGI//iRHV5D7XVnN8iwvpUYIgS1GwPSWSHDGS8EnlNMwub4Emiwr4Btb7LbgqMbfRKIiUjg3xCvsDWNuUz+35jwHZ9/Xwag9nP6lezRjLxc4Von4hVTm/EXjSRcB43Cpr+ff9ieJMp5U1Ba26sVC4lFaZq2pOWKYWlRsR9tvf7ZIXI4tm9ohY7jSGxjt5LAPH2dNPf/l4FgIxESn4sadCDc3mPYq+5k0A8uTI0VAUg1hgiZzUY27dPnx4MFIo+cKGnonzLtlDyy8baJjobsST/iKB5z253shABfR92rm/1gCMCTTtqkIIIRk1GRaUM3Z4p5s/3aLnHmG6v1ST0iiCKBIAqIk0KZekJviXNw4mk2fzWVJ0Dri0sRhmvFTEnF4Ju8CvfQSFmOzlvMQHTQ3p7lvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(4326008)(41300700001)(5660300002)(8676002)(6916009)(70586007)(8936002)(70206006)(356005)(82740400003)(54906003)(478600001)(316002)(81166007)(2906002)(86362001)(6666004)(7696005)(40460700003)(1076003)(83380400001)(426003)(26005)(40480700001)(36756003)(2616005)(16526019)(186003)(336012)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 07:16:40.8399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 587da447-187d-42d9-9616-08db925f40c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Lang
 Yu <Lang.Yu@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use amdgpu_bo_create_reserved() to create a BO in VRAM
domain would fail if requested VRAM size is large(>128MB)
on APU which usually has a default 512MB VRAM.

That's because VRAM is framgented after several allocations.

The approach is using amdgpu_bo_create_reserved() to
create a BO in CPU domain first, it will always succeed.

v2: Don't overwrite the contents at specific offset.
v3: Don't return GPU addr.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ff73cc11d47e..df5ba9509a41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -377,27 +377,36 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 	size = ALIGN(size, PAGE_SIZE);
 
 	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
-				      cpu_addr);
+				      AMDGPU_GEM_DOMAIN_CPU,
+				      bo_ptr, NULL, NULL);
 	if (r)
 		return r;
 
 	if ((*bo_ptr) == NULL)
 		return 0;
 
+	(*bo_ptr)->preferred_domains = AMDGPU_GEM_DOMAIN_VRAM;
+	(*bo_ptr)->allowed_domains = (*bo_ptr)->preferred_domains;
+	(*bo_ptr)->flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
+	(*bo_ptr)->flags |= cpu_addr ? AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
+		: AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
+
 	/*
 	 * Remove the original mem node and create a new one at the request
 	 * position.
 	 */
-	if (cpu_addr)
-		amdgpu_bo_kunmap(*bo_ptr);
-
 	ttm_resource_free(&(*bo_ptr)->tbo, &(*bo_ptr)->tbo.resource);
 
 	for (i = 0; i < (*bo_ptr)->placement.num_placement; ++i) {
 		(*bo_ptr)->placements[i].fpfn = offset >> PAGE_SHIFT;
 		(*bo_ptr)->placements[i].lpfn = (offset + size) >> PAGE_SHIFT;
+		(*bo_ptr)->placements[i].mem_type = TTM_PL_VRAM;
+		(*bo_ptr)->placements[i].flags = TTM_PL_FLAG_CONTIGUOUS;
+
+		if (!((*bo_ptr)->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED))
+			(*bo_ptr)->placements[i].flags |= TTM_PL_FLAG_TOPDOWN;
 	}
+
 	r = ttm_bo_mem_space(&(*bo_ptr)->tbo, &(*bo_ptr)->placement,
 			     &(*bo_ptr)->tbo.resource, &ctx);
 	if (r)
-- 
2.25.1

