Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2002C3F68F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7857F2173E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s+3eVUx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7857F2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 474FF6EB77;
	Wed, 11 Dec 2019 15:33:40 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760087.outbound.protection.outlook.com [40.107.76.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64D986EB8B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfPRtaVS9zW966oRZSD3JiAE79LKGAo3+lUc8shckWnVDm6yr/sqI/32D3rSDVIDnnllZmwEIsHI4WEeDEk7lxzY6KjikwE8RnbFr3ScrkDvrorZc+ROBuBL62ySn5iNxUuV68Uo0zZ/+51QGe1grsPAYWseO/LesAlzoU844Ijf8B96Z+UwYGNAcGveejAHs6z9UcQPE9ZfgPCn1ePDIkYEtoj4cVLd88skDUxAm2G+UQhrbnNS8ay7n1TrORhTVNyL+/fjQa0AYT33eUM26PeyXtdpDsjJlJl0TaUUMO/eoy9CwlAAJVEV9cYgtrd8nMxLIZSLkfc9QNV2D+Uo1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wrGJ1aAY4bn1MhnOqP30Zl/J/WnGUARD8HqfPtjBgk=;
 b=YhariN+nPAYylBR51uggxC9USUImKAhYdihE6kmvYIAywLOdy2dLibGQwD2kqhAmjoaAl/SHrjCWBL2z9NX7Uy5Mc94S//XnVGiBt3YhnCNEgLKCFTgWcTTFZHeTZFa/nrC4k20HABAGkuH/U+Q06MQ9IBHf5nbJLSh9rTvHvIsZnVrJ32u505k8IGLS9Bn35nYQo+z+cEMUhvAglg1fEDR0F8/5DkkLM6ZKOYjEDJMKIv4+qakXJy7JjbGde1HkEmpDwqSF1b5eKeXlwTObsliZDgYttAuBipvXSHaFz6E9EP1UpQhj8X6nztofslG6KyJy5VDa4cA2eJml3KjtKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wrGJ1aAY4bn1MhnOqP30Zl/J/WnGUARD8HqfPtjBgk=;
 b=s+3eVUx9U+OQ1WroGToQs8umpu4MYuhFHmZgki0RGCZDRvpP5rAARTsybB9l1vZNwmEaMg+9bQoWdg2bnxgAVHHpeFwVBAWr2qjlQRcnav2VeFlUxDatxHudPVVcN3uHi26mS1wmlvZkPO8jPyUQO6b7oXllbYw/qjmxjKLGEe0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:34 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:34 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/39] drm/amd/display: Add warmup escape call support
Date: Wed, 11 Dec 2019 10:32:34 -0500
Message-Id: <20191211153253.2291112-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2fbb67f6-f8dc-476c-e547-08d77e4f7bf3
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491EEAABB225F4D6CD58A69985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0mhdmPka9YWoeiBxjirYWARBgLcvRbcpuxQqh+B45Cyv5h8OZUEVSyolkP2N29MtoqUWcu8FpnYY2UsnMhQtqKPG7LhByXrXRZ8pPU/mB3LFsG3xEvhk1JDyXgJKPcB9hP/U/T0Y/WI3zUP5avum2K51hDIN6ljEXwjQqivwfFQXXdFRvskizsO8V9YOlTlUiZZ6t2lHFuxxnWwC9zDjfvgpDp4qtkWcqsIVfKg+VsIU8Lq0YCXlp8ak9gGB+cF8qY1eeFEXxjiF9GgkSv29KLoCxOkHx0VMJLqECbb+C+xNE5Twlm5qJdCJr9h76cvFbGzS19kjNXKyCjCIQAVWkD7NZstnVOxtWWH69VGytDa5y+jgk1RrRw/AydFS9UKXw8QBU3vddLqRz4PctUAv4G7ywoqotZJemSOkygMOb0ZzP32OL5204zpndVu38dqq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbb67f6-f8dc-476c-e547-08d77e4f7bf3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:34.5520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V48AAkOpVOb20ZjUn3jNMeL/m1PKzL1SppQMTWfXRN+dYGEXQRjzQuPZea44A09tdY70eB7vG04kGM3v/xamTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
 Chris Park <Chris.Park@amd.com>, Harry.Wentland@amd.com,
 Charlene Liu <charlene.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

