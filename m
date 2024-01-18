Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B1BC47077
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 07:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 192EC10E152;
	Thu, 18 Jan 2024 07:28:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF59210E152
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 07:28:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WntMndas4UtBd16sgiHPVoh9Kk5FBnp5e8YDOv5/PZt4HYRDljxHhTxtDcgk7B7G5DexgyD5skPRe6s5tUB0D7t2Zsi3b1sD3afJwLkD/o+Vv6mxPo55mmgiGJ/TqXBtZnwtTYGoLxRhZUh9lt8O4k1Q3sTVoW+3ty0jE4u6dzST0kEgPWqw/TEHsG627TFCjvELPr33p8hnoyL3Oe/1U4vSHWUSRCoOlwXZ90p2nhZ3f9PTTVFkUfKyR0gFbiIiiWBJYpKjxurnzd4aK+2GQfPQbJn2YO6y/sTbcx/CHTMeGfsV4Vu7TBKv2rPAlRunHDx6V3DBvSh1XoIQPd5caw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnLesYeH1RyOZ8GDEdZ10NX0Ah4ZCH057/wN2w1dfDc=;
 b=kiAmct3hUYusiotNpAPVd+2/2MiR3xi4FMPKbyDAFg+nqhswxTB9EzC7Zu5C9O03IaQOisa2XoS6gfXLjDJoPd69W5FTzgyW88u6MoqII7+EC0ojYjRDBU1C+/O6PYAEfMp8VnjJuK0qRCUxOLtXrsu1xeFO+Vdc+V4VLIa1PmDNm6bO6MjGNLBKXgEjOEyXxO8OfwB2L1ucoBWqbGeZPMmW0ffniTW+tXbXMJ5qpfyGUFJMPlYK9TpaktrGfSloEMFpI6Tkwgxg4qKrJF7m0wQ6XfJs4/PUboIA6U+aaWDlzSBdBrrmjiw8TNAg8gsTLYZWAdDqCyWQsylXq2/b3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnLesYeH1RyOZ8GDEdZ10NX0Ah4ZCH057/wN2w1dfDc=;
 b=QSU1x46ew34O3zPXKOK3vVgV0oRBoH/24a06aJpqD3Y/TqAbSiXLjmG7+MntJOc12wT/93rob0NWQ/G9UjyXSRGDb/kwV67zknPwXENYFVfjMxAfbpp6IouJIBtN6h+8vJtKQiIRa9zbQbrQUR1TMr+JjVm7IJEhUS+6V+7ME90=
Received: from MN2PR11CA0019.namprd11.prod.outlook.com (2603:10b6:208:23b::24)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:28:23 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::6b) by MN2PR11CA0019.outlook.office365.com
 (2603:10b6:208:23b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 07:28:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:28:22 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:28:17 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu/pm: Fix the power source flag error
Date: Thu, 18 Jan 2024 15:27:42 +0800
Message-ID: <20240118072742.999070-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: 0980f88f-961a-4ba6-849c-08dc17f70d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXd/7q+2Ga+GZt8ikMQGL3d0lJ7pfetrZVuQl9BhSVsM+QT1EEXswDOj4WTCebie07bD1eOgnnb44GfOzo8Wpk73WSDz5V3YB2A5WgmLprdEGAlZBsg+7VGOkvaa6epGu3O+v4cowDeYQqOH7cKRhhWtamFx+KOpVFegJyoaP1cFykCVh32oOsnoBagzcuIt3xqlaBRZbnTAdzj8bBn0+/JkgWgmj0Q9SXIYbqkRNk15UqyJXvUPkm+Qoc7UXnh9v0jku+ZnUUf8lkpLmtbTWkW5sVoehu8smv5pnBhRWg7TzURi5NGP2E8IJHcH5ZTJMPuHYi5Lfq7Adgq5s0sR7IXhUr9csQeE0F6h2GjlHLgtoUd7FzdZb56AsWXmbVTYY+t5ID5sGBt/gBqvAU29YIcI2KCNSs/h2JmMl+vC/rRxz6t9hlUq5LSFtp8LtGQeHW3tCqNAWwYkTa8wip6Mijp5O7X2KgR3pZyPKqHzhqfjBGbbpciU4QGWqdXDktoC8QbtU1VQAPkin8ZZWVdzXuo4y69yiDI0JIwnVWXDkAAGgdopdUYUzQH1O9LHVoR8z7Yz5fy5XVZ2eJ9ss6Gxzw+fner0GqXsR1/qAFT691gTBK6D9wFBg7XIrJpsCbBgbtztnLs2oJpTTQRs+N7VduLXZDNGVYHiQyRMLqrP4BJT7jAT1DH93HD5hR7VIj43Y0vJHjbwvYdEfU3xTyGyoGSOwIxck+Kmjx/zskH2yw1aC9AlNPulIpcjlC9yhgnTxJyb/yF69GFHw8OQpvg2Ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(26005)(426003)(7696005)(16526019)(1076003)(2616005)(83380400001)(6666004)(336012)(36860700001)(47076005)(5660300002)(4326008)(2906002)(41300700001)(70586007)(478600001)(6916009)(70206006)(54906003)(8676002)(316002)(8936002)(86362001)(36756003)(82740400003)(356005)(81166007)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:28:22.8613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0980f88f-961a-4ba6-849c-08dc17f70d68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344
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
Cc: Alexander.Deucher@amd.com, Ma Jun <Jun.Ma2@amd.com>, lijo.lazar@amd.com,
 Kenneth.Feng@amd.com, kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The power source flag should be updated when
[1] System receives an interrupt indicating that the power source
has changed.
[2] System resumes from suspend or runtime suspend

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 13 +++----------
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c |  2 ++
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c16703868e5c..a54663f2e2ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -24,6 +24,7 @@
 
 #include <linux/firmware.h>
 #include <linux/pci.h>
+#include <linux/power_supply.h>
 #include <linux/reboot.h>
 
 #include "amdgpu.h"
@@ -817,16 +818,8 @@ static int smu_late_init(void *handle)
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
+	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
+	smu_set_ac_dc(smu);
 
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

