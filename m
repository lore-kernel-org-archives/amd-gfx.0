Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59131C35656
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB692067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iCFjwVPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB692067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC7986F4C2;
	Fri, 21 Feb 2020 16:04:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F1F36F4AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcmzLTJ8gFJJNLCw7+QDMLnGVFurXbIrGxyQQL680gqTMSaEkYj1TMLzpjuK9JO9kBceHWBROWFXJC8j5iZ0Z2NYDagv9t6igWlrPpcnAIGzVR81piThzWr/on1g1Z44zfrDLc6MDtB+8nhiaYb+wzXkITtDSoASh6kdRwKgXnhXmrZhHSWQksaeIoBNCWXUtYG7pg8cBRG63iPLr/36uMcMTtSwFER6qcv/EVbDEehK3/RRlECb12fx9eh2j5XWZpHfl4gJ7hNSzbBKuJxRD7yAWKU9NkzBX5WkIY1C/fZGs+sDHpXVbmVoFfNh31iVhPZYFTOefNeqHawv0cjshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znLCXCqOiUVF0CI7HNBXonSarMXkGJ3a8+mZs6htnnk=;
 b=famWDB2jtLdvl6anXQEuJHXIIJP0i9FUtLxVDsw9JRqGQ6rjL/ScohZGwNyKAGQXRrI8xmwS4iWnVwXStx8b4m3V31X9oInpLNrkYzhtbK1caTQvwRqJsDQyAgGSpwla4uD1iVLw/4mFenhfnwE8dTT6tEOQr98EqyT/BLxshVKzXwVrmlgjBqugDKM3gY4Mt1vVBArFUF369KasF46mVF1FhxH/fycXtKswn+qH1owq+j+JrJih5X+l2DXzrHMEv//Qbtsdwoz/0W+HZ07PJjPFByIV1XSqJI13DLf8Rx7iA94NU5/WRSN1oprKF3rYdXV4kT14xplYkZaWcvrACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znLCXCqOiUVF0CI7HNBXonSarMXkGJ3a8+mZs6htnnk=;
 b=iCFjwVPc4zp1TeKzSnHINbZhdtrr7mt/BPv0xZW1ERXKSJ5shlTyorzL2R2NrLU1+BV93n1zksjzpCExtK+YedUjn2HOrRbe4GD1dUAB1YPWZdV1UFfb/mLwtmLjjPzRgWe9ENFx8HEmWs85r63lXRNXZD1gyEqRMOYeDW13mAw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:47 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:47 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 31/35] drm/amd/display: optimize prgoram wm and clks
Date: Fri, 21 Feb 2020 11:03:20 -0500
Message-Id: <20200221160324.2969975-32-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:04:13 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 20525ea1-7a87-4f53-c81b-08d7b6e7b219
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB257233A4FD39C5F56394479098120@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(36756003)(2906002)(8936002)(86362001)(30864003)(8676002)(6486002)(81156014)(81166006)(7696005)(52116002)(4326008)(6666004)(316002)(186003)(26005)(6916009)(16526019)(54906003)(2616005)(66476007)(66556008)(66946007)(956004)(478600001)(579004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rcjMyY//UnyPqW/mBnQUJf86/fYCefFVy8/BeklPlfuF7NmjK/zJK+mVCyYBri6F/INYbOs/MXiRJyJbwa11tBlBjy4zbkqKSIIZVRuiV/XVJxTtUVFroz0N3XYoMjru/1K5m4StPaoTvrdPKSgkDWURVPbGmpnGxc6SoYg2kAtP+G+9SWQKRfTRslWv6VRJathw9WYstMZtjcOpnuNKOiVc+POUJWTy5/wGNORiQjnbJH2xSoJtn3Bn9+1ukVCzer3L21RCfToGWHHqisoOqSHe1uF5S7nDpdeOTSq5B8I45cDIejg9JB77IT3Cv+jchpJC67QD4ele0pD2a9VeMcooMkvVaWgpMZJATECov2QSMtkmb0nbM20dRBc2e/ujG75W6C1AmGyg8UUW/fxTbbYO8TQdGyiIqbx81gyfKliEEI+0radpN+C/qc8Zq8XL
X-MS-Exchange-AntiSpam-MessageData: 5StlepVp7uBNwXBCoLA7lXQcxakg/aTceJdBX5CCqSIHEgHF+5g7hsWa67FOy+XZkTCRdb5TbM0C55kEXcrPOvGkwBea+5v5YU/GEqZLHyh5nem3EbhBbkWwOEbzTj8iIsPljqPzpYx+sfOEkSi4uA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20525ea1-7a87-4f53-c81b-08d7b6e7b219
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:13.9858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2IvNduGSvaMDJuyyScal7poL5Ju1NshC0Fo8arAOlEyimsx26gz4cP0nx/oN2xupxZjUNdIHh6HmMfcbKQq9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
 Harry Wentland <harry.wentland@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
In some display configuration like 1080P monitor playing a 1080P video,
if user use ALT+F4 to exit Movie and TV, there is a chance clocks are
same only water mark changed. Current clock optimization machanism will
result in water mark keeps high after exit Movie and TV app.

[How]
Return if watermark need to be optimized when doing program watermark,
perform the optimization after.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  10 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.c   | 101 +++++++++----
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   |   8 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  33 +++--
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.c   |  11 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  26 ++--
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   | 137 +++++++++++++-----
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.h   |   8 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   2 +-
 10 files changed, 237 insertions(+), 102 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7513aa71da38..6dece1ee30bf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1365,7 +1365,7 @@ bool dc_post_update_surfaces_to_stream(struct dc *dc)
 	int i;
 	struct dc_state *context = dc->current_state;
 
-	if (!dc->optimized_required || dc->optimize_seamless_boot_streams > 0)
+	if ((!dc->clk_optimized_required && !dc->wm_optimized_required) || dc->optimize_seamless_boot_streams > 0)
 		return true;
 
 	post_surface_trace(dc);
@@ -1377,8 +1377,6 @@ bool dc_post_update_surfaces_to_stream(struct dc *dc)
 			dc->hwss.disable_plane(dc, &context->res_ctx.pipe_ctx[i]);
 		}
 
