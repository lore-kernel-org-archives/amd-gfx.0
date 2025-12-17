Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAA9D65C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B572810ECD3;
	Wed, 17 Dec 2025 13:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oSkKCnYj";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012003.outbound.protection.outlook.com
 [40.107.200.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C786E10ECD3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEkDSDNqWkCdw6kqv7kmLTmCyX54H/0bGK193jWMuJ3L5mdZ5ytp7DwPecvLIOuLbhXu8w/PKDfr7+iy9W6V/RUXZeruPrCPlK5ewEuCaK/BPr/M32mlyZMf0O7WCxEFL/WbHVywQA22qMiP2OFL+dviHu8plIunM+V1cHOvHiZR1za0oa4DQTre3Qykj4xS/p5nO60K3a2FleBUt1MRlVodhvXpjBnYcwa+Wxzly2sNWiPUXs8vSI7TdbByVsSOVS4Lsg7hImMgy+VvJvu8HKUzWeSD2EvK9idMdl+xNImlKSfGU9ML2vh0BndnScNtHX5nOMyEydhj5/UlOcytAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrXX486VZUa3Ux7f9CxMltPZaut0jDQEoTeuRL7LEcU=;
 b=vkkFF86CnxSdc6F/JtC1cuO9dnEebXSj04i5zVHL5eZ/trgTPXyheuue/LTm0Id9DupHCnfBE23//uLsoUeoHk6cIJZzHAPAWd/FA4QXbtZsKgHKTpsjFVXwsw9za2gkCSsbU2/f1IN83c08I9nE6qj/ZL4m5vYGcwJ+hKLd0/4HSgT9Ex0P4yWMz747g/nwIaZlV8CpW/HC0zx7z2ygFObVEb0I5abQcM2d6Em0o7iayaH9jqOeb1Ej4TpKeQQ+3ZJKABpJJLO39rYqgc7x1hO/qvE00f+/P7pS2RJN8YFw4Dfc7PV7sLpIr27P0Fw7rMcDUqWq/vQMDSFe2S2fdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrXX486VZUa3Ux7f9CxMltPZaut0jDQEoTeuRL7LEcU=;
 b=oSkKCnYjJbt0CNovL/4PxsdVl0eaJndppl1u/RusZQ/PK2vE0eUBDvu2pFaknlnCus/bIwWDo/8YkOZ2PiRC2ePBHXRTNIlHTQkttVTxhMk2MyrjkGoa1bK27QfSWlm2S7wRTcZBd2UV9HzvzCCOVaVnWsG2mFNWsxX65OYQ3MI=
Received: from CH2PR03CA0005.namprd03.prod.outlook.com (2603:10b6:610:59::15)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:55:04 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::46) by CH2PR03CA0005.outlook.office365.com
 (2603:10b6:610:59::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 13:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 13:55:04 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:54:59 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 05/21] drm/amd/pm: Add message control for SMUv14
