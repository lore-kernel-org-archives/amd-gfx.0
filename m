Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA65C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 00:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9389113CBE;
	Thu, 21 Jul 2022 00:46:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA40112A1A
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 00:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpGMOikRswRGRryWWEfpMcG2nPD0cJ+w21GH5zUVdNil54R5bDe6jABuOg8VP3SP8SwWmvY94GFz232c4cEWZInaTPY7s+uegw1GEFILMrqOtzTzZ7vauR8hfXs2W/EE8s30t1mEcREG9CtXRskW6j2CBLSpTybnJiF/zDfbQNMU6fcz9oQGA6SkyIpij8UC1GP0ZhAtd/54vY2s3qnpL2Bvv/paflDC6vG4WXPJ0BFj9HXf8TRncxCIlvCz84wF0kAUQWmcoCGlYJyRR7rcU2njBjLKnD2wg+lppp7is3hvwhEfaPp85yo6zrDspw+9Kod0E1551+0/uz/GB+2mwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUXHBfcBlFaGgWBKTzEdy079FZn4hFjQmw7r/k42gL4=;
 b=ds84hPmQwx7CAQwYDBfWrzEAH90vuFu3uQ6vv4GyKJw/NiMjh4BJ6t0F3Ya+YMgnRmZyR+axGhRMAApX/Hzig1v5aemez36wfx7El1ta9habWIzmGjU78dh016rXBp6xKDKglmqL8tC9Ewa+X3bepv9eJnV+CNsLkCs6SKFbXTPgbNWlyhsdAdbuLMtMYG5VTTmfqMv72Rzfi3IoDZUGsGn61xEgxNs0UYmStInKxYuGo/TvEwdDCGDQKSX/UP6PyqSJbQ4l0D1GoXExFM8qayuNJIDKBdEryO7riDxejSDD1eIBZL727kTayyCfDYOoA0OkwEsqidIko5cszRDGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUXHBfcBlFaGgWBKTzEdy079FZn4hFjQmw7r/k42gL4=;
 b=uQutYaoo6fF44Ya/HWJWDIRDAJWuH439yy0YgL7PksV6ezmEfYyZIrVe+X7GHjnzSZ5VeJ8KFmOOB7JJznJuB0zbVHOomSSmE1Wl85kn6j+I5a/BX/7AVsyfv/fQxrpPNuLkSL6PqjDVcMYa3blzDfc2Dcz2MOqmUikrU4MAe/o=
