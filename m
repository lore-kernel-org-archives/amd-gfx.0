Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175A4C33CA6
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E091B2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ELJsJpq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E091B2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038146EA53;
	Fri, 10 Jan 2020 14:48:26 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770049.outbound.protection.outlook.com [40.107.77.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB536EA49
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZ6A0Y4XOHsUaNQu2S3iaPZ7XMR5u+cI76J9mgYuJ1DsDeEehjE1Fr+AlE70DUjowReDsp7tgi3pMRwI9mfGmxeLqd1QXH+e46R9s06f/eI33J3wxsfuJlI8e5+How9G9pdYqfRxA4mr5ZQHW6v4tRzBzy8kWX4QLlXXHzB+UQiwszzCBIp4R3YFfh+EWxpG9aYEZEk9XKCGGm07vn213ThB4csyaIKInECEe1GcBM/aumdEkqJgwsoW8l2gNt/5PakacF/Idy2DHCVxCulapM8utAGl/xDZChdo5xtFMSTPNt28Ozc75K33m9F04Y1oT3L0V+31t4PiJIx8AvCTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJvsRRuSvgvj1mXz/QqYuaiK1I9acmX2zzkmeUjfBXk=;
 b=lLR+UM6KsLQbDGNsVq7NbVv1r1Z0Y72shtNsI1a/I5O0fZmiQSqQgQU/t9j/EPm2JFzS4DIuYUMh7YV35QozMciydB0fdhBx3JkX6eqoW/cneKhFrOlM4wO9JwEMYLfoAQ9L+TyzHAMxicakowQmXP0gOYd2eoernY1mK6jP/pVJFHOV0AINHutuhfLlwKPlMR0g6ulmO/rzT+mDHSfBQjc5PVYOSovgYIyAXYB6jnllTQxMKPX39BCotQkMzE/XwCJ/DP7QTs8sJolJvocGrh91ElAJXWsofxQcXhvdUQ3gHGiqvGxLRBYm+sS5H7ae043MYo/EpP16BpzrE5tKgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJvsRRuSvgvj1mXz/QqYuaiK1I9acmX2zzkmeUjfBXk=;
 b=ELJsJpq4aP6lcUj9i0asv3w5UzjJGyQKKUQTVnbTq3wPDNmy5oob2yzk1gA8ey/vgcDAijMnvwovit6fsCoNRaHYAqzSSzoHCEhx0+LAdsqdY77dgsI/Ot7ytGcHi2w3kgdVpcAibaJ9Jw9FRb4rD4lO1EvoUMwI5NWqByPfE98=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2378.namprd12.prod.outlook.com (52.132.183.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 14:48:21 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:48:21 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 38/43] drm/amd/display: Only program surface flip for video
 plane via dmcub
Date: Fri, 10 Jan 2020 09:46:50 -0500
Message-Id: <20200110144655.55845-39-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:54 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b9d80f58-01f2-447a-6317-08d795dc1355
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:|MW2PR12MB2378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB237806ABFCB5287A149977AB98380@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(54906003)(52116002)(8676002)(81166006)(81156014)(86362001)(478600001)(7696005)(6916009)(26005)(2906002)(30864003)(316002)(8936002)(16526019)(186003)(66556008)(4326008)(6666004)(6486002)(36756003)(66476007)(5660300002)(956004)(2616005)(66946007)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2378;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/TQZKpDGWXREZt8JzTC0EBx1c4KixXiHNdsfnPk9m6eZrjI5gMv7zRxvKMI6/Q7M5CQ93kmhe5qw0pmUAS7ZeJSG4A4iCq4oHXIhont/vrft9R+5T/RjBKsIqu9HNUtbA93v2W5OB59v7Ci4qK5B6yONbLc/S6KK9nevtdCyQw5aRfr6SibPpiEoWMC8JeucEngds0x3J0Whp5O+pjATnL6sQfB2UwZY4cbE49HdKKZV7CsvWbwCuJ2yzEAnfdDA5u3KSSf/Pn4mOWT47w1oXdMiPmeNh2fAfxnAtbryiqEMOpj+y7wcgaRzhEaQbrPqY6B8x3kEZUlMu9kICp8FiH3JgjafCD2ar/d+NTskTR54E8ivf6FrTToaEHHtxb9cOx4rgN0MY2xY9xz1BG2D5DcLDevBHDBHO3dCOJqInASJxRg8ea2S04vvaEN+8Hh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d80f58-01f2-447a-6317-08d795dc1355
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:54.8030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4FIVEaxZpgspdI7e4xTR4NqUVoRD7OFQRSYAzUCZnDCMBHb13pFfl+TnKRYUQbC37jQ3HcRqqPy2UOVYfhOEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Yongqiang Sun <yongqiang.sun@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

Only need to do surface flip for video plane via dmcub.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c | 130 +++++++++---------
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  20 +++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  19 +--
 3 files changed, 94 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
index 12396c371569..da63fc53cc4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
@@ -690,86 +690,98 @@ void hubp21_validate_dml_output(struct hubp *hubp,
 				dml_dlg_attr->refcyc_per_meta_chunk_flip_l, dlg_attr.refcyc_per_meta_chunk_flip_l);
 }
 
