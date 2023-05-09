Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DADC7EE2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C14010E3FF;
	Tue,  9 May 2023 22:07:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0ABF10E3F6
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:07:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0+LlDFI/4iT8QTXCnIhHevR2WsLEY6qaxcIUnSO30mltMVs/0U4lS6quOnlizVe2zunp8g47mhY2z69Yzd/R/Lxj/0QonoUTVF6JDx7cyJEBpKe/+bNqVULN2YEhcYu1P7AFgt+Stv72Q5lfWaePOuRqidk2CC70SS8mgHNZVjknFHxJw9Vpe2aQlApxotWgsiR7YM8pJ+MA6My+F4r3Wxd5qdnbEfi4OrcL8Uyha7fbeSownrYPUldJwGmLrsiKI+NWJAGpjHpqwyG1TTI9FLBU779ecG6nqGtWBbQGN+M8DaAuPaSkVdu+Nuc9RsEHlOVIaWL3JLQLapH3ssbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usBxKOhG+Bsf3hoOwCUWSihNDIIM/NxVcOqdq3z0eXo=;
 b=lE3td/Clhmfli5+VsiflfAlKhBxfjtK143Q9Ma+UbshVYyqA/XZVxirHpwJ0GV/ioD/Rxxt1z0i4WN4uGkAdh+WdOQmiu50Nm+Tnc0t6eMrU8UnK2uGXFIRpvbO8lPmXHjJFFup04Wf4kObDgx+wU5Vw1palqbKOvoKLvd/fWoH9gV4Tm+4s2T/oYSBUqIxrdoALLdVSb/NTWIaXXwfeFlC0fCntVerhQ1EU/Pj2ebdHG6+sGgdvWlhj6fRQmpgwXhmmcnpRwHTQ7Enh59mf8Uevl9U8MsNIPMputRzLYey27c0a6dGlGse9NJYJLWJAtBiopbcXgxxYtpPeXkckkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usBxKOhG+Bsf3hoOwCUWSihNDIIM/NxVcOqdq3z0eXo=;
 b=r0bXRZtnhUWaQsgIO/THnetbptjLNorZ7nURqBKkcK/L51HfdlIy2PMMmSmQTxGJCAytyIK4jE5Jix/zjmVCrPuiN75bZ4Bow2xe+PISkhgs6nWPqgyqGQZnNhRWSAmxDZ+oY9D7R/+pdbOHEJZf1tdVMyOSAdW/Az5nlFJYtrg=
Received: from BN9PR03CA0422.namprd03.prod.outlook.com (2603:10b6:408:113::7)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.31; Tue, 9 May
 2023 22:07:29 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::2) by BN9PR03CA0422.outlook.office365.com
 (2603:10b6:408:113::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:07:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:07:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:07:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/12] drm/amd/pm: Keep interface version in PMFW header
Date: Tue, 9 May 2023 18:07:07 -0400
Message-ID: <20230509220714.475369-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220714.475369-1-alexander.deucher@amd.com>
References: <20230509220714.475369-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed2a7e4-870c-4f48-8989-08db50d9c7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FqzcOIPKSVDcShbsuzQ7HDzx84TbR5oudkIzHdJE4vBKtdNegY2vCwFvZWj5o+BENkF5eFT8+J9BnehIMifvyrb0hOD62K77X+TQvmyiJTIb/Yy6jKQqyyxRC9vSxMyXBDERQx0didJsZdp3UM610fBnIVdexZ5Xl4YrOJA6LCS9Sg+x96pLW85moT5LiOLeDQoevAqFv7K31EMCLXsAdejmIHh1PQKgp70FYzYgogRvv2AAnfFEF24z0KukRSsq3387Mx0omSE1yY51qhqSCI1jfsG+9Sdr32978P8chM5b5cbseZ06xP3fYPXbnFEmvj2te3K25omyYJ9QvHnPo6WrZACARBS63qma3ehWH2imFjS/zSyjeCmGBTMlIYOuzbS2muMLhRxc6l2Y8mAV5ubmE1bHjGYbVpURxfFeoreDlME12Wg7vmjSeTrcW35MAkMcq1ID0cHDNP9ENQ3oQd5tv1RVPQCAxP7dF9jCWrD5Q/ysAEA792ltNt4UxAjVYQNct3LVoLCRIoTb19TXMyHp+02tHMhs6IyVyW3iKc8i+MtPCMjxuqfHt+yH8qP/igtyf9+obcxiVykMnF0O83Dv8stuxiE5qjuw4gJNKH+cWZDkR2RMi1DXSbEU/01W65UawpZzGbScGSHYwDbs1aGWXGbMZm8x8ATQDmGhgaalYMPSbzeU/6FbxuJj+p+bZDj2iWH1jo2ouSgY2BrLsGfoc5WPO/c6r3K650HAwfQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(2616005)(36860700001)(47076005)(426003)(336012)(83380400001)(478600001)(7696005)(6666004)(36756003)(81166007)(54906003)(26005)(16526019)(186003)(1076003)(2906002)(30864003)(40460700003)(356005)(41300700001)(86362001)(6916009)(8676002)(82310400005)(4326008)(82740400003)(8936002)(5660300002)(40480700001)(316002)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:07:29.5012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed2a7e4-870c-4f48-8989-08db50d9c7ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Asad kamal <asad.kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Use the interface version directly from PMFW interface header file rather
than keeping another definition in common smu13 file.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../inc/pmfw_if/smu13_driver_if_aldebaran.h   |  2 +
 .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     |  2 +
 .../inc/pmfw_if/smu13_driver_if_v13_0_4.h     |  2 +-
 .../inc/pmfw_if/smu13_driver_if_v13_0_5.h     |  2 +-
 .../inc/pmfw_if/smu13_driver_if_v13_0_7.h     |  2 +-
 .../inc/pmfw_if/smu13_driver_if_yellow_carp.h |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  | 11 ------
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 39 +------------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  1 +
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  1 +
 15 files changed, 17 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
