Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81B2C369DC
	for <amd-gfx@archiver.kernel.org>; Thu,  1 May 2025 18:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D068810E874;
	Thu,  1 May 2025 18:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IIjM78li";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B5FC10E874
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 May 2025 18:35:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTnW19eFSmjfvvDf88WIitjp4j4dTpVjof/UDojYc8fIybW/YkAoQfBh8/+518IihuNpGCKupOG/atdohJQwMLYeC5oH7iQ6lRxmMsCRGbPcGmVhCzO2qEIX2VbgCILBxXnN0ZIuvgHQSiZL8WQJBneclmKzs6dM5Um/bRYPbad5gmZ7D4jlSZC9/dxI/L0xaqfVfSCQYkS+hOhe6KFEV6/+wqsuamaH51I8boL9XY+XJiQFuYslVtNDa15oXnz6NuU4f4Irkej3wBgI+MtyEtD+iqQmeCHuZtfSgUcewbfvUmMWttjPuLvnRuG7x2gMg5Ct6GLVvZu8dPqa5ODXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wza9tsy/JpMGB8Wkm4c33WdK+wUR3k6GXy2qpTZATdo=;
 b=sf/Xg63zEnFsMWuFyi0ijL36r1FdP0raGkPJHrgyBT0JZYHSrI0uWwuqsF2hrt1z/KEwXT5MXT7+hTZrKJAVX6xz9aDYrwKZ6QtLT5pUvug5eQWSrHw9IVTtcguJJpv6Mq+vSNKiBSoKV+j/N+i0qLCEW982xx0ksjvSqh9F4kP3o25FQ8E1Bwh2qxitaYv9f5CKf+OGqRIdrS7dvmQYn4Ml1lqgdPo9il3nQN7j6V77i1BP6Hpz4LH20KvnD03xkmZHAz4vng7wKj8HT2dhJrYrnVYLy0gcdzGKEI6Rc5vyyx6pDo7mJW72Qnr83h0oNf9O6uoqp/Fws9gNW1s7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wza9tsy/JpMGB8Wkm4c33WdK+wUR3k6GXy2qpTZATdo=;
 b=IIjM78liiB03EBJ5BQTgK3PNWi3s/Bg5py1/dbN32IxKAJRThc6Ek6jxT8qvdEyQhqJrVwXn2v+g7LKytN9RsSiNgYIE0SbOUSQs2kW9lw5OrW2dGfrDmQDWBziOduBh7P83A9+Qlirof/Z6Td2SFMzQWhFINSf8A6X1NMRQeOA=
