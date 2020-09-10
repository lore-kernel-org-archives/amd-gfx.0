Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD435C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E14421D81
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tuv2TJwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E14421D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B2856E95A;
	Thu, 10 Sep 2020 13:48:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 246846E95A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:48:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnYMFg+eulFN0MNThEYrcBnN5XviAgGzfMrFwPqbY61NKKN66ZUu7FZrS7pCVB5lyd2bTMqZShd3uLv6/fiFLthMs75+d8I/KP66lnzP2EWNrzAo9pYatsQakgm5UlV1of6hN3MOlNl2yvRoN/mxa8bygLI0uqlifyG6YV7BInAMepCeKzTwiylTQPQx6OgfWIa0AtY6Fr1pPNw7xaQMPP7GHM0vq+GXMKBo/pq6rbmjsZhoEtR1TZ0IwNt0us8Jd52hq6sUlyC+rkpQafTLx9uGP6R9zWKotYe6bFzzIzKH1JCmW3ZiKfGUIz0G4EEnv3VG2suDiO1pt3rLSWFC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqjFRhBKvpK1IDpTyyyJMgy6fOWFeeS5L2wUiQIMICY=;
 b=JvFdBCaUWjm5Elun6RownJJXCCR9HBHXUqZYkQR/3vH81+R3NIkpdEdq/RxvoMjzNcR/NzCwVd0YJoR641+w0matGV4RhQg0tLVHDis0MVDLY2JHeu7D73DMuAcZkzmrMhLsGXp/e1drMVFiWtWqYwcYRTtdPUEKRZNYwvIV6wbzpJ4L2U2oSmemHCJoLW6L8Z612Kfefq0Ec2iAlch+RAjWmf2+KDELKPHYeWkBVfcjzjnzpV51f7ZXomK4eW4A8kCJM1qkh7sONcTJKyA/kTNUpIlqK0tP3BUhPl84pfWTF1m46tP5YJl9AwiptK8fPL6CRqrgWrIVfUWCT1z+eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqjFRhBKvpK1IDpTyyyJMgy6fOWFeeS5L2wUiQIMICY=;
 b=tuv2TJwCxGkJPLd93fmaaBkI2mrfIMBCw7EoP9L85klkwXSziWL+4/lbsNFS6GQSb1k/34mlTqIbaN6Xl/pLtokKq375z0zXATu7q0i7rqyY2NffgXkw9ePXGnMfJTr2h505Mvg8M7EU6MVoo0xW0VgpxCPFdVQ5yQRq+HUrzpo=
Received: from BN1PR12CA0018.namprd12.prod.outlook.com (2603:10b6:408:e1::23)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:48:22 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::9) by BN1PR12CA0018.outlook.office365.com
 (2603:10b6:408:e1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:48:21 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:48:17 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:48:16 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 40/42] drm/amd/display: get socBB from VBIOS
Date: Thu, 10 Sep 2020 09:47:21 -0400
Message-ID: <20200910134723.27410-41-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 304de83a-fdb5-4242-7868-08d855902ea6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18828C0F54BB361F3ACC16968B270@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnK3C/99rG/gxsDP+izDbwzoIkGjBdc+HbJHXIPej8Ryl88xFprNpBNsmsqAAhS1wb+KLleHUZevWz6ln6Izo0Ib4/Kb4FlxzLTpjQJsZJVk6YqJ5scD03bzKyJwPHhvCUiLttb6D7+XsAX5NBb157PBZd02FEW0mCW1vCzyBO8aihMPfPtdW8YzEyXJNF+y700MKzNB60sW6fA+oWrWoxBtIayjIvQAjk/KrHvM9AgvrHbKln+ACe8jkwN83PQxkk83vDlP7XeL+gWllPDv2jyRLlLPUlEwzZ4iteem/dMC2nE1H3/awwFkpzsrGlOBQ3kr1NNvCA9ZRHTRHQvkZfkq7DT7OlxbnDGTXKH+wd3WXDAM5Ih9YIPcPd8FgV/Pmij1ob4GLMbZr1wYPFAHBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966005)(8936002)(54906003)(478600001)(6916009)(26005)(82740400003)(47076004)(426003)(186003)(336012)(86362001)(7696005)(44832011)(356005)(81166007)(83380400001)(70206006)(70586007)(82310400003)(36756003)(2616005)(6666004)(8676002)(2906002)(5660300002)(1076003)(316002)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:48:21.8798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 304de83a-fdb5-4242-7868-08d855902ea6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <Jun.Lei@amd.com>

[why]
Some SOC BB paramters may vary per SKU, and it does
not make sense for driver to hardcode these values

[how]
Parse the values from VBIOS if available, and use
them if valid

Signed-off-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 71 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |  4 ++
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 16 +++++
 .../amd/display/include/bios_parser_types.h   |  6 ++
 4 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 2d5c7daaee23..29d64e7e304f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -847,6 +847,73 @@ static enum bp_result bios_parser_get_spread_spectrum_info(
 	return result;
 }
 
