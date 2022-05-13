Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7440FC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 21:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2502210E5BF;
	Fri, 13 May 2022 21:17:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA81610E59D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 21:17:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRfeUjDyDnP0YkiG4rP4dvLqyWzLv5TxnJev153ufduDRV8mldIuSX9gw85nmQBH32m3nn+OsVFnSyFU3iP+2IG1yYlxfTfmqB9cCQYXCmGluhQhqngO8nyMcDFzi1xwLcu/FOV895aow+J9EiG+oMqb+MHOib8l3ptOBvNUVFfMV6BI9ekWIk+7+1fRZjF3qYBwaycUvQ2nQUoEjzf9s3SFrwnPToiHqCJCms60G03Km6mmNtmGH+1m4iW4iUDXAVKdAP6IVyoo50ff/nMsbphVQtryCWyeunAv9ggy0S6+1ipKuZR4AWYQPf7Vl5RVYsVSzWQDl8b9BItfBzjERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9BA1AkC/w1FSEUSj0YobsSXK9Y+gbOdyDtbdejtWAk=;
 b=N0EGJ+cBIkcJSET8rBycsrSHFJbsFLoDG1wPHT15MMywXsiRs83ODXFFrrtAu0rmHEbPlDjPi5nwkpVV8rWtxZcaHllVyIeu5qJ8wzPIBaCYbGxbUVa88+yllbXZXoOuN+aYlqsyRI4lcKdLZflY5qQ1lEBqVFUXjkLj9YjerWlqVG09IwsErF9kkjvUAZWegmxcRj4/3dBcj8ROJy4pZw4LYkzBwoDnnJvz9wIusrT8EAncOOPMOgFbvMa0OAnI7fqiYqW91tMP6iEtaQTJGGq/zCzypzJzHzgZKxukIuHRs3ePfbr4G7uR22MNZF6APiZ0PBolOBjnKspJCtftcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9BA1AkC/w1FSEUSj0YobsSXK9Y+gbOdyDtbdejtWAk=;
 b=qV1PcLM1P1476/zLpkajllId92EbeH8IohurtBqiDWTh6OrmyJhOX0OsWm5b8dBgR+NQYOfF2DtfdjyNeJSCexCJ53YEIQ4QOWzhPTN4J0fZn4+6XBiJC8LSp88ImXpZCvIVp4unuJhRdxuQxKFXSZgFOyp2pLtFkAoV5SezsmY=
Received: from MW4PR03CA0023.namprd03.prod.outlook.com (2603:10b6:303:8f::28)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 21:17:29 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::37) by MW4PR03CA0023.outlook.office365.com
 (2603:10b6:303:8f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Fri, 13 May 2022 21:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 21:17:28 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 16:17:26 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 09/11] drm/amd/display: Fic incorrect pipe being used for
 clk update
Date: Fri, 13 May 2022 17:16:49 -0400
Message-ID: <20220513211651.1312846-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
References: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c05f7d6b-f2fb-4027-149f-08da3525fc57
X-MS-TrafficTypeDiagnostic: DM4PR12MB6638:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6638A5FDFD709143EF7E472EFBCA9@DM4PR12MB6638.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPFHtnS0cAWTLfdFK6xYLh6gY/39Rze+GMnJDlEfsNBBzxu7QdXSqnCJd9oQFEP0UEKLBcrNy7BC15ngmUJ8K19HeiueLEheVkyfFMGFpue9tUZdd97w7RXsjerxXBVdKq0BvfF3Bzfqi40tQND6gFvVTMVyapqRRBom4kNlbdwXu31orUV3VmcUo77cbqWCuChRY8hQZmgZFD+Q0Y9iAqsc7RfeqqXq0xpcQbj6Ty3wtZ9WGrp6KYi5sCE7lWYEppStVHljFVlj9M4Uh+GRTztzidkjgsRupRDXD/WUBOz/qyZ/XQl2r52AR7BgguUMOeAMFDFMYlnQPhtKj7k6j9fLR34Uw0ycpaaC9u9kdYdrIeWX8WGr7MekLUtzLrrfvyELPPqewa7nOxMe+8EvlVT4NMiyaGpXrs5mE/14Kt5Kx4zNrP9450HBBEMU5zCDtLJ2ELCmO6aDPeZF52CWSyRQNOlriQzeAI8wpPddaZYqjkHySRcAi5eD9R5ENvKtW+jwOoynczv3Cj47TQP0hKd9UvF67GrTkhZW0WxWCVVAg63QiOdblCrTimLYScBj7eFxxy9ygbUNgM6u1wdfcY0tSjFGItqYzjsz7uEVpqKW3YUQXcp6OmjawiFtfo6QGscAal4IhYRKMo9o68AqOit8uj/L++lTy14LPv/g1VRjk0VOAezx0Y9dnDj/kYKOoqEXhTeZ6mnxPxF9bCiNnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(6916009)(8936002)(4326008)(70586007)(8676002)(316002)(356005)(5660300002)(36756003)(2906002)(15650500001)(44832011)(81166007)(70206006)(82310400005)(6666004)(26005)(86362001)(2616005)(186003)(16526019)(508600001)(36860700001)(47076005)(83380400001)(336012)(426003)(1076003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 21:17:28.8099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c05f7d6b-f2fb-4027-149f-08da3525fc57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[Why]
we save the prev_dppclk value using "dpp_inst" but
when reading this value we use the index "i". In
a case where a pipe is fused off we can end up reading
the incorrect instance because i != dpp_inst in this
case.

[How]
read the prev_dppclk using dpp_inst instead of i

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 02943ca65807..cf1b5f354ae9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -122,7 +122,7 @@ static void rn_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 		dpp_inst = clk_mgr->base.ctx->dc->res_pool->dpps[i]->inst;
 		dppclk_khz = context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz;
 
-		prev_dppclk_khz = clk_mgr->dccg->pipe_dppclk_khz[i];
+		prev_dppclk_khz = clk_mgr->dccg->pipe_dppclk_khz[dpp_inst];
 
 		if (safe_to_lower || prev_dppclk_khz < dppclk_khz)
 			clk_mgr->dccg->funcs->update_dpp_dto(
-- 
2.25.1