-	dc->optimized_required = false;
-
 	dc->hwss.optimize_bandwidth(dc, context);
 	return true;
 }
@@ -1826,10 +1824,10 @@ enum surface_update_type dc_check_update_surfaces_for_stream(
 		// If there's an available clock comparator, we use that.
 		if (dc->clk_mgr->funcs->are_clock_states_equal) {
 			if (!dc->clk_mgr->funcs->are_clock_states_equal(&dc->clk_mgr->clks, &dc->current_state->bw_ctx.bw.dcn.clk))
-				dc->optimized_required = true;
+				dc->clk_optimized_required = true;
 		// Else we fallback to mem compare.
 		} else if (memcmp(&dc->current_state->bw_ctx.bw.dcn.clk, &dc->clk_mgr->clks, offsetof(struct dc_clocks, prev_p_state_change_support)) != 0) {
-			dc->optimized_required = true;
+			dc->clk_optimized_required = true;
 		}
 	}
 
@@ -2200,7 +2198,7 @@ static void commit_planes_for_stream(struct dc *dc,
 			dc->optimize_seamless_boot_streams--;
 
 			if (dc->optimize_seamless_boot_streams == 0)
-				dc->optimized_required = true;
+				dc->clk_optimized_required = true;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e10d5a7d0cb8..bc1220dce3b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -520,7 +520,8 @@ struct dc {
 	struct dce_hwseq *hwseq;
 
 	/* Require to optimize clocks and bandwidth for added/removed planes */
-	bool optimized_required;
+	bool clk_optimized_required;
+	bool wm_optimized_required;
 
 	/* Require to maintain clocks and bandwidth for UEFI enabled HW */
 	int optimize_seamless_boot_streams;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
index 3e851713cf8d..e441c149ff40 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
@@ -243,7 +243,7 @@ void hubbub1_wm_change_req_wa(struct hubbub *hubbub)
 			DCHUBBUB_ARB_WATERMARK_CHANGE_REQUEST, 1);
 }
 
-void hubbub1_program_urgent_watermarks(
+bool hubbub1_program_urgent_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
@@ -251,6 +251,7 @@ void hubbub1_program_urgent_watermarks(
 {
 	struct dcn10_hubbub *hubbub1 = TO_DCN10_HUBBUB(hubbub);
 	uint32_t prog_wm_value;
+	bool wm_pending = false;
 
 	/* Repeat for water mark set A, B, C and D. */
 	/* clock state A */
@@ -264,7 +265,8 @@ void hubbub1_program_urgent_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("URGENCY_WATERMARK_A calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->a.urgent_ns, prog_wm_value);
-	}
+	} else if (watermarks->a.urgent_ns < hubbub1->watermarks.a.urgent_ns)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->a.pte_meta_urgent_ns > hubbub1->watermarks.a.pte_meta_urgent_ns) {
 		hubbub1->watermarks.a.pte_meta_urgent_ns = watermarks->a.pte_meta_urgent_ns;
@@ -274,7 +276,8 @@ void hubbub1_program_urgent_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("PTE_META_URGENCY_WATERMARK_A calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->a.pte_meta_urgent_ns, prog_wm_value);
-	}
+	} else if (watermarks->a.pte_meta_urgent_ns < hubbub1->watermarks.a.pte_meta_urgent_ns)
+		wm_pending = true;
 
 	/* clock state B */
 	if (safe_to_lower || watermarks->b.urgent_ns > hubbub1->watermarks.b.urgent_ns) {
@@ -287,7 +290,8 @@ void hubbub1_program_urgent_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("URGENCY_WATERMARK_B calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->b.urgent_ns, prog_wm_value);
-	}
+	} else if (watermarks->b.urgent_ns < hubbub1->watermarks.b.urgent_ns)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->b.pte_meta_urgent_ns > hubbub1->watermarks.b.pte_meta_urgent_ns) {
 		hubbub1->watermarks.b.pte_meta_urgent_ns = watermarks->b.pte_meta_urgent_ns;
@@ -297,7 +301,8 @@ void hubbub1_program_urgent_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("PTE_META_URGENCY_WATERMARK_B calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->b.pte_meta_urgent_ns, prog_wm_value);
-	}
+	} else if (watermarks->b.pte_meta_urgent_ns < hubbub1->watermarks.b.pte_meta_urgent_ns)
+		wm_pending = true;
 
 	/* clock state C */
 	if (safe_to_lower || watermarks->c.urgent_ns > hubbub1->watermarks.c.urgent_ns) {
@@ -310,7 +315,8 @@ void hubbub1_program_urgent_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("URGENCY_WATERMARK_C calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->c.urgent_ns, prog_wm_value);
-	}
+	} else if (watermarks->c.urgent_ns < hubbub1->watermarks.c.urgent_ns)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->c.pte_meta_urgent_ns > hubbub1->watermarks.c.pte_meta_urgent_ns) {
 		hubbub1->watermarks.c.pte_meta_urgent_ns = watermarks->c.pte_meta_urgent_ns;
@@ -320,7 +326,8 @@ void hubbub1_program_urgent_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("PTE_META_URGENCY_WATERMARK_C calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->c.pte_meta_urgent_ns, prog_wm_value);
-	}
+	} else if (watermarks->c.pte_meta_urgent_ns < hubbub1->watermarks.c.pte_meta_urgent_ns)
+		wm_pending = true;
 
 	/* clock state D */
 	if (safe_to_lower || watermarks->d.urgent_ns > hubbub1->watermarks.d.urgent_ns) {
@@ -333,7 +340,8 @@ void hubbub1_program_urgent_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("URGENCY_WATERMARK_D calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->d.urgent_ns, prog_wm_value);
-	}
+	} else if (watermarks->d.urgent_ns < hubbub1->watermarks.d.urgent_ns)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->d.pte_meta_urgent_ns > hubbub1->watermarks.d.pte_meta_urgent_ns) {
 		hubbub1->watermarks.d.pte_meta_urgent_ns = watermarks->d.pte_meta_urgent_ns;
@@ -343,10 +351,13 @@ void hubbub1_program_urgent_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("PTE_META_URGENCY_WATERMARK_D calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->d.pte_meta_urgent_ns, prog_wm_value);
-	}
+	} else if (watermarks->d.pte_meta_urgent_ns < hubbub1->watermarks.d.pte_meta_urgent_ns)
+		wm_pending = true;
+
+	return wm_pending;
 }
 
