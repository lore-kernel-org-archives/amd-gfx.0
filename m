Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6C0C33CA5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709422082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w69htxaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709422082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979156EA48;
	Fri, 10 Jan 2020 14:47:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BDB36EA48
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0RQbPlw94PQAZWRZvcCbkUt/LUUCCYLgAX+DVw67RciPm/t8HidZBOO1XmzCrUIlhr2cMLMxAMvYlQ8OKTfzZ2XFNu8SvOe0tzVZ3iG146+wCJcbfQNkFH1RjOq6ucbFBoMwVFaHp5iFikkSt/QNhklpwjY31G1RMalE6UvxKXKBmWrue6+3/hYTzbh/vQDCrAa5ZnHlTVRpOsLOVOKcvEj8/wOciYLAgiZTDPHlwtIuyfa0SAS2Qnq+DyEVoE02QbGNz4AD8KUaLuhYhQ+gTvf6BLeq73305h5L/H6lK21AS07xlEkqq6t55fnzdNqBAspzE98td+YdSBiBcXq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4uqVyt6LH75FcWzwkIHl0R7giwB1758Q9yPatodXHk=;
 b=G0by7MydL1bIiY6dX6BYiE07mCGEqwY4Ktp1KFC/JsRqmmPHwFxIirLyb3LuTl8482FVZ0e12q21Kwbe7xVZUptKdf7NEooBHGxy3qXg7gd8fY1GP4NbKyff9LwMBvu3DowWKYAA4RUTy8ddDSYKDeuJ3jF78Y1ndgVU6jk4hMh76T968C+UdTHT5t7SIpt/pjndEugl145So/xnMtmoOVDWgvtEvn6ngoyl1Fqv0lbgyY04kiWvg/YrT0iyE5HAuKOQwXRrbXsLW3eaVHSXEmLG39saB6/b0klLBUZpkadmX0ZMWXuNU92kj7NPQ91vH2H02ZKtIICBvlXX0C0E7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4uqVyt6LH75FcWzwkIHl0R7giwB1758Q9yPatodXHk=;
 b=w69htxaJQ2qWb+oSAdGVU4Hvg0Mo9oFk6cDUBMdYZ5bt5ZleNdhhE0qp/hMFY+bDmcWiuoPbZmgz34q+vfzMeqIDd7NG76JoogyLi77aeljOdSN5lbpK//1BY5gXVi1fb0qPfV4EcQHOhUa20XLVLhfr3c7GRz6qQtMdPsIIMtE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:43 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:43 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 25/43] drm/amd/display: Refactor surface flip programming
Date: Fri, 10 Jan 2020 09:46:37 -0500
Message-Id: <20200110144655.55845-26-Rodrigo.Siqueira@amd.com>
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
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:42 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be35144e-100f-44e3-1f94-08d795dc0c5b
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2524672F2AA8D6E75FC3706198380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(30864003)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mm/GaAdJa7BKRsf7plKFc/3lLoxvszTnT85M0ihFwOeizNSBP+/VmL7ba9KBcp2HWMDHqK885jCGdwCQpxloPT7S3e0zxkDWrMjEJh9MNK8eL81/vjUb6UJzYrFDWHzR2ThbCCggh7h44kpJ/9+zUd3YmOuSOsIuIBoIk58jDZgjlEcwPwz9US4nCWdeu87oAEsuYS76+60uVrd3eUE3TLawJ+1dQxCIgLh2yE4kMULnuAbCaiUCY4PIWDrETW1n9wW34X6He1r/O6VQWPpP5z6+/OpNVImOTnK+QAJY3WHbKvVaZQx2tM1owiAqyDiUpcFPnS9i1YC5Ve12IHG18uWkAs+fopo/8QpTP8Nr7CaLxWaqlTLUuxVtCJOebQ5wD8TuT3yYUNc0AhZy08s9ITAdbiWlmcmc3gGAEA1pO9Fjf/fAqDlaIykethqJjrt9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be35144e-100f-44e3-1f94-08d795dc0c5b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:43.0505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6uutees7PWgYvEh6AZkNpPHK4v1UW8IX9+cJSSyf8DLMRaui/caJlMf7xpgQNxPSVKpgcJmNpTUnlWEjJR4LQ==
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Yongqiang Sun <yongqiang.sun@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

Rework surface programming for RN to separate preparing parameters and
register programming.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c | 324 +++++++-----------
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  16 +-
 2 files changed, 127 insertions(+), 213 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
