Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FACAC2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 10:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCDE020692
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 10:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BQR/8hAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDE020692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E5D89BBE;
	Mon, 13 Apr 2020 10:57:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E2689BBE
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 10:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBaxhOBZ2GAgj9oscnWF+UOaNRqvlRIPt36lBvJ3HSAr2NnrM3r2kTXqUaSfNquh0R3++eVhNt27Il7/bsXGgCRXbakMEDXhswbvQ9TUm0bKn4ZxsafgeVaGiJMsbT2pDIf4vK56qOVto6J9pA5mtjqn66kj2vQ4QHn5MoUEvxg288WwiwNZZpaMVok0NHyyjdAUkL0K6Ew4JJFSSI7pgQIouLm6YH8XWyGhf4E4GIeHqJvaQPlro2Qv/w6p9W4yvu3oOI/Nsw9zYWsZlKf7/7kZtJhtqyyXLFHt1ukoVOCqLuBp6TUZ/apwvGSnpcEod9G//k1SsGhZaFRo9jXCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJqd5rP5xA393PWkH/17tMQY3T66a5NR4nL1yclO3dc=;
 b=OAepZpXfvSWSYwQuz3kcJJdGPDQo+24/yZCjgQcXmrx6kib2FMijFRhgoQf+rFmdgzmIeU5UD6DtKzJEV31yudEbQlmhaN57RO2gz2w9AHasNRPV44r0SzE4QAxa9wDVd1seMbrIO4lVRBBqZeFdGBfg09B93+HmoIIJqoFd1WnHpaURS3MiAwqUo1DPsVSofub9ZlHuk/gHZzcZYzs7gbEXmyMKSg0C/XKRStNulwbnwjvOc2BwAtv/jW7InBcdm0/uLo7KMsVYHdbKsUX1s+j74e8JKnGtiRy86Qj6ceru6+Xm+JSTL3vhlHPat5XuiCFZd6bPEoyPjdAtuYbP7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJqd5rP5xA393PWkH/17tMQY3T66a5NR4nL1yclO3dc=;
 b=BQR/8hAAsbb53X1ZN2AzPAGUyaKDS2iP3aV65u71fsyfIo4sJRqKxOWXD2FikaRlqB2RpqoZF3/FJiO3hLVcjYOBdOj38HtsZbXUTYlTR56orw+wmBd/KASM8H7NVGP6+X6IzE0zxyhQbNRG4yU/+aXUUvWmdQwp4lDVYctuKkk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2844.namprd12.prod.outlook.com (2603:10b6:5:45::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.28; Mon, 13 Apr 2020 10:57:01 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 10:57:01 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: update Arcturus smu-driver if header
Date: Mon, 13 Apr 2020 18:56:41 +0800
Message-Id: <20200413105641.15276-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
X-ClientProxiedBy: HK2PR0401CA0021.apcprd04.prod.outlook.com
 (2603:1096:202:2::31) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0401CA0021.apcprd04.prod.outlook.com (2603:1096:202:2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Mon, 13 Apr 2020 10:56:59 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b877c4f0-a9d8-4ce2-ccf7-08d7df99648c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2844:|DM6PR12MB2844:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB284487B9D6E400616A6C64CEE4DD0@DM6PR12MB2844.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(66556008)(66476007)(5660300002)(1076003)(2906002)(66946007)(44832011)(956004)(316002)(6666004)(6486002)(2616005)(86362001)(8676002)(4326008)(81156014)(26005)(36756003)(8936002)(186003)(16526019)(52116002)(478600001)(7696005)(6916009);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PElkPUN8XIMvrMkCZTrOPboXJ3ew4oqOjnl66euxXYFKb0b8KTaVYwBDBKh+bAd5ya9aUujg7UQeb6yxqNUDakLqsWpUrSCyPqqptq02uA0I6G1KpoSvRD1hJhtRaSuyOd5LZEi6e8sapc+iMW5uZ/3I5b/JB9noaIF99v8XcS89jEe3Snup4aex3x6axOUv916UPINhet/Gi5iroIkgKqCDlrq4orHaH/gtSmx2Y4eRCirCiRmUq1L65qGMs8sNTT3k+sL/LDhNS3HAy81eDnZCQeRTG1BeV8HKrO6CxXiEMTSUVh/P8S0Pw8uy+yZymdGk1tfuMBzm7l8EWWLbjnU+Ah6957+JyBYyUj1K9+QCuPjGnnTJmNs3p/rQuMJoCqxY5je/lBx/EIHg0dxZsMaysrCYJQ1ohZK4b1inj/aMI2/ySF/73TRWzw58Mom0
X-MS-Exchange-AntiSpam-MessageData: LctqmhBa2CGMzuCDMEdvCaxcEkGIXFyqrTwiH4KYYXzcBkSDvg1x15ACj4MT5jfz2kIghxRllZNblQ1M2Myl0rpEyBGuFwVsXAnB+W9kEgkKaPFzRxqe6vmLTQta7S5l8El5ZAkhlCeUrQV3wG8lvw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b877c4f0-a9d8-4ce2-ccf7-08d7df99648c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 10:57:01.0341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zvHB1jgWD/55DoqCMv6bL3YcBz9XsHbboNSJtHTnHbLMgeoduXf1RdyF5OW0sXf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2844
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
Cc: Evan Quan <evan.quan@amd.com>, kenneth.feng@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To fit the latest PMFW.

Change-Id: I1ebc5a4c3386e07a9fed73e4bec2c5d1ab8d4b23
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../amd/powerplay/inc/smu11_driver_if_arcturus.h  | 15 +++++++++++++--
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h     |  2 +-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
index ce5b5011c122..8b82059d97e7 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
@@ -82,8 +82,8 @@
 // Other
 #define FEATURE_OUT_OF_BAND_MONITOR_BIT 24
 #define FEATURE_TEMP_DEPENDENT_VMIN_BIT 25
+#define FEATURE_PER_PART_VMIN_BIT       26
 
-#define FEATURE_SPARE_26_BIT            26
 #define FEATURE_SPARE_27_BIT            27
 #define FEATURE_SPARE_28_BIT            28
 #define FEATURE_SPARE_29_BIT            29
@@ -154,6 +154,7 @@
 
 #define FEATURE_OUT_OF_BAND_MONITOR_MASK  (1 << FEATURE_OUT_OF_BAND_MONITOR_BIT   )
 #define FEATURE_TEMP_DEPENDENT_VMIN_MASK  (1 << FEATURE_TEMP_DEPENDENT_VMIN_BIT )
+#define FEATURE_PER_PART_VMIN_MASK        (1 << FEATURE_PER_PART_VMIN_BIT        )
 
 
 //FIXME need updating
@@ -628,8 +629,14 @@ typedef struct {
   uint16_t BasePerformanceFrequencyCap;   //In Mhz
   uint16_t MaxPerformanceFrequencyCap;    //In Mhz
 
+  // Per-Part Vmin
+  uint16_t VDDGFX_VminLow;        // mv Q2
+  uint16_t VDDGFX_TVminLow;       //Celcius
+  uint16_t VDDGFX_VminLow_HiTemp; // mv Q2
+  uint16_t VDDGFX_VminLow_LoTemp; // mv Q2
+
   // SECTION: Reserved
-  uint32_t     Reserved[9];
+  uint32_t     Reserved[7];
 
   // SECTION: BOARD PARAMETERS
 
@@ -869,6 +876,10 @@ typedef struct {
   uint8_t   Mem_DownHystLimit;
   uint16_t  Mem_Fps;
 
+  uint32_t  BusyThreshold;                  // Q16
+  uint32_t  BusyHyst;
+  uint32_t  IdleHyst;
+
   uint32_t  MmHubPadding[8]; // SMU internal use
 } DpmActivityMonitorCoeffInt_t;
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index e786d63b1e79..464d40983de9 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -27,7 +27,7 @@
 
 #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU11_DRIVER_IF_VERSION_VG20 0x13
-#define SMU11_DRIVER_IF_VERSION_ARCT 0x12
+#define SMU11_DRIVER_IF_VERSION_ARCT 0x14
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36
 #define SMU11_DRIVER_IF_VERSION_NV12 0x33
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
