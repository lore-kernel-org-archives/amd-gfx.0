Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF852C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5329A10E8AE;
	Thu,  6 Oct 2022 21:27:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF6310E8AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OI8GgBFKuUX/FQX8Ka9MKUz132TpmZ94II2F50v0SmyDKA5MwcSvBY3DgYOZNKnRNL1R3ehcBL3u98/J7Y2TOvkARm7rOCN8aS/EKPAVyESlfXrFvpq9ceY2yGtj0ABz7/DsAryObPDtaAN7Fd/xcLf+DWp39mqmt0AvgEHP0Me0g+aZ0IQuhYFg+bG5oHRp9eDr5/2TH6RoE1cjOy+6GHiBzm7AeRLIyOZgxo3oUiio7aDpH62F8srl77061y+CWUGEUSY5HbHhhgCaS97DuA63zE8JDMMwgfUF44Z4pnaQ6pBdMTVTFQml4gzFT3OolcmVFF0X+vU3TAxe+TZWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TyHAlSzj/yEcPI+g6viXr/GtfnbbBc6k4msCzOrFfs=;
 b=iFmyB5zJxlIS2zVba8bFq4Z2n+QBJSBTntZJuw8SLLyUkJr50BErfYAKsrSJeb6b0NwxU8Sup2dDL7Uz+TBCKrI/mBeFRLiqlvD8xw64eJeCjWt4q78Ad9W3Y0Ti2yTuG00FcFvJkNcaZVACn1CRGaVg8kSl5huL8LGvTJ44uncYNTkJj0/vkorvNAAWGSzht3BzICAcE8wyyxFtSgAW8eaIAf677Fl1050BQuwLF3Sae9LgOeZeB1xoti/xs05V/m86a/hfriq6YOn9yqGyjM0CSB0932kAHnL19RxPoLotnFG1cq4ZUiQQIl7DRf+/AAq+EIQHBi1u7ENrDPORdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TyHAlSzj/yEcPI+g6viXr/GtfnbbBc6k4msCzOrFfs=;
 b=brWrpVmNgOmaXPmmFAE2QtZemub9li9k3g/mEuOZbpCBY6wmKvthdecZxtIVK/CwkhSbNPg7IHbBxxlqDXO5YVjOLQAYALRjx1WSl1b5VpGdb5DfwLYLGu4xX1bvU6AfSMl0YIpg0P1keJPyzkRR5xrjKRHCVUb9Ho0aiCL+fEI=
Received: from BN0PR04CA0118.namprd04.prod.outlook.com (2603:10b6:408:ec::33)
 by DM4PR12MB5247.namprd12.prod.outlook.com (2603:10b6:5:39b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 21:27:29 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::76) by BN0PR04CA0118.outlook.office365.com
 (2603:10b6:408:ec::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:29 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:27 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/23] drm/amd/display: Update PMFW z-state interface for
 DCN314
Date: Thu, 6 Oct 2022 17:26:28 -0400
Message-ID: <20221006212650.561923-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|DM4PR12MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c874154-c251-4e87-4aa8-08daa7e19289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oAx6CzU692jr/qPrAG1aPGXJohTqviuSW4ASakUA+zaAl5zaBLoRKE85OxFqPRwAqfxN7+R/v14O/4a17/VxlO+893p8p+gK1MkbVQp8jHGwrMPwBE6fIvfFNtsniLMTa6Ifz2pwxtE4f4rGbAzYTYf3KGmU2DY/7uAqstgLPHLjAevWW74UJH0GMpGKaVxTl2m7Q3ekapAPrNcGWqxzC1tbAxm2EL8fl/PKgkwyBL7lL+fBifYa7qm7B2UWGTuygr1PKli6lNTruuTIydzcILmiHjg03eILusPYCVHHYej2KnxX8t+I0bShZ9hqROSa7YWUa41df1cLWcJqW4My7+9oGfjgnzpgFbW6iHXSBi2tBD7N7iXyfL7VVoBGYsz5QDylp4+ZdP5JvgwGNrxHPgBr+hL34WFxi04yDwM17sEdgT4bKGs57a6jyOUXJxBJdyMGVoHuC1/U9JoVxGjkm+f9fdM/gT1SBVc/2MNJ3YxWylAxzoGnq/Cfya19Uy09+MSDLVQWz/kJfIhrRCKZ5wpFK0nGWR50k2IQjlc9kxNL4enQ76w9dLWJG6Ovxtu8po7CQcoDmx+ubj8QRhA8bbPxl3dykCbBiHm0fr55gSXj1cwwAEt2TsAo2OGaoGMdW2xnKab4NrgheMk3SSCwY0SNJ0kn9x5TRIJwtpoERih18MCZrA/4IVc9v0AjA8Y2yiEbLKcqv46sKDFNmoo/y4hwT8jbJxbFfz1rgg/a8rXxVnq60UvtA5IwK97ONZ9o1TbKKGRhRo+wSCLm71bbHDMuzml11G47M2umApdXzbBEdpZly7bHN6+Ny3xxhOil
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(86362001)(36860700001)(44832011)(336012)(16526019)(1076003)(186003)(2616005)(83380400001)(356005)(82740400003)(81166007)(47076005)(426003)(26005)(8676002)(478600001)(70206006)(316002)(54906003)(6916009)(4326008)(70586007)(8936002)(82310400005)(40460700003)(5660300002)(2906002)(15650500001)(40480700001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:29.3672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c874154-c251-4e87-4aa8-08daa7e19289
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5247
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Request from PMFW to change the messaging format to specify whether we
support z-state via individual bits.

[How]
Update the args we pass in the support message.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c    | 11 +++--------
 .../gpu/drm/amd/display/dc/dcn314/dcn314_resource.c   |  3 ++-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
index 897105d1c111..ef0795b14a1f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
@@ -339,29 +339,24 @@ void dcn314_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zs
 	if (!clk_mgr->smu_present)
 		return;
 
-	if (!clk_mgr->base.ctx->dc->debug.enable_z9_disable_interface &&
-			(support == DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY))
-		support = DCN_ZSTATE_SUPPORT_DISALLOW;
-
-
 	// Arg[15:0] = 8/9/0 for Z8/Z9/disallow -> existing bits
 	// Arg[16] = Disallow Z9 -> new bit
 	switch (support) {
 
 	case DCN_ZSTATE_SUPPORT_ALLOW:
 		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
-		param = 9;
+		param = (1 << 10) | (1 << 9) | (1 << 8);
 		break;
 
 	case DCN_ZSTATE_SUPPORT_DISALLOW:
 		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
-		param = 8;
+		param = 0;
 		break;
 
 
 	case DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY:
 		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
-		param = 0x00010008;
+		param = (1 << 10);
 		break;
 
 	default: //DCN_ZSTATE_SUPPORT_UNKNOWN
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 70b647b9b4d3..d0ad72caead2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -881,7 +881,8 @@ static const struct dc_plane_cap plane_cap = {
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
-	.disable_z10 = true, /*hw not support it*/
+	.disable_z10 = false,
+	.enable_z9_disable_interface = true,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
 	.timing_trace = false,
-- 
2.25.1

