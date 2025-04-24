Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7536FC369AB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 17:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1758210E025;
	Thu, 24 Apr 2025 17:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PVAE0avi";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 444BC10E025
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 17:58:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEoCKQvaqaZwi9tuXMTCofEqziccqSZb7dpJZFjDs7CxadQg3MHsLxT90jB7Fv9crAdfIBIqOK7yR5fMrTa+JN6sSC/iCbApSIfi9QOxA/9r+R0hGAUrA4/vikntopY+wIfFpy0F4f9Cvf0OWVan7G5tkkNmUdFsHavEMsayPNzuYtaNux1aXg365bi58xHIBvtjmta5OU+kS65N4qsKj+qiby1NB6TDtLYo60FSCy8rODzYiLYhK+S/nY+Y4m561Dv5KSDI8T3TBonsBWw6B/UA04487c9vl2WTb0zvcq3XtU7QezUIjfBLStG1FAETjisuVSS0+DHh7aAtQiO5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RWzdnL1ZeKHYjuudL1Dr1PvyswOAdBoXMmmMqfsiso=;
 b=RPYMbC4rbBpPZvR4xQaCDQiJdn0ls361zHzYApXmhZn2ZR44lkGkKFZvse1+aUNaurPF75B5bVPNktY1A/g6uE+x/u38qV0bZJg4JSs5xbauV84QvZaT9IGyd42WuiLB5fKfStFpKHy5kgJ1QBq+eYRjqm3UuljIzjgKL3tcn7Qg4iUaw3Fvl70fN0dCiIjLmvZL+puGBjQP7ex94nkeH4NZWX/ZqO5VDuiiXZnogLNSa7GsIYUwMT3CpW3woAcB2XsPMI2pKOIrYFdHWf5rwvg7DJbuJWO2oHjEUjc583ApT5Ez24RNLnr+2CUUlKKuuKtXfRtawQeZfq5W3TfNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RWzdnL1ZeKHYjuudL1Dr1PvyswOAdBoXMmmMqfsiso=;
 b=PVAE0aviujM9evdK0LPlFYFPzGPpLTd4oOgjqfdWkVOdN0zRsmU9pl5Bw+IW8+xhw+7tLjUAUz/Dt/cJDLnePN2Z2yOAMq1wSg/45Gy5QCgrWi42KgNVS6p8Qw616zHfJt61NAeKL583rAs7wMwxEPxiloXPefDojrXu+9WHpUg=
