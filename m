Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F11C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 11:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77AB022CAE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 11:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kvsZ7gUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77AB022CAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 681AF6E8A9;
	Thu,  6 Aug 2020 09:42:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A9B6E8A9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 09:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e55WIF8L2O+k7VdqN4//uGagYAsBWiErv3IMzA1gKjwcw1MnguDDyh+UlUpgv4a4kAh9q3yFcOXJ7vKdC+0oWS6FrQwmsrKeBoQDxpxvljR0zLn4Gk/xjyu1uI0PiqFUExpeFbsZYhcDoHOcixLV8zyMfjPvBSdeddHAZLYSjfCyHCKkOajoAAu4M0tvg4CRPRIDqYUogaMhHDrrk4ukaj3qRI2E+Ig7mc7x2DoY72wsuPueKLuoG1KpU0w5X/3ijQTqpqU0zydPXrlj40Fcuj+8yJE9TOkk3d9BphrwcVft5hq31vJ72uvAOfITPaeMT+FozI+odBeKsliONjPmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KlgeIwK4DTYrSy+MUBRTyJK7qJD5Ix26c51JgEFl0w=;
 b=i4Qy4Q8KdRHMxBPJ2bud/j5JLdbdRYXxjCg6RYPI6a2clTx7H7nZJfghWXG/5V9hWpxW5F4vES3a8O5gv2ZTYkd32TJDSZKOGbKUgpxk9HhnLxjcYmwJ4IffPgDB+AXy/AF81PmAjz3VHynvkM1f8ObMOye5wHLT4TfxbyzGEMVBI1jHm9ROIFXlKhm4h8uBuIIqw9nUnEg9tynlnAOIS9qoCg7J2gVJWM6Fa8vIhKiJFby2EtZHgRffke9dsX/Y6VSWeFSjs/Z/Uk5jtwSIsgTkyyObeCXmhH+O2UcZBCgQI0TaxXwAUYm4raJFkRp9/IOp6yghdTTvF3LZv+W61A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KlgeIwK4DTYrSy+MUBRTyJK7qJD5Ix26c51JgEFl0w=;
 b=kvsZ7gUPcWATCulNIjXpY0QQvABWWT3MwN9vZ8ScWR6donSuZ3PRIIADerIsAFC3NaTXDT25ICt/WAADl6gxkZwFNbZUaKHcppEFNARb2AJElDDakjrPFNw0ovyKjYDu42Y73+x0zspkYLUznMrSOu5Uu84/+i0dK4eFBTd3izs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW3PR12MB4522.namprd12.prod.outlook.com (2603:10b6:303:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Thu, 6 Aug
 2020 09:42:56 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::c83a:4059:70c4:3911]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::c83a:4059:70c4:3911%9]) with mapi id 15.20.3261.019; Thu, 6 Aug 2020
 09:42:56 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: update driver if file for sienna_cichlid
