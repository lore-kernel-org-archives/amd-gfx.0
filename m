Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A06C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46EE2112CB5;
	Mon, 29 Apr 2024 14:34:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2l7Y95gP";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7346112CA6
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNojMCsZBWjlD1Dn/KuX1Im4hErV1EIWAqoBc6CQQlEBsZriNiWMDT+AfxaWAejIzjwM5QkylCxcgsfEIJwo4hZYdM0E7aoj+7kZETjm7ygcAVC7XA/9Y9ogbsP2fExRZ40f4Yuen2TapsqlGfcUoaF/R2bLhw0oJ/lv74vIC3TvfPPoVuplO9ornYyKYRvexvTe0fgScpSuMUxgqSmqYAqLwDKAeFfCZ0pnEzLhS66sXmsgxnj+BO6rQbG5h6iLDmLrZYJ5SO+OcHuT6LozRASZJuRHr6glQdk14sYrDGJaHPEHJliQHyj86r7f/gQZsljfOypoiT9Lvs31j7dNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vfGq8IdgP/nBPzQqo2DdcyoxOPCzU80eILvuhw83lQ=;
 b=d9dHAfPILGFFWwXOpPeWxpl/GDaB8zWvkRNJMOUv3e5kVx6x86N8nOPPhQmORb4ipn89lp6oe197OvzjBscryyn1aa6qBZ/4i1RIsxQkdnTYlA9NSAkSVoHSMRpJbmInM64+RYmLpB9iUT3eeBQunwPjOxgHHQBo1F92bS341gjOGuEkk7nCKQgEKO+MLV85Bu0Mn9ci+6F5nCNEw/Er4aOPtWH2NAwW/863dXpn1RqkZ+oW5QPz8aqY571ldzZ/DHV+OMH1v/KKkN6pm227eBJrd4UDlaajLht3faMABk8ZPGueg4xELnv4zO5/PPX6RaI2twDN/m2ftboPUWjc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vfGq8IdgP/nBPzQqo2DdcyoxOPCzU80eILvuhw83lQ=;
 b=2l7Y95gPOk+jKVMJcHiHDRExmrg80Tu158AGmGjy3qgP6j+Z9weSxgjbRgDUCEPBJcxcyvtGP+lILxK3aUuQI4vdu69HafASx8Kpx7mAh5y3veI9N1MsugmdQp6mmlrrTvdKjjGgEU6MbF9s1PkNljpBDxxKnzxWGGE2VXlO3mk=
Received: from BY5PR20CA0020.namprd20.prod.outlook.com (2603:10b6:a03:1f4::33)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:34:25 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::ea) by BY5PR20CA0020.outlook.office365.com
 (2603:10b6:a03:1f4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 28/31] drm/amdgpu: init gfxhub setting to align with mmhub
