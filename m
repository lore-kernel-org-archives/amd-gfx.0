Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86C6D65C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D24110ECDD;
	Wed, 17 Dec 2025 13:55:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IDv7Eunw";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46B2F10ECDD
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAvZJA6CnBE3TsSBk+7Bpec/PtgPLkZKUjB+S3PwECY1ehtA1VP2HPXgCUXjjjKWn9dFl7346z03qMzjh8tKXDlc5sajuZ1nBCIq+cIM6fcYQYKK07SbEU9uoNwPw09rXNf7a/tzNp8ifjJWQxjLldNb5cUuk/WgFgB4YRqdFTqiERLk1Sru6nebhBGmF1zCub2r4tec/28f9yJKo3XkclB6UJ+giwUg0GZ6SA6Ci762KomCPGyBNB+1eJhOhRfakQu+JdlwluH4wDTEuK9VqrQHs7z0ohNx2Eq/vh8laOmOmWQOZ7j/W2L8+oSbhUj/8LSKXujzqFGgSl2T2GaKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53D9cjP6VPjf2TwfEIing8XrFSBO9+1Iee6OMrQc6ho=;
 b=RIs0plugfYI4M7fclEaNsNOQ9fMcTYFydxMpHtTd+ukgyNnNLkMxZnIVT51y0mNDLMlX5zeFZBFKYFU8xy/RBw5sa1jHF+LiN/6QsyHt/IZIE3gu6b/rLs6L8SIAPuhkqlapL5A1x/CHYeRYV8nB1Z0LtJ5Vwq0qtq+YaefoG2UYSkjotiDCtcllT7o+TO1Jx2xpTdu8MqHrVGaDR7L9pXrsca0pf1kiiu2DtxHEbOWkaLHkQkScnnfTYjSxC8MflOABUXBnb8US7bbjtmQMF1jo8Q60Y7+5gA7D5Ny3/GjH6KUOhPJxr1sUb1TJXzVlgy7IQwOSde1O4Rfi18kB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53D9cjP6VPjf2TwfEIing8XrFSBO9+1Iee6OMrQc6ho=;
 b=IDv7EunwOZo7Hb6/UE7PIsznsr4/hBcAbHgDJsAl9LS458R98oEna3nElUDzLYZMMInq5W25raFIFmesLs3oGIGowJlh2OpCmLBH8/hlrdVu0iMHU88yQXMtoACbRKjtTMrrEcb8it1nXkTDSoJAGrrXQJm4om9dHijciBfV7iI=
Received: from CH0P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::10)
 by CH1PPFDA9B3771F.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::626) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:55:34 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::2c) by CH0P221CA0002.outlook.office365.com
 (2603:10b6:610:11c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 13:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 13:55:34 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:55:30 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 21/21] drm/amd/pm: Use message control for debug mailbox
