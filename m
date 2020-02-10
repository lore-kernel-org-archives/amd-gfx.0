Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B1CC352A4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 07:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9073520838
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 07:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Bmpq1isr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9073520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C1C6E8DD;
	Mon, 10 Feb 2020 07:12:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94D7E6E8DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 07:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKw4SNXgSS0KGlAB/wgPc7Q/kXodFON0eD+NA5bxn9h1h3f/ETmO9x2u0h0fFk7sUbniYFYn4Zp6pRxdqarq+h3+Gvfu9b5/CwZAjjfisS2GmHDFL34jPhiAw2xYDWEQ0ZM6xJWMUl7zlAnOufZZYfGibQyDIDhFGsBrJUeTh4fcAkBUUcmhDXUjtdKtXhXm4ZSsV/L6AGYJkWwW4kqewvZNhtAM109Ta34FMm0l+1HWTbQMKrYyYvfKLkJ0gRBRxFtQy/TLrGBk1dqfUdoGKT0GNK8bMmWNkJI844EeAufuSssBSGzXydssrbVgmBXMWgcFWAkN4US0BkelsyTxDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAR8KewBmR/IrwHz6w0EsEuW/3q1UYPEy1C5H6qzw/A=;
 b=ReedF25D1jTMk7v7m0xCXXDSHveDlNGZfIUsrG2gUoh/K0kcbA6Qf35Z4ZLKqSJ/oRs9Vs0HMTmy6WDCxyaW/T5jZ5TWxx9TB/3K9ZH5NgRyz+ZhtyYRumuwq6fqzn3fTDIzp9BOIUrJuyp4BGbCYy63CB5bWfFw7cd0QIA4lCfH8rDkXhi6PbyZAwUaYHteIvrLvf4K5RtPuCWMd88S48ueaZEvr3nMrAW7MwfOa56Y/tfRMZisByTh6TXvnVaqtZ6txvlM8jv1Olda4rIQs7+c574pL6Z7xwRqmVbbY2YNaxxjurCEt7rWFhGVgpKrgonGpzCKxjp5o3VsS8SnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAR8KewBmR/IrwHz6w0EsEuW/3q1UYPEy1C5H6qzw/A=;
 b=Bmpq1isre+zk+UdvR4m6clSREc7kguuUNQwcfeiNjFeoH2mzHygaxof19hn8XWF/9/O8Y2b8FgEgTpvHeDaLaoVtkJkduyTB38dN7oSPNjJIZmp4ebqj5IwbCcNyIDT+ZdLLe5GZc8mS4OxugfCPc2J8+mP8h4LhcZnULGcWXuI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3550.namprd12.prod.outlook.com (20.179.84.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Mon, 10 Feb 2020 07:12:18 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 07:12:18 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: update smu11_driver_if_navi10.h
Date: Mon, 10 Feb 2020 15:11:44 +0800
Message-Id: <20200210071144.1038-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.25.0
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR04CA0069.apcprd04.prod.outlook.com (2603:1096:202:15::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Mon, 10 Feb 2020 07:12:16 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22cef685-bf7c-4114-d69d-08d7adf88ffc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3550:|MN2PR12MB3550:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3550CB24C54699691ECEFD65E4190@MN2PR12MB3550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(189003)(199004)(66946007)(66556008)(66476007)(7696005)(36756003)(52116002)(2906002)(26005)(478600001)(186003)(8936002)(81166006)(316002)(86362001)(81156014)(6916009)(5660300002)(8676002)(6666004)(4326008)(956004)(2616005)(16526019)(6486002)(1076003)(44832011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3550;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: py/ExaqLT61dgX3wgRkKXbcA/y6Zl1dAl5p6zv0BXj0fzwRvS3oW3cpcj8CKt3F6yJn7PXkTR7C0zuyMXNNEebqx+YJDCN/09b33aKjuKbkbJTsDFf3GhvV8wpKEMa22SSExDfokHoKekjU3QXnvTjjk6Ds4UJkCewrtOLUYtLfIJBVbEhiebdB4+/ZpQExHg4cMG0O04QBzO3N1bJ2oAFaRTb3FA2fqxSbkf+eNPS/7dQTuDe1CZfcClJS6IKpYHn3Z2F0WAF5T1zgv0mK0XPR7pUguAmMUp2thC4QeDuJrr1phIsYfaIB0uzzMbwFDy+1U+6ypsXRX6zeYINR2u9+fb3iX2D/XgNrmufqfgFtheUeuA3A+RM8QywULXJvqElVSkx4xp0m57zew4scwRGckHEXj65w9V2+LPP4nr1FUQ40VFfuEHfS730iHsW5f
X-MS-Exchange-AntiSpam-MessageData: ButyUxtAAuXXISSFE1SPWqgmdy1ja3LUaaw6pjcEu+ZgI/zmbivU++UQ69WMQF50eiEl/0jjmVsU1RtKPjJgz367W+Gwpj7i8HSZ9wX7BtoBJaFbE0pswoOex1X7F2wvACfW6g7TFl7CIC3eY4QUyA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cef685-bf7c-4114-d69d-08d7adf88ffc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 07:12:17.9498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3riuzxNjEdaTueAfW+8Fq2SiN+6orKeA2GXcVr5aqnzSTMFSmmxCdqAx021+DeW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3550
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

To pair the latest SMU firmwares.

Change-Id: I5262c750fa08bc6268b43e3420e110e9ee71ccf6
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h | 3 ++-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h              | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h
index ac0120e384be..4b2da98afcd2 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h
@@ -701,7 +701,8 @@ typedef struct {
   // APCC Settings
   uint16_t     PccThresholdLow;
   uint16_t     PccThresholdHigh;
-  uint32_t     PaddingAPCC[6];  //FIXME pending SPEC
+  uint32_t     MGpuFanBoostLimitRpm;
+  uint32_t     PaddingAPCC[5];
 
   // Temperature Dependent Vmin
   uint16_t     VDDGFX_TVmin;       //Celcius
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index d5314d12628a..acccdf621b4e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -28,8 +28,8 @@
 #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU11_DRIVER_IF_VERSION_VG20 0x13
 #define SMU11_DRIVER_IF_VERSION_ARCT 0x12
-#define SMU11_DRIVER_IF_VERSION_NV10 0x33
-#define SMU11_DRIVER_IF_VERSION_NV14 0x34
+#define SMU11_DRIVER_IF_VERSION_NV10 0x35
+#define SMU11_DRIVER_IF_VERSION_NV14 0x36
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
