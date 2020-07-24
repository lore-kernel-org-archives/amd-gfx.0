Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300DDC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC35C206F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mjOMZnD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC35C206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFFF96EA0F;
	Fri, 24 Jul 2020 21:07:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DB46EA0F
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 21:07:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQgCTKVJpS27elTzfUmsDhj5LxVlIX9jWwHdmaU4VlJEEPLRAZ8d56OqB6mRv2diEk5F9/iuqVS3RQGLM5S9JRzPMBMG0LWZzaCyxjr388fvBbu0ovixVM+jeJnrBq0EAX7crtqM/fa3Uk1DwHd441ov4MbP1BiYrhMBDCyR3Oj9EPrSgnZFRFW8gdNmZKF4HUQCv/qrPn8zRjtSOObI7GQL+uClTmghCEyscL5W+XlPZEEQGMckZMlZy4wVvPNSumKjOpGnQ2+uR9rBoLdvDiFccWHxqERqzVYvZ5fY6MFd0hVXfKeUEoawTSEverevG9oH8HVChZ94xpvkgvSzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/denN/8/OXXrSc6HCrMi3tzLXt+gm0lbqczncFGXiw=;
 b=F9ZZ9d8Xm3Uj9jssGvEXPPRM0x1zgtcwmCXVix4bDzZMnU8AO+i4GghSJnCfU5k59qPNu80k1gulgfV9LBMaK5Gs/LOFtWcbJ1/vC/CkeutvX1rd16DuDhUoTH66gScLm6JZqtvwPVDlVMkyxiygVr/HJYnoTPvD4dM+b4GFBFDVCdSSZ7aqwM4soitnfXIBKn711fmaXo9UbwfA7xN8Nh5FrP4lLgPNowKqWxnQNt8xr+7EL7ZT8SMHbDYrRaMWyXCfUTl3QenQOFMmO64m0Z/KLjELcBg3itita+P/K0Vuf632GTxCCGu0UM6ueYt1HDzxwLkdRkHQmvNXLd2Y1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/denN/8/OXXrSc6HCrMi3tzLXt+gm0lbqczncFGXiw=;
 b=mjOMZnD2kuCFAlv15wrT3gGfxvohdqjfvAQc/VB44He4psU++YY7rrajjHhm2aYJDt7qEUwwR3bHsnpgFzR1xCAWehZHbT4FYs/IFOtj8wlHK07dAyASKuPPRa1LnxIYZtG/Ftt+VTq2/5a2itfMYUp+yC9ia1wQniqK9F/BEdk=
Received: from BN6PR10CA0031.namprd10.prod.outlook.com (2603:10b6:404:109::17)
 by DM6PR12MB3004.namprd12.prod.outlook.com (2603:10b6:5:11b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.25; Fri, 24 Jul
 2020 21:07:49 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:109:cafe::a4) by BN6PR10CA0031.outlook.office365.com
 (2603:10b6:404:109::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Fri, 24 Jul 2020 21:07:49 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Fri, 24 Jul 2020 21:07:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:07:49 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:07:48 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 24 Jul 2020 16:07:38 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/15] drm/amd/display: DSC Clock enable debugfs write entry