Received: from BY3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:254::8)
 by SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 17:58:37 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::1b) by BY3PR05CA0003.outlook.office365.com
 (2603:10b6:a03:254::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.11 via Frontend Transport; Thu,
 24 Apr 2025 17:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 17:58:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 12:58:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Alexey Klimov
 <alexey.klimov@linaro.org>
Subject: [PATCH] drm/amdgpu: only remap HDP registers on X86_64
Date: Thu, 24 Apr 2025 13:58:19 -0400
Message-ID: <20250424175819.3181101-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 2edc2bae-57d2-454d-b598-08dd8359a30b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dxUkoxZyan9UwS4aTWd7V9ll89sBueznWgLmgaLOW8uPL3+URwNifIJHMC+l?=
 =?us-ascii?Q?ALouA9uvzKevpTuXYFeszEkxZiRlo/ZJE8CxDijmhhWILhIcuMI4GBx6ceYK?=
 =?us-ascii?Q?DX/w9tmHzbssOXdhYCbrUZeuiQAr8GQbbtFn1w4mAT+2o3als4bNOeasZLdL?=
 =?us-ascii?Q?qRpY3qlP5x3GcgP/q9OyU9v8DqUl79Py1mbnVqZO2QUnV1cyEiMSR96ieapF?=
 =?us-ascii?Q?HilX18kY+/dd6OHyCeMz6sLCFdQG7Dd6KVjdU7fSPHKZ7ppX2ZVi/0hYXrlz?=
 =?us-ascii?Q?92jmVc2dMvefVApAMiVRnGoDmDcQnu1P3hgr5M7uBwBNWCYHWFkZNWyaONaq?=
 =?us-ascii?Q?IObyrOvyv00NlCx42ayeWawb8AJ9nZwmnJcq5GBuVakz2COS3HcTxus7pNAc?=
 =?us-ascii?Q?F+sFstG/JUMWfZQ1jpOnXkInbhTytACPM9AXf52fO8AMWciBIN9x8Yy1rtkC?=
 =?us-ascii?Q?47qm8KNynkuHisXxDgM0ZHpcvV+zcza0Bnr9+xPy5QiGNPtLzEqNsem21NKp?=
 =?us-ascii?Q?C8iP67Z9S7LiVtfTsS5ZbwGykhm8a730yuYTdM+GVn7A3x8nzqBm4tsrsm/W?=
 =?us-ascii?Q?GG1pQsmMq2FwyNdpfnmAXZfTiSf7tEzUq259UcCpesGx6ZRW7BmMPwe3p6yd?=
 =?us-ascii?Q?BkSsmcCbqsEisc7dR56RlUXMNEtQE3lSmuvyDY8gj+D5l1sWlmRZtQZOpr0Q?=
 =?us-ascii?Q?yNoPUboiHqyqYZQhRW412aDx7oS/xtiv+HWTfAHmY6lbnMouaLZzG0Pvi+Nm?=
 =?us-ascii?Q?tDTF1jcG3UZwvQFAU7NffsZ4KK8K9kAEIHOtfqwmtRAbgMlERc8pn7Mpq0Sf?=
 =?us-ascii?Q?QAXU2FL/VqrAscfmxaqftwoWteXeC5YVS8Me14Soo0PueOHFWQNyEDSTbFta?=
 =?us-ascii?Q?hFgua+Vl3zsYNJU+6KgsyDdeWBnu7FX+UPKQMNBd721Kbjoh1Zovyzl83awo?=
 =?us-ascii?Q?TAF3iI0+/0rbhbquPGQE8WTcYcYegG1s1TrFl1ZAhFK8j+UPdJZkUngEIW2b?=
 =?us-ascii?Q?cvmadBg8tYVkOxEacdbe1TXwfBj+7ZbvqQK+/FhJamCRukJ7SXxy/HMuxzVn?=
 =?us-ascii?Q?x2pQJ4RLvFP/20KTDf+9GhComVjjEsZd3JwbP96kOnflwLb6o/5Za5WMVz4w?=
 =?us-ascii?Q?LgO6TC77Ec3G1XWQnEVLfVyxceJ0sv4WTSwprBievR3xIyNHbL60r2NQ6dqy?=
 =?us-ascii?Q?ZWyIRtWYFN0Z/5dbJxc7UfADJJ30aK5SdN9mvqdtSc1/qR/o5POSePI+XCVs?=
 =?us-ascii?Q?mRpToYmdMWzx4LSUvn8xsx52XN16EcYpJIclCh4VyR4EtWgRwx1LqivTZpwk?=
 =?us-ascii?Q?n/7v2Z1DimIDlnxtqGR2WlWevgTKGh9E0jE9ibH1s3FcgMBIzrwgAkxkoiuL?=
 =?us-ascii?Q?rFYfJBh9rsTGDgfmxfaBv1cN4ApitcUgvbyE/Urt5ybjRXRQ4KAdSjf3j69l?=
 =?us-ascii?Q?SWxxkSoKyXOZZxU7BJnWhsj7Z7Khgq6kO1zs7BmG5qYtYSb1PKAYNw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 17:58:36.5697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edc2bae-57d2-454d-b598-08dd8359a30b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599
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

We remap the HDP registers to an open part of the MMIO
aperture.  This doesn't seem to work properly on non-X86 systems,
so only remap on X86_64.

Fixes: c9b8dcabb52a ("drm/amdgpu/hdp4.0: do a posting read when flushing HDP")
Fixes: cf424020e040 ("drm/amdgpu/hdp5.0: do a posting read when flushing HDP")
Fixes: f756dbac1ce1 ("drm/amdgpu/hdp5.2: do a posting read when flushing HDP")
Fixes: abe1cbaec6cf ("drm/amdgpu/hdp6.0: do a posting read when flushing HDP")
Fixes: 689275140cb8 ("drm/amdgpu/hdp7.0: do a posting read when flushing HDP")
Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
Link: https://lists.freedesktop.org/archives/amd-gfx/2025-April/123150.html
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4119
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 17 +++++++++++++----
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c   | 17 +++++++++++++----
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c   | 17 +++++++++++++----
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c   | 17 +++++++++++++----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c   | 16 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c  | 16 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c   | 17 +++++++++++++----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   | 17 +++++++++++++----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c   | 17 +++++++++++++----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c   | 17 +++++++++++++----
 10 files changed, 128 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index 9b4025c39e440..829904b9ea537 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -32,10 +32,12 @@
 
 static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	if (adev->rmmio_remap.bus_addr) {
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	}
 }
 
 static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_device *adev)