Add warmup escape support, for diags, in a way that is possible to
choose a new or an existing sequence. For achieving this goal, this
commit adds separated MCIF buffer as VCN request.

Signed-off-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 59 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  7 +++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  4 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |  1 -
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |  3 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  6 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |  6 +-
 7 files changed, 56 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index b43a4b115fd8..6ddbb00ed37a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -406,25 +406,30 @@ bool dc_stream_add_writeback(struct dc *dc,
 		stream->writeback_info[stream->num_wb_info++] = *wb_info;
 	}
 
-	if (!dc->hwss.update_bandwidth(dc, dc->current_state)) {
-		dm_error("DC: update_bandwidth failed!\n");
-		return false;
-	}
-
-	/* enable writeback */
 	if (dc->hwss.enable_writeback) {
 		struct dc_stream_status *stream_status = dc_stream_get_status(stream);
 		struct dwbc *dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
+		dwb->otg_inst = stream_status->primary_otg_inst;
+	}
+	if (IS_DIAG_DC(dc->ctx->dce_environment)) {
+		if (!dc->hwss.update_bandwidth(dc, dc->current_state)) {
+			dm_error("DC: update_bandwidth failed!\n");
+			return false;
+		}
 
-		if (dwb->funcs->is_enabled(dwb)) {
-			/* writeback pipe already enabled, only need to update */
-			dc->hwss.update_writeback(dc, stream_status, wb_info, dc->current_state);
-		} else {
-			/* Enable writeback pipe from scratch*/
-			dc->hwss.enable_writeback(dc, stream_status, wb_info, dc->current_state);
+		/* enable writeback */
+		if (dc->hwss.enable_writeback) {
+			struct dwbc *dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
+
+			if (dwb->funcs->is_enabled(dwb)) {
+				/* writeback pipe already enabled, only need to update */
+				dc->hwss.update_writeback(dc, wb_info, dc->current_state);
+			} else {
+				/* Enable writeback pipe from scratch*/
+				dc->hwss.enable_writeback(dc, wb_info, dc->current_state);
+			}
 		}
 	}
-
 	return true;
 }
 
@@ -463,19 +468,29 @@ bool dc_stream_remove_writeback(struct dc *dc,
 	}
 	stream->num_wb_info = j;
 
-	/* recalculate and apply DML parameters */
-	if (!dc->hwss.update_bandwidth(dc, dc->current_state)) {
-		dm_error("DC: update_bandwidth failed!\n");
-		return false;
-	}
-
-	/* disable writeback */
-	if (dc->hwss.disable_writeback)
-		dc->hwss.disable_writeback(dc, dwb_pipe_inst);
+	if (IS_DIAG_DC(dc->ctx->dce_environment)) {
+		/* recalculate and apply DML parameters */
+		if (!dc->hwss.update_bandwidth(dc, dc->current_state)) {
+			dm_error("DC: update_bandwidth failed!\n");
+			return false;
+		}
 
+		/* disable writeback */
+		if (dc->hwss.disable_writeback)
+			dc->hwss.disable_writeback(dc, dwb_pipe_inst);
+	}
 	return true;
 }
 
