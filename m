Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6886F606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ETQAaNCe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 079A810F893;
	Tue, 27 Oct 2026 23:21:41 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013070.outbound.protection.outlook.com
 [40.93.196.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB57910F893
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gqri7cIZ8HfSbjKj/AsoRdMyKoXJaWi14VRrm5UDs83IuQBLOxwgIQJ9DlcMguvleZvOX5cyWvs8NM8WA70AFp6nd5XSi7gxmBk2D4pkCgAreHBJfu9WARWLHkJbYzFizpZwd3SdARVf3QbegcrQ3UoYBfHpYOyl6PgT2uSAQnojr7+H6sJDz5AlnH/pUu5wX2ohGEBiYG7QZF8TfK+iG1dT5TaE9g2JHZaw1VEY0GIcfnurju/+iWQoraY8Uxs4aTgVaMNsQDpOu4bN5uNWcc6xbGII8ucQq0RuxAzQ/4cEOI3Ed7uo56JlJKhqzHJQTgm4ldFLXf+LEsjPj137Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QvaNmKgsR7hRj1F99jTARw8DZKYNraqNHkgVUVTGus=;
 b=I/Tv+S0TtSfDjOtuwRRZZinBotHl3dLnLO8uy5FSmoGTjMsWVtzQI6/fGA223BxGScatturtbJzuCoe0QiM6B08aYaiO3AjujoNz3QxhiWB99EFIbk98s5EVqQuTqjvCb9p0HcFUyuTzVKN05ucY/j5WW+V/SX7biKmsyIoQGIgHXdAC1peS6sewPa40fRnnGpZthP1GKPwlR/nIXxtzqP4B9RJnOHFNdb25LeOQBrBTEljiygWvAOw426QiVZegzDhhq5WQbsfQrSOiUH0LNWYh3XhsmZWJYfga9jYlgZ9Bvb8+lgy9OIWMHxY3JWfYG6TMJJStmwMI+Fy5emsU6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QvaNmKgsR7hRj1F99jTARw8DZKYNraqNHkgVUVTGus=;
 b=ETQAaNCeRGyLbRUUYz1vSCJWZYYYDP8cZ992zo0A/nGdoNmgh6Uq1DiRX5w0jImS3oYZtTtmR3kc0d/Aebk+zYF/hibmvBO2Gn1YM3lfv1tDyRkk4bOzTVbkFl7m6irCrDZ+E4AKlneXwTmXWycpcLMn9MhqaRqTgIEmOtir7fU=
Received: from MN2PR01CA0041.prod.exchangelabs.com (2603:10b6:208:23f::10) by
 IA4PR12MB9764.namprd12.prod.outlook.com (2603:10b6:208:5d0::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Tue, 27 Oct 2026 23:21:31 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::56) by MN2PR01CA0041.outlook.office365.com
 (2603:10b6:208:23f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:21:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:21:30 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:21:28 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <toncheng@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 05/28] drm/amd/display: Remove DCN401 RDPCS PHY state reads
Date: Tue, 27 Oct 2026 17:17:01 -0600
Message-ID: <20261027232005.2879750-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|IA4PR12MB9764:EE_
X-MS-Office365-Filtering-Correlation-Id: 5141def6-1da3-4a9b-dd9e-08df3481085e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|261026121527099003|11063799006|56012099006|261021135927099003|261022075727099003|261021123027099003|261009223027099003|261022105027099003|261021121427099003|22082099003|18002099003|261026140227099003|3023799007;
X-Microsoft-Antispam-Message-Info: rgVdZsSiSIZGiMMhSNJV8W9qJKeU2Ae4mAv5janIsO8Sbi8MOUkWO2wZ5sGECw+NqMlRwNDNqRqS6up5rC48xWQN8LpkEzkfU3ljxLt5bLVDZSQvgB4XIr1++aimznaV5KaPlobXsi3x6+T6EjsKn0lMe/uI4ikfNclaQqd9hFj2UFSnRYh/GXGT+3tZtgaoNSs5bN1MKhafz+oQA4quCGKci5tT56lNDoZseVoKJ5QDMfC5kNk5E4hkwJ9v4N/ywHjA9cFk+srUHr4LoDkEEwP0CE16ehRdtACcwpkATDCDwW6NVolQ9IgrVo0F/cnIeDuLXTaqREgE2UUwshODw2xWaeaThYTFbomyLhnJiYfuvzW6eB0d0BqGXWg01pD4tTLIb2OjhXvgSWVnbqIwOZlDd9fkIyxpaPAZ/GFMcqj567bJ+6MNbhEU9Qh6V10dKvOJXdbH8WJygVwVnwc4OPH+IgS+DY8D1NwQwNYsOjvd6B3MUpvT1DBv7RJmMS79FzrQzYs6AH8D4y2cf6dGv5eBoIHIeWlCso6HvMh4z7zZXvpKL1dm01v++7oWpfguq+H59Ta0w9qmV+9bDqHQfkrTgyLdhKQDqfR0FxB4/yur0uDf1Q2ID8YA7gPxGfeyYAIb5eKpMOR1+XjGAuHDt8fiPcBaN/Hn2njVVygWbtL61rZw3SPmL9Isv2LvqtLwqpvOZZiWnPZbJtssCQWmDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(261026121527099003)(11063799006)(56012099006)(261021135927099003)(261022075727099003)(261021123027099003)(261009223027099003)(261022105027099003)(261021121427099003)(22082099003)(18002099003)(261026140227099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g6LMFOTchHP8BXZbWqoOI/wsRLeIHY5gToierKFX8+j0LHprK0z+Q3VvAgfues0BtsWdgYhq5DSIsVTVPmBazhXxzAUoM+lF2rKN9Dr3sjucJFYkeyJxOy9KCAHo5/oD11dRsntr/d6Gs0hLXxF42X9yhX/VesR8beir3YhsQ0sgorkYf83YYAf4qCh7zupWXXBrryPhvLRG1PkHYUZoQqx4Ie31K3lpuEChL89VfpeGhqq6ABxV4jDhZniDCfkjTHGMKcpOrTuDpevcfL26NDylGr348oGcwjSgH7RAxvZ/CC7U3eg7LZeyq5SxxRRfhSiZj8YytLJ9cpbM+je1OyQu/EV0A0DDX3AonRwT3pjzuWIpf3Gxc9PqAHNrhZ3HwhOShoBiPZwpdnG5VkJ0KWa236Av4Uxu2NqeHr/W5odgbuJsZ3WEpWz65oabRxSp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:21:30.5333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5141def6-1da3-4a9b-dd9e-08df3481085e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9764
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

From: Tony Cheng <toncheng@amd.com>

[WHAT]
DMCUB owns the PHY on DCN31+ and can gate its REFCLK. Reading RDPCS
while REFCLK is off can hang the register interface, and only firmware
knows the REFCLK state.

Revert the RDPCS reads added by commit 4b21ed5d08af ("drm/amd/display:
Read DCN401 PHY reset and lane enable state"): the RDPCSTX_PHY_CNTL0/3
register entries, the shift/mask list, dcn401_link_encoder_read_state()
and the link_enc_state fields. Drop the phy_on and phy_active columns
from the get_hw_state LINK section, which read them.

Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Tony Cheng <toncheng@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       | 16 +++-----------
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   | 22 +------------------
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h   |  8 -------
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  2 --
 .../dc/resource/dcn401/dcn401_resource.c      | 10 +++------
 5 files changed, 7 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index 37a010e0bd6e..395bccdd0f1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -524,7 +524,7 @@ static unsigned int dcn10_get_link_states(struct dc *dc, char *pBuf, unsigned in
 	unsigned int i;
 
 	chars_printed = snprintf_count(pBuf, remaining_buffer,
-		"link,enc,hpd,dig_en,dig_mode,dig_fe,src_otg,preferred_otg,phy_on,phy_active\n");
+		"link,enc,hpd,dig_en,dig_mode,dig_fe,src_otg,preferred_otg\n");
 	remaining_buffer -= chars_printed;
 	pBuf += chars_printed;
 
@@ -532,8 +532,6 @@ static unsigned int dcn10_get_link_states(struct dc *dc, char *pBuf, unsigned in
 		struct dc_link *link = dc->links[i];
 		struct link_encoder *enc = link ? link->link_enc : NULL;
 		int hpd = -1, dig_en = -1, dig_mode = -1, dig_fe = -1, src_otg = -1;
-		int phy_on = -1, phy_active = -1;
-		struct link_enc_state s = {0};
 
 		if (!enc || link->connector_signal == SIGNAL_TYPE_VIRTUAL)
 			continue;
@@ -548,19 +546,11 @@ static unsigned int dcn10_get_link_states(struct dc *dc, char *pBuf, unsigned in
 			dig_fe = enc->funcs->get_dig_frontend(enc);
 			src_otg = dcn10_dig_source_otg(dc, dig_fe);
 		}
-		s.rdpcs_phy_reset = HW_STATE_NOT_READ;
-		s.rdpcs_tx_data_en = HW_STATE_NOT_READ;
-		if (enc->funcs->read_state)
-			enc->funcs->read_state(enc, &s);
-		if (s.rdpcs_phy_reset != HW_STATE_NOT_READ)
-			phy_on = s.rdpcs_phy_reset == 0;
-		if (s.rdpcs_tx_data_en != HW_STATE_NOT_READ)
-			phy_active = s.rdpcs_tx_data_en != 0;
 
 		chars_printed = snprintf_count(pBuf, remaining_buffer,
-			"%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
+			"%d,%d,%d,%d,%d,%d,%d,%d\n",
 			i, enc->transmitter, hpd, dig_en, dig_mode, dig_fe,
-			src_otg, enc->preferred_engine, phy_on, phy_active);
+			src_otg, enc->preferred_engine);
 		remaining_buffer -= chars_printed;
 		pBuf += chars_printed;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c
index 4d62a5982632..6594fbb3fa43 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c
@@ -364,26 +364,6 @@ bool dcn401_is_dig_enabled(struct link_encoder *enc)
 	return (clk_enabled == 1 && dig_enabled == 1);
 }
 
-void dcn401_link_encoder_read_state(struct link_encoder *enc, struct link_enc_state *s)
-{
-	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	uint32_t tx0 = 0, tx1 = 0, tx2 = 0, tx3 = 0;
-
-	link_enc2_read_state(enc, s);
-
-	if (enc10->link_regs->RDPCSTX_PHY_CNTL0)
-		REG_GET(RDPCSTX_PHY_CNTL0, RDPCS_PHY_RESET, &s->rdpcs_phy_reset);
-
-	if (enc10->link_regs->RDPCSTX_PHY_CNTL3) {
-		REG_GET_4(RDPCSTX_PHY_CNTL3,
-			  RDPCS_PHY_DP_TX0_DATA_EN, &tx0,
-			  RDPCS_PHY_DP_TX1_DATA_EN, &tx1,
-			  RDPCS_PHY_DP_TX2_DATA_EN, &tx2,
-			  RDPCS_PHY_DP_TX3_DATA_EN, &tx3);
-		s->rdpcs_tx_data_en = tx0 | tx1 << 1 | tx2 << 2 | tx3 << 3;
-	}
-}
-
 enum signal_type dcn401_get_dig_mode(
 	struct link_encoder *enc)
 {
@@ -419,7 +399,7 @@ void dcn401_setup_ri_pj_check_in_sw_or_hw_mode(
 }
 
 static const struct link_encoder_funcs dcn401_link_enc_funcs = {
-	.read_state = dcn401_link_encoder_read_state,
+	.read_state = link_enc2_read_state,
 	.validate_output_with_stream =
 			dcn30_link_encoder_validate_output_with_stream,
 	.hw_init = enc401_hw_init,
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.h
index 689fc817dbc5..62f8f9098b53 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.h
@@ -28,13 +28,6 @@
 
 #include "dcn30/dcn30_dio_link_encoder.h"
 
-#define LINK_ENCODER_PHY_STATE_MASK_SH_LIST_DCN401(mask_sh) \
-	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_PHY_RESET, mask_sh),\
-	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_DATA_EN, mask_sh),\
-	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_DATA_EN, mask_sh),\
-	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_DATA_EN, mask_sh),\
-	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_DATA_EN, mask_sh)
-
 #define LINK_ENCODER_MASK_SH_LIST_DCN401(mask_sh) \
 	LE_SF(DIG0_DIG_BE_EN_CNTL, DIG_BE_ENABLE, mask_sh),\
 	LE_SF(DIG0_DIG_BE_CNTL, DIG_RB_SWITCH_EN, mask_sh),\