@@ -437,6 +439,7 @@ static void nbif_v6_3_1_program_aspm(struct amdgpu_device *adev)
 
 static void nbif_v6_3_1_set_reg_remap(struct amdgpu_device *adev)
 {
+#ifdef CONFIG_X86_64
 	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
 		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
 		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
@@ -445,6 +448,12 @@ static void nbif_v6_3_1_set_reg_remap(struct amdgpu_device *adev)
 			regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 		adev->rmmio_remap.bus_addr = 0;
 	}
+#else
+	adev->rmmio_remap.reg_offset =
+		SOC15_REG_OFFSET(NBIO, 0,
+				 regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+	adev->rmmio_remap.bus_addr = 0;
+#endif
 }
 
 const struct amdgpu_nbio_funcs nbif_v6_3_1_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 04041b398781b..c19cde544f147 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -65,10 +65,12 @@
 
 static void nbio_v2_3_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	if (adev->rmmio_remap.bus_addr) {
+		WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	}
 }
 
 static u32 nbio_v2_3_get_rev_id(struct amdgpu_device *adev)
@@ -552,6 +554,7 @@ static void nbio_v2_3_clear_doorbell_interrupt(struct amdgpu_device *adev)
 
 static void nbio_v2_3_set_reg_remap(struct amdgpu_device *adev)
 {
+#ifdef CONFIG_X86_64
 	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
 		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
 		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
@@ -560,6 +563,12 @@ static void nbio_v2_3_set_reg_remap(struct amdgpu_device *adev)
 			mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 		adev->rmmio_remap.bus_addr = 0;
 	}
+#else
+	adev->rmmio_remap.reg_offset =
+		SOC15_REG_OFFSET(NBIO, 0,
+				 mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+	adev->rmmio_remap.bus_addr = 0;
+#endif
 }
 
 const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index f89e5f40e1a54..0922cc99977e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -30,10 +30,12 @@
 
 static void nbio_v4_3_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	if (adev->rmmio_remap.bus_addr) {
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	}
 }
 
 static u32 nbio_v4_3_get_rev_id(struct amdgpu_device *adev)
@@ -475,6 +477,7 @@ static void nbio_v4_3_program_aspm(struct amdgpu_device *adev)
 
 static void nbio_v4_3_set_reg_remap(struct amdgpu_device *adev)
 {
+#ifdef CONFIG_X86_64
 	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
 		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
 		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
@@ -483,6 +486,12 @@ static void nbio_v4_3_set_reg_remap(struct amdgpu_device *adev)
 			regBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 		adev->rmmio_remap.bus_addr = 0;
 	}
