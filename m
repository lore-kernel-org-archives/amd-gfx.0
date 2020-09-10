Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144C3C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 08:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CD42076C
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 08:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3I5EHRWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CD42076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CBC76E2A3;
	Thu, 10 Sep 2020 08:27:29 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700073.outbound.protection.outlook.com [40.107.70.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4306D6E2A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 08:27:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oG9I5BH7j2b32KhpGJ6HU6MiFYQs8w4bPlO3uMc+jhEubMAAAF/gp0Hd1nyMc/kCKlG+3nJkSc6un9X/yMQO/8vDqXbbnsRFi6VItooVL4KMM8SIfnVAsVHI9TR+kSXf7NUlkagXjm0kuHm6PxSaYs5ELGs16bDEG+lwUHiGkRxGjtiEVAfwA7rhhXL4mTipMq14ykkM5EJwBGHJa/bZjaFzxZlALSCvG3zDdMgD5w2BrauGgueovwfB0Pc+hf9RzRN/W28craYcMym0dp9sByYzFCc5so1fQQeDQhOg7jNqFWaEZdP45RkKND7mubHIKm7aDKtbBGeljvkzGvZrWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxWC8oHQ7B0sLzN9wjEATuqCZeRJvsHCJegs+KsqPEQ=;
 b=mQvQc30BorzvfBO0vCb/+lNqElm4pgsnRcxk9lSFUMcKdcjdkPlCPEROL8lp8eW17ZWcZ7eNS/Emxef8XjlOcfzSPWlqsFpO/Dsujp0sKUIF11VDfVpvzPUIIj2lI0oawtaJPmVvftpQE8vo/jrF5cLB2OO+bt7IOneJhJXhUgb5UgqcVJIJg0yD5A5ax+R9XCgMqlLcCrStHlpakTfwAVAJtgpwym3LdHafSiEIyK2taZ3cX6wYsVLtmKYg95whIdlain5U5eAnfy2rn5ttqv2UaQMu2WHhU28OTWfOjeuwadNd2M+Wssit+WAFHatmo4HFonTTfZLh5FUMYjRSbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxWC8oHQ7B0sLzN9wjEATuqCZeRJvsHCJegs+KsqPEQ=;
 b=3I5EHRWzfvEPyhe0fcGnMSFU8wJo/e8ziIMzbY6wO0/rWNQYDYSWY8plxe1WUHmanI6DCpkQf3C7QPcmjLAo3swEb+1O5XZ2wEb4AtCcK3NzA9T7Y69tDabDoYTyL57W34RmI6naNSNXiNfaapRak11TRtGRfx/R3xCwL3xVebc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR1201MB0237.namprd12.prod.outlook.com (2603:10b6:301:56::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 08:27:26 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::4956:743a:1fbe:e0d1]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::4956:743a:1fbe:e0d1%11]) with mapi id 15.20.3370.016; Thu, 10 Sep
 2020 08:27:26 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: update driver if file for sienna cichlid
