Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7439C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF55206F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yvtFjdHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF55206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 022E86E956;
	Thu, 30 Jul 2020 19:12:08 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680076.outbound.protection.outlook.com [40.107.68.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B43B6E955
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc4Qc1zzrBGqz0QmV3g9QRzXgNDxxgKTq9M+5rxf8TcsFnP+vxCj8eAUu+vlsy82Im/YV3FFIbCd+FNZtI6W1s21k5Yy8MouyJ7MK3Z4WtFVBC8GUV6h5ciyMuEf5QeLamQExTXQi4yCTJ8hSzwWxclHni2p+UjvrcWRe9AotGapZ4uFZJUSlqBWv4vuSPIiZxYvKUyT9af2rrUByY/EK+zksN89VHPdt/46fFqrBT/7SzKaWl8HdwYe59Pnh8KA0BCjwcs55neKZCb3s4qx5RB6NWgNAuEibLqvvnzXVCuTbYz4sAbzPk5jqjWxoh5ceXvECBly/y7DGhnJL1EnTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5Vv4ar9c7ksXop2PB7PrYU6s8lGJUVVcOT+ZJQmiJ0=;
 b=PJ7v1RXWD8uDK5tWOqSiyMMOiFMoXzfCTumqfNiQZwbpeBcyUxEezTymvl+XMxEUdyh2gT4TKbh2MY2Y5GnyjsC/c3+dg3ySZWQLsXI9ZB+Km8x5Eg9ceur5xvYGxgjhG4kGU4YrfTupxrZS5wUBUnvVUUKcvMo8SSkv2Rzt60Dc8oXwHyR6zpz7ogjsBDicBZ9VExE+ne4uaJslB/cRXkd8aSmKSbYPNA/HooDTj0vLCL2h9L+JWOTjl9wBWTIvrbOPL3BwseKnAwWZ6ifXG0eZZDiwJYpVoSLVf0t94xJNzUeP+Zo34YIJuUo0VrrbHGBtwFgk//gqjuSBzOYnQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5Vv4ar9c7ksXop2PB7PrYU6s8lGJUVVcOT+ZJQmiJ0=;
 b=yvtFjdHBLEc/50rlpzZ3DRXN4hEwDdJbFEm51pl3D9+C0X86mAl51ro9PignWOzrpiTJdBY9ftJj6pptNMhGGLgBCLsEOAAyw1wiBOL2feiQgPdY5n9rYMN11Z5mCc6MxyCIwbBcvQ9TBakA0/l86ELnUI5HDe4yST9l0HufsyU=
Received: from DM3PR12CA0060.namprd12.prod.outlook.com (2603:10b6:0:56::28) by
 MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.27; Thu, 30 Jul 2020 19:12:02 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::aa) by DM3PR12CA0060.outlook.office365.com
 (2603:10b6:0:56::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Thu, 30 Jul 2020 19:12:02 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 19:12:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:01 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:01 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 14:12:00 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/16] drm/amd/display: Read VBIOS Golden Settings Tbl
Date: Thu, 30 Jul 2020 15:11:34 -0400
Message-ID: <20200730191146.33112-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730191146.33112-1-aurabindo.pillai@amd.com>
References: <20200730191146.33112-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9921629-d539-4f11-b301-08d834bc70f3
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2524FF812F54CF32AE0A15F08B710@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mnfpzSqIUFnm6sa32jlqQiLzd8P8rWxY9r316And/WgnqQlLKiN+AZZjSMJ0ffozUL7s/4VUJdbDvLqrSXu1WCqRmsgu5fw6iLO5/aDgtGNLEbXWSUJAylbJg8ziMMlpPTub5OF8OIhQmmbugfFQDUHliNeT+bRp1+UUG0Yzihzr5hCMi4MRzcfSUoySPeLX2A7HDA0wgP5Uy+yKTl0WWgncF/77XcTo6RLBMDHkQ6JbI16rsFYNfS0kMjyHkQEyQGttY4A7a+jlgRjYomWk7pRWmrv4WQtEi+8H4OvH1axdCN1mYWyDXxivTFg6WprW5OH+TgihNf9QV+ure1NnzAOSz+Tf23zbm2rKJ75ujoiJJnlmQp9HGhADLEpS4nqz+LCN0+xtLmwo3LUULyvZMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966005)(81166007)(8936002)(82740400003)(6666004)(356005)(8676002)(478600001)(70586007)(47076004)(70206006)(316002)(6916009)(4326008)(30864003)(36756003)(7696005)(186003)(5660300002)(2616005)(26005)(86362001)(82310400002)(336012)(1076003)(44832011)(426003)(2906002)(83380400001)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 19:12:02.5600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9921629-d539-4f11-b301-08d834bc70f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Igor Kravchenko <Igor.Kravchenko@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Igor Kravchenko <Igor.Kravchenko@amd.com>

