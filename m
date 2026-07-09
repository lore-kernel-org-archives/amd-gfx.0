Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69032C44506
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A4D10F6D5;
	Thu,  9 Jul 2026 21:02:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ulQcpwWE";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010053.outbound.protection.outlook.com
 [40.93.198.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FAD10F6D7
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4xBHtFedFN/v4U/QOKrITAL1AuDIzqZCh8L5E9g6vf700uN1wDNnC8Zb7wIIjUVU0UNL8E0xOhLcxxvkSebmZFTGMtTIMQWBoM3DdLrivEcTGviIl9DyS1gN0ad4qLeZuA5yhckgDasUck91QdGygQ/z80Yk2Z+/kA1d1D2MkQzJ7Kp6kJ3Bfdr7G79F/b/hLt8NUTTmCf9udHIuEctBB3RvnRFiCFoueHNaBwfCfePo0NqFWgRq1jZgymsKNiExXkI53CGIa9rnT/FPIbkKu6fbGOpDBLrRiBVTELiPhbmcejmpIB7OV1W/dexP43uAlcA8vvy3Jd4nQZq3qwHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVRpW6mLovKMAP5U9MQd+ugSz7XOS7ntlSpX6HlC+ig=;
 b=mGATqiqFIJcPc6mHIgFCUyYwHZQT2RhWMoAe1FE+c9CHPdViAKz76pYjdZeON28K0Gm+U0JLFeWZIsZiuJJffKqO5G43g8kHMb7ityee3lrM1Kt7q0N+j9t2AOpzPamexxkLySizBdsf+Q3A6boB412he2sum/Vw9C0G7So//yaf1nl6s/JSYHjiBhnaJfaOuK1b8LEik6ghjVM/R3wattVfey4enXF5EXuEIKvwaNii64zX6s6Hut2RRe//260XmBqdNUXzmgvMMX8oVO94gbL0Hj/4vulsz04sWEJGr4Hl7qTnx+osnVrIjhH+9+RBUba0K/Aw8/+WfAA9uAgWhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVRpW6mLovKMAP5U9MQd+ugSz7XOS7ntlSpX6HlC+ig=;
 b=ulQcpwWE0OSIZVbb4VfMYjJVG1icyegMh5UIw8eXLD4HthX6X1JCvXxlDOR7v/jxCDI0ahNxpK54EufOf/sIGpWSd0jni/UAKlMbyQCfVSlgk5X0yR0AkFwqYnbqHfAe9CSmmteFH0EEh46jiaIkjABeJ5eRrJcZMaUNJHLF26I=
Received: from BLAPR03CA0173.namprd03.prod.outlook.com (2603:10b6:208:32f::35)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 9 Jul
 2026 21:02:16 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:32f:cafe::6b) by BLAPR03CA0173.outlook.office365.com
 (2603:10b6:208:32f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:16 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:54 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 24/80] drm/amd/display: Test EDID and ACPI/VBIOS readers
Date: Thu, 9 Jul 2026 16:47:52 -0400
Message-ID: <20260709205936.5719-25-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed2a5b2-af73-41d9-c1ec-08deddfd5b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|18002099003|56012099006|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 9BxR6dalv3Dr8oYVgZD779ng0v4NRkCGyG2R3YT0inXzt82R0urPefs3yUzMUjR6rNslAcPodwxrWTwP4hONm4BrpqalECL4MWkcKkcby5BOB/3JZfGl83G9dTjS4/eaFFDiiEn3UAvXENWSvcQ4ZdXVxzWvbThpz0TRo/D5m//TD0zfPpgKxBi1hGsZ9Yev5oL6i6DIV0JPKEoGQeHToP5MJWN01jO3B6E9qxwuiLNdeoiu3oEXmT+vEmG9wGHdxG6JBfUUI2l6wHRnqo4u4dovVXa1zZ+vE4PLZP+W9CE5wSehp50waQ+LsaZtTvWs0alYFKhS10Ehe82zc4dcktyq1c+5fjnyZb1T2FDhHMs16UH+sM6LMI2RhygIPCVll531nSwajTFlnfiI4boF3hTsWlmxDuQzExIqJSCnxEy45YS3H3Eh+J7vdPsoV8ylOM87y66GQKH1tJ1cH4FY8GaB01vJcu5HtnxiTilIG8vdpFcy4N05gFQpfSeNZnrLlXqMKOsEoLOL1pVQyU1VYYndEAaudGtXzXz+8bE7HU3ZFMeZqafpBZS/GKWORGfvTxATwp/RAROyAqO4r482oG4i3c2O2djGjb/2BoNyNP6CrZNSmMJu86RXA74zgNXk+RLbEMqXj1QUclpfcbvuNoQek34OVsYR1a4BJaQgkp65FyKGEY/WxPn7IKSFEhN7MZJ5MIcpXSlct/e+YB2EuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(18002099003)(56012099006)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iLcSuDAwJ67lfSeZx/jgLwChzBc3xdZeB18loKTE2rKEVTl1w1uHNdSGX7ruiEseCYeENmoQ7nTvYNi6paiWcWEViRFx1mme213Ih7TAzb/L3f7txvXI5CpwGZ7NB27vmL8XH5JAaGU276dzvb0EcN8f1xfMaqk3qZmWDdOwMsgBa/B3qFXtnz3IlmJGlqg1gj9dPl8r2DwfdumCYH2BE4a4eeK9UoeOi799e3K2p22yNfsvXe6AVLtbYr5uSEcsehVvIl+eNoWBR36FYJf3r0B6kawSHUiYTCEuTWS2B7skZy6tk0Y3sE80i8TvLoikx28rmMeDx09z88MqFeA3zT4uC4U+58IvTr1kjIJola/InKw3bgXJtrG1GEJz95CcY/Zy7sKoB8BgVNf0ZEwc3y3R4LRpGOgHUdjGyuJ3Hq9Hm+vbA7cLqVmLzsA3dIYs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:16.0651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed2a5b2-af73-41d9-c1ec-08deddfd5b47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add KUnit coverage for the EDID parsing helpers edid_extract_panel_id,
apply_edid_quirks and dm_helpers_parse_edid_caps, together with the
ACPI/VBIOS EDID readers dm_helpers_probe_acpi_edid,
dm_helpers_read_acpi_edid and dm_helpers_read_vbios_hardcoded_edid.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  27 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.h |  19 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 727 ++++++++++++++++++
 3 files changed, 769 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 9c4e0a4e251c..881518a861d5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -98,7 +98,7 @@ STATIC_IFN_KUNIT u32 edid_extract_panel_id(struct edid *edid)
 }
 EXPORT_IF_KUNIT(edid_extract_panel_id);

