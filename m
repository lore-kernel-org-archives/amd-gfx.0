Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B607BC433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B39A61953
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B39A61953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 138AB6F4A9;
	Fri, 26 Mar 2021 22:05:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE21D6F4A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMmZHDiXpwG3M6F612/zSntrleTsrnzaTe2kv5AjvHiLkSmFTW52JUM8qQI08LLwUhG+BJ+KCV/S0QrmGwSlGxb+2FXqLrE5yuPbvP3UQmXQFelzzhkp20qmP6J9NK0vxZWIggte9ZqdzHs+H4d/clHDviWg81817p87LjXx9Skc8O7vJGnwkB/YI3TU0tYLDqfv756RgP++ufbz6XpbSuYuUIIxPkLmz73JfOch687vn5kGJdqx7hHBBzfORWpYR4NNLc269RLZR2KdqMw0Ee9qvuaWfzmAOVI9PPAt5JWGcEHBh022t5kvOFzLI+KVfaisCRd6n+aFgRhp/twLTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3raDSY5Iln6AXemSrpYDtv0tbWkrLOaUdUU7E/c6+0Q=;
 b=aksCWiRaLMrNQQM52qRC2oYA1PAsTW6Llq2PgOrlqJ5UAqp2H8DjwQVUwD3z9cUNTBJOwDaMVrWtQr0hEAvNPlBQ8ZMHUl/QjcIU2jiz8vob5HClnlLu42pAjuPGh5OB04cjf6eaa/PQIaUmHZ4ohOT4iatSXCA3bTksfCbGfBhx0RXruhkBMLm6YouQLAZ6mjvWcxN/AMfRzV3pT9wsu0r/hxba5a++hWgWCNqfcCQi2eux11XOza4670WorFHQMGRay9pMt4uvT+RHyqJnjIUhuZdy0aXcCLmq95vkx3eCkqa7qXQ4cIUkO9WIIIAyfvi6++buqCfH5EDgpO8Qrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3raDSY5Iln6AXemSrpYDtv0tbWkrLOaUdUU7E/c6+0Q=;
 b=0U5QimvXc/uSo0uIyNYWXSMZ10ADmZybZcOt4flBZxgi24VHnUBiX/196YkrRf4U4EWvuaC5ZFpZkpSzL0CtNJhCYJ1TxpSnm42A2v3WarrbpixNp1d9Vlc2TzH+83BuGDg16kAAUu/o6fNYhni0dUOmRDMa0k9EPCZ4ofw640k=
Received: from DS7PR03CA0262.namprd03.prod.outlook.com (2603:10b6:5:3b3::27)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 22:05:42 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::b1) by DS7PR03CA0262.outlook.office365.com
 (2603:10b6:5:3b3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Fri, 26 Mar 2021 22:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:05:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:05:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:05:41 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:05:40 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/21] drm/amd/display: BIOS LTTPR Caps Interface
