Return-Path: <SRS0=LN+i=D3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AE0C43467
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 08:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6183E20936
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 08:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZkjUFMjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6183E20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB986EC47;
	Tue, 20 Oct 2020 08:57:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D6B16EC32
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 08:57:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdU/CfKrpZdYa7Si4COKNT1pDqX+XZrbuzdGSnuLqo/hdSVaTGhlaTylUBEOuNIoDZZNqL1MOpbmv4mHdMRjvETGLRrPVousBhUdGO2RkUGmHJaGqxMfv/nYpv+A99rVFDtTpZU/qAp3kJTPq4J1IED3jISsfLmxd/EYJT69ZAmYuwW7LtR091mnwq9qqT+mSyZLHuOoBTyZbhFtazpozV3foxiN/CbV8AVcs6JFM5dxiGHTra4GYklbRIsecIrnGKjoR6tRvzrTdcWPvq7i4TDxifAXlQt3700Plh4WlSRZN+99r2sfJTlR4uHR1GMMzsA//p0SZb/6EbooCjopMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JU2KkHzQQH5pVDEj+Gu1II+L3IxtLfu/EGIDFQvkgBg=;
 b=ck7ifmXol4zLDXmdXmt15QwC7vjjwsLMDzj1/OeasvtbVf+bJB2YoLM4yda85DI0LFDM3cndX0A34eiC8u1JfZc0NZ4fEesq18MVTtO/aazmXP1bgMk8kfa8Mwz+gI/ZvPp+VYfCfPDUnqLWW5uclgDcP7PBoKqsIrfLgYSfGMkEwM6LqoGaDG1wJTj+ParHAy36KkOp1ZEBo/j50uj7IsvzUAmJDy93UC9hWp+L684lhAH91sChg4HtXEGaUHenVggKVD9T7Y1vXotyGqjAQsiSL7HLmxROV3oQEgmOW4g5PNLw2BUdLpm315E6qIasXT3vnPEnL+XIGYXeZRahOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JU2KkHzQQH5pVDEj+Gu1II+L3IxtLfu/EGIDFQvkgBg=;
 b=ZkjUFMjqp+JLrkz4G3xLLMYeGDZ+D9IciVKMTfYxa1dr/YSxrDgnJIf7Ih2eJX1jm4OVsKGs90OfojU/8MqN1ZLnpRjOhPvVAGgoo0/0VPL4lIcNZfkyWnqnOuWFnlipOr7VhJ9qNKyanZRnYjpEMYDx3qyglFMB4U/fZkYqZP4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW2PR12MB2460.namprd12.prod.outlook.com (2603:10b6:907:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 20 Oct
 2020 08:57:42 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826%3]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 08:57:41 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: update driver if file for sienna cichlid
Date: Tue, 20 Oct 2020 16:57:22 +0800
Message-Id: <20201020085722.654734-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK0PR01CA0058.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::22) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK0PR01CA0058.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 20 Oct 2020 08:57:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9378fd5e-3cc3-4ece-9c54-08d874d633c8
X-MS-TrafficTypeDiagnostic: MW2PR12MB2460:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB246040F6AE8F1C835C1A7475EF1F0@MW2PR12MB2460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWdVxWtpP0ZM9wYBVj3Obq7RoBf6Uumsy43Hq/avX8QFLhom7MfK98GNDXSeZC+5568Uw7mzvRUFNMtX2XX2omDjLCLcoHUyn+9lMnvSO4WIpCuLyMaBFvZbZ4EL6JUce6rED/fUSxwqtPqGy51ud5TqB5+BFnTtuokgqdtEfRmHYFvBZodFZcRbN41sZtSnqzPIwqLoQDVt35J8+n49vSPdT/9mG99rcJ5fBCPbjpv9QukQu1xbJw3FcAXu2MWK7qWH1NGh3CN4lzSowwsphlK0ggHNG2C6u62G5DaEvkbUMLXY66djYlO7ARr3PGvVhia7+Tn97gopbUcdvVFVjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(186003)(6486002)(16526019)(44832011)(316002)(2906002)(478600001)(83380400001)(86362001)(36756003)(26005)(15650500001)(6666004)(1076003)(4326008)(52116002)(7696005)(66946007)(54906003)(2616005)(66476007)(66556008)(5660300002)(8676002)(6916009)(956004)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bIG2FCFdK+ydIVSUz6MzCEaU3Yi96RtrD/8W1QXvGeZxXMzRDm33zxGDouk1wRdo74OwebM0OBcCuo2TiXFpgc7A2Zssc6WYK4q8M3LqHH96vRoPLkaqywJOO6xT0kZzIYTX9IiIgGlvoJESburlsU4hnqg8qo2WFSg3reFm/bn5lkCk0zArfuK9WGs20VC/5kkiaqwL5AxCCrs40BeO438FLUqLGjxGh55eTKrUXCi+GwDG/d15qW/RB2fEFnxjB5RL3T0TlnNFNk6sqNjfFp34Zc5EKZqCpm+OpOydmMedwgj0yqAAnK630e6fKJgCg8mND26HZiktVq580pqgoaPc/9gBvoB2E1zuxbUG4A9zdfbQej/RDHMnfEyZPmOz84A7CnrAIXQv6b2sgGTgln5ZQHMh9tO6OX4SIou/jEmsuQ27E87UxPH+ORvn85Zpvy4nBKl6ngMdzNmfmFUlcQ95Q62gpg8BZ1/+ZoRI52LI4U0Yag7DIL6WIMi9F42qizhwk1mOG1L8VrlVzyDjuDxXwn/KU2Z3SFhFmvFYaPWMSwqnmK3i2W0GpPxfReNMigAj1NLh62SjjgWzuqWkEmJ/qQvrM7BfWJIEmcUolvYetgod0KeVXuACAiyNYtRHarwZd7jl7N6cnuVzqlQZuw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9378fd5e-3cc3-4ece-9c54-08d874d633c8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 08:57:41.7292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivnxANhSX3TUTgHJnfaCLgk/ld341pDOsLc1Ei91/6rNAtZ4oz8vqpwGXmPb51Hi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2460
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
Cc: Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Update driver if file for sienna cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Ie386abcd0a00fd904155361c9aa8c0861473552a
---
 .../amd/pm/inc/smu11_driver_if_sienna_cichlid.h    | 14 ++++++++++++--
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h             |  2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
index 1275246769d9..e418a46603c8 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if 
 // any structure is changed in this file
