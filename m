Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C36C33CA4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEDC2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OqPzi7OE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEDC2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5303F6EA46;
	Fri, 10 Jan 2020 14:47:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8146EA41
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko7DZrnze0Rpz1gcOmRkI1uzUnxoDm9fdPqn8oDe4E8sNFGodHQ01Drq1yYFUSDZ4/n4q9Zk1zq1C1xwogK/16soDYpL9zPH22y40hAkfSIXmU3sKTT/fd1SDl7WYrY2L6N4psxbBxVns+s7Nal7xK4eiHnsuYRsnArRylh2DdipARHOHLDIUcp37tIQ/62rbLU6i0rjNw0EABrAV8K8fYZW9W2gkPrPDCTKAfVO68QZEJWBHmwfPOcOQET5coonZagssRB/5ucLkLWv8aD1iyBN8nnnk7EQx1V+UwOG+MTOjS7jwcu6r9EtnfRe9mhvtJxuBa/3o5bAqhL4LI/AYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxQOlwvHIvKN2nfbFBipmyIQYbQBkBvSvG6ml2yBX58=;
 b=EAvjmVKDRNr9KPIjXYFH77Wz7BziUu9tnfckZ3PaAl5QGRDg9YQTc1brynNVoJGSTnA8BiosA9uzQyf2PSbXjgBHNA2StZU5JHwVuK80f8wRAHwPWJ//2an0R+E/ibxYHaQEI9FxDnkNoTVcMirBIAP2lK6RCjfDux6qZcJK/mtHI3CTk5ASqQw/gnE3SosIzU8ArM3DzhmG+TRUvA6BhSTU/rDi6ojEjBbqdJX62b5flzfyPNy9K6thIRwB152eYmAVWfrEohnAhTkovscZise8M/IIXZl2zqrq/4YSd6z3j7hHB3D5qufL8qGpCrRImMzDXWUzv0/OL9W7Vz76+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxQOlwvHIvKN2nfbFBipmyIQYbQBkBvSvG6ml2yBX58=;
 b=OqPzi7OEnN1bl0Z+bD9vnKUEubtNPm4a4kGJTHfjnJLqVoHoROrsJV69p2a7yQOeduJycOY47viy+RoGFee20C84muGijMY6SL9Jd9zpaB7HWNLdtXEoPVzd95mnubh1nwTqoTFz3OGcw3lpAXGORoiBWaNbn6Uu01nsKTxxLOc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:40 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:40 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/43] drm/amd/display: programing surface flip by dmcub.
Date: Fri, 10 Jan 2020 09:46:34 -0500
Message-Id: <20200110144655.55845-23-Rodrigo.Siqueira@amd.com>
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
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:39 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 220c7895-8751-4ccc-e550-08d795dc0aae
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB252446DFF5414F6B37A8E5CD98380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /v9/yfdYXvddu1URhXGnxT3gaMUcC8XrIXhMrmbSESYGzTtGSUg/Y7fFJDtw8ezzsxynTgkikdmtAQMAICkbJUljaQzyqfSqHZrkD6CAr2bFN8Z5v8eI0xgPUUzwk6GhKZr4S4dle7YMB/Iqe3gVXkN+4ZkK//sTlp+XpENV43dfVjfHnPomwtD0pVfGb+CYVT5PWO0YcXysSspEBGPviaBJYkt9Toq2zODevXWiSxTd9WnsBCALQ/0AVzWNNOrTimhJzPIXaDfXs79O2Qo8ejRFGsrp9ood/q2CDlpaqg32OtxIaLnMs+yMsT9OBbY44Nkq5sGkh3DrMmfSMVly0sJmVXi/W8bdO1lu7StPoscR3TFcNLDrZ+pVFJd0uTG4HhimNJeRf8SbYgBK1zAbbJgRQai6/lKl6t0KKoHpitv2OdT+AYL27LE0CwfMiuGI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220c7895-8751-4ccc-e550-08d795dc0aae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:40.2831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDoKmDb0KLka3hb4AR9/6nl6cP6X+59b3EEMtrbcg/Nh+IlzBu+TzpR5Sz85BSpjjfb5e10r1NYqnnv8Nn1zaA==
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

