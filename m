Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C8FC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 17:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55FD610E5A8;
	Fri, 17 Dec 2021 17:39:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF0A10E5D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 17:39:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OY/LE92UG9bygMfnvfufmCYfObz10KDRqBtfoZ1KF5BXoOF8K9wN8Y56oenKplP1mja2gl4J+MA4DU9HNV9mBNF6zSwkMhlg2NQmoqTco7V3GkdFFLuKE49iMDxlZI17W+VPtz+yaNbEUddjeFFGS0evs7mDxD8A3B1tVV3K10PCufj3ywatiQfFDE05JrYaD5h3p9etYn0v42XTGirRm6Odmw/yEmTRkujuNB+OAo1BcJs9caqheDn/b9g+qSY6X9Jo9paKGWzsmJq9y0PZcyLpVbMU6h08vcagvnDRtQ+px4OJXnZ4ae1YR1Gs9ymWhpnkaRDxVaRySaAaLUH/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viEzXAqiQXoCnjmfgMDuNg58kqTUio9su2mjFYUCI8w=;
 b=Vl32mDbflxm9mWz3AX3C3cNGeTMAvA0ngdNR984oH3NNesnjcSuoDUp8Cl7OqD082xHao3oexWy5FGFApkgHDsKySbPQ4FGOKHoBmKmu7YljHPmFIuPjU5EoOnjAomXEQuNKx04Ub3nueNo1EdFwjfVxSYkozatbM7ueP9jXCk5I3kQfUJUvGSUEDfLmLZgAGxEDJ00L68koZkIzEpRZD3RAcZ02SdY71Q8nNA/yKA763wutnrBX3yF+uevFhGJD7r+GAYgh90WAFh1/hepJCJG/X0mKJBOb0+RYe4lgxcwJSMTJNlRdxTLFlkiaaCbVZSvb/lmeelzL8Bb3/CPCIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viEzXAqiQXoCnjmfgMDuNg58kqTUio9su2mjFYUCI8w=;
 b=o+du+UFNRxBjXwLr8dQNKzMBvTYMtSEI7UpF7ZH28dIhDddjvMq2fVWO4/aX3XQ3PQNV9fKY94Zn0txLNEJhNI8ZMY2xTLkSOicEX7D87lSYvXR9ovxDdRx31dVzhO4bdf4IKZHK8EQtDnNaiC9N8DtawrGvdg0tphp9f/duUNE=
