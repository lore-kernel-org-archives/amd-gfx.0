Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D949FC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE15206F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SuSV8ITG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE15206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A2E76E95F;
	Thu, 30 Jul 2020 19:12:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D5AE6E95B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLqjeOVfs7FpCnGpQoxJLLfd08338T+NahwaABhvg3ZS+uW+yQa3qX+5EpmCFglimGXoph+xQl5qS4BAC8aI0doREjXbmMmAvlQUeUzpwDfvaaICQzsIvSWj4kn5tl7jbTAYnYE5NcENlgmmEgInB0+cb2tgqZWwg5FEpOR7L2umRvot3GeOF01+uvPEPogQB7QrPYcXfjJMaDjj6wfPL6Paj5w3lysZ5PXeVOKcyfbOMzFSFOQzOVchtIUQaTywnkwjoeYtnHurqUyq63HWqqN5XQnMxLGOe6OCwVSw04gVR5FFSJLnpAb5uRU+8qbJ7dPNR1ftgOas9EjTatelwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TXR5wLC/w/tFvXvcB5HxZyGSQ1Uz3NQA9oS8oZnRik=;
 b=nkqhjViIGmFGOTE/hUfGROR2Zv24/NkjKApwrRvcZ9YT+nutZ9oL3Z/JFuLX4Aw5XpZbU8UJfZfQ7E09DvLSmvo412rLZ1Fzuaqm//xx61+5kXVWErNx/Bu9VUewhSXJSPlRkYhX4xcK+smvqbFDtgRvjsyCbt+KqOxnn2Gl0n33+rNMfeMZQVjFJZuDIi0HFHT1lUR60XAXvIh6Iv5iww01ajCQ0is9Y9z4WKAmZnh9R/dK7kXwnOS5fDb/inaHF3TBGEB0jB8h3WvJ4EsHkjqCDro914TZwxnXTMncr/tSzWUQULxrYCDicENUA2/YAAPbFl9KxEDUB1xH3JK1xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TXR5wLC/w/tFvXvcB5HxZyGSQ1Uz3NQA9oS8oZnRik=;
 b=SuSV8ITGrZI21Q2AgVfyTxg2G434JrDZ2Sp75dePr5JWtb06rt4lA9qnewmEHpiMNZznNQM9aQUiCfOk24gcrf0N+gR6FgrJmGKBkaqveZtfMGY/AXIO+zorgFoYPWN1zVurZUig2TudxTYGAOG2Ibm9QXdOJbM7CgDtaxUzvCw=
Received: from DM5PR12CA0069.namprd12.prod.outlook.com (2603:10b6:3:103::31)
 by MN2PR12MB3392.namprd12.prod.outlook.com (2603:10b6:208:cb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 30 Jul
 2020 19:12:34 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::80) by DM5PR12CA0069.outlook.office365.com
 (2603:10b6:3:103::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Thu, 30 Jul 2020 19:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.20 via Frontend Transport; Thu, 30 Jul 2020 19:12:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:34 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:33 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 14:12:32 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/16] drm/amd/display: Display goes blank after inst
Date: Thu, 30 Jul 2020 15:11:42 -0400
Message-ID: <20200730191146.33112-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730191146.33112-1-aurabindo.pillai@amd.com>
References: <20200730191146.33112-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2b02624-7ba5-4393-c9b2-08d834bc8418
X-MS-TrafficTypeDiagnostic: MN2PR12MB3392:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3392F7E92853884C4B2EC15E8B710@MN2PR12MB3392.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8SG1L/v6D3eaItkCOC91xaOMLND7DOMgxjoEQGzd2m3+meYLWw2ZHDuGv2DAsS9fnR1xs1NLm6sWqvAUeLpYPRdhgopPgaBtyhug8FVA5UUs7iRoKe4q3EJPR7/MlZnMSZPZe6n13vY6qi0tDWfdbbYJTKSLToEZjJpd27oIVqWyuaUb94HxlQS2fAMdaxF2JyrtpmCT/G2ECE9dfpBy/Ww3l32R9hc/JTNTQER+e48y6jVEbM5vAiA9Oe4jzIOrVbi6NWBQcNJGksx/R0+dI2pY8TTptWyILRe/ZEyrA2HkLeeB/SEsb6B2aiPyN/G2ocT332OhIoRaWzhJ+YxeHGufufJS4JxKZx860bw5uQn0Lx1aCsSO8yp9iSx1+Jjg+rEn3uC+AaIUb1R1QNjSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966005)(70586007)(70206006)(356005)(6916009)(81166007)(82740400003)(4326008)(83380400001)(478600001)(82310400002)(47076004)(54906003)(5660300002)(2906002)(36756003)(8676002)(86362001)(8936002)(7696005)(2616005)(336012)(1076003)(26005)(186003)(6666004)(426003)(316002)(44832011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 19:12:34.6798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b02624-7ba5-4393-c9b2-08d834bc8418
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3392
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

[why]
Display goes blank after driver installation.
Aux tuning parameters must be used for 2.x only.
Wrong dc_golden_table offset was used.

[How]
Implement a new enc3_hw_init function without VBIOS constants usage to
be called for 3.x
Calculate dc_golden_table offset using sum of
base dce_info offset and golden table offset

Signed-off-by: Igor Kravchenko <Igor.Kravchenko@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    |  4 +-
 .../display/dc/dcn30/dcn30_dio_link_encoder.c | 53 ++++++++++++++++++-
 .../display/dc/dcn30/dcn30_dio_link_encoder.h |  2 +
 3 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index f8db92fed9cf..078b7e344185 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2101,7 +2101,7 @@ static struct atom_dc_golden_table_v1 *bios_get_golden_table(
 									DATA_TABLES(dce_info));
 			if (!disp_cntl_tbl_4_4)
 				return NULL;
-			dc_golden_offset = disp_cntl_tbl_4_4->dc_golden_table_offset;
+			dc_golden_offset = DATA_TABLES(dce_info) + disp_cntl_tbl_4_4->dc_golden_table_offset;
 			*dc_golden_table_ver = disp_cntl_tbl_4_4->dc_golden_table_ver;
 			break;
 		}