Date: Mon, 29 Apr 2024 10:33:36 -0400
Message-ID: <20240429143339.3450256-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e839998-bf70-4bd0-7859-08dc685977c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gw5bszw3iwfnTwqbxIl0tlYFe8NG5aKaAcAhrwWb/8mrFMj17CIC8oJxlW5l?=
 =?us-ascii?Q?MdyvtdXOBnBkeBUB6dG6Dz/t7k6tf/SS6hLu7hBpWRRY5VMfvHFdPQplC/NY?=
 =?us-ascii?Q?OnJBmpZfZseoR1iqtIlfraRTmwZD4rKZzuS+RN0T4Q+wtbhwKO5iUArZIktA?=
 =?us-ascii?Q?duqLZ6tglZ6GrUHSed87VGc5tZwpKKYn5s5DnvBH+h/k90m1VEYt+/50TiLd?=
 =?us-ascii?Q?6G4Y1pj9unV23S31T/y9VP4xa3WXYog+IKVnQ7z4WwpD15GdM/9AxdQvc/wY?=
 =?us-ascii?Q?3zLrIUco2r407TStKQLKk494udFeKANK7VXLReXPOwZanZncwNyMeXYEyZaS?=
 =?us-ascii?Q?OtUZDcVfWXpDTp87h+DaDc3kYYOWuu1TW1MqxtcMYWR+cyJkyPYE8pOVrSAr?=
 =?us-ascii?Q?2nW0DvDEpJ4p36F4qVhS6ZNYg07WQ+dqMZ41r6GR9aEHTvHSb0OiVi1Cy8qo?=
 =?us-ascii?Q?a3Z8Dw0MXw+X1WWoHDCnREi4RINABR69Ci/8RbwDWicLskJeFaDXa0MlJMFg?=
 =?us-ascii?Q?O8TuiejumyU/IprzbxnoS7Xdt9BR4vOx+PRV4QfgI7g6/CgU5CfMz50ayv+u?=
 =?us-ascii?Q?WgxyNhQ9maqYfQKCI+qIuuWT8hsc1fwFqaqar1gjLU8wDL3qakDOMoAJ4uFy?=
 =?us-ascii?Q?h7lHHPROqGkEAD13aebb1UdozOs5/ciAn5yfR7VWlN1bOjcsG0lt2CEsGBp2?=
 =?us-ascii?Q?XcGyF29MX0P+WcdruMa0HCq/fo0YKcBOoSPEMJDahxHIRfczyLqBA1HQwt0C?=
 =?us-ascii?Q?j4XbGD/U5LDflRQ9wGSJ8T+tQa6Oe2VwMw309fXHCodea8uYwN45hizcW+UR?=
 =?us-ascii?Q?EDSNFo21c/7NC3uCQwDyZWTchglKJZhpWoXMc8vdoJ/X61OpodtO5hhNAXPc?=
 =?us-ascii?Q?qM+DN5qSxk8wlVtFjAWk6UJdOlwypBEwJbIOIBOUDgtt/OHQMbJ4ZPLGvjaZ?=
 =?us-ascii?Q?PEgMYSVrrPu9G0m1L3gXNOccHtQ+b8JF0Aod4hP5FShmK9lq5InZ9+50rjb5?=
 =?us-ascii?Q?9Iq6ynRe2eUZMQBFEH3p3jjVRXQSQZB5YGx+raihqjck2TmpsHtSR9EqlNRs?=
 =?us-ascii?Q?Huvnr1/mtIpKBq2hZUxFZ+MH5mATwUxbUZwHHHFU7XMLysP5zfSfjf61kGah?=
 =?us-ascii?Q?jbZtR+HDiyEOU+au2xjo/310e+oar5dhe0KzHZngWagslyGfQj5Z2bkew4T/?=
 =?us-ascii?Q?K2s5R3x7j2JJxUtTwkROJIpjmd7mK/9+USsGsfJ5/qEEtMreEb1SFKuv2QX6?=
 =?us-ascii?Q?D7pZ7661JvD//s6fTCgXWzX2g8T1zXkPPCvG6WLTbOkEGQNrf9F8w0jh5T6j?=
 =?us-ascii?Q?WkfKgAVZkStoIigmkmR/3H2PTpbt/VIoK9WVhtQsbIIVqc3OQ8jVrvmk/N9n?=
 =?us-ascii?Q?aenCTnTQYMxP3E6Y1fkae/2mNn6b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:24.9275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e839998-bf70-4bd0-7859-08dc685977c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
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

From: Likun Gao <Likun.Gao@amd.com>

Align gfxhub settings with mmhub when program rlc ram.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
index 5baef51660637..d67807d5c14c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
@@ -30,6 +30,7 @@
 
 #include "gc/gc_12_0_0_offset.h"
 #include "gc/gc_12_0_0_sh_mask.h"
+#include "mmhub/mmhub_4_1_0_offset.h"
 
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_imu.bin");
 
@@ -295,6 +296,43 @@ static u32 imu_v12_0_grbm_gfx_index_remap(struct amdgpu_device *adev,
 	return val;
 }
 
+static u32 imu_v12_init_gfxhub_settings(struct amdgpu_device *adev,
+					u32 reg, u32 data)
+{
+	if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_FB_LOCATION_BASE))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_FB_LOCATION_BASE);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_FB_LOCATION_TOP))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_FB_LOCATION_TOP);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_FB_OFFSET))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_FB_OFFSET);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_AGP_BASE))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_AGP_BOT))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_AGP_TOP))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_MX_L1_TLB_CNTL))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_MX_L1_TLB_CNTL);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_LOCAL_FB_ADDRESS_START))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_LOCAL_FB_ADDRESS_START);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_LOCAL_FB_ADDRESS_END))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_LOCAL_FB_ADDRESS_END);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_LOCAL_SYSMEM_ADDRESS_START))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_LOCAL_SYSMEM_ADDRESS_START);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_LOCAL_SYSMEM_ADDRESS_END))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_LOCAL_SYSMEM_ADDRESS_END);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB);
+	else
+		return data;
+}
+
 static void program_imu_rlc_ram(struct amdgpu_device *adev,
 				const u32 *regs,
 				const u32 array_size)
@@ -308,6 +346,7 @@ static void program_imu_rlc_ram(struct amdgpu_device *adev,
 	for (i = 0; i < array_size; i += 3) {
 		reg = regs[i + 0];
 		data = regs[i + 2];
+		data = imu_v12_init_gfxhub_settings(adev, reg, data);
 		if (reg == SOC15_REG_OFFSET(GC, 0, regGRBM_GFX_INDEX)) {
 			val_l = imu_v12_0_grbm_gfx_index_remap(adev, data, false);
 			val_h = imu_v12_0_grbm_gfx_index_remap(adev, data, true);
-- 
2.44.0