-void hubbub1_program_stutter_watermarks(
+bool hubbub1_program_stutter_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
@@ -354,6 +365,7 @@ void hubbub1_program_stutter_watermarks(
 {
 	struct dcn10_hubbub *hubbub1 = TO_DCN10_HUBBUB(hubbub);
 	uint32_t prog_wm_value;
+	bool wm_pending = false;
 
 	/* clock state A */
 	if (safe_to_lower || watermarks->a.cstate_pstate.cstate_enter_plus_exit_ns
@@ -368,7 +380,9 @@ void hubbub1_program_stutter_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_EXIT_WATERMARK_A calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->a.cstate_pstate.cstate_enter_plus_exit_ns, prog_wm_value);
-	}
+	} else if (watermarks->a.cstate_pstate.cstate_enter_plus_exit_ns
+			< hubbub1->watermarks.a.cstate_pstate.cstate_enter_plus_exit_ns)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->a.cstate_pstate.cstate_exit_ns
 			> hubbub1->watermarks.a.cstate_pstate.cstate_exit_ns) {
@@ -382,7 +396,9 @@ void hubbub1_program_stutter_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_A calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->a.cstate_pstate.cstate_exit_ns, prog_wm_value);
-	}
+	} else if (watermarks->a.cstate_pstate.cstate_exit_ns
+			< hubbub1->watermarks.a.cstate_pstate.cstate_exit_ns)
+		wm_pending = true;
 
 	/* clock state B */
 	if (safe_to_lower || watermarks->b.cstate_pstate.cstate_enter_plus_exit_ns
@@ -397,7 +413,9 @@ void hubbub1_program_stutter_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_EXIT_WATERMARK_B calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->b.cstate_pstate.cstate_enter_plus_exit_ns, prog_wm_value);
-	}
+	} else if (watermarks->b.cstate_pstate.cstate_enter_plus_exit_ns
+			< hubbub1->watermarks.b.cstate_pstate.cstate_enter_plus_exit_ns)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->b.cstate_pstate.cstate_exit_ns
 			> hubbub1->watermarks.b.cstate_pstate.cstate_exit_ns) {
@@ -411,7 +429,9 @@ void hubbub1_program_stutter_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_B calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->b.cstate_pstate.cstate_exit_ns, prog_wm_value);
-	}
+	} else if (watermarks->b.cstate_pstate.cstate_exit_ns
+			< hubbub1->watermarks.b.cstate_pstate.cstate_exit_ns)
+		wm_pending = true;
 
 	/* clock state C */
 	if (safe_to_lower || watermarks->c.cstate_pstate.cstate_enter_plus_exit_ns
@@ -426,7 +446,9 @@ void hubbub1_program_stutter_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_EXIT_WATERMARK_C calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->c.cstate_pstate.cstate_enter_plus_exit_ns, prog_wm_value);
-	}
+	} else if (watermarks->c.cstate_pstate.cstate_enter_plus_exit_ns
+			< hubbub1->watermarks.c.cstate_pstate.cstate_enter_plus_exit_ns)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->c.cstate_pstate.cstate_exit_ns
 			> hubbub1->watermarks.c.cstate_pstate.cstate_exit_ns) {
@@ -440,7 +462,9 @@ void hubbub1_program_stutter_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_C calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->c.cstate_pstate.cstate_exit_ns, prog_wm_value);
-	}
+	} else if (watermarks->c.cstate_pstate.cstate_exit_ns
+			< hubbub1->watermarks.c.cstate_pstate.cstate_exit_ns)
+		wm_pending = true;
 
 	/* clock state D */
 	if (safe_to_lower || watermarks->d.cstate_pstate.cstate_enter_plus_exit_ns
@@ -455,7 +479,9 @@ void hubbub1_program_stutter_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_EXIT_WATERMARK_D calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->d.cstate_pstate.cstate_enter_plus_exit_ns, prog_wm_value);
-	}
+	} else if (watermarks->d.cstate_pstate.cstate_enter_plus_exit_ns
+			< hubbub1->watermarks.d.cstate_pstate.cstate_enter_plus_exit_ns)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->d.cstate_pstate.cstate_exit_ns
 			> hubbub1->watermarks.d.cstate_pstate.cstate_exit_ns) {
@@ -469,11 +495,14 @@ void hubbub1_program_stutter_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_D calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->d.cstate_pstate.cstate_exit_ns, prog_wm_value);
-	}
+	} else if (watermarks->d.cstate_pstate.cstate_exit_ns
+			< hubbub1->watermarks.d.cstate_pstate.cstate_exit_ns)
+		wm_pending = true;
 
+	return wm_pending;
 }
 
