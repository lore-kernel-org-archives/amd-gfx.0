Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3621EEB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 07:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4D1110E194;
	Mon, 26 Jun 2023 07:47:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37EF910E160
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 07:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4URAjwOh+UT49zL5R970wg8PH2KQXpt77ligXODg5VMtC9vyVWV5sH3f2iOA9WItqfhpETcIl0LtrALLjlGzOYz+v/BG+wFFCDezx0+ErfaV02bEEWiugxYxXdZ1Xjoue/8tVvNWBnpq8uOGyFnLp1jX6LYkv50ghW3c1xiUAkuK4dH1O0uwLawz3oh2UvoB++Y8JdEnKKYhgAGTaD0N85XmcgOJpEj/3oPdPEp2JuYhY/47eq2D6wx1t+PWhqxN5L0R33UJny9BmOaNtkm9rdP0QK7HzriF/rcerPSVgZ8HIFWV+1apRCiCCyt9sPuUMujfPHxHPlQQ2xLqA3+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVue0Tgmcbf1VDB0t//9jM0LGGMlrgCc2CJ8k9awHM8=;
 b=TDsIEWB9zjSjhWOgIg74OW0qEt+pdda0BPkE0nTle56oQCPrRcy15wyo9pTmwnYQ1DCfAHzPD/8rRvOHaZcDTLwAim4s4tB/rex98hmkIzsE7yxyTJgkUnDPWNMDlfLUcTRfmZUs5kqAu5ptjCbWqRTFJ+CvUtgXuriXp4T/sInPxqDB6f/Q17hAvQlK1wH3P6m5avHlyDbKiEy4htL+Yc56Bj0l6R69OP32fz/BFYFNtv0b5T+UcF5DJ3BgnAqLoYxlG9ss9npCb8rFXFOTYV9zkK1Fm0b6KsE05i5ul1UVYqCXNtodcM6VhDXpVvu0M+YPx+rAB7ELk6cGidt9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVue0Tgmcbf1VDB0t//9jM0LGGMlrgCc2CJ8k9awHM8=;
 b=RM6JFrtXY4/olzo22bkIgrGut8WSQ8hxQuFtKsyGR2An1lx1Orrr822jskOnCE3Ywqp1aR1g5FvHMRX3S+44BB0GnvXTgAOTDqjVcDUedXs9E/BELA+5qxjC5fwqIKMCUHvBQyKP8ICtElYpDEkJaFP65JUpUj0WW1nozF42mVY=
