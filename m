Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBBFC4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C67422265
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WBYHRl3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C67422265
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF2A6EB42;
	Tue, 27 Oct 2020 09:42:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9B196EB42
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 09:42:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmvm5aXojghZQAIgxdOVAzE3aLgSc2/Zq9+gonQSjYJGowe+JzEqiS6ytxHURBRppBoWsTiPQWYsEpqmG3srSN4ypsXw3H2udlFWx0MSZSvICAI0k+8vPF/dIdIDCcvysS9DcFT286fyMUyyunLikH2ycA6gNJAwicoqLXqoFUuvuvDMGrK8pQ417w9qgYSURzLeE/NbzlVB4Bj1SWuKbURpe00xk1HrlbcR+vvxOXgzOGo4N4NJuakETE32LPuH2guvahi+3zKBvavMVk+56a8RjOmDzwb8V4xDeRhZ8Cz5Jl1lUUuqYMOqedixge9EYzBzrhxLUyxzYJvVuQSmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2rUmDAFLslSXb10bjGXqethwxwQSDUeVnWIpe1Bx1o=;
 b=Ij6bY8iK6n/hOCLW0m7pUPkwUHdWokKHiQW5/P/JVNH1euOxcHIK+Ktjq8S4d9vGRQNNuRu6mSiemMTIzQ6Vo/I4PlNW9eMo8EzCD/7fCGV0Am9Pd2coxQDX2pD0U/E7LH1dkKZ8bMtaPRIf47Bc6ndV2tN7r3T8TLdDVtzFV3zeh2J6qppu2F3o670HmBugdDUCK1xOKTQxxyo6WyOeV4G9KJ0xq05mu4UePITkzNfuvalNPawKgO2JnWREKcQ15+I/gS9CgwxnNDaW7O3aWqMc5a7ceRtPZiMw7mux0WeIsP83qwkP5KZ2LCPyggeISQTshCrc+BhXWfNlxwHNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2rUmDAFLslSXb10bjGXqethwxwQSDUeVnWIpe1Bx1o=;
 b=WBYHRl3yjiomtTwC8TkwG0w+JRm1nQ98kgAV91XppYreCRgGWFXS2kA03qi8W3y5ZQ2L5TaTWJBsMnlBb8j8f/LPx7EUfjUTu5yozPXJ/r51Y/eWqoHgr0hUIzVrOUZ1sM6M8ZKB7cGKVbQE53oavg5UqOSmnbZBUlnNHKuuhTU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21)
 by CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 09:42:11 +0000
Received: from CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624]) by CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 09:42:11 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org, ray.huang@amd.com, evan.quan@amd.com,
 Alexander.Deucher@amd.com, kevin1.wang@amd.com
Subject: [PATCH 05/10] drm/amd/pm: update the smu v11.5 driver interface
 header for vangogh