-void hubbub1_program_pstate_watermarks(
+bool hubbub1_program_pstate_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
@@ -481,6 +510,7 @@ void hubbub1_program_pstate_watermarks(
 {
 	struct dcn10_hubbub *hubbub1 = TO_DCN10_HUBBUB(hubbub);
 	uint32_t prog_wm_value;
+	bool wm_pending = false;
 
 	/* clock state A */
 	if (safe_to_lower || watermarks->a.cstate_pstate.pstate_change_ns
@@ -495,7 +525,9 @@ void hubbub1_program_pstate_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("DRAM_CLK_CHANGE_WATERMARK_A calculated =%d\n"
 			"HW register value = 0x%x\n\n",
 			watermarks->a.cstate_pstate.pstate_change_ns, prog_wm_value);
-	}
+	} else if (watermarks->a.cstate_pstate.pstate_change_ns
+			< hubbub1->watermarks.a.cstate_pstate.pstate_change_ns)
+		wm_pending = true;
 
 	/* clock state B */
 	if (safe_to_lower || watermarks->b.cstate_pstate.pstate_change_ns
@@ -510,7 +542,9 @@ void hubbub1_program_pstate_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("DRAM_CLK_CHANGE_WATERMARK_B calculated =%d\n"
 			"HW register value = 0x%x\n\n",
 			watermarks->b.cstate_pstate.pstate_change_ns, prog_wm_value);
-	}
+	} else if (watermarks->b.cstate_pstate.pstate_change_ns
+			< hubbub1->watermarks.b.cstate_pstate.pstate_change_ns)
+		wm_pending = true;
 
 	/* clock state C */
 	if (safe_to_lower || watermarks->c.cstate_pstate.pstate_change_ns
@@ -525,7 +559,9 @@ void hubbub1_program_pstate_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("DRAM_CLK_CHANGE_WATERMARK_C calculated =%d\n"
 			"HW register value = 0x%x\n\n",
 			watermarks->c.cstate_pstate.pstate_change_ns, prog_wm_value);
-	}
+	} else if (watermarks->c.cstate_pstate.pstate_change_ns
+			< hubbub1->watermarks.c.cstate_pstate.pstate_change_ns)
+		wm_pending = true;
 
 	/* clock state D */
 	if (safe_to_lower || watermarks->d.cstate_pstate.pstate_change_ns
@@ -540,23 +576,33 @@ void hubbub1_program_pstate_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("DRAM_CLK_CHANGE_WATERMARK_D calculated =%d\n"
 			"HW register value = 0x%x\n\n",
 			watermarks->d.cstate_pstate.pstate_change_ns, prog_wm_value);
-	}
+	} else if (watermarks->d.cstate_pstate.pstate_change_ns
+			< hubbub1->watermarks.d.cstate_pstate.pstate_change_ns)
+		wm_pending = true;
+
+	return wm_pending;
 }
 
