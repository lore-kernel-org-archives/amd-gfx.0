Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817ECC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 17:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D60AF10E78A;
	Fri, 18 Nov 2022 17:01:09 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE3D10E78A
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 17:01:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrygjsGlK9rU7c6lnlDTYZ7JxNoyVH0mSq/4s1hYBIbimN/oRguSNMaJ6CQcRqYdGm4okwsTXEP/jyZn+u2DUm2PjuicPU2bNWhJOHjiI5kKCcOu4ms5kcbzgceSZtGzGP11a4YRphJum+COTjvAPVq9xu7csD33Ra6T9JuD3zKzTfMEmZmKH6z7bAcERenV18/3bI7N0HeiyYZexhlCyHXd070OU9wENHHG7zrCIkzdl3KN4b50uIIMyfIEVxCuHqxnC8ND4FJyU/76joIleV9Y3C+2CARAa+RlIHTBgEJT+LTL583dQqgRPpGrw7H4rYQyCPUyjOIzomINdKsGHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdoqz9Tn3zCKY6wJfB1YUq9Az1UveqkJw2eDzngI73g=;
 b=alDTNAx7Wiyk1xmvrgiIxOQKeuS9kIdTP+WKo6Ki6ruiR6q2jnFhnBFrm82A5k8218vnFcRFF0RckWXALIeGSNn2q4eHvoKojR1nsbQ54Yq2dic8iNiFqnhnlzX5wjIP573jh5qjV9lPMYhHzjjN6z0xVvRloGffWrBviWmc3rNEeGGJoFCuOyPWciQXUozGnEhzzvI9UzVJLp4D1NNxhfH1Bo5f/rmMqBn2bg+bxTuSLYQt59gEtxtw40REOn6nJiLNwM8bdJ1QCN8r2WHpIOZyraAnJ+T7r2mfhlxEbadwN64sRYWJVbunW14MKTi57oyULuvTsUZI19k3kHK8Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdoqz9Tn3zCKY6wJfB1YUq9Az1UveqkJw2eDzngI73g=;
 b=ADq0Y436wnFgwosq/ccnJYCg7SK1hxjlQkOAB6hSdaoNEDla7loSkJuO8e4LIvbnv9exCffhKjtWGqfer12c5WkyDqNB7u5qVZ9PKJ1zxkdp8pCxQqI92rNX/N2CYrGO+GMDKe1ZZjCxrtOaiyQe8/2Tx2LNF0/UZ2segnemRb4=
Received: from DS7PR05CA0079.namprd05.prod.outlook.com (2603:10b6:8:57::9) by
 BY5PR12MB4965.namprd12.prod.outlook.com (2603:10b6:a03:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 17:01:04 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::55) by DS7PR05CA0079.outlook.office365.com
 (2603:10b6:8:57::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.8 via Frontend
 Transport; Fri, 18 Nov 2022 17:01:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 17:01:04 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:00:27 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 09:00:00 -0800
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 10:59:56
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/22] drm/amd/display: Check if PSR enabled when entering MALL
Date: Fri, 18 Nov 2022 20:59:23 +0800
Message-ID: <20221118125935.4013669-11-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|BY5PR12MB4965:EE_
X-MS-Office365-Filtering-Correlation-Id: 9594c57b-b34a-4e03-5ccd-08dac9867a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QDXPdufm3HzN38mWSln+II2HZxyMwbhMPTPDX/Uo7O4yXKZg+gMxY4burvg3ivfSjzL5si4UGeIfhd0TqIwYeEf4w3jU0VFm2M0aqmNF9/6CF9CC//KK1zuA+54fjJolZ5iP70Bq3dzKILYS6tvIOZ9gzTb4mxG9GFV60EJgv4cFuHIGdhtTiyMOhKYUyJ6sTTNkAel0earRVt3lZRpZ4FpN18yluqpS7osIuDiRE6QVLxnSypVWd5uvdvYMj4wH4UQXD1DHAUT9tBHI9cI7dh2gN5Kcn2HM8QMmzY1F+TWBeLWoRVJhN/jwWG2pzU8NMz+GjZRuuFIVVYpkwNu9aVkkZ9NabBftyZN5ZTrYdK9aKuMz45yVIlQqjAbvLmfOkavtId1cT5nJg4dLcwMgR4li3rbZS3lXMyLUgyvdMOo+J+3Gc33e3LDx2j/ymsDvmtqyHTXHHawPZzjgrYkc24A1WjWXWDTYe16sO0fH/dsFn6VKn/ce9DJ2/hDKyptWKVEhKpbEkhkXd+ESyv0VodZ1tpAiSBuEkPV50dlwEOaZeHRuSTWldoHKlhGtnXyEcZM71oAHaxdtGVlxJ9hwLpSxsX8PXYqhr/m3liIH6V6BbLE25zZ/+quIDUQWj8Cq3j+UN3yaY5IgcrtyUloLlOH7qI68Ndiz4BkdxdHGedk+4/6OT5+DNW2SLdAyn00KE9s6QfnkMGowad1hUDbmmBh9TjfyA/zkWU+IAyTXynxF9prmbGb/iljLIQ32Ul6GXqmWGpDKKoGdSZfFryPOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(6666004)(478600001)(86362001)(6916009)(54906003)(316002)(26005)(41300700001)(2616005)(8676002)(4326008)(70586007)(8936002)(70206006)(186003)(40460700003)(1076003)(7696005)(36756003)(82740400003)(2906002)(47076005)(83380400001)(40480700001)(5660300002)(336012)(426003)(82310400005)(36860700001)(81166007)(356005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:01:04.4057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9594c57b-b34a-4e03-5ccd-08dac9867a87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4965
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- When attempting to enter MALL SS when a PSR panel
  is connected, we have to check that the PSR panel
  has already entered PSR because the vsync interrupt
  call is per display index (can be called for the
  non-PSR panel first)
- Also don't override link settings when programming
  phantom stream (main and phantom pipe share the same link)

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c  | 9 +++++++--
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c       | 7 ++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index c5380ce70653..913a1fe6b3da 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1561,8 +1561,13 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 
 	pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->bottom_pipe != NULL;
 
-	pipe_ctx->stream->link->psr_settings.psr_feature_enabled = false;
-
+	/* Phantom and main stream share the same link (because the stream
+	 * is constructed with the same sink). Make sure not to override
+	 * and link programming on the main.
+	 */
+	if (pipe_ctx->stream->mall_stream_config.type != SUBVP_PHANTOM) {
+		pipe_ctx->stream->link->psr_settings.psr_feature_enabled = false;
+	}
 	return DC_OK;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 763311ffb967..61f129faf251 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -227,8 +227,13 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
+		/* If PSR is supported on an eDP panel that's connected, but that panel is
+		 * not in PSR at the time of trying to enter MALL SS, we have to include it
+		 * in the static screen CAB calculation
+		 */
 		if (!pipe->stream || !pipe->plane_state ||
-				pipe->stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED ||
+				(pipe->stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED &&
+				pipe->stream->link->psr_settings.psr_allow_active) ||
 				pipe->stream->mall_stream_config.type == SUBVP_PHANTOM)
 			continue;
 
-- 
2.25.1

