Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92397C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 03:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8D46E957;
	Thu,  2 Dec 2021 03:10:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC2976E94D
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 03:10:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hV3oKbj+i/9FZrePLPMVdwvWE6tbRygVL1ZLQJfbCNLD4zAiWLwN3B5xbfIEuR9K+iEIivGT2XF6dZsvU7+AbteqZDzg77ZCnjiv3kCqR08UPkN7LIclQI8Ei2unYWXTtB/1vWAc98/mtJRCwOH9mC5Me49LE8d7BYkQi0d8Ez/CB/dWtO8ofpCtb5173c3/YYmmgyiBwKQuIzzKq/R9JcecbLvL56xm4ZtQetc0BVm0QWFBIGQG5bFZCgRxr+5W67NmSGZnLkXiw5jUjUIkWmjxFJj8zhLut9VJJrTJPj0xDDoPFh3cHbEoPmDwdcevhRdj31ZfxBefxLTW4Knzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDdz/mhE1NDgvWC/3cZe5RvUKivTYwCmMQBLFKfmlhw=;
 b=YHZKuAsEQNPP8zOyGsNtBeNjc4MMl56r1+ZYfxQNxUx7R7ipl/w21199jodqjyr2pbFV2tYJoE6fiaw4q53wJe5G99ZMJj2hH+P/gwIjcGVl4G56/6wigUIKFGsnjSfkHpS82G5lXha9edx/CUw7+frVycptt2h3bKmrXR8RO6fUNzykfdosjqFVMMPY/vZRVHBxMr++NbkkACBJKM4zuP5wojYn7s5M3Ub3j4jGePQSoBdDzM2K9htMQuhS0PN2eIzr3tnp08BS8Ei8SCrx3RFSLDOL+B7ghiK+Q+K6q8iU7CVG5Yve0Esz/zWteQW/tmqSAKSpDqbboCUY9Zo1Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDdz/mhE1NDgvWC/3cZe5RvUKivTYwCmMQBLFKfmlhw=;
 b=0dSNHNNkJTg1/XmZHkYzm67agI9YCCpoHdSKOJIBtXg4pnIX2v/OFoQ1aJnOz8U00Z7WRPwOhxmQQimZ/TLPIE/H4UsLUnOHlnjgao0kkIuXlAWiFFzMJVWOLYnSlkSkAT1wcVaizQlv7ScpxC2tTRYjKQAFFp5DlVVbFd2WnsY=
Received: from DM3PR08CA0001.namprd08.prod.outlook.com (2603:10b6:0:52::11) by
 MW3PR12MB4524.namprd12.prod.outlook.com (2603:10b6:303:2d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Thu, 2 Dec 2021 03:10:22 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::ce) by DM3PR08CA0001.outlook.office365.com
 (2603:10b6:0:52::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Thu, 2 Dec 2021 03:10:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 03:10:22 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 21:10:20 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 10/17] drm/amd/pm: move those code piece used by Stoney
 only to smu8_hwmgr.c
Date: Thu, 2 Dec 2021 11:09:23 +0800
Message-ID: <20211202030930.1681278-11-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211202030930.1681278-1-evan.quan@amd.com>
References: <20211202030930.1681278-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f33fda03-f49a-43f7-97f7-08d9b5414756
X-MS-TrafficTypeDiagnostic: MW3PR12MB4524:
X-Microsoft-Antispam-PRVS: <MW3PR12MB45248C7E4971EAB97771CB87E4699@MW3PR12MB4524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8e7TQQ/3bAJ360G3dvapihvvC4IiEuHmTsQx35cAD/efc73QQsxqI/4QY4q+/uRypfPLZ1oKpC3ixC0ypSCt4lNhW1QHT4vtF0jYmEnAgZDa718OhENCn9WCafAbu8E1WnmB8FIN5pZ/cCSUe6JFGynejKmSij0+Ny/fLqton/UQrLHEISli+SXUxPAmhGupWTR8B3tXhmPp4tLhpGEMtqfksiNXeSR8P7fqXrTTqVVIXIl2Yi0O2EV/hKJaeZL4MI35+FhTdB/ZJ+XELh7G85aD8BYodXolRPCX2CynGA72sRgUZQ5+hf7z1H2rzRUU0GcNPjbDhduqTsnEmJyq8d0Eqm6WyBFTjsk1GcNQVuoKj8iWWBd/lA6ZUdiF/BcEIhCcuVArUFXhEhSH1zSAw+fUSoDjYvfqZe2kEO2AkSJJ5SkOvis6OtyTsRIPzjyxFOdf2jkg8mJOfdaUR7GjaZikfom67ezdP+bnFJ77of3xHbuLruqdLhZAPybkyrj/6htVCp5RlgKqeB0PNfrJU4rHl6rphc7OD6SqKb23q8wMd6HBjSixz8Tj0Z+DFZtoKiGzTxZrSxoVUgf6UGuKZohFEvf4jnPjKbVcc2YHSb2CkCHZufqcxmKy1cYiW+J+HQyw6GixdaFFPGxYQwOH/m1pthXHhLokiLtT5vKNDAMrxWXvLYcmADOLJJ0rgv6lmr5rE/pl07SikhfVsst/CPBQgD5XC4Nyy4PsRMgsfzKP1h8/QElg2GrVmucQCsaCs+mkuepjt5qBi4yXZH5zc7hh58CFtp4liHJqwL63jE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(316002)(336012)(83380400001)(1076003)(6916009)(36756003)(36860700001)(5660300002)(70206006)(86362001)(4326008)(7696005)(2616005)(426003)(54906003)(81166007)(44832011)(508600001)(8936002)(186003)(16526019)(82310400004)(70586007)(2906002)(26005)(47076005)(356005)(8676002)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 03:10:22.3216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f33fda03-f49a-43f7-97f7-08d9b5414756
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4524
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
index e0ea92155627..16371879cfc1 100644
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

