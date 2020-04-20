Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977C0C54FCB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 02:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB1E20936
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 02:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vrp6/Zto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB1E20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1127789D86;
	Mon, 20 Apr 2020 02:11:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B430889D86
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 02:11:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axoBziEQoGLmv1bes1XMEgkNrnp8b6qs7ZXTwUYcykBWesQ9/A/1aM/cLa/maNfhQhhszRni4bRvDBE1ZJrYYnWhLxE3UlYoymqg5nHRjYXPZMMxaxb1epAUAT/u37VqRy6O7G8ybUrXg9olZ8xKRttVzU4ukpOGwRGml/UNr+HpX1eKye18mXKhTn8xkpAVAEfqA9jj0HhB5Veuwwifbd6qPte7y0Tjh+RQ5NeifeepKlWjqZdDGEiSDhUO6EQO/AmDnRdFEBOvkznX57o1iRFKM5FoEJjA1weeL2CmrG74NM5l+yZMH866UeKayljORoJSQqpC6KmYpXmkROxwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WilmfdDd+C9E17hWCdt8QnKXPIllQIqYPRD5GJrm6qs=;
 b=YKPmudreumKjM539f0AgxBCm2oZ0opMsobPB6/8g+tcU7ILpbnVHQMKNF3O/eJzMaLJj757dXG5o6hJJ6R2WMS8sCxMqDqP3Q31KvVzIa9vy3D+A6tOlNtVMmIhtSFEywEX88aKCMWJF7hazcASA0txT8NQV7kQdWkEx3DlzaD9+lfHbT9KH41JIeMBvU4TxiOCAVzNEtS3H/PdhQ3Owyu5W/uQCpKTx5hABeRvWbumOwp4lceMUgPnNu/XYynzZZZxRowayUYfmfWzsE7/W6Lg1i/jE8nl+qRetOgCxwU3gwVWYzcYcQV8Le5iMAG6qVnyAfeuPOxHO1mOXjvcLww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WilmfdDd+C9E17hWCdt8QnKXPIllQIqYPRD5GJrm6qs=;
 b=vrp6/ZtognSLj3MhNxJKm0dxxSBm5BSQAmNBGwO3dxYyMCspr8nELQZoAgiAQfgj2dGbjBpzC3VezuOvkE2fOLc/LModoGr3+SipffV0sPORCaBgUN5EiOozK6cVHPKz95xJbjOq/jTtNPbCU0KuUWUE/Fp1kNb2eFaBEignIaw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