index 90200f31ff52..cddf45eebee8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
@@ -24,6 +24,8 @@
 #ifndef SMU13_DRIVER_IF_ALDEBARAN_H
 #define SMU13_DRIVER_IF_ALDEBARAN_H
 
+#define SMU13_DRIVER_IF_VERSION_ALDE 0x08
+
 #define NUM_VCLK_DPM_LEVELS   8
 #define NUM_DCLK_DPM_LEVELS   8
 #define NUM_SOCCLK_DPM_LEVELS 8
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index b686fb68a6e7..fe995651c6f5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -24,6 +24,8 @@
 #ifndef SMU13_DRIVER_IF_V13_0_0_H
 #define SMU13_DRIVER_IF_V13_0_0_H
 
+#define SMU13_0_0_DRIVER_IF_VERSION 0x32
+
 //Increment this version if SkuTable_t or BoardTable_t change
 #define PPTABLE_VERSION 0x26
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
index 2162ecd1057d..fee9293b3f97 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if
 // any structure is changed in this file
-#define PMFW_DRIVER_IF_VERSION 8
+#define SMU13_0_4_DRIVER_IF_VERSION 8
 
 typedef struct {
   int32_t value;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h
index aa971412b434..7589faa0232d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h
@@ -23,7 +23,7 @@
 #ifndef __SMU13_DRIVER_IF_V13_0_5_H__
 #define __SMU13_DRIVER_IF_V13_0_5_H__
 
-#define PMFW_DRIVER_IF_VERSION 4
+#define SMU13_0_5_DRIVER_IF_VERSION 4
 
 // Throttler Status Bitmask
 #define THROTTLER_STATUS_BIT_SPL            0
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
index 4c46a0392451..44e879c51cae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
@@ -25,7 +25,7 @@
 
 // *** IMPORTANT ***
 // PMFW TEAM: Always increment the interface version on any change to this file
-#define SMU13_DRIVER_IF_VERSION  0x35
+#define SMU13_0_7_DRIVER_IF_VERSION  0x35
 
 //Increment this version if SkuTable_t or BoardTable_t change
 #define PPTABLE_VERSION 0x27
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_yellow_carp.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_yellow_carp.h
index 25540cb28208..7417634827ad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_yellow_carp.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_yellow_carp.h
@@ -26,7 +26,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if
 // any structure is changed in this file
-#define SMU13_DRIVER_IF_VERSION 4
+#define SMU13_YELLOW_CARP_DRIVER_IF_VERSION 4
 
 typedef struct {
   int32_t value;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index df3baaab0037..3ae8d5d252a3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -25,17 +25,6 @@
 
 #include "amdgpu_smu.h"
 
-#define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
-#define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
-#define SMU13_DRIVER_IF_VERSION_ALDE 0x08
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_0 0x37
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x08
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_10 0x32
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x37
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_10 0x1D
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_6 0x0
-
 #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
 
 /* MP Apertures */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index d30ec3005ea1..e80f122d8aec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -2147,5 +2147,6 @@ void aldebaran_set_ppt_funcs(struct smu_context *smu)
 	smu->clock_map = aldebaran_clk_map;
 	smu->feature_map = aldebaran_feature_mask_map;
 	smu->table_map = aldebaran_table_map;
+	smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_ALDE;
 	smu_v13_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 393c6a7b9609..b24c8549d0b1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -269,45 +269,10 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	smu_major = (smu_version >> 16) & 0xff;
 	smu_minor = (smu_version >> 8) & 0xff;
 	smu_debug = (smu_version >> 0) & 0xff;
-	if (smu->is_apu)
+	if (smu->is_apu ||
+	    adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 6))
 		adev->pm.fw_version = smu_version;
 
-	switch (adev->ip_versions[MP1_HWIP][0]) {
-	case IP_VERSION(13, 0, 2):
-		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_ALDE;
-		break;
-	case IP_VERSION(13, 0, 0):
-		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_0;
-		break;
-	case IP_VERSION(13, 0, 10):
-		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_10;
-		break;
-	case IP_VERSION(13, 0, 7):
-		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_7;
-		break;
-	case IP_VERSION(13, 0, 1):
-	case IP_VERSION(13, 0, 3):
-	case IP_VERSION(13, 0, 8):
-		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_YELLOW_CARP;
-		break;
-	case IP_VERSION(13, 0, 4):
-	case IP_VERSION(13, 0, 11):
-		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_4;
-		break;
-	case IP_VERSION(13, 0, 5):
-		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_5;
-		break;
-	case IP_VERSION(13, 0, 6):
-		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_6;
-		adev->pm.fw_version = smu_version;
-		break;
-	default:
-		dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
-			adev->ip_versions[MP1_HWIP][0]);
-		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_INV;
-		break;
-	}
-
 	/* only for dGPU w/ SMU13*/
 	if (adev->pm.fw)
 		dev_dbg(smu->adev->dev, "smu fw reported program %d, version = 0x%08x (%d.%d.%d)\n",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 09405ef1e3c8..f4783e685bf8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2199,5 +2199,6 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = smu_v13_0_0_table_map;
 	smu->pwr_src_map = smu_v13_0_0_pwr_src_map;
 	smu->workload_map = smu_v13_0_0_workload_map;
+	smu->smc_driver_if_version = SMU13_0_0_DRIVER_IF_VERSION;
 	smu_v13_0_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 8fa9a36c38b6..0a0a7debb3ae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -1043,6 +1043,7 @@ void smu_v13_0_4_set_ppt_funcs(struct smu_context *smu)
 	smu->message_map = smu_v13_0_4_message_map;
 	smu->feature_map = smu_v13_0_4_feature_mask_map;
 	smu->table_map = smu_v13_0_4_table_map;
+	smu->smc_driver_if_version = SMU13_0_4_DRIVER_IF_VERSION;
 	smu->is_apu = true;
 
 	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4))
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 66445964efbd..165b2470b017 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -1068,6 +1068,7 @@ void smu_v13_0_5_set_ppt_funcs(struct smu_context *smu)
 	smu->feature_map = smu_v13_0_5_feature_mask_map;
 	smu->table_map = smu_v13_0_5_table_map;
 	smu->is_apu = true;
