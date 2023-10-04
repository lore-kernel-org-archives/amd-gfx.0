Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81A7E936E6
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28D0B10E3C5;
	Wed,  4 Oct 2023 21:22:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7784710E3B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/eF+OQi6TBgXMgA9tyMjIXrBAw9DRBTJBx1vOSMGBoa2hHihin1xUkZWXYpA9A5X3wgJVIm51PHKhiz+kRV3389w+6fmhAcIm+h3hGzkZiBn0QbjR2GvArwRKyFf79+RKgf44N+iRgSMdSq3Cg3X0RACA/k67wxS5YrB3YvwL3WDbhGhihiKwPhY0IljTlTHkqs7Y5EKV38tQRmfSRvBk3jragaAZnH797UGe1W7jFoi4HpoWpOyEll2kxKJK7dQuDLLV0Ls+8QAf6FUzh4LSFO3X/6TRhpkLkwsUF6+MxJkYV71cYoEhCVtd4vsErZPapzVP9yMKX80xG8w391dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7mT/nTU4gGAO1rZQMjHH+Ia0cIQ71vhMK+4bBxxZM0=;
 b=CFkzLu9rqShkPCFZKFuc6SQcBBQ9Cw2cfho4GDmux+pDACbbGnpUAUJz09LjD/4w08kr5g2RbnM7xm3Kmlj7LKYJLR3h/QHCQR+bpeSLo1xoC5gjgZYHzALTpMiQHwYqG+XQOkBCVyrFgF9R/ApHwlIS0zbKvCbS7KwNlmwp48Y2OxU6shoWXqxlVUNb1Tc2u9VQ+Lx5GEorGBDP0dFmTvbrYjap7u/pvpF4rFw/j2kfHnCOGimtxieXPwG0SXIFRiuqHoYsLo7L/uk9BStTohkYKgFoShQ3DuQ4d2o6gPJGHo3GeycgzW83ZfPRzDRbPfDWQEGL9Eiqc5/ue6TJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7mT/nTU4gGAO1rZQMjHH+Ia0cIQ71vhMK+4bBxxZM0=;
 b=qBJ/JsaNBxCJgebkMs7fQMnLf2YbS0kIWIUS/mLIZdTfvYa7R/u0FIF+HZjuskEylHE55M6X+nGz/MbAQ9L9IBeImnB0AAFLziHjzcJXU2s8r14/A6DMscomSXUFMRdlHvaSytWqtr3UoRWWKtMlpMIIedhCkRloe3BvyOshoVE=
Received: from MW4PR03CA0116.namprd03.prod.outlook.com (2603:10b6:303:b7::31)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Wed, 4 Oct
 2023 21:22:08 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::c) by MW4PR03CA0116.outlook.office365.com
 (2603:10b6:303:b7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Wed, 4 Oct 2023 21:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 21:22:08 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 16:21:56 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 11/16] drm/amd/display: Move stereo timing check to helper
