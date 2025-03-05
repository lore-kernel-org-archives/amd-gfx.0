Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF37C19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5ECB10E0C2;
	Wed,  5 Mar 2025 05:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pG89NqET";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B766010E0C2
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4mR3AFrlIRE79HG9lSC/NPTWFmY/ggA0E6g/vMEtDOhmTKPrx7ayQidHvWfo20CRy0m+90tI29U6ti6q1Qd6kf1ar0ItoktXdIt1bYz4k1GtHHAJYj0T5Jr1m0D9opQ886rTbZiHi8IHChvE/jOZSJndQX87J7a2SHAFWj6EYURn+LWGmHj48NQZjQWrIHM8ECZI89M32o19KZGFHEUmZASS94Agn29DQrd4rXRjVJCX6XeFKovPGfR6RvONE6IMkzbp5Nyz6mZnZBjasoAYTgWnUXzgS1TdNzZMTzEwGJg8Dw5Ht9kjKy/1xu83c9pHAnAZQM7OCe6x3mWYYE0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FheW7w7lpz8oCrngc9ikgj3M/ucM4FHN7iVps3hT/P8=;
 b=UJgaiPAbPWTi3I0TZi00TJ+iSmySuWl0TxU9Gl+/kWukrChNrWmbPChrmmSBED9fjP0EM5re50aHmQuirgPctUlyKFcTMUWkgpcsDMofcv9FkxJbarGuHx4ocGclAkXUa8r8QRuJA48kRT7Wa5prm5FRSKGWy5IHPSsJuhnXYXsLoI5yvoIQCkHCugwNZbdJeguMcqYcB3WfTGUdrziVEnqvemekr6HtbsmKGSqpIvayTeAIvjy6KDzNH1fzhCyzeceutcJZYNQbiDxs8NY+p7/pskbjmjUuzMW0vfVcYoMHmiF96mOobatQ5i5bEKY3ZWIrBhWnSbM916dme2Feog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FheW7w7lpz8oCrngc9ikgj3M/ucM4FHN7iVps3hT/P8=;
 b=pG89NqET7C8LIvlC6EugXHtzs+r2vp6qeJPRZuwWLpAmxYr7YA4aQtNJvSskvkgbD68tfWFibAKieCdv6+kIdhIDCjhxxr4hAWl9M/adu4x5gei0nGPexzoxAZZ1vjQtX91/h1Lj7OWOQRohg2A8UFfguRTX1uX52aJJ9S+h1rc=
Received: from BN7PR06CA0054.namprd06.prod.outlook.com (2603:10b6:408:34::31)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Wed, 5 Mar 2025 05:14:45 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:34:cafe::32) by BN7PR06CA0054.outlook.office365.com
 (2603:10b6:408:34::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:14:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:14:43 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:14:21 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:14:17 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Leon Huang <Leon.Huang1@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 01/22] drm/amd/display: Fix incorrect DPCD configs while
 Replay/PSR switch
