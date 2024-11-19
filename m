Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445B5D60D15
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 03:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E84F610E15C;
	Tue, 19 Nov 2024 03:13:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yZ/Cr8ip";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3620F10E15C
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 03:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLxjHiA+7VFVSjueQ5C+6Y+gYXgRM3Nx2S9rxdUyp8Fnm7znSbihom4wDWELOJI4/KQJE3gKGnF/YDMzMdF1z0LvC6TMuk8wnYKqpXZBhDMbP+bdWYMqS7lGnMfdkh+JImBjWyIxUfQxuTne4JkwxK/ERW62iVMNOLG+TykOVe/JQtgAp887jAzbryL/RgHqaw6VYJkXpsGoz7nEzmLCJSBquWZJJwV5doRCuBJZqGUWGxlk0HwxELKYucowfhVpMi1GNHmly+7edRVicMPyVmyF8zfoJUkkyf0Zakzyd9aTubxHHuAE1qXJFuf9vxEq36xraSJGMhrT7MgSntChSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3D2ZriPZB0XvxIb1O8WfSwyKCx1JLV5nOxAhslKtyg=;
 b=upocxwjlzrjrui/mPWaHQJAhMRp1WNyPUBxYgnqDlf6i3D7/IjmtGV4JjbGkcXaeej/pfrTQZnBiu0+g4ioxpdnqeb3vZtCGTdf3SneYpXUqUs0JOL3GaSIV+DZIcDoFu6YKY6w/635WfurS2OeI0+TI6V0vEzhObiltZpV8H0R9mxRluC/hLqY0dgtkEt+Ilf17OVlPc62BAU+VO3PHtqjEacnggMbGsi5O3x0SOpeRPeRvSILuJFfu5rigXEWyldVEKbfOPmHyc3s4yFA0lnhV2SOCHaEXbUbb1DTuw48bcpO8fD9wk2nNLmLrEW5geugZI38+DRaRqa5yKHzsdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3D2ZriPZB0XvxIb1O8WfSwyKCx1JLV5nOxAhslKtyg=;
 b=yZ/Cr8ipm70DM2k//Tfiu75iuCrhDX4wWo1hL3TtRxRliKhhbMVTaFk7eWFhM9fh/QegloUCzmz/Fon+/AklQeEQPGOL0mzFqmSdcuhYuU4j0TFlS7JJmUFHz9KlLLq7+CS4/Rs7RhipBe++ycMEfUeJx0RX/9q6DjV9GDkLpoY=
Received: from MW3PR05CA0006.namprd05.prod.outlook.com (2603:10b6:303:2b::11)
 by SN7PR12MB8820.namprd12.prod.outlook.com (2603:10b6:806:341::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 03:13:12 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::d8) by MW3PR05CA0006.outlook.office365.com
 (2603:10b6:303:2b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Tue, 19 Nov 2024 03:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 03:13:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 21:13:11 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 21:12:34 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Mon, 18 Nov 2024 21:12:33 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amdgpu/pm: add gen5 display to the user on smu v14.0.2/3
Date: Tue, 19 Nov 2024 11:12:31 +0800
Message-ID: <20241119031231.434471-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|SN7PR12MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: c0312597-340c-47d9-e8ff-08dd0848199b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8DQLuuvox3herZ1dvtsQEwbt9bBwnoqUxegWaHYrC9xvpd4q3ha4/G6g93ye?=
 =?us-ascii?Q?p9IrevBVLV2dkCj4eSRUkjqW+aeXwoXy7a/SfyoGePWSOGOmP4aDs/D+Ydpp?=
 =?us-ascii?Q?4nSKbcyxBBjHv493MXPNqMhN0Pli5fs2NCvDUr+eUJIBaRoRJ5FPJdsEdlo5?=
 =?us-ascii?Q?jmepPNDENR3kabcj/WcQ+W8Ydup7Gc6FiY+8gl4TtVOD4DVjgT8QAdfykBFw?=
 =?us-ascii?Q?/UpTdmmPHi0FFmxy441K+sJ0xxAgQOnEmW3Wq2lXykst7tADh7MrakH/g3ur?=
 =?us-ascii?Q?QHo51z4x3aTrMcvhNLa4Du7hg6f7kNHnpOXdCbmoyVYA65w/oYJ+2gEsfvh3?=
 =?us-ascii?Q?e1LlP7yKeJ1kmoerx2EFiVrjsW+p9jTIetVZxYH88bJGgALlgylQ6H5EVHKv?=
 =?us-ascii?Q?gXdinO8TFTcdp//PYHD7vd9tLkPs8Yvb2SFU1kF0zB7zUPSxRyU9iZjGGu+d?=
 =?us-ascii?Q?PzLTPG4oQweTVg3yMHIVkXwlaA1MkxUUHkXtz+wrp/7syw7Uemkq2geGRcbQ?=
 =?us-ascii?Q?n1k5hYW3SqEvzj6xk9cGMfYLqcogdhjDT8sTScOIsDhbXjt1NQmaQ7PCTzdE?=
 =?us-ascii?Q?FvWLCoCPMr88WiwsMlO2bbe19czBpuUIZPBngeJbKLWl7PG28gbR3A5u1vvn?=
 =?us-ascii?Q?Fl4rxiYXQkOr8iMdqk61tcaLVGQzHZq2tQxB8YuVC50UbP9HEt2+oDptEW0B?=
 =?us-ascii?Q?vXkX+K8mdJLW1+dBcNXK9VM1QPstF4H7QMUex68OjuIaV1ogd1od7aU21FYV?=
 =?us-ascii?Q?guRzNCzjXclfUO0fkVsat5zloSNUCIHoAzDxohsJIaSoglqeNvYS0VHdCIVW?=
 =?us-ascii?Q?hyXAMm2/QFl+D6/o60OZcxnNaShJTqrAGytC/dAZEdZPaWIfMSfQiHnzJrPT?=
 =?us-ascii?Q?beuApeMhfgKu9jeterb+6e06lZuT72mrCgh4kaFWIvh/euF06SPhjW6vbAtR?=
 =?us-ascii?Q?Vo4odD/yqHJFEPF6gmw3hBJOEka/FIrAnpgqAaseWvo/mgseKYBT0GGoJPHd?=
 =?us-ascii?Q?5ge3nELFuOIL6RBV6PymQR68jgiaJvK/YYawIqmkk9vBpMD43legYrYDIqfM?=
 =?us-ascii?Q?ZJDi/8UMveNUyHRiAW/1h/SQckI3tzSDG2Qw5EULLYATg6XYKkZ7vH0JKPDq?=
 =?us-ascii?Q?KWhKSw8A359BQ4lQIxI4lNQP55x1aJ8Kj28CP3BKqNL1097VjslWOfuSjyxm?=
 =?us-ascii?Q?a2ANBL/kGwtadZzidfyiFDOp6lgpLsovez2rjMComfWfC7unczykVvZwW5PC?=
 =?us-ascii?Q?H5R8n4naTHQAWilPjYaIY23BobmIVWGwqZ83GoTFrk3/dvMlA3Y/VC9zF21t?=
 =?us-ascii?Q?dTx5pyLuY1fvLP3pV3jWXLebnDRlpON90nm7rap42gtXBNi1ZGKsLx9Mfa+D?=
 =?us-ascii?Q?Vaez1K+PMaKLCZXADNmL3rMlUJ/bKB5zFvBtSJyIJUwOUQ5+4Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 03:13:11.5231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0312597-340c-47d9-e8ff-08dd0848199b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8820
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

add gen5 display to the user on smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 8 ++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h         | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c       | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 6 ++++--
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c3a6b6f20455..5cba64996cdb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1714,7 +1714,9 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
-	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
+	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5)
+		pcie_gen = 4;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
 		pcie_gen = 3;
 	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
 		pcie_gen = 2;
