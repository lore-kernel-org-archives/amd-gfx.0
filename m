Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA28EC47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A596261263
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A596261263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6601E6ED91;
	Thu, 10 Jun 2021 16:29:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA7DB6ED8A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaUniDAFS6d0kHHDQKAJtRBIslcNgvSxzaVh7Jq8+gc1EY+RGqN2z3sB58tKKsqp29VTgjtXUnWqQDbNFcSSteEzk9hzFMnglvHnxifginy83refJi8pQHXNrQA6avFUnMsWERKgCOopJvV6o+IKAln6pcm7yjLVQLxfrWCFzaUuQOW9HhYrnRWAionTwsmfFGamIQs/tp5oh7TY+czbE7QofMZ+mlrOzWaCoE7mxu5is55ooNBMiDOO5WnvvC25zEVvxFVEUZWzcGcctruco527poxDruBuluff3pF93gMRGhxeB49xxGCxu9xi5ELgNvL5UdpuGrxZwCczU98O6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQCr34GtdeinvvsOSDXchkrUru6SIKuvOKy59VfFMss=;
 b=TpGP/Woj3atdNip1gzGDto+hccU/oflAg5sGym0nZwLBU6VywAg34JNTWNY85HkIZyR405K+cfHKiD6JO50moGFTp03STBJFHdRl4ZONMQZrUzxBvg+0M+R9Lo7/2hGkWeY/IYbYx6eFEqoodIDnUthw5QOgrzJMW4xaxDTGg0nJMebqi0YaJa1tIramGjHX+pvQRKxPcL1a54J90U0QuwGVR2sbbuT/4crNu8dN2tzVgPG73JhS8uP4flMMysJC9BETJMCrhgowKJfo3fSimCwSynrwXFjFOYQXNlfESRkkdNR8slzT6Ge7MT2vjnraC/5RnMiklHukuhP+0RkYdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQCr34GtdeinvvsOSDXchkrUru6SIKuvOKy59VfFMss=;
 b=Zx74fTR7GyzfdlDfVl8Hs5X7EhjHXLSNjXoNGocMo44EUIMZcS4J/GiLKxMgh1/Uw/TDxfSAiIx8Qr33LKWERMzdQsbg7vbuE2QtwolTi8+2NZ2Zo2AbCyCM8sHs+U53zeevQcayDt0/tJSC2HGCC/9SpPhT/LbojdK1VMBWK5M=
Received: from CO1PR15CA0084.namprd15.prod.outlook.com (2603:10b6:101:20::28)
 by BL1PR12MB5127.namprd12.prod.outlook.com (2603:10b6:208:31b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 16:29:18 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::7e) by CO1PR15CA0084.outlook.office365.com
 (2603:10b6:101:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:15 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:14 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/24] drm/amd/display: Updated variable name.
Date: Thu, 10 Jun 2021 12:28:21 -0400
Message-ID: <20210610162838.287723-8-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f886078-6f78-49c3-bf9f-08d92c2ce499
X-MS-TrafficTypeDiagnostic: BL1PR12MB5127:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5127E71300A66738991B4BFEEB359@BL1PR12MB5127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4j1uc0UgXIOIncS7F+liP4hpOa8/TK3WilP7LQTkmiZX7OWDcb2YgHb2SDIloTBMx6zt8ZJRlo6tx0MJsQP91dS0VAXCU12SCxXysULtlMy6jksNAAC+qEvshj5cDpUPdv7He8WsX8FAFTS2oP03hMYFGLl3Y/KKe59r5t/rTAXb2WnO8hRPFfGt/jvg9i45ZF2WRQucFKWzAIHKqIlVmxP5s5w7/4L0a9BEfOxKTL/pP3LDIUKju8UIvwqe+aPuZ2P0nRPV2FLrZCfU3DRX1C86p9LIuQkhj/sY5U1yovlMGSEPdXinXEvb4oP1VbNaXSVw5O36K8lCvhwoUeTQf8BDzLbw5BjV5vH6GDomKO83qk031B0BS1+RKnGI6RKbmpWUO7KUZvsGPJMP9T5LUWGGJhNbEH/odJezoOfcShFZKbNXt0gdojtzfrSnFKNKsoPQAma4l33wgxwonMLZ4TPXpjdwR2fp9BmqdSTkN4Yb511ta9szvNsErcyW9khHIuDvkvsd95MAZ/TGK2ZbCarIUezPRzoMB+l8VHmlviy9Rmw7axYsF3gja3km2A2dZX8sY/nPncL8EbQ9mt0N/ykJAAgBeLyD0m2lGaJxAYoy3UdVwRrzAsBNiTzLzMtu6Swiq/B1VU4LEghIw4RkOmjQLP3626NUk96utgA2l7R7mrxZs5ENNLWGFg9icxd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(36840700001)(46966006)(36756003)(6916009)(47076005)(36860700001)(478600001)(86362001)(336012)(426003)(2616005)(4326008)(2906002)(6666004)(26005)(186003)(7696005)(8676002)(316002)(70586007)(356005)(70206006)(54906003)(5660300002)(83380400001)(8936002)(1076003)(82310400003)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:17.3511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f886078-6f78-49c3-bf9f-08d92c2ce499
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5127
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
Cc: David Galiffi <David.Galiffi@amd.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[Why]
Fixed spelling error.

[How]
Changed "currnet_setting" to "current_setting".

Signed-off-by: David Galiffi <David.Galiffi@amd.com>
Reviewed-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 919c94de2a20..7024589791fe 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1806,7 +1806,7 @@ bool perform_link_training_with_retries(
 	enum dp_panel_mode panel_mode;
 	struct link_encoder *link_enc;
 	enum link_training_result status = LINK_TRAINING_CR_FAIL_LANE0;
-	struct dc_link_settings currnet_setting = *link_setting;
+	struct dc_link_settings current_setting = *link_setting;
 
 	/* Dynamically assigned link encoders associated with stream rather than
 	 * link.
@@ -1832,7 +1832,7 @@ bool perform_link_training_with_retries(
 			link,
 			signal,
 			pipe_ctx->clock_source->id,
-			&currnet_setting);
+			&current_setting);
 
 		if (stream->sink_patches.dppowerup_delay > 0) {
 			int delay_dp_power_up_in_ms = stream->sink_patches.dppowerup_delay;
@@ -1847,12 +1847,12 @@ bool perform_link_training_with_retries(
 			 panel_mode != DP_PANEL_MODE_DEFAULT);
 
 		if (link->aux_access_disabled) {
-			dc_link_dp_perform_link_training_skip_aux(link, &currnet_setting);
+			dc_link_dp_perform_link_training_skip_aux(link, &current_setting);
 			return true;
 		} else {
 				status = dc_link_dp_perform_link_training(
 										link,
-										&currnet_setting,
+										&current_setting,
 										skip_video_pattern);
 			if (status == LINK_TRAINING_SUCCESS)
 				return true;
@@ -1872,12 +1872,12 @@ bool perform_link_training_with_retries(
 		if (status == LINK_TRAINING_ABORT)
 			break;
 		else if (do_fallback) {
-			decide_fallback_link_setting(*link_setting, &currnet_setting, status);
+			decide_fallback_link_setting(*link_setting, &current_setting, status);
 			/* Fail link training if reduced link bandwidth no longer meets
 			 * stream requirements.
 			 */
 			if (dc_bandwidth_in_kbps_from_timing(&stream->timing) <
-					dc_link_bandwidth_kbps(link, &currnet_setting))
+					dc_link_bandwidth_kbps(link, &current_setting))
 				break;
 		}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
