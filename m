Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03187C74A5B
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7092010E0ED;
	Sat, 18 Mar 2023 07:56:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BCB710E0ED
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:56:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXte3iNSeW7OGgy7L2ak7l6Pt3ffYrH1C0nsKcuToV+Zq1a5QQZ8bqk7qWk31CUFXD6PEUAtqyfzfOLTi9QdASXpyLQqImAsLkgH+kdEJiAe4REjEKqq3uRY/IUoyB9Yi8yinuj0dwvFM9byYcZVIqsha1UxVP9bAfW3V3SmymgeBwU78YT8ujoVwq/Yw7EC3kz1iMCFRuIDpIKQNlDJW2/2hmYTm9MP/liPljGjoLCGL2czRTnQ9tRWVP9FBX984Nfc+vtux0gMzBQIiZg8H6H80ltP/rWJwpQnwG2wHR+PC/v2dJcabxKSKWQogaKpfMCKn2I1aCUosHdxfWYYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6em4XflGTy7g/RkeEG7L7XyuRTB+EOy67TyulBFUVCI=;
 b=QALbalh4x6wQjQWwaBZPunWtU+w7oSrfspfFFGCJReCiQs5RA97JJXW4QHuHY8EiiMJHqpNJKjvDoki2bPRjzNv2kKVo4MXpSDo76zFKpZ9VAOTnueRpi63Zpzrp/qiCQzL/MqEoluuC9DQvBIM2u6q5+LmbdsPeKo1ysc94DQRnFMCRRd0vSrUUD9pw1b5YEtzkVEne7xJhsB/bGXgOHFrlzlCMzxkYCYHP/1ahsQzfS58Tjnie+xnlbtRUeia8qmEil6bmWapQ9FM8J2nWuX2LAfp+wnNJI+mrd/vU/GvHm0vKT8DFII3MjP/FkvUUxxUmNb6Bs3VcQDN5imhL6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6em4XflGTy7g/RkeEG7L7XyuRTB+EOy67TyulBFUVCI=;
 b=AqiDMGWCAu5LV2V5xMf09qZ6rHoV57fdQFk+3vUSLq8efkLIankGTBQImclCjghcxIqcWAldd7EmK5Cr0bSnwTs5QdkIfZKR3azXlnZI6p9w0hKxnW5bTulzlHPP2gOJ3L217St23OWYBiKs8VnivKAlY4k9hq01BQm65U/aiqs=
Received: from BN1PR12CA0009.namprd12.prod.outlook.com (2603:10b6:408:e1::14)
 by MW4PR12MB7467.namprd12.prod.outlook.com (2603:10b6:303:212::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Sat, 18 Mar
 2023 07:56:43 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::9b) by BN1PR12CA0009.outlook.office365.com
 (2603:10b6:408:e1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36 via Frontend
 Transport; Sat, 18 Mar 2023 07:56:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.11 via Frontend Transport; Sat, 18 Mar 2023 07:56:42 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:56:35 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/19] drm/amd/display: Implement workaround for writing to
 OTG_PIXEL_RATE_DIV register
Date: Sat, 18 Mar 2023 03:55:57 -0400
Message-ID: <20230318075615.2630-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318075615.2630-1-qingqing.zhuo@amd.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|MW4PR12MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: 820329a3-7af6-4b1b-2689-08db27865044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uM3tzLakpd88fG6kmrF0gIIivIYfOP9wL38h5fIrsvFXx06EnAQpp04Bryd1UhEllJ0BAvTOAnPWTvM++bL4n2ZQILgZEd0H1zZxdD01yKSQr7XxH0E0nnXE4lOCGG19wu1clHcMxsC7I4zYXatIgedC/CoKTGS3yqUW8A4kBYV0FFY550mEQPLEDyBmWft5p/odev5AN9NKxMiGW5P1//js3Vd2bYXGbqJvPfL1qMqmwXbbgWFfUWQbtJc/6GcjWPLHxTObKO0vOfRX08kD2gXMxr5gKIN8vM1TLCrrMl8Kmi+TF/+pa8pr6Xw4UoNDPTYoqpxs3bP7fZZi+stkBV3pgs2bIV1Pznb80RCVKLzTCvLrD+vfrjYzy8LY9+56y/QC1SgXxVzIleS0YGwA8VbqYB5b3zZ/ZgXqiyYD8VLxF1QKK6Fm6hZgHAX0/X6uJqHYg9j6yv/HAWZ5K9G3fdwe+3pvjJa+SX8py1/YLtJ2ykjg4ChkugjgZOYPc19cvjuPtBWKLmt/2GMEXHEBHAcdIRBRgX5CpWeC2U8c6lCadC4Pe9xygqKtIqN3TcYJTQpC4FwyNY7doGA2MJuKIUebYXmobv3IhThSpphOg9tK1hnd0OlRtbczGB+X9KBLmKtEF0LiJZM3m6DmH4de09cDCAPaxx33Ljs44MfIMkMzdIAUF7/XBHF4GyD9Ww06SeFVVqWPlmuXQHlGnbXfV05heakpezGZDP+3SpaZcQA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(36840700001)(40470700004)(46966006)(86362001)(36756003)(82740400003)(356005)(81166007)(8936002)(36860700001)(4326008)(2906002)(41300700001)(5660300002)(44832011)(82310400005)(426003)(40480700001)(6916009)(1076003)(2616005)(83380400001)(336012)(26005)(16526019)(47076005)(54906003)(186003)(316002)(8676002)(6666004)(478600001)(70206006)(70586007)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:56:42.8489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 820329a3-7af6-4b1b-2689-08db27865044
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7467
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Saaem Rizvi <SyedSaaem.Rizvi@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>