+#else
+	adev->rmmio_remap.reg_offset =
+		SOC15_REG_OFFSET(NBIO, 0,
+				 regBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+	adev->rmmio_remap.bus_addr = 0;
+#endif
 }
 
 const struct amdgpu_nbio_funcs nbio_v4_3_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
index e911368c1aeb5..37f99cecff260 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
@@ -54,10 +54,12 @@
 
 static void nbio_v6_1_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	if (adev->rmmio_remap.bus_addr) {
+		WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	}
 }
 
 static u32 nbio_v6_1_get_rev_id(struct amdgpu_device *adev)
@@ -393,6 +395,7 @@ static void nbio_v6_1_program_aspm(struct amdgpu_device *adev)
 
 static void nbio_v6_1_set_reg_remap(struct amdgpu_device *adev)
 {
+#ifdef CONFIG_X86_64
 	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
 		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
 		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
@@ -402,6 +405,12 @@ static void nbio_v6_1_set_reg_remap(struct amdgpu_device *adev)
 					 mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 		adev->rmmio_remap.bus_addr = 0;
 	}
+#else
+	adev->rmmio_remap.reg_offset =
+		SOC15_REG_OFFSET(NBIO, 0,
+				 mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+	adev->rmmio_remap.bus_addr = 0;
+#endif
 }
 
 const struct amdgpu_nbio_funcs nbio_v6_1_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
index 1569a1e934ec4..9e69ae0d9dee2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
@@ -34,10 +34,12 @@
 
 static void nbio_v7_0_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	if (adev->rmmio_remap.bus_addr) {
+		WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	}
 }
 
 static u32 nbio_v7_0_get_rev_id(struct amdgpu_device *adev)
@@ -289,6 +291,7 @@ static void nbio_v7_0_init_registers(struct amdgpu_device *adev)
 
 static void nbio_v7_0_set_reg_remap(struct amdgpu_device *adev)
 {
+#ifdef CONFIG_X86_64
 	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
 		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
 		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
@@ -297,6 +300,11 @@ static void nbio_v7_0_set_reg_remap(struct amdgpu_device *adev)
 			SOC15_REG_OFFSET(NBIO, 0, mmHDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 		adev->rmmio_remap.bus_addr = 0;
 	}
+#else
+	adev->rmmio_remap.reg_offset =
+		SOC15_REG_OFFSET(NBIO, 0, mmHDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+	adev->rmmio_remap.bus_addr = 0;
+#endif
 }
 
 const struct amdgpu_nbio_funcs nbio_v7_0_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
index bed5ef4d87889..bbfe17f2d4e32 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -29,10 +29,12 @@
 
 static void nbio_v7_11_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
-		     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
-		     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	if (adev->rmmio_remap.bus_addr) {
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	}
 }
 
 static u32 nbio_v7_11_get_rev_id(struct amdgpu_device *adev)
@@ -364,6 +366,7 @@ static void nbio_v7_11_get_clockgating_state(struct amdgpu_device *adev,
 
 static void nbio_v7_11_set_reg_remap(struct amdgpu_device *adev)
 {
+#ifdef CONFIG_X86_64
 	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
 		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
 		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
@@ -372,6 +375,11 @@ static void nbio_v7_11_set_reg_remap(struct amdgpu_device *adev)
 			SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 		adev->rmmio_remap.bus_addr = 0;
 	}
+#else
+	adev->rmmio_remap.reg_offset =
+		SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+	adev->rmmio_remap.bus_addr = 0;
+#endif
 }
 
 const struct amdgpu_nbio_funcs nbio_v7_11_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
index acc5f363684ad..a27b3341f3982 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -48,10 +48,12 @@
 
 static void nbio_v7_2_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	if (adev->rmmio_remap.bus_addr) {
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	}
 }
 
 static u32 nbio_v7_2_get_rev_id(struct amdgpu_device *adev)
