Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F64FC4363D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 15:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84D62399A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 15:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zfA+T3hJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84D62399A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B2696E893;
	Tue, 22 Sep 2020 15:55:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98FFA6E893
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 15:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmLuHkpopoGv5+InfkmXsGGXNOp+gW/+SoaU0z7k5/+x0SSZ1SDNQ5gB+9UF0VbVTREXo5R4cjbLVZxhP1Vp5GXo4sD2FqhD+DzlUvifC5KTUtExhdWGh7b99oanvtR8bVtlYXBGk9dhbZ6dECoWXHlQMKZRQcDLNwdoaTpKi9VEyASr0tY6tASO4RY9000JadZVs9ioDmZDYN1TbUQ1oqScX6hCA20k5daX04JabYJgu+QamARtW/2TXfTqHoXKn1gj77YO2KAVOS87JTdzo5IjqmrZWc5UzqL2xSlYrMM/GkY/jTkomTlN4OoNa+G9/e7OG3lhC36UVoSKBL2k8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cPNIFVcchw9niw3PJ3aWs+OagrEEsEpgS2mPWodfYw=;
 b=hRGI5aCykdZGxUi/8sXDAUezi+F1IHHjbvPZhjDlOdUF6Gv2AAx8tgCcKDltKi7vujzc0jqO7qhmVZfGo+LuUfauu+saGfiot2s6il9KhJYRZEoY1Ed1f4K/wDNHhxsw0JNzCrq+35MGGkDZiAQBtioOHRvMt92TXx+B63/VW3LL8cEBky72sC2kniAhmPzKxay90TjXk4en+d2llPTuqZ1m/vYzoL9jnWWhV8+2ag7rd+2MspGs71RyEfL2WvxObsnG1HNeJ6YD/s51Ium9N4tPg4AGMIK0b9+O0+20W4QRNa0iUMh0jpgcUlGs+m6jaLefh2vpR6qtHm/eiWezug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cPNIFVcchw9niw3PJ3aWs+OagrEEsEpgS2mPWodfYw=;
 b=zfA+T3hJKwfHOgRGAhHfCGpY9OheFhyd649HdJCR6Rn+lDbD7d5ABdJ63vooIsbbK4EY/lMzUn3Q+tvs/bI6Utdcl0fvd6JCyoy5eYwqNU9DvDMFelGcFbykAKiOBnpnvvhqh3cuFgurMUKQAE2YVrxMo7ZJHvwfgfwV5Rv1xQA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3221.namprd12.prod.outlook.com (2603:10b6:a03:135::29)
 by BYAPR12MB3077.namprd12.prod.outlook.com (2603:10b6:a03:db::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 22 Sep
 2020 15:55:20 +0000
Received: from BYAPR12MB3221.namprd12.prod.outlook.com
 ([fe80::d492:66f5:21c4:7046]) by BYAPR12MB3221.namprd12.prod.outlook.com
 ([fe80::d492:66f5:21c4:7046%7]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 15:55:20 +0000
From: Ryan Taylor <ryan.taylor@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] Add PP_FEATURE_MASK comments
Date: Tue, 22 Sep 2020 08:55:00 -0700
Message-Id: <20200922155500.9239-1-ryan.taylor@amd.com>
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2600:1700:9260:7260::17]
X-ClientProxiedBy: BN1PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:408:e2::28) To BYAPR12MB3221.namprd12.prod.outlook.com
 (2603:10b6:a03:135::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Desktop.attlocal.net (2600:1700:9260:7260::17) by
 BN1PR13CA0023.namprd13.prod.outlook.com (2603:10b6:408:e2::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.6 via Frontend Transport; Tue, 22 Sep 2020 15:55:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e1cfe00-484d-42cd-7794-08d85f0fe834
X-MS-TrafficTypeDiagnostic: BYAPR12MB3077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB30772B79797D209E103940A8EA3B0@BYAPR12MB3077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/qoGer5JnJxSsbv6IOdVNE68FQ7033LUMad8+op2NJedLUyGZrVI4wcYY0rxmoZY8fGM72aDuCtLu0HbFxdrvipBbkXh0whCkMb+LTNO4UT7hiIfUOyz6BlwauUgWKBhox09BcbEP1smkpsKg2UhblqTq4XovvKjPUzc4IFsn68SgpAEb/p8TVwH3e6iP6Kxb0LUR7nrtUfcNbBwXpuKpcSEaeYBzC8MrA/qGGcf9wa/UF1QRxGUcXlR2q62NyGM17vO1tDgZj3QnGoV4q1xVzOYgc7gFWQCbTm4K8mpkZYcNDXZqV7fRS0XS1msj52QQWtekpQobMxcX7KCWLmWcX1nkvRqhaIRD8lFXkC3jG2f3ZufevY6psZNwu8Ip+f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3221.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(54906003)(478600001)(66946007)(44832011)(6506007)(5660300002)(4326008)(2616005)(66476007)(66556008)(83380400001)(6486002)(186003)(1076003)(6666004)(2906002)(8676002)(8936002)(52116002)(16526019)(316002)(86362001)(36756003)(6916009)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: y6deg+6zfnrZtHFz7yC46I/5BRbzINKp/XfxAyrLBgf8INuiM1fy+SrkdsB/HxoZbQmWvBXRjZneyJo761eyCl41FkwWDiOV77jTo31V9wLWkSQa10sudui63qQkTRIG4zN7yRFxJsuWua58MFfC3g3NiXK3EJykJIZCftjwEQyGO4HPyT0NFf5TCWM8NpbslqcODGSwodQssOXdQToU3LBITRJabccpqbkG+2A/4h3H/v/BK2DHupfOrlmU0lLIzHzmH6T9tz3UDzkmn7SAjzZeDRS5Y01p104m1YaebRamAKmI2+0JZq2dfHu+z4Yk98eVbyb/cBh3ngh2t65UPUaJ+q34cvW2OkoNyvSiKU3VU2Kp0xkEUVd02z+nhHgLUPICq0L8mxGGV/HAVnXc5SAXK4LyetdqflD2mkQiHmlzyFZGqh23kK/q6/mWKtqPWatnOeCc2XC1i2SwcBNTB3VP1fUTkX+dprgrPLcgU4QEMeBqwllk34l1XBv74HkLfZQZacPP9BMcdCQbkVCEf459jJbO74dEGz29ijrEYMnSFwI7sl/juFtUsD7CcOhktTQDSlRVsyfLAhn7JEyhCjLgtNqRG4LiV6Qm6yxvPq6MeSDhceEUi1WuIxKjYpNMUDHg9UlhwZiFp+fxZ578buWGpfc1q/K47ovRBGNMqQE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1cfe00-484d-42cd-7794-08d85f0fe834
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 15:55:20.1164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKii+jqhB/ENqr1m0Ph0oKc5vsivFClGhdRytGPt0nd9UDRdURAOz1VK8Hz5UD1+WW2ebgU8/9Dnyg0oqJIJWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3077
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Ryan Taylor <ryan.taylor@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Documents PP_FEATURE_MASK enum.
Provides instructions on how to use ppfeaturemasks.

v2: Improved enum definitions. Adds kernel command line
    parameters to ppfeaturemask instructions.

Signed-off-by: Ryan Taylor <ryan.taylor@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index e98c84ef206f..7c84d5beb600 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -128,6 +128,34 @@ enum amd_powergating_state {
 #define AMD_PG_SUPPORT_ATHUB			(1 << 16)
 #define AMD_PG_SUPPORT_JPEG			(1 << 17)
 
+/**
+* enum PP_FEATURE_MASK - Used to mask power play features.
+*
+* @PP_SCLK_DPM_MASK: Dynamic adjustment of the system (graphics) clock.
+* @PP_MCLK_DPM_MASK: Dynamic adjustment of the memory clock.
+* @PP_PCIE_DPM_MASK: Dynamic adjustment of PCIE clocks and lanes.
+* @PP_SCLK_DEEP_SLEEP_MASK: System (graphics) clock deep sleep.
+* @PP_POWER_CONTAINMENT_MASK: Power containment.
+* @PP_UVD_HANDSHAKE_MASK: Unified video decoder handshake.
+* @PP_SMC_VOLTAGE_CONTROL_MASK: Dynamic voltage control.
+* @PP_VBI_TIME_SUPPORT_MASK: Vertical blank interval support.
+* @PP_ULV_MASK: Ultra low voltage.
+* @PP_ENABLE_GFX_CG_THRU_SMU: SMU control of GFX engine clockgating.
+* @PP_CLOCK_STRETCH_MASK: Clock stretching.
+* @PP_OD_FUZZY_FAN_CONTROL_MASK: Overdrive fuzzy fan control.
+* @PP_SOCCLK_DPM_MASK: Dynamic adjustment of the SoC clock.
+* @PP_DCEFCLK_DPM_MASK: Dynamic adjustment of the Display Controller Engine Fabric clock.
+* @PP_OVERDRIVE_MASK: Over- and under-clocking support.
+* @PP_GFXOFF_MASK: Dynamic graphics engine power control.
+* @PP_ACG_MASK: Adaptive clock generator.
+* @PP_STUTTER_MODE: Stutter mode.
+* @PP_AVFS_MASK: Adaptive voltage and frequency scaling.
+*
+* To override these settings on boot, append amdgpu.ppfeaturemask=<mask> to
+* the kernel's command line parameters. This is usually done through a system's
+* boot loader (E.g. GRUB). If manually loading the driver, pass
+* ppfeaturemask=<mask> as a modprobe parameter.
+*/
 enum PP_FEATURE_MASK {
 	PP_SCLK_DPM_MASK = 0x1,
 	PP_MCLK_DPM_MASK = 0x2,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