+bool dc_stream_warmup_writeback(struct dc *dc,
+		int num_dwb,
+		struct dc_writeback_info *wb_info)
+{
+	if (dc->hwss.mmhubbub_warmup)
+		return dc->hwss.mmhubbub_warmup(dc, num_dwb, wb_info);
+	else
+		return false;
+}
 uint32_t dc_stream_get_vblank_counter(const struct dc_stream_state *stream)
 {
 	uint8_t i;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 3ea54321b045..37c10dbf269e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -344,10 +344,17 @@ bool dc_add_all_planes_for_stream(
 bool dc_stream_add_writeback(struct dc *dc,
 		struct dc_stream_state *stream,
 		struct dc_writeback_info *wb_info);
+
 bool dc_stream_remove_writeback(struct dc *dc,
 		struct dc_stream_state *stream,
 		uint32_t dwb_pipe_inst);
+
+bool dc_stream_warmup_writeback(struct dc *dc,
+		int num_dwb,
+		struct dc_writeback_info *wb_info);
+
 bool dc_stream_dmdata_status_done(struct dc *dc, struct dc_stream_state *stream);
+
 bool dc_stream_set_dynamic_metadata(struct dc *dc,
 		struct dc_stream_state *stream,
 		struct dc_dmdata_attributes *dmdata_attr);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index e1e274018049..fb667546db09 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1740,7 +1740,6 @@ bool dcn20_update_bandwidth(
 
 void dcn20_enable_writeback(
 		struct dc *dc,
-		const struct dc_stream_status *stream_status,
 		struct dc_writeback_info *wb_info,
 		struct dc_state *context)
 {
@@ -1754,8 +1753,7 @@ void dcn20_enable_writeback(
 	mcif_wb = dc->res_pool->mcif_wb[wb_info->dwb_pipe_inst];
 
 	/* set the OPTC source mux */
-	ASSERT(stream_status->primary_otg_inst < MAX_PIPES);
-	optc = dc->res_pool->timing_generators[stream_status->primary_otg_inst];
+	optc = dc->res_pool->timing_generators[dwb->otg_inst];
 	optc->funcs->set_dwb_source(optc, wb_info->dwb_pipe_inst);
 	/* set MCIF_WB buffer and arbitration configuration */
 	mcif_wb->funcs->config_mcif_buf(mcif_wb, &wb_info->mcif_buf_params, wb_info->dwb_params.dest_height);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
index eecd7a26ec4c..02c9be5ebd47 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
@@ -104,7 +104,6 @@ void dcn20_program_triple_buffer(
 	bool enable_triple_buffer);
 void dcn20_enable_writeback(
 		struct dc *dc,
-		const struct dc_stream_status *stream_status,
 		struct dc_writeback_info *wb_info,
 		struct dc_state *context);
 void dcn20_disable_writeback(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
index 735f41901b88..459f95f52486 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
@@ -113,7 +113,8 @@ struct dwbc {
 	int wb_src_plane_inst;/*hubp, mpcc, inst*/
 	bool update_privacymask;
 	uint32_t mask_id;
-
+        int otg_inst;
+        bool mvc_cfg;
 };
 
 struct dwbc_funcs {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index e9c6021a5372..df3204645c6b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -149,16 +149,18 @@ struct hw_sequencer_funcs {
 
 	/* Writeback Related */
 	void (*update_writeback)(struct dc *dc,
-			const struct dc_stream_status *stream_status,
 			struct dc_writeback_info *wb_info,
 			struct dc_state *context);
 	void (*enable_writeback)(struct dc *dc,
-			const struct dc_stream_status *stream_status,
 			struct dc_writeback_info *wb_info,
 			struct dc_state *context);
 	void (*disable_writeback)(struct dc *dc,
 			unsigned int dwb_pipe_inst);
 
+	bool (*mmhubbub_warmup)(struct dc *dc,
+			unsigned int num_dwb,
+			struct dc_writeback_info *wb_info);
+
 	/* Clock Related */
 	enum dc_status (*set_clock)(struct dc *dc,
 			enum dc_clock_type clock_type,
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 72b659c63aea..11d7daf6f076 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -138,10 +138,14 @@
 #define RAVEN2_15D8_REV_E4 0xE4
 #define RAVEN1_F0 0xF0
 #define RAVEN_UNKNOWN 0xFF
-
+#ifndef ASICREV_IS_RAVEN
 #define ASICREV_IS_RAVEN(eChipRev) ((eChipRev >= RAVEN_A0) && eChipRev < RAVEN_UNKNOWN)
+#endif
+
 #define ASICREV_IS_PICASSO(eChipRev) ((eChipRev >= PICASSO_A0) && (eChipRev < RAVEN2_A0))
+#ifndef ASICREV_IS_RAVEN2
 #define ASICREV_IS_RAVEN2(eChipRev) ((eChipRev >= RAVEN2_A0) && (eChipRev < RAVEN1_F0))
+#endif
 #define ASICREV_IS_RV1_F0(eChipRev) ((eChipRev >= RAVEN1_F0) && (eChipRev < RAVEN_UNKNOWN))
 #define ASICREV_IS_DALI(eChipRev) ((eChipRev == RAVEN2_15D8_REV_E3) \
 		|| (eChipRev == RAVEN2_15D8_REV_E4))
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
