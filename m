Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8503C87FCA
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 06:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60D5310E703;
	Thu, 31 Jul 2025 06:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CgqN1skV";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A83CD10E24B
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 06:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqdm0onRJ45GWbrwuznJlegwsksrTirTZgGphgH7ujfPXouREB4FrqJFl8Vf+IEqTsYTUTh+T3PL3aD3MUmgJ28VrG3WMGZtG8vUa2npSnMNxkPIHMmeuJ5uWHX+IYdXYqscF+NgoxWLFPrVh+SOGThxE+WjPuwaTEKYt0Z+e6ShK7/te5GUvh53gXEXeZOAbJTaDSlg5Ro9yDlmjT0seHdeFSvYz8DPApJoxMBwtZQj2+4CDTDOOEXAbTnCrhxS42xLFNDZXNi5zi3ISGF3NJteCA+CbRWaBXwl17yNnRVLF66DMDDEuSGsYxzlWaB4J15NCBO9gJF/VbknK14plQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyFyvm6RdUslLcGN2LfyJzLFh93H2BTtq0rrvDosU6Q=;
 b=D3XTG4pek/h7AsW4XSEYyLK7FIUBzga+aJJG/jPpDr8hT0d8yAyJvuqSedoHFTZzkCUppTc2bcTPG2JcRaiHs7Zc2Kp8Ptwq8BvPv0UvKBwxuCjlTWfMym5Wo7j6tnb+VPyCaADixcES9BVkuc+TrZ++o2yfbJzxz4PBbYJV3o68nyZw5WTmx2G5i94g/BLp3YUX9quTjNT87fxaR8qfR7eJuGE1OhBY2UZtZuEWEaNFCwCwfDCImRuERQgfQA/QaOUAOq8T8KYwX8X/7cyJQNVBNLEPZ5Ukv5hCKiEpqlJ2d0fQ4Ebhy1GaDOJoLNbUykk/vWvvkmvqaY1zDDcaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyFyvm6RdUslLcGN2LfyJzLFh93H2BTtq0rrvDosU6Q=;
 b=CgqN1skVQrUdgkusQVSrq2r5z65T+rVOeiLLqyjPSmaHqVxOK1y690l13NjZXS4sBCFtuyOlg7TGpdIx9gqYPCoafYCJnw5O+rXXeCXjFsuf0LWqZzTVxYuEMzWm2DCPHrYmkK0lGdO3/dnwJVApUz3M+IjgaLmVqgF4QECicig=
