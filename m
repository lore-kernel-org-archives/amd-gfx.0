Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5046FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 22:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAFE28D5DE;
	Thu, 21 Jul 2022 22:04:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8A788D5DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 22:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kd7yDPFAcDECPDF02iPSeFVIPTF0lsBgh1pL1ItjYNwjCFjGlv44JWunjeunW6ghOb218zbVzC0Spbx1wS7+x5JhWh9MdidRJG9FDfjv2NAz3PtO5s6vriAbYB3kHcwiKEjZriDcF4XG/2JP+EorQTY6u1XpsSQe+UCcbT28B2xqWfpox3p9MY8Xw3b9ui6XxFgHz+o1B2yZ58nQFPU5pHWhQFxZVGSyDQ4MCzZOtXPl+pbc7AZdkbcNwNKhrNqcr4wYDcRTt7ssKTP6s67rQq74P4j7otFjqCrenDDHwQuf+4IsMFChN4/Y7PZhsdPtlvokceHA1doLDguZE7fu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8I81v/WWcqsvsbdZd650nh44nuYMzu3IhOi2spG2zo=;
 b=kzTKa6czDUfGoLIKWBFEYwI9yjrowDSMql7fKxru1H80SiYLSAmJgQUBPOqyBQMgbOkTj3OfFebL5F0KjptCwvtU54KzL3cZmz89JJoqx8soKQZ27MTVe1MAT2uuTkvZ7SCDE4xB6wVv3sMKbBGrN2dULi2QtqNTy3m9tBzrBXQbp4fxJziCriIBALDBFfr9YkfVUgy5JLMjQTaTppKJ9IRKzycT07c41ox8fdo9Q9YNhvGprrGCn26414MvKIlDJ1MgpTctbsPeYi2/5be8lLpnVcWL5X0jPXI/lUGl2QFBo0Ifz+pJ2qk2euf/+lzp2oP6G11BkbrabQdxuqy8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8I81v/WWcqsvsbdZd650nh44nuYMzu3IhOi2spG2zo=;
 b=2yru29GFVcakoR9EM9h8iMcE5WXQrs6th6M5bCCxgkZ9cLyISQ9O3uwwJmkSdZfffJiPGJ1DQbWNBTdpPkEjEULUoZFfxRX5PSIPtT2OnhK43VRZRbRPGqu2MUx5LLjUb0g9pKTqJ832wOjaqLz+SGbwTLzfWVMNetrdcmHQTQA=
Received: from BN0PR10CA0019.namprd10.prod.outlook.com (2603:10b6:408:143::8)
 by MN2PR12MB4014.namprd12.prod.outlook.com (2603:10b6:208:16d::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Thu, 21 Jul
 2022 22:04:28 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::dc) by BN0PR10CA0019.outlook.office365.com
 (2603:10b6:408:143::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Thu, 21 Jul 2022 22:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 22:04:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 17:04:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 17:04:26 -0500
Received: from roma-vbox.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 21 Jul 2022 17:04:26 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Fix dc_version detect for dcn314
Date: Thu, 21 Jul 2022 18:04:22 -0400
Message-ID: <20220721220423.32618-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dec746ed-600e-46c8-0c11-08da6b64fb1d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4014:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2OxAeyc+tUYNj2KvSzmkH3b8EStqs4wllJKlIugTs7OkYyRkLr/ntop5BpVzqFYp46ZhjkUHKsqI6+VkgkMitwH+jccSoNpC+q+vLbiS5SmqNIhFnBepfCaJ8C4EsPx/weOI8tz3814zuN0Zhm9sc2vXaLFv5BoWlySABL6CNFvpElUw/srg+zuDfKCKLg81mGeTWpz8kQBwhVXpGRvUCI9vmfc3XmqDFnvB4wX6CM0ALJHM+Ack9GRVmUKTHA1BWoqFW6VIDnC14devEsZGEWCfyIR1TJ0tLRGI8s2miRtJBEQhHiwN+kmiUyGy3LVYUKhELfsQyLAPhVtzSujumL/8o/QGyHibgNVLdq0FVODiPRU6GvZAjeF3RuX4BHaIkMMLD+kJHFCNVddfNwtchZnZTcK4Rgo8ZzlHlhOLwCGXQoqrQlMuqHF0/epZtlL/rT0ZosMxRP7DYbqt5Ogkwhxdnv3YCfbXb1Pm6O+QCEwaG+ZNDha7Too6areRLSGtErcw7xff1M/kLhKXkqAfrYvLriDekaOy125Kgc6maH+eLmwkwhdKPvAljH3nSImAjoo/1agtfEDnFdt7JFfC3gH060iLQrKfwdSLsjnvaBRLa8A47nuQxqqZjEpfhp5m8n7rY7RLyFnMWPDTrynSuGmg/8k5LrdfbZzBIvzILTso0CRC9AvF9+tI2ULz+q8B39jQhCpcMACtLBe26pQR8X6VRj1M9Wgh55fUKiS9CgEUraVXHfhT+WqKhgPBhg6AoAOt0Qjz9SxgGv42JBYtxS3UJ+iQ1aTt0Hp4JepCIiClLnKGSTS8mukHcUk02obAOL42bEeSIyQTnxm/8QpTyzBokcOBzH/MfmmhX6ZQM0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(40470700004)(36840700001)(81166007)(356005)(86362001)(6636002)(336012)(26005)(47076005)(36756003)(186003)(36860700001)(6666004)(2616005)(41300700001)(478600001)(316002)(82740400003)(7696005)(110136005)(40460700003)(2906002)(82310400005)(4326008)(8676002)(8936002)(40480700001)(70586007)(70206006)(1076003)(2876002)(5660300002)(83380400001)(426003)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 22:04:27.9451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dec746ed-600e-46c8-0c11-08da6b64fb1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4014
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
Cc: Roman Li <roman.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
While parsing dc_version redundant check leads to
invalid dc_version for dcn314.

[How]
Remove redundant check

Fixes: 923989c9cc31b ("drm/amd/display: Enable DCN314 in DC")

Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index bdaad4ce4b2d..752ba4ab2b1e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -74,6 +74,7 @@
 enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 {
 	enum dce_version dc_version = DCE_VERSION_UNKNOWN;
+
 	switch (asic_id.chip_family) {
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
@@ -169,8 +170,7 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 			dc_version = DCN_VERSION_3_21;
 		break;
 	case AMDGPU_FAMILY_GC_11_0_2:
-		if (ASICREV_IS_GC_11_0_2(asic_id.hw_internal_rev))
-			dc_version = DCN_VERSION_3_14;
+		dc_version = DCN_VERSION_3_14;
 		break;
 	default:
 		dc_version = DCE_VERSION_UNKNOWN;
-- 
2.17.1

