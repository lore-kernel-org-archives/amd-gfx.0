Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37682C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D143621D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="akHzBX8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D143621D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C68E6E955;
	Thu, 10 Sep 2020 13:47:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCFC86E955
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PprPDPoDMH0EVMhwa5lJCVDoF1FsM+u2JGQayY9e8p5jb1k0kG9w/pGZ11ufvu3YhC94s+AMiKO5SSQTkTiWcklavsU/RWxXo/Hp9I1pXL8WN0mFV7i5zuz4oKlld9L3gMTLDC5YHizUy/r7Hapm4yL460qFTbMDZdB4DAB9rCJ6RHgzr5jNcbC8bwpzL0osy+Xmm88eh5NNSaQnLBC0Q3LlrpphrH3h2GmFMPlhNbU6hc2X5un8ogj3rqmtvAsIi9uQkRhj/U5XVVTNL+PJkK81tuDmL10tu5wnjT34dWvxV5U5RqZYL6YFqwnTYfjGuDAvBlSIwWFXHgtCWDI2UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPRgkHCzsJur64plBl/cq2syY9HPqfkLBNi+gs3c9yI=;
 b=d0XU7/Db7ilzyHqD+dKrIZz+JgXHAAWBsn2FDUjma3hoLyRpEHkevniGLl/nhCBpRqKqf9kvN7uyypUP1r5MqtYzUEXLGEUhXAVpZAjbQDcUVsdRR0HjcKIjkbil+6+ZNxaquPaT+Yys3pR8wJ1luAmTXEbMrc6luxcBO8c/XPruIW/PKMGTjINpC22v/fLrQSp4n1IwP9dlzuOuHUG+yGWcACS5gbzoZxQQe2bZ54GU869vS9R2Y0atr6mTi2Y2uv4rkuDn7aOfEXSTfFr7/OUO4DvceSpnEAhDngRfe18kMxVicgAj3b+K7C0ZVR3ySW/wXymjuV8D3hbwwu55cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPRgkHCzsJur64plBl/cq2syY9HPqfkLBNi+gs3c9yI=;
 b=akHzBX8IshFcFSUI4zZ+xlSEYIm27KQou0cY3qh6B0B79MNxEEXv/q3sr+Ks5Ch+nF+tnBhegqED0U7153af0b4Z3EKfRVs8fbZ961S2Tn1ZMunY/XRjMxNoZ0y7DkBcMqoUDsd8YiK/lKIGfxd6YmxWEEz8JyNPuKZT13pAn0c=
Received: from DM5PR19CA0025.namprd19.prod.outlook.com (2603:10b6:3:9a::11) by
 CH2PR12MB3750.namprd12.prod.outlook.com (2603:10b6:610:14::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Thu, 10 Sep 2020 13:47:47 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::1) by DM5PR19CA0025.outlook.office365.com
 (2603:10b6:3:9a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:46 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:46 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:41 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/42] drm/amd/display: Add DSC force disable to dsc_clock_en
 debugfs entry
Date: Thu, 10 Sep 2020 09:47:07 -0400
Message-ID: <20200910134723.27410-27-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbe5d9c5-4025-4ba9-2271-08d855901a30
X-MS-TrafficTypeDiagnostic: CH2PR12MB3750:
X-Microsoft-Antispam-PRVS: <CH2PR12MB37509682BEED563456D984368B270@CH2PR12MB3750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+/RphY52xpj9+7JzKB5sPnw4LyqZEBqTj8qyXA9YPaQuG5DWP/fhnktgiRczyHYTtEMlw6YO90ezUbk0LKqLGhRMIPzQMwCIjo8qJeipEq4gsRU1w9ajHYKGt4T8zeeCPwW7ZO4COIG1q2e192mpq3H5fcUT42B/XCgjNvZuYxSYLAxWJ8KpEk/EOQZe9Nu6RoZ7hxxe47sZjIh2mq/Pits6ISztHIcpSen8r9jun8zC6zqAc8oUje1mMb6ZFOkTT0AkEyxtEDTjkImEp6UM27eKm0CptcQXmm5djRpPjEt1aTCMTnvtpXKVmCmPfowV/qrU2q/Bxclb1OGJnJRfFevBeClrKi0F8vleyA1txAo6yzzzyjdv/8eFYkHXgWtCDc7Y4Vy4mx60ICSGVxe7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966005)(2616005)(47076004)(478600001)(186003)(44832011)(316002)(6666004)(336012)(6916009)(26005)(426003)(8676002)(1076003)(7696005)(2906002)(86362001)(82740400003)(83380400001)(81166007)(356005)(5660300002)(8936002)(70206006)(70586007)(4326008)(36756003)(82310400003)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:47.5039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe5d9c5-4025-4ba9-2271-08d855901a30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3750
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Mikita Lipski <mikita.lipski@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eryk Brol <eryk.brol@amd.com>

[why]
For debug purposes we want not to enable DSC on certain connectors
even if algorithm deesires to do so, instead it should enable DSC
on other capable connectors or fail the atomic check.

[how]
Adding the third option to connector's debugfs entry dsc_clock_en.

Accepted inputs:
     0x0 - connector is using default DSC enablement policy
     0x1 - force enable DSC on the connector, if it supports DSC
     0x2 - force disable DSC on the connector, if DSC is supported

