Return-Path: <SRS0=AWwP=FV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F19C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 16:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC16233A2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 16:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC16233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05B8989C09;
	Thu, 17 Dec 2020 16:55:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD6F89C09
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 16:55:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHI1V3s6s16U+BTRFWH4wwLziy8F5FsKfYVKNcPrOYAL5pKwvEPnr3w/2MG8njgS5NGh/JnCNCTK56kAUfZi35wA04QtbwGGluPBe58261BW0LxqC8XFTbVHoh/X2+oeVCbgeBdmHjYIK4k8QJpXvqG+BycFz8aE5hzb36blkBuWusSOTX9KLw6+xmSIBZFeKCvxL194gloSA4VaS21xomDWBSGm3o2/ZF5QorJgMejg2/ePbOo7dehdvcH61BlW3pRx60BgiizMtWJud5kJ0mQSb3ZiNl5Z/H/M+vdHCcunAo+3a4/U19iS/vqTSLOk4ns9ro8Zo8Ml1T6MQEaYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBQWuWmimdkcUjpEIjzevywJ5NV1K0uidhTpx3cZQCo=;
 b=Sq9/Dbzup5mRVWIkbp7S0ithlUSyYw8uAgHIUB5KlygXrcv7dCpvEx9s2HkwhZdOkHJbcbTA7p6H7paxIsf+zRih2nP5n5VmFBalHVOAr5rcfDiApKr+1PgixIfE+HiQxfeK3zrPFMz0m4N+umTjTKqFUbVeFhEtK461Vxlz2aIkJJFkRxcIY0+GpgqK5tjHcwRxjyeZHz35BqTpkuQXGvSlglnQa6NuhFqM5FIVur1MRbjt/RfQsUoYBr6VWncYuboljoos86Dj9gjpWFLz6acXBAd93mTzZr62IzRZvbliGBueqKgjRwX46fOISmvGanpGxyByRgDvm0YokxrrEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBQWuWmimdkcUjpEIjzevywJ5NV1K0uidhTpx3cZQCo=;
 b=xQAtm2xRNxWuGF9Wo1jjcu+bxyv39WTej/UKFDcE0wutPqgsxN0aCPpwR1Wnd1eZ2Iq9ML+dmw0TT2ruUjiExStVuivaxY2G5c1Dver9B44dqxI9ZfRZq2pRrTs5NDCVoEsiM7KI0Z42DglOu/IWyjPkc5olBUVBnspKnvIhjmA=
Received: from MWHPR19CA0020.namprd19.prod.outlook.com (2603:10b6:300:d4::30)
 by CY4PR12MB1223.namprd12.prod.outlook.com (2603:10b6:903:38::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.19; Thu, 17 Dec
 2020 16:55:41 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::73) by MWHPR19CA0020.outlook.office365.com
 (2603:10b6:300:d4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 17 Dec 2020 16:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Thu, 17 Dec 2020 16:55:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 17 Dec
 2020 10:55:39 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 17 Dec
 2020 10:55:39 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 17 Dec 2020 10:55:39 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Update idle optimization handling
Date: Thu, 17 Dec 2020 11:54:58 -0500
Message-ID: <20201217165459.3570331-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5896a91-e571-4ef8-aeaa-08d8a2ac961c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1223:
X-Microsoft-Antispam-PRVS: <CY4PR12MB12238F8261C6ABC57FCFD4FFF9C40@CY4PR12MB1223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:205;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1XXc6y+sJGC9jM3aSQIkjgJAX1qqmMhxHDvakYCmMMt9rDthd8MGOuF0uS1LKH7R9d8oCB9mwSH6AEpUoP0A07oqwTV6mfvySzvSHMx1g8zWgVmeuEz8mqAT0Ze4f4yLGK43aGHfZ/1AgAgTOA7heHmTJU4qDamZuUu469greO7v3DJ12hG0mM07LSR7GJ8h9ERFJ5x2C1LjZPdirjaBfqLSQWrfxpekirlxX3qsJyCbXhJzLL9t6LRPkTvU4UzytEVMXsb0y5Fo99vv885s+t0HPWyeUDC3m+GFy0rE1yZwbpCWS2ENsqlKEKjJ294wIUwMVCcp++7W4/rifx6EPLlWotQnakn1NnbSmcjymLxeScD0UwlN+9l/nUHG8Mspd3URLj9ZtRK1f3FvBamxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966005)(356005)(82740400003)(86362001)(110136005)(83380400001)(478600001)(336012)(186003)(426003)(2906002)(1076003)(2616005)(5660300002)(4326008)(316002)(70586007)(47076004)(26005)(82310400003)(8676002)(6666004)(70206006)(8936002)(7696005)(6636002)(15650500001)(36756003)(54906003)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 16:55:40.7862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5896a91-e571-4ef8-aeaa-08d8a2ac961c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1223
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[How]
 - use dc interface instead of hwss interface in cursor functions, to keep
dc->idle_optimizations_allowed updated
 - add dc interface to check if idle optimizations might apply to a plane

