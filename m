Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58125C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 02:56:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F275F20656
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 02:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LiXDtmmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F275F20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95EC389DB2;
	Tue, 25 Aug 2020 02:56:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77BC189DA5
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 02:56:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EA8vJtc/hPsFf58HMMQibKg5ZXPNF753XtRkkwdkMw3LAk/QYnveFjCS3zmZ/KI2/9/f8NpUwQJ10wtwQzK76S1ZlA+NEyk4LquCqgu14GYHQp3JEZAL9x43ZYie07aNZtWTqwTZNFRXYFG34jpcuGY7RGLxVitZraJdtdtk87LyGzIqU/EXA9ux25HdppLjVZ/2NqrBhIpOm06m3QvhPxKw/JlOfQH6iyCw/1jar2cbXoRw2aBTRNiKnNhYrg3a1irGgen5WatTHUznBQN9lerg2xRRXXFM2RTmee9gjFFQl6prHcUoN9oZZcHFX21l6420KjMpzq7KZEeTyJpHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlKG8aHd/d3FjZBnen9PrBiAGB9/Z/Eb5pUcrOWsL7w=;
 b=WEfNgvtf62cJScqtcr9gD7ObKTdksgcT8JmhhRYGSVCee5BQlqR4QE+V54p+RPULfcaVvoqhi82YyJlUUA84IPzpYftibzChsRG0DnzMA34EfCUS9Qz5s/6SvYhRe+tJ9sWQ1jzi2N8Ox7gMZEgJgM+0y30OlCLLVRQhh1ROBJMXg2DEYG2k7zbeSEaDJe95MtWkBDw/0ZcQhwFsv5smfxV8iXtYl0CH9q3b2EclZQJTLbnRJMfJTEioL0kXwaqYGWoS8sZMIYw/25Ft7EIQr64Ko/RNkO9rjXFkGBfkWL+X9entPy7sKuMGHVU2KqdspoZv9cYRphAvst1UTmfn+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlKG8aHd/d3FjZBnen9PrBiAGB9/Z/Eb5pUcrOWsL7w=;
 b=LiXDtmmf7PKMmB+zGlugGk10ZY73VJRfbeGHw93m1QPhYFU+5DNOpbR6Z9GUDTCHfws18KjxjQ4GOPL+ZWWM0pMlx2Sr/BWON0FzI5y7YB9iaKKe4+fYXrypEbexzvG7l1IXhCZB37H8zcdlYeinaNECQJM1cGQHn+v2EYy+J5A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Tue, 25 Aug 2020 02:56:00 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 02:56:00 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: correct the thermal alert temperature limit
 settings
