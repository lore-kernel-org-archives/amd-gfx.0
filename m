Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F2AC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 21:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B165910EB49;
	Fri, 11 Feb 2022 21:52:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC11510EB49
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 21:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOGBXCiqeNbOAz2M+UbqEeBJZMpmiFsHrVXzBJEdLKAIprJrJx4SA+RIIjKvXWag3t3sjqmNjLooDtrM/zwAn3WSGXBFS6DFcTHbJmvK8Nu44XLYqtekILySqvzvbXtZ2Wt/rezjHuaV84BoZN63jUrARxPpd1lB87M3cdvBfVA45Rh0kg+fz2CiwBKQT0otx8mT9RHQYHRprHPqlPSJSV5msYes/UoTgbfN6VTc+pLpnFDNuRhLQRXabila5G4eB8/fevTz1hDfmXivm+Jdg7sVsx+9uvq+CVXr0Og1adHxFjrEBAFmAkb7L27mbhrjPaNuOcGfGy52tyJgbrW8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKf8QGS9rV3mCNUIGhxxw80OqcbPdJFdB6OlyMwgW8Q=;
 b=fXNGjOwukP0KO4uAZGMpw83mfG1lssiAuXPKb35OdPn+sGjjvckgBMrTe30NANfQELGr0BCD0ECQ8g0nJq//3gKg41M5yAjvWmE5xtPfZ5KxGuN63AYGTx7k4mTOdFt257NCuMHUBUDKTJmUETNOhKFd0CzZiDXLLXdUpYfIIwkHN762Msi3blsHNQOTOoTbEW8cZFgC7E0Cg0JwuYYA9LBZZMyfPLYcWuiLODdNgd9JU0xdW+v2Avypl5HUT3iksKcy5d3U3uA7JLOvKNBFKwtdnYBn9sgtI2Cp/jsxXtp5RbxSzxY9FhFZZ61ANnSNCP6CS6X+H0HdhwTONpoGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKf8QGS9rV3mCNUIGhxxw80OqcbPdJFdB6OlyMwgW8Q=;
 b=0D+5l2UBuAEPRjPMbgeTnfs3t4jc3HcvBEAzDXpZjZA76H/2Orf2cECCNX+lduSjiYvV1i7i+frJH0Q94S81eJvogOadTge/ktZZTkkFsdveJTyw4EcojTi28ruMZGLJUugSaKK2Mn721zW3KzwdVhCdQ0+sN0e3M59BnBQkLN8=
Received: from MWHPR08CA0049.namprd08.prod.outlook.com (2603:10b6:300:c0::23)
 by DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 21:52:16 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::49) by MWHPR08CA0049.outlook.office365.com
 (2603:10b6:300:c0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 21:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 21:52:15 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 11 Feb 2022 15:52:12 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/11] drm/amd/display: add dsc mst stream pbn log for debug
Date: Fri, 11 Feb 2022 16:51:40 -0500
Message-ID: <20220211215142.94169-10-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211215142.94169-1-jdhillon@amd.com>
References: <20220211215142.94169-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc535972-4745-4fe9-d75e-08d9eda8c4b7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4060:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB40603754AB1349360B305666FB309@DM6PR12MB4060.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7djybSy9BJTd2qx8DbaozoDt6ZZZM+/RI9nvr3kvFr2SNuXW1kqFW0FStyZr55RyfQqTPG/+Z245jOhW/8zQvVNYoNFjeRxFRvTvgnlKlFwBQWdprKNhYjtW/fwcDnVyLved+npLesxIEFEhpyBTRumh7KPMmJLZKoBTAy/YqL5zivHtJ53E120pu4f4//BXbn/1AtG2FRlMqiFv7r+qe9PJmV+DCEJD1tVlc29nn8aXRmzxa8gBZeCEhF2e0UVqrXmQqiOpLUyPI2u6mWB8xJXMtQ0c4FJot9UtZbk4Icp94228yYHhZxusQnmopN6uQkMAEagJnwj4UdGieOPw8fBu9VoeRWl6fpYc8rtRljqv+KA+q6vl1RhXO9uoMlpBFUQk4QZn2ADUPsglMEqWjBHJbdIDvtMn7Q6B3neHhZtrwxv+ewEZgA6GON8hiwKBoGL4nfl/iethhoF51XZl6Zr+OmHGuTts45Jmo0XWYAKBpVDtH1mNPyz48IgPRCw6sBWRIkwo0DgEemg3zovHpDCnLEtlXov0AMTDQWQCgq0cDH6HBFhpMs64+4uk1dDN3RajNzH9pPt5hGKiJjuWE5kmM5O5OkqsEcfgZNr3pDPS5fCbEY/K09N6Z+mtH8juxwnj1xPO6/OOcWm5wTmwSOj2fiYnPS0w/1HM+YXxiEGteZjrg5RZ0bXGOslhad39/tjXZ+9Wtp9yBjsQ+5zp5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(6666004)(5660300002)(82310400004)(8936002)(8676002)(426003)(4326008)(336012)(36756003)(508600001)(356005)(70206006)(6916009)(2616005)(26005)(54906003)(16526019)(40460700003)(186003)(1076003)(2906002)(316002)(81166007)(70586007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:52:15.8588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc535972-4745-4fe9-d75e-08d9eda8c4b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Hersen Wu <hersenwu@amd.com>,
 solomon.chiu@amd.com, Jerry Zuo <Jerry.Zuo@amd.com>, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenwu@amd.com>

