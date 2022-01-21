Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7076C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 20:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B3F610E123;
	Fri, 21 Jan 2022 20:22:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1DB10E123
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 20:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQtNVR1aSD+LvhLDjYjp9cb9LoucGiJVEbSJNGT0f+wWt1fZryTASiUboc2N0ToQhJlX6Ghh2RN/4sbq97qE7rIpGhSn98Q2eJNg0q+/hsTTXMWtYcHba+nuLAE+Bec8nocKZ6gqZ3Q7yv7gUIbl+4ekzXP3UDBSTPdscnb7BscUFrQiXDjXb2kky95m9NytYJEmJE0JPC4FalNLOzw1UWCJz4+38Jo6mZN+ECUcetKpV4rD9mOPDJimA0yBWGRg1ef5RgaCFbqVDe+r5tDCj00LrU5HyckdoCoFZEeE0FCiPm3iVedjm47HMqmwDBNWbta32R2ONEvYsDHWJvQZ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuRVjvOzMZyPPrBfGvSBQ2W6xbYXOVaN9JVWwZKDHcY=;
 b=Eh3rqDTNZVbp3LIG7kwKEssHXDAgFN88BYLJHL4rEM6rBjmT3X/Tt/ZFlMh4uDfhZOq7SvN6hptQDvkuW4vVuI3NtH1xfOPWWdkLa0rvwv0Vf259RYR+77Z0UhzdZe+LZb2Nu1XsbgwsfT8RL4i+kyYUo6ZH0HE2rQ8atGKrDA61Uc98bW0SOWQZJhrEJcm1dWd+nhrG9Wwl4K3iGX6F/8yUDxwZo9LgASzHEAcJy5Ias+HmIg1JUD5UQWuu5BEKrnB0mV2ZiJLhX+9Paia8+1Xv8nU9bSl2PaoW5y/Ce8H8R2+V5GvxQWOAEnmr5wExS4Ri+inmY4vg2KtSWnYf2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuRVjvOzMZyPPrBfGvSBQ2W6xbYXOVaN9JVWwZKDHcY=;
 b=49/2P6Trh0P8sdWwuWnGXw87tub8Gq5ZKy4K26KxHVU/d51QgSmHSapYvn2wf6v9XKLldTFJrw6SqC5PXn966sLPfTof3vXc1V/BVVXpslsWDLaBQaIoeYytMEuf3L/e/bB2kRILIj5VIbybdm+9SvQkLlsUDv9JwnerMt2nxGA=
