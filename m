Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678C1C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 02:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6857510E198;
	Tue, 17 May 2022 02:06:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FDDC10E108
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 02:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3ulyE6yWVzAHwZuYvMhsz45vTITtYP41hhsoJrxLIutN5VrY3srV18DNfuQWio93VNSIIeiqGNUlNLFZsQAEIZvesyFOFYwelXZB4By7YKf8F0l7jmb2ROs7cODweNyT1DkTro5tjlIUgF+YntWIy4ls7q9dCs99Gq3iZO3a5FvPhP831y/gZA2tU7Lt2p1mIBEF0B3q20O8p0VZAtBC+39n8I5T22yG62KCkH/3dhzF9OWHV3tfyzEhpeYpHIie0jsPwQj3sYF/Leqop7YeYmnMadL3NSL7in7BGrEQh1XJO385by3H7NLHzS1rnxAjaGoTMN3gQoZ81Nzg+bhlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUjoSgHAllI8uw+pwtdbT9pCncDMtez8cj4QeJEv1p4=;
 b=SpcX1fbOITXOIFoG3EBdbXQ7PqkKGOqxlwopqGROU94fUnnhS5Y5lPhjNbs/ZvnzF6kngT4EJu60EGRRrlWa+9Yz9dytJTpa1AEpaKKMwbVKg6Vjs2ntdSrO+fU8npHPIPku+/PNOXKOu5wB59aN8hrmrTY95t77YYUQdp775vuGdvfk/aP64vLF6mXG5iogOuPa7iSsNkqUcc9GsA5vp9zqJEMS5DsZtX0HG7gNeWeqHeIkdcbb0GMKJEtFlTsvJ6yox6n1RVcOObnZuZDhXnIv3dl4X5rJgRUrLkgbUTudLMQI0Ib3+z+9zaI2pUtnBwAXwP1u4BDz7PcWLCDyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUjoSgHAllI8uw+pwtdbT9pCncDMtez8cj4QeJEv1p4=;
 b=11mcx0OWctk+ZT5vDnvFtde5kvqfHeFKkN5Fjw+QJHXottDqTURc1f1hw9gQSbwHQgpJqJrESD4hEaHqJWRegr50+/MTQqq4E+lRb9q+s3GPuOqOzqnVxIQnq/pmt1YDZ/5FYzrmilgDqIcaOPNhGL27CEpgHP2q+P2osIzA00M=
