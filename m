Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8104CEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 20:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203EF10E544;
	Thu, 15 Jun 2023 20:40:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C2010E19C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 20:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArV6NESyIaNRL74DI1LFt/jv5rdZb5Kgp8EEL2Zp+/ZXpXNCMBK+w93Y0IyfufTUP7knC8IxGBDcNEPa8+U9/HxmTBZ8XOmTVV2FqJ+583bG/PGCCily0w5+hJt3yJPEovzS8hCLHue25rCBFe47QLOo9TXR9JhIWWDRBp4icGqFXTHtRIBChwP1H1xRfG3q+SSaTZKqP7Vsex1qtj9vy49m/rPCgLJ0UjAFwomtRWpGVBcp7BRelXkR5zPKI8UcwDFnm6H79oPKzcCbwDutRq8Hkc8KETl1mYmFupzGnwJPf7b3qvQP/qtBxNtosWuQmSk3H6bLx6MjalO3kJmNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSX8v26ra0s01541HutOlaaF8rElhmkld3eibiykdtE=;
 b=iWBAtstUPMDJRegsthbfnSm2i5jcktukjGfAmS8b6e5l27AHXPd3jf64vh61nz0nSqDOwsAtQerhBUiSD9J2tZfpPswTZR/3BYZY/8Ftqi0n29lPl+DbZUD6Ey7k0dJd4iK8U7vQIPSjXc8OSnz39hMkhKBPrA2ucPjScOzus8ZFHwQkCtBFL1wYj1BtKlLD4nCd1RPaG76usNesGI3ICK1lu6ursEXW8fJaZgWIiqZdiNziXOkDdDOBsOnikuSrztzwVlkxBhsAwcwHLG8FhbnDbYK9HMYvjCwEDVEAU8AlsH7R4evXcosPTRQHHP6teoQRVLwAwBZGKiPJAlwAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSX8v26ra0s01541HutOlaaF8rElhmkld3eibiykdtE=;
 b=TfGYvKIwzvlTf/ayfFTgyhLrCmPYOaMO0XC5IqVmtH1k/PwAivX5Z5iORPUM/MRgHJWjHGNHVTlHxHyLKKBAWzyUIRgv8BIF0Onbi4IkjxB/nDNXqLLGLsHVGgJCsOyyA92g2Fpd3gx+solpu8Hk7E6C7GUUXJGBhfsS13d7mpE=