-static void apply_edid_quirks(struct dc_link *link, struct edid *edid,
+STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 			      struct dc_edid_caps *edid_caps)
 {
 	struct amdgpu_dm_connector *aconnector = link->priv;
@@ -141,6 +141,7 @@ static void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 		return;
 	}
 }
+EXPORT_IF_KUNIT(apply_edid_quirks);

 /**
  * dm_helpers_parse_edid_caps() - Parse edid caps
@@ -237,6 +238,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(

 	return result;
 }
+EXPORT_IF_KUNIT(dm_helpers_parse_edid_caps);

 static void
 fill_dc_mst_payload_table_from_drm(struct dc_link *link,
@@ -979,6 +981,20 @@ bool dm_helpers_dp_write_dsc_enable(
 	return ret;
 }

+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+uint dm_helpers_get_dc_debug_mask(void)
+{
+	return amdgpu_dc_debug_mask;
+}
+EXPORT_IF_KUNIT(dm_helpers_get_dc_debug_mask);
+
+void dm_helpers_set_dc_debug_mask(uint debug_mask)
+{
+	amdgpu_dc_debug_mask = debug_mask;
+}
+EXPORT_IF_KUNIT(dm_helpers_set_dc_debug_mask);
+#endif
+
 bool dm_helpers_dp_write_hblank_reduction(struct dc_context *ctx, const struct dc_stream_state *stream)
 {
 	// TODO
@@ -1002,7 +1018,7 @@ bool dm_helpers_is_dp_sink_present(struct dc_link *link)
 	return dp_sink_present;
 }

-static int
+STATIC_IFN_KUNIT int
 dm_helpers_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len)
 {
 	struct drm_connector *connector = data;
@@ -1040,8 +1056,9 @@ dm_helpers_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len)

 	return r;
 }
+EXPORT_IF_KUNIT(dm_helpers_probe_acpi_edid);

-static const struct drm_edid *
+STATIC_IFN_KUNIT const struct drm_edid *
 dm_helpers_read_acpi_edid(struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
@@ -1062,8 +1079,9 @@ dm_helpers_read_acpi_edid(struct amdgpu_dm_connector *aconnector)

 	return drm_edid_read_custom(connector, dm_helpers_probe_acpi_edid, connector);
 }
+EXPORT_IF_KUNIT(dm_helpers_read_acpi_edid);

-static const struct drm_edid *
+STATIC_IFN_KUNIT const struct drm_edid *
 dm_helpers_read_vbios_hardcoded_edid(struct dc_link *link, struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_bios *bios = link->ctx->dc_bios;
@@ -1101,6 +1119,7 @@ dm_helpers_read_vbios_hardcoded_edid(struct dc_link *link, struct amdgpu_dm_conn

 	return edid;
 }
+EXPORT_IF_KUNIT(dm_helpers_read_vbios_hardcoded_edid);

 STATIC_IFN_KUNIT uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_per_lane)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
index 2ac9762895ec..e5cbcd425847 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
@@ -9,12 +9,31 @@
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 #include <drm/drm_edid.h>

+struct amdgpu_dm_connector;
+struct dc_link;
+struct dc_context;
+struct dc_stream_state;
+struct dc_edid_caps;
+struct dc_dp_mst_stream_allocation_table;
+struct drm_dp_aux;
+struct drm_dp_mst_atomic_payload;
+struct drm_dp_mst_topology_mgr;
+struct drm_dp_mst_topology_state;
+
 /* Exported for KUnit testing */
 u32 edid_extract_panel_id(struct edid *edid);
+void apply_edid_quirks(struct dc_link *link, struct edid *edid,
+		       struct dc_edid_caps *edid_caps);
 uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_per_lane);
 bool dm_is_freesync_pcon_whitelist(const uint32_t branch_dev_id);
 extern const uint32_t dm_freesync_pcon_whitelist[];
 uint32_t dm_freesync_pcon_whitelist_count(void);