index 1f4e2cd08d4c..12396c371569 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
@@ -690,28 +690,114 @@ void hubp21_validate_dml_output(struct hubp *hubp,
 				dml_dlg_attr->refcyc_per_meta_chunk_flip_l, dlg_attr.refcyc_per_meta_chunk_flip_l);
 }
 
-static void program_video_progressive_dmcub(
-		struct dc_dmub_srv *dmcub,
+static void program_surface_flip_and_addr(struct hubp *hubp, struct dmub_rb_cmd_flip *surface_flip)
+{
+	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
+
+	REG_UPDATE_3(DCSURF_FLIP_CONTROL,
+					SURFACE_FLIP_TYPE, surface_flip->flip.flip_params.immediate,
+					SURFACE_FLIP_MODE_FOR_STEREOSYNC, surface_flip->flip.flip_params.grph_stereo,
+					SURFACE_FLIP_IN_STEREOSYNC, surface_flip->flip.flip_params.grph_stereo);
+
+	REG_UPDATE(VMID_SETTINGS_0,
+				VMID, surface_flip->flip.flip_params.vmid);
+
+	REG_UPDATE_8(DCSURF_SURFACE_CONTROL,
+			PRIMARY_SURFACE_TMZ, surface_flip->flip.flip_params.tmz_surface,
+			PRIMARY_SURFACE_TMZ_C, surface_flip->flip.flip_params.tmz_surface,
+			PRIMARY_META_SURFACE_TMZ, surface_flip->flip.flip_params.tmz_surface,
+			PRIMARY_META_SURFACE_TMZ_C, surface_flip->flip.flip_params.tmz_surface,
+			SECONDARY_SURFACE_TMZ, surface_flip->flip.flip_params.tmz_surface,
+			SECONDARY_SURFACE_TMZ_C, surface_flip->flip.flip_params.tmz_surface,
+			SECONDARY_META_SURFACE_TMZ, surface_flip->flip.flip_params.tmz_surface,
+			SECONDARY_META_SURFACE_TMZ_C, surface_flip->flip.flip_params.tmz_surface);
+
+	REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH_C, 0,
+			PRIMARY_META_SURFACE_ADDRESS_HIGH_C,
+			 surface_flip->flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH_C);
+
+	REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_C, 0,
+			PRIMARY_META_SURFACE_ADDRESS_C,
+			surface_flip->flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS_C);
+
+	REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH, 0,
+			PRIMARY_META_SURFACE_ADDRESS_HIGH,
+			surface_flip->flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH);
+
+	REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS, 0,
+			PRIMARY_META_SURFACE_ADDRESS,
+			surface_flip->flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS);
+
+	REG_SET(DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH, 0,
+			SECONDARY_META_SURFACE_ADDRESS_HIGH,
+			surface_flip->flip.DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH);
+
+	REG_SET(DCSURF_SECONDARY_META_SURFACE_ADDRESS, 0,
+			SECONDARY_META_SURFACE_ADDRESS,
+			surface_flip->flip.DCSURF_SECONDARY_META_SURFACE_ADDRESS);
+
+
+	REG_SET(DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH, 0,
+			SECONDARY_SURFACE_ADDRESS_HIGH,
+			surface_flip->flip.DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH);
+
+	REG_SET(DCSURF_SECONDARY_SURFACE_ADDRESS, 0,
+			SECONDARY_SURFACE_ADDRESS,
+			surface_flip->flip.DCSURF_SECONDARY_SURFACE_ADDRESS);
+
+
+	REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C, 0,
+			PRIMARY_SURFACE_ADDRESS_HIGH_C,
+			surface_flip->flip.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C);
+
+	REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_C, 0,
+			PRIMARY_SURFACE_ADDRESS_C,
+			surface_flip->flip.DCSURF_PRIMARY_SURFACE_ADDRESS_C);
+
+	REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH, 0,
+			PRIMARY_SURFACE_ADDRESS_HIGH,
+			surface_flip->flip.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH);
+
+	REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS, 0,
+			PRIMARY_SURFACE_ADDRESS,
+			surface_flip->flip.DCSURF_PRIMARY_SURFACE_ADDRESS);
+}
+
+void program_surface_flip_and_addr_dmcub(struct hubp *hubp, struct dmub_rb_cmd_flip *surface_flip)
+{
+	struct dc_dmub_srv *dmcub = hubp->ctx->dmub_srv;
+	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
+
+	PERF_TRACE();  // TODO: remove after performance is stable.
+	dc_dmub_srv_cmd_queue(dmcub, &surface_flip->header);
+	PERF_TRACE();  // TODO: remove after performance is stable.
+	dc_dmub_srv_cmd_execute(dmcub);
+	PERF_TRACE();  // TODO: remove after performance is stable.
+	dc_dmub_srv_wait_idle(dmcub);
+	PERF_TRACE();  // TODO: remove after performance is stable.
+}
+
+bool hubp21_program_surface_flip_and_addr(
 		struct hubp *hubp,
 		const struct dc_plane_address *address,
 		bool flip_immediate)
 {
-	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
 	struct dmub_rb_cmd_flip surface_flip = { 0 };
+	bool grph_stereo = false;
+	struct dc_debug_options *debug = &hubp->ctx->dc->debug;
+	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
 
 	surface_flip.header.type = DMUB_CMD__SURFACE_FLIP;
 
-	surface_flip.flip.addr_type = address->type;
-	surface_flip.flip.immediate = flip_immediate;
-	surface_flip.flip.vmid = address->vmid;
-
-	surface_flip.flip.hubp_inst = hubp->inst;
-	surface_flip.flip.tmz_surface = address->tmz_surface;
+	surface_flip.flip.flip_params.vmid = address->vmid;
+	surface_flip.flip.flip_params.hubp_inst = hubp->inst;
 
 	switch (address->type) {
 	case PLN_ADDR_TYPE_GRAPHICS:
-		if (address->grph.addr.quad_part == 0)
-			return;
+		if (address->grph.addr.quad_part == 0) {
+			BREAK_TO_DEBUGGER();
+			break;
+		}
 
 		if (address->grph.meta_addr.quad_part != 0) {
 			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS =
@@ -728,7 +814,7 @@ static void program_video_progressive_dmcub(
 	case PLN_ADDR_TYPE_VIDEO_PROGRESSIVE:
 		if (address->video_progressive.luma_addr.quad_part == 0
 				|| address->video_progressive.chroma_addr.quad_part == 0)
-			return;
+			break;
 
 		if (address->video_progressive.luma_meta_addr.quad_part != 0) {
 			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS =
@@ -747,19 +833,24 @@ static void program_video_progressive_dmcub(
 		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH =
 				address->video_progressive.luma_addr.high_part;
 
-		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_C =
-				address->video_progressive.chroma_addr.low_part;
+		if (debug->nv12_iflip_vm_wa) {
+			surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_C =
+					address->video_progressive.chroma_addr.low_part + hubp21->PLAT_54186_wa_chroma_addr_offset;
+		} else
+			surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_C =
+					address->video_progressive.chroma_addr.low_part;
+
 		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C =
 				address->video_progressive.chroma_addr.high_part;
 
 		break;
 	case PLN_ADDR_TYPE_GRPH_STEREO:
 		if (address->grph_stereo.left_addr.quad_part == 0)
-			return;
+			break;
 		if (address->grph_stereo.right_addr.quad_part == 0)
-			return;
+			break;
 
-		surface_flip.flip.grph_stereo = true;
+		grph_stereo = true;
 
 		if (address->grph_stereo.right_meta_addr.quad_part != 0) {
 			surface_flip.flip.DCSURF_SECONDARY_META_SURFACE_ADDRESS =
@@ -786,200 +877,21 @@ static void program_video_progressive_dmcub(
 				address->grph_stereo.right_addr.high_part;
 
 		break;
-
-	}
-
-	PERF_TRACE();  // TODO: remove after performance is stable.
-	dc_dmub_srv_cmd_queue(dmcub, &surface_flip.header);
-	PERF_TRACE();  // TODO: remove after performance is stable.
-	dc_dmub_srv_cmd_execute(dmcub);
-	PERF_TRACE();  // TODO: remove after performance is stable.
-	dc_dmub_srv_wait_idle(dmcub);
-}
-
-bool hubp21_program_surface_flip_and_addr(
-	struct hubp *hubp,
-	const struct dc_plane_address *address,
-	bool flip_immediate)
-{
-	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
-	struct dc_debug_options *debug = &hubp->ctx->dc->debug;
-
-
-	if (hubp->ctx->dc->debug.enable_dmcub_surface_flip) {
-		program_video_progressive_dmcub(hubp->ctx->dmub_srv, hubp, address, flip_immediate);
-		hubp->request_address = *address;
-		return true;
-	}
-
-	//program flip type
-	REG_UPDATE(DCSURF_FLIP_CONTROL,
-			SURFACE_FLIP_TYPE, flip_immediate);
-
-	// Program VMID reg
-	REG_UPDATE(VMID_SETTINGS_0,
-			VMID, address->vmid);
-
-	if (address->type == PLN_ADDR_TYPE_GRPH_STEREO) {
-		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_MODE_FOR_STEREOSYNC, 0x1);
-		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_IN_STEREOSYNC, 0x1);
-
-	} else {
-		// turn off stereo if not in stereo
-		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_MODE_FOR_STEREOSYNC, 0x0);
-		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_IN_STEREOSYNC, 0x0);
-	}
-
-
-
-	/* HW automatically latch rest of address register on write to
-	 * DCSURF_PRIMARY_SURFACE_ADDRESS if SURFACE_UPDATE_LOCK is not used
-	 *
-	 * program high first and then the low addr, order matters!
-	 */
-	switch (address->type) {
-	case PLN_ADDR_TYPE_GRAPHICS:
-		/* DCN1.0 does not support const color
-		 * TODO: program DCHUBBUB_RET_PATH_DCC_CFGx_0/1
-		 * base on address->grph.dcc_const_color
-		 * x = 0, 2, 4, 6 for pipe 0, 1, 2, 3 for rgb and luma
-		 * x = 1, 3, 5, 7 for pipe 0, 1, 2, 3 for chroma
-		 */
-
-		if (address->grph.addr.quad_part == 0)
-			break;
-
-		REG_UPDATE_2(DCSURF_SURFACE_CONTROL,
-				PRIMARY_SURFACE_TMZ, address->tmz_surface,
-				PRIMARY_META_SURFACE_TMZ, address->tmz_surface);
-
-		if (address->grph.meta_addr.quad_part != 0) {
-			REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH, 0,
-					PRIMARY_META_SURFACE_ADDRESS_HIGH,
-					address->grph.meta_addr.high_part);
-
-			REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS, 0,
-					PRIMARY_META_SURFACE_ADDRESS,
-					address->grph.meta_addr.low_part);
-		}
-
-		REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH, 0,
-				PRIMARY_SURFACE_ADDRESS_HIGH,
-				address->grph.addr.high_part);
-
-		REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS, 0,
-				PRIMARY_SURFACE_ADDRESS,
-				address->grph.addr.low_part);
-		break;
-	case PLN_ADDR_TYPE_VIDEO_PROGRESSIVE:
-		if (address->video_progressive.luma_addr.quad_part == 0
-				|| address->video_progressive.chroma_addr.quad_part == 0)
-			break;
-
-		REG_UPDATE_4(DCSURF_SURFACE_CONTROL,
-				PRIMARY_SURFACE_TMZ, address->tmz_surface,
-				PRIMARY_SURFACE_TMZ_C, address->tmz_surface,
-				PRIMARY_META_SURFACE_TMZ, address->tmz_surface,
-				PRIMARY_META_SURFACE_TMZ_C, address->tmz_surface);
-
-		if (address->video_progressive.luma_meta_addr.quad_part != 0) {
-			REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH_C, 0,
-					PRIMARY_META_SURFACE_ADDRESS_HIGH_C,
-					address->video_progressive.chroma_meta_addr.high_part);
-
-			REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_C, 0,
-					PRIMARY_META_SURFACE_ADDRESS_C,
-					address->video_progressive.chroma_meta_addr.low_part);
-
-			REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH, 0,
-					PRIMARY_META_SURFACE_ADDRESS_HIGH,
-					address->video_progressive.luma_meta_addr.high_part);
-
-			REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS, 0,
-					PRIMARY_META_SURFACE_ADDRESS,
-					address->video_progressive.luma_meta_addr.low_part);
-		}
-
-		REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C, 0,
-				PRIMARY_SURFACE_ADDRESS_HIGH_C,
-				address->video_progressive.chroma_addr.high_part);
-
-		if (debug->nv12_iflip_vm_wa) {
-			REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_C, 0,
-					PRIMARY_SURFACE_ADDRESS_C,
-					address->video_progressive.chroma_addr.low_part + hubp21->PLAT_54186_wa_chroma_addr_offset);
-		} else {
-			REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_C, 0,
-					PRIMARY_SURFACE_ADDRESS_C,
-					address->video_progressive.chroma_addr.low_part);
-		}
-
-		REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH, 0,
-				PRIMARY_SURFACE_ADDRESS_HIGH,
-				address->video_progressive.luma_addr.high_part);
-
-		REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS, 0,
-				PRIMARY_SURFACE_ADDRESS,
-				address->video_progressive.luma_addr.low_part);
-		break;
-	case PLN_ADDR_TYPE_GRPH_STEREO:
-		if (address->grph_stereo.left_addr.quad_part == 0)
-			break;
-		if (address->grph_stereo.right_addr.quad_part == 0)
-			break;
-
-		REG_UPDATE_8(DCSURF_SURFACE_CONTROL,
-				PRIMARY_SURFACE_TMZ, address->tmz_surface,
-				PRIMARY_SURFACE_TMZ_C, address->tmz_surface,
-				PRIMARY_META_SURFACE_TMZ, address->tmz_surface,
-				PRIMARY_META_SURFACE_TMZ_C, address->tmz_surface,
-				SECONDARY_SURFACE_TMZ, address->tmz_surface,
-				SECONDARY_SURFACE_TMZ_C, address->tmz_surface,
-				SECONDARY_META_SURFACE_TMZ, address->tmz_surface,
-				SECONDARY_META_SURFACE_TMZ_C, address->tmz_surface);
-
-		if (address->grph_stereo.right_meta_addr.quad_part != 0) {
-
-			REG_SET(DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH, 0,
-					SECONDARY_META_SURFACE_ADDRESS_HIGH,
-					address->grph_stereo.right_meta_addr.high_part);
-
-			REG_SET(DCSURF_SECONDARY_META_SURFACE_ADDRESS, 0,
-					SECONDARY_META_SURFACE_ADDRESS,
-					address->grph_stereo.right_meta_addr.low_part);
-		}
-		if (address->grph_stereo.left_meta_addr.quad_part != 0) {
-
-			REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH, 0,
-					PRIMARY_META_SURFACE_ADDRESS_HIGH,
-					address->grph_stereo.left_meta_addr.high_part);
-
-			REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS, 0,
-					PRIMARY_META_SURFACE_ADDRESS,
-					address->grph_stereo.left_meta_addr.low_part);
-		}
-
-		REG_SET(DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH, 0,
-				SECONDARY_SURFACE_ADDRESS_HIGH,
-				address->grph_stereo.right_addr.high_part);
-
-		REG_SET(DCSURF_SECONDARY_SURFACE_ADDRESS, 0,
-				SECONDARY_SURFACE_ADDRESS,
-				address->grph_stereo.right_addr.low_part);
-
-		REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH, 0,
-				PRIMARY_SURFACE_ADDRESS_HIGH,
-				address->grph_stereo.left_addr.high_part);
-
-		REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS, 0,
-				PRIMARY_SURFACE_ADDRESS,
-				address->grph_stereo.left_addr.low_part);
-		break;
 	default:
 		BREAK_TO_DEBUGGER();
 		break;
 	}
 
