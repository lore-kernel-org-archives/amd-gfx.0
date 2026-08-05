Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD39C561E6
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 475CC10ED06;
	Wed,  5 Aug 2026 06:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RMYuD27y";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35CED10ED01
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voUw63+ghLwTGw/g8JVUtkJuUYfqm+jjvdwc5urarLwZ7zWUeB0UYeMPO6fPGCImZ88iBPcdN/Mx8jK40fFjeLOzHjOr3UYUTtU21DASCo5z549iQGTg4EvVoGv9I+15x8XaiYWV/P8g+6C1cTUN1sNXyCxyGE9IpGab2rUbOAOhX1DcI2EWhVdpCV5ilMAZQMFILzeDAl9VqQwDb2Ns4i3MfzHlYjhrGHmak/7S5jryJ2cMLlc4U6C+sEVBlu1zbcyPlgDigb26Uu/4NQOcpZwFm40F546jJ822yejPxPoYyG/9Fp8At7yIjHwewMlSlXWNtyghBB82uAN8drdNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx/VY6ubv2e3jEmHwLNx8wODfGltrp/OfXp5qzIZyqI=;
 b=l106gosEJ+OSewK/YaP06I3PFxolwWNl3ACeaqfPeGixXi6pXqIRomrPg7dLtYFlukCbW19YPJDNhWHImmM8V8faYOtWiKMFJntm5uXW97qa8YaTCXKJd5IYeD80Zq7jfkyFXju5etHCy9db2OwG0Kgv+EEqg4NXzcSgcEKrLYrB03f5+gLLdIYsonvsc8Ex535PVpFJTsACZ0hb5yEJoz1Sl6L6suC/4EPAatWWhDqA60K+ca/ORRNIMyj0K+Bt59ChhZZkoGrw4y71FXjmt1W6QrwgWAT9y1QEVvsalr7LVY5/ln0K7t60niWWiNh7YQ3cdyumLEZ7x2WQ4VuVpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx/VY6ubv2e3jEmHwLNx8wODfGltrp/OfXp5qzIZyqI=;
 b=RMYuD27y8iKVbHMLzwJq2ozjyDFgxJeu+lXtn66XGDWUhCm8VzzHWO1ewmKnSqBB4yVzn5tEQYqTIkDUay0NRQlKkvawfGo94sgJM9iqp9rQ5iPc/pfE1orAPuEYdbUB+U6rclxse95oRyTLZ3YVogEV5iyC1JekEf9b4eaaRck=
