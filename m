Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0143C63699
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB352224A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W7OW6TWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB352224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83BAB6E847;
	Fri, 13 Nov 2020 20:58:13 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680084.outbound.protection.outlook.com [40.107.68.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EBA56E844
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:58:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQ4nr8t3ksU1YfZaMQQutaMUcR1BGbXbIxfjpWyubvz6Vgn8SzssW92zcI14CmB+nBdDa6nA7f67cQ7jmYpkouyLrPvVGNKKhHzYF8xOcuQ9flJsoalg6U7SezxAl8wT0hWuHb4iOTvs8r1abg3hbJ3WEw4Gyq2/YVzk6QNy9ADlYlm+Ye7aopZnYsvlnJUifCUZPC2XT/LHO/2dC4nH0yZBy101dw0P+OyHZr0CCnB9FypxwCUOJxeG0vuUch304s3di/edWYoZdw0oQ3Bh8jdo74bqbW02bsp8yhV6WlUeuDh3VsS12xNFAkqYzDDeWoKTLI0Y223yxWRTE99RJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbTOKK7PywtY7J1yG4daMYhPmzBGVjyzuNTX9Brpjms=;
 b=fTkmiWOHCXeQPJzRugl0dJzUpDUoAJuN5smLOVwlhtkVYrrbuhG/UmsQXiAPnDjaNCVoy6VPkyeXWtm+pWEgLHJctsfk8DKzMoxY9WuoIX4WgjatUXhMD73UoFRKMEdB8pmwVytkwEuFX40o2EDPF7aiOiggUmYVP6jOgo6Agv82cjFdB9KOUsBwtITk+0yM0w/Y6IDVB9HeRDjLCvqnU8YGZH4s/4fbU3RE3NYxrgmNI8yuotYdf8dgnJabRXoYGPm3+btkAql4mtQ8wvkd3PAeyfbjBWoTQuqF5TaZhr1EbTVaVooiR1z4T68aVbShbETmsEBKE/NXw3wREr2Qfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbTOKK7PywtY7J1yG4daMYhPmzBGVjyzuNTX9Brpjms=;
 b=W7OW6TWoh75RDiOPfF9dmkQrlTfSSJT/xltf+NBkbsRMfVT6y34k7nOXks4G7EnYtsSifW5LasmesAxRMOqQhU3SMN1X/wQUeJw2GF0Y1U5BeO/wBrZ/JERKcDNG2oVzEgeJjgVy6NCfRkGA0X+x/bsv8t/z2xSYEVd6n2idH6s=
Received: from DM5PR2201CA0011.namprd22.prod.outlook.com (2603:10b6:4:14::21)
 by BYAPR12MB3160.namprd12.prod.outlook.com (2603:10b6:a03:132::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 13 Nov
 2020 20:58:08 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::66) by DM5PR2201CA0011.outlook.office365.com
 (2603:10b6:4:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 20:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:58:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:05 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:04 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 13 Nov 2020 14:58:03 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/17] drm/amd/display: set dpp dto as per requested clk for
 lower case.
Date: Fri, 13 Nov 2020 15:56:38 -0500
Message-ID: <20201113205645.640981-11-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113205645.640981-1-bindu.r@amd.com>
References: <20201113205645.640981-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dba3a45-1702-4691-7ec7-08d88816d30d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3160:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3160346AF762720E578D0D30F5E60@BYAPR12MB3160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QE23bhEUeCRxrAuMRRXNWXTWjxtOs4XR669lHabbc6XkfEx8H2oQFVkqfMt4rbW3ZuolBbDwr/SN2vcfCGMD0TMi63tOrr9aH9qk5NDg1wvOG/fYsHeoL/m5LxVEXUaBU7ByJZioSMkVVj2zoHjYacjG1xgDOPyHTtUEXWENmyMPb6rT9oWvcGtNR/FYITojNxRwPoyol0uQ87ROJG1h7NgAnxM1s0oDrxIJEkZ2Tg/W+x2Ak+7oQxjEqzsrfpBju/UAqrTPrddRAR6Q3YXEgUXxttGCFx4WQax6akh+EwRg+cCswZLDZOlqgruQZQxf+FP51MEdvWUM2RkwD+rKlFSZ3+3jyKTQPQnEvX8MkYrNSGVJyDhohaHJDaeyyk0UsvCFscOUAcNpbxifb7T48Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966005)(86362001)(8676002)(82310400003)(2906002)(82740400003)(478600001)(6666004)(186003)(6916009)(336012)(26005)(316002)(5660300002)(36756003)(54906003)(7696005)(83380400001)(4326008)(8936002)(1076003)(356005)(2616005)(70206006)(70586007)(47076004)(81166007)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:58:08.3480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dba3a45-1702-4691-7ec7-08d88816d30d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3160
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
Blue screen when PNP with multiple monitor or hotplug external monitor when playing video
due to dpp dto isn't programmed properly.
If lower dpp clock, dpp dto need to be programmed first, and actual dpp clk not avalable yet.

[How]
set dpp dto as per request clk for lower case before dpp clk update, and after dpp clk updated
set dpp dto again with actual dpp clk.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 9e3d8af3895f..8d8ee4b9fee1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -104,11 +104,12 @@ void rn_set_low_power_state(struct clk_mgr *clk_mgr_base)
 }
 
 static void rn_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
-		struct dc_state *context, bool safe_to_lower)
+		struct dc_state *context, int ref_dpp_clk, bool safe_to_lower)
 {
 	int i;
 
-	clk_mgr->dccg->ref_dppclk = clk_mgr->base.clks.actual_dppclk_khz;
+	clk_mgr->dccg->ref_dppclk = ref_dpp_clk;
+
 	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
 		int dpp_inst, dppclk_khz, prev_dppclk_khz;
 
@@ -200,19 +201,36 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (dpp_clock_lowered) {
-		// increase per DPP DTO before lowering global dppclk
-		rn_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
+		// increase per DPP DTO before lowering global dppclk with requested dppclk
+		rn_update_clocks_update_dpp_dto(
+				clk_mgr,
+				context,
+				clk_mgr_base->clks.dppclk_khz,
+				safe_to_lower);
+
 		clk_mgr_base->clks.actual_dppclk_khz =
 				rn_vbios_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
 
+		//update dpp dto with actual dpp clk.
+		rn_update_clocks_update_dpp_dto(
+				clk_mgr,
+				context,
+				clk_mgr_base->clks.actual_dppclk_khz,
+				safe_to_lower);
+
 	} else {
 		// increase global DPPCLK before lowering per DPP DTO
 		if (update_dppclk || update_dispclk)
 			clk_mgr_base->clks.actual_dppclk_khz =
 					rn_vbios_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
+
 		// always update dtos unless clock is lowered and not safe to lower
 		if (new_clocks->dppclk_khz >= dc->current_state->bw_ctx.bw.dcn.clk.dppclk_khz)
-			rn_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
+			rn_update_clocks_update_dpp_dto(
+					clk_mgr,
+					context,
+					clk_mgr_base->clks.actual_dppclk_khz,
+					safe_to_lower);
 	}
 
 	if (update_dispclk &&
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
