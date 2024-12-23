Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0335E7718B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2024 03:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D0410E234;
	Mon, 23 Dec 2024 03:32:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2dkdlM1w";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A824410E234
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2024 03:32:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUcf762F8fJEptt4+xx+/DYhK9mQ7J7zYA4ZHgAxv9ZL8f+vxNUu0W5l3d5r1Ur0ftiGfV6RyVU8c4Pn7TOP96DdNQHt3OKBc6ipSl6jjVFvbq6E+ONgnWr+lZb+9/jWyt4xjKU41yXuAs0dWR5lBrmEkZq9fPCwc0IZHMF1Y4rvLQdenAT7d+ZdzJMO8ebZkjrx6poywK9GCyNauErTnA8eHm5KfoYrFcz5NlK0SjbuvbpO7WVFXtnf/KC20yivzt291g5JrPuiEDm6jWNXemNJMZCxzYImF4w/P+XEzrR7twWEqWGtTDen/6aZw6Ij14i9enniXcfNY9e0aHYF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B276Oq5FHA7LdVl4nUcZ1LPPlmY50v/3HcXk4NnprA=;
 b=WSfqlG11H0jCXgw6jfu1d9vwIe40pcaghYfvvKj2Jj/G6akcEM/XMlhoe7QZr8e/UgVHWohrPBYbsZgdAKREu2cXAQO8728wSIU9cNWvTZ9zvOpt3EGNPAd+f95b8SiHnPW3hJ3hcry6FNv98N4OjcEjmcuQ4ii1Y82dvnELdYhFYPe/er8AnWFZnimW+BYSaJq5PicH1/kgN3pJne+Vi5Nz7gJQ/KRQLAXKoi01NEmAAgZOLP6yUXNVh0z9k9ohReoFJb8WAeNkOtdb9omux0JX0ZbRGbLhceAbyZMaelWZrxjL/DPYDLqAWYHpU1UJPJnBM4o3LGr9ntAOxtcUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B276Oq5FHA7LdVl4nUcZ1LPPlmY50v/3HcXk4NnprA=;
 b=2dkdlM1wAgtNLILojynWqxTj55voxm6lEnKEYRzLza27G/bDBU8rvIjGBwGnTm3E2U/7cIxocKm2K/kxqdzZC40D1ExKYlviOkQhIaXwhdbKJ/M8YAuFssZMbasplPoMc/l4M6UGXmZcpkCtHzgGMvR/RY+pQXVNMJHKgw6lr0w=
