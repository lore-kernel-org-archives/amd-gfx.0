Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391C9C98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8A5110F744;
	Thu, 24 Sep 2026 18:47:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GeEJM5ZW";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE82E10F744
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWSkkuf09XY1UeTtPklxm6pbfZGitB5nYMVVq7fIHuRT4GrbFT5Uo6dJxePQCbgGnZAngBqLTFnA5Mry42bCSEa6yEq8hTMQpRlOdtQ46MV9iWJKmKt6EE9pjyssLnV06qGjniHDbQ6sdD1PLvEeQhQ4sKewKFzCG9gRlNydY8B11c8W9LnDebQY1xdfq3fjiE81ZnNdSeQHbI5o+GNVTHjaVqHEVnyIzFhE/NZvHPrv6wFJcyev0tArx0HVIQTnZZYBUhrEcheQxOipcDIz/LgVQyAiYYqqee5Q2KSRIoa1bkHuvbPS80lWyl6MjxLSXveavZv2hccbfel6FCNYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsE/GHPqKvSAsIrM6PKeIZahE2p+lmT0M4wspLD+ZmI=;
 b=dVrTbI0Eqnu+mRJoGkHGcow7tBjcJmuQHCXmCBTwSDGUXNdtoWLk16l7xTO6Kyyok2nCcxFRvL9UW6a1x1jh6x9IT2/CcfTdlBib6lb2zI1vnA4pfBedVY/LPSzHrKV4AfVTgpS1SA+4NeIhVK1yuGUSr8IDNnJPMYdYqI4RnBM3zXkQyzpuF27ydjphvv4l8e/Zq/Ot5KlafBkOh0tTtEwJcRARZfxVtc04V8Bea9hiuCIkZxYX7yAjJWmza/nceIReLs5DUqFOdSzI3WVvSf7tcg0ryfU46d/d0o3aH9Nq4uyT/icvmC/QcpG3Brnrar+v3PBKhDCLnGN0VQrxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsE/GHPqKvSAsIrM6PKeIZahE2p+lmT0M4wspLD+ZmI=;
 b=GeEJM5ZWzVWyHid0MIoYBDSXlesrrGYZHQvNupOfhrpmaOPJECPoPUqInCDrtN3l+Pl58tRJb33iY+CE45cYHqAzGpJlGCsIT/GsFl7syssbcHYCu5Sg/Mg7aoCn50SrG2aGbRiXqQwnPEVdWMNB1BxWi/C+MchyAhOhu15nUAs=
