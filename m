Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFF4C4707F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2565661168
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2565661168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9EF6E5B2;
	Fri, 21 May 2021 17:37:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D2E36E51D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 17:37:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2erK864hFKO4eZFkWXhJM5WzFQfACBlyvPQRtWw4znpfoyijd7NVPmmDjla6qIFquodMaP6Ffa5//4YF46TmOYnzj96Jo5ZHWHYX1CauBXyvdZf11C/Bk64/NcEhPVF2W31u1QeyvNbPSyczuRLz3FautJw1btIw1iMcfLLHEFYZb3AFJTtmZ8INC9fUxAzN0SwzdVEjqpg8A6yq88rSDMqIpJuLlWg60w13P2RVBHueAxR4HOW3PnZUDAo6KReHkYlhluGXk5Z21EHJEVjjcXrMX6irNF1tuA1OQ0mTCXSMoljm1SEb52OnLBvNp+iZd5cs5kcFantvNrnSPJuww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO1bxp+ShAGhykxOy212V8fSxNXpV2i/det0Rc0vewc=;
 b=YPGhQw1yJZ75mbhzNx1b6UnE+rvMexO30MFhph+00TAJyevHnt7eFVqDA8Csa/1UUIGzMpPZbb7zurJrOe6Z+gS4HMronH8W3D1V6b5onm0v5QVvmtAeQhj1W3JYBSv8qyFAcnpOIEo/BcGpv0UvcaBfCSLxXg3CBRAvhu4zi2SabuVy6wUqC4Jyjm7SGL0yWf/JAP6EgqBsQW37ZFgEunU6l0WsmOZYwmbuwpM0GN+Z4pr3zP8I4iHCOpsgzuhetglxGVhtg6LyxxYyMq2vj87bBavVVDtYRZmAF4dEPDm6XCLsirzVqO7xDlXJXQwfYU7i39cycl/IrBxOjkD0Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO1bxp+ShAGhykxOy212V8fSxNXpV2i/det0Rc0vewc=;
 b=pXrwfW2Up2pIL85B1t2MF6DvSu/r/rGeit25Jr4BxBYE/kIuGDgB1puaXeWbSyuzIO74u6BM6HaNYQ2/OZfprZXtBYVhPgoMWkw2EYJ51PH3+d/bvKXSrMZmXAXR0EzEy8TGZ7STIz4OimM4HO8XeiUzUJzJJFJy9s2Mv0L8kHk=
Received: from BN8PR15CA0068.namprd15.prod.outlook.com (2603:10b6:408:80::45)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 17:37:09 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::5d) by BN8PR15CA0068.outlook.office365.com
 (2603:10b6:408:80::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend
 Transport; Fri, 21 May 2021 17:37:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 17:37:09 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 21 May
 2021 12:37:06 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/15] drm/amd/display: Refactor SST DSC Determination Policy
Date: Fri, 21 May 2021 13:36:43 -0400
Message-ID: <20210521173646.1140586-13-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
References: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf9feea8-612d-4aba-68f5-08d91c7f0f77
X-MS-TrafficTypeDiagnostic: BN9PR12MB5161:
X-Microsoft-Antispam-PRVS: <BN9PR12MB516148FA58A0D531FC0930BCFB299@BN9PR12MB5161.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjRMJLudXYsspQhnOP6DKdIsn8ua2s5pPbGsJjuj7kAc7JV1H+RoM5IhdwjeZbdF7Fi5bgtDo5KCT6Bl1sj/FP8xg9nwZBqOZ1pDAIZi5f1cdBIR6tE8Z/LGQoRzfb2UXssQ4Pr7yTTIzHQpAZ3cFTXlKgaHEYUVhG7iN5RcuYfOBQaZMluLNk2aS7EFRFuKo3U7r9lCq+n4DlL6Puy5H83dE/uxz/Shw/3gwZ5IAqkbNIWjjTtrtvZ0yJmh79XaFwrEWDdMZtXqk4FljGTDgJmdltNj3BLNQZ6MooHWF6NHTzEijnIlxnstFG7vkRVsQ4MHmtbCUlRbMaBXU5Qhj0hBwK847gUiuFhcIPY++d3zz32JrjRPxH/aBT/y1/QlFrrGWJH9u4l2xUjUh1iH9ES5SZkadcx7kaHJPU5G/hC94EsGCzzY07EiXxqU8JFICHTM2rA0dYZ4EeG2FiBhtxG67UKpRYszXzD+XsR5SDHU4jOaNa1UOI5igkYtNYjSa7hH6og/iqVDNLoxsbdk3Spm3lu1CtrRrzGzYiOUKPceteKDa83ruQD7/LZdkT0avB+e3IjKcQEhynrvbEGiJd/EQ3wndDPu6PeXbn9ic66q/2tE4v5qkMbEwt2NId3Q6wlGOFaORbMKqz2AsjPYadqWMR4zMpggdbV3UjZccr9Lcl+ATNaPDOxp2YIXi0Ga
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(36840700001)(46966006)(44832011)(82310400003)(186003)(36756003)(426003)(36860700001)(70586007)(478600001)(70206006)(2906002)(356005)(336012)(83380400001)(8676002)(5660300002)(8936002)(2616005)(6666004)(316002)(1076003)(82740400003)(81166007)(4326008)(54906003)(26005)(16526019)(47076005)(86362001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 17:37:09.5114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9feea8-612d-4aba-68f5-08d91c7f0f77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[Why & How]
SST dsc determination policy becomes bigger when more scenarios
are introduced. Take it out to make it clean and readable.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 105 +++++++++++-------
 1 file changed, 63 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ac8dc341d956..f0703fe22c68 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5577,6 +5577,65 @@ static void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
 	}
 }
 