Ex. # echo 0x2 > /sys/kernel/debug/dri/0/DP-1/dsc_clock_en

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 ++++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 10 ++++++++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 15 ++++++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c   | 10 +++++-----
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9fb0dca839a5..e70e46764e61 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4719,9 +4719,10 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 							     dc_link_get_link_cap(aconnector->dc_link));
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-		if (dsc_caps.is_dsc_supported) {
+		if (aconnector->dsc_settings.dsc_force_enable != DSC_CLK_FORCE_DISABLE && dsc_caps.is_dsc_supported) {
 			/* Set DSC policy according to dsc_clock_en */
-			dc_dsc_policy_set_enable_dsc_when_not_needed(aconnector->dsc_settings.dsc_clock_en);
+			dc_dsc_policy_set_enable_dsc_when_not_needed(
+				aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE);
 
 			if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
 						  &dsc_caps,
@@ -4731,7 +4732,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 						  &stream->timing.dsc_cfg))
 				stream->timing.flags.DSC = 1;
 			/* Overwrite the stream flag if DSC is enabled through debugfs */
-			if (aconnector->dsc_settings.dsc_clock_en)
+			if (aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE)
 				stream->timing.flags.DSC = 1;
 
 			if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_slice_width)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 4da7cd065ba0..c805c61ef84f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -340,11 +340,17 @@ struct amdgpu_display_manager {
 	 * fake encoders used for DP MST.
 	 */
 	struct amdgpu_encoder mst_encoders[AMDGPU_DM_MAX_CRTC];
-        bool force_timing_sync;
+	bool force_timing_sync;
+};
+
+enum dsc_clock_force_state {
+	DSC_CLK_FORCE_DEFAULT = 0,
+	DSC_CLK_FORCE_ENABLE,
+	DSC_CLK_FORCE_DISABLE,
 };
 
 struct dsc_preferred_settings {
-	bool dsc_clock_en;
+	enum dsc_clock_force_state dsc_force_enable;
 	uint32_t dsc_slice_width;
 	uint32_t dsc_slice_height;
 	uint32_t dsc_bits_per_pixel;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 94fcb086154c..5cf3ba3ec5da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -111,7 +111,6 @@ static int parse_write_buffer_into_params(char *wr_buf, uint32_t wr_buf_size,
 
 	if (*param_nums > max_param_num)
 		*param_nums = max_param_num;
-;
 
 	wr_buf_ptr = wr_buf; /* reset buf pointer */
 	wr_buf_count = 0; /* number of char already checked */
@@ -1200,9 +1199,14 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
  *
  * The write function: dp_dsc_clock_en_write
  * enables to force DSC on the connector.
- * User can write to either force enable DSC
+ * User can write to either force enable or force disable DSC
  * on the next modeset or set it to driver default
  *
+ * Accepted inputs:
+ * 0 - default DSC enablement policy
+ * 1 - force enable DSC on the connector
+ * 2 - force disable DSC on the connector (might cause fail in atomic_check)
+ *
  * Writing DSC settings is done with the following command:
  * - To force enable DSC (you need to specify
  * connector like DP-1):
@@ -1262,7 +1266,12 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 	if (!pipe_ctx || !pipe_ctx->stream)
 		goto done;
 
-	aconnector->dsc_settings.dsc_clock_en = param[0];
+	if (param[0] == 1)
+		aconnector->dsc_settings.dsc_force_enable = DSC_CLK_FORCE_ENABLE;
+	else if (param[0] == 2)
+		aconnector->dsc_settings.dsc_force_enable = DSC_CLK_FORCE_DISABLE;
+	else
+		aconnector->dsc_settings.dsc_force_enable = DSC_CLK_FORCE_DEFAULT;
 
 done:
 	kfree(wr_buf);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index bd477a166015..be6b88e4c570 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -450,7 +450,7 @@ struct dsc_mst_fairness_params {
 	struct dc_dsc_bw_range bw_range;
 	bool compression_possible;
 	struct drm_dp_mst_port *port;
-	bool clock_overwrite;
+	enum dsc_clock_force_state clock_force_enable;
 	uint32_t slice_width_overwrite;
 	uint32_t slice_height_overwrite;
 	uint32_t bpp_overwrite;
@@ -635,7 +635,7 @@ static void try_disable_dsc(struct drm_atomic_state *state,
 	for (i = 0; i < count; i++) {
 		if (vars[i].dsc_enabled
 				&& vars[i].bpp_x16 == params[i].bw_range.max_target_bpp_x16
-				&& !params[i].clock_overwrite) {
+				&& !params[i].clock_force_enable == DSC_CLK_FORCE_DEFAULT) {
 			kbps_increase[i] = params[i].bw_range.stream_kbps - params[i].bw_range.max_kbps;
 			tried[i] = false;
 			remaining_to_try += 1;
@@ -715,8 +715,8 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		params[count].sink = stream->sink;
 		aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
 		params[count].port = aconnector->port;
-		params[count].clock_overwrite = aconnector->dsc_settings.dsc_clock_en;
-		if (params[count].clock_overwrite)
+		params[count].clock_force_enable = aconnector->dsc_settings.dsc_force_enable;
+		if (params[count].clock_force_enable == DSC_CLK_FORCE_ENABLE)
 			debugfs_overwrite = true;
 		params[count].slice_width_overwrite = aconnector->dsc_settings.dsc_slice_width;
 		params[count].slice_height_overwrite = aconnector->dsc_settings.dsc_slice_height;
@@ -753,7 +753,7 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 
 	/* Try max compression */
 	for (i = 0; i < count; i++) {
-		if (params[i].compression_possible) {
+		if (params[i].compression_possible && params[i].clock_force_enable != DSC_CLK_FORCE_DISABLE) {
 			vars[i].pbn = kbps_to_peak_pbn(params[i].bw_range.min_kbps);
 			vars[i].dsc_enabled = true;
 			vars[i].bpp_x16 = params[i].bw_range.min_target_bpp_x16;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
