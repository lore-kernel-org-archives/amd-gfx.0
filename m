Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FCCD591C4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 07:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B36910E126;
	Tue, 19 Nov 2024 07:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0117fEbn";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB5A10E126
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 07:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLo8UKzf7+H0xyv+Yc9Q3Jvj3Hs7+mHeMDwRwvSRSnfEsokYpI6UFej12vH1ne1E9B5HnSq4740fpmQAb4rtLgpzPPpGa33AzKd/qE7yhs6/aFWZTMz4MyzYyMCxiqwip/sohg/WlJ2ZftvurxhB3u7JgpcJrk25NasuWRuvUKCwk2V5QHZAYhJe/bmEjXB3q9pHRu+6+V6v3iRH81Ka2e2+Kl9O1MePZUi4KyWd0UNr8kHnD2OfZndPSZWNw654CbnlnfHVkXH7gaKWPC5i9XuRfOwDjzveaQGQaS+j/jvvnbwiEw/5Na8UKo8hjZroNLmYe1pGH0BWiutwufA4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yClZv5CFJg73sikXn/0w3jj6hisFUoS3B3E9z4ajhbQ=;
 b=Sybrs14Qsj9VIrTi/SeT62qaHLwE/dm3E8z4fa1SnvWUrhRED/xucvUhf0YmoWQ73zTrLtu5myhGb10E1n+irgihFwGsXOOMgebuGh+RTgaWGdw65XUceCNgF03W1Wx2RyKVuLKXZ1+TVDaW1515JU3lY5u1mCMDvN55VtkN0exbSDS5AjaNt30Ydb2rVpUdkv2gHGCovraaMgjjczbbnQM1LVBWnEPKel6Ix5pxn0JAubH+e3ZcJH6yUY4zTzSOar+Tyqxen7o5CABQAJckkQG6AEI5Vd/hSyD13+FyeENsvEGTQBSO6BQ+K71KvWAE2eP5ggyg2cFK6r5tgl7bwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yClZv5CFJg73sikXn/0w3jj6hisFUoS3B3E9z4ajhbQ=;
 b=0117fEbnRWpwy01ibM6bZ+wIGfnvS6SdJ+1jxLc+iPlKVtZ41UazT1VB0MTrC2bU+33/Ch/1EvpEBG9knKd7x2LLupUt+l7UUBNdmKqz6peL+1A6to2KSi2hrBM6DKsVq4BqcGtO8IoMShlCq5x394x1kQeARq/qctzSQr95dP4=