Date: Fri, 24 Jul 2020 17:06:12 -0400
Message-ID: <20200724210618.2709738-10-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724210618.2709738-1-eryk.brol@amd.com>
References: <20200724210618.2709738-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10ac5669-a676-47c8-2b4b-08d830159f4e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3004:
X-Microsoft-Antispam-PRVS: <DM6PR12MB30046F1BA8733D2D8A332157E5770@DM6PR12MB3004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYl7qQXXkN5A7OHrfO/W6s0p9m6i7pYiuvwk36m/uDgEVSfOX1+5xx538rBHSBFggLrK8ejZvZ8DnNs0zOw2+SxV5aACQFSMYWb2YiNdSHPIwUQFbhesNDse9oZ9/dM+CZRhW0JT1zFas/pm17lY91rZ+Whm+RkGNbGZJs7N8E3jx7PfAmLyDr5Wy1KzJdtAHLYKfLnpogkKSQ1uMdE4WuNrmzLDby0iBR0utNuNoKbjiQdaekBKYiLj6N9/Gt6H0UesNnnVpQU0niQ+VMgjyii9Xo3nDxEp55vBpIEHB8NHxFtXs7GDWg/q0xhAeqVPW15ooRyN0PaULokyvyMka7z6g+oJy40KhiA3sTMf0tYrjbAHhweN8PJRPQU+mfQ1fkltF5R8feYvj75D8hqPkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966005)(70206006)(5660300002)(47076004)(2906002)(36756003)(4326008)(8676002)(356005)(6666004)(70586007)(6916009)(2616005)(44832011)(54906003)(186003)(86362001)(426003)(316002)(82740400003)(26005)(83380400001)(8936002)(1076003)(336012)(81166007)(478600001)(82310400002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 21:07:49.7642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ac5669-a676-47c8-2b4b-08d830159f4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3004
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Mikita Lipski <Mikita.Lipski@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Need a mechanism to force enable DSC on any connector

[How]
Debugfs entry overwrites newly added connector's dsc preffered
settings structure and sets dsc_clock_en flag on it.
During the attomic commit, depending if connector is SST or
MST, we will enable DSC manually by overwriting stream's DSC flag.

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  5 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 89 +++++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 11 ++-
 4 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b1bc03594e5c..5105e13a6088 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4613,7 +4613,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 							     dc_link_get_link_cap(aconnector->dc_link));
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-		if (dsc_caps.is_dsc_supported)
+		if (dsc_caps.is_dsc_supported) {
 			if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
 						  &dsc_caps,
 						  aconnector->dc_link->ctx->dc->debug.dsc_min_slice_height_override,
@@ -4621,6 +4621,9 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 						  &stream->timing,
 						  &stream->timing.dsc_cfg))
 				stream->timing.flags.DSC = 1;
+			if (aconnector->dsc_settings.dsc_clock_en)
+				stream->timing.flags.DSC = 1;
+		}
 #endif
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 82cdf07b4bd0..6f0a81f6f3c4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -342,6 +342,10 @@ struct amdgpu_display_manager {
 	struct amdgpu_encoder mst_encoders[AMDGPU_DM_MAX_CRTC];
 };
 
+struct dsc_preferred_settings {
+	bool dsc_clock_en;
+};
+
 struct amdgpu_dm_connector {
 
 	struct drm_connector base;
@@ -389,6 +393,7 @@ struct amdgpu_dm_connector {
 	uint32_t debugfs_dpcd_size;
 #endif
 	bool force_yuv420_output;
+	struct dsc_preferred_settings dsc_settings;
 };
 
 #define to_amdgpu_dm_connector(x) container_of(x, struct amdgpu_dm_connector, base)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 65e9ee64c70c..d88620fa9d2b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -998,6 +998,21 @@ static ssize_t dp_dpcd_data_read(struct file *f, char __user *buf,
 	return read_size - r;
 }
 
+/* function: read DSC status on the connector
+ *
+ * The read function: dp_dsc_clock_en_read
+ * returns current status of DSC clock on the connector.
+ * The return is a boolean flag: 1 or 0.
+ *
+ * Access it with the following command (you need to specify
+ * connector like DP-1):
+ *
+ *	cat /sys/kernel/debug/dri/0/DP-X/dsc_clock_en
+ *
+ * Expected output:
+ * 1 - means that DSC is currently enabled
+ * 0 - means that DSC is disabled
+ */
 static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
@@ -1055,6 +1070,79 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 	return result;
 }
 
