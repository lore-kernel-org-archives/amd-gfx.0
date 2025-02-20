Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026F9C021B3
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 18:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9825610E9C7;
	Thu, 20 Feb 2025 18:33:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AdhW18pe";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC1B10E9C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 18:33:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyaHnqpkZztHrtL5JWKaoWGetTneXBY4k8O5HABVnOM9xsgINILhrmx8g3JDATqpn44rtWJkH0ny/BxYQCp/M8IbmjsCVHBw4/dxBqKTrTO9qFFWxOMmjHXha2eBzJMkJnHtrLPcs8/Xuxr+xz+NtqKZuQ/ubkd4H36Hz2UL6O6thzHdsRIjUDO5gxPmouxB4SvT4DEw279Bz+XA4Vp7EnWjIDVwmOCq+m3f4Eeghopfx4pdA/YJzM4XWFF9xBMAdBPFCV/QC6+qrBMV9pibzx0gVo1Y+IqGHpww0rYQOdvfF0ZfiCISOVc/2gnoeYRusU6TnNqw5GFoXFzO2m4nBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USb69dqzrekmi3+iFZcdhbKbqA7RPN2j2qt8cdGR0QY=;
 b=aeW1k8HwF+xxqjuDWoTzKxZF+QaOzHaAtbavOMfFi+chHnIbBrIpc35QNG6fDO+tGE/5gFDEz85pU7/MrLd7Cv1MN8YVXrO/p6wIcgYu7ncbrM6SWBt7OQR1B7KeDfUtlKHFXfvxGH+9wRaSNBM2grq+/Q1GOMFivcDeJXWAZ8UNM/VZqP/XaI28WkxwVvt2UoZk9/qOFSmpwpjK7AzKXx8/PugjUJuwGoirlvBu4cHutHAGmu9gtesImidsNlydslMK/D31NDUnG3cna3zVdfTeojiYdu1fR1e+9I92Z0cja1+7IOGLBzZpXNn4YRxQuRch0mM0NoOHI7Z0CzjI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USb69dqzrekmi3+iFZcdhbKbqA7RPN2j2qt8cdGR0QY=;
 b=AdhW18pePWpESSx8yZ/OczK68k1sMmdJmGpVpLuBpvCxCGleykhMRsq5Imx7XH7hABeleuFNrd/9r5Hv0Ia69r1xaOoQmnGnNQwWKVVdbpFRWZIeZO8PtHAtqiVJ0O2ncWRsSbwa2PUV557vPkQ+IqCuIdvEXxoW/H/uvfT882M=
