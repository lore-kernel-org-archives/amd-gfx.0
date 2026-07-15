Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41371C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D525C10F09D;
	Wed, 15 Jul 2026 13:48:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QOoumfVN";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012011.outbound.protection.outlook.com
 [40.107.200.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3697810F09D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:48:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xp5jlSpeGAbc8obzPTonAenDcx7/VZ4RXPAZvsFgHcj5he8r5YMAJ2wRYiDNrJRHavSC6J79Tnn31JQfA7iJaNiwsX35slDjnUQQ87mGKPY+lh8ui/3LH8Z4q0rfD6DFR8pS7+w5Nf5gw6VLWeXxjOB8apPpAJPKuxmedT6qjxLzXXQrCKJ1IBq1bXW1ovYI6UV+xmGSkmHTyhfEImaLSLbHJJJ+SXKiaAQeCzFETePe2QWL2vsKvj+60AVkMkHhgOXJ2v95LcMO2jTb8x3rgIvErJYVL0xu7NxVlp3jmEJJostd/X8ZEMMBxU2j8smdecMppHngUnONdBv9TudWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OryV5lFsU7ZeRzGR63nsFbIeP1zg3mqviOJpVN8f7VA=;
 b=yqNwyjvz+AaDD813s89l4m2sdysaL1h+OasqlFOihxz+5d5EAJLz6tX2ZbjOGxY8R7Ny2sDKwesrEInH3AmBvjGPSK55ArqSBFvbnXhljQF/TldYbvDcm1J0efSMlIKSaly1Ofn74W//1k/sltAQYhlM1C41zTyKyO6XXpOa+BkjnUgowROVQLV8458G/x/iJRyX2y/E6EIBj8gphxjMZD5FaKWDUR/7CMBoBNr9PV3/U6uUkiobc1amBSOEeDlDreqDdkW5bFCcSEVXrcM41fomQDQB68Dx30w4EdRvVmpdsDi6ldUT9QCbNthruSZgLLeHX/OyCi3VVvrZ7vVHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OryV5lFsU7ZeRzGR63nsFbIeP1zg3mqviOJpVN8f7VA=;
 b=QOoumfVNKqjxiQLzHxDSi6NoLjNefvYxCSCSE03CyZ2Oxk2Y8UQ9b1XckM7bls5xevZ6t5wAUVzN3Y/8DV7HZBhR6TyWOcQ5X1TaU/d0rHed1WsJjzEDUPmdvR27bC0d5tWleZfIkXOlwQmrhvzifDXPaU/2giKn0erV8hayJAo=
Received: from SJ0PR03CA0213.namprd03.prod.outlook.com (2603:10b6:a03:39f::8)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 13:47:55 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::29) by SJ0PR03CA0213.outlook.office365.com
 (2603:10b6:a03:39f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:47:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:46 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:47:42 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 46/70] drm/amd/display: Add i2c and EDID parsing tests for
 connector
