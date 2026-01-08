Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136A0D14893
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E9F10E68B;
	Thu,  8 Jan 2026 04:50:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZuXYRVzh";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013063.outbound.protection.outlook.com
 [40.93.196.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 479E710E68B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FriR8Q0aQ9Rp5v8B0Zs2g9Bef5EKDf5jE3KjNFMfqN8rYXWYt6ItF76crYYEQcZjs0xWTQ+84NYYDVq/uOxTijIztkobl0cL5KHDY9mefRJXjVlTZZbWVXRm0S2hHKBFW0Ik9o+W84LRZ2tBrUS0Z2lxcQKxGFEfSFUVulZguE+XAzYKRiYVL/GHJRMGQOCChC3r5cqx5U4Mtgx146X4YJyz43/YSXkyJwlHqfpH8rdNPBFp8I1Qsq6qXBuTzRIlcNlpRlVzSFe9XD48QEpYVcorkz5VS9RXS1I8wsZQBkRT+pTUnG3TDZQTl+4GbGTmVZB6PyHLBfLAoqUWxW/gfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=typ17/kKYyt5dZh8M3UZ0uylrUxCzC8caHihl2N8hDE=;
 b=Ze33acXnZMXaVMOKhdYbKNGX5Se+R26mhn3dyWnqLAFd+Ku68wRzyJ1eXQlTrQd0WUCZnZliyCQ/ZTlJZ45wQWJkJ2MmJYBh21i9qGAokSIM4uSZXjFBuHGcR35hbN3Z1gLEMCKQTDMr5pK1dSZMWoML81aZx98zKrme83tyG3wJmKjpg8TKw8QJppjha7xndXaKkD2hkVNiQq4mDxA315KczBolL2rbOLtPAiQZ4p8VkuccZqe5++KP8DkweSexy5tjJQRfbju2XO6mbYJkri6fALbUVqRR6Bf+Qx+ytxFs9U4fKjiXJdnTV9FFwvdnu092yOu2lXqSyELiLyUCWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=typ17/kKYyt5dZh8M3UZ0uylrUxCzC8caHihl2N8hDE=;
 b=ZuXYRVzh6QgGL4rvtciSrwO1gxccFIG+W0r0f5zyVLIbvaj7Sn2X3euBvygvn0BRoxSmgfU+7c6/d+IHyw9XmDppsXKTkoHmrmH2GZpR6NANzQD4kdmX/sc4Ps8ornRzbigvom8cX8WE2uTNldTDvoVW4LzOJxwdArfQsl33Hj0=
Received: from CH5P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::16)
 by CH1PR12MB9574.namprd12.prod.outlook.com (2603:10b6:610:2ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 04:50:09 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::97) by CH5P221CA0012.outlook.office365.com
 (2603:10b6:610:1f2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 04:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 04:50:09 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:50:07 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 24/24] drm/amd/pm: Use message control for debug mailbox
