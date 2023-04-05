Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA558C76188
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 15:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F24510E9EF;
	Wed,  5 Apr 2023 15:31:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56E6410E9EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 15:31:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=numFbr7s045ye8iMZoE35QurB3iW+v0VXgGI+QcnRh6ablUAXLA/bL8GsPoT8l+MdoNa30j7+ij25tmHNhzu1jAOVAuLb9LRfKl5GLZoXKHyvRG+WwRm1U6u18QrgArkZ9Gh48Epd6gj68A76kh7h8WKVthD3/U1hjIda7jfPLHpT6yRWDetgaSNAmdzfE1dzm4UanNFFhy47FNfB62k1tYRySlcmyXEnlszKoC7Pqwzk0vaG4hb7DoDyZB3vdpF4a8bRVzLECkyxE+/rnKIu1HkCMiDatsMAb/X3B6mJMZU59MYLzSWH4vBafwap9uWKYNQjeWWy+1vzqmbaIcdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1Lf6R4uK0APZkOa/mAJacEybHQZ+h9eOWqHJ55tKPw=;
 b=CiDdZ8WaO5KhXhbF+8EsjRHWRVJeFGZMPONZmQMCRKJ8BFnUNz4BOOp3akmCbQthhlMU1icKreL7V6EWAHuPC+xQ0L9y/sIfALlAAKUp+KOTptm2GDCL+dh85nNHKzIr+R0GconKkUZdePTF+zwU11NTDfBnZTfBJXxQAn8pxvfSX0eUoC1WwURGrzHENmBZW4MSJlFrXSYzGkEKiAF9tb7mL7gjXeH7EUkgr1nvzYCTghqPKpgnjChzqYtYZjKAfp9+jxsJ9ay0k3wIctVf5WHuRLCnVBYpXI0LGyEvvf/ABnB49wzQZ70vpo5ZbFv/DmiggKKVe7WEYusq+dMf4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1Lf6R4uK0APZkOa/mAJacEybHQZ+h9eOWqHJ55tKPw=;
 b=wckZ3hMha7gjowCihD5zXgU28zpXXyo/AaLnz0f2N3WJc5cb/f5DOzsIE9C2WcgG1U686ia1fdfwV8IpwkukcwSZiNy8zbDt7s/mEF+gNb6yY8T0NHzQSmo8Y/dADPHgGYuUAjs8WCoPBrHfI6x0ksQM9sjE9gBtqlfIz2GzyOU=
Received: from BN0PR04CA0131.namprd04.prod.outlook.com (2603:10b6:408:ed::16)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 15:31:41 +0000
Received: from BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::7) by BN0PR04CA0131.outlook.office365.com
 (2603:10b6:408:ed::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.29 via Frontend
 Transport; Wed, 5 Apr 2023 15:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT069.mail.protection.outlook.com (10.13.176.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.28 via Frontend Transport; Wed, 5 Apr 2023 15:31:41 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 5 Apr
 2023 10:31:38 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <felix.kuehling@amd.com>,
 <christian.koenig@amd.com>, <Philip.Yang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: DROP redundant drm_prime_sg_to_dma_addr_array
Date: Wed, 5 Apr 2023 23:31:21 +0800
Message-ID: <20230405153121.3324620-3-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405153121.3324620-1-shane.xiao@amd.com>
References: <20230405153121.3324620-1-shane.xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT069:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: cf33f7d0-ab15-4643-b254-08db35eadacb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zWa99BLQDolnMPXK1OmxDVv5r6bb8nwWf/ssdEkTeUGxSe1+y+MlUDpd4OZgHUfcdDbHb6DjPRL8zPKYBg5tkxkcQIG/3bZD4HUcfdGVyBdGOLXMyU0rMPfJShasdtNH5afTG6KOStsSxFNUvrvwlPgo46Rc8RpCK9c8xSuuboQTH4WtgvqYv6qvTgbJEvS581wxL05SQBZvp6yZYtLqyXb/jdNDgt6Eb7mqflfQPHboKz03ECqSoC6uI3zPWkTaaDOeSMAlX99Lgb+a8+7aUUDab/R3tPpN1cvlY0zQKpVKGGmIORqFPWR7LGaK1WLU+Kbg7wR3vzrk1/gZHK5kiOjGHiJ3hg81hfrjPjvkJKSFosatjn8XWXAvr03hle3dO6IQzSQ/V2YFaaoTf165rGmDNBq6dsJYLubu49P5QmwIPPeMpuOMwkIUtOMINktGNENdskICwrKlAu8hK11ZC4MnOi0VKaONDDL2ye9HTsup7VNqa7Q36N0uHT5BA2o1DfKVNmklr6maav4LCJcKjZEXKPULih63sedyjr5+OhnxqYiFYaqv/Jgdmp0BoP0TmXOOvtRSwx4BWrh4OkCDFmfnfLPeey1yZhN2hja2hpNqGgKdaxXkTMKtLsbs1LnJ+neD2YhStwoxITGeJXpRl1C8UKMxeSjHdJRjLuG7hCAjysrBloSgwo1O/MR2HGMTEOs4EAnfhRHnkf7bhI1GUoJVYF2pESy5FEy0UUsmt5Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(478600001)(110136005)(316002)(40460700003)(6636002)(54906003)(5660300002)(8936002)(36756003)(86362001)(82310400005)(4744005)(2906002)(44832011)(4326008)(40480700001)(8676002)(82740400003)(70206006)(70586007)(41300700001)(81166007)(16526019)(186003)(6666004)(356005)(47076005)(426003)(26005)(1076003)(336012)(83380400001)(2616005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 15:31:41.1990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf33f7d0-ab15-4643-b254-08db35eadacb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Shane Xiao <shane.xiao@amd.com>,
 aaron.liu@amd.com, shikai.guo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For DMA-MAP userptr on other GPUs, the dma address array
will be populated in amdgpu_ttm_backend_bind.

Remove the redundant call from the driver.

v2:
  update the comment

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b181bb373783..74a1070f0be7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -503,9 +503,6 @@ kfd_mem_dmamap_userptr(struct kgd_mem *mem,
 	if (unlikely(ret))
 		goto release_sg;
 
-	drm_prime_sg_to_dma_addr_array(ttm->sg, ttm->dma_address,
-				       ttm->num_pages);
-
 	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
 	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 	if (ret)
-- 
2.25.1

