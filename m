Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C050C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 18:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9A3B610A0
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 18:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C9A3B610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ECE46E9C7;
	Thu, 19 Aug 2021 18:59:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 375866E9C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 18:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvjquSvz4MTHMpKwOHTzXFB2NjMWGfacRKtU02goUKtTJ0yanv6GqB21hfbDuvhSk6yGLTCHDQNcP/skMs/rDmPc/B4OMJ/klCFjemLLkm4Mm7zxh87HQj0YVGR8o8LAeqy+4vjddOXsmVus2HlhLfB5/uhcal9CCj4ZKLIGECTj3SkiOKf6kjaFTt44nou73jj6geVdePxCNNrLGxxum/aOhoC4tc0qc/fkBGmjlj2LbILNEetakoRhNg6QjADcMYKVeQkk6HCsUkLhr3Pb4bW/yYlcYI5gcSoi7o47I5pONLW/zSVXoNi/x5SBhFsbeZQpUzJndDT/9ZQNOx20sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd3a5ovBuCTIHUNCvQw3Cvb5l14ZQoiIC+EukCnnd7M=;
 b=kAXYJM/2MKG4LpEaYDO/VxM7MXpeyVJ4xGFSubwmKrpS3JaiCNxTJN+Kr68cDvIefrueAY+KmildFZSCQ9qhO2maqYvmke0nqZe3bg6oW4H6mVIokL6/lG5nEGkDMJFO+RO0uLPohoBfUZCeGhOTZ9Hndyn1uEAy+c86kIVatgT8AV9ciEaU4m3WNjdjXkEvQRVX0VKZ9NDdhUthxcMb6jht8l4X+0f84otKMvhrostKXNTbGntBR89NNhb4kp4kJE92R9VY5mWcYmoeMn3uZwxplBtCrF3GcjTmaUYU0fwmPVsndro3swSK6zxIPk+bXJlVBep5CSLXaXvWE9qG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd3a5ovBuCTIHUNCvQw3Cvb5l14ZQoiIC+EukCnnd7M=;
 b=oE/DMulkKY549WKx1K0eMJIa3W3sKro5jjUsnMdwMd/mV0tLnEPj/sXf+TccVnEoQML1vfv64PzSZDiS7bJ2LC/yK4pAXfybMPY846ooJ4FYjfbeVnQ84mS3DUaa3iEe9mgHlWVlUAITm++RNenhFXMVdoC6XKAHUWzBZy8RFsQ=
Received: from DM6PR18CA0006.namprd18.prod.outlook.com (2603:10b6:5:15b::19)
 by CH0PR12MB5217.namprd12.prod.outlook.com (2603:10b6:610:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 18:59:06 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::dc) by DM6PR18CA0006.outlook.office365.com
 (2603:10b6:5:15b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 18:59:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 18:59:06 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 13:59:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 11:59:05 -0700
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 19 Aug 2021 13:59:04 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nicholas.kazlauskas@amd.com>,
 <harry.wentland@amd.com>
CC: <wayne.lin@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH v3 3/6] drm/amd/display: Add DP 2.0 HPO Link Encoder
Date: Thu, 19 Aug 2021 14:58:37 -0400
Message-ID: <20210819185840.3682559-4-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210819185840.3682559-1-Jerry.Zuo@amd.com>
References: <20210819185840.3682559-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ab27b42-a3cf-42dd-f5af-08d963436b44
X-MS-TrafficTypeDiagnostic: CH0PR12MB5217:
X-Microsoft-Antispam-PRVS: <CH0PR12MB521747EC6D6349B13C0B9134E5C09@CH0PR12MB5217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FAw5t5k3PPYe8z9ftOTwKpzSeko2MYMT7g8uQf/9P3AfpLDRBEH419UJPno+OqhDThGb8mL/kXE7ZFdaVacg76BjpRYNKcmRF+6fChLDZASuC4OBUzIXQuGKpN3S/ikkNtjZKMfU6BJFnIH4ZiQME3uGaMpPOUDuaLED/wkOd5GXzX8wJEOJQqc3GS9ZSE0W3BP5UXBWwkXTt7rGYZrSKTiZrja5sEi7A2zzqttKV9UVNed3to9HsBjI2X55UoqhvgqFo+cB8fx/WmWc6KgMCxdJERQW51VIBrkfNc5IqQlx+QpYfN9PEghupBoYF2cXI5KAFX213W93ft+NWf08zWoOWJX0Mh/YyCwMcrlQsgnyiKg+9Oa2QbZ05lU0i+uiBGErGciDjMqaoaF9WTVlToEY1SWMM7tqK5Ir74LzBCciwQbIOx0FbZRvPG1PrU4U83Rmos/EmbJXqIjysYewaDM2a+IL67px+iQO5Obblqq65Kyg+j4526ZzUbaPuoaJtLXHCvaLDdAjVnj9lem5hne8b2wirQL/IQHzwbccN4NKD4uTJws5iBZD1FMJv3lLp/TLiHKRxyRxTD58ic/g0eVP7LtChGI5AN11CEUjqJphOaQXJPv4mCVM68LXopyFwUx/UTSB6oyEfbREL2otQ8Qn0K3o6TzNP0y9L+lx6OzIqYwBnlnYbmzUyu1c5iLja6+v/DJkSuG+hBHEOmnaRYyGEKscyT3hI1sFne2bqG8l+aAV1YBRd0YYKg6wRgXtok6bjAhB/fpZwVXZknveTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(36840700001)(46966006)(70586007)(70206006)(54906003)(4326008)(86362001)(2616005)(110136005)(316002)(47076005)(186003)(36756003)(26005)(336012)(478600001)(426003)(34020700004)(82310400003)(83380400001)(7696005)(6636002)(8936002)(82740400003)(30864003)(36860700001)(356005)(2906002)(81166007)(6666004)(8676002)(5660300002)(1076003)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 18:59:06.2286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab27b42-a3cf-42dd-f5af-08d963436b44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5217
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