Date: Thu, 8 Jan 2026 10:17:40 +0530
Message-ID: <20260108044839.4084279-25-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260108044839.4084279-1-lijo.lazar@amd.com>
References: <20260108044839.4084279-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|CH1PR12MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: 88267071-5aaa-458c-ee34-08de4e7166d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QAI9UtpGhi74rdMzHNeRRx1+zDE6wE3D62QAW5F9Cm3Fd0i7zIsg26OJKyPK?=
 =?us-ascii?Q?zJ7xAxbZAebaG9lPrGiemWodh7lc5Wem8aNfcojXIPSXnav26vbi88/OY+Rk?=
 =?us-ascii?Q?HDjOiAfYRG8n23unvWgf6SKWLtCtCDdWLZ5QL5njKmIvm22Jyff2Y5mMNX4L?=
 =?us-ascii?Q?m/pxY7r8e84KbinmyW6jbHb30QORRgorNTXq6Eq6zKfvDKVd2drdo+YnGaeN?=
 =?us-ascii?Q?D9Tuu12ht69tMV0ls2ucsSR9InMvZTbuRji0+k2udNoubPRez/z5uPPLov43?=
 =?us-ascii?Q?kaC1anGO+Si3gie1QTl+o1jEjWqc1IkXNrr4RTwAoRo9ECrmnprtcb49wrSk?=
 =?us-ascii?Q?Hl5t+4zMh0FUl73c0o4rgTI8x3J51GdHwAtK6FPukAHUff5uPKhMwReHmbR9?=
 =?us-ascii?Q?JsbUBrIG7uiuiCjjPbv0cpC6x3uKP2FZykQxj8bgSbaJn+4ql3DJPRYdEBTm?=
 =?us-ascii?Q?jX53VFEXjKRCyQSfqKJNSmC61LQd0OV8kUkKHOpOQUHfBiwOfE+rRLp1LhdX?=
 =?us-ascii?Q?oLvlWRdkIpkBSurklkI8zxNwyMTKipAvTIObtQ1DfvxQUqS/9pLeu6CGX6jm?=
 =?us-ascii?Q?jcmf19yiKuvXvc5wb0xcsiswfgNtMfl3aR4yRdwmvhDLmguZAMuEvSXH1EpK?=
 =?us-ascii?Q?XGZ6LcWIQNaYyou3R7NYnAp4aQcEhVD2G6wsIEMYLLEZbctQ+ruGaT3xr/Oa?=
 =?us-ascii?Q?QdwOg6s7pDc/Wyf3u77bhbF6J0cBW07+h2rutEF7u4JihAoxlndYggHKD3KR?=
 =?us-ascii?Q?+ZvBQ3LZKcpY8Xt2f3hiq0uZaQGcGLUrc5MVFRAkS159k3L626rdaqpay7iJ?=
 =?us-ascii?Q?4QDM3xw2OzB7NtkVlkdEDRoFQBotuhE/o1183Hb4QLzmRoU6T0X7gmGKZ17d?=
 =?us-ascii?Q?T9LYGF6daT+MwN2DNa1m18TdX96+jZR1NGbMp0LQMi2wqZGGT+thc9cWrBO/?=
 =?us-ascii?Q?FuGd8c7tYQpbS0RAQganeCGxMOPdt1VlUcD96OBSxNST6UywNn3k9kzk+jae?=
 =?us-ascii?Q?QDbkXBWYjTzJybAg02lA1l0U3MwN2pm80G/EC+Aq12jBApQlilIu36FqZAmv?=
 =?us-ascii?Q?/UqIy6hJSE3RPXc7xErWVsnXV2R/49EFX3M6q2AWNG3tvTp9AZQRJSmt8mle?=
 =?us-ascii?Q?/hElhhHdGiKVozkQlWaRVR2BgYCmZgJtmbug1iqpJPvVwZRYkDrxUmY3IP8a?=
 =?us-ascii?Q?LtUJQ/J0Ecrr2OsIrcLmR1GnIhaLQRpEpHcQctpHXpWETq2s6fwiPf+8iOtP?=
 =?us-ascii?Q?aHBzhRwrfRfbgRTyOgecco9ddG6dNEcWnhDtxD8ZDNz5ISFNAx0R8cmcfo+2?=
 =?us-ascii?Q?m11GDOF6NjG68g/eQ4No5+XIgQN0ox2LDUAeoa//FVeJWXI08ujHTazzJaMP?=
 =?us-ascii?Q?V93r61mLDlOgxk+x5imyIGyIjVq0SjXn/g3TLW8razPdNvtUNwASP7oFCjiL?=
 =?us-ascii?Q?ohEwYsKijO9n9cFf/5iOcLJSIOdV7a7ag9+dCs1mX23mnxMA8B7NClK7OZVQ?=
 =?us-ascii?Q?1k+MIJH9sRUUbNyDNKV72jWv6GeAYTpYzuqkqByTIIPVa0RfVofDRXL8BiBY?=
 =?us-ascii?Q?dR99uypjQQfAaHsFfMc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:50:09.5854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88267071-5aaa-458c-ee34-08de4e7166d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9574
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

