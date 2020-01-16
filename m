Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BD7C33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04A6220663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ekkBQych"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A6220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC676E27F;
	Thu, 16 Jan 2020 20:14:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23AD36E25D
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avV1fqLEwBxs+kB/jN9y8HHvEKVy4W3xZ83au+NdrFHvU5XvMu519N7n2cPxLT57/vvDwwTq/ZTjpCxCxp9r2kfazKf0yud78P3g6DW/fKqKuXCubGq4kbutSYcGG/7V9mIcPZ8BaE/+nO2SmiWSdBr/celUbrAOD1F4EC8BvC8uP8MK1VCz/2hq2b0TQ59i2naxfI1KUWAyFxXdX1h5dUuapVFrXe3dzYeAjsz+L1LfCgwTfmCCiTQ2KA7+5r/Bd+Pj2gXtb/PBQamcj1DrT0Pk3ojZjmC/5xbDWuXV9dA8GjjEu/MihbVYToRxfX2+8m4GeWfm7WTT3IXrEgwG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjt8FxPu2i4rlBdzZSU5JWeljvd3LsjfpTfhapDPBPI=;
 b=lRbSIEvQdZ2mzXjpZRjvAFj8lqfWWIdUg/kIwo3u4kS5v20XNSfEvR6dvY7PpNZb5BgI6eJ/XmlpYLbzC6rAhg9rm/y/DqWsNsFiL1dViHriCE4LLH9r95/ezQRabqVsYgDel6JiE8wuHcGViAYhwtki/LdW7Mu9UPLzT2l5mvlKGJDWQhM/E7Mgpq5vbwOiMMb/IfkLyPVygrx0OdZGHZpTPbJjJYkelAf2Mwyw7qcBb6d1cQs5CjnWITtRB4iQovgYZZyKE8wwryQQLvd/sCDGq9tlVlfZtv8Io5smm58MmY8fByxoQvV4+iyB6CrRBdi4a4CYI8KdYbZIOn+7vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjt8FxPu2i4rlBdzZSU5JWeljvd3LsjfpTfhapDPBPI=;
 b=ekkBQych5lsQgQIgQRRjJXyen+utHmtv3KP9YdmGTIL6Q+yO5Jv+JoGsJWDfW3sgbjo5IBiFNMfLOQ/xr1nn9tuS6NSxZTYrzd+XzGsWV6k2x9SQzbut2mmxkB0VBYND1+2EKSZNABQrTnKDFv5wrIDSWXNItE7nOashF49sZ7E=
Received: from DM5PR12CA0010.namprd12.prod.outlook.com (2603:10b6:4:1::20) by
 CY4PR1201MB0021.namprd12.prod.outlook.com (2603:10b6:910:1a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Thu, 16 Jan
 2020 20:14:25 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by DM5PR12CA0010.outlook.office365.com
 (2603:10b6:4:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:25 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:24 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:24 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:24 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/22] drm/amd/display: Fallback to DMCUB when command table
 is missing
Date: Thu, 16 Jan 2020 15:14:01 -0500
Message-ID: <20200116201418.2254-6-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(396003)(376002)(428003)(199004)(189003)(336012)(26005)(70586007)(70206006)(186003)(1076003)(2906002)(36756003)(426003)(6666004)(478600001)(4326008)(7696005)(356004)(6916009)(5660300002)(86362001)(81166006)(81156014)(8676002)(54906003)(8936002)(2616005)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0021; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bacd918-403f-4ab4-e6fe-08d79ac0aeae
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0021:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00214673949AFC8C8F461D95F9360@CY4PR1201MB0021.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUt1mHvtH3tRbHXkQWICmGVV7fC1Py+HMD4UH+GcQ79sXAa3hnzvcKBzQQWaxuDPSPgHlmLN+9lVos4zJM5Zv0TThF5w3G6EFN2TZWcrfkoPFgdFdVdVmGsSTLb0tIxFEEcWAl2v/cw7KniyYWZeCyz+xL6izA00v9OnqO+PNBaXAEnDOU6Xo0FHAk70nah2trgvnBw0pEDQYpp+yLWxSJ30GiSQzM/LES69k6KezxDc8eevngvkrNkCweBPjF3MFgCIoCQ0Azcho0uejKsXQQm3O1or5rRUDlXlFBj2kpH3wbBpKWvk3Qy+4l63RxHGxbg4bLQ4QTdod2rnxZp+s5ZPFHufm374K6hVi8ynP177AeP6tHxOZEgd+LXLeRNwr29fjn13xJZc7CUzHesihavXgpkGq2Wl8vGjoPV4bFI3ENx8yOsZoJakdepNgMMk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:25.0290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bacd918-403f-4ab4-e6fe-08d79ac0aeae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0021
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
If the command table isn't available then we can fallback to DMCUB
offloading if it's enabled and available.

[How]
Instead of assigning NULL for supported command table functions we can
fallback to the DMCUB when it's available.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../drm/amd/display/dc/bios/command_table2.c  | 74 ++++++++++++++++++-
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index 2cb7a4288cb7..c4ba6e84db65 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -89,6 +89,10 @@ static enum bp_result encoder_control_digx_v1_5(
 	struct bios_parser *bp,
 	struct bp_encoder_control *cntl);
 
+static enum bp_result encoder_control_fallback(
+	struct bios_parser *bp,
+	struct bp_encoder_control *cntl);
+
 static void init_dig_encoder_control(struct bios_parser *bp)
 {
 	uint32_t version =
@@ -100,7 +104,7 @@ static void init_dig_encoder_control(struct bios_parser *bp)
 		break;
 	default:
 		dm_output_to_console("Don't have dig_encoder_control for v%d\n", version);
-		bp->cmd_tbl.dig_encoder_control = NULL;
+		bp->cmd_tbl.dig_encoder_control = encoder_control_fallback;
 		break;
 	}
 }