-static void program_surface_flip_and_addr(struct hubp *hubp, struct dmub_rb_cmd_flip *surface_flip)
+static void program_surface_flip_and_addr(struct hubp *hubp, struct surface_flip_registers *flip_regs)
 {
 	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
 
 	REG_UPDATE_3(DCSURF_FLIP_CONTROL,
-					SURFACE_FLIP_TYPE, surface_flip->flip.flip_params.immediate,
-					SURFACE_FLIP_MODE_FOR_STEREOSYNC, surface_flip->flip.flip_params.grph_stereo,
-					SURFACE_FLIP_IN_STEREOSYNC, surface_flip->flip.flip_params.grph_stereo);
+					SURFACE_FLIP_TYPE, flip_regs->immediate,
+					SURFACE_FLIP_MODE_FOR_STEREOSYNC, flip_regs->grph_stereo,
+					SURFACE_FLIP_IN_STEREOSYNC, flip_regs->grph_stereo);
 
 	REG_UPDATE(VMID_SETTINGS_0,
-				VMID, surface_flip->flip.flip_params.vmid);
+				VMID, flip_regs->vmid);
 
 	REG_UPDATE_8(DCSURF_SURFACE_CONTROL,
-			PRIMARY_SURFACE_TMZ, surface_flip->flip.flip_params.tmz_surface,
-			PRIMARY_SURFACE_TMZ_C, surface_flip->flip.flip_params.tmz_surface,
-			PRIMARY_META_SURFACE_TMZ, surface_flip->flip.flip_params.tmz_surface,
-			PRIMARY_META_SURFACE_TMZ_C, surface_flip->flip.flip_params.tmz_surface,
-			SECONDARY_SURFACE_TMZ, surface_flip->flip.flip_params.tmz_surface,
-			SECONDARY_SURFACE_TMZ_C, surface_flip->flip.flip_params.tmz_surface,
-			SECONDARY_META_SURFACE_TMZ, surface_flip->flip.flip_params.tmz_surface,
-			SECONDARY_META_SURFACE_TMZ_C, surface_flip->flip.flip_params.tmz_surface);
+			PRIMARY_SURFACE_TMZ, flip_regs->tmz_surface,
+			PRIMARY_SURFACE_TMZ_C, flip_regs->tmz_surface,
+			PRIMARY_META_SURFACE_TMZ, flip_regs->tmz_surface,
+			PRIMARY_META_SURFACE_TMZ_C, flip_regs->tmz_surface,
+			SECONDARY_SURFACE_TMZ, flip_regs->tmz_surface,
+			SECONDARY_SURFACE_TMZ_C, flip_regs->tmz_surface,
+			SECONDARY_META_SURFACE_TMZ, flip_regs->tmz_surface,
+			SECONDARY_META_SURFACE_TMZ_C, flip_regs->tmz_surface);
 
 	REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH_C, 0,
 			PRIMARY_META_SURFACE_ADDRESS_HIGH_C,
-			 surface_flip->flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH_C);
+			flip_regs->DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH_C);
 
 	REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_C, 0,
 			PRIMARY_META_SURFACE_ADDRESS_C,
-			surface_flip->flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS_C);
+			flip_regs->DCSURF_PRIMARY_META_SURFACE_ADDRESS_C);
 
 	REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH, 0,
 			PRIMARY_META_SURFACE_ADDRESS_HIGH,
-			surface_flip->flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH);
+			flip_regs->DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH);
 
 	REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS, 0,
 			PRIMARY_META_SURFACE_ADDRESS,