[why]
payload and slot number of display on dsc mst hub will be
adjusted when there is change on any display on dsc hub.
to monitor dsc enable/disable, pbn change, we need add log.

[How]
add mst_pbn to dc_dsc_config of dc_crtc_timing.
add dsc, pbn, display name within dc_core_enable_stream,
dc_core_disable_stream, dc_stream_log

Reviewed-by: Jerry Zuo <Jerry.Zuo@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 15 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 20 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 16 +++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  1 +
 4 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 914d59821c03..52ce5cc6462f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -599,6 +599,21 @@ static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *p
 		} else {
 			params[i].timing->flags.DSC = 0;
 		}
+		params[i].timing->dsc_cfg.mst_pbn = vars[i + k].pbn;
+	}
+
+	for (i = 0; i < count; i++) {
+		if (params[i].sink) {
+			if (params[i].sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
+				params[i].sink->sink_signal != SIGNAL_TYPE_NONE)
+				DRM_DEBUG_DRIVER("%s i=%d dispname=%s\n", __func__, i,
+					params[i].sink->edid_caps.display_name);
+		}
+
+		DRM_DEBUG_DRIVER("dsc=%d bits_per_pixel=%d pbn=%d\n",
+			params[i].timing->flags.DSC,
+			params[i].timing->dsc_cfg.bits_per_pixel,
+			vars[i + k].pbn);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b1718600fa02..48858e31b092 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4082,6 +4082,15 @@ void core_link_enable_stream(
 
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 
+	if (pipe_ctx->stream->sink) {
+		if (pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
+			pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_NONE) {
+			DC_LOG_DC("%s pipe_ctx dispname=%s signal=%x\n", __func__,
+			pipe_ctx->stream->sink->edid_caps.display_name,
+			pipe_ctx->stream->signal);
+		}
+	}
+
 	if (!IS_DIAG_DC(dc->ctx->dce_environment) &&
 			dc_is_virtual_signal(pipe_ctx->stream->signal))
 		return;
@@ -4303,6 +4312,17 @@ void core_link_disable_stream(struct pipe_ctx *pipe_ctx)
 	if (is_dp_128b_132b_signal(pipe_ctx))
 		vpg = pipe_ctx->stream_res.hpo_dp_stream_enc->vpg;
 
+	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
+
+	if (pipe_ctx->stream->sink) {
+		if (pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
+			pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_NONE) {
+			DC_LOG_DC("%s pipe_ctx dispname=%s signal=%x\n", __func__,
+			pipe_ctx->stream->sink->edid_caps.display_name,
+			pipe_ctx->stream->signal);
+		}
+	}
+
 	if (!IS_DIAG_DC(dc->ctx->dce_environment) &&
 			dc_is_virtual_signal(pipe_ctx->stream->signal))
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 57cf4cb82370..263f9891ecbc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -737,5 +737,21 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream)
 	DC_LOG_DC(
 			"\tlink: %d\n",
 			stream->link->link_index);
+
+	DC_LOG_DC(
+			"\tdsc: %d, mst_pbn: %d\n",
+			stream->timing.flags.DSC,
+			stream->timing.dsc_cfg.mst_pbn);
+
+	if (stream->sink) {
+		if (stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
+			stream->sink->sink_signal != SIGNAL_TYPE_NONE) {
+
+			DC_LOG_DC(
+					"\tdispname: %s signal: %x\n",
+					stream->sink->edid_caps.display_name,
+					stream->signal);
+		}
+	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index eac34f591a3f..c964f598755a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -745,6 +745,7 @@ struct dc_dsc_config {
 	bool is_frl; /* indicate if DSC is applied based on HDMI FRL sink's capability */
 #endif
 	bool is_dp; /* indicate if DSC is applied based on DP's capability */
+	uint32_t mst_pbn; /* pbn of display on dsc mst hub */
 };
 struct dc_crtc_timing {
 	uint32_t h_total;
-- 
2.25.1