Change-Id: I130107b6428b4afd73a1a177ef0f8125e0d877e6
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c          |  8 ++++++--
 drivers/gpu/drm/amd/display/dc/dc.h               |  5 +++++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h      |  3 +++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 15 +++++++++++++++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h    |  4 ++++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  3 +++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c |  6 ++++++
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h |  4 ++++
 8 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 58eb0d69873a..00f6d0e90ba4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3143,9 +3143,13 @@ void dc_lock_memory_clock_frequency(struct dc *dc)
 			core_link_enable_stream(dc->current_state, &dc->current_state->res_ctx.pipe_ctx[i]);
 }
 
-bool dc_is_plane_eligible_for_idle_optimizaitons(struct dc *dc,
-						 struct dc_plane_state *plane)
+bool dc_is_plane_eligible_for_idle_optimizaitons(struct dc *dc, struct dc_plane_state *plane)
 {
+#if defined(CONFIG_DRM_AMD_DC_MALL)
+	if (dc->hwss.does_plane_fit_in_mall && dc->hwss.does_plane_fit_in_mall(dc, plane))
+		return true;
+
+#endif
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 54a829f95346..33642566bcb2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -171,6 +171,11 @@ struct dc_caps {
 	bool dmcub_support;
 	uint32_t num_of_internal_disp;
 	enum dp_protocol_version max_dp_protocol_version;
+#if defined(CONFIG_DRM_AMD_DC_MALL)
+	unsigned int mall_size_per_mem_channel;
+	unsigned int mall_size_total;
+	unsigned int cursor_cache_size;
+#endif
 	struct dc_plane_cap planes[MAX_PLANES];
 	struct dc_color_caps color;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 701aa7178a89..0f71819be59f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -71,6 +71,9 @@ struct dc_plane_address {
 	union {
 		struct{
 			PHYSICAL_ADDRESS_LOC addr;
+#if defined(CONFIG_DRM_AMD_DC_MALL)
+			PHYSICAL_ADDRESS_LOC cursor_cache_addr;
+#endif
 			PHYSICAL_ADDRESS_LOC meta_addr;
 			union large_integer dcc_const_color;
 		} grph;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 518adbd12b74..7265432a95e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -814,6 +814,21 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 
 	return true;
 }
+#if defined(CONFIG_DRM_AMD_DC_MALL)
+
+bool dcn30_does_plane_fit_in_mall(struct dc *dc, struct dc_plane_state *plane)
+{
+	// add meta size?
+	unsigned int surface_size = plane->plane_size.surface_pitch * plane->plane_size.surface_size.height *
+			(plane->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ? 8 : 4);
+	unsigned int mall_size = dc->caps.mall_size_total;
+
+	if (dc->debug.mall_size_override)
+		mall_size = 1024 * 1024 * dc->debug.mall_size_override;
+
+	return (surface_size + dc->caps.cursor_cache_size) < mall_size;
+}
+#endif
 
 void dcn30_hardware_release(struct dc *dc)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
index 7d32c43aafe0..a83c77bec657 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
@@ -65,6 +65,10 @@ void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable);
 void dcn30_update_info_frame(struct pipe_ctx *pipe_ctx);
 void dcn30_program_dmdata_engine(struct pipe_ctx *pipe_ctx);
 
+#if defined(CONFIG_DRM_AMD_DC_MALL)
+bool dcn30_does_plane_fit_in_mall(struct dc *dc, struct dc_plane_state *plane);
+
+#endif
 bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable);
 
 void dcn30_hardware_release(struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 6125fe440ad0..1578dfa0ea29 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -91,6 +91,9 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
 	.apply_idle_power_optimizations = dcn30_apply_idle_power_optimizations,
+#if defined(CONFIG_DRM_AMD_DC_MALL)
+	.does_plane_fit_in_mall = dcn30_does_plane_fit_in_mall,
+#endif
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.hardware_release = dcn30_hardware_release,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 5e126fdf6ec1..11368948a56f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2631,6 +2631,12 @@ static bool dcn30_resource_construct(
 	dc->caps.max_cursor_size = 256;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
+#if defined(CONFIG_DRM_AMD_DC_MALL)
+	dc->caps.mall_size_per_mem_channel = 8;
+	/* total size = mall per channel * num channels * 1024 * 1024 */
+	dc->caps.mall_size_total = dc->caps.mall_size_per_mem_channel * dc->ctx->dc_bios->vram_info.num_chans * 1048576;
+	dc->caps.cursor_cache_size = dc->caps.max_cursor_size * dc->caps.max_cursor_size * 8;
+#endif
 
 	dc->caps.max_slave_planes = 1;
 	dc->caps.post_blend_color_processing = true;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 62804dc7b698..a1902b5411b3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -216,6 +216,10 @@ struct hw_sequencer_funcs {
 
 	/* Idle Optimization Related */
 	bool (*apply_idle_power_optimizations)(struct dc *dc, bool enable);
+#if defined(CONFIG_DRM_AMD_DC_MALL)
+
+	bool (*does_plane_fit_in_mall)(struct dc *dc, struct dc_plane_state *plane);
+#endif
 
 	bool (*is_abm_supported)(struct dc *dc,
 			struct dc_state *context, struct dc_stream_state *stream);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
