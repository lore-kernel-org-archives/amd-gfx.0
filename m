Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385F0C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 16:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C94AF10E1EB;
	Fri,  8 Jul 2022 16:36:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 454B510E215
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 16:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANWnD+5vJbmbDXBdrrRvSYX3Xn/Tw0TsPKkiINbOUdsf1qBfXmxSB9ftUvh6Nsc71umlNGJl1AIS98TvQt8KTMSoBG107zeV9BU/o3+vLf5Pe58Mm5YPdZY3vw6Hb9fkl4JqglXI+HVBjw1ZXRuXRGox84ejBhbsK6iifIv7FLAVpNKqTy4A5IxXKyM4g58LQAOs3PNM6DYi8ln17FAd7eyZCwO0H9cVoyIj7X97f81cqks93/17XBeYbHbyzXTGjbLGDXbvIuw9nheqY0+ELrP8pBLCiYtkFTMDZjvmngBw9rA+cLh6VoU9jH0bQhTxHA/UXY0cYzgXszDH5PoDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipwj2ZhhKguX8yYZOdSd64VTYqtrzQbk/Vr5enMXyKs=;
 b=iUpT6DsMLLRUoDs9CxmNohzZVMVNt2LbMsP8ate1BpA8ItJRI8cUr4Kowlrd0S0dO1ax2DklYwkBgPwbsKIrDRZ8/BszoF/+KaT3QFj4AgjpJXu0tZffhcxi35yr7c3bLML6e2uVS3SDTYJEo97Qm7CEp1sZwBthMHuSegdNdtjME5w9v5b5Aa7NXmdUpvppVUL2rlrlXyWBl7+kID4W8FAso7BN4UWlQD2aPqXJvQR+9GpNBx69EZc8M67CmRbZLR023Bz0S1Vo4/dUb2r69NmIvItYwyKF9bLc8jj6SNMbRQqNAOmLq/k1/Mm+NI+eLVyD7aaXQAlVS9bT5VYm1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipwj2ZhhKguX8yYZOdSd64VTYqtrzQbk/Vr5enMXyKs=;
 b=eSk2Iffos9e5Ag74Wxf0G1p0LsE0joYv60CbXLUMF+X2y1m9zLKjY19C/GYtNi3rBH6xoXlB8k+H/rjujtGxxfdu8F6n6m2u48+2XE1jwOxLyqTSCH1SOX/u69IhzezaDlr1Ysk9D2GpPT0LDtmhrQZfu0aUGdoZ1gmoaT2SNeI=
Received: from BN0PR04CA0001.namprd04.prod.outlook.com (2603:10b6:408:ee::6)
 by CY4PR12MB1239.namprd12.prod.outlook.com (2603:10b6:903:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Fri, 8 Jul
 2022 16:36:18 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::8f) by BN0PR04CA0001.outlook.office365.com
 (2603:10b6:408:ee::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Fri, 8 Jul 2022 16:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 16:36:18 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 11:36:13 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/21] drm/amd/display: Helper function for ALPM initialization
