Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DEFC35FFC
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 17:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4861F10E56C;
	Wed, 19 Mar 2025 17:57:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UYuyTIbD";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B722510E564
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 17:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pr3AXAieHg+9jgWHv6KIPa9Sy18D5UI1RjqPYSUo+MRW2S9DLxLHqZZBBsfW4wypkes04v6+FnRec1l542v1tIYXkzkfwr13zFN3im6U0JuIHt/7T9OIM+NUqHOhJi/iJ7+xe2krPssLvNUP1iTab3JgCrhukrGxiG6EZcvcNMFSJdNi3xARmi29qxx8h9sHDBrhQBQ7WjXKcObqjo6hBQ6+He24VEQsNR5OhwOQnN/8nB5UeDoRr85TcPj2G1UnZS49ZQA6CBQMcoHYqTxMJ0TXukqbnPsYX3mJbQj0znvRbAF2AK6tX4JxAa0W1sr9Ksd+5ULEy/yHqyOFchX6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJs9rNyDCvzbYuVjvYq+Xg1+GnLL+4rrD1HTp+VoBKo=;
 b=raV3WLicFmF2fwpd8rQiGinUvaERj+JVi5Ie5EX9AqNnm+BxtpQfKe8oK0xygs/OBX4TTFBChNQUhvdRqouoiZ2m7hwTcV7PCTr8bPkNANlOpcDA3yxLznhhOjVIzOQdbaUULbfeKpkBZtkisQLS0SANlznnSHJwGEKdfb+lvOszVTkQJSt5lZKi+qd+V8RRw3XsZk3RhKOm/qluhLnjqpIFtt28ZP3rUYtUkMMsglZNnTgQDe986uaPPLzA3OU4hGWAMzAH7drA85SiJUChcUfKQJuq6R+YiS8haZHvQ2irWSBIgqT+HHgwb6kgCz9OQ86yruNipbw1wgdFT0cOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJs9rNyDCvzbYuVjvYq+Xg1+GnLL+4rrD1HTp+VoBKo=;
 b=UYuyTIbD4fQuofwyE56JiGWWYiJjfJTZROE3gOuyfZ8RFQPl1b0cuTTtUW9AYLA2i88BjtMvjXszKcIrl+zc8XaGXvD4az19GjSOPdH38t3Fgh0fVWHkKIz74ioa+GQdCXs8do2PdiL0xVTgnBnh+2QTws5CH7BDr1djV4CQ/cw=
Received: from BYAPR21CA0020.namprd21.prod.outlook.com (2603:10b6:a03:114::30)
 by DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 17:57:24 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:114:cafe::f4) by BYAPR21CA0020.outlook.office365.com
 (2603:10b6:a03:114::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.8 via Frontend Transport; Wed,
 19 Mar 2025 17:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Wed, 19 Mar 2025 17:57:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:22 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 12:57:21 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 05/16] drm/amd/display: Increase vblank offdelay for PSR panels
