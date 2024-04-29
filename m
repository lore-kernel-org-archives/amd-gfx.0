Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4D7C19F53
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16274112CAC;
	Mon, 29 Apr 2024 14:34:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TyFoJugJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DC42112C9E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=St6rETCV/oIDD52/tpiKKZr6XBPBZzcUvWhCtB/FGcMqBUTh7Dg5rNLKBHghorQYauoLYFDv6CZwTkVthMm+n84o8/HckTWW9+92WBZ78tMUs6VgWb8hhibUU/giW3ktjybBCybIs4cgQvdB+FTCHu2aMX1BM9UU53DfknfmCk7NTijMkv6Zg1ddbcyswjC/Wx4YmKsLrE73h7wcqSzwgWJiKK+hx2p59BC9P1vWra9W83Xr4BfE62XY/A95ZBoGq275fudKzHvmAUHADSJnC4kHBEunTJuaiWIz0RUDkXxWaCbNr97MruS8qhrbt3f2YA5xQpFn0S8x/yacLmB2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7LOdPVhTDB4/E1vkwOAU/cIos/zgtedOqXVeMdywoY=;
 b=bgmkAg8TCO7KkhqDJQzySWPyWtImSvSPV7nF2gZUmdlT54CYIVhZeA5kkmmtu4DbpbbazQoXsDYz0H3KuIPgSWsy4Wqw/teMOS5XRfbc/Q10naS5xlA+9+SpyJQ3E3fon3k4XCNCeVLdaBuGtJympI1q9/gpNhy96Sx0Ls/Z2EMelPgiMIgCl5OyynVJsrh8AtjtHO+0khnlJ29BKVgbmPPilhIEZuG3Y58VahTFr8tqcnpYFeWtnjnQ0YgXPLand1cvyfCgZ+OMX6YBS4/q9cARsQIvChjNG5ZMfoezTEU5Xemvyj3XYYha+cPPv10zj9mZlJonwdM/oiOG5TRBVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7LOdPVhTDB4/E1vkwOAU/cIos/zgtedOqXVeMdywoY=;
 b=TyFoJugJ9Ng5pv3v5Y7paL+xZH7an6/ZilH4AA7Q8U9a0JKmYwLtBIlx5T4PJktL/Ro6hUy7DkDBHi3Rw43zd8DuRgQCDHElbrgy4WahEs6ZMrcFXwRYEugjob0trT80gAWNllnlT9KaseZlOQ3EBwQ31rohgTq9iWnoRY4fQMI=
Received: from BYAPR06CA0033.namprd06.prod.outlook.com (2603:10b6:a03:d4::46)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:34:24 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::f8) by BYAPR06CA0033.outlook.office365.com
 (2603:10b6:a03:d4::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 25/31] drm/amdgpu: use new method to program rlc ram
