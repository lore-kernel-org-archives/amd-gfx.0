Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD111606A324
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4Js4Usg3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B1D410F8D3;
	Wed, 11 Nov 2026 01:42:51 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E01AC10F8D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYUc0D7UsULUDOj26/7WhHnIdUtVNd3YXM9mm+lT44uqXOVOZauZnozf8GOkZWA/aHUOAe4Xh1Fk1/Tayu0bYdLZRGVcaWUldJ17xjJ9CdhLAD/SUarYkQKfVCJRvvD/kDS9J++4q+RKHYFuwQwWg3eqrj0BCizWNuq3dzs2ZmcdgVFDdi27eBdG7GwgdzsBUBuQ8QEQNCt8AihmBUXcx53o8XUjYY7rIk7eKVE1wCERb7PTjRxN5Mqz84SRpMqAuWWudtAy2M/38Nr64gs16Jhe+z/kJNHWkI5761zswmlrYuZi4SxxW6bNoZ0ZSlrgjuj2NR2lk5nvOuOJryX5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6fmpV98xMSjA/TzZS+skTojFGE620BPdo1l8swHI7k=;
 b=A8iO37Fy+utabOn35/tkG6I5idgokM0cE8fJs0E37S+yjguQTKiAcicX2KrlfLNPTG8SEXulM2BeqyqigXhmcJDxmoWd4gVxhNoa3v5KjDhvfN25CiBa+5vz6wPH8Zkgl++JtuQJvcuxCZclKyzdxJbynoslCfgxo7u+HbCusarkMKrHMONQE87hCbtX6MRm68u2SfdcaWbptTx3NB0H2yX+kxZjE7a1LX++znT4zmaX1BPg0LTM1M09ylOG7JjrfOL9Alsn3+CxHEtV9+d5EiNnIDF2fqHo+Y1OAtFzDceLsLtailivbGJeUGkzYp4UPvlW9jEDV++ABnTZvbC4Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6fmpV98xMSjA/TzZS+skTojFGE620BPdo1l8swHI7k=;
 b=4Js4Usg3BIxIASc0MbAAkuRNEIN5CwCUA0GxPDh/YxddAuMwf7HGydcQ9FMLKHGjG6NJw2O3x6LLcH0Aqj1l4mMDifrAHC4in63BXlkbZoH6eq2Kcc3EGNau8ixcWFWTFfAW4tEH0neIwzcTKBWlavc1S4kuNMlD6t55KEDgg3o=
Received: from SJ0PR05CA0140.namprd05.prod.outlook.com (2603:10b6:a03:33d::25)
 by CH3PR12MB9729.namprd12.prod.outlook.com (2603:10b6:610:253::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 01:42:41 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::af) by SJ0PR05CA0140.outlook.office365.com
 (2603:10b6:a03:33d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.5 via Frontend Transport; Wed, 11
 Nov 2026 01:42:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:42:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:40 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:42:37 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Sreeja Golui <Sreeja.Golui@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 36/74] drm/amd/display: detect static screen state and
 propagate