HW Blocks:

        +--------+  +-----+  +------+
        |  OPTC  |  | HDA |  | HUBP |
        +--------+  +-----+  +------+
            |          |        |
            |          |        |
    HPO ====|==========|========|====
     |      |          v        |
     |      |       +-----+     |
     |      |       | APG |     |
     |      |       +-----+     |
     |      |          |        |
     |      v          v        v
     |     +---------------------+
     |     |  HPO Stream Encoder |
     |     +---------------------+
     |                 |
     |                 v
     |      +--------------------+
     |      |  HPO Link Encoder  |
     v      +--------------------+

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   4 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  32 +
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   2 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |   4 +
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.c      | 620 ++++++++++++++++++
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.h      | 222 +++++++
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  50 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   1 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  87 +++
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   5 +
 .../amd/display/include/link_service_types.h  |  17 +
 12 files changed, 1045 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 83845d006c54..4450078213a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -45,6 +45,10 @@ struct dc_link_status {
 struct link_mst_stream_allocation {
 	/* DIG front */
 	const struct stream_encoder *stream_enc;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	/* HPO DP Stream Encoder */
+	const struct hpo_dp_stream_encoder *hpo_dp_stream_enc;
+#endif
 	/* associate DRM payload table with DC stream encoder */
 	uint8_t vcp_id;
 	/* number of slots required for the DP stream in transport packet */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index be98f5513fe5..70d47773c23c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -497,6 +497,38 @@ void dcn10_log_hw_state(struct dc *dc,
 
 			DTN_INFO("\n");
 		}
+
+		/* log DP HPO L_ENC section if any hpo_dp_link_enc exists */
+		for (i = 0; i < dc->link_count; i++)
+			if (dc->links[i]->hpo_dp_link_enc)
+				hpo_dp_link_enc_count++;
+
+		if (hpo_dp_link_enc_count) {
+			DTN_INFO("DP HPO L_ENC:  Enabled  Mode   Lanes   Stream  Slots   VC Rate X    VC Rate Y\n");
+
+			for (i = 0; i < dc->link_count; i++) {
+				struct hpo_dp_link_encoder *hpo_dp_link_enc = dc->links[i]->hpo_dp_link_enc;
+				struct hpo_dp_link_enc_state hpo_dp_le_state = {0};
+
+				if (hpo_dp_link_enc && hpo_dp_link_enc->funcs->read_state) {
+					hpo_dp_link_enc->funcs->read_state(hpo_dp_link_enc, &hpo_dp_le_state);
+					DTN_INFO("[%d]:                 %d  %6s     %d        %d      %d     %d     %d\n",
+							hpo_dp_link_enc->inst,
+							hpo_dp_le_state.link_enc_enabled,
+							(hpo_dp_le_state.link_mode == 0) ? "TPS1" :
+									(hpo_dp_le_state.link_mode == 1) ? "TPS2" :
+									(hpo_dp_le_state.link_mode == 2) ? "ACTIVE" : "TEST",
+							hpo_dp_le_state.lane_count,
+							hpo_dp_le_state.stream_src[0],
+							hpo_dp_le_state.slot_count[0],
+							hpo_dp_le_state.vc_rate_x[0],
+							hpo_dp_le_state.vc_rate_y[0]);
+					DTN_INFO("\n");
+				}
+			}
+
+			DTN_INFO("\n");
+		}
 	}
 
 	DTN_INFO_END();
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index 8b811f589524..5197825e7965 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -12,7 +12,7 @@
 
 DCN31 = dcn31_resource.o dcn31_hubbub.o dcn31_hwseq.o dcn31_init.o dcn31_hubp.o \
 	dcn31_dccg.o dcn31_optc.o dcn31_dio_link_encoder.o dcn31_panel_cntl.o \
-	dcn31_apg.o dcn31_hpo_dp_stream_encoder.o
+	dcn31_apg.o dcn31_hpo_dp_stream_encoder.o dcn31_hpo_dp_link_encoder.o
 
 ifdef CONFIG_X86
 CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o := -msse
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index 90127c1f9e35..77b81f6c24b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -320,6 +320,10 @@ void dcn31_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_HBR3_CAPABLE =
 				bp_cap_info.DP_HBR3_EN;
 		enc10->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
+		enc10->base.features.flags.bits.IS_DP2_CAPABLE = bp_cap_info.IS_DP2_CAPABLE;
+		enc10->base.features.flags.bits.IS_UHBR10_CAPABLE = bp_cap_info.DP_UHBR10_EN;
+		enc10->base.features.flags.bits.IS_UHBR13_5_CAPABLE = bp_cap_info.DP_UHBR13_5_EN;
+		enc10->base.features.flags.bits.IS_UHBR20_CAPABLE = bp_cap_info.DP_UHBR20_EN;
 		enc10->base.features.flags.bits.DP_IS_USB_C =
 				bp_cap_info.DP_IS_USB_C;
 	} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