[Why and How]
Current implementation requires FPGA builds to take a different
code path from DCN32 to write to OTG_PIXEL_RATE_DIV. Now that
we have a workaround to write to OTG_PIXEL_RATE_DIV register without
blanking display on hotplug on DCN32, we can allow the code paths for
FPGA to be exactly the same allowing for more consistent
testing.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |  3 ++-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c | 22 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h |  3 ++-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  3 ++-
 5 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index 915a20461c77..893c0809cd4e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -230,7 +230,8 @@
 	type DTBCLK_P2_SRC_SEL;\
 	type DTBCLK_P2_EN;\
 	type DTBCLK_P3_SRC_SEL;\
-	type DTBCLK_P3_EN;
+	type DTBCLK_P3_EN;\
+	type DENTIST_DISPCLK_CHG_DONE;
 
 struct dccg_shift {
 	DCCG_REG_FIELD_LIST(uint8_t)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index e4472c6be6c3..5dbef498580b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -42,6 +42,20 @@
 #define DC_LOGGER \
 	dccg->ctx->logger
 
+/* This function is a workaround for writing to OTG_PIXEL_RATE_DIV
+ * without the probability of causing a DIG FIFO error.
+ */
+static void dccg32_wait_for_dentist_change_done(
+	struct dccg *dccg)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	uint32_t dentist_dispclk_value = REG_READ(DENTIST_DISPCLK_CNTL);
+
+	REG_WRITE(DENTIST_DISPCLK_CNTL, dentist_dispclk_value);
+	REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, 1, 50, 2000);
+}
+
 static void dccg32_get_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
@@ -110,21 +124,29 @@ static void dccg32_set_pixel_rate_div(
 		REG_UPDATE_2(OTG_PIXEL_RATE_DIV,
 				OTG0_PIXEL_RATE_DIVK1, k1,
 				OTG0_PIXEL_RATE_DIVK2, k2);
+
+		dccg32_wait_for_dentist_change_done(dccg);
 		break;
 	case 1:
 		REG_UPDATE_2(OTG_PIXEL_RATE_DIV,
 				OTG1_PIXEL_RATE_DIVK1, k1,
 				OTG1_PIXEL_RATE_DIVK2, k2);
+
+		dccg32_wait_for_dentist_change_done(dccg);
 		break;
 	case 2:
 		REG_UPDATE_2(OTG_PIXEL_RATE_DIV,
 				OTG2_PIXEL_RATE_DIVK1, k1,
 				OTG2_PIXEL_RATE_DIVK2, k2);
+
+		dccg32_wait_for_dentist_change_done(dccg);
 		break;
 	case 3:
 		REG_UPDATE_2(OTG_PIXEL_RATE_DIV,
 				OTG3_PIXEL_RATE_DIVK1, k1,
 				OTG3_PIXEL_RATE_DIVK2, k2);
+
+		dccg32_wait_for_dentist_change_done(dccg);
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h
index 271c163e4844..8071ab98d708 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h
@@ -111,7 +111,8 @@
 	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P3_SRC_SEL, mask_sh),\
 	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P3_EN, mask_sh),\
 	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO_SEL, mask_sh),\
-	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO0_SOURCE_SEL, mask_sh)
+	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO0_SOURCE_SEL, mask_sh),\
+	DCCG_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, mask_sh)
 
 
 struct dccg *dccg32_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index f9073b722b36..5016b1313f3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1111,7 +1111,7 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 			*k2_div = PIXEL_RATE_DIV_BY_2;
 		else
 			*k2_div = PIXEL_RATE_DIV_BY_4;
-	} else if (dc_is_dp_signal(stream->signal)) {
+	} else if (dc_is_dp_signal(stream->signal) || dc_is_virtual_signal(stream->signal)) {
 		if (two_pix_per_container) {
 			*k1_div = PIXEL_RATE_DIV_BY_1;
 			*k2_div = PIXEL_RATE_DIV_BY_2;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index aca928edc4e3..10a3350376e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -1276,7 +1276,8 @@ double dcn32_determine_max_vratio_prefetch(struct dc *dc, struct dc_state *conte
       DCCG_SRII(PHASE, DTBCLK_DTO, 0), DCCG_SRII(PHASE, DTBCLK_DTO, 1),        \
       DCCG_SRII(PHASE, DTBCLK_DTO, 2), DCCG_SRII(PHASE, DTBCLK_DTO, 3),        \
       SR(DCCG_AUDIO_DTBCLK_DTO_MODULO), SR(DCCG_AUDIO_DTBCLK_DTO_PHASE),       \
-      SR(OTG_PIXEL_RATE_DIV), SR(DTBCLK_P_CNTL), SR(DCCG_AUDIO_DTO_SOURCE)     \
+      SR(OTG_PIXEL_RATE_DIV), SR(DTBCLK_P_CNTL),                               \
+      SR(DCCG_AUDIO_DTO_SOURCE), SR(DENTIST_DISPCLK_CNTL)                      \
   )
 
 /* VMID */
-- 
2.34.1