@@ -1727,7 +1729,9 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	 * Bit 15:8:  PCIE GEN, 0 to 3 corresponds to GEN1 to GEN4
 	 * Bit 7:0:   PCIE lane width, 1 to 7 corresponds is x1 to x32
 	 */
-	if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
+	if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X32)
+		pcie_width = 7;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
 		pcie_width = 6;
 	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)
 		pcie_width = 5;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 0546b02e198d..29a4583db873 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -53,7 +53,7 @@
 #define CTF_OFFSET_MEM			5
 
 extern const int decoded_link_speed[5];
-extern const int decoded_link_width[7];
+extern const int decoded_link_width[8];
 
 #define DECODE_GEN_SPEED(gen_speed_idx)		(decoded_link_speed[gen_speed_idx])
 #define DECODE_LANE_WIDTH(lane_width_idx)	(decoded_link_width[lane_width_idx])
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 5460f8e62264..4d083f7f772e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -49,7 +49,7 @@
 #define regMP1_SMN_IH_SW_INT_CTRL_mp1_14_0_0_BASE_IDX   0
 
 const int decoded_link_speed[5] = {1, 2, 3, 4, 5};
-const int decoded_link_width[7] = {0, 1, 2, 4, 8, 12, 16};
+const int decoded_link_width[8] = {0, 1, 2, 4, 8, 12, 16, 32};
 /*
  * DO NOT use these for err/warn/info/debug messages.
  * Use dev_err, dev_warn, dev_info and dev_dbg instead.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 59b369eff30f..5e2629219280 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1173,13 +1173,15 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 					(pcie_table->pcie_gen[i] == 0) ? "2.5GT/s," :
 					(pcie_table->pcie_gen[i] == 1) ? "5.0GT/s," :
 					(pcie_table->pcie_gen[i] == 2) ? "8.0GT/s," :
-					(pcie_table->pcie_gen[i] == 3) ? "16.0GT/s," : "",
+					(pcie_table->pcie_gen[i] == 3) ? "16.0GT/s," :
+					(pcie_table->pcie_gen[i] == 4) ? "32.0GT/s," : "",
 					(pcie_table->pcie_lane[i] == 1) ? "x1" :
 					(pcie_table->pcie_lane[i] == 2) ? "x2" :
 					(pcie_table->pcie_lane[i] == 3) ? "x4" :
 					(pcie_table->pcie_lane[i] == 4) ? "x8" :
 					(pcie_table->pcie_lane[i] == 5) ? "x12" :
-					(pcie_table->pcie_lane[i] == 6) ? "x16" : "",
+					(pcie_table->pcie_lane[i] == 6) ? "x16" :
+					(pcie_table->pcie_lane[i] == 7) ? "x32" : "",
 					pcie_table->clk_freq[i],
 					(gen_speed == DECODE_GEN_SPEED(pcie_table->pcie_gen[i])) &&
 					(lane_width == DECODE_LANE_WIDTH(pcie_table->pcie_lane[i])) ?
-- 
2.34.1

