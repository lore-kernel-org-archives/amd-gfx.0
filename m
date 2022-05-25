Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8E7C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF05710E314;
	Wed, 25 May 2022 16:20:05 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAF2910E5BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Njgj2Bcbx4thxbOBR8uGrKNn6xHkplf8qb+l7ZPeuOfJsOJThXjQOtgurEfjv6sztrsuqnbZM5Uh/zfdNOb+x14EtKzc3n+aHdsRgikC4GZILnQId25/+DZU1rtfgChN20f4Ku4sdY21UK6JxQYqmJlTamLGJ+iaMVAEcOznnXNG1nZUkxokhq9KkWNMk9nSs3Js6Ge/iPb3wLzFsjuDMicICijxft/fXjDvbmFl+42A41b/j6Kyd/+J0jzdGMbTNiMfYHFRad29g9i0xJlpbTvpwePWv5gUBPvz/6RlfA0WoJU+Z0y11JIBSQK+GQQKtGTVR4HM+NC1AjYOaOiJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M53W9T4GbdNqLKybK0yJ7KdBlLFLMT+uTb8YNuklkmc=;
 b=n1bBFCzo0jgsT0YhIim1/f1Q/bkTMXU3lIZegRlteEu5cZt8xSYKW8yRE9bUpLiIAoZ3so00wmytNdpnFd8e+9JxHWezR9jrjK+DN6Wf8xpNY/U4os1IekqgizAjyk1XrbEglO88enl4iy36cH43Up5muCROnh6HuY2Lg43tMudeu3IMB8mo1bt8VCNztNrr4QWy6mESa/WFAAz6WtmQPEPuaFlKXj5MFtTwQhyssz59tq4HxgjC1g+1hXAb7cVjL5YNIBekyJ85KkbRWS3gFNQbdYg1JfDWINXcVrrtuQTp6PeIEDnMeziRD0lwprK/PiBJvDdEM2cyEPz2aEklLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M53W9T4GbdNqLKybK0yJ7KdBlLFLMT+uTb8YNuklkmc=;
 b=Az0rVhpU7325zkGgrvQzHCoFnGgN9krWQV52KPlclfUtgMqQF6+Pzlyzhm23U+hnvmeXvOukVHYLYWCi5dBdHEZSLqD1E/eiFQ/DxXjwlqQ0kBEOziJ9+JpwKRk/OepIIQg9Vox/amVFTWnLcWQpeBg8SoO+29NqBdzj5azfh3U=
Received: from DM6PR04CA0003.namprd04.prod.outlook.com (2603:10b6:5:334::8) by
 MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.15; Wed, 25 May 2022 16:20:02 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::4e) by DM6PR04CA0003.outlook.office365.com
 (2603:10b6:5:334::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19 via Frontend
 Transport; Wed, 25 May 2022 16:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:19:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/43] drm/amd/display: remove stale config guards
Date: Wed, 25 May 2022 12:19:00 -0400
Message-ID: <20220525161941.2544055-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f3b37d8-b778-4101-6052-08da3e6a6bbe
X-MS-TrafficTypeDiagnostic: MW3PR12MB4459:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB44592C6A48D48429761463BFF7D69@MW3PR12MB4459.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZq9byyncTnzIHlStjNNZIeY8KZGOPeol4EBugQrxd4Z4ATeh0SprcGcwCBkIIKPDms3OGcvWUYpxszzr6Q9Wawocx7EFzFIiocxa3FMSdzCGPQ2om2xKuq0Lyo4aZejkiPSO46mEFAVPD5M/F/A/zyI31xwZ/cUUiScwZHPwvGSr69RhesOMhLJkswId+vLqrZwwFyF5Pst4xHqmaTiwh3wS8ypstFlB6MnhuWI9btYcCJeJ0hG5D3niIRkHanrfYPSjnIDWXlZ1iCB2X7aceYM8TqyjK4IIm86byBtVhuJFwUNVa00d5WODUie4o0is+a5SFIdaIxmHwxA/SiZpf89Vb4RnVl43g000wjCjFsySAbTucexEWMHtPN4bGKVM2aPSuTaIhL+AbQY0lWs9krndABCiRgDejFoeOT5DO6W4nTMt13hkK+n8+v3GsR/Vwr1lcYXnqaOODtBySZ11n1qqtWsskEQj9JfsS9K86/Bv70YI2UyVB1zV2IEgiT+qN0yoJvEGQCLssPuAtQ3b2KGNwRsFf8wXGK/Byp9xCD2dvnWrRx73MezoEUkx7xQOeCvnmw73neOtOQnuvqvbO6JY0IFWs3oU536e1C7VPuvCvPCRK8mWNQXOMSOAJ1nT+rLeflNYJy1CEoLVhQzF3gic0ObW4rzNkkD1e0CE25cidnfK4dv6T21Fihwh56G9OJqzGT4gRNfJnuPAFmt1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(70586007)(4326008)(8676002)(82310400005)(81166007)(8936002)(83380400001)(426003)(16526019)(2906002)(70206006)(316002)(86362001)(6666004)(7696005)(356005)(47076005)(26005)(2616005)(40460700003)(36756003)(336012)(186003)(54906003)(6916009)(36860700001)(508600001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:02.0503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3b37d8-b778-4101-6052-08da3e6a6bbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 2 --
 drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c               | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index a2ade6e93f5e..ff8f60f38b21 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -41,9 +41,7 @@
 
 #include "dc_dmub_srv.h"
 
-#if defined (CONFIG_DRM_AMD_DC_DP2_0)
 #include "dc_link_dp.h"
-#endif
 
 #define TO_CLK_MGR_DCN315(clk_mgr)\
 	container_of(clk_mgr, struct clk_mgr_dcn315, base)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c
index 789f7562cdc7..d2273674e872 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c
@@ -1284,10 +1284,8 @@ static bool is_dtbclk_required(struct dc *dc, struct dc_state *context)
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
-#if defined (CONFIG_DRM_AMD_DC_DP2_0)
 		if (is_dp_128b_132b_signal(&context->res_ctx.pipe_ctx[i]))
 			return true;
-#endif
 	}
 	return false;
 }
-- 
2.35.3