Received: from CH0PR07CA0007.namprd07.prod.outlook.com (2603:10b6:610:32::12)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 07:05:02 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::6c) by CH0PR07CA0007.outlook.office365.com
 (2603:10b6:610:32::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 07:05:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 07:05:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 01:05:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 01:05:00 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Tue, 19 Nov 2024 01:05:00 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: skip the power source check on smu v14.0.2/3
Date: Tue, 19 Nov 2024 15:04:52 +0800
Message-ID: <20241119070452.438808-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: b6fdc1cc-bb22-4a83-937b-08dd08687ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OpWfMIq5iJkqbuR9zJfDUj9TxZsZTvoJ0yw1xqJO9DFu86Bim4qUDj9nigix?=
 =?us-ascii?Q?jpAe4MrpXqE793WqCh1pIAaRwm45XuoNRzO7O96/YOCXdHjOV5qxDhxUPsD1?=
 =?us-ascii?Q?csPbFo/4Vyj+yuXPfoIq08oKdzBa1cGoeEPTEXxztHmBpRtWuJCw0TCe6Wru?=
 =?us-ascii?Q?WLfL3bxidt0z7npSlV94FyG+rj8gKtbs65mlkTARF2CUxk1RCqISVYN1tafn?=
 =?us-ascii?Q?d1IjHeqRXpHZl/KPK9rwPXQg/qpj1LqLNMrmGepwqLAefF92YRHxmExfW4R1?=
 =?us-ascii?Q?M9VZKuUZzC0tVHpSxoX0mt4LNqtLlrtOfAl2FZr8RdYuVVhkmuNAF7ATA8R2?=
 =?us-ascii?Q?fBkoAhYT2BAfNLf9ZrYWN7DaDgmcoEi2QLYohJ8U8MfZxpJ7Ztf9r7GlD2bo?=
 =?us-ascii?Q?vp3Y+9XeALrNE+FmQ1M8Z9eKHAvJj6hW9nvvKPGLgToBeq4/q26HmV50HEU6?=
 =?us-ascii?Q?c7wEsCMROPJE1fWo3+Ziu4WaUaR9WEUzyboTBxguD/baOh7ge/KkhGZ+egn4?=
 =?us-ascii?Q?0bRbvJR/jTfBqeWsmO4C4GdE6035V7TFcL9oHNbpWiZ8dTw/Vxl0qmV5XcJH?=
 =?us-ascii?Q?YOH6PC3Kdu8TnrTuQMAJbn+Co0iqOOIcvWzy/pE12OEhrqqUkF7GYMEbs82/?=
 =?us-ascii?Q?mlIeZYlsSa0NB4hnaqUvSsAoPqqB41EoeFIooAtVfDAwDAiobEzhFFuWCed2?=
 =?us-ascii?Q?3OC9m8AMlW7zLkABjFq612M2ZtrjneoZh9OCxzVXCrJdj5ZhMhpTXrBs2ubQ?=
 =?us-ascii?Q?wSrmKlQ5eF+eUwHvVPn1+gEZrBOY5bQ5EIKmhxggvF1OqlZCQ9LsZnQPMuwo?=
 =?us-ascii?Q?jncYnUFjCWH/Ly2vRNVvkb+XCXu2o9CwbndZDWSByGAfaGDnUoQ9/5wcq1Bm?=
 =?us-ascii?Q?FuqmG/95vsnqwQN618FOJr69mekrh4dcDz2JX3ylQ9+/RC8iDj0Bk7QT9vFQ?=
 =?us-ascii?Q?HbSLUaYj3jHLUHi6rRStLmaBk2MKlKjVOuOe6NTTI56SKVVtsYv5pe2kwtjg?=
 =?us-ascii?Q?zqWs4iEipqJ5uNdaKe5batO9hBcKTdKl+0KvOrf7PwJ8QKwFbwks3stJOIDZ?=
 =?us-ascii?Q?P0xIrhcQNRRTokOJzFAFm00mWSCWbduEuSLKAMgH+ylNem7AJdvcdoUWR06D?=
 =?us-ascii?Q?GbQs0PktQRC/eadoJ3MciyeC9KDTiFBHAIvsTZ1IjCl8z8Eqlzp0ZtTmakaI?=
 =?us-ascii?Q?PP6BqRYZzXOx8fPbZMkYRu48+cYpAGhJPNePSHTZhtliEimu2gyV+dTpSfOH?=
 =?us-ascii?Q?G9cZJ7SsCkFDelkL+huY5aVdlK+zLa06tsjUaWTjXAUll3zma/vc8V9e92/q?=
 =?us-ascii?Q?HSP0Q048bES37M95u4CuTa2SyJyTbWegCgrJp4garWlJNTkTTQv9uznhZMfp?=
 =?us-ascii?Q?0YtGk/aHH2rplKa5IWWblPcZo3i1Edgge5bSFznHYvHWssUzuQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 07:05:02.0254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fdc1cc-bb22-4a83-937b-08dd08687ce0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744
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

skip the power source check on smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 59b369eff30f..837281e49d72 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2753,7 +2753,6 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.get_unique_id = smu_v14_0_2_get_unique_id,
 	.get_power_limit = smu_v14_0_2_get_power_limit,
 	.set_power_limit = smu_v14_0_2_set_power_limit,
-	.set_power_source = smu_v14_0_set_power_source,
 	.get_power_profile_mode = smu_v14_0_2_get_power_profile_mode,
 	.set_power_profile_mode = smu_v14_0_2_set_power_profile_mode,
 	.run_btc = smu_v14_0_run_btc,
-- 
2.34.1

