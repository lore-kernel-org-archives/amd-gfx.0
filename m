Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FF4C3600C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 06:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63B6410E1A4;
	Thu,  3 Apr 2025 06:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LLpyGu4X";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82A8710E1A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 06:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kotgdO0aJEfIxhB2qPRaiL2NCMu4KrSvUERSxa26Po4VvZ2bt3ibWRzeOASap8zKe2b/WcF4hNoJs1I/JfNJOtNWEZnPk3TBRQG0XpVVudrQ+n1N2khe/p9PmyaV1kZ6oKU+BA77QDbArr1NA0qfHx8tIV007dqvUmFpXkTqcXYaGSNYMcj4PnK0Bkzh0WvY0ylgGnPyrW6Un2TKM8+J76bKqnYZSDw8F0SuOeFQXlo+6YzaKEAeB1YC/XpTHKkttYat5+Ed48EQZUdKAYmkqd3doB8A0/w0yvhZRgyyleojFPuZSZhKjenPyNlifd7zp78+AXCo3It2pbIZ1uMJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evJzuptWIIJWFemQFFcwSTr28oAa0RjtsE+QacdurKY=;
 b=cEIeY8mACGjJafoG8q85ebwgpK0nxIwxiOpmtaluGjC0Vhz7/asZnwBE3oDDvcZaH55AecE0u1Of4+MabkipgaxISMvMdwl0pyo3pv5gr3INiMBLR9ReNEt31e/zCItuxE0l2rL4U/r7QM3/4gj/8s3t0XE+gjid9Or9sd75H+pO3P8DSYfY5CKb/jE8ueK9yMKMMGYlXVQjYU+4bYQb0IJboc5ejS84LS82ohPRrFGPR6ZSRG3cSdJg8Q0v9Hq3BaOmAzva0Sl0TCXrLRiP5m3agpIGIepQpZRD7Ki4CNjtJQWeXl+0EhnnrcCvZUKtnP9ymcr6io5Qpq4hFxTtGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evJzuptWIIJWFemQFFcwSTr28oAa0RjtsE+QacdurKY=;
 b=LLpyGu4X/LXmmR6LJ9oIBglMztquTMU0FPVr7HLsgaP3nhak3+kv9Y+v7XJx+WdwXLCbhaIlR0OMxHUx7GS5mm+CG/LMxKCORoQOBJ/9rOrMEikm9tI5hGM7WVqA/s5v0skeQQ2VYXUmXdx25T2mdd3iVxMCMq7VeMyeR0vVNMw=
