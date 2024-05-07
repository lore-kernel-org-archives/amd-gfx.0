Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1BAC10F1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 03:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87A410E242;
	Tue,  7 May 2024 03:41:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ftpCMd6+";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D019610E242
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 03:41:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxU94mJz7zqmlV5Dq5KuQ76PH0WyAlWEWMq9x8yHdSRlbSbM326icKoFrEF6Ai+1nvfejdP6lkjjjBl6CBE/LeQDr4Xxliz1OsLm3vGTpf/6/IHNi0bCXutc2FHnQPAVxcQE2iuvQ5T+qtYJykWHziygMHdUMejverR4jTV4N1XFBQoXnFhXUwQEz/UmGSy02fOeCWlNb8zA4O7y4gOK6MMr0XobP2//w/VITzA7uHX6q3hRv8vrSiVBthdbSX1w1VIyJXQVu4DmXz3pC0H06ktQIrE9ugaw0HtkJ8e91q0fP/8CoeKujAtg9d+G6HR6Bt4F9DawzmD6SabEzSkxAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HG+kWZRzrSca91bs1pbZCsH1v57HTWMO8E7xKbFI9E=;
 b=jOpTycpuocf5sGIsXGzHoUqxDdyAjyNVFq8H1VVILBuRix+nfmg51O5qQ3AHvHvVOAJ3zz/rp5EQlvSDZP1VgIoCj7eO2jftd/UmrF1gGHZ+7N7/WnGZydcH6IX8R5Fz0FlKYnCcXNGyYU7O0XrPYHYR34csG9xvDTYnng9quzPadNkwRALac6VbYmE/Bk19nTomlgp2z8ma1wj8731wUzf4TtliYo5jTaL0aoDh/a7GmPi17OQfRQgzk95kUa3VRjPTOwHA+zdriA7rI22wmp9fO2JMrLwxkRstQjjtEpiZAffQzVe+Y9NNJoJbVH0I9VweXa7N70nCH1EhtCik5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HG+kWZRzrSca91bs1pbZCsH1v57HTWMO8E7xKbFI9E=;
 b=ftpCMd6+TzlvSuT6MN+5molTaWy15zR8e9Ks7xeX0x1Erif9lbWW/dW6f7EWpp0t/4GcdryQrKKbkYGWgkhKlX0kIORuglSLCDsPX3EgjmIUdsFdkDlsF/k62f1E8zfYC1JUEnkfPz53Q6iF3YGtEXrreGMJ85hdYQG5xF296Ks=
Received: from PH7PR10CA0007.namprd10.prod.outlook.com (2603:10b6:510:23d::7)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 03:41:51 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::6a) by PH7PR10CA0007.outlook.office365.com
 (2603:10b6:510:23d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Tue, 7 May 2024 03:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 03:41:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 22:40:31 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 6 May 2024 22:40:24 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: revert the commit 576bffd10d01
Date: Tue, 7 May 2024 11:40:23 +0800
Message-ID: <20240507034023.3176503-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c4d4eb-124a-4087-9eab-08dc6e47a142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xct2JvjyUtG7LjhkjxJ9kWS93rkXwAN6FNwTNW4g5Q+WA63iIS7GGGg9a0pT?=
 =?us-ascii?Q?4XNt+PUA4IsfWcM4NphMHW7/qVJ3CWm5e1Z81bSMHLnPHlowT+imMn7EMS2p?=
 =?us-ascii?Q?Ir8lh7tzzS72MZt68F0DcEiY6NMrLsNwkPykSIQxxC+fRW29j7RBCh4VdLV6?=
 =?us-ascii?Q?Jftk7jNtuxARQfMetdlYGS/Y/uvgT5sNqfw/uDhXsvjSzoeONG4RulMemJaz?=
 =?us-ascii?Q?2oSYmw14bEs+VpuDx3dFAedCb1ExYC+XhObpecsCgXq+0MAaQHe9jiarPe4/?=
 =?us-ascii?Q?7cfpZImNOLLOd+RE4JAJuGFA7lVk/+TMbWxWCyLdJiAxXOlHp3M/bxdVfdhl?=
 =?us-ascii?Q?B8nKha3gw37oDH3w0oCCBt6Phxokqt2xhvpK1KvGDImXpn4/ReqB26cfnvhf?=
 =?us-ascii?Q?EgM3R2XbkE+f0q7jOODCTZKrD8QZExZ5h+jh7qy8YsQp5THwoOJSNhaIT/rw?=
 =?us-ascii?Q?hXtOLfgiHcCHzNvFDkvwJa4FuzDuqX8sgzDE8M4xMeHn2ms8o8s1LqS6AHvL?=
 =?us-ascii?Q?Tss3KCwau0MtPwhfw4yp8795hMs19MgH/GCvhQ5Lgsy5i2m6RO4ebnfQsHFR?=
 =?us-ascii?Q?8Wf4myb+KKVXzEcoySmSLrMjSbmqRQjHZlclFayOOkEzKE5lLcWZT76iXGYY?=
 =?us-ascii?Q?lfV+imjp6S5ZX4MkNwMYSlF15ehtIJyFuLYr17Mr/lM6hjcdBlPqIoQNGGB9?=
 =?us-ascii?Q?qo2Suue2EMpUHFT8/+Zl5Wo/9W1RLEagUz/qL6SalVeoR32oMSxUd/NS3Ttl?=
 =?us-ascii?Q?njhfRYwKqgmYLARIFdpTdI9X8a20NhbqQqecnwIzc8kIx3W/0ZV3oHql1cHR?=
 =?us-ascii?Q?va0cY3ZZEDnAE0hhiele3uitBVKYDJGL+c4NprilDT1wz1pHNMMlSmk6wZMi?=
 =?us-ascii?Q?50oXHVGndB7UtRSEP8VXdNUdgf8yFI0mkYqg43amCZNLfVEfKcWLw3kdtN5j?=
 =?us-ascii?Q?WOzCpGsE6cSOXwj0uM0fN5qbWeWOj15kmy4yd1kmLDfDb6hGzqirn5xTgs4l?=
 =?us-ascii?Q?7o+lhevuWvgn4sdvYpqqjFvLv/NJFTOBf/t5pkd9ifCOteVorOH1oo1dpMld?=
 =?us-ascii?Q?VVplAVhBdiI6yuKiXCPzP3nD+3biRC4m/saeQDilqTbXR9v3EC9916oNPRs5?=
 =?us-ascii?Q?AiH6JIOl9CryPOHJ1ft7DpUaP04SBEUNJ+d4iL1CbkeG/cOZjjLShSK7HVMp?=
 =?us-ascii?Q?nZl+dzQQsa3L1JWYw31eaGaU3VIDRfpKPDyTB/I/+bsV5RRiRbnC2QrpJ6P9?=
 =?us-ascii?Q?So7VfEnuaxcb5B9RpCubZtV3nKaAtzpmQ+wraY6m5ZCFeOcz8WbwHcstpfQz?=
 =?us-ascii?Q?OLbVq8fK6ocLXdHEhRERLiGt3Rwf0LtnyFyms5/UAMTAwWiZ/lNUhJ5Y0FAF?=
 =?us-ascii?Q?o3eJ9mQM8fouUvYaWlXqZdZAGoxl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 03:41:50.4967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c4d4eb-124a-4087-9eab-08dc6e47a142
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
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

This patch doesn't need and will update new patch.

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