Date: Wed, 15 Jul 2026 21:37:56 +0800
Message-ID: <20260715134432.1975118-47-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|DM6PR12MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f111c6f-cbdf-4ceb-db00-08dee277ac69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|10067099003|6133799003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: vg/SAamnm0//Zb9WxH/4mTfyZPWMEMdmCQMBRHuatGJao8j98FvD2E5Q3NJvvoRQMgqfg7q5HLpSZ0sUL9sm5ZUzStXY52+/uo0KqdMKpXXX+QKmSBLJ6vna4hWLg0KXufZZ8/ObdQsI1yY0MYILLv0N0qBbZhwpCYrLnc/4mwEOKiLf4yTJWvp2uVz1LuuejmKQMETy9G9ol3IIiF72b+Bv910YTSfCFO7OiIeh5IhcyY0hitgVWtumvRcZdU2n/qFJJiuznO/VMhSjUR204/J7idiso6OFNt05lNWYj9WwMukF6M7nbr4kKe8GZOcmjqUoOV6gxCoG03NZdI/WtmfblmLz25hdbnyPf71ua2p0EBuN0/XrGdUIuTVrHJ9932EAcN50p2XgHoxshB4G/s6l7Pf9T+F1oV6yVpLriTi5VuVA9sXMmpz5pYstH9gSm42HhXkIR1jgSpUYvQmOPigb/POg7De//HC9ugUN1hdkLOFtJm61e3UrRdWkP48pFeXfw8k2p5ZiNH6DIz3vD0PaB3cRb4am+4FqI52L8p/gJNYPpuE4MHXKennk96sjEynyNV8PBSTzz0y3B6+m3Ic9pPyfPMGL2PFs7VZa1dAmlGyZFyNdDmYlP1VPBhz1DZFTmVboZhHoPBJ3RXgWg34q3isGkfsdor0ynMact7aVUo1higo7R6czLLEqS0U8jWtHpIOQeVq/sBAKuQHhbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(10067099003)(6133799003)(22082099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L3UwkdX/rdcvXJxRvwmOYnTPixphk76goJDfOhNB6WutYCS7Sw+GxQJYKEogDoHCBHqM+jbic/3sxExgVrgAVOD9uheuU4UkqCqXfm/sq2SIgG2UhhXrT+6cdwvSP/0WFusgijGcHVQGQKuFdmJ++TtjTfXiU05e4Zu1UWdSCVruJhzyuCvaL3Q78bmq0sLxJ3FgnPKqi+g/DR0gN/JIR9N5js4ffOVrFSh44xAy6EBdeXlimJaf4ZWYGszRdIpcHnEM0i9AuB40HRMkZMRxx/7Ec7tV25sv+B3w+kxK83XroSYT2R6uiBg4Lm1MFEkbSZSjGbsj77gfX2tusR1HrW3LONY4ZV3HkguBVtAwxZUOKIcpG63vyd6DAyJF1MbEm8HmnlcWCOtWPezpoz6MCu5caBUxBJ/hn3s+RKV1GcaqggBXQZIq+l1EvJctM0I/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:47:55.3534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f111c6f-cbdf-4ceb-db00-08dee277ac69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Add KUnit coverage for the i2c and EDID parsing helpers:
amdgpu_dm_i2c_func(), amdgpu_dm_i2c_xfer(), get_amd_vsdb(),
parse_hdmi_amd_vsdb() and parse_edid_displayid_vrr().

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  15 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |  10 +
 .../tests/amdgpu_dm_connector_test.c          | 249 ++++++++++++++++++
 3 files changed, 269 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 557cc6492529..72c12484d218 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -2999,7 +2999,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	}
 }
 
-static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
+STATIC_IFN_KUNIT int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 			      struct i2c_msg *msgs, int num)
 {
 	struct amdgpu_i2c_adapter *i2c = i2c_get_adapdata(i2c_adap);
@@ -3043,11 +3043,13 @@ static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 	kfree(cmd.payloads);
 	return result;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_i2c_xfer);
 
-static u32 amdgpu_dm_i2c_func(struct i2c_adapter *adap)
+STATIC_IFN_KUNIT u32 amdgpu_dm_i2c_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_i2c_func);
 
 static const struct i2c_algorithm amdgpu_dm_i2c_algo = {
 	.master_xfer = amdgpu_dm_i2c_xfer,
@@ -3409,7 +3411,7 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
 	return ret;
 }
 
-static void parse_edid_displayid_vrr(struct drm_connector *connector,
+STATIC_IFN_KUNIT void parse_edid_displayid_vrr(struct drm_connector *connector,
 				     const struct edid *edid)
 {
 	u8 *edid_ext = NULL;
@@ -3451,8 +3453,9 @@ static void parse_edid_displayid_vrr(struct drm_connector *connector,
 		j++;
 	}
 }
+EXPORT_IF_KUNIT(parse_edid_displayid_vrr);
 
-static int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
+STATIC_IFN_KUNIT int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	struct drm_connector *connector = &aconnector->base;
@@ -3462,8 +3465,9 @@ static int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 
 	return connector->display_info.amd_vsdb.version != 0;
 }
+EXPORT_IF_KUNIT(get_amd_vsdb);
 
-static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
+STATIC_IFN_KUNIT int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			       const struct edid *edid,
 			       struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
@@ -3494,6 +3498,7 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 
 	return valid_vsdb_found ? i : -ENODEV;
 }
