Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F57C55ABD
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 03:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C378206E3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 03:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CqFAHVBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C378206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2CB7899D4;
	Wed, 11 Nov 2020 03:04:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EE0D8920D
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 03:04:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiXKasw0VeCvvNaJhP+rTMhIreFA3O0i3SGvzQkUL93L2ickUrGhPchXk1cBHknffj9uL2C1aVBsgiU25PXy0izENHp0771w3ESZb7v9/EdiggOdhYS8U/MJgNmnp+MKMR7lRAXrWBN+oUKZaP5UVxU+j0JSYXQMtSDzgsAJNCEWlvTMlDguuos8bHeYqcPlfIxa6uith0zoB9F+axbWA8Swqd0eGASj82c3n0bE8Lec/AQpPRuLu19F4X0H6MLgoKPs4q1CjK3qPyli/pmxwjZx/VyKD7bLpbVesEUR5mBlnyY6GIydAiliKy5UsnL19/6Hsj3eUxyqTxHuacwuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcUVPeV7GW3rM6mtyssROnKn3R9rwyVhMfW9TZA2Btw=;
 b=S86YZE0cZdz9+Kuf2iH9jBMwiENKSAXLzmifS7dkzopjFAC0vD7bV6sM2SI/o8qswN31tGhEc+XPWDud+Qf+jpF4qo6rkkVlvZPy5jLWnqrfQCzRX4SE1YjEvdv7En3FNJkLyxuGsT8rse+z3+EU00yeosofXhqGE5/9JUckWZ6YrYqkR6jXKh2ZW+nveyIegZzIJg9KijVVojlteVqga1zPF3beRg5aaWqYQ5CHqLYt013wPwafJD4YjnbSvKLk6o3jw0+JumXBoLSuDfceh7VuXp9A1woCPFKPnWQ1tb3OyS1AeS1/uVQo3J+ZppfIpr3KJ7Mmzzy0FtlsyxNq1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcUVPeV7GW3rM6mtyssROnKn3R9rwyVhMfW9TZA2Btw=;
 b=CqFAHVBMAdf8Q6m9x5C6UfDmD7/1PEmMKlUjQbGQifYVGdgKu662uFb0yF1NrAEp6n0+oa5JiEm2cdZgnAID5d/FKjJpjLDDZlF+sqpFih45B5fbQXrgNhyrIwtk26BvYRvbZb7kJdv2wHizLWwAac87KFY9mHEZG2fgQ8IOzKE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21)
 by CY4PR12MB1382.namprd12.prod.outlook.com (2603:10b6:903:40::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 03:04:43 +0000
Received: from CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::ecae:a003:1c8c:c99f]) by CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::ecae:a003:1c8c:c99f%5]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 03:04:43 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: update the swSMU headers for vangogh
Date: Wed, 11 Nov 2020 11:04:18 +0800
Message-Id: <20201111030418.27296-2-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111030418.27296-1-Xiaojian.Du@amd.com>
References: <20201111030418.27296-1-Xiaojian.Du@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR04CA0056.apcprd04.prod.outlook.com
 (2603:1096:202:14::24) To CY4PR12MB1639.namprd12.prod.outlook.com
 (2603:10b6:910:f::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR04CA0056.apcprd04.prod.outlook.com (2603:1096:202:14::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Wed, 11 Nov 2020 03:04:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f2517653-5dea-4518-472c-08d885ee89b9
X-MS-TrafficTypeDiagnostic: CY4PR12MB1382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1382044FEF6E32103AF17F2BF1E80@CY4PR12MB1382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0XDU46/csTV+xS/GI0l2wVS7CvDz72GGQMPexUdU/VNyrttkIFBzGW6isVwU6RsK1hAnjbvK4ebUSoIqTTU0zFbqsmJ89SN5nBKQ2UWn9BRKTuUvrHYKbZL4fwRqpDGTxnOr1isl3EtXWgSe+pFHkwQ9RC7LWb0B+YhzBi/mNXhwYkK21N8QKJrWuAtjpgKNAg5Y22sNc4i26XoQzwus46KlptxKe0mZ5xrhzksGa5p54bYu7IRNpgC/mtfyHHX2z1bKUi9SldAX7a6ST0wXPHEaLenLvNStJPh9ScJdsNs73t9laBcuhMbmCGqSj+lnpZ8b2hqo2Jo21FS4iPdjCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1639.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(4326008)(16526019)(66556008)(2906002)(6486002)(66476007)(36756003)(186003)(6916009)(8936002)(8676002)(478600001)(15650500001)(86362001)(52116002)(5660300002)(7696005)(316002)(26005)(66946007)(83380400001)(1076003)(6666004)(2616005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: u2ZXO9BLXTqdYcSRHQ5u5cbJy2Jj1TjZDjw/3ax2xIzM+V1xRStZJ+xQ/9Zo6/2vU8Qi0Yb0WrUVqPj9tSMuw3HS76fWvRGL9AwgWqwMf5w/Y4ymfj59igiegiWoCAIWVNS4FCwd7tAxTV1NbgRylbwWrD0g7b71xIUMzsCQz4e4K7InRAIBRTAfE4/F2mOi/LgB0RUdwGD9Zu6cSsVuJYvsNyl5kt0h/4VRqCxuzqvyAF6hpno5JDRK0UA9u+PSKvWk1G5rlOJVrkIum9Z9Idf+P3EDCFxeRXcIeI8xJrFIpI4VgIjBMFSuWCG+8pnK7le6Nm6ap1qmxpFmOnHvD/2XORuFZPFBcNNqODRGJ8se1Tyat8ud+hX5CgLYTVG8BHK+QSM0GAsFySs5Lsg+D6REYgj6jp2h8QamZooRu2kAbDZN6lJgOVzBfgJMXJPjjZZMaICppxfa0sJPqwtydNf7evaSohq26q0RefIxVU+O+1rWUEV2pC79ymIanyicjoHPl3CYnkf34JUfDmj2MKsK4yogSIyIPMTSCO25jHgBvkqEtlb9zMADoivXDuDicleMFKlKqUr+LF1+LjyA9AkWzNFsSToAgfD1iu47jT4wX9E9AWLW2Xq28ou+ILTa7uQtoz6t6B9M1SM64XxHmw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2517653-5dea-4518-472c-08d885ee89b9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1639.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 03:04:43.5465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyxwFrW7J5flh19OJBI74i/9JqVxAXmM3GVX65UneDi8ZP+bokLR6RHwKb0iQnyx0tAFbz7MmbboebKOPht+jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1382
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
Cc: alexander.deucher@amd.com, xinmei.huang@amd.com, ray.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>, evan.quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to update the swSMU headers for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h |  6 ++++++
 drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h          | 11 +++++++----
 drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h         | 11 +++++++++--
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
index 8f438c80132e..1c19eae93ff1 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
@@ -142,6 +142,12 @@ typedef struct {
 
   uint8_t NumDfPstatesEnabled;
   uint8_t NumDpmLevelsEnabled;
+  uint8_t NumDcfclkLevelsEnabled;
+  uint8_t NumDispClkLevelsEnabled;  //applies to both dispclk and dppclk
+  uint8_t NumSocClkLevelsEnabled;
+
+  uint8_t IspClkLevelsEnabled;  //applies to both ispiclk and ispxclk
+  uint8_t VcnClkLevelsEnabled;  //applies to both vclk/dclk
   uint8_t spare[2];
 } DpmClocks_t;
 
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
index 99a406984135..22edd88b8117 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
@@ -90,14 +90,16 @@
 #define FEATURE_ATHUB_PG_BIT          56
 #define FEATURE_ECO_DEEPCSTATE_BIT    57
 #define FEATURE_CC6_BIT               58
-#define NUM_FEATURES                  59
+#define FEATURE_GFX_EDC_BIT           59
+#define NUM_FEATURES                  60
 
 typedef struct {
   // MP1_EXT_SCRATCH0
   uint32_t DpmHandlerID         : 8;
   uint32_t ActivityMonitorID    : 8;
   uint32_t DpmTimerID           : 8;
-  uint32_t spare0               : 8;
+  uint32_t DpmHubID             : 4;
+  uint32_t DpmHubTask           : 4;
   // MP1_EXT_SCRATCH1
   uint32_t GfxStatus            : 2;
   uint32_t GfxoffStatus         : 8;
@@ -109,9 +111,10 @@ typedef struct {
   uint32_t spare1               : 16;
   // MP1_EXT_SCRATCH2
   uint32_t P2JobHandler			: 32;
-  // MP1_EXT_SCRATCH3
-//  uint32_t spare2               : 32;
+  // MP1_EXT_SCRATCH3: used for postcodes
+
   // MP1_EXT_SCRATCH4:6 are used by Kernel
+  // MP1_EXT_SCRATCH7: used by HW
 } FwStatus_t;
 
 
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
index 1ada0eb64663..7e69b3bd311b 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
@@ -97,9 +97,16 @@
 #define PPSMC_MSG_StopDramLogging                      0x3F
 #define PPSMC_MSG_SetSoftMinCclk                       0x40
 #define PPSMC_MSG_SetSoftMaxCclk                       0x41
-#define PPSMC_Message_Count                            0x42
+#define PPSMC_MSG_SetDfPstateActiveLevel               0x42
+#define PPSMC_MSG_SetDfPstateSoftMinLevel              0x43
+#define PPSMC_MSG_SetCclkPolicy                        0x44
+#define PPSMC_MSG_DramLogSetDramAddrHigh               0x45
+#define PPSMC_MSG_DramLogSetDramBufferSize             0x46
+#define PPSMC_MSG_RequestActiveWgp                     0x47
+#define PPSMC_MSG_QueryActiveWgp                       0x48
+#define PPSMC_Message_Count                            0x49
 
-//Argument for  PPSMC_MSG_GpuChangeState
+//Argument for PPSMC_MSG_GfxDeviceDriverReset
 enum {
   MODE1_RESET = 1,
   MODE2_RESET = 2
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
