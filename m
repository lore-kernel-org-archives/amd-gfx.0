Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD11AC47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 18:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6902110EE72;
	Thu, 25 Jan 2024 18:38:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D29310EE72
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 18:38:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWZiqlYGPxcrHr/sLIqjbp5d/XG9+9JgFlon8BiCOfslbY71k505oXecXowMXsEawTtBigfjsUJal8Kt7O2niAyNq5CKsqfUezOoe/GxM8N25H4LHF9cUxh7n2iZ6jbEHIl0XbErg8ysqIuTC5UPsiBBVB4LF7S8HVPFW5uvArSKZticQr0gXn0WHR9tcPs8P4INimim0RnAv5/tpeQ/PmgskWlBTVZ1iUGjtP9/vVWQAmZOUdf7nh2tcOfQp/mzbwxppNdUJ338eQcted/c5a6hN2wjwN4y+G0NyLfHb5RDiqM/jpp9p/Gm4kzd7FR2zsitwAbcD8wstKQt4H2t+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VRsEf5udlh6oS+FpQg1Mr/i7hkdZv9kk0ooFV4dfaQ=;
 b=aV2OQoT7uz1ERmR0fBPSnhtGe7O1fBFeawwIuBuLxa9pB8PY8UGylXsSOSm5oVLZuDyV+IonrPS6W7jCSlrAD1lVNFoPjvjWiZ+cLb3xYRyaMBr72ZttHgwdunv3FrFnNs5W3bJeAHQMGNxafPrkn8AMPrEkALToHxVyHAU1CW/ODrbkby9/irX+ew5WAMige3fAEquF0KMWyHKuehBeiunEckUw7bNp82qfmM6lEyGCoKf6vSyKXnjy9bMG0iNbdtNk1PwHuBDNVR3Fj2+6eyigZabPIQb6JTRuPP3zeHa1/RXE9Xr8Ya5wyXrbT9oX0p9s5pg1hkVJqdB1AJ+46g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VRsEf5udlh6oS+FpQg1Mr/i7hkdZv9kk0ooFV4dfaQ=;
 b=NAtHX8Yz0UX/LOrqZXcyJY03X341C3nSWKH+aByEr17tQ5ijOvO5tqLwCUfHxdd2Ji67oZJV/AxWzC9aDRkbsscg0Uox6pEOLL8Uc3mylBdhsJ3JCP3FxUUwCtsYw/1kXWwtiVE3C8j9cRjUYof9zOx+gtjBP1QVtALeL1lT10k=
