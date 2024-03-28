Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD26CD11DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34BD0112541;
	Thu, 28 Mar 2024 19:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PSxS1Adp";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9637511232A
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhF1Qt0+/f2LlWFLdO8jAxsqgVylbMOMTQtu3KdW20Yia7lkBvDT3Zcg+LPpq2p5wuZNharxBiXk7oFvWjefS2bNtcru3eAInaTK4T2EtQtBmhk+jQWMFWzKtj/DGkoCfejwzJFvKaOnJ0lS07/0Jp3XisBM7eMl3tFpwu+Nbq+qkjCNtaHk1GwjJXexgBkqeBAQIFoNG0HTMiPbR7HXtXBlfUaxgD3ItW/lipaHPVQ46byoaxEWf6O1iNyAwCVAif3Okal81Emc5sHBIzUYzr5zkv8sm3A5KDvgsQImxHjSYZlE9jBp292Gk4qfYOn1jlIwtFn17slUMIqbLNRtKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7d0AeQ4B8OLSNrKsTJBHOcVS9jUZ8ouKMmm950NNnk=;
 b=XTlVBqfn33QaVvjgb6UNZNLtCQ7l688zsTxhkb0WH9zmGNrX0yu8VWYzRB7q94BKMjpsevmGdBmX283/WgTHbrq4KX4ryviiWH/i45OVuSUPleTxZnPww12Yn1yodTcT+ksW+dRjxFMlhyREVD94cG/OsczMnkjoZqvN4nZMqKvS23HnLsaAiQuRi0e0P5WWP3AGal03g3J27y8FjoRXmWledvly7GeBg6RwL84CxObCXI1BljtUJHlk4XHef/DhXPrfvqyEZ+8R6swU1wjOjsfmPB3jX8T1MOANVIs5xWd2EfoPql7KYtXljDnnO0AeuFo+J3TuVNJoxxk7pG5npA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7d0AeQ4B8OLSNrKsTJBHOcVS9jUZ8ouKMmm950NNnk=;
 b=PSxS1Adp3quXeSgFgUvBvgaJojTxlaSfSdV18uCY2s/cSTFjF60J96ZKw+IJQ6trsBZgdk3h5jaSpgblM8Y5OyXC9/IejSlYroy4n+RRsJ+fBv2dg4ijHOaLbVK3+BHqABNjtm5S6StoZW89hMbRLSHun2PIOpoF+SOLWNeBMSw=
