Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96590C7EE2A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 22:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F73410E07A;
	Wed, 25 Jun 2025 22:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2IYf4oLG";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8EA10E07A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 22:10:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2a79jSvQy0a9swd5/weI9qwujfhEa/W5D5SCCYaf1BhiSI4qBPyOX2Yj5VVC8YSeADc0F7gfxRrpYNecRHXT1iXSiHNczm8GU25VE82+P5JpwTP9QMs5LSee5a7//BUORRR5hjGZKg9POQ299P9DyF6LTFCCCwYuHPijfqXr8EHUQE4zDqQHbJkC0EQWljQWTbTUMc+JcggnTJzBh8zjlIBTkQYjTJr2Y86AMGCZI/hJxvSkv3QmpffFNWyGTnWXNNbAbWVO15ymmKitaLW0qXzbSzhHLj4OmDzTJOl9vpc3OtAHR5kJEWwn5zYN7sVo1o8aVKce/eq9kU+sx9PmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9s+do+PYj6JPFyEG/RGj1ArbOwmpBjLmwsFZK/7OOQ=;
 b=NHUkYfwcoRU6YBXvKMKgUaLSTRbRIiKoVHwz+mwNITtteQBkb8kIoCEX855aCBPhrUqQLsVzN0mX/FenF2KA9llQPXJpVmN8yKhPSZzSfDvd7XDn7pQaUWGNYpForicqfpAhJULMLlpm3nSmf8bO/rBO2dE0KrKYjFZo9Q2vfNVmOZ1i9qOxxDjvqaBtD+BNjWDwELEMKelmxM5h5373HOdrGahbsW43d4c8uCMRX3gZSHUEltummmHbcUM6fF050FG9qcweiArA57XqLvWsLtB7eeEeEVgOXuC+GTXsvDTBopvi+G5sAps5vE2sX565v2Wwf2PAy5j0ss8A83V+uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9s+do+PYj6JPFyEG/RGj1ArbOwmpBjLmwsFZK/7OOQ=;
 b=2IYf4oLGKCy+s502vClMl6cA6/IX5Abi36H1yYJhrEAUhan17UU+C6eHB5PRdEDVZgTNy0Fv6aWzQ095tpaX3kU6fO28MGXdU9VfHDlTd7SnX1qQMxnu7N1DATi5uy5Dxu0sZyW55v6y7YxrlbG37F0zCp8WYi2HK5waCa7tBiA=
Received: from SJ0PR13CA0214.namprd13.prod.outlook.com (2603:10b6:a03:2c1::9)
 by MN0PR12MB6221.namprd12.prod.outlook.com (2603:10b6:208:3c3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Wed, 25 Jun
 2025 22:10:11 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::cf) by SJ0PR13CA0214.outlook.office365.com
 (2603:10b6:a03:2c1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.18 via Frontend Transport; Wed,
 25 Jun 2025 22:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 22:10:11 +0000
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Jun 2025 17:10:07 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <mlimonci@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, <Phil.Jawich@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Initialize swnode for ISP MFD device
Date: Wed, 25 Jun 2025 18:09:32 -0400
Message-ID: <20250625220949.116574-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|MN0PR12MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 597c5082-d93b-48b5-a4df-08ddb4350da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jqXL66iT7dVfoQMlFqJp2XjZS4ybb5VAC19v+GHeHnaHb3depd2rk2fWoQMz?=
 =?us-ascii?Q?iRjyHweCX2gylpwFyCE2ILxibmAMYVOhqa7g4B+gJ4O6SV6BLA/PCj94nRoN?=
 =?us-ascii?Q?MkDV4Dhi8JngDModKWAq0SrLMK5imMx22d2dqtsmWrfVnGAC1UHIkbPGc5Zv?=
 =?us-ascii?Q?K9LyvBHlMMboEuSnPM6mr2X+zlHEvA/+h848GOrDpI670kHIweyf5f5Nsm2m?=
 =?us-ascii?Q?QOh4kgELQCWz4g0wdxUqXhGStpr+pswpmd574yUEEbWn+IGGj0ypckVbawJX?=
 =?us-ascii?Q?RSX27kNJWJ176sUR61xjuVi7wu2ojEueNfGzGL5/6Tvd0A+70bzbV5QHCh07?=
 =?us-ascii?Q?UcBAv0Ai7MwAhqepC+6K9zBfNzFQ0B/JcAqQ40vMgbqKCz3Ab+LEIahLQtgj?=
 =?us-ascii?Q?y7Fy/jWJFaiV6NUnCVZHawimGdlteGVFci/f4visTtMXj3FPNQInrXaN5oaR?=
 =?us-ascii?Q?719YKHP5r3GWUs+eNeQQ+BHnh+uMLmxCR11imlRQVHrBDzZ9zXL+YCQe6rgW?=
 =?us-ascii?Q?ox7neA13HHBUnhhsfoo4ZOXD1Ca928LKy7HxBMyBXzsH4E2vU9IWKxA7A9o1?=
 =?us-ascii?Q?ONLXhdFjURjtS449eLrp4xemXuGLg8AuKNEAahMGxQ29Cz6bXfKm8yKlpbt0?=
 =?us-ascii?Q?7fSTd+ZlUojaw7WMME3gST4UfPO+6myVBGS6WIhMiud4rhLL2HbzOiUkU4MS?=
 =?us-ascii?Q?0WCDC50snpVKsGoLJYDUa+9vZHumK0OeLPc/kA+rKPencTivkKZQwJqmXKpH?=
 =?us-ascii?Q?/my4u+aC/l+Z/DjmAPIoOrEAkc+ubo5Cw9UkkW+NSBtF7mmjPrMf6aZn9dQt?=
 =?us-ascii?Q?5RaGQdJTp4eNvCIu1aEI1v4mjI60o35xK7uHLspqv2N3OUQrWb22wpSNmZyJ?=
 =?us-ascii?Q?UTdf9wt2PrefEH8LeE5KXjtid0kHGTfalTbpzHabi46jnQXe13F4d3FNsTfM?=
 =?us-ascii?Q?yA8VVn3RFtgql7gPMz3a49NlVJA7yPvBuu32OWzKB0PTcCv/myCCtZRaUtDx?=
 =?us-ascii?Q?8WnUJ400KrBwsfknbM+ibi+IRU2VvHb/7zx4Cis0rq/sIt4rhnxOR+04PDaV?=
 =?us-ascii?Q?kaJT6C2EXg47AiX4HyOT2++AhSftREknQNAV+DMu2QNMNBltqa2X5TTZQ8QD?=
 =?us-ascii?Q?V+WtEHH0E4E6iaeuN9xsBEgQ9vsu38pByD3fCgfzTon9tvcWsObW/yUPn8GS?=
 =?us-ascii?Q?di9oK4tnU2LRS97W0bpz9WSGlGuTmJ16/2qfkoBxHNqq7ExnSIHpUsB/uYdY?=
 =?us-ascii?Q?jiOMcGmdxqIpXKxyBTm9DWLeam09Mdvb5L5pneliPuMxZvKds6+bd6g1h733?=
 =?us-ascii?Q?UJKjB27oZpqvgoQk7k9Cp5TzWZUvg6IMK9FKAE4c0F5CfSg1f4kw10yYzAb7?=
 =?us-ascii?Q?5XsusXKgUO0GVglc1vAPk1/AYVR/yd7p2/LxKfozf6qsG6gsszsZHbQzowys?=
 =?us-ascii?Q?4B+gHsy05qf+kWleFm1n7UurvEEVV3477Y/VLJzDhTAj5UgTtaulSCUTNrq8?=
 =?us-ascii?Q?q04bKioEILhduiFY4HUWFqDo6u5h7iODC+1A?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 22:10:11.0862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597c5082-d93b-48b5-a4df-08ddb4350da5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6221
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

Create amd_isp_capture MFD device with swnode initialized to
isp specific software_node part of fwnode graph in amd_isp4
x86/platform driver. The isp driver use this swnode handle
to retrieve the critical properties (data-lanes, mipi phyid,
link-frequencies etc.) required for camera to work on AMD ISP4
based targets.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 11 ++++++++---
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3f0b1fa590c6..7427986992d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1718,7 +1718,7 @@ static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return
 #endif
 
 #if defined(CONFIG_DRM_AMD_ISP)
-int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]);
+int amdgpu_acpi_get_isp4_dev(struct acpi_device **dev);
 #endif
 
 void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index f5466c592d94..ae2d08cf027e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1545,7 +1545,7 @@ static int isp_match_acpi_device_ids(struct device *dev, const void *data)
 	return acpi_match_device(data, dev) ? 1 : 0;
 }
 
