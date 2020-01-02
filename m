Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCE4C2D0DE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 01:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 492C1208C3
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 01:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NJBCkB4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492C1208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C263A89C96;
	Thu,  2 Jan 2020 01:54:49 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690060.outbound.protection.outlook.com [40.107.69.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA2889C96
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 01:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPZQvzTArJsx5QKLTR4bsP6OyqLQdfIjtYsvG+3uhJyMR59uTv8dxUhfaFEglbgmHM1hRTBZy5v9nhvzMkFRMo7yl2gQvDg4S9rw709w5nvXcOUn0qSuggHjgBQM7Ie5QBZHZF4JsTh0Qq19geFar9JWGT62tLMir07gDb8YM8VDv4DwDstcvdnduDVlL0YbmkSkZfbKtkK4bXFHocPvqZbMlvGF+0s9mnFED+Nd9sJWb3DWGrslH8SPc5eH3KGMg1bfL5xdh7yYxpb3LhmaTzgyg9acESPvaQMVZzMCxbIlQw09vQA+iXX560SY9olNrUe9AOhrila+A4Amq55ZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIoQ75POvGKhuNhpYLvfkpPIg7B4VDxH9P7kkJxNyjg=;
 b=ZZAR13+Ok7EFSb7KN0IibaBUbPrA5ryn8reWOruaqVggxGRcUp6+IRvlhdqaOXTL3fQeuRMeZkSW6wh6WDgZVkWHDcbBvRDXoq2U57WXTguneIm+JxDsoptt5f66rA9vqj0+8Eh13BcOJ0YunLQCP+raBa4ttaYEI2QIvgCK05r90o4YJtESzBp2+HIw1rgqFvN5t1eTj9uiJTgOel7jXYJdnGFvHMHPlWH6sHPNoNzkgHxqG+wKhIhWYuLAZ1UrclCxjyZWJ4xVa0IHrl+hf+/TMINHNayxHEKZTbItjgXZw7R9Nu+GYZMOiIRL9m6JCDExwcIv5GRGO/ds21rfpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIoQ75POvGKhuNhpYLvfkpPIg7B4VDxH9P7kkJxNyjg=;
 b=NJBCkB4uTSaDeUaOPCfAptf83zzzyCOB8y+VGr1wvZPxH65fAkhM+sQwOk9T2Ld3naPC7Tj0cnLLGxLYNZD9C5rMtuYPU4j+DnRCJq15ETE6l+ZO9u8qOnqVB5uzZ+CUqBUnBWT+cxxofRZdiNviT2/h0wnmZR0bTJUc1ysf/+g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4112.namprd12.prod.outlook.com (10.255.125.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Thu, 2 Jan 2020 01:54:47 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2602.010; Thu, 2 Jan 2020
 01:54:47 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: add smu11_driver_if_arcturus.h new OOB
 members
Date: Thu,  2 Jan 2020 09:54:24 +0800
Message-Id: <20200102015424.10737-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: HK2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:202:2e::29) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR06CA0017.apcprd06.prod.outlook.com (2603:1096:202:2e::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Thu, 2 Jan 2020 01:54:46 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d00eff7-ff25-40b0-010c-08d78f26bf04
X-MS-TrafficTypeDiagnostic: MN2PR12MB4112:|MN2PR12MB4112:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4112F5C053DF33B737D7B76CE4200@MN2PR12MB4112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 0270ED2845
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(39850400004)(396003)(136003)(199004)(189003)(186003)(6916009)(956004)(316002)(6666004)(6486002)(8936002)(81156014)(8676002)(86362001)(81166006)(52116002)(7696005)(2616005)(16526019)(26005)(44832011)(36756003)(66946007)(478600001)(66476007)(66556008)(1076003)(2906002)(4326008)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4112;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MTu7gFOkUqOKTUHkZQgCyWN44IxjUSpyvgs7sXIRJyTZgPG4yGDv7zzjRIM8TKJHWeBg7cmcqDTNnzzyyi3HTugHauiLZRuQ9Kl+bYOy1wKdbHAI5ddyDrpbYjMHEXe2xvbH8cDOcklOSjbLoooUdJ0P94m6QKCN5nS6FPy4zfSBULGASCnpK6uyKVqtaC+QB3LUv1duk1j+J+Qx7J9ogl11Yv+HR27DFJHTz15DCCbi09NQb508gnjQ0YpihcFa0x9GUrrUeHG3bnC1Ycl4nZ3ds6v3LfyuSEe0g6bk6lUGUsFEUQeW3Ws4sbzQw5UM4yYz0SzP8j7y8VLlxGO9hhEaQx7JLhCURjBxgjr++RYfn/vznSzKzTPZY6rvbw8WDN65GTB95zMZe7iN5awo2zs8tH5jdlv8TtwVKF0r17yYG8/b8XTZeUk9lXOmh2c+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d00eff7-ff25-40b0-010c-08d78f26bf04
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2020 01:54:47.5132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHZkU/NVJRnVGqvzQ2/qwTmd8894FQblxvONLGrh8R4f287pjA3YRHeHln+U9T8z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is to fit the latest SMC firmware and it's backward compatible.

Change-Id: Ic561f83fa5d9d15a226b9f134da7e7ae90d9c6f9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h  | 8 +++++++-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h             | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
index 910226ec512e..ce5b5011c122 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
@@ -622,8 +622,14 @@ typedef struct {
   uint16_t     PccThresholdHigh;
   uint32_t     PaddingAPCC[6];  //FIXME pending SPEC
 
+  // OOB Settings
+  uint16_t BasePerformanceCardPower;
+  uint16_t MaxPerformanceCardPower;
+  uint16_t BasePerformanceFrequencyCap;   //In Mhz
+  uint16_t MaxPerformanceFrequencyCap;    //In Mhz
+
   // SECTION: Reserved
-  uint32_t     Reserved[11];
+  uint32_t     Reserved[9];
 
   // SECTION: BOARD PARAMETERS
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 662989296174..d5314d12628a 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -27,7 +27,7 @@
 
 #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU11_DRIVER_IF_VERSION_VG20 0x13
-#define SMU11_DRIVER_IF_VERSION_ARCT 0x10
+#define SMU11_DRIVER_IF_VERSION_ARCT 0x12
 #define SMU11_DRIVER_IF_VERSION_NV10 0x33
 #define SMU11_DRIVER_IF_VERSION_NV14 0x34
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