Date: Mon, 29 Apr 2024 10:33:33 -0400
Message-ID: <20240429143339.3450256-25-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c96f77-177d-4db6-812e-08dc68597715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oUtN9mD7pQSMt+8a19Wb/U+F8aGvfyMpk8mnLRTvAqnJ2mR1zSKvqridpbrt?=
 =?us-ascii?Q?6yarIZo+8DhvDMYDCwPOhgFY1PZhuNfJpqaXvS1O4ygUt9yhje/32NGRx7jq?=
 =?us-ascii?Q?WQJLONVgU9FTLVs0vIMLEHDtjI9++cI5TA+RgbIWIhUWCZRfhd8lRe05y09N?=
 =?us-ascii?Q?hmpD5rcHJLHZF5LrlxmdeqSXfVw/k/BmJ4u0+fVj6coRm5QplLyC15IlV6Np?=
 =?us-ascii?Q?3+Jw8In50WaZwVX+6b/hNJnjGv1VTeuLgtsaZWGZmDNnLfH6gTh7PISbfEKI?=
 =?us-ascii?Q?kbJJ0X0pYnpBkunNDyYcfr70P8VOcCGVgT6Y+lT7Fk04MV+Shy/nrds5YWzr?=
 =?us-ascii?Q?CfbdZ3CKd0Qtwqa0LrWdvhfAhtHhT4mpFslpi2Ro1Kxx4/qSrHeYfy/v280E?=
 =?us-ascii?Q?5k6pAemq4+q3x8Z16HCRghlvRPmRvEgiNC+9gSkhr7RL15DiEGwjJQ2e9uNK?=
 =?us-ascii?Q?KxOZB2+HlnJ7srpLkWQsZ81DLwv3IrhTwo+4sx1Wo3EFG99kCpYmRRaidB7D?=
 =?us-ascii?Q?jz2OYP2Fjow39ErifRXPteKJXY3JuEpGBG4iQjKYcbWHJajL2qMq640hrjgl?=
 =?us-ascii?Q?OYU/5h6ucQ0f0Ul49oOYxly3EfOxsJnRSex1A5fOevmphmzkAQtiPDBMeTZF?=
 =?us-ascii?Q?+uMEfYM5NAlwfEB2l5tmKUk6bqeg0b0yBCuOh5thDZ0Nfp1zwrmuZY7PkfGs?=
 =?us-ascii?Q?ZRU0WhCnovJtNm7k8xbL7RYV2pVslnTgZ+rUwGsU9B3dq3f6gBIIBr1HHLuK?=
 =?us-ascii?Q?qoXvcemlGY8LVtPlGKQ9cso5XmGjBwrxyq1bQAKD2c73s9uZJwrE+FM7bQPs?=
 =?us-ascii?Q?hjTmC5UAjWA+cU37xDae7eG1OsDQbfbbwLbKFO9vwshxI4PgZGVIK6Kw2r/u?=
 =?us-ascii?Q?YaftpC/22NhVABtW5pcyXE3sbd+c/Y8CxYQWTy7zibpfDxQ15Wfd6inISGj6?=
 =?us-ascii?Q?fvAqItZiMMfxChvU6Dv7+GNp8pI6C8307uS+vn43mNRsHS3h5IUCAeAZHquJ?=
 =?us-ascii?Q?0Tr1h/z6/4671F4+tDY5BCe18bLBv2xWVKlq1ScmOWXCkOCKtuZaiL28JkvH?=
 =?us-ascii?Q?OjmxzCUMc18IHxGLbXJRqlClzZz6u4/uECMpDXeOZQazwbrGJtYMKWLZD+F6?=
 =?us-ascii?Q?cmwCeJJ9xlEbu63b80GLP18PXTGqbpO+k60RdKQ2E8L/ZdgYy7da+zq7wYnD?=
 =?us-ascii?Q?PWT/yfwpTqknIJ8UlWtvZl4bcaf4BkEefy5hYmZkFzvSm/HVmUL/T7P7G6gK?=
 =?us-ascii?Q?d9av0K6OfqD0iemOEM1JG/RV6xnXthRf5AhK3w+iqxxMHTKeSnooKe2gzeTD?=
 =?us-ascii?Q?ns0ctIbZtjsAkxm3Rs4V4AXECl+7Ejq3mu97JZJwrA3GW3YoOcKLgcijxQ+r?=
 =?us-ascii?Q?jihNHZnVFdiLJ1D0EOpcgtDA+/oV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:23.7793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c96f77-177d-4db6-812e-08dc68597715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937
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

Program rlc ram with golden setting data instead.
The old method (program_imu_rlc_ram_old) should be
retired in the future.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c | 70 ++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
index 7112e4b2d6489..5baef51660637 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
@@ -33,6 +33,8 @@
 
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_imu.bin");
 