[Why]
For ver.4.4 and higher VBIOS contains default setting table.

{How]
Read Golden Settings Table from VBIOS, apply Aux tuning parameters.

Signed-off-by: Igor Kravchenko <Igor.Kravchenko@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  2 +
 .../drm/amd/display/dc/bios/bios_parser2.c    | 81 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  3 +
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |  4 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 14 ++++
 .../drm/amd/display/dc/dce/dce_link_encoder.h |  4 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.h | 10 ++-
 .../amd/display/dc/dcn20/dcn20_link_encoder.c | 14 +++-
 .../amd/display/dc/dcn20/dcn20_link_encoder.h |  5 +-
 drivers/gpu/drm/amd/include/atomfirmware.h    | 54 ++++++++++++-
 10 files changed, 182 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 008d4d11339d..ad394aefa5d9 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -2834,6 +2834,8 @@ static const struct dc_vbios_funcs vbios_funcs = {
 	.bios_parser_destroy = bios_parser_destroy,
 
 	.get_board_layout_info = bios_get_board_layout_info,
+
+	.get_atom_dc_golden_table = NULL
 };
 
 static bool bios_parser_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index b8684131151d..f8db92fed9cf 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2079,6 +2079,85 @@ static uint16_t bios_parser_pack_data_tables(
 	return 0;
 }
 
+static struct atom_dc_golden_table_v1 *bios_get_golden_table(
+		struct bios_parser *bp,
+		uint32_t rev_major,
+		uint32_t rev_minor,
+		uint16_t *dc_golden_table_ver)
+{
+	struct atom_display_controller_info_v4_4 *disp_cntl_tbl_4_4 = NULL;
+	uint32_t dc_golden_offset = 0;
+	*dc_golden_table_ver = 0;
+
+	if (!DATA_TABLES(dce_info))
+		return NULL;
+
+	/* ver.4.4 or higher */
+	switch (rev_major) {
+	case 4:
+		switch (rev_minor) {
+		case 4:
+			disp_cntl_tbl_4_4 = GET_IMAGE(struct atom_display_controller_info_v4_4,
+									DATA_TABLES(dce_info));
+			if (!disp_cntl_tbl_4_4)
+				return NULL;
+			dc_golden_offset = disp_cntl_tbl_4_4->dc_golden_table_offset;
+			*dc_golden_table_ver = disp_cntl_tbl_4_4->dc_golden_table_ver;
+			break;
+		}
+		break;
+	}
+
+	if (!dc_golden_offset)
+		return NULL;
+
+	if (*dc_golden_table_ver != 1)
+		return NULL;
+
+	return GET_IMAGE(struct atom_dc_golden_table_v1,
+					 dc_golden_offset);
+}
+
+static enum bp_result bios_get_atom_dc_golden_table(
+	struct dc_bios *dcb)
+{
+	struct bios_parser *bp = BP_FROM_DCB(dcb);
+	enum bp_result result = BP_RESULT_OK;
+	struct atom_dc_golden_table_v1 *atom_dc_golden_table = NULL;
+	struct atom_common_table_header *header;
+	struct atom_data_revision tbl_revision;
+	uint16_t dc_golden_table_ver = 0;
+
+	header = GET_IMAGE(struct atom_common_table_header,
+							DATA_TABLES(dce_info));
+	if (!header)
+		return BP_RESULT_UNSUPPORTED;
+
+	get_atom_data_table_revision(header, &tbl_revision);
+
+	atom_dc_golden_table = bios_get_golden_table(bp,
+			tbl_revision.major,
+			tbl_revision.minor,
+			&dc_golden_table_ver);
+
+	if (!atom_dc_golden_table)
+		return BP_RESULT_UNSUPPORTED;
+
+	dcb->golden_table.dc_golden_table_ver = dc_golden_table_ver;
+	dcb->golden_table.aux_dphy_rx_control0_val = atom_dc_golden_table->aux_dphy_rx_control0_val;
+	dcb->golden_table.aux_dphy_rx_control1_val = atom_dc_golden_table->aux_dphy_rx_control1_val;
+	dcb->golden_table.aux_dphy_tx_control_val = atom_dc_golden_table->aux_dphy_tx_control_val;
+	dcb->golden_table.dc_gpio_aux_ctrl_0_val = atom_dc_golden_table->dc_gpio_aux_ctrl_0_val;
+	dcb->golden_table.dc_gpio_aux_ctrl_1_val = atom_dc_golden_table->dc_gpio_aux_ctrl_1_val;
+	dcb->golden_table.dc_gpio_aux_ctrl_2_val = atom_dc_golden_table->dc_gpio_aux_ctrl_2_val;
+	dcb->golden_table.dc_gpio_aux_ctrl_3_val = atom_dc_golden_table->dc_gpio_aux_ctrl_3_val;
+	dcb->golden_table.dc_gpio_aux_ctrl_4_val = atom_dc_golden_table->dc_gpio_aux_ctrl_4_val;
+	dcb->golden_table.dc_gpio_aux_ctrl_5_val = atom_dc_golden_table->dc_gpio_aux_ctrl_5_val;
+
+	return result;
+}
+
+
 static const struct dc_vbios_funcs vbios_funcs = {
 	.get_connectors_number = bios_parser_get_connectors_number,
 
@@ -2128,6 +2207,8 @@ static const struct dc_vbios_funcs vbios_funcs = {
 
 	.get_board_layout_info = bios_get_board_layout_info,
 	.pack_data_tables = bios_parser_pack_data_tables,
+
+	.get_atom_dc_golden_table = bios_get_atom_dc_golden_table
 };
 
 static bool bios_parser2_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 9f8ab679616c..071c7b32b282 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1540,6 +1540,9 @@ static bool dc_link_construct(struct dc_link *link,
 		}
 	}
 