Received: from BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 by BY5PR12MB3825.namprd12.prod.outlook.com (2603:10b6:a03:1a2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Mon, 20 Apr
 2020 02:11:29 +0000
Received: from BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::c8:8aec:d08e:8bca]) by BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::c8:8aec:d08e:8bca%4]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 02:11:29 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: update smu12_driver_if.h to align with pmfw
Date: Mon, 20 Apr 2020 10:11:11 +0800
Message-Id: <1587348671-24181-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR04CA0076.apcprd04.prod.outlook.com
 (2603:1096:202:15::20) To BY5PR12MB4307.namprd12.prod.outlook.com
 (2603:10b6:a03:20c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HK2PR04CA0076.apcprd04.prod.outlook.com (2603:1096:202:15::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 02:11:27 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d3750b3-3435-42ac-dbd7-08d7e4d02319
X-MS-TrafficTypeDiagnostic: BY5PR12MB3825:|BY5PR12MB3825:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB38250A5935AACE29511E5DC2FBD40@BY5PR12MB3825.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4307.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(6486002)(2906002)(26005)(16526019)(66556008)(66476007)(66946007)(4326008)(5660300002)(86362001)(8936002)(81156014)(52116002)(15650500001)(6666004)(36756003)(6916009)(8676002)(186003)(2616005)(956004)(7696005)(316002)(478600001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bTmXiQgqaxPvW1wDYZU4iYb7Gb+H3g6ukuK+tG4I2becnLDEZm3GnXmnrQpT9IKjkjgDCvOQ+V54r3RMo0NzhYyj/7gsTKne7tiB8z2P/ZAU2BJAEkGbjlfIb+SXVAA3qek/ySvIULWucpsrHeWbbCkuV/FI7ib/xTuENav1HZ66CCNyD/pxjmdKDICx0I61xViDGQiAdKtZGEXACPJf3OMtneBfRjANt/1toAxe8mKB1ddclAjkih+vgB9/3sy6tHBovJTW5/rkr2Oh4eRCSkaCe/vFoGYapzaWt/16r4I0Fp/VLzq8PXrTuOHXOYmaA1ArfpdKz6Nt/8QHgbnarQixvGLqlf9tiT/g308oGTXmZdAd5/djguYm3fhpTV1NQm9d0goyXB3F6g7nTmW2dwMAZTz1X600AxzDkQHS1a8BXkU0F8NSochQUnBGI+lv
X-MS-Exchange-AntiSpam-MessageData: En0NnVEaTKXuOe40gWTFmd0W7blVk8PISA3eRoLUwUGZnIn8WioTTGUc+oluRBiTYb6IC5lF+Rkbfk+ZOesOza9b31upxOeC5+uFxaW+HCpo6seUbG47YL/Exggr2Y6UVUO3JvxOAHiqI+YadxD5ug==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3750b3-3435-42ac-dbd7-08d7e4d02319
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 02:11:29.3006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDyqYHMNZ+Pkj4R7EPz0UpnoUv45xXPPleXjaHF/n3LW3LEZuYv2WqXZ6WTtIeCg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3825
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the smu12_driver_if.h header to follow the pmfw release.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/powerplay/inc/smu12_driver_if.h    | 40 ++++++++++++++--------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu12_driver_if.h b/drivers/gpu/drm/amd/powerplay/inc/smu12_driver_if.h
index 2f85a34..e9315eb 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu12_driver_if.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu12_driver_if.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if 
 // any structure is changed in this file
-#define SMU12_DRIVER_IF_VERSION 11
+#define SMU12_DRIVER_IF_VERSION 14
 
 typedef struct {
   int32_t value;
@@ -154,15 +154,19 @@ typedef enum {
 } CLOCK_IDs_e;
 
 // Throttler Status Bitmask
-#define THROTTLER_STATUS_BIT_SPL        0
-#define THROTTLER_STATUS_BIT_FPPT       1
-#define THROTTLER_STATUS_BIT_SPPT       2
-#define THROTTLER_STATUS_BIT_SPPT_APU   3
-#define THROTTLER_STATUS_BIT_THM_CORE   4
-#define THROTTLER_STATUS_BIT_THM_GFX    5
-#define THROTTLER_STATUS_BIT_THM_SOC    6
-#define THROTTLER_STATUS_BIT_TDC_VDD    7
-#define THROTTLER_STATUS_BIT_TDC_SOC    8
+#define THROTTLER_STATUS_BIT_SPL            0
+#define THROTTLER_STATUS_BIT_FPPT           1
+#define THROTTLER_STATUS_BIT_SPPT           2
+#define THROTTLER_STATUS_BIT_SPPT_APU       3
+#define THROTTLER_STATUS_BIT_THM_CORE       4
+#define THROTTLER_STATUS_BIT_THM_GFX        5
+#define THROTTLER_STATUS_BIT_THM_SOC        6
+#define THROTTLER_STATUS_BIT_TDC_VDD        7
+#define THROTTLER_STATUS_BIT_TDC_SOC        8
+#define THROTTLER_STATUS_BIT_PROCHOT_CPU    9
+#define THROTTLER_STATUS_BIT_PROCHOT_GFX   10
+#define THROTTLER_STATUS_BIT_EDC_CPU       11
+#define THROTTLER_STATUS_BIT_EDC_GFX       12
 
 typedef struct {
   uint16_t ClockFrequency[CLOCK_COUNT]; //[MHz]
@@ -180,7 +184,7 @@ typedef struct {
   uint16_t Power[2];                    //[mW] indices: VDDCR_VDD, VDDCR_SOC
 
   uint16_t FanPwm;                      //[milli]
-  uint16_t CurrentSocketPower;          //[mW]
+  uint16_t CurrentSocketPower;          //[W]
 
   uint16_t CoreFrequency[8];            //[MHz]
   uint16_t CorePower[8];                //[mW]
@@ -193,10 +197,16 @@ typedef struct {
   uint16_t ThrottlerStatus;
   uint16_t spare;
 
-  uint16_t StapmOriginalLimit;          //[mW]
-  uint16_t StapmCurrentLimit;           //[mW]
-  uint16_t ApuPower;              //[mW]
-  uint16_t dGpuPower;               //[mW]
+  uint16_t StapmOriginalLimit;          //[W]
+  uint16_t StapmCurrentLimit;           //[W]
+  uint16_t ApuPower;                    //[W]
+  uint16_t dGpuPower;                   //[W]
+
+  uint16_t VddTdcValue;                 //[mA]
+  uint16_t SocTdcValue;                 //[mA]
+  uint16_t VddEdcValue;                 //[mA]
+  uint16_t SocEdcValue;                 //[mA]
+  uint16_t reserve[2];
 } SmuMetrics_t;
 
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
