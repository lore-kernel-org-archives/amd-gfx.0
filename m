Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B28FC3F2CD
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3EE21D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f2DTeuc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3EE21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4DBC6E5D4;
	Mon,  2 Mar 2020 16:48:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8926E5D2
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9sMq0v/5hDQoF+rf1lwKf4OE6e3FJgnfmD5FwzTwYux9Ivx/iaJqMYvhKOYws2OVCYBGROO7LJ6MUnM4Wx9pexi3mzbRtkvPPAzc6YAyg6UeZqkyxI3FIQ+qkEc+fuQZ69/3xSkZPdg9w5WsoZT+U6CazhsMwRfV/Dy2ISGmBNx1Vei4Aw4pycaDHDUEuznv8DrsHWAAX0SoWa+uWYQTu/XLBPoKwSxXQkvrW27Th6dUozwsucoMoWZ6jlfiAy0X0LJWqLuFr10RolqynlRGZRBUo4sgCZdBB9IfHcnxMH6GPJaB/hXkeMyPIwnA5QQd+ozzeeTYxbRNvoOghWZxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnCG1Rgi5mPbl0ybljo2ohehZ5FUAHgeS5v0R9S78t0=;
 b=EEZ/TGSGbefT9Dulxw1ZPGfM/WRBp1MceciMDs930yguXlppgQXCaRNrVqiDqs9rJMSklADRZOPsud78zfVld/5h1T3DnYoTOmXToMdt8tjcH2NrwPOzKIve1cMdDJigBfQ/ibfrjyvL9i73CqmdYgfVDAxlsom3nIdvqkpRneY1Q6F8yWE79SisbK7anu5hg32Sup3JkDO8E5l5rzQ+wZygV9HZ0MLSFuxM6LCum5Un1OghauLbDy9ujE6hnBdplw1BpyaG6HyxMDdX89LD8I3Hsq+U2vYnEfU6rYHDJArSSiM91hgwTOIbyu8ZRuj+EjySQoV1rl2XhEz35awlGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnCG1Rgi5mPbl0ybljo2ohehZ5FUAHgeS5v0R9S78t0=;
 b=f2DTeuc4/23VJdksLNAgl3tfmR4PFCaeeOvIe084U+CCssGFMSEO2XsuJ/BqUzuyz9/ZSPENqst0yypxHgYyodBUSrKzbkgSzEesyB63HyoxZEZi6JxuyVFpC2MSMdFFSvmlKL5ahi1H4COLnw/V2es83BBtGiXvndj3rSd5Wxc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2540.namprd12.prod.outlook.com (2603:10b6:907:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 16:48:04 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:48:04 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/22] drm/amd/display: change number of cursor policy for dml
 calculation.