Migrate existing debug message mechanism so that it uses debug message
callbacks in message control block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  4 ----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 16 ++++++++++------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 17 +++++++----------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 19 ++++++++-----------
 5 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 84b50820a613..3efd5cca3d09 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -755,10 +755,6 @@ struct smu_context {
 
 	struct firmware pptable_firmware;
 
-	u32 debug_param_reg;
-	u32 debug_msg_reg;
-	u32 debug_resp_reg;
-
 	struct delayed_work		swctf_delayed_work;
 
 	/* data structures for wbrf feature support */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 34ff4c35baff..51f96fdcec24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2366,6 +2366,7 @@ void smu_v13_0_init_msg_ctl(struct smu_context *smu,
 	ctl->ops = &smu_msg_v1_ops;
 	ctl->default_timeout = adev->usec_timeout * 20;
 	ctl->message_map = message_map;
+	ctl->flags = 0;
 }
 
 int smu_v13_0_mode1_reset(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 37941b6c2831..ce52b616b935 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2882,13 +2882,18 @@ static int smu_v13_0_0_enable_gfx_features(struct smu_context *smu)
 		return -EOPNOTSUPP;
 }
 
-static void smu_v13_0_0_set_smu_mailbox_registers(struct smu_context *smu)
+static void smu_v13_0_0_init_msg_ctl(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 
-	smu->debug_param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_53);
-	smu->debug_msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_75);
-	smu->debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_54);
+	smu_v13_0_init_msg_ctl(smu, smu_v13_0_0_message_map);
+
+	/* Set up debug mailbox registers */
+	ctl->config.debug_param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_53);
+	ctl->config.debug_msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_75);
+	ctl->config.debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_54);
+	ctl->flags |= SMU_MSG_CTL_DEBUG_MAILBOX;
 }
 
 static int smu_v13_0_0_smu_send_bad_mem_page_num(struct smu_context *smu,
@@ -3216,8 +3221,7 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
 	smu->pwr_src_map = smu_v13_0_0_pwr_src_map;
 	smu->workload_map = smu_v13_0_0_workload_map;
 	smu->smc_driver_if_version = SMU13_0_0_DRIVER_IF_VERSION;
-	smu_v13_0_0_set_smu_mailbox_registers(smu);
-	smu_v13_0_init_msg_ctl(smu, smu_v13_0_0_message_map);
+	smu_v13_0_0_init_msg_ctl(smu);
 
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
 		IP_VERSION(13, 0, 10) &&
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index e414dfd6f644..03c26d8248a3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2107,15 +2107,6 @@ static int smu_v14_0_2_enable_gfx_features(struct smu_context *smu)
 		return -EOPNOTSUPP;
 }
 
-static void smu_v14_0_2_set_smu_mailbox_registers(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	smu->debug_param_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_53);
-	smu->debug_msg_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_75);
-	smu->debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_54);
-}
-
 static void smu_v14_0_2_init_msg_ctl(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -2130,6 +2121,13 @@ static void smu_v14_0_2_init_msg_ctl(struct smu_context *smu)
 	ctl->ops = &smu_msg_v1_ops;
 	ctl->default_timeout = adev->usec_timeout * 20;
 	ctl->message_map = smu_v14_0_2_message_map;
+	ctl->flags = 0;
+
+	/* Set up debug mailbox registers */
+	ctl->config.debug_param_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_53);
+	ctl->config.debug_msg_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_75);
+	ctl->config.debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_54);
+	ctl->flags |= SMU_MSG_CTL_DEBUG_MAILBOX;
 }
 
 static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
@@ -2876,6 +2874,5 @@ void smu_v14_0_2_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = smu_v14_0_2_table_map;
 	smu->pwr_src_map = smu_v14_0_2_pwr_src_map;
 	smu->workload_map = smu_v14_0_2_workload_map;
-	smu_v14_0_2_set_smu_mailbox_registers(smu);
 	smu_v14_0_2_init_msg_ctl(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index f639d3636d30..5b1f059105d6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -102,17 +102,14 @@ static int smu_msg_v1_send_debug_msg(struct smu_msg_ctl *ctl, u32 msg, u32 param
 	return 0;
 }
 
-static int __smu_cmn_send_debug_msg(struct smu_context *smu,
-			       u32 msg,
-			       u32 param)
+static int __smu_cmn_send_debug_msg(struct smu_msg_ctl *ctl,
+				    u32 msg,
+				    u32 param)
 {
-	struct amdgpu_device *adev = smu->adev;
-
-	WREG32(smu->debug_param_reg, param);
-	WREG32(smu->debug_msg_reg, msg);
-	WREG32(smu->debug_resp_reg, 0);
+	if (!ctl->ops || !ctl->ops->send_debug_msg)
+		return -EOPNOTSUPP;
 
-	return 0;
+	return ctl->ops->send_debug_msg(ctl, msg, param);
 }
 
 /**
@@ -199,13 +196,13 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,
 int smu_cmn_send_debug_smc_msg(struct smu_context *smu,
 			 uint32_t msg)
 {
-	return __smu_cmn_send_debug_msg(smu, msg, 0);
+	return __smu_cmn_send_debug_msg(&smu->msg_ctl, msg, 0);
 }
 
 int smu_cmn_send_debug_smc_msg_with_param(struct smu_context *smu,
 			 uint32_t msg, uint32_t param)
 {
-	return __smu_cmn_send_debug_msg(smu, msg, param);
+	return __smu_cmn_send_debug_msg(&smu->msg_ctl, msg, param);
 }
 
 static int smu_msg_v1_decode_response(u32 resp)
-- 
2.49.0

