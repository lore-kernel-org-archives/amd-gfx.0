Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E12C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D56D4206F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uaulWtEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56D4206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D906E952;
	Thu, 30 Jul 2020 19:12:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E8B6E952
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNbdfs1BPswaWR9jO3eizax+gEdxXEWwcK/lH76ssNvGJAKJs8jTZW/wydjWCoULvu6OzcBZxZ1UczXf3U0hZQZKz8HcMJ0n6ksallBxdP1LY9keGvJs7kzOG5Q1RL6Q8FwA+mBX1U0F92sNFZ9sOZisyPSUCQfKrgwlXpyH4cloq8YI/3mkbTGj1f9zKfQGI1wfwPPstIrHMoQ1hT1tmtS7y5GgloVleY9KlUvhNpo7icixQlY4iYGTefTSxNnW8062m6qiZ9XjbPeMoO4JpQUVsMGwXDnXUeULrIwLL0KIxo/Y+YObu+g8ep3Oup83TtUknWEN4PoMrHsGSpSKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WhR/EppiEyn7nfsA3QCcrcwbt7zc/AfzR8pMVuDnXg=;
 b=eWk0TVPfBtUNmQufzp45uBcgyu9xDYq5M3Ss9paRUddiXTVnB/MsgMGEPt8WarmxkLRanR171ghe5Fl8yrP/E54r4kyx1TZ/OBS7VtH7/rGYiYWS+4rFM/eKQYDg5fz6yKz3u69ahMpmo22g+rn0c4N9q/r2LHFVYbU5m6OjNdHIgbZ+6y1U12rk0eoq8E3hs41GMF85sLqkmlByGrQ96IUJvIh1WcTpmVuGiEipvOu4Xen7RjADxGOoinY8bm5ZkRU0xlZZAYgqphtq0VHgws1NTDtqL2wcG5HjB40SvXnpnjFonNur+JRgvw1j8l73gkczhopjtOySDcJ4tHvqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WhR/EppiEyn7nfsA3QCcrcwbt7zc/AfzR8pMVuDnXg=;
 b=uaulWtEQcAcQwS/LAUwhELyXW8flqcTmg7YUQlhXkJH9ZMv7X/QsM8hMDew8J/P7HDTX284C2D7F/C35qNAtZ1qxHvEuAmI8d1UQvCQQNGYRNkKKVl+EvOS+IRUREVdTizFdY8B4h1SKCvbIEAhx+DeaLTng3DzHUKO4qo2GsX8=
Received: from BN6PR16CA0026.namprd16.prod.outlook.com (2603:10b6:405:14::12)
 by DM6PR12MB3132.namprd12.prod.outlook.com (2603:10b6:5:3c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.33; Thu, 30 Jul
 2020 19:11:59 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::c7) by BN6PR16CA0026.outlook.office365.com
 (2603:10b6:405:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend
 Transport; Thu, 30 Jul 2020 19:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 19:11:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:11:58 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:11:58 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 14:11:47 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/16] drm/amd/display: DSC Slice height debugfs write entry
Date: Thu, 30 Jul 2020 15:11:31 -0400
Message-ID: <20200730191146.33112-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730191146.33112-1-aurabindo.pillai@amd.com>
References: <20200730191146.33112-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7f83a5a-737a-4a0b-f865-08d834bc6f01
X-MS-TrafficTypeDiagnostic: DM6PR12MB3132:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3132243E62A6D5D4A043BDCE8B710@DM6PR12MB3132.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ldLl1ojCDVtE9EdKDkMdgONX1s9rXZRuS0i+jtx/WwypnRGivQkAkpEphwycvm9sG4b+zD/VBU3dyFF/GnC3J3LC5vq/WZy6l2yeIXxNhvt2cJ/ZE5w2OQa0tw6UJ5KSZjzLEqOdXlNSEtz1Ykrtqxjb8R0g/Rl6we860qzmknEPii745uWhPPGYIjNUPsesag7crU/rntLtuqfQepEUYvE2MOKm4V44NkxCx1CNwTSmXi65SyvxGZQ/VAcAEuRzJRvtge6mz/IL+4cJKZCgBHX30ZYruIGgGdvTHdrCL4o7p9QDfsVbbR+rrEs8QPLjHAh+ZBpNuG5bk488JJtIgHsuvi+961XIzjkzzmzfO52EAG2WuKPMb4Hqp8/qbeoE4H/FJxRTutBDmqKpyfxmKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966005)(6916009)(83380400001)(8676002)(8936002)(2906002)(82310400002)(356005)(70586007)(86362001)(316002)(36756003)(54906003)(70206006)(82740400003)(81166007)(186003)(426003)(26005)(7696005)(4326008)(5660300002)(336012)(1076003)(6666004)(44832011)(2616005)(478600001)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 19:11:59.3381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f83a5a-737a-4a0b-f865-08d834bc6f01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3132
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
 Mikita Lipski <Mikita.Lipski@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eryk Brol <eryk.brol@amd.com>

[Why]
We need to be able to specify slice height for any connector's DSC