Date: Thu, 10 Sep 2020 16:27:05 +0800
Message-Id: <20200910082705.2207442-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HKAPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:d0::18) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HKAPR04CA0008.apcprd04.prod.outlook.com (2603:1096:203:d0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 08:27:24 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 54777b88-a0ac-49fa-3e1c-08d8556358f4
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02379273391B312949361DEEEF270@MWHPR1201MB0237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvSeuyXAT91qFqqr3qgATsdP5LX2/nIyoYamoNhycl0WYtawTgF5EBgYjAqE+h7L/rKhNVB4EcszbZdqx7Ijr9JiMcP5V+QZFBxq1wRmjaTsxa8rvqB2TXJOo34WLOPmenHF28ZHZzFCyTYgqYb6cF+O2Jf0DMaXxmukJaDUTc3UsuzRhD9Ku6n1Jw3m3qbncqUpjBvUJ+YZPYIt69fl2wXu/btIqbZuahiCIIBmMsCr89uvrusuRv9cN4Z5+t68lTc3nI6kjSDIdwlvkHpcUd/672S/9zDlS6LsY8nsLpt79nfAxFhH3H2vlJGLYTqgI+UP3ZhUuv9EqdpTkQzP/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(54906003)(16526019)(7696005)(956004)(2616005)(52116002)(8936002)(15650500001)(8676002)(36756003)(6916009)(4326008)(66556008)(66476007)(83380400001)(66946007)(5660300002)(316002)(478600001)(6666004)(66574015)(186003)(6486002)(86362001)(2906002)(26005)(1076003)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uBIaG3ZQth8E7iwaLsfRJIBpQGmqu+gYb7M71+GB3RtjLHpk/z+vIWqBITWl4yF4g6hKZ2/mRuNJRSoFC7gdmfhttMSYr+niRDfPcDUIZt1mbwKOk3V3NX4QM56NIEOSBKimKJXZdQBg67VaPtbDwJKZEPmm3ix9UKhn9fDGs9SHeC155HrOMRaK8IeD0adLcB7qbweCC2zAKElxpDYppuHuMmDgQTa0lmFil9JtYOcVju4QRcf+e8mOgWOEi4VHId/Gt56/KsyWmg5KjHGEh1dPbhXEs8w10aaPUmVwklKjzibgEjqIg5okZYg7NrBBU69skslLdoyFm+9H89fOwEa8dg7IlxoVOPiVi2RpHgeB/EjcvQDtGzmRweqGUCEXZwJ7HUSr8tm3jbOHy0CF4PakdSrj+5hPESfqrrwMqlcgyayYDgtoyWdpveBALgyaM9Un5ifg6Q8ONEWIOLl7m4OCWRHK7TE4KJ3KxLAV+yx/UOKArH/1/fbI9bklc1iKLHWNErVzcgj2eOkRtFZYHO4/KM3Gvsq04SNxT4t/NnYxOKPq1qiI63I6Q0pMuogTImCJ+T/8Oz69wOSD81ZYc3cHNJSxdnoBJgV/62bn9hkcVVIPsXNJn5R7ULZvnFT96MpnzsTW8x+B2Atb7R/CmA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54777b88-a0ac-49fa-3e1c-08d8556358f4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 08:27:25.9408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OclNKSDpTa55BjXrvA/r1VBtZOgXBjALzhDlPyFlFR8dTRzNrNZae5U5qw38MvIq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0237
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
Cc: Likun Gao <Likun.Gao@amd.com>, Jiansong Chen <Jiansong.Chen@amd.com>,
 Kenneth Feng <Kenneth.Feng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Update drive if file for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I53e5210acb760901622cd50aaf81193e9699feba
---
 .../pm/inc/smu11_driver_if_sienna_cichlid.h   | 20 ++++++++++++++-----
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 -----
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
index 5ef9c92f57c4..11a6cf96fe0c 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
@@ -27,9 +27,9 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if 
 // any structure is changed in this file
-#define SMU11_DRIVER_IF_VERSION 0x35
+#define SMU11_DRIVER_IF_VERSION 0x37
 
-#define PPTABLE_Sienna_Cichlid_SMU_VERSION 5
+#define PPTABLE_Sienna_Cichlid_SMU_VERSION 6
 
 #define NUM_GFXCLK_DPM_LEVELS  16
 #define NUM_SMNCLK_DPM_LEVELS  2
@@ -169,7 +169,7 @@ typedef enum {
 #define DPM_OVERRIDE_DISABLE_DFLL_PLL_SHUTDOWN       0x00000200
 #define DPM_OVERRIDE_DISABLE_MEMORY_TEMPERATURE_READ 0x00000400
 #define DPM_OVERRIDE_DISABLE_VOLT_LINK_VCN_DCEFCLK   0x00000800
-#define DPM_OVERRIDE_ENABLE_FAST_FCLK_TIMER          0x00001000
+#define DPM_OVERRIDE_DISABLE_FAST_FCLK_TIMER         0x00001000
 #define DPM_OVERRIDE_DISABLE_VCN_PG                  0x00002000
 #define DPM_OVERRIDE_DISABLE_FMAX_VMAX               0x00004000
 
@@ -793,8 +793,18 @@ typedef struct {
 
   // SECTION: Sku Reserved
   uint8_t          CustomerVariant;
-  uint8_t          Spare[3];
-  uint32_t         SkuReserved[14];
+
+  //VC BTC parameters are only applicable to VDD_GFX domain
+  uint8_t          VcBtcEnabled;
+  uint16_t         VcBtcVminT0;                 // T0_VMIN
+  uint16_t         VcBtcFixedVminAgingOffset;   // FIXED_VMIN_AGING_OFFSET 
+  uint16_t         VcBtcVmin2PsmDegrationGb;    // VMIN_TO_PSM_DEGRADATION_GB 
+  uint32_t         VcBtcPsmA;                   // A_PSM
+  uint32_t         VcBtcPsmB;                   // B_PSM
+  uint32_t         VcBtcVminA;                  // A_VMIN
+  uint32_t         VcBtcVminB;                  // B_VMIN  
+  
+  uint32_t         SkuReserved[9];
 
 
   // MAJOR SECTION: BOARD PARAMETERS
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 2a3f1ee4a50b..9dfc1c87b6dd 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -30,7 +30,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36
 #define SMU11_DRIVER_IF_VERSION_NV12 0x36
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
-#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x35
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x37
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x4
 
 /* MP Apertures */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b67931fd64b4..194abaca6948 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2295,11 +2295,6 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 	dev_info(smu->adev->dev, "SkuReserved[6] = 0x%x\n", pptable->SkuReserved[6]);
 	dev_info(smu->adev->dev, "SkuReserved[7] = 0x%x\n", pptable->SkuReserved[7]);
 	dev_info(smu->adev->dev, "SkuReserved[8] = 0x%x\n", pptable->SkuReserved[8]);
-	dev_info(smu->adev->dev, "SkuReserved[9] = 0x%x\n", pptable->SkuReserved[9]);
-	dev_info(smu->adev->dev, "SkuReserved[10] = 0x%x\n", pptable->SkuReserved[10]);
-	dev_info(smu->adev->dev, "SkuReserved[11] = 0x%x\n", pptable->SkuReserved[11]);
-	dev_info(smu->adev->dev, "SkuReserved[12] = 0x%x\n", pptable->SkuReserved[12]);
-	dev_info(smu->adev->dev, "SkuReserved[13] = 0x%x\n", pptable->SkuReserved[13]);
 
 	dev_info(smu->adev->dev, "GamingClk[0] = 0x%x\n", pptable->GamingClk[0]);
 	dev_info(smu->adev->dev, "GamingClk[1] = 0x%x\n", pptable->GamingClk[1]);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
