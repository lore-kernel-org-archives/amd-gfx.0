Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6668FC433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 04:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4ED2053B
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 04:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sv+tsHi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4ED2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 873706E087;
	Wed,  3 Jun 2020 04:36:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8141F6E087
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 04:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djGMUBLoBZh0cE3zP7ViYyBRHqfuex8wDNq4wDK8lUghKKOKLASiO6K5+d+RTvdTKQkt3qetOzG+maz6Ml6pYptjr8z9xpbiO5icuQeVMjIIJJsGgidBOqTxoMVMf92mew5y+5WQym9URe0vtvxYMM7E4CkZCYxEfUhLYFM0oKs5w3gbCabdJlYaiBxiSKWhmlhyfguk/D/Ynl+HsKOlTRdD7wYjwZH8clM5GuFL65M5l0vlZ1Mz2cdtDIFx9e+C/BJHSLP47nNkGUChy1toirzLeidcs7OtvTMuzlky9bhQee8o7slJM2mo7p9SKxzlJAlbJtodNq40ANCury27zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZG2KOWcCc+8JYStSe2XBYRT6agr/99RdixjJxKadeXE=;
 b=QcSQX5IF9pM2UHSJfgATI+TB4cMteLMMApUaPHtvASxFqv5eXvmF/lDL+sPTm1Q4qelzIpRgq+WdNuW9nk8vZQds7IQX/AvZJUKCL/7N445ywzEw89NKpwQS9EUh8CF8fr8vYV8soPLIeNWiUQ6Uic7V2kcWxUM+2Bi3IGfPaL3JRPE0dmtwAVwYSn5093SvMXcJWwe0C89s7Y5dmi5S4CJwjFczj8rH5woQsGK+v6SeSq3D+sgdixEW5AIDKkEiJpsoxvwZxSQzbWstMEhxOQoYAWFh+seyg3XEFqQhas34i9Hp2u/RuJ1CZMkt/Bs0qIHb/rX4OY4xxygFWrd5aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZG2KOWcCc+8JYStSe2XBYRT6agr/99RdixjJxKadeXE=;
 b=sv+tsHi+FHxkW7vZQmqqJ/nz5cWi0z4s36T5qtDNkh1lvEVRLdOPNW4rfBLv6rhN5Tgcs10OyBbklUjXO0BJnu/bunQ2Rs8V7cZeQS2grECCwwkNR7wPMR8B0ETDymXQug8/SJspTwu9mOfUV0uG1XvSAUIF+TDeXL2lFWSAVxo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19) by CY4PR1201MB2532.namprd12.prod.outlook.com
 (2603:10b6:903:d8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Wed, 3 Jun
 2020 04:36:19 +0000
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::b1bf:dda1:dd1e:8e30]) by CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::b1bf:dda1:dd1e:8e30%5]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 04:36:19 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: update driver if file for sienna_cichlid
Date: Wed,  3 Jun 2020 12:35:46 +0800
Message-Id: <20200603043546.3330085-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2P15301CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::15) To CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2P15301CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.3 via Frontend Transport; Wed, 3 Jun 2020 04:36:18 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d3bcd46-661a-4169-abd7-08d80777a93f
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2532:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB253257AC2C47C40AF6F52097EF880@CY4PR1201MB2532.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zbw7tYJjKE/sLycaDLtpGM6Ojqk9H7WJaHhh9XtMVyM3DBwM+OHLzV7EzI1QY1Ey+TFSikuu+b4YDk/rbBFi5lmMu9anLVTm6iH/Kd8ctz4NLM/iMvILEqc2ca8oCnty3ekKv1qFqufg+cNUBUytlzTHSH1d70JYSA30EQ0T1p6iOnkpUQu2ANYKBYK06bmSBghds/TEnXyHdofNfmlJcvGZ7vWT30A+Bkq5TeZJIJF4sMK07M89fBMvXJypuHshl4A8ww74445IQCucfyH5C1piimjDEDsjy7XfAkPVKzgrdcYT79r2NNZO4ioBIUV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39850400004)(366004)(376002)(396003)(136003)(66556008)(66476007)(15650500001)(6486002)(66946007)(5660300002)(19627235002)(6666004)(83380400001)(1076003)(36756003)(2616005)(8676002)(2906002)(26005)(16526019)(8936002)(186003)(478600001)(4326008)(956004)(86362001)(52116002)(6916009)(44832011)(316002)(54906003)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Xyzn16tPFqaXyMVErFFZSzPH1LzNdXTLTpooAZ5Zz4CmjSmnCKqmXkx5yM18jjX0Sylbta6hYfRfCqZl5a70/iJlTUsBi2m2qkqfezt/1jxbUnoWeHe9F3F4Pelerqn52nJT5LwySELr01uktnnko+BCkNaZ2EMh9ZQNTpCrF4Isz1XUZLC2g02Ya1k1hVpzTbGvwtsPZXh4cHNgR9J6F32aVfpd+Aoheen+iThjMc2GxGmTcxSA6FSa21xaCBWTNDEIxxZMhSwHRCW+CZRDtWTSWH51immtHgQGXkYAvj0soo8W6bHnvUDi4O8QytRzZwEd9P0tNgUoATvkx2M1cN0j11GlLWAurxb0MAI2xXJ+prjo5BZSz0JSsOPFukodRZ3dJzQqoMYtOvQ3hfh69N1/yAqNUnpUXWjXg8h0LTes66UJgqDDB8prYwLfgLPuX8wfhHtSAlfCoCkDJ7+RUYnmsQmYz7hM+fwk3aPh+UZm8RLKhydhMdEV1rDM85Fm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3bcd46-661a-4169-abd7-08d80777a93f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 04:36:19.7119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLbzGNLj7gVvh23/EMtN3oQGvX7oiRMq+Osu6sXbwxAe6UzmXjUAxLId62m7YdQH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2532
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
Cc: Likun Gao <Likun.Gao@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Kenneth Feng <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Update sienna_cichlid driver if header file to match pptable changes.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Ie0652935d512124c03f16ae75c44e134567ef5da
---
 .../inc/smu11_driver_if_sienna_cichlid.h        | 17 ++++++++++++++---
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h   |  2 +-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
index bdffba1f0086..5322f6da3071 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if 
 // any structure is changed in this file
