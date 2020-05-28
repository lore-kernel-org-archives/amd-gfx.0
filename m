Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EAEC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 03:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 644DF2084C
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 03:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ICVCO7GT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644DF2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FDA6E174;
	Thu, 28 May 2020 03:05:35 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700044.outbound.protection.outlook.com [40.107.70.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AC8A6E174
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 03:05:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGoUaKrMZUb6w3cleYhJtxOqH7tlXdv0SAbdVnhtadEKSLqRDboLV0awvkmErAvNkzlIqeileIodj1TayS2HTM8eScRqMeWYN9peKMoDyaXMqffXhrkmjRxm8NEt/H+wIMAflrTN4OHUl2EjHHo94/+YVVPyC1BDa+uPP+XY25DopDD2DkAczKJB2j7Cwzf4ur7ylafau7azDtGvQZeXXPWk1K3a7U6CflPHx9ih5goUJQeGtCvfjukjRU393As53Nz3KgEEIq3dVN92F72LBLEZZmeX9ZUHnDTA5Muw/4kke75mrfDnLarqeZtHDVI6hOeCRG/IMx5OMItYQEUffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXuEGaW13Kng9cHqra3RP68/haq7n6yEdW5d5u1R5w4=;
 b=Knc5RqARITEeJOF6fFBkUHUpGeHIpFMA8u0NI+S/XJrtzR37S6fftdCmZUPtlmIVcK6xTCPJmtALtp/y6N7IY5Es1HxyKhd1t4VXcUyka9fHqyBjQYxChmrBNrG/o8Dv89A0sEUwEn7OGa+I1ToMaDfplNPtWqAsHQFr/D0WsrHDBJlgikzqXJMIwVxVsllZOjwVJxQ01kjYz6hMnH9r0lyQ3jqvUj5LYXzYIpVaH++mcG0CgQMvPgDJHeR4LLsuSSrX8a/1CSCJJegOtYgJ7/UVnyPKv2CdzDAT/9wJhi8Yzvul7dlE+xx0qAm4RaALghAlMGyMAUgbY7isFWZS/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXuEGaW13Kng9cHqra3RP68/haq7n6yEdW5d5u1R5w4=;
 b=ICVCO7GTfgSsjY6F5Dx+U3qe3ClaN66eNMjj/WmqP3exqwmDMVPyhZVtOesBoJiUOFXCcQdvfS5ymwuaaneiEd4Oh4RVKJqRSvodhS0ZXucT/Jl1s7XLRYDOr9o15DvvHrMn2ziNBe+pWURw7z3VEv/AuiA2i2LUtnRJtXFeqqI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23; Thu, 28 May 2020 03:05:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3021.029; Thu, 28 May 2020
 03:05:29 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amd/powerplay: update Arcturus smu-driver headers
Date: Thu, 28 May 2020 11:04:41 +0800
Message-Id: <20200528030444.28735-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK2PR04CA0067.apcprd04.prod.outlook.com
 (2603:1096:202:15::11) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0067.apcprd04.prod.outlook.com (2603:1096:202:15::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 03:05:26 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93fdd740-3f10-4b55-2302-08d802b3f935
X-MS-TrafficTypeDiagnostic: DM6PR12MB3963:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB396336BC09858C9E2EA2E3A7E48E0@DM6PR12MB3963.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjXs3GFZEo1jpir71qa9IRQsaC7m7txpmyqKujPjMC9kj+blscW4PyC0+1TRNx5jZH5oySeU+lnHF1X19Gmiiv/+JnR7d2HS+PPzEpCIuGUDPSoJrTSqn238nqQpZ46lEhJRdsIGTAWNIUqiV7dAInGwz7bJZpD2Tj4NyEqpbDdbf6SDHqL+sLGeOirg3SF45EF/gtDPxAk01aOvQ2pHUYu/j9wt4FFlU9v42nikZKCPRv+IouZTHY8t6O83BES/kPTHLgGVJ8b2fWGfxeDTONTHTPd/SZYuMORqaM0+ZrR1SziKzBnBm0vQZVUIO2lm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(36756003)(6916009)(54906003)(478600001)(6486002)(86362001)(83380400001)(316002)(186003)(16526019)(26005)(1076003)(66946007)(66556008)(66476007)(52116002)(956004)(5660300002)(7696005)(2616005)(4326008)(6666004)(8936002)(8676002)(2906002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: B/z0VvU7rSq9WTkgN5T83WnsWzObEmfq7Q8p5qskG0yCrGYc+VsSdvHqpK5BcJ5xxaONvja2y7ZPjmUmd6Vr1RYm2BJOTJJvcCD0IyLXe/ykIYb5k48VAFK6kzn7EpQp89zUsZfIEkZpJ0TBhtfZTy90ShAanOEaaKe7AyK7RrVr1hf/q+60XYQxt3jkbfIROTWr002porp+nlXo/EO0u8bJjyPD72NgGLZ2c6nvtXZmmTUTLrTH8XUv4GPS0Ad8CaROFMk8f7VvU8TCZjcYSQIcPsDk4rJbLG21p0j3cJuIYgsb5aO+f+mFo3iu3OtGJpUqYs/CA6muE5+szqOltcPIFzePu5ER+GFmapNVfkr+Z0MYs8jGvKbLQgEBuhhybrPOIznFDDTgTR6zqSpyGAeorBYLwoUf56jVQAE3EasKMvdtsTAOPRcMxhmBDv9ODL13nNXYk3YWRmNiJQwr72emxKKC3yyfR6uUWuA+KW4wWEzI8hCFJ/9OtfG/HCFx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fdd740-3f10-4b55-2302-08d802b3f935
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 03:05:28.7879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLn2XlYFG6725WFmra6t8Iw4wieULi5g+L6w5qX/ICOu+LaGr8mJO1Ij0EER0wOg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To fit the latest 54.24.0 PMFW.

Change-Id: I38d08da6bf5120a7902b7366e09ca3fbc2c25f54
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/powerplay/inc/smu11_driver_if_arcturus.h | 12 ++++++++++--
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h        |  2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
index 8b82059d97e7..43d43d6addc0 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
@@ -200,6 +200,8 @@
 #define THROTTLER_PPM_BIT          13
 #define THROTTLER_FIT_BIT          14
 #define THROTTLER_APCC_BIT         15
+#define THROTTLER_VRHOT0_BIT       16
+#define THROTTLER_VRHOT1_BIT       17
 
 // Table transfer status
 #define TABLE_TRANSFER_OK         0x0
@@ -742,6 +744,9 @@ typedef struct {
 
   uint16_t     SocketPowerLpfTau;
 
+  uint16_t     VcnClkAverageLpfTau;
+  uint16_t     padding16;
+
   // Padding - ignore
   uint32_t     MmHubPadding[8]; // SMU internal use
 } DriverSmuConfig_t;
@@ -767,9 +772,12 @@ typedef struct {
   uint32_t ThrottlerStatus       ;
 
   uint16_t CurrFanSpeed          ;
-  uint16_t Padding16;
+  uint16_t AverageVclkFrequency  ;
+  uint16_t AverageDclkFrequency  ;
+  uint16_t VcnActivityPercentage ;
+  uint32_t EnergyAccumulator     ;
 
-  uint32_t Padding[4];
+  uint32_t Padding[2];
 
   // Padding - ignore
   uint32_t     MmHubPadding[8]; // SMU internal use
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 09047c3010e9..f3f34a0f5602 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -26,7 +26,7 @@
 #include "amdgpu_smu.h"
 
 #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
-#define SMU11_DRIVER_IF_VERSION_ARCT 0x14
+#define SMU11_DRIVER_IF_VERSION_ARCT 0x17
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36
 #define SMU11_DRIVER_IF_VERSION_NV12 0x33
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