Date: Wed, 4 Oct 2023 15:21:05 -0600
Message-ID: <20231004212110.3753955-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
References: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 8560bbc0-142e-40d5-b095-08dbc51ff751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZA+lh2X7RMwovajZ8gDczRxEL1IPfFlG9hI23L47V9duNUKwfoVy02ka5SGoyM4X6KMl8x4gQSYLOi/kx1XXqjBS9wMw6zc9EbkN+n2ZHlVIEH74SRXhcpbKCDgsqMU1OJsfndWTbYvxxQZvvUlij6bY0QpwNnGpP3W1f4mZkAKeDTDCje/kkjYRFeixLXxZacD4QdZw04dCtUvFfKBUPAipuql2mzW1Ev2UmMGgc09bbtPXgPAsx4AUFnIybRYFHMhaK0tVuOsaE1Sao+xdTOC33QBbrjo5rwdgyPapsvgOguN+YAJ9XnAM+puJjhMLBd+N5pobU7rnoycjG0GN+1kzaThX2TNACA7gg2VE6hm3BwJYrF4QY33Zc4rq5nXokkmN3UTYvoRrxrYLtVfts1OBfFc236wgPyeyTvmRrhcZoKWeP8IRe7nIFScpw8aBd539KrpYbREg+mGW/FEEqdR+rROrkbEi8wURsG3ns7aTYAw3Sdcvr4+WjfxSogdTdVOMBm2pL9Ji3oRvvXW+fas36PBFAVpgXp34sU5KPj0bZ6dPw7afiphDhXoVhzNGpYdgUMofrylauvz/VAqYGGjkjSgReGxIm9fNFzJi/+tNwd5RNOkyaFhQ5A8/qYOj3k8LTcJZFYhaBYKVyMgJvkcnlzff5P9xsEO0C2ATMK6aOTLznJTr8UroSxEB1nQ4rVLe33nHx1IM4A7WjOeFHkVfqXGD01cxn9et+HAB4ekqWhYE031VLyJDPS7hnhLLLHuRfaYjMxfpejCgv2L0Tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(36756003)(40460700003)(40480700001)(36860700001)(2616005)(4326008)(16526019)(5660300002)(47076005)(83380400001)(426003)(6666004)(26005)(8676002)(8936002)(336012)(1076003)(41300700001)(70586007)(356005)(86362001)(81166007)(478600001)(316002)(54906003)(82740400003)(6916009)(70206006)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:22:08.5634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8560bbc0-142e-40d5-b095-08dbc51ff751
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736
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
Cc: Sunpeng.Li@amd.com, richard.gong@amd.com,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Taimur
 Hassan <syed.hassan@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <syed.hassan@amd.com>

Rework dml2_map_dc_pipes to keep the logic clean.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
---
 .../amd/display/dc/dml2/dml2_dc_resource_mgmt.c |  9 +--------
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c    | 17 +++++++++++++++++
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.h    |  1 +
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 116b78a5107c..e22b5106df8f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -710,14 +710,7 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
 					scratch.mpc_info.mpc_factor = DPPPerSurface[plane_disp_cfg_index];
 
 					//For stereo timings, we need to pipe split
-					if ((state->streams[stream_index]->view_format ==
-							VIEW_3D_FORMAT_SIDE_BY_SIDE ||
-							state->streams[stream_index]->view_format ==
-							VIEW_3D_FORMAT_TOP_AND_BOTTOM) &&
-							(state->streams[stream_index]->timing.timing_3d_format ==
-							TIMING_3D_FORMAT_TOP_AND_BOTTOM ||
-							state->streams[stream_index]->timing.timing_3d_format ==
-							TIMING_3D_FORMAT_SIDE_BY_SIDE))
+					if (dml2_is_stereo_timing(state->streams[stream_index]))
 						scratch.mpc_info.mpc_factor = 2;
 				} else {
 					// If ODM combine is enabled, then we use at most 1 pipe per
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 4c3661fbecbc..ac6bf776bad0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -461,3 +461,20 @@ bool dml2_verify_det_buffer_configuration(struct dml2_context *in_ctx, struct dc
 
 	return need_recalculation;
 }
+
+bool dml2_is_stereo_timing(struct dc_stream_state *stream)
+{
+	bool is_stereo = false;
+
+	if ((stream->view_format ==
+			VIEW_3D_FORMAT_SIDE_BY_SIDE ||
+			stream->view_format ==
+			VIEW_3D_FORMAT_TOP_AND_BOTTOM) &&
+			(stream->timing.timing_3d_format ==
+			TIMING_3D_FORMAT_TOP_AND_BOTTOM ||
+			stream->timing.timing_3d_format ==
+			TIMING_3D_FORMAT_SIDE_BY_SIDE))
+		is_stereo = true;
+
+	return is_stereo;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.h
index 342d64039f9a..23b9028337d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.h
@@ -42,6 +42,7 @@ void dml2_copy_clocks_to_dc_state(struct dml2_dcn_clocks *out_clks, struct dc_st
 void dml2_extract_watermark_set(struct dcn_watermarks *watermark, struct display_mode_lib_st *dml_core_ctx);
 int dml2_helper_find_dml_pipe_idx_by_stream_id(struct dml2_context *ctx, unsigned int stream_id);
 bool is_dtbclk_required(const struct dc *dc, struct dc_state *context);
+bool dml2_is_stereo_timing(struct dc_stream_state *stream);
 
 /*
  * dml2_dc_construct_pipes - This function will determine if we need additional pipes based
-- 
2.40.1

