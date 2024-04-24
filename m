Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DD5C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F224710E3DC;
	Wed, 24 Apr 2024 08:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZruPdBZD";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29E6F889BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZUVj9wHBGHftBkvouOf3LzbuDKd+eZ0Sjvuk5GJ57ZNr/yExjQSteZT5Ecr4XANvSJ4g/KybxMNRbH/eAOrp+B+ioFxptFwTdvjfwbnKzeWdBdMlnymgSJfaobBnkTQDPWF2O26RYaZuRJPk0ywSN2hf+wVi4C9S5INwdV3lw+7PLaa7+VFjy3uZiORfESHGnSEP9o8Ut6fIi9aWWG4uw/snVBHB9ydIpNZ2QVPSFJYDd6VkLTp2aezDQSH67Rf0q5v1mn5asjvnfzVUqokuUHmZmA+tk9Ntpnpt+T5gouh2NiOmBnHbamYyT3k9YvocDAlT/U71IvtMwOFjrnmjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq71S19zixSpc/O3GWkY7kSK5MgLFr3wi1yO4lTWp6Y=;
 b=Xelj60ydpGRrUsHRKMN4189A8laH/avAmE/6qJX7JsLjby5YEH0UuELOsc+X3gd961OA9evo7tsdzmwpjzRdFXI5b68/3P6NFjn0jE74XjDKOeEFga3qNMDjWu9aZlI4SszkF114PvgHDGs5Uh/M81AZdZ4Mm1SqyH7xU31HuyT8eYs0SDPVhL+miJA7V5XSZH+51mLabUFY2izrclK+0Um/XtwYsf7PTWVOjY26NZ+q2vI667EvH8lTOIL8NETGYiqZ25VToJ4NfIuM1leRhysHnf3anWqk8TwXzJT9zWqcS06hWtPuc0J4lvb5R4risWgKzSTZ3hcURNUbEYcR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq71S19zixSpc/O3GWkY7kSK5MgLFr3wi1yO4lTWp6Y=;
 b=ZruPdBZDdZqRXJdWRpP6GrDWICn2j4boEj+eChb2NBtsRM/6pNKlIWdEyOmFqVqzQYBM9/ZqFH0FLTY/CEmaqlP1JD23qXtuUwZxikBL8WKc7It6+OOesstEiMG618vKbu5c/eKh6mYMfQLptIibJEQ4BvS6usP6x6FsLXtrvgE=
Received: from BN0PR02CA0046.namprd02.prod.outlook.com (2603:10b6:408:e5::21)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:52:25 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::99) by BN0PR02CA0046.outlook.office365.com
 (2603:10b6:408:e5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:52:25 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:52:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 01:52:21 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:52:17 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Dennis Chan
 <dennis.chan@amd.com>, ChunTao Tso <chuntao.tso@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 21/46] drm/amd/display: Refactor for Replay Link off frame
 count