Date: Wed, 19 Mar 2025 13:55:10 -0400
Message-ID: <20250319175718.2578234-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
References: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 644148d7-b92a-4938-c196-08dd670f80bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|30052699003|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?22laEDiRLzwgmk/dn1+ietYfjKhJhGITkqhbfO4oCtLcJf5q3tcihJI3Iklq?=
 =?us-ascii?Q?/wNJYSI6J4oduoemcTD9qDZy7Md+2H+w/q1GQV22fso5cqWTlalhJT+dafkz?=
 =?us-ascii?Q?AQOG/iI1cpyT1R0vFvf+F+hRz1IvTOfsnWuytHngFv6xwreV3zfSHqPyh2NI?=
 =?us-ascii?Q?HjLXksKIYoeALrqPzUeYoT4IJydyAb4oZp0Mc7rNvUtl6Ab/bOaTvTNUQGDf?=
 =?us-ascii?Q?JvWeQhfb/7iekr7t02Mx+/m+3Ym7zr/qsuaoLDlvVuey3RRnxGr/lOIhi8Qb?=
 =?us-ascii?Q?m8G8p5l4kvaMlUobotxE0ooU01UotAfB9al9GCYGAy0xiD5zPqIQ4S1UQMXv?=
 =?us-ascii?Q?CVqM6bHbWJ+yOKkar5rUY9IdD2zEHXKAR5jZd9bIuZFwLSRyZ4ft5pS262jY?=
 =?us-ascii?Q?IB19jnmmjF29TjyGw/RLnRukpL4pxzafGhaLWd1JCGjSg5Ep+z6Z4QLyCWNC?=
 =?us-ascii?Q?t38ObUW66SuSzNJgj5KL80igLyb6o6YLcdC3piSds2CTpbtpWYEraGkN7d+n?=
 =?us-ascii?Q?MIo3P52dpYCGNfP3AeWbpQM7mTCq1HCTlOeMqeRoBpxMzGsAqQo5dBD6G070?=
 =?us-ascii?Q?okWlULRFfDA6TPUC7/Ee0Rmo+N95Qb6BT+KAKDbHMjAT9v1hOzTBehOlLOLj?=
 =?us-ascii?Q?opw031lv/DIlJB1FIxoxAStB6x7qIpWrjUwqPVnn6hn1J9ISmQ6KeO3JcBff?=
 =?us-ascii?Q?7WCk/6ChDM9UAllB1SYog8lSx09IcWviAvXNpcAd8+VtVieXVVifjMoC+SIa?=
 =?us-ascii?Q?/6/qPRYAvfM6Y3JbC/jsnyXGlncAD3XYW4P51ss11pj0Zhh+VsWel6UvWen2?=
 =?us-ascii?Q?x3qLyvWft3jX3E3qrUAUh8iQKBPclqeEyj2gast7N0EU/ONg5RHwkn0mnake?=
 =?us-ascii?Q?y8l6B0Fr8PXTAvCwKED1OdM3xXpzOP84k6X36+gpyEZmz1Jygm1gjVLoSdta?=
 =?us-ascii?Q?lA7Qlj3fGWxgFK1iR9O3+We1Pt40L2gHVnaAPtG+L+5xIrdTeLLzo2jgowZc?=
 =?us-ascii?Q?WX4Nj4Oc5Uyjlnu23UiXxZEUv/HVqTpb1loXj0PGtiPrLafOgv29iI5ADRxV?=
 =?us-ascii?Q?WDegU4S3g6v7+46P/2CbcJQJ8k1Pin9jI1VaV+0CtwEupLJ6XcujV0BMyzGk?=
 =?us-ascii?Q?jKSitJZ1WwjxQvtHDAVxCW/s41CYftUBMLRcUbSPlG3aYoMlZiuMfBiGX9GB?=
 =?us-ascii?Q?bhAB0cifS1+UM7toPN0NzIN173RvcxCvkDQaezlgwqr7UtLGp1yxTEQUWcBQ?=
 =?us-ascii?Q?Jmwku3p0rBGZ1ap0DgNffE2kIaqc+0O9iG/X8zywFHv/UVq79qhXmmx+778i?=
 =?us-ascii?Q?XMqu/ZIur0ACXkom+Oydxe76NBwoVmAkNhBOpSLcUBT37+ZaZ1/S3m6wEmSH?=
 =?us-ascii?Q?EF3mNiw2GduvvBYhETWYf6MRuDowdXIphqvy6yralvb9FrAWbHtXsBgsl1sz?=
 =?us-ascii?Q?ctLhQapvNgW6WwRo9bcI002CY7bW6dgc1Ma3sLJf7PMf08to3h1qDw/h4tNF?=
 =?us-ascii?Q?+zhRMJKFXtrQ7JM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(30052699003)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:57:23.6875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 644148d7-b92a-4938-c196-08dd670f80bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

