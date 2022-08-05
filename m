Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2793C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC23B94732;
	Fri,  5 Aug 2022 18:00:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 329B6B936F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5pU0bRnBF5hE3dP4abRGCEyNgt0gut6U2yilntyB8JSYudJDTMpgk0+ssO//DotTAp6fvmhjT7S0rCggmkESJAE8gvy+blU8H4j25CWm4S7VCGPbNT9USxodQV0IZTq9+One3KOUOuQO5op+z/0k8EwcRgOdGoLLbhfyoXGhVTWv6uKhHcc6tyZ3KWQtYQNHsxR1Y5or3orceZ1lW/gvHti52j10yK4hUXKkqynJH3MB3L9XE41hKACTiRs9nrJENTuxESxztrWcWoKs2OEZnnxBtZYn3rlbLozuHzgP3pZwTaUpAuBRU0UkHyFTAfuw4OBoHe0wgXaOIurVx2jlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2IH6/An2AneOdbg5KelGhFDeoa6dloIE4o3c2aquWA=;
 b=Rocyw5GtK9Mx3LwCbBuiKwJ4mXhniGH0aU5rKR/DAhBgsZVKYYf+I/K5Mx+oXtUcgW1nidJQKzWapCwDyqOWagpBcm/P8JQlmeK4o5fNqXbt3ifMX2t6cA/82M3JVAdIUnbP5Z8VU/VeseHKhTD7l/i0GaDTZgfoM02bvmQkbFcPwZYJ45QCoOaGUzkoMsbRPNTzQdowAIi8MhT1zTjfkaJ2IUFoVyM38+uLY9DinUzsWd/PfXu8VoWkcoec/Kx7iGdkXT6bSn42VOHg+pMFyLNE+SP1ZNyA7CxevVGYSp6kzYxT8wSm8EWoxDJ7+EhEXaLN5RHsqWZlXwqh9ihLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2IH6/An2AneOdbg5KelGhFDeoa6dloIE4o3c2aquWA=;
 b=gTGpUdBaSaPaRNdL9k/yyCvH1GMEK/+7+wrUMTkTZqDo7qZxEM6z+DuXwCP9PRqA7O2eylpUQaWtjZ01t4+WlQWHOo7vjGeCJY6DiNrJPi0S9orUkec7130JWo/1/8WHqN7yZN4+YxJD0O2DqX77N3N8Zc652xBEGKlFn0iQTNI=
Received: from BN8PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:ac::16)
 by BYAPR12MB2887.namprd12.prod.outlook.com (2603:10b6:a03:12e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 18:00:33 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::8f) by BN8PR07CA0003.outlook.office365.com
 (2603:10b6:408:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14 via Frontend
 Transport; Fri, 5 Aug 2022 18:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:00:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:00:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:00:32 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:00:27 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/32] drm/amd/display: Expand documentation for timing