[How]
Overwrite computed parameters in dsc_cfg, with the value needed/
Overwrites for both SST and MST connectors, but in different places, but the process is identical. Overwrites only if DSC is decided to be enabled on that connector.

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 93 +++++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  7 ++
 4 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 346a6afd16ab..29570ce77967 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4743,9 +4743,14 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			/* Overwrite the stream flag if DSC is enabled through debugfs */
 			if (aconnector->dsc_settings.dsc_clock_en)
 				stream->timing.flags.DSC = 1;
+
 			if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_slice_width)
 				stream->timing.dsc_cfg.num_slices_h = DIV_ROUND_UP(stream->timing.h_addressable,
-										   aconnector->dsc_settings.dsc_slice_width);
+									aconnector->dsc_settings.dsc_slice_width);
+
+			if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_slice_height)
+				stream->timing.dsc_cfg.num_slices_v = DIV_ROUND_UP(stream->timing.v_addressable,
+									aconnector->dsc_settings.dsc_slice_height);
 		}
 #endif
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 5b6f879a108c..333813ede0c7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -345,6 +345,7 @@ struct amdgpu_display_manager {
 struct dsc_preferred_settings {
 	bool dsc_clock_en;
 	uint32_t dsc_slice_width;
+	uint32_t dsc_slice_height;
 };
 
 struct amdgpu_dm_connector {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index df8b84aecc4d..971b75a52e89 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1292,6 +1292,22 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 	return size;
 }
 
+/* function: read DSC slice height parameter on the connector
+ *
+ * The read function: dp_dsc_slice_height_read
+ * returns dsc slice height used in the current configuration
+ * The return is an integer: 0 or other positive number
+ *
+ * Access the status with the following command:
+ *
+ *	cat /sys/kernel/debug/dri/0/DP-X/dsc_slice_height
+ *
+ * 0 - means that DSC is disabled
+ *
+ * Any other number more than zero represents the
+ * slice height currently used by DSC in pixels
+ *
+ */
 static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
@@ -1349,6 +1365,82 @@ static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
 	return result;
 }
 
+/* function: write DSC slice height parameter
+ *
+ * The write function: dp_dsc_slice_height_write
+ * overwrites automatically generated DSC configuration
+ * of slice height.
+ *
+ * The user has to write the slice height divisible by the
+ * picture height.
+ *
+ * Also the user has to write height in hexidecimal
+ * rather than in decimal.
+ *
+ * Writing DSC settings is done with the following command:
+ * - To force overwrite slice height (example sets to 128 pixels):
+ *
+ *	echo 0x80 > /sys/kernel/debug/dri/0/DP-X/dsc_slice_height
+ *
+ *  - To stop overwriting and let driver find the optimal size,
+ * set the height to zero:
+ *
+ *	echo 0x0 > /sys/kernel/debug/dri/0/DP-X/dsc_slice_height
+ *
+ */
+static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
+				     size_t size, loff_t *pos)
+{
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct pipe_ctx *pipe_ctx;
+	int i;
+	char *wr_buf = NULL;
+	uint32_t wr_buf_size = 42;
+	int max_param_num = 1;
+	uint8_t param_nums = 0;
+	long param[1] = {0};
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
+	aconnector->dsc_settings.dsc_slice_height = param[0];
+
+done:
+	kfree(wr_buf);
+	return size;
+}
+
 static ssize_t dp_dsc_bits_per_pixel_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
@@ -1659,6 +1751,7 @@ static const struct file_operations dp_dsc_slice_width_debugfs_fops = {
 static const struct file_operations dp_dsc_slice_height_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.read = dp_dsc_slice_height_read,
+	.write = dp_dsc_slice_height_write,
 	.llseek = default_llseek
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 2c10352fa514..d433949fe53a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -473,6 +473,7 @@ struct dsc_mst_fairness_params {
 	struct drm_dp_mst_port *port;
 	bool clock_overwrite;
 	uint32_t slice_width_overwrite;
+	uint32_t slice_height_overwrite;
 };
 
 struct dsc_mst_fairness_vars {
@@ -511,6 +512,11 @@ static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *p
 				params[i].timing->dsc_cfg.num_slices_h = DIV_ROUND_UP(
 										params[i].timing->h_addressable,
 										params[i].slice_width_overwrite);
+
+			if (params[i].slice_height_overwrite)
+				params[i].timing->dsc_cfg.num_slices_v = DIV_ROUND_UP(
+										params[i].timing->v_addressable,
+										params[i].slice_height_overwrite);
 		} else {
 			params[i].timing->flags.DSC = 0;
 		}
@@ -728,6 +734,7 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		if (params[count].clock_overwrite)
 			debugfs_overwrite = true;
 		params[count].slice_width_overwrite = aconnector->dsc_settings.dsc_slice_width;
+		params[count].slice_height_overwrite = aconnector->dsc_settings.dsc_slice_height;
 		params[count].compression_possible = stream->sink->dsc_caps.dsc_dec_caps.is_dsc_supported;
 		dc_dsc_get_policy_for_timing(params[count].timing, &dsc_policy);
 		if (!dc_dsc_compute_bandwidth_range(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