-void hubbub1_program_watermarks(
+bool hubbub1_program_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
 	struct dcn10_hubbub *hubbub1 = TO_DCN10_HUBBUB(hubbub);
+	bool wm_pending = false;
 	/*
 	 * Need to clamp to max of the register values (i.e. no wrap)
 	 * for dcn1, all wm registers are 21-bit wide
 	 */
-	hubbub1_program_urgent_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower);
-	hubbub1_program_stutter_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower);
-	hubbub1_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower);
+	if (hubbub1_program_urgent_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
+
+	if (hubbub1_program_stutter_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
+
+	if (hubbub1_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
 
 	REG_UPDATE(DCHUBBUB_ARB_SAT_LEVEL,
 			DCHUBBUB_ARB_SAT_LEVEL, 60 * refclk_mhz);
@@ -570,6 +616,7 @@ void hubbub1_program_watermarks(
 			DCHUBBUB_ARB_WATERMARK_CHANGE_DONE_INTERRUPT_DISABLE, 1,
 			DCHUBBUB_ARB_WATERMARK_CHANGE_REQUEST, 1);
 #endif
+	return wm_pending;
 }
 
 void hubbub1_update_dchub(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
index af57751253de..343a537172c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
@@ -308,7 +308,7 @@ bool hubbub1_verify_allow_pstate_change_high(
 
 void hubbub1_wm_change_req_wa(struct hubbub *hubbub);
 
-void hubbub1_program_watermarks(
+bool hubbub1_program_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
@@ -331,17 +331,17 @@ void hubbub1_construct(struct hubbub *hubbub,
 	const struct dcn_hubbub_shift *hubbub_shift,
 	const struct dcn_hubbub_mask *hubbub_mask);
 
-void hubbub1_program_urgent_watermarks(
+bool hubbub1_program_urgent_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
-void hubbub1_program_stutter_watermarks(
+bool hubbub1_program_stutter_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
-void hubbub1_program_pstate_watermarks(
+bool hubbub1_program_pstate_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 77396a08ad29..c381d347208f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1048,7 +1048,7 @@ void dcn10_plane_atomic_disconnect(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	if (opp != NULL)
 		opp->mpcc_disconnect_pending[pipe_ctx->plane_res.mpcc_inst] = true;
 
-	dc->optimized_required = true;
+	dc->clk_optimized_required = true;
 
 	if (hubp->funcs->hubp_disconnect)
 		hubp->funcs->hubp_disconnect(hubp);
@@ -1099,7 +1099,7 @@ void dcn10_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 				false);
 
 	hubp->power_gated = true;
-	dc->optimized_required = false; /* We're powering off, no need to optimize */
+	dc->clk_optimized_required = false; /* We're powering off, no need to optimize */
 
 	hws->funcs.plane_atomic_power_down(dc,
 			pipe_ctx->plane_res.dpp,
@@ -2686,7 +2686,7 @@ void dcn10_prepare_bandwidth(
 				false);
 	}
 
-	hubbub->funcs->program_watermarks(hubbub,
+	dc->wm_optimized_required = hubbub->funcs->program_watermarks(hubbub,
 			&context->bw_ctx.bw.dcn.watermarks,
 			dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 			true);
@@ -2710,19 +2710,30 @@ void dcn10_optimize_bandwidth(
 		hws->funcs.verify_allow_pstate_change_high(dc);
 
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		if (context->stream_count == 0)
+		if (context->stream_count == 0) {
 			context->bw_ctx.bw.dcn.clk.phyclk_khz = 0;
 
-		dc->clk_mgr->funcs->update_clocks(
-				dc->clk_mgr,
-				context,
+			dc->clk_mgr->funcs->update_clocks(
+					dc->clk_mgr,
+					context,
+					true);
+		} else if (dc->clk_optimized_required || IS_DIAG_DC(dc->ctx->dce_environment)) {
+			dc->clk_mgr->funcs->update_clocks(
+								dc->clk_mgr,
+								context,
+								true);
+		}
+	}
+
+	if (dc->wm_optimized_required || IS_DIAG_DC(dc->ctx->dce_environment)) {
+		hubbub->funcs->program_watermarks(hubbub,
+				&context->bw_ctx.bw.dcn.watermarks,
+				dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 				true);
 	}
 
-	hubbub->funcs->program_watermarks(hubbub,
-			&context->bw_ctx.bw.dcn.watermarks,
-			dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
-			true);
+	dc->clk_optimized_required = false;
+	dc->wm_optimized_required = false;
 	dcn10_stereo_hw_frame_pack_wa(dc, context);
 
 	if (dc->debug.pplib_wm_report_mode == WM_REPORT_OVERRIDE)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
index 9235f7d29454..c0b21d7450d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
@@ -562,19 +562,23 @@ void hubbub2_get_dchub_ref_freq(struct hubbub *hubbub,
 	}
 }
 
-static void hubbub2_program_watermarks(
+static bool hubbub2_program_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
 	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
+	bool wm_pending = false;
 	/*
 	 * Need to clamp to max of the register values (i.e. no wrap)
 	 * for dcn1, all wm registers are 21-bit wide
 	 */
-	hubbub1_program_urgent_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower);
-	hubbub1_program_stutter_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower);
+	if (hubbub1_program_urgent_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
+
+	if (hubbub1_program_stutter_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
 
 	/*
 	 * There's a special case when going from p-state support to p-state unsupported
@@ -592,6 +596,7 @@ static void hubbub2_program_watermarks(
 	REG_UPDATE(DCHUBBUB_ARB_DF_REQ_OUTSTAND, DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 180);
 
 	hubbub->funcs->allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+	return wm_pending;
 }
 
 static const struct hubbub_funcs hubbub2_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index b9ec40a31f5c..cf13b1db1025 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1627,7 +1627,7 @@ void dcn20_prepare_bandwidth(
 			false);
 
 	/* program dchubbub watermarks */
-	hubbub->funcs->program_watermarks(hubbub,
+	dc->wm_optimized_required = hubbub->funcs->program_watermarks(hubbub,
 					&context->bw_ctx.bw.dcn.watermarks,
 					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 					false);
@@ -1639,16 +1639,22 @@ void dcn20_optimize_bandwidth(
 {
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 
-	/* program dchubbub watermarks */
-	hubbub->funcs->program_watermarks(hubbub,
-					&context->bw_ctx.bw.dcn.watermarks,
-					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
-					true);
+	if (dc->wm_optimized_required || IS_DIAG_DC(dc->ctx->dce_environment)) {
+		/* program dchubbub watermarks */
+		hubbub->funcs->program_watermarks(hubbub,
+						&context->bw_ctx.bw.dcn.watermarks,
+						dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
+						true);
+		dc->wm_optimized_required = false;
+	}
 
-	dc->clk_mgr->funcs->update_clocks(
-			dc->clk_mgr,
-			context,
-			true);
+	if (dc->clk_optimized_required || IS_DIAG_DC(dc->ctx->dce_environment)) {
+		dc->clk_mgr->funcs->update_clocks(
+				dc->clk_mgr,
+				context,
+				true);
+		dc->wm_optimized_required = false;
+	}
 }
 
 bool dcn20_update_bandwidth(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
index f546260c15b7..8440975206e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
@@ -141,7 +141,7 @@ int hubbub21_init_dchub(struct hubbub *hubbub,
 	return NUM_VMID;
 }
 
-void hubbub21_program_urgent_watermarks(
+bool hubbub21_program_urgent_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
@@ -149,6 +149,7 @@ void hubbub21_program_urgent_watermarks(
 {
 	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
 	uint32_t prog_wm_value;
+	bool wm_pending = false;
 
 	/* Repeat for water mark set A, B, C and D. */
 	/* clock state A */
@@ -163,7 +164,8 @@ void hubbub21_program_urgent_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("URGENCY_WATERMARK_A calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->a.urgent_ns, prog_wm_value);
-	}
+	} else if (watermarks->a.urgent_ns < hubbub1->watermarks.a.urgent_ns)
+		wm_pending = true;
 
 	/* determine the transfer time for a quantity of data for a particular requestor.*/
 	if (safe_to_lower || watermarks->a.frac_urg_bw_flip
@@ -172,7 +174,9 @@ void hubbub21_program_urgent_watermarks(
 
 		REG_SET(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_A, 0,
 				DCHUBBUB_ARB_FRAC_URG_BW_FLIP_A, watermarks->a.frac_urg_bw_flip);
-	}
+	} else if (watermarks->a.frac_urg_bw_flip
+			< hubbub1->watermarks.a.frac_urg_bw_flip)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->a.frac_urg_bw_nom
 			> hubbub1->watermarks.a.frac_urg_bw_nom) {
@@ -180,14 +184,18 @@ void hubbub21_program_urgent_watermarks(
 
 		REG_SET(DCHUBBUB_ARB_FRAC_URG_BW_NOM_A, 0,
 				DCHUBBUB_ARB_FRAC_URG_BW_NOM_A, watermarks->a.frac_urg_bw_nom);
-	}
+	} else if (watermarks->a.frac_urg_bw_nom
+			< hubbub1->watermarks.a.frac_urg_bw_nom)
+		wm_pending = true;
+
 	if (safe_to_lower || watermarks->a.urgent_latency_ns > hubbub1->watermarks.a.urgent_latency_ns) {
 		hubbub1->watermarks.a.urgent_latency_ns = watermarks->a.urgent_latency_ns;
 		prog_wm_value = convert_and_clamp(watermarks->a.urgent_latency_ns,
 				refclk_mhz, 0x1fffff);
 		REG_SET(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_A, 0,
 				DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_A, prog_wm_value);
-	}
+	} else if (watermarks->a.urgent_latency_ns < hubbub1->watermarks.a.urgent_latency_ns)
+		wm_pending = true;
 
 	/* clock state B */
 	if (safe_to_lower || watermarks->b.urgent_ns > hubbub1->watermarks.b.urgent_ns) {
@@ -201,7 +209,8 @@ void hubbub21_program_urgent_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("URGENCY_WATERMARK_B calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->b.urgent_ns, prog_wm_value);
-	}
+	} else if (watermarks->b.urgent_ns < hubbub1->watermarks.b.urgent_ns)
+		wm_pending = true;
 
 	/* determine the transfer time for a quantity of data for a particular requestor.*/
 	if (safe_to_lower || watermarks->a.frac_urg_bw_flip
@@ -210,7 +219,9 @@ void hubbub21_program_urgent_watermarks(
 
 		REG_SET(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_B, 0,
 				DCHUBBUB_ARB_FRAC_URG_BW_FLIP_B, watermarks->a.frac_urg_bw_flip);
-	}
+	} else if (watermarks->a.frac_urg_bw_flip
+			< hubbub1->watermarks.a.frac_urg_bw_flip)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->a.frac_urg_bw_nom
 			> hubbub1->watermarks.a.frac_urg_bw_nom) {
@@ -218,7 +229,9 @@ void hubbub21_program_urgent_watermarks(
 
 		REG_SET(DCHUBBUB_ARB_FRAC_URG_BW_NOM_B, 0,
 				DCHUBBUB_ARB_FRAC_URG_BW_NOM_B, watermarks->a.frac_urg_bw_nom);
-	}
+	} else if (watermarks->a.frac_urg_bw_nom
+			< hubbub1->watermarks.a.frac_urg_bw_nom)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->b.urgent_latency_ns > hubbub1->watermarks.b.urgent_latency_ns) {
 		hubbub1->watermarks.b.urgent_latency_ns = watermarks->b.urgent_latency_ns;
@@ -226,7 +239,8 @@ void hubbub21_program_urgent_watermarks(
 				refclk_mhz, 0x1fffff);
 		REG_SET(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B, 0,
 				DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B, prog_wm_value);
-	}
+	} else if (watermarks->b.urgent_latency_ns < hubbub1->watermarks.b.urgent_latency_ns)
+		wm_pending = true;
 
 	/* clock state C */
 	if (safe_to_lower || watermarks->c.urgent_ns > hubbub1->watermarks.c.urgent_ns) {
@@ -240,7 +254,8 @@ void hubbub21_program_urgent_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("URGENCY_WATERMARK_C calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->c.urgent_ns, prog_wm_value);
-	}
+	} else if (watermarks->c.urgent_ns < hubbub1->watermarks.c.urgent_ns)
+		wm_pending = true;
 
 	/* determine the transfer time for a quantity of data for a particular requestor.*/
 	if (safe_to_lower || watermarks->a.frac_urg_bw_flip
@@ -249,7 +264,9 @@ void hubbub21_program_urgent_watermarks(
 
 		REG_SET(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_C, 0,
 				DCHUBBUB_ARB_FRAC_URG_BW_FLIP_C, watermarks->a.frac_urg_bw_flip);
-	}
+	} else if (watermarks->a.frac_urg_bw_flip
+			< hubbub1->watermarks.a.frac_urg_bw_flip)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->a.frac_urg_bw_nom
 			> hubbub1->watermarks.a.frac_urg_bw_nom) {
@@ -257,7 +274,9 @@ void hubbub21_program_urgent_watermarks(
 
 		REG_SET(DCHUBBUB_ARB_FRAC_URG_BW_NOM_C, 0,
 				DCHUBBUB_ARB_FRAC_URG_BW_NOM_C, watermarks->a.frac_urg_bw_nom);
-	}
+	} else if (watermarks->a.frac_urg_bw_nom
+			< hubbub1->watermarks.a.frac_urg_bw_nom)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->c.urgent_latency_ns > hubbub1->watermarks.c.urgent_latency_ns) {
 		hubbub1->watermarks.c.urgent_latency_ns = watermarks->c.urgent_latency_ns;
@@ -265,7 +284,8 @@ void hubbub21_program_urgent_watermarks(
 				refclk_mhz, 0x1fffff);
 		REG_SET(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C, 0,
 				DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C, prog_wm_value);
-	}
+	} else if (watermarks->c.urgent_latency_ns < hubbub1->watermarks.c.urgent_latency_ns)
+		wm_pending = true;
 
 	/* clock state D */
 	if (safe_to_lower || watermarks->d.urgent_ns > hubbub1->watermarks.d.urgent_ns) {
@@ -279,7 +299,8 @@ void hubbub21_program_urgent_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("URGENCY_WATERMARK_D calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->d.urgent_ns, prog_wm_value);
-	}
+	} else if (watermarks->d.urgent_ns < hubbub1->watermarks.d.urgent_ns)
+		wm_pending = true;
 
 	/* determine the transfer time for a quantity of data for a particular requestor.*/
 	if (safe_to_lower || watermarks->a.frac_urg_bw_flip
@@ -288,7 +309,9 @@ void hubbub21_program_urgent_watermarks(
 
 		REG_SET(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_D, 0,
 				DCHUBBUB_ARB_FRAC_URG_BW_FLIP_D, watermarks->a.frac_urg_bw_flip);
-	}
+	} else if (watermarks->a.frac_urg_bw_flip
+			< hubbub1->watermarks.a.frac_urg_bw_flip)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->a.frac_urg_bw_nom
 			> hubbub1->watermarks.a.frac_urg_bw_nom) {
@@ -296,7 +319,9 @@ void hubbub21_program_urgent_watermarks(
 
 		REG_SET(DCHUBBUB_ARB_FRAC_URG_BW_NOM_D, 0,
 				DCHUBBUB_ARB_FRAC_URG_BW_NOM_D, watermarks->a.frac_urg_bw_nom);
-	}
+	} else if (watermarks->a.frac_urg_bw_nom
+			< hubbub1->watermarks.a.frac_urg_bw_nom)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->d.urgent_latency_ns > hubbub1->watermarks.d.urgent_latency_ns) {
 		hubbub1->watermarks.d.urgent_latency_ns = watermarks->d.urgent_latency_ns;
@@ -304,10 +329,13 @@ void hubbub21_program_urgent_watermarks(
 				refclk_mhz, 0x1fffff);
 		REG_SET(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D, 0,
 				DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D, prog_wm_value);
-	}
+	} else if (watermarks->d.urgent_latency_ns < hubbub1->watermarks.d.urgent_latency_ns)
+		wm_pending = true;
+
+	return wm_pending;
 }
 
-void hubbub21_program_stutter_watermarks(
+bool hubbub21_program_stutter_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
@@ -315,6 +343,7 @@ void hubbub21_program_stutter_watermarks(
 {
 	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
 	uint32_t prog_wm_value;
+	bool wm_pending = false;
 
 	/* clock state A */
 	if (safe_to_lower || watermarks->a.cstate_pstate.cstate_enter_plus_exit_ns
@@ -330,7 +359,9 @@ void hubbub21_program_stutter_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_EXIT_WATERMARK_A calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->a.cstate_pstate.cstate_enter_plus_exit_ns, prog_wm_value);
-	}
+	} else if (watermarks->a.cstate_pstate.cstate_enter_plus_exit_ns
+			< hubbub1->watermarks.a.cstate_pstate.cstate_enter_plus_exit_ns)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->a.cstate_pstate.cstate_exit_ns
 			> hubbub1->watermarks.a.cstate_pstate.cstate_exit_ns) {
@@ -345,7 +376,9 @@ void hubbub21_program_stutter_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_A calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->a.cstate_pstate.cstate_exit_ns, prog_wm_value);
-	}
+	} else if (watermarks->a.cstate_pstate.cstate_exit_ns
+			< hubbub1->watermarks.a.cstate_pstate.cstate_exit_ns)
+		wm_pending = true;
 
 	/* clock state B */
 	if (safe_to_lower || watermarks->b.cstate_pstate.cstate_enter_plus_exit_ns
@@ -361,7 +394,9 @@ void hubbub21_program_stutter_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_EXIT_WATERMARK_B calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->b.cstate_pstate.cstate_enter_plus_exit_ns, prog_wm_value);
-	}
+	} else if (watermarks->b.cstate_pstate.cstate_enter_plus_exit_ns
+			< hubbub1->watermarks.b.cstate_pstate.cstate_enter_plus_exit_ns)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->b.cstate_pstate.cstate_exit_ns
 			> hubbub1->watermarks.b.cstate_pstate.cstate_exit_ns) {
@@ -376,7 +411,9 @@ void hubbub21_program_stutter_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_B calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->b.cstate_pstate.cstate_exit_ns, prog_wm_value);
-	}
+	} else if (watermarks->b.cstate_pstate.cstate_exit_ns
+			< hubbub1->watermarks.b.cstate_pstate.cstate_exit_ns)
+		wm_pending = true;
 
 	/* clock state C */
 	if (safe_to_lower || watermarks->c.cstate_pstate.cstate_enter_plus_exit_ns
@@ -392,7 +429,9 @@ void hubbub21_program_stutter_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_EXIT_WATERMARK_C calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->c.cstate_pstate.cstate_enter_plus_exit_ns, prog_wm_value);
-	}
+	} else if (watermarks->c.cstate_pstate.cstate_enter_plus_exit_ns
+			< hubbub1->watermarks.c.cstate_pstate.cstate_enter_plus_exit_ns)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->c.cstate_pstate.cstate_exit_ns
 			> hubbub1->watermarks.c.cstate_pstate.cstate_exit_ns) {
@@ -407,7 +446,9 @@ void hubbub21_program_stutter_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_C calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->c.cstate_pstate.cstate_exit_ns, prog_wm_value);
-	}
+	} else if (watermarks->c.cstate_pstate.cstate_exit_ns
+			< hubbub1->watermarks.c.cstate_pstate.cstate_exit_ns)
+		wm_pending = true;
 
 	/* clock state D */
 	if (safe_to_lower || watermarks->d.cstate_pstate.cstate_enter_plus_exit_ns
@@ -423,7 +464,9 @@ void hubbub21_program_stutter_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_EXIT_WATERMARK_D calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->d.cstate_pstate.cstate_enter_plus_exit_ns, prog_wm_value);
-	}
+	} else if (watermarks->d.cstate_pstate.cstate_enter_plus_exit_ns
+			< hubbub1->watermarks.d.cstate_pstate.cstate_enter_plus_exit_ns)
+		wm_pending = true;
 
 	if (safe_to_lower || watermarks->d.cstate_pstate.cstate_exit_ns
 			> hubbub1->watermarks.d.cstate_pstate.cstate_exit_ns) {
@@ -438,10 +481,14 @@ void hubbub21_program_stutter_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_D calculated =%d\n"
 			"HW register value = 0x%x\n",
 			watermarks->d.cstate_pstate.cstate_exit_ns, prog_wm_value);