+#define TRANSFER_RAM_MASK	0x001c0000
+
 static int imu_v12_0_init_microcode(struct amdgpu_device *adev)
 {
 	char fw_name[40];
@@ -245,9 +247,9 @@ static const struct imu_rlc_ram_golden imu_rlc_ram_golden_12_0_1[] = {
 	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB, 0, 0x1c0000)
 };
 
-static void program_imu_rlc_ram(struct amdgpu_device *adev,
-				const struct imu_rlc_ram_golden *regs,
-				const u32 array_size)
+static void program_imu_rlc_ram_old(struct amdgpu_device *adev,
+				    const struct imu_rlc_ram_golden *regs,
+				    const u32 array_size)
 {
 	const struct imu_rlc_ram_golden *entry;
 	u32 reg, data;
@@ -271,21 +273,66 @@ static void program_imu_rlc_ram(struct amdgpu_device *adev,
 		WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_LOW, reg);
 		WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_DATA, data);
 	}
-	//Indicate the latest entry
-	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_HIGH, 0);
-	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_LOW, 0);
-	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_DATA, 0);
+}
+
+static u32 imu_v12_0_grbm_gfx_index_remap(struct amdgpu_device *adev,
+					  u32 data, bool high)
+{
+	u32 val, inst_index;
+
+	inst_index = REG_GET_FIELD(data, GRBM_GFX_INDEX, INSTANCE_INDEX);
+
+	if (high)
+		val = inst_index >> 5;
+	else
+		val = REG_GET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES) << 18 |
+		      REG_GET_FIELD(data, GRBM_GFX_INDEX, SA_BROADCAST_WRITES) << 19 |
+		      REG_GET_FIELD(data, GRBM_GFX_INDEX, INSTANCE_BROADCAST_WRITES) << 20 |
+		      REG_GET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX) << 21 |
+		      REG_GET_FIELD(data, GRBM_GFX_INDEX, SA_INDEX) << 25 |
+		      (inst_index & 0x1f);
+
+	return val;
+}
+
+static void program_imu_rlc_ram(struct amdgpu_device *adev,
+				const u32 *regs,
+				const u32 array_size)
+{
+	u32 reg, data, val_h = 0, val_l = TRANSFER_RAM_MASK;
+	int i;
+
+	if (array_size % 3)
+		return;
+
+	for (i = 0; i < array_size; i += 3) {
+		reg = regs[i + 0];
+		data = regs[i + 2];
+		if (reg == SOC15_REG_OFFSET(GC, 0, regGRBM_GFX_INDEX)) {
+			val_l = imu_v12_0_grbm_gfx_index_remap(adev, data, false);
+			val_h = imu_v12_0_grbm_gfx_index_remap(adev, data, true);
+		} else {
+			WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_HIGH, val_h);
+			WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_LOW, reg | val_l);
+			WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_DATA, data);
+		}
+	}
 }
 
 static void imu_v12_0_program_rlc_ram(struct amdgpu_device *adev)
 {
-	u32 reg_data;
+	u32 reg_data, size;
+	const u32 *data;
+	int r = -EINVAL;
 
 	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, 0x2);
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 0, 1):
-		program_imu_rlc_ram(adev, imu_rlc_ram_golden_12_0_1,
+		if (!r)
+			program_imu_rlc_ram(adev, data, (const u32)size);
+		else
+			program_imu_rlc_ram_old(adev, imu_rlc_ram_golden_12_0_1,
 				(const u32)ARRAY_SIZE(imu_rlc_ram_golden_12_0_1));
 		break;
 	default:
@@ -293,6 +340,11 @@ static void imu_v12_0_program_rlc_ram(struct amdgpu_device *adev)
 		break;
 	}
 
+	//Indicate the latest entry
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_HIGH, 0);
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_LOW, 0);
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_DATA, 0);
+
 	reg_data = RREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX);
 	reg_data |= GFX_IMU_RLC_RAM_INDEX__RAM_VALID_MASK;
 	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, reg_data);
-- 
2.44.0