-#define SMU11_DRIVER_IF_VERSION 0x39
+#define SMU11_DRIVER_IF_VERSION 0x3A
 
 #define PPTABLE_Sienna_Cichlid_SMU_VERSION 6
 
@@ -226,6 +226,8 @@ typedef enum {
 #define FW_DSTATE_MEM_PLL_PWRDN_BIT         9   
 #define FW_DSTATE_OPTIMIZE_MALL_REFRESH_BIT 10
 #define FW_DSTATE_MEM_PSI_BIT               11
+#define FW_DSTATE_HSR_NON_STROBE_BIT        12
+#define FW_DSTATE_MP0_ENTER_WFI_BIT         13
 
 #define FW_DSTATE_SOC_ULV_MASK                    (1 << FW_DSTATE_SOC_ULV_BIT          )
 #define FW_DSTATE_G6_HSR_MASK                     (1 << FW_DSTATE_G6_HSR_BIT           )
@@ -239,6 +241,8 @@ typedef enum {
 #define FW_DSTATE_MEM_PLL_PWRDN_MASK              (1 << FW_DSTATE_MEM_PLL_PWRDN_BIT    )
 #define FW_DSTATE_OPTIMIZE_MALL_REFRESH_MASK      (1 << FW_DSTATE_OPTIMIZE_MALL_REFRESH_BIT    )
 #define FW_DSTATE_MEM_PSI_MASK                    (1 << FW_DSTATE_MEM_PSI_BIT    )
+#define FW_DSTATE_HSR_NON_STROBE_MASK             (1 << FW_DSTATE_HSR_NON_STROBE_BIT    )
+#define FW_DSTATE_MP0_ENTER_WFI_MASK              (1 << FW_DSTATE_MP0_ENTER_WFI_BIT    )
 
 // GFX GPO Feature Contains PACE and DEM sub features
 #define GFX_GPO_PACE_BIT                   0
@@ -804,7 +808,11 @@ typedef struct {
   uint32_t         VcBtcVminA;                  // A_VMIN
   uint32_t         VcBtcVminB;                  // B_VMIN  
   
-  uint32_t         SkuReserved[9];
+  //GPIO Board feature
+  uint16_t         LedGpio;            //GeneriA GPIO flag used to control the radeon LEDs
+  uint16_t         GfxPowerStagesGpio; //Genlk_vsync GPIO flag used to control gfx power stages 
+  
+  uint32_t         SkuReserved[8];
 
 
   // MAJOR SECTION: BOARD PARAMETERS
@@ -1026,6 +1034,8 @@ typedef struct {
   uint16_t VcnActivityPercentage  ; //place holder, David N. to provide full sequence
   uint8_t  PcieRate               ;
   uint8_t  PcieWidth              ;
+  uint16_t AverageGfxclkFrequencyTarget;
+  uint16_t Padding16_2;
 
 } SmuMetrics_t;
 
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 75697b78c13f..820b9d34c997 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -30,7 +30,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36
 #define SMU11_DRIVER_IF_VERSION_NV12 0x36
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
-#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x39
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3A
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x4
 
 /* MP Apertures */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