Received: from BY5PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:1e0::13)
 by SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Thu, 1 May
 2025 18:35:11 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::74) by BY5PR03CA0003.outlook.office365.com
 (2603:10b6:a03:1e0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Thu,
 1 May 2025 18:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 18:35:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 May
 2025 13:35:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: stop evicting resources on APUs on suspend
Date: Thu, 1 May 2025 14:34:56 -0400
Message-ID: <20250501183457.4123584-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250501183457.4123584-1-alexander.deucher@amd.com>
References: <20250501183457.4123584-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 0523c563-d802-4010-70c0-08dd88dee7d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ZYTwQPuEQ8Eymygq7+ZMlb9qm3hk+2z9Jd1Hqan3c5dleASwse++yrzYpD0?=
 =?us-ascii?Q?o56ISejjuj7jeZtcjfQBwO/o/rLAYlMGgM8vKpRpomqpi9fhBv0j2Cvliyi2?=
 =?us-ascii?Q?OahTMM6hPjuDYRyysz/Y7cAfqGE03n2L6boeZsfPF/9gKuHYl1ms61I/eS50?=
 =?us-ascii?Q?3JcHt+CBQzCffF//Sv3nkEiRvE5OVYNkULYl8Rgm6dDIZ0H9Q1jhpUjtMV4W?=
 =?us-ascii?Q?NzP8ei6evCkn7GTY1/0YUPaP5w7KWri3JEnyUwGkoW/sSwO7N6sx/lLJVX4z?=
 =?us-ascii?Q?2usfJyEj0DrkOAcrAqf5kaA2W5/96s1JFbcYE0HCiE7S+zZeqXO3W9hs3ZBm?=
 =?us-ascii?Q?MyxuB29yg5UE132s+ZyEymv0kHGzAm2tPezb6W0AOTDpsMYF1I3cEO6ZRJuh?=
 =?us-ascii?Q?g9WO4cctrNBLpwdQhePK7e3GOWVIONtxSlx9FA3rv2aIhCnqxuXR5oCuusGl?=
 =?us-ascii?Q?fm9kzwb8lF8C0/pGiu1c5WJIznroGa6EWc2li8e7WJdFFRcRrfD/mcfiPvKS?=
 =?us-ascii?Q?e7fLfSprDIShJaOq14zzKyQfhsOVsT9x/BUnwOuwrANIgraKRsJ6MItPWDhG?=
 =?us-ascii?Q?1l8ID9SPdYjqIe842kuBwKC4hwg1LFrCYgTiuwg79GM62lq4de3USSOPht+L?=
 =?us-ascii?Q?exph0jqA4uRBC/5Z9UmfHW1z495xMYoqzTYz+4gV9zoiTBq8iAXTMmi0yFhM?=
 =?us-ascii?Q?US0pa2i1QgSpBDwahj7X/EgcXs7TM0S9HBBinuKEvE5t/wHrZn2qgD1wH+CL?=
 =?us-ascii?Q?9wws9jAYwpjXiRDh3HLxVNRzmavv2huoNoyRWM0bA2Gxo5Y3CkLO3H0isL1o?=
 =?us-ascii?Q?otsk0QVUqtIuLoP6gSJ0Al5Z/OObCxVI9SdoEnvQol5ZSX72XdpVdOxiOm9o?=
 =?us-ascii?Q?CwNOxGx0ipl94ctbJIlHH69zxBCl1dB18AuIpTBQb1tCLf5LuriA5C/NlSz4?=
 =?us-ascii?Q?fEmHRA61H2bkzwDPiXqUFP00vzacCi7Y9hpSMl6S3M8NXt31NWZpDyrNn5Pe?=
 =?us-ascii?Q?JDYdeZzjHnK/jxBFSNI1K4iNHZrwksQRUEcObd0nANR7CuDGPAd6i5teRoA6?=
 =?us-ascii?Q?GTGQxXj79WlVpXhvPko7+89qVXoMAXJUxQ2TWm3ivOikzpt9j2EguR3Kjhd7?=
 =?us-ascii?Q?J0XWDczW7dJW/bnfuUdthICWAGv8vw8yt8XlTLk/1b7BM4p4sNsUdyM7Y9Lm?=
 =?us-ascii?Q?DxXCeiGIGK0jVUyqP7IqCEDXRDern4NXWA+CmM0lCYlbN1voohJIrrfbO47K?=
 =?us-ascii?Q?iwYfgiK+JTNTrKdL5u0f4ep/rSANrbFGBCw1DmNzhZajynYy/kQ5xkx7wNOl?=
 =?us-ascii?Q?2cNvU5/jVIy97vkTH6o8NqeyWJmXM4s/Q/f8Z13zhjUjHP7Lw0aMG4Y2rNim?=
 =?us-ascii?Q?tDa15ed2vwyYJ9wpp5n2YLAk2vs1phH3EkDRX/Y6vpD3/wkNSidsNn+gnJLe?=
 =?us-ascii?Q?fZWfQAkkbobkKSk0d+3Ygt+Auhms0CaAy+xrg9rtOOBytDi+yjjQPQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 18:35:10.9028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0523c563-d802-4010-70c0-08dd88dee7d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164
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

Set the s3/s0ix and s4 in the pm notifier so that we can skip
the resource evictions in the pm notifier and pm prepare
functions, then reset them in pm prepare so that they
can be set properly in the suspend and freeze callbacks.

v2: always reset flags in pm prepare

Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 14 +++++++++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5ac7bd5942d01..a3e9f289e37c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4919,8 +4919,20 @@ static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mo
 	switch (mode) {
 	case PM_HIBERNATION_PREPARE:
 		adev->in_s4 = true;
-		fallthrough;
+		r = amdgpu_device_evict_resources(adev);
+		/*
+		 * This is considered non-fatal at this time because
+		 * amdgpu_device_prepare() will also fatally evict resources.
+		 * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
+		 */
+		if (r)
+			drm_warn(adev_to_drm(adev), "Failed to evict resources, freeze active processes if problems occur: %d\n", r);
+		break;
 	case PM_SUSPEND_PREPARE:
+		if (amdgpu_acpi_is_s0ix_active(adev))
+			adev->in_s0ix = true;
+		else if (amdgpu_acpi_is_s3_active(adev))
+			adev->in_s3 = true;
 		r = amdgpu_device_evict_resources(adev);
 		/*
 		 * This is considered non-fatal at this time because
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 24ee4710f807f..60c032f124149 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2516,22 +2516,29 @@ static int amdgpu_pmops_prepare(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
 	if (amdgpu_device_supports_boco(drm_dev) &&
-	    pm_runtime_suspended(dev))
+	    pm_runtime_suspended(dev)) {
+		adev->in_s0ix = adev->in_s3 = adev->in_s4 = false;
 		return 1;
+	}
 
 	/* if we will not support s3 or s2i for the device
 	 *  then skip suspend
 	 */
 	if (!amdgpu_acpi_is_s0ix_active(adev) &&
-	    !amdgpu_acpi_is_s3_active(adev))
+	    !amdgpu_acpi_is_s3_active(adev)) {
+		adev->in_s0ix = adev->in_s3 = adev->in_s4 = false;
 		return 1;
+	}
 
-	return amdgpu_device_prepare(drm_dev);
+	r = amdgpu_device_prepare(drm_dev);
+	adev->in_s0ix = adev->in_s3 = adev->in_s4 = false;
+	return r;
 }
 
 static void amdgpu_pmops_complete(struct device *dev)
@@ -2603,6 +2610,7 @@ static int amdgpu_pmops_freeze(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
+	adev->in_s4 = true;
 	r = amdgpu_device_suspend(drm_dev, true);
 	if (r)
 		return r;
-- 
2.49.0

