Return-Path: <SRS0=wil9=7Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8B2C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 23:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8492078A
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 23:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Yp5huArS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8492078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 378CE6E388;
	Fri, 12 Jun 2020 23:50:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 484626E398
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2020 23:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHSP4VWXwfc0qShWGuIBswlieLS1H2ZYXdT+W8RTRxwhap/+5ztG1McoCxx+ZY6uh1OgTXWnQQox6rjQjNGxKJyvq0Wbf4RkYoMf3YUIzWdNRqnOm69k/yg4cCe9ivylWGG+nnTxN5v6WKBFdUdCVSc4ET8OxThkYibaV7RQfJOBfh+53kp6gyezOGHe5LTv6BatvK57+9rS7pByikE6PjBB68WeBn0hNfZlPjYfV1WGMhDR8PE/m6cb5ioL7OOZujYZf8cvvQ/XGIcFRxllXTiin4CpxUpa/o9GZ9ctl5mPUo88XjJHGdk8b2svBoD5m6t2rMjn5VW47HKgnQ/v9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gICqw0mMWZAbzmkTdilVjvX9SdfJK+Xy5wmSvffykf8=;
 b=GVm9v/ymc9Mk9R7eBTWrnOgMhMicqjGk6p+vO39THqiS9Bv79EhIjgbMDcoqYDFJGkmx7xzkhrEUU4o+bO2VTPtV7sYCn7S0CHO0va53JBTI4+N/ahl6Ih13JugkJhRs7CLrjDX4IRoOph94Zw66L/CV0T3m+K4qZxI5uiq5hOsthbSQqmLFKSS8BT6QKOo1fqM6lSC9Uw5KNRoMr8/8JovWkvYV9q97P4DT1dhtpu17KAMUbXuXh1czObtxPbJ+k/rv2LybBmHOkdHDZeM+BXri5H66wqTipnsDBecMcbmAs2jfpUXYdUPY44eZv4x9SxoJna8umPrLHL2k9B8lwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gICqw0mMWZAbzmkTdilVjvX9SdfJK+Xy5wmSvffykf8=;
 b=Yp5huArSpkc/pc6KgbYada2mRtVeH+axPZ4gduTC+0dnBryy0BjDht5vlB7qBI+IxhSk7GEOPyp8rDkvluFdyWUd2r1jmF4BuKaNOw7F8yHI2QnEivxfvb4Q2EXvqI2Dbzk9H/qvPdKkelvJrLP5peC/VATBuWfpoWa2PIHf/7A=