Received: from BY5PR17CA0072.namprd17.prod.outlook.com (2603:10b6:a03:167::49)
 by CO6PR12MB5474.namprd12.prod.outlook.com (2603:10b6:303:139::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 20:39:53 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:167:cafe::35) by BY5PR17CA0072.outlook.office365.com
 (2603:10b6:a03:167::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Thu, 15 Jun 2023 20:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.29 via Frontend Transport; Thu, 15 Jun 2023 20:39:53 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 15:39:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 15 Jun
 2023 13:39:52 -0700
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 15 Jun 2023 15:39:52 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amd/display: Add Freesync Panel DM code
Date: Thu, 15 Jun 2023 16:39:27 -0400
Message-ID: <20230615203930.1715722-4-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT015:EE_|CO6PR12MB5474:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a905a9a-9b60-4617-a276-08db6de0ac63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZRJ/7kr/3LZs8H8Sn9CHpLsTUtZ7J3xBcwm2DGQiPlx597cgV4WYUlaiSvXud29DNaxqHwONzk+kuF8HaskpW8tx5pgCacICRX/X5NocGQj3yN9h45dHb6mV0iAcRpaVeEgDnM7jVPDMBr7YzF1kq5WgYlZqzdP/K4/xTTQkPK11TePYAT2NTzc0fMrWLip2+3emymrJZdWxNRKb8ZKh3Hj+wY3ZnxG8htmd/WAsm5cq6QHpc3FxStEO4LmZm/qkFGdJWFKsjGVMlcu6F4651L/govpewkIn249Yf38bUans3sVclSxjcgoxS8NMMeQUjB/XztyZffYGQkbe15N04Kd5hiO8sAN8eQSK10FSL2avK1nUw+RliMAT2/oBpK6RH51wyMTuF7OjvBacxd9fLy0kBG9FEAT8ciKdPkMbCyfTo2aVL++J5nOQ924LUeGj+D0IfcPY+nz3NFUQoFyPlNKaggEZJQznOmYZB5pxhimJ+IjZrs04/WRE4a9gTmG+/O1P06Errk/mP9Ba3a0dK4/GfwsdmqvM9/FKSdxjSa/b7lUHIO6hEdnU/h9QRJpha1d+8ngcRvEWYxZMyLQzJ6LR2SDvfpwlbhOTRR8gD9g3Z56KkLd8kTo6Cnz3/yBgwWdNXQKJpzt8Co664aEhxzApJYjPcITwvqSiQr3AErWSWkJm8yJN4dcAsusK1xYvjc5zxDtyornNXpRcxBVEQUKBX7arhWHy9CS3LSXz5NfYoJz+RP4OLGCG3IQ7KDgLi7QcJbGB5QVMuEtqjX4pw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(110136005)(26005)(1076003)(47076005)(81166007)(356005)(40480700001)(82740400003)(41300700001)(316002)(4326008)(36860700001)(6636002)(70586007)(70206006)(30864003)(186003)(6666004)(36756003)(7696005)(2616005)(8936002)(86362001)(2906002)(8676002)(83380400001)(5660300002)(40460700003)(478600001)(426003)(336012)(82310400005)(66899021)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 20:39:53.4588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a905a9a-9b60-4617-a276-08db6de0ac63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5474
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need certain conditions for replay to be enabled, so create an
interface in DM to enable/disable replay.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  | 183 ++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.h  |  46 +++++
 .../drm/amd/display/dc/core/dc_link_exports.c |   5 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +
 .../amd/display/modules/power/power_helpers.c |   5 +
 .../amd/display/modules/power/power_helpers.h |   2 +
 7 files changed, 244 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index 249b073f6a23..8bf94920d23e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -38,7 +38,7 @@ AMDGPUDM += dc_fpu.o
 endif
 
 ifneq ($(CONFIG_DRM_AMD_DC),)
-AMDGPUDM += amdgpu_dm_services.o amdgpu_dm_helpers.o amdgpu_dm_pp_smu.o amdgpu_dm_psr.o
+AMDGPUDM += amdgpu_dm_services.o amdgpu_dm_helpers.o amdgpu_dm_pp_smu.o amdgpu_dm_psr.o amdgpu_dm_replay.o
 endif
 
 AMDGPUDM += amdgpu_dm_hdcp.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
new file mode 100644
index 000000000000..7690ab6125a1
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -0,0 +1,183 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "amdgpu_dm_replay.h"
+#include "dc.h"
+#include "dm_helpers.h"
+#include "amdgpu_dm.h"
+#include "modules/power/power_helpers.h"
+#include "dmub/inc/dmub_cmd.h"
+#include "dc/inc/link.h"
+
+/*
+ * link_supports_replay() - check if the link supports replay
+ * @link: link
+ * @aconnector: aconnector
+ *
+ */
+static bool link_supports_replay(struct dc_link *link, struct amdgpu_dm_connector *aconnector)
+{
+	struct dm_connector_state *state = to_dm_connector_state(aconnector->base.state);
+	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
+	struct adaptive_sync_caps *as_caps = &link->dpcd_caps.adaptive_sync_caps;
+
+	if (!state->freesync_capable)
+		return false;
+
+	//TODO VSDB replay check
+	/* i = parse_amd_vsdb(aconnector, edid, &vsdb_info); */
+
+	/* if(!vsdb_info.replay_mode) */
+	/* 	return false; */
+
+	// Check the eDP version
+	if (dpcd_caps->edp_rev < EDP_REVISION_13)
+		return false;
+
+	if (!dpcd_caps->alpm_caps.bits.AUX_WAKE_ALPM_CAP)
+		return false;
+
+	// Check adaptive sync support cap
+	if (!as_caps->dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT)
+		return false;
+
+	return true;
+}
+
+/*
+ * amdgpu_dm_setup_replay() - setup replay configuration
+ * @link: link
+ * @aconnector: aconnector
+ *
+ */
+bool amdgpu_dm_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *aconnector)
+{
+	struct replay_config pr_config;
+	union replay_debug_flags *debug_flags = NULL;
+
+	if (!dc_is_embedded_signal(link->connector_signal))
+		return false;
+
+	if (link->panel_config.psr.disallow_replay)
+		return false;
+
+	if (!link_supports_replay(link, aconnector))
+		return false;
+
+	// Mark Replay is supported in link and update related attributes
+	pr_config.replay_supported = true;
+	pr_config.replay_power_opt_supported = 0;
+	pr_config.replay_enable_option |= pr_enable_option_static_screen;
+	pr_config.replay_timing_sync_supported = aconnector->max_vfreq >= 2 * aconnector->min_vfreq ? true : false;
+
+	if (!pr_config.replay_timing_sync_supported)
+		pr_config.replay_enable_option &= ~pr_enable_option_general_ui;
+
+	debug_flags = (union replay_debug_flags *)&pr_config.debug_flags;
+	debug_flags->u32All = 0;
+	debug_flags->bitfields.visual_confirm =
+		link->ctx->dc->debug.visual_confirm == VISUAL_CONFIRM_REPLAY ? true : false;
+
+	init_replay_config(link, &pr_config);
+
+	return true;
+}
+
+
+/*
+ * amdgpu_dm_replay_enable() - enable replay f/w
+ * @stream: stream state
+ *
+ * Return: true if success
+ */
+bool amdgpu_dm_replay_enable(struct dc_stream_state *stream, bool wait)
+{
+	uint64_t state;
+	unsigned int retry_count;
+	bool replay_active_request = true;
+	bool replay_active = true;
+	const unsigned int max_retry = 1000;
+	bool force_static = true;
+	struct dc_link *link = NULL;
+
+
+	if (stream == NULL)
+		return false;
+
+	link = stream->link;
+
+	if (link == NULL)
+		return false;
+
+	link->dc->link_srv->edp_setup_replay(link, stream);
+
+	replay_active_request = link->replay_settings.config.replay_enable_option;
+
+	link->dc->link_srv->edp_set_replay_allow_active(link, NULL, false, false, NULL);
+
+	link->dc->link_srv->edp_set_replay_allow_active(link, &replay_active, false, true, NULL);
+
+	if (wait == true) {
+
+		for (retry_count = 0; retry_count <= max_retry; retry_count++) {
+			dc_link_get_replay_state(link, &state);
+			if (replay_active) {
+				if (state != REPLAY_STATE_0 &&
+					(!force_static || state == REPLAY_STATE_3))
+					break;
+			} else {
+				if (state == REPLAY_STATE_0)
+					break;
+			}
+			udelay(500);
+		}
+
+		/* assert if max retry hit */
+		if (retry_count >= max_retry)
+			ASSERT(0);
+	} else {
+		/* To-do: Add trace log */
+	}
+
+	return true;
+}
+
+/*
+ * amdgpu_dm_replay_disable() - disable replay f/w
+ * @stream:  stream state
+ *
+ * Return: true if success
+ */
+bool amdgpu_dm_replay_disable(struct dc_stream_state *stream)
+{
+
+	if (stream->link) {
+		DRM_DEBUG_DRIVER("Disabling replay...\n");
+		stream->link->dc->link_srv->edp_set_replay_allow_active(stream->link, NULL, false, false, NULL);
+		return true;
+	}
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
new file mode 100644
index 000000000000..01cba3cd6246
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
@@ -0,0 +1,46 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef AMDGPU_DM_AMDGPU_DM_REPLAY_H_
+#define AMDGPU_DM_AMDGPU_DM_REPLAY_H_
+
+#include "amdgpu.h"
+
+enum replay_enable_option {
+	pr_enable_option_static_screen = 0x1,
+	pr_enable_option_mpo_video = 0x2,
+	pr_enable_option_full_screen_video = 0x4,
+	pr_enable_option_general_ui = 0x8,
+	pr_enable_option_static_screen_coasting = 0x10000,
+	pr_enable_option_mpo_video_coasting = 0x20000,
+	pr_enable_option_full_screen_video_coasting = 0x40000,
+};
+
+
+bool amdgpu_dm_replay_enable(struct dc_stream_state *stream, bool enable);
+bool amdgpu_dm_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *aconnector);
+bool amdgpu_dm_replay_disable(struct dc_stream_state *stream);
+
+#endif /* AMDGPU_DM_AMDGPU_DM_REPLAY_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 18e098568cb4..d531f980896d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -449,6 +449,11 @@ bool dc_link_setup_psr(struct dc_link *link,
 	return link->dc->link_srv->edp_setup_psr(link, stream, psr_config, psr_context);
 }
 