Received: from BN9PR03CA0558.namprd03.prod.outlook.com (2603:10b6:408:138::23)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 20:22:36 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::7c) by BN9PR03CA0558.outlook.office365.com
 (2603:10b6:408:138::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Fri, 21 Jan 2022 20:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 20:22:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 14:22:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: move PX checking into
 amdgpu_device_ip_early_init
Date: Fri, 21 Jan 2022 15:22:17 -0500
Message-ID: <20220121202220.5557-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121202220.5557-1-alexander.deucher@amd.com>
References: <20220121202220.5557-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01310235-7939-4a05-f3bb-08d9dd1bc36a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4128234745E7485051A07792F75B9@MN2PR12MB4128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n1wrzYOjKpVBMRtJy3s2ZjX2gLgVwmrDQnvun4/VbKI9++W5C6j5kEu2bMyS07AQC1Tu98X+ViLjZK2KpNzgruuvlWxzTAGRiAF9/ueEQL86LDBmLCZo5yRhh8HYBDdQ2aC46IUw97pTKCUofN0qVa7RLSTtxJ0KFhvR6CWq9gtcUsNZNiE9ILbzH0ByHf4lF4XAILaGFCUodkbTkWnghcMp2EYbKzNFauY2zPRhZnnSzc6nqogD7r71DTCQeSRW4W12WLHveOHF1OLOCaoMflY/uWrG89XuzmZ7eDdPimonkeCnHUCQIqdSnnjgbFdpF9k7O4WlvpjBii4ISribGNvVRWgyIjdqt7Z11ZCkE4NifJlJZEHbaguxhQNgpzZyuLOKpVMUnv0XizXQEyL3NQNbZk2PhoZeB0hXk3QtPJa4upy3NnMVPiXFNqqhLRj6gjALTPsu5BAkRTA4tjlCRHVtT5N6wHzgjXttBWPUU/ZItwe+Bhc7D4lCKKjjw6dINOqGQXZfEHlzGejA0nqybn/cojPNADre6h9I46nUwTd0mSu9w511/Mb0vUJoNEoA/O/SoLt//esK6gqGQzjM/al2JbhaZoiAxDq51GfkKyr2yDzOzd77Oc5K5LPiP0V4aBLNDDlvo1W5WLDP1sKENkO9yYQLcikARuOMMRDYw/rfLs7xGUC6egXZgMzXHFfXYkWBbUg3gibkwxBNlOZi2fAJbGH/QgfCGmxO0UJvroEJuGS+49mQ04eWYLRQ80a2cgNzn4OyQrAK17BeTr10wY9gg3QiwNimP5qKXRTRlcE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(84040400005)(40470700002)(36840700001)(46966006)(316002)(7696005)(16526019)(8936002)(1076003)(2906002)(36756003)(508600001)(8676002)(6916009)(36860700001)(336012)(186003)(26005)(83380400001)(47076005)(82310400004)(40460700001)(70586007)(81166007)(356005)(4326008)(86362001)(6666004)(2616005)(5660300002)(426003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 20:22:36.1745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01310235-7939-4a05-f3bb-08d9dd1bc36a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to set the APU flag from IP discovery before
we evaluate this code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 13 -------------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 061ea30650cc..df78adecf157 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -31,6 +31,7 @@
 #include <linux/console.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include <linux/pci.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_probe_helper.h>
@@ -2073,6 +2074,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
  */
 static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 {
+	struct drm_device *dev = adev_to_drm(adev);
+	struct pci_dev *parent;
 	int i, r;
 
 	amdgpu_device_enable_virtual_display(adev);
@@ -2137,6 +2140,18 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		break;
 	}
 
+	if (amdgpu_has_atpx() &&
+	    (amdgpu_is_atpx_hybrid() ||
+	     amdgpu_has_atpx_dgpu_power_cntl()) &&
+	    ((adev->flags & AMD_IS_APU) == 0) &&
+	    !pci_is_thunderbolt_attached(to_pci_dev(dev->dev)))
+		adev->flags |= AMD_IS_PX;
+
+	if (!(adev->flags & AMD_IS_APU)) {
+		parent = pci_upstream_bridge(adev->pdev);
+		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
+	}
+
 	amdgpu_amdkfd_device_probe(adev);
 
 	adev->pm.pp_feature = amdgpu_pp_feature_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 56c2d988694a..16a6da09c924 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -152,23 +152,10 @@ static void amdgpu_get_audio_func(struct amdgpu_device *adev)
 int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 {
 	struct drm_device *dev;
-	struct pci_dev *parent;
 	int r, acpi_status;
 
 	dev = adev_to_drm(adev);
 
-	if (amdgpu_has_atpx() &&
-	    (amdgpu_is_atpx_hybrid() ||
-	     amdgpu_has_atpx_dgpu_power_cntl()) &&
-	    ((flags & AMD_IS_APU) == 0) &&
-	    !pci_is_thunderbolt_attached(to_pci_dev(dev->dev)))
-		flags |= AMD_IS_PX;
-
-	if (!(flags & AMD_IS_APU)) {
-		parent = pci_upstream_bridge(adev->pdev);
-		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
-	}
-
 	/* amdgpu_device_init should report only fatal error
 	 * like memory allocation failure or iomapping failure,
 	 * or memory manager initialization failure, it must
-- 
2.34.1

