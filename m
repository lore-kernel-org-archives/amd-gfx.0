Return-Path: <SRS0=lnB5=AU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67498C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 06:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 026AB206C3
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 06:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZPXzVyo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026AB206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A55806E9A9;
	Thu,  9 Jul 2020 06:40:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6671A6E9A9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 06:40:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiEwlJCpTDI+Bql8aw0O8a3usaVvOhKDqwBGG9I/IfR54NdE6QcB0bLdYhlxkEX8mjwvlqKHdvL6pZy5Bsx9akBlAGPvRFe7wwlTxKQjUXQNmZZVa2tD10LpipQeOdELlT5FmJQMNGcvVdOdqx1APGFwDGa3zPTX1Qj0tR1fOPTiDYvildJHELX9ii+qRLC++FtVLF30LAbVZiVRLujGEOj37OhCg3eJx5xiPLKwv+Kx8zyfgpc2xwnyXPNtSCkHhyPUMZ5fkk4O5ysGj9LYMNUn04FYbG5pE6qT2/A12ogC7DFlaK7VKY4pfzZqskiDbUN3QwsV6rjxuHgmpxuhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjzfxgVDQ4aCSvQHZPRiJhNCozJhcebPn7hjM0YaYTg=;
 b=NvXEOvsYsAMzaPSZd1LPqx86blWuaY8FYqBjVTkRoAFGYGLZcwRTpYXc/HvUs/MY7VuYPfdx6qLtw3FZvyEISDIyeMXAKBQmlRNJrbFAE0jEAhIu+OEaDO5AR3cTYXhNb8Q2z90hy1cxDtqys2UANRF0kRS01NMNxotNo0dbSoTtX1GOi8UxWIbE2VfH1wGJEh0RHxa6FPXyjch+BsP9SWAmYKe3B6Z9VZHUyPEOFUh07LP8PqQY1/32kV3R6885/CTi50n/VZMYMuaRqhfQftgkNus0NlyoZcb2zyCAAx5qS8runVognR2maXzcxYn0A0Vqy+ouXaIk+8dN69vskw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjzfxgVDQ4aCSvQHZPRiJhNCozJhcebPn7hjM0YaYTg=;
 b=ZPXzVyo67ktmydCYzoWOMQav5oysZ9mcfsI5bF82vXAj4sI4qIoJHFyymuz51ATyJ20x0GEBoxrlRoy03xTByF8Uwb63qs/1pNq4T0coBYN81ibj0CAV+uEVL1KDa7oRb2jpIxAPRMCnXOT7taE4RAkQ+Ob6OrQrtIQXqom+Cos=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR1201MB0174.namprd12.prod.outlook.com (2603:10b6:301:55::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Thu, 9 Jul
 2020 06:40:05 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2%10]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 06:40:05 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: update driver if file for sienna_cichlid