Received: from SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::13)
 by CY5PR12MB6082.namprd12.prod.outlook.com (2603:10b6:930:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Thu, 24 Sep
 2026 18:46:20 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::27) by SJ0P220CA0029.outlook.office365.com
 (2603:10b6:a03:41b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:20 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:09 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ashwin Santhosh <Ashwin.Santhosh@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>
Subject: [PATCH 12/34] drm/amd/display: Program OPP formatter for plane-less
 ODM segments
Date: Thu, 24 Sep 2026 14:45:25 -0400
Message-ID: <20260924184824.596894-13-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|CY5PR12MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 074426a8-10fa-4bb4-4164-08df1a6c1ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: zdTLmmChgpADdNNLJ54EaCBex2Od/Us5paUG9XDV8r3kaQkZFoJwRRsl4SojkVcO8v1hka1ke+KCkvWSYmgMEujksvBH8srIuMvBxoZJGmd7+U8whaH8J9v9Uj2IeNQ/rH8KxecDAENrIEK2RA2BmK3ZBCGGsQQ4BOFu1nzWZiHvWa9om9zr0T/I269wECp+J1pMzk53cg4jPLZWKyISrH/khyv0/EZtdUOo5ItI5w8+yfSORO71YE6UaHfRRKEI3i90dVvJ+kZ3zKk5gUyrD9duArVJfahDViz5frC4p2OL+Qjdj8PLl/x5kOFeHDFtKq0IOTbCI6nP0cQpH8GitTG42qVt+Runzrq6Hrm57D8Twx3S91BRq2o1gIdCbpKWZ0n4PMbhwlU0MK9M4S+hS9bK0hukWYDKVMbGOBHWOxQJ4e/WnFenVv3P9zBhMz5qmJQOww6GZJ6khP0QNU7Srpr73ohMUwmzNO0wGXFs7l7ADXSJik75HZHfztycMIcjIgcNo96kXbOj2oqmJjNHmySqQNcRE7xlBvTn7zV4u5leQlWJfPwY4dvVwfSzdcjO3Vg4e+sfim4D+0J0avmdHLwYadWf19djX2gdVz0c+wdcRddYLLzbxQtRIOZYvyeoccHva9GG73Q6jL4P0WV7JOIr8SPaciKWtmtlr7/q53P3w9ka9XukMhcuRdugJWQC1cRzxR7R6aiKk0vqf4jXww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DGkvMZrz67FKdISUXqUuM2kOvMFevXRdmR4UgMgHjM0ljQY9rZ2Jq1SnxM2hmeB/N9jWhYvYOhZXWVpkJ33GjfKzZ5csdCnwbqGuDnCnlhMcliN6fDNA8EItZTZdWbKVWfh7/OwVWXuOgdX9evUrhQcfXrYFB887xCocFthMDXBY4/1yAWaxebibSTipqBjxvzxNAvkqGQ6AhIRZDKJ8JvNIh9YMbqU3mC+XT/DXoz2/8A+BXpZ7wsyJrDq6bR1D/jXFYKpuoSMWQ0ZMD3KgHUPSt+qCJgct63EHfSSuaAo6XeCyz7m3L8Pv61WOtRtP7ThAkF5iufpdxFTZ1bIJv81jS+nZt7WU0CUPN5asJeJnkQJDmt/eLOBAI4czrTS6jjvZd2DUzVs7EVa9VxMFbrdLI+S6meuFkDz5cON27rgbRLrnSgRH8AT6S6u1PANg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:20.4193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 074426a8-10fa-4bb4-4164-08df1a6c1ffe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082
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

From: Ashwin Santhosh <Ashwin.Santhosh@amd.com>

why:
When a display is disabled the surviving DSC stream is committed with no
planes but the dynamic ODM policy still expands it to a four to one
combine. The added plane-less segments skip program_pipe so their OPP
formatter is never configured. The DPG blank then feeds an unprogrammed
formatter and the OPTC input underflows which flashes grey on screen.

how:
Program the OPP formatter for each plane-less OPP head in update_odm and
update_odm_sequence the same way program_pipe does for planed pipes. Both
function pointers are checked for null before calling. Every ODM segment
now feeds valid data to the OPTC so the four to one combine no longer
underflows.

Signed-off-by: Ashwin Santhosh <Ashwin.Santhosh@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 7780f37c615c..1d53240cd736 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1740,6 +1740,22 @@ void dcn401_update_odm(struct dc *dc, struct dc_state *context,
 				opp_heads[i]->stream_res.opp,
 				opp_heads[i]->stream->timing.pixel_encoding,
 				resource_is_pipe_type(opp_heads[i], OTG_MASTER));
+
+		// Plane-less OPP heads are skipped by program_pipe, where the OPP
+		// formatter is normally configured, so set it up for them here.
+		if (!opp_heads[i]->plane_state &&
+				opp_heads[i]->stream_res.opp->funcs->opp_set_dyn_expansion &&
+				opp_heads[i]->stream_res.opp->funcs->opp_program_fmt) {
+			opp_heads[i]->stream_res.opp->funcs->opp_set_dyn_expansion(
+					opp_heads[i]->stream_res.opp,
+					COLOR_SPACE_YCBCR601,
+					opp_heads[i]->stream->timing.display_color_depth,
+					opp_heads[i]->stream->signal);
+			opp_heads[i]->stream_res.opp->funcs->opp_program_fmt(
+					opp_heads[i]->stream_res.opp,
+					&opp_heads[i]->stream->bit_depth_params,
+					&opp_heads[i]->stream->clamping);
+		}
 	}
 
 	update_dsc_for_odm_change(dc, context, otg_master);
@@ -1876,6 +1892,20 @@ void dcn401_update_odm_sequence(struct dc *dc, struct dc_state *context,
 		/* Add OPP program left edge extra pixel operation */
 		hwss_add_opp_program_left_edge_extra_pixel(seq_state, opp_heads[i]->stream_res.opp,
 			opp_heads[i]->stream->timing.pixel_encoding, resource_is_pipe_type(opp_heads[i], OTG_MASTER));
+
+		//Plane-less OPP heads are skipped by program_pipe, where the OPP
+		// formatter is normally configured, so set it up for them here.
+		if (!opp_heads[i]->plane_state &&
+				opp_heads[i]->stream_res.opp->funcs->opp_set_dyn_expansion &&
+				opp_heads[i]->stream_res.opp->funcs->opp_program_fmt) {
+			hwss_add_opp_set_dyn_expansion(seq_state, opp_heads[i]->stream_res.opp,
+				COLOR_SPACE_YCBCR601,
+				opp_heads[i]->stream->timing.display_color_depth,
+				opp_heads[i]->stream->signal);
+			hwss_add_opp_program_fmt(seq_state, opp_heads[i]->stream_res.opp,
+				&opp_heads[i]->stream->bit_depth_params,
+				&opp_heads[i]->stream->clamping);
+		}
 	}
 
 	/* Add DSC update operations to sequence */
-- 
2.53.0

