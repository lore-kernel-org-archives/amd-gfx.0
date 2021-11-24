Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D82DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 17:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA746E901;
	Wed, 24 Nov 2021 17:28:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 900C56E902
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 17:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AU/sOrgKyGLTWnSgwXLjjUsekyPDWvLDEInNouu4musRKwYyiTv7oXbb/FG11jRplLwcZmBA8UZiZYaLHSYyVh5xaDVS8UB/nolBQMt68qVK0G+pg4cPgWHrc8NdqMmTfMXG85ZLrsaBxNxA72Q7PETAQvR8TEP35Bv8Df9fE42fhHdMrjksAdPSLyrAt/1gE5NuEaj6MClqsiigt494H+s7LK5xZ2osA29UuIbdPNWFJPQrVjRITtrdOUXxlB3bc3/DpvrSBdi5F0VvmfZ/E3+55Xw4hPc7n70m/eLI5469TXMdgkV2ea3jjdQbZsApv30qfUQx18+Jo/oWqmhf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uSMBv9toP95zgZPHJ6mVeGQ3F1G8BXCclIRLGPZKtI=;
 b=AFczR4mb5C3YwMqDKtKz7Arvov5ZwjRtYr/KSEJTomk/KqJE9bxJgEYtp9bO4XAwSg289PIX+pv0ACNKrYkAmNBx+SLVwbvO6mnXaaZJPeuQeLs5fxTC0Kuq7mb1il+PZT2SDo8jHc6Qt1tJf2oPD9Kk7SvpM+x/jpcA+9COp4cU7QBInbp4HfpnfYXN+ofpr8LqbtTATK/YEylqxpduRH4QE5xmNH+Mz3fvVhX1v9no60k7Ayk5kKuFick7ZwHNQSQe6ceU5xM65UwXh2La1pP2ZzN13SbdgUzPioKSmvanY77F3bDFleeSh74agVoeOHaZVczlcJIeB8d8A3FqIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uSMBv9toP95zgZPHJ6mVeGQ3F1G8BXCclIRLGPZKtI=;
 b=w88bPyw/rk8kNy5TwMjA47YD/2BH+lry1/HZ77/W/T88T0cK6PBIGiQOu9ZcZnq8y2Nc7h2ekyWc/iCha/fSHuBs8atzd3EZw+p1mDgDtMqkMM6oryZwLOhMofOWlIgxdiKxut4d7Xk9U9EcmCJ1TnrD7QPOu6b740TbQdeKKoA=
Received: from CO2PR04CA0091.namprd04.prod.outlook.com (2603:10b6:104:6::17)
 by BL0PR12MB2402.namprd12.prod.outlook.com (2603:10b6:207:45::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 24 Nov
 2021 17:28:46 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::c7) by CO2PR04CA0091.outlook.office365.com
 (2603:10b6:104:6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Wed, 24 Nov 2021 17:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Wed, 24 Nov 2021 17:28:45 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 24 Nov
 2021 11:28:45 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 24 Nov
 2021 09:28:44 -0800
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 24 Nov 2021 11:28:42 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH v1] drm/amd/display: Add DP-HDMI PCON SST Support
Date: Wed, 24 Nov 2021 12:28:37 -0500
Message-ID: <20211124172837.41507-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a12cfa71-4273-458d-531a-08d9af6fdea9
X-MS-TrafficTypeDiagnostic: BL0PR12MB2402:
X-Microsoft-Antispam-PRVS: <BL0PR12MB24029B2F36B889C05D3721BFE5619@BL0PR12MB2402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3yjvmyDcvJOamNB9d8V0/Wg0sQixVyACuabyZkVnOzo4sD0hD+yePsN8yJSJ1FUClOSAV95hyAt984j3AnHKjmkn8YR3riwMfQWiGlntWPAF94MK74bNaod+51KfMX+G4vjQFVV4Nuiigz6AdfiVYXINZKWFhMWR5smg2s5y3Kl5JQ01VqzNzLZpVyX+4f1niazFoVJNZM40H4pXI0Gb73Rxzo4nh5ko1F1D2QG1s2NrEwigndkhfQYhcIyTSKgs/hxMCpuma5Eq2ODIAMaaQbDLNU4h1FUtvPX1Gbl6132EKtCnIfuBpEvhDgdPvelRJsdByCe3TWcjNtDyhOnq3XUIz5d6RftP2TaxFlilbnWsGi6jACzTH3cE5zntoGY9e0EkEuMJK6UzoquRLmfeLsFSREvH4G/BghSVgdSUGhXSAME003WQMN6QZRMKb1ge1RKFdTOLX84x9+5MzlDXK7hT4tOgdOkTm7JogIu7IvIjnvy54xv86zTVnpxUf++Ht6G86kijTiWu4DqYRmBP7tas9jxGk2XwRQPkwOT6MbgFqemp592mwcqVnHza/dH/HNSb1cx+mR+c1lLzuIVhlmM6bujfBLICFtnrpVifY5rbelG1njVrYQJ8etcX6J2XRAZrryMz8OZAoNz/bXOq52dwmkwwaE3FuB1ggFp9vWVZttbGW3FVLRPlXl2RKeKiOveywgcdMngD8+gLfpKpoMIskuVV5/3J59kGzfBMeZE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400004)(5660300002)(81166007)(86362001)(83380400001)(7696005)(6666004)(356005)(2616005)(426003)(508600001)(336012)(47076005)(70586007)(4326008)(8936002)(8676002)(316002)(2906002)(54906003)(36860700001)(6636002)(26005)(186003)(36756003)(70206006)(1076003)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 17:28:45.9946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a12cfa71-4273-458d-531a-08d9af6fdea9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2402
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
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>, wayne.lin@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Parse DSC caps from PCON DPCD
2. Determine policy if decoding DSC at PCON
3. Enable/disable DSC at PCON

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 41 +++++++++++++++----
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 13 +++++-
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9a1ac657faa2..9dbf6bf3f1c3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6047,10 +6047,12 @@ static void update_dsc_caps(struct amdgpu_dm_connector *aconnector,
 
 	if (aconnector->dc_link && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
 		sink->sink_signal == SIGNAL_TYPE_EDP)) {
-		dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
-				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
-				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
-				      dsc_caps);
+		if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_NONE ||
+			sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER)
+			dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
+				aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
+				aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
+				dsc_caps);
 	}
 }
 