Date: Fri, 26 Mar 2021 18:05:14 -0400
Message-ID: <20210326220534.918023-2-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7c14a55-a9d1-4c8c-ed87-08d8f0a34c38
X-MS-TrafficTypeDiagnostic: PH0PR12MB5484:
X-Microsoft-Antispam-PRVS: <PH0PR12MB54846FD53BC52903A1687ACFEB619@PH0PR12MB5484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQDRJxA89plql1gYB1MmfKweDrgOL1uv2FIay1Bh6jYhLNbbe2Gr1TNOPkcuwloZmyMg1MKMUFcAHI8pxH3Z25SxDHGZE7yGR6PIjlfc3TeMGgKwSD14eRC/kR7XYSkweNJ1w0qtFia1z/hCvG19JYJsvKuQbFnar2I7FdlvBt2vS6cQ2CKuxidRYT+Axkx2/pVONYvKWJ3/Uk+xtsxVq4FFGhq18J1kdK4trWpuqbooYDwnqxuKNCOnGjkJ9M4avK827diGKRH49IWvS2SEAlIz/HkVKNWRWNBN7BCOhNPT6FwuL2phUxC/wKmDX3LTaA+SSuHpoQmarrtdxWB28Fp3GInFdeslDFbgIQVDXPizIlPY6y8nJlSX+tBi9wOK7waAgZnko7mHyyDeem2KQZjfgy11cnNHpNKq0ASV1vo02B1KKveDwavwmP9qtd8LTATZF1aowugzg5kWdl+czm7nL54HqUMEgsDVW0Rz4L0uX38Lxalj2gzvbK3+ZDpcXrYujuYFP8TziXPPO1Kt3yTOb8z6BzuNAYuSmB8qFiZqUKBVzqOMXZtRoA/NoAcRgtUFD+LzVSsvmnndFPVTc3XQOsoMqWuelaSNUO4b05AdXnf8SGVMEldXzwhoDeRB9+4jaRuSmiR2kJqvg392BD2LMG5oKWCe/Vd2YqKfhVrPsGeuQh6vEDHPk+6KeJCT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(6666004)(82310400003)(70586007)(316002)(83380400001)(478600001)(336012)(8936002)(36756003)(6916009)(47076005)(36860700001)(2906002)(5660300002)(54906003)(86362001)(8676002)(2616005)(7696005)(356005)(82740400003)(1076003)(426003)(4326008)(26005)(70206006)(186003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:05:42.1030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c14a55-a9d1-4c8c-ed87-08d8f0a34c38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
Some platforms will have LTTPR capabilities forced on by VBIOS flags;
the functions added here will access those flags.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 139 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   3 +
 drivers/gpu/drm/amd/include/atomfirmware.h    |  37 ++++-
 3 files changed, 178 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index b208f06ed514..2ee0c6fc069a 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -916,6 +916,143 @@ static enum bp_result bios_parser_get_soc_bb_info(
 	return result;
 }
 
+static enum bp_result get_lttpr_caps_v4_1(
+	struct bios_parser *bp,
+	uint8_t *dce_caps)
+{
+	enum bp_result result = BP_RESULT_OK;
+	struct atom_display_controller_info_v4_1 *disp_cntl_tbl = NULL;
+
+	if (!dce_caps)
+		return BP_RESULT_BADINPUT;
+
+	if (!DATA_TABLES(dce_info))
+		return BP_RESULT_BADBIOSTABLE;
+
+	disp_cntl_tbl = GET_IMAGE(struct atom_display_controller_info_v4_1,
+							DATA_TABLES(dce_info));
+
+	if (!disp_cntl_tbl)
+		return BP_RESULT_BADBIOSTABLE;
+
+	*dce_caps = !!(disp_cntl_tbl->display_caps & DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE);
+
+	return result;
+}
+
+static enum bp_result get_lttpr_caps_v4_2(
+	struct bios_parser *bp,
+	uint8_t *dce_caps)
+{
+	enum bp_result result = BP_RESULT_OK;
+	struct atom_display_controller_info_v4_2 *disp_cntl_tbl = NULL;
+
+	if (!dce_caps)
+		return BP_RESULT_BADINPUT;
+
+	if (!DATA_TABLES(dce_info))
+		return BP_RESULT_BADBIOSTABLE;
+
+	disp_cntl_tbl = GET_IMAGE(struct atom_display_controller_info_v4_2,
+							DATA_TABLES(dce_info));
+
+	if (!disp_cntl_tbl)
+		return BP_RESULT_BADBIOSTABLE;
+
+	*dce_caps = !!(disp_cntl_tbl->display_caps & DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE);
+
+	return result;
+}
+
+static enum bp_result get_lttpr_caps_v4_3(
+	struct bios_parser *bp,
+	uint8_t *dce_caps)
+{
+	enum bp_result result = BP_RESULT_OK;
+	struct atom_display_controller_info_v4_3 *disp_cntl_tbl = NULL;
+
+	if (!dce_caps)
+		return BP_RESULT_BADINPUT;
+
+	if (!DATA_TABLES(dce_info))
+		return BP_RESULT_BADBIOSTABLE;
+
+	disp_cntl_tbl = GET_IMAGE(struct atom_display_controller_info_v4_3,
+							DATA_TABLES(dce_info));
+
+	if (!disp_cntl_tbl)
+		return BP_RESULT_BADBIOSTABLE;
+
+	*dce_caps = !!(disp_cntl_tbl->display_caps & DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE);
+
+	return result;
+}
+
+static enum bp_result get_lttpr_caps_v4_4(
+	struct bios_parser *bp,
+	uint8_t *dce_caps)
+{
+	enum bp_result result = BP_RESULT_OK;
+	struct atom_display_controller_info_v4_4 *disp_cntl_tbl = NULL;
+
+	if (!dce_caps)
+		return BP_RESULT_BADINPUT;
+
+	if (!DATA_TABLES(dce_info))
+		return BP_RESULT_BADBIOSTABLE;
+
+	disp_cntl_tbl = GET_IMAGE(struct atom_display_controller_info_v4_4,
+							DATA_TABLES(dce_info));
+
+	if (!disp_cntl_tbl)
+		return BP_RESULT_BADBIOSTABLE;
+
+	*dce_caps = !!(disp_cntl_tbl->display_caps & DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE);
+
+	return result;
+}
+
+static enum bp_result bios_parser_get_lttpr_caps(
+	struct dc_bios *dcb,
+	uint8_t *dce_caps)
+{
+	struct bios_parser *bp = BP_FROM_DCB(dcb);
+	enum bp_result result = BP_RESULT_UNSUPPORTED;
+	struct atom_common_table_header *header;
+	struct atom_data_revision tbl_revision;
+
+	if (!DATA_TABLES(dce_info))
+		return BP_RESULT_UNSUPPORTED;
+
+	header = GET_IMAGE(struct atom_common_table_header,
+						DATA_TABLES(dce_info));
+	get_atom_data_table_revision(header, &tbl_revision);
+	switch (tbl_revision.major) {
+	case 4:
+		switch (tbl_revision.minor) {
+		case 1:
+			result = get_lttpr_caps_v4_1(bp, dce_caps);
+			break;
+		case 2:
+			result = get_lttpr_caps_v4_2(bp, dce_caps);
+			break;
+		case 3:
+			result = get_lttpr_caps_v4_3(bp, dce_caps);
+			break;
+		case 4:
+			result = get_lttpr_caps_v4_4(bp, dce_caps);
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return result;
+}
+
 static enum bp_result get_embedded_panel_info_v2_1(
 		struct bios_parser *bp,
 		struct embedded_panel_info *info)
@@ -2531,6 +2668,8 @@ static const struct dc_vbios_funcs vbios_funcs = {
 	.get_soc_bb_info = bios_parser_get_soc_bb_info,
 
 	.get_disp_connector_caps_info = bios_parser_get_disp_connector_caps_info,
+
+	.get_lttpr_caps = bios_parser_get_lttpr_caps,
 };
 
 static bool bios_parser2_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index 86ab8f16f621..1b957c60156b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -150,6 +150,9 @@ struct dc_vbios_funcs {
 			struct dc_bios *dcb,
 			struct graphics_object_id object_id,
 			struct bp_disp_connector_caps_info *info);
+	enum bp_result (*get_lttpr_caps)(
+			struct dc_bios *dcb,
+			uint8_t *dce_caps);
 };
 
 struct bios_registers {
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 58364a8eb1f3..82b3cd89b383 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -981,6 +981,40 @@ struct atom_display_controller_info_v4_2
   uint8_t  reserved3[8];
 };
 
+struct atom_display_controller_info_v4_3
+{
+  struct  atom_common_table_header  table_header;
+  uint32_t display_caps;
+  uint32_t bootup_dispclk_10khz;
+  uint16_t dce_refclk_10khz;
+  uint16_t i2c_engine_refclk_10khz;
+  uint16_t dvi_ss_percentage;       // in unit of 0.001%
+  uint16_t dvi_ss_rate_10hz;
+  uint16_t hdmi_ss_percentage;      // in unit of 0.001%
+  uint16_t hdmi_ss_rate_10hz;
+  uint16_t dp_ss_percentage;        // in unit of 0.001%
+  uint16_t dp_ss_rate_10hz;
+  uint8_t  dvi_ss_mode;             // enum of atom_spread_spectrum_mode
+  uint8_t  hdmi_ss_mode;            // enum of atom_spread_spectrum_mode
+  uint8_t  dp_ss_mode;              // enum of atom_spread_spectrum_mode
+  uint8_t  ss_reserved;
+  uint8_t  dfp_hardcode_mode_num;   // DFP hardcode mode number defined in StandardVESA_TimingTable when EDID is not available
+  uint8_t  dfp_hardcode_refreshrate;// DFP hardcode mode refreshrate defined in StandardVESA_TimingTable when EDID is not available
+  uint8_t  vga_hardcode_mode_num;   // VGA hardcode mode number defined in StandardVESA_TimingTable when EDID is not avablable
+  uint8_t  vga_hardcode_refreshrate;// VGA hardcode mode number defined in StandardVESA_TimingTable when EDID is not avablable
+  uint16_t dpphy_refclk_10khz;
+  uint16_t reserved2;
+  uint8_t  dcnip_min_ver;
+  uint8_t  dcnip_max_ver;
+  uint8_t  max_disp_pipe_num;
+  uint8_t  max_vbios_active_disp_pipe_num;
+  uint8_t  max_ppll_num;
+  uint8_t  max_disp_phy_num;
+  uint8_t  max_aux_pairs;
+  uint8_t  remotedisplayconfig;
+  uint8_t  reserved3[8];
+};
+
 struct atom_display_controller_info_v4_4 {
 	struct atom_common_table_header table_header;
 	uint32_t display_caps;
@@ -1043,7 +1077,8 @@ enum dce_info_caps_def
   DCE_INFO_CAPS_DISABLE_DFP_DP_HBR2      =0x04,
   // only for VBIOS
   DCE_INFO_CAPS_ENABLE_INTERLAC_TIMING   =0x08,
-
+  // only for VBIOS
+  DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE	 =0x20,
 };
 
 /* 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
