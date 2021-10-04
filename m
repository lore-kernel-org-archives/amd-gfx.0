Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CBFC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5530D61373
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5530D61373
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024706EA03;
	Mon,  4 Oct 2021 14:43:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2286EA03
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrWsSCdduKNNBAeV7yOAuLw2WGlST1v6Diw/ABUr02h3LeNbg7MUHBVBerOmvjZkuMvJZgTgScdmBrPtuRstWQE0jjB2nOR1bReOWAeeFX1dSj2fGp7ifssjKlQ+2xW1zWK1GkX1bNSfPFXZZ1021dWBL/XdOWR45yhqiRaaCEboypy8A602HBb9odE4jXkR8GVL1E/mGchi2mbGjXPcdk8o46s3G5xaluJx5RMobY8nlBboPBXZwXhfMTKiIVHEqDw/RDoDfEfkD7TrvomJpcFHm5acIK4AU230B4vGHnVETRX5DkzoZoftQKnsgVn4BaGEjCxrCEVZYSSa/GkSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUmd85WbCP+eROKQBKNi8Vl299J2P5rUJ7gPQ9DzpQU=;
 b=kwCf8oqia/3ZUQFDSDRVE7dwNxNyhi7Ok2DfUZr/rIz+/HLOIMPN9L+9vcfRZXIq2QFLsMcc89FzhjywQSaR99R61/uX8SLbrzpFxI4CeKwtbpsA7SXtoV2hNDKw2NEPziZfbWAx4bZU3ptNxZGUpKiW59Nc9IHz0NdpUG9Lxm6tE/4qgRXNYZd+qTWA57l+If4Yo7+waukXtKgCxQOxyA6HTU6dxenLw0a4yzAYwaJ3rEqMLEUiR9T/yUvkz71zKTyFAxj0Z7s18ZnKIJgmpzJlkm2+gIMcUh/en4mBiocitZJOtDtXD6M/u+yl28IVh18fcQ0WQyt91E+JvWkgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUmd85WbCP+eROKQBKNi8Vl299J2P5rUJ7gPQ9DzpQU=;
 b=yckQ0pR0Dso9oAGSPtWTNmszHbgdk3IDy4zCozwHTA3mX8lyeM3xkwSVRqTq94pZagjLUtwluAH2gy4Iw/FxxO3XI0q51fHAm5uJ2teuxBBP53WZslnHJ1XteBrwed0m1tZD+IHrlqGfPGyKkChh6jyUD20TfRczoE4fJ55oM2A=
Received: from BN7PR06CA0046.namprd06.prod.outlook.com (2603:10b6:408:34::23)
 by SN6PR12MB4672.namprd12.prod.outlook.com (2603:10b6:805:12::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 14:43:12 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::15) by BN7PR06CA0046.outlook.office365.com
 (2603:10b6:408:34::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend
 Transport; Mon, 4 Oct 2021 14:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:43:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:43:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 07:43:11 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:42:59 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 09/23] drm/amd/display: Implement DPIA training loop