@@ -407,6 +409,7 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
 
 static void nbio_v7_2_set_reg_remap(struct amdgpu_device *adev)
 {
+#ifdef CONFIG_X86_64
 	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
 		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
 		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
@@ -416,6 +419,12 @@ static void nbio_v7_2_set_reg_remap(struct amdgpu_device *adev)
 					 regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 		adev->rmmio_remap.bus_addr = 0;
 	}
+#else
+	adev->rmmio_remap.reg_offset =
+		SOC15_REG_OFFSET(NBIO, 0,
+				 regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+	adev->rmmio_remap.bus_addr = 0;
+#endif
 }
 
 const struct amdgpu_nbio_funcs nbio_v7_2_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index d5002ff931d84..2c451953e9792 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -100,10 +100,12 @@ static void nbio_v7_4_query_ras_error_count(struct amdgpu_device *adev,
 
 static void nbio_v7_4_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	if (adev->rmmio_remap.bus_addr) {
+		WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	}
 }
 
 static u32 nbio_v7_4_get_rev_id(struct amdgpu_device *adev)
@@ -791,6 +793,7 @@ static void nbio_v7_4_program_aspm(struct amdgpu_device *adev)
 
 static void nbio_v7_4_set_reg_remap(struct amdgpu_device *adev)
 {
+#ifdef CONFIG_X86_64
 	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
 		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
 		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
@@ -800,6 +803,12 @@ static void nbio_v7_4_set_reg_remap(struct amdgpu_device *adev)
 					 mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 		adev->rmmio_remap.bus_addr = 0;
 	}
+#else
+	adev->rmmio_remap.reg_offset =
+		SOC15_REG_OFFSET(NBIO, 0,
+				 mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+	adev->rmmio_remap.bus_addr = 0;
+#endif
 }
 
 const struct amdgpu_nbio_funcs nbio_v7_4_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
index 2ee60b8746a61..4f9be8a61b657 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -29,10 +29,12 @@
 
 static void nbio_v7_7_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
-		     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
-		     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	if (adev->rmmio_remap.bus_addr) {
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	}
 }
 
 static u32 nbio_v7_7_get_rev_id(struct amdgpu_device *adev)
@@ -333,6 +335,7 @@ static void nbio_v7_7_get_clockgating_state(struct amdgpu_device *adev,
 
 static void nbio_v7_7_set_reg_remap(struct amdgpu_device *adev)
 {
+#ifdef CONFIG_X86_64
 	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
 		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
 		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
@@ -342,6 +345,12 @@ static void nbio_v7_7_set_reg_remap(struct amdgpu_device *adev)
 					 regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 		adev->rmmio_remap.bus_addr = 0;
 	}
+#else
+	adev->rmmio_remap.reg_offset =
+		SOC15_REG_OFFSET(NBIO, 0,
+				 regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+	adev->rmmio_remap.bus_addr = 0;
+#endif
 }
 
 const struct amdgpu_nbio_funcs nbio_v7_7_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index a376f072700dc..456a7b3c66c8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -36,10 +36,12 @@
 
 static void nbio_v7_9_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	if (adev->rmmio_remap.bus_addr) {
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	}
 }
 
 static u32 nbio_v7_9_get_rev_id(struct amdgpu_device *adev)
@@ -487,6 +489,7 @@ static u64 nbio_v7_9_get_pcie_replay_count(struct amdgpu_device *adev)
 
 static void nbio_v7_9_set_reg_remap(struct amdgpu_device *adev)
 {
+#ifdef CONFIG_X86_64
 	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
 		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
 		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
@@ -498,6 +501,12 @@ static void nbio_v7_9_set_reg_remap(struct amdgpu_device *adev)
 			<< 2;
 		adev->rmmio_remap.bus_addr = 0;
 	}
+#else
+	adev->rmmio_remap.reg_offset =
+		SOC15_REG_OFFSET(NBIO, 0,
+				 regBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+	adev->rmmio_remap.bus_addr = 0;
+#endif
 }
 
 const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
-- 
2.49.0

