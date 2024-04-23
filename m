Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0517EC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 13:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFA01133A0;
	Tue, 23 Apr 2024 13:05:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4WSt5uSQ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81DB911339E
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 13:05:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfaSkMfyICFC1lntAaXgkWp35rglqzU+Y2GKkfiWMhJvcLkbHNHedraidux2M88O7rd0awHQG1cvnhPEA6EbzCOa5GlGLsWaAIGwx4SP65T9uR+0UCReHVAxeoLO5QxTCD7HW+Gp1TojONwKJqAwwmiPq4D2cT1sUkBeXx7kIPa3VFIQWfO4dJczVSJq5c6FpmLi+J42d79OjDJaneWws5/H0TIJNRwAo7GfswMC2qk065+JGsgzeO/8AZb/+4xJtPS7crqtqjMf17cPDEyn941vItgPMSx5pg1zmpTcakReLIT3v2CkJC0sh0mwm7xaOEcF1SPfW2EUEjWzqYbzpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wovQSx5Qh+OXe/D4o7YpPwOipyvGtes9n+hJZR87nJs=;
 b=S0ce/vVlKMjF9fJZprOeQejY2ezdo8wPNO7NWK+6izhxZCL2hF4ors5kG4carR+Dxm7b6IH3e8izFcdBa+MiE2xNZS0z436qqbPH0i1cfPxfK33cVm7kgl3ApqvlxssT/7YzmViud2XvypI14LuaVVWtpnYKsu56T4CMGb4X3+iglKmPldv8tPQQldqtbkjPGDBxl670xKpqMuCMZ9e+kx9rpUieqcFiKB5RorlK7j+y/UhpNiQ7eu4Qqh0SI2VUUNdL2mOuCreCUOT2tz4TSUVSUKpE4qLk/87KqkWFcqDKk/Jt8/suAXNih4w4wT7dhTrIUPBlmuJccnL74kwwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wovQSx5Qh+OXe/D4o7YpPwOipyvGtes9n+hJZR87nJs=;
 b=4WSt5uSQJuBQjC6CbnoVoyC5JoeR2ykxUYK047wneEu7BonjNYI5yaZu8GHo6nnVBWS7zmFJdlDc/yIs28qVuuLDewZdJnwTE0C0T9waRmekkMKp8BLYMBAvTOcjYzqMW0QlyPnoea8Q8ervEfBUk6HZ8V3L2NEVZ3N98pfExOs=
Received: from CH2PR05CA0033.namprd05.prod.outlook.com (2603:10b6:610::46) by
 SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 13:05:50 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::ea) by CH2PR05CA0033.outlook.office365.com
 (2603:10b6:610::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Tue, 23 Apr 2024 13:05:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 23 Apr 2024 13:05:49 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 08:05:42 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v4 6/7] drm/amdgpu: Skip dma map resource for null RDMA device
