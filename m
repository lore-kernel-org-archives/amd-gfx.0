Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18B7F513EE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7212610E302;
	Fri,  6 Mar 2026 03:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RDI1NuLh";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03DA210E302
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:26:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtCmifO6zJ5bzcCOa3X858/BcPjhPAthRh4kYOq17HxAGXWm4+hr1wsSY+IxPTWLbGT3PkfODJnkqoaRiuB4GmbkY8g8Pwk6OtcIhx9jtcw8WWrbyO1DmcWDeAf92WETBd6UX2MeWInHWG3FqWnnN2Bx0aPIiAzCctg/6huGZIqmiYEK3jQ0azp6ycMkC+W/Y2/+PLPzjhwmUxif6jFjR2SCc/wlhVpYu5zt0p7cCV9b36S+1l/hhEuH03oNCJZ/eK1VaVfJGgctWiX06BRF74cKh4GsTWhtv49cdGH7oVjFjbDfnXZsdo4Yjy/x0CYkAEesbKhnaA4XJEbkPQQ+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlfEqnUXZaQRSmIzVpTBoK2zUhV96yrqFao6JPBe6eI=;
 b=jJmKxb/a6QCYa/Vxy63PJwRlCfElp9+HWsWd+O1zbX0taUnrgxiBkMgJ7Ps/a1wzUVigG/lZgWGoD/9+fwUoeuWdZscBBqcaKmvCSkBDRhTklY4+VK9SpXrRBG8N+5htlBJeILSISncZb3AqL9JiT6ICBieZQ1bI6cesK+VUVHDCr/EGEpEPjHC3soKM6hZhJyieABGvj5hNiZ5S+awUW11H6wV1755TKt1MijmZRKVWkVaKOcw8Y4gy21q6gwj2VOALFksuHBz0zlevStP462NaLN2klYcb7v8+AG9g/6Tq5TZKHlJvRWK2dSYydcBjqJAMUSUIbzAPnzpgNQ0zhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlfEqnUXZaQRSmIzVpTBoK2zUhV96yrqFao6JPBe6eI=;
 b=RDI1NuLhRimQQzPapeNqYZkQ2o+Xv6fy4B5feLFVpnGLavMjO+5kSajzD1+0QBJ1FO3HI8jjK6JD+ZmiwzvB5MAlPoh96tGCS+i+BDp7Qm7tGBwx242fMU+9zQBam3wPdNovJckOY0bKumPDHEJkGiLO6IvpyUfe4gnVBrH9Nf4=
Received: from SJ0PR03CA0235.namprd03.prod.outlook.com (2603:10b6:a03:39f::30)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 03:26:22 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::1e) by SJ0PR03CA0235.outlook.office365.com
 (2603:10b6:a03:39f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Fri,
 6 Mar 2026 03:26:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:26:22 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:26:14 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, ChunTao Tso <chuntao.tso@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 11/21] drm/amd/display: Add new types to replay config
