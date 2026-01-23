Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DEFD72369
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 10:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7051D10EA98;
	Fri, 23 Jan 2026 10:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I0nMq98y";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2024310EA98
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 10:11:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rhx7vigxTPDd8Zjbbp8SF/3lrf4yCeX13KLeyD7eibKZyqqVAMJBv16XHQB8vtYBsCclhNB34smhxRuuOMotLnpVb95AVhAZkkwAcITx3tLTgSh0Iz/5E6N0kEyH3K6J5NhNje+ve22Lyvtmep8A6nTN02bA+dV5irBZbwGBKwvqBIx8sOB+nSUHQFOyMxzVSQ7QQ1qxCHuM8+S93o6EyTdwiYVe3Lk7Rlj4siSZW+cvQkxS+cullQJBYUwaDkb+QhABdVrfZ5c0Im1/P8BHU/oDpdWX8QhtU2QILy2NNvR6QqVivVBI8hbzGknTWJOs15gBd51xdJQIQRGS3MUm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZ1sylgZZajIYl8gZe/EYvX2a7qSMR/MMpoHrTfEgXY=;
 b=Sy8ruLjqbzHqDIrgKLDAGv6x/1Us9kpjsERnKbSR1dtXeIL66nWKmkXNguvDsBUZnLZlNaBZYtCfhck1Xzo0/JRNd+Vf0HAWkBeLuIkF40mkB9Nq9dblZ9muDgmXJCduaMEfUw1rIS1L/w/pUtWXIS5LcMiOzHlbtCB4I/2F2ozJ22RCsWdQevqDRQ99JikZKS4Nk6xgPUyPep12BNAiyy2KrGRZUqHApRs0jYb1NoWchgei4p0NNgiULk6n57zqcMHNwfdwz/uLWVYbgaLfVxy2zaKB5TAPrV8uF+/F0L0uPq2JNx++JVjhlJ9nxADBq/phe//7gbhm7pa6zaWVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZ1sylgZZajIYl8gZe/EYvX2a7qSMR/MMpoHrTfEgXY=;
 b=I0nMq98y8V3pL9HoVN4QQ6JBOAwfRByHdYzXGZjwNc12OqCaikKA2dGaBklfaLDhHpN5YlITWf8ueHCqOv5ZNYbQz9XOF0eR7t7jl5zk51flreFzxIKL+5ZBrE6MZizOCI4bAY6HsGO2SmvYRBbvFZafuyvCFpGXDF4ld3Vi9PE=