Date: Wed, 11 Nov 2026 09:28:42 +0800
Message-ID: <20261111014100.3596072-37-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|CH3PR12MB9729:EE_
X-MS-Office365-Filtering-Correlation-Id: ec094b0d-ef2e-4192-4dba-08df3f951328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|261102123227099003|11063799006|261021121427099003|261022105027099003|261026140227099003|261009223027099003|56012099006|261028144727099003|18002099003|22082099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: WYFRRrtqirl99gcdGaidDXbl1dTI4tuJHniB5cEtPdBMXkFTCG0e3Ksd2zDsjDGwj47wHdSG/XnrgNywV1heEQW2NBf7iWW3UgrEf0i1Dg8b3S6oPnuti1i85eyuKKO1dh93m8dqlJPOrvEaibmjTSZwrKIYP+QzmNM49bB04eoUPZKx2sQsb79SONVePOHfOdkGxAFYC42sJv/G5qbfbmACvodzkSZyQbE9KX11MacYqfqszmbo9Fvufvzgt3p3Z+KD2NvwWNqT3VJWi/eCvhX1oVVm3CwuD84hwWGJWb0Q6xnqMCF1OLZYwGyXRZozxfwm5daqrDWwqvkT8K1zLDThIMzqf6CKi2tyN2SsDFxWkfJLRcwiBEgKS2Kun0FHSDAL/NFO2rtFXrqDF3oEPUFW8ds7Y1Ci5po0Nzj6CbNmYFW630x+NlayspFN0z+Z0V0Y/ipp+mEO7iP2hKeC8i60G5sQpp+1MAzU8B3OjvG7MJdlRT5S8Emt0Ck2mgVnHxKPpcRyVEy4x1e3ToWArkmGJTgoNbcjlOT84ZPeDlvAXmndQ6kQwqiKfMBErckFbZw/ldPmRiIbvMq6D3RVh4rxOmnomy4fC9LzSoD7C3+uKA1yVo/Lx05ZXylA/1JCxqXddFQCFSbtKIAZ6rsYVvvD8iu54iNlnxM5unDq2wMGeKy++8S6v00yBuFWIWx3nXlskYHkwXz9B9gmu0CiwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261102123227099003)(11063799006)(261021121427099003)(261022105027099003)(261026140227099003)(261009223027099003)(56012099006)(261028144727099003)(18002099003)(22082099003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5j9JNq/518WRy7GutuGbhbD7a27L7/t34zP5w7RzNGVzjpc2/4jL1bpVuZDXbNONwJiYVlaF3a7CLIy8qkSSC9vD3nlC59Vlssw5Cv2gtG2jbbtsC0lGaTd+7IyvdGiIs1C58ma/E211XlnSF8jiXBJqdBgicRq/JXjfrmiLJU1RTiJNW39qK9KZc7GfXHlhlb8rKEOF0rVHeW9jfcuPFbadBGZ3q2LtSxLoA+oVs4y2IkguYbtCbejmsWeoB1qEeNZZbwHrAhN/w2zB5144JPRqoJxK3okJX0PTsTK3tXAnFdAGRZMtpFuQXEQ5uA18B1irt7HjMxX/AXawKIPEP5MaYQPlMYBo7u2YpCBfBKK3MhbfcoH3Z3MloJcsIFj7Mpbty9JXnAqGqt5c2M+FelOYfiHrma0GGhWiL+0k0c+vGvRACyJH4TboOx1nJhy4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:42:41.2703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec094b0d-ef2e-4192-4dba-08df3f951328
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9729
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

From: Sreeja Golui <Sreeja.Golui@amd.com>

Why:
Need an extra flag to track when vblank is being stretched in idle
scenarios

How:
Track static screen with the new flag and pass it to dml layer.
Requires the DML DRR member and stutter-gate change in dml.

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Sreeja Golui <Sreeja.Golui@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                   | 7 +++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h                 | 3 +++
 .../dml2_wrapper/dml21_wrapper/dml21_translation_helper.c  | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index fd382363a0ea..6f2f219a928a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3300,6 +3300,10 @@ static struct dc_update_descriptor check_update_surfaces_for_stream(
 				stream_update->vrr_active_variable || stream_update->vrr_active_fixed))
 			su_flags->bits.fams_changed = 1;
 
+		/* Static-screen transitions change DML stutter constraints even if VRR stays variable. */
+		if (stream_update->vrr_active_idle_static_screen)
+			su_flags->bits.fams_changed = 1;
+
 		if (stream_update->scaler_sharpener_update) {
 			su_flags->bits.scaler_sharpener = 1;
 			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STREAM);
@@ -3669,6 +3673,9 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->vrr_active_fixed)
 		stream->vrr_active_fixed = *update->vrr_active_fixed;
 
+	if (update->vrr_active_idle_static_screen)
+		stream->vrr_active_idle_static_screen = *update->vrr_active_idle_static_screen;
+
 	if (update->crtc_timing_adjust) {
 		if (stream->adjust.v_total_min != update->crtc_timing_adjust->v_total_min ||
 			stream->adjust.v_total_max != update->crtc_timing_adjust->v_total_max)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 7999a7d84a77..94eccb87cbde 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -256,6 +256,8 @@ struct dc_stream_state {
 	bool vrr_active_variable;
 	bool freesync_on_desktop;
 	bool vrr_active_fixed;
+	/* Ramless Idle static screen; variable VRR still permits cursor boosting. */
+	bool vrr_active_idle_static_screen;
 
 	bool converter_disable_audio;
 	uint8_t qs_bit;
@@ -367,6 +369,7 @@ struct dc_stream_update {
 	bool *allow_freesync;
 	bool *vrr_active_variable;
 	bool *vrr_active_fixed;
+	bool *vrr_active_idle_static_screen;
 
 	struct colorspace_transform *gamut_remap;
 	enum dc_color_space *output_color_space;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
index dc65750a7fe3..2e3ad7152f3f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
@@ -170,6 +170,7 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 	timing->drr_config.enabled = stream->ignore_msa_timing_param;
 	timing->drr_config.drr_active_variable = stream->vrr_active_variable;
 	timing->drr_config.drr_active_fixed = stream->vrr_active_fixed;
+	timing->drr_config.drr_active_idle_static_screen = stream->vrr_active_idle_static_screen;
 	timing->drr_config.disallowed = !stream->allow_freesync;
 
 	/* limit min refresh rate to DC cap */
-- 
2.43.0

