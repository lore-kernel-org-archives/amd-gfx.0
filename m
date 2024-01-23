Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5ADC47DDB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 08:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D3D10E6B4;
	Tue, 23 Jan 2024 08:17:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5667C10E6B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 08:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQX0hxm87b8ejcsVwvTK+RpQ64B5/a82rwYv3GN0tbU4n+F75R5A1prD27R+Lc7lPF/jQ2Ry093IrTaEz+4v4bAwJsyTxS0qvl16xd1wZYvocGwo5tbP9kt1jtcLip0NIktYeRTM0uega1+lVJ2CqzZ13mmY9VIkPWejHusRHPBuze3qOv80EYWPVWlQCRO97I3EkU/MjRQ+OgkFPVVftorMZZ7QV1B7CZExiMg6H9rnG6tYi9Lb/4O2Nl724boI/v8qeTZlPT+FHtpRemt/hpkI/lmNDTLStRXKBOX5XV4NxhOMvq2fUyQCN/4pi1+U3b3pq/8nY5IRMpVVWHCu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhONeiUQOr+8cs6LNyaiI1wlaL6S1/AitPvdt1lFjTA=;
 b=h5vgPqVM9sM8TlguNxVv7U6U+5bC/lvSVuNop5wnlFPtpklTGy9R+GVP7rJ9bTl63klWBB16qQSdkDac2s/kVtcnrwLv0h5muAFGnkmFYxPFEmsWOQ31L2to36TLPOHJggOE0b9z7p3LtHIkrL5OeeA6pLsOAmTIJsiuxqQ5KeKiLbt3bAFq9Y/RYAO1+VJRuG+PpH23elxB8Hf0SSY/0sePFmcdMddPHKcoPCfjG9EybcwjDdrGfvB+eME82D2ms8ixv+q0kmLlcn5OZAE3Dv/KY2kmBhs7FXSDtNtkiFs4i3nEwTuAE3XY1XEaO7X/cKrPyby101aBI6Zx/QppFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhONeiUQOr+8cs6LNyaiI1wlaL6S1/AitPvdt1lFjTA=;
 b=DsNjow8oD3fxWelr11KN7xrWo6B4soXfZYIlqFrvJYi8ui0uSjW8jFYUjFjzSjygRhQ3khHlJvJT0l0E9RYcREwkCX1suiyWeCz+c/iITq498pyDshlry14k7aJmU0BkX3NMrfupV3YDhgFfgFMB4hXoRePsXkPZOZXAR19ndT4=