+uint dm_helpers_get_dc_debug_mask(void);
+void dm_helpers_set_dc_debug_mask(uint debug_mask);
+int dm_helpers_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len);
+const struct drm_edid *dm_helpers_read_acpi_edid(struct amdgpu_dm_connector *aconnector);
+const struct drm_edid *dm_helpers_read_vbios_hardcoded_edid(struct dc_link *link,
+							    struct amdgpu_dm_connector *aconnector);
 #endif /* CONFIG_DRM_AMD_DC_KUNIT_TEST */

 #endif /* __AMDGPU_DM_HELPERS_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 33014a2d2222..3766d8d211e4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -8,13 +8,18 @@
 #include <kunit/test.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_kunit_helpers.h>
+#include <drm/display/drm_dp_mst_helper.h>

 #include "dc.h"
+#include "core_types.h"
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
+#include "amdgpu_dm_mst_types.h"
+#include "dc_bios_types.h"
 #include "dm_helpers.h"
 #include "ddc_service_types.h"
+#include "dmub_cmd.h"
 #include "amdgpu_dm_helpers.h"
 #include "amdgpu_dm_kunit_test_helpers.h"

@@ -61,6 +66,701 @@ static void dm_test_edid_extract_panel_id_zeros(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, edid_extract_panel_id(edid), 0U);
 }