Date: Tue, 25 Aug 2020 10:54:58 +0800
Message-Id: <20200825025458.21396-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HKAPR03CA0025.apcprd03.prod.outlook.com
 (2603:1096:203:c9::12) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HKAPR03CA0025.apcprd03.prod.outlook.com (2603:1096:203:c9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.10 via Frontend Transport; Tue, 25 Aug 2020 02:55:58 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f7db11a-9941-40b7-21b8-08d848a265ca
X-MS-TrafficTypeDiagnostic: DM6PR12MB3963:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB396319972DE19AFB612663EAE4570@DM6PR12MB3963.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: asgLq2aWZgEikFSI02nI9VvwwTx4LOAGgY1mYpy2i1/kYP5leW9g4OMXprnLD5rr89YHKUB4QfQuXsK0uYUE3BpdYCY1PPPv41ROrKiwC1gFt6eQ/4NAm6I/cpEeMeCztYftBbGt7HBKovNZLF27mBpi7V8oegpL9kUc+tOBjSqbqXQEmwt7+gaA3FjSpNc0W4Ofn3wBW2mtFudXmIkKDLpeP6odNX2ydc68HV1B8jnUF0X6QsdvHS/1KF7np27PWIB8eMCLZUm0pZ2wTt9pLpBBAVDb/EKVqL29hxyPRuWujcqcS8UaQ03ptJayAd9NvjXAdJcbHVBVaCB8eGD3Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(478600001)(8936002)(2906002)(83380400001)(44832011)(66946007)(186003)(956004)(8676002)(66476007)(5660300002)(66556008)(26005)(2616005)(4326008)(316002)(52116002)(86362001)(16576012)(1076003)(6916009)(6486002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ztDiYR5nnjQDQ2FhM1t9UH379n5icInNqaVuBU/6CW3+gz9bnji0CAxaeVjdqD1ueiP9AbqA170YLjst0oZzPq2M9FkjCaTgzT2CNaVCYAh6jYICM7nE4XT6F/4NHqCpu851D97Mra9xvQMEYVBQRFbDQQvcq/rDIWrCAXuQ8LjJAWO1EX+GGonfUuECMxcpdqeuCTApxNBwzGcVewA2TKns9UCQRh6nNrBanriAqJ0Ci79UlpEGd6V8bcjbeDs47q9h3Axslf9McJ5xVAdfcIkfcoSTy9DUbB4zRMSj2XBViyX/z/BmdP+FzE2WnIAxMGQ2mZ3TNn1+zF66OFpH6rVQmuBtTjF+lLpTcBJA1+QIxWwcQmIE4KTq/pEb0TlAgTp8z5Anjb8TdjIcznBX0cjYbIYVnI4obqTBCLHBbxRaU40Odoll7TaeAZ8t3PuSDdv7OWg8/xKC1lrzgLL6Zzo/dbwJHT3M7XvearYV3QMSDJmJ9zeeCSf/XDmrM7z2dQ6IFjJ134kxiA8D2TbCbg1kEPM7avZEyPqvlWO+i/+Cwth/qjtNDz2f3GTuoNxUtNci1VZwrBm8ArmT/oEC6wqZQFqgfxbfHiPMELKaSaqymnbtI9Xqy8qmklgp9qGL5lAwl58bn6GwhBdj1MCZ4w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7db11a-9941-40b7-21b8-08d848a265ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 02:56:00.5441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4naD11Kr8QTWTIlR+7exV0gIhYa1BnR5rf7ylL40y11ZvPJ4kJy2uc9QEkxjhIkL
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 kenneth.feng@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do the maths in celsius degree. This can fix the issues caused
by the changes below:

drm/amd/pm: correct Vega20 swctf limit setting
drm/amd/pm: correct Vega12 swctf limit setting
drm/amd/pm: correct Vega10 swctf limit setting

Change-Id: Ia49936240106a3172d10ffc44e51d3c9ba00763d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega10_thermal.c   | 15 +++++++--------
 .../drm/amd/pm/powerplay/hwmgr/vega12_thermal.c   | 15 +++++++--------
 .../drm/amd/pm/powerplay/hwmgr/vega20_thermal.c   | 15 +++++++--------
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index ce9514c881ec..d572ba4ec9b1 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -367,14 +367,13 @@ static int vega10_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 		(struct phm_ppt_v2_information *)(hwmgr->pptable);
 	struct phm_tdp_table *tdp_table = pp_table_info->tdp_table;
 	struct amdgpu_device *adev = hwmgr->adev;
-	int low = VEGA10_THERMAL_MINIMUM_ALERT_TEMP *
-			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
-	int high = VEGA10_THERMAL_MAXIMUM_ALERT_TEMP *
-			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	int low = VEGA10_THERMAL_MINIMUM_ALERT_TEMP;
+	int high = VEGA10_THERMAL_MAXIMUM_ALERT_TEMP;
 	uint32_t val;
 
-	if (low < range->min)
-		low = range->min;
+	/* compare them in unit celsius degree */
+	if (low < range->min / PP_TEMPERATURE_UNITS_PER_CENTIGRADES)
+		low = range->min / PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	if (high > tdp_table->usSoftwareShutdownTemp)
 		high = tdp_table->usSoftwareShutdownTemp;
 
@@ -385,8 +384,8 @@ static int vega10_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 
 	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
 	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
-	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
-	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, high);
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, low);
 	val &= (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK) &
 			(~THM_THERMAL_INT_CTRL__THERM_INTH_MASK_MASK) &
 			(~THM_THERMAL_INT_CTRL__THERM_INTL_MASK_MASK);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
index e755fc0c9886..7ace439dcde7 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
@@ -173,14 +173,13 @@ static int vega12_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 	struct phm_ppt_v3_information *pptable_information =
 		(struct phm_ppt_v3_information *)hwmgr->pptable;
 	struct amdgpu_device *adev = hwmgr->adev;
-	int low = VEGA12_THERMAL_MINIMUM_ALERT_TEMP *
-			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
-	int high = VEGA12_THERMAL_MAXIMUM_ALERT_TEMP *
-			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	int low = VEGA12_THERMAL_MINIMUM_ALERT_TEMP;
+	int high = VEGA12_THERMAL_MAXIMUM_ALERT_TEMP;
 	uint32_t val;
 
-	if (low < range->min)
-		low = range->min;
+	/* compare them in unit celsius degree */
+	if (low < range->min / PP_TEMPERATURE_UNITS_PER_CENTIGRADES)
+		low = range->min / PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	if (high > pptable_information->us_software_shutdown_temp)
 		high = pptable_information->us_software_shutdown_temp;
 
@@ -191,8 +190,8 @@ static int vega12_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 
 	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
 	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
-	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
-	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, high);
+	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, low);
 	val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
 
 	WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
index a9bc9d16641a..364162ddaa9c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
@@ -243,14 +243,13 @@ static int vega20_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 	struct phm_ppt_v3_information *pptable_information =
 		(struct phm_ppt_v3_information *)hwmgr->pptable;
 	struct amdgpu_device *adev = hwmgr->adev;
-	int low = VEGA20_THERMAL_MINIMUM_ALERT_TEMP *
-			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
-	int high = VEGA20_THERMAL_MAXIMUM_ALERT_TEMP *
-			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	int low = VEGA20_THERMAL_MINIMUM_ALERT_TEMP;
+	int high = VEGA20_THERMAL_MAXIMUM_ALERT_TEMP;
 	uint32_t val;
 
-	if (low < range->min)
-		low = range->min;
+	/* compare them in unit celsius degree */
+	if (low < range->min / PP_TEMPERATURE_UNITS_PER_CENTIGRADES)
+		low = range->min / PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	if (high > pptable_information->us_software_shutdown_temp)
 		high = pptable_information->us_software_shutdown_temp;
 
@@ -261,8 +260,8 @@ static int vega20_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 
 	val = CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
 	val = CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
-	val = CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
-	val = CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
+	val = CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, high);
+	val = CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, low);
 	val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
 
 	WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
