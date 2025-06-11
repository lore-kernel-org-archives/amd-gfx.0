Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EFBC71141
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 18:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD4510E2F2;
	Wed, 11 Jun 2025 18:41:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xwLNXdP7";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E15310E28A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 18:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szTUK1Idyo9spaRGynR6mbJAhkFFug2MduA0p+jqakierhJdQsaSUu9cHf6z/tTtnd7zDmTf5zyu+GjeJpp1Ea/hvyEeWoHefQBfyMI+lXtJbY84kDP4ce9vBlHMu0RjnMWx8RwGDa4as0FZcAUfrzQ3Aw8FAjm8FrS6FPqgZOP6qi/XdLqQKK957TZHAnt8j3Gg5e8MiWm3nfusanYW2FKxLgU6cYr2QASd+BO5dSK9YiAaRvZPVlVOGABr0vY3T5xuLpC3gD0ZtIRK7jB9WCMxg4ZdgR6pb+tlSETszLFsNPT5feHO/mWCJYW+PMs+cR4WSLecS487fJTcX++oow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJxSmM3S75WOzsW/wGslZyiaOlWRT1LNTQ7D2kH0q2A=;
 b=c+A24Y1+vs6lXMnjzwtSGuwM9Wz3cHr6wwNWUtGbnrJwSa6uR/cb/rgrZsGHBlyV7z7ZsWS3aJvXB4BDw66/fYxZmmbP2bQDT6Qe0iSafTvEll4YHl37zcLi1Q4koilja5JR5BGqYClLkj/eLiLCBQYMbt0B2OhSU1kDBRV8C7NWAH2jzFV7u/MEIwPSm9TL6Vh2bAxnxevmvEr4UE4UmXh4ivKCwsHoIUkGQoDat/n5Mdu8YxoA+7vB88KnHaXOUFhisB7WmOVmzVGYZpeJvkCcgzmaNSUHoxpIZcMXhwE8OMgKrO52Gy7jYeEVLD+0BF4Q07EHDaeOCHR6SdYmhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJxSmM3S75WOzsW/wGslZyiaOlWRT1LNTQ7D2kH0q2A=;
 b=xwLNXdP7thkMSgSzxtLM3ii/OyV51gBpBwHs4i5sBHHZ/0Cb/m159WVDc7oPrzV/trqdN92guypxU08GQRq+Ik6jY9Ph0tVlc+1QXchJGfWAf+uTnQBqAidcZKnjg4VgYwCGZpVsAHkVeSQN4T7mMhVr9rgpN0UK5PExc0Uz4LU=
