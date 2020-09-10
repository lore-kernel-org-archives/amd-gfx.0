Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98AFC433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C9621D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jX6creht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C9621D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15FF36E92A;
	Thu, 10 Sep 2020 13:48:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 026F56E92A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAswDb+f5G54bQXwlCE0wCFgpyHF7swSpwe33tu9r4eQkS1jB+cCDE/atDflAJv65oavMdp7ChMGdrpp66ioUcmpJG4ag8RugnPU8d3PWP0lLAZUAUGXnjijajXGh6Zi3XZHA/7eTbtW+hy7yjAAqq51NUSgj3Zznup8s7LmBrbTEORG9fdFhkpQrJFGfZv85hiKroL3ZrlR/n5OrV2SzAnlJ9spfw63jYNl8rOOBqoxBLwnVlIdd1qSuPeH6OLNlmSITaKj/1cKs4bQfQFVDeM1X4tjOLMI7Jjg05OMHtRwwenMbwUPp++S6hTTCuA5xyQGvvq2Wgp5uo95akFZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw+RmLUFRRsKg5l72KqWjVELWnu6tp8XsXBWqlD1HVQ=;
 b=aLCp58O0Ryl1quk15MITpVapKk3gr62QRw2DeSx+OSvGbPR4IQA3zWVAwRTCrDomVm4t0KiFVuiZa9pIE1W0cnfFgCe2oBoKzq85vGy1BXlQjtlCy822eHQuQMnksBsjOZwpKl5nPAZQ7eVryYViZB8wNRyggOBIVFKZkpsveBhGb7d8Uz5yn+FTkK7Y4Wef4kdqj8Nz7xZyzFGXzcksmrWkKJHHB/qrwJ1wNTRfYx9aq3sjbunBZQ4OHNGQRF/czfybUL5J06dY5Zx1Gz1A0kZFASyUJSpG76J/3s1FPXgQcTIB8mcGvW1JW+ohXilZ+b3zzy8RvaJf98qW/DUMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw+RmLUFRRsKg5l72KqWjVELWnu6tp8XsXBWqlD1HVQ=;
 b=jX6crehtJCNg35MxViUn+lJ0BUCDGX5qPlO5MJpiOurJnJwoTiJbABH7ybljEsAZz4MIstAf+yeAyY1Y1iS+KGgolQ62PLDHUJ//HzJY5dtmj/Cj6Vip4dhdhxBFIUOs5Ru71LPX+vb0WcWKwr9FWtx3wQSWl72bzZR/+iOJGJw=
Received: from BN6PR20CA0071.namprd20.prod.outlook.com (2603:10b6:404:151::33)
 by BN7PR12MB2788.namprd12.prod.outlook.com (2603:10b6:408:30::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:48:08 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::cd) by BN6PR20CA0071.outlook.office365.com
 (2603:10b6:404:151::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:48:08 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:48:07 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:48:01 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 34/42] drm/amd/display: Calculate DSC number of slices in
 debugfs when forced
Date: Thu, 10 Sep 2020 09:47:15 -0400
Message-ID: <20200910134723.27410-35-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37d3aeda-b03b-464d-7217-08d85590266b
X-MS-TrafficTypeDiagnostic: BN7PR12MB2788:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2788D3E85DC5B2FCF14D8C958B270@BN7PR12MB2788.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2ELygY8meapWXPi+aA1+g8khHlzkLAYKc207yejiYoy2u9xHJSufcZbFUIU5b5rZiN4evSaW0GTferlUdiKNDyVQJm890EK//7aFXQTXcrLZEF/fm+OC9qRqrAH0zfDes5IRiNZfUb5XFtona5YeJsNZ7pQufGiUSDvk8mw+d1fQRkMiLwy0yuwZkTjva+olbe4O8aEmhTuUYv5Q+zXh/4t+fRUF6U/vCB+C84zvVVxMl22UT975iB1fZO6Zzv6C1YQunWfwQNNvFmnAc+YhMogSnr/QP5AdHL8wH32u3UuZ+umZrfyfoX7gilB44UzTKfPy92dEr0qqcZHy73SilWc6U5zmhaymDpd3YDk8jUFH23kB9h25wWGj25d16T6X5IRHRelrOigmr8RIH11WA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966005)(6666004)(8936002)(356005)(426003)(70206006)(70586007)(36756003)(44832011)(82740400003)(5660300002)(316002)(83380400001)(2616005)(47076004)(81166007)(7696005)(6916009)(8676002)(336012)(2906002)(82310400003)(26005)(186003)(4326008)(478600001)(1076003)(86362001)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:48:08.0712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d3aeda-b03b-464d-7217-08d85590266b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2788
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
When comparing current DSC timing settings with enforced through
debugfs we have to calculate number of both vertical and horisontal
slices. So instead of doing that every time we should just
use number of slices rather than setting its dimensions.

