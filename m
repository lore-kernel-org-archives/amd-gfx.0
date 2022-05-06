Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2F8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E0110E841;
	Fri,  6 May 2022 15:45:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9AAB10E841
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:45:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmN+kaaLHaAb6ukDTx8JSrFIMWEEekMkCRI2m06xot2eO8V1xDl+N4X1MQr4t5qoWw5ZVii3yVSmqpHcT0wo9oqmCNcgN/lCC712gPFE59uEPHeEugKNvNMSmXuI2ynFeD+kJUFxtMB/3rJFL7Jsjap+zBcQ3tuqiwsRviP9/rAorWwk0b5fNWUX1yM0Fj+ta2bpozukzvNaPZDnMLbMNVxPp8spRdpW2gNj4YqN0+qT78E30vSq9YizUWf2gKE5FIsiLTQf6awiRVtR9K/Xp/Y9xuzYAwJCZxsN3GWaDffpB7Nln0omfmML+3VMMcxR4I/keKOtTn/KQi1EFjmV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2RnrcR5Zzc4ZwLsezTF7jSiTGX1o2nDcB2GAMZPU7k=;
 b=T6dLC7VQhJsqC7BCmWyNHCKO1I1SgYANz+jLgd4iRtA5P4YTUU3W/vVG5MtgrVrfKXaVTbrXquIhpWuQ8K6kQHwJZpQttedXTimdsfc5Ke7OT0ONPbj9CF9qrXreUEMo0e1n9v4/H7u5YLHdKG2fJdzRPhfw2M7TdYZZhuCfcarVqpNtei36HuIu9JUT1+9pD/Xq98qq8D58+2JO1qYYA3tggOsi3or1MJZF2M3wE16KplBXvIZP+0VrUhRPxEO/V8Q+4ke/jHFO+m2/0mNKVRAQTKi6a6y0oGrCYonvJpzeLuuV8NrPzuJx8p9fdd3aYPKj92l9vr7bWFCt8AXKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2RnrcR5Zzc4ZwLsezTF7jSiTGX1o2nDcB2GAMZPU7k=;
 b=BFv9/5emTQNWv9q3JU2gwthrvSfmWhtat+Gn3F78hrIIWPaR7cC0ZPbdelKTv/DX21HjqxTCzoJ3edXfPuApGlfycuHUFiSOBXcFtLMHwE961Jk1PHyZw7/dAEPM2bkPsFpV0K1PzegsyfKHDMDVwBLCVMsWZBa+tfYKfLBmxbE=
Received: from MW4PR04CA0252.namprd04.prod.outlook.com (2603:10b6:303:88::17)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 15:45:03 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::e2) by MW4PR04CA0252.outlook.office365.com
 (2603:10b6:303:88::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 6 May 2022 15:45:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 15:45:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:45:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/mes: fix format specifier for size_t
Date: Fri, 6 May 2022 11:44:30 -0400
Message-ID: <20220506154430.3837653-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dabcac48-ec0e-4750-a9f9-08da2f776283
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB511101CEEC28DD4380D4F5B7F7C59@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/n7j2SaYaGZ6kLRl5FJAK86AjhYDbgQ7xbJ/943UwY1zADedAp4TJ38pnG4m05PwSqW7uG9M8GJy9bejWcIt2FR7QNSYSmBclXmIc9VzhnyW/bqQNwniYa8f36+skQnzgJFKj+j1fVLHJZXCnjou+98y4/IBS/lLz6kD18DL0oExJ0QCBLvRlSSLlTtwOUW1q73d6oDg2+xKVHalMw7VGGeMuQnK8feO7bUPYYG4+fyOFxcCygrGdC5G6LBxRdhqww396/yoAfFwcZlYI2zbXRl7JiPJS9Ltiq0Oi+gY8/wPdLtqTGJYW/3bgbnHQNjmavho12ba1SWcjoSOpc6BHJvIZuILIepssL9Dw0gBD4+2WDAXcVAihmwh5aFd4ofHJwKFmvfgZAeW/WkwJHRDaIXS5QIB+zYS/JAQqqNVFG8zJmG14Ibn8E5zmnrDx9pca7jkBIsYLPbdqogdKfEi0Ek3mzjH+cBd/+o6IHMmRiw2B11yynxGwen0tmxUbQnb2baK2Q4ZIu1TGCGA5QH1PIXmhC3tDMjsndzW+M5RQ20yyvIyQDGvtV6j38J3ZUp1gaIfGpsJNp7E2S9agl4khFxBecHuv2QAOSjmn4FlmrmTy86P4Qdng9X9SFMkJMT0/oFwppQ97QdikLaUHPrIDdKAvNbH9EZrd/EGCpRgjvhJUakeojoakU3IAzN41bQp/F54cceZjxPaBi4dCp/6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(186003)(16526019)(5660300002)(316002)(83380400001)(6666004)(7696005)(36860700001)(36756003)(508600001)(8936002)(2906002)(82310400005)(1076003)(86362001)(6916009)(356005)(54906003)(426003)(47076005)(81166007)(336012)(4744005)(40460700003)(70586007)(70206006)(4326008)(8676002)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:45:02.5037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dabcac48-ec0e-4750-a9f9-08da2f776283
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To avoid a warning on 32 bit.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 72bafba1c470..69a70a0aaed9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -135,7 +135,7 @@ static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
 	adev->mes.doorbell_id_offset = doorbell_start_offset / sizeof(u32);
 	adev->mes.max_doorbell_slices = doorbell_process_limit;
 
-	DRM_INFO("max_doorbell_slices=%ld\n", doorbell_process_limit);
+	DRM_INFO("max_doorbell_slices=%zu\n", doorbell_process_limit);
 	return 0;
 }
 
-- 
2.35.1