Received: from BLAPR03CA0110.namprd03.prod.outlook.com (2603:10b6:208:32a::25)
 by DM4PR12MB7504.namprd12.prod.outlook.com (2603:10b6:8:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 03:32:44 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::fe) by BLAPR03CA0110.outlook.office365.com
 (2603:10b6:208:32a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.20 via Frontend Transport; Mon,
 23 Dec 2024 03:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Mon, 23 Dec 2024 03:32:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 22 Dec
 2024 21:32:41 -0600
Received: from qdhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 22 Dec 2024 21:32:40 -0600
From: Kun Liu <Kun.Liu2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <kenneth.feng@amd.com>, <richardqi.liang@amd.com>,
 <alexander.deucher@amd.com>, Kun Liu <Kun.Liu2@amd.com>
Subject: [PATCH] drm/amd/pm:  fix BUG: scheduling while atomic
Date: Mon, 23 Dec 2024 11:32:39 +0800
Message-ID: <20241223033239.922540-1-Kun.Liu2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Kun.Liu2@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|DM4PR12MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: f2cc34bf-3b9a-4023-a7fc-08dd23027644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g2Qw+RMKi/e0mUJaTcUJWKEV/T+c7itsO77wOXCxeMEOv6WDbILnvkwjiqnD?=
 =?us-ascii?Q?Wf7K5ZGK/P3raCoczzfkrJRX/xoiBcv/aLQVO9PB0J5O5UkTkEnfV8NDbqvY?=
 =?us-ascii?Q?NAE9KsrSv1xhCXJOAIYYxvpDkYzUWtgdzM/pY5S8sM/2VT2SMlmRT00cwd2e?=
 =?us-ascii?Q?YtTq7WA4vpEezqRniL2kojfohgYSjs/0aIMh491AJjuQWK8FnjOLtpPolD7D?=
 =?us-ascii?Q?i3s/iXpaUuEeFxm3v+q5z08NL2aYExUyiBTZgbvTWrwYcEHfwTtJCHNUaOrM?=
 =?us-ascii?Q?+pNe7dfow5ghE0jA4ykS1j+UlDoT03pqkC8Pe9TacwdykkCgI7T85OLRgbRU?=
 =?us-ascii?Q?RxpmXrV+ygMwaRYWArr3Q/upQT0ORzEqWUQiiQ8EMxWr/UnbpNmYbSViVwzI?=
 =?us-ascii?Q?6uN/DxrNvhvHgiyyxHb/sveMcHOrKxAAss3TgdqSGOH0rI8MjiMGrCkP8g4h?=
 =?us-ascii?Q?y6TgRDalao45tMW/yj8gkiDTVGAQethHYuqhF7svuKvmgcwHci83fIIRceS5?=
 =?us-ascii?Q?9378Xo7uX21IAD2IVndk0EaE1UOOIAhlJrmKrv+uN0U0fbm5XUHtzZ0ND5b7?=
 =?us-ascii?Q?I239Q5f+m2yYHDVkZIkR+ibZM3aaZ56ZyZDbu4LAyZRh1G/3kPDYvbxI2LWp?=
 =?us-ascii?Q?HOIrDC37E6Z+BHkewNVpGpGr4s1abe3ZBy60mWR/03EsU/uAF9EmGx5AN49j?=
 =?us-ascii?Q?lxDel2bKo8uXmYoo5n/hKXnVURHaJ47uisvpWIpy2GJypNYNiuwEfw6q2W1E?=
 =?us-ascii?Q?kVAtCEoEGI9K90pxdNvyBphSW/1XUkvABpkCunijvLdWz+MXlVFUWyY42Fpd?=
 =?us-ascii?Q?tAsOvySoPuhOx0iBB0XsZt84AK3m3A+BzL/unfh+qc+Eu1jYt+2qthCyc15q?=
 =?us-ascii?Q?z1ERA1DYNcBGnygXflW2yhFAExg1koYQNtILY+2125XHS0uHcZM2AQQV+zlE?=
 =?us-ascii?Q?ThZzV8rTVwpjpykNON2CeqMLtsLdXDrPyrYSrkguJn/cqAX9V8AwuCzPRCz8?=
 =?us-ascii?Q?QecdqQL9mLU5Mdyj/+sHbfQfr+qfh45qJqwNcW8ebwvVXzqxWBhhng6p156m?=
 =?us-ascii?Q?oahwwPZH/2vAdLo63u/4TpcY5Bd8EzHCiQWp6r9sNDTBDmq0CYTe6uyDYjXP?=
 =?us-ascii?Q?zIX7V/Av1BOgfP/qq0BaUHbb79QVM5NlwDBWW7nn1I8GJ2vgy4lf0lbp3Swy?=
 =?us-ascii?Q?KkmGg3cBMXbqSsyCwS37r+aPb9VJHhPAd7LgGNH7zmcGwsLMa+1nvHmHdhdt?=
 =?us-ascii?Q?t5fGdQ/aixJY8yWZgqa5TMY7qdSwnG6z6ItEgMSi68VZuuILkbisN0V5eizK?=
 =?us-ascii?Q?FG2ZgljYAFtKinwziwL4GqSU0rC4pcVOBT00tH15p2BTPpwY85QNmn/917Je?=
 =?us-ascii?Q?PtzYP4FNtMOZb4bEAuKjwxHzBkj28IeRS3oZTb0KucfE5QRu6GX8tY1nGFn2?=
 =?us-ascii?Q?+HmmcNtIzrqbs9+xx09khXJ+AzfJ1VjctWqqRYQlvTJLabVnmsfHPalAlcsx?=
 =?us-ascii?Q?WTFQufIGryVdGtE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 03:32:43.6814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cc34bf-3b9a-4023-a7fc-08dd23027644
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504
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

atomic scheduling will be triggered in interrupt handler for
AC/DC mode switch as following backtrace.
Call Trace:
 <IRQ>
 dump_stack_lvl
 __schedule_bug
 __schedule
 schedule
 schedule_preempt_disabled
 __mutex_lock
 smu_cmn_send_smc_msg_with_param
 smu_v13_0_irq_process
 amdgpu_irq_dispatch
 amdgpu_ih_process
 amdgpu_irq_handler
 __handle_irq_event_percpu
 handle_irq_event
 handle_edge_irq
 __common_interrupt
 common_interrupt
 </IRQ>
 <TASK>
 asm_common_interrupt

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Kun Liu <Kun.Liu2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h         |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 12 ++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c |  1 +
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index ae3563d71fa0..356d9422b411 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -303,5 +303,7 @@ int smu_v13_0_set_wbrf_exclusion_ranges(struct smu_context *smu,
 int smu_v13_0_get_boot_freq_by_index(struct smu_context *smu,
 				     enum smu_clk_type clk_type,
 				     uint32_t *value);
+
+void smu_v13_0_interrupt_work(struct smu_context *smu);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 7bb45ff6d5c8..fbbdfa54f6a2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1321,11 +1321,11 @@ static int smu_v13_0_set_irq_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int smu_v13_0_ack_ac_dc_interrupt(struct smu_context *smu)
+void smu_v13_0_interrupt_work(struct smu_context *smu)
 {
-	return smu_cmn_send_smc_msg(smu,
-				    SMU_MSG_ReenableAcDcInterrupt,
-				    NULL);
+	smu_cmn_send_smc_msg(smu,
+			     SMU_MSG_ReenableAcDcInterrupt,
+			     NULL);
 }
 
 #define THM_11_0__SRCID__THM_DIG_THERM_L2H		0		/* ASIC_TEMP > CG_THERMAL_INT.DIG_THERM_INTH  */
@@ -1378,12 +1378,12 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 			switch (ctxid) {
 			case SMU_IH_INTERRUPT_CONTEXT_ID_AC:
 				dev_dbg(adev->dev, "Switched to AC mode!\n");
-				smu_v13_0_ack_ac_dc_interrupt(smu);
+				schedule_work(&smu->interrupt_work);
 				adev->pm.ac_power = true;
 				break;
 			case SMU_IH_INTERRUPT_CONTEXT_ID_DC:
 				dev_dbg(adev->dev, "Switched to DC mode!\n");
-				smu_v13_0_ack_ac_dc_interrupt(smu);
+				schedule_work(&smu->interrupt_work);
 				adev->pm.ac_power = false;
 				break;
 			case SMU_IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 3aa705aae4c0..2a09b27788e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -3219,6 +3219,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.is_asic_wbrf_supported = smu_v13_0_0_wbrf_support_check,
 	.enable_uclk_shadow = smu_v13_0_enable_uclk_shadow,
 	.set_wbrf_exclusion_ranges = smu_v13_0_set_wbrf_exclusion_ranges,
+	.interrupt_work = smu_v13_0_interrupt_work,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index aabb94796005..55ef18517b0f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2797,6 +2797,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.is_asic_wbrf_supported = smu_v13_0_7_wbrf_support_check,
 	.enable_uclk_shadow = smu_v13_0_enable_uclk_shadow,
 	.set_wbrf_exclusion_ranges = smu_v13_0_set_wbrf_exclusion_ranges,
+	.interrupt_work = smu_v13_0_interrupt_work,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

