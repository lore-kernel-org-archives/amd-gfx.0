Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DFDCD4F25
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 15:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2DD010EB7E;
	Tue, 12 May 2026 15:53:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MRZwTLmE";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010028.outbound.protection.outlook.com
 [40.93.198.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E067E10EB7E
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 15:53:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9nPOhEMY1Cfyg1RnrV8T4k5rQdqpICRJL3YtijHze8VXFwiJ+/nWgUDi2dClvStUtivRPbcr1hY3uS3nObnQ2w7BE5OxO+bSqk0xsuplWiIolvg+q5KPXoHCh8kaPFr78HylKLOwFGTSliVxZZanym+acke3u7K22vpsuv3p2rlvJKZzlo5/srFK52pIcFgdDuNx6vX4CJp0yeTczBEtwFJxfUsxC7Sb2bL/hEHKzYfBc/tHm9cvmsF6hNsr5z/P+lmQLWxJlhEYDvqTeuW0q0DJwCCRneswi0P84GymclrXrD4JEXx45P2C5MqOl3xWtPwqQcnncfapQUnczCS/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vw7NGrufP5QyOkcwJi4+9puA6fUVYDxClBWHeNYk1aw=;
 b=oM1detfzfi46WxJjbHSXEBzxiQ32hIJ8lLforLEoiJ+JZ0Li7ii6nho7XWR4GC3FKZx075O9NZlouWY4lnB/o25rYTEfxrc4qWCE/kudoajwDtPxMKjyYsk2xQROlrZi3yudyqIVfrHVykBdMMqSA2/Zr/9fC7qiMAnQOg7dxJuIkzS7ChD5C1xeSTCahwLa+xIeUk50nADE4/pOkvuIO21IJnTJVziiIjj+HkcLsi7e6sTq6RW0DSCbzcmHldiXn6WIPvunOjSAi7h1c931NbvILaNQaW0TMRcm1FjH0Ys6Nbr01rbLmzzIddSYhoW3HhUBFdzlNIsr+yIIYr4ICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw7NGrufP5QyOkcwJi4+9puA6fUVYDxClBWHeNYk1aw=;
 b=MRZwTLmE34qwNrEKB8IkLrRPyzKVasz3EG4xiLAOHm0rKbMpffxMf9dqrj0WrfZL3Bek6A3kmZONBa6oxxtt0I4Md59kbP7kkGwjxMl/O/LLXr/N9lCBcR8iD1jpFNquYUuRvOUF9/RYKQkdp7N7jrjIRLqcrGThMVpMXVLub/w=
Received: from MN2PR20CA0039.namprd20.prod.outlook.com (2603:10b6:208:235::8)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 15:53:05 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::72) by MN2PR20CA0039.outlook.office365.com
 (2603:10b6:208:235::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 15:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 15:53:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 10:52:55 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 10:52:55 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v5 13/13] drm/amd/display: add HDMI 2.1 DSC over FRL support
Date: Tue, 12 May 2026 11:52:44 -0400
Message-ID: <20260512155244.403854-14-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512155244.403854-1-harry.wentland@amd.com>
References: <20260512155244.403854-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d5e021-ea6e-4371-b2df-08deb03e8e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|11063799003|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: MeLb0spVtTwu2rbF+51SUczsXsNuche3fZP5S2RoQdiqiAqE6SgrgtfWRHH1Ez8/N2g5eATb0do3AARH8GsSGE0mlVg+1KuvUPZ7yQHFanJ/5dXASIDBi+xtRJb9xRQMhIPBiavGKCzXyomNFO0hH0mBNFFn9UkRwW7kkuATu6ZW5d8BQ03dYBZz2eqwcJsfRsWJZGAoe8kS6CNxSWprGO/hMbg2r8G+i+RqLxmdPL14N6s/bg9N7VDDbUkc6PTOmzKP/VeN2MA1hgPN7/cJvKWQxSfIBzpudbQfqicwwoA9foI7c70E6KCbscfl9yEjxqcnYT8rbQCLIIj20JYU1pilkHhxr/KFelywVF6IzMJhfr/vOPK3JnK4diX0YLUlGkSXG57kTTx1qtvxWAcsJ8y4vwLJCt9vvX0+91+XzJ4oHWyd2t1SeptrK7yHp5Bd1f/L2gz9nMTUZw7km3BZif16GI9aH+Cn8kTGmZbs9ZI8H8ipYZjm/oiQMkaZCksi4rU/ZVpk5SDFNHFB8I027nslhjNZ5juQABw8++s1HFn5TqnkdClU3O9Dym1Zrqf6Ts8VHM6wuIXdhIBcQKNho95/dHfeEmb866lxmqTEL4WLal8jSsDI4++Tayt9QU9gFEpxz2zsATHcU30JSDZqpg4wn4uYA+HIHnLlXRgsHDw0Lhnm5rX4bm4U9uQn4/sror8/QSQGRuTEtMTEjQAUpe+5SRHCgiej9Pr4ImJ9r+M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799003)(22082099003)(56012099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uT+SBkem7xu0a0pfVlZq4XfhdFVRQih9JhwoZsRTWGRK3oH637opw6ljMkC2aMrR+DdCF6hyL4I2JS4KGs4heZ9h+V5xU1lLGpU5qfr/fRbiBOYRmSf7dRcQXAlR4Og7zd+dY+pitvv949uRJjpTqn9B8zYzCJEWtmQwHJj0LN8QutqWIOyBbLTPoQ3JXYOaT5vzcRLOWik2s8Ic438EB6c2J4rqQ8DlPovIt24agJEi1MF1AgKRMvi9l1Zg95dom2mz8Njmp83A0Ms/vQ4am0eQTzQzZKeE09pFnH0LRb4ztU9gqQq8tdnZniA3lRcBOpKFtaau6WG/0l5UdxGJF+MK0iua91e3IL1UTOQ6U7VCwmGlu1iScbpFEh0r5ho/RKp3lB1H5n6R20/IjBLoa3ggDOzPi9b3r96n0yhIX5RF0cIQ9zg155SWNs/jtPkq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:53:05.5342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d5e021-ea6e-4371-b2df-08deb03e8e56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406
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

Add all the bits to enable DSC over FRL.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  74 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  45 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  13 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  56 ++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   7 +
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   8 +
 .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |   2 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  40 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |   3 +
 .../dc/dml/dcn31/display_mode_vba_31.c        |   3 +
 .../dc/dml/dcn314/display_mode_vba_314.c      |   3 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   3 +
 .../drm/amd/display/dc/dml/dml1_frl_cap_chk.c | 197 +++++
 .../drm/amd/display/dc/dml/dml1_frl_cap_chk.h |   9 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 704 ++++++++++++++++++
 .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.c  | 105 +++
 .../dcn401/dcn401_hpo_frl_stream_encoder.c    |   1 +
 .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.c  |   1 +
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |   3 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   2 +
 .../amd/display/dc/inc/hw/stream_encoder.h    |   4 +
 .../amd/display/dc/inc/hw/timing_generator.h  |   1 -
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  38 +
 .../display/dc/link/protocols/link_hdmi_frl.c |  38 +
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |   8 +-
 27 files changed, 1362 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f262c63c426e..e108b14dece8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7327,12 +7327,30 @@ static void update_dsc_caps(struct amdgpu_dm_connector *aconnector,
 
 	if (aconnector->dc_link && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
 	    sink->sink_signal == SIGNAL_TYPE_EDP)) {
-		if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_NONE ||
-			sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER)
+		if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_NONE)
 			dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
 				aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
 				aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
 				dsc_caps);
+		else if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
+			if (aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_PASSTHROUGH_SUPPORT &&
+					!aconnector->dsc_settings.dsc_force_disable_passthrough &&
+					aconnector->dc_link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps > 0 &&
+					sink->edid_caps.frl_dsc_support &&
+					sink->edid_caps.max_frl_rate > 0 &&
+					sink->edid_caps.frl_dsc_max_frl_rate > 0)
+				dc_dsc_parse_dsc_edid(aconnector->dc_link->ctx->dc, &sink->edid_caps, dsc_caps);
+			else
+				dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
+				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
+				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
+				      dsc_caps);
+		}
+	} else if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_HDMI_FRL) {
+		if (sink->edid_caps.frl_dsc_support &&
+				sink->edid_caps.max_frl_rate > 0 &&
+				sink->edid_caps.frl_dsc_max_frl_rate > 0)
+			dc_dsc_parse_dsc_edid(aconnector->dc_link->ctx->dc, &sink->edid_caps, dsc_caps);
 	}
 }
 
@@ -7406,6 +7424,10 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 	struct drm_connector *drm_connector = &aconnector->base;
 	u32 link_bandwidth_kbps;
 	struct dc *dc = sink->ctx->dc;
+	const struct dc_hdmi_frl_link_settings *frl_verified_link_cap = NULL;
+	u32 converter_bw_in_kbps;
+	u32 sink_bw_in_kbps;
+	u32 dsc_sink_bw_in_kbps;
 	u32 max_supported_bw_in_kbps, timing_bw_in_kbps;
 	u32 dsc_max_supported_bw_in_kbps;
 	u32 max_dsc_target_bpp_limit_override =
@@ -7444,8 +7466,18 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 		} else if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
 			timing_bw_in_kbps = dc_bandwidth_in_kbps_from_timing(&stream->timing,
 					dc_link_get_highest_encoding_format(aconnector->dc_link));
-			max_supported_bw_in_kbps = link_bandwidth_kbps;
-			dsc_max_supported_bw_in_kbps = link_bandwidth_kbps;
+			converter_bw_in_kbps = aconnector->dc_link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps;
+			sink_bw_in_kbps = dc_link_bw_kbps_from_raw_frl_link_rate_data(dc, sink->edid_caps.max_frl_rate);
+			dsc_sink_bw_in_kbps = dc_link_bw_kbps_from_raw_frl_link_rate_data(dc, sink->edid_caps.frl_dsc_max_frl_rate);
+
+			if (dsc_caps->is_frl) {
+				max_supported_bw_in_kbps = min(link_bandwidth_kbps, converter_bw_in_kbps);
+				max_supported_bw_in_kbps = min(max_supported_bw_in_kbps, sink_bw_in_kbps);
+				dsc_max_supported_bw_in_kbps = min(max_supported_bw_in_kbps, dsc_sink_bw_in_kbps);
+			} else {
+				max_supported_bw_in_kbps = link_bandwidth_kbps;
+				dsc_max_supported_bw_in_kbps = link_bandwidth_kbps;
+			}
 
 			if (timing_bw_in_kbps > max_supported_bw_in_kbps &&
 					max_supported_bw_in_kbps > 0 &&
@@ -7458,11 +7490,41 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 						dc_link_get_highest_encoding_format(aconnector->dc_link),
 						&stream->timing.dsc_cfg)) {
 					stream->timing.flags.DSC = 1;
-					drm_dbg_driver(drm_connector->dev, "%s: SST_DSC [%s] DSC is selected from DP-HDMI PCON\n",
-									 __func__, drm_connector->name);
+					drm_dbg_driver(drm_connector->dev, "%s: SST_DSC [%s] DSC is selected from %s\n",
+							__func__, drm_connector->name,
+							(dsc_caps->is_frl == 1) ? "HDMI FRL RX" : "DP-HDMI PCON");
 				}
 		}
 	}