Received: from BN6PR02CA0028.namprd02.prod.outlook.com (2603:10b6:404:5f::14)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.20; Fri, 12 Jun
 2020 23:50:42 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:5f:cafe::8a) by BN6PR02CA0028.outlook.office365.com
 (2603:10b6:404:5f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Fri, 12 Jun 2020 23:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3088.18 via Frontend Transport; Fri, 12 Jun 2020 23:50:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 12 Jun
 2020 18:50:41 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 12 Jun
 2020 18:50:41 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 12 Jun 2020 18:50:40 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <nicholas.kazlauskas@amd.com>, <hersenxs.wu@amd.com>
Subject: [PATCH] drm/amd/display: Get num_chans from VBIOS table
Date: Fri, 12 Jun 2020 19:50:37 -0400
Message-ID: <20200612235037.29143-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966005)(186003)(2906002)(82310400002)(26005)(356005)(81166007)(82740400003)(8936002)(47076004)(8676002)(316002)(6636002)(70586007)(70206006)(54906003)(7696005)(110136005)(4326008)(36756003)(6666004)(1076003)(336012)(5660300002)(83380400001)(2616005)(86362001)(426003)(478600001)(2101003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecafdb0f-58fc-4af0-8dc4-08d80f2b6a98
X-MS-TrafficTypeDiagnostic: MN2PR12MB4224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4224A93F6697241101580CD5F9810@MN2PR12MB4224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-Forefront-PRVS: 0432A04947
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jf4nkecj0Q/vCrk/xiT+Wz9wEwNWF2w+G46j7/pjN7Ebcq1cNOfADJ6NfisHOk9A3KJIvag3HvVT4+4QpA+52ZEpYgmNskOaT6wkEqRDSar/9Hp3SoqlQL2IUciHJu9OLr4ZZQaLdkFDuKsvpNogPZFucAs1FK2Tw7B8ViQLaY/UnCOymGznH3Hry4F4/p4/0yoD8bLlKt6mfvQm8uvhxwLyagR8z7Y8Np/qsKLH5FVCvzHJ+ABgMybOcVNHcyPin0uoPGgoBLAczzniQp2kTZUgekPF9s/359R4ifcGjgBYslA9Zy90OeHlU4mGAM2fkt46JmIw7+z18hOKLiYmggP4EgN6WQZvXcZ04EGS0JiD6vEy1ruWHna6hX40aV+aGdCYkSnbD6zGye7E7AWRTLivsxnnqv4BZGWn9e8R6qw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2020 23:50:41.8888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecafdb0f-58fc-4af0-8dc4-08d80f2b6a98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

Get the values from VBIOS table

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 98 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  7 +-
 .../display/include/grph_object_ctrl_defs.h   |  5 +
 4 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 9311fec1643c..b8684131151d 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1378,6 +1378,63 @@ static struct atom_encoder_caps_record *get_encoder_cap_record(
 	return NULL;
 }
 
+static enum bp_result get_vram_info_v23(
+	struct bios_parser *bp,
+	struct dc_vram_info *info)
+{
+	struct atom_vram_info_header_v2_3 *info_v23;
+	enum bp_result result = BP_RESULT_OK;
+
+	info_v23 = GET_IMAGE(struct atom_vram_info_header_v2_3,
+						DATA_TABLES(vram_info));
+
+	if (info_v23 == NULL)
+		return BP_RESULT_BADBIOSTABLE;
+
+	info->num_chans = info_v23->vram_module[0].channel_num;
+	info->dram_channel_width_bytes = (1 << info_v23->vram_module[0].channel_width) / 8;
+
+	return result;
+}
+
+static enum bp_result get_vram_info_v24(
+	struct bios_parser *bp,
+	struct dc_vram_info *info)
+{
+	struct atom_vram_info_header_v2_4 *info_v24;
+	enum bp_result result = BP_RESULT_OK;
+
+	info_v24 = GET_IMAGE(struct atom_vram_info_header_v2_4,
+						DATA_TABLES(vram_info));
+
+	if (info_v24 == NULL)
+		return BP_RESULT_BADBIOSTABLE;
+
+	info->num_chans = info_v24->vram_module[0].channel_num;
+	info->dram_channel_width_bytes = (1 << info_v24->vram_module[0].channel_width) / 8;
+
+	return result;
+}
+
+static enum bp_result get_vram_info_v25(
+	struct bios_parser *bp,
+	struct dc_vram_info *info)
+{
+	struct atom_vram_info_header_v2_5 *info_v25;
+	enum bp_result result = BP_RESULT_OK;
+
+	info_v25 = GET_IMAGE(struct atom_vram_info_header_v2_5,
+						DATA_TABLES(vram_info));
+
+	if (info_v25 == NULL)
+		return BP_RESULT_BADBIOSTABLE;
+
+	info->num_chans = info_v25->vram_module[0].channel_num;
+	info->dram_channel_width_bytes = (1 << info_v25->vram_module[0].channel_width) / 8;
+
+	return result;
+}
+
 /*
  * get_integrated_info_v11
  *
@@ -1669,6 +1726,46 @@ static enum bp_result construct_integrated_info(
 	return result;
 }
 
+static enum bp_result bios_parser_get_vram_info(
+		struct dc_bios *dcb,
+		struct dc_vram_info *info)
+{
+	struct bios_parser *bp = BP_FROM_DCB(dcb);
+	enum bp_result result = BP_RESULT_BADBIOSTABLE;
+	struct atom_common_table_header *header;
+	struct atom_data_revision revision;
+
+	if (info && DATA_TABLES(vram_info)) {
+		header = GET_IMAGE(struct atom_common_table_header,
+					DATA_TABLES(vram_info));
+
+		get_atom_data_table_revision(header, &revision);
+
+		switch (revision.major) {
+		case 2:
+			switch (revision.minor) {
+			case 3:
+				result = get_vram_info_v23(bp, info);
+				break;
+			case 4:
+				result = get_vram_info_v24(bp, info);
+				break;
+			case 5:
+				result = get_vram_info_v25(bp, info);
+				break;
+			default:
+				break;
+			}
+			break;
+
+		default:
+			return result;
+		}
+
+	}
+	return result;
+}
+
 static struct integrated_info *bios_parser_create_integrated_info(
 	struct dc_bios *dcb)
 {
@@ -2112,6 +2209,7 @@ static bool bios_parser2_construct(
 
 	bp->base.integrated_info = bios_parser_create_integrated_info(&bp->base);
 	bp->base.fw_info_valid = bios_parser_get_firmware_info(&bp->base, &bp->base.fw_info) == BP_RESULT_OK;
+	bios_parser_get_vram_info(&bp->base, &bp->base.vram_info);
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index 441768aa53ff..845a3054f21f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -153,6 +153,7 @@ struct dc_bios {
 	struct integrated_info *integrated_info;
 	struct dc_firmware_info fw_info;
 	bool fw_info_valid;
+	struct dc_vram_info vram_info;
 };
 
 #endif /* DC_BIOS_TYPES_H */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 011f1454b8cb..654fdbbff86b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -195,7 +195,6 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc = {
 	.max_avg_dram_bw_use_normal_percent = 40.0,
 	.writeback_latency_us = 12.0,
 	.max_request_size_bytes = 256,
-	.dram_channel_width_bytes = 2,
 	.fabric_datapath_to_dcn_data_return_bytes = 64,
 	.dcn_downspread_percent = 0.5,
 	.downspread_percent = 0.38,
@@ -2242,6 +2241,12 @@ static void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
 {
 	unsigned int i;
 
+	if (dc->ctx->dc_bios->vram_info.num_chans)
+		dcn3_0_soc.num_chans = dc->ctx->dc_bios->vram_info.num_chans;
+
+	if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
+		dcn3_0_soc.dram_channel_width_bytes = dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
+
 	dcn3_0_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 
diff --git a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
index d51de94e4bc3..7a06e3914c00 100644
--- a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
+++ b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
@@ -183,6 +183,11 @@ struct dc_firmware_info {
 
 };
 
+struct dc_vram_info {
+	unsigned int num_chans;
+	unsigned int dram_channel_width_bytes;
+};
+
 struct step_and_delay_info {
 	uint32_t step;
 	uint32_t delay;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
