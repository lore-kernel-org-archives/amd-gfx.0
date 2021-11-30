Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13196C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 07:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5460C6F4B5;
	Tue, 30 Nov 2021 07:43:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6726F3A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 07:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1ApmJ2ZWe7BQtA9x7xjcr2PFi4aZcThUcbyRPhmEW1x0wkDv1oKbD+tNcdvM8MQAPIsF1ZD9DoOvqCZ/uMrfk413b4msF80s7pGYPzVO0xo52FJh/ejkS0RSdymc0LzwFmBAr7/jzB//N71825uk8jxX6gk3mtuYlkD+D/krp2PqDoAsNOeDra+zAPJYx1fXXcHPZUY/U6he3bc4DVOQdoKcrbwPZzuc6dkiiCKqB3gQeb7asqfTV8oN6P204EVT+g/Gy7CiNw8wyE8KgfQjuMwZqCZ0+lNJwcHcld3ePW5VS+Ysv+7pe/kCU47TN16iE0SdPfsU3Qp3tJbJcpyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/FgJMHgMtdGlkG3o9aAnABUw+DfAqFqzYLcKeC8Xmo=;
 b=TMi6QrI62dMC0V/s4u+GQ8rAo6/22X9u5ifP2JyW1hlFVdW1flXsYrhdsmY/wthP/D/ahwOQ0xGLwAVallAaIDAECBgKrhb39gPTlA5EzLAdUD0osiC2pPEz6P8Dl4i5bpoJB7EhhkzWez5OaGBwY6/4xDvTNAGHbrjHaED4q/mjJOMUuSc2Nitxn8PAWTQpp2LcRbPn99fyyRj7B2aGGI9oV2zHs0rXxJO1b0EoDyuiWgJlQA2J6+jwMnjs+DmIzUfpAvTmDyHcSe4fUFE+OZa7AF0lvz0L94nxhrSLLIKbWFpWR3kKwCb7w268COefRT1RHu+E2fzJHQD/iuf7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/FgJMHgMtdGlkG3o9aAnABUw+DfAqFqzYLcKeC8Xmo=;
 b=m83Jj0wemY6wsqsgjU05s2Dgr94J4aHeUhGTXf5JhkkaHODgjgv3uyvAHqQ4N+qT+D5p7B2XogdjmZnX3Ba+fbSgQCfYaABRnn/9m2cK0wCguyuMBxQEYK65BFLJ0cK+3Hy3HudkqyenbX424Py0zrqM7CPO+4hkE/AkWXLfm+o=
Received: from BN6PR19CA0097.namprd19.prod.outlook.com (2603:10b6:404:a0::11)
 by MN2PR12MB3631.namprd12.prod.outlook.com (2603:10b6:208:c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 07:43:52 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::91) by BN6PR19CA0097.outlook.office365.com
 (2603:10b6:404:a0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Tue, 30 Nov 2021 07:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 07:43:44 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 01:43:42 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 10/17] drm/amd/pm: move those code piece used by Stoney
 only to smu8_hwmgr.c
Date: Tue, 30 Nov 2021 15:42:52 +0800
Message-ID: <20211130074259.1271965-11-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211130074259.1271965-1-evan.quan@amd.com>
References: <20211130074259.1271965-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53d6857a-54fe-44a6-dc9b-08d9b3d522ee
X-MS-TrafficTypeDiagnostic: MN2PR12MB3631:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3631964CB08FC735EE9B98CCE4679@MN2PR12MB3631.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wdxwp1ysSlKdPrl8szIuCytwNRd8OX3HYk1XoG78/2V5osj3oUe0P/H0bnGEtBDrLwvO7/nHGjyKoawsYZ0A1ytzprBOZfxYvo0tx3wXkKyZUBjEcg16+tb6BD2+hNPEC8QQ85Qxk5Z+vXeuE4GYCySgUuLZX0EofvGe4kQTCiO6dXHQBF2bVuKTbvGdWSEmmYI2pyr8fe4G13YOMnpdfus2P2m7mvHbYSDBsbLj3qIJyugqa6P3PnZ/DywIop5JSpSX7KSNVv3JcuwgiqQt+Wi+/h4U7VXSrSGnSX8xUxwoo0yWdPhUH054om4gXxJNkjjSQnDX5N36PnZHkbRzrznG976K9RtOCWT5oKjFG1e5IchJKa7ECEGBxi9F5bJu7qfgetIP1xxjC6svfJ+0qmkSumOVb15WyhqBhSDGdUyfQJqa8sSbmKUPydXTSvuYO9l7ysqvOz0II6aLL2jF5TMyUYNv+q8aMVMpbDwG7G8eOK2b83hVIG11KaOth866q80WlJI0k4JuSaSgZvYXwjNu8WiK5ya4JOeSOotJOmPdz9GKSS1imP5r2W/WLb0bfM1B7A1dCgYQBJyxPqybWzyjW3zJn0dmEQdPUcpS5dD1nocne18AKuQusDbtZGgu9V2oUHj3uIEvDprnpW0I9Ep2H9ddTroN/LCgOiyJ5T253ylvi88jeg3wSql4ZP7mkF20mqMn9N2Yv0tVPJQ7qrvERYy7MFTjBVlhz4b6EkYJHXzpTLhGP/KHieHhpBQXeot3x79/DZctsqh2DWaCpCpZWMXYUn1fSPVp/eG/VvE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(186003)(83380400001)(36860700001)(47076005)(26005)(16526019)(2616005)(36756003)(2906002)(316002)(426003)(8936002)(7696005)(44832011)(1076003)(82310400004)(86362001)(81166007)(5660300002)(336012)(8676002)(508600001)(6916009)(356005)(54906003)(70586007)(6666004)(70206006)(4326008)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 07:43:44.4681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d6857a-54fe-44a6-dc9b-08d9b3d522ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3631
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
index 1399b4426080..c6299e406848 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -32,8 +32,6 @@
 #include "hwmgr.h"
 #include <linux/power_supply.h>
 
-#define WIDTH_4K 3840
-
 #define amdgpu_dpm_enable_bapm(adev, e) \
 		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
 
@@ -383,18 +381,6 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
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