Depending on when the HW latching event (vupdate) of double-buffered
registers happen relative to the PSR SDP (signals panel psr enter/exit)
deadline, and how bad the Panel clock has drifted since the last ALPM
off event, there can be up to 3 frames of delay between sending the PSR
exit cmd to DMUB fw, and when the panel starts displaying live frames.
This can manifest as micro-stuttering when userspace commit patterns
cause rapid toggling of the DRM vblank counter, since PSR enter/exit is
hooked up to DRM vblank disable/enable respectively.

In the ideal world, the panel should present the live frame immediately
on PSR exit cmd. But due to HW design and PSR limitations, immediate
exit can only happen by chance, when:

1. PSR exit cmd is ack'd by FW before HW latching (vupdate) event, and
2. Panel's SDP deadline -- determined by it's PSR Start Delay in DPCD
  71h -- is after the vupdate event. The PSR exit SDP can then be sent
  immediately after HW latches. Otherwise, we have to wait 1 frame. And
3. There is negligible drift between the panel's clock and source clock.
  Otherwise, there can be up to 1 frame of drift.

Note that this delay is not expected with Panel Replay.

[How]

Since PSR power savings can be quite substantial, and there are a lot of
systems in the wild with PSR panels, It'll be nice to have a middle
ground that balances user experience with power savings.

A simple way to achieve this is by extending the vblank offdelay, such
that additional PSR exit delays will be less perceivable.

We can set:

   20/100 * offdelay_ms = 3_frames_ms
=> offdelay_ms = 5 * 3_frames_ms

This ensures that `3_frames_ms` will only be experienced as a 20% delay
on top how long the panel has been static, and thus make the delay
less perceivable.

If this ends up being too high of a percentage, it can be dropped
further in a future change.

Fixes: 537ef0f88897 ("drm/amd/display: use new vblank enable policy for DCN35+")
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 41 +++++++++++++++----
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8dd9bf58eac5..684f131e5c4e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8693,14 +8693,39 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 	int offdelay;
 
 	if (acrtc_state) {
-		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
-		    IP_VERSION(3, 5, 0) ||
-		    acrtc_state->stream->link->psr_settings.psr_version <
-		    DC_PSR_VERSION_UNSUPPORTED ||
-		    !(adev->flags & AMD_IS_APU)) {
-			timing = &acrtc_state->stream->timing;
-
-			/* at least 2 frames */
+		timing = &acrtc_state->stream->timing;
+
+		/*
+		 * Depending on when the HW latching event of double-buffered
+		 * registers happen relative to the PSR SDP deadline, and how
+		 * bad the Panel clock has drifted since the last ALPM off
+		 * event, there can be up to 3 frames of delay between sending
+		 * the PSR exit cmd to DMUB fw, and when the panel starts
+		 * displaying live frames.
+		 *
+		 * We can set:
+		 *
+		 * 20/100 * offdelay_ms = 3_frames_ms
+		 * => offdelay_ms = 5 * 3_frames_ms
+		 *
+		 * This ensures that `3_frames_ms` will only be experienced as a
+		 * 20% delay on top how long the display has been static, and
+		 * thus make the delay less perceivable.
+		 */
+		if (acrtc_state->stream->link->psr_settings.psr_version <
+		    DC_PSR_VERSION_UNSUPPORTED) {
+			offdelay = DIV64_U64_ROUND_UP((u64)5 * 3 * 10 *
+						      timing->v_total *
+						      timing->h_total,
+						      timing->pix_clk_100hz);
+			config.offdelay_ms = offdelay ?: 30;
+		} else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
+			   IP_VERSION(3, 5, 0) ||
+			   !(adev->flags & AMD_IS_APU)) {
+			/*
+			 * Older HW and DGPU have issues with instant off;
+			 * use a 2 frame offdelay.
+			 */
 			offdelay = DIV64_U64_ROUND_UP((u64)20 *
 						      timing->v_total *
 						      timing->h_total,
-- 
2.49.0

