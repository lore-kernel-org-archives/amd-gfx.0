Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3186AC43461
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F45610FC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F45610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81CEC6EB8C;
	Fri, 16 Apr 2021 14:34:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F5D6EB90
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfp1/hcy4MtMmUXjD6O0uffAR379gNwGna6d3CCgICy/kpAnhZz/0DkZaRpW8lJIM6rPd+vjbFvEz8oFWE0ucJulLgTPkh7eQqiNkuygsGN1H1oLbTxcLZXtNdzWwTSESO5cqhmeGuyB/dGgbLAU/K8y52iw/f0ywp+++0VS7ifwl1SqLKVaH0h36sutcEmSIIZDN4Gds3TkRsoeOUF0m04kMP5dVa/DUbQiXLli0aTDFOVQGvYgZc2Z6XDew5uT8I8KAunEAj3N5GfKh/me67GJX+4D3kTp63iwhN4PkHeR/ZqHkq/iV3UeEhhbaceGXnrzyKcGTzeRxwaHowv+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER+RlQr3P7G4s2QZ9x1lLDCihxtHCTb7nb0t5PToo00=;
 b=YLEiSBuEf7zI/z2js4BhDRTQk2Lc1E4MdXF2reaH1nhmoBHtxcsPBkUPLCsCkPq4chaLUfu1F6KY2k34Q/N7QOCGRE9UY6vFqtHe/Z02UyJd6tDI42/nmc1wH0rMm5dgvBpD53P+p4DnLuFb6ldGdm35zTUL6SUH5CM43zweRdc+qY0/gNKVbnaIF7eEgvbnZ3U8Y4ziXLBTHlnd+AO3UnP1X50dMsNYzdsYZIkR9/RK9DnVQnJiBaHdCtQb86kh4SpiLQuu6paV3sM+HQjj/nS703+H1m5kySyKTvKVxaBsXBHuASeDicB40rqC5NuUlZFi34o0TniKHSExGnJ5oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER+RlQr3P7G4s2QZ9x1lLDCihxtHCTb7nb0t5PToo00=;
 b=e1z0+KJ/ovQRx6euC8nihzvTouodTt4UW7XCQgE6o3BgHx84jvkqPqvAlhTNX8EFdZUSLElXWZ3QA+BJeRaMxMU7OpLua6b0gfnLwDAsT30ijLBrzzCS7Y1GWeTfs54viD+VrJYQMeYXTi0kPEnaTfMvfin+DqPj/8WM/MHmqdg=
Received: from BN6PR17CA0022.namprd17.prod.outlook.com (2603:10b6:404:65::32)
 by CO6PR12MB5409.namprd12.prod.outlook.com (2603:10b6:5:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 14:34:34 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::e9) by BN6PR17CA0022.outlook.office365.com
 (2603:10b6:404:65::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:33 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:32 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/19] drm/amd/display: Fixed typo in function name.
Date: Fri, 16 Apr 2021 10:34:10 -0400
Message-ID: <20210416143417.611019-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cce2c839-c49f-4da8-9c96-08d900e4c0fc
X-MS-TrafficTypeDiagnostic: CO6PR12MB5409:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5409F211F0B242C5BA2A0D228B4C9@CO6PR12MB5409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:316;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDGjaI7MEQTjA8tTbQdFmfPUdfS2nOu9BKylKgaMUYBtZ9ot61ZrLu52/e5KRQ87sTKql7TNa3PuZBx09nompWZBTuUBhH1SlKeEqorEBQVSWdls+eVhutQNj+ljhLcW01VFtpW+LT/DvcyBkCdVbpKHyF98k3Mgl+YO1oKY7apVZXH1IrByEQZVZajYKztdynTm1UQlZzKSUqfsjgzCOt3BPKPyOoBCpmnLe9zY3ov6b90wOb3XFFwPK5S8TCBmHYMYV+oUAyvFh6mBgwoF0gPjpZ5izrV31kQP3stpvbZsRcl3k4GT71VYjf1JPze39+fa279DysMnhWMnq+IOt2AyGGany64rVvAW3jnk7J/zbXgQXh+c/E13mhzxey7q+dyreNJ7NKc0WZGptj3y/lHuW6beBQKC/c2Ce4E40ikuG9tRTnqPQiFoJPq4bvpc1AKW0d9Ore/kmxvA8DspYqDSX3z9CuhjS9Ct0xI8i0BaBmqblmMruFKE6SIOQ7cyUnyAkF1i1OjtqAM7ZGFRJZBuGWRWVbMeiqq8ja115NNvzfiMiNok4D91Ork8PBc8h7cDgO9EX+NXl3h22t+Vk+cXNuOxByrnK2/pGXFSENeJ1Md0Rpzh5zh6GlhdoCYruJh6KjUe8qk3GbJCZ0HPDkrYtUYG1SscZnsjHRvhZoyRZdEDUyyUNDcQz5/Io2HW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(36840700001)(46966006)(6666004)(70206006)(2616005)(54906003)(478600001)(70586007)(336012)(316002)(83380400001)(86362001)(4326008)(426003)(7696005)(8676002)(82740400003)(26005)(2906002)(82310400003)(36860700001)(186003)(6916009)(1076003)(356005)(47076005)(44832011)(8936002)(81166007)(36756003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:33.9510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce2c839-c49f-4da8-9c96-08d900e4c0fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5409
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
Cc: David Galiffi <David.Galiffi@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Chris Park <Chris.Park@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[How & Why]
Changed "prsent" to "present".

Signed-off-by: David Galiffi <David.Galiffi@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 577e7f97045e..652fa89fae5f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -432,7 +432,7 @@ static void dcn3_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 			clk_mgr->base.ctx->dc, clk_mgr_base->bw_params);
 }
 
-static bool dcn3_is_smu_prsent(struct clk_mgr *clk_mgr_base)
+static bool dcn3_is_smu_present(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	return clk_mgr->smu_present;
@@ -500,7 +500,7 @@ static struct clk_mgr_funcs dcn3_funcs = {
 		.are_clock_states_equal = dcn3_are_clock_states_equal,
 		.enable_pme_wa = dcn3_enable_pme_wa,
 		.notify_link_rate_change = dcn30_notify_link_rate_change,
-		.is_smu_present = dcn3_is_smu_prsent
+		.is_smu_present = dcn3_is_smu_present
 };
 
 static void dcn3_init_clocks_fpga(struct clk_mgr *clk_mgr)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
