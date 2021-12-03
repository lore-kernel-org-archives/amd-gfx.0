Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D84DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 03:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C3C6EB9C;
	Fri,  3 Dec 2021 03:06:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CC4A6EB9C
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 03:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEOkzIuKo00l1tEQ2y5c5bQ29TpDOv+ZWCCbU2kNMd0wMs0nK0YjSJ4SlSBk9Y7k4UT5sv62lRp4bWkwXt4FEhtB0bs3gyXZ1IuJMtl3txr7GqA05C0CR3z6jy+Hxyn7Awms1DRM3FqsjPceXtyCFGEOfKiQa5rSSY46WNkfkpWMB2mmGUyzlTp6sOfhlIn20M3I9psgbcwkk3s+eIT4Npl5thy6RSZ/ZGmtmi1zyRAH0ltJ3bQthaPlZh9Gr7+axs3zfcIJedSt5aIj3lr1jdI7Jq2CGoph1ABcpSqOOz/BchjMeyxQJWlrzCeDk+MqFE8VUGiFx6Z2Ngn5MuIe8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/egOMSZ0X+2cBDwAGidrzjrIBjmjxN9sJa7ukA4flc=;
 b=nRwsRTFGDogHhppICLEuiLXlHXO28ZMYvMDt0Y/lNzh1VY4HYeoI9jG6R6pDdFTjP/RJkRVEV7PGuhiz0lg4qen95s5WRcNBHJIDGvU9amPd/xnCSCKc3ZYLNNxNi8Q3DQlRPifxIIn7dVRaYrRV/H0MELD8ZvkwMCF59jc/SPVZvHLsfA/2jCwY9HpyJ9yyYMBjuxxyOucsRYmSXudCVplYgWP1OTzLd6dipBfHEy5GT0Z9iXpdnEfeMNJa2HJkM6wh3I8cvuupDKGYY7bYNyiKQ9GCqBrA/Px1XEIxeA7bMiyczzLzc6azWBhRylQEfDY/bMUpBdcWV65rtw0ljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/egOMSZ0X+2cBDwAGidrzjrIBjmjxN9sJa7ukA4flc=;
 b=wi8pqn8qv3p7NfbKja060+AxoV4ubDtS/KcRJdWKofXqHZa5pIwoiG8O+wyFYjiCoWd1ocDLZFvXwzQM0i52hUpev9go8Kxoke+MAqqQIOeNDrPtz60eXyOjL+A1L47cW/OAykZ2+ciaHZK8MXqcSs4m4+vlI4vpH24vJP0lWQY=
Received: from MWHPR12CA0068.namprd12.prod.outlook.com (2603:10b6:300:103::30)
 by CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 03:06:21 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::ae) by MWHPR12CA0068.outlook.office365.com
 (2603:10b6:300:103::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Fri, 3 Dec 2021 03:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 03:06:20 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 21:06:18 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V4 10/17] drm/amd/pm: move those code piece used by Stoney
 only to smu8_hwmgr.c