Received: from BN9PR03CA0138.namprd03.prod.outlook.com (2603:10b6:408:fe::23)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 07:47:42 +0000
Received: from BN8NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::9d) by BN9PR03CA0138.outlook.office365.com
 (2603:10b6:408:fe::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 07:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT103.mail.protection.outlook.com (10.13.176.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 07:47:41 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 02:47:40 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: avoid unintentional shutdown due to
 temperature momentary fluctuation
Date: Mon, 26 Jun 2023 15:47:13 +0800
Message-ID: <20230626074713.27397-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626074713.27397-1-evan.quan@amd.com>
References: <20230626074713.27397-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT103:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ecac36-4acc-4bf4-d313-08db76199f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvaMUzsPHpVEL9ivCeqfKsoQqy31wFZaf/gvgWE5S1epKs81Z0oPd/aPT8dJ4i4iObftDh5Kh4uZLSQFn8BhdBvmzxsiQZPmXg/QsV1tsApMifgYldAXgRjsMovr1o6XvZtsMSAy0e2fo8UFEWm5HRCf/RcvEGBZV3acM6GFNuq85ocXASa/KiNIyAcW5OmdU9tWd9GHuiRrtfYAZtHk+lQ7sNEnGU7S/6k3jmmJ2tOLYmcJEhB/gtrJhXuxE8kCnGyJOBg2zqz9CglSRk5A4YUxXNVMo92ekB8AMpyJn8ezI3sFvCydRwNXnpaVMQ3/6T1G265lr16ubAgiFvGkqAT4qTZCd++n6tuHfUmj8JHsAVKYTFAo0vmpK5FnGPaiRAZJ5ldCOtrKQI/CJ6lo2LfvJ+4zMtlrekIK0SI7mlkmPdLnQh01ghbx2ExBRL+kHppwBcHp0M3J+0Oe6Vm2jFTJSd+zKGY7ZugfDf2WY5JkXbW+fYJhodYMij6uGzOiKNLZmzErbdmH08pVEYrrqnQP/enui6Yl3cVw3ieMiOYzselZXkTPNOSnFptpgsCANbmcdzkLJ7+RuFxALr6nz46HSFKZRpD/phPvWfKnE8GSmZovdC8D0l7jy+5TvumUg9xY80B9njjlGkfGm+IoKwvYYNvuaVP2e8+Jn74yKlSR5rf75Ku57WcDpvxsZMpFf6/nMOlTj3/Ou9JTdKdrIaHuVA95vSiSo16NnKLv9OOhfRTgOlwb3+c+L/2nFHYtTxDeeEZ4zod71WDTx6gMiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(36756003)(316002)(70586007)(70206006)(4326008)(6916009)(478600001)(5660300002)(8936002)(8676002)(44832011)(40460700003)(36860700001)(40480700001)(86362001)(54906003)(41300700001)(82310400005)(7696005)(30864003)(2906002)(16526019)(336012)(426003)(1076003)(26005)(47076005)(186003)(82740400003)(6666004)(356005)(83380400001)(2616005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 07:47:41.9691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ecac36-4acc-4bf4-d313-08db76199f31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

An intentional delay is added on soft ctf triggered. Then there will
be a double check for the GPU temperature before taking further
action. This can avoid unintended shutdown due to temperature
momentary fluctuation.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 ++
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 48 +++++++++++++++++++
 .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   | 27 ++++-------
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 34 +++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  9 +---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  9 +---
 8 files changed, 102 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e459381dc759..5ef1f31e703c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -287,6 +287,9 @@ extern int amdgpu_user_partt_mode;
 #define AMDGPU_SMARTSHIFT_MAX_BIAS (100)
 #define AMDGPU_SMARTSHIFT_MIN_BIAS (-100)
 
+/* Extra time delay(in ms) to eliminate the influence of temperature momentary fluctuation */
+#define AMDGPU_SWCTF_EXTRA_DELAY		50
+
 struct amdgpu_xcp_mgr;
 struct amdgpu_device;
 struct amdgpu_irq_src;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 11b7b4cffaae..ff360c699171 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -26,6 +26,7 @@
 #include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/firmware.h>
+#include <linux/reboot.h>
 #include "amd_shared.h"
 #include "amd_powerplay.h"
 #include "power_state.h"
@@ -91,6 +92,45 @@ static int pp_early_init(void *handle)
 	return 0;
 }
 
+static void pp_swctf_delayed_work_handler(struct work_struct *work)
+{
+	struct pp_hwmgr *hwmgr =
+		container_of(work, struct pp_hwmgr, swctf_delayed_work.work);
+	struct amdgpu_device *adev = hwmgr->adev;
+	struct amdgpu_dpm_thermal *range =
+				&adev->pm.dpm.thermal;
+	uint32_t gpu_temperature, size;
+	int ret;
+
+	/*
+	 * If the hotspot/edge temperature is confirmed as below SW CTF setting point
+	 * after the delay enforced, nothing will be done.
+	 * Otherwise, a graceful shutdown will be performed to prevent further damage.
+	 */
+	if (range->sw_ctf_threshold &&
+	    hwmgr->hwmgr_func->read_sensor) {
+		ret = hwmgr->hwmgr_func->read_sensor(hwmgr,
+						     AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
+						     &gpu_temperature,
+						     &size);
+		/*
+		 * For some legacy ASICs, hotspot temperature retrieving might be not
+		 * supported. Check the edge temperature instead then.
+		 */
+		if (ret == -EOPNOTSUPP)
+			ret = hwmgr->hwmgr_func->read_sensor(hwmgr,
+							     AMDGPU_PP_SENSOR_EDGE_TEMP,
+							     &gpu_temperature,
+							     &size);
+		if (!ret && gpu_temperature / 1000 < range->sw_ctf_threshold)
+			return;
+	}
+
+	dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
+	dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
+	orderly_poweroff(true);
+}
+
 static int pp_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = handle;
@@ -101,6 +141,10 @@ static int pp_sw_init(void *handle)
 
 	pr_debug("powerplay sw init %s\n", ret ? "failed" : "successfully");
 
+	if (!ret)
+		INIT_DELAYED_WORK(&hwmgr->swctf_delayed_work,
+				  pp_swctf_delayed_work_handler);
+
 	return ret;
 }
 
@@ -135,6 +179,8 @@ static int pp_hw_fini(void *handle)
 	struct amdgpu_device *adev = handle;
 	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
 
+	cancel_delayed_work_sync(&hwmgr->swctf_delayed_work);
+
 	hwmgr_hw_fini(hwmgr);
 
 	return 0;
@@ -221,6 +267,8 @@ static int pp_suspend(void *handle)
 	struct amdgpu_device *adev = handle;
 	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
 
+	cancel_delayed_work_sync(&hwmgr->swctf_delayed_work);
+
 	return hwmgr_suspend(hwmgr);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
index bfe80ac0ad8c..d0b1ab6c4523 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
@@ -603,21 +603,17 @@ int phm_irq_process(struct amdgpu_device *adev,
 			   struct amdgpu_irq_src *source,
 			   struct amdgpu_iv_entry *entry)
 {
+	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
 	uint32_t client_id = entry->client_id;
 	uint32_t src_id = entry->src_id;
 
 	if (client_id == AMDGPU_IRQ_CLIENTID_LEGACY) {
 		if (src_id == VISLANDS30_IV_SRCID_CG_TSS_THERMAL_LOW_TO_HIGH) {
-			dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
-			/*
-			 * SW CTF just occurred.
-			 * Try to do a graceful shutdown to prevent further damage.
-			 */
-			dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
-			orderly_poweroff(true);
-		} else if (src_id == VISLANDS30_IV_SRCID_CG_TSS_THERMAL_HIGH_TO_LOW)
+			schedule_delayed_work(&hwmgr->swctf_delayed_work,
+					      msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
+		} else if (src_id == VISLANDS30_IV_SRCID_CG_TSS_THERMAL_HIGH_TO_LOW) {
 			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected!\n");
-		else if (src_id == VISLANDS30_IV_SRCID_GPIO_19) {
+		} else if (src_id == VISLANDS30_IV_SRCID_GPIO_19) {
 			dev_emerg(adev->dev, "ERROR: GPU HW Critical Temperature Fault(aka CTF) detected!\n");
 			/*
 			 * HW CTF just occurred. Shutdown to prevent further damage.
@@ -626,15 +622,10 @@ int phm_irq_process(struct amdgpu_device *adev,
 			orderly_poweroff(true);
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_THM) {
-		if (src_id == 0) {
-			dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
-			/*
-			 * SW CTF just occurred.
-			 * Try to do a graceful shutdown to prevent further damage.
-			 */
-			dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
-			orderly_poweroff(true);
-		} else
+		if (src_id == 0)
+			schedule_delayed_work(&hwmgr->swctf_delayed_work,
+					      msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
+		else
 			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected!\n");
 	} else if (client_id == SOC15_IH_CLIENTID_ROM_SMUIO) {
 		dev_emerg(adev->dev, "ERROR: GPU HW Critical Temperature Fault(aka CTF) detected!\n");
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index f1580a26a850..612d66aeaab9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -811,6 +811,8 @@ struct pp_hwmgr {
 	bool gfxoff_state_changed_by_workload;
 	uint32_t pstate_sclk_peak;
 	uint32_t pstate_mclk_peak;
+
+	struct delayed_work swctf_delayed_work;
 };
 
 int hwmgr_early_init(struct pp_hwmgr *hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2aecb8faf407..4062b9b46986 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -24,6 +24,7 @@
 
 #include <linux/firmware.h>
 #include <linux/pci.h>
+#include <linux/reboot.h>
 
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
@@ -1078,6 +1079,34 @@ static void smu_interrupt_work_fn(struct work_struct *work)
 		smu->ppt_funcs->interrupt_work(smu);
 }
 
+static void smu_swctf_delayed_work_handler(struct work_struct *work)
+{
+	struct smu_context *smu =
+		container_of(work, struct smu_context, swctf_delayed_work.work);
+	struct smu_temperature_range *range =
+				&smu->thermal_range;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t hotspot_tmp, size;
+
+	/*
+	 * If the hotspot temperature is confirmed as below SW CTF setting point
+	 * after the delay enforced, nothing will be done.
+	 * Otherwise, a graceful shutdown will be performed to prevent further damage.
+	 */
+	if (range->software_shutdown_temp &&
+	    smu->ppt_funcs->read_sensor &&
+	    !smu->ppt_funcs->read_sensor(smu,
+					 AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
+					 &hotspot_tmp,
+					 &size) &&
+	    hotspot_tmp / 1000 < range->software_shutdown_temp)
+		return;
+
+	dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
+	dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
+	orderly_poweroff(true);
+}
+
 static int smu_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1120,6 +1149,9 @@ static int smu_sw_init(void *handle)
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 	smu->smu_dpm.requested_dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 
+	INIT_DELAYED_WORK(&smu->swctf_delayed_work,
+			  smu_swctf_delayed_work_handler);
+
 	ret = smu_smc_table_sw_init(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to sw init smc table!\n");
@@ -1600,6 +1632,8 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
 		return ret;
 	}
 
+	cancel_delayed_work_sync(&smu->swctf_delayed_work);
+
 	ret = smu_disable_dpms(smu);
 	if (ret) {
 		dev_err(adev->dev, "Fail to disable dpm features!\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 4ce394903c07..18101ec0ae6e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -573,6 +573,8 @@ struct smu_context
 	u32 debug_param_reg;
 	u32 debug_msg_reg;
 	u32 debug_resp_reg;
+
+	struct delayed_work		swctf_delayed_work;
 };
 
 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index e1ef88ee1ed3..aa4a5498a12f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1412,13 +1412,8 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 	if (client_id == SOC15_IH_CLIENTID_THM) {
 		switch (src_id) {
 		case THM_11_0__SRCID__THM_DIG_THERM_L2H:
-			dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
-			/*
-			 * SW CTF just occurred.
-			 * Try to do a graceful shutdown to prevent further damage.
-			 */
-			dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
-			orderly_poweroff(true);
+			schedule_delayed_work(&smu->swctf_delayed_work,
+					      msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
 		break;
 		case THM_11_0__SRCID__THM_DIG_THERM_H2L:
 			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 9e8414037638..4071bfa38727 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1353,13 +1353,8 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 	if (client_id == SOC15_IH_CLIENTID_THM) {
 		switch (src_id) {
 		case THM_11_0__SRCID__THM_DIG_THERM_L2H:
-			dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
-			/*
-			 * SW CTF just occurred.
-			 * Try to do a graceful shutdown to prevent further damage.
-			 */
-			dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
-			orderly_poweroff(true);
+			schedule_delayed_work(&smu->swctf_delayed_work,
+					      msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
 			break;
 		case THM_11_0__SRCID__THM_DIG_THERM_H2L:
 			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected\n");
-- 
2.34.1

