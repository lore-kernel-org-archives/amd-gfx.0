Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1007C77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 02:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B88E10E2CE;
	Tue, 16 May 2023 02:52:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12AB10E2CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 02:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAVIvCR3fACyAyqO8xVxY3QcdD3wCsyc7FCUMlvl9gi/MOQvvmVFQFU9hs24WRn/kpG0twetdV0o7AoPOOQtgD8SotVmC7EHWWwE5a8T1qgtv/3+4Ght7pXG95ZQDN44qB+ISzCNaL59WEnYPiG5HGLWtKP9zIgvLDc6wyM6OoV7gEPSRzPivYyb2EOPZhQpWsyIAro53E6mMQ6tr2Rx5hmSi+CeTmVaZf6xQQMl31rVned4rjVMR6J77+iNOFRRuNZNfoIpunWbhdVZe/4j6OXEnD+vNR8Lu7OEIQ91UoO51s9kYdPeD7vxOzP/mWv1mLxT4Het+X5C20aE/oaPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPg7iTcTcicfR8WbLSINxgkMz+fDx+xt/3wCbrMF1nE=;
 b=JItXt6wi/Y6bU5pzjWcnTuT+nIiJ4mInN7YvZ9NdmXAedBFsrXk9Le0m+TkrhikCy/FPeIB2HG9Zfm45fjMLBc3HUt0b1EZpFaD0mJeuTrI0eAtl+rpNaXnALTJZg+Q/o+l76swg9+/DfBAPYio2eoVj74z2TdTzQeVAFreJxWLxDWz5QETtbwaV4xCjITIyG58Q1zRu119XOKoNwdfBZCQy1KX/eImnBQcSZegAyC8OnWCGfdqfuXGyPY4H6gwB4YVCRW5XcH6qNUwWPzf4uw1FFOUkK0COctKJRhGH5A6OqPV86/a0d2kP7L6xDPu6u9tXfONTos70ctyaH7NOJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPg7iTcTcicfR8WbLSINxgkMz+fDx+xt/3wCbrMF1nE=;
 b=kSuEz5lLdN+V1E89c/dNF3BJBXAd8r2PxuavasDO4KoQ6QtOoraDzXtTbKNG2v2jDdwyoc3JOFzjpRy1bGmByHdygbx7ogDwyjLRQMcxp+UC9ZuWl5ev8DPwE0Jy2yrP45NVkULEE2UIXbAaiyMMzlT83SpVZBIOUzoDLy6IEtQ=