+	smu->smc_driver_if_version = SMU13_0_5_DRIVER_IF_VERSION;
 	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_34);
 	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_2);
 	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_33);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 43a855de7e9e..b46e0414be60 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2176,5 +2176,6 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
 	smu->clock_map = smu_v13_0_6_clk_map;
 	smu->feature_map = smu_v13_0_6_feature_mask_map;
 	smu->table_map = smu_v13_0_6_table_map;
+	smu->smc_driver_if_version = SMU13_0_6_DRIVER_IF_VERSION;
 	smu_v13_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 3d9ff46706fb..1b52b7df9c91 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1796,5 +1796,6 @@ void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = smu_v13_0_7_table_map;
 	smu->pwr_src_map = smu_v13_0_7_pwr_src_map;
 	smu->workload_map = smu_v13_0_7_workload_map;
+	smu->smc_driver_if_version = SMU13_0_7_DRIVER_IF_VERSION;
 	smu_v13_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 04e56b0b3033..ac5fcca0e47f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -1234,5 +1234,6 @@ void yellow_carp_set_ppt_funcs(struct smu_context *smu)
 	smu->feature_map = yellow_carp_feature_mask_map;
 	smu->table_map = yellow_carp_table_map;
 	smu->is_apu = true;
+	smu->smc_driver_if_version = SMU13_YELLOW_CARP_DRIVER_IF_VERSION;
 	smu_v13_0_set_smu_mailbox_registers(smu);
 }
-- 
2.40.1