+EXPORT_IF_KUNIT(parse_hdmi_amd_vsdb);
 
 /**
  * amdgpu_dm_update_freesync_caps - Update Freesync capabilities
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index b237e8f864db..b64c81477a60 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -146,6 +146,16 @@ int amdgpu_dm_encoder_init(struct drm_device *dev,
 			   uint32_t link_index);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
+		       struct i2c_msg *msgs, int num);
+u32 amdgpu_dm_i2c_func(struct i2c_adapter *adap);
+void parse_edid_displayid_vrr(struct drm_connector *connector,
+			      const struct edid *edid);
+int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
+		 struct amdgpu_hdmi_vsdb_info *vsdb_info);
+int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
+			const struct edid *edid,
+			struct amdgpu_hdmi_vsdb_info *vsdb_info);
 void amdgpu_dm_connector_funcs_force(struct drm_connector *connector);
 enum dc_status dm_validate_stream_and_context(struct dc *dc,
 					      struct dc_stream_state *stream);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 459f0eda9a69..f60ce381683e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -17,6 +17,7 @@
 #include <drm/drm_modes.h>
 #include <drm/drm_property.h>
 #include <linux/hdmi.h>
+#include <linux/i2c.h>
 
 #include "dc.h"
 #include "amdgpu.h"
@@ -4666,6 +4667,239 @@ static void dm_test_add_freesync_modes_null_edid_noop(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, aconnector->num_modes, 7);
 }
 
+/* EDID extension block tag values (avoids pulling in private drm headers). */
+#define DM_TEST_CEA_EXT		0x02
+#define DM_TEST_DISPLAYID_EXT	0x70
+
+/**
+ * dm_test_i2c_func_returns_flags - Test the i2c functionality flags
+ * @test: The KUnit test context
+ *
+ * The algorithm advertises plain I2C plus emulated SMBUS regardless of the
+ * adapter argument, which it never dereferences.
+ */
+static void dm_test_i2c_func_returns_flags(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_i2c_func(NULL),
+			I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL);
+}
+
+/**
+ * dm_test_i2c_xfer_no_ddc_pin - Test transfers without a DDC pin are rejected
+ * @test: The KUnit test context
+ *
+ * When the backing ddc_service has no ddc_pin the transfer bails out early
+ * with -EIO before touching the message buffers or the dc handle.
+ */
+static void dm_test_i2c_xfer_no_ddc_pin(struct kunit *test)
+{
+	struct amdgpu_i2c_adapter *i2c;
+	struct ddc_service *ddc;
+
+	i2c = kunit_kzalloc(test, sizeof(*i2c), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, i2c);
+	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ddc);
+
+	i2c->ddc_service = ddc;
+	i2c_set_adapdata(&i2c->base, i2c);
+
+	/* ddc->ddc_pin is NULL -> transfer is rejected with -EIO. */
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_i2c_xfer(&i2c->base, NULL, 0), -EIO);
+}
+
+/**
+ * dm_test_get_amd_vsdb_unsupported - Test a zero VSDB version reports no support
+ * @test: The KUnit test context
+ */
+static void dm_test_get_amd_vsdb_unsupported(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	aconnector->base.display_info.amd_vsdb.version = 0;
+	aconnector->base.display_info.amd_vsdb.replay_mode = false;
+
+	KUNIT_EXPECT_EQ(test, get_amd_vsdb(aconnector, &vsdb_info), 0);
+	KUNIT_EXPECT_EQ(test, vsdb_info.amd_vsdb_version, 0);
+}
+
+/**
+ * dm_test_get_amd_vsdb_supported - Test a non-zero VSDB version is reported
+ * @test: The KUnit test context
+ *
+ * The display info's VSDB version and replay mode are copied out and a
+ * non-zero version reports support.
+ */
+static void dm_test_get_amd_vsdb_supported(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	aconnector->base.display_info.amd_vsdb.version = 2;
+	aconnector->base.display_info.amd_vsdb.replay_mode = true;
+
+	KUNIT_EXPECT_EQ(test, get_amd_vsdb(aconnector, &vsdb_info), 1);
+	KUNIT_EXPECT_EQ(test, vsdb_info.amd_vsdb_version, 2);
+	KUNIT_EXPECT_TRUE(test, vsdb_info.replay_mode);
+}
+
+/**
+ * dm_test_parse_hdmi_amd_vsdb_null_edid - Test NULL EDID returns -ENODEV
+ * @test: The KUnit test context
+ */
+static void dm_test_parse_hdmi_amd_vsdb_null_edid(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	KUNIT_EXPECT_EQ(test,
+			parse_hdmi_amd_vsdb(aconnector, NULL, &vsdb_info),
+			-ENODEV);
+}
+
+/**
+ * dm_test_parse_hdmi_amd_vsdb_no_extensions - Test EDID without extensions
+ * @test: The KUnit test context
+ *
+ * An EDID that declares no extension blocks has no CEA block to parse.
+ */
+static void dm_test_parse_hdmi_amd_vsdb_no_extensions(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
+	struct edid *edid;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	edid = kunit_kzalloc(test, sizeof(*edid), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, edid);
+
+	edid->extensions = 0;
+
+	KUNIT_EXPECT_EQ(test,
+			parse_hdmi_amd_vsdb(aconnector, edid, &vsdb_info),
+			-ENODEV);
+}
+
+/**
+ * dm_test_parse_hdmi_amd_vsdb_no_cea_ext - Test EDID with no CEA extension
+ * @test: The KUnit test context
+ *
+ * An extension block that is not a CEA block leaves no VSDB to parse.
+ */
+static void dm_test_parse_hdmi_amd_vsdb_no_cea_ext(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
+	struct edid *edid;
+	u8 *raw;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	/* Base block + one extension block that is NOT a CEA extension. */
+	raw = kunit_kzalloc(test, 2 * EDID_LENGTH, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, raw);
+	edid = (struct edid *)raw;
+	edid->extensions = 1;
+	raw[EDID_LENGTH] = DM_TEST_DISPLAYID_EXT;
+
+	KUNIT_EXPECT_EQ(test,
+			parse_hdmi_amd_vsdb(aconnector, edid, &vsdb_info),
+			-ENODEV);
+}
+
+/**
+ * dm_test_parse_displayid_vrr_null_edid - Test NULL EDID leaves range untouched
+ * @test: The KUnit test context
+ */
+static void dm_test_parse_displayid_vrr_null_edid(struct kunit *test)
+{
+	struct drm_connector *connector;
+
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+
+	parse_edid_displayid_vrr(connector, NULL);
+
+	KUNIT_EXPECT_EQ(test, connector->display_info.monitor_range.max_vfreq, 0);
+	KUNIT_EXPECT_EQ(test, connector->display_info.monitor_range.min_vfreq, 0);
+}
+
+/**
+ * dm_test_parse_displayid_vrr_no_displayid - Test EDID without a DisplayID ext
+ * @test: The KUnit test context
+ *
+ * Without a DisplayID extension block there is no dynamic range to extract.
+ */
+static void dm_test_parse_displayid_vrr_no_displayid(struct kunit *test)
+{
+	struct drm_connector *connector;
+	struct edid *edid;
+	u8 *raw;
+
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+	raw = kunit_kzalloc(test, 2 * EDID_LENGTH, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, raw);
+	edid = (struct edid *)raw;
+	edid->extensions = 1;
+	raw[EDID_LENGTH] = DM_TEST_CEA_EXT;
+
+	parse_edid_displayid_vrr(connector, edid);
+
+	KUNIT_EXPECT_EQ(test, connector->display_info.monitor_range.max_vfreq, 0);
+}
+
+/**
+ * dm_test_parse_displayid_vrr_sets_range - Test a DisplayID VRR block is parsed
+ * @test: The KUnit test context
+ *
+ * A DisplayID dynamic video timing range descriptor populates the connector's
+ * monitor refresh range.
+ */
+static void dm_test_parse_displayid_vrr_sets_range(struct kunit *test)
+{
+	struct drm_connector *connector;
+	struct edid *edid;
+	u8 *raw, *ext;
+
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+	raw = kunit_kzalloc(test, 2 * EDID_LENGTH, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, raw);
+	edid = (struct edid *)raw;
+	edid->extensions = 1;
+
+	ext = raw + EDID_LENGTH;
+	ext[0] = DM_TEST_DISPLAYID_EXT;
+	/*
+	 * DisplayID dynamic video timing range descriptor, parsed from offset
+	 * 1: tag 0x25, flags 0 (single-byte max), payload length 9, then the
+	 * min/max vfreq bytes.
+	 */
+	ext[1] = 0x25;
+	ext[2] = 0x00;
+	ext[3] = 9;
+	ext[10] = 40;
+	ext[11] = 144;
+
+	parse_edid_displayid_vrr(connector, edid);
+
+	KUNIT_EXPECT_EQ(test, connector->display_info.monitor_range.min_vfreq, 40);
+	KUNIT_EXPECT_EQ(test, connector->display_info.monitor_range.max_vfreq, 144);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -4917,6 +5151,21 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_add_fs_modes_no_preferred_mode),
 	/* amdgpu_dm_connector_add_freesync_modes */
 	KUNIT_CASE(dm_test_add_freesync_modes_null_edid_noop),
+	/* amdgpu_dm_i2c_func */
+	KUNIT_CASE(dm_test_i2c_func_returns_flags),
+	/* amdgpu_dm_i2c_xfer */
+	KUNIT_CASE(dm_test_i2c_xfer_no_ddc_pin),
+	/* get_amd_vsdb */
+	KUNIT_CASE(dm_test_get_amd_vsdb_unsupported),
+	KUNIT_CASE(dm_test_get_amd_vsdb_supported),
+	/* parse_hdmi_amd_vsdb */
+	KUNIT_CASE(dm_test_parse_hdmi_amd_vsdb_null_edid),
+	KUNIT_CASE(dm_test_parse_hdmi_amd_vsdb_no_extensions),
+	KUNIT_CASE(dm_test_parse_hdmi_amd_vsdb_no_cea_ext),
+	/* parse_edid_displayid_vrr */
+	KUNIT_CASE(dm_test_parse_displayid_vrr_null_edid),
+	KUNIT_CASE(dm_test_parse_displayid_vrr_no_displayid),
+	KUNIT_CASE(dm_test_parse_displayid_vrr_sets_range),
 	{}
 };
 
-- 
2.43.0

