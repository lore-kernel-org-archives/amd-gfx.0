Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4483C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9849421D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ta3e2jmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9849421D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E3F06E956;
	Thu, 10 Sep 2020 13:47:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB54A6E94B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ci/SW2G9UTV6gnoDjYKa//Kkp1WypSN1SdmGtfSZh1xttqY0vpilLzPXnAKxSS3BvINE9PpFpeo6IXrEfNrPgfj6vNlkJ8XYqtuR5Ou/Y3GtPU5UgWsPJ+p78F1cApqHHvNkjpfZaEiX5BIQEqU20EiSnQzO/EiTv+arIJE5hU9fol6lAqxIBiNBmFF5aE+3NzW5bhYRHVZ/WEFUYqZAHjMsloAIRb+VdUxO1jvWN+fhDHbL9bUNL4sfAh04Hd9L4Bbb+z8owfo0b2fXU6Hb+3ckyccVbY4uqVuKzFzamocpkA132WXWDkQly2Vr5+Npxeuuj71x0HtEhAjG/a8R8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED6rz52/Saob3ymGEKH4PaKIzC5Km18FV5Cq9q6iF2E=;
 b=OOjX8Tt94qDzrRv4PTAPI+kG1y0RPApwuGInfJMe0bSzj1acUFCioFdmeNp04p5tHJxaqNY7WuuxAHfHeCNEOoZyV1ssQXzt8SMaxCa4TS8cMk+y1H8hlIyViOIsCBIO4k+0R13uRHtfqorLDOLUtTdpYgGimPFImMN9jGh9Nd4nLBZ1u+B9N6vrfPa0KZ9T2M8h6+kdjh0QIHHiFnuy8EaSacOQBnqHYufcSjESf7yT1m8m8vRMHuoTe983aUkhCdg/2Do7TwTchkqrclVWIPhOn7iHBI9kB176BPEbovR5lMNaa8IU2D3JngTrjc+sDIza9kxUCeOqpGM/iXlm0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED6rz52/Saob3ymGEKH4PaKIzC5Km18FV5Cq9q6iF2E=;
 b=Ta3e2jmgWFnUe0d+4rldohz7YzqZBSZY5VBgM9rO5hYuHChJS4NCLMp5AiJe7S2vI0KE0ZylbBnf/zEFqjo8KGuV5tSghchBsGOKuq1GXfVIv355EYhdxWvO1NbejDe/kK/d/32crDfxusEEteViLX8R+JHPdo1yBEyPr55id/Y=
Received: from BN6PR1701CA0020.namprd17.prod.outlook.com
 (2603:10b6:405:15::30) by BYAPR12MB2600.namprd12.prod.outlook.com
 (2603:10b6:a03:69::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Thu, 10 Sep
 2020 13:47:54 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::43) by BN6PR1701CA0020.outlook.office365.com
 (2603:10b6:405:15::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:53 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:53 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:52 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/42] drm/amd/display: adding pathway to retrieve stutter
 period
Date: Thu, 10 Sep 2020 09:47:09 -0400
Message-ID: <20200910134723.27410-29-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c7a3a9f-8bf1-4790-99d7-08d855901e06
X-MS-TrafficTypeDiagnostic: BYAPR12MB2600:
X-Microsoft-Antispam-PRVS: <BYAPR12MB26009794A619713E86D956DA8B270@BYAPR12MB2600.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRaFaFxttuuqU8+SG/xQhgloiXjFMDTIdkNqHzEZBamsGs89MAJn3lcbWYR7G8NN4EWwtfrrZPhbQkg6VO1ljB+8l4xt3tHlpgCFVpVAolf58XC1exGbF+srPb5R6L2Ik+k+kyx8McALHO7bMvYffeOj3GTJHkJkjtjTCFbBN0/Yu9TVkRZzuxMbxPyGKHWMkJLzzwaTnvfFg5LevV8nTV/doB9dlG2Er3+7Os3k1e5qclX+xAxES6CvGxFXDOPtBiZTs/YAwyXHgACAIij/cZGm1/HSKoqvaEXLuY02P38BezcXim4E9uzqNrYWwK4VQ4Z/WqJuV1MvHlREgylsWEKaNm57XZ5pU8tJipSnyaaNSedUS2y5rzKOh2sDarhVohfT8r3A5CFrbFp1HuDO72ExGdO9oktkfcE4oI5PYtc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966005)(82310400003)(70586007)(2616005)(1076003)(478600001)(44832011)(426003)(5660300002)(336012)(356005)(8676002)(6916009)(54906003)(70206006)(7696005)(2906002)(186003)(4326008)(86362001)(36756003)(82740400003)(26005)(6666004)(81166007)(83380400001)(316002)(47076004)(8936002)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:53.8316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7a3a9f-8bf1-4790-99d7-08d855901e06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2600
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
 Martin Leung <martin.leung@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

why:
some functions may need be dependent on stutter period in the future

how:
Extract from stutter calculations and place into perf_params structure

Signed-off-by: Martin Leung <martin.leung@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c    |  3 +++
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c   | 12 +++++++++---
 drivers/gpu/drm/amd/display/dc/inc/core_types.h      |  4 ++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 88f23f12aeb8..168e6e4efaf4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2210,6 +2210,9 @@ static void dcn30_calculate_wm(
 	context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	context->bw_ctx.bw.dcn.watermarks.a.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 
+	context->perf_params.stutter_period_us =
+		context->bw_ctx.dml.vba.StutterPeriod;
+
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 2beb284f89b0..8f8bf83a60a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -597,7 +597,8 @@ static void CalculateStutterEfficiency(
 		double meta_row_bw[],
 		double dpte_row_bw[],
 		double *StutterEfficiencyNotIncludingVBlank,
-		double *StutterEfficiency);
+		double *StutterEfficiency,
+		double *StutterPeriodOut);
 
 static void CalculateSwathAndDETConfiguration(
 		bool ForceSingleDPP,
@@ -3134,7 +3135,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			v->meta_row_bw,
 			v->dpte_row_bw,
 			&v->StutterEfficiencyNotIncludingVBlank,
-			&v->StutterEfficiency);
+			&v->StutterEfficiency,
+			&v->StutterPeriod);
 }
 
 static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
@@ -6151,7 +6153,8 @@ static void CalculateStutterEfficiency(
 		double meta_row_bw[],
 		double dpte_row_bw[],
 		double *StutterEfficiencyNotIncludingVBlank,
-		double *StutterEfficiency)
+		double *StutterEfficiency,
+		double *StutterPeriodOut)
 {
 	double FullDETBufferingTimeY[DC__NUM_DPP__MAX] = { 0 };
 	double FrameTimeForMinFullDETBufferingTime = 0;
@@ -6262,6 +6265,9 @@ static void CalculateStutterEfficiency(
 	}
 
 	*StutterEfficiency =  (*StutterEfficiencyNotIncludingVBlank / 100.0 * (FrameTimeForMinFullDETBufferingTime - SmallestVBlank) + SmallestVBlank) / FrameTimeForMinFullDETBufferingTime * 100;
+
+	if (StutterPeriodOut)
+		*StutterPeriodOut = StutterPeriod;
 }
 
 static void CalculateSwathAndDETConfiguration(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index cc5f053ef5a3..3ec1d9dd1670 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -411,6 +411,10 @@ struct dc_state {
 	struct clk_mgr *clk_mgr;
 
 	struct kref refcount;
+
+	struct {
+		unsigned int stutter_period_us;
+	} perf_params;
 };
 
 #endif /* _CORE_TYPES_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
