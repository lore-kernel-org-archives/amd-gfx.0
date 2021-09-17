Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCD2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2A6604E9
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D2A6604E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5050A6EE7C;
	Fri, 17 Sep 2021 19:26:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA9876EE84
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:26:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTXin09FEZCU/TksXcyVTa7gAZkwOWcZxCSp1UIM+FUnQeGCXhCGScz0hdSVL9fmwb2M/3WI3IltrC0qc3wLHq6i/WWWJheZVERUe/Y/LdMh0fphIaPndf8EHtxknOSvM5NQyrT+gXa9J3ZO0jEx1Ypl7UNEBpoVRHdVyuJ3zOrmIX4ggeLY9solv5UzNf7baQ7ln6bAvt1m8WjvtDo96rKWs/Adt2G3p96HQlN2/Qc63RrDn4Bd7U3lFO+AIN3vyXpA6JmapxvugYArbfnWZheHYcM5yw3faqPPR0ixY/7RSOz8MPGqi/aXWrk7ZnMkA6g+d2x10TwVtlHA4oCSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=pZ3NHenudWjyunQM6uHiplowPhyemqZ6JQXnQG56GVc=;
 b=CD7PNem52N1NcoIQ/9fBu3eUH8HUSUUrWrrgDHuIJSHffxjyPADHg7MFv5wZzS1igm6EdqOOlhoFwN0ltfQmLkkXAeuMsr0peGiwfbKSI7z9d3vmIrBQonYsANEWA70ffryr9SA9nbVLdqRzlO+Z3KYFhWd2A0zopHdhJvPchjk/icJZB0OLztQ9UEYYEQRsDvapSLmYC3KFLhbImp7OGrAlQPSBuW0MKdTilxXAkDC+nI4BQpOztcYOaxXY1VE0hQEgUNnnaN4kWq2kNzCmVyPGcdsjxptV9nOD08aJM6nG+0qxpksU+Us+pgCKWV8nSrTuX+qrigxi7E08PI24VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ3NHenudWjyunQM6uHiplowPhyemqZ6JQXnQG56GVc=;
 b=u/XVBFKZf2eSASN4SffmJQV90fek1/p2efbbcAXPoy4Fl+TVbE9LKwvcNjDu0VSy3FVTRlqQGWm+JqwGFpt4NMwldVdLvfeCeatyGuOjnUeuBb0NZRwQ4A+AQpaip3CF8Q6hSUFe0Z4rcRKEANq3jzo/yfcGcFa8GONGwfdMAmA=
Received: from BN9PR03CA0044.namprd03.prod.outlook.com (2603:10b6:408:fb::19)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 19:25:58 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::12) by BN9PR03CA0044.outlook.office365.com
 (2603:10b6:408:fb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:25:58 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:25:57 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, "Liu, Zhan"
 <Zhan.Liu@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 12/18] drm/amd/display: Fix B0 USB-C DP Alt mode
Date: Fri, 17 Sep 2021 15:25:18 -0400
Message-ID: <20210917192524.3020276-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
References: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30ef2c0e-779c-4557-3a88-08d97a10fa6e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51113D34F8FC24A2DA22277398DD9@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6820qP2gIprnf+mh5jf8Pc6lDwkI8jjm2sYVRsh0CKuFGqlCIa6zdJk1YpwtY/lpVEMaXWzEDu0lfZH4/rozeNMFRzeFXVflUnaYyB2nWyFoswQvjFjRcM+cNdLCbZMIpqlqd27GAJqX8s+t9u2tMI+JietYMTXAaEUzlUCv0fOzkjUZHvt7U/PXEfOY1XTBIbJVe1osnzsd36fonHo3UPNSWWS+oN9ECb1dyiqhpku9s0tVrB8ZmqVRKteMDXqmTNat0J+BDoE9i1CgBoz8uPHiVKdjel5K4Gbh6Df9d/z2mb43/1elyn9RuW0mV+Uiz9G3FxUPnrjX+V/i1kHQEFdNLDLRjtzqzfXF7kb65LYekTYw6vBEaM+qq2nPWRCi3fHBckhNT2DmnobZvl9g98aKmigyYhGaQ65uH53jKAcbXSpyTw1reX3yEwXIv5OXJllNTMdt8SZVkzuATwf53ilHI97SpADELh65IWhpa88Upls8//ZM/2iUlRYh1ummpgU3fgTgUrAvhA3Jdvr5EXK3Gaz8nTFzMqSTqLD4opjHyVCf+w0z8ZQ9qqD4ScUbAdIFOcWD9M7AzKpFCCnDrkh/aMPM1gwGhXnxZH7PXYZQOwykE896/oa7IEI39R8XWb6DNgON5/uCtfjcC8DFBLD0+9OC3vJVMp0IYD9BoGwXS1kye98shUtx0D4IJByt8yMbTke6uHb2bZO2HUW/OTKzl+awyc+brxTe7GiaTcA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(36756003)(2906002)(186003)(356005)(6916009)(54906003)(6666004)(4326008)(508600001)(36860700001)(81166007)(83380400001)(16526019)(47076005)(316002)(426003)(70206006)(86362001)(2616005)(8936002)(70586007)(1076003)(336012)(82310400003)(26005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:25:58.8789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ef2c0e-779c-4557-3a88-08d97a10fa6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
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

