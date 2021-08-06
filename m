Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6CBC4338F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3E8611C5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF3E8611C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2887C893A3;
	Fri,  6 Aug 2021 16:36:37 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2071.outbound.protection.outlook.com [40.107.96.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 686C76EC28
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 16:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbzEfvvzN1AlipBmJND3Ap3Pil0nRcQOgtyASQx2oXcyCa82tfvpr2p2ekWBXKP1cgRbd4F0qUBLY7L0Szg2EnppF6qUpEAZDObpbY9ka1pep6yuqQ9ln28tNyvbcEi0HopnVk65Pl9LYECjHkOqjp5AJx4DBsJYd0q2VnsaVB0cOtAC1xrFq0ZUvqBf05I41IQ5x5BJW1pUXz7ryD+D3WxdTpzvJ43hONjl5MyhjmIpOXiM1Prw0MHRW2EjSzONlXjw4jFxAKPV0FMmwFYOdUYMWL6FUPurucI6t+ltaO9+lUOE5taqW+0kTcKsOeOtmdY9hadawhGFKarzedBPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cejyJMye8FT0P1cBBJpE0M3bUP6ObuN73MOI4MezqZE=;
 b=KAWi5/s9fZzu2PA7d1I9w7TCWTlQLGZTrfik5Ghkk11YTY7zaH0LdrTpRXTnF7Pn9MqXLCCba9WcRP/wCCQ8mA4AnuDct7mHjh1xaweqDYbWRAaZG1KOpqltW5N5ooQ2SNAh5I7m+SJO19ojDibQPgAYWkHtCIXdly7MsRea0Ffkpe7Bv0yQPmFbpKCrfBOWCqCniCnBIzY8Mijw9P8KzHrc9s1O7C3mEOSOLuZkOCLhPJrspVwH9BOxo2+fK2QNWEA1BTyCXZN34A+I/LFNpdDaVTHo8BLLivNYKRe2iiPiXJxloF9GNnHeUVmUzs5wZUwaqr2wZpgFmNkHeeX7BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cejyJMye8FT0P1cBBJpE0M3bUP6ObuN73MOI4MezqZE=;
 b=lGNYWGtKKt8FNTgWbvBQdcFxvgOUjCg+7TpuUBLu5z56DDxfyGUnzCkmgqb5AQ9+/7avZKHrDwQInMqYDWHH58guVUm4PGVjak8bb/Gn1wg6iNOrf7xBPpRyBze/hmpHzWhklPXV7U2tjYNpCj4SDW0ZCJT92535vls0weWSiNw=
Received: from BN9PR03CA0645.namprd03.prod.outlook.com (2603:10b6:408:13b::20)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Fri, 6 Aug
 2021 16:35:53 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::5f) by BN9PR03CA0645.outlook.office365.com
 (2603:10b6:408:13b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Fri, 6 Aug 2021 16:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 16:35:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 11:35:48 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 6 Aug 2021 11:35:46 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <Eryk.Brol@amd.com>,
 <bindu.r@amd.com>, <Anson.Jacob@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 08/13] drm/amd/display: add authentication_complete in hdcp
 output