Date: Thu,  9 Jul 2020 14:39:45 +0800
Message-Id: <20200709063945.3097737-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HKAPR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:d0::13) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HKAPR04CA0003.apcprd04.prod.outlook.com (2603:1096:203:d0::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 06:40:03 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c4e0f29-6431-4296-6490-08d823d2e9f1
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01749E72DD53A08F3BF2854FEF640@MWHPR1201MB0174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 04599F3534
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EdJzDHnaKjHw5129X/pYwgRxI6lDfxvSYa1u7jNV3gUcYMEY4a8d2UeDNF4ZrLcOQxkHYubQvAXMRE8VPmYh/djvQ2nO3uM+F2+T5l9vVCYi3XpwvHPJqeUB/6bS6E3doEgAuimfG5OPXvLsAjuw3M/W3yZ+wMJ6SrJWYCM11GfIgfmG74Fwk79SSsfydusI5srr271tjds6tTtVtICM8StLcJQw49nf8CQbNQKhXRcdSSlGC0GkZfUjxZjcXyGMXA7GovgnSB8NzcBWF2Ham/JA7ZVB8QkwJfKrGdKraa++HttfkkIzay3poUJiJvpSzbEHXc0vh3Y0JtVQvnjx+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(26005)(8936002)(83380400001)(36756003)(66556008)(66476007)(8676002)(478600001)(2906002)(66946007)(7696005)(52116002)(16526019)(186003)(54906003)(5660300002)(6916009)(956004)(2616005)(15650500001)(316002)(44832011)(86362001)(6666004)(1076003)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bBv2iS2zMZ9Lyl0wfyWK9+/Bcj0vo82pGw+jFHAfn/6dVQpxakiGXgNdY7TAW6OmUa7wc3yVGLBPthi6+RkO6rFs1WSFci/0IUDXrXvDghYMQKUx1UAqAzpQhxVH1lZcnt2sjY4vfZfcr8OHJLfyyOXsXzif871wDqTCe0Dsw6oy3nvZEL2GC1gvUS75l8agQ9cJzcrKv71b8BBY4wf7qVtATZOcX9xNeLC59vnhe4NrUfvJbJ7jaehDJNa3IAcXH7qm5QN5Ch+gzNXlR0rgl3ikGO6q0gNRZk04Zx69XtsmEDmHNDBqhNvwANUuhGaOm9cK9VDYa700S02yX25QRqNbdOSPC+RFhQehWhqFTQsMgPa1xcrWThGkcQcIIWwTasmukOMa7W9iO5/FLkhy/KSALcj4em2mlH6MoN96qcdwIex/999pW0DNzDEp5ZXSoGpwgGEu/IZINg4oCBPP7q61erNMIL9mmbE1uwTnNm0jdECcL5H05jV2R/Htmhcb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4e0f29-6431-4296-6490-08d823d2e9f1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 06:40:05.0219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTnFCxABxpUu/SSqsjzCh86lf7ts2NoqsNcmbHPM19Ja3E1rPHvU3wSdnJSg/BlV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0174
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

Update sienna_cichlid driver if header and related files.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: If303e7fca32ebf922ee5d918855bbaca8dc61d38
---
 .../inc/smu11_driver_if_sienna_cichlid.h        | 17 +++++++++++++----
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h   |  2 +-
 .../gpu/drm/amd/powerplay/sienna_cichlid_ppt.c  |  1 -
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
index 302c2bcf9404..b2232e24d82f 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
@@ -27,9 +27,9 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if 
 // any structure is changed in this file
-#define SMU11_DRIVER_IF_VERSION 0x32
+#define SMU11_DRIVER_IF_VERSION 0x33
 
-#define PPTABLE_Sienna_Cichlid_SMU_VERSION 4
+#define PPTABLE_Sienna_Cichlid_SMU_VERSION 5
 
 #define NUM_GFXCLK_DPM_LEVELS  16
 #define NUM_SMNCLK_DPM_LEVELS  2
@@ -128,7 +128,7 @@
 #define FEATURE_2_STEP_PSTATE_BIT       46
 #define FEATURE_SMNCLK_DPM_BIT          47
 #define FEATURE_SPARE_48_BIT            48
-#define FEATURE_SPARE_49_BIT            49
+#define FEATURE_GFX_EDC_BIT             49
 #define FEATURE_SPARE_50_BIT            50
 #define FEATURE_SPARE_51_BIT            51
 #define FEATURE_SPARE_52_BIT            52
@@ -564,6 +564,12 @@ typedef enum {
   TDC_THROTTLER_COUNT
 } TDC_THROTTLER_e;
 
+typedef enum {
+  CUSTOMER_VARIANT_ROW,
+  CUSTOMER_VARIANT_FALCON,
+  CUSTOMER_VARIANT_COUNT,
+} CUSTOMER_VARIANT_e;
+	 
 // Used for 2-step UCLK DPM change workaround
 typedef struct {
   uint16_t Fmin;
@@ -786,7 +792,10 @@ typedef struct {
   QuadraticInt_t    ReservedEquation3; 
 
   // SECTION: Sku Reserved
-  uint32_t         SkuReserved[15];
+  uint8_t          CustomerVariant;
+  uint8_t          Spare[3];
+  uint32_t         SkuReserved[14];
+
 
   // MAJOR SECTION: BOARD PARAMETERS
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index d07bf4fe6e4a..b2f65438ad8d 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -30,7 +30,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36
 #define SMU11_DRIVER_IF_VERSION_NV12 0x33
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
-#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x32
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x33
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index dc5ca9121db5..3efa41444ddf 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -2317,7 +2317,6 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 	dev_info(smu->adev->dev, "SkuReserved[11] = 0x%x\n", pptable->SkuReserved[11]);
 	dev_info(smu->adev->dev, "SkuReserved[12] = 0x%x\n", pptable->SkuReserved[12]);
 	dev_info(smu->adev->dev, "SkuReserved[13] = 0x%x\n", pptable->SkuReserved[13]);
-	dev_info(smu->adev->dev, "SkuReserved[14] = 0x%x\n", pptable->SkuReserved[14]);
 
 	dev_info(smu->adev->dev, "GamingClk[0] = 0x%x\n", pptable->GamingClk[0]);
 	dev_info(smu->adev->dev, "GamingClk[1] = 0x%x\n", pptable->GamingClk[1]);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
