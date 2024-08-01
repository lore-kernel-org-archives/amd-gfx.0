Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B114C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 07:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBCA610E8A0;
	Thu,  1 Aug 2024 07:04:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uVVCz262";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F0D10E89F
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 07:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfT22agGZXwjqn0Uf4MsgwsHki66u0e7pWq/mKnbyNMoLXtvlS7yU8GByZwbOJaGoZ3QWXxL0t/LpzUBEhTWxVUMBKgFhwh8Cq+1x5+dam7eo9jOfep7p6D5aBZFY6nG6uYRMB643twXOLsoICbffJwQC7wPYk0B5UzELPvomCBcpbEcylZQ6cmfYh9jrs24Zkt8N1PDrb0GHd7LOaLTIIf9IrALw+S3wcLT6AnqqTzfamtEtJx7uG/1Weq3XlBUHCJTm0zzC1Zi0o2voTOQq7EFM08KjWNT1NEPzw/VZ+BSbWnXYW3r/sp1l6nHrRE9VtPMwdEwnPRszf6kDBwTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8kK4l49KdhoJv+3myurXMN+HETzpXdbARZK2mqcESU=;
 b=CgZUnHvyUkfLhyt7TASCRfH6Fe9y1AF1ZpCxMIYHS34OGi/rrEoyUvL8OUMZVbiu+5J0gWxkMDFxIDWXu6B4jQ6xkif2lr7ywEDH/jBWIRFdhsyeEFK1CAPNyazoWYEVdKikmZ/QV+JCrZykkBtiE5yGXUtoSua28DZ4ZZc6gJokMAtGIpq0lI/xrYUenY0DxARRaVvCCo0hwKhvqMk0g/sIzjymY4slCJCbR5fKLNyml9j2l2kERxYrLF4UoJwHmVDNGqLYKwrDGPk9LTEamRmwV0epr636u8eRYMFWU6d+W8vWMNLxIayZoimnW7NyYc7ubz7cVxE8oi+KIsveLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8kK4l49KdhoJv+3myurXMN+HETzpXdbARZK2mqcESU=;
 b=uVVCz2624WOFDk8Ar2KFmqa+NG3a73gLVrVvKMkpSk1f9WtBfvvdjG8oo1PYzLcXG7X67tSpo6WqzOgjWH+DXpv2nTG0ebwxx/SS/tgD28vLJRwNWJtta+lZtHywwfDpF1eCjw4+pM9LyDgZ9NLzVIxMXare8heARD6O6RRpYw8=