Received: from MWHPR11CA0026.namprd11.prod.outlook.com (2603:10b6:300:115::12)
 by BN8PR12MB4626.namprd12.prod.outlook.com (2603:10b6:408:72::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 17:39:34 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::df) by MWHPR11CA0026.outlook.office365.com
 (2603:10b6:300:115::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15 via Frontend
 Transport; Fri, 17 Dec 2021 17:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 17:39:34 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 11:39:33 -0600
From: sashank saye <sashank.saye@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough for
 sbr handling
Date: Fri, 17 Dec 2021 12:38:50 -0500
Message-ID: <20211217173850.198047-1-sashank.saye@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8b7bb4e-60fa-4bf0-e869-08d9c184309e
X-MS-TrafficTypeDiagnostic: BN8PR12MB4626:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB4626DE3228960CBD23222A1D90789@BN8PR12MB4626.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: URsulvN/Zc8BpVgH/8oDq0IegfxPX7WbG0ahgDQt6Hxs3lKiTPJC9og1L4hLcVrQeBxT5iL0HoBgk1BLYriDzm/UMkEMjvOOZJoWJriHZ9o5Zw6sQesIz+T0W5QHOWbTSaE7J92Liu2p8VUC8IOIaIxj11FTUX6jGn8+fSP/0v4+hUygWMN8AGBOEKP+eoshGmW/TDCAaySXfRMa5qIsNDhlU8+oQiF6m2kPp6Ca79je5PFKuBsnNG/Gm/i8wb55eECKYukqOGZI5mHz1Nue37jPqcHEUuFOrNDUyKxI1C2bRY9rEsGMeJfZKcr03tcNCGefT+B/MktMWZhVCcDa2SpZN9/uBK4nfe+J7WLpFWwcXBxq4LW3XuwR1y3Pv0JB15Vaw4KQgB8aBR3KsNhbok976yzGukg6t2+oRuERl2pPC2CkgWbD3FQPt3iL08U8tSrT7b/ldjB2o/mlEwJ59ft7Q/KLp4GaFISsO/mkcj4Xm094rx3ZATzC4q88AuTRR8qG1kmsPGJV2uKYEDzlidsw+fCLSWVs7VdRlC8hBEpuHUQLqs0mn41rJsoqOlzr1Pb1UXdT1VWsn4ywakv+Zv3uqaj8myPH8j+/GAw7p8r0qQJWTxFtTF9etz8cor0YM6tlY+ri1tlTS8TODvKN0ykiU2j5N+8qSUrbhmfI0QRGPnTsBa9a4dAEl/lkZMnjjzvYFRWZmpuQCF7kWG3Bz1VmizE18Io8jR6GbMKYB0Oevac8oSBepkGTSn74YNQqNDtyTVldreiv16+fLdvwqB0cnWyuPBhZHdMVV15shJk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(47076005)(316002)(508600001)(186003)(82310400004)(2906002)(81166007)(15650500001)(16526019)(36756003)(4326008)(2616005)(36860700001)(6666004)(26005)(6916009)(70206006)(86362001)(336012)(70586007)(1076003)(83380400001)(356005)(40460700001)(7696005)(8936002)(5660300002)(8676002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 17:39:34.3637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b7bb4e-60fa-4bf0-e869-08d9c184309e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4626
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
Cc: sashank saye <sashank.saye@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For Aldebaran chip passthrough case we need to intimate SMU
about special handling for SBR.On older chips we send
LightSBR to SMU, enabling the same for Aldebaran. Slight
difference, compared to previous chips, is on Aldebaran, SMU
would do a heavy reset on SBR. Hence, the word Heavy
instead of Light SBR is used for SMU to differentiate.

Signed-off-by: sashank saye <sashank.saye@amd.com>
Change-Id: I79420e7352bb670d6f9696df97d7546f131b18fc
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  6 +++---
 drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h       |  4 +++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            |  6 +++---
 drivers/gpu/drm/amd/pm/inc/smu_types.h             |  3 ++-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h             |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  6 +++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 11 +++++++++++
 9 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f31caec669e7..01b02701121e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2618,11 +2618,11 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 	if (r)
 		DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
 
-	/* For XGMI + passthrough configuration on arcturus, enable light SBR */
-	if (adev->asic_type == CHIP_ARCTURUS &&
+	/* For XGMI + passthrough configuration on arcturus and aldebaran, enable light SBR */
+	if ((adev->asic_type == CHIP_ARCTURUS || adev->asic_type == CHIP_ALDEBARAN ) &&
 	    amdgpu_passthrough(adev) &&
 	    adev->gmc.xgmi.num_physical_nodes > 1)
-		smu_set_light_sbr(&adev->smu, true);
+		smu_handle_passthrough_sbr(&adev->smu, true);
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
 		mutex_lock(&mgpu_info.mutex);
diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
index 35fa0d8e92dd..ab66a4b9e438 100644
--- a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
@@ -102,7 +102,9 @@
 
 #define PPSMC_MSG_GfxDriverResetRecovery	0x42
 #define PPSMC_MSG_BoardPowerCalibration 	0x43
-#define PPSMC_Message_Count			0x44
+#define PPSMC_MSG_HeavySBR                      0x45
+#define PPSMC_Message_Count			0x46
+
 
 //PPSMC Reset Types
 #define PPSMC_RESET_TYPE_WARM_RESET              0x00
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 2b9b9a7ba97a..ba7565bc8104 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1257,9 +1257,9 @@ struct pptable_funcs {
 	int (*set_fine_grain_gfx_freq_parameters)(struct smu_context *smu);
 
 	/**
-	 * @set_light_sbr:  Set light sbr mode for the SMU.
+	 * @smu_handle_passthrough_sbr:  Send message to SMU about special handling for SBR.
 	 */
-	int (*set_light_sbr)(struct smu_context *smu, bool enable);
+	int (*smu_handle_passthrough_sbr)(struct smu_context *smu, bool enable);
 
 	/**
 	 * @wait_for_event:  Wait for events from SMU.
@@ -1415,7 +1415,7 @@ int smu_allow_xgmi_power_down(struct smu_context *smu, bool en);
 
 int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
 
-int smu_set_light_sbr(struct smu_context *smu, bool enable);
+int smu_handle_passthrough_sbr(struct smu_context *smu, bool enable);
 
 int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
 		       uint64_t event_arg);
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 18b862a90fbe..ff8a0bcbd290 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -229,7 +229,8 @@
 	__SMU_DUMMY_MAP(BoardPowerCalibration),   \
 	__SMU_DUMMY_MAP(RequestGfxclk),           \
 	__SMU_DUMMY_MAP(ForceGfxVid),             \
-	__SMU_DUMMY_MAP(UnforceGfxVid),
+	__SMU_DUMMY_MAP(UnforceGfxVid),           \
+	__SMU_DUMMY_MAP(HeavySBR),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 2d422e6a9feb..acb3be292096 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -312,7 +312,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 void smu_v11_0_interrupt_work(struct smu_context *smu);
 
-int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable);
+int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool enable);
 
 int smu_v11_0_restore_user_od_settings(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index af98fa140d83..76f95e8ada4c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3058,13 +3058,13 @@ static int smu_gfx_state_change_set(void *handle,
 	return ret;
 }
 
-int smu_set_light_sbr(struct smu_context *smu, bool enable)
+int smu_handle_passthrough_sbr(struct smu_context *smu, bool enable)
 {
 	int ret = 0;
 
 	mutex_lock(&smu->mutex);
-	if (smu->ppt_funcs->set_light_sbr)
-		ret = smu->ppt_funcs->set_light_sbr(smu, enable);
+	if (smu->ppt_funcs->smu_handle_passthrough_sbr)
+		ret = smu->ppt_funcs->smu_handle_passthrough_sbr(smu, enable);
 	mutex_unlock(&smu->mutex);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 58bc387fb279..505d2fb94fd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2472,7 +2472,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.deep_sleep_control = smu_v11_0_deep_sleep_control,
 	.get_fan_parameters = arcturus_get_fan_parameters,
 	.interrupt_work = smu_v11_0_interrupt_work,
-	.set_light_sbr = smu_v11_0_set_light_sbr,
+	.smu_handle_passthrough_sbr = smu_v11_0_handle_passthrough_sbr,
 	.set_mp1_state = smu_cmn_set_mp1_state,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 28b7c0562b99..4e9e2cf39859 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1724,7 +1724,7 @@ int smu_v11_0_mode1_reset(struct smu_context *smu)
 	return ret;
 }
 
-int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable)
+int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool enable)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7433a051e795..2813ab2cc336 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -141,6 +141,7 @@ static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_MAX_COUNT
 	MSG_MAP(SetUclkDpmMode,			     PPSMC_MSG_SetUclkDpmMode,			0),
 	MSG_MAP(GfxDriverResetRecovery,		     PPSMC_MSG_GfxDriverResetRecovery,		0),
 	MSG_MAP(BoardPowerCalibration,		     PPSMC_MSG_BoardPowerCalibration,		0),
+	MSG_MAP(HeavySBR,                            PPSMC_MSG_HeavySBR,                        0),
 };
 
 static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] = {
@@ -1912,6 +1913,15 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 	return ret;
 }
 
+static int aldebaran_smu_handle_passthrough_sbr(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+	//For alderbarn chip, SMU would do a mode 1 reset as part of SBR hence we call it HeavySBR instead of light
+	ret =  smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_HeavySBR, enable ? 1 : 0, NULL);
+
+	return ret;
+}
+
 static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)
 {
 #if 0
@@ -2021,6 +2031,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.get_gpu_metrics = aldebaran_get_gpu_metrics,
 	.mode1_reset_is_support = aldebaran_is_mode1_reset_supported,
 	.mode2_reset_is_support = aldebaran_is_mode2_reset_supported,
+	.smu_handle_passthrough_sbr = aldebaran_smu_handle_passthrough_sbr,
 	.mode1_reset = aldebaran_mode1_reset,
 	.set_mp1_state = aldebaran_set_mp1_state,
 	.mode2_reset = aldebaran_mode2_reset,
-- 
2.25.1