Received: from BN9PR03CA0343.namprd03.prod.outlook.com (2603:10b6:408:f6::18)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 31 Jul
 2025 06:14:28 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:f6:cafe::72) by BN9PR03CA0343.outlook.office365.com
 (2603:10b6:408:f6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Thu,
 31 Jul 2025 06:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.0 via Frontend Transport; Thu, 31 Jul 2025 06:14:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 01:14:25 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Ce.Sun@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Set dpc status appropriately
Date: Thu, 31 Jul 2025 11:44:06 +0530
Message-ID: <20250731061408.1699369-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250731061408.1699369-1-lijo.lazar@amd.com>
References: <20250731061408.1699369-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: cedaecdb-1d61-42bb-23c3-08ddcff98103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HOgVrKI8abfR445rX2MZAPxZJ0jQGuoWpScriAml3rDPn46RV62gAWlNA35Q?=
 =?us-ascii?Q?SeihpbsPYjLVUMkNRx+oyhISRRvzHBujprdAPMzUraU8+QuuXSj30Mu8vVgt?=
 =?us-ascii?Q?VobHW4pyZGba3rR5kcE38lbU87O/oYdH3TqJMMC8swDtvEzYeJSO+fMdSKaA?=
 =?us-ascii?Q?deOn1H26P944TNivWaFAPk0e+EzbjRqescwLecb1zBfpfc16wlySPPR8y8HI?=
 =?us-ascii?Q?siPxcEhZZ55qtf0ee0CLlRhYBRM2LsjxRf3hQMf0ERASjEMBaZeAdRUT26WP?=
 =?us-ascii?Q?XxwUN+1I/xgz+QQ16mW7BNqfB1I5uf7E2OgyZov2USblobT3GamqnXlnr2Z7?=
 =?us-ascii?Q?qtUb5tbXWui3G4BhGXqagEXe5YePGOoWVEBiyLmit8MJsLs1lcvFLvp5uXwh?=
 =?us-ascii?Q?/sVp5H6RQPSJw2lbWcjE7y/bmTnXcnCof8uYcYcTALgMSpzJ/KviJiqTsIOH?=
 =?us-ascii?Q?oxWlRn0sMrP3fGcCLj3X5NztY+rhoGAmur5P66QyxRhZ6sF2CgU1XSMqD066?=
 =?us-ascii?Q?OhLtW15VSloxXrg3TqipsqFHRofmcGXSmX11yDqRac4meX2X6YWiFbmUH/rA?=
 =?us-ascii?Q?l+JVL7E01uy/FgZZYkME08+Mhmpz4ortbOGTiKNFgPjyTmZcx4zQIWwIplVJ?=
 =?us-ascii?Q?YiKCeGT1q2f7bs2jcVq94RvtSLqZZ39KDewlJkEN8IEHOb6Km3DfWXVbzvWS?=
 =?us-ascii?Q?x/SMdAKpDa3ZC960b4b93/aWHwP7uCxLs+QzDrLsMSMqpHCvPAsSShtLEvQH?=
 =?us-ascii?Q?MXntW4DfxVqqelwYXtkos2jhMHZzKbipNS5t7hzWXE2MbGKz0Rz8UesMBtQN?=
 =?us-ascii?Q?0C9TKc4X5SEgzY/GWBzX/lMIcyNbnB6cKNtLL0Ast3pu8hmKHNMsZw+PZYbm?=
 =?us-ascii?Q?WqasRFe3fYONt9sYYSvWivjO8Ik7KdWuOZtQp6j/yDtp0nAqPtylUJ6japLO?=
 =?us-ascii?Q?4jYIGhvRyPuubqo50QbITdZTQsjY97+zQ+wHNEPg68FAVWido9pI6MmugTAS?=
 =?us-ascii?Q?taGZZoUges5nx6tyM6oN2DNw5zAycv2NjC8XjBpsChYNw1dSFL8zM9WUbQyx?=
 =?us-ascii?Q?2Bl2Hc8TtEinihfrPVLJggS1De2DCxU3SlGSo9jXuA5rCzozfEOfP3WYejWy?=
 =?us-ascii?Q?6kPLfgm4SOZGssoP+qgCt1o9PQ2T8tvQnfs2ZMwxyhmwjp556XesLOE9xwg0?=
 =?us-ascii?Q?WBkL1fbIWJgiGujgYqGj5uZKyV8B7MqvJrhYNvUy2JYqBmpU/EjZoWJcRq6N?=
 =?us-ascii?Q?I6ncRRTZeZhJdROU3LBrEXiBlV88AklJw+gV/Q45x4AlhH8GCF2OFDBiIQZp?=
 =?us-ascii?Q?EY9uqKYs+/IahhqpG5HLZs9FmuYB8/lxTlwM9k3iOCSBcLbXi2lpdhi+j2Tm?=
 =?us-ascii?Q?/cBGpfZqY2Z/zWWNQaWVOzHIg5wvsbxzF+PjtS5wXXL6UqamVKzVJzJPKQVT?=
 =?us-ascii?Q?hhO27y5iuI1Gc3jcAt99odRHNJasrn2MiGL9/S8SIXTYa1TKQH6HO5AOZF4P?=
 =?us-ascii?Q?f4kYlVRIUruTYIZVmDMzLo/Qw2ZkaBy89V53?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 06:14:27.4337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cedaecdb-1d61-42bb-23c3-08ddcff98103
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
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

Set the dpc status based on hardware stae. Also, clear the status before
reinitialization after a successful reset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ea66322c279b..076ad472a95e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5836,6 +5836,7 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 		amdgpu_set_init_level(tmp_adev, init_level);
 		if (full_reset) {
 			/* post card */
+			amdgpu_reset_set_dpc_status(tmp_adev, false);
 			amdgpu_ras_clear_err_state(tmp_adev);
 			r = amdgpu_device_asic_init(tmp_adev);
 			if (r) {
@@ -6882,11 +6883,6 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 
 	dev_info(adev->dev, "PCI error: detected callback!!\n");
 
-	if (!amdgpu_dpm_is_link_reset_supported(adev)) {
-		dev_warn(adev->dev, "No support for XGMI hive yet...\n");
-		return PCI_ERS_RESULT_DISCONNECT;
-	}
-
 	adev->pci_channel_state = state;
 
 	switch (state) {
@@ -6896,10 +6892,23 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 	case pci_channel_io_frozen:
 		/* Fatal error, prepare for slot reset */
 		dev_info(adev->dev, "pci_channel_io_frozen: state(%d)!!\n", state);
+		if (hive) {
+			/* Hive devices should be able to support FW based
+			 * link reset on other devices, if not return.
+			 */
+			if (!amdgpu_dpm_is_link_reset_supported(adev)) {
+				dev_warn(adev->dev,
+					 "No support for XGMI hive yet...\n");
+				return PCI_ERS_RESULT_DISCONNECT;
+			}
+			/* Set dpc status only if device is part of hive
+			 * Non-hive devices should be able to recover after
+			 * link reset.
+			 */
+			amdgpu_reset_set_dpc_status(adev, true);
 
-		if (hive)
 			mutex_lock(&hive->hive_lock);
-		amdgpu_reset_set_dpc_status(adev, true);
+		}
 		memset(&reset_context, 0, sizeof(reset_context));
 		INIT_LIST_HEAD(&device_list);
 
@@ -7062,7 +7071,6 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 	amdgpu_device_sched_resume(&device_list, NULL, NULL);
 	amdgpu_device_gpu_resume(adev, &device_list, false);
 	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
-	amdgpu_reset_set_dpc_status(adev, false);
 
 	if (hive) {
 		mutex_unlock(&hive->hive_lock);
-- 
2.49.0