+static enum bp_result get_soc_bb_info_v4_4(
+	struct bios_parser *bp,
+	struct bp_soc_bb_info *soc_bb_info)
+{
+	enum bp_result result = BP_RESULT_OK;
+	struct atom_display_controller_info_v4_4 *disp_cntl_tbl = NULL;
+
+	if (!soc_bb_info)
+		return BP_RESULT_BADINPUT;
+
+	if (!DATA_TABLES(dce_info))
+		return BP_RESULT_BADBIOSTABLE;
+
+	if (!DATA_TABLES(smu_info))
+		return BP_RESULT_BADBIOSTABLE;
+
+	disp_cntl_tbl =  GET_IMAGE(struct atom_display_controller_info_v4_4,
+							DATA_TABLES(dce_info));
+	if (!disp_cntl_tbl)
+		return BP_RESULT_BADBIOSTABLE;
+
+	soc_bb_info->dram_clock_change_latency_100ns = disp_cntl_tbl->max_mclk_chg_lat;
+	soc_bb_info->dram_sr_enter_exit_latency_100ns = disp_cntl_tbl->max_sr_enter_exit_lat;
+	soc_bb_info->dram_sr_exit_latency_100ns = disp_cntl_tbl->max_sr_exit_lat;
+
+	return result;
+}
+
+static enum bp_result bios_parser_get_soc_bb_info(
+	struct dc_bios *dcb,
+	struct bp_soc_bb_info *soc_bb_info)
+{
+	struct bios_parser *bp = BP_FROM_DCB(dcb);
+	enum bp_result result = BP_RESULT_UNSUPPORTED;
+	struct atom_common_table_header *header;
+	struct atom_data_revision tbl_revision;
+
+	if (!soc_bb_info) /* check for bad input */
+		return BP_RESULT_BADINPUT;
+
+	if (!DATA_TABLES(dce_info))
+		return BP_RESULT_UNSUPPORTED;
+
+	header = GET_IMAGE(struct atom_common_table_header,
+						DATA_TABLES(dce_info));
+	get_atom_data_table_revision(header, &tbl_revision);
+
+	switch (tbl_revision.major) {
+	case 4:
+		switch (tbl_revision.minor) {
+		case 1:
+		case 2:
+		case 3:
+			break;
+		case 4:
+			result = get_soc_bb_info_v4_4(bp, soc_bb_info);
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
@@ -2222,7 +2289,9 @@ static const struct dc_vbios_funcs vbios_funcs = {
 
 	.get_atom_dc_golden_table = bios_get_atom_dc_golden_table,
 
-	.enable_lvtma_control = bios_parser_enable_lvtma_control
+	.enable_lvtma_control = bios_parser_enable_lvtma_control,
+
+	.get_soc_bb_info = bios_parser_get_soc_bb_info,
 };
 
 static bool bios_parser2_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index 0811f941f430..e146e3cba8eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -140,6 +140,10 @@ struct dc_vbios_funcs {
 	enum bp_result (*enable_lvtma_control)(
 		struct dc_bios *bios,
 		uint8_t uc_pwr_on);
+
+	enum bp_result (*get_soc_bb_info)(
+		struct dc_bios *dcb,
+		struct bp_soc_bb_info *soc_bb_info);
 };
 
 struct bios_registers {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 168e6e4efaf4..dde87baf1370 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1828,6 +1828,22 @@ static bool init_soc_bounding_box(struct dc *dc,
 	loaded_ip->max_num_dpp = pool->base.pipe_count;
 	loaded_ip->clamp_min_dcfclk = dc->config.clamp_min_dcfclk;
 	dcn20_patch_bounding_box(dc, loaded_bb);
+
+	if (!bb && dc->ctx->dc_bios->funcs->get_soc_bb_info) {
+		struct bp_soc_bb_info bb_info = {0};
+
+		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
+			if (bb_info.dram_clock_change_latency_100ns > 0)
+				dcn3_0_soc.dram_clock_change_latency_us = bb_info.dram_clock_change_latency_100ns * 10;
+
+			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
+				dcn3_0_soc.sr_enter_plus_exit_time_us = bb_info.dram_sr_enter_exit_latency_100ns * 10;
+
+			if (bb_info.dram_sr_exit_latency_100ns > 0)
+				dcn3_0_soc.sr_exit_time_us = bb_info.dram_sr_exit_latency_100ns * 10;
+		}
+	}
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/include/bios_parser_types.h b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
index 21011edea337..7c782924c941 100644
--- a/drivers/gpu/drm/amd/display/include/bios_parser_types.h
+++ b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
@@ -318,4 +318,10 @@ struct bp_encoder_cap_info {
 	uint32_t RESERVED:27;
 };
 
+struct bp_soc_bb_info {
+	uint32_t dram_clock_change_latency_100ns;
+	uint32_t dram_sr_exit_latency_100ns;
+	uint32_t dram_sr_enter_exit_latency_100ns;
+};
+
 #endif /*__DAL_BIOS_PARSER_TYPES_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
