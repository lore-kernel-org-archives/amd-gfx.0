Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B1BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 18:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7090D10F263;
	Fri, 17 Dec 2021 18:18:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A9D310F263
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 18:18:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTQZm8NH7d7L69ysXLmuB3Gnwt8+M+b6g6qUpo6V+C2n23mgJD6IWGjAFME5ybrUFqjSo2nRTLeEaIm084AVI7gRe4kuJQilFUL2tPc5rKK38bHJvWPW/khLHc8m/75lTrIRV4SaubdMKW+yc/s2miJj9LwgOfuQttZ1BjSn3ueLFdlROCwxTd2Ab0T/kVVRSwE+6htKHae3DDdlqnG2xWt8RcWXgV3oxupDox5taOn5B2OCO0aCC34/lOPDFqtYBRnjczrRgNoOHhb7V7ikI6MObDVKC+zzIuigc4VdekMC632Zpw0TzscRUkfHrP9zJsj/x7BzsbfbmolA300ckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz9gPt8/JZPw0LFZssnoF7ffvTP51xpZjSxXA6qoNmM=;
 b=cPVQd22Uw9O98jsMcx/sfDvpbDBqtFOvl5szSzpnwPpSoLcX4Ss4aDw0+vxnUC6eOTsXqplnOXHBEqF4CPaiM1azhzyMdfDmJbb7X8/82qaZu2lkd6EJgGCk/OV/FsNnSNI3YO5r7aElqk4l6V1EV41OW54bpOqzplNZKSldgLNicPAdKP7Lc7X5V1Kqua33WF8+JFvjhIPU1TaTXzLwDdTwHIL2ietrqxcg0fsukFBco6RzmT7lwR8A1HYZFOiH/lHUITB3+4CJZB9G6Aq97X9Yg7zBe2OY7h6OdySbil3PQM9bfe6HMGyfuYjs54Yt2OepUoyxaQODXvq61Z+VFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz9gPt8/JZPw0LFZssnoF7ffvTP51xpZjSxXA6qoNmM=;
 b=G+uTgNiRBuuI/wSd4cRevI5cBRa5y7VEQrfodzQOPWMRvC5q4E5NPWCI6YIz/Uk1SBGR4MGPye9eMNE+1/HMwoG4jckXn61QYQ93eHXpbjHl1SKikM/jwrSGnUjykpEjXIXyqP7oyvEYNlxKEZF2KdT16TktnO7pNz+ctR5jpiU=
