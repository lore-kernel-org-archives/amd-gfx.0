Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFEDC6FD1F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 08:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 363771125A9;
	Fri, 29 Mar 2024 08:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nr+iqzdv";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C8191125A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 08:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+eGUrf/Unr889xqnZrSJcE9VcBiZhV43T8J2/CmMzT2Z6RdxhGDc1nfRf+Z/vivtRdgqDU8oHn4iyz4ZusfEcKSpYruL1/29caEpjm7JKfFTbun/xvyiVcWMPDkoiZ/HvBNKvaj+MiV6sMgfhiR3u23C35fy7I82fGISUUewn9/zG98MUdXoE9MaI+PjW/Qk/pwBXL8XVvZJefvTDk24A9GK6isWXYHVLbPBPDo670CEATglSq/tH/2iRqGYM7g5wyHA2vXgpfXjTHMlrOzvYXzzc0zDeZwokJJj4M+n+HS0Tp7HCEU7mWs6nGxHF0pwObzeYycuaXeS2vcNx/Kwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eFF2QyGTWPpxUPR4vpas3o4hhHyCRgAdYCKwmrEg4c=;
 b=RnVFGS4simnVjdbcQ6WkcTIWOwvg7nEbR62rNOh4X4d3H982sc60kFBXRM52JL3YBGR/6zQOdMHGu92Y214sBVFnqB8/m4Ih4VG5dDIMRKmuD+wDQO5WkJKhPnTsUgJuLO1+/0BGcdWYrLAz6pNhhVQWonia1UcNCSKPgx2LOz0zHfMOTcuPQxkRWtaRYO/UZHsEHXB5uUGLqFk7/hbR9XfdRdMmlwfmTs+VYxkdOfdYI7/sl8BgB2QOlxu7r52lP0BJhDD0T6IeYkocI1L8WGkER+QIlDcBSLZJEtDrojLwi5mDW+SW7GninzhyVQG0oX0e3jMqrmdJy+MpeBaI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eFF2QyGTWPpxUPR4vpas3o4hhHyCRgAdYCKwmrEg4c=;
 b=nr+iqzdvRXnbGxAdD90xdwfogBlU4rpt3TwOxLIy8ncgGRQNUXSbyQstGdYFAOrWeTXlVE+2v3p8Ux3LzCIKa+30ON85zJeZIQ7/C7+pujMfwnstQ9f0bIR7taDYi18rlv+vkuchlAPs/z5Q8/ZHev9zRfhMCYCVPtrhDl6Pu9M=
Received: from CH0PR03CA0064.namprd03.prod.outlook.com (2603:10b6:610:cc::9)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.41; Fri, 29 Mar
 2024 08:29:19 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:cc:cafe::16) by CH0PR03CA0064.outlook.office365.com
 (2603:10b6:610:cc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Fri, 29 Mar 2024 08:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.0 via Frontend Transport; Fri, 29 Mar 2024 08:29:19 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 29 Mar
 2024 03:29:17 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu: refactoring the runtime pm mode detection code
Date: Fri, 29 Mar 2024 16:28:57 +0800
Message-ID: <20240329082857.3082844-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3c9063-52c3-4fd8-3bfe-08dc4fca543d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kuvihrq+ZPNWPgAmfgMn87YA2qpfe2TndcYg6n+YnpCmw8jSTFbcPsUaRFj7YW9NdYRoW1/DIsgsPBtkMEhUydDrxeENYsayNwfM4nd2aS1QCj1azlordQyW6wg/kpwBgX/OX+P8q+sWRHUj0klzX2D28t1IELYRjSP2zxjkYtUVaQz02xO7NqLEEiUqs4CHDBEvGvgtJAuOy9y7PUew6RNZmbFcRhCxZJLRqmhNqR9zAY/dMSfjp0HHJiGZlm5OegZPyZh1xmYhhlSleKx+WRxX4P6rFfPt4xPPIId7NBGZo3D/TiGYjduXAJOIgl8xrFVrb+CcwcVaSvX0zBXMvD3LUelPkW4BcpbMHHD9avGEjE/tXkRRzOS6tNp0OdBU6Vb555U1amtY0ElEwJwOwPaHGVDndIyeraRQoPuopp6/VhTNjq9LBh/aignJ3/ahX/994moiqbOpSalHoZNp2Ae1CNJ4kFqs/lHlcyn/bUcwoSSa/LnHjeernXva5AtNmcZ54R/Y0S1LOleVKxIQ1nW0LbH2qqDY20eWbbmEJG8cPnQiGwHLeYp8OyZPRG8Zc37mHNMXmTXsG32tBTJQVNovDtAJjyjhnRvMEVqsMUkljUktZYOGmrvzFzaXleBb0fy9oqylFQBi+A4bo610jfXLdCv/bPH9xybBn/ljaNWtMBKvR9IQYI9ogx7iGrVdfxQPrkZm9cz2R1I3wt6LI9gaNTFyH8MvjsHi91XFfBGaC+OhSzA2FjTyhB/u/aSR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 08:29:19.4430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3c9063-52c3-4fd8-3bfe-08dc4fca543d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257
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

refactor the code of runtime pm mode detection to support
amdgpu_runtime_pm =2 and 1 two cases

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 68 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 48 +--------------
 3 files changed, 70 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3723235f5818..4358d8c630b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1408,6 +1408,7 @@ bool amdgpu_device_supports_px(struct drm_device *dev);
 bool amdgpu_device_supports_boco(struct drm_device *dev);
 bool amdgpu_device_supports_smart_shift(struct drm_device *dev);
 int amdgpu_device_supports_baco(struct drm_device *dev);
+void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 				      struct amdgpu_device *peer_adev);
 int amdgpu_device_baco_enter(struct drm_device *dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 410f878462bc..ca117f2666bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -350,6 +350,74 @@ int amdgpu_device_supports_baco(struct drm_device *dev)
 	return amdgpu_asic_supports_baco(adev);
 }
 