Received: from MN2PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:23a::21)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 18:38:36 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::6) by MN2PR03CA0016.outlook.office365.com
 (2603:10b6:208:23a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24 via Frontend
 Transport; Thu, 25 Jan 2024 18:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 18:38:33 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 12:38:32 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/include: Add missing registers/mask for DCN316 and 350
Date: Thu, 25 Jan 2024 11:37:25 -0700
Message-ID: <20240125183752.999995-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 9199c4c8-ac7e-4aeb-a5e3-08dc1dd4d5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTKxZaXi040Znkl0D0UFBD/pUo5iRwvnipiXTcjL6W3/HMQmiOigqK+LK1vUeVYv55FSgcmTV4ThOMPCpZKMXNxs8eQxbabKWKGZX4NdvsC70vVNRdayuolwEn9aiQi3OypIHyzZVQPWk05VMOZrEzGj2KvqiNzjEx+8kM+n8HQHSJpbla6pZjCNb5FrLy5Jmk63v/j8264A5i6s0whJGlzwJPrArsyQDcxBy2JvXFNleB5pl+oJeot6RLZ0Day+uCVI6P21LiXew+1Gc94f0jMSaeCNeKFTOukPbe4ZZ0XrPGIldUzEG4KOv2Lngyd1/WqF8F6BP7ddj2wmvR0ptlTCjaxSYZ9rGr950oWKOaRCW18RfG0Fz2RPjB8D+ey2Zbs0GRZ6DguzG41wRHYAV3ziqEbWoMbBMJUkkdszLRsTKb8meGOMyPJhSCK/SCRcj7r8lx8nMuaozQJzmk2evirOYdUVc1EC6b44rmnHrwvkykfKSMcj2pQPOPfXfLL5yeSBsib8kSnLqcG5SqBRvMUhuG0yUi4UmRKuVx3OAo7QmlK6b88y49tRbBAkzkzrA19QxTbzaKXY+0a8sq7JfiwNBYtSlKvDfaXVM9W7mF8BXVlYqudEoo0WMaWQ/+xnKfXoFGNJ8408P/kZokQUOVFhR7ga5LLiW+KxchOxuzJ0kEXbi3GbCg3xwalkNuozM7ZtoVb4WMEq5q7eKaePSZoy9aA+pBH1afVHxGUG8NhqXOeV/0x7tKOuKro8hSh4ejGSckb81u7fvzttQFWZrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(40470700004)(36840700001)(46966006)(356005)(82740400003)(81166007)(426003)(66899024)(16526019)(336012)(41300700001)(83380400001)(6916009)(2616005)(86362001)(36756003)(70586007)(2906002)(6666004)(54906003)(478600001)(26005)(1076003)(30864003)(316002)(70206006)(8936002)(4326008)(5660300002)(47076005)(36860700001)(8676002)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 18:38:33.9413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9199c4c8-ac7e-4aeb-a5e3-08dc1dd4d5f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027
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
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cc: Jun Lei <Jun.Lei@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../include/asic_reg/dcn/dcn_3_1_6_offset.h   |  4 ++
 .../include/asic_reg/dcn/dcn_3_1_6_sh_mask.h  | 10 +++
 .../include/asic_reg/dcn/dcn_3_5_0_offset.h   | 24 +++++++
 .../include/asic_reg/dcn/dcn_3_5_0_sh_mask.h  | 65 +++++++++++++++++++
 4 files changed, 103 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_offset.h
index 222fa8d13269..a05bf8e4f58d 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_offset.h
@@ -626,6 +626,8 @@
 #define regDTBCLK_DTO2_MODULO_BASE_IDX                                                                  2
 #define regDTBCLK_DTO3_MODULO                                                                           0x0022
 #define regDTBCLK_DTO3_MODULO_BASE_IDX                                                                  2
+#define regHDMICHARCLK0_CLOCK_CNTL                                                                      0x004a
+#define regHDMICHARCLK0_CLOCK_CNTL_BASE_IDX                                                             2
 #define regPHYASYMCLK_CLOCK_CNTL                                                                        0x0052
 #define regPHYASYMCLK_CLOCK_CNTL_BASE_IDX                                                               2
 #define regPHYBSYMCLK_CLOCK_CNTL                                                                        0x0053
@@ -638,6 +640,8 @@
 #define regPHYESYMCLK_CLOCK_CNTL_BASE_IDX                                                               2
 #define regPHYFSYMCLK_CLOCK_CNTL                                                                        0x0057
 #define regPHYFSYMCLK_CLOCK_CNTL_BASE_IDX                                                               2
+#define regHDMISTREAMCLK_CNTL                                                                           0x0059
+#define regHDMISTREAMCLK_CNTL_BASE_IDX                                                                  2
 #define regDCCG_GATE_DISABLE_CNTL3                                                                      0x005a
 #define regDCCG_GATE_DISABLE_CNTL3_BASE_IDX                                                             2
 #define regHDMISTREAMCLK0_DTO_PARAM                                                                     0x005b
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_sh_mask.h
index 8ddb03a1dc39..df84941bbe5b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_sh_mask.h
@@ -1933,6 +1933,11 @@
 //DTBCLK_DTO3_MODULO
 #define DTBCLK_DTO3_MODULO__DTBCLK_DTO3_MODULO__SHIFT                                                         0x0
 #define DTBCLK_DTO3_MODULO__DTBCLK_DTO3_MODULO_MASK                                                           0xFFFFFFFFL
+//HDMICHARCLK0_CLOCK_CNTL
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_EN__SHIFT                                                       0x0
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_SRC_SEL__SHIFT                                                  0x4
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_EN_MASK                                                         0x00000001L
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_SRC_SEL_MASK                                                    0x00000070L
 //PHYASYMCLK_CLOCK_CNTL
 #define PHYASYMCLK_CLOCK_CNTL__PHYASYMCLK_FORCE_EN__SHIFT                                                     0x0
 #define PHYASYMCLK_CLOCK_CNTL__PHYASYMCLK_FORCE_SRC_SEL__SHIFT                                                0x4
@@ -1967,6 +1972,11 @@
 #define PHYFSYMCLK_CLOCK_CNTL__PHYFSYMCLK_FORCE_SRC_SEL__SHIFT                                                0x4
 #define PHYFSYMCLK_CLOCK_CNTL__PHYFSYMCLK_FORCE_EN_MASK                                                       0x00000001L
 #define PHYFSYMCLK_CLOCK_CNTL__PHYFSYMCLK_FORCE_SRC_SEL_MASK                                                  0x00000030L
+//HDMISTREAMCLK_CNTL
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_SRC_SEL__SHIFT                                                     0x0
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_DTO_FORCE_DIS__SHIFT                                               0x10
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_SRC_SEL_MASK                                                       0x00000003L
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_DTO_FORCE_DIS_MASK                                                 0x00010000L
 //DCCG_GATE_DISABLE_CNTL3
 #define DCCG_GATE_DISABLE_CNTL3__HDMISTREAMCLK0_GATE_DISABLE__SHIFT                                           0x0
 #define DCCG_GATE_DISABLE_CNTL3__HDMISTREAMCLK1_GATE_DISABLE__SHIFT                                           0x1
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_offset.h
index 7cf0a625277b..33b5d9be06b1 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_offset.h
@@ -4802,6 +4802,10 @@
 #define regCM0_CM_DEALPHA_BASE_IDX                                                                      2
 #define regCM0_CM_COEF_FORMAT                                                                           0x0d8c
 #define regCM0_CM_COEF_FORMAT_BASE_IDX                                                                  2
+#define regCM0_CM_TEST_DEBUG_INDEX                                                                      0x0d8d
+#define regCM0_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define regCM0_CM_TEST_DEBUG_DATA                                                                       0x0d8e
+#define regCM0_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp0_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -5210,6 +5214,10 @@
 #define regCM1_CM_DEALPHA_BASE_IDX                                                                      2
 #define regCM1_CM_COEF_FORMAT                                                                           0x0ef7
 #define regCM1_CM_COEF_FORMAT_BASE_IDX                                                                  2
+#define regCM1_CM_TEST_DEBUG_INDEX                                                                      0x0ef8
+#define regCM1_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define regCM1_CM_TEST_DEBUG_DATA                                                                       0x0ef9
+#define regCM1_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp1_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -5618,6 +5626,10 @@
 #define regCM2_CM_DEALPHA_BASE_IDX                                                                      2
 #define regCM2_CM_COEF_FORMAT                                                                           0x1062
 #define regCM2_CM_COEF_FORMAT_BASE_IDX                                                                  2
+#define regCM2_CM_TEST_DEBUG_INDEX                                                                      0x1063
+#define regCM2_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define regCM2_CM_TEST_DEBUG_DATA                                                                       0x1064
+#define regCM2_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp2_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -6026,6 +6038,10 @@
 #define regCM3_CM_DEALPHA_BASE_IDX                                                                      2
 #define regCM3_CM_COEF_FORMAT                                                                           0x11cd
 #define regCM3_CM_COEF_FORMAT_BASE_IDX                                                                  2
+#define regCM3_CM_TEST_DEBUG_INDEX                                                                      0x11ce
+#define regCM3_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define regCM3_CM_TEST_DEBUG_DATA                                                                       0x11cf
+#define regCM3_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp3_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -10568,6 +10584,8 @@
 #define regDSCC0_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
 #define regDSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL                                           0x3035
 #define regDSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
+#define regDSCC0_DSCC_TEST_DEBUG_BUS_ROTATE                                                             0x303a
+#define regDSCC0_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                                                    2
 
 
 // addressBlock: dce_dc_dsc0_dispdec_dsc_dcperfmon_dc_perfmon_dispdec
@@ -10697,6 +10715,8 @@
 #define regDSCC1_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
 #define regDSCC1_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL                                           0x3091
 #define regDSCC1_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
+#define regDSCC1_DSCC_TEST_DEBUG_BUS_ROTATE                                                             0x3096
+#define regDSCC1_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                                                    2
 
 
 // addressBlock: dce_dc_dsc1_dispdec_dsc_dcperfmon_dc_perfmon_dispdec
@@ -10827,6 +10847,8 @@
 #define regDSCC2_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
 #define regDSCC2_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL                                           0x30ed
 #define regDSCC2_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
+#define regDSCC2_DSCC_TEST_DEBUG_BUS_ROTATE                                                             0x30f2
+#define regDSCC2_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                                                    2
 
 
 // addressBlock: dce_dc_dsc2_dispdec_dsc_dcperfmon_dc_perfmon_dispdec
@@ -10957,6 +10979,8 @@
 #define regDSCC3_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
 #define regDSCC3_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL                                           0x3149
 #define regDSCC3_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
+#define regDSCC3_DSCC_TEST_DEBUG_BUS_ROTATE                                                             0x314e
+#define regDSCC3_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                                                    2
 
 
 // addressBlock: dce_dc_dsc3_dispdec_dsc_dcperfmon_dc_perfmon_dispdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h
index fca72e2ec929..ff77b71167eb 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h
@@ -16556,6 +16556,13 @@
 #define CM0_CM_COEF_FORMAT__CM_BIAS_FORMAT_MASK                                                               0x00000001L
 #define CM0_CM_COEF_FORMAT__CM_POST_CSC_COEF_FORMAT_MASK                                                      0x00000010L
 #define CM0_CM_COEF_FORMAT__CM_GAMUT_REMAP_COEF_FORMAT_MASK                                                   0x00000100L
+
+//CM0_CM_TEST_DEBUG_INDEX
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX__SHIFT                                                   0x0
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN__SHIFT                                                0x8
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX_MASK                                                     0x000000FFL
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN_MASK                                                  0x00000100L
+
 #define DC_PERFMON10_PERFCOUNTER_CNTL__PERFCOUNTER_EVENT_SEL__SHIFT                                           0x0
 #define DC_PERFMON10_PERFCOUNTER_CNTL__PERFCOUNTER_CVALUE_SEL__SHIFT                                          0x9
 #define DC_PERFMON10_PERFCOUNTER_CNTL__PERFCOUNTER_INC_MODE__SHIFT                                            0xc
@@ -27176,6 +27183,23 @@
 #define DIG0_AFMT_CNTL__AFMT_AUDIO_CLOCK_ON__SHIFT                                                            0x8
 #define DIG0_AFMT_CNTL__AFMT_AUDIO_CLOCK_EN_MASK                                                              0x00000001L
 #define DIG0_AFMT_CNTL__AFMT_AUDIO_CLOCK_ON_MASK                                                              0x00000100L
+
+//DIG0_DIG_BE_CLK_CNTL
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_MODE__SHIFT                                                              0x0
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_CLK_EN__SHIFT                                                            0x4
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SOFT_RESET__SHIFT                                                        0x5
+#define DIG0_DIG_BE_CLK_CNTL__HDCP_SOFT_RESET__SHIFT                                                          0x6
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_CLOCK_ON__SHIFT                                                 0xb
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_HDCP_CLOCK_ON__SHIFT                                            0xc
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_TMDS_CLOCK_ON__SHIFT                                            0xd
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_MODE_MASK                                                                0x00000007L
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_CLK_EN_MASK                                                              0x00000010L
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SOFT_RESET_MASK                                                          0x00000020L
+#define DIG0_DIG_BE_CLK_CNTL__HDCP_SOFT_RESET_MASK                                                            0x00000040L
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_CLOCK_ON_MASK                                                   0x00000800L
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_HDCP_CLOCK_ON_MASK                                              0x00001000L
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_TMDS_CLOCK_ON_MASK                                              0x00002000L
+
 #define DIG0_DIG_BE_CNTL__DIG_DUAL_LINK_ENABLE__SHIFT                                                         0x0
 #define DIG0_DIG_BE_CNTL__DIG_SWAP__SHIFT                                                                     0x1
 #define DIG0_DIG_BE_CNTL__DIG_RB_SWITCH_EN__SHIFT                                                             0x2
@@ -36716,6 +36740,17 @@
 #define DSCC0_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL__DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_MASK  0x0003FFFFL
 #define DSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL__DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL__SHIFT  0x0
 #define DSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL__DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_MASK  0x0003FFFFL
+
+//DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS0_ROTATE__SHIFT                                  0x0
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS1_ROTATE__SHIFT                                  0x8
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS2_ROTATE__SHIFT                                  0x10
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS3_ROTATE__SHIFT                                  0x18
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS0_ROTATE_MASK                                    0x0000001FL
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS1_ROTATE_MASK                                    0x00001F00L
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS2_ROTATE_MASK                                    0x001F0000L
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS3_ROTATE_MASK                                    0x1F000000L
+
 #define DC_PERFMON17_PERFCOUNTER_CNTL__PERFCOUNTER_EVENT_SEL__SHIFT                                           0x0
 #define DC_PERFMON17_PERFCOUNTER_CNTL__PERFCOUNTER_CVALUE_SEL__SHIFT                                          0x9
 #define DC_PERFMON17_PERFCOUNTER_CNTL__PERFCOUNTER_INC_MODE__SHIFT                                            0xc
@@ -38488,6 +38523,18 @@
 #define DWB_OGAM_LUT_INDEX__DWB_OGAM_LUT_INDEX_MASK                                                           0x000001FFL
 #define DWB_OGAM_LUT_DATA__DWB_OGAM_LUT_DATA__SHIFT                                                           0x0
 #define DWB_OGAM_LUT_DATA__DWB_OGAM_LUT_DATA_MASK                                                             0x0003FFFFL
+//DWB_OGAM_LUT_CONTROL
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_WRITE_COLOR_MASK__SHIFT                                            0x0
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_READ_COLOR_SEL__SHIFT                                              0x4
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_READ_DBG__SHIFT                                                    0x8
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_HOST_SEL__SHIFT                                                    0xc
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_CONFIG_MODE__SHIFT                                                 0x10
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_WRITE_COLOR_MASK_MASK                                              0x00000007L
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_READ_COLOR_SEL_MASK                                                0x00000030L
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_READ_DBG_MASK                                                      0x00000100L
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_HOST_SEL_MASK                                                      0x00001000L
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_CONFIG_MODE_MASK                                                   0x00010000L
+
 #define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_WRITE_COLOR_MASK__SHIFT                                            0x0
 #define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_READ_COLOR_SEL__SHIFT                                              0x4
 #define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_HOST_SEL__SHIFT                                                    0xc
@@ -52008,6 +52055,14 @@
 #define DIO_CLK_CNTL__SYMCLK_R_GATE_DIS__SHIFT                                                                0x10
 #define DIO_CLK_CNTL__SYMCLK_G_GATE_DIS__SHIFT                                                                0x11
 #define DIO_CLK_CNTL__DIO_FGCG_REP_DIS__SHIFT                                                                 0x14
+#define DIO_CLK_CNTL__DISPCLK_G_HDCP_GATE_DIS__SHIFT                                                          0x15
+#define DIO_CLK_CNTL__SYMCLKA_G_HDCP_GATE_DIS__SHIFT                                                          0x16
+#define DIO_CLK_CNTL__SYMCLKB_G_HDCP_GATE_DIS__SHIFT                                                          0x17
+#define DIO_CLK_CNTL__SYMCLKC_G_HDCP_GATE_DIS__SHIFT                                                          0x18
+#define DIO_CLK_CNTL__SYMCLKD_G_HDCP_GATE_DIS__SHIFT                                                          0x19
+#define DIO_CLK_CNTL__SYMCLKE_G_HDCP_GATE_DIS__SHIFT                                                          0x1a
+#define DIO_CLK_CNTL__SYMCLKF_G_HDCP_GATE_DIS__SHIFT                                                          0x1b
+#define DIO_CLK_CNTL__SYMCLKG_G_HDCP_GATE_DIS__SHIFT                                                          0x1c
 #define DIO_CLK_CNTL__DIO_TEST_CLK_SEL_MASK                                                                   0x0000007FL
 #define DIO_CLK_CNTL__DISPCLK_R_GATE_DIS_MASK                                                                 0x00000200L
 #define DIO_CLK_CNTL__DISPCLK_G_GATE_DIS_MASK                                                                 0x00000400L
@@ -52019,6 +52074,16 @@
 #define DIO_CLK_CNTL__SYMCLK_R_GATE_DIS_MASK                                                                  0x00010000L
 #define DIO_CLK_CNTL__SYMCLK_G_GATE_DIS_MASK                                                                  0x00020000L
 #define DIO_CLK_CNTL__DIO_FGCG_REP_DIS_MASK                                                                   0x00100000L
+
+#define DIO_CLK_CNTL__DISPCLK_G_HDCP_GATE_DIS_MASK                                                            0x00200000L
+#define DIO_CLK_CNTL__SYMCLKA_G_HDCP_GATE_DIS_MASK                                                            0x00400000L
+#define DIO_CLK_CNTL__SYMCLKB_G_HDCP_GATE_DIS_MASK                                                            0x00800000L
+#define DIO_CLK_CNTL__SYMCLKC_G_HDCP_GATE_DIS_MASK                                                            0x01000000L
+#define DIO_CLK_CNTL__SYMCLKD_G_HDCP_GATE_DIS_MASK                                                            0x02000000L
+#define DIO_CLK_CNTL__SYMCLKE_G_HDCP_GATE_DIS_MASK                                                            0x04000000L
+#define DIO_CLK_CNTL__SYMCLKF_G_HDCP_GATE_DIS_MASK                                                            0x08000000L
+#define DIO_CLK_CNTL__SYMCLKG_G_HDCP_GATE_DIS_MASK                                                            0x10000000L
+
 #define DIO_PSP_INTERRUPT_STATUS__DIO_PSP_INTERRUPT_STATUS__SHIFT                                             0x0
 #define DIO_PSP_INTERRUPT_STATUS__DIO_PSP_INTERRUPT_MESSAGE__SHIFT                                            0x1
 #define DIO_PSP_INTERRUPT_STATUS__DIO_PSP_INTERRUPT_STATUS_MASK                                               0x00000001L
-- 
2.43.0