-#define SMU11_DRIVER_IF_VERSION 0x30
+#define SMU11_DRIVER_IF_VERSION 0x31
 
 #define PPTABLE_Sienna_Cichlid_SMU_VERSION 4
 
@@ -914,12 +914,14 @@ typedef struct {
   uint16_t     GfxActivityLpfTau;
   uint16_t     UclkActivityLpfTau;
   uint16_t     SocketPowerLpfTau;  
+  uint16_t     VcnClkAverageLpfTau;
+  uint16_t     padding16; 
 } DriverSmuConfig_t;
 
 typedef struct {
   DriverSmuConfig_t DriverSmuConfig;
 
-  uint32_t     Spare[8];  
+  uint32_t     Spare[7];  
   // Padding - ignore
   uint32_t     MmHubPadding[8]; // SMU internal use
 } DriverSmuConfigExternal_t;
@@ -984,11 +986,20 @@ typedef struct {
   uint8_t D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
   uint8_t D3HotExitCountPerMode[D3HOT_SEQUENCE_COUNT];
   uint8_t ArmMsgReceivedCountPerMode[D3HOT_SEQUENCE_COUNT];
+
+  //PMFW-4362
+  uint32_t EnergyAccumulator;
+  uint16_t AverageVclk0Frequency  ;
+  uint16_t AverageDclk0Frequency  ;  
+  uint16_t AverageVclk1Frequency  ;
+  uint16_t AverageDclk1Frequency  ;  
+  uint16_t VcnActivityPercentage ; //place holder, David N. to provide full sequence
+  uint16_t padding16_2;
 } SmuMetrics_t;
 
 typedef struct {
   SmuMetrics_t SmuMetrics;
-  uint32_t Spare[5];
+  uint32_t Spare[1];
 
   // Padding - ignore
   uint32_t     MmHubPadding[8]; // SMU internal use  
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 4ad3f07891fe..282eb45e7b86 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -31,7 +31,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36
 #define SMU11_DRIVER_IF_VERSION_NV12 0x33
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
-#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x30
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x31
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
