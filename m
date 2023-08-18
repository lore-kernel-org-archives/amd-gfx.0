Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A99FC001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Aug 2023 06:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B15C10E464;
	Fri, 18 Aug 2023 06:46:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D09A910E464
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 06:46:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpKyTR/A6rIlyv5mMxQ02Y7P3wZVRJFx2Xai2WB7Oo8HNPcawGucUb+6wE6lVGseHp/oN3G6NYnhiL9inS+EJy4h+TSBG6J2wWs2DDBs6cd3Wx/55eBijVkrvpqBGUhMaI7JrABJAplrxLoAtvL9+7Hyxi8hFy2881RhKQMbJMCPrLj8JdIjNqcbcqyZUBBzwL7mcN8b5gh97yVN6mLpSRee6dCNGyaBNWUpTq4Jdz5MSMTMffOCxfRK3AC0IVdNdYwkO93jsj+yk3CAQLaN/gWSla00HVt4IuvOxx8skD/mj+FVhTRHC1g27I9M9v8d/9rzhc2WRFMWcgj7nEVbaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZPV29CUtSOp5c/9p5HVMTK0yFd7t5WQaqH51qXRnR8=;
 b=Ac0NKALRiHvG0fa9Nt6np5KvUlnclTBu1aWIUtlQF9Tj9j/vvm+dajaf2GE9tsJMmGDoeCHUG/Gd9rTnalWe+Eat6OCAI9a9yF5RIfE1K6xzk5+6DC+v7pQnDETizFFTN0SCwi1TbQfUGwiNdBuNFg/vwvOKHixsuzmRA9JDZdRiCHoITbvPggrFfZ8Qg5UY8QQ4pVUX5j4V1EwZ0BzZNxutnF6a+N+27NNqVJKy32WA+mobtNi8n5SKoURdKPkWEG5fypl7CohDhOPdsKk7hwdkfsyt5xYB5Z9dwMCbwunf+YYSwU2ZBmeW/ry63EPWzXDqJkOzT8On5kZNy+URwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZPV29CUtSOp5c/9p5HVMTK0yFd7t5WQaqH51qXRnR8=;
 b=FFmMRV6xEn9BVNqzK6uDanRtlEPBScLZqYs01UB9VwIwVvJuA4NXFE8NMkw6kTCHBdfBEbdKW5Svc7yko35yrPZrJwhShNz5KoOGmQDDOqu604kPmTmBDATPoIVFwQYwNFlgieuTPJ3BNdYeSOSXtuppxBUjkw5QhWlEJ5Fty4M=
Received: from SN6PR01CA0032.prod.exchangelabs.com (2603:10b6:805:b6::45) by
 DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Fri, 18 Aug 2023 06:46:20 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:805:b6:cafe::9c) by SN6PR01CA0032.outlook.office365.com
 (2603:10b6:805:b6::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Fri, 18 Aug 2023 06:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 06:46:20 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 01:46:17 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdgpu: Fix kcalloc over kzalloc in
 'gmc_v9_0_init_mem_ranges'
Date: Fri, 18 Aug 2023 12:15:58 +0530
Message-ID: <20230818064558.819989-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: bc630f1e-d89a-4268-15dc-08db9fb6d4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xj6mAVrkAK1CkS0qEkn2VRAt2NSvfvkRHMvegvUwYKP02ZnODSGUzD+rACjIH9veKR88D/frdvew9RU05EpD6DrT4jCKcD/1+LMHA4sOL9r6LqfJIWThSW+DxAFTXLyvS/crna/HycpaLJNthqCCOIFplmEnvCqPDnxvPQ2VwCjUXGbkLmNHn5VfwgyYn775kjTEzinjhQdp2yoSIqTxSqph+yWbxl0aR3AdaQ3SKJLqDeqj8uXJu0c8Smh8kLbcIHhSCASRCVgHkoucycKf0IPBlhQGd8zWJMHaqD/ud1sBvlpxST2ep4nUzTU2Fy6VhDsyhFh8DosvBjatPodPX/KDphtQ1mwsyhEqomksGyEILpwRHp0wVygGPTLl4nGL3+T4+etp1YYVKMwX8pzebioYuAPvnFg7c33sUAQKIMcnAJ9C1q3IpF0LEYNfGkJnv8vUO9FeBYFqJfFt+K+ilpp+aZ6NulmvvIUIUeKbHeTZiWhsOloDhjQeqfLhq9N5lfoJbApuXAdJ+xKLuKoU51dhlvK4ibfXaC52aEAwXNxGtsH4TV/RbW0mkaG/YYcsIBqHSMDPyCa/zYJONjjkHM7f/lALyUhdx0zg/lS9h1GE0VqZ1FNtMQIHM6bDf7BkigZNRR00OJm8spHqJ/Nxl27PShx49bC7JW5BBPw8bQMvg6ku3a3mJv7UXcuiHTcnU7QYlOqSx0A/j09yBAhSkILR+AyHwZIloMQwr8GmrsHaxu+DIvodQw12wFskopH+7IzWvT9Ao1pF088ArXIzqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(86362001)(36756003)(82740400003)(356005)(81166007)(40480700001)(478600001)(5660300002)(2616005)(110136005)(16526019)(44832011)(70206006)(70586007)(7696005)(6666004)(26005)(54906003)(316002)(6636002)(1076003)(4326008)(8676002)(8936002)(41300700001)(40460700003)(66574015)(47076005)(336012)(36860700001)(2906002)(426003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 06:46:20.3162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc630f1e-d89a-4268-15dc-08db9fb6d4ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace kzalloc(n * sizeof(...), ...) with kcalloc(n, sizeof(...), ...)
since kcalloc is the preferred API in case of allocating with multiply.

Fixes the below:

WARNING: Prefer kcalloc over kzalloc with multiply

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index f9a5a2c0573e..0673cda547bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1972,10 +1972,9 @@ static int gmc_v9_0_init_mem_ranges(struct amdgpu_device *adev)
 {
 	bool valid;
 
-	adev->gmc.mem_partitions = kzalloc(
-		MAX_MEM_RANGES * sizeof(struct amdgpu_mem_partition_info),
-		GFP_KERNEL);
-
+	adev->gmc.mem_partitions = kcalloc(MAX_MEM_RANGES,
+					   sizeof(struct amdgpu_mem_partition_info),
+					   GFP_KERNEL);
 	if (!adev->gmc.mem_partitions)
 		return -ENOMEM;
 
-- 
2.25.1

