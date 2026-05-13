Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB75ACD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B2310EED0;
	Wed, 13 May 2026 14:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pkm8nOly";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012030.outbound.protection.outlook.com
 [40.93.195.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6272B10EEE2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xG3HhBORxpgJJHY+ZXUFdQ4AD1YoQyczSLN8ifNyp9Ylx1UCdhCI0wGLzM4UhpDu4uCx7JRPydTI5DgdoM/BeOCepDI4Ou/bTmQ2DM18XHBeegmDzxhB5pEmLBhBLjVyq5geB/rtfYzsEQbShjAu9drII70c9yxz5jpgc9CE4wQwQfEar5ntO3gMwFuNws2pTtHk7T7zYgzq1PUD/sNcDTRtUqQij7R18j8dOmQwBjWfItmRQK5yceOOQvsjOK8dJTDB3EzvrbdRz7jKAUwRWZWSQbMIDU64p79rFid8HEmRyDhNaMAzh5guPEesbENJlsmodmVXTzvYojfSUT1hEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYm/a3uq2a6UbQycr2gqjrxeKlNVoo2G0LUHXbiMzyQ=;
 b=Us4rL9TlQxy6M9+srtx1Xne5912zY7a8Ij/0khWhkGbuvTczWnNx/D6hv5lU/OPxvwNvQmZ7fiQ/QDzWY/L/oxick1RFSw1WTFPCD+8d8/2gVudnXICEsb4iVl6ZPJfKwc6i9WjVj4Q2kxGBllwLbolliFn0udavuBMp0kKuo6XLMCm4F/ssJTJa7B9vD3EQyU2v83DtzjEyCbhrvLFvqn3eRnMWFUWG7jUztBU1w5nV7iqWg7kcWFUC4ZWgk+hxkLRX5a3NPAzYwMJXqDTzmvUKtKxyZTx6VtPd76zz2Biyzg+Q7sLE/NnEKRABMXAIxHvL19P+OHzw4cjh/MbOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYm/a3uq2a6UbQycr2gqjrxeKlNVoo2G0LUHXbiMzyQ=;
 b=pkm8nOlyVtouDIsSiK+mBkCemr9JLq5g0yoHes6uk8raY+BILwEvWcbxVDmW0s3JfnSGdtURQKPsL7AqWMV4EGW0c5Zse+6OFqRBYY/m9qMAN0awCLqMnMUarCv2TBs0X5nZp20JhMI1ECJFSVcTDYgD794fJ0Na/2XL8kcXF1Q=
Received: from BY3PR05CA0020.namprd05.prod.outlook.com (2603:10b6:a03:254::25)
 by SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:33:49 +0000
Received: from MWH0EPF000C6192.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::7f) by BY3PR05CA0020.outlook.office365.com
 (2603:10b6:a03:254::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 14:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6192.mail.protection.outlook.com (10.167.249.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:40 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:40 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:40 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Leon Huang <Leon.Huang1@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 24/28] drm/amd/display: Add Auxless-ALPM support in VESA Panel
 Replay
Date: Wed, 13 May 2026 10:29:46 -0400
Message-ID: <20260513143213.1852892-26-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6192:EE_|SA1PR12MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: d732d544-5ac8-43d8-7ea0-08deb0fca5cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|22082099003|3023799003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: DwlG5C7vPlb9P0j0hA/b6mMxDmyvlHvftnxBwB17MzwyzFVxhE70dqMihtiO+DpplETF6+nvJDGl9zinkI8faENfD3j+FCM5g5UYEpBLTUXLdcZpztpIFMMDbKVgdYJiZvgIXNwKT77E33rkrqr6zFJDrPkFDI4652ssSx1hznQKwX5bpUmbBRkGzaUi5s+ecTFqt0HS0X1C17/VpS9rd9Jz7la3Z9Jz1LxCAzUGnzY87//rnCRa/j/pW2zTNyewwjOI/+bxi1lqyLAy1r8PZUTViWRx1MZINJSRD63iby5BjlU7vyZ4kZVJqB5aXgSeRq2c5PT3Sy3i+QU2wr/PSbIg71fet0cGlBIUZ+zuMCzH7z8/9bE6JTZEHlVPwQ2i78UBDyPw2k5KRXzaqVpLql/4iSfqUR2S4Ux51O7YBK9HnMbemxU15gTga5ZZQbyfLFRA3i9lkTfX1mFnJD+j9g52wRU87/aPPeXw3aH0513z4EEi1nAYGwAhCHldc8ooxjZUIoNyTDLJE6h6RbNGXB+HESYyhHPNxwTxReed3cqB69pfObm6GVXAcmQjb/7TU80S25p8Tdj3GuIqTeighyjoEyyp/7R9JmySXjjfQDjF+lReWa1bxKr/ksg/sXVhkk/LDyUEj11F8R9/Qi1R2+V+oRbNyQbAbBuxY5qwV3NwGRpH0zyqhHA7HG7ETf2Nikqg/Q6TYCoqmXeZ3Abl6JIguoP6lRat9xRjZofpQYY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(3023799003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZDHcNk6BjyDyevvcN0vDYqk8BkxBwpfEvnNfQW9UCtg4dwOYPu2QYNA01fvEKw2DWfRsBVcAQTQq5wJdancGEKCSrq7ygrdUrH446NXEm/OMVIm6T21n8V7dOoE9TTE4HVQVRC1pJGBmBrCF9QmJTVFraH2qxyXVNcUo+nGsXadU/J9Vwv1PjQ3Q6qOSFXIdehcDGblYILXbUUpkb8+wusvL9C9+64eSXoBJnLBuRYUqVDL/qakpaIshBU0HaUzC325IQzQjyRIM33mTHqqexv2doREF0Qsj71DxW/h9wtfyBKmgjvKVUous4MtuaG7Tl0sqfUXglfYs66Cy+xvG0vj5dBI/olS5+whrQq33kGNmIv9kz2tLcrUIl0VIpHYoJByggxoqbCLQkZOXeAksq+swJeXlapI5TXK2DpgQ0D7ndS618DUuK0hCZcDw1w+8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:49.1757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d732d544-5ac8-43d8-7ea0-08deb0fca5cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6192.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119
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

From: Leon Huang <Leon.Huang1@amd.com>

[How]
Add Auxless-ALPM data in VESA PR initialization

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../dc/link/protocols/link_dp_panel_replay.c        | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
index 72d6e6011a09..d87f87a02d63 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
@@ -321,6 +321,19 @@ bool dp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_con
 	cmd.pr_copy_settings.data.flags.bitfields.dsc_enable_status = (pipe_ctx->stream->timing.flags.DSC == 1);
 	cmd.pr_copy_settings.data.debug.u32All = link->replay_settings.config.debug_flags;
 
+	// ALPM settings
+	cmd.pr_copy_settings.data.flags.bitfields.alpm_mode = (enum dmub_alpm_mode)link->replay_settings.config.alpm_mode;
+	if (link->replay_settings.config.alpm_mode == DC_ALPM_AUXLESS) {
+		cmd.pr_copy_settings.data.auxless_alpm_data.lfps_setup_ns = (uint16_t)dc->debug.auxless_alpm_lfps_setup_ns;
+		cmd.pr_copy_settings.data.auxless_alpm_data.lfps_period_ns = (uint16_t)dc->debug.auxless_alpm_lfps_period_ns;
+		cmd.pr_copy_settings.data.auxless_alpm_data.lfps_silence_ns = (uint16_t)dc->debug.auxless_alpm_lfps_silence_ns;
+		cmd.pr_copy_settings.data.auxless_alpm_data.lfps_t1_t2_override_us =
+			(uint16_t)dc->debug.auxless_alpm_lfps_t1t2_us;
+		cmd.pr_copy_settings.data.auxless_alpm_data.lfps_t1_t2_offset_us =
+			(uint16_t)dc->debug.auxless_alpm_lfps_t1t2_offset_us;
+		cmd.pr_copy_settings.data.auxless_alpm_data.lttpr_count = link->dc->link_srv->dp_get_lttpr_count(link);
+	}
+
 	cmd.pr_copy_settings.data.su_granularity_needed = link->dpcd_caps.vesa_replay_caps.bits.PR_SU_GRANULARITY_NEEDED;
 	cmd.pr_copy_settings.data.su_x_granularity = link->dpcd_caps.vesa_replay_su_info.pr_su_x_granularity;
 	cmd.pr_copy_settings.data.su_y_granularity = link->dpcd_caps.vesa_replay_su_info.pr_su_y_granularity;
-- 
2.43.0

