Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56790C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 03:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDEF210ED0D;
	Mon, 13 Dec 2021 03:53:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2E8110ED0D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 03:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQFYe82lK6x6ZeuGyvNwQ6X6JXTLZFVfasCkOFo8MTEVyWWwvtN8qIf+qU7F12vMZSu3RQN8mV5Ls2orcO3bMe1Mn5KHWP3vc66vrDrdoWrQu0BVr8JmgLWpU03mOOQcZvuBqwoUjBf18GzmTDrtoTOpe9wP+dzLS3qElOTxf2WPTv4IcrMcHp62Pj4u2MJOzy1LmU4bvdNZgOfbj0X6Hm/G4RVlMgICpgDhNmEoppQT53Aly04r6Ro9DmFbsc9DZM4x8ENvtTNAz1U3Y29/y2LIcgXW0GnmlwlsQJdPu1Co1VuxHdauoOwzwn6aEzvyxxPSFdu8ZXy+Gdo0atwvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u79OQPesSvdVAw2cTj1Y1+u01GmtOxEKHH0sNlZP/x4=;
 b=YEdK1Pcu8txBJ270q/ZB1b/JhnZunfLtn0ePy0/XKVTkrgo5YiVgOdmdfQz0UnR4EgArKkQEUjIuXFD+mpgq+dHu5ZWuSBF4OzZMB59xP+f+bCEsjbqkn6v0cV8l6fFG2Y73c5KobcwaH1L5uUHJ/ZHTbnG9LofxfPGT+g71FnxSSYHdA9zR1pqBzEXHHcFD8/kTpMBt6vLaa5M2sB/7A7z7UclupCInICRkIAX7x1f911O5KNFTR0D1WDAcgfvCyoeITimtEO1uCUEk/lSSBa1RZ6+Cz/jDkwTHxvgBkxGxfntOVp22D0uXMXwMmIYE4Mm1nM5291XhD+L+drnabA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u79OQPesSvdVAw2cTj1Y1+u01GmtOxEKHH0sNlZP/x4=;
 b=ywQoc7XxqZOM8hf0ZawUJBr5aSDrJMnka/zoOo5ql+Hb721mUPMqiIJFbY9Kz4BOeQh2IXRqUD4feprAjySY5cvDRC9UHLnG3saKXQW1b00DajrAbMknQ94g/JYUDLfJgV0EvGnPjTnFtFfiN8+eRxDgIsFLlQSbFlwDbktAZio=
Received: from DS7PR03CA0222.namprd03.prod.outlook.com (2603:10b6:5:3ba::17)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 03:52:59 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::76) by DS7PR03CA0222.outlook.office365.com
 (2603:10b6:5:3ba::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Mon, 13 Dec 2021 03:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 03:52:59 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 21:52:57 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V5 10/16] drm/amd/pm: move those code piece used by Stoney
 only to smu8_hwmgr.c
Date: Mon, 13 Dec 2021 11:52:17 +0800
Message-ID: <20211213035223.772700-11-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211213035223.772700-1-evan.quan@amd.com>
References: <20211213035223.772700-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fe7f09c-edb3-4f11-11c3-08d9bdec0de3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4454:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4454EA1EF6604E4D48F4AF19E4749@MN2PR12MB4454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VkCh5/QLKz/FMpz/0nTSFiCaay+lqabR03mXC+lGzA8BULU9hLOrR1s1DhBbSfpEFeNsT1SsxaVWQCnb/o/vm5ijyIsjasnR63yLjauoij/643i5CtIPz5xRl1bqXSOyMrlCFKkJSA4i7VXe2hKEvTJqHiMh0M3MjIGn4iUMhNlHYnT3Yz0ZHuNnFvTeyh2LLu8aUYA7i/iBs4CUhkNcE+Fzb4CIQFRL0/GcsEjhftJiM8OGjPCGbucsUGJAIsdQ3b/crroqgo01ahvBOZYc8KnCHPMzgMB9G1kj4Nexc67SnmCdzd2Ue4eKhey8GS3la1Oih+V/PxX3yVCZUOSzGzC5+mgyrxHxiibFkLSPv2KYJltXSM3fMDN47aAWjU6iKL5PYf3KQqXD5ZBgFntlW+sm0C9hhtZOmgkFIn56dUTpq1BATED82kSBGQ2v37iNMBU3EknhcZbUieEQSAm6JZepHR1+k5ZcREWJVxTXmyPPdPgKwUpbG2vjdRO5xmgNsUGic7IvqyIePuAJednze5C1OuoxrDX192M3ISergF1FAuwYzOLST0MU8GfvlXZDCpkAvGlbrxrPjIZQ2q4QPyrnxTPLovATYIkwEpXs73EjqUP4DcUCAqxeUjFbqhA4vFnSVAnzfAICAZn7xOJONFEz6No8Mtp5lq4UpklMjJIO/8EeyEzXRgbL/tJSJJEqSWrRW1pJBiObkj5oVmfdxP2ozAVtIksRPnAkQyYNlUVv3xmFjbQA+75e9PrOHL9Uz15pGL72vXHQVGwijDPMvdAt23UD2FgRd6R0jtbo0bE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(26005)(2616005)(426003)(186003)(44832011)(4326008)(6916009)(7696005)(336012)(81166007)(316002)(8936002)(54906003)(16526019)(70206006)(47076005)(36860700001)(70586007)(6666004)(40460700001)(5660300002)(86362001)(82310400004)(8676002)(36756003)(356005)(1076003)(2906002)(508600001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 03:52:59.1458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe7f09c-edb3-4f11-11c3-08d9bdec0de3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
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
index f62c253e35d3..166c62b68727 100644
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

