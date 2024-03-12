Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13C1C54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67859112C44;
	Tue, 12 Mar 2024 09:23:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PEbNnaCS";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C994112C37
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:23:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecsskJsINw+6njeJ9WXIntaSUpQsQwapH/UtJL5S6xJjrQX+EGfkuZPDiUfvmFL3xuuFcNfLeM9Rlm7mSpAo1ROzg3mL7ZqM+EP+I/NnpIir3kpQpUB1vQmcTqHRoyexkwfAELN82zHgQ0fuFKqQP3FocWGVZMB7REahjxKm1b8InveKEW/ebOoifTQ2gU/zNcU77v8/HZT5BccxxbyTmJAaVG78ABSQxP9yWwJ5s9mXmednizgSFCWJo76Q59wzrjPikJIlkP830nxaMoLe7VTskPWeZt2hInplnz6xwcgbRiCNOe2ea4tiLxrdb73S8bJuoW1erKTqqCZFZD9Q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54zvJmzMZxGoar1zAQT3uR9JBPtb+a6ZCOWLxpELfJ4=;
 b=cals7it5QPE5am15QAzWnqLVRvF5SL3T+HwgpePC3yA+hTNExEUWGUmT1XGWCn8No+rl4MAX/ZQOQQtPrY/l1JyozEku8uIWC+I8sC+5pwl3NM445Cuuickrq4JSRcG/vahjPN6AzC49Z6nEN2CJEEeTx5w53UFM6dP+x33cjM1VHkIRXoDAZnE4JEQkaN4H/j2CSGGQGVbIBiKwLO3auI6WTTuJbE9EwlCgGeRCjjKb3dKFTOPuIVsdcBpS0X6kSBrt6P2b4hNB5+f/8kw8DQxT/ngMGl48tQOV2ekoV4dTrc29RbT+LCij81t3LNuFoGAAqqYait/qfzt1sEebxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54zvJmzMZxGoar1zAQT3uR9JBPtb+a6ZCOWLxpELfJ4=;
 b=PEbNnaCSHNriFTBhNaIogOsN8+0ilmB0UPCmZVCo8vmgoTRhdMOxsHW6DSZqL+tu6DZfhIz2pHwf05Y445k7iJIeOn0MIVlU5Aah/d02LZSDgS+eOKNCecAAwSUyLW8h3+A1yhZl6m6kZJV8kfF6+Uxb9vZ28bazXb+FKRYoeHQ=
Received: from CY5PR04CA0020.namprd04.prod.outlook.com (2603:10b6:930:1e::10)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:23:37 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:1e:cafe::1a) by CY5PR04CA0020.outlook.office365.com
 (2603:10b6:930:1e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.37 via Frontend
 Transport; Tue, 12 Mar 2024 09:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:23:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:23:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 02:23:35 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:23:31 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Duncan Ma <duncan.ma@amd.com>
Subject: [PATCH 26/43] drm/amd/display: Workaround register access in idle
 race with cursor
Date: Tue, 12 Mar 2024 17:20:19 +0800
Message-ID: <20240312092036.3283319-27-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb8f9fa-b756-4911-e85f-08dc427618eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05qzVuRi0GIJ6+xT+d9U9Uj0WZVIuzFZZmLNGxrI5cCfkqtmJCluGmnEp4cEO+JnkrJfSXLoQnAdt2MT4PPhtQ1G0rOR5lj+U8kJB3tJFcZdrktoVHeG5ainav4dqvAqnhtwlHb0HQs/Evzqikqviw6AHhidzKQE/cNTiAfPywX9lr6wczx+uxmOOY0cXXUqgQ9sxEVAYnqsnPUa1xtuCNUxVfw+SYrCuUqCBl0Lqxwl8K1AQcNSPoAPOIG2vYFNZIc8FFH5N3Xgl8JPAxtl7eMB3LqjO5zUsIPhqAoYDrSMNf5OXlCJwALsgrvzTKxzeJGA/6a34s4fRwYg7aJZ719DOJSAJ4MpU+FAPe1QLRb03bzi8BjI+swGH7nwmkxLtE33Rd6U4yDLEybWo1AfklIdqzPZ/TMyFXIWT9sy+lP+qoPL5uwPaIioKbaJrhXZ79yOuTTPIS9WOzQ1PKH2xYulIj0hqCvVD+JmEOYz0jTm4gZ//ccdqYXL4hk8vbc+uWGAZ8F7PJi8nCzC4CXH0gTwnjO9XnUwZJbjQkuyF/6a26R4b9fJ6n9heTkey24pFlGyCNC/33UVoEnezIkzoM9gt15Nj+SIpUTAuv9PXL2gRkg76qOMxr46RbiPJjg1FARIpdzhHYvX8daRzQuxM5P27Mdopad0qtMEWC4yyUXOLHUkLghTeuzl3N3liKqTMa9uoUb2bGIqPWgJYf84ArjbCf/ieB8ZJuCovvK5LwIP2jBurBJ41G0FJAgUXd0Q
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:23:37.0517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb8f9fa-b756-4911-e85f-08dc427618eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Cursor update can be pre-empted by a request for setting target flip
submission.

This causes an issue where we're in the middle of the exit sequence
trying to log to DM, but the pre-emption starts another DMCUB
command submission that requires being out of idle.

The DC lock aqusition can fail, and depending on the DM/OS interface
it's possible that the function inserted into this thread must not fail.

This means that lock aqusition must be skipped and exit *must* occur.

[How]
Modify when we consider idle as active. Consider it exited only once
the exit has fully finished.

Consider it as entered prior to actual notification.

Since we're on the same core/thread the cached values are coherent
and we'll see that we still need to exit. Once the cursor update resumes
it'll continue doing the double exit but this won't cause a functional
issue, just a (potential) redundant operation.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 23 +++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 765a459d54eb..f796ed061879 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1434,16 +1434,27 @@ void dc_dmub_srv_apply_idle_power_optimizations(const struct dc *dc, bool allow_
 	 * Powering up the hardware requires notifying PMFW and DMCUB.
 	 * Clearing the driver idle allow requires a DMCUB command.
 	 * DMCUB commands requires the DMCUB to be powered up and restored.
-	 *
-	 * Exit out early to prevent an infinite loop of DMCUB commands
-	 * triggering exit low power - use software state to track this.
 	 */
-	dc_dmub_srv->idle_allowed = allow_idle;
 
-	if (!allow_idle)
+	if (!allow_idle) {
 		dc_dmub_srv_exit_low_power_state(dc);
-	else
+		/*
+		 * Idle is considered fully exited only after the sequence above
+		 * fully completes. If we have a race of two threads exiting
+		 * at the same time then it's safe to perform the sequence
+		 * twice as long as we're not re-entering.
+		 *
+		 * Infinite command submission is avoided by using the
+		 * dm_execute_dmub_cmd submission instead of the "wake" helpers.
+		 */
+		dc_dmub_srv->idle_allowed = false;
+	} else {
+		/* Consider idle as notified prior to the actual submission to
+		 * prevent multiple entries. */
+		dc_dmub_srv->idle_allowed = true;
+
 		dc_dmub_srv_notify_idle(dc, allow_idle);
+	}
 }
 
 bool dc_wake_and_execute_dmub_cmd(const struct dc_context *ctx, union dmub_rb_cmd *cmd,
-- 
2.37.3

