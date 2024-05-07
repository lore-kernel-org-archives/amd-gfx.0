Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2F9C10F1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 03:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E33A310E11C;
	Tue,  7 May 2024 03:43:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KnUPs4DY";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CDC810E11C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 03:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjXAlVGz19zzQEAIos2VFPDRFe5OfrmnY4I2IOV9+N3rlXvrfOeO57xq1CzHIDzHk7uVMlb1MEsMfdJzWEXarwQANd/Lv3Yx3SrgucVJVtBJ0Oqtrt7HbMKt/QYLfnmVzld9E/aT86wd15jSs3teLF/hf6ckyCwng4b/NieTt/H3kRdaPpTtIYGF+SaSIVgTPrJqCnGMhLikcNpoEgKJGbsopgFIAu1n0i94T3Imkm/GSliBL507C0Jz3wSPTK2l/FNKQdD04yCUoCT0Qi24t+gcPymWURhL7z5VtQiF0KXSKFgPnysvO+tZCf1HrSuOX/g6o8E/8CP1cK7f+Co2tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqFQJukkY+t81wu3M7emx1UbMg73sfK9weqFHqh3Tkk=;
 b=KIwhZEIPDFYzI65jhkQJTcVrV14KQhJ4lN/pUJYoV2pHuk8L1Kk17UdI3uxYVUa8iTWnPGs/tKk3n1FRETuyuSti3EO5WTXQeoqZQeXGlpr7fsFKF8uZPYtmp+0SmCIjcQEm6SopiIzn+b0VEJiz9LuZExpeVoosOr9cQ1NDtWMmzwp7yBqRWOd7YWDHAPsAtsIjGyMYwuG1cROdMLHvohDgiLsCO+jiTAxsxhLUCio2w6PtIcPuocy1R9on0tVC2JHxgKPntkaxVQCYXrq8tysO2WvIaF5ot0L/nm5LNclWPpa4e0H1Bu8NqRkYXyM3Fr5J5jhOkqZA2b770c3wrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqFQJukkY+t81wu3M7emx1UbMg73sfK9weqFHqh3Tkk=;
 b=KnUPs4DYKidYhFDSipMKNGQOWDsNRIBEf5tJk8BtQKYDAb1K4WESL9GrvXg8AZwD3HnSEX26au9D01uBZAyeYIiD3VK8fxoeukIpLR4kSAME2EY6Ac7phmybAWadHghV7lR2eQInxA8n9+Eu89/7nA0asJGt7Ek8gnkyZWXJsa8=