Date: Sat, 9 Jul 2022 00:35:11 +0800
Message-ID: <20220708163529.3534276-4-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aab8b893-0bc6-44d6-f2a5-08da60fffbdf
X-MS-TrafficTypeDiagnostic: CY4PR12MB1239:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25D7JrCe2peKUPGDYACLAXuz/hYMfUHjgGFRWjwnirEbLn0byI6Om4uBHu1Vi1Ad4HL/sz9pMII04zD36ccHAA7nYcmVVmk6evnLeUgA5P+l4TW0xy5WMVlXuiaJhtiwpTQmPu58TEyg2NfLBuIbh4mVWB1YVTJXoCjqDe4XJ92h3HiGkm4NEIN/87JxH2EWU+b2R5Mz4qGW1r+dg40hiIPSGyw9jlhBV6+sWQq5fG8H3aGwSyw3VFMuBK+wJPUS32jgHYpFpDLCa0ipkvn9BZqCXFObB3uSqHhlfzqYYDilIa2W/E5qEH3TOH2HKRBIPxUQbIs/hDEEjQ0Y+scKNE/VmUJBDwCZuYSP35xpivQi3F3dNl1iw52iT9X+WenjLd37foyVGHaIs/If+nSNn1VEVpK9fSMkNmgT/XGYjOfu4wxl0AN0pZry2JjFhXwHqGpzemZRTWSS+wde1XdCcprr1MA9dzwoVvRjTGODioj4Wz/nd5Ef2nKYVIMK5sfDdUrmSD9llxDXiD3w0+Nbkosg5IXkuVt1Ot6Ygo9KTSE96+3557X6VT4IdBWgIL6gjR67ix+5UxEu5ZZ9kV/H8TrrX4O13/+mDkVJJuQbl4zO5e4I5W5U1epse0cJlDNNuWP1bc/FdnnFs3bqc3SSj7+i3JilRANaOSWlGh0TTyW15iqxs1I8Q+mf6NPdldfRE8Xx02h8YBJ0enByFVYwsrbrJyFsvKZuYcL4OYH7j/LficKWAMqFUb9WqdIjl5jhODjRj/7yZyjSb46R8fcNHYqJRPgP8mTw3tkcvGmz0X8k19tDbjW6TtOcJM9UrAqcLbLamlDhPiroHeAl6cxSDij2eyMMrZ7RELHTDJWDGQDovQHAtteUGJGHkx2+nK9u
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966006)(40470700004)(36840700001)(40460700003)(2616005)(26005)(7696005)(36756003)(186003)(478600001)(2906002)(34020700004)(47076005)(316002)(1076003)(336012)(16526019)(8676002)(44832011)(40480700001)(82740400003)(356005)(70206006)(82310400005)(41300700001)(4326008)(5660300002)(426003)(83380400001)(86362001)(36860700001)(54906003)(6916009)(70586007)(8936002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 16:36:18.4406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aab8b893-0bc6-44d6-f2a5-08da60fffbdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1239
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, muansari <muansari@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: muansari <muansari@amd.com>

[WHY]
Needed a helper function for ALPM DPCD initialization

[HOW]
Refactoring to put ALPM initialization in a helper function

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Muhammad Ansari <muansari@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 27 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  2 ++
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 335ca5b14fa7..dbdeda60e9e2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2734,6 +2734,22 @@ static void enable_link_lvds(struct pipe_ctx *pipe_ctx)
 
 }
 
+bool dc_power_alpm_dpcd_enable(struct dc_link *link, bool enable)
+{
+	bool ret = false;
+	union dpcd_alpm_configuration alpm_config;
+
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1) {
+		memset(&alpm_config, 0, sizeof(alpm_config));
+
+		alpm_config.bits.ENABLE = (enable ? true : false);
+		ret = dm_helpers_dp_write_dpcd(link->ctx, link,
+				DP_RECEIVER_ALPM_CONFIG, &alpm_config.raw,
+				sizeof(alpm_config.raw));
+	}
+	return ret;
+}
+
 /****************************enable_link***********************************/
 static enum dc_status enable_link(
 		struct dc_state *state,
@@ -3228,7 +3244,6 @@ bool dc_link_setup_psr(struct dc_link *link,
 	unsigned int panel_inst;
 	/* updateSinkPsrDpcdConfig*/
 	union dpcd_psr_configuration psr_configuration;
-	union dpcd_alpm_configuration alpm_configuration;
 	union dpcd_sink_active_vtotal_control_mode vtotal_control = {0};
 
 	psr_context->controllerId = CONTROLLER_ID_UNDEFINED;
@@ -3284,15 +3299,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 		sizeof(psr_configuration.raw));
 
 	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1) {
-		memset(&alpm_configuration, 0, sizeof(alpm_configuration));
-
-		alpm_configuration.bits.ENABLE = 1;
-		dm_helpers_dp_write_dpcd(
-			link->ctx,
-			link,
-			DP_RECEIVER_ALPM_CONFIG,
-			&alpm_configuration.raw,
-			sizeof(alpm_configuration.raw));
+		dc_power_alpm_dpcd_enable(link, true);
 		psr_context->su_granularity_required =
 			psr_config->su_granularity_required;
 		psr_context->su_y_granularity =
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 29c0040a6dd4..023774b94da3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -320,6 +320,8 @@ bool dc_link_setup_psr(struct dc_link *dc_link,
 		const struct dc_stream_state *stream, struct psr_config *psr_config,
 		struct psr_context *psr_context);
 
+bool dc_power_alpm_dpcd_enable(struct dc_link *link, bool enable);
+
 void dc_link_get_psr_residency(const struct dc_link *link, uint32_t *residency);
 
 void dc_link_blank_all_dp_displays(struct dc *dc);
-- 
2.25.1

