Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CBB606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TVAQ9uZ1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5818D10F961;
	Wed, 21 Oct 2026 06:27:39 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013034.outbound.protection.outlook.com
 [40.107.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B30410F95C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:27:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IResuR9DriCX/xQOTrIPHddbTx+XQ/vjrRG2xusIFTd4jMNLni7ERiGgeX7iNNSamGJt31Po+cZNkSrhkzpeaqO0yg36BcOolAKK0EGl0T9SFVxy6RBX0yNeaQy7bs7D0bPv/o4X+p4F3cjoopwTf8QYpxf2t0GuzADaYoop+qZfi46aME0d16H9FGR0iHqMDz+2Dv95zx2lJwu/F+OvlhfmYAFewr1Y1pFqyEne+WmSLaENLKJv98+48fpqb7sKi2iRBo99ysv4gQwoxFrEn+25CKkA1diOZyder1drVxe1PH9HHPHd2QTbzkL4jHSsJA6L8WpHscz425ndgSFq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQSWfM1Wl0YYfl9xU/tQTvg5MRoizxz3oIKV07dSp1g=;
 b=Tnna1FVQrU66vRsyirNg1hMxWCYbcGrGeI+CrOjYFaPRYR5SHUsxVnLp2LnJnm/p60VP2TvPzX9z/nRRaI7gCdOhzD/U+gAbNV3b7lqwkIIbjVPzpg2nNuID44rnBakgILlSfk04rC11tgcEUgCpkUZLIqFQXVEL6z/SKxJdb7HVcpgAQAIBqYUS/XvKnckH0s8Z3/wSX6yBSDvadf8e+D1nPJocgdAN0+LNeyBF4r0NeXXA54MNc/ZUAbcK/2AuediOxbEVC8A9fjdyDKXJ+Np36wEe3bD2mmIxsQnbAKyQXAkHcHCsMr2kJ4VrKbrwjUjjZX4rnno6kf52cdiNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQSWfM1Wl0YYfl9xU/tQTvg5MRoizxz3oIKV07dSp1g=;
 b=TVAQ9uZ1E+UXBK3WJ3nBq7IROeiDWmi3luv2N7kSk0ahzqg5pwnSs003PbWA+PJJ04iKXizhL/rf3ZlTAHBBcBlp0Fg/pZa62LNybaiCGjxilQh7g3Fx+zbZtRWBQ6CZOUABY25RgCcLVT5B0EYbaksEwJn8v7TXDKPLe9js2SU=
Received: from BY3PR05CA0048.namprd05.prod.outlook.com (2603:10b6:a03:39b::23)
 by IA4PR12MB9811.namprd12.prod.outlook.com (2603:10b6:208:54e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:27:27 +0000
Received: from SJ1PEPF000037AF.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::63) by BY3PR05CA0048.outlook.office365.com
 (2603:10b6:a03:39b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:27:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AF.mail.protection.outlook.com (10.167.244.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:27:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:26 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:27:22 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 33/49] drm/amd/display: Read DCN401 PHY reset and lane enable
 state
Date: Wed, 21 Oct 2026 14:22:39 +0800
Message-ID: <20261021062519.674697-34-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AF:EE_|IA4PR12MB9811:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fd4bc5-beb7-4da1-e42c-08df2f3c6053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|5023799004|11063799006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: /b4krq+vJk5yPXBUWqTnwR8GTKOi4+YgYeL4qA6+kiARsXXi13d0f+vZH65QoJMgN/c042aiCsWt0IBZgzDhdxGcbJTv554Qo35YlJASovcOaP43NnNq2V+N7NbdKPgZ+ZF0zvp+4zSjhj888iSGTouZUpCTy5K8lEXkuaHrS1Qlh0ae/5KcBmGjvLJKdAQhVpbJTuczwnQABj8Pgu72lXHhxRqyRX91+8iCzkPdQDUag/SzDJly5n1ZGD4r0LG4b2VjSZXGF81FoDxA/eUfR6ZobxiBJOLq33ubffRyejAhpvxtMBZ2Pwse71zPhLQthgNgPxeYCJDIwR/L1OCmaHI9WKV9jGzx81hWSJnRM9rXr8GQ1X/EKfVb+TNg6r9wSjJD975BluUhPrntGGqN79gZ7aOHqY0/bpbskBH9lOyQFArMkPVYFS8o8LX1lM2ZvW39emJLiDIHh/kbtw0VPTcCqbLU2py1PWgxk9G8NHybYwsUw843DS0wsOeiYh6gFn45VVk0ogCn6H3NWuzFt0BKktupADyaXwL7zLM3UuAowRUjH6eoajrqK8tVwX81taKjUtxRh39OqkeopNidyOGvsCo0kpRnKwjQOiAbuiMcfnBf+vJc+MexFdkSypsavG8xpME6lRZDNXrxS0iZn/44ddcK0BHcPdR+K0Kyoblz4yWCtoH+XPI/AvWj1dTxTAFskff0u6RaP8WKrccb1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1opkfEwpUIEtoMoU/Yn96jdnVTlMV+VpwqQOgMo84Ut9hKWIh6TKd3BOSTiW/Bq53qNO8WE6zlWprkEQkRQdeTZ+KzVHJKuOpUFdpiUS8n0GaULJjxGJ3gMXPPbcas4pbIGI/YxE7tCsi17tR2zrEsQVCp+QZJy3FiEZWLtqoUJvEnqKgxOQnaInlLRD95pcrX5Xwhl74NT9QoQWiZKSkaOik/Q76GrNhK8P9Skd2qYn7MuP1Lsp5ad1k9yqQm0L5DGyjAoSoxF0njhSjMdkubzoCCvw65GHp3VZTY4QnCIzDwDkKfXG424YvdOVzLbVxa+5IqrH9Bvp1jeWjxoCUTXU2Avf4p1+GziK33/glaXSxndDDk8QQ+UdcKSeU+7HeQ6AwxSRixCiabvSDNMaTxOpDmebL7xDDmawXp97l4WigZIdiVJSIs8o/mP38p04
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:27:26.9800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fd4bc5-beb7-4da1-e42c-08df2f3c6053
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9811
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tony Cheng <tony.cheng@amd.com>

link->phy_state is software bookkeeping, so nothing in DC tells
whether a PHY is really out of reset. Add rdpcs_phy_reset and
rdpcs_tx_data_en (one bit per DP TX lane DATA_EN) to struct
link_enc_state and fill them from a DCN401 read_state that wraps
link_enc2_read_state.

DCN401 had no RDPCSTX registers mapped for its link encoders. Map
RDPCSTX_PHY_CNTL0 and CNTL3 in dcn401_resource.c only; the shared
DCN401 lists are also used by later generations, which lack them.
Only read_state reads these registers; nothing programs them.

The fields are printed by get_hw_state later in this series.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   | 22 ++++++++++++++++++-
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h   |  8 +++++++
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  2 ++
 .../dc/resource/dcn401/dcn401_resource.c      | 10 ++++++---
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c
index 6594fbb3fa43..4d62a5982632 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c
@@ -364,6 +364,26 @@ bool dcn401_is_dig_enabled(struct link_encoder *enc)
 	return (clk_enabled == 1 && dig_enabled == 1);
 }
 
+void dcn401_link_encoder_read_state(struct link_encoder *enc, struct link_enc_state *s)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	uint32_t tx0 = 0, tx1 = 0, tx2 = 0, tx3 = 0;
+
+	link_enc2_read_state(enc, s);
+
+	if (enc10->link_regs->RDPCSTX_PHY_CNTL0)
+		REG_GET(RDPCSTX_PHY_CNTL0, RDPCS_PHY_RESET, &s->rdpcs_phy_reset);
+
+	if (enc10->link_regs->RDPCSTX_PHY_CNTL3) {
+		REG_GET_4(RDPCSTX_PHY_CNTL3,
+			  RDPCS_PHY_DP_TX0_DATA_EN, &tx0,
+			  RDPCS_PHY_DP_TX1_DATA_EN, &tx1,
+			  RDPCS_PHY_DP_TX2_DATA_EN, &tx2,
+			  RDPCS_PHY_DP_TX3_DATA_EN, &tx3);
+		s->rdpcs_tx_data_en = tx0 | tx1 << 1 | tx2 << 2 | tx3 << 3;
+	}
+}
+
 enum signal_type dcn401_get_dig_mode(
 	struct link_encoder *enc)
 {
@@ -399,7 +419,7 @@ void dcn401_setup_ri_pj_check_in_sw_or_hw_mode(
 }
 
 static const struct link_encoder_funcs dcn401_link_enc_funcs = {
-	.read_state = link_enc2_read_state,
+	.read_state = dcn401_link_encoder_read_state,
 	.validate_output_with_stream =
 			dcn30_link_encoder_validate_output_with_stream,
 	.hw_init = enc401_hw_init,
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.h
index 62f8f9098b53..689fc817dbc5 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.h
@@ -28,6 +28,13 @@
 
 #include "dcn30/dcn30_dio_link_encoder.h"
 
+#define LINK_ENCODER_PHY_STATE_MASK_SH_LIST_DCN401(mask_sh) \
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_PHY_RESET, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_DATA_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_DATA_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_DATA_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_DATA_EN, mask_sh)
+
 #define LINK_ENCODER_MASK_SH_LIST_DCN401(mask_sh) \
 	LE_SF(DIG0_DIG_BE_EN_CNTL, DIG_BE_ENABLE, mask_sh),\
 	LE_SF(DIG0_DIG_BE_CNTL, DIG_RB_SWITCH_EN, mask_sh),\
@@ -150,6 +157,7 @@ enum signal_type dcn401_get_dig_mode(
 	struct link_encoder *enc);
 
 bool dcn401_is_dig_enabled(struct link_encoder *enc);
+void dcn401_link_encoder_read_state(struct link_encoder *enc, struct link_enc_state *s);
 
 enum signal_type dcn401_get_dig_mode(struct link_encoder *enc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index f3ef5bbfad81..1c95d643af14 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -117,6 +117,8 @@ struct link_enc_state {
 		uint32_t dphy_fec_ready_shadow;
 		uint32_t dphy_fec_active_status;
 		uint32_t dp_link_training_complete;
+		uint32_t rdpcs_phy_reset;
+		uint32_t rdpcs_tx_data_en;
 
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 34e218bff078..acc5aa8d777f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -307,19 +307,23 @@ static struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[5];
 
 #define link_regs_init(id, phyid) \
 	LE_DCN401_REG_LIST_RI(id), \
-	LE_DCN60_REG_LIST_RI(id)
+	LE_DCN60_REG_LIST_RI(id), \
+	SRI_ARR(RDPCSTX_PHY_CNTL0, RDPCSTX, id), \
+	SRI_ARR(RDPCSTX_PHY_CNTL3, RDPCSTX, id)
 
 static struct dcn10_link_enc_registers link_enc_regs[4];
 
 
 static const struct dcn10_link_enc_shift le_shift = {
 	LINK_ENCODER_MASK_SH_LIST_DCN401(__SHIFT), \
-	LINK_ENCODER_MASK_SH_LIST_DCN60_ON_DCN401(__SHIFT)
+	LINK_ENCODER_MASK_SH_LIST_DCN60_ON_DCN401(__SHIFT), \
+	LINK_ENCODER_PHY_STATE_MASK_SH_LIST_DCN401(__SHIFT)
 };
 
 static const struct dcn10_link_enc_mask le_mask = {
 	LINK_ENCODER_MASK_SH_LIST_DCN401(_MASK), \
-	LINK_ENCODER_MASK_SH_LIST_DCN60_ON_DCN401(_MASK)
+	LINK_ENCODER_MASK_SH_LIST_DCN60_ON_DCN401(_MASK), \
+	LINK_ENCODER_PHY_STATE_MASK_SH_LIST_DCN401(_MASK)
 };
 
 
-- 
2.43.0

