Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6545AC433EC
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305E6206F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fIlxe6mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305E6206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66926E994;
	Fri, 24 Jul 2020 21:08:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 457E36E994
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 21:08:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2bTP57ppn3PAtndwq7kA+Q+4F3xfp4JBkIXOnIOU3gHuEErF/5g7fP+bO6HiMYKIe+xjLgQgyl0mQyrTWwJ38iOPPrxlqNpp3ADiVaYgRUKak00UUjXigd2dT8Gk70qCL765R3dlrz9C/4h5TnYbHPCB9B3o2UMRp92gnfZJ1Q2KB0L9xFGMBPVndbkAMxr88MldAlUz9hD4L3gVsSKrEErZHt88YsLZeHDmrKjBG4rmXUtql9GsE3zk9p/DoD8tcO/qyLc9iv7bv/V7vGy2c2fJ0m0RVSH4KAGqXBhIFXpAEXqlmv+ZFssQVPkYouOLcnxB0FS+BZPOHtz9CGFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/Rd+33mo1ASM1THcQDQEh/ZtZ2BRh6IbitRVKKm7HM=;
 b=cvjs7X7s75NR9Eo76XjUX/Xa4ZkyXYUHsFnYiXkkqcgXj8wwumJP2PqpiluaDoUCCveE4pzyfqU87ABYEe2FNGnaGgI27PxyPrXvg4f/BQEMf6zGLzppmBDImgkcangIjw+K9bUm8jioTcLeuMg4pv0GgQ6mmBFlLLixa6t+UB9t7rl4rdDze1Bq0vnYkpfOmOevZwl7sugRviJlFlcnoEwU1Nswn66eVvA5EePlLvVZqNTWDSzsQx7oD+dTFgw6WirxXG9BLvkLG/xZHDC7QwPA1VmxqJ9naemME8Wi3HBayz8rsB+wtBLXRYk5ir/KJnDU2huWN+3YJBJcst5fTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/Rd+33mo1ASM1THcQDQEh/ZtZ2BRh6IbitRVKKm7HM=;
 b=fIlxe6mjXV3DhwxL0L2ZrWOG4zYBEWwom12qibsfpZr0tS+Efd1qjDcfVBxmoQH0fdbQlb4bRyJROhB+Q0zJmmTuSeeHcq3uwTV+6ny7kBFdkpT4zr9bCT2UOkCdjDyx/d9x2/Vp3TqfoRer1qhxDp6d+L0Q6JCbqEjDj5ayGMY=
Received: from CO2PR04CA0186.namprd04.prod.outlook.com (2603:10b6:104:5::16)
 by MN2PR12MB4536.namprd12.prod.outlook.com (2603:10b6:208:263::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Fri, 24 Jul
 2020 21:08:18 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::7f) by CO2PR04CA0186.outlook.office365.com
 (2603:10b6:104:5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend
 Transport; Fri, 24 Jul 2020 21:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Fri, 24 Jul 2020 21:08:18 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:08:17 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 24 Jul 2020 16:08:06 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/15] drm/amd/display: DSC Slice width debugfs write entry
Date: Fri, 24 Jul 2020 17:06:16 -0400
Message-ID: <20200724210618.2709738-14-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724210618.2709738-1-eryk.brol@amd.com>
References: <20200724210618.2709738-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a31b87b-3f25-4d04-e22d-08d83015b040
X-MS-TrafficTypeDiagnostic: MN2PR12MB4536:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4536245605E119EB1A3E5174E5770@MN2PR12MB4536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQuXbs7/XMKHWHq+kmQez0V9jV2lHOHzzVX3TepZhG9U+/izmnZUerMHLDJggq4rtuC/6vWAJnNpoPb+kI1qdCC6XrXhgrTTMr2n2WFHZw1fd1Kud0cOsD7rRNOTzkp4WT7n7MrQ6FWscnNYHLdME7u9yG1zs+uqQV0MAen878quvdnMHpZDbpldSo8OeikbcPqvL2ctu7bHTPi99mEEHK5D28J1lJXL9GTBiZ18VgMQxALFCXumsN4B+XZnDFtA74hQ9c/xCmak5Un8jUWluhjbB6OVjzr9RO3BPySiEtIn5GKnO5walyrDPcEylmJr/42H3sVTs7pjFBqtPbV1F0QPsLGV67mYS6QcE7FmiE1NNVEbsl/cESGOBWnlyhFV/m+3qQkyWZ0jCDc9+fR4PA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966005)(54906003)(81166007)(8936002)(336012)(356005)(186003)(70586007)(70206006)(426003)(6916009)(2906002)(6666004)(26005)(1076003)(82740400003)(316002)(86362001)(8676002)(83380400001)(47076004)(44832011)(478600001)(4326008)(82310400002)(2616005)(5660300002)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 21:08:18.0724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a31b87b-3f25-4d04-e22d-08d83015b040
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4536
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
We need to be able to specify slice width for DSC on aconnector