Date: Wed, 17 Dec 2025 19:17:58 +0530
Message-ID: <20251217135431.2943441-6-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 376b6361-cdae-4d7c-cb25-08de3d73e143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IBpnBxs0qxE3SgJUqP/HyproD+T2xWClzq/xPnXWYSvst57ZS/q0lK6Du6S1?=
 =?us-ascii?Q?0jpGYJkz5+sHGhodUcAkoqYleQV80IqRcZSCp2/YNT5kahDrtpd+r7DH2o+v?=
 =?us-ascii?Q?baebZ1I6U0tP+7KbH8sOFSIvEl+T/Ys6Xgob8HeqqLv1Rq2xqAKjFuIzeMlp?=
 =?us-ascii?Q?WYvxwKhKfNLztPRCI2V/oeI6wINZ8poMushXC+6tFu/5Fghs10PjQNcmrDcP?=
 =?us-ascii?Q?SJVHs/WAIWBhM7GGEUDSaqzesrwz+u6/pPC6ABE2aclSS9AXRJJZ6aGK1yoN?=
 =?us-ascii?Q?/YQGgPlna/isn1YqAV9GF5dfyPh6OZVkWtNbq8ojZhzH1P5QME1HhWO7nHKO?=
 =?us-ascii?Q?Ph/CmwF4SkQgR98Xa856F1zAJQwUlZrTj0nMoX5blmf25awuWXN5aNXhzP9n?=
 =?us-ascii?Q?V5adVlwFOE5uiZGOQaP6XyMJk8y+8+uIGqvJVUKOIOg1ME+NeJgcBA6KdB4A?=
 =?us-ascii?Q?nnyRraggMHn9tfeX/OIm6jq5vchJDO98njCZjjd3htxR6CE++IQfoVXGLhlB?=
 =?us-ascii?Q?upUksgbWi0BilYUnvFeNEKsmHB8oK2fTa3xJ2oETroHbuD2Ydtccujb/76Ad?=
 =?us-ascii?Q?CLOTqvzzXcnS1of4nTaTgeyyCssbMZeApV2VnlkwHBeZAlXsxZzr59SzKV0W?=
 =?us-ascii?Q?SKfa++XI+FGOuMCs0Y+ns3UGmQ4ZSDlolFUYA+zJjoES8qYCVjGCNkYp7uWR?=
 =?us-ascii?Q?axSgfK9OEaJAO1KZ/+1yb/l2aBES2p/syYlGTLtRyBw8DeRS00w151j+52jL?=
 =?us-ascii?Q?F5rZIVXHi/BtnAYYSZMAmATN2Q1a0j6Qm9MrCaZ407GtMXtrSzxQuyUS6xHo?=
 =?us-ascii?Q?oEs1GW0TAq0NJo1+pmO7ngW4zH9H2hzyWogKLrVV+OYadIdWeEwb5BRRLftm?=
 =?us-ascii?Q?oPRctSsV7cxslOGuI5EiWwhxDRT9ZYCdp1zLXKzE6bO6uCkcPCGqSAC5CGWE?=
 =?us-ascii?Q?SVWVGn1r+/I+hf3BhvNi5b/bW/2gzFAZ+XvvdRMGpcou46GsAUIjCpl53LFy?=
 =?us-ascii?Q?F7PEWQVRK5l16FLb9mg5377lC6Z9+iRcokJfoc7VXVvxNsUmhPUQy104+CXG?=
 =?us-ascii?Q?otdlPK2bnlXu5+cwoG7rzaItLltjDPRVTThmbKFoF2ar5vURznPgEUwvkJnm?=
 =?us-ascii?Q?KQCxDioHKYgMvkrYG/JA1yBwdlYAPXAVtrVX2YyUy/4zBK0HTFrYExNFI2QY?=
 =?us-ascii?Q?WXYWgADxSI5crlAcgp3z3vEQLX3pnxnUTEmAc8tUKheTEsAxDOtII6F70uhO?=
 =?us-ascii?Q?K38ntasVRyJeEkjrVsqJTGBPDmo3yMHC+YzFxa5xTm1siAN4O5lzRWeh1Ms3?=
 =?us-ascii?Q?0WUiYz/nbVlktG1qn7f519q9uXtXixgmZHqvfCjKRJSjwmSpHpe7Nio6G2wO?=
 =?us-ascii?Q?PvQVIcFbp6aoqSeNM+XuJTc92N+zqu8wHb2RjPYs5D4h4ZpM3khW847GJfPa?=
 =?us-ascii?Q?x3Ol0uGuwyrnMuPyX2mH0nvO9D1PUvY1o3psV4ccJrTTMGX9wxYL8jgIXx4s?=
 =?us-ascii?Q?Q85wB34jSVUmFclTjjr06IySgD94YO2KhHvdXXF4AxpKZvQ93ZLbuy14GJWD?=
 =?us-ascii?Q?5N/j6ojCJ3dliOCF+M8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:55:04.2426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 376b6361-cdae-4d7c-cb25-08de3d73e143
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505
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

Initialize smu message control in SMUv14 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c    | 17 +++++++++++++++++
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c    | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index ba895ca4f3e6..9c15fccac2b8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1740,6 +1740,22 @@ static void smu_v14_0_0_set_smu_mailbox_registers(struct smu_context *smu)
 	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }
 
+static void smu_v14_0_0_init_msg_ctl(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	ctl->smu = smu;
+	mutex_init(&ctl->lock);
+	ctl->config.msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
+	ctl->config.resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
+	ctl->config.arg_regs[0] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	ctl->config.num_arg_regs = 1;
+	ctl->ops = &smu_msg_v1_ops;
+	ctl->default_timeout = adev->usec_timeout * 20;
+	ctl->message_map = smu_v14_0_0_message_map;
+}
+
 void smu_v14_0_0_set_ppt_funcs(struct smu_context *smu)
 {
 
@@ -1750,4 +1766,5 @@ void smu_v14_0_0_set_ppt_funcs(struct smu_context *smu)
 	smu->is_apu = true;
 
 	smu_v14_0_0_set_smu_mailbox_registers(smu);
+	smu_v14_0_0_init_msg_ctl(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index f8da61d993be..67a773253a65 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2113,6 +2113,22 @@ static void smu_v14_0_2_set_smu_mailbox_registers(struct smu_context *smu)
 	smu->debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_54);
 }
 
+static void smu_v14_0_2_init_msg_ctl(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	ctl->smu = smu;
+	mutex_init(&ctl->lock);
+	ctl->config.msg_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_66);
+	ctl->config.resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_90);
+	ctl->config.arg_regs[0] = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_82);
+	ctl->config.num_arg_regs = 1;
+	ctl->ops = &smu_msg_v1_ops;
+	ctl->default_timeout = adev->usec_timeout * 20;
+	ctl->message_map = smu_v14_0_2_message_map;
+}
+
 static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
 					   void **table)
 {
@@ -2859,4 +2875,5 @@ void smu_v14_0_2_set_ppt_funcs(struct smu_context *smu)
 	smu->pwr_src_map = smu_v14_0_2_pwr_src_map;
 	smu->workload_map = smu_v14_0_2_workload_map;
 	smu_v14_0_2_set_smu_mailbox_registers(smu);
+	smu_v14_0_2_init_msg_ctl(smu);
 }
-- 
2.49.0