Received: from BN0PR04CA0106.namprd04.prod.outlook.com (2603:10b6:408:ec::21)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 02:51:56 +0000
Received: from BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec::4) by BN0PR04CA0106.outlook.office365.com
 (2603:10b6:408:ec::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 02:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT098.mail.protection.outlook.com (10.13.177.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 02:51:56 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 21:51:53 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: add delay to avoid unintened shutdown due to
 hotspot temperature spark
Date: Tue, 16 May 2023 10:51:05 +0800
Message-ID: <20230516025105.795595-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT098:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fccc5f3-0638-4a2c-f408-08db55b8830b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4c9DyzbCTpYIH+sqyixtH1MnyW0NLrXwd/IoZc6EDIUi+38sGan0xIHt4xVrVqKRpbtleFkbeAwbsa+SDui/HN80ysAonK22aYINe/1XcWYGCxczQsZwd0hk8BoGgjWGg7qCy3jCXs7jaX+eCTTDaJxq/7Lgr3TyFTLSKy33+F303rDxFGB4gZudMKAl2JJU9XoqqpDoEs4D1zKIGSUF1r4FDO9IS15wLiFEeGjxwSl1Pn6sy+ItCv0Wruq+21hCm6WHt9/WgE/ncYt/q/v1hGI2ywBsO6r3Q4Rs9lKmuXb0vwakRgkDMknMlakm7jrvAkQoSQsWeZYClqJpUkpg5UtRs8MVY80n31X8peCz3Tu1r3FBIBMwVsJlI2nEd1jB5JwJapA+YxXPP2lhEPXoeoPQdavz5WphFRr4C/TfQgYLmobfYUbYuYujtzxRj3viwPNtxe79YCdGSdQXUSHw+ZfAEJCCTS2Cz4Xa+QKiAldC1xHeTVnHa4fcpxH2gnFCaXk9K3S93KS6Su0LlxqQntNLu7JptSR8FM/lQK225drDLcxiD9oom9N18V7Xdb/MxjvEK/xAkh78A6FeshN+ps2XhblNwDce2+li/yqzvoUJy37/nmpkVNYk/IES56qt24cxz6y+MEvD50LbvQxbcY51vPkyZR2Xo+ZYKEofjG3J6Wu7NstlDk5fyl0cODWxBRPCm4C4DiitSJUK8l52rfJBcJMIKDyBER2vqzhu+bmDRnBbM5pBezUxNiF9rP2qr+AD5JrlLvPV8PrIyxZEsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(70206006)(4326008)(478600001)(6916009)(70586007)(54906003)(186003)(16526019)(40460700003)(83380400001)(426003)(2616005)(336012)(47076005)(36860700001)(36756003)(82310400005)(8936002)(8676002)(40480700001)(2906002)(44832011)(41300700001)(6666004)(7696005)(316002)(356005)(86362001)(81166007)(5660300002)(82740400003)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 02:51:56.3530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fccc5f3-0638-4a2c-f408-08db55b8830b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There will be a double check for the hotspot temperature on delay
expired. This can avoid unintended shutdown due to hotspot temperature
spark.

Signed-off-by: Evan Quan <evan.quan@amd.com>
--
v1->v2:
  - add the proper millidegree Celsius to degree Celsius transform
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 14 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 34 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  9 ++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  9 ++---
 6 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 39192eba3ff8..4cd873659365 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -243,6 +243,7 @@ extern int amdgpu_num_kcq;
 #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
 extern int amdgpu_vcnfw_log;
 extern int amdgpu_sg_display;
+extern uint amdgpu_ctf_delay;
 
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 749eeb9a2976..6c699fefdf92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -198,6 +198,7 @@ int amdgpu_smartshift_bias;
 int amdgpu_use_xgmi_p2p = 1;
 int amdgpu_vcnfw_log;
 int amdgpu_sg_display = -1; /* auto */
+uint amdgpu_ctf_delay = 50; /* in ms */
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -973,6 +974,19 @@ MODULE_PARM_DESC(smu_pptable_id,
 	"specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
 module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
 
+/**
+ * DOC: ctf_delay (uint)
+ * On SW CTF triggerred, to protect the chip from over-heated and possible damage, we usually
+ * trigger a system shutdown. However, considering there may be a hotspot temperature spark
+ * momentarily hitting the SW CTF setting point, a delay is added to avoid unintended shutdown.
+ * On the delay expired, the shutdown will be performed if the hotspot temp is still
+ * bigger than the SW CTF setting. Otherwise, nothing will be done.
+ * The default setting for the delay is 50ms.
+ */
+MODULE_PARM_DESC(ctf_delay,
+		"the delay(default 50ms) enforced before real action taken on ctf triggerred");
+module_param_named(ctf_delay, amdgpu_ctf_delay, uint, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3c860939031e..71153b335ad9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -24,6 +24,7 @@
 
 #include <linux/firmware.h>
 #include <linux/pci.h>
+#include <linux/reboot.h>
 
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
@@ -1070,6 +1071,34 @@ static void smu_interrupt_work_fn(struct work_struct *work)
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
+	if (smu->ppt_funcs->read_sensor &&
+	    !smu->ppt_funcs->read_sensor(smu,
+					 AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
+					 &hotspot_tmp,
+					 &size) &&
+	    range->software_shutdown_temp &&
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
@@ -1358,6 +1387,9 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
+	INIT_DELAYED_WORK(&smu->swctf_delayed_work,
+			  smu_swctf_delayed_work_handler);
+
 	ret = smu_enable_thermal_alert(smu);
 	if (ret) {
 	  dev_err(adev->dev, "Failed to enable thermal alert!\n");
@@ -1592,6 +1624,8 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
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
index e1ef88ee1ed3..4c3c682bf7a0 100644
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
+					      msecs_to_jiffies(amdgpu_ctf_delay));
 		break;
 		case THM_11_0__SRCID__THM_DIG_THERM_H2L:
 			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0bc0a6e97b5a..a5447119d5f5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1377,13 +1377,8 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
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
+					      msecs_to_jiffies(amdgpu_ctf_delay));
 			break;
 		case THM_11_0__SRCID__THM_DIG_THERM_H2L:
 			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected\n");
-- 
2.34.1