new file mode 100644
index 000000000000..ee07a0bba12b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
@@ -0,0 +1,620 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ *  and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "dc_bios_types.h"
+#include "dcn31_hpo_dp_link_encoder.h"
+#include "reg_helper.h"
+#include "dc_link.h"
+#include "stream_encoder.h"
+
+#define DC_LOGGER \
+		enc3->base.ctx->logger
+
+#define REG(reg)\
+	(enc3->regs->reg)
+
+#undef FN
+#define FN(reg_name, field_name) \
+	enc3->hpo_le_shift->field_name, enc3->hpo_le_mask->field_name
+
+
+#define CTX \
+	enc3->base.ctx
+
+enum {
+	DP_SAT_UPDATE_MAX_RETRY = 200
+};
+
+void dcn31_hpo_dp_link_enc_enable(
+		struct hpo_dp_link_encoder *enc,
+		enum dc_lane_count num_lanes)
+{
+	struct dcn31_hpo_dp_link_encoder *enc3 = DCN3_1_HPO_DP_LINK_ENC_FROM_HPO_LINK_ENC(enc);
+	uint32_t dp_link_enabled;
+
+	/* get current status of link enabled */
+	REG_GET(DP_DPHY_SYM32_STATUS,
+			STATUS, &dp_link_enabled);
+
+	/* Enable clocks first */
+	REG_UPDATE(DP_LINK_ENC_CLOCK_CONTROL, DP_LINK_ENC_CLOCK_EN, 1);
+
+	/* Reset DPHY.  Only reset if going from disable to enable */
+	if (!dp_link_enabled) {
+		REG_UPDATE(DP_DPHY_SYM32_CONTROL, DPHY_RESET, 1);
+		REG_UPDATE(DP_DPHY_SYM32_CONTROL, DPHY_RESET, 0);
+	}
+
+	/* Configure DPHY settings */
+	REG_UPDATE_3(DP_DPHY_SYM32_CONTROL,
+			DPHY_ENABLE, 1,
+			PRECODER_ENABLE, 1,
+			NUM_LANES, num_lanes == LANE_COUNT_ONE ? 0 : num_lanes == LANE_COUNT_TWO ? 1 : 3);
+}
+
+void dcn31_hpo_dp_link_enc_disable(
+		struct hpo_dp_link_encoder *enc)
+{
+	struct dcn31_hpo_dp_link_encoder *enc3 = DCN3_1_HPO_DP_LINK_ENC_FROM_HPO_LINK_ENC(enc);
+
+	/* Configure DPHY settings */
+	REG_UPDATE(DP_DPHY_SYM32_CONTROL,
+			DPHY_ENABLE, 0);
+
+	/* Shut down clock last */
+	REG_UPDATE(DP_LINK_ENC_CLOCK_CONTROL, DP_LINK_ENC_CLOCK_EN, 0);
+}
+
+void dcn31_hpo_dp_link_enc_set_link_test_pattern(
+		struct hpo_dp_link_encoder *enc,
+		struct encoder_set_dp_phy_pattern_param *tp_params)
+{
+	struct dcn31_hpo_dp_link_encoder *enc3 = DCN3_1_HPO_DP_LINK_ENC_FROM_HPO_LINK_ENC(enc);
+	uint32_t tp_custom;
+
+	switch (tp_params->dp_phy_pattern) {
+	case DP_TEST_PATTERN_VIDEO_MODE:
+		REG_UPDATE(DP_DPHY_SYM32_CONTROL,
+				MODE, DP2_LINK_ACTIVE);
+		break;
+	case DP_TEST_PATTERN_128b_132b_TPS1_TRAINING_MODE:
+		REG_UPDATE(DP_DPHY_SYM32_CONTROL,
+				MODE, DP2_LINK_TRAINING_TPS1);
+		break;
+	case DP_TEST_PATTERN_128b_132b_TPS2_TRAINING_MODE:
+		REG_UPDATE(DP_DPHY_SYM32_CONTROL,
+				MODE, DP2_LINK_TRAINING_TPS2);
+		break;
+	case DP_TEST_PATTERN_128b_132b_TPS1:
+		REG_UPDATE_4(DP_DPHY_SYM32_TP_CONFIG,
+				TP_SELECT0, DP_DPHY_TP_SELECT_TPS1,
+				TP_SELECT1, DP_DPHY_TP_SELECT_TPS1,
+				TP_SELECT2, DP_DPHY_TP_SELECT_TPS1,
+				TP_SELECT3, DP_DPHY_TP_SELECT_TPS1);
+		REG_UPDATE(DP_DPHY_SYM32_CONTROL,
+				MODE, DP2_TEST_PATTERN);
+		break;
+	case DP_TEST_PATTERN_128b_132b_TPS2:
+		REG_UPDATE_4(DP_DPHY_SYM32_TP_CONFIG,
+				TP_SELECT0, DP_DPHY_TP_SELECT_TPS2,
+				TP_SELECT1, DP_DPHY_TP_SELECT_TPS2,
+				TP_SELECT2, DP_DPHY_TP_SELECT_TPS2,
+				TP_SELECT3, DP_DPHY_TP_SELECT_TPS2);
+		REG_UPDATE(DP_DPHY_SYM32_CONTROL,
+				MODE, DP2_TEST_PATTERN);
+		break;
+	case DP_TEST_PATTERN_PRBS7:
+		REG_UPDATE_4(DP_DPHY_SYM32_TP_CONFIG,
+				TP_PRBS_SEL0, DP_DPHY_TP_PRBS7,
+				TP_PRBS_SEL1, DP_DPHY_TP_PRBS7,
+				TP_PRBS_SEL2, DP_DPHY_TP_PRBS7,
+				TP_PRBS_SEL3, DP_DPHY_TP_PRBS7);
+		REG_UPDATE_4(DP_DPHY_SYM32_TP_CONFIG,
+				TP_SELECT0, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT1, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT2, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT3, DP_DPHY_TP_SELECT_PRBS);
+		REG_UPDATE(DP_DPHY_SYM32_CONTROL,
+				MODE, DP2_TEST_PATTERN);
+		break;
+	case DP_TEST_PATTERN_PRBS9:
+		REG_UPDATE_4(DP_DPHY_SYM32_TP_CONFIG,
+				TP_PRBS_SEL0, DP_DPHY_TP_PRBS9,
+				TP_PRBS_SEL1, DP_DPHY_TP_PRBS9,
+				TP_PRBS_SEL2, DP_DPHY_TP_PRBS9,
+				TP_PRBS_SEL3, DP_DPHY_TP_PRBS9);
+		REG_UPDATE_4(DP_DPHY_SYM32_TP_CONFIG,
+				TP_SELECT0, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT1, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT2, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT3, DP_DPHY_TP_SELECT_PRBS);
+		REG_UPDATE(DP_DPHY_SYM32_CONTROL,
+				MODE, DP2_TEST_PATTERN);
+		break;
+	case DP_TEST_PATTERN_PRBS11:
+		REG_UPDATE_4(DP_DPHY_SYM32_TP_CONFIG,
+				TP_PRBS_SEL0, DP_DPHY_TP_PRBS11,
+				TP_PRBS_SEL1, DP_DPHY_TP_PRBS11,
+				TP_PRBS_SEL2, DP_DPHY_TP_PRBS11,
+				TP_PRBS_SEL3, DP_DPHY_TP_PRBS11);
+		REG_UPDATE_4(DP_DPHY_SYM32_TP_CONFIG,
+				TP_SELECT0, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT1, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT2, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT3, DP_DPHY_TP_SELECT_PRBS);
+		REG_UPDATE(DP_DPHY_SYM32_CONTROL,
+				MODE, DP2_TEST_PATTERN);
+		break;
+	case DP_TEST_PATTERN_PRBS15:
+		REG_UPDATE_4(DP_DPHY_SYM32_TP_CONFIG,
+				TP_PRBS_SEL0, DP_DPHY_TP_PRBS15,
+				TP_PRBS_SEL1, DP_DPHY_TP_PRBS15,
+				TP_PRBS_SEL2, DP_DPHY_TP_PRBS15,
+				TP_PRBS_SEL3, DP_DPHY_TP_PRBS15);
+		REG_UPDATE_4(DP_DPHY_SYM32_TP_CONFIG,
+				TP_SELECT0, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT1, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT2, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT3, DP_DPHY_TP_SELECT_PRBS);
+		REG_UPDATE(DP_DPHY_SYM32_CONTROL,
+				MODE, DP2_TEST_PATTERN);
+		break;
+	case DP_TEST_PATTERN_PRBS23:
+		REG_UPDATE_4(DP_DPHY_SYM32_TP_CONFIG,
+				TP_PRBS_SEL0, DP_DPHY_TP_PRBS23,
+				TP_PRBS_SEL1, DP_DPHY_TP_PRBS23,
+				TP_PRBS_SEL2, DP_DPHY_TP_PRBS23,
+				TP_PRBS_SEL3, DP_DPHY_TP_PRBS23);
+		REG_UPDATE_4(DP_DPHY_SYM32_TP_CONFIG,
+				TP_SELECT0, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT1, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT2, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT3, DP_DPHY_TP_SELECT_PRBS);
+		REG_UPDATE(DP_DPHY_SYM32_CONTROL,
+				MODE, DP2_TEST_PATTERN);
+		break;
+	case DP_TEST_PATTERN_PRBS31:
+		REG_UPDATE_4(DP_DPHY_SYM32_TP_CONFIG,
+				TP_PRBS_SEL0, DP_DPHY_TP_PRBS31,
+				TP_PRBS_SEL1, DP_DPHY_TP_PRBS31,
+				TP_PRBS_SEL2, DP_DPHY_TP_PRBS31,
+				TP_PRBS_SEL3, DP_DPHY_TP_PRBS31);
+		REG_UPDATE_4(DP_DPHY_SYM32_TP_CONFIG,
+				TP_SELECT0, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT1, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT2, DP_DPHY_TP_SELECT_PRBS,
+				TP_SELECT3, DP_DPHY_TP_SELECT_PRBS);
+		REG_UPDATE(DP_DPHY_SYM32_CONTROL,
+				MODE, DP2_TEST_PATTERN);
+		break;
+	case DP_TEST_PATTERN_264BIT_CUSTOM:
+		tp_custom = (tp_params->custom_pattern[2] << 16) | (tp_params->custom_pattern[1] << 8) | tp_params->custom_pattern[0];
+		REG_SET(DP_DPHY_SYM32_TP_CUSTOM0, 0, TP_CUSTOM, tp_custom);
+		tp_custom = (tp_params->custom_pattern[5] << 16) | (tp_params->custom_pattern[4] << 8) | tp_params->custom_pattern[3];
+		REG_SET(DP_DPHY_SYM32_TP_CUSTOM1, 0, TP_CUSTOM, tp_custom);
+		tp_custom = (tp_params->custom_pattern[8] << 16) | (tp_params->custom_pattern[7] << 8) | tp_params->custom_pattern[6];
+		REG_SET(DP_DPHY_SYM32_TP_CUSTOM2, 0, TP_CUSTOM, tp_custom);
+		tp_custom = (tp_params->custom_pattern[11] << 16) | (tp_params->custom_pattern[10] << 8) | tp_params->custom_pattern[9];
+		REG_SET(DP_DPHY_SYM32_TP_CUSTOM3, 0, TP_CUSTOM, tp_custom);
+		tp_custom = (tp_params->custom_pattern[14] << 16) | (tp_params->custom_pattern[13] << 8) | tp_params->custom_pattern[12];
+		REG_SET(DP_DPHY_SYM32_TP_CUSTOM4, 0, TP_CUSTOM, tp_custom);
+		tp_custom = (tp_params->custom_pattern[17] << 16) | (tp_params->custom_pattern[16] << 8) | tp_params->custom_pattern[15];
+		REG_SET(DP_DPHY_SYM32_TP_CUSTOM5, 0, TP_CUSTOM, tp_custom);
+		tp_custom = (tp_params->custom_pattern[20] << 16) | (tp_params->custom_pattern[19] << 8) | tp_params->custom_pattern[18];
+		REG_SET(DP_DPHY_SYM32_TP_CUSTOM6, 0, TP_CUSTOM, tp_custom);
+		tp_custom = (tp_params->custom_pattern[23] << 16) | (tp_params->custom_pattern[22] << 8) | tp_params->custom_pattern[21];
+		REG_SET(DP_DPHY_SYM32_TP_CUSTOM7, 0, TP_CUSTOM, tp_custom);
+		tp_custom = (tp_params->custom_pattern[26] << 16) | (tp_params->custom_pattern[25] << 8) | tp_params->custom_pattern[24];
+		REG_SET(DP_DPHY_SYM32_TP_CUSTOM8, 0, TP_CUSTOM, tp_custom);
+		tp_custom = (tp_params->custom_pattern[29] << 16) | (tp_params->custom_pattern[28] << 8) | tp_params->custom_pattern[27];
+		REG_SET(DP_DPHY_SYM32_TP_CUSTOM9, 0, TP_CUSTOM, tp_custom);
+		tp_custom = (tp_params->custom_pattern[32] << 16) | (tp_params->custom_pattern[31] << 8) | tp_params->custom_pattern[30];
+		REG_SET(DP_DPHY_SYM32_TP_CUSTOM10, 0, TP_CUSTOM, tp_custom);
+
+		REG_UPDATE_4(DP_DPHY_SYM32_TP_CONFIG,
+				TP_SELECT0, DP_DPHY_TP_SELECT_CUSTOM,
+				TP_SELECT1, DP_DPHY_TP_SELECT_CUSTOM,
+				TP_SELECT2, DP_DPHY_TP_SELECT_CUSTOM,
+				TP_SELECT3, DP_DPHY_TP_SELECT_CUSTOM);
+
+		REG_UPDATE(DP_DPHY_SYM32_CONTROL,
+				MODE, DP2_TEST_PATTERN);
+		break;
+	case DP_TEST_PATTERN_SQUARE_PULSE:
+		REG_SET(DP_DPHY_SYM32_TP_SQ_PULSE, 0,
+				TP_SQ_PULSE_WIDTH, tp_params->custom_pattern[0]);
+
+		REG_UPDATE_4(DP_DPHY_SYM32_TP_CONFIG,
+				TP_SELECT0, DP_DPHY_TP_SELECT_SQUARE,
+				TP_SELECT1, DP_DPHY_TP_SELECT_SQUARE,
+				TP_SELECT2, DP_DPHY_TP_SELECT_SQUARE,
+				TP_SELECT3, DP_DPHY_TP_SELECT_SQUARE);
+
+		REG_UPDATE(DP_DPHY_SYM32_CONTROL,
+				MODE, DP2_TEST_PATTERN);
+		break;
+	default:
+		break;
+	}
+}
+
+static void fill_stream_allocation_row_info(
+		const struct link_mst_stream_allocation *stream_allocation,
+		uint32_t *src,
+		uint32_t *slots)
+{
+	const struct hpo_dp_stream_encoder *stream_enc = stream_allocation->hpo_dp_stream_enc;
+
+	if (stream_enc && (stream_enc->id >= ENGINE_ID_HPO_DP_0)) {
+		*src = stream_enc->id - ENGINE_ID_HPO_DP_0;
+		*slots = stream_allocation->slot_count;
+	} else {
+		*src = 0;
+		*slots = 0;
+	}
+}
+
+/* programs DP VC payload allocation */
+void dcn31_hpo_dp_link_enc_update_stream_allocation_table(
+		struct hpo_dp_link_encoder *enc,
+		const struct link_mst_stream_allocation_table *table)
+{
+	struct dcn31_hpo_dp_link_encoder *enc3 = DCN3_1_HPO_DP_LINK_ENC_FROM_HPO_LINK_ENC(enc);
+	uint32_t value0 = 0;
+	uint32_t value1 = 0;
+	uint32_t value2 = 0;
+	uint32_t slots = 0;
+	uint32_t src = 0;
+	uint32_t retries = 0;
+
+	/* --- Set MSE Stream Attribute -
+	 * Setup VC Payload Table on Tx Side,
+	 * Issue allocation change trigger
+	 * to commit payload on both tx and rx side
+	 */
+
+	/* we should clean-up table each time */
+
+	if (table->stream_count >= 1) {
+		fill_stream_allocation_row_info(
+			&table->stream_allocations[0],
+			&src,
+			&slots);
+	} else {
+		src = 0;
+		slots = 0;
+	}
+
+	REG_UPDATE_2(DP_DPHY_SYM32_SAT_VC0,
+			SAT_STREAM_SOURCE, src,
+			SAT_SLOT_COUNT, slots);
+
+	if (table->stream_count >= 2) {
+		fill_stream_allocation_row_info(
+			&table->stream_allocations[1],
+			&src,
+			&slots);
+	} else {
+		src = 0;
+		slots = 0;
+	}
+
+	REG_UPDATE_2(DP_DPHY_SYM32_SAT_VC1,
+			SAT_STREAM_SOURCE, src,
+			SAT_SLOT_COUNT, slots);
+
+	if (table->stream_count >= 3) {
+		fill_stream_allocation_row_info(
+			&table->stream_allocations[2],
+			&src,
+			&slots);
+	} else {
+		src = 0;
+		slots = 0;
+	}
+
+	REG_UPDATE_2(DP_DPHY_SYM32_SAT_VC2,
+			SAT_STREAM_SOURCE, src,
+			SAT_SLOT_COUNT, slots);
+
+	if (table->stream_count >= 4) {
+		fill_stream_allocation_row_info(
+			&table->stream_allocations[3],
+			&src,
+			&slots);
+	} else {
+		src = 0;
+		slots = 0;
+	}
+
+	REG_UPDATE_2(DP_DPHY_SYM32_SAT_VC3,
+			SAT_STREAM_SOURCE, src,
+			SAT_SLOT_COUNT, slots);
+
+	/* --- wait for transaction finish */
+
+	/* send allocation change trigger (ACT)
+	 * this step first sends the ACT,
+	 * then double buffers the SAT into the hardware
+	 * making the new allocation active on the DP MST mode link
+	 */
+
+	/* SAT_UPDATE:
+	 * 0 - No Action
+	 * 1 - Update SAT with trigger
+	 * 2 - Update SAT without trigger
+	 */
+	REG_UPDATE(DP_DPHY_SYM32_SAT_UPDATE,
+			SAT_UPDATE, 1);
+
+	/* wait for update to complete
+	 * (i.e. SAT_UPDATE_PENDING field is set to 0)
+	 * No need for HW to enforce keepout.
+	 */
+	/* Best case and worst case wait time for SAT_UPDATE_PENDING
+	 *   best: 109 us
+	 *   worst: 868 us
+	 */
+	REG_WAIT(DP_DPHY_SYM32_STATUS,
+			SAT_UPDATE_PENDING, 0,
+			10, DP_SAT_UPDATE_MAX_RETRY);
+}
+
+void dcn31_hpo_dp_link_enc_set_throttled_vcp_size(
+		struct hpo_dp_link_encoder *enc,
+		uint32_t stream_encoder_inst,
+		struct fixed31_32 avg_time_slots_per_mtp)
+{
+	struct dcn31_hpo_dp_link_encoder *enc3 = DCN3_1_HPO_DP_LINK_ENC_FROM_HPO_LINK_ENC(enc);
+	uint32_t x = dc_fixpt_floor(
+		avg_time_slots_per_mtp);
+	uint32_t y = dc_fixpt_ceil(
+		dc_fixpt_shl(
+			dc_fixpt_sub_int(
+				avg_time_slots_per_mtp,
+				x),
+			25));
+
+	switch (stream_encoder_inst) {
+	case 0:
+		REG_SET_2(DP_DPHY_SYM32_VC_RATE_CNTL0, 0,
+				STREAM_VC_RATE_X, x,
+				STREAM_VC_RATE_Y, y);
+		break;
+	case 1:
+		REG_SET_2(DP_DPHY_SYM32_VC_RATE_CNTL1, 0,
+				STREAM_VC_RATE_X, x,
+				STREAM_VC_RATE_Y, y);
+		break;
+	case 2:
+		REG_SET_2(DP_DPHY_SYM32_VC_RATE_CNTL2, 0,
+				STREAM_VC_RATE_X, x,
+				STREAM_VC_RATE_Y, y);
+		break;
+	case 3:
+		REG_SET_2(DP_DPHY_SYM32_VC_RATE_CNTL3, 0,
+				STREAM_VC_RATE_X, x,
+				STREAM_VC_RATE_Y, y);
+		break;
+	default:
+		ASSERT(0);
+	}
+
+	/* Best case and worst case wait time for RATE_UPDATE_PENDING
+	 *   best: 116 ns
+	 *   worst: 903 ns
+	 */
+	/* wait for update to be completed on the link */
+	REG_WAIT(DP_DPHY_SYM32_STATUS,
+			RATE_UPDATE_PENDING, 0,
+			1, 10);
+}
+
+static bool dcn31_hpo_dp_link_enc_is_in_alt_mode(
+		struct hpo_dp_link_encoder *enc)
+{
+	struct dcn31_hpo_dp_link_encoder *enc3 = DCN3_1_HPO_DP_LINK_ENC_FROM_HPO_LINK_ENC(enc);
+	uint32_t dp_alt_mode_disable = 0;
+
+	ASSERT((enc->transmitter >= TRANSMITTER_UNIPHY_A) && (enc->transmitter <= TRANSMITTER_UNIPHY_E));
+
+	/* if value == 1 alt mode is disabled, otherwise it is enabled */
+	REG_GET(RDPCSTX_PHY_CNTL6[enc->transmitter], RDPCS_PHY_DPALT_DISABLE, &dp_alt_mode_disable);
+	return (dp_alt_mode_disable == 0);
+}
+
+void dcn31_hpo_dp_link_enc_read_state(
+		struct hpo_dp_link_encoder *enc,
+		struct hpo_dp_link_enc_state *state)
+{
+	struct dcn31_hpo_dp_link_encoder *enc3 = DCN3_1_HPO_DP_LINK_ENC_FROM_HPO_LINK_ENC(enc);
+
+	ASSERT(state);
+
+	REG_GET(DP_DPHY_SYM32_STATUS,
+			STATUS, &state->link_enc_enabled);
+	REG_GET(DP_DPHY_SYM32_CONTROL,
+			NUM_LANES, &state->lane_count);
+	REG_GET(DP_DPHY_SYM32_CONTROL,
+			MODE, (uint32_t *)&state->link_mode);
+
+	REG_GET_2(DP_DPHY_SYM32_SAT_VC0,
+			SAT_STREAM_SOURCE, &state->stream_src[0],
+			SAT_SLOT_COUNT, &state->slot_count[0]);
+	REG_GET_2(DP_DPHY_SYM32_SAT_VC1,
+			SAT_STREAM_SOURCE, &state->stream_src[1],
+			SAT_SLOT_COUNT, &state->slot_count[1]);
+	REG_GET_2(DP_DPHY_SYM32_SAT_VC2,
+			SAT_STREAM_SOURCE, &state->stream_src[2],
+			SAT_SLOT_COUNT, &state->slot_count[2]);
+	REG_GET_2(DP_DPHY_SYM32_SAT_VC3,
+			SAT_STREAM_SOURCE, &state->stream_src[3],
+			SAT_SLOT_COUNT, &state->slot_count[3]);
+
+	REG_GET_2(DP_DPHY_SYM32_VC_RATE_CNTL0,
+			STREAM_VC_RATE_X, &state->vc_rate_x[0],
+			STREAM_VC_RATE_Y, &state->vc_rate_y[0]);
+	REG_GET_2(DP_DPHY_SYM32_VC_RATE_CNTL1,
+			STREAM_VC_RATE_X, &state->vc_rate_x[1],
+			STREAM_VC_RATE_Y, &state->vc_rate_y[1]);
+	REG_GET_2(DP_DPHY_SYM32_VC_RATE_CNTL2,
+			STREAM_VC_RATE_X, &state->vc_rate_x[2],
+			STREAM_VC_RATE_Y, &state->vc_rate_y[2]);
+	REG_GET_2(DP_DPHY_SYM32_VC_RATE_CNTL3,
+			STREAM_VC_RATE_X, &state->vc_rate_x[3],
+			STREAM_VC_RATE_Y, &state->vc_rate_y[3]);
+}
+
+static enum bp_result link_transmitter_control(
+	struct dcn31_hpo_dp_link_encoder *enc3,
+	struct bp_transmitter_control *cntl)
+{
+	enum bp_result result;
+	struct dc_bios *bp = enc3->base.ctx->dc_bios;
+
+	result = bp->funcs->transmitter_control(bp, cntl);
+
+	return result;
+}
+
+/* enables DP PHY output for 128b132b encoding */
+void dcn31_hpo_dp_link_enc_enable_dp_output(
+	struct hpo_dp_link_encoder *enc,
+	const struct dc_link_settings *link_settings,
+	enum transmitter transmitter)
+{
+	struct dcn31_hpo_dp_link_encoder *enc3 = DCN3_1_HPO_DP_LINK_ENC_FROM_HPO_LINK_ENC(enc);
+	struct bp_transmitter_control cntl = { 0 };
+	enum bp_result result;
+
+	/* Set the transmitter */
+	enc3->base.transmitter = transmitter;
+
+	/* Enable the PHY */
+	cntl.action = TRANSMITTER_CONTROL_ENABLE;
+	cntl.engine_id = ENGINE_ID_UNKNOWN;
+	cntl.transmitter = enc3->base.transmitter;
+	//cntl.pll_id = clock_source;
+	cntl.signal = SIGNAL_TYPE_DISPLAY_PORT_MST;
+	cntl.lanes_number = link_settings->lane_count;
+	cntl.hpd_sel = enc3->base.hpd_source;
+	cntl.pixel_clock = link_settings->link_rate * 1000;
+	cntl.color_depth = COLOR_DEPTH_UNDEFINED;
+	cntl.hpo_engine_id = enc->inst + ENGINE_ID_HPO_DP_0;
+
+	result = link_transmitter_control(enc3, &cntl);
+
+	if (result != BP_RESULT_OK) {
+		DC_LOG_ERROR("%s: Failed to execute VBIOS command table!\n",
+			__func__);
+		BREAK_TO_DEBUGGER();
+	}
+}
+
+void dcn31_hpo_dp_link_enc_disable_output(
+	struct hpo_dp_link_encoder *enc,
+	enum signal_type signal)
+{
+	struct dcn31_hpo_dp_link_encoder *enc3 = DCN3_1_HPO_DP_LINK_ENC_FROM_HPO_LINK_ENC(enc);
+	struct bp_transmitter_control cntl = { 0 };
+	enum bp_result result;
+
+	/* disable transmitter */
+	cntl.action = TRANSMITTER_CONTROL_DISABLE;
+	cntl.transmitter = enc3->base.transmitter;
+	cntl.hpd_sel = enc3->base.hpd_source;
+	cntl.signal = signal;
+
+	result = link_transmitter_control(enc3, &cntl);
+
+	if (result != BP_RESULT_OK) {
+		DC_LOG_ERROR("%s: Failed to execute VBIOS command table!\n",
+			__func__);
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+
+	/* disable encoder */
+	dcn31_hpo_dp_link_enc_disable(enc);
+}
+
+void dcn31_hpo_dp_link_enc_set_ffe(
+	struct hpo_dp_link_encoder *enc,
+	const struct dc_link_settings *link_settings,
+	uint8_t ffe_preset)
+{
+	struct dcn31_hpo_dp_link_encoder *enc3 = DCN3_1_HPO_DP_LINK_ENC_FROM_HPO_LINK_ENC(enc);
+	struct bp_transmitter_control cntl = { 0 };
+	enum bp_result result;
+
+	/* disable transmitter */
+	cntl.transmitter = enc3->base.transmitter;
+	cntl.action = TRANSMITTER_CONTROL_SET_VOLTAGE_AND_PREEMPASIS;
+	cntl.signal = SIGNAL_TYPE_DISPLAY_PORT_MST;
+	cntl.lanes_number = link_settings->lane_count;
+	cntl.pixel_clock = link_settings->link_rate * 1000;
+	cntl.lane_settings = ffe_preset;
+
+	result = link_transmitter_control(enc3, &cntl);
+
+	if (result != BP_RESULT_OK) {
+		DC_LOG_ERROR("%s: Failed to execute VBIOS command table!\n",
+			__func__);
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static struct hpo_dp_link_encoder_funcs dcn31_hpo_dp_link_encoder_funcs = {
+	.enable_link_phy = dcn31_hpo_dp_link_enc_enable_dp_output,
+	.disable_link_phy = dcn31_hpo_dp_link_enc_disable_output,
+	.link_enable = dcn31_hpo_dp_link_enc_enable,
+	.link_disable = dcn31_hpo_dp_link_enc_disable,
+	.set_link_test_pattern = dcn31_hpo_dp_link_enc_set_link_test_pattern,
+	.update_stream_allocation_table = dcn31_hpo_dp_link_enc_update_stream_allocation_table,
+	.set_throttled_vcp_size = dcn31_hpo_dp_link_enc_set_throttled_vcp_size,
+	.is_in_alt_mode = dcn31_hpo_dp_link_enc_is_in_alt_mode,
+	.read_state = dcn31_hpo_dp_link_enc_read_state,
+	.set_ffe = dcn31_hpo_dp_link_enc_set_ffe,
+};
+
+void hpo_dp_link_encoder31_construct(struct dcn31_hpo_dp_link_encoder *enc31,
+		struct dc_context *ctx,
+		uint32_t inst,
+		const struct dcn31_hpo_dp_link_encoder_registers *hpo_le_regs,
+		const struct dcn31_hpo_dp_link_encoder_shift *hpo_le_shift,
+		const struct dcn31_hpo_dp_link_encoder_mask *hpo_le_mask)
+{
+	enc31->base.ctx = ctx;
+
+	enc31->base.inst = inst;
+	enc31->base.funcs = &dcn31_hpo_dp_link_encoder_funcs;
+	enc31->base.hpd_source = HPD_SOURCEID_UNKNOWN;
+	enc31->base.transmitter = TRANSMITTER_UNKNOWN;
+
+	enc31->regs = hpo_le_regs;
+	enc31->hpo_le_shift = hpo_le_shift;
+	enc31->hpo_le_mask = hpo_le_mask;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h
new file mode 100644
index 000000000000..0706ccaf6fec
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h
@@ -0,0 +1,222 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DAL_DCN31_HPO_DP_LINK_ENCODER_H__
+#define __DAL_DCN31_HPO_DP_LINK_ENCODER_H__
+
+#include "link_encoder.h"
+
+
+#define DCN3_1_HPO_DP_LINK_ENC_FROM_HPO_LINK_ENC(hpo_dp_link_encoder)\
+	container_of(hpo_dp_link_encoder, struct dcn31_hpo_dp_link_encoder, base)
+
+
+#define DCN3_1_HPO_DP_LINK_ENC_REG_LIST(id) \
+	SRI(DP_LINK_ENC_CLOCK_CONTROL, DP_LINK_ENC, id), \
+	SRI(DP_DPHY_SYM32_CONTROL, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_STATUS, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_TP_CONFIG, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_TP_PRBS_SEED0, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_TP_PRBS_SEED1, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_TP_PRBS_SEED2, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_TP_PRBS_SEED3, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_TP_SQ_PULSE, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_TP_CUSTOM0, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_TP_CUSTOM1, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_TP_CUSTOM2, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_TP_CUSTOM3, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_TP_CUSTOM4, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_TP_CUSTOM5, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_TP_CUSTOM6, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_TP_CUSTOM7, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_TP_CUSTOM8, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_TP_CUSTOM9, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_TP_CUSTOM10, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_SAT_VC0, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_SAT_VC1, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_SAT_VC2, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_SAT_VC3, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_VC_RATE_CNTL0, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_VC_RATE_CNTL1, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_VC_RATE_CNTL2, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_VC_RATE_CNTL3, DP_DPHY_SYM32, id), \
+	SRI(DP_DPHY_SYM32_SAT_UPDATE, DP_DPHY_SYM32, id)
+
+#define DCN3_1_RDPCSTX_REG_LIST(id) \
+	SRII(RDPCSTX_PHY_CNTL6, RDPCSTX, id)
+
+
+#define DCN3_1_HPO_DP_LINK_ENC_REGS \
+	uint32_t DP_LINK_ENC_CLOCK_CONTROL;\
+	uint32_t DP_DPHY_SYM32_CONTROL;\
+	uint32_t DP_DPHY_SYM32_STATUS;\
+	uint32_t DP_DPHY_SYM32_TP_CONFIG;\
+	uint32_t DP_DPHY_SYM32_TP_PRBS_SEED0;\
+	uint32_t DP_DPHY_SYM32_TP_PRBS_SEED1;\
+	uint32_t DP_DPHY_SYM32_TP_PRBS_SEED2;\
+	uint32_t DP_DPHY_SYM32_TP_PRBS_SEED3;\
+	uint32_t DP_DPHY_SYM32_TP_SQ_PULSE;\
+	uint32_t DP_DPHY_SYM32_TP_CUSTOM0;\
+	uint32_t DP_DPHY_SYM32_TP_CUSTOM1;\
+	uint32_t DP_DPHY_SYM32_TP_CUSTOM2;\
+	uint32_t DP_DPHY_SYM32_TP_CUSTOM3;\
+	uint32_t DP_DPHY_SYM32_TP_CUSTOM4;\
+	uint32_t DP_DPHY_SYM32_TP_CUSTOM5;\
+	uint32_t DP_DPHY_SYM32_TP_CUSTOM6;\
+	uint32_t DP_DPHY_SYM32_TP_CUSTOM7;\
+	uint32_t DP_DPHY_SYM32_TP_CUSTOM8;\
+	uint32_t DP_DPHY_SYM32_TP_CUSTOM9;\
+	uint32_t DP_DPHY_SYM32_TP_CUSTOM10;\
+	uint32_t DP_DPHY_SYM32_SAT_VC0;\
+	uint32_t DP_DPHY_SYM32_SAT_VC1;\
+	uint32_t DP_DPHY_SYM32_SAT_VC2;\
+	uint32_t DP_DPHY_SYM32_SAT_VC3;\
+	uint32_t DP_DPHY_SYM32_VC_RATE_CNTL0;\
+	uint32_t DP_DPHY_SYM32_VC_RATE_CNTL1;\
+	uint32_t DP_DPHY_SYM32_VC_RATE_CNTL2;\
+	uint32_t DP_DPHY_SYM32_VC_RATE_CNTL3;\
+	uint32_t DP_DPHY_SYM32_SAT_UPDATE
+
+struct dcn31_hpo_dp_link_encoder_registers {
+	DCN3_1_HPO_DP_LINK_ENC_REGS;
+	uint32_t RDPCSTX_PHY_CNTL6[5];
+};
+
+#define DCN3_1_HPO_DP_LINK_ENC_MASK_SH_LIST(mask_sh)\
+	SE_SF(DP_LINK_ENC0_DP_LINK_ENC_CLOCK_CONTROL, DP_LINK_ENC_CLOCK_EN, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_CONTROL, DPHY_RESET, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_CONTROL, DPHY_ENABLE, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_CONTROL, PRECODER_ENABLE, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_CONTROL, MODE, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_CONTROL, NUM_LANES, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_STATUS, STATUS, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_STATUS, SAT_UPDATE_PENDING, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_STATUS, RATE_UPDATE_PENDING, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_TP_CUSTOM0, TP_CUSTOM, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_TP_CONFIG, TP_SELECT0, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_TP_CONFIG, TP_SELECT1, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_TP_CONFIG, TP_SELECT2, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_TP_CONFIG, TP_SELECT3, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_TP_CONFIG, TP_PRBS_SEL0, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_TP_CONFIG, TP_PRBS_SEL1, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_TP_CONFIG, TP_PRBS_SEL2, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_TP_CONFIG, TP_PRBS_SEL3, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_TP_SQ_PULSE, TP_SQ_PULSE_WIDTH, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_SAT_VC0, SAT_STREAM_SOURCE, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_SAT_VC0, SAT_SLOT_COUNT, mask_sh),\
+	SE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_VC_RATE_CNTL0, STREAM_VC_RATE_X, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_VC_RATE_CNTL0, STREAM_VC_RATE_Y, mask_sh),\
+	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_SAT_UPDATE, SAT_UPDATE, mask_sh)
+
+#define DCN3_1_HPO_DP_LINK_ENC_REG_FIELD_LIST(type) \
+	type DP_LINK_ENC_CLOCK_EN;\
+	type DPHY_RESET;\
+	type DPHY_ENABLE;\
+	type PRECODER_ENABLE;\
+	type NUM_LANES;\
+	type MODE;\
+	type STATUS;\
+	type SAT_UPDATE_PENDING;\
+	type RATE_UPDATE_PENDING;\
+	type TP_CUSTOM;\
+	type TP_SELECT0;\
+	type TP_SELECT1;\
+	type TP_SELECT2;\
+	type TP_SELECT3;\
+	type TP_PRBS_SEL0;\
+	type TP_PRBS_SEL1;\
+	type TP_PRBS_SEL2;\
+	type TP_PRBS_SEL3;\
+	type TP_SQ_PULSE_WIDTH;\
+	type SAT_STREAM_SOURCE;\
+	type SAT_SLOT_COUNT;\
+	type STREAM_VC_RATE_X;\
+	type STREAM_VC_RATE_Y;\
+	type SAT_UPDATE;\
+	type RDPCS_PHY_DPALT_DISABLE
+
+
+struct dcn31_hpo_dp_link_encoder_shift {
+	DCN3_1_HPO_DP_LINK_ENC_REG_FIELD_LIST(uint8_t);
+};
+
+struct dcn31_hpo_dp_link_encoder_mask {
+	DCN3_1_HPO_DP_LINK_ENC_REG_FIELD_LIST(uint32_t);
+};
+
+struct dcn31_hpo_dp_link_encoder {
+	struct hpo_dp_link_encoder base;
+	const struct dcn31_hpo_dp_link_encoder_registers *regs;
+	const struct dcn31_hpo_dp_link_encoder_shift *hpo_le_shift;
+	const struct dcn31_hpo_dp_link_encoder_mask *hpo_le_mask;
+};
+
+void hpo_dp_link_encoder31_construct(struct dcn31_hpo_dp_link_encoder *enc31,
+	struct dc_context *ctx,
+	uint32_t inst,
+	const struct dcn31_hpo_dp_link_encoder_registers *hpo_le_regs,
+	const struct dcn31_hpo_dp_link_encoder_shift *hpo_le_shift,
+	const struct dcn31_hpo_dp_link_encoder_mask *hpo_le_mask);
+
+void dcn31_hpo_dp_link_enc_enable_dp_output(
+	struct hpo_dp_link_encoder *enc,
+	const struct dc_link_settings *link_settings,
+	enum transmitter transmitter);
+
+void dcn31_hpo_dp_link_enc_disable_output(
+	struct hpo_dp_link_encoder *enc,
+	enum signal_type signal);
+
+void dcn31_hpo_dp_link_enc_enable(
+	struct hpo_dp_link_encoder *enc,
+	enum dc_lane_count num_lanes);
+
+void dcn31_hpo_dp_link_enc_disable(
+	struct hpo_dp_link_encoder *enc);
+
+void dcn31_hpo_dp_link_enc_set_link_test_pattern(
+	struct hpo_dp_link_encoder *enc,
+	struct encoder_set_dp_phy_pattern_param *tp_params);
+
+void dcn31_hpo_dp_link_enc_update_stream_allocation_table(
+	struct hpo_dp_link_encoder *enc,
+	const struct link_mst_stream_allocation_table *table);
+
+void dcn31_hpo_dp_link_enc_set_throttled_vcp_size(
+	struct hpo_dp_link_encoder *enc,
+	uint32_t stream_encoder_inst,
+	struct fixed31_32 avg_time_slots_per_mtp);
+
+void dcn31_hpo_dp_link_enc_read_state(
+	struct hpo_dp_link_encoder *enc,
+	struct hpo_dp_link_enc_state *state);
+
+void dcn31_hpo_dp_link_enc_set_ffe(
+	struct hpo_dp_link_encoder *enc,
+	const struct dc_link_settings *link_settings,
+	uint8_t ffe_preset);
+
+#endif   // __DAL_DCN31_HPO_LINK_ENCODER_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 1994a8d3883d..f264a32ebade 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -53,6 +53,7 @@
 #include "dcn30/dcn30_afmt.h"
 #include "dcn30/dcn30_dio_stream_encoder.h"
 #include "dcn31/dcn31_hpo_dp_stream_encoder.h"
+#include "dcn31/dcn31_hpo_dp_link_encoder.h"
 #include "dcn31/dcn31_apg.h"
 #include "dcn31/dcn31_dio_link_encoder.h"
 #include "dce/dce_clock_source.h"
@@ -585,6 +586,29 @@ static const struct dcn31_hpo_dp_stream_encoder_mask hpo_dp_se_mask = {
 	DCN3_1_HPO_DP_STREAM_ENC_MASK_SH_LIST(_MASK)
 };
 
+#define hpo_dp_link_encoder_reg_list(id)\
+[id] = {\
+	DCN3_1_HPO_DP_LINK_ENC_REG_LIST(id),\
+	DCN3_1_RDPCSTX_REG_LIST(0),\
+	DCN3_1_RDPCSTX_REG_LIST(1),\
+	DCN3_1_RDPCSTX_REG_LIST(2),\
+	DCN3_1_RDPCSTX_REG_LIST(3),\
+	DCN3_1_RDPCSTX_REG_LIST(4)\
+}
+
+static const struct dcn31_hpo_dp_link_encoder_registers hpo_dp_link_enc_regs[] = {
+	hpo_dp_link_encoder_reg_list(0),
+	hpo_dp_link_encoder_reg_list(1),
+};
+
+static const struct dcn31_hpo_dp_link_encoder_shift hpo_dp_le_shift = {
+	DCN3_1_HPO_DP_LINK_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn31_hpo_dp_link_encoder_mask hpo_dp_le_mask = {
+	DCN3_1_HPO_DP_LINK_ENC_MASK_SH_LIST(_MASK)
+};
+
 static const struct dcn3_dpp_registers dpp_regs[] = {
 	dpp_regs(0),
 	dpp_regs(1),
@@ -922,6 +946,7 @@ static const struct resource_caps res_cap_dcn31 = {
 	.num_stream_encoder = 5,
 	.num_dig_link_enc = 5,
 	.num_hpo_dp_stream_encoder = 4,
+	.num_hpo_dp_link_encoder = 2,
 	.num_pll = 5,
 	.num_dwb = 1,
 	.num_ddc = 5,
@@ -1398,6 +1423,22 @@ static struct hpo_dp_stream_encoder *dcn31_hpo_dp_stream_encoder_create(
 	return &hpo_dp_enc31->base;
 }
 
+static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
+	uint8_t inst,
+	struct dc_context *ctx)
+{
+	struct dcn31_hpo_dp_link_encoder *hpo_dp_enc31;
+
+	/* allocate HPO link encoder */
+	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+
+	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
+					&hpo_dp_link_enc_regs[inst],
+					&hpo_dp_le_shift, &hpo_dp_le_mask);
+
+	return &hpo_dp_enc31->base;
+}
+
 static struct dce_hwseq *dcn31_hwseq_create(
 	struct dc_context *ctx)
 {
@@ -1416,6 +1457,7 @@ static const struct resource_create_funcs res_create_funcs = {
 	.create_audio = dcn31_create_audio,
 	.create_stream_encoder = dcn31_stream_encoder_create,
 	.create_hpo_dp_stream_encoder = dcn31_hpo_dp_stream_encoder_create,
+	.create_hpo_dp_link_encoder = dcn31_hpo_dp_link_encoder_create,
 	.create_hwseq = dcn31_hwseq_create,
 };
 
@@ -1424,6 +1466,7 @@ static const struct resource_create_funcs res_create_maximus_funcs = {
 	.create_audio = NULL,
 	.create_stream_encoder = NULL,
 	.create_hpo_dp_stream_encoder = dcn31_hpo_dp_stream_encoder_create,
+	.create_hpo_dp_link_encoder = dcn31_hpo_dp_link_encoder_create,
 	.create_hwseq = dcn31_hwseq_create,
 };
 
@@ -1461,6 +1504,13 @@ static void dcn31_resource_destruct(struct dcn31_resource_pool *pool)
 		}
 	}
 
+	for (i = 0; i < pool->base.hpo_dp_link_enc_count; i++) {
+		if (pool->base.hpo_dp_link_enc[i] != NULL) {
+			kfree(DCN3_1_HPO_DP_LINK_ENC_FROM_HPO_LINK_ENC(pool->base.hpo_dp_link_enc[i]));
+			pool->base.hpo_dp_link_enc[i] = NULL;
+		}
+	}
+
 	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
 		if (pool->base.dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->base.dscs[i]);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 19dbfc8a44bb..ed254c2771f0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -249,6 +249,8 @@ struct resource_pool {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	unsigned int hpo_dp_stream_enc_count;
 	struct hpo_dp_stream_encoder *hpo_dp_stream_enc[MAX_HPO_DP2_ENCODERS];
+	unsigned int hpo_dp_link_enc_count;
+	struct hpo_dp_link_encoder *hpo_dp_link_enc[MAX_HPO_DP2_LINK_ENCODERS];
 #endif
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct dc_3dlut *mpc_lut[MAX_PIPES];
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index ad9e9e2d52b0..10ecbc667ffa 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -40,6 +40,7 @@
 #define MAX_DWB_PIPES	1
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 #define MAX_HPO_DP2_ENCODERS	4
+#define MAX_HPO_DP2_LINK_ENCODERS	2
 #endif
 
 struct gamma_curve {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index 9eaf345aa2a1..fa3a725e11dc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -210,4 +210,91 @@ struct link_enc_assignment {
 	enum engine_id eng_id;
 };
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+enum dp2_link_mode {
+	DP2_LINK_TRAINING_TPS1,
+	DP2_LINK_TRAINING_TPS2,
+	DP2_LINK_ACTIVE,
+	DP2_TEST_PATTERN
+};
+
+enum dp2_phy_tp_select {
+	DP_DPHY_TP_SELECT_TPS1,
+	DP_DPHY_TP_SELECT_TPS2,
+	DP_DPHY_TP_SELECT_PRBS,
+	DP_DPHY_TP_SELECT_CUSTOM,
+	DP_DPHY_TP_SELECT_SQUARE
+};
+
+enum dp2_phy_tp_prbs {
+	DP_DPHY_TP_PRBS7,
+	DP_DPHY_TP_PRBS9,
+	DP_DPHY_TP_PRBS11,
+	DP_DPHY_TP_PRBS15,
+	DP_DPHY_TP_PRBS23,
+	DP_DPHY_TP_PRBS31
+};
+
+struct hpo_dp_link_enc_state {
+	uint32_t   link_enc_enabled;
+	uint32_t   link_mode;
+	uint32_t   lane_count;
+	uint32_t   slot_count[4];
+	uint32_t   stream_src[4];
+	uint32_t   vc_rate_x[4];
+	uint32_t   vc_rate_y[4];
+};
+
+struct hpo_dp_link_encoder {
+	const struct hpo_dp_link_encoder_funcs *funcs;
+	struct dc_context *ctx;
+	int inst;
+	enum engine_id preferred_engine;
+	enum transmitter transmitter;
+	enum hpd_source_id hpd_source;
+};
+
+struct hpo_dp_link_encoder_funcs {
+
+	void (*enable_link_phy)(struct hpo_dp_link_encoder *enc,
+		const struct dc_link_settings *link_settings,
+		enum transmitter transmitter);
+
+	void (*disable_link_phy)(struct hpo_dp_link_encoder *link_enc,
+		enum signal_type signal);
+
+	void (*link_enable)(
+			struct hpo_dp_link_encoder *enc,
+			enum dc_lane_count num_lanes);
+
+	void (*link_disable)(
+			struct hpo_dp_link_encoder *enc);
+
+	void (*set_link_test_pattern)(
+			struct hpo_dp_link_encoder *enc,
+			struct encoder_set_dp_phy_pattern_param *tp_params);
+
+	void (*update_stream_allocation_table)(
+			struct hpo_dp_link_encoder *enc,
+			const struct link_mst_stream_allocation_table *table);
+
+	void (*set_throttled_vcp_size)(
+			struct hpo_dp_link_encoder *enc,
+			uint32_t stream_encoder_inst,
+			struct fixed31_32 avg_time_slots_per_mtp);
+
+	bool (*is_in_alt_mode) (
+			struct hpo_dp_link_encoder *enc);
+
+	void (*read_state)(
+			struct hpo_dp_link_encoder *enc,
+			struct hpo_dp_link_enc_state *state);
+
+	void (*set_ffe)(
+		struct hpo_dp_link_encoder *enc,
+		const struct dc_link_settings *link_settings,
+		uint8_t ffe_preset);
+};
+#endif
+
 #endif /* LINK_ENCODER_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 5a2cfc899044..713f6d5cf3e0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -51,6 +51,7 @@ struct resource_caps {
 	unsigned int num_dig_link_enc; // Total number of DIGs (digital encoders) in DIO (Display Input/Output).
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	int num_hpo_dp_stream_encoder;
+	int num_hpo_dp_link_encoder;
 #endif
 	int num_mpc_3dlut;
 };
@@ -74,6 +75,10 @@ struct resource_create_funcs {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct hpo_dp_stream_encoder *(*create_hpo_dp_stream_encoder)(
 			enum engine_id eng_id, struct dc_context *ctx);
+
+	struct hpo_dp_link_encoder *(*create_hpo_dp_link_encoder)(
+			uint8_t inst,
+			struct dc_context *ctx);
 #endif
 
 	struct dce_hwseq *(*create_hwseq)(
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 32f5274ed34e..efd9812c13ec 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -114,13 +114,30 @@ enum dp_test_pattern {
 	DP_TEST_PATTERN_CP2520_2,
 	DP_TEST_PATTERN_HBR2_COMPLIANCE_EYE = DP_TEST_PATTERN_CP2520_2,
 	DP_TEST_PATTERN_CP2520_3,
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	DP_TEST_PATTERN_128b_132b_TPS1,
+	DP_TEST_PATTERN_128b_132b_TPS2,
+	DP_TEST_PATTERN_PRBS9,
+	DP_TEST_PATTERN_PRBS11,
+	DP_TEST_PATTERN_PRBS15,
+	DP_TEST_PATTERN_PRBS23,
+	DP_TEST_PATTERN_PRBS31,
+	DP_TEST_PATTERN_264BIT_CUSTOM,
+	DP_TEST_PATTERN_SQUARE_PULSE,
+#endif
 
 	/* Link Training Patterns */
 	DP_TEST_PATTERN_TRAINING_PATTERN1,
 	DP_TEST_PATTERN_TRAINING_PATTERN2,
 	DP_TEST_PATTERN_TRAINING_PATTERN3,
 	DP_TEST_PATTERN_TRAINING_PATTERN4,
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	DP_TEST_PATTERN_128b_132b_TPS1_TRAINING_MODE,
+	DP_TEST_PATTERN_128b_132b_TPS2_TRAINING_MODE,
+	DP_TEST_PATTERN_PHY_PATTERN_END = DP_TEST_PATTERN_128b_132b_TPS2_TRAINING_MODE,
+#else
 	DP_TEST_PATTERN_PHY_PATTERN_END = DP_TEST_PATTERN_TRAINING_PATTERN4,
+#endif
 
 	/* link test patterns*/
 	DP_TEST_PATTERN_COLOR_SQUARES,
-- 
2.25.1