-			surface_flip->flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS);
+			flip_regs->DCSURF_PRIMARY_META_SURFACE_ADDRESS);
 
 	REG_SET(DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH, 0,
 			SECONDARY_META_SURFACE_ADDRESS_HIGH,
-			surface_flip->flip.DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH);
+			flip_regs->DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH);
 
 	REG_SET(DCSURF_SECONDARY_META_SURFACE_ADDRESS, 0,
 			SECONDARY_META_SURFACE_ADDRESS,
-			surface_flip->flip.DCSURF_SECONDARY_META_SURFACE_ADDRESS);
+			flip_regs->DCSURF_SECONDARY_META_SURFACE_ADDRESS);
 
 
 	REG_SET(DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH, 0,
 			SECONDARY_SURFACE_ADDRESS_HIGH,
-			surface_flip->flip.DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH);
+			flip_regs->DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH);
 
 	REG_SET(DCSURF_SECONDARY_SURFACE_ADDRESS, 0,
 			SECONDARY_SURFACE_ADDRESS,
-			surface_flip->flip.DCSURF_SECONDARY_SURFACE_ADDRESS);
+			flip_regs->DCSURF_SECONDARY_SURFACE_ADDRESS);
 
 
 	REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C, 0,
 			PRIMARY_SURFACE_ADDRESS_HIGH_C,
-			surface_flip->flip.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C);
+			flip_regs->DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C);
 
 	REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_C, 0,
 			PRIMARY_SURFACE_ADDRESS_C,
-			surface_flip->flip.DCSURF_PRIMARY_SURFACE_ADDRESS_C);
+			flip_regs->DCSURF_PRIMARY_SURFACE_ADDRESS_C);
 
 	REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH, 0,
 			PRIMARY_SURFACE_ADDRESS_HIGH,
-			surface_flip->flip.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH);
+			flip_regs->DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH);
 
 	REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS, 0,
 			PRIMARY_SURFACE_ADDRESS,
-			surface_flip->flip.DCSURF_PRIMARY_SURFACE_ADDRESS);
+			flip_regs->DCSURF_PRIMARY_SURFACE_ADDRESS);
 }
 