Date: Mon,  2 Mar 2020 11:47:29 -0500
Message-Id: <20200302164736.89429-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:48:03 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b96fb49-da0f-435c-ee12-08d7bec97a17
X-MS-TrafficTypeDiagnostic: MW2PR12MB2540:|MW2PR12MB2540:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2540A52CB228BADEDDD0727198E70@MW2PR12MB2540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(189003)(199004)(54906003)(316002)(7696005)(52116002)(8936002)(6486002)(86362001)(6666004)(36756003)(81166006)(81156014)(8676002)(1076003)(5660300002)(16526019)(2616005)(4326008)(2906002)(186003)(956004)(478600001)(6916009)(66556008)(66946007)(66476007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2540;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: unuOSSTgLSAfl2YWfSwI5nXx2lcUUCjbqfF1SadVCY/X2Ov6vER9f28hefo7mH8+2nhrAZwKFso/jMq17HS1X3iXJ9GSZFLpRxHxQaox+Jg79P+RxA3T8RI9/CdWkPw0HQ6O8aQI0XyELOpbksSlTEDNHygbYDxZzKVstfil1QRB4sSgP6Xvf7QBTAoNXu3Y8r2OELE3vbHLxCxvQdey8mk3GMGiVLisgvIxQL5uZESsaizKm4z/auJ75Oy/sAt+FilosdIItS0iydiDz+I5Pa1BLEwJBfwPQKlhG9nNp2VU248ELHjpSP0W79axZLNMs8jHw7n9tKsAhTaHzjgaRY1MuWtiY4LIhiieDT7Nn+lam4/M7yRdb/sShESZpRvo3GvbEG05dRzy7DiZwA8K2qZZ3XBv7v3aGaIRrrlToyd6rquju9NXgFUTrIaOMdnH
X-MS-Exchange-AntiSpam-MessageData: 7e2tpfxIwMrtTKqIFcSzjp9oyYI0W9AQYTGbpQ+ABemojPOYgMJBoWGtreqPpiYD7BGzfG5HVgwZCFXtfb4yW0xuQVpusP1zvJodfeoE9dACiwuGV9FBS+j/IcMCdj68P7ymSnxRWSI9Z6IoxKqa5Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b96fb49-da0f-435c-ee12-08d7bec97a17
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:48:04.4845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kB3x0gr6MBGVXZwrGcOYX9aNNWYmwjQ+L8dhPFOlELEsC8MmlODyjz36qflZhotu763kOYjJy+8drr8Wbz+tOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2540
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
Cc: Sunpeng.Li@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Rodrigo.Siqueira@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Harry.Wentland@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
vstartup calculation is incorrect due to use 2 number of cursors and
result in an underflow when playing video in full screen mode and
combines graphic plane and video plane.

[How]
Apply new policy for dml calculation.
1 cursor for graphic plane, 0 cursor for video plane.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  6 ++----
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 15 ++++++++++-----
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c |  3 ++-
 .../drm/amd/display/dc/dml/display_mode_structs.h |  1 +
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index a9a43b397db9..94ac34106776 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -299,7 +299,6 @@ void optc1_set_vtg_params(struct timing_generator *optc,
 	uint32_t asic_blank_end;
 	uint32_t v_init;
 	uint32_t v_fp2 = 0;
-	int32_t vertical_line_start;
 
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -316,9 +315,8 @@ void optc1_set_vtg_params(struct timing_generator *optc,
 			patched_crtc_timing.v_border_top;
 
 	/* if VSTARTUP is before VSYNC, FP2 is the offset, otherwise 0 */
-	vertical_line_start = asic_blank_end - optc1->vstartup_start + 1;
-	if (vertical_line_start < 0)
-		v_fp2 = -vertical_line_start;
+	if (optc1->vstartup_start > asic_blank_end)
+		v_fp2 = optc1->vstartup_start - asic_blank_end;
 
 	/* Interlace */
 	if (REG(OTG_INTERLACE_CONTROL)) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 4ce701877ffa..c629a7b45f56 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -153,6 +153,7 @@ struct _vcs_dpi_ip_params_st dcn2_0_ip = {
 	.xfc_supported = true,
 	.xfc_fill_bw_overhead_percent = 10.0,
 	.xfc_fill_constant_bytes = 0,
+	.number_of_cursors = 1,
 };
 
 struct _vcs_dpi_ip_params_st dcn2_0_nv14_ip = {
@@ -220,7 +221,8 @@ struct _vcs_dpi_ip_params_st dcn2_0_nv14_ip = {
 	.xfc_supported = true,
 	.xfc_fill_bw_overhead_percent = 10.0,
 	.xfc_fill_constant_bytes = 0,
-	.ptoi_supported = 0
+	.ptoi_supported = 0,
+	.number_of_cursors = 1,
 };
 
 struct _vcs_dpi_soc_bounding_box_st dcn2_0_soc = {
@@ -2042,14 +2044,17 @@ int dcn20_populate_dml_pipes_from_context(
 		/* todo: default max for now, until there is logic reflecting this in dc*/
 		pipes[pipe_cnt].dout.output_bpc = 12;
 		/*
-		 * Use max cursor settings for calculations to minimize
+		 * For graphic plane, cursor number is 1, nv12 is 0
 		 * bw calculations due to cursor on/off
 		 */
-		pipes[pipe_cnt].pipe.src.num_cursors = 2;
+		if (res_ctx->pipe_ctx[i].plane_state &&
+				res_ctx->pipe_ctx[i].plane_state->address.type == PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
+			pipes[pipe_cnt].pipe.src.num_cursors = 0;
+		else
+			pipes[pipe_cnt].pipe.src.num_cursors = dc->dml.ip.number_of_cursors;
+
 		pipes[pipe_cnt].pipe.src.cur0_src_width = 256;
 		pipes[pipe_cnt].pipe.src.cur0_bpp = dm_cur_32bit;
-		pipes[pipe_cnt].pipe.src.cur1_src_width = 256;
-		pipes[pipe_cnt].pipe.src.cur1_bpp = dm_cur_32bit;
 
 		if (!res_ctx->pipe_ctx[i].plane_state) {
 			pipes[pipe_cnt].pipe.src.is_hsplit = pipes[pipe_cnt].pipe.dest.odm_combine != dm_odm_combine_mode_disabled;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index c87eb7b9c060..158f7c8b55ae 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -156,7 +156,8 @@ struct _vcs_dpi_ip_params_st dcn2_1_ip = {
 	.xfc_supported = false,
 	.xfc_fill_bw_overhead_percent = 10.0,
 	.xfc_fill_constant_bytes = 0,
-	.ptoi_supported = 0
+	.ptoi_supported = 0,
+	.number_of_cursors = 1,
 };
 
 struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index a1d68e06cf21..dfd3be452766 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -204,6 +204,7 @@ struct _vcs_dpi_ip_params_st {
 	unsigned int LineBufferFixedBpp;
 	unsigned int can_vstartup_lines_exceed_vsync_plus_back_porch_lines_minus_one;
 	unsigned int bug_forcing_LC_req_same_size_fixed;
+	unsigned int number_of_cursors;
 };
 
 struct _vcs_dpi_display_xfc_params_st {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