Date: Wed, 5 Mar 2025 13:13:41 +0800
Message-ID: <20250305051402.1550046-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ba61db-9c39-4244-aaaf-08dd5ba4a48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aq0K7WYvw92QTLfztKMjbZ+opBqxoXa9iPuHrmzMZTlSdkHKLLMjCGsO+NRv?=
 =?us-ascii?Q?jap9cXddWGvfDJFx7va61FC6olPTvRxIREY8eszd6F+TUak4yeQ/ryTNkx5W?=
 =?us-ascii?Q?/W84k4R4o0n5eKZT1AVmsXA0bKfItgLCuXkKWz6igBtxB/UX6ITuRPEQbOFj?=
 =?us-ascii?Q?11VtVEYC6tqt0iZ8m5vT1IGrawX5/pGbjr3+olD6YCc4L1iZpTIQJyWwqq2O?=
 =?us-ascii?Q?FzL/h35heqgctqM5Yp5uHb5hYAyWUALCqHwJVfmxm6NyJ5DQRUgQ3VRwY8KR?=
 =?us-ascii?Q?5vYOsc2M5F81sx1Z3PbUjjXk9cAhcemtYwy/qstxGYAURYOSsoY/suMBXKSV?=
 =?us-ascii?Q?P3eV+dAtWW8odoig9sahUforhsWDlR8Dm30O8bAAqGUds4Shq0FqFg9Y5wZw?=
 =?us-ascii?Q?FOrHD8sGQW8Kz7SAs7pef/VL05FAQiBLQkIPtQtZiacPZ/O+KTxMdruAgB8+?=
 =?us-ascii?Q?O+5i931mIrmddP0Q/3QT5o9eGQQaAOioQVz7AwBATl8S6kioycewj0uRIMKl?=
 =?us-ascii?Q?HH++ew2Gk0YsID9btALMDHBrBAmA8jyKIVg3AJUZFGQr/RCfwSPclDQPqq0I?=
 =?us-ascii?Q?j2f9a11wVWgM2lO+AZz1h+k8xAiUP/R84SksKCx67DXhQbeV5lJPvTpo29js?=
 =?us-ascii?Q?bAQMiRWy6uS11rvidSS6tnaLzxExEDhNCr9fusHNlc6/5TzqDD8h0R4jHE2+?=
 =?us-ascii?Q?xT8hmjxZiTgm5tgJ9ZLJvVOgrcOIeqxXj33l9jV9teJ8RAK3d/kjQAKwXoCl?=
 =?us-ascii?Q?FfwpWrR96mSi5CT9BQOF76ZjEHsPLqhLhvGrFV1OONXrjxuDckn9o7E9s5u5?=
 =?us-ascii?Q?jworoqUTk4npFICI7QtNuU8Kxy8x8UpRUjdr2kAvQb/CdFlb5jOY3qTkuG3z?=
 =?us-ascii?Q?NzBJIrtW5hyTrS/Ektvh9+PsMVqVpOAv2cchsL/LAjMwudXA+Ip9oNMfU3wx?=
 =?us-ascii?Q?QzlUSkJs4ApahbgbMnKOm8pC44ehL/Ml5GLxvDJFPasOOMQvsDhWwAHyjKMF?=
 =?us-ascii?Q?Aq1HCVImwrlTy/W/Pr/ovc8DrQHfH2SF7ONNC/YLbRoff3HLcYHLwuNzzNCV?=
 =?us-ascii?Q?P7MTAU/0tQwaeWSKbX14/px5wEnBtiZ55+N14iGFQ8E57R326zFsfpVAoRTF?=
 =?us-ascii?Q?ZRF+czhC7PcUYIu89ORXaJohaXT/EQnfPA/A5ORfhtM2Jcwx9N98jNHMDwwn?=
 =?us-ascii?Q?vHrHqRpaFyqM0s1uKmLOfl91opkDrKoj0x5CCej5pF6N/B/e/xrQAdmKl20G?=
 =?us-ascii?Q?iougrhjzq7sckooGguyCsoyOyTqonc0Bk3dB7JJmaMsrqQ/F9fBkQklbQUM9?=
 =?us-ascii?Q?pafay/03j823hGCynwFAnMkiugCqnLQvakMOOpxHLw1wpTSZ4mHlfQ/oMxVe?=
 =?us-ascii?Q?cJRXuLp6JHo2ZgQmzAJuQB5kd52vpPRnFGlePz+EmQHNNjj5NKwQGmPoLzxo?=
 =?us-ascii?Q?++rlgWboXte2k7T4CV5J4cLh0yzdjG/jjFugxHZNqKGChi/rAVTd9EllHE/f?=
 =?us-ascii?Q?y4DCk9mHy+/IngM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:14:44.9652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ba61db-9c39-4244-aaaf-08dd5ba4a48f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
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

[Why]
When switching between PSR/Replay,
the DPCD config of previous mode is not cleared,
resulting in unexpected behavior in TCON.

[How]
Initialize the DPCD in setup function

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../link/protocols/link_edp_panel_control.c   | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index e0e3bb865359..1e4adbc764ea 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -675,6 +675,18 @@ bool edp_setup_psr(struct dc_link *link,
 	if (!link)
 		return false;
 
+	//Clear PSR cfg
+	memset(&psr_configuration, 0, sizeof(psr_configuration));
+	dm_helpers_dp_write_dpcd(
+		link->ctx,
+		link,
+		DP_PSR_EN_CFG,
+		&psr_configuration.raw,
+		sizeof(psr_configuration.raw));
+
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED)
+		return false;
+
 	dc = link->ctx->dc;
 	dmcu = dc->res_pool->dmcu;
 	psr = dc->res_pool->psr;
@@ -685,9 +697,6 @@ bool edp_setup_psr(struct dc_link *link,
 	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
 		return false;
 
-
-	memset(&psr_configuration, 0, sizeof(psr_configuration));
-
 	psr_configuration.bits.ENABLE                    = 1;
 	psr_configuration.bits.CRC_VERIFICATION          = 1;
 	psr_configuration.bits.FRAME_CAPTURE_INDICATION  =
@@ -950,6 +959,16 @@ bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream
 	if (!link)
 		return false;
 
+	//Clear Replay config
+	dm_helpers_dp_write_dpcd(link->ctx, link,
+		DP_SINK_PR_ENABLE_AND_CONFIGURATION,
+		(uint8_t *)&(replay_config.raw), sizeof(uint8_t));
+
+	if (!(link->replay_settings.config.replay_supported))
+		return false;
+
+	link->replay_settings.config.replay_error_status.raw = 0;
+
 	dc = link->ctx->dc;
 
 	replay = dc->res_pool->replay;
-- 
2.34.1

