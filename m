Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEF4C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B528D21D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Yytb0bvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B528D21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C73B6E958;
	Thu, 10 Sep 2020 13:48:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F8BE6E958
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcYysuHLDNdLjrmZAOM22ehOw/DeGWXYD+FwivaAkdwrzF1BhLictdQfcssrpN0TjlBulzAFaSc5MwMoI9QLUYpe21It8IgHTfSpJxdB448HgbW3qZ+8RTWgK39iLJoTyUxOg626Thak7j18QAnCV4QlUSa+pmrS/vM4YcVYFYtnSawYYKtpcUJ4YlicAQojnPrYdrNsgb5HOw+/fh3ZdpsTx2RuNzCa/uOcicsHAkuP40iIj0GDUhZ1XvOsnjCbzMtTxMmuFlYTw9EJzUCgSmM0HRCSPE+wnwHO4by3TqNZQidAa3GJAJvEwaJ+bRivVX/T/yN5ytUKMLI3o2P4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLPkH1fYkmgCrgg6TlNEFtc9pIzOyEQgIakwolW2Tfc=;
 b=VhNkG7ji4pHE4pfnsEZ/rRlyKvHV7ZTpVYGf5BVlEBgV4NDAEY/hdTlg54UwO+uFnkpT+bLwDuHEo6zvRdrRj8AzkxJ6rSycAxJypvWb3y9H0NxX3QIV0HHkDRCD9RtkB0jwbbuUomNINByPjaxNoL1iR+pCLfCDRMAi6P4jfZ5sdCu7Fr53dPqzN5WToqAwJ4EaMOuLkanL4g5v9ZgZ8QRYH3UyPtlYHiMSqOpS4ZquuMehFWoYvI3OvbhzESJTLwFpoYM96akU4oN4H9BYdNij/S8PIeqgJwJc29TuYocoqoFOENg87ttJwwjTYFNbVU1OjkCYc4niyvvmiv8ZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLPkH1fYkmgCrgg6TlNEFtc9pIzOyEQgIakwolW2Tfc=;
 b=Yytb0bvRuUW73VieBft3ppBcnencOF8vW8xsMTGXV33fiJ0N0cjrJ0sLXe9rO2UlWBMnLjWuao0MhekGkjD6ctam0add70agyWiGPE2sPAYyZe7PLfpxZwccwA68CcvxPyv/wp2W7ge0BCRRGraDO/Fau+HpNt74GZFRmkR49rQ=
Received: from BN0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:408:e6::16)
 by DM6PR12MB2620.namprd12.prod.outlook.com (2603:10b6:5:42::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:56 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::83) by BN0PR03CA0011.outlook.office365.com
 (2603:10b6:408:e6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:56 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:55 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:55 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 32/42] drm/amd/display: Update idle optimization handling
Date: Thu, 10 Sep 2020 09:47:13 -0400
Message-ID: <20200910134723.27410-33-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ce4984e-1a1b-4a8c-36f0-08d855901f79
X-MS-TrafficTypeDiagnostic: DM6PR12MB2620:
X-Microsoft-Antispam-PRVS: <DM6PR12MB262090ADFB163C23EE61CB198B270@DM6PR12MB2620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3eID7k+1O8OY7H+WKiHAo2rzJYrCTz/HEFGE79eDGMAmoaWEmaBHTnIrNxRS/YYTmhLog1drLCVl4/VSgWZtkX8Cfyfj/fLVPyE5DzzzSGbYPY1lZVtVK4VSu53Kw0nNNMW3pDcx/n8exiidkxLy5TGKTfITg6qC0AVxttEtFwdpFLJPclvSwKQiDq0mT564SlTWcKWIzjWCOR8S7pLqaHfcMYi/e6EEr4RtESlUjHB/VXtYUGAsMjMeo6n84LlN3JEkCE1U9KaUqQnZvLxdbn8on5yWt7nl6uCnuMooYE6q1YBZJWrs0hc5uSNPnbUQC3oJlLtxHkOQx/jYPJCdxHisz6Ggesf96e+O2WpUm16MUxXevP91wn3YYHMWqWJuVjG60I+3YhLx9ltLGyWLMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(46966005)(81166007)(316002)(426003)(5660300002)(186003)(1076003)(6666004)(44832011)(8676002)(26005)(82310400003)(70586007)(70206006)(83380400001)(2906002)(7696005)(15650500001)(356005)(2616005)(8936002)(6916009)(4326008)(47076004)(82740400003)(336012)(54906003)(478600001)(36756003)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:56.4184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce4984e-1a1b-4a8c-36f0-08d855901f79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2620
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[How]
 - use dc interface instead of hwss interface in cursor functions, to keep
dc->idle_optimizations_allowed updated
 - add dc interface to check if idle optimizations might apply to a plane

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c        |  6 ++++++
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 11 +++++------
 drivers/gpu/drm/amd/display/dc/dc.h             |  3 +++
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1190c58275c3..7ab82d6a5630 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3039,4 +3039,10 @@ void dc_lock_memory_clock_frequency(struct dc *dc)
 		if (dc->current_state->res_ctx.pipe_ctx[i].plane_state)
 			core_link_enable_stream(dc->current_state, &dc->current_state->res_ctx.pipe_ctx[i]);
 }
+
+bool dc_is_plane_eligible_for_idle_optimizaitons(struct dc *dc,
+						 struct dc_plane_state *plane)
+{
+	return false;
+}
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index f42a17d765e3..6fef9078f3d1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -298,7 +298,7 @@ bool dc_stream_set_cursor_attributes(
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 	/* disable idle optimizations while updating cursor */
 	if (dc->idle_optimizations_allowed) {
-		dc->hwss.apply_idle_power_optimizations(dc, false);
+		dc_allow_idle_optimizations(dc, false);
 		reset_idle_optimizations = true;
 	}
 
@@ -326,7 +326,7 @@ bool dc_stream_set_cursor_attributes(
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 	/* re-enable idle optimizations if necessary */
 	if (reset_idle_optimizations)
-		dc->hwss.apply_idle_power_optimizations(dc, true);
+		dc_allow_idle_optimizations(dc, true);
 
 #endif
 	return true;
@@ -359,9 +359,8 @@ bool dc_stream_set_cursor_position(
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 
 	/* disable idle optimizations if enabling cursor */
-	if (dc->idle_optimizations_allowed &&
-			!stream->cursor_position.enable && position->enable) {
-		dc->hwss.apply_idle_power_optimizations(dc, false);
+	if (dc->idle_optimizations_allowed && !stream->cursor_position.enable && position->enable) {
+		dc_allow_idle_optimizations(dc, false);
 		reset_idle_optimizations = true;
 	}
 
@@ -392,7 +391,7 @@ bool dc_stream_set_cursor_position(
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 	/* re-enable idle optimizations if necessary */
 	if (reset_idle_optimizations)
-		dc->hwss.apply_idle_power_optimizations(dc, true);
+		dc_allow_idle_optimizations(dc, true);
 
 #endif
 	return true;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8631d290afee..9d7d5dd9e820 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1250,6 +1250,9 @@ enum dc_status dc_set_clock(struct dc *dc, enum dc_clock_type clock_type, uint32
 void dc_get_clock(struct dc *dc, enum dc_clock_type clock_type, struct dc_clock_config *clock_cfg);
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 
+bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc,
+						 struct dc_plane_state *plane);
+
 void dc_allow_idle_optimizations(struct dc *dc, bool allow);
 
 /*
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