Received: from BL1PR13CA0438.namprd13.prod.outlook.com (2603:10b6:208:2c3::23)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 08:17:07 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::1d) by BL1PR13CA0438.outlook.office365.com
 (2603:10b6:208:2c3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Tue, 23 Jan 2024 08:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 08:17:06 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 02:16:37 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdgpu/pm: Use macro definitions in the smu IH
 process function
Date: Tue, 23 Jan 2024 16:13:26 +0800
Message-ID: <20240123081326.1066121-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123081326.1066121-1-Jun.Ma2@amd.com>
References: <20240123081326.1066121-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: dac61126-05de-4524-13e5-08dc1bebb059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WjNgz4kK/SXaj8KAu9/nlu8H44Ncas0HRa4qmQJLqTufStqG2Oy3iCH/kULTLBQI3H/H562GhIxwdQtciBnpWZS6b1xgk4MykuwfakKUrcgBfBur1cXAF55TcoskHMlg3GXIFbVxs6oQi2vjTCKrxNPedMV7vj6jUyPDP+MHm+67R28A+tzmocDYjYco7GV+AcxpgRiggegq1pSkx6IWpzFo/5ge4ITia7W3ia8e9V/4vdrbEN5VFQumI8Q3+KbAnOBlev3xK7UrkQZGHsGC3DDVrXy+coAGh9nhgO2If6PKIonEl0paJ737hrJpc2OqJxzCpoMJCanmMtPJmx6WXVQtUB8PnKoUKRnwQAx6VMzgba3aZZMMHI3KKFsZSk/7cdd0rhmxb4nNV2R6xAWEhhSxpkppRJ32n4cvviTfVAQhY8DLnfOHC3JxUSihiPk6mJFa/b+zusDct/FlxsrUxJjEzNbFbA6QT1b8oWSaBDTIUu2SHRgykMA/wh4u+BU0w9Z3HvnL0fxmOGdY6fALkeK0nXS1kg5f1t29N8rRnQK8dy1NnPTE9iW0l2K/Svuzjg5MiA1DYTzKRvjOpr2sMI45EpUe/JbFSIrLy0JiG47Wgi13r+96b12BWgJMZ9P9W8i6YsCWorDXFAna/E3jPRR4Z35RPdl0xLI3TBGBcMmu0WKIwyjL0OYEZHLSK09o6Gaa/HOuxP4nizFClrwRFq7zJhcFCBek6EFKaQv25GAkGXOmzuMoV4esIF3jsusSWicWtW2S7pvMTb5epVeYwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40470700004)(83380400001)(336012)(47076005)(426003)(16526019)(2616005)(1076003)(26005)(81166007)(82740400003)(36860700001)(8676002)(5660300002)(8936002)(2906002)(478600001)(7696005)(70206006)(6666004)(54906003)(6916009)(70586007)(316002)(4326008)(41300700001)(356005)(36756003)(86362001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 08:17:06.9191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dac61126-05de-4524-13e5-08dc1bebb059
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835
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

Replace the hard-coded numbers with macro definition

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h | 11 -----------
 .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h |  4 ----
 .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h | 11 -----------
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 10 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     | 14 +++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             | 10 ++++++++++
 7 files changed, 23 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index b114d14fc053..91229b2dadb5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -1618,15 +1618,4 @@ typedef struct {
 #define TABLE_WIFIBAND                12
 #define TABLE_COUNT                   13
 
-//IH Interupt ID
-#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
-#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
-#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
-#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
-#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
-#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
-#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
-#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
-#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
-
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
index ced348d2e8bb..957b177414a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
@@ -209,10 +209,6 @@ typedef struct {
   float    minPsmVoltage[30];
 } AvfsDebugTableXcd_t;
 
-// Defines used for IH-based thermal interrupts to GFX driver - A/X only
-#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
-#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
-
 //thermal over-temp mask defines for IH interrupt to host
 #define THROTTLER_PROCHOT_BIT           0
 #define THROTTLER_PPT_BIT               1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
index 8b1496f8ce58..33937c1d984f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
@@ -1608,15 +1608,4 @@ typedef struct {
 #define TABLE_WIFIBAND                12
 #define TABLE_COUNT                   13
 
-//IH Interupt ID
-#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
-#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
-#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
-#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
-#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
-#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
-#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
-#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
-#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
-
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index fbeb31bf9e48..ddf435cdddfa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1432,24 +1432,24 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 		dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
 		orderly_poweroff(true);
 	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
-		if (src_id == 0xfe) {
+		if (src_id == IH_INTERRUPT_ID_TO_DRIVER) {
 			/* ACK SMUToHost interrupt */
 			data = RREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL);
 			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
 			WREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL, data);
 
 			switch (ctxid) {
-			case 0x3:
+			case IH_INTERRUPT_CONTEXT_ID_AC:
 				dev_dbg(adev->dev, "Switched to AC mode!\n");
 				schedule_work(&smu->interrupt_work);
 				adev->pm.ac_power = true;
 				break;
-			case 0x4:
+			case IH_INTERRUPT_CONTEXT_ID_DC:
 				dev_dbg(adev->dev, "Switched to DC mode!\n");
 				schedule_work(&smu->interrupt_work);
 				adev->pm.ac_power = false;
 				break;
-			case 0x7:
+			case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
 				/*
 				 * Increment the throttle interrupt counter
 				 */
@@ -1508,7 +1508,7 @@ int smu_v11_0_register_irq_handler(struct smu_context *smu)
 		return ret;
 
 	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				0xfe,
+				IH_INTERRUPT_ID_TO_DRIVER,
 				irq_src);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1db74c0b5257..9277c5dff5e4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1368,24 +1368,24 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 		dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
 		orderly_poweroff(true);
 	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
-		if (src_id == 0xfe) {
+		if (src_id == IH_INTERRUPT_ID_TO_DRIVER) {
 			/* ACK SMUToHost interrupt */
 			data = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
 			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
 			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, data);
 
 			switch (ctxid) {
-			case 0x3:
+			case IH_INTERRUPT_CONTEXT_ID_AC:
 				dev_dbg(adev->dev, "Switched to AC mode!\n");
 				smu_v13_0_ack_ac_dc_interrupt(smu);
 				adev->pm.ac_power = true;
 				break;
-			case 0x4:
+			case IH_INTERRUPT_CONTEXT_ID_DC:
 				dev_dbg(adev->dev, "Switched to DC mode!\n");
 				smu_v13_0_ack_ac_dc_interrupt(smu);
 				adev->pm.ac_power = false;
 				break;
-			case 0x7:
+			case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
 				/*
 				 * Increment the throttle interrupt counter
 				 */
@@ -1398,7 +1398,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 					schedule_work(&smu->throttling_logging_work);
 
 				break;
-			case 0x8:
+			case IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL:
 				high = smu->thermal_range.software_shutdown_temp +
 					smu->thermal_range.software_shutdown_temp_offset;
 				high = min_t(typeof(high),
@@ -1415,7 +1415,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 				data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
 				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
 				break;
-			case 0x9:
+			case IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY:
 				high = min_t(typeof(high),
 					     SMU_THERMAL_MAXIMUM_ALERT_TEMP,
 					     smu->thermal_range.software_shutdown_temp);
@@ -1476,7 +1476,7 @@ int smu_v13_0_register_irq_handler(struct smu_context *smu)
 		return ret;
 
 	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				0xfe,
+				IH_INTERRUPT_ID_TO_DRIVER,
 				irq_src);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 4894f7ee737b..9a8b7fd6995d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -892,7 +892,7 @@ int smu_v14_0_register_irq_handler(struct smu_context *smu)
 	// TODO: THM related
 
 	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				0xfe,
+				IH_INTERRUPT_ID_TO_DRIVER,
 				irq_src);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index cc590e27d88a..9d5d1afe4137 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -30,6 +30,16 @@
 #define FDO_PWM_MODE_STATIC  1
 #define FDO_PWM_MODE_STATIC_RPM 5
 
+#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
+#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
+#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
+#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
+#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
+#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
+#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
+#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
+#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
+
 extern const int link_speed[];
 
 /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */
-- 
2.34.1