+bool dc_link_get_replay_state(const struct dc_link *link, uint64_t *state)
+{
+	return link->dc->link_srv->edp_get_replay_state(link, state);
+}
+
 bool dc_link_wait_for_t12(struct dc_link *link)
 {
 	return link->dc->link_srv->edp_wait_for_t12(link);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c3a41db3c91c..1ac2f305fdd5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1974,6 +1974,8 @@ bool dc_link_setup_psr(struct dc_link *dc_link,
 		const struct dc_stream_state *stream, struct psr_config *psr_config,
 		struct psr_context *psr_context);
 
+bool dc_link_get_replay_state(const struct dc_link *dc_link, uint64_t *state);
+
 /* On eDP links this function call will stall until T12 has elapsed.
  * If the panel is not in power off state, this function will return
  * immediately.
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 30349881a283..73a2b37fbbd7 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -926,6 +926,11 @@ void mod_power_calc_psr_configs(struct psr_config *psr_config,
 		!link->dpcd_caps.psr_info.psr_dpcd_caps.bits.LINK_TRAINING_ON_EXIT_NOT_REQUIRED;
 }
 
+void init_replay_config(struct dc_link *link, struct replay_config *pr_config)
+{
+	link->replay_settings.config = *pr_config;
+}
+
 bool mod_power_only_edp(const struct dc_state *context, const struct dc_stream_state *stream)
 {
 	return context && context->stream_count == 1 && dc_is_embedded_signal(stream->signal);
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index ffc924c9991b..d9e0d67d67f7 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -53,6 +53,8 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 		struct dmcu_iram_parameters params,
 		unsigned int inst);
 
+void init_replay_config(struct dc_link *link, struct replay_config *pr_config);
+
 bool is_psr_su_specific_panel(struct dc_link *link);
 void mod_power_calc_psr_configs(struct psr_config *psr_config,
 		struct dc_link *link,
-- 
2.25.1