+	else if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_HDMI_FRL) {
+		struct dc_dsc_policy dsc_policy = {0};
+
+		frl_verified_link_cap = dc_link_get_frl_link_cap(stream->link);
+		if (frl_verified_link_cap->frl_link_rate != HDMI_FRL_LINK_RATE_DISABLE &&
+			aconnector->dc_link->frl_flags.force_frl_dsc) {
+			dc_dsc_policy_set_enable_dsc_when_not_needed(true);
+			dc_dsc_get_policy_for_timing(&stream->timing, 0, &dsc_policy, dc_link_get_highest_encoding_format(stream->link));
+		}
+
+		timing_bw_in_kbps = dc_bandwidth_in_kbps_from_timing(&stream->timing, DC_LINK_ENCODING_HDMI_FRL);
+		link_bandwidth_kbps = dc_link_frl_bandwidth_kbps(stream->link, frl_verified_link_cap->frl_link_rate);
+		dsc_sink_bw_in_kbps = dc_link_bw_kbps_from_raw_frl_link_rate_data(dc, sink->edid_caps.frl_dsc_max_frl_rate);
+
+		if ((timing_bw_in_kbps > link_bandwidth_kbps && dsc_sink_bw_in_kbps > 0) ||
+		    (dsc_policy.enable_dsc_when_not_needed || dsc_options.force_dsc_when_not_needed)) {
+			if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
+					dsc_caps,
+					&dsc_options,
+					dsc_sink_bw_in_kbps,
+					&stream->timing,
+					dc_link_get_highest_encoding_format(aconnector->dc_link),
+					&stream->timing.dsc_cfg)) {
+				stream->timing.flags.DSC = 1;
+				drm_dbg_driver(drm_connector->dev, "%s: HDMI_FRL_DSC [%s] DSC is selected from HDMI FRL RX\n",
+						__func__, drm_connector->name);
+			}
+		}
+	}
 
 	/* Overwrite the stream flag if DSC is enabled through debugfs */
 	if (aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index d2598e391eb8..f9ec006e08c4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -178,8 +178,15 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 
 	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
-	if (edid_caps->edid_hdmi)
+	if (edid_caps->edid_hdmi) {
 		populate_hdmi_info_from_connector(&connector->display_info.hdmi, edid_caps);
+		drm_dbg_driver(connector->dev, "%s: HDMI_FRL [%s] max_frl_rate %d\n", __func__, connector->name, edid_caps->max_frl_rate);
+		if (edid_caps->frl_dsc_support)
+			drm_dbg_driver(connector->dev, "%s: HDMI_FRL_DSC [%s] frl_dsc_10bpc %d, frl_dsc_12bpc %d, frl_dsc_all_bpp %d, frl_dsc_native_420 %d, frl_dsc_max_slices %d, frl_dsc_max_frl_rate %d, frl_dsc_total_chunk_kbytes %d\n",
+					__func__, connector->name, edid_caps->frl_dsc_10bpc, edid_caps->frl_dsc_12bpc, \
+					edid_caps->frl_dsc_all_bpp, edid_caps->frl_dsc_native_420, edid_caps->frl_dsc_max_slices, \
+					edid_caps->frl_dsc_max_frl_rate, edid_caps->frl_dsc_total_chunk_kbytes);
+	}
 
 	apply_edid_quirks(dev, edid_buf, edid_caps);
 
@@ -1093,10 +1100,46 @@ static uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_per_lane)
 	return max_frl_rate;
 }
 
+static uint8_t get_dsc_max_slices(uint8_t max_slices, int clk_per_slice)
+{
+	uint8_t dsc_max_slices;
+
+	if ((max_slices == 1) && (clk_per_slice == 340))
+		dsc_max_slices = 1;
+	else if ((max_slices == 2) && (clk_per_slice == 340))
+		dsc_max_slices = 2;
+	else if ((max_slices == 4) && (clk_per_slice == 340))
+		dsc_max_slices = 3;
+	else if ((max_slices == 8) && (clk_per_slice == 340))
+		dsc_max_slices = 4;
+	else if ((max_slices == 8) && (clk_per_slice == 400))
+		dsc_max_slices = 5;
+	else if ((max_slices == 12) && (clk_per_slice == 400))
+		dsc_max_slices = 6;
+	else if ((max_slices == 16) && (clk_per_slice == 400))
+		dsc_max_slices = 7;
+	else
+		dsc_max_slices = 0;
+
+	return dsc_max_slices;
+}
+
 void populate_hdmi_info_from_connector(struct drm_hdmi_info *hdmi, struct dc_edid_caps *edid_caps)
 {
 	edid_caps->scdc_present = hdmi->scdc.supported;
 	edid_caps->max_frl_rate = get_max_frl_rate(hdmi->max_lanes, hdmi->max_frl_rate_per_lane);
+	edid_caps->frl_dsc_support = hdmi->dsc_cap.v_1p2;
+	if (edid_caps->frl_dsc_support) {
+		if (hdmi->dsc_cap.bpc_supported == 10)
+			edid_caps->frl_dsc_10bpc = true;
+		else if (hdmi->dsc_cap.bpc_supported == 12)
+			edid_caps->frl_dsc_12bpc = true;
+		edid_caps->frl_dsc_all_bpp = hdmi->dsc_cap.all_bpp;
+		edid_caps->frl_dsc_native_420 = hdmi->dsc_cap.native_420;
+		edid_caps->frl_dsc_max_slices = get_dsc_max_slices(hdmi->dsc_cap.max_slices, hdmi->dsc_cap.clk_per_slice);
+		edid_caps->frl_dsc_max_frl_rate = get_max_frl_rate(hdmi->dsc_cap.max_lanes, hdmi->dsc_cap.max_frl_rate_per_lane);
+		edid_caps->frl_dsc_total_chunk_kbytes = hdmi->dsc_cap.total_chunk_kbytes;
+	}
 }
 
 enum dc_edid_status dm_helpers_read_local_edid(
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index af0e5ca48abb..ddab7ca5b5fb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4059,6 +4059,12 @@ static void add_link_update_dsc_config_sequence(
 					pipe_ctx->stream_res.stream_enc,
 					true, dsc_packed_pps, false);
 		}