Date: Tue, 23 Apr 2024 09:04:49 -0400
Message-ID: <20240423130450.25200-7-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423130450.25200-1-Philip.Yang@amd.com>
References: <20240423130450.25200-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 4facfce9-a6ca-420e-05f2-08dc6396193c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vpSjC6nEQqfoDYZSXQgo97NLkmALth7dn+jMg7IIR91CpQhnMUwP3wQbbgXJ?=
 =?us-ascii?Q?RooUm2G0PGuWUQeL9mnk3FM6l+52XT+KwayXRW8Rfugub/KXV67aeBh3AVsb?=
 =?us-ascii?Q?/u48vtGlB0UgDdOpHaNlKJ1gCHTdAmQCG/Wz9anz/Kbi2lNiATTa6YXb+Sa5?=
 =?us-ascii?Q?tqK/+TnmgeWT8qUpuDqOVqADCMh5NrenPYmg3dlL7Ubqv/5CXTV0acfXvZ9K?=
 =?us-ascii?Q?rpBFLL9tnaWMAQdHOC4ieNS9orGxgnzc1kMFAljGnLyL1yC9KFUfIrMfWfaJ?=
 =?us-ascii?Q?FEIBuvyOwQXf5ii5odLMl7Q5oDB8J3Y4dmCSpMcZkulq8+Hh3rePRI/+f7GP?=
 =?us-ascii?Q?Im4SiWTg/mteHhHB0ZS/Ju8Z1fmNIpcDWKkJUBPfuea4UDolXfOFrr4E0/bI?=
 =?us-ascii?Q?xymURFG1Y4YuYcUwoZDeMRVhz8RFD3BqWKOfsTmG0nAg83PL+rAMOA1Yihcj?=
 =?us-ascii?Q?A6rEEMqZfXhvHCTLmOwfnEoEbzQCMBiqLRsLiM5FEE3nYATnmkajsWSi9Iz1?=
 =?us-ascii?Q?e/rGVGZE+Vy2znvNpuDmC7vkAorlqUMRk6Q0w6HtEFOoFYeXilwxTUGQE4pq?=
 =?us-ascii?Q?zw+XRgrfTEKH9ucV/upThOhDlvYWYHYxSgsZgrPNHiS3wCx8ZCvGhxU/uhBr?=
 =?us-ascii?Q?POwCZYFVloQWo+UJBQeMlO67zS4vjmj5VQ5SmmWu0o6RucfYsULK38o5RirQ?=
 =?us-ascii?Q?ikTmUXCJvjdxtgQEqa5JmqbfrdWPEc9Xp8lFvJnUwb4nYIREt4KQpiP84mL/?=
 =?us-ascii?Q?59eT5+8L4rdXl52TXyDvCtUOdrJnIMzWoVJLtrHFqJhzRodONzSpGRMkKa4U?=
 =?us-ascii?Q?vsqzX+YTVxO7BXoR0ptyFHyN3cWFwQQWL8s9qZD3lZ7XuSm4vmKoA1efrnmP?=
 =?us-ascii?Q?l2ft2gRKw0OM4VNcToqR0gLj/+nXN7ONesBnPCk5ofaDymTIUsc1R0CT4gxk?=
 =?us-ascii?Q?3veCRWCiLe555Zt9uVHg54UY0dKY9DmOVWzwqq31e0nkMgnAo3KYeLWP7ks/?=
 =?us-ascii?Q?ewez1FnY4EFAJejlqI2M731u/1KkEIcpIrhE8ID4iDx8+UursEGN5T4pR4yS?=
 =?us-ascii?Q?HFuxp5O0tgs/2m2ftkuTFfYCKGk4/nsyhD06Eo0OI86tX1FQruxce58tDi4U?=
 =?us-ascii?Q?MoVAanQ6SUAtLi54q1Bj3N1eq1+WozVqgFT44NBoI7MNcuANfxF78dDw06Ec?=
 =?us-ascii?Q?micwbS5aOoumbW0AK2XKYUqqjU2l+IaHXG65sxe6l7tKZ4VskjEhznIcr5ZF?=
 =?us-ascii?Q?kW2pmQxjN/2/xQFzojTWPNm0k+K4YwB7jyoorh3jcFW46jCB5cqhEy5wnYhj?=
 =?us-ascii?Q?qPqLIA8kha4z4Uh/yqv7aJRiUlFtr7waXFW5ietuw+1VtxncA7rzM0/9JcoI?=
 =?us-ascii?Q?YDkvLQDnyTkoYGWBpjnx61WMjMmz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 13:05:49.8751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4facfce9-a6ca-420e-05f2-08dc6396193c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
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

To test RDMA using dummy driver on the system without NIC/RDMA
device, the get/put dma pages pass in null device pointer, skip the
dma map/unmap resource and sg table to avoid null pointer access.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 33 +++++++++++---------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 6c7133bf51d8..101a85263b53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -698,12 +698,15 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 		unsigned long size = min(cursor.size, MAX_SG_SEGMENT_SIZE);
 		dma_addr_t addr;
 
-		addr = dma_map_resource(dev, phys, size, dir,
-					DMA_ATTR_SKIP_CPU_SYNC);
-		r = dma_mapping_error(dev, addr);
-		if (r)
-			goto error_unmap;
-
+		if (dev) {
+			addr = dma_map_resource(dev, phys, size, dir,
+						DMA_ATTR_SKIP_CPU_SYNC);
+			r = dma_mapping_error(dev, addr);
+			if (r)
+				goto error_unmap;
+		} else {
+			addr = phys;
+		}
 		sg_set_page(sg, NULL, size, 0);
 		sg_dma_address(sg) = addr;
 		sg_dma_len(sg) = size;
@@ -717,10 +720,10 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 	for_each_sgtable_sg((*sgt), sg, i) {
 		if (!sg->length)
 			continue;
-
-		dma_unmap_resource(dev, sg->dma_address,
-				   sg->length, dir,
-				   DMA_ATTR_SKIP_CPU_SYNC);
+		if (dev)
+			dma_unmap_resource(dev, sg->dma_address,
+					   sg->length, dir,
+					   DMA_ATTR_SKIP_CPU_SYNC);
 	}
 	sg_free_table(*sgt);
 
@@ -745,10 +748,12 @@ void amdgpu_vram_mgr_free_sgt(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	for_each_sgtable_sg(sgt, sg, i)
-		dma_unmap_resource(dev, sg->dma_address,
-				   sg->length, dir,
-				   DMA_ATTR_SKIP_CPU_SYNC);
+	if (dev) {
+		for_each_sgtable_sg(sgt, sg, i)
+			dma_unmap_resource(dev, sg->dma_address,
+					   sg->length, dir,
+					   DMA_ATTR_SKIP_CPU_SYNC);
+	}
 	sg_free_table(sgt);
 	kfree(sgt);
 }
-- 
2.43.2

