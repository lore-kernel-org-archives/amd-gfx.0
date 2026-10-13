Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694BCCA9ED2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A2110F783;
	Tue, 13 Oct 2026 11:19:35 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B81010F785
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTqMyu+6JX6DN4RmtQNMbOvW1UxxGR7sygGLjdnx/U2O1TgTTUMDSzKl1Gf19CSKHWXKXsDepRK/0T66UIYbHczmkpjeDcnG+GEJSmR/ufhSU0IhLSW7grledkeEHpD5BdWIIzNLPGur71RC88TDng/Buu6vU9rDzEsjLulj99Sw7vnylla9GRs7LjX7f0bSeRiDPTURDmZFOVxvI5ykOYJenPtooVGia+8ZY39Jxygl/gc/YbhkxsUH8Hrecco3scpJcPXfZdgNW8fzCFBpkcE00ruj5vwUNcMB8d3vWAqT6vMNIUemwAWNQAuoH9+rQz74zwwXe5nzgAPANQOMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sgJuyiZ/jJB2nv26tBUwnaHc95z9CZ7nr1flQ2V8tk=;
 b=cZgrIm7Bjm8MXrQc0PrF1LyC48n/fTGx3oQbx9CVlDSvz8ehLjXD7F7dV0mdQEy+alJ/Dx5dTWgx/QEI5PjPXQt7buZt/19axB0mP9vq+1bZreu8Ag3kuZx5a6vRo0ZNeyFCOs0S8bdEKBACPN36A6mE01jwJbvPVWqCfZBxcf85p6UDaXz0fiQZ9GoZ+XFYTqvF/LkNHBdFnE9KEXBYW0joNxBX7sp13yQyvY4+7WLVGaNoS4U22VZ0Eu8hFK0QF2wngri3VPspuaIPaaCKoX98vt6qFe9c1kiSk+5oBwx/h+7H5mFd9w7CHWZjQMO+SM/sJqufFWbJMFztgar3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sgJuyiZ/jJB2nv26tBUwnaHc95z9CZ7nr1flQ2V8tk=;
 b=BglnGPXmtA9GehktQfiOw2LltyDad9yLdhevP+qI7U0IHei3mhpti4Ka6Obg2fpAflrKnhOqUmDMr6Ceb97D8UbP1eNRC97+v8QgB1Oyl80qrHFLYx1wAmvEOVzgs8RbVo/SEp7GszhrvNQ2MXPA6ox06jXno3+eGH45fv/fUO8=
Received: from DS7PR03CA0059.namprd03.prod.outlook.com (2603:10b6:5:3b5::34)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:19:26 +0000
Received: from DM3PEPF000265C4.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::3d) by DS7PR03CA0059.outlook.office365.com
 (2603:10b6:5:3b5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:19:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265C4.mail.protection.outlook.com (10.167.23.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:19:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:19:18 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:19:18 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:19:10 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 22/30] drm/amd/display: warn on unadvertised modes without
 scaling
Date: Tue, 13 Oct 2026 19:08:09 +0800
Message-ID: <20261013111616.2267344-23-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C4:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da386ec-6da7-401a-8037-08df291bd738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: V+uBkoD5s8Q8xFai9tj9oS1P/Qyvj6+meMlq7a3d3S5EM2bIvrgc5H+6fdefEdnMQlz9i5IgO2guf2wMtqhpZx2quA85j1tVejL+7LNYREm1aMMtJNUW8W0s03vgUB7Tya0O7HuohHdXp451Ch2+9DJLAqqqTlwjmTyejR1TjCnpMc5UBKV1OxIPx87Ap7NjacN/U39hugeaEtTXJ89kqdPeN1qjTcZm1CCENK5s2MNWBXD45JNi6Vo7xP/WPvHnnBsxZwlPGSlktv3tasZ76zdr2+Dw/h5QN49tGmEKQvW04hH62tjU0Oci3BT7UxDxtd3OfTBKxwa2o7yrrCIuiohtjMqajuIT1aEzLiObS+9xFsxnlrYnieLtDtdnJJl/MV2M3MBM8bmzb7ShtvZ4xqgdghh3rA7epKANaRvS9UBNjyX6O13XVZPD3chhuANXS+k5elBL4K54pKVdihjO0qw5xYsz+jVl2Uchbup+vSyadNOWANEUVgAok+zZ1Ub2BacKzlg+hD30LeRD+7FnIPO32hRbg4ilha+sMiY7ttUCl0pTh+PGTayniRb3cYHPLHgQop7U+/yzbxgDNe+04HpNl7CdzMXhfxqxVXBX1w5k7m3tWxMf6Xs1mDrjuSMtzrUvhEYZKzkyXeVuGdGdHCUYuT64dHpXFuyEFzt+edTecq1UhvVRaisgtPDjm7xK35qF9JeuNqo2RPlfqMu6kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G0DXY9Trpeh/kU+ZiV3LC5qi3h0PcFyS4fl6MplZCKGtRs01KZeUfpNhQ9K+L5Xr83iNYhCNa/9+micXIfM+TIsBw8xC5I1Xu9FVhVsv1Jpq3f0btPtpLIsH76kfrHbKFN4bFw7PfJDL6KY5oMqHOYzUcjey8HOx3/vqBBS3hWr60kn3eMDNScGKmSXyKj0OFssh5Kf/B0bqsp2LrqXP30WaiixvMQNwCr8KbnEwhWGNjuCPsirR3p0VhWKGhBEz5OZffAMno4T/4zXMrjpbPlcc2ydWA5EOLuOxd2oO+wT4qaZ8+uL4zRLo8zkR+6A6qEFWIbFdsEW2gtF49HgsYfbUyjWIZUpX8Du8Sku3nj6nzlm4rwoIp0LaHblD449ElPFKJ+4QxtxI7Ul8/QXFZEt4GTS35DmzkzgbCZ2ocm6id/lhY0Dm204b3uIGJ8Ic
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:19:26.1130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da386ec-6da7-401a-8037-08df291bd738
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <jerry.zuo@amd.com>

[Why]
Selecting an unadvertised custom mode without scaling can send an
unsupported timing directly to the display.

[How]
Post a warning when this selection is made and advise to choose an
advertised/native mode when visual defect is observed.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 36 ++++++++++++-------
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |  2 +-
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 2ef1483869f9..324634e9cb16 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1397,6 +1397,21 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 }
 #endif
 