+/* Tests for apply_edid_quirks() */
+
+/*
+ * Build an EDID whose extracted panel id equals @panel_id. Inverse of
+ * edid_extract_panel_id(): mfg_id holds the top 16 bits, prod_code the
+ * low 16 bits (prod_code[0] | prod_code[1] << 8).
+ */
+static struct edid *dm_test_edid_with_panel_id(struct kunit *test, u32 panel_id)
+{
+	struct edid *edid;
+
+	edid = kunit_kzalloc(test, sizeof(*edid), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, edid);
+
+	edid->mfg_id[0] = (panel_id >> 24) & 0xff;
+	edid->mfg_id[1] = (panel_id >> 16) & 0xff;
+	edid->prod_code[0] = panel_id & 0xff;
+	edid->prod_code[1] = (panel_id >> 8) & 0xff;
+
+	return edid;
+}
+
+/*
+ * Wire a connector-backed link so apply_edid_quirks() can resolve
+ * link->priv->base.dev for its drm_dbg_driver() calls.
+ */
+static struct dc_link *dm_test_quirk_link(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_device *adev;
+	struct dc_link *link;
+
+	adev = dm_kunit_alloc_adev(test);
+	link = dm_kunit_alloc_link(test);
+	aconnector = dm_kunit_alloc_connector(test, adev, NULL);
+	link->priv = aconnector;
+
+	return link;
+}
+
+/**
+ * dm_test_apply_edid_quirks_dpcd_poweroff_delay - Test GBT 0x3215 delay quirk
+ * @test: The KUnit test context
+ */
+static void dm_test_apply_edid_quirks_dpcd_poweroff_delay(struct kunit *test)
+{
+	struct dc_edid_caps edid_caps = {0};
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct edid *edid = dm_test_edid_with_panel_id(test,
+			drm_edid_encode_panel_id('G', 'B', 'T', 0x3215));
+
+	apply_edid_quirks(link, edid, &edid_caps);
+
+	KUNIT_EXPECT_EQ(test, edid_caps.panel_patch.wait_after_dpcd_poweroff_ms, 10000U);
+}
+
+/**
+ * dm_test_apply_edid_quirks_disable_fams - Test SAM panel FAMS-disable quirk
+ * @test: The KUnit test context
+ */
+static void dm_test_apply_edid_quirks_disable_fams(struct kunit *test)
+{
+	struct dc_edid_caps edid_caps = {0};
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct edid *edid = dm_test_edid_with_panel_id(test,
+			drm_edid_encode_panel_id('S', 'A', 'M', 0x0E5E));
+
+	apply_edid_quirks(link, edid, &edid_caps);
+
+	KUNIT_EXPECT_TRUE(test, edid_caps.panel_patch.disable_fams);
+}
+
+/**
+ * dm_test_apply_edid_quirks_remove_sink_ext_caps - Test AUO 0x317 clear quirk
+ * @test: The KUnit test context
+ */
+static void dm_test_apply_edid_quirks_remove_sink_ext_caps(struct kunit *test)
+{
+	struct dc_edid_caps edid_caps = {0};
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct edid *edid = dm_test_edid_with_panel_id(test,
+			drm_edid_encode_panel_id('A', 'U', 'O', 0xA7AB));
+
+	apply_edid_quirks(link, edid, &edid_caps);
+
+	KUNIT_EXPECT_TRUE(test, edid_caps.panel_patch.remove_sink_ext_caps);
+}
+
+/**
+ * dm_test_apply_edid_quirks_disable_colorimetry - Test SDC VSC-disable quirk
+ * @test: The KUnit test context
+ */
+static void dm_test_apply_edid_quirks_disable_colorimetry(struct kunit *test)
+{
+	struct dc_edid_caps edid_caps = {0};
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct edid *edid = dm_test_edid_with_panel_id(test,
+			drm_edid_encode_panel_id('S', 'D', 'C', 0x4154));
+
+	apply_edid_quirks(link, edid, &edid_caps);
+
+	KUNIT_EXPECT_TRUE(test, edid_caps.panel_patch.disable_colorimetry);
+}
+
+/**
+ * dm_test_apply_edid_quirks_skip_phy_ssc - Test DEL 0x4147 PHY SSC quirk
+ * @test: The KUnit test context
+ */
+static void dm_test_apply_edid_quirks_skip_phy_ssc(struct kunit *test)
+{
+	struct dc_edid_caps edid_caps = {0};
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct edid *edid = dm_test_edid_with_panel_id(test,
+			drm_edid_encode_panel_id('D', 'E', 'L', 0x4147));
+
+	apply_edid_quirks(link, edid, &edid_caps);
+
+	KUNIT_EXPECT_TRUE(test, link->wa_flags.skip_phy_ssc_reduction);
+}
+
+/**
+ * dm_test_apply_edid_quirks_unknown_noop - Test unknown panel id is a no-op
+ * @test: The KUnit test context
+ */
+static void dm_test_apply_edid_quirks_unknown_noop(struct kunit *test)
+{
+	struct dc_edid_caps edid_caps = {0};
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct edid *edid = dm_test_edid_with_panel_id(test,
+			drm_edid_encode_panel_id('X', 'Y', 'Z', 0x0000));
+
+	apply_edid_quirks(link, edid, &edid_caps);
+
+	/* default: branch leaves every quirk field untouched */
+	KUNIT_EXPECT_EQ(test, edid_caps.panel_patch.wait_after_dpcd_poweroff_ms, 0U);
+	KUNIT_EXPECT_FALSE(test, edid_caps.panel_patch.disable_fams);
+	KUNIT_EXPECT_FALSE(test, edid_caps.panel_patch.remove_sink_ext_caps);
+	KUNIT_EXPECT_FALSE(test, edid_caps.panel_patch.disable_colorimetry);
+	KUNIT_EXPECT_FALSE(test, link->wa_flags.skip_phy_ssc_reduction);
+}
+
+/* Tests for dm_helpers_parse_edid_caps() */
+
+/*
+ * Build a minimal valid base EDID block into @dc_edid. When @good_checksum is
+ * false the final checksum byte is corrupted so drm_edid_is_valid() fails.
+ *
+ *   manufacturer_id = 0xAC10, product_id = 0x1234, serial = 0x12345678,
+ *   week = 10, year (raw) = 30, digital input, no CEA extension.
+ */
+static void dm_test_fill_base_edid(struct dc_edid *dc_edid, bool good_checksum)
+{
+	static const u8 header[8] = {
+		0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00
+	};
+	u8 *raw = dc_edid->raw_edid;
+	int sum = 0;
+	int i;
+
+	memset(raw, 0, EDID_LENGTH);
+	memcpy(raw, header, sizeof(header));
+
+	raw[8] = 0x10;	raw[9] = 0xAC;		/* mfg_id    -> 0xAC10 */
+	raw[10] = 0x34;	raw[11] = 0x12;		/* prod_code -> 0x1234 */
+	raw[12] = 0x78;	raw[13] = 0x56;		/* serial    -> 0x12345678 */
+	raw[14] = 0x34;	raw[15] = 0x12;
+	raw[16] = 10;				/* mfg_week */
+	raw[17] = 30;				/* mfg_year (raw) */
+	raw[18] = 1;				/* version */
+	raw[19] = 4;				/* revision */
+	raw[20] = DRM_EDID_INPUT_DIGITAL;	/* digital input */
+	raw[126] = 0;				/* no extensions */
+
+	for (i = 0; i < EDID_LENGTH - 1; i++)
+		sum += raw[i];
+	raw[127] = (256 - (sum % 256)) % 256;
+	if (!good_checksum)
+		raw[127] ^= 0xFF;		/* corrupt checksum */
+
+	dc_edid->length = EDID_LENGTH;
+}
+
+/**
+ * dm_test_parse_edid_caps_null_edid - Test NULL edid returns EDID_BAD_INPUT
+ * @test: The KUnit test context
+ */
+static void dm_test_parse_edid_caps_null_edid(struct kunit *test)
+{
+	struct dc_edid_caps edid_caps = {0};
+	struct dc_link *link = dm_test_quirk_link(test);
+
+	KUNIT_EXPECT_EQ(test, dm_helpers_parse_edid_caps(link, NULL, &edid_caps), EDID_BAD_INPUT);
+}
+
+/**
+ * dm_test_parse_edid_caps_null_caps - Test NULL edid_caps returns EDID_BAD_INPUT
+ * @test: The KUnit test context
+ */
+static void dm_test_parse_edid_caps_null_caps(struct kunit *test)
+{
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct dc_edid *dc_edid;
+
+	dc_edid = kunit_kzalloc(test, sizeof(*dc_edid), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_edid);
+	dm_test_fill_base_edid(dc_edid, true);
+
+	KUNIT_EXPECT_EQ(test, dm_helpers_parse_edid_caps(link, dc_edid, NULL), EDID_BAD_INPUT);
+}
+
+/**
+ * dm_test_parse_edid_caps_valid - Test field extraction from a valid EDID
+ * @test: The KUnit test context
+ */
+static void dm_test_parse_edid_caps_valid(struct kunit *test)
+{
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct dc_edid_caps *edid_caps;
+	struct dc_edid *dc_edid;
+
+	dc_edid = kunit_kzalloc(test, sizeof(*dc_edid), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_edid);
+	edid_caps = kunit_kzalloc(test, sizeof(*edid_caps), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, edid_caps);
+
+	dm_test_fill_base_edid(dc_edid, true);
+
+	KUNIT_EXPECT_EQ(test, dm_helpers_parse_edid_caps(link, dc_edid, edid_caps), EDID_OK);
+	KUNIT_EXPECT_EQ(test, edid_caps->manufacturer_id, 0xAC10);
+	KUNIT_EXPECT_EQ(test, edid_caps->product_id, 0x1234);
+	KUNIT_EXPECT_EQ(test, edid_caps->serial_number, 0x12345678U);
+	KUNIT_EXPECT_EQ(test, edid_caps->manufacture_week, 10);
+	KUNIT_EXPECT_EQ(test, edid_caps->manufacture_year, 30);
+	KUNIT_EXPECT_FALSE(test, edid_caps->analog);
+}
+
+/**
+ * dm_test_parse_edid_caps_bad_checksum - Test bad checksum still parses fields
+ * @test: The KUnit test context
+ */
+static void dm_test_parse_edid_caps_bad_checksum(struct kunit *test)
+{
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct dc_edid_caps *edid_caps;
+	struct dc_edid *dc_edid;
+
+	dc_edid = kunit_kzalloc(test, sizeof(*dc_edid), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_edid);
+	edid_caps = kunit_kzalloc(test, sizeof(*edid_caps), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, edid_caps);
+
+	dm_test_fill_base_edid(dc_edid, false);
+
+	/* Invalid checksum -> EDID_BAD_CHECKSUM but fields are still parsed */
+	KUNIT_EXPECT_EQ(test,
+			dm_helpers_parse_edid_caps(link, dc_edid, edid_caps),
+			EDID_BAD_CHECKSUM);
+	KUNIT_EXPECT_EQ(test, edid_caps->manufacturer_id, 0xAC10);
+	KUNIT_EXPECT_EQ(test, edid_caps->product_id, 0x1234);
+}
+
+/**
+ * dm_test_parse_edid_caps_hdmi_frl - Test HDMI/FRL branch via connector info
+ * @test: The KUnit test context
+ *
+ * Drives the edid_caps->edid_hdmi path by marking the connector as HDMI and
+ * providing a fake dc with FRL enabled, so populate_hdmi_info_from_connector()
+ * is exercised inside dm_helpers_parse_edid_caps().
+ */
+static void dm_test_parse_edid_caps_hdmi_frl(struct kunit *test)
+{
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct amdgpu_dm_connector *aconnector = link->priv;
+	struct drm_connector *connector = &aconnector->base;
+	struct dc_edid_caps *edid_caps;
+	struct dc_edid *dc_edid;
+	struct dc *dc;
+
+	dc_edid = kunit_kzalloc(test, sizeof(*dc_edid), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_edid);
+	edid_caps = kunit_kzalloc(test, sizeof(*edid_caps), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, edid_caps);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+
+	link->dc = dc;
+	dc->config.enable_frl = true;
+
+	dm_test_fill_base_edid(dc_edid, true);
+
+	/* Drive the HDMI/FRL branch */
+	connector->display_info.is_hdmi = true;
+	connector->display_info.hdmi.scdc.supported = true;
+	connector->display_info.hdmi.max_lanes = 4;
+	connector->display_info.hdmi.max_frl_rate_per_lane = 12;
+
+	KUNIT_EXPECT_EQ(test, dm_helpers_parse_edid_caps(link, dc_edid, edid_caps), EDID_OK);
+	KUNIT_EXPECT_TRUE(test, edid_caps->edid_hdmi);
+	KUNIT_EXPECT_TRUE(test, edid_caps->scdc_present);
+	/* max_lanes 4 + max_frl_rate_per_lane 12 -> rate index 6 */
+	KUNIT_EXPECT_EQ(test, edid_caps->max_frl_rate, 6);
+}
+
+/**
+ * dm_test_parse_edid_caps_hdmi_frl_dsc - Test HDMI FRL DSC sub-branch
+ * @test: The KUnit test context
+ *
+ * Sets the connector's HDMI DSC capability so populate_hdmi_info_from_connector()
+ * reports frl_dsc_support, exercising the frl_dsc_support log path.
+ */
+static void dm_test_parse_edid_caps_hdmi_frl_dsc(struct kunit *test)
+{
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct amdgpu_dm_connector *aconnector = link->priv;
+	struct drm_connector *connector = &aconnector->base;
+	struct dc_edid_caps *edid_caps;
+	struct dc_edid *dc_edid;
+	struct dc *dc;
+
+	dc_edid = kunit_kzalloc(test, sizeof(*dc_edid), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_edid);
+	edid_caps = kunit_kzalloc(test, sizeof(*edid_caps), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, edid_caps);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+
+	link->dc = dc;
+	dc->config.enable_frl = true;
+
+	dm_test_fill_base_edid(dc_edid, true);
+
+	connector->display_info.is_hdmi = true;
+	/* Drive the frl_dsc_support sub-branch */
+	connector->display_info.hdmi.dsc_cap.v_1p2 = true;
+	connector->display_info.hdmi.dsc_cap.bpc_supported = 10;
+
+	KUNIT_EXPECT_EQ(test, dm_helpers_parse_edid_caps(link, dc_edid, edid_caps), EDID_OK);
+	KUNIT_EXPECT_TRUE(test, edid_caps->frl_dsc_support);
+	KUNIT_EXPECT_TRUE(test, edid_caps->frl_dsc_10bpc);
+}
+
+/*
+ * Build a 2-block EDID: a valid base block plus a CTA-861 extension block
+ * carrying one LPCM Short Audio Descriptor and, when @with_speaker is set, a
+ * Speaker Allocation Data Block, so the audio/speaker parsing code is
+ * exercised.
+ */
+static void dm_test_fill_cea_edid(struct dc_edid *dc_edid, bool with_speaker)
+{
+	u8 *raw = dc_edid->raw_edid;
+	u8 *ext = raw + EDID_LENGTH;
+	u8 dtd_offset;
+	int sum = 0;
+	int i;
+
+	/* Base block, flagged as having one extension */
+	dm_test_fill_base_edid(dc_edid, true);
+	raw[126] = 1;
+	for (i = 0; i < EDID_LENGTH - 1; i++)
+		sum += raw[i];
+	raw[127] = (256 - (sum % 256)) % 256;
+
+	/* Audio DB spans [4,7]; optional Speaker Alloc DB spans [8,11] */
+	dtd_offset = with_speaker ? 12 : 8;
+
+	/* CTA-861 extension block */
+	memset(ext, 0, EDID_LENGTH);
+	ext[0] = 0x02;			/* CTA extension tag */
+	ext[1] = 0x03;			/* revision 3 */
+	ext[2] = dtd_offset;		/* DTD offset; end of data blocks */
+	ext[3] = 0x00;			/* no native DTDs / feature flags */
+	/* Audio Data Block: tag 1, length 3, one LPCM SAD */
+	ext[4] = (1 << 5) | 3;
+	ext[5] = (1 << 3) | 1;		/* format 1 (LPCM), 2 channels */
+	ext[6] = 0x07;			/* 32 / 44.1 / 48 kHz */
+	ext[7] = 0x07;			/* 16 / 20 / 24-bit */
+	if (with_speaker) {
+		/* Speaker Allocation Data Block: tag 4, length 3 */
+		ext[8] = (4 << 5) | 3;
+		ext[9] = 0x01;		/* front left / front right */
+	}
+
+	sum = 0;
+	for (i = 0; i < EDID_LENGTH - 1; i++)
+		sum += ext[i];
+	ext[127] = (256 - (sum % 256)) % 256;
+
+	dc_edid->length = 2 * EDID_LENGTH;
+}
+
+/**
+ * dm_test_parse_edid_caps_cea_audio - Test CEA audio/speaker block parsing
+ * @test: The KUnit test context
+ */
+static void dm_test_parse_edid_caps_cea_audio(struct kunit *test)
+{
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct dc_edid_caps *edid_caps;
+	struct dc_edid *dc_edid;
+
+	dc_edid = kunit_kzalloc(test, sizeof(*dc_edid), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_edid);
+	edid_caps = kunit_kzalloc(test, sizeof(*edid_caps), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, edid_caps);
+
+	dm_test_fill_cea_edid(dc_edid, true);
+
+	KUNIT_EXPECT_EQ(test, dm_helpers_parse_edid_caps(link, dc_edid, edid_caps), EDID_OK);
+	KUNIT_EXPECT_EQ(test, edid_caps->audio_mode_count, 1);
+	KUNIT_EXPECT_EQ(test, edid_caps->audio_modes[0].format_code, 1);
+	KUNIT_EXPECT_EQ(test, edid_caps->audio_modes[0].channel_count, 2);
+	KUNIT_EXPECT_EQ(test, edid_caps->audio_modes[0].sample_rate, 0x07);
+	KUNIT_EXPECT_EQ(test, edid_caps->audio_modes[0].sample_size, 0x07);
+	KUNIT_EXPECT_EQ(test, edid_caps->speaker_flags, 0x01);
+}
+
+/**
+ * dm_test_parse_edid_caps_cea_no_speaker - Test default speaker flags path
+ * @test: The KUnit test context
+ *
+ * Audio data block present but no Speaker Allocation Data Block, so
+ * speaker_flags falls back to DEFAULT_SPEAKER_LOCATION.
+ */
+static void dm_test_parse_edid_caps_cea_no_speaker(struct kunit *test)
+{
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct dc_edid_caps *edid_caps;
+	struct dc_edid *dc_edid;
+
+	dc_edid = kunit_kzalloc(test, sizeof(*dc_edid), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_edid);
+	edid_caps = kunit_kzalloc(test, sizeof(*edid_caps), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, edid_caps);
+
+	dm_test_fill_cea_edid(dc_edid, false);
+
+	KUNIT_EXPECT_EQ(test, dm_helpers_parse_edid_caps(link, dc_edid, edid_caps), EDID_OK);
+	KUNIT_EXPECT_EQ(test, edid_caps->audio_mode_count, 1);
+	KUNIT_EXPECT_EQ(test, edid_caps->speaker_flags, DEFAULT_SPEAKER_LOCATION);
+}
+
+/* Tests for ACPI and VBIOS EDID readers */
+
+/**
+ * dm_test_probe_acpi_edid_no_companion - Test ACPI probe without companion
+ * @test: The KUnit test context
+ */
+static void dm_test_probe_acpi_edid_no_companion(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_device *adev;
+	u8 buf[EDID_LENGTH] = {0};
+
+	adev = dm_kunit_alloc_adev(test);
+	aconnector = dm_kunit_alloc_connector(test, adev, NULL);
+
+	KUNIT_EXPECT_EQ(test,
+			dm_helpers_probe_acpi_edid(&aconnector->base, buf, 0, sizeof(buf)),
+			-ENODEV);
+}
+
+/**
+ * dm_test_read_acpi_edid_debug_mask_disabled - Test debug mask early return
+ * @test: The KUnit test context
+ */
+static void dm_test_read_acpi_edid_debug_mask_disabled(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_device *adev;
+	uint old_debug_mask;
+
+	adev = dm_kunit_alloc_adev(test);
+	aconnector = dm_kunit_alloc_connector(test, adev, NULL);
+	old_debug_mask = dm_helpers_get_dc_debug_mask();
+
+	dm_helpers_set_dc_debug_mask(old_debug_mask | DC_DISABLE_ACPI_EDID);
+	KUNIT_EXPECT_NULL(test, dm_helpers_read_acpi_edid(aconnector));
+	dm_helpers_set_dc_debug_mask(old_debug_mask);
+}
+
+/**
+ * dm_test_read_acpi_edid_non_panel_connector - Test non-panel connector skip
+ * @test: The KUnit test context
+ */
+static void dm_test_read_acpi_edid_non_panel_connector(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	aconnector = dm_kunit_alloc_connector(test, adev, NULL);
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
+
+	KUNIT_EXPECT_NULL(test, dm_helpers_read_acpi_edid(aconnector));
+}
+
+/**
+ * dm_test_read_acpi_edid_force_off - Test forced-off connector skip
+ * @test: The KUnit test context
+ */
+static void dm_test_read_acpi_edid_force_off(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	aconnector = dm_kunit_alloc_connector(test, adev, NULL);
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_eDP;
+	aconnector->base.force = DRM_FORCE_OFF;
+
+	KUNIT_EXPECT_NULL(test, dm_helpers_read_acpi_edid(aconnector));
+}
+
+struct dm_test_vbios_edid {
+	struct dc_bios bios;
+	enum bp_result result;
+	const u8 *fake_edid;
+	u16 fake_edid_size;
+	u16 width_mm;
+	u16 height_mm;
+};
+
+static enum bp_result dm_test_get_embedded_panel_info(struct dc_bios *bios,
+						      struct embedded_panel_info *info)
+{
+	struct dm_test_vbios_edid *fixture;
+
+	fixture = container_of(bios, struct dm_test_vbios_edid, bios);
+	if (fixture->result != BP_RESULT_OK)
+		return fixture->result;
+
+	info->fake_edid = fixture->fake_edid;
+	info->fake_edid_size = fixture->fake_edid_size;
+	info->panel_width_mm = fixture->width_mm;
+	info->panel_height_mm = fixture->height_mm;
+
+	return BP_RESULT_OK;
+}
+
+static const struct dc_vbios_funcs dm_test_vbios_edid_funcs = {
+	.get_embedded_panel_info = dm_test_get_embedded_panel_info,
+};
+
+static void dm_test_setup_vbios_link(struct kunit *test,
+				     struct dc_link **link_out,
+				     struct amdgpu_dm_connector **aconnector_out,
+				     struct dm_test_vbios_edid **fixture_out)
+{
+	struct dm_test_vbios_edid *fixture;
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_link *link;
+
+	adev = dm_kunit_alloc_adev(test);
+	link = dm_kunit_alloc_link(test);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	fixture = kunit_kzalloc(test, sizeof(*fixture), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture);
+	aconnector = dm_kunit_alloc_connector(test, adev, link);
+
+	fixture->bios.funcs = &dm_test_vbios_edid_funcs;
+	fixture->result = BP_RESULT_OK;
+	ctx->dc_bios = &fixture->bios;
+	link->ctx = ctx;
+	link->priv = aconnector;
+	link->connector_signal = SIGNAL_TYPE_EDP;
+
+	*link_out = link;
+	*aconnector_out = aconnector;
+	*fixture_out = fixture;
+}
+
+/**
+ * dm_test_read_vbios_edid_non_embedded - Test non-embedded signal skip
+ * @test: The KUnit test context
+ */
+static void dm_test_read_vbios_edid_non_embedded(struct kunit *test)
+{
+	struct dm_test_vbios_edid *fixture;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+
+	dm_test_setup_vbios_link(test, &link, &aconnector, &fixture);
+	link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+
+	KUNIT_EXPECT_NULL(test,
+			  dm_helpers_read_vbios_hardcoded_edid(link, aconnector));
+}
+
+/**
+ * dm_test_read_vbios_edid_missing_callback - Test missing callback skip
+ * @test: The KUnit test context
+ */
+static void dm_test_read_vbios_edid_missing_callback(struct kunit *test)
+{
+	static const struct dc_vbios_funcs empty_funcs;
+	struct dm_test_vbios_edid *fixture;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+
+	dm_test_setup_vbios_link(test, &link, &aconnector, &fixture);
+	fixture->bios.funcs = &empty_funcs;
+
+	KUNIT_EXPECT_NULL(test,
+			  dm_helpers_read_vbios_hardcoded_edid(link, aconnector));
+}
+
+/**
+ * dm_test_read_vbios_edid_callback_error - Test callback failure skip
+ * @test: The KUnit test context
+ */
+static void dm_test_read_vbios_edid_callback_error(struct kunit *test)
+{
+	struct dm_test_vbios_edid *fixture;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+
+	dm_test_setup_vbios_link(test, &link, &aconnector, &fixture);
+	fixture->result = BP_RESULT_BADINPUT;
+
+	KUNIT_EXPECT_NULL(test,
+			  dm_helpers_read_vbios_hardcoded_edid(link, aconnector));
+}
+
+/**
+ * dm_test_read_vbios_edid_missing_fake_edid - Test missing fake EDID skip
+ * @test: The KUnit test context
+ */
+static void dm_test_read_vbios_edid_missing_fake_edid(struct kunit *test)
+{
+	struct dm_test_vbios_edid *fixture;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+
+	dm_test_setup_vbios_link(test, &link, &aconnector, &fixture);
+	fixture->fake_edid = NULL;
+	fixture->fake_edid_size = 0;
+
+	KUNIT_EXPECT_NULL(test,
+			  dm_helpers_read_vbios_hardcoded_edid(link, aconnector));
+}
+
+/**
+ * dm_test_read_vbios_edid_invalid_fake_edid - Test invalid fake EDID skip
+ * @test: The KUnit test context
+ */
+static void dm_test_read_vbios_edid_invalid_fake_edid(struct kunit *test)
+{
+	struct dm_test_vbios_edid *fixture;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_edid *dc_edid;
+	struct dc_link *link;
+
+	dm_test_setup_vbios_link(test, &link, &aconnector, &fixture);
+	dc_edid = kunit_kzalloc(test, sizeof(*dc_edid), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_edid);
+	dm_test_fill_base_edid(dc_edid, false);
+	fixture->fake_edid = dc_edid->raw_edid;
+	fixture->fake_edid_size = EDID_LENGTH;
+
+	KUNIT_EXPECT_NULL(test,
+			  dm_helpers_read_vbios_hardcoded_edid(link, aconnector));
+}
+
+/**
+ * dm_test_read_vbios_edid_valid - Test valid fake EDID updates display size
+ * @test: The KUnit test context
+ */
+static void dm_test_read_vbios_edid_valid(struct kunit *test)
+{
+	struct dm_test_vbios_edid *fixture;
+	struct amdgpu_dm_connector *aconnector;
+	const struct drm_edid *edid;
+	struct dc_edid *dc_edid;
+	struct dc_link *link;
+
+	dm_test_setup_vbios_link(test, &link, &aconnector, &fixture);
+	dc_edid = kunit_kzalloc(test, sizeof(*dc_edid), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_edid);
+	dm_test_fill_base_edid(dc_edid, true);
+	fixture->fake_edid = dc_edid->raw_edid;
+	fixture->fake_edid_size = EDID_LENGTH;
+	fixture->width_mm = 301;
+	fixture->height_mm = 201;
+
+	edid = dm_helpers_read_vbios_hardcoded_edid(link, aconnector);
+
+	KUNIT_ASSERT_NOT_NULL(test, edid);
+	KUNIT_EXPECT_EQ(test, aconnector->base.display_info.width_mm, 301U);
+	KUNIT_EXPECT_EQ(test, aconnector->base.display_info.height_mm, 201U);
+	drm_edid_free(edid);
+}
+
 /* Tests for dm_is_freesync_pcon_whitelist() */

 /**
@@ -581,6 +1281,33 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	/* edid_extract_panel_id */
 	KUNIT_CASE(dm_test_edid_extract_panel_id_basic),
 	KUNIT_CASE(dm_test_edid_extract_panel_id_zeros),