@@ -184,6 +188,18 @@ static enum bp_result encoder_control_digx_v1_5(
 	return result;
 }
 
+static enum bp_result encoder_control_fallback(
+	struct bios_parser *bp,
+	struct bp_encoder_control *cntl)
+{
+	if (bp->base.ctx->dc->ctx->dmub_srv &&
+	    bp->base.ctx->dc->debug.dmub_command_table) {
+		return encoder_control_digx_v1_5(bp, cntl);
+	}
+
+	return BP_RESULT_FAILURE;
+}
+
 /*****************************************************************************
  ******************************************************************************
  **
@@ -196,6 +212,10 @@ static enum bp_result transmitter_control_v1_6(
 	struct bios_parser *bp,
 	struct bp_transmitter_control *cntl);
 
+static enum bp_result transmitter_control_fallback(
+	struct bios_parser *bp,
+	struct bp_transmitter_control *cntl);
+
 static void init_transmitter_control(struct bios_parser *bp)
 {
 	uint8_t frev;
@@ -209,7 +229,7 @@ static void init_transmitter_control(struct bios_parser *bp)
 		break;
 	default:
 		dm_output_to_console("Don't have transmitter_control for v%d\n", crev);
-		bp->cmd_tbl.transmitter_control = NULL;
+		bp->cmd_tbl.transmitter_control = transmitter_control_fallback;
 		break;
 	}
 }
@@ -273,6 +293,18 @@ static enum bp_result transmitter_control_v1_6(
 	return result;
 }
 
+static enum bp_result transmitter_control_fallback(
+	struct bios_parser *bp,
+	struct bp_transmitter_control *cntl)
+{
+	if (bp->base.ctx->dc->ctx->dmub_srv &&
+	    bp->base.ctx->dc->debug.dmub_command_table) {
+		return transmitter_control_v1_6(bp, cntl);
+	}
+
+	return BP_RESULT_FAILURE;
+}
+
 /******************************************************************************
  ******************************************************************************
  **
@@ -285,6 +317,10 @@ static enum bp_result set_pixel_clock_v7(
 	struct bios_parser *bp,
 	struct bp_pixel_clock_parameters *bp_params);
 
+static enum bp_result set_pixel_clock_fallback(
+	struct bios_parser *bp,
+	struct bp_pixel_clock_parameters *bp_params);
+
 static void init_set_pixel_clock(struct bios_parser *bp)
 {
 	switch (BIOS_CMD_TABLE_PARA_REVISION(setpixelclock)) {
@@ -294,7 +330,7 @@ static void init_set_pixel_clock(struct bios_parser *bp)
 	default:
 		dm_output_to_console("Don't have set_pixel_clock for v%d\n",
 			 BIOS_CMD_TABLE_PARA_REVISION(setpixelclock));
-		bp->cmd_tbl.set_pixel_clock = NULL;
+		bp->cmd_tbl.set_pixel_clock = set_pixel_clock_fallback;
 		break;
 	}
 }
@@ -400,6 +436,18 @@ static enum bp_result set_pixel_clock_v7(
 	return result;
 }
 
+static enum bp_result set_pixel_clock_fallback(
+	struct bios_parser *bp,
+	struct bp_pixel_clock_parameters *bp_params)
+{
+	if (bp->base.ctx->dc->ctx->dmub_srv &&
+	    bp->base.ctx->dc->debug.dmub_command_table) {
+		return set_pixel_clock_v7(bp, bp_params);
+	}
+
+	return BP_RESULT_FAILURE;
+}
+
 /******************************************************************************
  ******************************************************************************
  **
@@ -632,6 +680,11 @@ static enum bp_result enable_disp_power_gating_v2_1(
 	enum controller_id crtc_id,
 	enum bp_pipe_control_action action);
 
+static enum bp_result enable_disp_power_gating_fallback(
+	struct bios_parser *bp,
+	enum controller_id crtc_id,
+	enum bp_pipe_control_action action);
+
 static void init_enable_disp_power_gating(
 	struct bios_parser *bp)
 {
@@ -643,7 +696,7 @@ static void init_enable_disp_power_gating(
 	default:
 		dm_output_to_console("Don't enable_disp_power_gating enable_crtc for v%d\n",
 			 BIOS_CMD_TABLE_PARA_REVISION(enabledisppowergating));
-		bp->cmd_tbl.enable_disp_power_gating = NULL;
+		bp->cmd_tbl.enable_disp_power_gating = enable_disp_power_gating_fallback;
 		break;
 	}
 }
@@ -695,6 +748,19 @@ static enum bp_result enable_disp_power_gating_v2_1(
 	return result;
 }
 
+static enum bp_result enable_disp_power_gating_fallback(
+	struct bios_parser *bp,
+	enum controller_id crtc_id,
+	enum bp_pipe_control_action action)
+{
+	if (bp->base.ctx->dc->ctx->dmub_srv &&
+	    bp->base.ctx->dc->debug.dmub_command_table) {
+		return enable_disp_power_gating_v2_1(bp, crtc_id, action);
+	}
+
+	return BP_RESULT_FAILURE;
+}
+
 /******************************************************************************
 *******************************************************************************
  **
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