Date: Wed, 24 Apr 2024 16:49:06 +0800
Message-ID: <20240424084931.2656128-22-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 8450432a-8e1c-401b-00ab-08dc643bdd40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/ADfFwVlWKcCOI9oOaPJyd40IM9RUVIVnEKUT2IlVrvHxWlhRwrTWzMxnoFJ?=
 =?us-ascii?Q?Wd/AVuohsMSUnAc6/M/Lpaw8ffB8cFAovvfaPVHp/erc/OK2GlE20oxzU1R7?=
 =?us-ascii?Q?l+YE5J5iGTpEnr3yKLcwnFruC4BgqAhbld1T/ZymFS6mOmKZ2yBXDFxen/2T?=
 =?us-ascii?Q?By5FTc42dw2EmNAWxOKLrermU9PMRDJSOVvK3B2CiHqE5S0RaXsaJ+3QKtTl?=
 =?us-ascii?Q?ay1NI/dYd0jxgdw9qB7EaKmipU5qyzNj2Gng7S6Mx4Bli/okOIAUELyrUURw?=
 =?us-ascii?Q?D1hwtIybn42l/PGZMKKLAiIQRqwDZ204/HfIpACNvPC8Sm2LVz/ZQC7Vl71Z?=
 =?us-ascii?Q?nKoMQ6qQaO3qsHxRUmSwe0n1H7eeEmC/vl/IGHZfdMv/Itx4JBy6GC3PDhJ2?=
 =?us-ascii?Q?FN9z3vdj/jmHVKnMelGVm8nTvwsO+wKywvwqSLq/bJ/A5GlWb8yS/t7ug7bW?=
 =?us-ascii?Q?igdZK9wO/hbJ7czCRi7JisNjMLWm9AHItYEHOzNQQ/bWbL/Q809tPMhbRohR?=
 =?us-ascii?Q?8XUCUwjuczKBTfI0Qr/5dG0NU+U65jW5Ts3VDukTUHp121DLK+TFLAkRcpxA?=
 =?us-ascii?Q?st1BqyYtKFgrJUYDefCL5xirwOD0QuKHBT6xILfYvTxhiXt3Y7oNoweJgwqf?=
 =?us-ascii?Q?VARzdxtdDHJDylCDaCugMv0F33vdZp+Wx9Jt47+J4vV9WZLJbcoGrvZM7JJ6?=
 =?us-ascii?Q?co3gyJxjqzzfkjLHPaXbvrJL6Bys+ionsAzYdqSuPx+z5brImt76pLFcziNJ?=
 =?us-ascii?Q?ld/TNhsuV5VRnIfiNdm8riujEJ+hQ3wbiy9kiFNhG9xbKskrwLcQAZIpwwmP?=
 =?us-ascii?Q?ReNLfXemeelsa9sw1kHgXKMWvT9I1kggvVzOQwHAlOn9A8wSu/SozL0IHqWE?=
 =?us-ascii?Q?8HFe7XW0KQ+Zve9vfSOyoVu9NwHRFwz9DK7+ROxBVvBRRZSWQFw8rHgkD2Qb?=
 =?us-ascii?Q?6Pd8qPdT/8TX4NcJNqsooN4WSr28091xPYfrzhksCZ21YkFTnItPk5Bks3wz?=
 =?us-ascii?Q?CI75uyxvjfMI31rkDP/QR5ntfQDNu7F9CddpZ2sp9jmgmg+VGTLcywKTAh0a?=
 =?us-ascii?Q?XxyZyb8iqBnRI2YwIe8QrDY99bp8o21V8U6stTgMfCoOTICPNA1mNrcyddua?=
 =?us-ascii?Q?YRGFJ+wTO3PSQe3AWv16vEmqjxBEmI+Gn9LeJy8/yq0jB7CJ2MyfBR8Bdc0S?=
 =?us-ascii?Q?y3hbY4mFTfqNa1o7vuL5C1KgfV74nAZkI6TuctLnX7b022VEgHlMqpaHWS4R?=
 =?us-ascii?Q?wEw51XY6sQcpzVUoPnUU4JFEnQfKMhn5zXg4EcOg/4FHFYkQmh6PRGCg42qu?=
 =?us-ascii?Q?5vwbjyszfuIueu25CjDWnSKiPPLXYRm5qIuxAqjaNcARaTGfSpvygFVfYNwn?=
 =?us-ascii?Q?gi5cAVA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:52:25.7106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8450432a-8e1c-401b-00ab-08dc643bdd40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320
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

From: Dennis Chan <dennis.chan@amd.com>

[why]
To refine for link off frame count in diagnose tool,
the driver show the link off frame count number instead of showing link
off frame count level.

Reviewed-by: ChunTao Tso <chuntao.tso@amd.com>
Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Dennis Chan <dennis.chan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 2 +-
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 8 ++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index d79de4780151..cee012587e6e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1092,7 +1092,7 @@ struct replay_settings {
 	/* Coasting vtotal table */
 	uint32_t coasting_vtotal_table[PR_COASTING_TYPE_NUM];
 	/* Maximum link off frame count */
-	enum replay_link_off_frame_count_level link_off_frame_count_level;
+	uint32_t link_off_frame_count;
 	/* Replay pseudo vtotal for abm + ips on full screen video which can improve ips residency */
 	uint16_t abm_with_ips_on_full_screen_video_pseudo_vtotal;
 	/* Replay last pseudo vtotal set to DMUB */
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 2a3698fd2dc2..530379508a69 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -994,16 +994,12 @@ void calculate_replay_link_off_frame_count(struct dc_link *link,
 	max_deviation_line = link->dpcd_caps.pr_info.max_deviation_line;
 	pixel_deviation_per_line = link->dpcd_caps.pr_info.pixel_deviation_per_line;
 
-	if (htotal != 0 && vtotal != 0)
+	if (htotal != 0 && vtotal != 0 && pixel_deviation_per_line != 0)
 		max_link_off_frame_count = htotal * max_deviation_line / (pixel_deviation_per_line * vtotal);
 	else
 		ASSERT(0);
 
-	link->replay_settings.link_off_frame_count_level =
-		max_link_off_frame_count >= PR_LINK_OFF_FRAME_COUNT_BEST ? PR_LINK_OFF_FRAME_COUNT_BEST :
-		max_link_off_frame_count >= PR_LINK_OFF_FRAME_COUNT_GOOD ? PR_LINK_OFF_FRAME_COUNT_GOOD :
-		PR_LINK_OFF_FRAME_COUNT_FAIL;
-
+	link->replay_settings.link_off_frame_count = max_link_off_frame_count;
 }
 
 bool fill_custom_backlight_caps(unsigned int config_no, struct dm_acpi_atif_backlight_caps *caps)
-- 
2.37.3

