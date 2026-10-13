Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DB4CA9ED2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9150510E7B1;
	Tue, 13 Oct 2026 11:17:23 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013035.outbound.protection.outlook.com
 [40.93.196.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 616C010E7D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg99Lhco+CA6jfWcAi2jJrEGiWOlXauMMOxDSuGgOnnAD3EWVo8iyIk6i5LJ8ogd1qOtBHN3TqslsUQgZjKP9u+TjBxUUJAd5PAPFWdO1XgVXkRVqQsWapmTfmuN0hQ7RTnlCzrMlYYCLuBstsgCxkl9PlPKxWJI1vGGXv0AgUrJ47poYFFdgfhsfTVx07oxjCOzW8On6rohs0wHYUYAmaQJz4kOdWC57tkeL80nxggtFARatZ4yQ0giDTruz6L4YIPilRbdvvrA186Y7CZWcNVAdV4kRCd/9srAW39HWoUX1w49UfX0GFETCKhUAaS74H4pURGnp+v0IzLBwi1ypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVrJj6fWBnT00/KLQ2Y/5NWJWn3N1Tzrx7PPh/9wlok=;
 b=sduVdmhNZ+MbxX8KpUk8OQ1VtibTIZlHw1GseW6JvyH3/Keu5MzqkdIfPAA9VEDjOowt7MbkvoYMEB/Q7lNkg4EM1mJOcKNauzvrVctIWjOxaVgrkBharNdhPOkP2PK2cYOZSuGdE5H/o8PNz4dfckEcMaEP13CfIHkRK9YII0YH4py6VRMZrvA4zuuUBXddYfCBRGhc7Wm8PU70G8X9+u/8OQ/7S85g5oTWa2/1Ryp8+sihMmFPJ7CDmzCgsU/U0KbNPb+YGhawASRDWDgVNdbbQpNoUuMjm2pZ88T2TRGGTLDJbjS0wnuOUq6RVxKSGX9j6oL0e36BHRrIBoUesA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVrJj6fWBnT00/KLQ2Y/5NWJWn3N1Tzrx7PPh/9wlok=;
 b=rFox8nO7D4U/Pq7mb7TVCNTNBm5PvI0NeKK4ii9PGEOCVuTam3pnnAv6pt30KBH6CKYAUOELRDM/DyxY2TsV6UGW+3QG5J6q1zf7C/KChkFZYY2kMKFjC57wYaO23kQPnbZKqtuLOI2vJH/PsTtafti+SfZ81Iu8HR8SgHp8u/E=
Received: from BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::13)
 by SA9PR12MB407125.namprd12.prod.outlook.com (2603:10b6:806:a6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Tue, 13 Oct
 2026 11:17:13 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::12) by BY1P220CA0016.outlook.office365.com
 (2603:10b6:a03:5c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 11:17:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:17:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:16:54 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:16:45 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Piotr Maziarz <piotr.maziarz@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 07/30] drm/amd/display: Gate DP_TRACE_SOURCE_SEQUENCE emission
 on the debug flag
Date: Tue, 13 Oct 2026 19:07:54 +0800
Message-ID: <20261013111616.2267344-8-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|SA9PR12MB407125:EE_
X-MS-Office365-Filtering-Correlation-Id: f03c6958-340d-4315-2493-08df291b87d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|6133799003|18002099003|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: qLn754l/knCxw4c/fEKALFzf5samhIGSYEV3+Pvah0Q/5zPSYi20ZHM/x2Ae5jdlYbPd/nyOkFQ4kwufpfbylqG1ko2QQ6Bb+yNQrwwkMtaXHdhh4v3/k0GaqNKg6SBItFuf6KblhE0r83AISqYhNFXL3iQe2OeSAusQsFTCPeFZPdx3HAB4MSLegceHA/u32afbMXryIxz3TdvahjP222LrgI+luVw6tm/GdZ4qilSiOvSZEqQdZh/Vl4pFYBime1B27xL+4bn5LUZGISUzp5Vm/F0p3yT6+Ogbiin1H9uAktQIJl+woGoWs8+KcGSs1Vrfu+XfklYCUzZGNcWtAkqS9sY6tlt0v0VdXEebiCoO46kiWuDnOyK3S21mdnhuRgoFxrsHuGVxDic3KxFhvXZj8iM9aCcXvantLyJRFhzAhOmXneD4mzRMLFqT8AOneIxHzR61hncwFftjIEADSFfqyRzPWvd9JwGX52/XXp/jf0Yavti0L82491DUuHSgV2H7WYavOQzZ5Vjl+PEFkjU2gkr6PlwdopRxCuJMjJyg/QT9O7ZuQzjm0/AwSrdcrPDZO4OqYxV0EUIpTijiAEOWuKvhVea60wNg3I7PLFT6CKZdsljQwvwQJKstZE5rFz2cPlnOsneLFU/smepCfLtdQQfFHmZlSgfI1E0vxAilaPHliLuwFIuYhme+Njtp4/T8lmWfiEtlAKlXGFEPdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: imr2NKDU9dI/Bb+wohZiz/7EzFhGCr1E2KlS6/Xw1Y8dt8qk5k6fjojY0UG5/GwI27Vn4dkks7WC2kyAjFRJpkpS/zngq8v858dkIwRstoeGgS2bLCjraDBQFCkpndhZ2HNhh9qgoN6xj/Ox8VwkGNsnaPO9AtLq1ewjpAtBiiHiAbgtySrb0I25gIpKvJwC3vK63xm2ZJRifGoNoW8Q68uTqC5WbOGVeraxTaCp7r18PGqbTN74hiIMSUgKyK92RZIkgpikLb5NVOQBJ7hKlIbAnuqchrExdDPYZcSOvP3UJ8KIbfIpA/NmwXTOSFk19OI9CAipjQcV+S2ZCytUlGl42VRH2tg6cnKO+YJU5Buk70VfNljxfLIN6qM95UA7a9P7q9zRpPQh7fG6UhpEIjMmhXXpAUvafeJn9J+2cNOzT/X9WjOu0dDhmF5f1+wR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:17:12.8059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f03c6958-340d-4315-2493-08df291b87d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA9PR12MB407125
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

