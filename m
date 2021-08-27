Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2E8C4320A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8664361004
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8664361004
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 125796E9CD;
	Fri, 27 Aug 2021 20:44:25 +0000 (UTC)
X-Greylist: delayed 886 seconds by postgrey-1.36 at gabe;
 Fri, 27 Aug 2021 20:44:24 UTC
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (unknown
 [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF6B6E9CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 20:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAf5exrRnpHRJ/djRLHbbe3giZtQs7CSFEWRnN9yYsUcvrrzq/0l38JxegFotgd1/tdrW77hRUuOuw4Af1s7hE6LLxP4vNCnUs90KK2pNUT01/kjIf2Py61h8l8CTpOsbkgVzEbzSGdDxQWU40rI4iFSMarsQRQJL202cW8oaWz4Ymbdo6jrry/38mEXKKWHm5Rcy3/QjtwIvhuCRkL5qPHQpQahKq7y2ubGFnEbPi2Ymy5n5IyV23Av+GINlstOVe57vO8Xa9SmvBhRLtTUfkR8TagXO/vvz68iTn815vsYrujnB4Ij6tU49BhCKo1IkUEIt5yr4uDRcJIQCFm9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzNiVl5A/gWT4+0dlKsqXvcSAnCa821/PPNFYFIOQ8M=;
 b=Mn+WRpow02gavlpXGYe4A4iyykJENjKw9/eZGFTrpWN+Gwji804QSFBsPn7qVW/+n4QgDdj18/ZQxczn/OV5hgxPT/4hIXVXCyWcBvpCa0HZN+o8uzzlutQGUqf+m/xhhobAV8Uinog2v6HnwXh4t8apg8CodymoqjEu+5WRkiQWNTtasHn6O81wOGbNzo9GJ2kNGlxwJPGyCEoJmWrT4pzvme5GkkgyJ8MBnu1VGej5sf9qh7Hi0T9Gbi0qdedZQbSwxOXH/NIbNNixqTbAoHMoc10qRZo6Yxh09dcEqKT89ffGAIvgmgjLMilf7Fq8K/GR/PDlDdMv6FP9Ov87Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzNiVl5A/gWT4+0dlKsqXvcSAnCa821/PPNFYFIOQ8M=;
 b=AQz9myNUUkSnXJPKt0/tx0Hl/s8m2QzeNVbL7SaiBaIDvgdS8cysnjcMs+he1wxFbL01ecAIDULX4iIRSjFTGbwofst9pTRG/5jzjCSgxASM89pGwRcIeEEB2ciR/y9jliX12H1CofGjdkeecfhdqLcvagp0D50xVcMY94cH+nQ=
Received: from MW4PR04CA0254.namprd04.prod.outlook.com (2603:10b6:303:88::19)
 by DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Fri, 27 Aug
 2021 20:29:35 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::5a) by MW4PR04CA0254.outlook.office365.com
 (2603:10b6:303:88::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend
 Transport; Fri, 27 Aug 2021 20:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:29:35 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 15:29:33 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>, Josip Pavic <Josip.Pavic@amd.com>, Anthony Koo
 <anthony.koo@amd.com>
Subject: [PATCH 10/19] drm/amd/display: unblock abm when odm is enabled only
 on configs that support it
Date: Fri, 27 Aug 2021 16:29:01 -0400
Message-ID: <20210827202910.20864-11-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827202910.20864-1-mikita.lipski@amd.com>
References: <20210827202910.20864-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eed48b2-207c-4055-4277-08d96999629a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:
X-Microsoft-Antispam-PRVS: <DM4PR12MB53918A6148AE8433EC7591F3E4C89@DM4PR12MB5391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQebLbJ0Aaf3EDneNuilBY45xkn1+uWrp3qs1kAzGCPydO2gHMMLZHDSq7/6vftiZVcWk1AHflKeILXnkmXtOmcao8pEHAB27+jC2nrHlMpYFXbLjl4IamwXkeBCEbxLgu3AUO0dYCv61DnaInFHJAf6676uagQGJzvBiI6nikWJ9nCs9bR7YsrjzvCWj9jRFvgdTPE+zAwzpDT4ORo2r2irM75lpr2ZtMl2On0XVc+nyA1YFuxa2i7rDTO1GONFTGqztiyfnp99zG5qrBiFyZ6Zu83f7Ra4Gjs0gA70NziJJHi5OCz6q3BoErBOXM+pnPWCcU4+4s+kth0+ItdJIsNtlgIeaYvYMerl2ogNI4ofu9n/DTgoBXSSnR4ZMYEjF1t9CuBin6/fdFZPD6CpYH0U7amt+9hYdy1DkbGPkurICE+VhGMgZEuQxFd90V6myFzrLjTfRPgtLUtmx56fYW5HjtxvILUjxg25eYXEsPmXx58pdeu+E0bbQtFVZCbVaEe3TBf0kwPP/3gTlektcifTtvv+L98PUmCteLDWnurxBtM/5ArySLPCH4U5PZMsOjZ04pOV6xiWzWClypw0KOwh+heFPqBkisW/bqKHBMHe9xY2zeLXg8BG8Y5LUQn9aJey2GPpQbi/fqrRnjk8MPZg5UpE1gQAbj15Fi0FxA/qBTSz0JAscnbQ24r87sHgdtDgUAZbveoOepMX7YiVs2C/eFLfTK3RYx1Iqi9Vud8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966006)(36840700001)(316002)(70206006)(2906002)(1076003)(8676002)(44832011)(16526019)(8936002)(54906003)(4326008)(36860700001)(5660300002)(426003)(2616005)(478600001)(356005)(47076005)(86362001)(6916009)(336012)(36756003)(186003)(6666004)(83380400001)(26005)(81166007)(82740400003)(70586007)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:29:35.3266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eed48b2-207c-4055-4277-08d96999629a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why]
When ODM is enabled, ABM is blocked on dcn31 but unblocked on dcn30.

Since the dcn31 firmware is now able to handle ABM interop with ODM, it
is no longer necessary to block ABM when ODM is enabled.

Since the dcn30 firmware does not handle ABM interop with ODM, leaving
that combination unblocked can lead to one side of the screen appearing
brighter than the other.

[How]
When ODM is enabled, unblock abm on dcn31 and block it on dcn30

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 15 ---------------
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  1 -
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 3a5b53dd2f6d..93f32a312fee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -100,6 +100,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
+	.is_abm_supported = dcn21_is_abm_supported
 };
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 07a9e0feda99..e7994c4f7f02 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -584,21 +584,6 @@ void dcn31_reset_hw_ctx_wrap(
 	}
 }
 
-bool dcn31_is_abm_supported(struct dc *dc,
-		struct dc_state *context, struct dc_stream_state *stream)
-{
-	int i;
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-
-		if (pipe_ctx->stream == stream &&
-				(pipe_ctx->prev_odm_pipe == NULL && pipe_ctx->next_odm_pipe == NULL))
-			return true;
-	}
-	return false;
-}
-
 static void apply_riommu_invalidation_wa(struct dc *dc)
 {
 	struct dce_hwseq *hws = dc->hwseq;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index aaf2dbd095fe..9b0f7c22e7e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -97,7 +97,6 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
 	.z10_restore = dcn31_z10_restore,
-	.is_abm_supported = dcn31_is_abm_supported,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 };
-- 
2.25.1