-	}
+	} else if (watermarks->d.cstate_pstate.cstate_exit_ns
+			< hubbub1->watermarks.d.cstate_pstate.cstate_exit_ns)
+		wm_pending = true;
+
+	return wm_pending;
 }
 
-void hubbub21_program_pstate_watermarks(
+bool hubbub21_program_pstate_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
@@ -450,6 +497,8 @@ void hubbub21_program_pstate_watermarks(
 	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
 	uint32_t prog_wm_value;
 
+	bool wm_pending = false;
+
 	/* clock state A */
 	if (safe_to_lower || watermarks->a.cstate_pstate.pstate_change_ns
 			> hubbub1->watermarks.a.cstate_pstate.pstate_change_ns) {
@@ -464,7 +513,9 @@ void hubbub21_program_pstate_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("DRAM_CLK_CHANGE_WATERMARK_A calculated =%d\n"
 			"HW register value = 0x%x\n\n",
 			watermarks->a.cstate_pstate.pstate_change_ns, prog_wm_value);
-	}
+	} else if (watermarks->a.cstate_pstate.pstate_change_ns
+			< hubbub1->watermarks.a.cstate_pstate.pstate_change_ns)
+		wm_pending = true;
 
 	/* clock state B */
 	if (safe_to_lower || watermarks->b.cstate_pstate.pstate_change_ns
@@ -480,7 +531,9 @@ void hubbub21_program_pstate_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("DRAM_CLK_CHANGE_WATERMARK_B calculated =%d\n"
 			"HW register value = 0x%x\n\n",
 			watermarks->b.cstate_pstate.pstate_change_ns, prog_wm_value);
-	}
+	} else if (watermarks->b.cstate_pstate.pstate_change_ns
+			< hubbub1->watermarks.b.cstate_pstate.pstate_change_ns)
+		wm_pending = false;
 
 	/* clock state C */
 	if (safe_to_lower || watermarks->c.cstate_pstate.pstate_change_ns
@@ -496,7 +549,9 @@ void hubbub21_program_pstate_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("DRAM_CLK_CHANGE_WATERMARK_C calculated =%d\n"
 			"HW register value = 0x%x\n\n",
 			watermarks->c.cstate_pstate.pstate_change_ns, prog_wm_value);
-	}
+	} else if (watermarks->c.cstate_pstate.pstate_change_ns
+			< hubbub1->watermarks.c.cstate_pstate.pstate_change_ns)
+		wm_pending = true;
 
 	/* clock state D */
 	if (safe_to_lower || watermarks->d.cstate_pstate.pstate_change_ns
@@ -512,20 +567,30 @@ void hubbub21_program_pstate_watermarks(
 		DC_LOG_BANDWIDTH_CALCS("DRAM_CLK_CHANGE_WATERMARK_D calculated =%d\n"
 			"HW register value = 0x%x\n\n",
 			watermarks->d.cstate_pstate.pstate_change_ns, prog_wm_value);
-	}
+	} else if (watermarks->d.cstate_pstate.pstate_change_ns
+			< hubbub1->watermarks.d.cstate_pstate.pstate_change_ns)
+		wm_pending = true;
+
+	return wm_pending;
 }
 
