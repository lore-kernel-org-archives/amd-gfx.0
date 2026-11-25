Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD06B606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sht0ZIRy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D2010F643;
	Wed, 25 Nov 2026 06:58:10 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011034.outbound.protection.outlook.com
 [40.93.194.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C09810F643
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcLZ1TOZ2rTuFXVUlVDF/aONxsBLWgAkR7AHyRxZ+UF3KUdKTGG9px9sn64qQwRwVyYOaxhG2qECEcquQHVTXRO/XyBnXTiIn5vZABZxfH5960D2BcUB5vsY2jlyX34a+T9vgo/ih9at7BrJi8F2FVi5sH9X1lOY4GXiUcqrVJdX/fWM8a0jiC9kexomIvSeqCF235sCFU/hsIxOQdwBARidfYcP++bk62lR7bUrllJzGgR5hBteFz6Q4ml+ki26nChqmIPBHM7rFpVbSa/xI5WrTmIN0SdmOUszIybrY9w+6KJyQsHPfHNJVCO2U5/+MBohKBy8H9hIGhfPppIdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Lvty3e7VCUYhMKdDPxH+57a85jcKen4C/3foTj8s38=;
 b=m/3GvqHaBcR0zsBARCYbWn0B4a+af0HW7whFtLGRi+kXN6hRPRL/WSuxZtKWj+DhzqEE6fVSSiMolNhNCWq83pu1azXCOJbZgkSR4s82p8iFWRQake6u1rsT4mj6VlPxjTEwvSX4itQwmv5gcnFpv+2nAuQJQtle/8BPck6oU0DFXvp8PYeONKkfMm6mcpa8S0PDty9khhHMidX83Dy0IDDRc5MQyOww+cdfRDG8bsfD4Ub/nhZiJLaTyL+nvtl0c05vrfafgsiAyrwM3wc4elRwZGsEz9ifDfLS9vqpzFd9kDZHDYTJT7+e+Vi7nuv49CbxcaTliClh4fLt4uluPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Lvty3e7VCUYhMKdDPxH+57a85jcKen4C/3foTj8s38=;
 b=sht0ZIRy16POMQeTwvg45fvzkCM50Fa+ZuhPPTihZqmCIfC0arBMqqalOZfccaZ2aOhW0wiLE2LYQZQri0EV7ntZaNKXQM0FuiMBYyVy4tVrjdD8IB2iHEkCE0IYxbJa6ujbVvg1kmNl0BKLBDAMi2XVoRPwVkKzbdgP59c13p8=
Received: from PH5P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::10)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 06:58:00 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:510:34b:cafe::a6) by PH5P222CA0008.outlook.office365.com
 (2603:10b6:510:34b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 06:58:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:57:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:57:59 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:57:58 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:57:50 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 18/27] drm/amd/display: Add the immediate flip to the DC2
 seamless update