Programming surface flip addresses via dmcub uC for optimizing the data
flush.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c | 116 ++++++++++++++++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  36 +++++-
 .../gpu/drm/amd/display/dmub/inc/dmub_rb.h    |  18 ++-
 4 files changed, 165 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index dfc66954a24b..ecd2257de80b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -420,6 +420,7 @@ struct dc_debug_options {
 	bool nv12_iflip_vm_wa;
 	bool disable_dram_clock_change_vactive_support;
 	bool validate_dml_output;
+	bool enable_dmcub_surface_flip;
 };
 
 struct dc_debug_data {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
index 4d2564f79395..1f4e2cd08d4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
@@ -29,6 +29,8 @@
 #include "dm_services.h"
 #include "reg_helper.h"
 
+#include "dc_dmub_srv.h"
+
 #define DC_LOGGER_INIT(logger)
 
 #define REG(reg)\
@@ -688,6 +690,113 @@ void hubp21_validate_dml_output(struct hubp *hubp,
 				dml_dlg_attr->refcyc_per_meta_chunk_flip_l, dlg_attr.refcyc_per_meta_chunk_flip_l);
 }
 
+static void program_video_progressive_dmcub(
+		struct dc_dmub_srv *dmcub,
+		struct hubp *hubp,
+		const struct dc_plane_address *address,
+		bool flip_immediate)
+{
+	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
+	struct dmub_rb_cmd_flip surface_flip = { 0 };
+
+	surface_flip.header.type = DMUB_CMD__SURFACE_FLIP;
+
+	surface_flip.flip.addr_type = address->type;
+	surface_flip.flip.immediate = flip_immediate;
+	surface_flip.flip.vmid = address->vmid;
+
+	surface_flip.flip.hubp_inst = hubp->inst;
+	surface_flip.flip.tmz_surface = address->tmz_surface;
+
+	switch (address->type) {
+	case PLN_ADDR_TYPE_GRAPHICS:
+		if (address->grph.addr.quad_part == 0)
+			return;
+
+		if (address->grph.meta_addr.quad_part != 0) {
+			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS =
+					address->grph.meta_addr.low_part;
+			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH =
+					address->grph.meta_addr.high_part;
+		}
+
+		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS =
+				address->grph.addr.low_part;
+		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH =
+				address->grph.addr.high_part;
+		break;
+	case PLN_ADDR_TYPE_VIDEO_PROGRESSIVE:
+		if (address->video_progressive.luma_addr.quad_part == 0
+				|| address->video_progressive.chroma_addr.quad_part == 0)
+			return;
+
+		if (address->video_progressive.luma_meta_addr.quad_part != 0) {
+			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS =
+					address->video_progressive.luma_meta_addr.low_part;
+			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH =
+					address->video_progressive.luma_meta_addr.high_part;
+
+			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS_C =
+					address->video_progressive.chroma_meta_addr.low_part;
+			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH_C =
+					address->video_progressive.chroma_meta_addr.high_part;
+		}
+
+		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS =
+				address->video_progressive.luma_addr.low_part;
+		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH =
+				address->video_progressive.luma_addr.high_part;
+
+		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_C =
+				address->video_progressive.chroma_addr.low_part;
+		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C =
+				address->video_progressive.chroma_addr.high_part;
+
+		break;
+	case PLN_ADDR_TYPE_GRPH_STEREO:
+		if (address->grph_stereo.left_addr.quad_part == 0)
+			return;
+		if (address->grph_stereo.right_addr.quad_part == 0)
+			return;
+
+		surface_flip.flip.grph_stereo = true;
+
+		if (address->grph_stereo.right_meta_addr.quad_part != 0) {
+			surface_flip.flip.DCSURF_SECONDARY_META_SURFACE_ADDRESS =
+					address->grph_stereo.right_meta_addr.low_part;
+			surface_flip.flip.DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH =
+					address->grph_stereo.right_meta_addr.high_part;
+		}
+
+		if (address->grph_stereo.left_meta_addr.quad_part != 0) {
+			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS =
+					address->grph_stereo.left_meta_addr.low_part;
+			surface_flip.flip.DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH =
+					address->grph_stereo.left_meta_addr.high_part;
+		}
+
+		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS =
+				address->grph_stereo.left_addr.low_part;
+		surface_flip.flip.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH =
+				address->grph_stereo.left_addr.high_part;
+
+		surface_flip.flip.DCSURF_SECONDARY_SURFACE_ADDRESS =
+				address->grph_stereo.right_addr.low_part;
+		surface_flip.flip.DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH =
+				address->grph_stereo.right_addr.high_part;
+
+		break;
+
+	}
+
+	PERF_TRACE();  // TODO: remove after performance is stable.
+	dc_dmub_srv_cmd_queue(dmcub, &surface_flip.header);
+	PERF_TRACE();  // TODO: remove after performance is stable.
+	dc_dmub_srv_cmd_execute(dmcub);
+	PERF_TRACE();  // TODO: remove after performance is stable.
+	dc_dmub_srv_wait_idle(dmcub);
+}
+
 bool hubp21_program_surface_flip_and_addr(
 	struct hubp *hubp,
 	const struct dc_plane_address *address,
@@ -696,6 +805,13 @@ bool hubp21_program_surface_flip_and_addr(
 	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
 	struct dc_debug_options *debug = &hubp->ctx->dc->debug;
 
+
+	if (hubp->ctx->dc->debug.enable_dmcub_surface_flip) {
+		program_video_progressive_dmcub(hubp->ctx->dmub_srv, hubp, address, flip_immediate);
+		hubp->request_address = *address;
+		return true;
+	}
+
 	//program flip type
 	REG_UPDATE(DCSURF_FLIP_CONTROL,
 			SURFACE_FLIP_TYPE, flip_immediate);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index d8fdf7e76ded..919323257edb 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -30,12 +30,13 @@
 #include "dmub_cmd_dal.h"
 #include "dmub_cmd_vbios.h"
 #include "atomfirmware.h"
-
+#include "dc_hw_types.h"
 #define DMUB_RB_CMD_SIZE 64
 #define DMUB_RB_MAX_ENTRY 128
 #define DMUB_RB_SIZE (DMUB_RB_CMD_SIZE * DMUB_RB_MAX_ENTRY)
 #define REG_SET_MASK 0xFFFF
 
+
 /*
  * Command IDs should be treated as stable ABI.
  * Do not reuse or modify IDs.
@@ -47,6 +48,7 @@ enum dmub_cmd_type {
 	DMUB_CMD__REG_SEQ_FIELD_UPDATE_SEQ = 2,
 	DMUB_CMD__REG_SEQ_BURST_WRITE = 3,
 	DMUB_CMD__REG_REG_WAIT = 4,
+	DMUB_CMD__SURFACE_FLIP = 5,
 	DMUB_CMD__PSR = 64,
 	DMUB_CMD__VBIOS = 128,
 };
@@ -145,6 +147,37 @@ struct dmub_rb_cmd_reg_wait {
 	struct dmub_cmd_reg_wait_data reg_wait;
 };
 
+#ifndef PHYSICAL_ADDRESS_LOC
+#define PHYSICAL_ADDRESS_LOC union large_integer
+#endif
+
+struct dmub_cmd_surface_flip {
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
+	enum dc_plane_addr_type addr_type;
+	uint8_t hubp_inst;
+	bool tmz_surface;
+	bool immediate;
+	uint8_t vmid;
+	bool grph_stereo;
+};
+
+struct dmub_rb_cmd_flip {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_surface_flip flip;
+};
+
 struct dmub_cmd_digx_encoder_control_data {
 	union dig_encoder_control_parameters_v1_5 dig;
 };
@@ -262,6 +295,7 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_psr_enable psr_enable;
 	struct dmub_rb_cmd_psr_copy_settings psr_copy_settings;
 	struct dmub_rb_cmd_psr_set_level psr_set_level;
+	struct dmub_rb_cmd_flip surface_flip;
 };
 
 #pragma pack(pop)
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h
index ade688fd32f0..df875fdd2ab0 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h
@@ -73,12 +73,17 @@ static inline bool dmub_rb_full(struct dmub_rb *rb)
 static inline bool dmub_rb_push_front(struct dmub_rb *rb,
 				      const struct dmub_cmd_header *cmd)
 {
-	uint8_t *wt_ptr = (uint8_t *)(rb->base_address) + rb->wrpt;
+	uint64_t volatile *dst = (uint64_t volatile *)(rb->base_address) + rb->wrpt / sizeof(uint64_t);
+	const uint64_t *src = (const uint64_t *)cmd;
+	int i;
 
 	if (dmub_rb_full(rb))
 		return false;
 
-	dmub_memcpy(wt_ptr, cmd, DMUB_RB_CMD_SIZE);
+	// copying data
+	for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
+		*dst++ = *src++;
+
 	rb->wrpt += DMUB_RB_CMD_SIZE;
 
 	if (rb->wrpt >= rb->capacity)
@@ -115,14 +120,17 @@ static inline bool dmub_rb_pop_front(struct dmub_rb *rb)
 
 static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
 {
-	uint8_t buf[DMUB_RB_CMD_SIZE];
 	uint32_t rptr = rb->rptr;
 	uint32_t wptr = rb->wrpt;
 
 	while (rptr != wptr) {
-		const uint8_t *data = (const uint8_t *)rb->base_address + rptr;
+		uint64_t volatile *data = (uint64_t volatile *)rb->base_address + rptr / sizeof(uint64_t);
+		//uint64_t volatile *p = (uint64_t volatile *)data;
+		uint64_t temp;
+		int i;
 
-		dmub_memcpy(buf, data, DMUB_RB_CMD_SIZE);
+		for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
+			temp = *data++;
 
 		rptr += DMUB_RB_CMD_SIZE;
 		if (rptr >= rb->capacity)
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