Received: from DM6PR05CA0039.namprd05.prod.outlook.com (2603:10b6:5:335::8) by
 DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.18; Thu, 21 Jul 2022 00:46:05 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::72) by DM6PR05CA0039.outlook.office365.com
 (2603:10b6:5:335::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.15 via Frontend
 Transport; Thu, 21 Jul 2022 00:46:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 00:46:05 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 20 Jul
 2022 19:46:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 20 Jul
 2022 17:46:04 -0700
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Wed, 20 Jul 2022 19:46:03 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: update driver if header for smu_13_0_7
Date: Thu, 21 Jul 2022 08:46:01 +0800
Message-ID: <20220721004601.202347-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b258a6f-e738-4768-df2f-08da6ab26507
X-MS-TrafficTypeDiagnostic: DM4PR12MB5120:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zOcEHPoqKeeZ0nxhs8pev/sNg52n9QJ/3E4M35lFhDSafAiIX9KT9WwyGAvcYERldLzWT+nF6vm8fxHtEJc3HP3m+KIQtYsuL8K4pmn/AkWKw2TRkPIzI6FPMGUOGEtyv4DoHwv63oJ7QciVeLX3wJ4pF91Gsw3yrnSZXv8DeDRWNqD/xEZE4S4cySmOvZwKL3m2heU1w8CokfVbRNtjXJ7AALFH3WhXAMhbjdZHB0rlAQ5TI/L9tm3kb9cLQJGH37UKyIYxhKgAHd+olIGBFRi/itxBepD41F0CuD5DdHDNR9EzUCKK0ao4WWe6mw1pFZFjLmlHtUGI54kxB3oxcpFrfBdTbrsB2I11tl7WsvY5YW9hkpNky5cVMaMEUACmKTGksw8y8P8QCuBadfPotgjzgfVB24TANplTbPdv6iMXXKU6uwUtsIE7dFbgtujF/P1o8QrmeRyEI3Vr/s2+i8MXEO7YtO7OnmrijvPWqgvMGeu7tS6c/WCmoF8uZY+x/RGRp/6bQnfr7sC46Urw0ogENQ7xMM5wOLJiGSURMZUozc+JLZnDfnx4+4wK/apWFoKvWMTMtZz7k58ALnk6mpB+zq8mXQcpcRHhuvkcoIVcVpRDEsyxvSrx83dvVBlGhmHMoHdwM1Wj4+NJn3DNOoRzn/InojzjZAgIPVtui7nNrEwTVnzBEZ/3MYkzenxPOGD7B5Kw+e2RJm2YKg5buLZLC9TEoxVD6p6RKebuYtIkSEuiJYV/YjsT/fvsW2IVU/RAZE+JBFV8rJ5Udu5jHHjcfTS623iPQp4nLnfx6vcv7YHNdEisdhnB3St8TUVpwWcdJ+2DpFS7lxaRtq6sLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(36840700001)(46966006)(40470700004)(8936002)(7696005)(2616005)(41300700001)(82740400003)(5660300002)(4326008)(1076003)(81166007)(336012)(426003)(83380400001)(70586007)(36756003)(70206006)(356005)(8676002)(40460700003)(47076005)(478600001)(26005)(316002)(36860700001)(6916009)(186003)(44832011)(15650500001)(40480700001)(2906002)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 00:46:05.7146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b258a6f-e738-4768-df2f-08da6ab26507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update driver if header for smu_13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../inc/pmfw_if/smu13_driver_if_v13_0_7.h     | 24 ++++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  2 +-
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
index 132da684e379..25c08f963f49 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
@@ -25,10 +25,10 @@
 
 // *** IMPORTANT ***
 // PMFW TEAM: Always increment the interface version on any change to this file
-#define SMU13_DRIVER_IF_VERSION  0x2A
+#define SMU13_DRIVER_IF_VERSION  0x2C
 
 //Increment this version if SkuTable_t or BoardTable_t change
-#define PPTABLE_VERSION 0x1E
+#define PPTABLE_VERSION 0x20
 
 #define NUM_GFXCLK_DPM_LEVELS    16
 #define NUM_SOCCLK_DPM_LEVELS    8
@@ -152,6 +152,7 @@ typedef enum {
 #define DEBUG_OVERRIDE_DISABLE_DFLL                    0x00000200
 #define DEBUG_OVERRIDE_ENABLE_RLC_VF_BRINGUP_MODE      0x00000400
 #define DEBUG_OVERRIDE_DFLL_MASTER_MODE                0x00000800
+#define DEBUG_OVERRIDE_ENABLE_PROFILING_MODE           0x00001000
 
 // VR Mapping Bit Defines
 #define VR_MAPPING_VR_SELECT_MASK  0x01
@@ -1014,8 +1015,8 @@ typedef struct {
   uint16_t        Vmin_Hot_Eol[PMFW_VOLT_PLANE_COUNT];           //In mV(Q2) End-of-life Vset to be used at hot.
   uint16_t        Vmin_Cold_Eol[PMFW_VOLT_PLANE_COUNT];          //In mV(Q2) End-of-life Vset to be used at cold.
   uint16_t        Vmin_Aging_Offset[PMFW_VOLT_PLANE_COUNT];      //In mV(Q2) Worst-case aging margin
-  uint16_t        Vmin_Plat_Offset_Hot[PMFW_VOLT_PLANE_COUNT];   //In mV(Q2) Platform offset apply to T0 Hot
-  uint16_t        Vmin_Plat_Offset_Cold[PMFW_VOLT_PLANE_COUNT];  //In mV(Q2) Platform offset apply to T0 Cold
+  uint16_t        Spare_Vmin_Plat_Offset_Hot[PMFW_VOLT_PLANE_COUNT];   //In mV(Q2) Platform offset apply to T0 Hot
+  uint16_t        Spare_Vmin_Plat_Offset_Cold[PMFW_VOLT_PLANE_COUNT];  //In mV(Q2) Platform offset apply to T0 Cold
 
   //This is a fixed/minimum VMIN aging degradation offset which is applied at T0. This reflects the minimum amount of aging already accounted for.
   uint16_t        VcBtcFixedVminAgingOffset[PMFW_VOLT_PLANE_COUNT];
@@ -1081,11 +1082,15 @@ typedef struct {
 
   uint16_t        GfxclkFreqGfxUlv; // in MHz
   uint8_t         GfxIdlePadding2[2];
-
-  uint32_t        GfxoffSpare[16];
+  uint32_t        GfxOffEntryHysteresis; //For RLC to count after it enters CGCG, and before triggers GFXOFF entry
+  uint32_t        GfxoffSpare[15];
 
   // GFX GPO
-  uint32_t        GfxGpoSpare[16];
+  float           DfllBtcMasterScalerM;
+  int32_t         DfllBtcMasterScalerB;
+  float           DfllBtcSlaveScalerM;
+  int32_t         DfllBtcSlaveScalerB;
+  uint32_t        GfxGpoSpare[12];
 
   // GFX DCS
 
@@ -1326,8 +1331,11 @@ typedef struct {
   uint32_t    PostVoltageSetBacoDelay; // in microseconds. Amount of time FW will wait after power good is established or PSI0 command is issued
   uint32_t    BacoEntryDelay; // in milliseconds. Amount of time FW will wait to trigger BACO entry after receiving entry notification from OS
 
+  uint8_t     FuseWritePowerMuxPresent;
+  uint8_t     FuseWritePadding[3];
+
   // SECTION: Board Reserved
-  uint32_t     BoardSpare[64];
+  uint32_t     BoardSpare[63];
 
   // SECTION: Structure Padding
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 038a8956de5b..3e5838346f02 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -31,7 +31,7 @@
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x2A
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x2A
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x2C
 
 #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
 
-- 
2.25.1

