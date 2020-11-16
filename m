Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EA2C55ABD
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 07:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B058C2225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 07:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UJ9iRSw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B058C2225B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AF4C89A34;
	Mon, 16 Nov 2020 07:34:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF6FA89A34
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 07:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0RK4h/XQmwBHGUohqCxKWxaPvhbIdZJXT3t8bOUfQGjo21TWyEOx8ynlRceQ5NuziKM9SXGRHRI5FH6B1WIn58QGVMvf2oDvx+3qIOZz7H4Mu/Y/mPdZ59dmdqVD/8hOw2+YZtJqLdpYiJqtySOCmiNFR7YYHmhWBLullOpJFFryamNGcJpGnLSy9uIwK1kDLCHM1HZUI3aIMtb4Hj5tkVyPkZfplibgXb95uGD8OnnJHblzV8BvUhupsnc56i+p7CFmh9RezRDumFLkR/JohyiTZ4T8CA+16v3U6oMVGnSuXId571E1JzyftJNs7ywKLYU9R7iIR35uu+MWX5HDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV/LRfxV4iZnbrSuurot1mYSNFUomewvpRcWYfeGio0=;
 b=TOn3ide58rG8V79tcMvcwXrzovKCS3TRS2ZKkKjCcoyQjd4RLXpbnfoO8or64e4EIpJ5zcUtgddgvus0fU7XniN5rqlv+1SmkeqH1U/nj0Zp8rpW4A5eBWVKIktz0QlOBXoWgEHm8Fyom/N5xRvXqxEk2Xf5sU8hOhjz9XMQ93PCfhvAUY0klIElzyY30fRO8gx7E19sxuWpH0oB8yHv9vYNia2gRseYjoiHaiBYfVGfCj9inhDZtzOPM6bbJ1KFr0S6r/Xi8XfZWuYnqN1kyiwLh2Ye4nZS/XSol/dl/lrQozcYeXSJ2wbnYS5/pJ1L8dtAthvrpmXqevKNVj54QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV/LRfxV4iZnbrSuurot1mYSNFUomewvpRcWYfeGio0=;
 b=UJ9iRSw92WqP2glWR7Z8zZagQOGK2sSajyUS/jZJfSlrrH4mIHm6OtyClhidDJWMU69OJbwVuz0idmcM5re2EUa274m7ZLMpuCGCaVUuLrOhZZEoJA8gA3hnfv0ECycyjGByXPyNpVSu028O+eFyT7psF+II30oVa/Qd4O3H8KY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR1201MB0173.namprd12.prod.outlook.com (2603:10b6:301:56::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 16 Nov
 2020 07:34:56 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3564.028; Mon, 16 Nov
 2020 07:34:56 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: update driver if file for sienna cichlid
Date: Mon, 16 Nov 2020 15:34:36 +0800
Message-Id: <20201116073436.410900-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:202::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.14 via Frontend Transport; Mon, 16 Nov 2020 07:34:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bea6de5f-c8a3-4fec-9e31-08d88a021d42
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0173BAED03B755D085044B76EFE30@MWHPR1201MB0173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3mHYRM0VgiC7p3JRFYTYNbPUoarHrLL5A5c/q2Oyu5J7CTsOUSrhwTT9eybuDL4aclgybYs5oRzEx7LxcKzWMEa6fGRoErbI5ysrg/ujCS/W0Ct8FXR3YG1TiOhskYRyffSsLjv2/QjpU/N9ri7lzcBAkgGQzqZ2jytu5itgmucjAy3zidsuwZmUBcJbubyyWyEMNLgZqGgB6i41X76UgQXnBICpGP/XWJBJhrYhuiHXvccUyl7BDxf90u6JwS0IbPS+v4eahC+N5ZYdX9Y/VlXHjiJ938k0Ed8yRgJHCD+DGdI6irt2dD+Q/rED/eOg29RuQ2e4BqkU8rR1RgIHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(15650500001)(44832011)(5660300002)(1076003)(2906002)(83380400001)(36756003)(16526019)(6666004)(186003)(54906003)(6486002)(316002)(66946007)(86362001)(7696005)(8676002)(4326008)(66556008)(66476007)(478600001)(2616005)(956004)(26005)(52116002)(6916009)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: S0X4WcYvUGajCsGh+k1kXdhlwSKDfCWbpV5UGaBhgOKNkGQ4cWkE5xt134MDR/C+B6YCWy4o3PvkguTrGeGVw5++I72MxgnntwgQt0uo7EVj3E7i2JwsKED29jvURt3aNNYWhmS8Y/+TAu44jgoQ2b9pfxwmoJh/Lf+BXmEAYAiiTCdhm8xpJQACZdXiPOjwLIbD4P720kdf+bep6FlxeHPc2ZSS/Ujyr4+I+Y8BB74Bg8N1njJyvFlwVSDeWT6ZDrKTBY5yuqU7hjwhr0xoPguBQH3dl9tBmRr1FVhKCzcVIg6ikz60cdLse5sDIYf2bu/oSHnfPUBrqrw6SR0Q+G51TYozEfl8ofYfUcWj0WyH7uvUgg2WzrOxUP0p7o5WEDj8MHLlCUHYZ8yWXydwb/eg7L8Hwz4xM+HsPoQamrMC2PoWY++c3sb+GUQOf/ggAKXppCLpkRX0wZnPFfr/wcxd3Te0GOFBK1e+pG0IK1BKQMgEMEr1vVHN11DJqSCqm7XZMEQxjOoCzjbY+QhRmno/SrmeR5e1W0xuVISJmCXjq8SweAbHV1LUa31DTkOP8LF4+JrdQKMI41PsOG9LBMwYdXU0bl5D/m+P389nYImTzwgLlPEip3kq4VFyetcK9YSQdOVUPtpskVDPYvJnNx4nEh4Dnm3UqktAnded9CxW+RAuhxWpnTCi5BH0U/S9M0mei5YCkOks3ntlIsbsWEt9wIxmagx+Tb/CA1V+prM3z9nCzm9ebQYFZCCKptNht+Xr5kaaFAbR4k85IYqpwF2EU+V1IlS+Vq9okVTKRXZDPYPH6Y7dZBiNwyIUN+05Pitt20zI4k/kRguFbICCt77g2ZzWMf5M2DfPwEMU6f1Km1ZkYfEmyh7WR/qRvNBW2zjFVn/3tQk2WHu3o+mYQw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea6de5f-c8a3-4fec-9e31-08d88a021d42
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 07:34:56.1046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jk/U6mbJyDyVU7p7qHiFfLdc8n2vql49li4jOLiatqmG8Yu+qpbcpxd9ndeqM7W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0173
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
Change-Id: Ibcffb2a668202f941b1e8e7a22924976c910cf35
---
 .../pm/inc/smu11_driver_if_sienna_cichlid.h   | 16 +++++++++-----
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 22 -------------------
 3 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
index e418a46603c8..fa95147b5a63 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
@@ -27,9 +27,9 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if 
 // any structure is changed in this file
-#define SMU11_DRIVER_IF_VERSION 0x3A
+#define SMU11_DRIVER_IF_VERSION 0x3B
 
-#define PPTABLE_Sienna_Cichlid_SMU_VERSION 6
+#define PPTABLE_Sienna_Cichlid_SMU_VERSION 7
 
 #define NUM_GFXCLK_DPM_LEVELS  16
 #define NUM_SMNCLK_DPM_LEVELS  2
@@ -437,6 +437,7 @@ typedef enum {
   PIECEWISE_LINEAR_FUSED_MODEL = 0,
   PIECEWISE_LINEAR_PP_MODEL,
   QUADRATIC_PP_MODEL,
+  PERPART_PIECEWISE_LINEAR_PP_MODEL,  
 } DfllDroopModelSelect_e;
 
 typedef struct {
@@ -612,7 +613,9 @@ typedef struct {
   uint16_t       SmnclkDpmFreq        [NUM_SMNCLK_DPM_LEVELS];       // in MHz
   uint16_t       SmnclkDpmVoltage     [NUM_SMNCLK_DPM_LEVELS];       // mV(Q2)
 
-  uint32_t     PaddingAPCC[4];
+  uint32_t       PaddingAPCC;
+  uint16_t       PerPartDroopVsetGfxDfll[NUM_PIECE_WISE_LINEAR_DROOP_MODEL_VF_POINTS];  //In mV(Q2)
+  uint16_t       PaddingPerPartDroop;
 
   // SECTION: Throttler settings
   uint32_t ThrottlerControlMask;   // See Throtter masks defines
@@ -667,7 +670,9 @@ typedef struct {
   uint16_t       FreqTablePhyclk   [NUM_PHYCLK_DPM_LEVELS  ];     // In MHz
   uint16_t       FreqTableDtbclk   [NUM_DTBCLK_DPM_LEVELS  ];     // In MHz
   uint16_t       FreqTableFclk     [NUM_FCLK_DPM_LEVELS    ];     // In MHz
-  uint32_t       Paddingclks[16];
+  uint32_t       Paddingclks;
+
+  DroopInt_t     PerPartDroopModelGfxDfll[NUM_PIECE_WISE_LINEAR_DROOP_MODEL_VF_POINTS]; //GHz ->Vstore in IEEE float format
 
   uint32_t       DcModeMaxFreq     [PPCLK_COUNT            ];     // In MHz
   
@@ -1221,7 +1226,8 @@ typedef struct {
 #define WORKLOAD_PPLIB_VR_BIT             4 
 #define WORKLOAD_PPLIB_COMPUTE_BIT        5 
 #define WORKLOAD_PPLIB_CUSTOM_BIT         6 
-#define WORKLOAD_PPLIB_COUNT              7 
+#define WORKLOAD_PPLIB_W3D_BIT            7 
+#define WORKLOAD_PPLIB_COUNT              8 
 
 
 // These defines are used with the following messages:
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 41bc919dc9f4..eff396c7a281 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -30,7 +30,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36
 #define SMU11_DRIVER_IF_VERSION_NV12 0x36
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
-#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3A
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3B
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02
 #define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xD
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 0600befc6e4c..21c5ea3a4a63 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1805,11 +1805,6 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 		dev_info(smu->adev->dev, "SmnclkDpmFreq[%d] = 0x%x\n", i, pptable->SmnclkDpmFreq[i]);
 		dev_info(smu->adev->dev, "SmnclkDpmVoltage[%d] = 0x%x\n", i, pptable->SmnclkDpmVoltage[i]);
 	}
-	dev_info(smu->adev->dev, "PaddingAPCC[0] = 0x%x\n", pptable->PaddingAPCC[0]);
-	dev_info(smu->adev->dev, "PaddingAPCC[1] = 0x%x\n", pptable->PaddingAPCC[1]);
-	dev_info(smu->adev->dev, "PaddingAPCC[2] = 0x%x\n", pptable->PaddingAPCC[2]);
-	dev_info(smu->adev->dev, "PaddingAPCC[3] = 0x%x\n", pptable->PaddingAPCC[3]);
-
 	dev_info(smu->adev->dev, "ThrottlerControlMask = 0x%x\n", pptable->ThrottlerControlMask);
 
 	dev_info(smu->adev->dev, "FwDStateMask = 0x%x\n", pptable->FwDStateMask);
@@ -2036,23 +2031,6 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 	for (i = 0; i < NUM_FCLK_DPM_LEVELS; i++)
 		dev_info(smu->adev->dev, "  .[%02d] = 0x%x\n", i, pptable->FreqTableFclk[i]);
 
-	dev_info(smu->adev->dev, "Paddingclks[0] = 0x%x\n",  pptable->Paddingclks[0]);
-	dev_info(smu->adev->dev, "Paddingclks[1] = 0x%x\n",  pptable->Paddingclks[1]);
-	dev_info(smu->adev->dev, "Paddingclks[2] = 0x%x\n",  pptable->Paddingclks[2]);
-	dev_info(smu->adev->dev, "Paddingclks[3] = 0x%x\n",  pptable->Paddingclks[3]);
-	dev_info(smu->adev->dev, "Paddingclks[4] = 0x%x\n",  pptable->Paddingclks[4]);
-	dev_info(smu->adev->dev, "Paddingclks[5] = 0x%x\n",  pptable->Paddingclks[5]);
-	dev_info(smu->adev->dev, "Paddingclks[6] = 0x%x\n",  pptable->Paddingclks[6]);
-	dev_info(smu->adev->dev, "Paddingclks[7] = 0x%x\n",  pptable->Paddingclks[7]);
-	dev_info(smu->adev->dev, "Paddingclks[8] = 0x%x\n",  pptable->Paddingclks[8]);
-	dev_info(smu->adev->dev, "Paddingclks[9] = 0x%x\n",  pptable->Paddingclks[9]);
-	dev_info(smu->adev->dev, "Paddingclks[10] = 0x%x\n", pptable->Paddingclks[10]);
-	dev_info(smu->adev->dev, "Paddingclks[11] = 0x%x\n", pptable->Paddingclks[11]);
-	dev_info(smu->adev->dev, "Paddingclks[12] = 0x%x\n", pptable->Paddingclks[12]);
-	dev_info(smu->adev->dev, "Paddingclks[13] = 0x%x\n", pptable->Paddingclks[13]);
-	dev_info(smu->adev->dev, "Paddingclks[14] = 0x%x\n", pptable->Paddingclks[14]);
-	dev_info(smu->adev->dev, "Paddingclks[15] = 0x%x\n", pptable->Paddingclks[15]);
-
 	dev_info(smu->adev->dev, "DcModeMaxFreq\n");
 	dev_info(smu->adev->dev, "  .PPCLK_GFXCLK = 0x%x\n", pptable->DcModeMaxFreq[PPCLK_GFXCLK]);
 	dev_info(smu->adev->dev, "  .PPCLK_SOCCLK = 0x%x\n", pptable->DcModeMaxFreq[PPCLK_SOCCLK]);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
