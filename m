Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F8DC47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 08:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E668210EB05;
	Thu, 25 Jan 2024 08:51:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CE5A10EB05
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 08:50:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYrpxDefTl5o91wPfhjQcRoYWWUC7R4M4nixxXJpbaMMArnjFC63aTbNr/aGh/v1wxQpvMLpYzzVxHWhC0ktFQ1aE6GE+9f0Ee9XcNLWu+FzWDCKKZZMVbghh2b8RJK85XvxpCHfySRoV9/5QYuRoC8SYqpLfVdR4xfSNy87fUj97/D2DXV3YVJVywE8mv+7JOwusfKRhGQn/oaChaRibx/3pmKjN70fQPLTSRMgYFJlxdnm/Ip4yb2FdRgKy+Bmq3CC6KSbh6BKqk/fabW72ilwZDP2KZUxd/Dq/iKubhuM9AcFk6QMvr4W8mOTapFBRv0eDt/1f6YBAqEW4DJmpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX3fPiSXdzzbVguQHYfQ0UBsWS/JY7jxipwHoxhnTfc=;
 b=ckwSwO2Ras4qGAsmTVDJhb1bHjnQuy5v4syX89x/bFfgi37L4Wb/UU18oHyeFrR1C78+JkvpQsihijK2+vo4nFbYweh6KKh3aM71yZPWiG7zL/av5RU7xWU24LqkP0AHka+Fo3j9UjyYEej8qg7nRTmOb76J3ylXDq9PepLUN5BCOrsDu/RM5DYD57v0aayyL0WnAxpw4jTBlAJ31WTmXEgnmYPAZ5S8zzC/fA8aJQFxhgsZ3yYHkzSk3uDn6vljzHDkFx6ks8FoqX085+pyowF0XO/ijUT7PdbMCxRZEg3iWvdx0hXw1tfls8OOaHhhxP4/PVlK2XckI+9kbiUEzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX3fPiSXdzzbVguQHYfQ0UBsWS/JY7jxipwHoxhnTfc=;
 b=oYdphFRdZR7xNI0Z0EATPJYFfbmlN2hl9WpWH26lR14K38/Mll1K6mRhtncJgUbBQ38o2ZrZwBq9qZCilPBLhDKPZOHHCWAAaEtPDVHFYNADE2FRKLnacTl5IlE0jQxJJYWwm7AG9B7gn2/SNjekZzvpRj/NhTBCZtiXNtyf6tw=