Date: Mon, 4 Oct 2021 22:40:36 +0800
Message-ID: <20211004144050.3425351-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee0a92b7-ddef-452d-040b-08d987454ad0
X-MS-TrafficTypeDiagnostic: SN6PR12MB4672:
X-Microsoft-Antispam-PRVS: <SN6PR12MB46727C349F4E393267516F47FCAE9@SN6PR12MB4672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:152;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVC7ahnGmeS8dCp0VOuQ6YTz09BXPnklqAGnsFOTfOSyg7LPndrE+jNVDGG9CDnp51DonsblFHFMRxehgmLzICHxBgI8fNyAcIzmMMFT2+76j/QlvBkmTM4iJGpx3K8nEUzUTGPwBjb4akjNcF81iCmffJOEx3r1A9mnGuTpOoMeQdNXlEG4VmNkoSsu2zbvxVcca75K6YDSIL9wrT9MSq+CO/5sqxRhVR3rt72BAvundkeLxGtLa8kWA30aOM6mI7jtQyglveg4yQ2SQ4DremY31rKWSA3AgB8Pgz3MDeNbcwhIwmHVSVWTzttjNzf8BXymP2uGiAJ1s0ZoimWBuRfN8dEXnTVxQciYeO8zjHZhnvFOJHbGssMmmDt0+4o4rmSGvniPenesjuf9kbh+VVgRLNPMNC/x+lNrzC6HCR7L4ODn2nhe38Yxc9yEekXv3oaS8SqBkWZfGyeBAgFTPXouIMjzv4+vfGrI3vZUiAGi5622B7qewlQM/grcJnlUh1UwS0O6HVMa92B5BITy2hA31mQUMRC9Kyad4+xGisMS3G23NGzSBS8ufpfv6wYXbBOPNt1T4iIHX5kXdpA1xH/Josp421/rfJdZPZFKQ0hRHyuMvAcS09/rroNNwMhN5EH5Edjzcs6bdR75xd1J1Ue028uNID4q1OqHmfeEoKLlZQ4tITDvX5sJAhFJrLbUlPgqPIBChl0H7Zmf0Kp6ePzGGGDbfbaIxzBO1nqcXl0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(7696005)(508600001)(356005)(81166007)(70206006)(70586007)(54906003)(2906002)(36756003)(6916009)(1076003)(316002)(6666004)(47076005)(82310400003)(36860700001)(83380400001)(336012)(26005)(426003)(2616005)(8936002)(4326008)(186003)(86362001)(8676002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:43:12.6845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0a92b7-ddef-452d-040b-08d987454ad0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4672
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Training of DPIA link differs enough from that of conventional
DP link to warrant a separate implementation.

[How]
- Implement top-level of DPIA training loop.
- Make functions shared between DP and DPIA link training "public".

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  17 ---
 .../drm/amd/display/dc/core/dc_link_dpia.c    | 109 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/inc/dc_link_dpia.h |  10 ++
 drivers/gpu/drm/amd/display/dc/os_types.h     |   1 +
 4 files changed, 120 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index d7dddc0998db..7f6fd0a3bf18 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2320,23 +2320,6 @@ enum link_training_result dc_link_dp_perform_link_training(
 	return status;
 }
 
-/*
- * Train DP tunneling link for USB4 DPIA display endpoint.
- *
- * DPIA equivalent of dc_link_dp_perfrorm_link_training.
- */
-enum link_training_result dc_link_dpia_perform_link_training(struct dc_link *link,
-	const struct dc_link_settings *link_setting,
-	bool skip_video_pattern)
-{
-	enum link_training_result status;
-
-	/** @todo Always fail until USB4 DPIA training implemented. */
-	status = LINK_TRAINING_CR_FAIL_LANE0;
-
-	return status;
-}
-
 bool perform_link_training_with_retries(
 	const struct dc_link_settings *link_setting,
 	bool skip_video_pattern,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index 183601e300fe..4e9bbc9180d0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -23,12 +23,121 @@
  *
  */
 
+#include "dc.h"
 #include "dc_link_dpia.h"
 #include "inc/core_status.h"
 #include "dc_link.h"
+#include "dc_link_dp.h"
 
 enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link)
 {
 	/** @todo Read corresponding DPCD region and update link caps. */
 	return DC_OK;
 }
+
+/* Configure link as prescribed in link_setting; set LTTPR mode; and
+ * Initialize link training settings.
+ */
+static enum link_training_result dpia_configure_link(struct dc_link *link,
+		const struct dc_link_settings *link_setting,
+		struct link_training_settings *lt_settings)
+{
+	enum link_training_result result;
+
+	/** @todo Fail until implemented. */
+	result = LINK_TRAINING_ABORT;
+
+	return result;
+}
+
+/* Execute clock recovery phase of link training for specified hop in display
+ * path.
+ */
+static enum link_training_result dpia_training_cr_phase(struct dc_link *link,
+		struct link_training_settings *lt_settings,
+		uint32_t hop)
+{
+	enum link_training_result result;
+
+	/** @todo Fail until implemented. */
+	result = LINK_TRAINING_ABORT;
+
+	return result;
+}
+
+/* Execute equalization phase of link training for specified hop in display
+ * path.
+ */
+static enum link_training_result dpia_training_eq_phase(struct dc_link *link,
+		struct link_training_settings *lt_settings,
+		uint32_t hop)
+{
+	enum link_training_result result;
+
+	/** @todo Fail until implemented. */
+	result = LINK_TRAINING_ABORT;
+
+	return result;
+}
+
+/* End training of specified hop in display path. */
+static enum link_training_result dpia_training_end(struct dc_link *link,
+		uint32_t hop)
+{
+	enum link_training_result result;
+
+	/** @todo Fail until implemented. */
+	result = LINK_TRAINING_ABORT;
+
+	return result;
+}
+
+enum link_training_result dc_link_dpia_perform_link_training(struct dc_link *link,
+	const struct dc_link_settings *link_setting,
+	bool skip_video_pattern)
+{
+	enum link_training_result result;
+	struct link_training_settings lt_settings;
+	uint8_t repeater_cnt = 0; /* Number of hops/repeaters in display path. */
+	uint8_t repeater_id; /* Current hop. */
+
+	/* Configure link as prescribed in link_setting and set LTTPR mode. */
+	result = dpia_configure_link(link, link_setting, &lt_settings);
+	if (result != LINK_TRAINING_SUCCESS)
+		return result;
+
+	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
+		repeater_cnt = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+
+	/* Train each hop in turn starting with the one closest to DPTX.
+	 * In transparent or non-LTTPR mode, train only the final hop (DPRX).
+	 */
+	for (repeater_id = repeater_cnt; repeater_id >= 0; repeater_id--) {
+		/* Clock recovery. */
+		result = dpia_training_cr_phase(link, &lt_settings, repeater_id);
+		if (result != LINK_TRAINING_SUCCESS)
+			break;
+
+		/* Equalization. */
+		result = dpia_training_eq_phase(link, &lt_settings, repeater_id);
+		if (result != LINK_TRAINING_SUCCESS)
+			break;
+
+		/* Stop training hop. */
+		result = dpia_training_end(link, repeater_id);
+		if (result != LINK_TRAINING_SUCCESS)
+			break;
+	}
+
+	/* Double-check link status if training successful; gracefully stop
+	 * training of current hop if training failed for any reason other than
+	 * sink unplug.
+	 */
+	if (result == LINK_TRAINING_SUCCESS) {
+		msleep(5);
+		result = dp_check_link_loss_status(link, &lt_settings);
+	} else if (result != LINK_TRAINING_ABORT) {
+		dpia_training_end(link, repeater_id);
+	}
+	return result;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
index 8ed0c9f6414b..1392eb689d1e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
@@ -29,10 +29,20 @@
 /* This module implements functionality for training DPIA links. */
 
 struct dc_link;
+struct dc_link_settings;
 
 /* Read tunneling device capability from DPCD and update link capability
  * accordingly.
  */
 enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link);
 
+/* Train DP tunneling link for USB4 DPIA display endpoint.
+ * DPIA equivalent of dc_link_dp_perfrorm_link_training.
+ * Aborts link training upon detection of sink unplug.
+ */
+enum link_training_result
+dc_link_dpia_perform_link_training(struct dc_link *link,
+	const struct dc_link_settings *link_setting,
+	bool skip_video_pattern);
+
 #endif /* __DC_LINK_DPIA_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index f50cae252de4..415b56223bcf 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -31,6 +31,7 @@
 #include <linux/kref.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 
 #include <asm/byteorder.h>
 
-- 
2.25.1

