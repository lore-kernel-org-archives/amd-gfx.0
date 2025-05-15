Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC83C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 16:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C5CB10E912;
	Thu, 15 May 2025 16:41:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZWiCJIZe";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D2710E90B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 16:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DE1qZJ6r+PLwJ8fqIla2TUkLvG3w5cvQf7/poPH1MEGocOaEPQFtq2XS85BqNcI+0O1mJ0CvANscykUCmnNYe4eSOldkNhUOEqdsjNeHW2mIcv4z77TiBCEuFbxssM36onGQ9Adb141AwQGuuUyOYWLgMnavvvdjVcW8G1sZrrpxEd9E7NRz5QxzriR5/5rIFVXyxtYZ2Qc8VbcApl6QWBYWBV1Rn8nAEmz4KsmXdx3gIxJK6pvdEmJeShKYxcrL32b+/M0y6Lwji5AjdtD2Jq1ySTWYE2O4E5irRSE5xpIbImoQ8w5suu6lPr8I3dT/AWil6FAVVRg15EDTxGzbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4VTJxEXLbPtbWLOsmdaegLSKU4xQxEJw37JkhqjDXs=;
 b=IaOtCQf3J7Vt2Gk4peOvwkO2TwXXLGHQ0YHoiFYknWITNatb+rac4cRUzzT/5ogu+7aCpEVRzWkaPLCZHF5PKom3LjxKijgRxqH+xSsAHbNs9MrOHXWqqdMnG2zky5YxAZT2znm6hkkJXOqUd7eKS3Se3mF2PUg866lFMSRCpaHgAJE7M4klidSYCcc9TN69GuCcX4StezWid0R1AnXJlxOjfLaHkobarZeULJdWjX8pcotSNGYAFVWUA2OzZMzuKxn8jaAZRmXloj67xMzwH/QwLQTPhF7l5bSt9aKmNm76HT7U6rmsrfs8uDWl6zRfj+FApI1quIJ/KbQxL++Dgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4VTJxEXLbPtbWLOsmdaegLSKU4xQxEJw37JkhqjDXs=;
 b=ZWiCJIZemAcUiMge0D+S+6CKDPVgHJ814NOOf6J7C2NUWTY57WpCTkW03HMfP3CC17CacMKpM3bFA1Gj9wswvDKPeZRiA1jC/tfHCEC1WmLup6jAPnAMn0+4wjN4Jw4bjop8pDl46l+bEuN/1xEikXgiQNRJzA0U4q0VxrDPNJs=
Received: from MN2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:208:1a0::13)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 16:41:19 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::44) by MN2PR07CA0003.outlook.office365.com
 (2603:10b6:208:1a0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Thu,
 15 May 2025 16:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 16:41:18 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 May 2025 11:41:17 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v2 4/9] drm/amdgpu: read back register after written
