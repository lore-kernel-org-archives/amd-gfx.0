Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF2BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 21:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4423410E11B;
	Tue, 15 Feb 2022 21:45:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDD7189F24
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 21:45:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7jQ+iErBiWkdzGqLr/KeCRoj8/8oGgv5hTxVV1M07ybYorojiyr91W6p2fcY+2I45xm03cHLI+TgDn3mEoUlWgQHgCcMnhT74BTet1GStYYExMbtLKuVTNZSgfnTgVakqUfl30SbmvCveoTGlmUcYfjXuF7Vmx61Q048m2an0Ht5wqr5jfPPZNrMKEP4dALkYsVhN9GudUn8l3ALZrK5kjMtGyt2rilHuE9i1uJ8XDjRlq+F9/rmukdHacn5Kd9+JiH1oek6g2sImS8OTaQ0ijdpOYGU1ioUm5nDVd14Ee4/P6OogBpfkJJKi1EP6qvCgMVt9n+MeWXFn62f+6a6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoUdYoqxlmSqXzrMhY066dvgNDOuI/9xld2Fsips5iY=;
 b=hkhwq37gLnMq8TyGKRjE6el8/lyJjmXkrVm7uH8y7GPwpnNZlq9usFXnJe6uFGw9Dx4EFSU9jrkmgEd9VyRmPpCiHguqgjp7CVwi0XnaPvyi3YcAs17/MX+3/DWWRFbfnRigIdWjKZUfP7ElW6GOT0h7n26enbpHd/uT+6Z5N3iIDFmwB1ZjwzhYyL0dtGLivhm1SKTks+zuUGEFuGeovNLaFBSvJKFh49I1lxyKUYTZVm+9kmZ5X6qbIjH0cHabmmFzJE2wgn67LedNF8cv+SSzv0mhvV2jDSuUP1eFBtBc4neApKdKn1PXaLR4Am63PVtQy7aLw4VhDdhLq7tEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoUdYoqxlmSqXzrMhY066dvgNDOuI/9xld2Fsips5iY=;
 b=ifIvhYO+kO1q69n/bhyJtLkK5M5/NY00RjBVagGoU0iHGv49HQurKFxZcxx37LnkXXXqlmLhd52uCIiCX2koHtIUaXhB7e6uEzzrF5FyoAObXN+RQLCaZjZvpXWEwQDVzDb8HcIAMzIqza0IaGwW2y7GCwGQg//OhEK2rW24Axs=