Date: Sat, 6 Aug 2022 01:58:13 +0800
Message-ID: <20220805175826.2992171-20-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a21e471-c89e-4241-6e27-08da770c643e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2887:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yik7RQMC5nFDfqSLw2IsZ8VU/DVddzfyalu3ivIywYPppGQdg+3UaoeeKWxGvjB324CTlbPZXtLSam6CURymxe00LDuCoGwmfWQGw+VUDZaxBP6KhKzZXFNx+vvAszxxpOkXBbtxxOlnn7GYglbIGYl6OJi9L1oczk4tyPTFasKXhk5HyqapEwOyivqyKOaarQdMoDJDqw5HGAelGcwQ8dwD6IIm7+3JjukHOxlDiJhy4AFZdEpgrQ1QctAY46WBoJF0TR2uaLsYcGA9dvaBDnA/qFf/dcDtYC4A6rBJWxSw+802ZU166dJW9ntWmlb1yQ2EYxU43SsJr2EIdmZ5Ccpo9cY6xdKwR4uwfVlnfUdm7lyklO1LY/jx7kN0n80PuPpwzsgt0bTis8IxKeXwPUajF+FRmoufbGlHJuoNXcxugtLYj+vCiXQTvrheUENPFCYzDP9cXqT5KX9RBVuxi+FGyk2D7AoimnE0g3kN/naa6PAN3fKFmuMsNuLL6efAIgkflbm6DSW1OIo1L0A0Jw0bP2ccRLMG3Wrhjg0Ff6OL21rg3Sn/hG/jhGyUw5PwrIzNZwbBmaDwCM0n8UhQvIVjW9T+jQiOHeJGcgKGiiI1x7fVKWfwH/7CehoY9PXAYNnO4lP18oAcDP8s7PKzXnxs4Agmewa6z2VHY4TpmCAUDiz2JwcgH8NUpp64zFZJUv3kyGumJMZ06/hHP9Sn8IR7ZmrPILfoHoDcUhVLCSFMibp2dQrd+VAV6Z7T+9EfjVngazSc60lAmEZ4t+C0FqGMTSzN2WzrjYHYqaogilLRwLYD0MuLIjHU9Cixfq1YiinLKjUuCraZkS+R3n0qGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(39860400002)(40470700004)(46966006)(36840700001)(8936002)(36860700001)(2906002)(83380400001)(81166007)(356005)(82740400003)(40460700003)(70586007)(70206006)(316002)(54906003)(6916009)(8676002)(478600001)(2616005)(336012)(1076003)(426003)(186003)(47076005)(6666004)(41300700001)(5660300002)(7696005)(26005)(40480700001)(86362001)(82310400005)(36756003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:00:33.0847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a21e471-c89e-4241-6e27-08da770c643e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2887
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

The timing programming inside DCN is far from trivial, it has multiple
parameters associated with that, and the lack of documentation does not
help comprehend this already complicated topic. This commit tries to
improve this situation by expanding the documentation of dc_crtc_timing
and the VTG program function.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  | 86 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 14 +++
 2 files changed, 100 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index d158aa4985f8..848db8676adf 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -812,22 +812,108 @@ struct dc_dsc_config {
 	bool is_dp; /* indicate if DSC is applied based on DP's capability */
 	uint32_t mst_pbn; /* pbn of display on dsc mst hub */
 };
+
+/**
+ * struct dc_crtc_timing - Timing parameters used to configure DCN blocks
+ *
+ * DCN provides multiple signals and parameters that can be used to adjust
+ * timing parameters, this struct aggregate multiple of these values for easy
+ * access. In this struct, fields prefixed with h_* are related to horizontal
+ * timing, and v_* to vertical timing. Keep in mind that when we talk about
+ * vertical timings, the values, in general, are described in the number of
+ * lines; on the other hand, the horizontal values are in pixels.
+ */
 struct dc_crtc_timing {
+	/**
+	 * @h_total: The total number of pixels from the rising edge of HSync
+	 * until the rising edge of the current HSync.
+	 */
 	uint32_t h_total;
+
+	/**
+	 * @h_border_left: The black pixels related to the left border
+	 */
 	uint32_t h_border_left;
+
+	/**
+	 * @h_addressable: It is the range of pixels displayed horizontally.
+	 * For example, if the display resolution is 3840@2160, the horizontal
+	 * addressable area is 3840.
+	 */
 	uint32_t h_addressable;
+
+	/**
+	 * @h_border_right: The black pixels related to the right border
+	 */
 	uint32_t h_border_right;
+
+	/**
+	 * @h_front_porch: Period (in pixels) between HBlank start and the
+	 * rising edge of HSync.
+	 */
 	uint32_t h_front_porch;
+
+	/**
+	 * @h_sync_width: HSync duration in pixels.
+	 */
 	uint32_t h_sync_width;
 
+	/**
+	 * @v_total: It is the total number of lines from the rising edge of
+	 * the previous VSync until the rising edge of the current VSync.
+	 *
+	 *          |--------------------------|
+	 *          +-+        V_TOTAL         +-+
+	 *          | |                        | |
+	 * VSync ---+ +--------- // -----------+ +---
+	 */
 	uint32_t v_total;
+
+	/**
+	 * @v_border_top: The black border on the top.
+	 */
 	uint32_t v_border_top;
+
+	/**
+	 * @v_addressable: It is the range of the scanout at which the
+	 * framebuffer is displayed. For example, if the display resolution is
+	 * 3840@2160, the addressable area is 2160 lines, or if the resolution
+	 * is 1920x1080, the addressable area is 1080 lines.
+	 */
 	uint32_t v_addressable;
+
+	/**
+	 * @v_border_bottom: The black border on the bottom.
+	 */
 	uint32_t v_border_bottom;
+
+	/**
+	 * @v_front_porch: Period (in lines) between VBlank start and rising
+	 * edge of VSync.
+	 *                  +-+
+	 * VSync            | |
+	 *        ----------+ +--------...
+	 *          +------------------...
+	 * VBlank   |
+	 *        --+
+	 *          |-------|
+	 *        v_front_porch
+	 */
 	uint32_t v_front_porch;
+
+	/**
+	 * @v_sync_width: VSync signal width in lines.
+	 */
 	uint32_t v_sync_width;
 
+	/**
+	 * @pix_clk_100hz: Pipe pixel precision
+	 *
+	 * This field is used to communicate pixel clocks with 100 Hz accuracy
+	 * from dc_crtc_timing to BIOS command table.
+	 */
 	uint32_t pix_clk_100hz;
+
 	uint32_t min_refresh_in_uhz;
 
 	uint32_t vic;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 1b14250d1b33..bcca4847590d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -312,6 +312,20 @@ void optc1_program_timing(
 	}
 }
 
+/**
+ * optc1_set_vtg_params - Set Vertical Timing Generator (VTG) parameters
+ *
+ * @optc: timing_generator struct used to extract the optc parameters
+ * @dc_crtc_timing: Timing parameters configured
+ * @program_fp2: Boolean value indicating if FP2 will be programmed or not
+ *
+ * OTG is responsible for generating the global sync signals, including
+ * vertical timing information for each HUBP in the dcfclk domain. Each VTG is
+ * associated with one OTG that provides HUBP with vertical timing information
+ * (i.e., there is 1:1 correspondence between OTG and VTG). This function is
+ * responsible for setting the OTG parameters to the VTG during the pipe
+ * programming.
+ */
 void optc1_set_vtg_params(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing, bool program_fp2)
 {
-- 
2.25.1

