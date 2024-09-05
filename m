Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F5CCD4F59
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 07:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3D7D10E70A;
	Thu,  5 Sep 2024 07:40:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a7NhvHkM";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 992A410E70A
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 07:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDvQ9lDj/1ql8CW2PefGCOlZl2GdiVaBtaCI2GjftJGrQsWS4dwMDD71xOnGzzLZtd5aBWgRR9iJhZ/0urzbu/iuIkA7xnMJHpXiJE5TjFu5KPh/D2wqXkgenIV7ro9tnQ9CPFj21qpbeA2kAqzkTf/L9FFWoa5F3eqz3ttHCGya7uUdsDQAG05FT+B8QbBg8MLk8cSAZuA13rAa13auaFRg+lQzNPnRXH2OehTqtJQFTgqGyAVRhyoQvVes6TBEB0G82L8w12dpNKg7ZPHyaZWu1iV646JZe5BS4l1u9VdpZzd0QV9cpyoUrImUM/rup6lQKQkurJbRsWWp+ORCBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjSWG7K8XoMPX6qygYFxojBP9+7Et77RumxS+oouBKA=;
 b=ywJBW2Aa9VqR2qmdP8iTDoSauSGNZJTOwEaQodQJiZpTo/vG6Zyf8ZnJdN0f8E8KwzDwgZ9dAdsn0rKtrjw4Y80ZJTWq266ZUPYKWP8fiQ3nmY0zxqfiPfO9pGGrjfZNKYWP2dTzxA28tL4EIeoj62efyJXI+LR5H5aodcTxuD5zyUQ27aPxrzR3N1/aX6d5LlpDHE1wfQs0vPhqRKlPYm2JwwLKjRIHcjJ41vI7WZZ72w+/iP3+WJkP03xw5aEEUjw5TQ5U6nwGA9MZz0dOmmnIOyD5d5Td1hbAh5DtKG/+RkQs6afP6mOs+VQ4RUgj3P+3BBmHPUuoMN6jy9ByYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjSWG7K8XoMPX6qygYFxojBP9+7Et77RumxS+oouBKA=;
 b=a7NhvHkMX8piafajr7S+P4baQUOJCFGnl4cGZW8nwHPXnMjJd0I2K3J39pm7STNr23InR2ZFyM5nUGeINtvZPq4+acaJJh+BBpXdbtBM7mudlaiBXvPBiWViofGaRtuUR41+zc8Z/V90N9Sj0vpKsniVQXB756apzPLQ6EiDkkQ=
