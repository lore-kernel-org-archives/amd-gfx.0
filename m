Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66F5C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79FD206F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sF6Mvaz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79FD206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75C336E958;
	Thu, 30 Jul 2020 19:12:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE1796E958
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:12:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVGcC3BVTJY+aqjBrNcsoH8RJsQJDWUYqA8Q3O//4vTGsbJCerfRtf7cEas4G6IE70j9ysVkr2rVmt6ZK9B3lJcVE1UR2lMmpyn6J7KdhEAobbU8tVR+MePmiSPl1SA7GIAN2b/Dg3A/oqUQowKB8KyNcSO74ftVyekpbDqLXwFFOmBvIRKiuHOkGRfeSxh6vhrs+nporwOd47Kl8CU1ksGquBtOTmRB+QAHncEHrEupRaqbIY+FylfFUxnEaA6U3ARdl3D0C9wY7csojMzX4Qq1MXWaEd0Bjo+YOXaF2z110ddguaygBpKgMdVi6npYf0+afBTQ0rWIcxtT5fwRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5iapud7QzicriWK4aiB+Eat545lP/aRnruLwTwv5SM=;
 b=GHydT23h5usJu8yyf37l4POQyXe/dtBD5wT9i60SnUyALh1HLHX8CH5GEiKjQ8iDsgjDiML0jCGPpz2IdvbixPGLBZCHhmZUoAYD/d8oAQ6zdxlIg+DvtJtHnmOlUnWwmJfLqGm1208b45DmlTjICZO1VYwlzkb5ndMrnGWwaRILZ0HP5obPK+5u1ZVINgD18kuORPjB2NjkvPqbFnFF8OL0lIurs9l5aFah55+pdOJcik0Va4eDCvXtxyN7MZh6qZ198hMFuP6MWPR19pjcEYdEj/QNyakGfkWiQAw4v5S5VD72xIn/giDJjac97Pzei5AnXSdSvIZCzQ6htLDH3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5iapud7QzicriWK4aiB+Eat545lP/aRnruLwTwv5SM=;
 b=sF6Mvaz0Cy0DXfM7ujnLHc0DF8xXu/uREGIqN9D5pdnDAeL0ObfvlRzz78rYEhMtm4m20HN3FGJQB8GbYqdHKYulEyvPn/D0feA9PDd7Bmk7nfcpAPCSgBMW7J4aLccgIwXlCD/qFnPiGVdY6C1AQAd6q355gUlaIAtjd1aD3mQ=
Received: from DM6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:5:80::37) by
 BN7PR12MB2643.namprd12.prod.outlook.com (2603:10b6:408:29::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.24; Thu, 30 Jul 2020 19:12:15 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::9a) by DM6PR08CA0024.outlook.office365.com
 (2603:10b6:5:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Thu, 30 Jul 2020 19:12:14 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 19:12:13 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:13 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 14:12:02 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/16] drm/amd/display: DSC Bit target rate debugfs write entry
Date: Thu, 30 Jul 2020 15:11:36 -0400
Message-ID: <20200730191146.33112-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730191146.33112-1-aurabindo.pillai@amd.com>
References: <20200730191146.33112-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3ae713e-5bd6-4f5b-60e5-08d834bc77a5
X-MS-TrafficTypeDiagnostic: BN7PR12MB2643:
X-Microsoft-Antispam-PRVS: <BN7PR12MB264304C7DAD6651EE18736838B710@BN7PR12MB2643.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CCXW5YlvkNR51jfsCACTTCPFliMuZyz2i7JuDwaqRjmSFQZM1fFjs+lc4BJ9SAlFtUlwy1egsZsuQRKwBrqGnl7HYWY6CDudqh2v+DuuDRA6QG1enMTOnIm+5oZPpvoJnJt9Jx4RdmwtL0dwN7kGyp3fKkkv1C7UoWWD/Ha2LqmthH7pTYzC1KqvgEcfZmRm1JUGJlJ7Sw50D9gW2gsQvkjJnUkoVKK/B1o9V02eiQvxhHSSaoT1Jycm41hw77fB+SHcgbylAIe7r5xk66Wrk50xOO85EhIcL0/o6+EvnSxaYzJrv0WpdcDrrDsoenAgvZC6+oK+mA7x5JhUy92FlGUcfJFpViRxkf4nPgMvuDCQtmvgFQZQOETwdJLWwwufhsVkxlt8OtuunuLi8FtB4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(2616005)(7696005)(478600001)(1076003)(336012)(316002)(54906003)(6666004)(5660300002)(8676002)(8936002)(44832011)(426003)(6916009)(86362001)(70206006)(36756003)(82310400002)(81166007)(83380400001)(186003)(70586007)(2906002)(26005)(356005)(47076004)(4326008)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 19:12:13.7918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ae713e-5bd6-4f5b-60e5-08d834bc77a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2643
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
We need to be able to specify bits per pixel for DSC on any
connector.

