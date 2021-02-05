Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8230FC433E9
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4252564F97
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4252564F97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51FA6F504;
	Fri,  5 Feb 2021 22:03:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BB0D6F502
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 22:03:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cG9vECG1QPUzWwKLSYKrHJWFsBDNrO/y610wAe+qYQKP2CjF0dOGPdFrlJqeo8M6xejJQLpuGJPQsRnaCy8Akj0zY6yswMMfTkg2FfLeOON6ej6Fv4C5nY2nh9Z4bcpT/z7A7cUxbNbqiA/bhOvmlHNR67hgg1F5aKrQ86fDNG5hvEjdF1zxyV++mNquMvmRWixfx0Bd07f1+fHIGrlr42G0uP1Z+FKJzw+cVEOc4Zcdj6RxfkOr/3YtcNV24XCvOLUXIQOyiUr53F9OgGULpPA/2vNyJcAkbTC4NPadur28J37LpJakwaxmN0/UjF/Lr1ktSks/JXZVs8nomAK2OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtM0VXFI7gX8xAEYdiJz/6MqzigsGsnS32iHJsbU/9c=;
 b=kX9SwWVW1/nhncsZMPk+pJrxp+XqinGSmUOG5HvkUMXkQ8C2h2TIC6wFZvjqvW79BN3ydHB02GHItHmNWz4XuN7bql+QX/+CLErAjnPJCBDKDerZOlnT4MVWO4ef0bVm91YyGsmivGGLidFPWck5cUM3aaB1LCf23OysJ+cQK0eGu9uXeTuRJinAz3zxsoAFK58s5ObxEJgD+XjfoB5mwHeVJrayAp7d0XZDmJKIf+hWdXnCl+M/emyF3uHrEBaTRR53zGgGWdVu8wdboOl3aHjMdp0hFtuI0nc3u1DDxqgO1dwWJ6dZpiDGAsjAcf9L/tb6QbU8x7D12oGyee6Qbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtM0VXFI7gX8xAEYdiJz/6MqzigsGsnS32iHJsbU/9c=;
 b=qDNGXx+SvxXUN+Bs/KNelUbOuIGhfvhQbgRn1FBMDqwOUN8xXW1Y6/gGuajs42xuKLe72ejZhxGGavy67sHAby44AHerVQSERmVgGXcBpSyVOu9TOkhSvnhqLJFU4M70cSAnAbIgwkz32UeTUK1FGEHU8L4qzUP9fg46A78TEAA=
Received: from MW4PR03CA0016.namprd03.prod.outlook.com (2603:10b6:303:8f::21)
 by MWHPR1201MB0142.namprd12.prod.outlook.com (2603:10b6:301:55::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.20; Fri, 5 Feb
 2021 22:03:15 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::17) by MW4PR03CA0016.outlook.office365.com
 (2603:10b6:303:8f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23 via Frontend
 Transport; Fri, 5 Feb 2021 22:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 5 Feb 2021 22:03:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:03:11 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:03:10 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 5 Feb 2021 16:03:10 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/11] drm/amd/display: fix 64bit division issue on 32bit OS
Date: Fri, 5 Feb 2021 17:02:45 -0500
Message-ID: <20210205220250.1871069-7-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210205220250.1871069-1-Anson.Jacob@amd.com>
References: <20210205220250.1871069-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8785dba0-04ca-4a87-c0c4-08d8ca21d598
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0142:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01421D77D5658CFFB97FF040EBB29@MWHPR1201MB0142.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVufviErHvqkbCXq9uaNxgycVSnsami02txy9K12tKrS4g3Yop+ui+KNoVESwEP1E9leyIZxHO58YG00+ifeN9GPDxa0Zq7gVjjyRTD7p02KErDj8IY9THLDZTXfyro1J6jwS/8QhaJEpKYOT3hHqDHyceUvSqsfu/XIHOKKWLEFxOnZQPWSIkJKR/TF3BPLiMqZRHCDSKups+UXWZrPzwERkyGlREDWsriArVW8xVJmmnxh2p2CVtBplEOB3KmtDAbfzwuWxCXyteN9M89NW7eOyBN4YFvHh94G3hihVHtoPdn7ilJ/r9W5DudqZ2n4ZUXAy2wBeAJTci/dbpsfChfS3wLrbwr/I6de335PiFzybtjLwglcwwwNSIOEtuYGn+zkkxYsdB32DRpsa3Yy6i571RnIkaCWDWzj5xuR8ceISS+WGDJot7v271UzBPCJXe2gK2T688lWOq+eYkC0NWL/FnooC+Ejdtw7V+MlOA+C3oSy9sxu3oMs5EO4vZWnGLiwQfDdhH84Bve8fELDk+knDYwnLq9ZORn6//emPtgx/3eRKaYyotFiyyfif6szbWVCECJivzPh+gq95jHPLFMs8NzOVxN1qdvVnUKX0+yzycm32aPNrxxor+In24tgF0yLEBxQGjLnM32k/g8FjhiftWNW4p9smGOHvvt1GirhyAq6tnZDTJ/1jO5Y54WJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(36840700001)(46966006)(70206006)(82310400003)(83380400001)(6916009)(81166007)(6666004)(356005)(316002)(5660300002)(2616005)(4326008)(336012)(1076003)(70586007)(36756003)(8936002)(82740400003)(186003)(2906002)(86362001)(26005)(7696005)(54906003)(47076005)(36860700001)(426003)(8676002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 22:03:13.7545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8785dba0-04ca-4a87-c0c4-08d8ca21d598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0142
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Lang Yu <Lang.Yu@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Huang Rui <ray.huang@amd.com>,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Replace "/" with div_u64 for 64bit division on 32bit OS.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c         | 4 ++--
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 8506739a22f7..fa5059f71727 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3688,8 +3688,8 @@ uint32_t dc_link_bandwidth_kbps(
 		 * but the difference is minimal and is in a safe direction,
 		 * which all works well around potential ambiguity of DP 1.4a spec.
 		 */
-		link_bw_kbps = mul_u64_u32_shr(BIT_ULL(32) * 970LL / 1000,
-					       link_bw_kbps, 32);
+		long long fec_link_bw_kbps = link_bw_kbps * 970LL;
+		link_bw_kbps = (uint32_t)(div64_s64(fec_link_bw_kbps, 1000LL));
 	}
 
 	return link_bw_kbps;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 17ec63253fc3..bc942725b9d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -240,7 +240,7 @@ static bool calc_fb_divider_checking_tolerance(
 		pll_settings->calculated_pix_clk_100hz =
 			actual_calculated_clock_100hz;
 		pll_settings->vco_freq =
-			actual_calculated_clock_100hz * post_divider / 10;
+			div_u64(actual_calculated_clock_100hz * post_divider, 10);
 		return true;
 	}
 	return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 064f158ce671..6505373483bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3506,7 +3506,8 @@ void dcn20_update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_s
 		calculated_states[i].dram_speed_mts = uclk_states[i] * 16 / 1000;
 
 		// FCLK:UCLK ratio is 1.08
-		min_fclk_required_by_uclk = mul_u64_u32_shr(BIT_ULL(32) * 1080 / 1000000, uclk_states[i], 32);
+		min_fclk_required_by_uclk = div_u64(((unsigned long long)uclk_states[i]) * 1080,
+			1000000);
 
 		calculated_states[i].fabricclk_mhz = (min_fclk_required_by_uclk < min_dcfclk) ?
 				min_dcfclk : min_fclk_required_by_uclk;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