Received: from IA1P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::15)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 10:11:16 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:464:cafe::dd) by IA1P220CA0015.outlook.office365.com
 (2603:10b6:208:464::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 10:11:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 04:11:10 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 04:08:21 -0600
Received: from kenneth-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 23 Jan 2026 02:08:14 -0800
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <KevinYang.Wang@amd.com>, <Alexander.Deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: use debug port for mode1 reset request on
 smu 13&14
Date: Fri, 23 Jan 2026 18:08:07 +0800
Message-ID: <20260123100808.1992-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: d04fd739-e049-455b-e09a-08de5a67be7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t/9V/PrVvKzS1BfoPJUWXCwMA4zJiJnjOP1/p1f/HcP7MsSg2jQTY4dUtNBj?=
 =?us-ascii?Q?qmKozrlDdVn474700EA0675GjaYSz4gSxoTtNMyBT2jHfPvrkK3y0jq0vYEN?=
 =?us-ascii?Q?c/rC2aUHbuyKtT+Hi678daB6Ad5rgeMiw6svfvcy7AKrhptS0+W67mlAV4zA?=
 =?us-ascii?Q?1VMqw4FQ9nl/7wjuhs6tKPuySRYdXJ+E2RjzCbDdipmIVRtgDQLWrj+Xlu/2?=
 =?us-ascii?Q?1zzlA2UY9EWPPy5hT4e73AURoPgveRcBsiop2bA5KMqIKCFjqM06vK6QV22X?=
 =?us-ascii?Q?oohIy3Rkzs/le5i23X/Ddf4ybhNGQxg+lekToX3PfH6jqKTdlPuXX7Jc+4tN?=
 =?us-ascii?Q?SdZf+iPRPlABwdAMtJU7eycwq+NijbBPDGAAltPzfGmeMfPsvap0IuW0gjqd?=
 =?us-ascii?Q?65OkQmceqVwIEarsQHuknSUpjcfCz0/ukZE3dIhEHuiZ/OuijMjwHtgFyuYC?=
 =?us-ascii?Q?gARyl/dQ8taP9gqAj0xFw/uj162tRN/zojNBv6Kv3bU5h24KVe/prFq/DODy?=
 =?us-ascii?Q?MIIE5YOqmvIRXeuHK13eRrhWTHHYQh+nMRa8dcQVYEBoQj2+LnG/iObmfA1e?=
 =?us-ascii?Q?m3OslatWawwrWM2HeL6HNnyC4xzJiHTBipgfOD/kKI/09vKcNxTusJaGpCo9?=
 =?us-ascii?Q?/f5lEM9tehmzXVeNKJsLDHRgwHpthDwTo9U2sWGH/7NTC10YRlnRUB3wnU85?=
 =?us-ascii?Q?JAa1PiOz+Qzl7F6empQ1+QV8MGUjzvp/9bZbXkdJF1CfjUnMow6qb/rRlhMH?=
 =?us-ascii?Q?kSzf2qTb6jdtQ5T3pXxoHpCtlJ+oKiKtNx/QQrQAJEmDdiiB5VbWF/X4xzC8?=
 =?us-ascii?Q?l14NpES2QnsGnVFTUTDPHYQ1dUdcTtjhuwnUaQiV4qFfQjCQvzR6+SOE9Bhr?=
 =?us-ascii?Q?64tkPQ4vxX0RxnJnn7uxv1EbHch0Q2+AYS817AzR6UZpwGnf91CzrDb7Fzp3?=
 =?us-ascii?Q?Y7RkO3cJAfIagTdurQ9kdL515bptt/2YNR+yYb/4wkuY5RvJztCh2ybZKCK1?=
 =?us-ascii?Q?VHKh6qpzOG6SaQZLdV8bl+UZULerXBnsGVeXXZ4VZ06A8n2vIfPwypG6U28+?=
 =?us-ascii?Q?pAMDPc5pV4rx5ghiKfGit0a1tosCJdmdP1hE4z32ZM7BfMjWqJITHDdj5Ts7?=
 =?us-ascii?Q?fTqKfdV7GwHVkDxsGQdJ4kSJd8171MGhGiBhket+jcGvppO7MR519Ka1agO8?=
 =?us-ascii?Q?OizC/dJBHT0r32831LYrI2ELBDygPmAamXL8K0wrLWmWH6Yu2XxfQnhKTjwo?=
 =?us-ascii?Q?6cKMe9S+8eDKJ4LVyDTCU5vprnKECuYnlBkes2vZMZkGO6bL4rKqRzItbWEq?=
 =?us-ascii?Q?0RK13wcu/uvWTFaaq15YOVZLwEhtvrbjwQ1rDTFrFdkP7QsDlkXNvkLmI/ND?=
 =?us-ascii?Q?TJIwZJVo9Sk2SrG0pf634GOAsll3jRDIeHvP8jo93oajuU39AMzespHgZXTO?=
 =?us-ascii?Q?Z4Qr2bQxbHPNw09MQA5yS0hd1V+0Y0x46Ts7aK4YOhZtpSee8sN7tPD1+U5t?=
 =?us-ascii?Q?kCNIYOqTgAiYZSxvXYPQUZDusMeRXFODgJoMXmObf+bC6WdyvgyVnPbs7fCy?=
 =?us-ascii?Q?mhcj889JnLNSVAGWiAvfavjc21N83QduBEBxxqPowKKwOii7rpZEcpy8+Hue?=
 =?us-ascii?Q?xdzEDbJ4dADkQ8LFvhOMqabP475/7n2F0bEZewz8Uukf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:11:15.6773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d04fd739-e049-455b-e09a-08de5a67be7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
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

use debug port for mode1 reset request so fw can handle mode1 reset
even when it is stuck.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 14 ++-----------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 20 ++++++++++++++++++-
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index ce52b616b935..d216db3b804b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2617,21 +2617,11 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	u32 smu_version;
-	int ret;
 
 	/* SRIOV does not support SMU mode1 reset */
 	if (amdgpu_sriov_vf(adev))
 		return false;
 
-	/* PMFW support is available since 78.41 */
-	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (ret)
-		return false;
-
-	if (smu_version < 0x004e2900)
-		return false;
-
 	return true;
 }
 
@@ -2830,8 +2820,8 @@ static int smu_v13_0_0_mode1_reset(struct smu_context *smu)
 		/* SMU 13_0_0 PMFW supports RAS fatal error reset from 78.77 */
 		smu_v13_0_0_set_mode1_reset_param(smu, 0x004e4d00, &param);
 
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						SMU_MSG_Mode1Reset, param, NULL);
+		ret = smu_cmn_send_debug_smc_msg_with_param(smu,
+						DEBUGSMC_MSG_Mode1Reset, param);
 		break;
 
 	case IP_VERSION(13, 0, 10):
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 0375e8484b2a..5a212a4641c3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -72,6 +72,8 @@
 
 #define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE	0x4000
 
+#define DEBUGSMC_MSG_Mode1Reset	2
+
 #define PP_OD_FEATURE_GFXCLK_FMIN			0
 #define PP_OD_FEATURE_GFXCLK_FMAX			1
 #define PP_OD_FEATURE_UCLK_FMIN				2
@@ -2735,6 +2737,22 @@ static int smu_v13_0_7_update_pcie_parameters(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_7_mode1_reset(struct smu_context *smu)
+{
+	int ret;
+
+	ret = smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset);
+	if (!ret) {
+		/* disable mmio access while doing mode 1 reset*/
+		smu->adev->no_hw_access = true;
+		/* ensure no_hw_access is globally visible before any MMIO */
+		smp_mb();
+		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
+	}
+
+	return ret;
+}
+
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -2796,7 +2814,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.baco_enter = smu_v13_0_baco_enter,
 	.baco_exit = smu_v13_0_baco_exit,
 	.mode1_reset_is_support = smu_v13_0_7_is_mode1_reset_supported,
-	.mode1_reset = smu_v13_0_mode1_reset,
+	.mode1_reset = smu_v13_0_7_mode1_reset,
 	.set_mp1_state = smu_v13_0_7_set_mp1_state,
 	.set_df_cstate = smu_v13_0_7_set_df_cstate,
 	.gpo_control = smu_v13_0_gpo_control,
-- 
2.34.1