Received: from DM6PR17CA0001.namprd17.prod.outlook.com (2603:10b6:5:1b3::14)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 07:40:06 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:1b3:cafe::fe) by DM6PR17CA0001.outlook.office365.com
 (2603:10b6:5:1b3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Thu, 5 Sep 2024 07:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 07:40:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 02:40:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 02:40:05 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 5 Sep 2024 02:40:04 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: update the features set on smu v14.0.2/3
Date: Thu, 5 Sep 2024 15:40:02 +0800
Message-ID: <20240905074002.47855-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ff6b97-ce83-41c9-5579-08dccd7df63c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dPWhtpyxaQINtxk0PibzOeHKxdsymRrnyoSslJFGEVb9vAo9PANI6PQGRPrH?=
 =?us-ascii?Q?n2GJoZ6nXWCulh+UyB+7Y8SzxvSNnuqEX8JKiLIShNSj6BU7URs6Bsr/QpMW?=
 =?us-ascii?Q?9u7a1aACl00yOH3So+sPwk0gMYdBdgHUZz6F7dPxMvPzZ3PP0scrC4a1v952?=
 =?us-ascii?Q?wcZOYk+0jYad9ZlYn2Aekk80y3UqkBI6KgtwYU5KGAZCJx+Obx+iWLIdJ9M7?=
 =?us-ascii?Q?Qlzq0cv8bdeBEoDZDBzrQ7yVM0q2CaupT6CdL3EAyJBWYxQtyn8K6OxJBGGb?=
 =?us-ascii?Q?TRgmvo64Khqu0D46zqDe+z8UD+UJ5EhVc0/f7FUd/RL0UogEeA1hsNaZfjlt?=
 =?us-ascii?Q?quZJUgneOC02Xc2AqAAIxA+9nLS8+s7kkHd6WwzZjOR/hMyBbNz3QZ9SrEN2?=
 =?us-ascii?Q?fnSVcKSSHWZFp+dIX36rAI3L1XeS4Owsqf2k44nQ5D43oiK+fyMwZvJT9epA?=
 =?us-ascii?Q?dhymuC0hAHaOhmbOHeFpF+KBB77gLNmmzTpwOmWnAZQynckavU/I89oh0kFx?=
 =?us-ascii?Q?NXEAxy5OFaaibFB2PRfKl8GeBbrvunn0m5iqXaukwSRJH1PiaGOk9uaYXWE3?=
 =?us-ascii?Q?LXL2Ily1N9EPE4bzSrPHebj/YmMf07beEjsnopE/qSR2ZY8QuVa15if/5jW/?=
 =?us-ascii?Q?hxTVMt8XInYKxPPkY9neFqx61ou54x0DEzh8fDuWTveZKIQ0Uyfadm/KpeiX?=
 =?us-ascii?Q?5QkkVfsH7JnXhrjPmLTeKWZRV2itzHwsRQClx83ccfneM8pynDwgDya3oc7h?=
 =?us-ascii?Q?YYC0tBaXm5Xq+JjAYqcVxc02/CFr5IQjYV5Tu5dqmblxG+TSOjsOJa82Ijxy?=
 =?us-ascii?Q?q4YRBCt9gTamAmr7M7LVawWhUalE8wIJ+8dLrCyLLqXR+ZfSpbjo/s4hORuP?=
 =?us-ascii?Q?I7SGPAKy6yPRnhlMAUNslx2IaigpkH6yhGYZG0CVf7BsXfZ40erAz4KYFIJx?=
 =?us-ascii?Q?2yqDxpo9lIzmm2xxN329ohuDEmV49B2tbN5kDAhL1yjJS/0X82bEN6uTGTik?=
 =?us-ascii?Q?CVR5upLq+YwargOK0Vz43hut1fk8NYSoOXYkzaAU8y2/XLvZ5Ai25A/zxarh?=
 =?us-ascii?Q?/acJK+kRzXJKeehqk9O3Cfk5U5gU0OL4tFOk+f6jPCO5vmoYQ5e+3JbF1diq?=
 =?us-ascii?Q?2fPteHiU4mha0esaaw5NMEC2BZJYMHjU2efxOpzSCma0AAP1gR9zBuLSJIAq?=
 =?us-ascii?Q?hFuPBQcSsYTdG/9854XsNnUP2k22aCCFufm9AXhNC23HiLNdgQF/xLVAJNh3?=
 =?us-ascii?Q?WGjtcFs3R37UeHWnqJXVj+tf5NVKjB03MWjoee5sslXFBKkxNfLFFUsbQUQS?=
 =?us-ascii?Q?Rgpy/ibDwjgovo36AFFne5ZgbFAQniJIfvzJUfwJs4sVxNC1n+Vf018inPig?=
 =?us-ascii?Q?H45eDTEd3dETYfpUJF2o261tuLfcMoGXnbROnwSyrftvC9UOhXN51C213edR?=
 =?us-ascii?Q?iuQ7PhgBBMo/Y2jTX40aO2Qv6gB5h4ZH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 07:40:06.4429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ff6b97-ce83-41c9-5579-08dccd7df63c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
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

update the features set on smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h         | 11 ++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c |  9 +++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 12a7b0634ed5..5b3e38eb26b7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -439,7 +439,16 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(BACO_CG),			\
        __SMU_DUMMY_MAP(SOC_CG),    \
        __SMU_DUMMY_MAP(LOW_POWER_DCNCLKS),       \
-       __SMU_DUMMY_MAP(WHISPER_MODE),
+       __SMU_DUMMY_MAP(WHISPER_MODE),			\
+       __SMU_DUMMY_MAP(EDC_PWRBRK),				\
+       __SMU_DUMMY_MAP(SOC_EDC_XVMIN),				\
+       __SMU_DUMMY_MAP(GFX_PSM_DIDT),				\
+       __SMU_DUMMY_MAP(APT_ALL_ENABLE),				\
+       __SMU_DUMMY_MAP(APT_SQ_THROTTLE),				\
+       __SMU_DUMMY_MAP(APT_PF_DCS),				\
+       __SMU_DUMMY_MAP(GFX_EDC_XVMIN),				\
+       __SMU_DUMMY_MAP(GFX_DIDT_XVMIN),				\
+       __SMU_DUMMY_MAP(FAN_ABNORMAL),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(feature)	SMU_FEATURE_##feature##_BIT
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index a31fae5feedf..7125f72d01f2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -199,6 +199,15 @@ static struct cmn2asic_mapping smu_v14_0_2_feature_mask_map[SMU_FEATURE_COUNT] =
 	FEA_MAP(MEM_TEMP_READ),
 	FEA_MAP(ATHUB_MMHUB_PG),
 	FEA_MAP(SOC_PCC),
+	FEA_MAP(EDC_PWRBRK),
+	FEA_MAP(SOC_EDC_XVMIN),
+	FEA_MAP(GFX_PSM_DIDT),
+	FEA_MAP(APT_ALL_ENABLE),
+	FEA_MAP(APT_SQ_THROTTLE),
+	FEA_MAP(APT_PF_DCS),
+	FEA_MAP(GFX_EDC_XVMIN),
+	FEA_MAP(GFX_DIDT_XVMIN),
+	FEA_MAP(FAN_ABNORMAL),
 	[SMU_FEATURE_DPM_VCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
 	[SMU_FEATURE_DPM_DCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
 	[SMU_FEATURE_PPT_BIT] = {1, FEATURE_THROTTLERS_BIT},
-- 
2.34.1