Received: from SJ0PR13CA0103.namprd13.prod.outlook.com (2603:10b6:a03:2c5::18)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 06:40:32 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::19) by SJ0PR13CA0103.outlook.office365.com
 (2603:10b6:a03:2c5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 06:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:40:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:30 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:40:26 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>
Subject: [PATCH 10/34] drm/amd/display: clamp force_min_dcfclk to dcn42b range
Date: Wed, 5 Aug 2026 14:36:22 +0800
Message-ID: <20260805063937.2145774-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|DS7PR12MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: f80fe062-d1cc-4a20-b0fe-08def2bc7278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: gCWpjQDNanxbdV4u25MF6hFlM0Nwn4DXP/NDJ6AXoFC17oq0M/zNDKptmjmb6zoyDZZ7xrR8+1ZJyEYSaWlvVaV6/czSZcEfVPEd/HryiRSEyYUuo3QdcOQi2tFy3S1suyNw76CV6+R1wgdMkx9w3DZnzgwtmVepL6nHC2BhUHoGe2Z3tU8whabtBjvteQb1rY2xlvCBVOvB3w8CmqX1GrT+mSR9hqBtYchksOtP0UyJhn/QirYL4zKP+ZwXtPCV04s0m7wjgZnjkubCZA+9ZcsrAOm85YShXa9TJitFbDJSMJ3YW0wNL5U4S1GK0oJ/JJRez4iEVTqBaxhstveCKdRM6C2YJ2ExReONH+uCCPUB6StOikZBBlRoK1+WrTnR/kyPSWAu/N/zHVLpCqgmltZViDuV671qjV/9pxBUq4isZc96Z+j3LViJS0rd6/y/ihjPqXCClf2e8003h7488N4/O/tk/WN9Oygr8DC9lTv07nww8vSFuibzuLydty1SDMad4o9r/2Sc3sJn+47yXg4oW85Pj/ng3ygSIISnLP9myW8xSnIT1YGXUdmIn6Fup7ItlEbjz2nBPumuSJYhaUIJuFzN8n/jqNS6opq4pjIX0bbxwEUFDiJNINPoRp4odcW2MYezn7sYXtDfEzYqpIEUspXuqWzhfC8v1dKQWlPO0TkABwnmgNJDKhuk1rnvHww1roRBVasOKRcLfFmGjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FkX7pWxDGYVvBNk3JT0Aunjo5VDwOIAOVzcl5Xi/PjKRUMFMoszeQsbkIRSZaoBF9/g9BKq8aYMv5GveM2UPDvqd2k00Wu7zUhLq23OFY7A3T0geL5aZC7rw+Rg7G4sf2kzElbmMfUSJ3JTJyxmDJZe9acUamUFPFWEPg8LP3P7T361s/PVPxtY3QFex0oBGoAXGioY7SB+JNkzOG6fwwSvEvaAwvDylZVplzN7jmnjhGscFyEZkQRUjMMVrM8feO898dhEIuGRMZaBpBX96P2udAlDeenh9P0imM/Yxl+EXl3mJklIGlU9FCYGgw6yp6K3s7ChWjxe8ANiLbj2PWPe3ovr4af2zOPIAFMtEEUkbDnxMQXCwcK6I5HLFU5mHls1Aob6aFlodz6j+5iTxJSXZBEWUFirmvIT0hvwdA6MPXK0BrCVsp9v9uWdqtg+L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:40:32.0705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f80fe062-d1cc-4a20-b0fe-08def2bc7278
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934
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

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
The force_min_dcfclk_mhz debug option can request a DCFCLK
outside the dcn42b hardware limits, which risks driving the
clock below its minimum or above its maximum.

[How]
Add a dcn42b_update_clocks wrapper that clamps
force_min_dcfclk_mhz to [200, 600] MHz (0 leaves it disabled)
before calling the shared dcn42_update_clocks, keeping the
clamp specific to dcn42b, and wire it into the dcn42b clk_mgr
funcs.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
index 2c2ba09221e4..770b2351c631 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
@@ -389,14 +389,38 @@ uint32_t dcn42b_get_clock_freq_from_clkip(struct clk_mgr *clk_mgr_base, enum clo
 	return (uint32_t)clock_freq_mhz;
 }
 
-/* dcn42b_get_dispclk_from_dentist removed: reuse dcn42_get_dispclk_from_dentist.
- * DENTIST_DISPCLK_CNTL is a DCN register with the same offset on both dcn42 and dcn42b.
+#define DCN42B_MIN_DCFCLK_MHZ 200
+#define DCN42B_MAX_DCFCLK_MHZ 600
+
+/*
+ * dcn42b_update_clocks - DCN42B wrapper around dcn42_update_clocks.
+ *
+ * Sanitizes the user-requested force-min-DCFCLK override
+ * (DalForceMinDcFclkMhz -> dc->debug.force_min_dcfclk_mhz) to the DCN42B
+ * supported DCFCLK range before delegating to the shared dcn42_update_clocks(),
+ * which applies the floor to new_clocks->dcfclk_khz. Clamping here (rather than
+ * in the shared dcn42 path) keeps the [200, 600] MHz limit DCN42B-specific.
  */
+static void dcn42b_update_clocks(struct clk_mgr *clk_mgr_base,
+			struct dc_state *context,
+			bool safe_to_lower)
+{
+	struct dc *dc = clk_mgr_base->ctx->dc;
+
+	if (dc->debug.force_min_dcfclk_mhz > 0) {
+		if (dc->debug.force_min_dcfclk_mhz < DCN42B_MIN_DCFCLK_MHZ)
+			dc->debug.force_min_dcfclk_mhz = DCN42B_MIN_DCFCLK_MHZ;
+		else if (dc->debug.force_min_dcfclk_mhz > DCN42B_MAX_DCFCLK_MHZ)
+			dc->debug.force_min_dcfclk_mhz = DCN42B_MAX_DCFCLK_MHZ;
+	}
+
+	dcn42_update_clocks(clk_mgr_base, context, safe_to_lower);
+}
 
 static struct clk_mgr_funcs dcn42b_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
-	.update_clocks = dcn42_update_clocks,
+	.update_clocks = dcn42b_update_clocks,
 	.init_clocks = dcn42b_init_clocks,
 	.enable_pme_wa = dcn42_enable_pme_wa,
 	.are_clock_states_equal = dcn42_are_clock_states_equal,
-- 
2.43.0

