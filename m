Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F39C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9196C21D81
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l9Xs0m1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9196C21D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59F036E93E;
	Thu, 10 Sep 2020 13:47:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B326E93D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkjWNQok+iR0hvXRsbdF2Hwmmp37hZKI1ZZCyH/rVtvYxfICZujBzHg5TsTC8VJLeawkL2rgIN+TVizY+CjagiZb62yju3nOaXdVScWKQ1dS8hvv4s/mTS8WUqBePVFqhnUivaCnhl4MaAxmaCpZ3n+g2Ep4lPNGo7LiuczddEXv20n9rySuDWfMSMy0bSXZ6ZVZbB/yytBcyEq/7tBFds6Ud0JUjl+RExMu2qCqY/FkqJGvT51ITmXTIP25mjy+ZiwZBua40Ojy33caDuUfIh/FtN//DbPX+PmibRoN2NDkh4437POawGx07DDZsZGK9v9RLt+kkobMeae5mFzAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc+AkGkrfJqK7MqhsZvz58qowMNgcxQuwPFfR4F8Diw=;
 b=UUF7qeK9+r3DubxM/I9MrMYvB97nm0yamDvzNb0edTxz9CH9e2w0uCSvRZ43jD6X6YJ7yXks2p4u0l78wwjG6jjrN3sTib/wKJPq0kEHxOSdW3SyrFli6JMK+8czwKnrXMG1i6BtBhY6jfY4XIUekDc/twr/ui9/mP487z76qxU6nqci2FaQ1Z4sxDFNqEjceHA2ttjLKdKZxINMUX8ajFvrU2XIXZQX/2G+/CAVcuHeMqYY5BgA58VBJOVfP+uo6KVyOnbsJ7d0gZ5OyhaQVC29Erx7EeadO0lY+amhqkeTAiv5zp2uSaxoDaXNUCKnDDZoLGozNZ2JrBj8nkD9oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc+AkGkrfJqK7MqhsZvz58qowMNgcxQuwPFfR4F8Diw=;
 b=l9Xs0m1E/mtVbX8Sj2ZEXUFFeIv1nHgN8eG12gPVtf0vgHqZsQyeI1s5E1Xtzt2lHjiS5GyKOk3Bu+mcy50e8/kzF+TF2kfd6YE+CTi0mwQ4S/oq1fQCr1cZiXsWwkWWrFOaGcLrzBmd5SPJjdlPRf+mPk5XYxaM+NjUxDK87+Q=
Received: from BN8PR07CA0002.namprd07.prod.outlook.com (2603:10b6:408:ac::15)
 by BY5PR12MB3859.namprd12.prod.outlook.com (2603:10b6:a03:1a8::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:30 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::7c) by BN8PR07CA0002.outlook.office365.com
 (2603:10b6:408:ac::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:30 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:30 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:29 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/42] drm/amd/display: Check clock table return
Date: Thu, 10 Sep 2020 09:46:50 -0400
Message-ID: <20200910134723.27410-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab7af729-881b-406c-9d01-08d855900ff5
X-MS-TrafficTypeDiagnostic: BY5PR12MB3859:
X-Microsoft-Antispam-PRVS: <BY5PR12MB38597B8712DCC5BC8335F89A8B270@BY5PR12MB3859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Rup4uuNHE2jIYefTKJlNLK3Y96ZGnODrBlC7Bsm64ZovZachq1eHfKchwXOArIOoAmI/m9Vv/z1QsBefWaJeEPmccQ9cXnWYOTaLmh3dfPGHSfTaVzQ6VoqdlIxYVvOj2+Eu9tv6J3niSP0ZtZ71U9lXj4yug5yoa/TdS+E0i169wvhf7n9bw7wtbuejUNgQqX/XhKW2mnNR67O/y9H9nUfM4/sFabPJp3VbEmr6+smMArzHptx0ZIIfSTzUjMN/u8Ncog0ud+CxbrNYXEuMvdW8hL+kj1wRumi+3Ad1PuGgf9Pwu4YyJ+dnP1OC0ZJW+2AphKOc3fABKvqAroojcakQqI28LnJhTPTQpRknclSqYPNSIGk40XfS1PzBEW3e15Ux4InIAzODRAfUIBoJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966005)(426003)(26005)(44832011)(86362001)(336012)(70206006)(36756003)(70586007)(6916009)(8676002)(6666004)(1076003)(8936002)(82740400003)(81166007)(2616005)(356005)(478600001)(186003)(47076004)(2906002)(316002)(54906003)(5660300002)(83380400001)(7696005)(82310400003)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:30.3901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7af729-881b-406c-9d01-08d855900ff5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3859
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

During the load processes for Renoir, our display code needs to retrieve
the SMU clock and voltage table, however, this operation can fail which
means that we have to check this scenario. Currently, we are not
handling this case properly and as a result, we have seen the following
dmesg log during the boot:

RIP: 0010:rn_clk_mgr_construct+0x129/0x3d0 [amdgpu]
...
Call Trace:
 dc_clk_mgr_create+0x16a/0x1b0 [amdgpu]
 dc_create+0x231/0x760 [amdgpu]

This commit fixes this issue by checking the return status retrieved
from the clock table before try to populate any bandwidth.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 543afa34d87a..136ae6d70c80 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -761,6 +761,7 @@ void rn_clk_mgr_construct(
 {
 	struct dc_debug_options *debug = &ctx->dc->debug;
 	struct dpm_clocks clock_table = { 0 };
+	enum pp_smu_status status = 0;
 
 	clk_mgr->base.ctx = ctx;
 	clk_mgr->base.funcs = &dcn21_funcs;
@@ -818,8 +819,10 @@ void rn_clk_mgr_construct(
 	clk_mgr->base.bw_params = &rn_bw_params;
 
 	if (pp_smu && pp_smu->rn_funcs.get_dpm_clock_table) {
-		pp_smu->rn_funcs.get_dpm_clock_table(&pp_smu->rn_funcs.pp_smu, &clock_table);
-		if (ctx->dc_bios && ctx->dc_bios->integrated_info) {
+		status = pp_smu->rn_funcs.get_dpm_clock_table(&pp_smu->rn_funcs.pp_smu, &clock_table);
+
+		if (status == PP_SMU_RESULT_OK &&
+		    ctx->dc_bios && ctx->dc_bios->integrated_info) {
 			rn_clk_mgr_helper_populate_bw_params (clk_mgr->base.bw_params, &clock_table, ctx->dc_bios->integrated_info);
 		}
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