Received: from MN2PR05CA0018.namprd05.prod.outlook.com (2603:10b6:208:c0::31)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 08:50:43 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::5c) by MN2PR05CA0018.outlook.office365.com
 (2603:10b6:208:c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Thu, 25 Jan 2024 08:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 08:50:42 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 02:50:40 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu/pm: Use macro definitions in the smu IH process
 function
Date: Thu, 25 Jan 2024 16:50:18 +0800
Message-ID: <20240125085018.1119071-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 009d9210-0033-4a9d-ccc1-08dc1d82b6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LAKaCoAq3r0rgKqfjBl/JzwJWQ1s+sUQtBu6R/Ov/LXHVlJGNEB/hFGq5GEa84iHbVYKh9llHTxTCNnJNWa3zbBgqdtdVvxqH3yjpcnF6esPj83hn8HgdTatHFMTYWK9C1jvVfMYVVv8FWPB0EofctWdMK1ls8MmVftLSN2Q2wjAPP+dXA88jf3dfcwUpxK7vFGseVCpTIxIWo4wDmBEOd2m6ZgvNbPTfB+RU+eBhOy82GKQ53Pe50O5AAMXEsH/3/Aya2CyacgZwdbR/yBnK+RsZn5hZoeWyAQRnBzF1r/nRAQLuxonngntWiCYFf+KctH/jaC7xnBRrnAgYQ2XDrU48IlH/EJiABdl3kOW2x/jTykm4DGqhXk9h4Gc8xdrk7q1d4ijEfV8JkUhvJjPz/9NQUrvchuR0ZrCHoIW0Zr4JpT6gQXam8Ya80mh6C9KVRdtO2VF04eu6vMUTrPfTp/MpIe3IUYgsuSGHjMmaX9CMXezgBeLudCw88DXre09bYlNR7rBrv8PGZwXSZoMpTSw89zrFTQg2ByAZg2/sHCu8gCdQs+Bt2Zhakfmgk/LDevIFI4schNgznOvtfdrSHvh9skIVmQOGDKecLqZxnNv3tknlJtIeVl35mXYT57/T4w96GCYvwCIzmzrdRF7/7177E9VXno0PJ1T7p5s8ndfQMY3Aymtp8+PeEkhQdZf85oJL27+wSnoXx7zdJhmPSTd0mIdBCgi1xutwck2a5uaN/B4sF2HvBaWmwz5T36LY7xgAUt/sEX0+MPoeGkmqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(36840700001)(40470700004)(46966006)(16526019)(26005)(36860700001)(426003)(336012)(7696005)(36756003)(6666004)(8676002)(2616005)(41300700001)(70206006)(478600001)(70586007)(316002)(4326008)(54906003)(6916009)(8936002)(82740400003)(5660300002)(86362001)(2906002)(81166007)(356005)(1076003)(40460700003)(83380400001)(40480700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 08:50:42.6572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 009d9210-0033-4a9d-ccc1-08dc1d82b6a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
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
v3:
- Add new SMU_IH_INTERRUPT_* macros for smu, keeping the original
macro definitions in sync with pmfw (kevin)
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 10 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 14 +++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h         | 10 ++++++++++
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index fbeb31bf9e48..f6545093bfc1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1432,24 +1432,24 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 		dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
 		orderly_poweroff(true);
 	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
-		if (src_id == 0xfe) {
+		if (src_id == SMU_IH_INTERRUPT_ID_TO_DRIVER) {
 			/* ACK SMUToHost interrupt */
 			data = RREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL);
 			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
 			WREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL, data);
 
 			switch (ctxid) {
-			case 0x3:
+			case SMU_IH_INTERRUPT_CONTEXT_ID_AC:
 				dev_dbg(adev->dev, "Switched to AC mode!\n");
 				schedule_work(&smu->interrupt_work);
 				adev->pm.ac_power = true;
 				break;
-			case 0x4:
+			case SMU_IH_INTERRUPT_CONTEXT_ID_DC:
 				dev_dbg(adev->dev, "Switched to DC mode!\n");
 				schedule_work(&smu->interrupt_work);
 				adev->pm.ac_power = false;
 				break;
-			case 0x7:
+			case SMU_IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
 				/*
 				 * Increment the throttle interrupt counter
 				 */
@@ -1508,7 +1508,7 @@ int smu_v11_0_register_irq_handler(struct smu_context *smu)
 		return ret;
 
 	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				0xfe,
+				SMU_IH_INTERRUPT_ID_TO_DRIVER,
 				irq_src);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1db74c0b5257..c13364830500 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1368,24 +1368,24 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 		dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
 		orderly_poweroff(true);
 	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
-		if (src_id == 0xfe) {
+		if (src_id == SMU_IH_INTERRUPT_ID_TO_DRIVER) {
 			/* ACK SMUToHost interrupt */
 			data = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
 			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
 			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, data);
 
 			switch (ctxid) {
-			case 0x3:
+			case SMU_IH_INTERRUPT_CONTEXT_ID_AC:
 				dev_dbg(adev->dev, "Switched to AC mode!\n");
 				smu_v13_0_ack_ac_dc_interrupt(smu);
 				adev->pm.ac_power = true;
 				break;
-			case 0x4:
+			case SMU_IH_INTERRUPT_CONTEXT_ID_DC:
 				dev_dbg(adev->dev, "Switched to DC mode!\n");
 				smu_v13_0_ack_ac_dc_interrupt(smu);
 				adev->pm.ac_power = false;
 				break;
-			case 0x7:
+			case SMU_IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
 				/*
 				 * Increment the throttle interrupt counter
 				 */
@@ -1398,7 +1398,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 					schedule_work(&smu->throttling_logging_work);
 
 				break;
-			case 0x8:
+			case SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL:
 				high = smu->thermal_range.software_shutdown_temp +
 					smu->thermal_range.software_shutdown_temp_offset;
 				high = min_t(typeof(high),
@@ -1415,7 +1415,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 				data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
 				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
 				break;
-			case 0x9:
+			case SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY:
 				high = min_t(typeof(high),
 					     SMU_THERMAL_MAXIMUM_ALERT_TEMP,
 					     smu->thermal_range.software_shutdown_temp);
@@ -1476,7 +1476,7 @@ int smu_v13_0_register_irq_handler(struct smu_context *smu)
 		return ret;
 
 	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				0xfe,
+				SMU_IH_INTERRUPT_ID_TO_DRIVER,
 				irq_src);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 4894f7ee737b..2aa7e9945a0b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -892,7 +892,7 @@ int smu_v14_0_register_irq_handler(struct smu_context *smu)
 	// TODO: THM related
 
 	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				0xfe,
+				SMU_IH_INTERRUPT_ID_TO_DRIVER,
 				irq_src);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index cc590e27d88a..81bfce1406e5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -30,6 +30,16 @@
 #define FDO_PWM_MODE_STATIC  1
 #define FDO_PWM_MODE_STATIC_RPM 5
 
+#define SMU_IH_INTERRUPT_ID_TO_DRIVER                   0xFE
+#define SMU_IH_INTERRUPT_CONTEXT_ID_BACO                0x2
+#define SMU_IH_INTERRUPT_CONTEXT_ID_AC                  0x3
+#define SMU_IH_INTERRUPT_CONTEXT_ID_DC                  0x4
+#define SMU_IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
+#define SMU_IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
+#define SMU_IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
+#define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
+#define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
+
 extern const int link_speed[];
 
 /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */
-- 
2.34.1

