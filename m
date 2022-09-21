Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDE5C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 04:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C86F510E822;
	Wed, 21 Sep 2022 04:56:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C1210E822
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 04:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1f4R0KzCTyDtdh5nRaDEAnXM2J41Cue30cMR40GVbQWoSR/vnjOshA5QAPza2X/LHGcPnHstNHo7YFMBPE8VHfpsUY1IVIJKhQAlyXW4889gpRb58X6Yi1zYYL2fDeFE/TPwalRhXWRd/WKRxLT7LTCHF7RIMqXbU91SKjE32G3GSfOermJn82KfRBYcegBa5XRA4VdhkafXeNwTGxu8+ctb1QU797De/jF5t/AfWn4fuMW73TIhI+/f6B6xh94Jii9QajepthNAPW1Akkkp3ou+72gm+LgR1+nOEvlbeQYUuQbuwZTk/BcCJX9qq59YAjQ/foAhhaIEMJR3OykoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1P1qzc5C1jVhPbbicpnbWcd04t86mzOq1fKMEf+c7k=;
 b=VBQet1dbGQv7AakR7DCvFLuvdG882ubUwRzZyX6yImBvspcQlJDKKdLA6bWpAwn5gyrkTeBGYnzF8E8odFboRRHZxmv200sOxUs+RVUmNW7Kz6vTC0S1wFxeuApEvRyFCaxLe13UE/NZpGirJ6W5OMOC7Nol5XO+XIX44m0/eONCVh2rwVVLKrpx/UjiRMYrrvPkt7g3l/+QRdgBE50wBhBffdoCbIYPBKf4QD1Q3aiEYcYxHJ8smYVODCP+2xTfsDj7YOjLp4WZQulJc/4gRG2vIrYnmH9FDxV7K+AZaet+oKHutNgXMrfendzQccUQwEb+7dUn4zAZkrGxJwvqlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1P1qzc5C1jVhPbbicpnbWcd04t86mzOq1fKMEf+c7k=;
 b=FaSUVoBRmORhEB05QlxmJzPX2rhChdNQjUk8U71/OCtMKatT0szyWixEwewZrkB5ZUBhQLahI6c2onBX1WS2AdBtwz0WuAbM6GVCORVxhREe8uyALdmK7D2pAAR5tryDiFNTIds3Ll6pr7Ds5cyxmX8i+xAjlsnQ4jeV36A0gUs=
Received: from BN0PR08CA0029.namprd08.prod.outlook.com (2603:10b6:408:142::15)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 04:56:49 +0000
Received: from BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::73) by BN0PR08CA0029.outlook.office365.com
 (2603:10b6:408:142::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Wed, 21 Sep 2022 04:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT082.mail.protection.outlook.com (10.13.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 04:56:49 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 23:56:47 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/pm: enable gfxoff feature for SMU 13.0.0
Date: Wed, 21 Sep 2022 12:56:22 +0800
Message-ID: <20220921045623.43401-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921045623.43401-1-evan.quan@amd.com>
References: <20220921045623.43401-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT082:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3afa29-b5c4-4f14-cfe2-08da9b8db14e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qou4Oyde81sjxUDqy4IIFuLLzv6hGh0H1u8yBibWT0qROrw3ksUeOcYv8oqePsnl5aZcOK/Tc2FTZi9zj4VW+X18KIEnhA41eGMaYcth4oX0giodiZbQvg6L8Gm0hXBSXkFN584JQ6H6BXkApAJZID0xGeeXjEu1ew5Y18kj14d4nyb4MGjAjjqrnBNoC7AlVGJHMd/9repY33wxe0sMMHPCgDFBWH/C6X+OeHo3FpPsU1iuuUr7xiD+svJfO/CSzdWQDN7zXxYC/t/3+az4OxCjypeO14u7fQTsUzRhHvibq58CytHwKi23/oJVJPqR29a2PzV62+S8wV/My7xKRTOrNsGegBfyIhKrwTHLz1TYvuEI0oDulhU3Pi3mPgFzh/eVna0grr7fwA3j4JPF6BhQGV1hPD4zw5yULvE9MQWFuUrau6obhW0nHYN1cw8TnWrJbkgt8TiVWMoWtJGkuJVlaBJiFB+cb9L1K5BhDwl4TnCqBhdfiVI8bdY8VCTALaWcVRUSat1h2aR8YZu3DhI0j6jnWNkx6xF4bn+qz+SxsIyltTQJ/DbFRyWWvcgZB+NWE84e76D1csGgd5WnmhrhnJeI1EoBnzVm/0PraJ3ts9i2Mx8l+AaWyOFxmTD34oitSonEw+rRotqF/uLl+zPlodKRVZAGIo7gS/1Gt9O4f6d7pqnsA2BdYuCgoIXgltQq8uU7sJT8/StkkWOUG9YzvqJ5lyymiSeKYSeoR9meUbka7mBi3VCbP9rYH7STk4xzPyp4rTOpcS9QlOupMjO3GhDSXJ6wXif2vd1Y0k7Ai38NQ8jIUwcBYeQJPwGR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(4326008)(54906003)(70586007)(70206006)(40480700001)(356005)(8676002)(316002)(82740400003)(6666004)(6916009)(426003)(47076005)(2616005)(336012)(16526019)(186003)(82310400005)(7696005)(36860700001)(36756003)(1076003)(86362001)(478600001)(83380400001)(5660300002)(44832011)(26005)(81166007)(2906002)(8936002)(41300700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 04:56:49.2679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3afa29-b5c4-4f14-cfe2-08da9b8db14e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The feature is ready with latest 78.58.0 PMFW.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ia8ec869be41b328eee9fd9544b3de604a085f9cc
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 096327513dd0..03b732bf8cd0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -239,6 +239,7 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 				  uint32_t *feature_mask, uint32_t num)
 {
 	struct amdgpu_device *adev = smu->adev;
+	u32 smu_version;
 
 	if (num > 2)
 		return -EINVAL;
@@ -262,10 +263,11 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
 
-#if 0
-	if (adev->pm.pp_feature & PP_GFXOFF_MASK)
+	/* PMFW 78.58 contains a critical fix for gfxoff feature */
+	smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if ((smu_version >= 0x004e3a00) &&
+	    (adev->pm.pp_feature & PP_GFXOFF_MASK))
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFXOFF_BIT);
-#endif
 
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_THROTTLERS_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FAN_CONTROL_BIT);
-- 
2.34.1