From: "Liu, Zhan" <Zhan.Liu@amd.com>

[Why]
Starting from B0, along with RDPCSTX, RDPCSPIPE registers are also used.

[How]
Make sure RDPCSPIPE registers are programmed correctly.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by:Zhan Liu <Zhan.Liu@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |  1 +
 .../display/dc/dcn31/dcn31_dio_link_encoder.c | 33 ++++++++++++++++++-
 .../display/dc/dcn31/dcn31_dio_link_encoder.h | 11 ++++++-
 .../include/asic_reg/dpcs/dpcs_4_2_0_offset.h | 27 +++++++++++++++
 4 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
index d8b22618b79e..c337588231ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
@@ -118,6 +118,7 @@ struct dcn10_link_enc_registers {
 	uint32_t RDPCSTX_PHY_CNTL4;
 	uint32_t RDPCSTX_PHY_CNTL5;
 	uint32_t RDPCSTX_PHY_CNTL6;
+	uint32_t RDPCSPIPE_PHY_CNTL6;
 	uint32_t RDPCSTX_PHY_CNTL7;
 	uint32_t RDPCSTX_PHY_CNTL8;
 	uint32_t RDPCSTX_PHY_CNTL9;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index 03f0290d41f2..4f0a0803db6c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -37,6 +37,7 @@
 
 #include "link_enc_cfg.h"
 #include "dc_dmub_srv.h"
+#include "dal_asic_id.h"
 
 #define CTX \
 	enc10->base.ctx
@@ -215,7 +216,7 @@ static const struct link_encoder_funcs dcn31_link_enc_funcs = {
 	.fec_is_active = enc2_fec_is_active,
 	.get_dig_frontend = dcn10_get_dig_frontend,
 	.get_dig_mode = dcn10_get_dig_mode,
-	.is_in_alt_mode = dcn20_link_encoder_is_in_alt_mode,
+	.is_in_alt_mode = dcn31_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn20_link_encoder_get_max_link_cap,
 	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
 };
@@ -408,3 +409,33 @@ void dcn31_link_encoder_disable_output(
 	}
 }
 
+bool dcn31_link_encoder_is_in_alt_mode(struct link_encoder *enc)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	uint32_t dp_alt_mode_disable;
+	bool is_usb_c_alt_mode = false;
+
+	if (enc->features.flags.bits.DP_IS_USB_C) {
+		if (enc->ctx->asic_id.hw_internal_rev != YELLOW_CARP_B0) {
+			// [Note] no need to check hw_internal_rev once phy mux selection is ready
+			REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, &dp_alt_mode_disable);
+		} else {
+		/*
+		 * B0 phys use a new set of registers to check whether alt mode is disabled.
+		 * if value == 1 alt mode is disabled, otherwise it is enabled.
+		 */
+			if ((enc10->base.transmitter == TRANSMITTER_UNIPHY_A)
+					|| (enc10->base.transmitter == TRANSMITTER_UNIPHY_B)
+					|| (enc10->base.transmitter == TRANSMITTER_UNIPHY_E)) {
+				REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, &dp_alt_mode_disable);
+			} else {
+			// [Note] need to change TRANSMITTER_UNIPHY_C/D to F/G once phy mux selection is ready
+				REG_GET(RDPCSPIPE_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, &dp_alt_mode_disable);
+			}
+		}
+
+		is_usb_c_alt_mode = (dp_alt_mode_disable == 0);
+	}
+
+	return is_usb_c_alt_mode;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
index 32d146312838..bec50e4402ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
@@ -69,6 +69,7 @@
 	SRI(RDPCSTX_PHY_CNTL4, RDPCSTX, id), \
 	SRI(RDPCSTX_PHY_CNTL5, RDPCSTX, id), \
 	SRI(RDPCSTX_PHY_CNTL6, RDPCSTX, id), \
+	SRI(RDPCSPIPE_PHY_CNTL6, RDPCSPIPE, id), \
 	SRI(RDPCSTX_PHY_CNTL7, RDPCSTX, id), \
 	SRI(RDPCSTX_PHY_CNTL8, RDPCSTX, id), \
 	SRI(RDPCSTX_PHY_CNTL9, RDPCSTX, id), \
@@ -115,7 +116,9 @@
 	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX2_MPLL_EN, mask_sh),\
 	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX3_MPLL_EN, mask_sh),\
 	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, mask_sh),\
