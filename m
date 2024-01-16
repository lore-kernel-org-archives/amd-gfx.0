Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A876C47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 14:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D7E10E07C;
	Tue, 16 Jan 2024 14:39:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FE0E10E07C
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 14:39:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2U6zJMwvNXnxIFLX52YHXSlgCiOjSJHV4q/8vYSKZeqoKTkkwzdU5xxqs580Z/j1DUlCDepnHWBkRjkLgRnBDNjDyWdf2vkkEzfMVGGrOS+5w8rG3tTLxrCPlAmmquZD23aA4TCOqhVxth0oR9mzBGH0SKkHWcz9/EiK5bNvwNnwxlHgxKPeN15mE5Yk2jUFm0/WldY/OmgOQtbC5XCnRS71YE34cmJirdeNn2vznUW1WjsoUFGJ5HNG0VDfbyx2S5niwQFN/Ktle0dwUe64E5sFXeBKdq6EAaInIUsKFFUKJwbBO5aaKbl4F52i5mC1AETp0hr+90afaftJw/A/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuElONyUu5TStIGPTUdz/OEwGUsaQw2dgFWEqjQ8RPw=;
 b=KhCTDw+dU9IXr9a6ylrQHdMFrwNUaazGo+sBF4otqNkJaCIp8Y8ZZBQ2jB2s4bSgfofoN5Wxnk/529Qv+nU/y7s2wMO6tpK54MiDr5qNvtE5QfeYHCUBA5W6ZYlant32XbcaNb/Ov8lWgQXwxL2W0+BvSL6sy0eIKDeHGZjqHptgyZ9jjKoU0PxOwkt6aBVTvc8fLyXAGrLrRMQ9vyTtmA4VuGyBj3Dxqdl9pkCszg5C8EetyHghpaXl4/N0/t361zcaFz1ub0DJ0OhWZ3CGs8vqGPUfeTzl2EyV/8XKfDz2DXKhEBbvOq0sC34Hcvccub9sRncgXCWJFb//DCIvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuElONyUu5TStIGPTUdz/OEwGUsaQw2dgFWEqjQ8RPw=;
 b=jTGzw4aSPYjI40A/JjdzqgtVLPd/sHsfIzt9q5IQSDBIz/mE+B5l2P7/dyDgpOEhfRgzRfr5UFmaJkrIUBd5NcVbr/d2FqFz+OgH8QjxeVys/sOB0tnphgR8+wXweUwXr8qa+BxoWYnXGsYtpzXUTO/tXNz3b+RGvCokE/NyU+0=
Received: from CH5P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::8)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 14:39:30 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::b) by CH5P220CA0017.outlook.office365.com
 (2603:10b6:610:1ef::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Tue, 16 Jan 2024 14:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 14:39:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 08:39:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: only remove existing FBs for devices with displays
Date: Tue, 16 Jan 2024 09:39:14 -0500
Message-ID: <20240116143914.2991405-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ecf16dc-e77d-4f67-e20c-08dc16a0f2ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DoWz86iETignO2caDZrJkkjHMHKH0t2qzOTqX4UvGxr9IsG6f55+htLMyYmd2dSoPXwICY843Q6Ns8viymgHC+WmZNzd/20rDoKvL1Sw2RigTtIFgkdkvuE04n1AOQ43wKv7VwI+FK2+jazT/p3jX0r04m7Zf+/8LxqYsoizS/TZ7QoP6sQdcqqtLp5ovEjivXbpfXJ1Ke2XUj1oS3OI0fXWiCegWEqmYowaP2yV/RsEk549yEwWYF46XAdXtxGDKd2V5Zvf0G9JcHLICr+KwceLwByOCN4+VOZDWPZ9PF8g36VjSCwS6M97LCeBThCZNmdT0c7wofoT1oQnWA0CuHUrvJgN0NB5KAEozw1QMhCzoqC7gzYzAABujYGrVE0OIVr1Go05gkACpCEcgn2m7U+BWG9NUIjfE3BDaH+C/KhNpz/vTfkoTVmiQf6TTn9dbH6jMrqQk2BblJQsgQDl0LPlX5ECKfDF/H+XQir0U8e67jF6PRaPIIsjOhnnBuKKuDYAZea16B6e8mcNF/JeC6BgBT8XujpnPvo1Zgh5m7KkE9ID4Wf6lWuKWle+nuELoRb52ppstt/JpkeHJuTU0AXp3zM6untGOJtlSutPgnEez5DabcBdOy3FxPSZvhYzvFoch0IqVSRplFOndkNb9QZkA4ygEmgrACVEa8kdf6QmV3MIoD5ezjFC0hbq1BfKGR1QULkDcmXr2OSI8gFMSbnezNjs4PItO6Jby8TOHXzFcolgIgfkKbF8SCcPJGkgBJb/IzXezngbHsmt6LO3rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(46966006)(40470700004)(36840700001)(2906002)(86362001)(36756003)(41300700001)(16526019)(336012)(426003)(356005)(83380400001)(47076005)(6666004)(7696005)(26005)(1076003)(2616005)(81166007)(82740400003)(36860700001)(316002)(6916009)(70206006)(70586007)(8936002)(4326008)(8676002)(5660300002)(478600001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 14:39:30.0512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecf16dc-e77d-4f67-e20c-08dc16a0f2ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109
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

Seems calling drm_aperture_remove_conflicting_pci_framebuffers()
will take away the apertures for unrelated devices on some kernel
versions.  E.g., calling this on a PCIe accelerator with no display
IP may take the apertures away from the actual PCIe display adapter
on the system, breaking efifb, depending on the kernel version.

Just do this if there is display IP present.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 62772b58ef3d..353c38f008e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4056,10 +4056,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_device_set_mcbp(adev);
 
-	/* Get rid of things like offb */
-	r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
-	if (r)
-		return r;
+	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE)) {
+		/* Get rid of things like offb */
+		r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
+		if (r)
+			return r;
+	}
 
 	/* Enable TMZ based on IP_VERSION */
 	amdgpu_gmc_tmz_set(adev);
-- 
2.42.0