Received: from DM6PR03CA0084.namprd03.prod.outlook.com (2603:10b6:5:333::17)
 by DM6PR12MB3866.namprd12.prod.outlook.com (2603:10b6:5:1c6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 18:18:55 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::4b) by DM6PR03CA0084.outlook.office365.com
 (2603:10b6:5:333::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 18:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 18:18:55 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 12:18:53 -0600
From: sashank saye <sashank.saye@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough for
 sbr handling
Date: Fri, 17 Dec 2021 13:18:33 -0500
Message-ID: <20211217181833.203229-1-sashank.saye@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e40e4934-8093-4e2e-bb9d-08d9c189afb7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3866:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB386668097F18B3E5596A532190789@DM6PR12MB3866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dUJaOGph2SQGhqju2f7KbTDS621QhU8kjCMRovhPh06vdrcnhd3Nhdzo94rJPtl35yKreODcNvbrEV3+bI32CDDvBooueAvHrYaXoXfwMRQFzEj+Vwh17CFES3OETxBKGtef3wf9ZfbBrEjcFoW0GAvjgY5geV4Nq5h63tg3wL6X9O3dOdEL0pCaNP+0Q0/6yNZCIQfZoGNppUnbkUfM+WEpjzv4lBlK6ZmADC7lnjtEssDXAoJ2dyEKGoJaOjco3hrX24kkfumNfp1E8dmEBtVsAGKes+S9Xp2Kuqpqaq8M2pR5AeJDDUlGiy2b9zgGiz/f7CLV4JoHVRmNgG8byQLHXAs+dg/6tfO/9Ij3CSOXgzMREwHY7XHmEpFXwqgYPTJKlh51ePUfwyaDaeWrGjN/Qdgg/vIaGhb9YUtv9CL9o2v6KJZ2TzZtZm2+lImvdmh7g46BRNPVfuCXOPofYl77d8eHu85JHi0pgGLFIgfCALbk1NP2PWufyXvpUsnZCKeStiqpWKRndrw/ABxoBuRMV4KJo0Gc87iHRplMw4tdcglxv/fSlT+Xe+ZVSAiMy4UjBHUY6e/QaSNXpXLsb071iI82XiXCsUpxt8jQ0qoAyyz22fij4nwv1mhZ0k+4gkiTqKbPnX4cC1on0p0vyaugNgq092JxK8EX9Jm5JSKLmiHHUCEocx2V1bbyno6q7xJ67UycgeLKO8UYBF2Nit9CbgYW5R5hpgh4DK8UsmgCMECfc6mgNJfuSJidxcbzWSLyFAPk9pJ0V/Wy2PwqUryMBt6Czzh3nMNYjpkWVO0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(16526019)(316002)(1076003)(8676002)(26005)(6666004)(15650500001)(86362001)(6916009)(36756003)(8936002)(7696005)(81166007)(82310400004)(356005)(2616005)(47076005)(2906002)(508600001)(83380400001)(40460700001)(426003)(4326008)(70586007)(36860700001)(70206006)(5660300002)(336012)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 18:18:55.1322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e40e4934-8093-4e2e-bb9d-08d9c189afb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3866
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  9 ++++-----
 drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h       |  4 +++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            |  6 +++---
 drivers/gpu/drm/amd/pm/inc/smu_types.h             |  3 ++-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h             |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  6 +++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 10 ++++++++++
 9 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f31caec669e7..0c292e119f7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2618,11 +2618,10 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 	if (r)
 		DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
 
-	/* For XGMI + passthrough configuration on arcturus, enable light SBR */
-	if (adev->asic_type == CHIP_ARCTURUS &&
-	    amdgpu_passthrough(adev) &&
-	    adev->gmc.xgmi.num_physical_nodes > 1)
-		smu_set_light_sbr(&adev->smu, true);
+	/* For passthrough configuration on arcturus and aldebaran, enable special handling SBR */
+	if ((adev->asic_type == CHIP_ARCTURUS || adev->asic_type == CHIP_ALDEBARAN ) &&
+	    amdgpu_passthrough(adev))
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
index 7433a051e795..0e60d63ba94f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -141,6 +141,7 @@ static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_MAX_COUNT
 	MSG_MAP(SetUclkDpmMode,			     PPSMC_MSG_SetUclkDpmMode,			0),
 	MSG_MAP(GfxDriverResetRecovery,		     PPSMC_MSG_GfxDriverResetRecovery,		0),
 	MSG_MAP(BoardPowerCalibration,		     PPSMC_MSG_BoardPowerCalibration,		0),
+	MSG_MAP(HeavySBR,                            PPSMC_MSG_HeavySBR,                        0),
 };
 
 static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] = {
@@ -1912,6 +1913,14 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 	return ret;
 }
 
+static int aldebaran_smu_handle_passthrough_sbr(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+	ret =  smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_HeavySBR, enable ? 1 : 0, NULL);
+
+	return ret;
+}
+
 static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)
 {
 #if 0
@@ -2021,6 +2030,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.get_gpu_metrics = aldebaran_get_gpu_metrics,
 	.mode1_reset_is_support = aldebaran_is_mode1_reset_supported,
 	.mode2_reset_is_support = aldebaran_is_mode2_reset_supported,
+	.smu_handle_passthrough_sbr = aldebaran_smu_handle_passthrough_sbr,
 	.mode1_reset = aldebaran_mode1_reset,
 	.set_mp1_state = aldebaran_set_mp1_state,
 	.mode2_reset = aldebaran_mode2_reset,
-- 
2.25.1