+STATIC_IFN_KUNIT bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
+					const struct drm_display_mode *mode)
+{
+	struct drm_display_mode *m;
+
+	list_for_each_entry(m, &aconnector->base.probed_modes, head) {
+		if (drm_mode_equal(m, mode))
+			return true;
+	}
+
+	return false;
+}
+
+EXPORT_IF_KUNIT(is_duplicate_mode);
+
 void amdgpu_dm_update_stream_scaling_settings(struct drm_device *dev,
 					   const struct drm_display_mode *mode,
 					   const struct dm_connector_state *dm_state,
@@ -1473,6 +1488,7 @@ create_stream_for_sink(struct drm_connector *connector,
 	struct drm_display_mode *freesync_mode = NULL;
 	bool native_mode_found = false;
 	bool recalculate_timing = false;
+	bool unadvertised_mode = false;
 	bool scale = dm_state->scaling != RMX_OFF;
 	int mode_refresh;
 	int preferred_refresh = 0;
@@ -1559,6 +1575,13 @@ create_stream_for_sink(struct drm_connector *connector,
 					&mode, preferred_mode, scale);
 
 			preferred_refresh = drm_mode_vrefresh(preferred_mode);
+			unadvertised_mode = !is_duplicate_mode(aconnector, drm_mode);
+
+			if (unadvertised_mode && dm_state->scaling == RMX_OFF)
+				drm_dbg_driver(dev,
+					       "Unadvertised mode %dx%d@%d with RMX_OFF\n",
+					       drm_mode->hdisplay, drm_mode->vdisplay,
+					       drm_mode_vrefresh(drm_mode));
 		}
 	}
 
@@ -2961,19 +2984,6 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *co
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_ddc_get_modes);
 
-STATIC_IFN_KUNIT bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
-			      struct drm_display_mode *mode)
-{
-	struct drm_display_mode *m;
-
-	list_for_each_entry(m, &aconnector->base.probed_modes, head) {
-		if (drm_mode_equal(m, mode))
-			return true;
-	}
-
-	return false;
-}
-EXPORT_IF_KUNIT(is_duplicate_mode);
 
 STATIC_IFN_KUNIT uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 79698deacf61..7bfbb6853833 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -214,7 +214,7 @@ bool adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
 					   const struct drm_display_info *info);
 
 int to_drm_connector_type(enum signal_type st, uint32_t connector_id);
-bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector, struct drm_display_mode *mode);
+bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector, const struct drm_display_mode *mode);
 enum dc_aspect_ratio get_aspect_ratio(const struct drm_display_mode *mode_in);
 void copy_crtc_timing_for_drm_display_mode(const struct drm_display_mode *src_mode,
 					   struct drm_display_mode *dst_mode);
-- 
2.43.0