@@ -157,7 +150,6 @@ enum signal_type dcn401_get_dig_mode(
 	struct link_encoder *enc);
 
 bool dcn401_is_dig_enabled(struct link_encoder *enc);
-void dcn401_link_encoder_read_state(struct link_encoder *enc, struct link_enc_state *s);
 
 enum signal_type dcn401_get_dig_mode(struct link_encoder *enc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index 1c95d643af14..f3ef5bbfad81 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -117,8 +117,6 @@ struct link_enc_state {
 		uint32_t dphy_fec_ready_shadow;
 		uint32_t dphy_fec_active_status;
 		uint32_t dp_link_training_complete;
-		uint32_t rdpcs_phy_reset;
-		uint32_t rdpcs_tx_data_en;
 
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index acc5aa8d777f..34e218bff078 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -307,23 +307,19 @@ static struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[5];
 
 #define link_regs_init(id, phyid) \
 	LE_DCN401_REG_LIST_RI(id), \
-	LE_DCN60_REG_LIST_RI(id), \
-	SRI_ARR(RDPCSTX_PHY_CNTL0, RDPCSTX, id), \
-	SRI_ARR(RDPCSTX_PHY_CNTL3, RDPCSTX, id)
+	LE_DCN60_REG_LIST_RI(id)
 
 static struct dcn10_link_enc_registers link_enc_regs[4];
 
 
 static const struct dcn10_link_enc_shift le_shift = {
 	LINK_ENCODER_MASK_SH_LIST_DCN401(__SHIFT), \
-	LINK_ENCODER_MASK_SH_LIST_DCN60_ON_DCN401(__SHIFT), \
-	LINK_ENCODER_PHY_STATE_MASK_SH_LIST_DCN401(__SHIFT)
+	LINK_ENCODER_MASK_SH_LIST_DCN60_ON_DCN401(__SHIFT)
 };
 
 static const struct dcn10_link_enc_mask le_mask = {
 	LINK_ENCODER_MASK_SH_LIST_DCN401(_MASK), \
-	LINK_ENCODER_MASK_SH_LIST_DCN60_ON_DCN401(_MASK), \
-	LINK_ENCODER_PHY_STATE_MASK_SH_LIST_DCN401(_MASK)
+	LINK_ENCODER_MASK_SH_LIST_DCN60_ON_DCN401(_MASK)
 };
 
 
-- 
2.53.0