+/* function: write force DSC on the connector
+ *
+ * The write function: dp_dsc_clock_en_write
+ * enables to force DSC on the connector.
+ * User can write to either force enable DSC
+ * on the next modeset or set it to driver default
+ *
+ * Writing DSC settings is done with the following command:
+ * - To force enable DSC (you need to specify
+ * connector like DP-1):
+ *
+ *	echo 0x1 > /sys/kernel/debug/dri/0/DP-X/dsc_clock_en
+ *
+ * - To return to default state set the flag to zero and
+ * let driver deal with DSC automatically
+ * (you need to specify connector like DP-1):
+ *
+ *	echo 0x0 > /sys/kernel/debug/dri/0/DP-X/dsc_clock_en
+ *
+ */
+static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
+				     size_t size, loff_t *pos)
+{
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct pipe_ctx *pipe_ctx;
+	int i;
+	char *wr_buf = NULL;
+	uint32_t wr_buf_size = 42;
+	int max_param_num = 1;
+	long param[1] = {0};
+	uint8_t param_nums = 0;
+
+	if (size == 0)
+		return -EINVAL;
+
+	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
+
+	if (!wr_buf) {
+		DRM_DEBUG_DRIVER("no memory to allocate write buffer\n");
+		return -ENOSPC;
+	}
+
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+					    (long *)param, buf,
+					    max_param_num,
+					    &param_nums)) {
+		kfree(wr_buf);
+		return -EINVAL;
+	}
+
+	if (param_nums <= 0) {
+		DRM_DEBUG_DRIVER("user data not be read\n");
+		kfree(wr_buf);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+			if (pipe_ctx && pipe_ctx->stream &&
+			    pipe_ctx->stream->link == aconnector->dc_link)
+				break;
+	}
+
+	if (!pipe_ctx || !pipe_ctx->stream)
+		goto done;
+
+	aconnector->dsc_settings.dsc_clock_en = param[0];
+
+done:
+	kfree(wr_buf);
+	return size;
+}
+
 static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
@@ -1465,6 +1553,7 @@ DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
 static const struct file_operations dp_dsc_clock_en_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.read = dp_dsc_clock_en_read,
+	.write = dp_dsc_clock_en_write,
 	.llseek = default_llseek
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 729ca38750d9..8250c37abe40 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -471,6 +471,7 @@ struct dsc_mst_fairness_params {
 	struct dc_dsc_bw_range bw_range;
 	bool compression_possible;
 	struct drm_dp_mst_port *port;
+	bool clock_overwrite;
 };
 
 struct dsc_mst_fairness_vars {
@@ -636,7 +637,9 @@ static void try_disable_dsc(struct drm_atomic_state *state,
 	int remaining_to_try = 0;
 
 	for (i = 0; i < count; i++) {
-		if (vars[i].dsc_enabled && vars[i].bpp_x16 == params[i].bw_range.max_target_bpp_x16) {
+		if (vars[i].dsc_enabled
+				&& vars[i].bpp_x16 == params[i].bw_range.max_target_bpp_x16
+				&& !params[i].clock_overwrite) {
 			kbps_increase[i] = params[i].bw_range.stream_kbps - params[i].bw_range.max_kbps;
 			tried[i] = false;
 			remaining_to_try += 1;
@@ -697,6 +700,7 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	struct dsc_mst_fairness_vars vars[MAX_PIPES];
 	struct amdgpu_dm_connector *aconnector;
 	int count = 0;
+	bool debugfs_overwrite = false;
 
 	memset(params, 0, sizeof(params));
 
@@ -715,6 +719,9 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		params[count].sink = stream->sink;
 		aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
 		params[count].port = aconnector->port;
+		params[count].clock_overwrite = aconnector->dsc_settings.dsc_clock_en;
+		if (params[count].clock_overwrite)
+			debugfs_overwrite = true;
 		params[count].compression_possible = stream->sink->dsc_caps.dsc_dec_caps.is_dsc_supported;
 		dc_dsc_get_policy_for_timing(params[count].timing, &dsc_policy);
 		if (!dc_dsc_compute_bandwidth_range(
@@ -740,7 +747,7 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 						 dm_mst_get_pbn_divider(dc_link)) < 0)
 			return false;
 	}
-	if (!drm_dp_mst_atomic_check(state)) {
+	if (!drm_dp_mst_atomic_check(state) && !debugfs_overwrite) {
 		set_dsc_configs_from_fairness_vars(params, vars, count);
 		return true;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