Received: from MW4PR03CA0153.namprd03.prod.outlook.com (2603:10b6:303:8d::8)
 by CH3PR12MB9097.namprd12.prod.outlook.com (2603:10b6:610:1a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Thu, 3 Apr
 2025 06:48:23 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::14) by MW4PR03CA0153.outlook.office365.com
 (2603:10b6:303:8d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Thu,
 3 Apr 2025 06:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 06:48:23 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Apr
 2025 01:48:21 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: add loop bits for NPS2 RAS page retirement
Date: Thu, 3 Apr 2025 14:48:12 +0800
Message-ID: <20250403064812.5003-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CH3PR12MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: dda6ef5a-bacd-4325-0678-08dd727b8743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aUsOUeCcBxI4FOO3OQEZ9r/y6TefqcKOT5JmR3SX6NO8h/dleV8PcR9AwtU6?=
 =?us-ascii?Q?gZlhtvwQr3HRSjWY/T9nfR4lworaZYh2Ue7zu6vFEoNnoWJNGR1n7oDr9KQq?=
 =?us-ascii?Q?ugYk8wqAio+7hWvRQWfty40KyiBvDqCrxoKfko8JuWzVzON6+q45T+Wt+zO8?=
 =?us-ascii?Q?j0cBJD1bK8k3tomUmZv1CqlRHQRtvtbYYH8SloSe0M8zDvDNVYHcFEkMIXTW?=
 =?us-ascii?Q?uFCaDzyVYMvnw4x6d0D6+A2Xi6cz5qvZse9dnmayTPw05GTD35ohSlLxFwkW?=
 =?us-ascii?Q?OCUspJVMPay6/fDhdJWFAvjkKECYFc0npG4foYaxG+TffmgW4Opwc+xAks7z?=
 =?us-ascii?Q?1dRp3jv+TDvyuHjdmCEO44s6BTeM+wsjT2Xg6JOvC8xe47AC2SJo7srB6zWh?=
 =?us-ascii?Q?7/Rj3f2YzEb7Hzw5cZnAJ4/ZVpRvvQ1WR1+mQkKNSAWYJZbtkmFHNNoCKMvI?=
 =?us-ascii?Q?gAwQF+AzftiWlEwOrIf/IOd3KsCORt5KEEAy9vIhe1/Q+xXx7fhFnXMp4DaX?=
 =?us-ascii?Q?DQGB5tkPfBlbjdEpr0gxJXH20AG3LkscuyiSD4Ug/4yH0fzPSDKgexBh0e7f?=
 =?us-ascii?Q?GWc/acXrwKjqCEhys6VA3JhVjn5HzxHD/OdluobRTrOPdZb0FG4bXgUO9GcY?=
 =?us-ascii?Q?4oNyt3yAjcMJTBPqqBtTO1cgjwAT6ZfPJMyVFUgU4jpGi7Hh7UZZTeriBaRQ?=
 =?us-ascii?Q?HCmgGT2rRYGh+S5AwswFaNweu3d68pxpRkw9w1rK1mqCHZD+FrR+F4uT6ZoF?=
 =?us-ascii?Q?DZWuRxdNcaPtRAxZuk0/fOU6qEjtjMkVahtDp2OCPs/4AhEtgz7EhSvj1sWr?=
 =?us-ascii?Q?JSG8IYTbhBdlD4SPOvctwtUm1Z6Hnxgyi4pM24lIuCOQzAGWCD1GTPSW1nqt?=
 =?us-ascii?Q?FqeBMSg8yzfP8dsK9CPXid8v5tUFKhPKk8Gu99AQ4AyZBFjHjaV5iM+eQkxi?=
 =?us-ascii?Q?D8nUwNdwwVT8mjVaSXLrCId6eYBJC46P6/G1gUkiIrqJy0oYT/7eSH3N+YJq?=
 =?us-ascii?Q?MYBNAOGEyllFRVssEOcteeJMfp9TYVPjxphahYt2lD2dmvQb1799fUEQqzlv?=
 =?us-ascii?Q?ncAxMi2PofKbC3lw5XoIljeXvpZ2aHX4Ko/0Sp9Y2KcIhNsPl5BAjVEYu8Po?=
 =?us-ascii?Q?M4yzgPwfF6pV3sC844imPv5uUKc5/2a4CdU8qwFwZEszwIHG2Je7Do+WK9Oa?=
 =?us-ascii?Q?27m4xMod6earUEkvHRrZKUHUHzdPDXRsZ74ie8/4RiJxHXvS4yQDT0rE7y8o?=
 =?us-ascii?Q?0t/Top80KxAm2iTrr/2OhEMVfrlWnuUaZ5C1eQ5DhI19k7TJr+CPqX5bVvkk?=
 =?us-ascii?Q?IjtQV4P3tWVVBkA3WUI06xihPjVTuM+TA0RgkIzT3fT2PEdRGAHxCPClwSJ/?=
 =?us-ascii?Q?dugjIitBzs8h+NGnJlrUvHSWSs82ykpAgy4r3SxGj6T5aWNSUX/BGNXSbR+u?=
 =?us-ascii?Q?Xzg9OmR707+s9pi1jBLuYjZE1oSM1iHCQKqhmpAkBubT67KRx+WWDw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 06:48:23.0932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dda6ef5a-bacd-4325-0678-08dd727b8743
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9097
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

Support NPS2 UMC RAS.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 0e404c074975..da00d6b3b6a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -220,6 +220,13 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
 
 	/* other nps modes are taken as nps1 */
+	if (nps == AMDGPU_NPS2_PARTITION_MODE) {
+		loop_bits[0] = UMC_V12_0_PA_CH5_BIT;
+		loop_bits[1] = UMC_V12_0_PA_C2_BIT;
+		loop_bits[2] = UMC_V12_0_PA_B1_BIT;
+		loop_bits[3] = UMC_V12_0_PA_R12_BIT;
+	}
+
 	if (nps == AMDGPU_NPS4_PARTITION_MODE) {
 		loop_bits[0] = UMC_V12_0_PA_CH4_BIT;
 		loop_bits[1] = UMC_V12_0_PA_CH5_BIT;
@@ -517,6 +524,9 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 
 	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
 		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
+
+	if (nps == AMDGPU_NPS2_PARTITION_MODE)
+		shift_bit = UMC_V12_0_PA_B1_BIT;
 	if (nps == AMDGPU_NPS4_PARTITION_MODE)
 		shift_bit = UMC_V12_0_PA_B0_BIT;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index 9298018d938f..056bbc038312 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -65,12 +65,14 @@
 /* row bits in SOC physical address */
 #define UMC_V12_0_PA_R0_BIT 22
 #define UMC_V12_0_PA_R11_BIT 33
+#define UMC_V12_0_PA_R12_BIT 34
 #define UMC_V12_0_PA_R13_BIT 35
 /* channel bit in SOC physical address */
 #define UMC_V12_0_PA_CH4_BIT 12
 #define UMC_V12_0_PA_CH5_BIT 13
 /* bank bit in SOC physical address */
 #define UMC_V12_0_PA_B0_BIT 19
+#define UMC_V12_0_PA_B1_BIT 20
 /* row bits in MCA address */
 #define UMC_V12_0_MA_R0_BIT 10
 
-- 
2.34.1