-int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN])
+int amdgpu_acpi_get_isp4_dev(struct acpi_device **dev)
 {
 	struct device *pdev __free(put_device) = NULL;
 	struct acpi_device *acpi_pdev;
@@ -1559,7 +1559,7 @@ int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN])
 	if (!acpi_pdev)
 		return -ENODEV;
 
-	strscpy(*hid, acpi_device_hid(acpi_pdev));
+	*dev = acpi_pdev;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index f857796f0297..a887df520414 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -183,15 +183,16 @@ static int isp_genpd_remove_device(struct device *dev, void *data)
 
 static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 {
+	const struct software_node *amd_camera_node, *isp4_node;
 	struct amdgpu_device *adev = isp->adev;
+	struct acpi_device *acpi_dev;
 	int idx, int_idx, num_res, r;
-	u8 isp_dev_hid[ACPI_ID_LEN];
 	u64 isp_base;
 
 	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
 		return -EINVAL;
 
-	r = amdgpu_acpi_get_isp4_dev_hid(&isp_dev_hid);
+	r = amdgpu_acpi_get_isp4_dev(&acpi_dev);
 	if (r) {
 		drm_dbg(&adev->ddev, "Invalid isp platform detected (%d)", r);
 		/* allow GPU init to progress */
@@ -199,7 +200,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 	}
 
 	/* add GPIO resources required for OMNI5C10 sensor */
-	if (!strcmp("OMNI5C10", isp_dev_hid)) {
+	if (!strcmp("OMNI5C10", acpi_device_hid(acpi_dev))) {
 		gpiod_add_lookup_table(&isp_gpio_table);
 		gpiod_add_lookup_table(&isp_sensor_gpio_table);
 	}
@@ -241,6 +242,9 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 		goto failure;
 	}
 
+	amd_camera_node = (const struct software_node *)acpi_dev->driver_data;
+	isp4_node = software_node_find_by_name(amd_camera_node, "isp4");
+
 	/* initialize isp platform data */
 	isp->isp_pdata->adev = (void *)adev;
 	isp->isp_pdata->asic_type = adev->asic_type;
@@ -269,6 +273,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 	isp->isp_cell[0].num_resources = num_res;
 	isp->isp_cell[0].resources = &isp->isp_res[0];
 	isp->isp_cell[0].platform_data = isp->isp_pdata;
+	isp->isp_cell[0].swnode = isp4_node;
 	isp->isp_cell[0].pdata_size = sizeof(struct isp_platform_data);
 
 	/* initialize isp i2c platform data */
-- 
2.43.0

