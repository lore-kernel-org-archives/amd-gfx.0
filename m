Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCC5C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 08:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ADEC10E60C;
	Wed, 17 Jan 2024 08:52:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B1710E60C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 08:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5FPLniIqUQ3GkOuICzN4Hps3uuHc/ps76U8hJASOod8cwrYftTQ8BOOTdUjgBn2EmsXlmLt3bvLKjhO78YlTrk3QixG4m1anEHvHOTnGSLoffx97KgUtwISH+n1L89AjTvCLUKnnSNy/dkoIXSvrat8k0ktWSDFilx197kiWjXP9Qso+NfyaTfWvnMjshMm8gaBtSQZitD8rbZbEYhWEIYPcyS6Ec9HHLGzxw3aiReQ/uF34/oeGc1uztO64ZNWUgoLRzSUv/EkNNs3swGdna8WGlve3qpQeO+RcOI2hNexazb//5uDdO0PmVeyLVZkRjh6kXd4+gNpSrBwfvCC/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gx5trY49QV7PJXr5REn/pyBHnsq3cZlUuNWp5rq32Ew=;
 b=Cg4kqajyPos9yha2FLFnFIw/aqE2yxECXVkO+WZRCvrDwvmGbnrjX31cnV6I51wht+QEiNBOmPnCuL6lR46aat0AijlaMLQHrwSCDhxSkE2VTX1mmOdFUhM+5Uog/SZ3NwPAbjFZR74OvudT7vl+C/fIhHp/EiU7CfQLk2oCByD3TZJD2J1qGeG03JtysDUiokkQKrVjEPTBTDQnnNiljLGhRT8snKF1opU+Rl9Rgzxu0HtozDugKAZRWxXhVQ1NvW8XSdGoEP2K30Hwt4r06B47dKDaJ/UQx6hFboRU7TiymrBIeJMxmJhEFd/QA7giVEnlMvoR0gCfJihhCLAx3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx5trY49QV7PJXr5REn/pyBHnsq3cZlUuNWp5rq32Ew=;
 b=p4UFtjuca0l7c3BYXSBcMyoSXg9ntG1a7fQvofaTgP2Tt3RkxVakCbbuh9TC6p1rNQiRl6xnSsC6dCjVwcoqBXzI7mAOorE+Nq2n179GttO/RhA0T9MXljlwaK+A1DyQ9AdZGP0ZeAnJ0t7l5DE7bLxEq+GwqdgYKQJX1wwHWW4=
Received: from MWH0EPF00056D04.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:c) by CH3PR12MB7618.namprd12.prod.outlook.com
 (2603:10b6:610:14c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.31; Wed, 17 Jan
 2024 08:52:45 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2a01:111:f403:c903::) by MWH0EPF00056D04.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.2 via Frontend
 Transport; Wed, 17 Jan 2024 08:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 08:52:45 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 17 Jan
 2024 02:52:43 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/pm: Fix the power source flag error
