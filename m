Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFAEC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 07:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86252080C
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 07:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="icchRARE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86252080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E156EB12;
	Fri,  3 Apr 2020 07:02:30 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760080.outbound.protection.outlook.com [40.107.76.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83FA76EB11
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 07:02:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nARvm4BTxcn+vojalFmT16XMol0yFODuW9OCoWMJ34B9gDhFWlZnT+yRXDfGWrDQTq9qINQk3SoD2Ub8JUWcG+BTeAGAJbKBeslkpEnSNlyz0FAVh73R8184nmZhwoGuOGVtugzgOT4jmvC8EUxgA+9NGYARWAv+z9nOV4cYJ9uR5eHzwUQh7kNqOEq1PQ0Is/ds9po0kZVrrq4CQksCj8yyhtCNnvZbWUJXUqKMMNK4e7C9hcjq6o0YZYn3NpZtjCo5UP+uC486sbRQhd8GobBWDyQ/AKyn4F8YYA/HIyocad7djGoPJ9AF+CpTWwxqO/XcFabfFJcTOSK8WO4Qdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPUfahlE474GjHUaQkMDk+SZvJWCMmFPLKl9LIV+8LA=;
 b=Y/xlJrG1FASl1pHmes/ruGQxmXt54yy8qNOhEb/84/TalZCXUFn8bQL6pSMfyUaxmhK2p4mxS48tXoqjVNjM1Guc1syHN1kKGxy5SLcjPMU4GqgS45+oFbsr83L6kisaYndLVny8IQOhcCr+TS0qu6cgxP2kVwoYJUI0bKxp0CK/C/L0YKeE5USsmMQfBPxIcqSS1V05rt/o5eJC4VORhV6jiUcXGTNWgjOldUPCngUw54I1De/1eWLUQ5Sg4OooQZSI9cXtiZ48g4l2SsMtO92INTxWrPBAnTnoLLZfS8wwynaxGP2aI+Vi3uBR3mBTj/Un6E1Kx9XXEWr+Z5UeLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPUfahlE474GjHUaQkMDk+SZvJWCMmFPLKl9LIV+8LA=;
 b=icchRAREu4IynThuqN5WK0ApNhM4qV+nnIzJXhdzlIsW3NRITjiCsb5C05IuGMrU3bANdymzRSHaw0LBoQ1v4AK913TucrCzGk1kk/6MwPFAGCsSIpx5nM35MlosYHvoXxXlagHhq9DqP6OVJm69A6cOsNzF1v5yKIbpEDOtH7c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
Received: from MN2PR12MB3536.namprd12.prod.outlook.com (2603:10b6:208:104::19)
 by MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 3 Apr
 2020 07:02:26 +0000
Received: from MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b]) by MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b%4]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 07:02:26 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: update smu12_driver_if.h to align with pmfw
Date: Fri,  3 Apr 2020 15:02:12 +0800
Message-Id: <1585897332-28286-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR02CA0163.apcprd02.prod.outlook.com
 (2603:1096:201:1f::23) To MN2PR12MB3536.namprd12.prod.outlook.com
 (2603:10b6:208:104::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HK2PR02CA0163.apcprd02.prod.outlook.com (2603:1096:201:1f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 07:02:24 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 971cebc3-db04-41ad-ac05-08d7d79cf76e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:|MN2PR12MB3997:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3997F7AD2C95D93F819B37C3FBC70@MN2PR12MB3997.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3536.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(15650500001)(8676002)(16526019)(81166006)(8936002)(7696005)(6666004)(2616005)(81156014)(66556008)(66476007)(316002)(52116002)(36756003)(5660300002)(186003)(26005)(6486002)(956004)(66946007)(2906002)(6916009)(4326008)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pj5FEp561JAQRCNdzL2ZsP+7owXwJmWMOM7T2O4lYLi0SFn8zLcZKDdFW0a0FLHk5FzRtvsSf3l+rhx2uwOwctRx8QALSE0jEJu9zP/w50EwgvXgp221maggcgA7WJadQK3FREJGdyFYaSqcF1AvLTa96gYGBEyblZIvcnc60gcMo+atbYOhfeZ6HB2ZG+4AyNgFpHzIdvOcPGr5Wzau0AcCeRSnS9gPSNZhpjxv5FvcI3AdvtaSzI4eK8ogvYoedZVkulG4Su5Mf8xShMVVz8ZcOUo8KLZb8dPg45p2KVMKGcPu2N9lTkg7umN4jaXNrnKF3Fo7JAayIf3fNjyqSvkAVDUaCgX2UjRlgop+PdPanvJukcbrtnV9c1b1byqcECJ10f1s4K8rUMC6aGwBRvKkkbCszNDwCjVUynh6Z0hZkEZkZ4tL8iCxt1L8MEOW
X-MS-Exchange-AntiSpam-MessageData: 4GsDT/OM3g/bpz8wtosP4wdQOAQTczyVTJyhjgj8RdqRLS/7JhBCmtzqFCXa5V0c55cRmNtIZ45M2bGoYLic1RJb4TrpS96orSCmCJ5cICPQaJE7+Ie1S8KNZ7Paz9Tq2KCO3UWn6XDRp6As4iipLg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971cebc3-db04-41ad-ac05-08d7d79cf76e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 07:02:26.5288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0jymuUKq8o7ve37fEIDeXBVso0Ci43caQAkap9JGz9EBM6G+uYOQXm+5dOSwjdD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3997
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
Cc: Prike Liang <Prike.Liang@amd.com>, evan.quan@amd.com, Ray.Huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the smu12_driver_if.h header to follow the pmfw release.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../gpu/drm/amd/powerplay/inc/smu12_driver_if.h    | 42 ++++++++++++++--------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu12_driver_if.h b/drivers/gpu/drm/amd/powerplay/inc/smu12_driver_if.h
index 2f85a34..b4d8f83 100644
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
@@ -193,10 +197,18 @@ typedef struct {
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
+
+  uint16_t InfrastructureCpuMaxFreq;    //[MHz]
+  uint16_t InfrastructureGfxMaxFreq;    //[MHz]
 } SmuMetrics_t;
 
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
