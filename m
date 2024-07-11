Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448F7C3DA45
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jul 2024 23:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E54EE10E064;
	Thu, 11 Jul 2024 23:20:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b8h9D74G";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82A6210E064
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 23:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzdmhWOp4Rfuq4d+CZt2LIyqoR3Z+tJBwWs/WP09QbSj8KCt67bhdtdw2RKXnnq4Xb/mNxJsNX6WFHyMQOoNwUJlrCrOZi7BaDqQMH2cOhOJYPcv+nRLE/GEaQH2YNDF+OYjLUbDT1BuZeNNTN92hE6pYZLFwoszuPkiI/eNJqSVPxUgLC+mTxpyXjgzw4cAuiSxDz8MFYJvvpeFFKhV4ybeWWLzKGARqy/5Ngy1Vpmn+hY7LWFRJ2h5+zHTyImcSw+DM1HXeNWD6BMFy/8/P8QnY0eRulVX2vqX+ZPjV1PxHGVGDD9jqQW+UpUvzGzpcXrE1fSTd8i0M+C9lNtyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRnOW36EtFAICfkZsbSZOjhgIH69n3kKfM3bhQBYNEY=;
 b=iBvh7kddn0rFYdIhAaiXVkOqunCEIAYJQZQS5+96NMZCnkDMikEiXIUGFyoj7MkvttFU0ct0CH34UHiFhbCGSu+qrKNxrLiWdE1t4uqVSXGrNrmUtKOJXTOy9o9p03CkcGeFcUTMS8UXgcKubTnYyZwEAC3upLL35vDOKOQtbgL06ZoEZrDGABWLsDXskngN7MOcf5bq/kCJZXctPorbJv5XKcrhCFurU/TSTVs9plfMZjCFNrwLjiC7ko34gdpZkdGM51T4q08V4IUhbFKkDh5QTSmqoVqvx7GAwSGclk3WIRClvgz1X5VKZ93IWtA9B32vg+DNZqbJvaKzmWdk9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRnOW36EtFAICfkZsbSZOjhgIH69n3kKfM3bhQBYNEY=;
 b=b8h9D74G1rgwQGezmrjTM7SF0mbdQZ6bb741T8ewh88Eal18Q2kRwnx04dpJEeTmZdHL5ScGH3PzZbZB9mMuwWno1XuHqsGm0btAqvOaH5Hr01o6ou0fbqe+kkYWg05Y0Ov+trCRTdn8neMhbVkz1zLkZ6uWPmGaWs6aR65XDsQ=