Date: Fri, 3 Dec 2021 11:05:33 +0800
Message-ID: <20211203030540.1710564-10-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211203030540.1710564-1-evan.quan@amd.com>
References: <20211203030540.1710564-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc01193f-fcdc-4bf3-649d-08d9b609e1f4
X-MS-TrafficTypeDiagnostic: CH2PR12MB3895:
X-Microsoft-Antispam-PRVS: <CH2PR12MB38959FDF2A3094350E443411E46A9@CH2PR12MB3895.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/ldZBsRpF5aEODNhSeTrp8VCNe5vcs/nV/OiRL96NjCE1iqriRdYIGT16eaFlvZqNlJF20Alo8Vh9uBgUuLW5UediVFjjcUdPDsnH9i2jgUOJDrXvu51rQFx8c9e7y2QEwFzXZDuTZNnn+6d642YDgOYPYgZe6VJgLhpgtzhpqTyRfCerqv6ZOb1/9raAfelSXq4S+Duc/N13IzJdUxq+zMwDAFz4VLMdVDAbENiCfvHD+QhvApKJ4r2j5zdv1+S6RvTlVG8pm+9sM15KRF3CUuhGHuGY4JwNUDvnnZtuQSPJmA9uraYzIbgEiImRj07cfxg0FX1jwElvLfUQVbfs5Xqu6MQrkivj84qWnKCrePms1LDtuUSlrkfHvm+Hv+wd3B8RB1ao8P8poRIWkL5M01ZV7rBJcfRaacnUgBc4Grbu9eF8SWdK2TzTY8hEcZfxHkhVgI5YYYh+6+GDldS2r5AZqC/L5gTulTo89sw1VkOdXcLmKNKEJAQydVdStzfkjsSI/DUH23+aBhOZ4WIXcra0zvyniZcWFNPmFIYtX2PzQ/eB7xm/gNWukmjyXfapqWC6tdRGzbSI9jQ6GJymwI/xi6WCQ6Mk61rT4HQdRovIJm6Z7L2EB3zxi3YVjWNojvT0CjkevN2gIfEkWID5+LAG0i5rwlTKvjND5FO4Jemo0Wd0G/CAOHJ1sOxDvE8DfKdPqlhef6fzHkhwllsepnUORk6579anNn1qK77VVTJOOrEJxrxWVIVTbaGdNUWEZU90ZDhZHPiciXVcP6ZOV46siX42pPrIjRNdxrBl4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(16526019)(82310400004)(86362001)(83380400001)(6666004)(54906003)(316002)(6916009)(426003)(26005)(336012)(36756003)(4326008)(70586007)(44832011)(5660300002)(36860700001)(8936002)(2906002)(8676002)(186003)(7696005)(81166007)(2616005)(508600001)(47076005)(1076003)(70206006)(40460700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 03:06:20.9924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc01193f-fcdc-4bf3-649d-08d9b609e1f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3895
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of putting them in amdgpu_dpm.c.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ieb7ed5fb6140401a7692b401c5a42dc53da92af8
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                | 14 --------------
 drivers/gpu/drm/amd/pm/inc/hwmgr.h                 |  3 ---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    | 10 +++++++++-
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 952fd865db13..6d9db2e2cbd3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -32,8 +32,6 @@
 #include "hwmgr.h"
 #include <linux/power_supply.h>
 
-#define WIDTH_4K 3840
-
 #define amdgpu_dpm_enable_bapm(adev, e) \
 		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
 
@@ -386,18 +384,6 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 	if (ret)
 		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
 			  enable ? "enable" : "disable", ret);
-
-	/* enable/disable Low Memory PState for UVD (4k videos) */
-	if (adev->asic_type == CHIP_STONEY &&
-		adev->uvd.decode_image_width >= WIDTH_4K) {
-		struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
-
-		if (hwmgr && hwmgr->hwmgr_func &&
-		    hwmgr->hwmgr_func->update_nbdpm_pstate)
-			hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
-							       !enable,
-							       true);
-	}
 }
 
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index 8ed01071fe5a..03226baea65e 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -331,9 +331,6 @@ struct pp_hwmgr_func {
 					uint32_t mc_addr_low,
 					uint32_t mc_addr_hi,
 					uint32_t size);
-	int (*update_nbdpm_pstate)(struct pp_hwmgr *hwmgr,
-					bool enable,
-					bool lock);
 	int (*get_thermal_temperature_range)(struct pp_hwmgr *hwmgr,
 					struct PP_TemperatureRange *range);
 	int (*get_power_profile_mode)(struct pp_hwmgr *hwmgr, char *buf);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 03bf8f069222..b50fd4a4a3d1 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1950,9 +1950,12 @@ static void smu8_dpm_powergate_acp(struct pp_hwmgr *hwmgr, bool bgate)
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ACPPowerON, NULL);
 }
 
+#define WIDTH_4K		3840
+
 static void smu8_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 {
 	struct smu8_hwmgr *data = hwmgr->backend;
+	struct amdgpu_device *adev = hwmgr->adev;
 
 	data->uvd_power_gated = bgate;
 
@@ -1976,6 +1979,12 @@ static void smu8_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 		smu8_dpm_update_uvd_dpm(hwmgr, false);
 	}
 
+	/* enable/disable Low Memory PState for UVD (4k videos) */
+	if (adev->asic_type == CHIP_STONEY &&
+	    adev->uvd.decode_image_width >= WIDTH_4K)
+		smu8_nbdpm_pstate_enable_disable(hwmgr,
+						 bgate,
+						 true);
 }
 
 static void smu8_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
@@ -2037,7 +2046,6 @@ static const struct pp_hwmgr_func smu8_hwmgr_funcs = {
 	.power_state_set = smu8_set_power_state_tasks,
 	.dynamic_state_management_disable = smu8_disable_dpm_tasks,
 	.notify_cac_buffer_info = smu8_notify_cac_buffer_info,
-	.update_nbdpm_pstate = smu8_nbdpm_pstate_enable_disable,
 	.get_thermal_temperature_range = smu8_get_thermal_temperature_range,
 };
 
-- 
2.29.0