Date: Thu,  6 Aug 2020 17:42:38 +0800
Message-Id: <20200806094238.2022133-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:202:2e::24) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2PR06CA0012.apcprd06.prod.outlook.com (2603:1096:202:2e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.18 via Frontend Transport; Thu, 6 Aug 2020 09:42:54 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ed9515f-61b8-46cd-0022-08d839ed18d1
X-MS-TrafficTypeDiagnostic: MW3PR12MB4522:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB45227E51BAEEE37BA0A4C71AEF480@MW3PR12MB4522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IslE350ngmfr88UtlFuHlV+VqnXzUnhP7MWgj+yAXqD3MtAf0mvN5Se9SKgbsUkFuWta0LgjE6jygTXRWcbzilNN0bzT3eR3i1vkPRPZsBxsVQ5DZN6lwNcRibEVNxRm9O4xWrU0C2n0Kn/plwK2k4/tVfGvMzs4YaTAfaFfhNqU2u0zeZ6Xp+qCzlrV9HWFZX0upnC3l8lEAT5Dh1BtAVqUvQGPh+SOjvz7gR5HdzGhzA4Zr1Ly3jAi2nuthVHZh9HxlVpvxmvC1ki1guvKgTaFQtbyb6uZ4w8UROMt3HIE6ZjTrb8JOEwnazPl9JC4AQri03a5KrCzFDFHsDo7eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(52116002)(186003)(1076003)(7696005)(4326008)(15650500001)(16526019)(36756003)(8936002)(316002)(8676002)(5660300002)(86362001)(2906002)(478600001)(54906003)(26005)(6666004)(6486002)(66556008)(66946007)(2616005)(956004)(44832011)(83380400001)(6916009)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZLVfQkxoL8YD4DWO4wVEMgy50u3E5E0kAs+NoR8+bjNHtBEFYdGYdcyvB3yRFN80zAawfOgFvuD2l3w7cTzblsf8q7CTiPf8ODuP7rq7jV9e16lAJJg6/b7HqkTM87gpcZ6xF6bsW7Mtox/wI3Pi3jw8/a+MYLh/nV5k/+82PyQ+bkK63oTRHwr2505BlnEay4pb+hf20jFOYx2kJ8VPiVZdOiMdhgkQdkjO6Q5ST6wJLCpHTOJs/109QVvByv/Xh1lsBiD4YBgEufCqoqvN855yTpzZbc1zsvP2Ow3p0RrpV0yJ8yOm/+r8uzUmExK6NsWXQK6EFnoJ2k+zm9TumJSjXM1Wfx7W/c0GyN7ITX4/qtL9CNkXb8xaFGsGnNMQHIISRBUkFSmLUzY3mvtV+MFa/wQBZJgBvcZ2Jh87yqYLW/kJqTz3MTrzz9/bWhz5amew8f8Qptzgvv/Kyu69LBQ9v5/DmoE8dDXf62dn4eCrGu3ylRyK6bPo2A4XiXN7Im64O4QomEdAQyNUVRWoAcGLXvHns5Z0GpFg591NeVjpEcdquUnhN8m5/SBURo4lWD/pFiUmGKndIFcl0laPcQ5KiTrczLVBKDLnvugp93RpGqtpxv3cg2xuggFjiPZ1kk8T2XzbNkUIeuDoQz53yQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed9515f-61b8-46cd-0022-08d839ed18d1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 09:42:56.3166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuzPc+bFhCwMVhyF0CrQrFcUnyVnN6HF0ciwtLxKv+Fglmko/RNoh6IR51cvG6Zw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522
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
 Wenhui Sheng <Wenhui.Sheng@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Update drive if file for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: If405461cfbe0133ceb61fa123272b2e53db99755
---
 .../drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h  | 6 +++---
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h               | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
index aa2708fccb6d..5ef9c92f57c4 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if 
 // any structure is changed in this file
-#define SMU11_DRIVER_IF_VERSION 0x34
+#define SMU11_DRIVER_IF_VERSION 0x35
 
 #define PPTABLE_Sienna_Cichlid_SMU_VERSION 5
 
@@ -127,7 +127,7 @@
 #define FEATURE_DF_CSTATE_BIT           45
 #define FEATURE_2_STEP_PSTATE_BIT       46
 #define FEATURE_SMNCLK_DPM_BIT          47
-#define FEATURE_SPARE_48_BIT            48
+#define FEATURE_PERLINK_GMIDOWN_BIT     48
 #define FEATURE_GFX_EDC_BIT             49
 #define FEATURE_SPARE_50_BIT            50
 #define FEATURE_SPARE_51_BIT            51
@@ -169,7 +169,7 @@ typedef enum {
 #define DPM_OVERRIDE_DISABLE_DFLL_PLL_SHUTDOWN       0x00000200
 #define DPM_OVERRIDE_DISABLE_MEMORY_TEMPERATURE_READ 0x00000400
 #define DPM_OVERRIDE_DISABLE_VOLT_LINK_VCN_DCEFCLK   0x00000800
-#define DPM_OVERRIDE_DISABLE_FAST_FCLK_TIMER         0x00001000
+#define DPM_OVERRIDE_ENABLE_FAST_FCLK_TIMER          0x00001000
 #define DPM_OVERRIDE_DISABLE_VCN_PG                  0x00002000
 #define DPM_OVERRIDE_DISABLE_FMAX_VMAX               0x00004000
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 6a42331aba8a..737b6d14372c 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -30,7 +30,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36
 #define SMU11_DRIVER_IF_VERSION_NV12 0x33
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
-#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x34
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x35
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x3
 
 /* MP Apertures */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