Received: from BN7PR02CA0025.namprd02.prod.outlook.com (2603:10b6:408:20::38)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.39; Thu, 11 Jul
 2024 23:20:15 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:20:cafe::b9) by BN7PR02CA0025.outlook.office365.com
 (2603:10b6:408:20::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Thu, 11 Jul 2024 23:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 23:20:15 +0000
Received: from vengutta-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 18:20:14 -0500
From: Venkata Narendra Kumar Gutta <vengutta@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <mlimonci@amd.com>, <benjamin.chan@amd.com>, <king.li@amd.com>,
 <bin.du@amd.com>, <vengutta@amd.com>, <pratap.nirujogi@amd.com>
Subject: [PATCH v0 1/1] Add MFD support for ISP I2C bus
Date: Thu, 11 Jul 2024 16:19:59 -0700
Message-ID: <20240711231959.272993-2-vengutta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711231959.272993-1-vengutta@amd.com>
References: <20240711231959.272993-1-vengutta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e51c1a-b317-45a8-f483-08dca2000561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b3sq7tM56RGjPl4ugLcbL/WF5RGHoH6tP2Lb4aDyCfdFUum/va948NqXkNRL?=
 =?us-ascii?Q?gtGNgoN5T7Kg6UWHqxv97BKNt2aZn8NGEFNHtuhxbxLV8xQcF0JvbcxA0xyA?=
 =?us-ascii?Q?LCDRcRW2UzKxrmUd3Vm+E+J+2YesbHYCvcDO0yRVjYOQvnIhiurCE+HAfiq9?=
 =?us-ascii?Q?gPS4PhmmiK4Gq4oT4sLMEk4rQtAEZuFmBSq1ZHSSM+uygKdzs7HBgIm6xYmI?=
 =?us-ascii?Q?hA6XDMLlTaJFliLeABTFsJdNdiHT+IgT0FAP/Qesg1KD8DT8fmPPnGybOEvD?=
 =?us-ascii?Q?GUkDYkwlaID6ZuSiT3xU3pmbcNi31TtqKSr8Q3J+tY/+RGnL6OX4cwCxlYAs?=
 =?us-ascii?Q?2vmkbgd7lj3XQBagFmISXV7daCVIliyK1RtTZKCm1uaRfJ4XZstipKWVnTQ4?=
 =?us-ascii?Q?bAM/K5ohAYBGDGh+WPKfwVyBgR3iB+2oSNKGCWAM/iFHFGTyn4h5Mfxy8Cb9?=
 =?us-ascii?Q?1VjLZaJqTuBUhSWZBI43hPrfy9y73k2MOCWB+M3NJDr3kWBHN+A5ODinw43B?=
 =?us-ascii?Q?mnF23gs+hESGOWfeqwVNiBS4f7ixsMiyZJzwkWmN/JFoqMOJHljSqvPabdW8?=
 =?us-ascii?Q?aRR2INAGazhE1hk3TrNnCI3Ba+GbFflDh+IxZ00NM7qTbUPANdE70poKNwO5?=
 =?us-ascii?Q?0oIJZjDUmF/eDPkgVG86azac8AjPB6uQJDzqOkBrfimnln7T7vkpRT43B0M9?=
 =?us-ascii?Q?Ah0eg7B+ea1B5Uqqn1ub26U9mg+eDQoq66+49oSyJCW76IiC1c1oufZkT/gC?=
 =?us-ascii?Q?5zcxD0Qowqhbe/t7wo+GKlVQcy78HeiJLG3jiuIRf1+t5Ztq9opKwvgEcKt8?=
 =?us-ascii?Q?rhrUgF0I1VrHvhl2xYtTAa0n8A2hBS9cs/TGkA0iNhKAYJ6iYsOdsdNWpIV+?=
 =?us-ascii?Q?fRDRzXu2yA7YMOZYp0pMAFGEnfFolHfviXyGTxfXItaD7HyD/v/RCHcxjVN1?=
 =?us-ascii?Q?dt5ZnptsR/L+GyNwW61/3u+XAoldassNufxNFoXWWZCP+EONaC47VurCApL1?=
 =?us-ascii?Q?UKObrqAdPWoHwSb/a0l+ETuzaFcMhJ7LOOPLmPj59yEaBQUmncS0y9aAq/i2?=
 =?us-ascii?Q?YWSwL0XoDLT09Ih5cD8Ur3mmgiaUjkYW7Mb26joAujIT1AOlu8FmD5egZid2?=
 =?us-ascii?Q?kbyLbni3wsFIJtBkgAG0dvPDqAq4Srke02KbIKnKNUi24FJ5iJGiWZUR0NSa?=
 =?us-ascii?Q?RFMUZD1wl3G/Wsh+0QJRUPnvO2nbvKERqvzEKoL4TFIonw/+o00C+TBFT4mS?=
 =?us-ascii?Q?M377B2bJQ90jwXYe/1rtJKY+1j2/AXkx1iATl/HL8Dr5wfYFLK8JyVh5mc98?=
 =?us-ascii?Q?RrjA/sy6rjQZ2o+4TLSabmUOqeJJOZ8vy7MSDdxmxP9LUS6VrLiDGwD4K7vU?=
 =?us-ascii?Q?QQcKB04Y2z6QKrLDnVXdjWVpuI3WUAwAU5PxyREByAoIuoMZH3BVr6grPRt2?=
 =?us-ascii?Q?eIACdy0bPBoZOBx/ybpcU4/EDtzeiALY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 23:20:15.3148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e51c1a-b317-45a8-f483-08dca2000561
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243
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

ISP I2C bus device can't be enumerated via ACPI mechanism
since it shares the memory map with the AMDGPU.
So use the MFD mechanism for registering the ISP I2C device
and add the required resources.

Signed-off-by: Venkata Narendra Kumar Gutta <vengutta@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  1 +
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c | 57 +++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h | 12 ++++++
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 57 +++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h | 11 +++++
 5 files changed, 114 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
index 44e2ea8c9728..b03664c66dd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
@@ -49,6 +49,7 @@ struct amdgpu_isp {
 	const struct isp_funcs	*funcs;
 	struct mfd_cell *isp_cell;
 	struct resource *isp_res;
+	struct resource *isp_i2c_res;
 	struct isp_platform_data *isp_pdata;
 	unsigned int harvest_config;
 	const struct firmware	*fw;
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
index aac107898bae..964c29ef25dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
@@ -42,23 +42,23 @@ static const unsigned int isp_4_1_0_int_srcid[MAX_ISP410_INT_SRC] = {
 static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
 {
 	struct amdgpu_device *adev = isp->adev;
+	int idx, int_idx, num_res, r;
 	u64 isp_base;
-	int int_idx;
-	int r;
 
 	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
 		return -EINVAL;
 
 	isp_base = adev->rmmio_base;
 
-	isp->isp_cell = kcalloc(1, sizeof(struct mfd_cell), GFP_KERNEL);
+	isp->isp_cell = kcalloc(2, sizeof(struct mfd_cell), GFP_KERNEL);
 	if (!isp->isp_cell) {
 		r = -ENOMEM;
 		DRM_ERROR("%s: isp mfd cell alloc failed\n", __func__);
 		goto failure;
 	}
 
-	isp->isp_res = kcalloc(MAX_ISP410_INT_SRC + 1, sizeof(struct resource),
+	num_res = MAX_ISP410_MEM_RES + MAX_ISP410_SENSOR_RES + MAX_ISP410_INT_SRC;
+	isp->isp_res = kcalloc(num_res, sizeof(struct resource),
 			       GFP_KERNEL);
 	if (!isp->isp_res) {
 		r = -ENOMEM;
@@ -83,22 +83,53 @@ static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
 	isp->isp_res[0].start = isp_base;
 	isp->isp_res[0].end = isp_base + ISP_REGS_OFFSET_END;
 
-	for (int_idx = 0; int_idx < MAX_ISP410_INT_SRC; int_idx++) {
-		isp->isp_res[int_idx + 1].name = "isp_4_1_0_irq";
-		isp->isp_res[int_idx + 1].flags = IORESOURCE_IRQ;
-		isp->isp_res[int_idx + 1].start =
+	isp->isp_res[1].name = "isp_4_1_phy0_reg";
+	isp->isp_res[1].flags = IORESOURCE_MEM;
+	isp->isp_res[1].start = isp_base + ISP410_PHY0_OFFSET;
+	isp->isp_res[1].end = isp_base + ISP410_PHY0_OFFSET + ISP410_PHY0_SIZE;
+
+	isp->isp_res[2].name = "isp_gpio_sensor0_reg";
+	isp->isp_res[2].flags = IORESOURCE_MEM;
+	isp->isp_res[2].start = isp_base + ISP410_GPIO_SENSOR0_OFFSET;
+	isp->isp_res[2].end = isp_base + ISP410_GPIO_SENSOR0_OFFSET +
+			      ISP410_GPIO_SENSOR0_SIZE;
+
+	for (idx = MAX_ISP410_MEM_RES + MAX_ISP410_SENSOR_RES, int_idx = 0;
+	     idx < num_res; idx++, int_idx++) {
+		isp->isp_res[idx].name = "isp_4_1_0_irq";
+		isp->isp_res[idx].flags = IORESOURCE_IRQ;
+		isp->isp_res[idx].start =
 			amdgpu_irq_create_mapping(adev, isp_4_1_0_int_srcid[int_idx]);
-		isp->isp_res[int_idx + 1].end =
-			isp->isp_res[int_idx + 1].start;
+		isp->isp_res[idx].end =
+			isp->isp_res[idx].start;
 	}
 
 	isp->isp_cell[0].name = "amd_isp_capture";
-	isp->isp_cell[0].num_resources = MAX_ISP410_INT_SRC + 1;
+	isp->isp_cell[0].num_resources = num_res;
 	isp->isp_cell[0].resources = &isp->isp_res[0];
 	isp->isp_cell[0].platform_data = isp->isp_pdata;
 	isp->isp_cell[0].pdata_size = sizeof(struct isp_platform_data);
 
-	r = mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 1);
+	isp->isp_i2c_res = kcalloc(1, sizeof(struct resource),
+				   GFP_KERNEL);
+	if (!isp->isp_i2c_res) {
+		r = -ENOMEM;
+		DRM_ERROR("%s: isp mfd res alloc failed\n", __func__);
+		goto failure;
+	}
+
+	isp->isp_i2c_res[0].name = "isp_i2c0_reg";
+	isp->isp_i2c_res[0].flags = IORESOURCE_MEM;
+	isp->isp_i2c_res[0].start = isp_base + ISP410_I2C0_OFFSET;
+	isp->isp_i2c_res[0].end = isp_base + ISP410_I2C0_OFFSET + ISP410_I2C0_SIZE;
+
+	isp->isp_cell[1].name = "amd_isp_i2c_designware";
+	isp->isp_cell[1].num_resources = 1;
+	isp->isp_cell[1].resources = &isp->isp_i2c_res[0];
+	isp->isp_cell[1].platform_data = isp->isp_pdata;
+	isp->isp_cell[1].pdata_size = sizeof(struct isp_platform_data);
+
+	r = mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 2);
 	if (r) {
 		DRM_ERROR("%s: add mfd hotplug device failed\n", __func__);
 		goto failure;
@@ -111,6 +142,7 @@ static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
 	kfree(isp->isp_pdata);
 	kfree(isp->isp_res);
 	kfree(isp->isp_cell);
+	kfree(isp->isp_i2c_res);
 
 	return r;
 }
@@ -122,6 +154,7 @@ static int isp_v4_1_0_hw_fini(struct amdgpu_isp *isp)
 	kfree(isp->isp_res);
 	kfree(isp->isp_cell);
 	kfree(isp->isp_pdata);
+	kfree(isp->isp_i2c_res);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
index 315f2822410c..d6f7ffb0e2f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
@@ -32,8 +32,20 @@
 
 #include "ivsrcid/isp/irqsrcs_isp_4_1.h"
 
+#define MAX_ISP410_MEM_RES 2
+#define MAX_ISP410_SENSOR_RES 1
 #define MAX_ISP410_INT_SRC 8
 
+#define ISP410_PHY0_OFFSET 0x66700
+#define ISP410_PHY0_SIZE   0xD30
+
+#define ISP410_I2C0_OFFSET 0x66400
+#define ISP410_I2C0_SIZE 0x100
+
+#define ISP410_GPIO_SENSOR0_OFFSET 0x6613C
+#define ISP410_GPIO_SENSOR0_SIZE 0x4
+
+
 void isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index 4e17fa03f7b5..b56f27295468 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -42,23 +42,24 @@ static const unsigned int isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
 static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 {
 	struct amdgpu_device *adev = isp->adev;
+	int idx, int_idx, num_res, r;
 	u64 isp_base;
-	int int_idx;
-	int r;
 
 	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
 		return -EINVAL;
 
 	isp_base = adev->rmmio_base;
 
-	isp->isp_cell = kcalloc(1, sizeof(struct mfd_cell), GFP_KERNEL);
+	isp->isp_cell = kcalloc(2, sizeof(struct mfd_cell), GFP_KERNEL);
 	if (!isp->isp_cell) {
 		r = -ENOMEM;
 		DRM_ERROR("%s: isp mfd cell alloc failed\n", __func__);
 		goto failure;
 	}
 
-	isp->isp_res = kcalloc(MAX_ISP411_INT_SRC + 1, sizeof(struct resource),
+	num_res = MAX_ISP411_MEM_RES + MAX_ISP411_SENSOR_RES + MAX_ISP411_INT_SRC;
+
+	isp->isp_res = kcalloc(num_res, sizeof(struct resource),
 			       GFP_KERNEL);
 	if (!isp->isp_res) {
 		r = -ENOMEM;
@@ -83,22 +84,52 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 	isp->isp_res[0].start = isp_base;
 	isp->isp_res[0].end = isp_base + ISP_REGS_OFFSET_END;
 
-	for (int_idx = 0; int_idx < MAX_ISP411_INT_SRC; int_idx++) {
-		isp->isp_res[int_idx + 1].name = "isp_4_1_1_irq";
-		isp->isp_res[int_idx + 1].flags = IORESOURCE_IRQ;
-		isp->isp_res[int_idx + 1].start =
+	isp->isp_res[1].name = "isp_4_1_1_phy0_reg";
+	isp->isp_res[1].flags = IORESOURCE_MEM;
+	isp->isp_res[1].start = isp_base + ISP411_PHY0_OFFSET;
+	isp->isp_res[1].end = isp_base + ISP411_PHY0_OFFSET + ISP411_PHY0_SIZE;
+
+	isp->isp_res[2].name = "isp_4_1_1_sensor0_reg";
+	isp->isp_res[2].flags = IORESOURCE_MEM;
+	isp->isp_res[2].start = isp_base + ISP411_GPIO_SENSOR0_OFFSET;
+	isp->isp_res[2].end = isp_base + ISP411_GPIO_SENSOR0_OFFSET +
+			      ISP411_GPIO_SENSOR0_SIZE;
+
+	for (idx = MAX_ISP411_MEM_RES + MAX_ISP411_SENSOR_RES, int_idx = 0;
+	     idx < num_res; idx++, int_idx++) {
+		isp->isp_res[idx].name = "isp_4_1_1_irq";
+		isp->isp_res[idx].flags = IORESOURCE_IRQ;
+		isp->isp_res[idx].start =
 			amdgpu_irq_create_mapping(adev, isp_4_1_1_int_srcid[int_idx]);
-		isp->isp_res[int_idx + 1].end =
-			isp->isp_res[int_idx + 1].start;
+		isp->isp_res[idx].end =
+			isp->isp_res[idx].start;
 	}
 
 	isp->isp_cell[0].name = "amd_isp_capture";
-	isp->isp_cell[0].num_resources = MAX_ISP411_INT_SRC + 1;
+	isp->isp_cell[0].num_resources = num_res;
 	isp->isp_cell[0].resources = &isp->isp_res[0];
 	isp->isp_cell[0].platform_data = isp->isp_pdata;
 	isp->isp_cell[0].pdata_size = sizeof(struct isp_platform_data);
 
-	r = mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 1);
+	isp->isp_i2c_res = kcalloc(1, sizeof(struct resource), GFP_KERNEL);
+	if (!isp->isp_i2c_res) {
+		r = -ENOMEM;
+		DRM_ERROR("%s: isp mfd res alloc failed\n", __func__);
+		goto failure;
+	}
+
+	isp->isp_i2c_res[0].name = "isp_i2c0_reg";
+	isp->isp_i2c_res[0].flags = IORESOURCE_MEM;
+	isp->isp_i2c_res[0].start = isp_base + ISP411_I2C0_OFFSET;
+	isp->isp_i2c_res[0].end = isp_base + ISP411_I2C0_OFFSET + ISP411_I2C0_SIZE;
+
+	isp->isp_cell[1].name = "amd_isp_i2c_designware";
+	isp->isp_cell[1].num_resources = 1;
+	isp->isp_cell[1].resources = &isp->isp_i2c_res[0];
+	isp->isp_cell[1].platform_data = isp->isp_pdata;
+	isp->isp_cell[1].pdata_size = sizeof(struct isp_platform_data);
+
+	r = mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 2);
 	if (r) {
 		DRM_ERROR("%s: add mfd hotplug device failed\n", __func__);
 		goto failure;
@@ -111,6 +142,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 	kfree(isp->isp_pdata);
 	kfree(isp->isp_res);
 	kfree(isp->isp_cell);
+	kfree(isp->isp_i2c_res);
 
 	return r;
 }
@@ -122,6 +154,7 @@ static int isp_v4_1_1_hw_fini(struct amdgpu_isp *isp)
 	kfree(isp->isp_res);
 	kfree(isp->isp_cell);
 	kfree(isp->isp_pdata);
+	kfree(isp->isp_i2c_res);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
index dfb9522c9d6a..40887ddeb08c 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
@@ -32,8 +32,19 @@
 
 #include "ivsrcid/isp/irqsrcs_isp_4_1.h"
 
+#define MAX_ISP411_MEM_RES 2
+#define MAX_ISP411_SENSOR_RES 1
 #define MAX_ISP411_INT_SRC 8
 
+#define ISP411_PHY0_OFFSET 0x66700
+#define ISP411_PHY0_SIZE   0xD30
+
+#define ISP411_I2C0_OFFSET 0x66400
+#define ISP411_I2C0_SIZE 0x100
+
+#define ISP411_GPIO_SENSOR0_OFFSET 0x6613C
+#define ISP411_GPIO_SENSOR0_SIZE 0x4
+
 void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp);
 
 #endif
-- 
2.34.1