-	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, mask_sh),\
+	LE_SF(RDPCSPIPE0_RDPCSPIPE_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, mask_sh),\
+	LE_SF(RDPCSPIPE0_RDPCSPIPE_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, mask_sh),\
+	LE_SF(RDPCSPIPE0_RDPCSPIPE_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE_ACK, mask_sh),\
 	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL7, RDPCS_PHY_DP_MPLLB_FRACN_QUOT, mask_sh),\
 	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL7, RDPCS_PHY_DP_MPLLB_FRACN_DEN, mask_sh),\
 	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL8, RDPCS_PHY_DP_MPLLB_SSC_PEAK, mask_sh),\
@@ -243,4 +246,10 @@ void dcn31_link_encoder_disable_output(
 	struct link_encoder *enc,
 	enum signal_type signal);
 
+/*
+ * Check whether USB-C DP Alt mode is disabled
+ */
+bool dcn31_link_encoder_is_in_alt_mode(
+	struct link_encoder *enc);
+
 #endif /* __DC_LINK_ENCODER__DCN31_H__ */
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_2_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_2_0_offset.h
index 92caf8441d1e..01a56556cde1 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_2_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_2_0_offset.h
@@ -11932,5 +11932,32 @@
 #define ixDPCSSYS_CR4_RAWLANEX_DIG_PCS_XF_RX_OVRD_OUT_2                                                0xe0c7
 #define ixDPCSSYS_CR4_RAWLANEX_DIG_PCS_XF_TX_OVRD_IN_2                                                 0xe0c8
 
+//RDPCSPIPE0_RDPCSPIPE_PHY_CNTL6
+#define RDPCSPIPE0_RDPCSPIPE_PHY_CNTL6__RDPCS_PHY_DPALT_DP4__SHIFT                                            0x10
+#define RDPCSPIPE0_RDPCSPIPE_PHY_CNTL6__RDPCS_PHY_DPALT_DISABLE__SHIFT                                        0x11
+#define RDPCSPIPE0_RDPCSPIPE_PHY_CNTL6__RDPCS_PHY_DPALT_DISABLE_ACK__SHIFT                                    0x12
+#define RDPCSPIPE0_RDPCSPIPE_PHY_CNTL6__RDPCS_PHY_DPALT_DP4_MASK                                              0x00010000L
+#define RDPCSPIPE0_RDPCSPIPE_PHY_CNTL6__RDPCS_PHY_DPALT_DISABLE_MASK                                          0x00020000L
+#define RDPCSPIPE0_RDPCSPIPE_PHY_CNTL6__RDPCS_PHY_DPALT_DISABLE_ACK_MASK                                      0x00040000L
+
+//RDPCSPIPE1_RDPCSPIPE_PHY_CNTL6
+#define RDPCSPIPE1_RDPCSPIPE_PHY_CNTL6__RDPCS_PHY_DPALT_DP4__SHIFT                                            0x10
+#define RDPCSPIPE1_RDPCSPIPE_PHY_CNTL6__RDPCS_PHY_DPALT_DISABLE__SHIFT                                        0x11
+#define RDPCSPIPE1_RDPCSPIPE_PHY_CNTL6__RDPCS_PHY_DPALT_DISABLE_ACK__SHIFT                                    0x12
+#define RDPCSPIPE1_RDPCSPIPE_PHY_CNTL6__RDPCS_PHY_DPALT_DP4_MASK                                              0x00010000L
+#define RDPCSPIPE1_RDPCSPIPE_PHY_CNTL6__RDPCS_PHY_DPALT_DISABLE_MASK                                          0x00020000L
+#define RDPCSPIPE1_RDPCSPIPE_PHY_CNTL6__RDPCS_PHY_DPALT_DISABLE_ACK_MASK                                      0x00040000L
+
+//[Note] Hack. RDPCSPIPE only has 2 instances.
+#define regRDPCSPIPE0_RDPCSPIPE_PHY_CNTL6                                                              0x2d73
+#define regRDPCSPIPE0_RDPCSPIPE_PHY_CNTL6_BASE_IDX                                                     2
+#define regRDPCSPIPE1_RDPCSPIPE_PHY_CNTL6                                                              0x2e4b
+#define regRDPCSPIPE1_RDPCSPIPE_PHY_CNTL6_BASE_IDX                                                     2
+#define regRDPCSPIPE2_RDPCSPIPE_PHY_CNTL6                                                              0x2d73
+#define regRDPCSPIPE2_RDPCSPIPE_PHY_CNTL6_BASE_IDX                                                     2
+#define regRDPCSPIPE3_RDPCSPIPE_PHY_CNTL6                                                              0x2e4b
+#define regRDPCSPIPE3_RDPCSPIPE_PHY_CNTL6_BASE_IDX                                                     2
+#define regRDPCSPIPE4_RDPCSPIPE_PHY_CNTL6                                                              0x2d73
+#define regRDPCSPIPE4_RDPCSPIPE_PHY_CNTL6_BASE_IDX                                                     2
 
 #endif
-- 
2.25.1