Date: Tue, 27 Oct 2020 17:41:28 +0800
Message-Id: <20201027094133.21881-5-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027094133.21881-1-Xiaojian.Du@amd.com>
References: <20201027094133.21881-1-Xiaojian.Du@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:202:2::20) To CY4PR12MB1639.namprd12.prod.outlook.com
 (2603:10b6:910:f::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0401CA0010.apcprd04.prod.outlook.com (2603:1096:202:2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 27 Oct 2020 09:42:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a60b04a1-d779-4e27-0bfc-08d87a5c9424
X-MS-TrafficTypeDiagnostic: CY4PR12MB1845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB184561D79CFBA0CC7C585B6EF1160@CY4PR12MB1845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: et0jLZdxaX7MA6p5q5FQRD6uqgiqangOK3vmTACdn52/gzksutt+JBZxA/R1E1AwKkNSUsUyFbUIRMvZVGcAWERySgTdQAlvk0zcP1LpzD2ftWUdwCMjIP+o2mTLXpHSX91dmk9EHRSDHhq2jK73JHrmGpK7G1AiFbNsA21NeocRyRm2aZY/Ol+c/JFxs7njBsicW+Z+u0PQLzPcOCjRpg0kFG0+LvTQpPq/P0EwqsbeDzAKgVq07MVNzDd/7UNLC8FC0qMf233Nz9zU6DyjMSJYOaKhoR7QGFXhdPeWBAae6UpFuLyaj7wWemZJ9pvCsgAJ2ua2UBW8NdraUut+vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1639.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(7696005)(16526019)(1076003)(52116002)(6486002)(15650500001)(8936002)(66476007)(4326008)(186003)(86362001)(8676002)(478600001)(316002)(6636002)(66946007)(2906002)(83380400001)(66556008)(2616005)(36756003)(26005)(6666004)(956004)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uUPHQUgYPAETyPQUUIRsD4Rk0trmsCSgnQPHlwEZnIo7cPNbuPX6yZvvWZ/LxN55eTGuJjQ7Q5ojSzLfOSQlVBsHcTWL0MtlUKaqUqChY1g5RrAKgBoFnAMgoxqAjpWzfgWENKZ0lcx49MVA2RkfRPUnRkeWYZ70vmbSlC23MUZO+5Ml/DmfTHV/zMfwPqPUqN+l8JYqjtYqcYI3YZdjJHhULQiUxd7fuSEwoGQ27swq43Uc5RAasNPAcSUKfNuSrBm7CYl/igFUBfEunc82BKhLNMNVFRpW9w2bwMzlmYTe55+O2XIwM2x+ZgV0DxuOfykI4MH7YDgIyMHP/W7ORZpypTo8eBQftxDCSmRfRK+QliVaypo1a3Kq/j4yKlAQ0GkRtbs9TedMf5tS+iEjvbFetTBx6VXyzsREC09+WFbjRoPLNInlv0+VJuU8gjWUpqvZGsJvKrec5+HkT2BfSsbpE8p8rPI61+KwKhU5llM1vZiuJ03z14ZtXGMy3sDjQ0ss7Edc2NB+/yVoTRcggJ+Nrd7eleEqs8OYGFdHAFTARzFaWIpFVHCgpZZH47Nkr+OgVTjhUDGnpWVkk0CaBJC8i1f43vNdNqtkoE2fd4r1n0qgctqW7F8VRfnIJiHA1qa46KqBvQ/gZe77s90spA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60b04a1-d779-4e27-0bfc-08d87a5c9424
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1639.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 09:42:11.7663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFr98piJthqeGbNYPPDiGLRYdoEDZPHzWlsdAgnvGeWhbGqTNStF9OHs2SCEkLGPjOGQ1iqK1UyVRPVMC9NCfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1845
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
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, xinmei.huang@amd.com,
 prike.liang@amd.com, changfeng.zhu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to update the smu v11.5 driver interface header for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/inc/smu11_driver_if_vangogh.h  | 70 +++++++++----------
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 +-
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
index 20f8c6f460b8..8f438c80132e 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
@@ -100,13 +100,13 @@ typedef struct {
   DpmActivityMonitorCoeffExt_t DpmActivityMonitorCoeff[CUSTOM_DPM_SETTING_COUNT];
 } CustomDpmSettings_t;
 
-#define NUM_DCFCLK_DPM_LEVELS 6
-#define NUM_DISPCLK_DPM_LEVELS 6
-#define NUM_DPPCLK_DPM_LEVELS 6
-#define NUM_SOCCLK_DPM_LEVELS 8
-#define NUM_ISPICLK_DPM_LEVELS 6
-#define NUM_ISPXCLK_DPM_LEVELS 6
-#define NUM_VCN_DPM_LEVELS 8
+#define NUM_DCFCLK_DPM_LEVELS 7
+#define NUM_DISPCLK_DPM_LEVELS 7
+#define NUM_DPPCLK_DPM_LEVELS 7
+#define NUM_SOCCLK_DPM_LEVELS 7
+#define NUM_ISPICLK_DPM_LEVELS 7
+#define NUM_ISPXCLK_DPM_LEVELS 7
+#define NUM_VCN_DPM_LEVELS 5
 #define NUM_FCLK_DPM_LEVELS 4
 #define NUM_SOC_VOLTAGE_LEVELS 8
 
@@ -160,30 +160,30 @@ typedef struct {
 #define THROTTLER_STATUS_BIT_TDC_CVIP 10
 
 typedef struct {
-  uint16_t AverageGfxclkFrequency; //[MHz]
-  uint16_t AverageSocclkFrequency; //[MHz]
-  uint16_t AverageVclkFrequency;   //[MHz]
-  uint16_t AverageDclkFrequency;   //[MHz]
-  uint16_t AverageMemclkFrequency; //[MHz]
+  uint16_t GfxclkFrequency;      //[MHz]
+  uint16_t SocclkFrequency;      //[MHz]
+  uint16_t VclkFrequency;        //[MHz]
+  uint16_t DclkFrequency;        //[MHz]
+  uint16_t MemclkFrequency;      //[MHz]
   uint16_t spare;
 
-  uint16_t AverageGfxActivity; //[centi]
-  uint16_t AverageUvdActivity; //[centi]
+  uint16_t GfxActivity;          //[centi]
+  uint16_t UvdActivity;          //[centi]
 
-  uint16_t Voltage[3];         //[mV] indices: VDDCR_VDD, VDDCR_SOC, VDDCR_GFX
-  uint16_t Current[3];         //[mA] indices: VDDCR_VDD, VDDCR_SOC, VDDCR_GFX
-  uint16_t Power[3];           //[mW] indices: VDDCR_VDD, VDDCR_SOC, VDDCR_GFX
-  uint16_t CurrentSocketPower; //[mW]
+  uint16_t Voltage[3];           //[mV] indices: VDDCR_VDD, VDDCR_SOC, VDDCR_GFX
+  uint16_t Current[3];           //[mA] indices: VDDCR_VDD, VDDCR_SOC, VDDCR_GFX
+  uint16_t Power[3];             //[mW] indices: VDDCR_VDD, VDDCR_SOC, VDDCR_GFX
+  uint16_t CurrentSocketPower;   //[mW]
 
-  //3rd party tools in Windows need this info in the case of APUs
-  uint16_t CoreFrequency[8];   //[MHz]
-  uint16_t CorePower[8];       //[mW]
-  uint16_t CoreTemperature[8]; //[centi-Celsius]
-  uint16_t L3Frequency[2];     //[MHz]
-  uint16_t L3Temperature[2];   //[centi-Celsius]
+  //3rd party tools in Windows need info in the case of APUs
+  uint16_t CoreFrequency[8];     //[MHz]
+  uint16_t CorePower[8];         //[mW]
+  uint16_t CoreTemperature[8];   //[centi-Celsius]
+  uint16_t L3Frequency[2];       //[MHz]
+  uint16_t L3Temperature[2];     //[centi-Celsius]
 
-  uint16_t GfxTemperature; //[centi-Celsius]
-  uint16_t SocTemperature; //[centi-Celsius]
+  uint16_t GfxTemperature;       //[centi-Celsius]
+  uint16_t SocTemperature;       //[centi-Celsius]
   uint16_t EdgeTemperature;
   uint16_t ThrottlerStatus;
 } SmuMetrics_t;
@@ -197,15 +197,15 @@ typedef struct {
 #define WORKLOAD_PPLIB_CUSTOM_BIT 5
 #define WORKLOAD_PPLIB_COUNT 6
 
-#define TABLE_BIOS_IF 0    // Called by BIOS
-#define TABLE_WATERMARKS 1 // Called by DAL through VBIOS
-#define TABLE_CUSTOM_DPM 2 // Called by Driver
-#define TABLE_SPARE1 3
-#define TABLE_DPMCLOCKS 4    // Called by Driver
-#define TABLE_MOMENTARY_PM 5 // Called by Tools
-#define TABLE_MODERN_STDBY 6 // Called by Tools for Modern Standby Log
-#define TABLE_SMU_METRICS 7  // Called by Driver
-#define TABLE_COUNT 8
+#define TABLE_BIOS_IF            0 // Called by BIOS
+#define TABLE_WATERMARKS         1 // Called by DAL through VBIOS
+#define TABLE_CUSTOM_DPM         2 // Called by Driver
+#define TABLE_SPARE1             3
+#define TABLE_DPMCLOCKS          4 // Called by Driver
+#define TABLE_SPARE2             5 // Called by Tools
+#define TABLE_MODERN_STDBY       6 // Called by Tools for Modern Standby Log
+#define TABLE_SMU_METRICS        7 // Called by Driver
+#define TABLE_COUNT              8
 
 //ISP tile definitions
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index b5f0cc7829f0..2efa0dd3719f 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -32,7 +32,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3A
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5
-#define SMU11_DRIVER_IF_VERSION_VANGOGH 0x01
+#define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02
 #define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0x9
 
 /* MP Apertures */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