Received: from BL1PR13CA0016.namprd13.prod.outlook.com (2603:10b6:208:256::21)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Thu, 20 Feb
 2025 18:33:44 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:256:cafe::85) by BL1PR13CA0016.outlook.office365.com
 (2603:10b6:208:256::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 18:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 18:33:44 +0000
Received: from maple-stxh-09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 12:33:43 -0600
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <mlimonci@amd.com>, <benjamin.chan@amd.com>, <king.li@amd.com>,
 <bin.du@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add amdisp pinctrl MFD resource
Date: Thu, 20 Feb 2025 13:31:11 -0500
Message-ID: <20250220183326.2957649-3-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220183326.2957649-1-pratap.nirujogi@amd.com>
References: <20250220183326.2957649-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|CH2PR12MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0f4e3f-13c8-4fd5-ffdd-08dd51dd1b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J7mJZP7+kYCXAnfrZol+LStRzquMI8qK6FTsBjVwFi66jPDSkYnQxnWfsY0N?=
 =?us-ascii?Q?A2y8o32WEEOlGCNL8haGOV370fe0dwX2wg7lBgThcRTkBn3r5vCfHchnMJd9?=
 =?us-ascii?Q?uTJcMrHxzWwDs5vPgjmkimPAT6FjN0rV4yW/t9lCFXOxUzSHQJgX1RfFj/AK?=
 =?us-ascii?Q?+8oHNlS7qXtdyJ+Yoy/M8w8rvBLEj4Rkptqx6wV5dNNhMNaJ71KJKpBR8pbt?=
 =?us-ascii?Q?dbaz2krpL1KR+nS9hjcuEtobE6iFF+ZeLIItkRQ9UXs/Kg7kOy+YGP5DqSBn?=
 =?us-ascii?Q?CTS7CK/bGcBB71xnbWE9J55WKcvv63Axzobdl+r5UX/GWKmBj1pLTSDrXWMk?=
 =?us-ascii?Q?PXlOEnL5s+he733gkNTHZeyNKPI16blEJS6B1QGrhB2G+NkndmBafIZq0iS/?=
 =?us-ascii?Q?jADmHBj2qIpPJg8YJ16beZwBbyaASs6qWA2BSR/+7U/DGqFQHzDjePNNCIaQ?=
 =?us-ascii?Q?SSyX6PWcl1srSQ/4IUoL3ynQ5fDTNaT9vnqqiTvAtVGkmYbsdezgBwLOjMD9?=
 =?us-ascii?Q?9IzgUhfaeYrVo6hQt+8OQCdzRC+/OvKLdu6wnCCmZZlQjlHOCl4uT63/0Ms3?=
 =?us-ascii?Q?K6yiALnOIfJPEFB5xFtE+NWuamzvh95NAzx15zZ7tQLUfAPjLzRY8al5OuWr?=
 =?us-ascii?Q?S1/CK52S+TVonwVFX2PPSRZwe8wLXp837qEktbzpHHnQ1BDDw7cAlQ1mdC6J?=
 =?us-ascii?Q?E4ZP9YGx6jVq/WiIu+DV8BQo28KqzC2Un7V8ORFRFImfjeYKRJdbXcV0KgTk?=
 =?us-ascii?Q?6Eu7pqoG8ZMmK0tzxlGsHduNqHiEco/6mYvug3xDbrnv1vFlxXWMTnlxTXCG?=
 =?us-ascii?Q?nZmSYaJcST1tk7Ve7eqxBWhk5fgOOSa27lOeOILc9DF/N3oHqHBFYaerIUTn?=
 =?us-ascii?Q?74tEkasDggCesMbyJ+CmBecCFQYYh3TnPgoB44KL+ycMI5eERTYD60Orx3A8?=
 =?us-ascii?Q?AZWATE2VQOEJ1YDG41jevC/VzQJarhprnAmt5WuACLS/KbnGCQZ/b3agqT3Y?=
 =?us-ascii?Q?4hd8GlE0G53hnGWAQMDzP9DywBbLE+EmSmrGhP44nouVRv27rzyE+Y2ozU2h?=
 =?us-ascii?Q?GS4Mt5uUN82CxWcfah33LKkW75bErELRh4uQnwUkQd/AW6dlMf+8BxpzPuf1?=
 =?us-ascii?Q?Tw4jsOcj5++ULdoh4nx/Q7QX5z2EBfb1N4CLGWzVqYTr010ISewDLhB08qCQ?=
 =?us-ascii?Q?zK3IkAWIiLlcaV5kMLURUYPiYswYDmcx5NTkhBb8ByI3cT3NnxxHNjf5773j?=
 =?us-ascii?Q?KTNkUyuNDFl3A3tSbR0X+MXvBPJuZ3t0lusYoFwxWuCqMsoiDOp4M3wZ6aRz?=
 =?us-ascii?Q?NzoQRfmzLriz9zZMOvO7w4J9FYtdAZaY3QgMXPrOvhqGA69Oi/X9y804RrG/?=
 =?us-ascii?Q?EY4LnbpEwYktGKg6kCG43hCNZThLtRREKLkDzQXr1dORuKLMT2Y0c+0aGRs+?=
 =?us-ascii?Q?MLT8STaJzWy7jySM4O/4WVMNDwBp6XMXEk3YlHGAPgH6iSlG9On5HjbFppkT?=
 =?us-ascii?Q?VYvQyi4EEkbeEkQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:33:44.2483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0f4e3f-13c8-4fd5-ffdd-08dd51dd1b3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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

From: Benjamin Chan <benjamin.chan@amd.com>

AMDISP GPIO control uses a dedicated pinctrl driver,
and requires MFD hotadd GPIO resources.

Co-developed-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
Signed-off-by: Benjamin Chan <benjamin.chan@amd.com>
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  1 +
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c | 42 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h |  4 +--
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 39 ++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h |  5 ++-
 5 files changed, 62 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
index b03664c66dd6..4f3b7b5d9c1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
@@ -50,6 +50,7 @@ struct amdgpu_isp {
 	struct mfd_cell *isp_cell;
 	struct resource *isp_res;
 	struct resource *isp_i2c_res;
+	struct resource *isp_gpio_res;
 	struct isp_platform_data *isp_pdata;
 	unsigned int harvest_config;
 	const struct firmware	*fw;
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
index 2475564b2c08..0027a639c7e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
@@ -50,7 +50,7 @@ static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
 
 	isp_base = adev->rmmio_base;
 
-	isp->isp_cell = kcalloc(2, sizeof(struct mfd_cell), GFP_KERNEL);
+	isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);
 	if (!isp->isp_cell) {
 		r = -ENOMEM;
 		drm_err(&adev->ddev,
@@ -58,7 +58,7 @@ static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
 		goto failure;
 	}
 
-	num_res = MAX_ISP410_MEM_RES + MAX_ISP410_SENSOR_RES + MAX_ISP410_INT_SRC;
+	num_res = MAX_ISP410_MEM_RES + MAX_ISP410_INT_SRC;
 	isp->isp_res = kcalloc(num_res, sizeof(struct resource),
 			       GFP_KERNEL);
 	if (!isp->isp_res) {
@@ -91,14 +91,7 @@ static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
 	isp->isp_res[1].start = isp_base + ISP410_PHY0_OFFSET;
 	isp->isp_res[1].end = isp_base + ISP410_PHY0_OFFSET + ISP410_PHY0_SIZE;
 
-	isp->isp_res[2].name = "isp_gpio_sensor0_reg";
-	isp->isp_res[2].flags = IORESOURCE_MEM;
-	isp->isp_res[2].start = isp_base + ISP410_GPIO_SENSOR0_OFFSET;
-	isp->isp_res[2].end = isp_base + ISP410_GPIO_SENSOR0_OFFSET +
-			      ISP410_GPIO_SENSOR0_SIZE;
-
-	for (idx = MAX_ISP410_MEM_RES + MAX_ISP410_SENSOR_RES, int_idx = 0;
-	     idx < num_res; idx++, int_idx++) {
+	for (idx = MAX_ISP410_MEM_RES, int_idx = 0; idx < num_res; idx++, int_idx++) {
 		isp->isp_res[idx].name = "isp_4_1_0_irq";
 		isp->isp_res[idx].flags = IORESOURCE_IRQ;
 		isp->isp_res[idx].start =
@@ -113,8 +106,8 @@ static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
 	isp->isp_cell[0].platform_data = isp->isp_pdata;
 	isp->isp_cell[0].pdata_size = sizeof(struct isp_platform_data);
 
-	isp->isp_i2c_res = kcalloc(1, sizeof(struct resource),
-				   GFP_KERNEL);
+	/* initialize isp i2c platform data */
+	isp->isp_i2c_res = kcalloc(1, sizeof(struct resource), GFP_KERNEL);
 	if (!isp->isp_i2c_res) {
 		r = -ENOMEM;
 		drm_err(&adev->ddev,
@@ -133,7 +126,28 @@ static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
 	isp->isp_cell[1].platform_data = isp->isp_pdata;
 	isp->isp_cell[1].pdata_size = sizeof(struct isp_platform_data);
 
-	r = mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 2);
+	/* initialize isp gpiochip platform data */
+	isp->isp_gpio_res = kcalloc(1, sizeof(struct resource), GFP_KERNEL);
+	if (!isp->isp_gpio_res) {
+		r = -ENOMEM;
+		drm_err(&adev->ddev,
+			"%s: isp gpio res alloc failed\n", __func__);
+		goto failure;
+	}
+
+	isp->isp_gpio_res[0].name = "isp_gpio_reg";
+	isp->isp_gpio_res[0].flags = IORESOURCE_MEM;
+	isp->isp_gpio_res[0].start = isp_base + ISP410_GPIO_SENSOR_OFFSET;
+	isp->isp_gpio_res[0].end = isp_base + ISP410_GPIO_SENSOR_OFFSET +
+				   ISP410_GPIO_SENSOR_SIZE;
+
+	isp->isp_cell[2].name = "amdisp-pinctrl";
+	isp->isp_cell[2].num_resources = 1;
+	isp->isp_cell[2].resources = &isp->isp_gpio_res[0];
+	isp->isp_cell[2].platform_data = isp->isp_pdata;
+	isp->isp_cell[2].pdata_size = sizeof(struct isp_platform_data);
+
+	r = mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 3);
 	if (r) {
 		drm_err(&adev->ddev,
 			"%s: add mfd hotplug device failed\n", __func__);
@@ -148,6 +162,7 @@ static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
 	kfree(isp->isp_res);
 	kfree(isp->isp_cell);
 	kfree(isp->isp_i2c_res);
+	kfree(isp->isp_gpio_res);
 
 	return r;
 }
@@ -160,6 +175,7 @@ static int isp_v4_1_0_hw_fini(struct amdgpu_isp *isp)
 	kfree(isp->isp_cell);
 	kfree(isp->isp_pdata);
 	kfree(isp->isp_i2c_res);
+	kfree(isp->isp_gpio_res);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
index 7db24c0f1080..4d239198edd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
@@ -42,8 +42,8 @@
 #define ISP410_I2C0_OFFSET 0x66400
 #define ISP410_I2C0_SIZE 0x100
 
-#define ISP410_GPIO_SENSOR0_OFFSET 0x6613C
-#define ISP410_GPIO_SENSOR0_SIZE 0x4
+#define ISP410_GPIO_SENSOR_OFFSET 0x6613C
+#define ISP410_GPIO_SENSOR_SIZE 0x54
 
 void isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index 3ee5942bc24d..69dd92f6e86d 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -50,7 +50,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 
 	isp_base = adev->rmmio_base;
 
-	isp->isp_cell = kcalloc(2, sizeof(struct mfd_cell), GFP_KERNEL);
+	isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);
 	if (!isp->isp_cell) {
 		r = -ENOMEM;
 		drm_err(&adev->ddev,
@@ -58,7 +58,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 		goto failure;
 	}
 
-	num_res = MAX_ISP411_MEM_RES + MAX_ISP411_SENSOR_RES + MAX_ISP411_INT_SRC;
+	num_res = MAX_ISP411_MEM_RES + MAX_ISP411_INT_SRC;
 
 	isp->isp_res = kcalloc(num_res, sizeof(struct resource),
 			       GFP_KERNEL);
@@ -92,14 +92,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 	isp->isp_res[1].start = isp_base + ISP411_PHY0_OFFSET;
 	isp->isp_res[1].end = isp_base + ISP411_PHY0_OFFSET + ISP411_PHY0_SIZE;
 
-	isp->isp_res[2].name = "isp_4_1_1_sensor0_reg";
-	isp->isp_res[2].flags = IORESOURCE_MEM;
-	isp->isp_res[2].start = isp_base + ISP411_GPIO_SENSOR0_OFFSET;
-	isp->isp_res[2].end = isp_base + ISP411_GPIO_SENSOR0_OFFSET +
-			      ISP411_GPIO_SENSOR0_SIZE;
-
-	for (idx = MAX_ISP411_MEM_RES + MAX_ISP411_SENSOR_RES, int_idx = 0;
-	     idx < num_res; idx++, int_idx++) {
+	for (idx = MAX_ISP411_MEM_RES, int_idx = 0; idx < num_res; idx++, int_idx++) {
 		isp->isp_res[idx].name = "isp_4_1_1_irq";
 		isp->isp_res[idx].flags = IORESOURCE_IRQ;
 		isp->isp_res[idx].start =
@@ -114,6 +107,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 	isp->isp_cell[0].platform_data = isp->isp_pdata;
 	isp->isp_cell[0].pdata_size = sizeof(struct isp_platform_data);
 
+	/* initialize isp i2c platform data */
 	isp->isp_i2c_res = kcalloc(1, sizeof(struct resource), GFP_KERNEL);
 	if (!isp->isp_i2c_res) {
 		r = -ENOMEM;
@@ -133,7 +127,28 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 	isp->isp_cell[1].platform_data = isp->isp_pdata;
 	isp->isp_cell[1].pdata_size = sizeof(struct isp_platform_data);
 
-	r = mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 2);
+	/* initialize isp gpiochip platform data */
+	isp->isp_gpio_res = kcalloc(1, sizeof(struct resource), GFP_KERNEL);
+	if (!isp->isp_gpio_res) {
+		r = -ENOMEM;
+		drm_err(&adev->ddev,
+			"%s: isp gpio res alloc failed\n", __func__);
+		goto failure;
+	}
+
+	isp->isp_gpio_res[0].name = "isp_gpio_reg";
+	isp->isp_gpio_res[0].flags = IORESOURCE_MEM;
+	isp->isp_gpio_res[0].start = isp_base + ISP411_GPIO_SENSOR_OFFSET;
+	isp->isp_gpio_res[0].end = isp_base + ISP411_GPIO_SENSOR_OFFSET +
+				   ISP411_GPIO_SENSOR_SIZE;
+
+	isp->isp_cell[2].name = "amdisp-pinctrl";
+	isp->isp_cell[2].num_resources = 1;
+	isp->isp_cell[2].resources = &isp->isp_gpio_res[0];
+	isp->isp_cell[2].platform_data = isp->isp_pdata;
+	isp->isp_cell[2].pdata_size = sizeof(struct isp_platform_data);
+
+	r = mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 3);
 	if (r) {
 		drm_err(&adev->ddev,
 			"%s: add mfd hotplug device failed\n", __func__);
@@ -148,6 +163,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 	kfree(isp->isp_res);
 	kfree(isp->isp_cell);
 	kfree(isp->isp_i2c_res);
+	kfree(isp->isp_gpio_res);
 
 	return r;
 }
@@ -160,6 +176,7 @@ static int isp_v4_1_1_hw_fini(struct amdgpu_isp *isp)
 	kfree(isp->isp_cell);
 	kfree(isp->isp_pdata);
 	kfree(isp->isp_i2c_res);
+	kfree(isp->isp_gpio_res);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
index 40887ddeb08c..fe45d70d87f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
@@ -33,7 +33,6 @@
 #include "ivsrcid/isp/irqsrcs_isp_4_1.h"
 
 #define MAX_ISP411_MEM_RES 2
-#define MAX_ISP411_SENSOR_RES 1
 #define MAX_ISP411_INT_SRC 8
 
 #define ISP411_PHY0_OFFSET 0x66700
@@ -42,8 +41,8 @@
 #define ISP411_I2C0_OFFSET 0x66400
 #define ISP411_I2C0_SIZE 0x100
 
-#define ISP411_GPIO_SENSOR0_OFFSET 0x6613C
-#define ISP411_GPIO_SENSOR0_SIZE 0x4
+#define ISP411_GPIO_SENSOR_OFFSET 0x6613C
+#define ISP411_GPIO_SENSOR_SIZE 0x54
 
 void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp);
 
-- 
2.43.0