+static void update_dsc_caps(struct amdgpu_dm_connector *aconnector,
+							struct dc_sink *sink, struct dc_stream_state *stream,
+							struct dsc_dec_dpcd_caps *dsc_caps)
+{
+	stream->timing.flags.DSC = 0;
+
+	if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT) {
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+		dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
+				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
+				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
+				      dsc_caps);
+#endif
+	}
+}
+
+static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
+										struct dc_sink *sink, struct dc_stream_state *stream,
+										struct dsc_dec_dpcd_caps *dsc_caps)
+{
+	struct drm_connector *drm_connector = &aconnector->base;
+	uint32_t link_bandwidth_kbps;
+
+	link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
+							dc_link_get_link_cap(aconnector->dc_link));
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	/* Set DSC policy according to dsc_clock_en */
+	dc_dsc_policy_set_enable_dsc_when_not_needed(
+		aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE);
+
+	if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT) {
+
+		if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
+						dsc_caps,
+						aconnector->dc_link->ctx->dc->debug.dsc_min_slice_height_override,
+						0,
+						link_bandwidth_kbps,
+						&stream->timing,
+						&stream->timing.dsc_cfg)) {
+			stream->timing.flags.DSC = 1;
+			DRM_DEBUG_DRIVER("%s: [%s] DSC is selected from SST RX\n", __func__, drm_connector->name);
+		}
+	}
+
+	/* Overwrite the stream flag if DSC is enabled through debugfs */
+	if (aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE)
+		stream->timing.flags.DSC = 1;
+
+	if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_num_slices_h)
+		stream->timing.dsc_cfg.num_slices_h = aconnector->dsc_settings.dsc_num_slices_h;
+
+	if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_num_slices_v)
+		stream->timing.dsc_cfg.num_slices_v = aconnector->dsc_settings.dsc_num_slices_v;
+
+	if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_bits_per_pixel)
+		stream->timing.dsc_cfg.bits_per_pixel = aconnector->dsc_settings.dsc_bits_per_pixel;
+#endif
+}
+
 static struct drm_display_mode *
 get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 			  bool use_probed_modes)
@@ -5678,7 +5737,6 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	int preferred_refresh = 0;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct dsc_dec_dpcd_caps dsc_caps;
-	uint32_t link_bandwidth_kbps;
 #endif
 	struct dc_sink *sink = NULL;
 
@@ -5769,47 +5827,10 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			stream, &mode, &aconnector->base, con_state, old_stream,
 			requested_bpc);
 
-	stream->timing.flags.DSC = 0;
-
-	if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT) {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-		dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
-				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
-				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
-				      &dsc_caps);
-		link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
-							     dc_link_get_link_cap(aconnector->dc_link));
-
-		if (aconnector->dsc_settings.dsc_force_enable != DSC_CLK_FORCE_DISABLE && dsc_caps.is_dsc_supported) {
-			/* Set DSC policy according to dsc_clock_en */
-			dc_dsc_policy_set_enable_dsc_when_not_needed(
-				aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE);
-
-			if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
-						  &dsc_caps,
-						  aconnector->dc_link->ctx->dc->debug.dsc_min_slice_height_override,
-						  0,
-						  link_bandwidth_kbps,
-						  &stream->timing,
-						  &stream->timing.dsc_cfg)) {
-				stream->timing.flags.DSC = 1;
-				DRM_DEBUG_DRIVER("%s: [%s] DSC is selected from SST RX\n", __func__, drm_connector->name);
-			}
-			/* Overwrite the stream flag if DSC is enabled through debugfs */
-			if (aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE)
-				stream->timing.flags.DSC = 1;
-
-			if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_num_slices_h)
-				stream->timing.dsc_cfg.num_slices_h = aconnector->dsc_settings.dsc_num_slices_h;
-
-			if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_num_slices_v)
-				stream->timing.dsc_cfg.num_slices_v = aconnector->dsc_settings.dsc_num_slices_v;
-
-			if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_bits_per_pixel)
-				stream->timing.dsc_cfg.bits_per_pixel = aconnector->dsc_settings.dsc_bits_per_pixel;
-		}
-#endif
-	}
+	/* SST DSC determination policy */
+	update_dsc_caps(aconnector, sink, stream, &dsc_caps);
+	if (aconnector->dsc_settings.dsc_force_enable != DSC_CLK_FORCE_DISABLE && dsc_caps.is_dsc_supported)
+		apply_dsc_policy_for_stream(aconnector, sink, stream, &dsc_caps);
 
 	update_stream_scaling_settings(&mode, dm_state, stream);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