Date: Thu, 15 May 2025 12:40:57 -0400
Message-ID: <20250515164102.808954-4-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515164102.808954-1-David.Wu3@amd.com>
References: <20250515164102.808954-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 351a2b51-8e2f-4656-a2d1-08dd93cf514b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DE47db13WhgIEhKuIkG5ARz07ZM3p7O6wNRZ+wPJgAGMFsw4wjgZuH/TZGCt?=
 =?us-ascii?Q?ecR5Z5AhrLo8EIs4GiVrA71w4CWL26SKV/o3tyd81QBrpY0mbcNKatLRoY1x?=
 =?us-ascii?Q?ZG/rrY8k5/YY5ra9S0irw+qW390xVUl2fLGWeIUASznqPqcUmZC3sy7j3jqj?=
 =?us-ascii?Q?Uj7+bWilcRsB+lUKWa5nNzPsjnlHPu5yyr6oxHrDgCbgdH+92vqL1p5n54PS?=
 =?us-ascii?Q?2E9wPvTDWQKOoIeYz9UFdOh5bITyRESwGZzv3HthIqBXNGXnoOZn7kiORs0Y?=
 =?us-ascii?Q?06v7GWB5otufzaB9wOyQ719S2nsAdip6t51f1ETcwZ7DCNKXyO8yiUQfWu94?=
 =?us-ascii?Q?3ZIvqXLNfexko7GVCiImKHMsQ29nCcW37skw70vBCigjFJe/r1Azy7hkLbW7?=
 =?us-ascii?Q?VWhE8dXCENhtYpuJbus3Ze41AKh9l5JdClxFYL+Xkun7qzJ7UZTXFXXzrlBj?=
 =?us-ascii?Q?ITy5S/Y66m1H24dgvHXe8lb6URgz3i5/R1YjyakKGSfsEELfZ32Is6QTIib1?=
 =?us-ascii?Q?69nI4ygnIghWjbHdB3W60B2S0NI9KmNY8ToAKhmDBfs/n1HZmPOEmA+oKo0X?=
 =?us-ascii?Q?VzFUUYDPKx6svB5ERfVMByHLCTc3SoLj/8TcBp6Qux0ol1mDfJ5qShdLjN+o?=
 =?us-ascii?Q?EhnddNLik1zOQLEYkI1dGpcnN+RVFcNcVvqw1DRxt9wH/i9/c354gKHoNKwF?=
 =?us-ascii?Q?3c1DyhJY8N9KLSkIN2WFRKHcK88YTY8vcUdv/zltApd+MofaNR/CniG3vPrr?=
 =?us-ascii?Q?MEEkeMhpY9VtWUXyFuggIb2xSsoFeP9B8TAt7JldE9guE21PqMi3s3UyscnN?=
 =?us-ascii?Q?DmZPa4jkj7EnqNhu0uYk/Ln0jfDV2HKCUw4udPLG/m+xlvlgIJxCS9YKLtaC?=
 =?us-ascii?Q?b9Xrbum7hWjeupNtFQoxFwya4YV9gE2f2tGkkEEoDHdq+OC+iIBLgZcNlrHz?=
 =?us-ascii?Q?XYaxM4F6GSL6Bvp188+XgKW1KbtkHs7rODifyN6g/ZcUBMkX2pmLv7xUJUkE?=
 =?us-ascii?Q?jwbqC/Sczi1ZZ4Bxhchr2G4QHCUwRufJ45OHDoMI8ftM8FtX45jZ7pQqHJi0?=
 =?us-ascii?Q?kc+4WqXTUvSojhhH3IenCAtvujO8sZbNgKVtpoAUG24uK9FZC/8u893VpC7H?=
 =?us-ascii?Q?PtIb71pO7qDg+IXyAfIxwkupBWK72WWhzUjOO5cGYZFdK2HDreLFMlUPZvRd?=
 =?us-ascii?Q?nFwSd3Hz3GCavFcByhBMyeRn0TYQsvDJpOMKEZHglHsO3IYgSaZJ0/NuinRz?=
 =?us-ascii?Q?iQwUMSDbMBxo7oQb7ns/aKYJA6nk91/GULSVwUYMysX8vVQd1ubqiqQJWg60?=
 =?us-ascii?Q?encSmEGI9ejrsHXzZuhlwpGNhSdMAmhg4KAWbPxiiLAsTKChUqjm8S60Sm/t?=
 =?us-ascii?Q?xZhIIVgzvJLfeCWrhmI7+fnZ7yTzwnTJwaHOe33M5MmAGZhuKS6T2H+udxCP?=
 =?us-ascii?Q?PMrqLDV4Da/WF19ggo5yRWUw5ldwoXYt1Jecgho6uteaK5lNsoBVWp9nCBxS?=
 =?us-ascii?Q?DsQKmP8G+HzHUGZg8cfQpT6t4ySy/i112BDD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 16:41:18.7474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 351a2b51-8e2f-4656-a2d1-08dd93cf514b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
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

The addition of register read-back in VCN v3.0 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 0b19f0ab4480..9fb0d5380589 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1173,6 +1173,11 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1360,6 +1365,11 @@ static int vcn_v3_0_start(struct amdgpu_vcn_inst *vinst)
 		fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
 	}
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1602,6 +1612,11 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS), 0,
 		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1674,6 +1689,11 @@ static int vcn_v3_0_stop(struct amdgpu_vcn_inst *vinst)
 	/* enable VCN power gating */
 	vcn_v3_0_enable_static_power_gating(vinst);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, mmUVD_STATUS);
+
 done:
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
-- 
2.49.0