[How]
Getting slice width parameter from debugfs entry, if it is
a valid the value is set in connector's dsc preffered settings
structure. Which then overwrites dsc_cfg structure's parameters
if DSC is decided to be enabled. Works for both SST and MST.

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 93 +++++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  6 ++
 4 files changed, 104 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5105e13a6088..0327e785e45c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4621,8 +4621,12 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 						  &stream->timing,
 						  &stream->timing.dsc_cfg))
 				stream->timing.flags.DSC = 1;
+			/* Overwrite the stream flag if DSC is enabled through debugfs */
 			if (aconnector->dsc_settings.dsc_clock_en)
 				stream->timing.flags.DSC = 1;
+			if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_slice_width)
+				stream->timing.dsc_cfg.num_slices_h = DIV_ROUND_UP(stream->timing.h_addressable,
+										   aconnector->dsc_settings.dsc_slice_width);
 		}
 #endif
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 6f0a81f6f3c4..5b6f879a108c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -344,6 +344,7 @@ struct amdgpu_display_manager {
 
 struct dsc_preferred_settings {
 	bool dsc_clock_en;
+	uint32_t dsc_slice_width;
 };
 
 struct amdgpu_dm_connector {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index d88620fa9d2b..df8b84aecc4d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1143,6 +1143,22 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 	return size;
 }
 
+/* function: read DSC slice width parameter on the connector
+ *
+ * The read function: dp_dsc_slice_width_read
+ * returns dsc slice width used in the current configuration
+ * The return is an integer: 0 or other positive number
+ *
+ * Access the status with the following command:
+ *
+ *	cat /sys/kernel/debug/dri/0/DP-X/dsc_slice_width
+ *
+ * 0 - means that DSC is disabled
+ *
+ * Any other number more than zero represents the
+ * slice width currently used by DSC in pixels
+ *
+ */
 static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
@@ -1200,6 +1216,82 @@ static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
 	return result;
 }
 
+/* function: write DSC slice width parameter
+ *
+ * The write function: dp_dsc_slice_width_write
+ * overwrites automatically generated DSC configuration
+ * of slice width.
+ *
+ * The user has to write the slice width divisible by the
+ * picture width.
+ *
+ * Also the user has to write width in hexidecimal
+ * rather than in decimal.
+ *
+ * Writing DSC settings is done with the following command:
+ * - To force overwrite slice width: (example sets to 1920 pixels)
+ *
+ *	echo 0x780 > /sys/kernel/debug/dri/0/DP-X/dsc_slice_width
+ *
+ *  - To stop overwriting and let driver find the optimal size,
+ * set the width to zero:
+ *
+ *	echo 0x0 > /sys/kernel/debug/dri/0/DP-X/dsc_slice_width
+ *
+ */
+static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
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
+	aconnector->dsc_settings.dsc_slice_width = param[0];
+
+done:
+	kfree(wr_buf);
+	return size;
+}
+
 static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
@@ -1560,6 +1652,7 @@ static const struct file_operations dp_dsc_clock_en_debugfs_fops = {
 static const struct file_operations dp_dsc_slice_width_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.read = dp_dsc_slice_width_read,
+	.write = dp_dsc_slice_width_write,
 	.llseek = default_llseek
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 8250c37abe40..2c10352fa514 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -472,6 +472,7 @@ struct dsc_mst_fairness_params {
 	bool compression_possible;
 	struct drm_dp_mst_port *port;
 	bool clock_overwrite;
+	uint32_t slice_width_overwrite;
 };
 
 struct dsc_mst_fairness_vars {
@@ -506,6 +507,10 @@ static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *p
 					&params[i].timing->dsc_cfg)) {
 			params[i].timing->flags.DSC = 1;
 			params[i].timing->dsc_cfg.bits_per_pixel = vars[i].bpp_x16;
+			if (params[i].slice_width_overwrite)
+				params[i].timing->dsc_cfg.num_slices_h = DIV_ROUND_UP(
+										params[i].timing->h_addressable,
+										params[i].slice_width_overwrite);
 		} else {
 			params[i].timing->flags.DSC = 0;
 		}
@@ -722,6 +727,7 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		params[count].clock_overwrite = aconnector->dsc_settings.dsc_clock_en;
 		if (params[count].clock_overwrite)
 			debugfs_overwrite = true;
+		params[count].slice_width_overwrite = aconnector->dsc_settings.dsc_slice_width;
 		params[count].compression_possible = stream->sink->dsc_caps.dsc_dec_caps.is_dsc_supported;
 		dc_dsc_get_policy_for_timing(params[count].timing, &dsc_policy);
 		if (!dc_dsc_compute_bandwidth_range(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
