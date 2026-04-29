Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30B8FF885A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 01:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4783410E3B7;
	Wed, 29 Apr 2026 01:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WPojL8xt";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F7DD10E3B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 01:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBoa+USd8r6RbadGfC5SVp/C/ho8En0C4x6fkFInnipxrlZcSFrsWTun+s+idMzjMS3vKI6zh2i0xIM5Q1K/Oqud7pIp9mhAk2eMG21auwqPULP6St+Naaxrjhwz96trrMVgN7QwuiJ72lbEVJMG0XlkFeUgJj8xNnOZpJ+iAbuNS417GrRSbsSijKlNIvZRhy4yksiIFqiWlzsFLpb8PXb5ezhbmnvX8UDqZV+R66uMjmBqebRNZ0Qb4y3lA1ccUiQUEWrGbH0yU1jJk9lKYWr6+t6ad2ydOsmRbl+gbt8ZfS9Q8G4VGt0d/0YRMYFtekJ6zSky4/hTboI9dkQlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e31Lp18Qahs3UhTHKgwV+x4AJpOUudUT2ai0SnUAvt8=;
 b=qLH8Nw1DDJyq/QYxnyA/AH+CtrJMBldL5EzLJnP0yFAdyEcLUVYQWYvy8IiWcZ3CapNzOyd96gAT3TutC+2h8I9ssWTRPbiYACPmVKmyGzPEvuhemugWPqBOmvMyOtX34tCEPyI7SHGyJu8/5nlf2a+0IPPUk1NHeBiT/G2wmRHDV9dyWX4/zEpY2fv77aFz/elvS9qauPl9wQmniDAdTQr9DXkCVRSGDMFk6D29v+r3m4agtHP3afEngIIeEdYzHMNibQxpwW/2q1ZBwesD+vqcvOQa+lJdU3UI7rD4NJ/jXCPZtaO5LxK4EG+PGihGOsox9cWFJP8aYYUaPTLMmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e31Lp18Qahs3UhTHKgwV+x4AJpOUudUT2ai0SnUAvt8=;
 b=WPojL8xtzNI6qfbr35CJLCxqCUwpsnIonkUIsHv+lmz7j5bUY5zD51ts3t1bFVxLZvLHFve7ByCPeLwh2IJqVOlCTlzCCaOoDs1B2fGa7w5ZJdtCnox8+UdpVEZ1I5PUP1ecIq3vfCNahr8woWa6X+VOntvO+3aYYNkd6xx8yq8=
Received: from MN2PR22CA0020.namprd22.prod.outlook.com (2603:10b6:208:238::25)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 01:53:47 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::c6) by MN2PR22CA0020.outlook.office365.com
 (2603:10b6:208:238::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 01:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 01:53:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 20:53:45 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Tue, 28 Apr 2026 20:53:37 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 12/17] drm/amd/display: Find link encoder for flexible DIG
 mapping cases
