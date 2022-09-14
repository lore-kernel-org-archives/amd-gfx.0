Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D304AECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A6B910E7EB;
	Wed, 14 Sep 2022 03:28:46 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F59D10E7EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVtbQ4sCrYOmLNOF/QG/bUI7vONapD5UvbwKJwi9TicCdx9TxW3IHoHFW39qjEHG/Ik7BFH8d767K+Qbi8wHfxYmrYiE7SVw2Q8T7yeEo1PjZPyyiMbsufV+h5hk7tR42RCM+kcyrR7jsLCkL7pGWCeM/bbx6mR52ni/lWpeUD64XEz2hIj5I/YivdI48Et5+5z2LJNo72YimzGdGkzeKzfckHwdCMdHGXVxQHnrFcAxrbCSglLvham73HA0wtPn/MIDgok/UGboApPMaVw5fyId3cAfBeLO9QABYTlMQsqTSgVp99Glj+xUur8jjaGMjNcB5tISrz0waESLjnraBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ustIEJ7rt1h/Jxej59DLgAVxmJN1egO9c6HGTnDG204=;
 b=AngakZ5cPEDwlW1wb+IntOuUr19QcIL6S1r29dMf/yjbJNA9ssFyy4wnaYnKe7So4lAhkm6wjzKoWGhcM5FpdGzYhoLOprhzdPb8LOqLGf6zqrYWwuLkswzx04IcRZNpYqOnQcraqC/QH0Tzi7E1Y3euHIsJrl3Us6C9F7EQEfhrwAQLzH0twk5/ZdBw+Dnpuep4CjGXWyYfAI7VW+A5GcU/aBoSTAl1Vy6sbq4XWgvpsl6JUhrLEpUi2q2iv+cGbkVBwu+zycWyC6n4SPFIeCVVSO1wXF/sbYHzfQlloDBXt1iBivHy0IKrunCQgZaZEdFaZ3qUkoYOqmrRWUN//A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ustIEJ7rt1h/Jxej59DLgAVxmJN1egO9c6HGTnDG204=;
 b=TRVcdrFmjbnFpIDswcqLBAlQPKxl5lbWOx2a0byuzTlaVuYf1T/jJ1cEr01I4/EzRCCs+nrnUnkRqLdfeKJ/ajOSOUUnZQTiztBP1yXc6Zldhz555LRPXARKg2y9FVDnW1jnzjiJzqBdUyd+38syuCR4kWmGCcK2Aa0BcQfD8/E=
Received: from DS7PR03CA0344.namprd03.prod.outlook.com (2603:10b6:8:55::28) by
 CH2PR12MB4939.namprd12.prod.outlook.com (2603:10b6:610:61::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.20; Wed, 14 Sep 2022 03:28:37 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::2a) by DS7PR03CA0344.outlook.office365.com
 (2603:10b6:8:55::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Wed, 14 Sep 2022 03:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:28:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:28:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:28:02 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:27:58 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/47] drm/amd/display: For ODM seamless transition require
 AUTO mode