[how]
In connector's dsc preferred settings structure change slice height
and slice width parameters to number of slices vertical and horisontal.
Also calculate number of slices in debugfs rather in create_stream_for_sink.

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  4 ++--
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 14 +++++++++++--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 20 ++++++++-----------
 4 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e70e46764e61..11afdb28eeda 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4735,13 +4735,11 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			if (aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE)
 				stream->timing.flags.DSC = 1;
 
-			if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_slice_width)
-				stream->timing.dsc_cfg.num_slices_h = DIV_ROUND_UP(stream->timing.h_addressable,
-									aconnector->dsc_settings.dsc_slice_width);
+			if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_num_slices_h)
+				stream->timing.dsc_cfg.num_slices_h = aconnector->dsc_settings.dsc_num_slices_h;
 
-			if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_slice_height)
-				stream->timing.dsc_cfg.num_slices_v = DIV_ROUND_UP(stream->timing.v_addressable,
-									aconnector->dsc_settings.dsc_slice_height);
+			if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_num_slices_v)
+				stream->timing.dsc_cfg.num_slices_v = aconnector->dsc_settings.dsc_num_slices_v;
 
 			if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_bits_per_pixel)
 				stream->timing.dsc_cfg.bits_per_pixel = aconnector->dsc_settings.dsc_bits_per_pixel;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index c805c61ef84f..87471f4c8cd1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -351,8 +351,8 @@ enum dsc_clock_force_state {
 
 struct dsc_preferred_settings {
 	enum dsc_clock_force_state dsc_force_enable;
-	uint32_t dsc_slice_width;
-	uint32_t dsc_slice_height;
+	uint32_t dsc_num_slices_v;
+	uint32_t dsc_num_slices_h;
 	uint32_t dsc_bits_per_pixel;
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 240a4fc403df..9be2f291382d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1447,7 +1447,12 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 	if (!pipe_ctx || !pipe_ctx->stream)
 		goto done;
 
-	aconnector->dsc_settings.dsc_slice_width = param[0];
+	if (param[0] > 0)
+		aconnector->dsc_settings.dsc_num_slices_h = DIV_ROUND_UP(
+					pipe_ctx->stream->timing.h_addressable,
+					param[0]);
+	else
+		aconnector->dsc_settings.dsc_num_slices_h = 0;
 
 done:
 	kfree(wr_buf);
@@ -1596,7 +1601,12 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 	if (!pipe_ctx || !pipe_ctx->stream)
 		goto done;
 
-	aconnector->dsc_settings.dsc_slice_height = param[0];
+	if (param[0] > 0)
+		aconnector->dsc_settings.dsc_num_slices_v = DIV_ROUND_UP(
+					pipe_ctx->stream->timing.v_addressable,
+					param[0]);
+	else
+		aconnector->dsc_settings.dsc_num_slices_v = 0;
 
 done:
 	kfree(wr_buf);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index be6b88e4c570..0b9a4fc642ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -451,8 +451,8 @@ struct dsc_mst_fairness_params {
 	bool compression_possible;
 	struct drm_dp_mst_port *port;
 	enum dsc_clock_force_state clock_force_enable;
-	uint32_t slice_width_overwrite;
-	uint32_t slice_height_overwrite;
+	uint32_t num_slices_h;
+	uint32_t num_slices_v;
 	uint32_t bpp_overwrite;
 };
 
@@ -493,15 +493,11 @@ static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *p
 			else
 				params[i].timing->dsc_cfg.bits_per_pixel = vars[i].bpp_x16;
 
-			if (params[i].slice_width_overwrite)
-				params[i].timing->dsc_cfg.num_slices_h = DIV_ROUND_UP(
-										params[i].timing->h_addressable,
-										params[i].slice_width_overwrite);
+			if (params[i].num_slices_h)
+				params[i].timing->dsc_cfg.num_slices_h = params[i].num_slices_h;
 
-			if (params[i].slice_height_overwrite)
-				params[i].timing->dsc_cfg.num_slices_v = DIV_ROUND_UP(
-										params[i].timing->v_addressable,
-										params[i].slice_height_overwrite);
+			if (params[i].num_slices_v)
+				params[i].timing->dsc_cfg.num_slices_v = params[i].num_slices_v;
 		} else {
 			params[i].timing->flags.DSC = 0;
 		}
@@ -718,8 +714,8 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		params[count].clock_force_enable = aconnector->dsc_settings.dsc_force_enable;
 		if (params[count].clock_force_enable == DSC_CLK_FORCE_ENABLE)
 			debugfs_overwrite = true;
-		params[count].slice_width_overwrite = aconnector->dsc_settings.dsc_slice_width;
-		params[count].slice_height_overwrite = aconnector->dsc_settings.dsc_slice_height;
+		params[count].num_slices_h = aconnector->dsc_settings.dsc_num_slices_h;
+		params[count].num_slices_v = aconnector->dsc_settings.dsc_num_slices_v;
 		params[count].bpp_overwrite = aconnector->dsc_settings.dsc_bits_per_pixel;
 		params[count].compression_possible = stream->sink->dsc_caps.dsc_dec_caps.is_dsc_supported;
 		dc_dsc_get_policy_for_timing(params[count].timing, &dsc_policy);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