-void program_surface_flip_and_addr_dmcub(struct hubp *hubp, struct dmub_rb_cmd_flip *surface_flip)
+void dmcub_PLAT_54186_wa(struct hubp *hubp, struct surface_flip_registers *flip_regs)
 {
 	struct dc_dmub_srv *dmcub = hubp->ctx->dmub_srv;
 	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
+	struct dmub_rb_cmd_PLAT_54186_wa PLAT_54186_wa = { 0 };
+
+	PLAT_54186_wa.header.type = DMUB_CMD__PLAT_54186_WA;
+	PLAT_54186_wa.flip.DCSURF_PRIMARY_SURFACE_ADDRESS = flip_regs->DCSURF_PRIMARY_SURFACE_ADDRESS;
+	PLAT_54186_wa.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_C = flip_regs->DCSURF_PRIMARY_SURFACE_ADDRESS_C;
+	PLAT_54186_wa.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH = flip_regs->DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH;
+	PLAT_54186_wa.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C = flip_regs->DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C;
+	PLAT_54186_wa.flip.flip_params.grph_stereo = flip_regs->grph_stereo;
+	PLAT_54186_wa.flip.flip_params.hubp_inst = hubp->inst;
+	PLAT_54186_wa.flip.flip_params.immediate = flip_regs->immediate;
+	PLAT_54186_wa.flip.flip_params.tmz_surface = flip_regs->tmz_surface;
+	PLAT_54186_wa.flip.flip_params.vmid = flip_regs->vmid;
 
 	PERF_TRACE();  // TODO: remove after performance is stable.
-	dc_dmub_srv_cmd_queue(dmcub, &surface_flip->header);
+	dc_dmub_srv_cmd_queue(dmcub, &PLAT_54186_wa.header);
 	PERF_TRACE();  // TODO: remove after performance is stable.
 	dc_dmub_srv_cmd_execute(dmcub);
 	PERF_TRACE();  // TODO: remove after performance is stable.
@@ -782,15 +794,11 @@ bool hubp21_program_surface_flip_and_addr(
 		const struct dc_plane_address *address,
 		bool flip_immediate)
 {
-	struct dmub_rb_cmd_flip surface_flip = { 0 };
-	bool grph_stereo = false;
 	struct dc_debug_options *debug = &hubp->ctx->dc->debug;
 	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
+	struct surface_flip_registers flip_regs = { 0 };
 
-	surface_flip.header.type = DMUB_CMD__SURFACE_FLIP;
-
-	surface_flip.flip.flip_params.vmid = address->vmid;
-	surface_flip.flip.flip_params.hubp_inst = hubp->inst;
+	flip_regs.vmid = address->vmid;
 
 	switch (address->type) {
 	case PLN_ADDR_TYPE_GRAPHICS:
@@ -800,15 +808,15 @@ bool hubp21_program_surface_flip_and_addr(
 		}
 
 		if (address->grph.meta_addr.quad_part != 0) {
-			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS =
+			flip_regs.DCSURF_PRIMARY_META_SURFACE_ADDRESS =
 					address->grph.meta_addr.low_part;
-			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH =
+			flip_regs.DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH =
 					address->grph.meta_addr.high_part;
 		}
 
-		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS =
+		flip_regs.DCSURF_PRIMARY_SURFACE_ADDRESS =
 				address->grph.addr.low_part;
-		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH =
+		flip_regs.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH =
 				address->grph.addr.high_part;
 		break;
 	case PLN_ADDR_TYPE_VIDEO_PROGRESSIVE:
@@ -817,30 +825,30 @@ bool hubp21_program_surface_flip_and_addr(
 			break;
 
 		if (address->video_progressive.luma_meta_addr.quad_part != 0) {
-			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS =
+			flip_regs.DCSURF_PRIMARY_META_SURFACE_ADDRESS =
 					address->video_progressive.luma_meta_addr.low_part;
-			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH =
+			flip_regs.DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH =
 					address->video_progressive.luma_meta_addr.high_part;
 
-			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS_C =
+			flip_regs.DCSURF_PRIMARY_META_SURFACE_ADDRESS_C =
 					address->video_progressive.chroma_meta_addr.low_part;
-			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH_C =
+			flip_regs.DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH_C =
 					address->video_progressive.chroma_meta_addr.high_part;
 		}
 
-		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS =
+		flip_regs.DCSURF_PRIMARY_SURFACE_ADDRESS =
 				address->video_progressive.luma_addr.low_part;
-		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH =
+		flip_regs.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH =
 				address->video_progressive.luma_addr.high_part;
 
 		if (debug->nv12_iflip_vm_wa) {
-			surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_C =
+			flip_regs.DCSURF_PRIMARY_SURFACE_ADDRESS_C =
 					address->video_progressive.chroma_addr.low_part + hubp21->PLAT_54186_wa_chroma_addr_offset;
 		} else
-			surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_C =
+			flip_regs.DCSURF_PRIMARY_SURFACE_ADDRESS_C =
 					address->video_progressive.chroma_addr.low_part;
 
-		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C =
+		flip_regs.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C =
 				address->video_progressive.chroma_addr.high_part;
 
 		break;
@@ -850,30 +858,30 @@ bool hubp21_program_surface_flip_and_addr(
 		if (address->grph_stereo.right_addr.quad_part == 0)
 			break;
 
-		grph_stereo = true;
+		flip_regs.grph_stereo = true;
 
 		if (address->grph_stereo.right_meta_addr.quad_part != 0) {
-			surface_flip.flip.DCSURF_SECONDARY_META_SURFACE_ADDRESS =
+			flip_regs.DCSURF_SECONDARY_META_SURFACE_ADDRESS =
 					address->grph_stereo.right_meta_addr.low_part;
-			surface_flip.flip.DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH =
+			flip_regs.DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH =
 					address->grph_stereo.right_meta_addr.high_part;
 		}
 
 		if (address->grph_stereo.left_meta_addr.quad_part != 0) {
-			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS =
+			flip_regs.DCSURF_PRIMARY_META_SURFACE_ADDRESS =
 					address->grph_stereo.left_meta_addr.low_part;
-			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH =
+			flip_regs.DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH =
 					address->grph_stereo.left_meta_addr.high_part;
 		}
 
-		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS =
+		flip_regs.DCSURF_PRIMARY_SURFACE_ADDRESS =
 				address->grph_stereo.left_addr.low_part;
-		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH =
+		flip_regs.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH =
 				address->grph_stereo.left_addr.high_part;
 
-		surface_flip.flip.DCSURF_SECONDARY_SURFACE_ADDRESS =
+		flip_regs.DCSURF_SECONDARY_SURFACE_ADDRESS =
 				address->grph_stereo.right_addr.low_part;
-		surface_flip.flip.DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH =
+		flip_regs.DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH =
 				address->grph_stereo.right_addr.high_part;
 
 		break;
@@ -882,15 +890,13 @@ bool hubp21_program_surface_flip_and_addr(
 		break;
 	}
 
-	surface_flip.flip.flip_params.vmid = address->vmid;
-	surface_flip.flip.flip_params.grph_stereo = grph_stereo;
-	surface_flip.flip.flip_params.tmz_surface = address->tmz_surface;
-	surface_flip.flip.flip_params.immediate = flip_immediate;
+	flip_regs.tmz_surface = address->tmz_surface;
+	flip_regs.immediate = flip_immediate;
 
-	if (hubp->ctx->dc->debug.enable_dmcub_surface_flip)
-		program_surface_flip_and_addr_dmcub(hubp, &surface_flip);
+	if (hubp->ctx->dc->debug.enable_dmcub_surface_flip && address->type == PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
+		dmcub_PLAT_54186_wa(hubp, &flip_regs);
 	else
-		program_surface_flip_and_addr(hubp, &surface_flip);
+		program_surface_flip_and_addr(hubp, &flip_regs);
 
 	hubp->request_address = *address;
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 686145933335..2cb8466e657b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -63,6 +63,26 @@ struct hubp {
 	bool power_gated;
 };
 
+struct surface_flip_registers {
+	uint32_t DCSURF_SURFACE_CONTROL;
+	uint32_t DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH;
+	uint32_t DCSURF_PRIMARY_META_SURFACE_ADDRESS;
+	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH;
+	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS;
+	uint32_t DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH_C;
+	uint32_t DCSURF_PRIMARY_META_SURFACE_ADDRESS_C;
+	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C;
+	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS_C;
+	uint32_t DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH;
+	uint32_t DCSURF_SECONDARY_META_SURFACE_ADDRESS;
+	uint32_t DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH;
+	uint32_t DCSURF_SECONDARY_SURFACE_ADDRESS;
+	bool tmz_surface;
+	bool immediate;
+	uint8_t vmid;
+	bool grph_stereo;
+};
+
 struct hubp_funcs {
 	void (*hubp_setup)(
 			struct hubp *hubp,
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 0c3ae02148a6..cd9532b4f14d 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -48,7 +48,7 @@ enum dmub_cmd_type {
 	DMUB_CMD__REG_SEQ_FIELD_UPDATE_SEQ = 2,
 	DMUB_CMD__REG_SEQ_BURST_WRITE = 3,
 	DMUB_CMD__REG_REG_WAIT = 4,
-	DMUB_CMD__SURFACE_FLIP = 5,
+	DMUB_CMD__PLAT_54186_WA = 5,
 	DMUB_CMD__PSR = 64,
 	DMUB_CMD__VBIOS = 128,
 };
@@ -151,20 +151,12 @@ struct dmub_rb_cmd_reg_wait {
 #define PHYSICAL_ADDRESS_LOC union large_integer
 #endif
 
-struct dmub_cmd_surface_flip {
+struct dmub_cmd_PLAT_54186_wa {
 	uint32_t DCSURF_SURFACE_CONTROL;
-	uint32_t DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH;
-	uint32_t DCSURF_PRIMARY_META_SURFACE_ADDRESS;
 	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH;
 	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS;
-	uint32_t DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH_C;
-	uint32_t DCSURF_PRIMARY_META_SURFACE_ADDRESS_C;
 	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C;
 	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS_C;
-	uint32_t DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH;
-	uint32_t DCSURF_SECONDARY_META_SURFACE_ADDRESS;
-	uint32_t DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH;
-	uint32_t DCSURF_SECONDARY_SURFACE_ADDRESS;
 	struct {
 		uint8_t hubp_inst : 4;
 		uint8_t tmz_surface : 1;
@@ -173,11 +165,12 @@ struct dmub_cmd_surface_flip {
 		uint8_t grph_stereo : 1;
 		uint32_t reserved : 21;
 	} flip_params;
+	uint32_t reserved[9];
 };
 
-struct dmub_rb_cmd_flip {
+struct dmub_rb_cmd_PLAT_54186_wa {
 	struct dmub_cmd_header header;
-	struct dmub_cmd_surface_flip flip;
+	struct dmub_cmd_PLAT_54186_wa flip;
 };
 
 struct dmub_cmd_digx_encoder_control_data {
@@ -287,7 +280,7 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_psr_enable psr_enable;
 	struct dmub_rb_cmd_psr_copy_settings psr_copy_settings;
 	struct dmub_rb_cmd_psr_set_level psr_set_level;
-	struct dmub_rb_cmd_flip surface_flip;
+	struct dmub_rb_cmd_PLAT_54186_wa PLAT_54186_wa;
 	struct dmub_rb_cmd_psr_setup psr_setup;
 };
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