Received: from BL0PR02CA0140.namprd02.prod.outlook.com (2603:10b6:208:35::45)
 by SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 11 Jun
 2025 18:41:20 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::48) by BL0PR02CA0140.outlook.office365.com
 (2603:10b6:208:35::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Wed,
 11 Jun 2025 18:41:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 18:41:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:41:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:41:16 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 11 Jun 2025 13:41:16 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Karthi Kandasamy <karthi.kandasamy@amd.com>, "Nevenko
 Stupar" <nevenko.stupar@amd.com>
Subject: [PATCH 07/10] drm/amd/display: prepare for new platform
Date: Wed, 11 Jun 2025 14:39:57 -0400
Message-ID: <20250611184111.517494-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611184111.517494-1-aurabindo.pillai@amd.com>
References: <20250611184111.517494-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SJ2PR12MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca834bf-dd35-4539-c704-08dda9178ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pMXVOnbv4gbeP0PbCKwvi/cStB5iS3FU5yZdF5oqc1oLjKW4IoA9YzgK6C/9?=
 =?us-ascii?Q?Fn/h812ovDcp4NsTof5GB+0HW4FUDM7sxN3wiwRfMtSh/m8HsniwGz13LC/5?=
 =?us-ascii?Q?kLBjsaMUQv4lwEYMbj4VQwQHG3fdrHVjyiusA+rA6rLRroYNh6o+7zVZUjR5?=
 =?us-ascii?Q?MRlHHjaVCl+Phw0QB/EVhQyrWGwSXD9Kcb4iZfpA20qscosjCjucaeqPalhp?=
 =?us-ascii?Q?Hpb494q7aMzXXvSvhnwD/ku4NBLbMRoRBbtbR0umXpyMOmSzBbk9i8aOcewe?=
 =?us-ascii?Q?MJ2cUsDNOjVLAHlxHK0zjflH+aCgQcEoRN6MJ4eNPCFhmXsZInHpo+S1uoVb?=
 =?us-ascii?Q?5bmVrDHCwXJeYATq0N+w2/vkXMNGxxdKjfySjTWeJPBiISLggRohS/DRUg5l?=
 =?us-ascii?Q?47obSdjNd//IrXcZaSE84/QZlxCgJcSgN6orwWUZ9ppOuJsWONeoRlvgOCS7?=
 =?us-ascii?Q?8/xjeLx+SogrGxaN4e31ex2V+etFlFumJ6DQW01lhznvjj4ZM/FoV+WnjMJF?=
 =?us-ascii?Q?1WvjKAl3h/mUH8IZ1vZ0MjXwy7cqPleYHhub/2wORs72LpUB/9/sLkC1iO7j?=
 =?us-ascii?Q?waBOfgu5MIyKhhAvZVYEYy+/H68XZoaNEfcZKRWE5gomvDOtNb28ZD0aOVQU?=
 =?us-ascii?Q?EDGT2QPM2ifuIZt4hL+EXWLuSyfsgMc8bRchu61N6b0cm9/MGBg9tQ+x8EqN?=
 =?us-ascii?Q?YTruaWgMBHMvfp0hEfo+RFSJpwMwQepv5Kx0eJ8ppUUBAijAjhdZO2/aD2IT?=
 =?us-ascii?Q?35dMOtIaj6uyZQ8e/FbI9vPDHW5hqiDKMjsOh5myFiQ7i2DZvB2bhptGo2L6?=
 =?us-ascii?Q?hUDZM3A5ZsxYmuB56ZSe26yuW98cOiKnkZbQcOgnccW89xIC6TPRTCIAFaYM?=
 =?us-ascii?Q?WscjYZIifCOuPFlPK/D4kIQL62eATWE82J2c8qBK5fYWyhr94RdkNG2JsSzs?=
 =?us-ascii?Q?0MFbiCSXtOmjJwEvg/qlJA9wwdchENCvs1ZEY5zoW13uSaBFJv6dWLNS7fea?=
 =?us-ascii?Q?SC0bt6C9suoE+0U71OUmZXwgXK2BtR6+J13nhj9dzaLFF66KUz0fJR+4zwlJ?=
 =?us-ascii?Q?3CA7um7Z6Ljhn+Fu6Oq7LmYtz91EdRB4ldheYYXlz1kZH266rpbNjQdmWb0F?=
 =?us-ascii?Q?8L086EPknv3ERl7zY92qMqd2Povm9NcxzpcXOgVvV46747gRGPVEUqLh8LCV?=
 =?us-ascii?Q?dPOPiOTLB3KKC7CSzweXKFAudSqpvsZnqGs07+YI2wxPhJ6PxLgVJZZOfhw/?=
 =?us-ascii?Q?OU9/km4tTVoxnwSGS1jb0qzHPaqo3uybPGmPMz1CM0p5uqUWfXyE55ugQfgz?=
 =?us-ascii?Q?c76DF58Y22FvlRt8rOAfAS9T/AAHhFXVJqyPuul/bnAIGOxfOaGAwF1c3GGg?=
 =?us-ascii?Q?XZXcuosf0KNOnykMdK0fuIs8M3PhjWiLHVOkl1DA3tuqcPv3m49Vfypu6f4T?=
 =?us-ascii?Q?ZhmDLZJIQDAT/cpO/StVZpm6mtxZphSynDy0iEQgGEo+UEfZ3l+LYj2y80w/?=
 =?us-ascii?Q?OidkmdxD5Unj9hVqdBKY0ClfUKN9h+I+BAZF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 18:41:20.3914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca834bf-dd35-4539-c704-08dda9178ef6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845
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

From: Karthi Kandasamy <karthi.kandasamy@amd.com>

Expose some functions for new platform use

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Signed-off-by: Karthi Kandasamy <karthi.kandasamy@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c | 2 +-
 drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.h | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
index 50ea62a009e8..6f0e017a8ae2 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
@@ -878,7 +878,7 @@ void mpc32_set3dlut_ram10(
 }
 
 
-static void mpc32_set_3dlut_mode(
+void mpc32_set_3dlut_mode(
 		struct mpc *mpc,
 		enum dc_lut_mode mode,
 		bool is_color_channel_12bits,
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.h
index 9622518826c9..8c9b20bcca85 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.h
@@ -391,4 +391,12 @@ void mpc32_select_3dlut_ram(
 		enum dc_lut_mode mode,
 		bool is_color_channel_12bits,
 		uint32_t mpcc_id);
+
+void mpc32_set_3dlut_mode(
+	struct mpc *mpc,
+	enum dc_lut_mode mode,
+	bool is_color_channel_12bits,
+	bool is_lut_size17x17x17,
+	uint32_t mpcc_id);
+
 #endif		//__DC_MPCC_DCN32_H__
-- 
2.49.0