+	surface_flip.flip.flip_params.vmid = address->vmid;
+	surface_flip.flip.flip_params.grph_stereo = grph_stereo;
+	surface_flip.flip.flip_params.tmz_surface = address->tmz_surface;
+	surface_flip.flip.flip_params.immediate = flip_immediate;
+
+	if (hubp->ctx->dc->debug.enable_dmcub_surface_flip)
+		program_surface_flip_and_addr_dmcub(hubp, &surface_flip);
+	else
+		program_surface_flip_and_addr(hubp, &surface_flip);
+
 	hubp->request_address = *address;
 
 	return true;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 3b79079ec9b8..0c3ae02148a6 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -30,7 +30,7 @@
 #include "dmub_cmd_dal.h"
 #include "dmub_cmd_vbios.h"
 #include "atomfirmware.h"
-#include "dc_hw_types.h"
+
 #define DMUB_RB_CMD_SIZE 64
 #define DMUB_RB_MAX_ENTRY 128
 #define DMUB_RB_SIZE (DMUB_RB_CMD_SIZE * DMUB_RB_MAX_ENTRY)
@@ -165,12 +165,14 @@ struct dmub_cmd_surface_flip {
 	uint32_t DCSURF_SECONDARY_META_SURFACE_ADDRESS;
 	uint32_t DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH;
 	uint32_t DCSURF_SECONDARY_SURFACE_ADDRESS;
-	enum dc_plane_addr_type addr_type;
-	uint8_t hubp_inst;
-	bool tmz_surface;
-	bool immediate;
-	uint8_t vmid;
-	bool grph_stereo;
+	struct {
+		uint8_t hubp_inst : 4;
+		uint8_t tmz_surface : 1;
+		uint8_t immediate :1;
+		uint8_t vmid : 4;
+		uint8_t grph_stereo : 1;
+		uint32_t reserved : 21;
+	} flip_params;
 };
 
 struct dmub_rb_cmd_flip {
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