Received: from CH0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::20)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 19:51:54 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::36) by CH0P220CA0025.outlook.office365.com
 (2603:10b6:610:ef::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:53 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:53 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Josip Pavic <josip.pavic@amd.com>
Subject: [PATCH 21/43] drm/amd/display: Add extra DMUB logging to track
 message timeout
Date: Thu, 28 Mar 2024 15:50:25 -0400
Message-ID: <20240328195047.2843715-22-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b9e26a-488e-46e2-f8dd-08dc4f608508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9msdGLSBn6aLuKh70HtQfU20huoDRWxu4291NaZSaEm+zCFNN/movltQL5d9curP0PqDC66wCmoTaawDesgFlebZm2HDwy4Thwc0CtqIDX100XL+Or/QuTPAj5ddq6uraxPl2bd06BpeA3GfAnOpeyVnRlRxhZYaB8EdoEqnO6LdeRaidDSLBpZzr2ZFUF4LHmo5yLOTgp0fhuHOWSYWh4IytuG7pU0/jcrGqop5GpUmf32F+ibXNQ5/UtsM0M3cfYhSnvxb17r469DtHzdyU70cLtEJx805+e2k6iEb5q7p6QxL1TsW5V4VUnZIAF5JHKZPSFCug26Lqze0rwYX5YpO9vgFyq1qy2I9iGSmqW6edgdkBD3we8yP8+m9902L+33qgvgFtLlS2wZlERSJ7QZiUDCeBbpaLzaQRl4bTX0I4vClXchwSUZ1ftdaluwuHJIZtSeX3GlN8uEFX2DRmtu1LloTRUV5eE8Bly3QOXC0JczeWSaNUNZ5IbdeCqcFDyhiJNMNdQ0WgU4xk0/6t7OU9hPBTIkL7r92ezo4ChEjhnqQjeqS5oKJOWgiWkqShVUelh2NAqdqlYUULm1uXVqQ73ngX8hA8Mbxx34t3J8u0ovW5zlG6MLTDaeHL9b3TWGPz5v94SGSFdN/ukltwUwnX80Gi8XQAIW0nXCleHAhipTX2vwajiy03eramrTnTAM2fDbe34kS6NNsiuuDnayDCcN907Z2KXOwJsoFhijO6BxH1GZslQypMVGjKYk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:54.5617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b9e26a-488e-46e2-f8dd-08dc4f608508
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
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

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- Add logging for first DMUB inbox message that timed out to diagnostic
  data
- It is useful to track the first failed message for debug purposes
  because once DMUB becomes hung (typically on a message), it will
  remain hung and all subsequent messages. In these cases we're
  interested in knowing which is the first message that failed.

Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c    | 10 +++++++++-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h     | 17 ++++++++++++++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c   |  1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c   |  1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c   |  2 ++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c   |  1 +
 6 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 9ae0e602e737..34d199b08dd9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -23,6 +23,7 @@
  *
  */
 
+#include "dm_services.h"
 #include "dc.h"
 #include "dc_dmub_srv.h"
 #include "../dmub/dmub_srv.h"
@@ -198,6 +199,11 @@ bool dc_dmub_srv_wait_for_idle(struct dc_dmub_srv *dc_dmub_srv,
 
 		if (status != DMUB_STATUS_OK) {
 			DC_LOG_DEBUG("No reply for DMUB command: status=%d\n", status);
+			if (!dmub->debug.timeout_occured) {
+				dmub->debug.timeout_occured = true;
+				dmub->debug.timeout_cmd = *cmd_list;
+				dmub->debug.timestamp = dm_get_timestamp(dc_dmub_srv->ctx);
+			}
 			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
 			return false;
 		}
@@ -904,6 +910,7 @@ bool dc_dmub_srv_get_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv, struct dmu
 void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
 {
 	struct dmub_diagnostic_data diag_data = {0};
+	uint32_t i;
 
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub) {
 		DC_LOG_ERROR("%s: invalid parameters.", __func__);
@@ -935,7 +942,8 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
 	DC_LOG_DEBUG("    scratch [13]       : %08x", diag_data.scratch[13]);
 	DC_LOG_DEBUG("    scratch [14]       : %08x", diag_data.scratch[14]);
 	DC_LOG_DEBUG("    scratch [15]       : %08x", diag_data.scratch[15]);
-	DC_LOG_DEBUG("    pc                 : %08x", diag_data.pc);
+	for (i = 0; i < DMUB_PC_SNAPSHOT_COUNT; i++)
+		DC_LOG_DEBUG("    pc[%d]             : %08x", i, diag_data.pc[i]);
 	DC_LOG_DEBUG("    unk_fault_addr     : %08x", diag_data.undefined_address_fault_addr);
 	DC_LOG_DEBUG("    inst_fault_addr    : %08x", diag_data.inst_fetch_fault_addr);
 	DC_LOG_DEBUG("    data_fault_addr    : %08x", diag_data.data_write_fault_addr);
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 7785908a6676..662bdb0e5d3d 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -71,6 +71,8 @@
 extern "C" {
 #endif
 
+#define DMUB_PC_SNAPSHOT_COUNT 10
+
 /* Forward declarations */
 struct dmub_srv;
 struct dmub_srv_common_regs;
@@ -299,6 +301,17 @@ struct dmub_srv_hw_params {
 	enum dmub_ips_disable_type disable_ips;
 };
 
+/**
+ * struct dmub_srv_debug - Debug info for dmub_srv
+ * @timeout_occured: Indicates a timeout occured on any message from driver to dmub
+ * @timeout_cmd: first cmd sent from driver that timed out - subsequent timeouts are not stored
+ */
+struct dmub_srv_debug {
+	bool timeout_occured;
+	union dmub_rb_cmd timeout_cmd;
+	unsigned long long timestamp;
+};
+
 /**
  * struct dmub_diagnostic_data - Diagnostic data retrieved from DMCUB for
  * debugging purposes, including logging, crash analysis, etc.
@@ -306,7 +319,7 @@ struct dmub_srv_hw_params {
 struct dmub_diagnostic_data {
 	uint32_t dmcub_version;
 	uint32_t scratch[17];
-	uint32_t pc;
+	uint32_t pc[DMUB_PC_SNAPSHOT_COUNT];
 	uint32_t undefined_address_fault_addr;
 	uint32_t inst_fetch_fault_addr;
 	uint32_t data_write_fault_addr;
@@ -317,6 +330,7 @@ struct dmub_diagnostic_data {
 	uint32_t inbox0_wptr;
 	uint32_t inbox0_size;
 	uint32_t gpint_datain0;
+	struct dmub_srv_debug timeout_info;
 	uint8_t is_dmcub_enabled : 1;
 	uint8_t is_dmcub_soft_reset : 1;
 	uint8_t is_dmcub_secure_reset : 1;
@@ -506,6 +520,7 @@ struct dmub_srv {
 	struct dmub_visual_confirm_color visual_confirm_color;
 
 	enum dmub_srv_power_state_type power_state;
+	struct dmub_srv_debug debug;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index cae96fba6349..e500ca9ae09c 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -472,4 +472,5 @@ void dmub_dcn20_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnosti
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
 	diag_data->is_cw6_enabled = is_cw6_enabled;
+	diag_data->timeout_info = dmub->debug;
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 2bcf5fb87dd9..662c34e9495c 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -466,6 +466,7 @@ void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnosti
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
 	diag_data->is_cw6_enabled = is_cw6_enabled;
+	diag_data->timeout_info = dmub->debug;
 }
 
 bool dmub_dcn31_should_detect(struct dmub_srv *dmub)
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index 0d521eeda050..e1da270502cc 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -478,6 +478,8 @@ void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnosti
 	diag_data->is_cw6_enabled = is_cw6_enabled;
 
 	diag_data->gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
+
+	diag_data->timeout_info = dmub->debug;
 }
 void dmub_dcn32_configure_dmub_in_system_memory(struct dmub_srv *dmub)
 {
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 53f359f3fae2..98afaecd3984 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -516,6 +516,7 @@ void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnosti
 	diag_data->is_cw6_enabled = is_cw6_enabled;
 
 	diag_data->gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
+	diag_data->timeout_info = dmub->debug;
 }
 void dmub_dcn35_configure_dmub_in_system_memory(struct dmub_srv *dmub)
 {
-- 
2.34.1