Date: Wed, 17 Jan 2024 16:52:29 +0800
Message-ID: <20240117085229.981555-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CH3PR12MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8c5b16-cdad-4c12-c4e5-08dc1739ac9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QtKG59StudcZnKGz6YTQCdGKFPp39jM6vpyjXW99cd4M4rOxHIBE6AvzKAS4/b5l8Uzp764IrTQ9hPAvbykiZDfrTdKkKqHgEukI/U6Z4TYNiWeidfcZHOk76AkjQG3MGyPwi8TtRVorhAgDiOKUkSq+lWupz/9Y1oZ6IY4poik8gEUxl/wdZsuUnViYYusa7EoFc1ueTmMVw1kw4x7afRNGN/V+SC6f5CzpxnCFmyMTvB9ylNQnzxH29Mm6wnlJDT8Wx6jHoLqu+t1TSYtNkpsO5X7cGKDicvQkKMEqUatCePGTJ6Salh20319yiEn6T3M1kjFCjiSMzr6GyPbHrEbV8Jd5PI6xqnUVFJCfGkRPXRzBS3bzc+8FKxwHJIrSoFgs28SVPc4Mp7OlLwoBvy/HI45vHtpWAkssuMZxsNo7L9tb+HaXW47MO6+9wXrdhaHXScVT0L793Gkoy1EKb6NywOQ/Ci6GFWZjMJn2TYSKOqmFQTt2siG7387BCMdgUmXAGN5RsWhQk4aoXNpJwQOcuz7wGqEADqDMn0OS9O54KiqglxoK4KAuVpAreh/D/iO9uBdzp1Rcut3dN4xWahjxSG36MogSF4mfJ1+RV5bsr7toydowRj7Vcn+hkh1TCeGQxDyva1Z6bycAo2mHgzC1X5G4hRt7Y4V91XNVjQspKMDUKFw36ebAUULIM0ZE3Y9nnoAeshZ68deL3KR5VlqOTll0+3IHp0J5r8/RWk/tRFmNZ6U43Rx9NiahOocSz5iU7bWAV/0nUQ+EsQCKtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(83380400001)(47076005)(16526019)(26005)(336012)(426003)(1076003)(2616005)(82740400003)(36860700001)(4326008)(8676002)(8936002)(5660300002)(41300700001)(2906002)(478600001)(6666004)(7696005)(54906003)(70206006)(70586007)(316002)(6916009)(356005)(81166007)(36756003)(86362001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 08:52:45.5088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8c5b16-cdad-4c12-c4e5-08dc1739ac9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7618
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
Cc: Alexander.Deucher@amd.com, Ma Jun <Jun.Ma2@amd.com>, Kenneth.Feng@amd.com,
 kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The power source flag should be updated when
[1] System receives an interrupt indicating that the power source
has changed.
[2] System resumes from suspend or runtime suspend

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 24 +++++++++++--------
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 ++
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c16703868e5c..e16d22e30a8a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -24,6 +24,7 @@
 
 #include <linux/firmware.h>
 #include <linux/pci.h>
+#include <linux/power_supply.h>
 #include <linux/reboot.h>
 
 #include "amdgpu.h"
@@ -793,6 +794,17 @@ static int smu_apply_default_config_table_settings(struct smu_context *smu)
 	return smu_set_config_table(smu, &adev->pm.config_table);
 }
 
+static void smu_update_power_source(struct amdgpu_device *adev)
+{
+	if (power_supply_is_system_supplied() > 0)
+		adev->pm.ac_power = true;
+	else
+		adev->pm.ac_power = false;
+
+	if (is_support_sw_smu(adev))
+		smu_set_ac_dc(adev->powerplay.pp_handle);
+}
+
 static int smu_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -817,16 +829,8 @@ static int smu_late_init(void *handle)
 	 * handle the switch automatically. Driver involvement
 	 * is unnecessary.
 	 */
-	if (!smu->dc_controlled_by_gpio) {
-		ret = smu_set_power_source(smu,
-					   adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
-					   SMU_POWER_SOURCE_DC);
-		if (ret) {
-			dev_err(adev->dev, "Failed to switch to %s mode!\n",
-				adev->pm.ac_power ? "AC" : "DC");
-			return ret;
-		}
-	}
+	if (!smu->dc_controlled_by_gpio)
+		smu_update_power_source(adev);
 
 	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 1)) ||
 	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 3)))
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 2e7f8d5cfc28..8047150fddd4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1442,10 +1442,12 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 			case 0x3:
 				dev_dbg(adev->dev, "Switched to AC mode!\n");
 				schedule_work(&smu->interrupt_work);
+				adev->pm.ac_power = true;
 				break;
 			case 0x4:
 				dev_dbg(adev->dev, "Switched to DC mode!\n");
 				schedule_work(&smu->interrupt_work);
+				adev->pm.ac_power = false;
 				break;
 			case 0x7:
 				/*
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 771a3d457c33..c486182ff275 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1379,10 +1379,12 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 			case 0x3:
 				dev_dbg(adev->dev, "Switched to AC mode!\n");
 				smu_v13_0_ack_ac_dc_interrupt(smu);
+				adev->pm.ac_power = true;
 				break;
 			case 0x4:
 				dev_dbg(adev->dev, "Switched to DC mode!\n");
 				smu_v13_0_ack_ac_dc_interrupt(smu);
+				adev->pm.ac_power = false;
 				break;
 			case 0x7:
 				/*
-- 
2.34.1