Received: from SJ0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:a03:33e::28)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 07:04:54 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::1f) by SJ0PR03CA0053.outlook.office365.com
 (2603:10b6:a03:33e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 07:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 07:04:53 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 02:04:49 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <jesse.zhang@amd.com>, <bob.zhou@amd.com>, Tim Huang <tim.huang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: check return for setting engine dram timings
Date: Thu, 1 Aug 2024 15:03:33 +0800
Message-ID: <20240801070333.423881-4-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801070333.423881-1-tim.huang@amd.com>
References: <20240801070333.423881-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: b24a4d78-02d9-4aa9-fce5-08dcb1f83e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Sif2tRnF/SO7/xszNEFApqvCPBpI9fLJcClDXJ037CfgvjWkjmixiYuJ6uh?=
 =?us-ascii?Q?MKfZzm4gkJse6UbvRWoU9CbN7LHuAhAO6cd16jqlBMIS1w4MplB6gwGMTNR2?=
 =?us-ascii?Q?hRZUrz6T43XIUItvp91T23w6QmUBYfIn/n0xGtIVu8weAmHyjDjhdFICLJUj?=
 =?us-ascii?Q?osHgEvX9jUb1ozgogCMGAkKcHpOLIF2DdJxC4WFoAtJ8zN2EC/rmGMyEppk0?=
 =?us-ascii?Q?PsqED+VGGhGd8BJRhFGwbby4+30ls9DuNT/ejxIfXzsChysYejmoCFGqXmdX?=
 =?us-ascii?Q?4V4mG43HJWpCrqEdqbs/TLECtVdh6lavO8ZQhcHb1yhH2cvLeVYe2Pjo3TTB?=
 =?us-ascii?Q?Btv2VUbaMA4jkspckHYSnoYclcFz5GOsYTAxL9w64vnIpqvrsZCo/SoelsDJ?=
 =?us-ascii?Q?oXzwkp33fNWF10oUaIe/w21yldjQMB+R3RcJ05HBQ4mmmrTyhmRbo5xOEzWe?=
 =?us-ascii?Q?mWAMlWlcrsZA9IgiNtkQhb3FjGLYFBlvaV/tIS27IswlMdaNu3+deTLdVEJp?=
 =?us-ascii?Q?fMfx4GVqfkDHGsAjdvM/dcWljYm0yWl/utzArniSgeL5nbmgMbGE9iY0JB1r?=
 =?us-ascii?Q?8j0A/HUyaNXiTFghsfk01m/7+oTLVoEFUI/L+zWckIcbQu23+OL39tLMzEHd?=
 =?us-ascii?Q?97+vCMyeAuXF7HVvYy6mrOEnb206Ubk4fT0jAUF1VTckhJOMR8rflHWnshKy?=
 =?us-ascii?Q?iO5q3NQ6L2OD3iiSRsbWn7FyeIvbASc/w60FdCVmweYjxAt74o/Y14/7l4il?=
 =?us-ascii?Q?QdnaRgyowJocMmFsyF/xvZLV1nDUrzTMVKDLdkKLCCVs1hZvgU96k9QoJKFh?=
 =?us-ascii?Q?lc3M2WlRvwi+kvZXFXv/3wCrBVAc0rAbZsuamF/neZARvnIA+07O14c5MGOu?=
 =?us-ascii?Q?tCKad94VUNns34wPW3BiLhIVbVBHBwzQz2coogHaHyK5SmiCfuXhWltv0DDx?=
 =?us-ascii?Q?rROB8A+7ged1i6xYuxexu8IvCx1pOvRw/3fVQhoQd2IVtCMgXcDkc6Mj1Z4K?=
 =?us-ascii?Q?aPbyFvyV/ie8k5vefv9ChouZIHgak2BALEAZaki/k+j7H8XN+FGLCE/ST2De?=
 =?us-ascii?Q?aPWt2GDcI7gCo87+u2qoFPoHk2hdSMVHPETsNJtdTS713bI2VOR/HmyIqaJW?=
 =?us-ascii?Q?DgQ39xrPkbS1SRqvGodc8VaytJDnCiRxJT3aAACz0qNVGmuD1NaxN3KbZ8on?=
 =?us-ascii?Q?ntcrr6lWIo2DA113+b7zMaZlfhYfD0T3YjP9NjgEYVoJFhGrc/LiZoD++PTs?=
 =?us-ascii?Q?xLrbUv9k9DoQjSUM3nA5GMEVGunxUknQ8xQ2gnicIJZiH7tanj/+UTMbIQG7?=
 =?us-ascii?Q?3BX2y7Qrl6O/cFskkuXahZ+zuwuehCxj5BYFnWsKunPV2l9GTQ4t1plaklI/?=
 =?us-ascii?Q?iNZoQGxG9qLBs9QqZYKYPKnBP/M0bFwWyT2JHa5/BMfqIVW7Z9Q3EMsvzg7k?=
 =?us-ascii?Q?VmrhN2BKjWOFZlwVi91VYULxu27EvfGP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 07:04:53.8449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b24a4d78-02d9-4aa9-fce5-08dcb1f83e96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961
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

This resolves the unchecded return value warning reported by Coverity.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h | 4 ++--
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c   | 8 +++++---
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 0c8975ac5af9..093141ad6ed0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1145,8 +1145,8 @@ int amdgpu_atombios_get_memory_pll_dividers(struct amdgpu_device *adev,
 	return 0;
 }
 
-void amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *adev,
-					     u32 eng_clock, u32 mem_clock)
+int amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *adev,
+					    u32 eng_clock, u32 mem_clock)
 {
 	SET_ENGINE_CLOCK_PS_ALLOCATION args;
 	int index = GetIndexIntoMasterTable(COMMAND, DynamicMemorySettings);
@@ -1161,8 +1161,8 @@ void amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *adev,
 	if (mem_clock)
 		args.sReserved.ulClock = cpu_to_le32(mem_clock & SET_CLOCK_FREQ_MASK);
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-		sizeof(args));
+	return amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
+					 (uint32_t *)&args, sizeof(args));
 }
 
 void amdgpu_atombios_get_default_voltages(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
index 0811474e8fd3..0e16432d9a72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
@@ -163,8 +163,8 @@ int amdgpu_atombios_get_memory_pll_dividers(struct amdgpu_device *adev,
 					    bool strobe_mode,
 					    struct atom_mpll_param *mpll_param);
 
-void amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *adev,
-					     u32 eng_clock, u32 mem_clock);
+int amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *adev,
+					    u32 eng_clock, u32 mem_clock);
 
 bool
 amdgpu_atombios_is_voltage_gpio(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index a1baa13ab2c2..43028e776c93 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -4755,13 +4755,15 @@ static int si_populate_memory_timing_parameters(struct amdgpu_device *adev,
 	u32 dram_timing;
 	u32 dram_timing2;
 	u32 burst_time;
+	int ret;
 
 	arb_regs->mc_arb_rfsh_rate =
 		(u8)si_calculate_memory_refresh_rate(adev, pl->sclk);
 
-	amdgpu_atombios_set_engine_dram_timings(adev,
-					    pl->sclk,
-		                            pl->mclk);
+	ret = amdgpu_atombios_set_engine_dram_timings(adev, pl->sclk,
+						      pl->mclk);
+	if (ret)
+		return ret;
 
 	dram_timing  = RREG32(MC_ARB_DRAM_TIMING);
 	dram_timing2 = RREG32(MC_ARB_DRAM_TIMING2);
-- 
2.43.0