Date: Wed, 29 Apr 2026 09:19:21 +0800
Message-ID: <20260429012055.2065869-13-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429012055.2065869-1-PingLei.Lin@amd.com>
References: <20260429012055.2065869-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e7c77c-3570-4b59-9901-08dea5922683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: n4BJQ9pwp+mKbZBaehFtEogfUh9Z2jNwdkG8ZFgr6DkrT+wuRzH9kZgYDnmozx00fSeBkAWHL+ruv+7Ng1+8lQhD9qQaK4/+pwtpj3bwcST0ISf/YWSU7tNkOv2xRsKDI0Pz3ahf6dDoOwaJt0XjFJrMm+e0WgTRGgLjniIvbhfR7fRTQlfIkzKz/WlZsCIGJW4E/wuvc/TxtAsgVD7zOQXYQAFuacGSGVAW+XRcCWaQLmty+BUbYHRPoMtL8ur0A28lUJZraCVPNG+2w1GN/ry6gYarCcMVNYgVIT1fXvTN7cP3G5+Fstnd2e2NcpnfkmQ+BLxdAkyhEjycvHb3eQtGFBpPyxAwI7bJ21L23U0VOjLA5tzA9KelIOAd6CC0/adjIJeZBrjKuy7FonQgpB8BJSKVWHS/Fyc4gR+rTNo7rdYH10u8JnCUlvoU5609xad2O/+pHGTSsYDjUqRwdYQuRGdADVC1/Vwb9TPH0G5AgF7CRXZBZ83FMfi0T0dWEIPF8U73W7M6kpbnybwvkYEtdI71DXQyrg/kmjmFzrx5x93o1Cf5pf3QNgdeso+eoDvp5+7Y089ikAVEFBNTZlzIOFV9eKqvbqIaH1TIuqAFQVR176LCYrqj5c0t55PZ2P7x9xA3EeOOtK2WaKblmw8hJJYW3QLH6A0YCCAvD752nnEUsOfLKH9Z3Zd1cpbtqzM1cnqGu91HZhbsXyo9I923pnsJOx8KFPaZCVOV2RT9W1JE399vjZMuDOmdLNQ1tx8SN5O9zv4tBqTT5eeRTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4lP98ReBTlKOi6u+u9FbtS/PrfaJ5FYLBBQ1tJ/HoPTvbaeIzIo4M2N1BAPxaDi3q7T+C95B1vFpzqsFduS4EtILsK8KfBOGd1ZerZ+6CaRbrZjjCh+dQ207y0nZE5CaKvBjB6fLfgJvXnvAz4yjoEqV0GNVZbLIFH6VYJZv9vCyViitBulUEePqORrUnzAzB+CGk02zaM/Z2zQWatrrZRJPBOffuKGNa18FVekyTowpgPiD13PiC7gU2gPtoZwQks0trOklA6I0Ztqds5L/C5+gZ1XAeMWgvmWocPutfukQYllQC9HfvVmtpV2ksUnO00f+QR/rwcgUKH+4d6Yu8wx1MqLLRrTD9oQqrfU2rjQRLG7/v6p5WPPCXJPZ3eTzQHV6ilfmDbVWIUnm8P20rEziiYOejQVowMaGuQH3DAh7NrIYZrBZl1olMWnMFjjX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 01:53:46.2725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e7c77c-3570-4b59-9901-08dea5922683
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why & how]
link->link_enc can only be used to identify the link's link encoder
when the link is not permitted to use flexible link encoder
assignments.

Use the correct function for identifying link encoder and add
function pointer guards before calling them.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c    | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 921e70c14346..d81271b870bb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1787,20 +1787,22 @@ static void power_down_encoders(struct dc *dc)
 
 	for (i = 0; i < dc->link_count; i++) {
 		struct dc_link *link = dc->links[i];
-		struct link_encoder *link_enc = link->link_enc;
+		struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
 		enum signal_type signal = link->connector_signal;
 
 		dc->link_srv->blank_dp_stream(link, false);
 		if (signal != SIGNAL_TYPE_EDP)
 			signal = SIGNAL_TYPE_NONE;
 
-		if (link->ep_type == DISPLAY_ENDPOINT_PHY)
+		if (link->ep_type == DISPLAY_ENDPOINT_PHY && link_enc)
 			link_enc->funcs->disable_output(link_enc, signal);
 
 		if (link->fec_state == dc_link_fec_enabled) {
-			link_enc->funcs->fec_set_enable(link_enc, false);
-			link_enc->funcs->fec_set_ready(link_enc, false);
-			link->fec_state = dc_link_fec_not_ready;
+			if (link_enc && link_enc->funcs->fec_set_enable && link_enc->funcs->fec_set_ready) {
+				link_enc->funcs->fec_set_enable(link_enc, false);
+				link_enc->funcs->fec_set_ready(link_enc, false);
+				link->fec_state = dc_link_fec_not_ready;
+			}
 		}
 
 		link->link_status.link_active = false;
-- 
2.43.0