+		else if (dc_is_hdmi_frl_signal(stream->signal)) {
+			hwss_add_hpo_frl_stream_enc_set_dsc_config(seq_state,
+				pipe_ctx->stream_res.hpo_frl_stream_enc,
+				&stream->timing,
+				dsc_packed_pps);
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 97380cda9eb4..88446817a71f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1641,6 +1641,9 @@ void hwss_execute_sequence(struct dc *dc,
 		case STREAM_ENC_DP_SET_DSC_PPS_INFO_PACKET:
 			hwss_stream_enc_dp_set_dsc_pps_info_packet(params);
 			break;
+		case HPO_FRL_STREAM_ENC_SET_DSC_CONFIG:
+			hwss_hpo_frl_stream_enc_set_dsc_config(params);
+			break;
 		case DP_TRACE_SOURCE_SEQUENCE:
 			hwss_dp_trace_source_sequence(params);
 			break;
@@ -3733,6 +3736,16 @@ void hwss_stream_enc_dp_set_dsc_pps_info_packet(union block_sequence_params *par
 			params->stream_enc_dp_set_dsc_pps_info_packet_params.pps_sdp_stream);
 }
 
+void hwss_hpo_frl_stream_enc_set_dsc_config(union block_sequence_params *params)
+{
+	if (params->hpo_frl_stream_enc_set_dsc_config_params.hpo_frl_stream_enc &&
+	    params->hpo_frl_stream_enc_set_dsc_config_params.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config)
+		params->hpo_frl_stream_enc_set_dsc_config_params.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
+			params->hpo_frl_stream_enc_set_dsc_config_params.hpo_frl_stream_enc,
+			(struct dc_crtc_timing *)params->hpo_frl_stream_enc_set_dsc_config_params.timing,
+			params->hpo_frl_stream_enc_set_dsc_config_params.dsc_packed_pps);
+}
+
 void hwss_set_dmdata_attributes(union block_sequence_params *params)
 {
 	struct hubp *hubp = params->set_dmdata_attributes_params.hubp;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 09235ae5055e..d4c61c9be922 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4594,6 +4594,38 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 }
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
+/**
+ * dc_update_modified_pix_clock_for_dsc_with_padding() - update pix_clk for dsc with padding
+ *
+ * @dc_stream_state: Pointer to the stream structure.
+ * @dc_crtc_timing: Pointer to the stream dc_crtc_timing structure.
+ * @dsc_padding_params: Pointer to the DSC padding parameters structure.
+ *
+ * This function updated the pix_clk for dsc with padding stored in pipe_ctx
+ * such that the OTG h_active time fits withing the expected compressed active
+ * time calculated according to HDMI spec. H_total is then increased to
+ * maintain the same OTG line time as before the increased pix_clk.
+ */
+static void dc_update_modified_pix_clock_for_dsc_with_padding(const struct dc_stream_state *stream,
+		const struct dc_crtc_timing *timing, struct dsc_padding_params *dsc_padding_params)
+{
+	DC_FP_START();
+	frl_modified_pix_clock_for_dsc_padding(stream->link->frl_verified_link_cap.borrow_params.hc_active_target,
+	stream->link->frl_verified_link_cap.borrow_params.hc_blank_target,
+	stream->link->frl_verified_link_cap.frl_num_lanes,
+	timing->pix_clk_100hz,
+	stream->link->frl_verified_link_cap.frl_link_rate,
+	timing->h_addressable,
+	timing->h_border_left,
+	timing->h_border_right,
+	timing->h_total,
+	(timing->h_addressable + dsc_padding_params->dsc_hactive_padding),
+	&dsc_padding_params->dsc_pix_clk_100hz,
+	&dsc_padding_params->dsc_htotal_padding);
+	DC_FP_END();
+
+	dsc_padding_params->dsc_htotal_padding = dsc_padding_params->dsc_htotal_padding - timing->h_total;
+}
 #endif /* CONFIG_DRM_AMD_DC_FP */
 
 /**
@@ -4620,6 +4652,30 @@ static void calculate_timing_params_for_dsc_with_padding(struct pipe_ctx *pipe_c
 	if (stream)
 		pipe_ctx->dsc_padding_params.dsc_pix_clk_100hz = stream->timing.pix_clk_100hz;
 
+#if defined(CONFIG_DRM_AMD_DC_FP)
+	uint32_t hactive;
+	uint32_t ceil_slice_width;
+	if (stream && stream->timing.flags.DSC) {
+		hactive = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
+
+		/* Assume if determined slices does not divide Hactive evenly, Hborrow is needed for padding*/
+		if (hactive % stream->timing.dsc_cfg.num_slices_h != 0) {
+			ceil_slice_width = (hactive / stream->timing.dsc_cfg.num_slices_h) + 1;
+
+			/* If YCBCR420 slice width must be even */
+			if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420 && ceil_slice_width % 2 != 0)
+				ceil_slice_width++;
+
+			pipe_ctx->dsc_padding_params.dsc_hactive_padding =
+				(uint8_t)(ceil_slice_width * stream->timing.dsc_cfg.num_slices_h - hactive);
+
+			if (stream->timing.h_total - hactive - pipe_ctx->dsc_padding_params.dsc_hactive_padding < 32)
+				pipe_ctx->dsc_padding_params.dsc_hactive_padding = 0;
+
+			dc_update_modified_pix_clock_for_dsc_with_padding(stream, &stream->timing, &pipe_ctx->dsc_padding_params);
+		}
+	}
+#endif
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 42b2a88d2d52..1b2c22545be3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -99,7 +99,7 @@ void update_stream_signal(struct dc_stream_state *stream, struct dc_sink *sink)
 
 		if (stream->link->frl_flags.force_frl_always ||
 				stream->link->frl_flags.force_frl_max
-				)
+				|| stream->link->frl_flags.force_frl_dsc)
 			stream->signal = SIGNAL_TYPE_HDMI_FRL;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 0cbb60325875..68e43961caa4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -121,6 +121,12 @@ struct frl_cap_chk_params_fixed31_32 {
 
 	bool     compressed;              /* set to true if DSC is enabled */
 	bool     bypass_hc_target_calc;   /* debug only */
+	bool     allow_all_bpp;           /* dsc_all_bpp */
+
+	/* DSC parameters */
+	int      slices;
+	int      slice_width;
+	struct fixed31_32   bpp_target;
 	int      layout;
 	int      acat;    /* not supported */
 
@@ -1152,6 +1158,7 @@ struct dc_debug_options {
 	int  select_ffe;
 	int  limit_ffe;
 	bool force_frl_always;
+	bool force_frl_dsc;
 	bool force_frl_max;
 	bool apply_vsdb_rcc_wa;
 	bool enable_hdmi_idcc;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index 7cb34e2b44a1..de169ed3b3b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -63,11 +63,19 @@ struct dc_dsc_config_options {
 	bool force_dsc_when_not_needed;
 };
 
+struct dc_dsc_primary_bpp {
+	uint32_t vic;
+	uint32_t target_bpp;
+};
 bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
 		const uint8_t *dpcd_dsc_basic_data,
 		const uint8_t *dpcd_dsc_ext_data,
 		struct dsc_dec_dpcd_caps *dsc_sink_caps);
 
+bool dc_dsc_parse_dsc_edid(const struct dc *dc,
+		const struct dc_edid_caps *edid_caps,
+		struct dsc_dec_dpcd_caps *dsc_sink_caps);
+
 bool dc_dsc_compute_bandwidth_range(
 		const struct display_stream_compressor *dsc,
 		uint32_t dsc_min_slice_height_override,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
index afd21eb6bbcd..5923a5f112a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
@@ -138,6 +138,7 @@ union hdmi_scdc_status_flags_data {
 		uint8_t LANE3_LOCKED:1;
 		uint8_t RESERVED:1;
 		uint8_t FLT_READY:1;
+		uint8_t DSC_DECODEFAIL:1;
 	} fields;
 };
 
@@ -270,6 +271,7 @@ struct dc_hdmi_frl_flags {
 	int  select_ffe;
 	int  limit_ffe;
 	bool force_frl_always;
+	bool force_frl_dsc;
 	bool force_frl_max;
 	bool apply_vsdb_rcc_wa;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index a690324f78dc..6f5a11d37899 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -782,6 +782,38 @@ void hpo_fpu_enc3_validate_hdmi_frl_output_link(struct hpo_frl_stream_encoder *e
 		break;
 	}
 
+	if (timing->flags.DSC &&
+			(unsigned int)frl_link_settings->frl_link_rate > dsc_max_rate) {
+		if (dsc_max_rate < HDMI_FRL_LINK_RATE_6GBPS_4LANE) {
+			frl_params->lanes = 3;
+		} else {
+			frl_params->lanes = 4;
+		}
+
+		switch (dsc_max_rate) {
+		case HDMI_FRL_LINK_RATE_3GBPS:
+			frl_params->r_bit_nominal = 3.0e9;
+			break;
+		case HDMI_FRL_LINK_RATE_6GBPS:
+		case HDMI_FRL_LINK_RATE_6GBPS_4LANE:
+			frl_params->r_bit_nominal = 6.0e9;
+			break;
+		case HDMI_FRL_LINK_RATE_8GBPS:
+			frl_params->r_bit_nominal = 8.0e9;
+			break;
+		case HDMI_FRL_LINK_RATE_10GBPS:
+		default:
+			frl_params->r_bit_nominal = 10.0e9;
+			break;
+		case HDMI_FRL_LINK_RATE_12GBPS:
+			frl_params->r_bit_nominal = 12.0e9;
+			break;
+		}
+	}
+
+	if (timing->flags.DSC && timing->rid > 0)
+		frl_params->is_ovt = true;
+
 	frl_params->f_pixel_clock_nominal = (double)timing->pix_clk_100hz * 100;
 	frl_params->h_active = timing->h_addressable + timing->h_border_left + timing->h_border_right;
 	frl_params->h_blank = timing->h_total - frl_params->h_active;
@@ -797,6 +829,12 @@ void hpo_fpu_enc3_validate_hdmi_frl_output_timing(
 
 	if (timing->flags.DSC) {
 		frl_params->compressed = true;
+		frl_params->slices = timing->dsc_cfg.num_slices_h;
+		frl_params->slice_width = (frl_params->h_active + frl_params->slices - 1) / frl_params->slices;
+		// If YCBCR420 slice width must be even
+		if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420 && frl_params->slice_width % 2 != 0)
+			frl_params->slice_width++;
+		frl_params->bpp_target = timing->dsc_cfg.bits_per_pixel / 16.0;
 	} else {
 		frl_params->compressed = false;
 	}
@@ -828,5 +866,5 @@ enum frl_cap_chk_result frl_fpu_cap_chk_compressed(struct hpo_frl_stream_encoder
 						   struct frl_cap_chk_intermediates *inter)
 {
 	(void)enc;
-	return -5;
+	return dml1_frl_cap_chk_compressed(params, inter);
 }
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 2a309e86f60f..33b5136f7ce3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -3359,6 +3359,9 @@ static double TruncToValidBPP(
 	hdmifrlparams.h_active = HActive;
 	hdmifrlparams.h_blank = HTotal - HActive;
 	hdmifrlparams.compressed = DSCEnable;
+	hdmifrlparams.slices = DSCSlices;
+	hdmifrlparams.slice_width = (int)dml_ceil((double) HActive / DSCSlices, 1.0);
+	hdmifrlparams.bpp_target = DesiredBPP;
 
 	if (Format == dm_420) {
 		NonDSCBPP0 = 12;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 261d90aaa3ad..bd14ebea1111 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -3665,6 +3665,9 @@ static double TruncToValidBPP(
 	hdmifrlparams.h_active = HActive;
 	hdmifrlparams.h_blank = HTotal - HActive;
 	hdmifrlparams.compressed = DSCEnable;
+	hdmifrlparams.slices = DSCSlices;
+	hdmifrlparams.slice_width = (int)dml_ceil((double) HActive / DSCSlices, 1.0);
+	hdmifrlparams.bpp_target = DesiredBPP;
 
 	if (Format == dm_420) {
 		NonDSCBPP0 = 12;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 674605d8d4fd..2ea5cf37f273 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -3771,6 +3771,9 @@ static double TruncToValidBPP(
 	hdmifrlparams.h_active = HActive;
 	hdmifrlparams.h_blank = HTotal - HActive;
 	hdmifrlparams.compressed = DSCEnable;
+	hdmifrlparams.slices = DSCSlices;
+	hdmifrlparams.slice_width = (int)dml_ceil((double) HActive / DSCSlices, 1.0);
+	hdmifrlparams.bpp_target = DesiredBPP;
 
 	if (Format == dm_420) {
 		NonDSCBPP0 = 12;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 40a0a5815ca5..ebf792fb22e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -1702,6 +1702,9 @@ double dml32_TruncToValidBPP(
 	hdmifrlparams.h_blank = HTotal - HActive;
 	hdmifrlparams.bpc = (int)(DesiredBPP / 3);
 	hdmifrlparams.compressed = DSCEnable;
+	hdmifrlparams.slices = DSCSlices;
+	hdmifrlparams.slice_width = (int)dml_ceil((double) HActive / DSCSlices, 1.0);
+	hdmifrlparams.bpp_target = DesiredBPP;
 
 	if (Format == dm_420) {
 		NonDSCBPP0 = 12;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
index 9dde4e56f237..327d89b66613 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
@@ -430,10 +430,207 @@ enum frl_cap_chk_result dml1_frl_cap_chk_uncompressed(struct frl_cap_chk_params
 	return FRL_CAP_CHK_OK;
 }
 
+enum frl_cap_chk_result dml1_frl_cap_chk_compressed(struct frl_cap_chk_params *params,
+						    struct frl_cap_chk_intermediates *inter)
+{
+	enum frl_cap_chk_result res;
+	int      c_frl_available;
+#if defined(DEBUG_FRL_CAP_CHK)
+	int      c_frl_active_available;
+	int      c_frl_blank_available;
+#endif
+	int      bytes_target = 0;
+	int      hc_active_target;
+	int      hc_blank_target_est1;
+	int      hc_blank_target_est2;
+	int      hc_blank_target = 0;
+	int      c_frl_actual_target_payload;
+	double   utilization_targeted;
+	double   margin_target;
+	double   f_tb_average;
+	double   t_active_ref;
+	double   t_blank_ref;
+	double   t_active_target;
+	double   t_blank_target;
+	double   tb_borrowed;
+#ifdef DEBUG_FRL_CAP_CHK
+	double   tb_delta;
+	double   tb_delta_limit;
+	int      tb_worst;
+#endif
+	int table_size_444 = ARRAY_SIZE(prim_format_444);
+	int table_size_422 = ARRAY_SIZE(prim_format_422);
+	int table_size_420 = ARRAY_SIZE(prim_format_420);
+	int i;
+	bool hc_active_blank_predefined = false;
+
+	dc_assert_fp_enabled();
+
+	res = dml1_frl_cap_chk_common(inter, params);
+
+	if (res != FRL_CAP_CHK_OK)
+		return res;
+
+	c_frl_available        = (int)dml_floor((1 - inter->overhead_max) * inter->c_frl_line, 1);
+#if defined(DEBUG_FRL_CAP_CHK)
+	c_frl_active_available = dml_floor(c_frl_available * ((double)params->h_active / (params->h_active + params->h_blank)), 1);
+	c_frl_blank_available  = dml_floor(c_frl_available * ((double)params->h_blank / (params->h_active + params->h_blank)), 1);
+#endif
+	bytes_target           = (int)(params->slices * dml_ceil(params->bpp_target * params->slice_width / 8.0, 1));
+
+	if (!params->bypass_hc_target_calc)
+			hc_active_target = (int)dml_ceil(bytes_target / 3.0, 1);
+	else
+		hc_active_target = params->borrow_params.hc_active_target;
+
+	if (!params->allow_all_bpp && params->vic != 0) {
+		if (params->pixel_encoding == HDMI_FRL_PIXEL_ENCODING_444) {
+			for (i = 0; i < table_size_444 ; i++) {
+				if (prim_format_444[i].vic == params->vic) {
+					params->borrow_params.hc_active_target = prim_format_444[i].hc_active;
+					params->borrow_params.hc_blank_target  = prim_format_444[i].hc_blank;
+					hc_active_blank_predefined = true;
+					break;
+				}
+			}
+		} else if (params->pixel_encoding == HDMI_FRL_PIXEL_ENCODING_422) {
+			for (i = 0; i < table_size_422 ; i++) {
+				if (prim_format_422[i].vic == params->vic) {
+					params->borrow_params.hc_active_target = prim_format_422[i].hc_active;
+					params->borrow_params.hc_blank_target  = prim_format_422[i].hc_blank;
+					hc_active_blank_predefined = true;
+					break;
+				}
+			}
+		} else if (params->pixel_encoding == HDMI_FRL_PIXEL_ENCODING_420) {
+			for (i = 0; i < table_size_420 ; i++) {
+				if (prim_format_420[i].vic == params->vic) {
+					params->borrow_params.hc_active_target = prim_format_420[i].hc_active;
+					params->borrow_params.hc_blank_target  = prim_format_420[i].hc_blank;
+					hc_active_blank_predefined = true;
+					break;
+				}
+			}
+		}
+
+		if (hc_active_blank_predefined) {
+			hc_active_target = params->borrow_params.hc_active_target;
+			hc_blank_target = params->borrow_params.hc_blank_target;
+		}
+	}
+
+	hc_blank_target_est1 = (int)dml_ceil(hc_active_target * ((double)params->h_blank / params->h_active), 1);
+	hc_blank_target_est2 = (int)dml_max(hc_blank_target_est1, inter->blank_audio_min);
+
+	if (!hc_active_blank_predefined) {
+		if (!params->bypass_hc_target_calc) {
+			hc_blank_target = (int)(4 * dml_floor(dml_min(hc_blank_target_est2, c_frl_available - 3.0 / 2.0 * hc_active_target) / 4.0, 1));
+
+			params->borrow_params.hc_active_target = hc_active_target;
+			params->borrow_params.hc_blank_target  = hc_blank_target;
+		} else {
+			hc_blank_target  = params->borrow_params.hc_blank_target;
+		}
+	}
+
+#ifdef DEBUG_FRL_CAP_CHK
+	{
+		frl_dump_var("%i", c_frl_available);
+		frl_dump_var("%i", c_frl_active_available);
+		frl_dump_var("%i", c_frl_blank_available);
+		frl_dump_var("%i", bytes_target);
+		frl_dump_var("%i", hc_active_target);
+		frl_dump_var("%i", hc_blank_target_est1);
+		frl_dump_var("%i", hc_blank_target_est2);
+		frl_dump_var("%i", hc_blank_target);
+	}
+#endif
+
+	if (!(inter->blank_audio_min <= hc_blank_target)) {
+		frl_dump_var("%i", inter->blank_audio_min);
+		frl_dump_var("%i", hc_blank_target);
+		return FRL_CAP_CHK_ERROR_AUDIO_BW;
+	}
+
+	f_tb_average    = inter->f_pixel_clock_max / (params->h_active + params->h_blank) * (hc_active_target + hc_blank_target);
+	t_active_ref    = inter->t_line * ((double)params->h_active / (params->h_active + params->h_blank));
+	t_blank_ref     = inter->t_line - t_active_ref; // * ((double) params->h_blank / (params->h_active + params->h_blank));
+	t_active_target = dml_max((hc_active_target / f_tb_average),
+				  (3.0 / 2.0 * hc_active_target) /
+				  (params->lanes * inter->r_frl_char_min * (1.0 - inter->overhead_max)));
+	t_blank_target  = inter->t_line - t_active_target;
+
+	tb_borrowed     = t_active_target * f_tb_average - hc_active_target;
+#ifdef DEBUG_FRL_CAP_CHK
+	tb_delta        = dcn_bw_fabs(t_active_target - t_active_ref) * (hc_active_target + hc_blank_target_est1) / inter->t_line;
+
+	{
+		frl_dump_var("%le", f_tb_average);
+		frl_dump_var("%le", t_active_ref);
+		frl_dump_var("%le", t_blank_ref);
+		frl_dump_var("%le", t_active_target);
+		frl_dump_var("%le", t_blank_target);
+		frl_dump_var("%le", tb_delta);
+	}
+#endif
+
+	if (t_blank_target - t_blank_ref > DBL_EPSILON) {
+#ifdef DEBUG_FRL_CAP_CHK
+		tb_delta_limit = (t_active_ref - hc_active_target / f_tb_average) * (hc_active_target + hc_blank_target_est1) / inter->t_line;
+#endif
+		params->borrow_params.borrow_mode = FRL_BORROW_MODE_FROM_ACTIVE;
+	} else if (t_active_target - t_active_ref > DBL_EPSILON) {
+#ifdef DEBUG_FRL_CAP_CHK
+		tb_delta_limit = tb_delta;
+#endif
+		params->borrow_params.borrow_mode = FRL_BORROW_MODE_FROM_BLANK;
+	} else {
+#ifdef DEBUG_FRL_CAP_CHK
+		tb_delta_limit = 0;
+#endif
+		params->borrow_params.borrow_mode = FRL_BORROW_MODE_NONE;
+	}
+
+#ifdef DEBUG_FRL_CAP_CHK
+	tb_worst = dml_ceil(dml_max(tb_borrowed, tb_delta_limit), 1);
+
+	{
+		frl_dump_var("%le", tb_delta_limit);
+		frl_dump_var("%le", tb_borrowed);
+		frl_dump_var("%i", params->borrow_params.borrow_mode);
+		frl_dump_var("%i", tb_worst);
+	}
+#endif
+
+	if (!(tb_borrowed <= TB_BORROWED_MAX))
+		return FRL_CAP_CHK_ERROR_MAX_BORROW;
+
+	c_frl_actual_target_payload = (int)(dml_ceil(3.0 / 2.0 * hc_active_target, 1) + hc_blank_target);
+	utilization_targeted        = c_frl_actual_target_payload / inter->c_frl_line;
+	margin_target               = 1.0 - (utilization_targeted + inter->overhead_max);
+
+#ifdef DEBUG_FRL_CAP_CHK
+	{
+		frl_dump_var("%i",  c_frl_actual_target_payload);
+		frl_dump_var("%le", utilization_targeted);
+		frl_dump_var("%le", margin_target);
+	}
+#endif
+
+	// oversubscribed bandwidth relative to margin
+	if (margin_target < 0 && dcn_bw_fabs(margin_target) > EPSILON)
+		return FRL_CAP_CHK_ERROR_MARGIN;
+
+	return FRL_CAP_CHK_OK;
+}
+
 enum frl_cap_chk_result dml1_frl_cap_chk(struct frl_cap_chk_params *params)
 {
 	struct frl_cap_chk_intermediates inter;
 
+	if (params->compressed)
+		return dml1_frl_cap_chk_compressed(params, &inter);
+
 	return dml1_frl_cap_chk_inter(params, &inter);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
index 545f498ea396..debe4c1dc0f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
@@ -119,6 +119,13 @@ struct frl_cap_chk_params {
 
 	bool     compressed;              /* set to true if DSC is enabled */
 	bool     bypass_hc_target_calc;   /* debug only */
+	bool     allow_all_bpp;           /* dsc_all_bpp */
+
+	/* DSC parameters */
+	int      slices;
+	int      slice_width;
+	double   bpp_target;
+	bool     is_ovt;
 	int      layout;
 	int      acat;    /* not supported */
 
@@ -138,6 +145,8 @@ enum frl_cap_chk_result dml1_frl_cap_chk_common(struct frl_cap_chk_intermediates
 enum frl_cap_chk_result dml1_frl_cap_chk_uncompressed(struct frl_cap_chk_params *params,
 						      struct frl_cap_chk_intermediates *inter);
 
+enum frl_cap_chk_result dml1_frl_cap_chk_compressed(struct frl_cap_chk_params *params,
+						    struct frl_cap_chk_intermediates *inter);
 #endif
 
 void frl_modified_pix_clock_for_dsc_padding(const int hc_active_target,
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 9aa5adb15103..ba4988118c68 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -151,6 +151,166 @@ uint32_t dc_bandwidth_in_kbps_from_timing(
 	return kbps;
 }
 
+const struct dc_dsc_primary_bpp prim_bpp_444[] = {
+	/* VIC/BPP */
+	{64,  192}, /* 1920x1080 @ 100 */
+	{77,  192}, /* 1920x1080 @ 100 */
+	{63,  192}, /* 1920x1080 @ 120 */
+	{78,  192}, /* 1920x1080 @ 120 */
+	{93,  192}, /* 3840x2160 @ 24 */
+	{103, 192}, /* 3840x2160 @ 24 */
+	{94,  192}, /* 3840x2160 @ 25 */
+	{104, 192}, /* 3840x2160 @ 25 */
+	{95,  192}, /* 3840x2160 @ 30 */
+	{105, 192}, /* 3840x2160 @ 30 */
+	{114, 192}, /* 3840x2160 @ 48 */
+	{116, 192}, /* 3840x2160 @ 48 */
+	{96,  192}, /* 3840x2160 @ 50 */
+	{106, 192}, /* 3840x2160 @ 50 */
+	{97,  192}, /* 3840x2160 @ 60 */
+	{107, 192}, /* 3840x2160 @ 60 */
+	{117, 192}, /* 3840x2160 @ 100 */
+	{119, 192}, /* 3840x2160 @ 100 */
+	{118, 192}, /* 3840x2160 @ 120 */
+	{120, 192}, /* 3840x2160 @ 120 */
+	{98,  192}, /* 4096x2160 @ 24 */
+	{99,  192}, /* 4096x2160 @ 25 */
+	{100, 192}, /* 4096x2160 @ 30 */
+	{115, 192}, /* 4096x2160 @ 48 */
+	{101, 192}, /* 4096x2160 @ 50 */
+	{102, 192}, /* 4096x2160 @ 60 */
+	{218, 192}, /* 4096x2160 @ 100 */
+	{219, 192}, /* 4096x2160 @ 120 */
+	{121, 192}, /* 5120x2160 @ 24 */
+	{122, 192}, /* 5120x2160 @ 25 */
+	{123, 192}, /* 5120x2160 @ 30 */
+	{124, 192}, /* 5120x2160 @ 48 */
+	{125, 192}, /* 5120x2160 @ 50 */
+	{126, 173}, /* 5120x2160 @ 60 */
+	{127, 192}, /* 5120x2160 @ 100 */
+	{193, 175}, /* 5120x2160 @ 120 */
+	{194, 192}, /* 7680x2160 @ 24 */
+	{202, 192}, /* 7680x2160 @ 24 */
+	{195, 192}, /* 7680x2160 @ 25 */
+	{203, 192}, /* 7680x2160 @ 25 */
+	{196, 192}, /* 7680x2160 @ 30 */
+	{204, 192}, /* 7680x2160 @ 30 */
+	{197, 157}, /* 7680x2160 @ 48 */
+	{205, 157}, /* 7680x2160 @ 48 */
+	{198, 157}, /* 7680x2160 @ 50 */
+	{206, 157}, /* 7680x2160 @ 50 */
+	{199, 159}, /* 7680x2160 @ 60 */
+	{207, 159}, /* 7680x2160 @ 60 */
+	{200, 134}, /* 7680x2160 @ 100 */
+	{208, 134}, /* 7680x2160 @ 100 */
+	{201, 130}, /* 7680x2160 @ 120 */
+	{209, 130}, /* 7680x2160 @ 120 */
+	{210, 182}, /* 10240x4320 @ 24 */
+	{211, 181}, /* 10240x4320 @ 25 */
+	{212, 177}, /* 10240x4320 @ 30 */
+	{213, 163}, /* 10240x4320 @ 48 */
+	{214, 162}, /* 10240x4320 @ 50 */
+	{215, 157}, /* 10240x4320 @ 60 */
+};
+const struct dc_dsc_primary_bpp prim_bpp_422[] = {
+	/* VIC/BPP */
+	{114, 192}, /* 3840x2160 @ 48 */
+	{116, 192}, /* 3840x2160 @ 48 */
+	{96,  192}, /* 3840x2160 @ 50 */
+	{106, 192}, /* 3840x2160 @ 50 */
+	{97,  192}, /* 3840x2160 @ 60 */
+	{107, 192}, /* 3840x2160 @ 60 */
+	{117, 137}, /* 3840x2160 @ 100 */
+	{119, 137}, /* 3840x2160 @ 100 */
+	{118, 113}, /* 3840x2160 @ 120 */
+	{120, 113}, /* 3840x2160 @ 120 */
+	{115, 192}, /* 4096x2160 @ 48 */
+	{101, 192}, /* 4096x2160 @ 50 */
+	{102, 192}, /* 4096x2160 @ 60 */
+	{218, 192}, /* 4096x2160 @ 100 */
+	{219, 192}, /* 4096x2160 @ 120 */
+	{121, 192}, /* 5120x2160 @ 24 */
+	{122, 192}, /* 5120x2160 @ 25 */
+	{123, 192}, /* 5120x2160 @ 30 */
+	{124, 192}, /* 5120x2160 @ 48 */
+	{125, 192}, /* 5120x2160 @ 50 */
+	{126, 173}, /* 5120x2160 @ 60 */
+	{127, 192}, /* 5120x2160 @ 100 */
+	{193, 175}, /* 5120x2160 @ 120 */
+	{194, 123}, /* 7680x2160 @ 24 */
+	{202, 123}, /* 7680x2160 @ 24 */
+	{195, 123}, /* 7680x2160 @ 25 */
+	{203, 123}, /* 7680x2160 @ 25 */
+	{196, 118}, /* 7680x2160 @ 30 */
+	{204, 118}, /* 7680x2160 @ 30 */
+	{197, 123}, /* 7680x2160 @ 48 */
+	{205, 123}, /* 7680x2160 @ 48 */
+	{198, 123}, /* 7680x2160 @ 50 */
+	{206, 123}, /* 7680x2160 @ 50 */
+	{199, 119}, /* 7680x2160 @ 60 */
+	{207, 119}, /* 7680x2160 @ 60 */
+	{200, 134}, /* 7680x2160 @ 100 */
+	{208, 134}, /* 7680x2160 @ 100 */
+	{201, 130}, /* 7680x2160 @ 120 */
+	{209, 130}, /* 7680x2160 @ 120 */
+	{210, 182}, /* 10240x4320 @ 24 */
+	{211, 181}, /* 10240x4320 @ 25 */
+	{212, 177}, /* 10240x4320 @ 30 */
+	{213, 126}, /* 10240x4320 @ 48 */
+	{214, 125}, /* 10240x4320 @ 50 */
+	{215, 117}, /* 10240x4320 @ 60 */
+	{216, 125}, /* 10240x4320 @ 100 */
+	{217, 117}, /* 10240x4320 @ 120 */
+};
+
+const struct dc_dsc_primary_bpp prim_bpp_420[] = {
+	/* VIC/BPP */
+	{114, 192}, /* 3840x2160 @ 48 */
+	{116, 192}, /* 3840x2160 @ 48 */
+	{96,  192}, /* 3840x2160 @ 50 */
+	{106, 192}, /* 3840x2160 @ 50 */
+	{97,  192}, /* 3840x2160 @ 60 */
+	{107, 192}, /* 3840x2160 @ 60 */
+	{117, 137}, /* 3840x2160 @ 100 */
+	{119, 137}, /* 3840x2160 @ 100 */
+	{118, 113}, /* 3840x2160 @ 120 */
+	{120, 113}, /* 3840x2160 @ 120 */
+	{115, 192}, /* 4096x2160 @ 48 */
+	{101, 192}, /* 4096x2160 @ 50 */
+	{102, 192}, /* 4096x2160 @ 60 */
+	{218, 129}, /* 4096x2160 @ 100 */
+	{219, 106}, /* 4096x2160 @ 120 */
+	{124, 192}, /* 5120x2160 @ 48 */
+	{125, 192}, /* 5120x2160 @ 50 */
+	{126, 173}, /* 5120x2160 @ 60 */
+	{127, 192}, /* 5120x2160 @ 100 */
+	{193, 175}, /* 5120x2160 @ 120 */
+	{194, 123}, /* 7680x4320 @ 24 */
+	{202, 123}, /* 7680x4320 @ 24 */
+	{195, 123}, /* 7680x4320 @ 25 */
+	{203, 123}, /* 7680x4320 @ 25 */
+	{196, 118}, /* 7680x4320 @ 30 */
+	{204, 118}, /* 7680x4320 @ 30 */
+	{197, 123}, /* 7680x4320 @ 48 */
+	{205, 123}, /* 7680x4320 @ 48 */
+	{198, 123}, /* 7680x4320 @ 50 */
+	{206, 123}, /* 7680x4320 @ 50 */
+	{199, 119}, /* 7680x4320 @ 60 */
+	{207, 119}, /* 7680x4320 @ 60 */
+	{200, 112}, /* 7680x4320 @ 100 */
+	{208, 112}, /* 7680x4320 @ 100 */
+	{201, 103}, /* 7680x4320 @ 120 */
+	{209, 103}, /* 7680x4320 @ 120 */
+	{210,  98}, /* 10240x4320 @ 24 */
+	{211,  98}, /* 10240x4320 @ 25 */
+	{212, 177}, /* 10240x4320 @ 30 */
+	{213,  98}, /* 10240x4320 @ 48 */
+	{214, 125}, /* 10240x4320 @ 50 */
+	{215, 117}, /* 10240x4320 @ 60 */
+	{216, 107}, /* 10240x4320 @ 100 */
+	{217,  97}, /* 10240x4320 @ 120 */
+};
+
 /* Forward Declerations */
 static unsigned int get_min_dsc_slice_count_for_odm(
 		const struct display_stream_compressor *dsc,
@@ -194,6 +354,15 @@ static bool setup_dsc_config(
 		int min_slice_count,
 		struct dc_dsc_config *dsc_cfg);
 
+static bool convert_bandwidth_to_frl_params(
+	int bandwidth_kbps,
+	int *num_lanes,
+	int *frl_rate);
+
+static uint32_t compute_bpp_x16_from_frl_params(
+		const struct dc_crtc_timing *timing,
+		const uint32_t num_slices_h,
+		const struct dsc_enc_caps *dsc_caps);
 static bool dsc_buff_block_size_from_dpcd(int dpcd_buff_block_size, int *buff_block_size)
 {
 
@@ -328,6 +497,207 @@ static bool dsc_bpp_increment_div_from_dpcd(uint8_t bpp_increment_dpcd, uint32_t
 
 
 
+static bool get_vic_preset_bpp(
+		const struct dc_crtc_timing *timing,
+		int *preset_bpp)
+{
+	bool preset_found = false;
+	uint32_t table_size_444 = ARRAY_SIZE(prim_bpp_444);
+	uint32_t table_size_422 = ARRAY_SIZE(prim_bpp_422);
+	uint32_t table_size_420 = ARRAY_SIZE(prim_bpp_420);
+	uint32_t i;
+	uint32_t vid_id;
+
+	if (timing->vic == 0 && timing->hdmi_vic == 0)
+		return false;
+
+	vid_id = timing->vic;
+	switch (timing->hdmi_vic) {
+	case 1:
+		vid_id = 95;
+		break;
+	case 2:
+		vid_id = 94;
+		break;
+	case 3:
+		vid_id = 93;
+		break;
+	case 4:
+		vid_id = 98;
+		break;
+	default:
+		break;
+	}
+
+	if (timing->pixel_encoding == PIXEL_ENCODING_RGB ||
+			timing->pixel_encoding == PIXEL_ENCODING_YCBCR444) {
+		for (i = 0; i < table_size_444 ; i++) {
+			if (prim_bpp_444[i].vic == vid_id) {
+				preset_found = true;
+				*preset_bpp = prim_bpp_444[i].target_bpp;
+				break;
+			}
+		}
+	} else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+		for (i = 0; i < table_size_422 ; i++) {
+			if (prim_bpp_422[i].vic == vid_id) {
+				preset_found = true;
+				*preset_bpp = prim_bpp_422[i].target_bpp;
+				break;
+			}
+		}
+	} else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420) {
+		for (i = 0; i < table_size_420 ; i++) {
+			if (prim_bpp_420[i].vic == vid_id) {
+				preset_found = true;
+				*preset_bpp = prim_bpp_420[i].target_bpp;
+				break;
+			}
+		}
+	} else {
+		return false;
+	}
+
+	return preset_found;
+}
+
+static int hdmi_dsc_get_num_slices(const struct dc_crtc_timing *timing)
+{
+	int k_slice_adjust = 1;
+	int adj_pix_clk_mhz;
+	int min_slices;
+	int slice_target;
+	int slice_width = timing->h_addressable;
+	int h_ratio_adj_pix_clk_mhz;
+
+	if (timing->pixel_encoding == PIXEL_ENCODING_RGB ||
+			timing->pixel_encoding == PIXEL_ENCODING_YCBCR444)
+		k_slice_adjust = 2;
+
+	adj_pix_clk_mhz = k_slice_adjust * timing->pix_clk_100hz / 10000 / 2;
+	h_ratio_adj_pix_clk_mhz = adj_pix_clk_mhz * timing->h_addressable / timing->h_total;
+	if (adj_pix_clk_mhz <= 2720) {
+		min_slices = adj_pix_clk_mhz / 340;
+		if (adj_pix_clk_mhz % 340 != 0)
+			min_slices++;
+	} else if (adj_pix_clk_mhz <= 4800) {
+		min_slices = adj_pix_clk_mhz / 400;
+		if (adj_pix_clk_mhz % 400 != 0)
+			min_slices++;
+	} else if (h_ratio_adj_pix_clk_mhz <= 4800) {
+		min_slices = h_ratio_adj_pix_clk_mhz / 600;
+		if (h_ratio_adj_pix_clk_mhz % 600 != 0)
+			min_slices++;
+	} else {
+		min_slices = h_ratio_adj_pix_clk_mhz / 900;
+		if (h_ratio_adj_pix_clk_mhz % 900 != 0)
+			min_slices++;
+	}
+
+	do {
+		if (min_slices <= 1)
+			slice_target = 1;
+		else if (min_slices <= 2)
+			slice_target = 2;
+		else if (min_slices <= 4)
+			slice_target = 4;
+		else if (min_slices <= 8)
+			slice_target = 8;
+		else if (min_slices <= 12)
+			slice_target = 12;
+		else if (min_slices <= 16)
+			slice_target = 16;
+		else
+			return 0;
+
+		slice_width = timing->h_addressable / slice_target;
+		min_slices++;
+	} while (slice_width > 2720);
+
+	return slice_target;
+}
+
+static int hdmi_dsc_get_bpp(const struct dc_crtc_timing *timing,
+		const struct dsc_enc_caps *dsc_common_caps)
+{
+	int max_dsc_bpp, min_dsc_bpp;
+	int target_bytes;
+	bool bpp_found = false;
+	int bpp_decrement_x16;
+	int src_fractional_bpp = dsc_common_caps->bpp_increment_div;
+	int bpp_target;
+	int bpp_target_x16;
+	int bpc_factor = 8;
+	int slice_width;
+	int num_slices;
+	bool hdmi_all_bpp = dsc_common_caps->is_vic_all_bpp;
+	int hdmi_max_chunk_bytes = dsc_common_caps->total_chunk_kbytes;
+
+	int preset_bpp;
+	bool preset_found = false;
+
+	if (timing->display_color_depth == COLOR_DEPTH_101010)
+		bpc_factor = 10;
+	if (timing->display_color_depth == COLOR_DEPTH_121212)
+		bpc_factor = 12;
+
+	/* Assuming: bpc as 8*/
+	if (timing->pixel_encoding == PIXEL_ENCODING_RGB ||
+			timing->pixel_encoding == PIXEL_ENCODING_YCBCR444) {
+		min_dsc_bpp = 8;
+		max_dsc_bpp = 3 * bpc_factor;
+	} else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+		min_dsc_bpp = 7;
+		max_dsc_bpp = 2 * bpc_factor;
+	} else {
+		min_dsc_bpp = 6;
+		max_dsc_bpp = 3 * bpc_factor / 2;
+	}
+
+	if (!hdmi_all_bpp)
+		max_dsc_bpp = min(max_dsc_bpp, 12);
+
+
+	num_slices = hdmi_dsc_get_num_slices(timing);
+	if (num_slices == 0)
+		return 0;
+
+	slice_width = timing->h_addressable / num_slices;
+
+	bpp_target = max_dsc_bpp;
+	bpp_decrement_x16 = 16 / src_fractional_bpp;
+	bpp_target_x16 = (bpp_target * 16) - bpp_decrement_x16;
+	if (!hdmi_all_bpp)
+			bpp_target_x16 = (bpp_target * 16);
+
+	/* check if byte target is below allowed Kbytes */
+	while (bpp_target_x16 > (min_dsc_bpp * 16)) {
+		target_bytes = num_slices * slice_width * bpp_target_x16 / 16 / 8;
+		if (target_bytes <= hdmi_max_chunk_bytes) {
+			bpp_found = true;
+			break;
+		}
+		bpp_target_x16 -= bpp_decrement_x16;
+	}
+
+	if (bpp_found) {
+		if (!hdmi_all_bpp) {
+			/* Get preset bpp for CTA modes */
+			preset_found = get_vic_preset_bpp(timing, &preset_bpp);
+			if (preset_found) {
+				bpp_target_x16 = preset_bpp;
+				target_bytes =
+						num_slices * slice_width * bpp_target_x16 / 16 / 8;
+				if (target_bytes > hdmi_max_chunk_bytes)
+					return 0;
+			}
+		}
+		return bpp_target_x16;
+	}
+
+	return 0;
+}
+
 bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
 		const uint8_t *dpcd_dsc_basic_data,
 		const uint8_t *dpcd_dsc_branch_decoder_caps,
@@ -450,6 +820,104 @@ bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
 	dsc_sink_caps->is_dp = true;
 	return true;
 }
+bool dc_dsc_parse_dsc_edid(const struct dc *dc, const struct dc_edid_caps *edid_caps,
+		struct dsc_dec_dpcd_caps *dsc_sink_caps)
+{
+	(void)dc;
+	dsc_sink_caps->is_dsc_supported = edid_caps->frl_dsc_support;
+	if (!edid_caps->frl_dsc_support)
+		return false;
+
+	dsc_sink_caps->dsc_version = 0x21;
+	dsc_sink_caps->is_frl = true;
+	dsc_sink_caps->is_dp = false;
+
+	switch (edid_caps->frl_dsc_max_slices) {
+	case 0:
+		break;
+	case 1:
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_1 = 1;
+		dsc_sink_caps->throughput_mode_0_mps = 340;
+		dsc_sink_caps->throughput_mode_1_mps = 680;
+		break;
+	case 2:
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_1 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_2 = 1;
+		dsc_sink_caps->throughput_mode_0_mps = 340;
+		dsc_sink_caps->throughput_mode_1_mps = 680;
+		break;
+	case 3:
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_1 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_2 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_4 = 1;
+		dsc_sink_caps->throughput_mode_0_mps = 340;
+		dsc_sink_caps->throughput_mode_1_mps = 680;
+		break;
+	case 4:
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_1 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_2 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_4 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_8 = 1;
+		dsc_sink_caps->throughput_mode_0_mps = 340;
+		dsc_sink_caps->throughput_mode_1_mps = 680;
+		break;
+	case 5:
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_1 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_2 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_4 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_8 = 1;
+		dsc_sink_caps->throughput_mode_0_mps = 400;
+		dsc_sink_caps->throughput_mode_1_mps = 800;
+		break;
+	case 6:
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_1 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_2 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_4 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_8 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_12 = 1;
+		dsc_sink_caps->throughput_mode_0_mps = 400;
+		dsc_sink_caps->throughput_mode_1_mps = 800;
+		break;
+	case 7:
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_1 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_2 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_4 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_8 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_12 = 1;
+		dsc_sink_caps->throughput_mode_0_mps = 600;
+		dsc_sink_caps->throughput_mode_1_mps = 1200;
+		break;
+	case 8:
+	default:
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_1 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_2 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_4 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_8 = 1;
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_12 = 1;
+		dsc_sink_caps->throughput_mode_0_mps = 900;
+		dsc_sink_caps->throughput_mode_1_mps = 1800;
+		break;
+	}
+	dsc_sink_caps->lb_bit_depth = 13; //Table 7-25
+	dsc_sink_caps->is_block_pred_supported = true; //Table 7-25
+	dsc_sink_caps->color_formats.bits.RGB = 1;
+	dsc_sink_caps->color_formats.bits.YCBCR_444 = 1;
+	dsc_sink_caps->color_formats.bits.YCBCR_NATIVE_422 = 1;
+	dsc_sink_caps->color_formats.bits.YCBCR_NATIVE_420 =
+			(edid_caps->frl_dsc_native_420 == true) ? 1 : 0;
+	dsc_sink_caps->color_depth.bits.COLOR_DEPTH_8_BPC = 1;
+	dsc_sink_caps->color_depth.bits.COLOR_DEPTH_10_BPC =
+			(edid_caps->frl_dsc_10bpc == true) ? 1 : 0;
+	dsc_sink_caps->color_depth.bits.COLOR_DEPTH_12_BPC =
+			(edid_caps->frl_dsc_12bpc == true) ? 1 : 0;
+	dsc_sink_caps->max_slice_width = 2560;
+	dsc_sink_caps->bpp_increment_div = 16; /* bpp increment divisor, e.g. if 16, it's 1/16th of a bit */
+	dsc_sink_caps->is_vic_all_bpp = edid_caps->frl_dsc_all_bpp;
+	dsc_sink_caps->total_chunk_kbytes =
+			1024 * (1 + edid_caps->frl_dsc_total_chunk_kbytes);
+
+	return true;
+}
 
 /* If DSC is possbile, get DSC bandwidth range based on [min_bpp, max_bpp] target bitrate range and
  * timing's pixel clock and uncompressed bandwidth.
@@ -757,6 +1225,9 @@ static bool intersect_dsc_caps(
 	if (pixel_encoding == PIXEL_ENCODING_YCBCR422 || pixel_encoding == PIXEL_ENCODING_YCBCR420)
 		dsc_common_caps->bpp_increment_div = min(dsc_common_caps->bpp_increment_div, (uint32_t)8);
 
+	dsc_common_caps->is_frl = dsc_sink_caps->is_frl;
+	dsc_common_caps->is_vic_all_bpp = dsc_sink_caps->is_vic_all_bpp;
+	dsc_common_caps->total_chunk_kbytes = dsc_sink_caps->total_chunk_kbytes;
 	dsc_common_caps->edp_sink_max_bits_per_pixel = dsc_sink_caps->edp_max_bits_per_pixel;
 	dsc_common_caps->is_dp = dsc_sink_caps->is_dp;
 	return true;
@@ -786,6 +1257,191 @@ static uint32_t compute_bpp_x16_from_target_bandwidth(
 	return dc_fixpt_floor(bpp_x16);
 }
 
+static bool convert_bandwidth_to_frl_params(
+	int bandwidth_kbps,
+	int *num_lanes,
+	int *frl_rate)
+{
+	if (bandwidth_kbps == 0)
+		return false;
+
+	switch (bandwidth_kbps) {
+	case 9000000:
+		*num_lanes = 3;
+		*frl_rate = 3000;
+		break;
+	case 18000000:
+		*num_lanes = 3;
+		*frl_rate = 6000;
+		break;
+	case 24000000:
+		*num_lanes = 4;
+		*frl_rate = 6000;
+		break;
+	case 32000000:
+		*num_lanes = 4;
+		*frl_rate = 8000;
+		break;
+	case 40000000:
+		*num_lanes = 4;
+		*frl_rate = 10000;
+		break;
+	case 48000000:
+		*num_lanes = 4;
+		*frl_rate = 12000;
+		break;
+	default:
+		return false;
+	}
+	return true;
+}
+
+static uint32_t compute_bpp_x16_from_frl_params(
+		const struct dc_crtc_timing *timing,
+		const uint32_t num_slices_h,
+		const struct dsc_enc_caps *dsc_caps)
+{
+	struct fixed31_32 pixel_clock;
+	uint32_t num_lanes = dsc_caps->num_lanes;
+	uint32_t frl_rate = dsc_caps->frl_rate;
+	uint32_t h_active = timing->h_addressable;
+	uint32_t h_blank = timing->h_total - timing->h_addressable;
+	uint32_t bpp_target_x16;
+	struct fixed31_32 r_bit;
+	uint32_t f_audio = 48000;
+	struct fixed31_32 pixel_rate_tolerance;
+	uint32_t audio_tolerance = 1000;
+	uint32_t frl_bit_tolerance = 300;
+	uint32_t acr_rate_max = 1500;
+	uint32_t c_frl_cb = 510;
+	uint32_t c_frl_sb;
+	struct fixed31_32 overhead_sb;
+	struct fixed31_32 overhead_rs;
+	struct fixed31_32 overhead_map;
+	struct fixed31_32 overhead_min;
+	struct fixed31_32 overhead_m;
+	struct fixed31_32 overhead_max;
+	struct fixed31_32 pixel_clock_max;
+	struct fixed31_32 t_line;
+	struct fixed31_32 r_bit_min;
+	struct fixed31_32 r_frl_char_min;
+	struct fixed31_32 c_frl_line;
+	uint32_t c_frl_line_int;
+	struct fixed31_32 c_frl_available;
+	uint32_t c_frl_av_int;
+	struct fixed31_32 c_frl_active_av;
+	struct fixed31_32 c_frl_blank_av;
+	uint32_t acat_ap = 4;
+	struct fixed31_32 r_ap;
+	struct fixed31_32 max_audio_tol_rate;
+	struct fixed31_32 avg_audio_packets_line;
+	uint32_t avg_audio_packets_line_int;
+	int hc_blank_audio_min;
+	uint32_t bytes_target;
+	uint32_t hc_active_target;
+	uint32_t hc_blank_target_est1;
+	uint32_t hc_blank_target_est2;
+	struct fixed31_32 hc_blank_target_bandwidth;
+	int hc_blank_target;
+	uint32_t bpc_factor = 8;
+	uint32_t min_dsc_bpp_x16;
+	uint32_t max_dsc_bpp_x16;
+	bool hdmi_all_bpp = dsc_caps->is_vic_all_bpp;
+	uint32_t slice_width;
+
+	if (timing->display_color_depth == COLOR_DEPTH_101010)
+		bpc_factor = 10;
+	if (timing->display_color_depth == COLOR_DEPTH_121212)
+		bpc_factor = 12;
+
+	/* Assuming: bpc as 8*/
+	if (timing->pixel_encoding == PIXEL_ENCODING_RGB ||
+			timing->pixel_encoding == PIXEL_ENCODING_YCBCR444) {
+		min_dsc_bpp_x16 = 8 * 16;
+		max_dsc_bpp_x16 = 3 * 16 * bpc_factor;
+	} else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+		min_dsc_bpp_x16 = 7 * 16;
+		max_dsc_bpp_x16 = 2 * 16 * bpc_factor;
+	} else {
+		min_dsc_bpp_x16 = 6 * 16;
+		max_dsc_bpp_x16 = 3 * 16 * bpc_factor / 2;
+	}
+
+	max_dsc_bpp_x16 = MIN(max_dsc_bpp_x16, 256);
+	if (!hdmi_all_bpp)
+		max_dsc_bpp_x16 = MIN(max_dsc_bpp_x16, 192);
+
+	c_frl_sb = 4 * c_frl_cb + num_lanes;
+	pixel_clock = dc_fixpt_div_int(dc_fixpt_from_int(timing->pix_clk_100hz), 10000);
+	r_bit = dc_fixpt_from_int(frl_rate);
+	pixel_rate_tolerance = dc_fixpt_div_int(dc_fixpt_from_int(5), 1000);
+	overhead_sb = dc_fixpt_div_int(dc_fixpt_from_int(num_lanes), c_frl_sb);
+	overhead_rs = dc_fixpt_div_int(dc_fixpt_from_int(32), c_frl_sb);
+	overhead_map = dc_fixpt_div_int(dc_fixpt_from_int(25), (c_frl_sb * 10));
+	overhead_min = dc_fixpt_add(overhead_sb, overhead_rs);
+	overhead_min = dc_fixpt_add(overhead_min, overhead_map);
+	overhead_m = dc_fixpt_div_int(dc_fixpt_from_int(3), 1000);
+	overhead_max = dc_fixpt_add(overhead_min, overhead_m);
+	pixel_rate_tolerance = dc_fixpt_add_int(pixel_rate_tolerance, 1);
+	pixel_clock_max = dc_fixpt_mul(pixel_clock, pixel_rate_tolerance);
+	t_line = dc_fixpt_div(dc_fixpt_from_int(h_active + h_blank), pixel_clock_max);
+	r_bit_min = dc_fixpt_div_int(dc_fixpt_from_int(frl_bit_tolerance), 1000000);
+	r_bit_min = dc_fixpt_sub(dc_fixpt_from_int(1), r_bit_min);
+	r_bit_min = dc_fixpt_mul(r_bit, r_bit_min);
+	r_frl_char_min = dc_fixpt_div_int(r_bit_min, 18);
+	c_frl_line = dc_fixpt_mul(t_line, r_frl_char_min);
+	c_frl_line = dc_fixpt_mul_int(c_frl_line, num_lanes);
+	c_frl_line_int = dc_fixpt_floor(c_frl_line);
+	c_frl_available = dc_fixpt_sub(dc_fixpt_from_int(1), overhead_max);
+	c_frl_available = dc_fixpt_mul_int(c_frl_available, c_frl_line_int);
+	c_frl_av_int = dc_fixpt_floor(c_frl_available);
+	c_frl_active_av = dc_fixpt_mul_int(dc_fixpt_from_int(c_frl_av_int), h_active);
+	c_frl_active_av = dc_fixpt_div_int(c_frl_active_av, (h_active + h_blank));
+	c_frl_blank_av = dc_fixpt_mul_int(dc_fixpt_from_int(c_frl_av_int), h_blank);
+	c_frl_blank_av =  dc_fixpt_div_int(c_frl_blank_av, (h_active + h_blank));
+	r_ap = dc_fixpt_max(dc_fixpt_from_int(192000),
+			dc_fixpt_from_int(f_audio * acat_ap));
+	r_ap = dc_fixpt_add(r_ap, dc_fixpt_from_int(2 * acr_rate_max));
+	max_audio_tol_rate =  dc_fixpt_div_int(dc_fixpt_from_int(audio_tolerance), 1000000);
+	max_audio_tol_rate =  dc_fixpt_add(dc_fixpt_from_int(1), max_audio_tol_rate);
+	r_ap = dc_fixpt_mul(r_ap, max_audio_tol_rate);
+	avg_audio_packets_line = dc_fixpt_mul(r_ap, t_line);
+	avg_audio_packets_line = dc_fixpt_div_int(avg_audio_packets_line, 1000000);
+	avg_audio_packets_line_int = dc_fixpt_ceil(avg_audio_packets_line);
+	hc_blank_audio_min = 32 + 32 * avg_audio_packets_line_int;
+	slice_width = dc_fixpt_ceil(dc_fixpt_div_int(
+			dc_fixpt_from_int(h_active), num_slices_h));
+
+	/* Slice width for 420 must be even */
+	if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420 && slice_width % 2 != 0) {
+		slice_width++;
+	}
+
+	for (uint32_t i = max_dsc_bpp_x16; i >= min_dsc_bpp_x16; i--) {
+		bpp_target_x16 = i;
+		bytes_target = num_slices_h * dc_fixpt_ceil(dc_fixpt_div_int(
+				dc_fixpt_from_int(bpp_target_x16 * slice_width), 8 * 16));
+		hc_active_target = dc_fixpt_ceil(dc_fixpt_div_int(
+				dc_fixpt_from_int(bytes_target), 3));
+		hc_blank_target_est1 = dc_fixpt_ceil(dc_fixpt_div_int(
+				dc_fixpt_from_int(hc_active_target * h_blank), h_active));
+		hc_blank_target_est2 = dc_fixpt_floor(dc_fixpt_max(
+				dc_fixpt_from_int(hc_blank_target_est1),
+				dc_fixpt_from_int(hc_blank_audio_min)));
+		hc_blank_target_bandwidth = dc_fixpt_div_int(dc_fixpt_from_int(3), 2);
+		hc_blank_target_bandwidth = dc_fixpt_mul(hc_blank_target_bandwidth,
+				dc_fixpt_from_int(hc_active_target));
+		hc_blank_target_bandwidth = dc_fixpt_sub(dc_fixpt_from_int(c_frl_av_int),
+				hc_blank_target_bandwidth);
+		hc_blank_target_bandwidth = dc_fixpt_min(hc_blank_target_bandwidth,
+				dc_fixpt_from_int(hc_blank_target_est2));
+		hc_blank_target_bandwidth = dc_fixpt_div_int(hc_blank_target_bandwidth, 4);
+		hc_blank_target = dc_fixpt_floor(hc_blank_target_bandwidth) * 4;
+		if (hc_blank_target >= hc_blank_audio_min)
+			return bpp_target_x16;
+	}
+	return 0;
+}
 /* Decide DSC bandwidth range based on signal, timing, specs specific and input min and max
  * requirements.
  * The range output includes decided min/max target bpp, the respective bandwidth requirements
@@ -812,6 +1468,30 @@ static bool decide_dsc_bandwidth_range(
 			range->min_target_bpp_x16 = preferred_bpp_x16;
 		}
 	}
+	else if (dsc_caps->is_frl) {
+		uint32_t specs_preferred_bpp_x16 = hdmi_dsc_get_bpp(timing, dsc_caps);
+		uint32_t specs_calculated_bpp_x16 = 0;
+
+		if (timing->vic) {
+			/* For CTA timing, we should strictly follow HDMI spec. */
+			range->max_target_bpp_x16 = specs_preferred_bpp_x16;
+			if (dsc_caps->is_vic_all_bpp || dsc_caps->is_dp)
+				range->min_target_bpp_x16 = min_bpp_x16;
+			else
+				range->min_target_bpp_x16 = specs_preferred_bpp_x16;
+		} else {
+			if (timing->vic == 0 && timing->hdmi_vic == 0)
+				specs_calculated_bpp_x16 = compute_bpp_x16_from_frl_params(
+						timing, num_slices_h, dsc_caps);
+
+			if (specs_calculated_bpp_x16 != 0)
+				specs_preferred_bpp_x16 = MIN(specs_calculated_bpp_x16,
+						specs_preferred_bpp_x16);
+
+			range->max_target_bpp_x16 = MIN(max_bpp_x16, specs_preferred_bpp_x16);
+			range->min_target_bpp_x16 = min_bpp_x16;
+		}
+	}
 	/* TODO - make this value generic to all signal types */
 	else if (dsc_caps->edp_sink_max_bits_per_pixel) {
 		/* apply max bpp limitation from edp sink */
@@ -878,6 +1558,10 @@ static bool decide_dsc_target_bpp_x16(
 					dsc_common_caps->bpp_increment_div,
 					dsc_common_caps->is_dp);
 		}
+		/* Assign minimum bpp and validate TB borrow scenario later */
+		if (target_bandwidth_kbps < range.min_kbps)
+			if (dsc_common_caps->is_frl)
+				*target_bpp_x16 = range.min_target_bpp_x16;
 	}
 
 	return *target_bpp_x16 != 0;
@@ -1063,6 +1747,8 @@ static bool setup_dsc_config(
 	int pic_height;
 	int slice_height;
 	struct dc_dsc_policy policy;
+	int num_lanes;
+	int frl_rate;
 
 	memset(dsc_cfg, 0, sizeof(struct dc_dsc_config));
 
@@ -1081,6 +1767,11 @@ static bool setup_dsc_config(
 	is_dsc_possible = intersect_dsc_caps(dsc_sink_caps, dsc_enc_caps, timing->pixel_encoding, &dsc_common_caps);
 	if (!is_dsc_possible)
 		goto done;
+	if (convert_bandwidth_to_frl_params(
+					target_bandwidth_kbps, &num_lanes, &frl_rate)) {
+		dsc_common_caps.num_lanes = num_lanes;
+		dsc_common_caps.frl_rate = frl_rate;
+	}
 
 	sink_per_slice_throughput_mps = 0;
 
@@ -1204,6 +1895,8 @@ static bool setup_dsc_config(
 		else
 			is_dsc_possible = false;
 	}
+	if (dsc_sink_caps->is_frl)
+		num_slices_h = hdmi_dsc_get_num_slices(timing);
 	// When we force ODM, num dsc h slices must be divisible by num odm h slices
 	switch (options->dsc_force_odm_hslice_override) {
 	case 0:
@@ -1282,6 +1975,11 @@ static bool setup_dsc_config(
 	dsc_cfg->block_pred_enable = dsc_common_caps.is_block_pred_supported;
 	dsc_cfg->linebuf_depth = dsc_common_caps.lb_bit_depth;
 	dsc_cfg->version_minor = (dsc_common_caps.dsc_version & 0xf0) >> 4;
+	dsc_cfg->is_frl = dsc_sink_caps->is_frl;
+	if (dsc_cfg->is_frl)
+		dsc_cfg->num_slices_h = num_slices_h;
+	dsc_cfg->is_vic_all_bpp = dsc_sink_caps->is_vic_all_bpp;
+	dsc_cfg->total_chunk_kbytes = dsc_sink_caps->total_chunk_kbytes;
 	dsc_cfg->is_dp = dsc_sink_caps->is_dp;
 
 done:
@@ -1408,6 +2106,12 @@ void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
 		/* DP specs limits to 3 x bpc */
 		policy->max_target_bpp = 3 * bpc;
 		policy->ycbcr422_simple = true;
+		if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422 && link_encoding == DC_LINK_ENCODING_HDMI_FRL) {
+			/* HDMI FRL YCbCr422 native support */
+			policy->min_target_bpp = 7;
+			policy->max_target_bpp = 2 * bpc;
+			policy->ycbcr422_simple = false;
+		}
 		break;
 	case PIXEL_ENCODING_YCBCR420:
 		/* DP specs limits to 6 */
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
index cd7d2bb661e5..cff5c95a771c 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
@@ -216,6 +216,16 @@ void hpo_enc3_set_hdmi_stream_attribute(struct hpo_frl_stream_encoder *enc,
 		break;
 	}
 
+	/* When compression active, CD/PP/Phase field shall be zero in GCP */
+	if (crtc_timing->flags.DSC) {
+		REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
+				HDMI_DEEP_COLOR_DEPTH, 0,
+				HDMI_DEEP_COLOR_ENABLE, 0);
+	} else {
+		REG_UPDATE(HDMI_TB_ENC_PIXEL_FORMAT,
+			HDMI_DSC_MODE, 0);
+	}
+
 	/* Configure ODM combine mode */
 	switch (odm_combine_num_segments) {
 	case 1:
@@ -457,6 +467,94 @@ void hpo_enc3_update_hdmi_info_packet(struct dcn30_hpo_frl_stream_encoder *enc3,
 	}
 }
 
+void hpo_enc3_hdmi_set_dsc_config(
+	struct hpo_frl_stream_encoder *enc,
+	struct dc_crtc_timing *timing,
+	uint8_t *dsc_packed_pps)
+{
+	struct dcn30_hpo_frl_stream_encoder *enc3 = DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
+	enum optc_dsc_mode dsc_mode = OPTC_DSC_DISABLED;
+	uint8_t i;
+
+	if (dsc_packed_pps) {
+		if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420 ||
+				(timing->pixel_encoding == PIXEL_ENCODING_YCBCR422
+					&& !timing->dsc_cfg.ycbcr422_simple))
+			dsc_mode = OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
+		else
+			dsc_mode = OPTC_DSC_ENABLED_444;
+	}
+
+	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
+			FIFO_DSC_MODE, dsc_mode);
+
+	REG_UPDATE(HDMI_TB_ENC_PIXEL_FORMAT,
+			HDMI_DSC_MODE, dsc_mode);
+
+	/* 5 packets for hdmi 2.1, use generic packets 5-10 to transmit*/
+	/* TODO: do we change new bit to 0 after first transmission? Do we set End bit when exiting dsc? */
+	if (dsc_mode != OPTC_DSC_DISABLED) {
+		struct dc_info_packet emp_packet = {0};
+		uint32_t dsc_pic_width = timing->h_addressable + timing->h_border_left + timing->h_border_right;
+		uint32_t h_back = timing->h_total - dsc_pic_width - timing->h_sync_width - timing->h_front_porch;
+		/* HCactivebytes = Slices * ceil(SliceWidth * bpp/8)
+		 * use ... + 15) / 16 to achieve ceil since bpp is stored as 16x actual value
+		 */
+		uint32_t h_cactive_bytes = timing->dsc_cfg.num_slices_h * (
+				(dsc_pic_width / timing->dsc_cfg.num_slices_h * timing->dsc_cfg.bits_per_pixel / 8 + 15) / 16);
+
+		/* Packet 0 */
+		emp_packet.valid = true;
+		emp_packet.hb0 = 0x7F; /* Default */
+		emp_packet.hb1 = (1 << 7); /* First */
+		emp_packet.hb2 = 0; /* Sequence index */
+		emp_packet.sb[0] = (1 << 1) | (1 << 2) | (1 << 7); /* Sync[1] = 1, VFR[2] = 1, New[7] = 1*/
+		emp_packet.sb[2] = 1; /* Organization_ID = 1 (Vesa spec)*/
+		emp_packet.sb[4] = 2; /* Data_Set_Tag(LSB) = 2*/
+		emp_packet.sb[6] = 136; /* Data_Set_Length(LSB) = 136*/
+		memcpy(&emp_packet.sb[7], dsc_packed_pps, 21);
+		hpo_enc3_update_hdmi_info_packet(enc3, 5, &emp_packet);
+
+		/* Packets 1-3 */
+		emp_packet.hb1 = 0; /* Not first or last*/
+		for (i = 1; i < 4; i++) {
+			emp_packet.hb2 = i; /* Sequence index */
+			memcpy(&emp_packet.sb[0], &dsc_packed_pps[21 + 28 * (i - 1)], 28);
+			hpo_enc3_update_hdmi_info_packet(enc3, 5 + i, &emp_packet);
+		}
+
+		/* Packet 4 */
+		emp_packet.hb2 = 4; /* Sequence index */
+		memcpy(&emp_packet.sb[0], &dsc_packed_pps[105], 23);
+		emp_packet.sb[23] = (uint8_t)timing->h_front_porch; /* Hfront[7:0] */
+		emp_packet.sb[24] = (uint8_t)(timing->h_front_porch >> 8); /* Hfront[15:8] */
+		emp_packet.sb[25] = (uint8_t)timing->h_sync_width; /* Hsync[7:0] */
+		emp_packet.sb[26] = (uint8_t)(timing->h_sync_width >> 8); /* Hsync[15:8] */
+		emp_packet.sb[27] = (uint8_t)h_back; /* Hback[7:0] */
+		hpo_enc3_update_hdmi_info_packet(enc3, 9, &emp_packet);
+
+		/* Packet 5 */
+		emp_packet.hb1 = (1 << 6); /* Last */
+		emp_packet.hb2 = 5;
+		emp_packet.sb[0] = (uint8_t)(h_back >> 8); /* Hback[15:8] */
+		emp_packet.sb[1] = (uint8_t)h_cactive_bytes; /* HCactive_bytes[7:0] */
+		emp_packet.sb[2] = (uint8_t)(h_cactive_bytes >> 8); /* HCactive_bytes[15:8] */
+		hpo_enc3_update_hdmi_info_packet(enc3, 10, &emp_packet);
+
+		/* Packet 0 - Clear New[7] */
+		emp_packet.valid = true;
+		emp_packet.hb0 = 0x7F; /* Default */
+		emp_packet.hb1 = (1 << 7); /* First */
+		emp_packet.hb2 = 0; /* Sequence index */
+		emp_packet.sb[0] = (1 << 1) | (1 << 2); /* Sync[1] = 1, VFR[2] = 1*/
+		emp_packet.sb[2] = 1; /* Organization_ID = 1 (Vesa spec)*/
+		emp_packet.sb[4] = 2; /* Data_Set_Tag(LSB) = 2*/
+		emp_packet.sb[6] = 136; /* Data_Set_Length(LSB) = 136*/
+		memcpy(&emp_packet.sb[7], dsc_packed_pps, 21);
+		hpo_enc3_update_hdmi_info_packet(enc3, 5, &emp_packet);
+	}
+}
+
 void hpo_enc3_stop_hdmi_info_packets(
 	struct hpo_frl_stream_encoder *enc)
 {
@@ -777,12 +875,18 @@ bool hpo_enc3_validate_hdmi_frl_output(
 	default:
 		break;
 	}
+	frl_params.allow_all_bpp = timing->dsc_cfg.is_vic_all_bpp;
 	if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420)
 		frl_params.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_420;
 	else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422)
 		frl_params.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_422;
 	else
 		frl_params.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_444;
+	/* DSC parameters */
+	frl_params.bypass_hc_target_calc = false;
+	DC_FP_START();
+	hpo_fpu_enc3_validate_hdmi_frl_output_timing(timing, audio, &frl_params);
+	DC_FP_END();
 	/* Audio parameters */
 	/* TODO: set Audio parameters */
 
@@ -910,6 +1014,7 @@ static const struct hpo_frl_stream_encoder_funcs dcn30_str_enc_funcs = {
 	.set_avmute			= enc3_stream_encoder_set_avmute,
 	.validate_hdmi_frl_output	= hpo_enc3_validate_hdmi_frl_output,
 	.read_state			= hpo_enc3_read_state,
+	.hdmi_frl_set_dsc_config	= hpo_enc3_hdmi_set_dsc_config,
 	.set_dynamic_metadata           = hpo_enc3_set_dynamic_metadata,
 	.hdmi_frl_fifo_odm_enabled = hpo_enc3_fifo_odm_enabled,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
index 27f7ffd89629..28cb14dc87b0 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
@@ -879,6 +879,7 @@ static const struct hpo_frl_stream_encoder_funcs dcn401_str_enc_funcs = {
 	.hdmi_audio_disable		= hpo_enc401_hdmi_audio_disable,
 	.set_avmute			= enc401_stream_encoder_set_avmute,
 	.read_state			= hpo_enc401_read_state,
+	.hdmi_frl_set_dsc_config	= hpo_enc401_hdmi_set_dsc_config,
 	.set_dynamic_metadata           = hpo_enc401_set_dynamic_metadata,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
index 0ec386347f80..d4f66e62c729 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
@@ -179,6 +179,7 @@ static const struct hpo_frl_stream_encoder_funcs dcn42_str_enc_funcs = {
 	.hdmi_audio_disable		= hpo_enc42_hdmi_audio_disable,
 	.set_avmute			= enc401_stream_encoder_set_avmute,
 	.read_state			= hpo_enc401_read_state,
+	.hdmi_frl_set_dsc_config	= hpo_enc401_hdmi_set_dsc_config,
 	.set_dynamic_metadata           = hpo_enc401_set_dynamic_metadata,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
index 2306354e90af..a963d360a368 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
@@ -85,9 +85,6 @@ int dcn30_hw_get_max_fva_factor(struct dc *dc,
 		struct dc_crtc_timing *timing,
 		unsigned int max_pixel_clock);
 
-void dcn30_hw_set_vstartup_dsc_frl(struct dc *dc,
-		struct pipe_ctx *pipe_ctx);
-
 bool dcn30_does_plane_fit_in_mall(struct dc *dc,
 		unsigned int pitch,
 		unsigned int height,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index a9569078622f..dfb278a9fc3e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1710,6 +1710,8 @@ void hwss_hpo_dp_stream_enc_dp_set_dsc_pps_info_packet(union block_sequence_para
 
 void hwss_stream_enc_dp_set_dsc_pps_info_packet(union block_sequence_params *params);
 
+void hwss_hpo_frl_stream_enc_set_dsc_config(union block_sequence_params *params);
+
 void hwss_set_dmdata_attributes(union block_sequence_params *params);
 
 void hwss_dp_trace_source_sequence(union block_sequence_params *params);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 22d5f291c7db..2b95cb11eede 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -369,6 +369,10 @@ struct hpo_frl_stream_encoder {
  * stream interfaces for setup the FRL stream encoder.
  */
 struct hpo_frl_stream_encoder_funcs {
+	void (*hdmi_frl_set_dsc_config)(
+		struct hpo_frl_stream_encoder *enc,
+		struct dc_crtc_timing *timing,
+		uint8_t *dsc_packed_pps);
 	/**
 	 * @hdmi_frl_enable:
 	 *
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index e4e17f630e97..2eaba65894ab 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -498,7 +498,6 @@ struct timing_generator_funcs {
 	int (*get_max_hw_supported_fva_factor)(struct timing_generator *optc,
 		struct dc_crtc_timing *timing,
 		unsigned int max_pixclk_100hz);
-	void (*set_vstartup_dsc_frl)(struct timing_generator *optc);
 	void (*set_vtotal_change_limit)(struct timing_generator *optc,
 			uint32_t limit);
 	void (*align_vblanks)(struct timing_generator *master_optc,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 9096b34fc35f..194db125cd1c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -549,6 +549,8 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 
 	/* dig front end */
 	config.dig_fe = (uint8_t) pipe_ctx->stream_res.stream_enc->stream_enc_inst;
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
+		config.dig_fe = (uint8_t)pipe_ctx->stream_res.hpo_frl_stream_enc->stream_enc_inst;
 
 	/* stream encoder index */
 	config.stream_enc_idx = (uint8_t)(pipe_ctx->stream_res.stream_enc->id - ENGINE_ID_DIGA);
@@ -785,6 +787,22 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 
 			/* PPS SDP is set elsewhere because it has to be done after DIG FE is connected to DIG BE */
 		}
+		else if (dc_is_hdmi_frl_signal(stream->signal)) {
+			uint8_t dsc_packed_pps[128];
+			struct dc_crtc_timing patched_crtc_timing = stream->timing;
+
+			DC_LOG_DSC("Setting stream encoder DSC config for engine %d:", (int)pipe_ctx->stream_res.hpo_frl_stream_enc->id);
+			dsc_optc_config_log(dsc, &dsc_optc_cfg);
+
+			/* if we are borrowing from hblank, h_addressable and  pic_width need to be adjusted */
+			if (dc->debug.enable_hblank_borrow) {
+				dsc_cfg.pic_width = stream->timing.h_addressable;
+			}
+
+			dsc->funcs->dsc_get_packed_pps(dsc, &dsc_cfg, &dsc_packed_pps[0]);
+			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
+					pipe_ctx->stream_res.hpo_frl_stream_enc, &patched_crtc_timing, &dsc_packed_pps[0]);
+		}
 
 		/* Enable DSC in OPTC */
 		DC_LOG_DSC("Setting optc DSC config for tg instance %d:", pipe_ctx->stream_res.tg->inst);
@@ -816,6 +834,9 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 							pipe_ctx->stream_res.stream_enc, false, NULL, true);
 			}
 		}
+		else if (dc_is_hdmi_frl_signal(stream->signal))
+			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
+					pipe_ctx->stream_res.hpo_frl_stream_enc, &stream->timing, NULL);
 
 		/* disable DSC block */
 		for (odm_pipe = pipe_ctx; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
@@ -903,6 +924,12 @@ bool link_set_dsc_pps_packet(struct pipe_ctx *pipe_ctx, bool enable, bool immedi
 						&dsc_packed_pps[0],
 						immediate_update);
 		}
+		else if (dc_is_hdmi_frl_signal(stream->signal)) {
+			//TODO: bring HDMI FRL in line with DP
+			DC_LOG_DSC("Setting stream encoder DSC PPS SDP for engine %d\n", (int)pipe_ctx->stream_res.hpo_frl_stream_enc->id);
+			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
+					pipe_ctx->stream_res.hpo_frl_stream_enc, &stream->timing, &dsc_packed_pps[0]);
+		}
 	} else {
 		/* disable DSC PPS in stream encoder */
 		memset(&stream->dsc_packed_pps[0], 0, sizeof(stream->dsc_packed_pps));
@@ -917,6 +944,10 @@ bool link_set_dsc_pps_packet(struct pipe_ctx *pipe_ctx, bool enable, bool immedi
 				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
 						pipe_ctx->stream_res.stream_enc, false, NULL, true);
 		}
+		else if (dc_is_hdmi_frl_signal(stream->signal))
+			//TODO: bring HDMI FRL in line with DP
+			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
+					pipe_ctx->stream_res.hpo_frl_stream_enc, &stream->timing, NULL);
 	}
 
 	return true;
@@ -2424,6 +2455,8 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 	if (pipe_ctx->stream->timing.flags.DSC) {
 		if (dc_is_dp_signal(pipe_ctx->stream->signal))
 			link_set_dsc_enable(pipe_ctx, false);
+		else if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
+			link_set_dsc_on_stream(pipe_ctx, false);
 	}
 	if (dp_is_128b_132b_signal(pipe_ctx)) {
 		if (pipe_ctx->stream_res.tg->funcs->set_out_mux)
@@ -2604,6 +2637,11 @@ void link_set_dpms_on(
 		}
 	}
 
+	if (pipe_ctx->stream->timing.flags.DSC &&
+			dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
+			//TODO: bring HDMI FRL in line with DP
+			link_set_dsc_on_stream(pipe_ctx, true);
+
 	/* turn off otg test pattern if enable */
 	if (pipe_ctx->stream_res.tg->funcs->set_test_pattern)
 		pipe_ctx->stream_res.tg->funcs->set_test_pattern(pipe_ctx->stream_res.tg,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index 9087f786d6c9..c35074177a36 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -92,6 +92,25 @@ static void hdmi_return_preeshoot_and_deemphasis(struct dc_link *link,
 	}
 }
 
+static bool hdmi_frl_test_dsc_max_rate(struct ddc_service *ddc_service)
+{
+	uint8_t slave_address = HDMI_SCDC_ADDRESS;
+	uint8_t offset = HDMI_SCDC_SOURCE_TEST_REQ;
+	union hdmi_scdc_source_test_req test_req = {0};
+
+	DC_LOGGER_INIT(ddc_service->link->ctx->logger);
+
+	link_query_ddc_data(ddc_service, slave_address,
+					&offset, sizeof(offset), &test_req.byte,
+					sizeof(test_req.byte));
+	if (test_req.fields.DSC_FRL_MAX) {
+		FRL_INFO("FRL TEST REQ:  DSC_FRL_MAX = 1");
+		return true;
+	}
+
+	return false;
+}
+
 enum clock_source_id hdmi_frl_find_matching_phypll(
 		struct dc_link *link)
 {
@@ -767,6 +786,9 @@ void hdmi_frl_verify_link_cap(struct dc_link *link,
 			link->preferred_hdmi_frl_settings.force_frl_max ||
 			link->ctx->dc->debug.force_frl_max ? true :
 			hdmi_frl_test_max_rate(link->ddc);
+	link->frl_flags.force_frl_dsc =
+			link->ctx->dc->debug.force_frl_dsc ? true :
+			hdmi_frl_test_dsc_max_rate(link->ddc);
 	link->frl_flags.apply_vsdb_rcc_wa =
 			link->ctx->dc->debug.apply_vsdb_rcc_wa;
 
@@ -778,8 +800,16 @@ void hdmi_frl_verify_link_cap(struct dc_link *link,
 			link->frl_flags.force_frl_always = true;
 
 	if (!link->frl_flags.force_frl_max &&
+			!link->frl_flags.force_frl_dsc &&
 			link->local_sink->edid_caps.panel_patch.hdmi_comp_auto) {
 		link->frl_flags.force_frl_max = true;
+		link->frl_flags.force_frl_dsc = true;
+	}
+
+	if (link->frl_flags.force_frl_max &&
+			!link->frl_flags.force_frl_dsc &&
+			link->local_sink->edid_caps.panel_patch.hdmi_comp_auto) {
+		link->frl_flags.force_frl_dsc = true;
 	}
 
 	if (link->local_sink &&
@@ -996,6 +1026,9 @@ void hdmi_frl_set_preferred_link_settings(struct dc *dc,
 			resource_build_info_frame(pipe);
 			link_stream->ctx->dc->hwss.update_info_frame(pipe);
 
+			if (link_stream->timing.flags.DSC)
+				link_set_dsc_on_stream(pipe, true);
+
 			link_stream->ctx->dc->hwss.enable_audio_stream(pipe);
 			link_stream->ctx->dc->hwss.enable_stream(pipe);
 			link_stream->ctx->dc->hwss.unblank_stream(pipe,
@@ -1106,6 +1139,10 @@ void hdmi_frl_decide_link_settings(struct dc_stream_state *stream,
 		*frl_link_settings = stream->link->frl_verified_link_cap;
 		return;
 	}
+	if (stream->link->frl_flags.force_frl_dsc) {
+		*frl_link_settings = stream->link->frl_verified_link_cap;
+		return;
+	}
 
 	if (stream->link->local_sink)
 		if (stream->link->local_sink->edid_caps.panel_patch.hdmi_spe_handling) {
@@ -1128,6 +1165,7 @@ void hdmi_frl_decide_link_settings(struct dc_stream_state *stream,
 	} while (!success);
 
 	*frl_link_settings = temp_settings;
+	update_borrow_mode_from_dsc_padding(dsc_padding_params, &stream->timing, frl_link_settings);
 }
 
 void hdmi_frl_write_read_request_enable(struct ddc_service *ddc_service)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
index d72574db1f07..90ec4cb8a9dd 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
@@ -189,7 +189,13 @@ void optc3_set_dsc_config(struct timing_generator *optc,
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
 	optc2_set_dsc_config(optc, dsc_mode, dsc_bytes_per_pixel, dsc_slice_width);
-	REG_UPDATE(OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, 0);
+
+	if (dsc_mode != OPTC_DSC_DISABLED
+			&& optc1->signal == SIGNAL_TYPE_HDMI_FRL) {
+		REG_UPDATE(OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, 1);
+	} else {
+		REG_UPDATE(OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, 0);
+	}
 }
 
 void optc3_set_odm_bypass(struct timing_generator *optc,
-- 
2.54.0