+	if (bios->funcs->get_atom_dc_golden_table)
+		bios->funcs->get_atom_dc_golden_table(bios);
+
 	/*
 	 * TODO check if GPIO programmed correctly
 	 *
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index 845a3054f21f..d06d07042a12 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -133,6 +133,9 @@ struct dc_vbios_funcs {
 	uint16_t (*pack_data_tables)(
 		struct dc_bios *dcb,
 		void *dst);
+
+	enum bp_result (*get_atom_dc_golden_table)(
+			struct dc_bios *dcb);
 };
 
 struct bios_registers {
@@ -154,6 +157,7 @@ struct dc_bios {
 	struct dc_firmware_info fw_info;
 	bool fw_info_valid;
 	struct dc_vram_info vram_info;
+	struct dc_golden_table golden_table;
 };
 
 #endif /* DC_BIOS_TYPES_H */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 29fe5389f973..946ba929c6f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -890,6 +890,20 @@ struct dsc_dec_dpcd_caps {
 	uint32_t branch_max_line_width;
 };
 
+struct dc_golden_table {
+	uint16_t dc_golden_table_ver;
+	uint32_t aux_dphy_rx_control0_val;
+	uint32_t aux_dphy_tx_control_val;
+	uint32_t aux_dphy_rx_control1_val;
+	uint32_t dc_gpio_aux_ctrl_0_val;
+	uint32_t dc_gpio_aux_ctrl_1_val;
+	uint32_t dc_gpio_aux_ctrl_2_val;
+	uint32_t dc_gpio_aux_ctrl_3_val;
+	uint32_t dc_gpio_aux_ctrl_4_val;
+	uint32_t dc_gpio_aux_ctrl_5_val;
+};
+
+
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 enum dc_gpu_mem_alloc_type {
 	DC_MEM_ALLOC_TYPE_GART,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
index 40ea2220330c..cb714a48b171 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
@@ -38,7 +38,8 @@
 
 #define AUX_REG_LIST(id)\
 	SRI(AUX_CONTROL, DP_AUX, id), \
-	SRI(AUX_DPHY_RX_CONTROL0, DP_AUX, id)
+	SRI(AUX_DPHY_RX_CONTROL0, DP_AUX, id), \
+	SRI(AUX_DPHY_RX_CONTROL1, DP_AUX, id)
 
 #define HPD_REG_LIST(id)\
 	SRI(DC_HPD_CONTROL, HPD, id)
@@ -135,6 +136,7 @@
 struct dce110_link_enc_aux_registers {
 	uint32_t AUX_CONTROL;
 	uint32_t AUX_DPHY_RX_CONTROL0;
+	uint32_t AUX_DPHY_RX_CONTROL1;
 };
 
 struct dce110_link_enc_hpd_registers {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
index cf59ab0034dc..04dabed5f1c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
@@ -31,10 +31,10 @@
 #define TO_DCN10_LINK_ENC(link_encoder)\
 	container_of(link_encoder, struct dcn10_link_encoder, base)
 
-
 #define AUX_REG_LIST(id)\
 	SRI(AUX_CONTROL, DP_AUX, id), \
-	SRI(AUX_DPHY_RX_CONTROL0, DP_AUX, id)
+	SRI(AUX_DPHY_RX_CONTROL0, DP_AUX, id), \
+	SRI(AUX_DPHY_RX_CONTROL1, DP_AUX, id)
 
 #define HPD_REG_LIST(id)\
 	SRI(DC_HPD_CONTROL, HPD, id)
@@ -73,6 +73,7 @@ struct dcn10_link_enc_aux_registers {
 	uint32_t AUX_CONTROL;
 	uint32_t AUX_DPHY_RX_CONTROL0;
 	uint32_t AUX_DPHY_TX_CONTROL;
+	uint32_t AUX_DPHY_RX_CONTROL1;
 };
 
 struct dcn10_link_enc_hpd_registers {
@@ -443,7 +444,10 @@ struct dcn10_link_enc_registers {
 	type AUX_TX_PRECHARGE_LEN; \
 	type AUX_TX_PRECHARGE_SYMBOLS; \
 	type AUX_MODE_DET_CHECK_DELAY;\
-	type DPCS_DBG_CBUS_DIS
+	type DPCS_DBG_CBUS_DIS;\
+	type AUX_RX_PRECHARGE_SKIP;\
+	type AUX_RX_TIMEOUT_LEN;\
+	type AUX_RX_TIMEOUT_LEN_MUL
 
 struct dcn10_link_enc_shift {
 	DCN_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
index 8d209dae66e6..15c2ff264ff6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
@@ -309,7 +309,6 @@ bool dcn20_link_encoder_is_in_alt_mode(struct link_encoder *enc)
 void enc2_hw_init(struct link_encoder *enc)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-
 /*
 	00 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__1to2 : 1/2
 	01 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__3to4 : 3/4
@@ -333,9 +332,18 @@ void enc2_hw_init(struct link_encoder *enc)
 	AUX_RX_PHASE_DETECT_LEN,  [21,20] = 0x3 default is 3
 	AUX_RX_DETECTION_THRESHOLD [30:28] = 1
 */
-	AUX_REG_WRITE(AUX_DPHY_RX_CONTROL0, 0x103d1110);
+	if (enc->ctx->dc_bios->golden_table.dc_golden_table_ver > 0) {
+		AUX_REG_WRITE(AUX_DPHY_RX_CONTROL0, enc->ctx->dc_bios->golden_table.aux_dphy_rx_control0_val);
+
+		AUX_REG_WRITE(AUX_DPHY_TX_CONTROL, enc->ctx->dc_bios->golden_table.aux_dphy_tx_control_val);
+
+		AUX_REG_WRITE(AUX_DPHY_RX_CONTROL1, enc->ctx->dc_bios->golden_table.aux_dphy_rx_control1_val);
+	} else {
+		AUX_REG_WRITE(AUX_DPHY_RX_CONTROL0, 0x103d1110);
+
+		AUX_REG_WRITE(AUX_DPHY_TX_CONTROL, 0x21c4d);
 
-	AUX_REG_WRITE(AUX_DPHY_TX_CONTROL, 0x21c7a);
+	}
 
 	//AUX_DPHY_TX_REF_CONTROL'AUX_TX_REF_DIV HW default is 0x32;
 	// Set AUX_TX_REF_DIV Divider to generate 2 MHz reference from refclk
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
index db09f40075c2..bf0044f7417e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
@@ -191,7 +191,10 @@
 	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_DETECTION_THRESHOLD, mask_sh), \
 	LE_SF(DP_AUX0_AUX_DPHY_TX_CONTROL, AUX_TX_PRECHARGE_LEN, mask_sh),\
 	LE_SF(DP_AUX0_AUX_DPHY_TX_CONTROL, AUX_TX_PRECHARGE_SYMBOLS, mask_sh),\
-	LE_SF(DP_AUX0_AUX_DPHY_TX_CONTROL, AUX_MODE_DET_CHECK_DELAY, mask_sh)
+	LE_SF(DP_AUX0_AUX_DPHY_TX_CONTROL, AUX_MODE_DET_CHECK_DELAY, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL1, AUX_RX_PRECHARGE_SKIP, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL1, AUX_RX_TIMEOUT_LEN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL1, AUX_RX_TIMEOUT_LEN_MUL, mask_sh)
 
 #define UNIPHY_DCN2_REG_LIST(id) \
 	SRI(CLOCK_ENABLE, SYMCLK, id), \
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index c2544c81dfb2..3e526c394f6c 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -941,7 +941,6 @@ struct atom_display_controller_info_v4_1
   uint8_t  reserved3[8];
 };
 
-
 struct atom_display_controller_info_v4_2
 {
   struct  atom_common_table_header  table_header;
@@ -976,6 +975,59 @@ struct atom_display_controller_info_v4_2
   uint8_t  reserved3[8];
 };
 
+struct atom_display_controller_info_v4_4 {
+	struct atom_common_table_header table_header;
+	uint32_t display_caps;
+	uint32_t bootup_dispclk_10khz;
+	uint16_t dce_refclk_10khz;
+	uint16_t i2c_engine_refclk_10khz;
+	uint16_t dvi_ss_percentage;	 // in unit of 0.001%
+	uint16_t dvi_ss_rate_10hz;
+	uint16_t hdmi_ss_percentage;	 // in unit of 0.001%
+	uint16_t hdmi_ss_rate_10hz;
+	uint16_t dp_ss_percentage;	 // in unit of 0.001%
+	uint16_t dp_ss_rate_10hz;
+	uint8_t dvi_ss_mode;		 // enum of atom_spread_spectrum_mode
+	uint8_t hdmi_ss_mode;		 // enum of atom_spread_spectrum_mode
+	uint8_t dp_ss_mode;		 // enum of atom_spread_spectrum_mode
+	uint8_t ss_reserved;
+	uint8_t dfp_hardcode_mode_num;	 // DFP hardcode mode number defined in StandardVESA_TimingTable when EDID is not available
+	uint8_t dfp_hardcode_refreshrate;// DFP hardcode mode refreshrate defined in StandardVESA_TimingTable when EDID is not available
+	uint8_t vga_hardcode_mode_num;	 // VGA hardcode mode number defined in StandardVESA_TimingTable when EDID is not avablable
+	uint8_t vga_hardcode_refreshrate;// VGA hardcode mode number defined in StandardVESA_TimingTable when EDID is not avablable
+	uint16_t dpphy_refclk_10khz;
+	uint16_t hw_chip_id;
+	uint8_t dcnip_min_ver;
+	uint8_t dcnip_max_ver;
+	uint8_t max_disp_pipe_num;
+	uint8_t max_vbios_active_disp_pipum;
+	uint8_t max_ppll_num;
+	uint8_t max_disp_phy_num;
+	uint8_t max_aux_pairs;
+	uint8_t remotedisplayconfig;
+	uint32_t dispclk_pll_vco_freq;
+	uint32_t dp_ref_clk_freq;
+	uint32_t max_mclk_chg_lat;	 // Worst case blackout duration for a memory clock frequency (p-state) change, units of 100s of ns (0.1 us)
+	uint32_t max_sr_exit_lat;	 // Worst case memory self refresh exit time, units of 100ns of ns (0.1us)
+	uint32_t max_sr_enter_exit_lat;	 // Worst case memory self refresh entry followed by immediate exit time, units of 100ns of ns (0.1us)
+	uint16_t dc_golden_table_offset; // point of struct of atom_dc_golden_table_vxx
+	uint16_t dc_golden_table_ver;
+	uint32_t reserved3[3];
+};
+
+struct atom_dc_golden_table_v1
+{
+	uint32_t aux_dphy_rx_control0_val;
+	uint32_t aux_dphy_tx_control_val;
+	uint32_t aux_dphy_rx_control1_val;
+	uint32_t dc_gpio_aux_ctrl_0_val;
+	uint32_t dc_gpio_aux_ctrl_1_val;
+	uint32_t dc_gpio_aux_ctrl_2_val;
+	uint32_t dc_gpio_aux_ctrl_3_val;
+	uint32_t dc_gpio_aux_ctrl_4_val;
+	uint32_t dc_gpio_aux_ctrl_5_val;
+	uint32_t reserved[23];
+};
 
 enum dce_info_caps_def
 {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