-void hubbub21_program_watermarks(
+bool hubbub21_program_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
 	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
+	bool wm_pending = false;
+
+	if (hubbub21_program_urgent_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
 
-	hubbub21_program_urgent_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower);
-	hubbub21_program_stutter_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower);
-	hubbub21_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower);
+	if (hubbub21_program_stutter_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
+
+	if (hubbub21_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
 
 	/*
 	 * The DCHub arbiter has a mechanism to dynamically rate limit the DCHub request stream to the fabric.
@@ -549,6 +614,8 @@ void hubbub21_program_watermarks(
 			DCHUBBUB_ARB_MAX_QOS_COMMIT_THRESHOLD, 0xF);
 
 	hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+
+	return wm_pending;
 }
 
 void hubbub21_wm_read_state(struct hubbub *hubbub,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h
index c4840dfb1fa5..ef3ef28509ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h
@@ -113,22 +113,22 @@
 void dcn21_dchvm_init(struct hubbub *hubbub);
 int hubbub21_init_dchub(struct hubbub *hubbub,
 		struct dcn_hubbub_phys_addr_config *pa_config);
-void hubbub21_program_watermarks(
+bool hubbub21_program_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
-void hubbub21_program_urgent_watermarks(
+bool hubbub21_program_urgent_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
-void hubbub21_program_stutter_watermarks(
+bool hubbub21_program_stutter_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
-void hubbub21_program_pstate_watermarks(
+bool hubbub21_program_pstate_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index c0dc1d0f5cae..f5dd0cc73c63 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -134,7 +134,7 @@ struct hubbub_funcs {
 			unsigned int dccg_ref_freq_inKhz,
 			unsigned int *dchub_ref_freq_inKhz);
 
-	void (*program_watermarks)(
+	bool (*program_watermarks)(
 			struct hubbub *hubbub,
 			struct dcn_watermark_set *watermarks,
 			unsigned int refclk_mhz,
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