Date: Thu, 5 Mar 2026 20:13:37 -0700
Message-ID: <20260306031932.136179-12-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: c769f56a-4293-483e-7f24-08de7b30240b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016; 
X-Microsoft-Antispam-Message-Info: 4hVk0OH3/kmZ+a/JyxXnV6mc1CQH+p6JP6jasA+CSVRYWb9aEpmMxPI5pAVrnR3h+GP3YMdYoQKZihov4AHaqS/iONYGGdZLh11p6NLuRILNnYohwXBTVY3W2f0tmcSYrJpeEtmbOd0PptW8KDjMMG+UoLmMZoqnAv51AF/LFOZ5hvMqFGQuh6rI3pOEPh1MhQGNRUWZwFbuhVsk1WDAyknacguf0lgdZb3CGP0jInJVtRqop/sq+usot0y5jrDBaYMh6QormXshPrtFKlupBo+VRT/dLUIn/9+pDLqRLaui0vzAlTZDz5bjnSY1eH+/fZj3EzzpvoRL5dRrXETmqfV6VdlU+fzZIVjjJevssXvSUAvWWjR5aP1Nd6aeDqF59U5ICCTDBR1tHfXpmzYJxOIMpV6M0JaXoM6LLx1uNOEHEu7b2nifoOJw0MR86hXJ68RXfgFxdYBWjSEcJZF1JprYuXP13e31IOcpl8sqq1+jmEIpOHAfb6lR5xTxnaF+wxXqHNZG3lrd4PX3fCexz+Mh3GVrJhHx4O/IxWBBDpw8nqA4vCPQcvAD2GqRsgzMOSmUf8ZHDTjy6G3no4MbWhEn6AaUVJVrCFzewnTIKI26kRNG+ohIomaK4adYxCYYplCI0W9qw4GhSG3BUPhiQVj6wQejjVKf9ieAKkFvzZQlZ1+ygs97nTlWLLdN2MZ1AUi0h0EL1RfidC0Kx59lXBJfyx/SwlwttjrmvEIWo97u5K/yfAAPMK22m4M03p03o31eX9xVd4PNWwAI0ud+7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R0g9iz2hlS6CbofYgjwipRmuoMISIM4NnZfegkpsKYGUx48UQvmpaJQcJFC/8W6nPdqWazhFxesUCSFmlQ4E8T7GtewPnk2J0zktkAfOBPmEhTsTosCvmtwza1j5KY64EwXejJJmcjyY+WzfIZ2veY/kxhoN9D5x28Mt9bGdkSfAodHmuDKp40q08yaNElQK3jKez7EKjbMZdMC0m8Cg+7BctcNImulWcjkHVLrO01wHbicurVSuZX1qJaShVX1qIaO5xlr+83aUceUhk7DL4Co1hpvWmwaXQDOApmlqtWj9rCyueev1WYe0OYsf7H6/cyBJfP18/irjtCfMRFuGfczkPXpUgpUaba+MYRJsnuc2xvnd3mUo2Td7eZAhJAIht73i6EAApliG73MnkM4YlrATZYufM9fwQamyL8iAw9E2z521K3cddNuUL9YWXLXp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:26:22.5424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c769f56a-4293-483e-7f24-08de7b30240b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
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

From: ChunTao Tso <chuntao.tso@amd.com>

[WHAT]
Add FRAME_SKIPPING_ERROR_STATUS to dpcd_replay_configuration.
Add received_frame_skipping_error_hpd to replay_config.
Add REPLAY_GENERAL_CMD_SET_COASTING_VTOTAL_WITHOUT_FRAME_UPDATE to
dmub_cmd_replay_general_subtype.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: ChunTao Tso <chuntao.tso@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h    | 2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h       | 2 ++
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 9540f0ead279..7fa336bf1115 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1374,7 +1374,7 @@ union dpcd_replay_configuration {
 		unsigned char DESYNC_ERROR_STATUS              : 1;
 		unsigned char SINK_DEVICE_REPLAY_STATUS        : 3;
 		unsigned char SINK_FRAME_LOCKED                : 2;
-		unsigned char RESERVED                         : 1;
+		unsigned char FRAME_SKIPPING_ERROR_STATUS      : 1;
 	} bits;
 	unsigned char raw;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index d2e60480fb2b..d0ae5c27a511 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1194,6 +1194,8 @@ struct replay_config {
 	union replay_optimization replay_optimization;
 	/* Replay sub feature Frame Skipping is supported */
 	bool frame_skip_supported;
+	/* Replay Received Frame Skipping Error HPD. */
+	bool received_frame_skipping_error_hpd;
 };
 
 /* Replay feature flags*/
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 2abbc6c97850..f67a0ffb9335 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -4441,6 +4441,7 @@ enum dmub_cmd_replay_general_subtype {
 	REPLAY_GENERAL_CMD_SET_LOW_RR_ACTIVATE,
 	REPLAY_GENERAL_CMD_VIDEO_CONFERENCING,
 	REPLAY_GENERAL_CMD_SET_CONTINUOUSLY_RESYNC,
+	REPLAY_GENERAL_CMD_SET_COASTING_VTOTAL_WITHOUT_FRAME_UPDATE,
 };
 
 struct dmub_alpm_auxless_data {
-- 
2.43.0

