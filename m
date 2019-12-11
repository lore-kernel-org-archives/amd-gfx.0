Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46516C00454
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7482173E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TCVkiDte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7482173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B35906EB84;
	Wed, 11 Dec 2019 15:33:43 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760045.outbound.protection.outlook.com [40.107.76.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605006EB8C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWv5S75NQXmd6eqYWF5HeFJNOCyCYUNII3CwRvKBzA83kiqaVNuYGZX6CGhlR/+6quvStZP1priRRGvYsMgh5m1HJP4BolobTjvwqYBq2tIw1UqTrlpwglv6yNWj5riQgkE+NFY97zo6Cqzktmc8Fj/bM7xzNlMMju4zdWfasppFSB1A+HDj9rdSWuPUV2G/cu5s4ioHK7nD4WwOosExoQ6/NcQU8XNIpsQmQNneJhN4liqJVTQugfMYjJhM1K04lENoZsj5Z3FrWC9sSJazs2OiFT4OaBWeVYSSBkswbMvr8vmckyUGaumvOOMrjus1nRp/qp552v87COzfErOaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MU25GB8ryZFcsSsOe4vjO26PPYCVN6F+PuSDWAOr0n8=;
 b=XARfpcYE+oy8d3yLRUV+SJCRYzzqk1erimoBYY1QtSKrTlgzVseE87lrXc/OmMmwGzxlMuuFaEOFEiLsS/1eyiV2KfWInUMcoAVzd9Umn2UtraSNJqn4iWdHgbdYgYeQt6U1D/Br5SAK5thYgLJywmf6Yjb4rPEY8wf/DXiP4gV8PJjn5lVDWutQ/zrl6AHeReSKQrvCnRTw1MY0nxaWSrbN2qMuP12FodFYqJ42zNvDiQsi6621OQv9zYJ4Y9+1cXbD6CmmbWT/s4g/kzc+ApHA/JowL4mURwYtsQL6/JzLLfnzESxUm9RVlvTuh0GFo4+VpNUnimSdu66x35LKcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MU25GB8ryZFcsSsOe4vjO26PPYCVN6F+PuSDWAOr0n8=;
 b=TCVkiDtetAWGGPBUpg/+2WPWvOKWmUg3sRbhak+vee680HsyF/oVKmVfwFo/2WvBe1S0aNXRqqeHtdSHBBK2mJJXEFqXrQkpl4jFYTiGnXADPzldL8ffpxlMzVORnFhP4t4XbloHeRNzhUh5tuwhEU1hjS/9NpdzWQLY71s2Y7w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:39 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:39 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/39] drm/amd/display: Remove reliance on pipe indexing
Date: Wed, 11 Dec 2019 10:32:40 -0500
Message-Id: <20191211153253.2291112-27-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 59babe23-186b-4fe9-cb51-08d77e4f7f21
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491AFA775CEAE51107830CB985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(6666004)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7PmZMhh0kC9n11gR5ssmJb8WRW/E/vC6fjzwAJrG3IbFBdhcD70ddOuirCkGWhFvBAF/WIXvAIXZ1THAbyp4+E1kd4O5Z9sNZQzfRKwSginoIZ/fv78ZLF9JHPPPCc+tO84yl9qiR7wPo6WPYLP6FnG0lPuvynKsCEOxP/kdVQVH7NDByhUoqukyW/EVlNFwFmGSw+HhdEb9GV1X9DPBl0PQwAuh95FI/xr0TOLrXNmsHlE2uI9Nmm4AH+CAb+wAsAPg5Ap7zNZfXmp4FPHUGThhtSycR8dbL2g5aEm0tKheEQVgJG5C1dZ/vBaKKJzapGTis20NFRNq7/MllQ0blCciYH0FjR3h8BGTuVqVn/NLiSQflsJ76UcasdILCIsGLc3DOSLUhAGlf3cSnjO/jj8mO0047X4iI4OlhxckkZJtXIQZnEjU+M8yAUpmjOp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59babe23-186b-4fe9-cb51-08d77e4f7f21
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:39.8610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2aDa65/i9DUzaPNlGXuwvrS4+k+rtxRF2zm4Zkswkkw53c1NDjxUGf7pokZ2P4QKsexSSDHk1RUiLTz7aBSOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Harry.Wentland@amd.com,
 Noah Abradjian <noah.abradjian@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Noah Abradjian <noah.abradjian@amd.com>

[Why]
In certain instances, there was a reliance on pipe indexing being accurate. However, this
assumption fails with harvesting of pipes 1 or 2, which can occur in production B6 parts.
HW hang would occur as a result.

[How]
Use hubp index for mpcc, and do mpc_init for all theoretical pipes (including disabled ones).

Signed-off-by: Noah Abradjian <noah.abradjian@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c        | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index aa389dea279d..9e53bbd5d2b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1163,7 +1163,8 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 		}
 	}
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+	/* num_opp will be equal to number of mpcc */
+	for (i = 0; i < dc->res_pool->res_cap->num_opp; i++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 
 		/* Cannot reset the MPC mux if seamless boot */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 3706299906e4..aa00fbe49c6e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1356,7 +1356,7 @@ static void dcn20_update_dchubp_dpp(
 			|| plane_state->update_flags.bits.global_alpha_change
 			|| plane_state->update_flags.bits.per_pixel_alpha_change) {
 		// MPCC inst is equal to pipe index in practice
-		int mpcc_inst = pipe_ctx->pipe_idx;
+		int mpcc_inst = hubp->inst;
 		int opp_inst;
 		int opp_count = dc->res_pool->pipe_count;
 
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