@@ -2115,7 +2115,7 @@ static struct atom_dc_golden_table_v1 *bios_get_golden_table(
 		return NULL;
 
 	return GET_IMAGE(struct atom_dc_golden_table_v1,
-					 dc_golden_offset);
+			dc_golden_offset);
 }
 
 static enum bp_result bios_get_atom_dc_golden_table(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
index c29326e9856a..2ae159e2dd6e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
@@ -62,7 +62,7 @@ static const struct link_encoder_funcs dcn30_link_enc_funcs = {
 	.read_state = link_enc2_read_state,
 	.validate_output_with_stream =
 			dcn30_link_encoder_validate_output_with_stream,
-	.hw_init = enc2_hw_init,
+	.hw_init = enc3_hw_init,
 	.setup = dcn10_link_encoder_setup,
 	.enable_tmds_output = dcn10_link_encoder_enable_tmds_output,
 	.enable_dp_output = dcn20_link_encoder_enable_dp_output,
@@ -203,3 +203,54 @@ void dcn30_link_encoder_construct(
 		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
 	}
 }
+
+#define AUX_REG(reg)\
+	(enc10->aux_regs->reg)
+
+#define AUX_REG_READ(reg_name) \
+		dm_read_reg(CTX, AUX_REG(reg_name))
+
+#define AUX_REG_WRITE(reg_name, val) \
+			dm_write_reg(CTX, AUX_REG(reg_name), val)
+void enc3_hw_init(struct link_encoder *enc)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
+/*
+	00 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__1to2 : 1/2
+	01 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__3to4 : 3/4
+	02 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__7to8 : 7/8
+	03 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__15to16 : 15/16
+	04 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__31to32 : 31/32
+	05 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__63to64 : 63/64
+	06 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__127to128 : 127/128
+	07 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__255to256 : 255/256
+*/
+
+/*
+	AUX_REG_UPDATE_5(AUX_DPHY_RX_CONTROL0,
+	AUX_RX_START_WINDOW = 1 [6:4]
+	AUX_RX_RECEIVE_WINDOW = 1 default is 2 [10:8]
+	AUX_RX_HALF_SYM_DETECT_LEN  = 1 [13:12] default is 1
+	AUX_RX_TRANSITION_FILTER_EN = 1 [16] default is 1
+	AUX_RX_ALLOW_BELOW_THRESHOLD_PHASE_DETECT [17] is 0  default is 0
+	AUX_RX_ALLOW_BELOW_THRESHOLD_START [18] is 1  default is 1
+	AUX_RX_ALLOW_BELOW_THRESHOLD_STOP [19] is 1  default is 1
+	AUX_RX_PHASE_DETECT_LEN,  [21,20] = 0x3 default is 3
+	AUX_RX_DETECTION_THRESHOLD [30:28] = 1
+*/
+	AUX_REG_WRITE(AUX_DPHY_RX_CONTROL0, 0x103d1110);
+
+	AUX_REG_WRITE(AUX_DPHY_TX_CONTROL, 0x21c7a);
+
+	//AUX_DPHY_TX_REF_CONTROL'AUX_TX_REF_DIV HW default is 0x32;
+	// Set AUX_TX_REF_DIV Divider to generate 2 MHz reference from refclk
+	// 27MHz -> 0xd
+	// 100MHz -> 0x32
+	// 48MHz -> 0x18
+
+	// Set TMDS_CTL0 to 1.  This is a legacy setting.
+	REG_UPDATE(TMDS_CTL_BITS, TMDS_CTL0, 1);
+
+	dcn10_aux_initialize(enc10);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h
index 585d1ce63db1..8e9fd59ccde8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h
@@ -73,4 +73,6 @@ void dcn30_link_encoder_construct(
 	const struct dcn10_link_enc_shift *link_shift,
 	const struct dcn10_link_enc_mask *link_mask);
 
+void enc3_hw_init(struct link_encoder *enc);
+
 #endif /* __DC_LINK_ENCODER__DCN30_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
