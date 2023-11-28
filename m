Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C20CC4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 05:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93FAB10E068;
	Wed, 29 Nov 2023 05:58:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 936CE10E068
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 05:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwP4bjg0FEblgCrMO/3/nsxhwXEbo75pG2nwEvb/v782QNCMSEDPyD8C3a08JVKHkEibZ4QcC5y3zZ+I4wxL4P5Gr1mUeVtxf4MwhSt0adIWs1eGWVh/Rypxbfu/AC2l0gTtaoqwNRiytl+5LGzuESSJ2vl45+ldRC6NLlHWGMB2StdV+tgzJRUckUB40To1DAgi9eTY8CwSrtqIX2+R9tG3gWRZMU/vT8H3/adNMyRmWDN/M+pZN2C+UaI03JK6frWlMK0LsfkvPsHqW1Mufv9CbmlGDTFCEOSFa2dVoZgWf0qTGDEOL8L7QEVH1rQa1oNc13DEEQZLbLZ6hge7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8UWva4INLTtGOwu0W6gcRAZdNFukJcbzMQ4Xga2yUo=;
 b=D1qIPNuGQLk9DA9hqE2JpAEy4YJPb97rq3PFpECvwTddDjuzUx7xg4CBCS2q8RIUeu2Z1d+xmAq4Xe/HA+NAphHo/vEwKDB5TiyKt3jrZANtupLR/dSzlz6QSuQsQfgtKkVkIwXt4VaSTbDOwOUxiotxZN8an7xXFYs/+x97N2qCTyxgq0+FlnNRh35uKMLWxt4D4afaAYM4ltIcfC0F1CGjyfY0cGvC3jSsQtXR6i/PSOVFJQWHRlr+wyHXyH7g+8+GFPcqSC7GHDvPmfyS6qBo3HCBLXWmb9dIbjXAP/B0/Mys8zMIaGr9VbWd6a8DJZwOAMgqertZuW2z1hQVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8UWva4INLTtGOwu0W6gcRAZdNFukJcbzMQ4Xga2yUo=;
 b=P51lvCjhuj9tLRKuGT/cavR6l0Sjwy4XY1M9V/wkwlPT6HaYycv/qgbcSHL+7dQwgVKhdsnShIfLYL3xhhezugqZoL9mBxSpWI9b2t07xA2I7hJrWflFfxhpwr0OFC9n2iTSQPDAqdk3dsfpFf7KIIDiwKpuJUkkhs6We3puM9U=
