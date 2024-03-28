Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4822CD1283
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A45E10E516;
	Thu, 28 Mar 2024 19:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W3V9vQur";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A061810E516
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbqFIzkVY7Ok2rYIrsVy3BA8aIBwBkNJGMofRXX+v0bdyYsMVkyj4r/UUUdAuw1Fta4xdlOVwYeHUJrDnhMUoFCJaFadVJ4tctPqvhjOF16ZwzyJ56ixPaJ1vrAwrvOtnzQid6WSCsVJ7WkhbCMjbu+8e6qzxdxNIy7ulmwbv8wE4vdC6nG3/bjdlLxa+WyNACPhR+WlOikAN1PwMq4wBJLulQSQAoLagTly2uT8xEWhvH0tzjdxF7BT79du5BvByOMMNxRySOYPp2s4mw24oURSmls0vbWA+EVc1+Lnd1SG47iOpCEQsHtDs8LgJjEaDqNwsuWy04MfaT3naN9fDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uMC1eM0qan7SLhEw7hNVYuH3fnqAEu9tE7t/eWSkZo=;
 b=RXClRVMTd2vmDPcvIY9BQFTaPK4CtvHc18/JKrZ7C79W3VX+Dk70sFyw41ARS+JZb/wUcY7FwHA0q84u49mqHNPpr3YVRIFe4LUzIhxgm26YMTrT1MuWkUG4FajReQZxImJFYBfi8GQPZBlKng4Wd9hp4YynwOVkfNfjfBOuSxxTSiV5LMcK7FyBl8KL6CB84Nz2cg/1QnfY7Rn+eSimwQZGXZP6XlNRyYSOlFZt3F+YfaSz1mqkfHLtwUmoGzeb60+Nfc0heNjNKlPN1mLe4L+UoG9K0qd+SqTfYvtUcZt+IPp+eq01594Uk6s3R6ycwyBUxIe+L45AeBXX1dzZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uMC1eM0qan7SLhEw7hNVYuH3fnqAEu9tE7t/eWSkZo=;
 b=W3V9vQurLTJBVOVbXD0KM7acYNSDooVlaiCpDC7c0o/LK4VyXQX/ryFkbrRXcoIBzKmTZwjxVuFtP3q7K3dy4K5g6P+o9VgcLXmvzgRCw+jhJY6DtuhMW7szOdxnYI7wKq3fnUdj+vpkO9Lr8+P+Dr78/V1Jf9ElJoImfhYtAy4=
Received: from SJ0PR03CA0341.namprd03.prod.outlook.com (2603:10b6:a03:39c::16)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 19:51:27 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::49) by SJ0PR03CA0341.outlook.office365.com
 (2603:10b6:a03:39c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:25 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:25 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Mounika Adhuri
 <moadhuri@amd.com>, Martin Leung <martin.leung@amd.com>
Subject: [PATCH 01/43] drm/amd/display: Fix compiler redefinition warnings for
 certain configs
Date: Thu, 28 Mar 2024 15:50:05 -0400
Message-ID: <20240328195047.2843715-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d35a935-e7a7-401c-2c2b-08dc4f6074e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wZGlzrCv794KJWdSRKRfW2Hrl8id3uKZc3UTQRninPi1Qfr/2DCtM5YSmEM832WmaLou20VGkhlHpiNohDRb7C9qsALcduZlefMK2dAGVwHnzTJtdU9LHjiOwXu+MXCqcK49NPF3dIm77zCrhZBecLa1wm/QbCT66JY+HhX9TWBTYnDCULRzpk29l6TGeHmEh5x7qzD0kkESoV9zx+0DfRgk0h+GCSheQRrEX4jxDgYKYUuRlDZ9i9i63qTV3QI5NIlik+VomwfuJidRJLBTDFJGuXV/gxhACABkkbvpDzNnczLmQs14RGJqiNGsXYhWLFqnGzbE3vcsTLVL3vvKMqS7Igi0lR9X8XLqZnTDJ6R0cf2Wq3tflmQpbRMF06N+AvQTmVrcsOFKcR2s+2E7NfvOQycnuqjomjVxVFAe9kw5PmdqA31oCe4PURGyaSlZxDS17CJ9EnIhHf526tW9OEyCobzJbUyIrZ9maDaBGmQEaWmowCK2C9ZNYyuuRyaRZfCtlDVV3yDoH2w8qvdjTDH+/15SRlzK0bGei3GUlE7PfeB09U6KE+Q6/GtSF2oGasxC+qTs+TTXW3NE4nAQNApWYqh2NNp2yTyl6+xaLDFJoddaZQjzLT5xQp3/m81rkyNeWFyXL7XFmTkijv+U8Khk+bRpPFNb4nV2S55bq/o+G63lCHQTynNLIakF5B16/LPtIF+53qBf4T4vzHPyysLMwpC3x460IYhJDSZz1sNHMLhAHZs7YKqH6Gt5b3MP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:27.4211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d35a935-e7a7-401c-2c2b-08dc4f6074e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601
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

From: Mounika Adhuri <moadhuri@amd.com>

[why & how]
Modified definitions of 1 function and 2 structs to remove warnings on
certain specific compiler configurations due to redefinition.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Mounika Adhuri <moadhuri@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 4 ++--
 drivers/gpu/drm/amd/display/include/grph_object_id.h      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 35c631c22934..17b404cb1155 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -249,7 +249,7 @@ static bool dce110_enable_display_power_gating(
 		return false;
 }
 
-static void build_prescale_params(struct ipp_prescale_params *prescale_params,
+static void dce110_prescale_params(struct ipp_prescale_params *prescale_params,
 		const struct dc_plane_state *plane_state)
 {
 	prescale_params->mode = IPP_PRESCALE_MODE_FIXED_UNSIGNED;
@@ -291,7 +291,7 @@ dce110_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 
 	tf = &plane_state->in_transfer_func;
 
-	build_prescale_params(&prescale_params, plane_state);
+	dce110_prescale_params(&prescale_params, plane_state);
 	ipp->funcs->ipp_program_prescale(ipp, &prescale_params);
 
 	if (!plane_state->gamma_correction.is_identity &&
diff --git a/drivers/gpu/drm/amd/display/include/grph_object_id.h b/drivers/gpu/drm/amd/display/include/grph_object_id.h
index c6bbd262f1ac..08ee0350b31f 100644
--- a/drivers/gpu/drm/amd/display/include/grph_object_id.h
+++ b/drivers/gpu/drm/amd/display/include/grph_object_id.h
@@ -226,8 +226,8 @@ enum dp_alt_mode {
 
 struct graphics_object_id {
 	uint32_t  id:8;
-	uint32_t  enum_id:4;
-	uint32_t  type:4;
+	enum object_enum_id  enum_id;
+	enum object_type  type;
 	uint32_t  reserved:16; /* for padding. total size should be u32 */
 };
 
-- 
2.34.1

