Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD8DC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 03:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343ED10F9F6;
	Thu, 18 Apr 2024 03:02:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vn3GQmOS";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3922A10E3C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 03:02:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eu2yaP3mOMcs5ualIyQDSnQ38t03A0PYRGBzVsAVM7inwz3gAZwT7UB6ASG+KAJxvGZ090Vgjpgyos5+oEyOIEDdtqJtKKVwwrj3qBsmKr5buVPE4plsY5Nz/h0K2HdukZn/RwQrSK2dGpQpk6qJxlixK8at+JXDJI2y6c61rm6UBmnwfX/q+jV8ApJj6ggKa3TY/Du+e2bVm4cHuRJH1KwNYCwOMxibPKUFCBucT7NGc0fn4g1uH7cJbNKj76gDx7gyMtB3kWNYsCO5yYQh8WBo/pcA5wLLVVGld545ZwHgWhT8YjjIaoF8iDqV65Zl1xVegYfSmAou/NVXB4Y4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIUTvvlBice+DSWTDL7yn4U32nvNdUWTNHCI+xWc3Wg=;
 b=cCCtLb7k74+5apHVjL0oWo2eh8nPyYU23pIZTnJIjONn9azb7pXAhCFERI5/B45Ta+kg43nYHVMAdaQrZRFYYIOtfTGe65+MLe2vaXvzZVb3IUD9qhL2PFVQTo3k0L1T+CohefQGjAOc4RH32L5skufaAmIeEvbpN+p1MNCnxdlKrOC61Qu7+agvmSAZ+gVWQF/5ZBa7AW2S8EoogBTgxwB4S9xCBxTWsnfianHUD45e0mJJutUCGM97g2fpszIortJXvgWPqYcLeamuH3PVq2N1wbSxYX35qYg7Hq5wQqeSxaaeevNzq6NCYEkYlbOmkknESa9oYhHfGqj5iHW4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIUTvvlBice+DSWTDL7yn4U32nvNdUWTNHCI+xWc3Wg=;
 b=vn3GQmOS438nCjWXPf2McyqObW582jmaAcfmfR3vzoBfrmFRMvFqiKUsMsylo5KXSH0WkAJaBX3CYFacpOgeC0q4UlbdShqdGdZ1v0g5ok1xpXS/gssqsviTPxrpXPv0tcoEVH5ntDbkDz939dfLZukEljlnGelBMVdtZHBXxoU=
Received: from BL1PR13CA0251.namprd13.prod.outlook.com (2603:10b6:208:2ba::16)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 03:02:27 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::4b) by BL1PR13CA0251.outlook.office365.com
 (2603:10b6:208:2ba::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.23 via Frontend
 Transport; Thu, 18 Apr 2024 03:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 03:02:26 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 22:02:04 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 14/15] drm/amdgpu: Fix address translation defect
Date: Thu, 18 Apr 2024 10:58:35 +0800
Message-ID: <20240418025836.170106-14-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418025836.170106-1-YiPeng.Chai@amd.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 53dae3a2-787b-4cb6-ad42-08dc5f53fa9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bj0pDx81qt4u+VT3EvtkQwdHzXwvZjWMZDa+fAW/BjvhitRg8jifAuK6CCRgnb17YfY+MSF5u6Hvn3+leWkttDJ6lvnd5wTTZq7Q3XdaTXMYj4xOOnBhduaSwOFV1WMZHCwMUXO2uhn6UjUaXk8lHTb+6cx8xb5Oh25y0GdGu9DxyiNQLcOa0lXdszQqe3eMR8tjYt9gD/M+85/BdHxDXwCEMbvH1g7xyFHk7+wq79c9MosXUewA5SrfxtYCfODnkWxWcNbQysBDVmsFiqa6rea5uT6gXTi2k+nsSpvj9TJ7pbjTSLoelHwi5vx7h1IU4H3GYEZ+36OWocqQAPWsXn6JIBLk0Dzoi2ZSrWBSXTZnbv4H45pXtY4XmtH6kfxK36459w+QbbswfUTOZpBrZRzaGpF3Yg+vw/9BpTSMmaxvz3XTQ+PT54sEwfXyIM4LvPnNPgwVHKbeJw/V1oKqC/GMknDtm2nlw1ghMONAKEsq5kL2hIxseILv20c5MXJeYjCjYeaFOHyfVjk4v60gKScJWq7fhRXDGQHty9cqgVGG28jYhm/x66Z9o186quzvnY1/GznRW3ILUz98r5qB6dskpX67ZpVpHlVNtkw6Vwi3Ra9He1+Vp4S3eaeICibXTIMu/vEBPx7cGoncikG974EOOxO4KfsrAP+882foWQ2RiOg3B0B/3OnRn4HaZ/mU9XbzxZtg5YPR8ahlH5l0tmQZbN1wI3O1qp3czfIkTWY57ZLReGjVDjJrKWZOqBA+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:02:26.9257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dae3a2-787b-4cb6-ad42-08dc5f53fa9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338
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

retired_page is page frame and should be expanded
to the full address when querying status.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3f34b3abbd79..d1a2ab944b7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2403,7 +2403,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 			.flags = AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 		};
 		status = amdgpu_vram_mgr_query_page_status(&adev->mman.vram_mgr,
-				data->bps[i].retired_page);
+				data->bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT);
 		if (status == -EBUSY)
 			(*bps)[i].flags = AMDGPU_RAS_RETIRE_PAGE_PENDING;
 		else if (status == -ENOENT)
-- 
2.34.1