@@ -6120,6 +6122,8 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 	uint32_t link_bandwidth_kbps;
 	uint32_t max_dsc_target_bpp_limit_override = 0;
 	struct dc *dc = sink->ctx->dc;
+	uint32_t max_supported_bw_in_kbps, timing_bw_in_kbps;
+	uint32_t dsc_max_supported_bw_in_kbps;
 
 	link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
 							dc_link_get_link_cap(aconnector->dc_link));
@@ -6138,16 +6142,37 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 		apply_dsc_policy_for_edp(aconnector, sink, stream, dsc_caps, max_dsc_target_bpp_limit_override);
 
 	} else if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT) {
-
-		if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
+		if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_NONE) {
+			if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
 						dsc_caps,
 						aconnector->dc_link->ctx->dc->debug.dsc_min_slice_height_override,
 						max_dsc_target_bpp_limit_override,
 						link_bandwidth_kbps,
 						&stream->timing,
 						&stream->timing.dsc_cfg)) {
-			stream->timing.flags.DSC = 1;
-			DRM_DEBUG_DRIVER("%s: [%s] DSC is selected from SST RX\n", __func__, drm_connector->name);
+				stream->timing.flags.DSC = 1;
+				DRM_DEBUG_DRIVER("%s: [%s] DSC is selected from SST RX\n",
+								 __func__, drm_connector->name);
+			}
+		} else if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
+			timing_bw_in_kbps = dc_bandwidth_in_kbps_from_timing(&stream->timing);
+			max_supported_bw_in_kbps = link_bandwidth_kbps;
+			dsc_max_supported_bw_in_kbps = link_bandwidth_kbps;
+
+			if (timing_bw_in_kbps > max_supported_bw_in_kbps &&
+					max_supported_bw_in_kbps > 0 &&
+					dsc_max_supported_bw_in_kbps > 0)
+				if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
+						dsc_caps,
+						aconnector->dc_link->ctx->dc->debug.dsc_min_slice_height_override,
+						max_dsc_target_bpp_limit_override,
+						dsc_max_supported_bw_in_kbps,
+						&stream->timing,
+						&stream->timing.dsc_cfg)) {
+					stream->timing.flags.DSC = 1;
+					DRM_DEBUG_DRIVER("%s: [%s] DSC is selected from DP-HDMI PCON\n",
+									 __func__, drm_connector->name);
+				}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index e8e70840a622..2c73594da85f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -585,8 +585,17 @@ bool dm_helpers_dp_write_dsc_enable(
 	}
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT || stream->signal == SIGNAL_TYPE_EDP) {
-		ret = dm_helpers_dp_write_dpcd(ctx, stream->link, DP_DSC_ENABLE, &enable_dsc, 1);
-		DC_LOG_DC("Send DSC %s to sst display\n", enable_dsc ? "enable" : "disable");
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+		if (stream->sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_NONE) {
+#endif
+			ret = dm_helpers_dp_write_dpcd(ctx, stream->link, DP_DSC_ENABLE, &enable_dsc, 1);
+			DC_LOG_DC("Send DSC %s to SST RX\n", enable_dsc ? "enable" : "disable");
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+		} else if (stream->sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
+			ret = dm_helpers_dp_write_dpcd(ctx, stream->link, DP_DSC_ENABLE, &enable_dsc, 1);
+			DC_LOG_DC("Send DSC %s to DP-HDMI PCON\n", enable_dsc ? "enable" : "disable");
+		}
+#endif
 	}
 
 	return (ret > 0);
-- 
2.25.1