+	/* apply_edid_quirks */
+	KUNIT_CASE(dm_test_apply_edid_quirks_dpcd_poweroff_delay),
+	KUNIT_CASE(dm_test_apply_edid_quirks_disable_fams),
+	KUNIT_CASE(dm_test_apply_edid_quirks_remove_sink_ext_caps),
+	KUNIT_CASE(dm_test_apply_edid_quirks_disable_colorimetry),
+	KUNIT_CASE(dm_test_apply_edid_quirks_skip_phy_ssc),
+	KUNIT_CASE(dm_test_apply_edid_quirks_unknown_noop),
+	/* dm_helpers_parse_edid_caps */
+	KUNIT_CASE(dm_test_parse_edid_caps_null_edid),
+	KUNIT_CASE(dm_test_parse_edid_caps_null_caps),
+	KUNIT_CASE(dm_test_parse_edid_caps_valid),
+	KUNIT_CASE(dm_test_parse_edid_caps_bad_checksum),
+	KUNIT_CASE(dm_test_parse_edid_caps_hdmi_frl),
+	KUNIT_CASE(dm_test_parse_edid_caps_hdmi_frl_dsc),
+	KUNIT_CASE(dm_test_parse_edid_caps_cea_audio),
+	KUNIT_CASE(dm_test_parse_edid_caps_cea_no_speaker),
+	/* ACPI / VBIOS / local EDID readers */
+	KUNIT_CASE(dm_test_probe_acpi_edid_no_companion),
+	KUNIT_CASE(dm_test_read_acpi_edid_debug_mask_disabled),
+	KUNIT_CASE(dm_test_read_acpi_edid_non_panel_connector),
+	KUNIT_CASE(dm_test_read_acpi_edid_force_off),
+	KUNIT_CASE(dm_test_read_vbios_edid_non_embedded),
+	KUNIT_CASE(dm_test_read_vbios_edid_missing_callback),
+	KUNIT_CASE(dm_test_read_vbios_edid_callback_error),
+	KUNIT_CASE(dm_test_read_vbios_edid_missing_fake_edid),
+	KUNIT_CASE(dm_test_read_vbios_edid_invalid_fake_edid),
+	KUNIT_CASE(dm_test_read_vbios_edid_valid),
 	/* dm_is_freesync_pcon_whitelist */
 	KUNIT_CASE(dm_test_freesync_pcon_whitelist_all_known),
 	KUNIT_CASE(dm_test_freesync_pcon_whitelist_not_in_list),
--
2.55.0