Date: Fri, 6 Aug 2021 12:34:44 -0400
Message-ID: <20210806163449.349757-9-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806163449.349757-1-Anson.Jacob@amd.com>
References: <20210806163449.349757-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c2b2305-92d3-4666-dc6e-08d958f841cf
X-MS-TrafficTypeDiagnostic: MN2PR12MB4318:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4318D3735B70B14321F4648FEBF39@MN2PR12MB4318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tqI/AORyO7R/5MzBAAThBpWc1k67qFeIetjFZfX+sxTTiTVa986liRfhga7L7Qvd3bufM1ibVojvrWhZPHYAvfTwW3hm5m2B1huEGWG89nEHCfyho8M6BOwAbw2Ng0GOEKYcWVbY1qBvrquke9Dj2T98UlQ2KVWZcSxug/HLjJq8VoOHKmQlxPZX1h/QyuynGZB6T5sO/ak5aDVIKToV0Gmy/dnblkYClvnWFlbOwy1sDR96BVrMUA51EQWNU+Mz1QnWTQ1EDs7RofHVDbGwTz0yQjxToMeGL794PBqjE7arlbNUGmHFc7IkrNgvdl4GEgd6FIUnZcckRtyyfVo4BBRniNJBWSFTlI6ixlrzq+3veZ/mlFTRvlF75DbU346l+jqrGWy+z3LMByAO80DFLFvcmY54YeRuDGYcwZ7WSdH7F+d1TtNZGHHUJMrScZbz+iOMXj/jo+PkK/Ve0aMqgISzJcI03TuI2hn8Jygrz13RjKjZYfHdI5JgHR3HDQhrC+k8XoN/XjL4c9dRnag3+tVBeilEuBpRD/TW2CiqgISj6b72JtQcAQDWRwL7D4S6KGg/5T8NjLXMPH7pfvGm/DoDqUSqisxFeuQE3mdW+TSdNBQ8Hs2VaV6o4QXbjQOLvcQlFlElCkYT6hBm3NHTeYPKvkVLAOYZl5ddEp6/8VjySlwV+UefCe5y2Im6kClLBIMV20IWIWvCilKsQY++KeNh4vV9bXUyIq3BAI6+Q7g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966006)(36840700001)(2906002)(478600001)(356005)(186003)(2616005)(83380400001)(426003)(336012)(36860700001)(54906003)(7696005)(86362001)(82310400003)(6916009)(1076003)(30864003)(70586007)(36756003)(4326008)(70206006)(8676002)(26005)(316002)(47076005)(82740400003)(5660300002)(8936002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 16:35:52.8481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2b2305-92d3-4666-dc6e-08d958f841cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
DM needs to be notified when hdcp module has completed
authentication attempt.

Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  5 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |  8 ++
 .../display/modules/hdcp/hdcp1_transition.c   |  8 +-
 .../display/modules/hdcp/hdcp2_transition.c   |  4 +-
 .../drm/amd/display/modules/hdcp/hdcp_log.c   | 74 +++++++++++++++++++
 .../drm/amd/display/modules/hdcp/hdcp_log.h   | 72 ------------------
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  1 +
 7 files changed, 93 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index 06d60f031a06..3e81850a7ffe 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -145,6 +145,7 @@ static enum mod_hdcp_status transition(struct mod_hdcp *hdcp,
 			} else {
 				callback_in_ms(0, output);
 				set_state_id(hdcp, output, HDCP_CP_NOT_DESIRED);
+				set_auth_complete(hdcp, output);
 			}
 		else if (is_hdmi_dvi_sl_hdcp(hdcp))
 			if (is_cp_desired_hdcp2(hdcp)) {
@@ -156,10 +157,12 @@ static enum mod_hdcp_status transition(struct mod_hdcp *hdcp,
 			} else {
 				callback_in_ms(0, output);
 				set_state_id(hdcp, output, HDCP_CP_NOT_DESIRED);
+				set_auth_complete(hdcp, output);
 			}
 		else {
 			callback_in_ms(0, output);
 			set_state_id(hdcp, output, HDCP_CP_NOT_DESIRED);
+			set_auth_complete(hdcp, output);
 		}
 	} else if (is_in_cp_not_desired_state(hdcp)) {
 		increment_stay_counter(hdcp);
@@ -520,7 +523,7 @@ enum mod_hdcp_status mod_hdcp_process_event(struct mod_hdcp *hdcp,
 
 	/* reset authentication if needed */
 	if (trans_status == MOD_HDCP_STATUS_RESET_NEEDED) {
-		HDCP_FULL_DDC_TRACE(hdcp);
+		mod_hdcp_log_ddc_trace(hdcp);
 		reset_status = reset_authentication(hdcp, output);
 		if (reset_status != MOD_HDCP_STATUS_SUCCESS)
 			push_error_status(hdcp, reset_status);
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index 7123f0915706..399fbca8947b 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -324,6 +324,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_dp_transition(struct mod_hdcp *hdcp,
 /* log functions */
 void mod_hdcp_dump_binary_message(uint8_t *msg, uint32_t msg_size,
 		uint8_t *buf, uint32_t buf_size);
+void mod_hdcp_log_ddc_trace(struct mod_hdcp *hdcp);
 /* TODO: add adjustment log */
 
 /* psp functions */
@@ -494,6 +495,13 @@ static inline void set_watchdog_in_ms(struct mod_hdcp *hdcp, uint16_t time,
 	output->watchdog_timer_delay = time;
 }
 
+static inline void set_auth_complete(struct mod_hdcp *hdcp,
+		struct mod_hdcp_output *output)
+{
+	output->auth_complete = 1;
+	mod_hdcp_log_ddc_trace(hdcp);
+}
+
 /* connection topology helpers */
 static inline uint8_t is_display_active(struct mod_hdcp_display *display)
 {
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
index 3dda8c1d83fc..7f011196ce98 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
@@ -89,7 +89,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_transition(struct mod_hdcp *hdcp,
 		} else {
 			callback_in_ms(0, output);
 			set_state_id(hdcp, output, H1_A45_AUTHENTICATED);
-			HDCP_FULL_DDC_TRACE(hdcp);
+			set_auth_complete(hdcp, output);
 		}
 		break;
 	case H1_A45_AUTHENTICATED:
@@ -137,7 +137,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_transition(struct mod_hdcp *hdcp,
 		}
 		callback_in_ms(0, output);
 		set_state_id(hdcp, output, H1_A45_AUTHENTICATED);
-		HDCP_FULL_DDC_TRACE(hdcp);
+		set_auth_complete(hdcp, output);
 		break;
 	default:
 		status = MOD_HDCP_STATUS_INVALID_STATE;
@@ -239,7 +239,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dp_transition(struct mod_hdcp *hdcp,
 			set_state_id(hdcp, output, D1_A6_WAIT_FOR_READY);
 		} else {
 			set_state_id(hdcp, output, D1_A4_AUTHENTICATED);
-			HDCP_FULL_DDC_TRACE(hdcp);
+			set_auth_complete(hdcp, output);
 		}
 		break;
 	case D1_A4_AUTHENTICATED:
@@ -311,7 +311,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dp_transition(struct mod_hdcp *hdcp,
 			break;
 		}
 		set_state_id(hdcp, output, D1_A4_AUTHENTICATED);
-		HDCP_FULL_DDC_TRACE(hdcp);
+		set_auth_complete(hdcp, output);
 		break;
 	default:
 		fail_and_restart_in_ms(0, &status, output);
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
index 70cb230d8f56..1f4095b26409 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
@@ -242,7 +242,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_transition(struct mod_hdcp *hdcp,
 		}
 		callback_in_ms(0, output);
 		set_state_id(hdcp, output, H2_A5_AUTHENTICATED);
-		HDCP_FULL_DDC_TRACE(hdcp);
+		set_auth_complete(hdcp, output);
 		break;
 	case H2_A5_AUTHENTICATED:
 		if (input->rxstatus_read == FAIL ||
@@ -559,7 +559,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_dp_transition(struct mod_hdcp *hdcp,
 			break;
 		}
 		set_state_id(hdcp, output, D2_A5_AUTHENTICATED);
-		HDCP_FULL_DDC_TRACE(hdcp);
+		set_auth_complete(hdcp, output);
 		break;
 	case D2_A5_AUTHENTICATED:
 		if (input->rxstatus_read == FAIL ||
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
index 1a0f7c3dc964..6b3b5f610907 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
@@ -51,6 +51,80 @@ void mod_hdcp_dump_binary_message(uint8_t *msg, uint32_t msg_size,
 	}
 }
 
+void mod_hdcp_log_ddc_trace(struct mod_hdcp *hdcp)
+{
+	if (is_hdcp1(hdcp)) {
+		HDCP_DDC_READ_TRACE(hdcp, "BKSV", hdcp->auth.msg.hdcp1.bksv,
+				sizeof(hdcp->auth.msg.hdcp1.bksv));
+		HDCP_DDC_READ_TRACE(hdcp, "BCAPS", &hdcp->auth.msg.hdcp1.bcaps,
+				sizeof(hdcp->auth.msg.hdcp1.bcaps));
+		HDCP_DDC_READ_TRACE(hdcp, "BSTATUS",
+				(uint8_t *)&hdcp->auth.msg.hdcp1.bstatus,
+				sizeof(hdcp->auth.msg.hdcp1.bstatus));
+		HDCP_DDC_WRITE_TRACE(hdcp, "AN", hdcp->auth.msg.hdcp1.an,
+				sizeof(hdcp->auth.msg.hdcp1.an));
+		HDCP_DDC_WRITE_TRACE(hdcp, "AKSV", hdcp->auth.msg.hdcp1.aksv,
+				sizeof(hdcp->auth.msg.hdcp1.aksv));
+		HDCP_DDC_WRITE_TRACE(hdcp, "AINFO", &hdcp->auth.msg.hdcp1.ainfo,
+				sizeof(hdcp->auth.msg.hdcp1.ainfo));
+		HDCP_DDC_READ_TRACE(hdcp, "RI' / R0'",
+				(uint8_t *)&hdcp->auth.msg.hdcp1.r0p,
+				sizeof(hdcp->auth.msg.hdcp1.r0p));
+		HDCP_DDC_READ_TRACE(hdcp, "BINFO",
+				(uint8_t *)&hdcp->auth.msg.hdcp1.binfo_dp,
+				sizeof(hdcp->auth.msg.hdcp1.binfo_dp));
+		HDCP_DDC_READ_TRACE(hdcp, "KSVLIST", hdcp->auth.msg.hdcp1.ksvlist,
+				hdcp->auth.msg.hdcp1.ksvlist_size);
+		HDCP_DDC_READ_TRACE(hdcp, "V'", hdcp->auth.msg.hdcp1.vp,
+				sizeof(hdcp->auth.msg.hdcp1.vp));
+	} else if (is_hdcp2(hdcp)) {
+		HDCP_DDC_READ_TRACE(hdcp, "HDCP2Version",
+				&hdcp->auth.msg.hdcp2.hdcp2version_hdmi,
+				sizeof(hdcp->auth.msg.hdcp2.hdcp2version_hdmi));
+		HDCP_DDC_READ_TRACE(hdcp, "Rx Caps", hdcp->auth.msg.hdcp2.rxcaps_dp,
+				sizeof(hdcp->auth.msg.hdcp2.rxcaps_dp));
+		HDCP_DDC_WRITE_TRACE(hdcp, "AKE Init", hdcp->auth.msg.hdcp2.ake_init,
+				sizeof(hdcp->auth.msg.hdcp2.ake_init));
+		HDCP_DDC_READ_TRACE(hdcp, "AKE Cert", hdcp->auth.msg.hdcp2.ake_cert,
+				sizeof(hdcp->auth.msg.hdcp2.ake_cert));
+		HDCP_DDC_WRITE_TRACE(hdcp, "Stored KM",
+				hdcp->auth.msg.hdcp2.ake_stored_km,
+				sizeof(hdcp->auth.msg.hdcp2.ake_stored_km));
+		HDCP_DDC_WRITE_TRACE(hdcp, "No Stored KM",
+				hdcp->auth.msg.hdcp2.ake_no_stored_km,
+				sizeof(hdcp->auth.msg.hdcp2.ake_no_stored_km));
+		HDCP_DDC_READ_TRACE(hdcp, "H'", hdcp->auth.msg.hdcp2.ake_h_prime,
+				sizeof(hdcp->auth.msg.hdcp2.ake_h_prime));
+		HDCP_DDC_READ_TRACE(hdcp, "Pairing Info",
+				hdcp->auth.msg.hdcp2.ake_pairing_info,
+				sizeof(hdcp->auth.msg.hdcp2.ake_pairing_info));
+		HDCP_DDC_WRITE_TRACE(hdcp, "LC Init", hdcp->auth.msg.hdcp2.lc_init,
+				sizeof(hdcp->auth.msg.hdcp2.lc_init));
+		HDCP_DDC_READ_TRACE(hdcp, "L'", hdcp->auth.msg.hdcp2.lc_l_prime,
+				sizeof(hdcp->auth.msg.hdcp2.lc_l_prime));
+		HDCP_DDC_WRITE_TRACE(hdcp, "Exchange KS", hdcp->auth.msg.hdcp2.ske_eks,
+				sizeof(hdcp->auth.msg.hdcp2.ske_eks));
+		HDCP_DDC_READ_TRACE(hdcp, "Rx Status",
+				(uint8_t *)&hdcp->auth.msg.hdcp2.rxstatus,
+				sizeof(hdcp->auth.msg.hdcp2.rxstatus));
+		HDCP_DDC_READ_TRACE(hdcp, "Rx Id List",
+				hdcp->auth.msg.hdcp2.rx_id_list,
+				hdcp->auth.msg.hdcp2.rx_id_list_size);
+		HDCP_DDC_WRITE_TRACE(hdcp, "Rx Id List Ack",
+				hdcp->auth.msg.hdcp2.repeater_auth_ack,
+				sizeof(hdcp->auth.msg.hdcp2.repeater_auth_ack));
+		HDCP_DDC_WRITE_TRACE(hdcp, "Content Stream Management",
+				hdcp->auth.msg.hdcp2.repeater_auth_stream_manage,
+				hdcp->auth.msg.hdcp2.stream_manage_size);
+		HDCP_DDC_READ_TRACE(hdcp, "Stream Ready",
+				hdcp->auth.msg.hdcp2.repeater_auth_stream_ready,
+				sizeof(hdcp->auth.msg.hdcp2.repeater_auth_stream_ready));
+		HDCP_DDC_WRITE_TRACE(hdcp, "Content Stream Type",
+				hdcp->auth.msg.hdcp2.content_stream_type_dp,
+				sizeof(hdcp->auth.msg.hdcp2.content_stream_type_dp));
+	}
+}
+
 char *mod_hdcp_status_to_str(int32_t status)
 {
 	switch (status) {
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
index 47f8ee2832ff..eb6f9b9c504a 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
@@ -106,78 +106,6 @@
 				hdcp->config.index, msg_name,\
 				hdcp->buf); \
 } while (0)
-#define HDCP_FULL_DDC_TRACE(hdcp) do { \
-	if (is_hdcp1(hdcp)) { \
-		HDCP_DDC_READ_TRACE(hdcp, "BKSV", hdcp->auth.msg.hdcp1.bksv, \
-				sizeof(hdcp->auth.msg.hdcp1.bksv)); \
-		HDCP_DDC_READ_TRACE(hdcp, "BCAPS", &hdcp->auth.msg.hdcp1.bcaps, \
-				sizeof(hdcp->auth.msg.hdcp1.bcaps)); \
-		HDCP_DDC_READ_TRACE(hdcp, "BSTATUS", \
-				(uint8_t *)&hdcp->auth.msg.hdcp1.bstatus, \
-				sizeof(hdcp->auth.msg.hdcp1.bstatus)); \
-		HDCP_DDC_WRITE_TRACE(hdcp, "AN", hdcp->auth.msg.hdcp1.an, \
-				sizeof(hdcp->auth.msg.hdcp1.an)); \
-		HDCP_DDC_WRITE_TRACE(hdcp, "AKSV", hdcp->auth.msg.hdcp1.aksv, \
-				sizeof(hdcp->auth.msg.hdcp1.aksv)); \
-		HDCP_DDC_WRITE_TRACE(hdcp, "AINFO", &hdcp->auth.msg.hdcp1.ainfo, \
-				sizeof(hdcp->auth.msg.hdcp1.ainfo)); \
-		HDCP_DDC_READ_TRACE(hdcp, "RI' / R0'", \
-				(uint8_t *)&hdcp->auth.msg.hdcp1.r0p, \
-				sizeof(hdcp->auth.msg.hdcp1.r0p)); \
-		HDCP_DDC_READ_TRACE(hdcp, "BINFO", \
-				(uint8_t *)&hdcp->auth.msg.hdcp1.binfo_dp, \
-				sizeof(hdcp->auth.msg.hdcp1.binfo_dp)); \
-		HDCP_DDC_READ_TRACE(hdcp, "KSVLIST", hdcp->auth.msg.hdcp1.ksvlist, \
-				hdcp->auth.msg.hdcp1.ksvlist_size); \
-		HDCP_DDC_READ_TRACE(hdcp, "V'", hdcp->auth.msg.hdcp1.vp, \
-				sizeof(hdcp->auth.msg.hdcp1.vp)); \
-	} else { \
-		HDCP_DDC_READ_TRACE(hdcp, "HDCP2Version", \
-				&hdcp->auth.msg.hdcp2.hdcp2version_hdmi, \
-				sizeof(hdcp->auth.msg.hdcp2.hdcp2version_hdmi)); \
-		HDCP_DDC_READ_TRACE(hdcp, "Rx Caps", hdcp->auth.msg.hdcp2.rxcaps_dp, \
-				sizeof(hdcp->auth.msg.hdcp2.rxcaps_dp)); \
-		HDCP_DDC_WRITE_TRACE(hdcp, "AKE Init", hdcp->auth.msg.hdcp2.ake_init, \
-				sizeof(hdcp->auth.msg.hdcp2.ake_init)); \
-		HDCP_DDC_READ_TRACE(hdcp, "AKE Cert", hdcp->auth.msg.hdcp2.ake_cert, \
-				sizeof(hdcp->auth.msg.hdcp2.ake_cert)); \
-		HDCP_DDC_WRITE_TRACE(hdcp, "Stored KM", \
-				hdcp->auth.msg.hdcp2.ake_stored_km, \
-				sizeof(hdcp->auth.msg.hdcp2.ake_stored_km)); \
-		HDCP_DDC_WRITE_TRACE(hdcp, "No Stored KM", \
-				hdcp->auth.msg.hdcp2.ake_no_stored_km, \
-				sizeof(hdcp->auth.msg.hdcp2.ake_no_stored_km)); \
-		HDCP_DDC_READ_TRACE(hdcp, "H'", hdcp->auth.msg.hdcp2.ake_h_prime, \
-				sizeof(hdcp->auth.msg.hdcp2.ake_h_prime)); \
-		HDCP_DDC_READ_TRACE(hdcp, "Pairing Info", \
-				hdcp->auth.msg.hdcp2.ake_pairing_info, \
-				sizeof(hdcp->auth.msg.hdcp2.ake_pairing_info)); \
-		HDCP_DDC_WRITE_TRACE(hdcp, "LC Init", hdcp->auth.msg.hdcp2.lc_init, \
-				sizeof(hdcp->auth.msg.hdcp2.lc_init)); \
-		HDCP_DDC_READ_TRACE(hdcp, "L'", hdcp->auth.msg.hdcp2.lc_l_prime, \
-				sizeof(hdcp->auth.msg.hdcp2.lc_l_prime)); \
-		HDCP_DDC_WRITE_TRACE(hdcp, "Exchange KS", hdcp->auth.msg.hdcp2.ske_eks, \
-				sizeof(hdcp->auth.msg.hdcp2.ske_eks)); \
-		HDCP_DDC_READ_TRACE(hdcp, "Rx Status", \
-				(uint8_t *)&hdcp->auth.msg.hdcp2.rxstatus, \
-				sizeof(hdcp->auth.msg.hdcp2.rxstatus)); \
-		HDCP_DDC_READ_TRACE(hdcp, "Rx Id List", \
-				hdcp->auth.msg.hdcp2.rx_id_list, \
-				hdcp->auth.msg.hdcp2.rx_id_list_size); \
-		HDCP_DDC_WRITE_TRACE(hdcp, "Rx Id List Ack", \
-				hdcp->auth.msg.hdcp2.repeater_auth_ack, \
-				sizeof(hdcp->auth.msg.hdcp2.repeater_auth_ack)); \
-		HDCP_DDC_WRITE_TRACE(hdcp, "Content Stream Management", \
-				hdcp->auth.msg.hdcp2.repeater_auth_stream_manage, \
-				hdcp->auth.msg.hdcp2.stream_manage_size); \
-		HDCP_DDC_READ_TRACE(hdcp, "Stream Ready", \
-				hdcp->auth.msg.hdcp2.repeater_auth_stream_ready, \
-				sizeof(hdcp->auth.msg.hdcp2.repeater_auth_stream_ready)); \
-		HDCP_DDC_WRITE_TRACE(hdcp, "Content Stream Type", \
-				hdcp->auth.msg.hdcp2.content_stream_type_dp, \
-				sizeof(hdcp->auth.msg.hdcp2.content_stream_type_dp)); \
-	} \
-} while (0)
 #define HDCP_TOP_ADD_DISPLAY_TRACE(hdcp, i) \
 		HDCP_LOG_TOP(hdcp, "[Link %d]\tadd display %d", \
 				hdcp->config.index, i)
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index a6eb86de8d5c..f37101f5a777 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -225,6 +225,7 @@ struct mod_hdcp_output {
 	uint8_t watchdog_timer_stop;
 	uint16_t callback_delay;
 	uint16_t watchdog_timer_delay;
+	uint8_t auth_complete;
 };
 
 /* used to represent per display info */
-- 
2.25.1

