Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51C9C27C76
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 17:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5472D10E7F4;
	Wed, 25 Jan 2023 17:16:38 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14DC710E7F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 17:16:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GigaqC917KSYrbhiD1IC+BwqxLuorhU3VkqtGR/TF6rQspD3INOFU/ANebh7j81sLKR82tfJ2xtxdSzi/YWqkvWelHlnPjcV6aQwjNqDiTXfIh1cNS7kzbHDu0XtFjw0Yy5zmPBd9jgH68+gGI8446RunMtEGhzNk1Tvl5xayawIejal5RrPZ0Oo86ZWumjozllZ5D3INevzaHMF5YQA68tRx2KI41H2Dzf6c+NlE2WlwJGOVJ4YY2/dd+BGwK3F5z/OB10bp+Fu0mFjS/ZZyCXIWpXjulZ3QAJgGYSD/jj6GtCAmlqmnrUUVTgwgMkTkNfPWuEIVRn1EdtB8sVkFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/FmFY3leZ4Yr5noFDC7pbzv2QYcGT6u2XSLxXWpzMQ=;
 b=FFlqOX/1pR8hWGssvGllTqndRWE1A8XbYYM8jMGsIDCrZeOPIhqDKFS6Ks/AMIdIjJ48DmXQPZJWxQi+I7ilaItzMmFJwDeVs7LP1NHQ+ZqtTa9L1zA00vgJzjT6T0baj9NsFbLl9twehAT+g3MRbtr9J0BuwrL8hcmIOoLwTTQRI1n7KNjVVHHYdvKNJASzdwxYcPWSVEaGzrtbEYlDF2D+tupwBqaMopi3DaCZk88wrWwJ0vceMWstgMOFgwUbXbIgEI5tzAFvNJc4VyX0FmYTvsr/nxOMOBQ4QjZYgmhsetvw/3r0I+tYYnNVkn9Qz30icfxZj+L4/tZfJ9A3/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/FmFY3leZ4Yr5noFDC7pbzv2QYcGT6u2XSLxXWpzMQ=;
 b=vka6yPpZOL4kizURe2epv6dDh5vdVjSLt+13hddOGSFAXf826684KXwlD+DE2P5dT2332w67LefX1O2JP4kwAe1m1oLd0sxR2lEPetLhMj38HiZzFReqgPhmRZmhsU35GLqYzbdFPtMY/6VQ+QrIAu0HEy6QmVegPmlceDgO+Zw=
Received: from BN0PR04CA0067.namprd04.prod.outlook.com (2603:10b6:408:ea::12)
 by DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 17:16:33 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:408:ea:cafe::ca) by BN0PR04CA0067.outlook.office365.com
 (2603:10b6:408:ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17 via Frontend
 Transport; Wed, 25 Jan 2023 17:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.10 via Frontend Transport; Wed, 25 Jan 2023 17:16:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 11:16:32 -0600
Received: from desktop-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 25 Jan 2023 11:16:32 -0600
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 1/3] Revert "drm/amdgpu: TA unload messages are not actually
 sent to psp when amdgpu is uninstalled"
Date: Wed, 25 Jan 2023 12:16:28 -0500
Message-ID: <20230125171630.112605-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|DM8PR12MB5400:EE_
X-MS-Office365-Filtering-Correlation-Id: d23b2f8a-4161-4d95-eb98-08dafef7e857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BIoQQ0+qCMQyl7lo4KnTP1xErJ4VW46xzoYbS1tfT8xLjwo5ksv+YlXVBZH0uJwr8fKwqHW5XppzFYLZpLkJJ3UN9waFbhkFQ1VfDR3hUrmyd2BQBqLMjrFUa/kEYnxJ3tQRZ/pIp15ao3ZZbeH9S0esdhpsODBy9GNfGSRbzlgq6HYZhCs39Yc9N5iwiufvJh9IqT4Ap7IpL+u8KVE8DU249hyUwqaBV2iGRpXiR3tBseheJpn8BT5PJYKZrW58sK1N9FO/l3o8NEu5+c40aXVFwHI0Qr1+JQtCAGEJ08cwcrNkvEjw5vG6lRyI+NOTXa/U4Tafty7j24V2KO5mMfeR2UnuUY7sR/nKbTuoRdCu492S9G3R4ZJ0HCR4kMqaxjyT7+KGw4G2RomumELeq4jo2OxRRQmL8LUu9XZLyCYEJVXrpAqiFaPLGWrXwlqWFjCS2lMchLH640D5Qd3+3FCnw5QTjVaftqpYc5Hm8sncF4hNhMpuLPFppP1lOYxQkZQGBiZk1e44ClvrOpeuxtzsHjVsNo/QxTVisrYtsnI24UYM3g8WSCVNFRO1lV/9T/qtoc+z5PqCH1j6Gqik2uK+KFluZEjcj72RGCq6bo95hP4ZZzSceheD7nn3YO+9WBFOvlBBeHKSADUwROLE1Ell0qhHGDXTwD8ZVrh5JGg7ScsbNQs45C8C/vw1tj21RtbcFPMAQiv0cOEMfkQCuhcgy6NMsP7On/S1sZjgh8Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199018)(36840700001)(40470700004)(46966006)(47076005)(186003)(36756003)(8676002)(6636002)(40460700003)(81166007)(40480700001)(356005)(36860700001)(2616005)(336012)(86362001)(83380400001)(426003)(26005)(82310400005)(478600001)(5660300002)(6666004)(316002)(7696005)(1076003)(70206006)(82740400003)(41300700001)(8936002)(70586007)(2876002)(2906002)(4326008)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 17:16:33.4019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d23b2f8a-4161-4d95-eb98-08dafef7e857
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5400
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
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

This reverts commit fac53471d0ea9693d314aa2df08d62b2e7e3a0f8.
The following change: move the drm_dev_unplug call after
amdgpu_driver_unload_kms in amdgpu_pci_remove. The reason is
the following: amdgpu_pci_remove calls drm_dev_unregister
and it should be called first to ensure userspace can't access the
device instance anymore. If we call drm_dev_unplug after
amdgpu_driver_unload_kms then we observe IGT PCI software unplug
test failure (kernel hung) for all ASICs. This is how this
regression was found.

After this revert, the following commands do work not, but it would
be fixed in the next commit:
 - sudo modprobe -r amdgpu
 - sudo modprobe amdgpu

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Reviewed-by Alex Deucher <alexander.deucher@amd.com>
Change-Id: Ia5c6c174dddb89a33dd93b641fd05466ffb3500c
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0f9a5b12c3a5..a10b627c8357 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4031,7 +4031,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_gart_dummy_page_fini(adev);
 
-	amdgpu_device_unmap_mmio(adev);
+	if (drm_dev_is_unplugged(adev_to_drm(adev)))
+		amdgpu_device_unmap_mmio(adev);
 
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a75dba2caeca..7edbaa90fac9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2227,6 +2227,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
+	drm_dev_unplug(dev);
+
 	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
@@ -2266,8 +2268,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 
 	amdgpu_driver_unload_kms(dev);
 
-	drm_dev_unplug(dev);
-
 	/*
 	 * Flush any in flight DMA operations from device.
 	 * Clear the Bus Master Enable bit and then wait on the PCIe Device
-- 
2.25.1