Date: Wed, 17 Dec 2025 19:18:14 +0530
Message-ID: <20251217135431.2943441-22-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251217135431.2943441-1-lijo.lazar@amd.com>
References: <20251217135431.2943441-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|CH1PPFDA9B3771F:EE_
X-MS-Office365-Filtering-Correlation-Id: d7cfbd3d-82f6-436e-1fe0-08de3d73f37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+AluvQ3xPLL/ysWByzX80Sxd4attxTDj90PLELkbUqaNh+JaMmI9NQlbXpmr?=
 =?us-ascii?Q?Ynf5KspMFLn1koTkFwUfdandDVAjOFQEan/jFVaRiOloHWn8242nm8+dmqTO?=
 =?us-ascii?Q?rZW7Z4Ht3+W4d8/qCGkZr9HNnaCr2vQeLl2p2KL1xha1+eJgFxTacE3x1hqq?=
 =?us-ascii?Q?H/YtwNhXJR8Dx0zM1OHBjR4c16UApOn3zQRA4jKgY28kzYQ+PS75CGw4nTbC?=
 =?us-ascii?Q?cU8k4elnLBQ4I+FYZm25WnCbKpNuBTimzBK4+pjde9aBWTDoem9Zvet/gE8x?=
 =?us-ascii?Q?9xEDugGhR7xHJF7Rmu0vJo3t+TgiF8ZaHwdZlegGyY6mKOWFCZPATHz9TK7P?=
 =?us-ascii?Q?DoKlSpj+Cbh7Q0igjEBtt/4nibXFUlwnERHhHRgYJt8vyeaGr0f3V0a6NE3U?=
 =?us-ascii?Q?gB+18ZB4zrh69NtWYW5mHyl4QZJhtxhZTZQNwC4pDQm6qTr2LAwpNileONLb?=
 =?us-ascii?Q?D2wOzHNdXeYb/CDhmpGEZJCKG4ukKsXnrxrTTOhSuj5To7JsPwW3hb+63bPl?=
 =?us-ascii?Q?3uz+8aAbDeP6qBrmoAehwyVx6eWzT5np2SE2k/g2sL1BWj4AQOxRkoLvWK+q?=
 =?us-ascii?Q?fEF0BTD6+fSY7qd7JLOUoTb+3vmDr464uLOSEL42zXQXnhqAkELjFVeqXCS/?=
 =?us-ascii?Q?xV1bvOc9IDwmor3lt1SIJefJnxAijPsDXk1MJ1tvWG8VoAkIxNxGdgXEhYF6?=
 =?us-ascii?Q?HZtdZZ2RLZkfw3v1Uc2tVeTnOMr+SyLbRBoT928eeP92ov7YlbjF4JNgeG8E?=
 =?us-ascii?Q?FW8mC8jvn1JZeof2cbRL4gpK4NFm34VFL3lfGeXKfcClBnoOGxkD+IMakTM6?=
 =?us-ascii?Q?1ayByttQccso0vAWg/aJ8MbeT23I0FuARKypD/ZekArXU/fwM/yA1RRJ7SWh?=
 =?us-ascii?Q?jjMrmgZk53QvJAmGzhQfSUjxphk7McRjLTVznKLtCdujEkz98EaR9d3PkIDX?=
 =?us-ascii?Q?BsWKDmwAtKQos9VHzVbNpZgayDZSCMw12hHVvQHvuXK7yDRw+IMRVrHUyeJB?=
 =?us-ascii?Q?qJcBIRieDD54x4n8AkoSngCmpr/WPrzTF8YH20oXqc1yamkazGr8gWT1dWTI?=
 =?us-ascii?Q?SlhUw3a/NLYpPWTHJujGwtZF4khqMwy3AYmqyRizqBOnTfAT93ZrKzgZqbAP?=
 =?us-ascii?Q?FldAzSeGn3R3HAucFmUsP16kNyXDxgKAYTQvf9bpYvRI+Tfo/J9u9DX4VoZI?=
 =?us-ascii?Q?PbAI0kn/JO3P9Jbd4hdb2wFOSH5McIznZUGb2lwdOgTmaIANRtaLx40i6+S3?=
 =?us-ascii?Q?/XlWz63FxuHxowV6x45CIxqVHe6i7Jy/oWEy1MJSzkvhEl1YFlyNOIhOBAsd?=
 =?us-ascii?Q?dolBqVi7y475LJ64Un0uGYKPj0+Z69cUZ3MVL5Xy2OQ8kz65EbaUcdOBFMw0?=
 =?us-ascii?Q?L415dA/tJmXH4viVBnQvH/VDZEMMPjggr3vQmgwY8CUTG0utLGYG/7hYd3Ib?=
 =?us-ascii?Q?VzSJXeiTPz93/MUFECyV89rk8xn7MuGEbjSFqBxekTWw225cqapdW5FVfUC3?=
 =?us-ascii?Q?PgxNSJaHIwviH+aigTTcet1ls3Rh7VVrOrKvGJ/uBCTimiEOeyZqrvgHuUHf?=
 =?us-ascii?Q?ZFiXePQNMYS1nYCgkx4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:55:34.8167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cfbd3d-82f6-436e-1fe0-08de3d73f37c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA9B3771F
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
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  4 ----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 16 ++++++++++------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 17 +++++++----------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 19 ++++++++-----------
 5 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 9b151425feb6..47176810fccd 100644
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
index a245e3bfc69f..07da29d14c3c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2875,13 +2875,18 @@ static int smu_v13_0_0_enable_gfx_features(struct smu_context *smu)
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
@@ -3209,8 +3214,7 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
 	smu->pwr_src_map = smu_v13_0_0_pwr_src_map;
 	smu->workload_map = smu_v13_0_0_workload_map;
 	smu->smc_driver_if_version = SMU13_0_0_DRIVER_IF_VERSION;
-	smu_v13_0_0_set_smu_mailbox_registers(smu);
-	smu_v13_0_init_msg_ctl(smu, smu_v13_0_0_message_map);
+	smu_v13_0_0_init_msg_ctl(smu);
 
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
 		IP_VERSION(13, 0, 10) &&
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index a060346f5bd8..a541a923febb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2100,15 +2100,6 @@ static int smu_v14_0_2_enable_gfx_features(struct smu_context *smu)
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
@@ -2123,6 +2114,13 @@ static void smu_v14_0_2_init_msg_ctl(struct smu_context *smu)
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
@@ -2869,6 +2867,5 @@ void smu_v14_0_2_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = smu_v14_0_2_table_map;
 	smu->pwr_src_map = smu_v14_0_2_pwr_src_map;
 	smu->workload_map = smu_v14_0_2_workload_map;
-	smu_v14_0_2_set_smu_mailbox_registers(smu);
 	smu_v14_0_2_init_msg_ctl(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 5890526f1278..9cd7ea33efe1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -99,17 +99,14 @@ static int smu_msg_v1_send_debug_msg(struct smu_msg_ctl *ctl, u32 msg, u32 param
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
@@ -196,13 +193,13 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,
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

