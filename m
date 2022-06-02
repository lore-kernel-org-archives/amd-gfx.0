Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88CBC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 02:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 412C911298F;
	Thu,  2 Jun 2022 02:31:54 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D11811298F
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 02:31:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJNVUNpS1QvzWSBM1imnRDmJB1o+uHl4FvSc5kKHq6bzn7neveGd8rcwHfdNmE/ErSWpz26bEPw2o1cvxzkFbJbUlWxGOEZ6+SKT2GPYb1EHKSAepEh7rTlRQpCMDm3usBsibrw8KD38UPOQQ+SXtGd2o5/3AhFBOUzeTVc1iAsTtZVcZZUdhrr6eAjnVLn75RwO8jE59b6OxHEBhzPSuOF+bjFNBpgkU+0Pk8hosDyd73fqutiFRINj6o82WXpA25vqh5N+lKL2EGR7u3skLPUQ6HLrmKJT/BGSLKWDvNBPDyUszfw7UsSFqWrMXx1jIAxZ/NcNfVh7O7RSd/RJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2EbJr1qZHC4WIpyyurzAwM5l3KhlS9JVyBdLfhrbss=;
 b=H3gPaWqznDWuIY43cMlnydk4DEMJCpbLnfdVQdo01d5+383H2zSPyijiHEH/ZwbtPA9pgv3cSeM902L8Zhep2OSqg3Tp9Vc3+BxZ6ndV42i53vCUUVBNLkmIKP+TFv/sh3VcawzokToMP6A2EZe5zatbIxLTqP/OFvKKQ8Mu/YcLuOOHuD0/YMebHV/p/T0JJszUhWj8yluFsIYRON9ROAGRreVwKi2Ncod+ogx2sYvxFPPrDaM0qIXQAWNlzAdQbjTPEdK6N7rNTmQS4OZsfKKr4eJs5/KEcZ3Xw8981II1T0Ld9z9G4hPDaO5FBV9zUv9VYnzvthVrvZHwOP0sOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2EbJr1qZHC4WIpyyurzAwM5l3KhlS9JVyBdLfhrbss=;
 b=1TWABBigonbvH8NzU67sZGvyGaS3MG1oz4VKunUIowpg2hum1URXkAv+u36Gn3yERmAW9W6yVU5wHTbOabKpRxaNSjaOs0/n/MtdqQ9OWWtzZl5I2courxLhWL3pzioW1mo3gbpm365whvpvPWsXtYOtG/g3AYMd0JU2/KDcBio=
Received: from MW4PR04CA0385.namprd04.prod.outlook.com (2603:10b6:303:81::30)
 by DM5PR12MB1161.namprd12.prod.outlook.com (2603:10b6:3:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Thu, 2 Jun
 2022 02:31:51 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::8c) by MW4PR04CA0385.outlook.office365.com
 (2603:10b6:303:81::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Thu, 2 Jun 2022 02:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 02:31:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 1 Jun
 2022 21:31:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/display: Protect some functions with
 CONFIG_DRM_AMD_DC_DCN
Date: Wed, 1 Jun 2022 22:31:36 -0400
Message-ID: <20220602023136.836224-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb8f0c0a-b482-4ebd-4feb-08da44400cde
X-MS-TrafficTypeDiagnostic: DM5PR12MB1161:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB116126CD46F935E186261A19F7DE9@DM5PR12MB1161.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEc7Y6H1ILXwC/0Pn73nh9EKsKrMO+iu5y/3+FJ2Q3E3EHABacSPlmN4eD8GzaBYL56lhNSN2bws6Dx65AZzTXox1L8WtESk2roV2/y8g1qOLpFpT3vPB1mkv+3veUA3Z3j5nK++V+8UTgiOUJwDFevUyXYBbPBZuVwkPNx3h21AoUFzGpjAQKFxEoKNP4ENNnWsJrhiJm+yIPM5S8pEUso9HiAX8mLQoveM7t6lm38T0PtYWLsFvGVZSyun09UTi+HDNW0saSl4lTugDf80j7GClt4KUQ4tK4H6/BNREIcpL9SVcQm+d3Oszk0DwQz2ZfPjR2yF8FFjCiFHfRUs8BcYEnmkDI9hmf4CO9EsBHzzIZzgh9Ulqr5tA/mHb7Zp+Oz13fLYFlZlfem8H9BW4UpF/jTZZudn74jXXWOBwlM2N2WbMy3Fbmvp27aoev/aUUJ3TvJkcU7iViflaoD9GpbxOAdKXm4e3g8b9sstVRMWYJU46EikxkynQOr17N6P0o/CgsIeOMkAhSxeRN0Nz1gcPJXdghvlYGbwaiDE/Z4wdeU76bwUosKdI1BQ3Bhk4lNy2UVPzm53AnD/MsxmOwgUg2gY76U7B+pj5ng6+tBrGFGGqTZ9dGr7uPimn7ZMc+J16Rswu5smH2NcWcRv9aDw5vv6sILY2zj0gBJi9i0eVGCUCku+JtkFOVmsRVtQxOqg4rfLBXpm/VmCiVUCDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(86362001)(81166007)(316002)(6916009)(356005)(83380400001)(36860700001)(2906002)(5660300002)(47076005)(82310400005)(54906003)(70586007)(70206006)(2616005)(1076003)(426003)(4326008)(16526019)(186003)(336012)(8936002)(6666004)(40460700003)(508600001)(36756003)(7696005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 02:31:50.8963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8f0c0a-b482-4ebd-4feb-08da44400cde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1161
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
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Protect remove_hpo_dp_link_enc_from_ctx() and release_hpo_dp_link_enc()
with CONFIG_DRM_AMD_DC_DCN as the functions are only called from code
that is protected by CONFIG_DRM_AMD_DC_DCN.  Fixes build fail with
-Werror=unused-function.

Fixes: 9b0e0d433f74 ("drm/amd/display: Add dependant changes for DCN32/321")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b087452e4590..a098fd0cb240 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1801,6 +1801,7 @@ static inline void retain_hpo_dp_link_enc(
 	res_ctx->hpo_dp_link_enc_ref_cnts[enc_index]++;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 static inline void release_hpo_dp_link_enc(
 		struct resource_context *res_ctx,
 		int enc_index)
@@ -1808,6 +1809,7 @@ static inline void release_hpo_dp_link_enc(
 	ASSERT(res_ctx->hpo_dp_link_enc_ref_cnts[enc_index] > 0);
 	res_ctx->hpo_dp_link_enc_ref_cnts[enc_index]--;
 }
+#endif
 
 static bool add_hpo_dp_link_enc_to_ctx(struct resource_context *res_ctx,
 		const struct resource_pool *pool,
@@ -1832,6 +1834,7 @@ static bool add_hpo_dp_link_enc_to_ctx(struct resource_context *res_ctx,
 	return pipe_ctx->link_res.hpo_dp_link_enc != NULL;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 static void remove_hpo_dp_link_enc_from_ctx(struct resource_context *res_ctx,
 		struct pipe_ctx *pipe_ctx,
 		struct dc_stream_state *stream)
@@ -1845,6 +1848,7 @@ static void remove_hpo_dp_link_enc_from_ctx(struct resource_context *res_ctx,
 		pipe_ctx->link_res.hpo_dp_link_enc = NULL;
 	}
 }
+#endif
 
 /* TODO: release audio object */
 void update_audio_usage(
-- 
2.35.3