Date: Wed, 25 Nov 2026 14:55:07 +0800
Message-ID: <20261125065631.3889665-19-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: ea16b74d-b12f-4192-e647-08df4ac1714f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|22082099003|261009223027099003|6133799003|261021123027099003|261021121427099003|56012099006|261022105027099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: ewzCOr5wWTxc2n5eBq9IJymPgtFGITHB3nrh3rCaXa5/s9GZBO6KVS4b+qYE7fkmsW1RQNnb7FDodggLEjgmaXLDTkVnwmAngSav/vxENXKqtW1wMavt+cWAB2f7Hc3+KgIK20M4MsOXlUzIFZx8D22aSK8vaI6bOwPwo6EcklbrBeSCGXSV2qTwQlWkvdXoc+eMVt1z/eBjQbD7Pzb27wxtgW0qxa36X6PM8ctxEE3AyFjVdXReIg/+QH5A1wr5DQn4L7Jetj7Bc3oISe/wHbR6osEyZOxGxJwujPgF9glbJAd1lod39aboxOmAAGZiU3ds02im+UGQcp/DuGvb1WoI71Dz7jHUcNkbRmZ3mI2mv3rKu+GobbtJXZQK8Agm/kKKfrdRXWlRhY9+qg3TeFuA2myddRpvsuHlBlCzDgTwHN/lK8qV9DPXTAiD7HMAiwAUL8wEknPfDqcc5sGjynoz9TgD9njK5ZiOrTzrfIs+UFBHPBM7lWU9HlszZ6GynHmWKw6IY8mlcuhOwRGw7i/A7PoiaIAVBEhZFdJ/FJF2rXMh05UY8Z/9J21bNkL9le1EJ2eqvDr/27FkhG/kbK+e4re2fcP7vMOHNZRzYYWejmJmx8krae2WV47v2XFu4D6nkh3o4By73TmItKObOrN3FIZ93M1bDaLxaxv8wXLUvmblG25rxTJ7HpP3adPAk8ZxQFYj623mSIU4Yi6N9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(261009223027099003)(6133799003)(261021123027099003)(261021121427099003)(56012099006)(261022105027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 79gITRJlv3i4zFXckk01OMKeXcjk5VB2caxxJpZsAu9Elv94lyyQWIbGkj5K4LggXD7TN8Eo1BrZYZq2zQxO6U+zVtMb7iDh5S3Jrsv7MX2zzPMAjyjXAjAIwDyJe6EsA4akqGSXbOYFyCO3t4K6Th9Ha53bVgDFRroeqwsJjYGNTFFu2m7uC6/wZMVBEtrrxJCfcCieWTfYGmVKWidwzAlVPs4Ww0fikVH3vRo8fH4hAfv1oWQLKaGiFBjPWU9VA8bQQmA2duENbCn1DJpSy2jBWifjXBX8LwFM29IRVDIZbiLoLQxaAtdD/iCFmLBtPZ66a0IH2RXk60TDiI9UphxL5pIY5M5Ki70sq1Zf1zvl2LHLh3VyTsWbdmDjIGrZSWnCAlyuQH/jUpRFq4V1L3W6ByPWnWdg/Gqm+dbxFKkX9PDq6NuJOUkL2fyvVEpH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:57:59.8827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea16b74d-b12f-4192-e647-08df4ac1714f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tony Cheng <tony.cheng@amd.com>

[Why]
With DC2 selected, Core2 rejects an immediate flip. The flip falls
back to DC1, although DC1 programs it in the same order as the vsync
flip.

[How]
Let the flip on the kept context run when the plane flips
immediately. The order stays lock, GSL, triple buffer, the address,
unlock and the manual trigger. GSL now takes flip_immediate from the
plane, as the address already did.

After the flip, Core2 sets the current address of an immediate flip,
as dcn20_prepare_plane_addr_update does.

Reject an immediate flip of a DCC surface. For it, DC1 waits for the
DCC meta data to propagate, and the flip does not emit that wait.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../dc/bls_builder/dcn401_seamless_builder.c  | 22 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   |  2 ++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
index 850b5d8c96d4..bc7dd933e35e 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
@@ -824,6 +824,24 @@ static bool check_no_immediate_flip(const struct dc *dc,
 			DC_TRAIT_MATCH(DC_PLANE_TRAIT_FLIP_IMMEDIATE, 0));
 }
 
+/*
+ * DC1 waits for the DCC meta data to propagate before an immediate flip of
+ * a DCC surface. The flip does not emit that wait.
+ */
+static bool check_no_immediate_dcc_flip(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state, unsigned int i)
+{
+	struct dc_state_facts facts;
+
+	(void)current_state;
+	(void)dc;
+	dc_state_facts_derive(new_state, &facts);
+	return !dc_state_facts_any_plane(&facts, (uint8_t)i,
+			DC_TRAIT_MATCH(DC_PLANE_TRAIT_FLIP_IMMEDIATE |
+			DC_PLANE_TRAIT_DCC, 0));
+}
+
 /*
  * DC1 translates a distributed-points curve into a LUT while it programs
  * the plane. The update programs only the predefined and bypass curves.
@@ -1081,7 +1099,7 @@ static enum bls_builder_result dcn401_check_flip(const struct dc *dc,
 	CHECK_UPDATE(one_address_only_plane,
 			"stream has odm, or not one plane with an address-only update");
 	CHECK_CONDITION(triple_buffer, "triple buffer is disabled");
-	CHECK_UPDATE(no_immediate_flip, "flip is immediate");
+	CHECK_UPDATE(no_immediate_dcc_flip, "immediate flip of a dcc surface");
 	CHECK_UPDATE(no_mcm_luts, "an mcm lut is enabled");
 	return BLS_BUILD_SUCCESS;
 }
@@ -2318,6 +2336,8 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 		break;
 	case HUBP_SET_FLIP_CONTROL_GSL:
 		p->set_flip_control_gsl_params.hubp = pipe->plane_res.hubp;
+		p->set_flip_control_gsl_params.flip_immediate =
+				plane->flip_immediate;
 		break;
 	case HUBP_CLK_CNTL:
 		p->hubp_clk_cntl_params.hubp = pipe->plane_res.hubp;
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
index 245ebd8e01d0..ce2d4f0c89d6 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
@@ -417,6 +417,8 @@ static void core2_update_done(struct dc *dc, struct dc_state *context,
 		vm_helper_mark_vmid_used(dc->vm_helper, plane->address.vmid,
 				(uint8_t)hubp->inst);
 		plane->status.requested_address = plane->address;
+		if (plane->flip_immediate)
+			plane->status.current_address = plane->address;
 		hubp->opp_id = pipe->stream_res.opp->inst;
 		hubp->mpcc_id = hubp->inst;
 		hubp->power_gated = false;
-- 
2.43.0

