Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33CCC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A238D206D4
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A238D206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F12894C1;
	Fri, 15 Jan 2021 17:31:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 261CF894C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 17:31:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUf4FD1tI5mcjlQgtRq0WJjN3+ijvw/bgFJTdFAO7HPnRYLv+XIiF1pJAFIYKiLH2SCoCQy7aC6GJU899fuBrS7H550Q2XVk/D19qVjKLhW36tFRexD0v9C2VEw/R5sl+KlemSjlvyFwlfMIxaK1PkFdyqjdbNbkYuuI6VpO5YndrcV5v7dxK8+Zt4ddN8uWJeY4eFV2DMS7kfkPCHoNW/Y4jP5UTb6f/UnfniIRdJwkcBwsuAcHzGFRKE3CwooQOVIzdsFhJOpOdDL+jbjBqwIbcKEtl7QCeheR4lQfRn8YbJGVsOyC01XKu6t6n+NNlxkgn/ZjOpYEwfWssQAqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GrOzARl0cTjLP8kOO83mhY/Staf8DyJahFTjRc2tdk=;
 b=DMH7CYkjE9lyXJQ54Xmgln02u9xoyQIZNondhVG8mtAlczkakWOuWz2KYu6yrgkPhXv5qrIw2HeSNwtGCaP2I/4a9ZeQaC9hsUuVm/HKoQYq2fcqhK1XP5GrC/d6oH0uMSxBFtzfR8unU1HjZeOQ1bLZKDrDppO7PKJMkI3VqOrA7tWUuLDHheWpJICyd5KG2ibnORHNB4SS2GMhRdG1bKjMbQLZsRlUsUJJNorDgIwbtrqUWi4xiYg/h2Z6fj0feSGoCw2Sgw367SACSIzg3xsIdD6EVSmmsUxwtSNK0H9apLYODuLqVMEgmoCYEuHgXjI0ES4nIcQZcUGAcqDPeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GrOzARl0cTjLP8kOO83mhY/Staf8DyJahFTjRc2tdk=;
 b=rwVE6qy9f6RnezGQI0RxOVLA3nHNu5IQLKgSMVimOFJjSGfZTMJvuokk7ja68vVvHPOUph0OY3hg0KnXOQRRfOx8SVAM5aHnCyNsuzpYQfJhonOfx3Zx2X+/8DIxE8Z8ZFhhutM7+nFgrpfn85GHbqtJ3QaASn8juGjvtlBVH8M=
Received: from BN8PR16CA0020.namprd16.prod.outlook.com (2603:10b6:408:4c::33)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 15 Jan
 2021 17:31:41 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::41) by BN8PR16CA0020.outlook.office365.com
 (2603:10b6:408:4c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend
 Transport; Fri, 15 Jan 2021 17:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Fri, 15 Jan 2021 17:31:40 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:31:39 -0600
Received: from ajacob-ThinkPad-X250.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 15 Jan 2021 11:31:33 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/16] drm/amd/display: Allow PSTATE chnage when no displays
 are enabled
Date: Fri, 15 Jan 2021 12:27:15 -0500
Message-ID: <20210115172714.126866-14-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115172714.126866-1-Anson.Jacob@amd.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baf260ba-2499-49a1-a063-08d8b97b6b39
X-MS-TrafficTypeDiagnostic: CH2PR12MB4166:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4166D319A9E8A08C59EEE6EBEBA70@CH2PR12MB4166.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4vm4kNY26U3pE36nBLInxrBO77CDKkXHS+jI/RLMSAfD6QT6IRcdfk7/hye9Q434QrqlFgDpkMAu8j6ODb1eLt676LavEtyj3TlfUnlfsTjx8xGNASgwAxKclC8mRIVOgF0tZMhPNlUkoCtiAOdZQuh3f1pb/VkDdKzGDyWCtsqeBV28pWenWJ+McOekdM7XdvnpTb15qqPuumfTCZteX/njknIm8lacsE1w/El9cRfQfzPsiLdnPk/46ghlVnmEo5Vt5uFQoqm9fZc1yNE1n8TR5MrRNLgq1Fp4Q6QBHve/XhMtpaZCUIRz36j7ENuFznlQpR5vi9O1WPl2cm8i6UCGqLUczIOb+sTCNb8MiOHFyr3mB7KPLLPIJfldzfE7SWsaf0v5xMJCsX5R6IENo1vWLLrIjRmFVZt5UF0IVSDLS1jMeUjKilth4bj3WMCqsNT4exPcR5Wv/ml+SWVsaQ8hiQlz94FCdsmhtc1l4Ilk1i3XnZlmM49LA6Vmzu5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966006)(8936002)(54906003)(70586007)(8676002)(6916009)(4326008)(70206006)(82740400003)(86362001)(83380400001)(478600001)(36756003)(336012)(316002)(5660300002)(6666004)(34020700004)(1076003)(186003)(2616005)(81166007)(356005)(47076005)(82310400003)(26005)(2906002)(426003)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:31:40.3540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baf260ba-2499-49a1-a063-08d8b97b6b39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson Jacob <anson.jacob@amd.com>, Aurabindo.Pillai@amd.com, Jun
 Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
When no displays are currently enabled, display driver should not
disallow PSTATE switching.

[How]
Allow PSTATE switching if either the active configuration supports it,
or there are no active displays.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <anson.jacob@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c    | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 5b466f440d67..ab98c259ef69 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -251,6 +251,7 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 	struct dmcu *dmcu = clk_mgr_base->ctx->dc->res_pool->dmcu;
 	bool force_reset = false;
 	bool update_uclk = false;
+	bool p_state_change_support;
 
 	if (dc->work_arounds.skip_clock_update || !clk_mgr->smu_present)
 		return;
@@ -291,8 +292,9 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 		clk_mgr_base->clks.socclk_khz = new_clocks->socclk_khz;
 
 	clk_mgr_base->clks.prev_p_state_change_support = clk_mgr_base->clks.p_state_change_support;
-	if (should_update_pstate_support(safe_to_lower, new_clocks->p_state_change_support, clk_mgr_base->clks.p_state_change_support)) {
-		clk_mgr_base->clks.p_state_change_support = new_clocks->p_state_change_support;
+	p_state_change_support = new_clocks->p_state_change_support || (display_count == 0);
+	if (should_update_pstate_support(safe_to_lower, p_state_change_support, clk_mgr_base->clks.p_state_change_support)) {
+		clk_mgr_base->clks.p_state_change_support = p_state_change_support;
 
 		/* to disable P-State switching, set UCLK min = max */
 		if (!clk_mgr_base->clks.p_state_change_support)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