From: Piotr Maziarz <piotr.maziarz@amd.com>

[Why]
dp_trace_source_sequence() only writes DPCD when
dc->debug.enable_driver_sequence_debug is set, and it reads that flag at
execute time. The step was therefore emitted on every DP flip and then
discarded by the callee whenever the flag was clear. The flag is set once
at init, so the decision belongs in the build phase.

The fast-sequence site also hand-wrote the step, bypassing the bounds
check in hwss_add_dp_trace_source_sequence(), and the golden dumper had
no case for the operation despite core_golden.hpp carrying .source.

[How]
Emit the step only when the signal is DP and the flag is set. The guard
inside dp_trace_source_sequence() stays, as many non-BLS callers rely on
it. Use the bounds-checked helper in hwss_build_fast_sequence(), add the
dumper case, and set the flag in FAST_UPDATE_INFO_FRAME so its golden
still matches.

No functional change when the flag is set.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Piotr Maziarz <piotr.maziarz@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c              |  4 +++-
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 10 ++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 05e8fcc710e3..8cf6edbd39c9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4216,7 +4216,9 @@ static void commit_planes_do_stream_update_sequence(struct dc *dc,
 				resource_build_info_frame(pipe_ctx);
 				add_update_info_frame_sequence(&seq_state, pipe_ctx);
 
-				if (dc_is_dp_signal(pipe_ctx->stream->signal))
+				/* The step only writes DPCD when the debug flag is set, so gate emission on it here. */
+				if (dc_is_dp_signal(pipe_ctx->stream->signal) &&
+						dc->debug.enable_driver_sequence_debug)
 					hwss_add_dp_trace_source_sequence(&seq_state,
 							pipe_ctx->stream->link,
 							DPCD_SOURCE_SEQ_AFTER_UPDATE_INFO_FRAME);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index d6177463c0a0..86957b4d182a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1292,12 +1292,10 @@ void hwss_build_fast_sequence(struct dc *dc,
 		block_sequence[*num_steps].func = HWSS_UPDATE_INFO_FRAME;
 		(*num_steps)++;
 
-		if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
-			block_sequence[*num_steps].params.dp_trace_source_sequence_params.link = pipe_ctx->stream->link;
-			block_sequence[*num_steps].params.dp_trace_source_sequence_params.source = DPCD_SOURCE_SEQ_AFTER_UPDATE_INFO_FRAME;
-			block_sequence[*num_steps].func = DP_TRACE_SOURCE_SEQUENCE;
-			(*num_steps)++;
-		}
+		/* The step only writes DPCD when the debug flag is set, so gate emission on it here. */
+		if (dc_is_dp_signal(pipe_ctx->stream->signal) && dc->debug.enable_driver_sequence_debug)
+			hwss_add_dp_trace_source_sequence(&seq_state, pipe_ctx->stream->link,
+					DPCD_SOURCE_SEQ_AFTER_UPDATE_INFO_FRAME);
 	}
 
 	if (dc->hwss.set_dmdata_attributes && stream->update_flags.bits.dmdata &&
-- 
2.43.0