+void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
+{
+	struct drm_device *dev;
+	int bamaco_support = 0;
+
+	dev = adev_to_drm(adev);
+
+	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
+	bamaco_support = amdgpu_device_supports_baco(dev);
+
+	if (amdgpu_runtime_pm == 2) {
+		if (bamaco_support == (BACO_SUPPORT | MACO_SUPPORT)) {
+			adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
+			dev_info(adev->dev, "Forcing BAMACO for runtime pm\n");
+		} else if (bamaco_support == BACO_SUPPORT) {
+			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+			dev_info(adev->dev, "Forcing BACO for runtime pm\n");
+		}
+	} else if (amdgpu_runtime_pm == 1) {
+		if (bamaco_support == BACO_SUPPORT) {
+			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+			dev_info(adev->dev, "Forcing BACO for runtime pm\n");
+		}
+	} else if (amdgpu_runtime_pm == -1 || amdgpu_runtime_pm == -2) {
+		if (amdgpu_device_supports_px(dev)) { /* enable PX as runtime mode */
+			adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
+			dev_info(adev->dev, "Using ATPX for runtime pm\n");
+		} else if (amdgpu_device_supports_boco(dev)) { /* enable boco as runtime mode */
+			adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
+			dev_info(adev->dev, "Using BOCO for runtime pm\n");
+		} else {
+			if (!bamaco_support)
+				goto no_runtime_pm;
+
+			switch (adev->asic_type) {
+			case CHIP_VEGA20:
+			case CHIP_ARCTURUS:
+				/* BACO are not supported on vega20 and arctrus */
+				break;
+			case CHIP_VEGA10:
+				/* enable BACO as runpm mode if noretry=0 */
+				if (!adev->gmc.noretry)
+					adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+				break;
+			default:
+				/* enable BACO as runpm mode on CI+ */
+				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+				break;
+			}
+
+			if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
+				if (bamaco_support & MACO_SUPPORT) {
+					adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
+					dev_info(adev->dev, "Using BAMACO for runtime pm\n");
+				} else {
+					dev_info(adev->dev, "Using BACO for runtime pm\n");
+				}
+			}
+		}
+
+	} else {
+		dev_info(adev->dev, "runtime pm is manually disabled\n");
+	}
+
+no_runtime_pm:
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
+		dev_info(adev->dev, "NO pm mode for runtime pm\n");
+}
 /**
  * amdgpu_device_supports_smart_shift - Is the device dGPU with
  * smart shift support
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 5d1b084eb631..924baf58e322 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -133,7 +133,6 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
 int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 {
 	struct drm_device *dev;
-	int bamaco_support = 0;
 	int r, acpi_status;
 
 	dev = adev_to_drm(adev);
@@ -150,52 +149,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
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
-	} else if (amdgpu_runtime_pm != 0) {
-		bamaco_support = amdgpu_device_supports_baco(dev);
-
-		if (!bamaco_support)
-			goto no_runtime_pm;
-
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
-		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
-			if (bamaco_support & MACO_SUPPORT) {
-				adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
-				dev_info(adev->dev, "Using BAMACO for runtime pm\n");
-			} else {
-				dev_info(adev->dev, "Using BACO for runtime pm\n");
-			}
-		}
-	}
-
-no_runtime_pm:
-	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
-		dev_info(adev->dev, "NO pm mode for runtime pm\n");
+	amdgpu_device_detect_runtime_pm_mode(adev);
 
 	/* Call ACPI methods: require modeset init
 	 * but failure is not fatal
-- 
2.34.1