Received: from BN9PR03CA0249.namprd03.prod.outlook.com (2603:10b6:408:ff::14)
 by DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 21:45:07 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::d4) by BN9PR03CA0249.outlook.office365.com
 (2603:10b6:408:ff::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 15 Feb 2022 21:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:45:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 15:45:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amd/display: configure dc hw resource for DCN 3.1.6
Date: Tue, 15 Feb 2022 16:44:44 -0500
Message-ID: <20220215214447.2234978-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215214447.2234978-1-alexander.deucher@amd.com>
References: <20220215214447.2234978-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 908b1d96-8436-4680-a56c-08d9f0cc6ef4
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2360EEFE91B4CF0B8ED31A34F7349@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:49;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anTIoG9UayR8uJgt43VqWetwyvUy99+sSXWvfqc4OlhgYl9zRtiSiDQquDdw4EuHt2i64CQuGY+bGA08kKQbhgILJs8Ma8yFRfLpwN3qdSJJMCqCDo0+UwiQlA6W8PTbw/LNH5JJfRwfvSAnDhFLh/AeU79lkFwCFnHdjSo4f8d7TPoox/lAJz2QdhiZMGReLzyfrtOkSApR8E54l4lu2zmwzAJ0pYVfRCJxVOz+QQUCRb0dCjLdhujwXJ2dxAftu+uybGUg+3eQYuPDmTbIssA4EDVqzHKY1Spt21MhtU8QM/p8z5pGBVLo0TSfhm+59wpusVd30YrnQR5oGSAQ6929BpSyPeVKzYoLgOI3TpX5LfqZxQDDCfopf52tROw1CtOndkuK1BLPpbF2Jd5mVvZxSzn5q97cokeoy0/WCjvZr+bMyyJTAxKRs8MKjGJFC3v0PMlQAVns+yWa/S66WuT2RAuUPRJPTqmEqj/zEyxQNpt7/U50clN+WgGDQQoEYHiqkyjSwjn6fe8k3nvE3tZx2HD8eyUfUyh3oKAalR5d85ar/JJjXkEKIpLa3AWTzKEy2jEaDNGb+0UJlhjoWHlXHLOBbr3l4M9f4Cz/fT4AsQYblguAJIBWU3YZihvemaOhADyiKjhi7lWudpS1H2IzupKu5s9RxUr6p2ZW567rDNGIzx338hZoJazgIB6auQusuywuqy0/25yKqRPfaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(316002)(4326008)(508600001)(16526019)(426003)(186003)(2906002)(70586007)(70206006)(36756003)(8676002)(336012)(86362001)(26005)(83380400001)(2616005)(54906003)(5660300002)(40460700003)(1076003)(47076005)(6916009)(356005)(81166007)(36860700001)(6666004)(7696005)(8936002)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:45:07.4688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 908b1d96-8436-4680-a56c-08d9f0cc6ef4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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
Cc: Leo Li <sunpeng.li@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

- set DC version
- add construct/destroy dc clock management function
- register dcn interrupt handler

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 14 +++++++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |  3 ++-
 .../amd/display/dc/bios/command_table_helper2.c    |  1 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |  4 +++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  4 ++++
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |  1 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |  1 +
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |  6 +++++-
 drivers/gpu/drm/amd/display/include/dal_types.h    |  1 +
 9 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 10ca3fc6d91e..a4254357bf5f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -114,6 +114,8 @@ MODULE_FIRMWARE(FIRMWARE_DIMGREY_CAVEFISH_DMUB);
 MODULE_FIRMWARE(FIRMWARE_BEIGE_GOBY_DMUB);
 #define FIRMWARE_YELLOW_CARP_DMUB "amdgpu/yellow_carp_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_YELLOW_CARP_DMUB);
+#define FIRMWARE_DCN316_DMUB "amdgpu/dcn_3_1_6_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_DCN316_DMUB);
 
 #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"
 MODULE_FIRMWARE(FIRMWARE_RAVEN_DMCU);
@@ -1801,6 +1803,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
+		case IP_VERSION(3, 1, 6):
 			return 0;
 		default:
 			break;
@@ -1916,6 +1919,10 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		dmub_asic = (adev->external_rev_id == YELLOW_CARP_B0) ? DMUB_ASIC_DCN31B : DMUB_ASIC_DCN31;
 		fw_name_dmub = FIRMWARE_YELLOW_CARP_DMUB;
 		break;
+	case IP_VERSION(3, 1, 6):
+		dmub_asic = DMUB_ASIC_DCN31B;
+		fw_name_dmub = FIRMWARE_DCN316_DMUB;
+		break;
 
 	default:
 		/* ASIC doesn't support DMUB. */
@@ -4224,6 +4231,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case IP_VERSION(3, 0, 0):
 	case IP_VERSION(3, 1, 2):
 	case IP_VERSION(3, 1, 3):
+	case IP_VERSION(3, 1, 6):
 	case IP_VERSION(2, 1, 0):
 		if (register_outbox_irq_handlers(dm->adev)) {
 			DRM_ERROR("DM: Failed to initialize IRQ\n");
@@ -4240,6 +4248,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		switch (adev->ip_versions[DCE_HWIP][0]) {
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
+		case IP_VERSION(3, 1, 6):
 			psr_feature_enabled = true;
 			break;
 		default:
@@ -4356,6 +4365,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
+		case IP_VERSION(3, 1, 6):
 			if (dcn10_register_irq_handlers(dm->adev)) {
 				DRM_ERROR("DM: Failed to initialize IRQ\n");
 				goto fail;
@@ -4541,6 +4551,7 @@ static int dm_early_init(void *handle)
 		case IP_VERSION(2, 1, 0):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
+		case IP_VERSION(3, 1, 6):
 			adev->mode_info.num_crtc = 4;
 			adev->mode_info.num_hpd = 4;
 			adev->mode_info.num_dig = 4;
@@ -5213,6 +5224,7 @@ get_plane_modifiers(const struct amdgpu_device *adev, unsigned int plane_type, u
 	case AMDGPU_FAMILY_NV:
 	case AMDGPU_FAMILY_VGH:
 	case AMDGPU_FAMILY_YC:
+	case AMDGPU_FAMILY_GC_10_3_7:
 		if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 3, 0))
 			add_gfx10_3_modifiers(adev, mods, &size, &capacity);
 		else
@@ -6179,7 +6191,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 	if (stream->link && stream->link->local_sink)
 		max_dsc_target_bpp_limit_override =
 			stream->link->local_sink->edid_caps.panel_patch.max_dsc_target_bpp_limit;
-	
+
 	/* Set DSC policy according to dsc_clock_en */
 	dc_dsc_policy_set_enable_dsc_when_not_needed(
 		aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 5bfdc66b5867..8709827b69ad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -663,7 +663,8 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
 		INIT_DELAYED_WORK(&hdcp_work[i].property_validate_dwork, event_property_validate);
 
 		hdcp_work[i].hdcp.config.psp.handle = &adev->psp;
-		if (dc->ctx->dce_version == DCN_VERSION_3_1)
+		if (dc->ctx->dce_version == DCN_VERSION_3_1 ||
+		    dc->ctx->dce_version == DCN_VERSION_3_16)
 			hdcp_work[i].hdcp.config.psp.caps.dtm_v3_supported = 1;
 		hdcp_work[i].hdcp.config.ddc.handle = dc_get_link_at_index(dc, i);
 		hdcp_work[i].hdcp.config.ddc.funcs.write_i2c = lp_write_i2c;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index eedc553f340e..d0fcfb158436 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -76,6 +76,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 	case DCN_VERSION_3_02:
 	case DCN_VERSION_3_03:
 	case DCN_VERSION_3_1:
+	case DCN_VERSION_3_16:
 		*h = dal_cmd_tbl_helper_dce112_get_table2();
 		return true;
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 9200c8ce02ba..a707d07d5197 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -278,7 +278,8 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			return &clk_mgr->base.base;
 		}
 		break;
-	case FAMILY_YELLOW_CARP: {
+	case FAMILY_YELLOW_CARP:
+	case AMDGPU_FAMILY_GC_10_3_7:{
 		struct clk_mgr_dcn31 *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
 
 		if (clk_mgr == NULL) {
@@ -322,6 +323,7 @@ void dc_destroy_clk_mgr(struct clk_mgr *clk_mgr_base)
 		break;
 
 	case FAMILY_YELLOW_CARP:
+	case AMDGPU_FAMILY_GC_10_3_7:
 			dcn31_clk_mgr_destroy(clk_mgr);
 		break;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 71b393194c55..ed6b0eec1b68 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -155,6 +155,10 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 		if (ASICREV_IS_YELLOW_CARP(asic_id.hw_internal_rev))
 			dc_version = DCN_VERSION_3_1;
 		break;
+	case AMDGPU_FAMILY_GC_10_3_7:
+		if (ASICREV_IS_GC_10_3_7(asic_id.hw_internal_rev))
+			dc_version = DCN_VERSION_3_16;
+		break;
 #endif
 
 	default:
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index 5029d4e42dbf..c9ee212b2e80 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -114,6 +114,7 @@ bool dal_hw_factory_init(
 	case DCN_VERSION_3_02:
 	case DCN_VERSION_3_03:
 	case DCN_VERSION_3_1:
+	case DCN_VERSION_3_16:
 		dal_hw_factory_dcn30_init(factory);
 		return true;
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index 904bd30bed68..42adba630125 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -109,6 +109,7 @@ bool dal_hw_translate_init(
 	case DCN_VERSION_3_02:
 	case DCN_VERSION_3_03:
 	case DCN_VERSION_3_1:
+	case DCN_VERSION_3_16:
 		dal_hw_translate_dcn30_init(translate);
 		return true;
 #endif
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index e672be6327cb..79f6a9ddb4bd 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -227,7 +227,6 @@ enum {
 #endif
 
 #define FAMILY_YELLOW_CARP                     146
-
 #define YELLOW_CARP_A0 0x01
 #define YELLOW_CARP_B0 0x20
 #define YELLOW_CARP_UNKNOWN 0xFF
@@ -236,6 +235,11 @@ enum {
 #define ASICREV_IS_YELLOW_CARP(eChipRev) ((eChipRev >= YELLOW_CARP_A0) && (eChipRev < YELLOW_CARP_UNKNOWN))
 #endif
 
+#define AMDGPU_FAMILY_GC_10_3_7                151
+#define GC_10_3_7_A0 0x01
+#define GC_10_3_7_UNKNOWN 0xFF
+
+#define ASICREV_IS_GC_10_3_7(eChipRev) ((eChipRev >= GC_10_3_7_A0) && (eChipRev < GC_10_3_7_UNKNOWN))
 
 /*
  * ASIC chip ID
diff --git a/drivers/gpu/drm/amd/display/include/dal_types.h b/drivers/gpu/drm/amd/display/include/dal_types.h
index 012b7c61798c..8ddb25519880 100644
--- a/drivers/gpu/drm/amd/display/include/dal_types.h
+++ b/drivers/gpu/drm/amd/display/include/dal_types.h
@@ -57,6 +57,7 @@ enum dce_version {
 	DCN_VERSION_3_02,
 	DCN_VERSION_3_03,
 	DCN_VERSION_3_1,
+	DCN_VERSION_3_16,
 	DCN_VERSION_MAX
 };
 
-- 
2.34.1