Received: from BLAP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::7)
 by BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 05:58:26 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::87) by BLAP220CA0002.outlook.office365.com
 (2603:10b6:208:32c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 05:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 05:58:26 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 28 Nov
 2023 23:58:25 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd: Fix handling of amdgpu.runpm on systems with BOCO
Date: Tue, 28 Nov 2023 12:52:36 -0600
Message-ID: <20231128185238.187381-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128185238.187381-1-mario.limonciello@amd.com>
References: <20231128185238.187381-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|BL1PR12MB5094:EE_
X-MS-Office365-Filtering-Correlation-Id: f6600dc7-2267-426d-e4c9-08dbf0a03420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKOMU0xbm0AcfeeZG2VNnQvyJgydVCROpTexnwiQrTHxKZgv9Vx8/Tyv31ha9VJCavBm39EEqclSJkCr+3Yzz9O3kf16uXEwK+ERgyRcJlz0dB9XbXRBYTvA46PHugQnxYXcMkUo1gpbU77kx3qUUCR/t5XKxHnsqNXHmTEwuYGwxwVJe33CjfRXTyGcZ4ghTA+bhUgvGvIIJjWR43wIXk2/FB3wz/yeK98Knrn+C+Himk2htyWY7QT2VEY/icYOQGBQIBD+OrzXeFmvd6Ugwb4b8OtCEvjScNw5QBI3/iwi963eZ9Rol24yWxvPP8sMFtP3r70/GsdNDSi9ImUJV75wkUZZm/cTd9aFx1U0TrNiO+fFSkirJDDZDOmSwlc4n6SR3NmG4tX/YFjE8ZA8IsQAb0MSatKqjTkATLAQOD5xdIm1xTrFZVbZC8E1Mo1vh8B8Ly343nWujhjFQ2BLYSI755wfXb0r7n6Yn0Q3uACSUoCKsu4HH8WfrX0UGuVavkklvVUAG+wFGJSCvavXRSrBbJ0pJtB7WU8EeNLnfCq/5EXdza+9Kx8JF2vEkLLdrkEIBFHWcSFHkPqQqVXFK09WR+3KhDhOrns5Xs8+WbbCQBygzDI423mlWLdoDDtMav73OtJq5Sy6WL1YsGdor4epYNZD3HweHAMRQwd5bq78M5oKoHBIe8STZv2yVYvsxm/L1iHrjpc2MKnG5fUZD1TWKNLABHi/DfqwmunDt7lFrxIFUcqDWL1ExUrMPwYDppBcARmabh+/4AJUhAm+Yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(82740400003)(426003)(336012)(36860700001)(40480700001)(81166007)(40460700003)(83380400001)(47076005)(356005)(2906002)(44832011)(86362001)(5660300002)(8936002)(8676002)(4326008)(6916009)(316002)(70586007)(54906003)(70206006)(478600001)(6666004)(41300700001)(7696005)(36756003)(16526019)(26005)(2616005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 05:58:26.2749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6600dc7-2267-426d-e4c9-08dbf0a03420
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5094
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
Cc: Jun.Ma2@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On products that support both BOCO and BACO it should be possible
to override the BOCO detection and force BACO by amdgpu.runpm=1 but
this doesn't work today.

Adjust the logic used in amdgpu_driver_load_kms() to make sure that
module parameters are looked at first and only use automatic policies
in the -1 or -2 cases.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 80 +++++++++++++++----------
 1 file changed, 48 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b5ebafd4a3ad..29381da08fd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -121,6 +121,53 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
 	mutex_unlock(&mgpu_info.mutex);
 }
 
+static void amdgpu_driver_set_runtime_pm_mode(struct amdgpu_device *adev)
+{
+	struct drm_device *dev = adev_to_drm(adev);
+
+	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
+
+	switch (amdgpu_runtime_pm) {
+	case -1:
+	case -2:
+		break;
+	case 0:
+	default:
+		return;
+	case 1:
+		if (amdgpu_device_supports_baco(dev))
+			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+		else
+			dev_err(adev->dev, "BACO is not supported on this ASIC\n");
+		return;
+	case 2:
+		// TODO: adjust plumbing to be able to pull PP table to check MACO support as well
+		if (amdgpu_device_supports_baco(dev))
+			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+		else
+			dev_err(adev->dev, "BAMACO is not supported on this ASIC\n");
+		return;
+	}
+
+	if (amdgpu_device_supports_px(dev)) {
+		adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
+		dev_info(adev->dev, "Using ATPX for runtime pm\n");
+	} else if (amdgpu_device_supports_boco(dev)) {
+		adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
+		dev_info(adev->dev, "Using BOCO for runtime pm\n");
+	} else if (amdgpu_device_supports_baco(dev)) {
+		if (adev->asic_type == CHIP_VEGA10) {
+			/* enable BACO as runpm mode if noretry=0 */
+			if (!adev->gmc.noretry)
+				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+		} else {
+			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+		}
+		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
+			dev_info(adev->dev, "Using BACO for runtime pm\n");
+	}
+}
+
 /**
  * amdgpu_driver_load_kms - Main load function for KMS.
  *
@@ -149,38 +196,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		goto out;
 	}
 
-	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
-	if (amdgpu_device_supports_px(dev) &&
-	    (amdgpu_runtime_pm != 0)) { /* enable PX as runtime mode */
-		adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
-		dev_info(adev->dev, "Using ATPX for runtime pm\n");
-	} else if (amdgpu_device_supports_boco(dev) &&
-		   (amdgpu_runtime_pm != 0)) { /* enable boco as runtime mode */
-		adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
-		dev_info(adev->dev, "Using BOCO for runtime pm\n");
-	} else if (amdgpu_device_supports_baco(dev) &&
-		   (amdgpu_runtime_pm != 0)) {
-		switch (adev->asic_type) {
-		case CHIP_VEGA20:
-		case CHIP_ARCTURUS:
-			/* enable BACO as runpm mode if runpm=1 */
-			if (amdgpu_runtime_pm > 0)
-				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
-			break;
-		case CHIP_VEGA10:
-			/* enable BACO as runpm mode if noretry=0 */
-			if (!adev->gmc.noretry)
-				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
-			break;
-		default:
-			/* enable BACO as runpm mode on CI+ */
-			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
-			break;
-		}
-
-		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
-			dev_info(adev->dev, "Using BACO for runtime pm\n");
-	}
+	amdgpu_driver_set_runtime_pm_mode(adev);
 
 	/* Call ACPI methods: require modeset init
 	 * but failure is not fatal
-- 
2.34.1