Date: Wed, 14 Sep 2022 11:24:06 +0800
Message-ID: <20220914032441.1075031-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT006:EE_|CH2PR12MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e035be6-6c52-4212-9aaf-08da960135d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: faPCeGuImsY/5ejw5gxnpHpFN1aqytBpJeg0aVc1mSH5iyqiLeppFw3I4TLLeNvKZAa3V254lpONXe572nxwLg8caEEOEGAgTdjwLNzAJ6FDoflOEGviKz987vD77l4ylLNAmIQODQsoLPXycwaxX+wPDjxlEIpWoWtpDfCWWFPJYthgGSmWHrGdn1ypvrzmlwXcmmg25sylx8Yhb+CaPJxTI6e4P8TBnq/OTrWzKLsISJ0xR84NskiJ4MFr+hb8YpH7dXNVnMfXZej3qDK3B4BmSqsDJAoNrAnK1Mq3uGPZ0k3FABHtOD4yWSxxp6PSlFrNt+LyDgcqFjirDAd3O7JcqNTwDqlExnOkJidBDDcYNcNMhmN1DXbzNSEXpkvDbzvSRUe2izEmncQ5yAYeLf93Ga4NLuR5zkSHl5vNTtpHNz10Xv9gHbfLlTVlgZbno61EM3vzz8NcNto7GLllw0iDzjuuv+kvMxZ+xrYIFMBtLKsKH2Ago/ctknkSwMqtSuTB792FDpZqOXWRFqAFEeR0S5wBm0dKL+P0S6vVHSQ1MobjvLng/ah0qD3L38PFNPpTaaJqKg1H1byRxKdsRNnbBmeT+ZzK3Sqn7MMXrrzyz+mf/pD9+NaVXSXhmgEvlBkZU/Pi9eGBuJwAbYc08hhKKYCJcNQLQ7idmACwAU1B6TVv7CfNEjkL9+4N2WNnxMlO5sNLUfhtNq8ROylv1J4KxakogFL/I7ePVRUoFqRlzFnshIE/8OHwL7FFCvzwZQGtl7Jyd4j7vM41uDGH5oguRLfg1zXc9xfPQ23sq8pb8E4L4VgspuPm+EDvk0+q
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(70206006)(26005)(7696005)(47076005)(336012)(356005)(6916009)(5660300002)(41300700001)(6666004)(4326008)(8936002)(36860700001)(40460700003)(81166007)(8676002)(54906003)(82310400005)(86362001)(36756003)(1076003)(186003)(82740400003)(478600001)(316002)(2906002)(83380400001)(40480700001)(426003)(2616005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:28:36.7471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e035be6-6c52-4212-9aaf-08da960135d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4939
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
ODM seamless transitions require DIV_MODE_AUTO. However,
DIV_MODE_AUTO only works when all the horizontal timing params
are divisible by the ODM combine factor. Therefore, disable the
ODM 2:1 policy when the horizontal timing params are not divisible
by 2.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 22 +++++++++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  3 ++-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  2 ++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 29f27e3fe3ac..5bedee56acd4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3645,3 +3645,25 @@ const struct link_hwss *get_link_hwss(const struct dc_link *link,
 	else
 		return get_virtual_link_hwss();
 }
+
+bool is_h_timing_divisible_by_2(struct dc_stream_state *stream)
+{
+	bool divisible = false;
+	uint16_t h_blank_start = 0;
+	uint16_t h_blank_end = 0;
+
+	if (stream) {
+		h_blank_start = stream->timing.h_total - stream->timing.h_front_porch;
+		h_blank_end = h_blank_start - stream->timing.h_addressable;
+
+		/* HTOTAL, Hblank start/end, and Hsync start/end all must be
+		 * divisible by 2 in order for the horizontal timing params
+		 * to be considered divisible by 2. Hsync start is always 0.
+		 */
+		divisible = (stream->timing.h_total % 2 == 0) &&
+				(h_blank_start % 2 == 0) &&
+				(h_blank_end % 2 == 0) &&
+				(stream->timing.h_sync_width % 2 == 0);
+	}
+	return divisible;
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 6bc0fe922599..d757d1638fa7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1871,7 +1871,8 @@ int dcn32_populate_dml_pipes_from_context(
 		timing = &pipe->stream->timing;
 
 		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
-		if (context->stream_count == 1 && !dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal)) {
+		if (context->stream_count == 1 && !dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal) &&
+				is_h_timing_divisible_by_2(res_ctx->pipe_ctx[i].stream)) {
 			if (dc->debug.enable_single_display_2to1_odm_policy) {
 				if (!((plane_count > 2) && pipe->top_pipe))
 					pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 58158764adc0..a58f80ac94ba 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -224,4 +224,6 @@ uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter tr
 const struct link_hwss *get_link_hwss(const struct dc_link *link,
 		const struct link_resource *link_res);
 
+bool is_h_timing_divisible_by_2(struct dc_stream_state *stream);
+
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
-- 
2.37.3