[How]
Overwrite computed DSC target rate in dsc_cfg, with requested value.
Overwrites for both SST and MST connectors, but in different places, but the process is identical. Overwrites only if DSC is decided to be enabled on that connector.

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 86 +++++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  9 +-
 4 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 29570ce77967..a64c2d5789df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4751,6 +4751,9 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_slice_height)
 				stream->timing.dsc_cfg.num_slices_v = DIV_ROUND_UP(stream->timing.v_addressable,
 									aconnector->dsc_settings.dsc_slice_height);
+
+			if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_bits_per_pixel)
+				stream->timing.dsc_cfg.bits_per_pixel = aconnector->dsc_settings.dsc_bits_per_pixel;
 		}
 #endif
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 333813ede0c7..3114f6e938e3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -346,6 +346,7 @@ struct dsc_preferred_settings {
 	bool dsc_clock_en;
 	uint32_t dsc_slice_width;
 	uint32_t dsc_slice_height;
+	uint32_t dsc_bits_per_pixel;
 };
 
 struct amdgpu_dm_connector {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 971b75a52e89..33e87f508991 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1441,6 +1441,18 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 	return size;
 }
 
+/* function: read DSC target rate on the connector in bits per pixel
+ *
+ * The read function: dp_dsc_bits_per_pixel_read
+ * returns target rate of compression in bits per pixel
+ * The return is an integer: 0 or other positive integer
+ *
+ * Access it with the following command:
+ *
+ *	cat /sys/kernel/debug/dri/0/DP-X/dsc_bits_per_pixel
+ *
+ *  0 - means that DSC is disabled
+ */
 static ssize_t dp_dsc_bits_per_pixel_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
@@ -1498,6 +1510,79 @@ static ssize_t dp_dsc_bits_per_pixel_read(struct file *f, char __user *buf,
 	return result;
 }
 
+/* function: write DSC target rate in bits per pixel
+ *
+ * The write function: dp_dsc_bits_per_pixel_write
+ * overwrites automatically generated DSC configuration
+ * of DSC target bit rate.
+ *
+ * Also the user has to write bpp in hexidecimal
+ * rather than in decimal.
+ *
+ * Writing DSC settings is done with the following command:
+ * - To force overwrite rate (example sets to 256 bpp x 1/16):
+ *
+ *	echo 0x100 > /sys/kernel/debug/dri/0/DP-X/dsc_bits_per_pixel
+ *
+ *  - To stop overwriting and let driver find the optimal rate,
+ * set the rate to zero:
+ *
+ *	echo 0x0 > /sys/kernel/debug/dri/0/DP-X/dsc_bits_per_pixel
+ *
+ */
+static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *buf,
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
+	aconnector->dsc_settings.dsc_bits_per_pixel = param[0];
+
+done:
+	kfree(wr_buf);
+	return size;
+}
+
 static ssize_t dp_dsc_pic_width_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
@@ -1758,6 +1843,7 @@ static const struct file_operations dp_dsc_slice_height_debugfs_fops = {
 static const struct file_operations dp_dsc_bits_per_pixel_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.read = dp_dsc_bits_per_pixel_read,
+	.write = dp_dsc_bits_per_pixel_write,
 	.llseek = default_llseek
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index d433949fe53a..9ef7492e4d3b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -474,6 +474,7 @@ struct dsc_mst_fairness_params {
 	bool clock_overwrite;
 	uint32_t slice_width_overwrite;
 	uint32_t slice_height_overwrite;
+	uint32_t bpp_overwrite;
 };
 
 struct dsc_mst_fairness_vars {
@@ -507,7 +508,12 @@ static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *p
 					params[i].timing,
 					&params[i].timing->dsc_cfg)) {
 			params[i].timing->flags.DSC = 1;
-			params[i].timing->dsc_cfg.bits_per_pixel = vars[i].bpp_x16;
+
+			if (params[i].bpp_overwrite)
+				params[i].timing->dsc_cfg.bits_per_pixel = params[i].bpp_overwrite;
+			else
+				params[i].timing->dsc_cfg.bits_per_pixel = vars[i].bpp_x16;
+
 			if (params[i].slice_width_overwrite)
 				params[i].timing->dsc_cfg.num_slices_h = DIV_ROUND_UP(
 										params[i].timing->h_addressable,
@@ -735,6 +741,7 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 			debugfs_overwrite = true;
 		params[count].slice_width_overwrite = aconnector->dsc_settings.dsc_slice_width;
 		params[count].slice_height_overwrite = aconnector->dsc_settings.dsc_slice_height;
+		params[count].bpp_overwrite = aconnector->dsc_settings.dsc_bits_per_pixel;
 		params[count].compression_possible = stream->sink->dsc_caps.dsc_dec_caps.is_dsc_supported;
 		dc_dsc_get_policy_for_timing(params[count].timing, &dsc_policy);
 		if (!dc_dsc_compute_bandwidth_range(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