Received: from MW2PR16CA0054.namprd16.prod.outlook.com (2603:10b6:907:1::31)
 by MWHPR1201MB0221.namprd12.prod.outlook.com (2603:10b6:301:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 02:06:49 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::ea) by MW2PR16CA0054.outlook.office365.com
 (2603:10b6:907:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Tue, 17 May 2022 02:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 02:06:48 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 21:06:47 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amd/pm: update SMU 13.0.0 driver_if header
Date: Tue, 17 May 2022 10:05:59 +0800
Message-ID: <20220517020602.160108-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220517020602.160108-1-evan.quan@amd.com>
References: <20220517020602.160108-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d62b61d5-01b4-40f9-ac19-08da37a9e705
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0221:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0221382819D4C1FC812919C6E4CE9@MWHPR1201MB0221.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wferlh7iftzc25j2r0gM86K0Bfh4h5fDTfK35Ukr4EMkL0+k+hnQ4Il7A5zDidXNIJi5pTfzKITsYIJnkjkL2yDgwHkpZjnQZTVA9UD+r2p77tS+98b32GD79tZ2Nx6Y/4envd7TlHl2YfTRrg7O38pAO195me7MhTVNvl/7KzZMkzH09UJFXBXxsFUbVCtsSkztIrXFiRVx73/DLkBCxWzVzz0tovKrFBALrk408Mt0iEodWT4Esxx1do7gIvtz16Gv7+bFsozARnXGoQwY+bI96nrIUt5Qk4PZet2LUt4JNqEOsfEwyqMyIqP/Q6YXJVyYAIIfbheMERlZqhI4GYf26YdeTEunaBjT4BJbTTdj83Ly7pCRXxJYGB5XNtL6Rd0LFIFOuwRbimvsTLtfI8JWfY49UQ/K+vEYbH1Ff0osDPz2XoaTgzqM+1cdokYvGoKdgOVBwxgvFx3MsUJpVTG8p92m3W7B2prMiCeriSrM9lqtpm7Oixdqeu8iE8Q/3aYtOuKUCxy99vsdYC2VYz3FyVBge3hvlF1CAaqs/Yd5bEJfg61j4tomBDGj+XE/2CYxtFsUUy1C14NzDdCRWLtEST5PrxesXXtg2/IAHpWC1PcBEOKs4nfkVzuj72nKhHDU13cqypDZGMSfUVKXNXonLPAEoSTQyIqFjefV9RAkn9pphozYjFej53Ds3c9DDhWiD9f9VlQtR1sHZOWpkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(54906003)(70206006)(70586007)(81166007)(83380400001)(6916009)(36756003)(356005)(4326008)(86362001)(5660300002)(36860700001)(426003)(47076005)(336012)(2616005)(82310400005)(2906002)(26005)(16526019)(7696005)(186003)(6666004)(8936002)(508600001)(316002)(15650500001)(8676002)(44832011)(1076003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 02:06:48.9380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d62b61d5-01b4-40f9-ac19-08da37a9e705
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0221
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To align with 78.37.0 and later PMFWs.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: I17c3a6b466c921cb5ffe5025a94023fae478c80e
---
 .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     | 22 +++++++++----------
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  2 +-
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index ecc6411dfc8d..c1f76236da26 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -671,8 +671,8 @@ typedef struct {
   uint16_t               reserved[2];
 
   //Frequency changes
-  uint16_t               GfxclkFmin;           // MHz
-  uint16_t               GfxclkFmax;           // MHz
+  int16_t                GfxclkFmin;           // MHz
+  int16_t                GfxclkFmax;           // MHz
   uint16_t               UclkFmin;             // MHz
   uint16_t               UclkFmax;             // MHz
 
@@ -683,15 +683,14 @@ typedef struct {
   //Fan control
   uint8_t                FanLinearPwmPoints[NUM_OD_FAN_MAX_POINTS];
   uint8_t                FanLinearTempPoints[NUM_OD_FAN_MAX_POINTS];
-  uint16_t               FanMaximumRpm;
   uint16_t               FanMinimumPwm;
-  uint16_t               FanAcousticLimitRpm;
+  uint16_t               AcousticTargetRpmThreshold;
+  uint16_t               AcousticLimitRpmThreshold;
   uint16_t               FanTargetTemperature; // Degree Celcius
   uint8_t                FanZeroRpmEnable;
   uint8_t                FanZeroRpmStopTemp;
   uint8_t                FanMode;
-  uint8_t                Padding[1];
-
+  uint8_t                MaxOpTemp;
 
   uint32_t               Spare[13];
   uint32_t               MmHubPadding[8]; // SMU internal use. Adding here instead of external as a workaround
@@ -719,15 +718,14 @@ typedef struct {
 
   uint8_t                FanLinearPwmPoints;
   uint8_t                FanLinearTempPoints;
-  uint16_t               FanMaximumRpm;
   uint16_t               FanMinimumPwm;
-  uint16_t               FanAcousticLimitRpm;
+  uint16_t               AcousticTargetRpmThreshold;
+  uint16_t               AcousticLimitRpmThreshold;
   uint16_t               FanTargetTemperature; // Degree Celcius
   uint8_t                FanZeroRpmEnable;
   uint8_t                FanZeroRpmStopTemp;
   uint8_t                FanMode;
-  uint8_t                Padding[1];
-
+  uint8_t                MaxOpTemp;
 
   uint32_t               Spare[13];
 
@@ -997,7 +995,8 @@ typedef struct {
   uint16_t SocketPowerLimitAcTau[PPT_THROTTLER_COUNT]; // Time constant of LPF in ms
   uint16_t SocketPowerLimitDcTau[PPT_THROTTLER_COUNT]; // Time constant of LPF in ms
 
-  uint32_t       SpareVmin[12];
+  QuadraticInt_t Vmin_droop;
+  uint32_t       SpareVmin[9];
 
 
   //SECTION: DPM Configuration 1
@@ -1286,7 +1285,6 @@ typedef struct {
   uint32_t    PostVoltageSetBacoDelay; // in microseconds. Amount of time FW will wait after power good is established or PSI0 command is issued
   uint32_t    BacoEntryDelay; // in milliseconds. Amount of time FW will wait to trigger BACO entry after receiving entry notification from OS
 
-
   // SECTION: Board Reserved
   uint32_t     BoardSpare[64];
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 2b44d41a5157..afa1991e26f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -30,7 +30,7 @@
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x27
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x28
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x28
 
 #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
-- 
2.29.0

