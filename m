Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C00C2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED7C206D8
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Eb4fVdGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED7C206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE81E6EDE1;
	Fri, 27 Nov 2020 14:11:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CEA76EDE2
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 14:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQDlvdv7Cd9Sy/s4iH70NdFJENSORXyRE8U+b36YsPh3xge4GDlpEJ/NywZlQgORqpV9gYZ/b3FPTJ4NqeOlaANn+Bf8Et8uhsAVX20OBwJDLWS/8gzvzeIG7I5ZqVqiUpuhcMai8vjWyV4j2gqAoSRP7Dfs9K7i+NJa50I8sCcgDRe/hbTQHarxcGDtA4UTgTlPukoChZWX2T37GiaGHe55CTjbPDGQhlrkeDgT2B8IsqPpoTfkhK/Z1+9pUa1GrlYb0g5Hy48XNOL4NuzfIGxbRd6FodSBq8ElaIOEphL4sfq+xfCbSHObF9blUYwLoD3WyYTlu2g1uemTTUQG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDZx/aDOBaRzjKdtynFnTmCxq+GFP6EaXXZIXqdvRE4=;
 b=IgYBtbP4p1IZGzwBKgZUjpXMrvAkm2XsSWQH/3TG+Q6EV1cgjR1/zNFvJgH3W272X+fdru/6apdXYjXINzhbbWn8BmCcAm5RFxUvtk76rBLTl9X/63j5z5If1+I4DcWbMeP1WMw8oeZcy//4od7YveFgF7kaQe9nS7eRcORsh9JHQ8gbZEyauS7+1QKTacbDb/RYVw9UFVdjVByz7xo5mmVLn1jq9igjpLEZ1dyG2CQ0TORIcvHYHtDXslxwa48BBLaxFgTX+rlkXok+fSVivf8BKSR/pOQ7cYdLh5sa7hYtK//mkAo19MXwCVI+Ljb8PTRIQa4STLY/CoOT10L0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDZx/aDOBaRzjKdtynFnTmCxq+GFP6EaXXZIXqdvRE4=;
 b=Eb4fVdGdFAvwAIMrI0PYEBlBkN/m2LZ0/KLeX18qRJJAUIjqNsDIgjUHR+e8ql5r64RwCOCdZCeGCdT5hpR/jWWAVOxXYjNpI7CjubQeyYTPnjhOFcS3PDb9NyX6PeVC6AzaUQApUTOUHrIh2t09MgQSeXDF7lgO3MaLP5uKOS8=
Received: from MWHPR21CA0062.namprd21.prod.outlook.com (2603:10b6:300:db::24)
 by CH2PR12MB4923.namprd12.prod.outlook.com (2603:10b6:610:6a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Fri, 27 Nov
 2020 14:11:20 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::ed) by MWHPR21CA0062.outlook.office365.com
 (2603:10b6:300:db::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.0 via Frontend
 Transport; Fri, 27 Nov 2020 14:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Fri, 27 Nov 2020 14:11:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:18 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:18 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 27 Nov 2020 08:11:17 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/11] drm/amd/display: Init clock value by current vbios CLKs
Date: Fri, 27 Nov 2020 09:11:02 -0500
Message-ID: <20201127141107.7731-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127141107.7731-1-aurabindo.pillai@amd.com>
References: <20201127141107.7731-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19faaa22-440f-4cb4-a933-08d892de5048
X-MS-TrafficTypeDiagnostic: CH2PR12MB4923:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4923DC95843AF23DC98D91D98BF80@CH2PR12MB4923.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MXi8RhFHCcVTIgDLzL15ZbWqd4swBNzbHYwAuix7pRI8s+UK6pz6FNXNWjVPPYGEx6MprIsSBaT2uXobkTdlRbjyqS+cTE6L+MNYE1dwjLWLcuA4e2DfHsvUTWqFNxfdDNkC7EAXwDW34cRW9L0AflYc+jWimYD1OWGMjqcSw5FyQ5iPVxU385wtQA/azLaKXOf79EmcQcpZHWy51MnFegfT6XTXQS8jxnDRXH4WwhUxUGYfGLW9aPp3P870PDZ0JRFNnTcwZyv6+wgEyr1IznVJVsOtBNdITkx6LWmhyN3uu5Brm1BX0fmAkLyl6cIV2/iyRh9+IqwCKZh/7ZFPmKKVt3nTy4lxyJKvMJeQZ51WgJKhT7nffolqNw1GiMGNXkcoqQZFUPBmT5TyrZu1Yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966005)(86362001)(8676002)(54906003)(2906002)(44832011)(336012)(356005)(478600001)(70586007)(70206006)(426003)(82740400003)(8936002)(6666004)(2616005)(1076003)(4326008)(81166007)(83380400001)(26005)(316002)(47076004)(5660300002)(36756003)(186003)(7696005)(82310400003)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 14:11:19.8530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19faaa22-440f-4cb4-a933-08d892de5048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4923
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Brandon Syu <Brandon.Syu@amd.com>, Aurabindo.Pillai@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Brandon Syu <Brandon.Syu@amd.com>

[Why]
While booting into OS, driver updates DPP/DISP CLKs.
But init clock value is zero which is invalid.

[How]
Get current clocks value to update init clocks.
To avoid underflow.

Signed-off-by: Brandon Syu <Brandon.Syu@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c   | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 458dab9e813b..fe6dc1e68e60 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -186,8 +186,17 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (new_clocks->dppclk_khz < 100000 && new_clocks->dppclk_khz > 0)
 		new_clocks->dppclk_khz = 100000;
 
-	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
-		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
+	/*
+	 * Temporally ignore thew 0 cases for disp and dpp clks.
+	 * We may have a new feature that requires 0 clks in the future.
+	 */
+	if (new_clocks->dppclk_khz == 0 || new_clocks->dispclk_khz == 0) {
+		new_clocks->dppclk_khz = clk_mgr_base->clks.dppclk_khz;
+		new_clocks->dispclk_khz = clk_mgr_base->clks.dispclk_khz;
+	}
+
+	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr_base->clks.dppclk_khz)) {
+		if (clk_mgr_base->clks.dppclk_khz > new_clocks->dppclk_khz)
 			dpp_clock_lowered = true;
 		clk_mgr_base->clks.dppclk_khz = new_clocks->dppclk_khz;
 		update_dppclk = true;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