Received: from SJ0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:33a::31)
 by CY5PR12MB6598.namprd12.prod.outlook.com (2603:10b6:930:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 03:43:01 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::91) by SJ0PR03CA0026.outlook.office365.com
 (2603:10b6:a03:33a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.40 via Frontend
 Transport; Tue, 7 May 2024 03:43:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 03:43:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 22:42:16 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 6 May 2024 22:42:09 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: revert the commit 576bffd10d01
Date: Tue, 7 May 2024 11:42:04 +0800
Message-ID: <20240507034204.3176571-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|CY5PR12MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f59f255-dd1a-4c38-5001-08dc6e47caf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WWoKuPKQGPbb4sZRm6VZ3p2NrbNdB8D/rEI7Fspn+04ucTxxaqI7amN+RLiK?=
 =?us-ascii?Q?8fyspEbZStShsTKjQf7b8QlNlUyOQ3muWLiWxyaag/H+nzGpM8ZtWoUIES4/?=
 =?us-ascii?Q?DIzdBK2s+DZZLbrb1RLsMnO3R2ODTSx84UzhZSabdfhBdgRTtA6tzQIwcRPS?=
 =?us-ascii?Q?Qmcj1H/t6osdDw8g0DnlfYngqScnOLu/BQuzweb6S//wafL89UKMGsu4EYSE?=
 =?us-ascii?Q?vz+wVDAwVsWKowXiwAQKneFWbw/ZyTYfrT3yIzeRrYuipYt+YSwTbirzTz9f?=
 =?us-ascii?Q?y3WwAyR0eidPoJWap1SV7Mv1GhFpePVKYPLoABLI5b1wJyIlHLHEYGjIzAwI?=
 =?us-ascii?Q?3+I4iG3seWC/Fr090PNatuXalZsxl7rCbIBITrgQNPdnjlsCmG1BmH+W47BT?=
 =?us-ascii?Q?Q3jSvU165e4hNMihYTPo2FqWku4TxjhcQQy2qUQEhUdD1G2A/tYx0KzUbcan?=
 =?us-ascii?Q?wKXeLCM9Zjn4lRf90aB8YfFv/otprKTPoGFLKMliQBLZvJoSPKWkQx0vne4H?=
 =?us-ascii?Q?HOlO2kID4kBkWDJcjWURtVyJ/92C0f/tFavPvtQ0KyAVQiuP/99arXGb7Gq9?=
 =?us-ascii?Q?y6mO5JaaqWazQffC5CWJuN/RLRCTYtIqVejb/S3K/GIlz/uOqxUEmNS+q7EF?=
 =?us-ascii?Q?OUytYAw1mrqlbBHGjg+A7GH31VysDKJkF3pxqHq2GK5SnHqoM1GNH9ADsYNL?=
 =?us-ascii?Q?nOMLnf+A6bP1EGpxGPWncNbLGaseQuV1pGEjVwEZPNiIy0aBNwVlqXgReaUv?=
 =?us-ascii?Q?zsNaKNw6a8CxxhEGDFI/ksjyKiY76qZ69eYYLR7chB9VQ4bG6KJeyxS2WxLZ?=
 =?us-ascii?Q?/8o23rCTNFokwCscEekSteMam0qEUH2aXGNVMOVMxKmAx64Kv6j4/KCsONkJ?=
 =?us-ascii?Q?5bdpRBZ/pTQ6VgvkHw6FOPUPH5F9sBaNWhXC6dQVfpRkxQ6iWrQom4CNudd9?=
 =?us-ascii?Q?IPaeq++uutgacLQK1W+txnrH3X4P66FZRVmHOiCFr60RX6amM2PJ3u+qe06m?=
 =?us-ascii?Q?Pm11f+RyQS7jBaQ/FRI1HRPP/jRLXnS2PWEPhXp0HYIqITNNrb/IBcuWrRtE?=
 =?us-ascii?Q?HuPgRqkiW8IZs/xJYURIzy9VQePnxEqhOE/3/F6piC0M8L1sq74BQry4l6lZ?=
 =?us-ascii?Q?qAIh8hoFNymNyqG+WpBwM1kavBS0qDZ1+2QNBKg1EP+Wf2LFu/1mLr/ofHRF?=
 =?us-ascii?Q?OQAXo0OjV4F5aK0Et9OQlLXZXe5RFNTohxTh+Z5OrM+vgwHMysoIMwvwzeN7?=
 =?us-ascii?Q?T+iJQVuJz0mqZNXYS7bIvYErg/4xdKF0Yb8tLf3ZZ8VtGFzUksaL/XAc8Wz4?=
 =?us-ascii?Q?IE7+5o983HmLHSwR92BpGly4f5zRnMboU39I9Hn+wq54xiaeohH4jBTZaT1a?=
 =?us-ascii?Q?dSJgAjIgM2DJyMY/1rl1mBknOgSZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 03:43:00.5678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f59f255-dd1a-4c38-5001-08dc6e47caf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6598
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

Revert this commit: 576bffd10d01 and will update new patch.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 32 +++----------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 36a49cfc22e4..8908bbb3ff1f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -835,20 +835,10 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 		ret = renoir_get_dpm_clk_limited(smu, clk_type, soft_max_level, &max_freq);
 		if (ret)
 			return ret;
-		 /* =  0: min_freq
-		  * =  1: UMD_PSTATE_CLK
-		  * >= 2: max_freq
-		  */
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxSocclkByFreq,
-							soft_max_level == 0 ? min_freq :
-							soft_max_level == 1 ? RENOIR_UMD_PSTATE_SOCCLK : max_freq,
-							NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxSocclkByFreq, max_freq, NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinSocclkByFreq,
-							soft_min_level == 0 ? min_freq :
-							soft_min_level == 1 ? RENOIR_UMD_PSTATE_SOCCLK : max_freq,
-							NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinSocclkByFreq, min_freq, NULL);
 		if (ret)
 			return ret;
 		break;
@@ -860,21 +850,10 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 		ret = renoir_get_dpm_clk_limited(smu, clk_type, soft_max_level, &max_freq);
 		if (ret)
 			return ret;
-		/* mclk levels are in reverse order
-		 * =  0: max_freq
-		 * =  1: UMD_PSTATE_CLK
-		 * >= 2: min_freq
-		 */
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxFclkByFreq,
-							soft_max_level >= 2 ? min_freq :
-							soft_max_level == 1 ? RENOIR_UMD_PSTATE_FCLK : max_freq,
-							NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxFclkByFreq, max_freq, NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinFclkByFreq,
-							soft_min_level >= 2  ? min_freq :
-							soft_min_level == 1 ? RENOIR_UMD_PSTATE_SOCCLK : max_freq,
-							NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinFclkByFreq, min_freq, NULL);
 		if (ret)
 			return ret;
 		break;
@@ -953,8 +932,7 @@ static int renoir_set_performance_level(struct smu_context *smu,
 					enum amd_dpm_forced_level level)
 {
 	int ret = 0;
-	/* default mask is UMD PSTATE CLK */
-	uint32_t sclk_mask = 1, mclk_mask = 1, soc_mask = 1;
+	uint32_t sclk_mask, mclk_mask, soc_mask;
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
-- 
2.25.1

