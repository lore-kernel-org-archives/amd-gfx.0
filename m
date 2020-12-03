Return-Path: <SRS0=Gsig=FH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ACBC6369E
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 01:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5CFF20B80
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 01:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CFF20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C10B6EB23;
	Thu,  3 Dec 2020 01:35:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B08526EB23
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Dec 2020 01:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmkPWUTxncopYp5UXJ3S40jHLHN1qzjEQe4L5yTCAS24P0c4kH4SvqJlye60au3T912RN+7d7uNjSoGXVThdPYsft6xkYeO0Zno0mCCRuajnENY6KD6lwMSWAfKUoFDCrvq/QoFw9D2hG8ykAXzjWJXPE7r9R+XUp2y6BlvOf/PkutIxgKLtuyPpsFLR5PSIAN8DEiuY1SS69vaGJtP3IkMxl4I3hLQhw0LfQWCgDBFXsc3cumZdmNKhMhopfIUeg/z6h1yBB3Z945Rrc2EWQ1oHCnZymlkkXim1zySEfoLLdBKKot2zRkRT29eLfWBNFRCBIucsrxx7AQUudu+PxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRs4q8PtrofjToaLCCLISknhPyaQbOky0KHnrMqkBpU=;
 b=kVzoRzY4z991UcxdJN+0gW3xShWxHpkhy2s8DvG0SaKzbV26KZcGRlI/9Rel2fQumqjLvRUj86cn8TRGykN83f/ZGy4dSi3yJ47CQRGsUiZlGGsFkmzTVhLSx1RG6/lx3vWqJVK2rF1KwZ+jIQSjDMUzgHZ6Y9bLEp4aAHbnQQn3lB0KOhcAZ23rkYYOwXfEWShtAFDngX8YH/I0Kss0CNPnn8REBTxrzdKllZVXbzroRp7eBkYWIi/y0xr431UHecf429mbhRgo04c5sBoFpOFoQWdOC+l51ZetNDZNsDE6qMVzvQT8wPK9QsHT8wuQgXTPzeT1i05HMFIfjnBlxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRs4q8PtrofjToaLCCLISknhPyaQbOky0KHnrMqkBpU=;
 b=W9aiQ1aWmEaMh387lGbxgfPbGq7p0u8BJbT2IZ5S7ufTH7tmPiXZv3zMCOvYuYtHoGMsRzik/cIm4bPSXAM8ic8ouMMM6Cm4qwg1QF/Cu7PpBiDsAPsV+u28duB8uNACRaD3637XCia6bkieup58ujnu7/UvTnQTN/Eq2RkZDOg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3772.namprd12.prod.outlook.com (2603:10b6:5:1c3::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.24; Thu, 3 Dec 2020 01:35:37 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Thu, 3 Dec 2020
 01:35:37 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay: parse fan table for CI asics
Thread-Topic: [PATCH] drm/amdgpu/powerplay: parse fan table for CI asics
Thread-Index: AQHWyOg7Umz4qZMzHUSl80Z53WUjYqnkl04Q
Date: Thu, 3 Dec 2020 01:35:37 +0000
Message-ID: <DM6PR12MB261995B8F59ABBE6999153E7E4F20@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201202201747.1433842-1-alexander.deucher@amd.com>
In-Reply-To: <20201202201747.1433842-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e77a9c93-2743-4b55-8ab2-50de617705e3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-03T01:35:20Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b513479f-d4c6-4321-8510-08d8972bbc78
x-ms-traffictypediagnostic: DM6PR12MB3772:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37724872A3FC7A49A776F44EE4F20@DM6PR12MB3772.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1gsJ0EYeAiP6ctKT5y7bJO8kf6kfQnB4Jz1gohxVbnaZTX/nHsTiShN3VLVqXpLbjNtuHq16A4CTiwGDY1XClLs0p30gV7S7f+BDBy4mstu4gNAA6etaf4zN8sgiiP0aUTVg5r5K3AhvUldcb4n+Dc6SNHx94wqvKv8bzoMeoTgk3QLMB6VzitszBWYqkAgNA3984iAz3HqpjlY4RaweQvsOfWA3OWhWy/oh0ab7aEmwspDF1jWjylJNsEYgkFZ2kCkesLkBDox0Vhpa5Ed+CQtqU5OhlvG3lPBoAPp34dYSiSDcpDmsLwSJYXtJ2xW1AhSWbKcMjkJ99RAxYqhpSOT6rKK7v2GtyiGQkDvbvU6CLWSSLV8O/fcd9CknZc5j+M7SQA/WWoFZyOFVCN86Xg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(71200400001)(66556008)(66946007)(45080400002)(316002)(64756008)(9686003)(83380400001)(2906002)(66476007)(8676002)(66446008)(4326008)(76116006)(478600001)(55016002)(26005)(966005)(53546011)(6506007)(110136005)(52536014)(33656002)(186003)(8936002)(86362001)(7696005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?w4xbx+nAisQgspWi/uS5+DwbAl3zS8CoqETj6EBumNoufu6b8AiDdmGs1BwV?=
 =?us-ascii?Q?cEkFftjkzHy2kiVkV8hkh78xMSm+Tlk6fqCUDYM10Ji65Sei24m4ijE7I4vL?=
 =?us-ascii?Q?9BSu5O99qeeguEfO1hRh2dfBfn/lExzAmtCDrhhZfej1bDyqx4AVUWGi9JO4?=
 =?us-ascii?Q?NN7mGLmOkEE4v4sQM2sNYv+jyQL4JJwNBKWYtvl6+gxVogL3R5KRQa8ZyQHi?=
 =?us-ascii?Q?dZwT3EKKtmeW56eBM8V6lKaVbGwsfK8+NZMHAbcxK7JroN+iVjfCvB4IRP+V?=
 =?us-ascii?Q?eOg8q0gJeuatpnL1q/zr3q8PJPfivIT5dqr14gNlr5yQkviedSNzg51fdtqO?=
 =?us-ascii?Q?uVrKLg+RoHKAUEaT72r3UCJwgNQ5qBgjpEy8aAbtEOUvjFdbzIYg2Nykespj?=
 =?us-ascii?Q?AcEa1JoooizIow7DplwOXAYz0yN3BLUdxoAP2DsnJF0lT4M09u333ATSU2LO?=
 =?us-ascii?Q?rMbMGSlrCUDoc0oaZLbgMRee4y+zUDIP0qXAcIJu4g7luG2TU1nL8oRGQ0Na?=
 =?us-ascii?Q?CsLdSDGwcB0a2VhQzluZgIRB5oBYrY2RwvT8lto7HBarj/8WVGdyRJHhOJY+?=
 =?us-ascii?Q?d2hEIVqxgcW/TGrxzSPxTILEPEnvZ4uoW+aIlzlkUCHYO2AB/qyKu/gFF/xe?=
 =?us-ascii?Q?y0UVhebJgXGMsZuU36XFw6bN82pOjLrgXwd2VSdZvcrZyHEeqwoXoigBtlsM?=
 =?us-ascii?Q?tACI0Wa7nb39vPf5KM0nxs7WgukK2KKngo5IjB7L1/g2RS2drnlM3FZqOdhe?=
 =?us-ascii?Q?u6kk4alTF8lzH+RV2H7xkG/sw2LPwT4UO4fJhppn+Sq9HOAdk4E5ytJ7Hux3?=
 =?us-ascii?Q?AUGH4Klm9y17vhjBb80e3pZKEpbggbqIuy7WqFgqLBj5hxPntg8uT5FC075d?=
 =?us-ascii?Q?eAge5b86FYWENZ9zBZ36WWI1ZZplV5crnVxdFiIazvP+Y8snevd8V8TCIO1n?=
 =?us-ascii?Q?Af9lWxLxL9N9qe4y/KzfCSex/iRdSvo/ktRCQ5QUqhc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b513479f-d4c6-4321-8510-08d8972bbc78
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 01:35:37.2835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uV10zrPG0xd5kY+tRHUtM8jVFErzZsD19+1z6Ps80f/nsysBlQ9E9eWvFuj4UH8x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3772
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, December 3, 2020 4:18 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/powerplay: parse fan table for CI asics

Set up all the parameters required for SMU fan control if supported.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D201539&amp;data=04%7C01%7Cevan.quan%40amd.com%7C5c05d069b0e04d822a1608d896ff5c89%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637425370804495239%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=WNkQfQiTDGtHx7V8pw2vntXXWeOv6KWA1qENo6wiTAw%3D&amp;reserved=0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/pm/powerplay/hwmgr/processpptables.c  | 103 +++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index 48d550d26c6a..182118e3fd5f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -24,6 +24,8 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
+
 #include <drm/amdgpu_drm.h>
 #include "processpptables.h"
 #include <atom-types.h>
@@ -980,6 +982,8 @@ static int init_thermal_controller(
 struct pp_hwmgr *hwmgr,
 const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table)
 {
+struct amdgpu_device *adev = hwmgr->adev;
+
 hwmgr->thermal_controller.ucType =
 powerplay_table->sThermalController.ucType;
 hwmgr->thermal_controller.ucI2cLine =
@@ -1004,7 +1008,104 @@ static int init_thermal_controller(
    ATOM_PP_THERMALCONTROLLER_NONE != hwmgr->thermal_controller.ucType,
    PHM_PlatformCaps_ThermalController);

-hwmgr->thermal_controller.use_hw_fan_control = 1;
+        if (powerplay_table->usTableSize >= sizeof(ATOM_PPLIB_POWERPLAYTABLE3)) {
+const ATOM_PPLIB_POWERPLAYTABLE3 *powerplay_table3 =
+(const ATOM_PPLIB_POWERPLAYTABLE3 *)powerplay_table;
+
+if (0 == le16_to_cpu(powerplay_table3->usFanTableOffset)) {
+hwmgr->thermal_controller.use_hw_fan_control = 1;
+return 0;
+} else {
+const ATOM_PPLIB_FANTABLE *fan_table =
+(const ATOM_PPLIB_FANTABLE *)(((unsigned long)powerplay_table) +
+      le16_to_cpu(powerplay_table3->usFanTableOffset));
+
+if (1 <= fan_table->ucFanTableFormat) {
+hwmgr->thermal_controller.advanceFanControlParameters.ucTHyst =
+fan_table->ucTHyst;
+hwmgr->thermal_controller.advanceFanControlParameters.usTMin =
+le16_to_cpu(fan_table->usTMin);
+hwmgr->thermal_controller.advanceFanControlParameters.usTMed =
+le16_to_cpu(fan_table->usTMed);
+hwmgr->thermal_controller.advanceFanControlParameters.usTHigh =
+le16_to_cpu(fan_table->usTHigh);
+hwmgr->thermal_controller.advanceFanControlParameters.usPWMMin =
+le16_to_cpu(fan_table->usPWMMin);
+hwmgr->thermal_controller.advanceFanControlParameters.usPWMMed =
+le16_to_cpu(fan_table->usPWMMed);
+hwmgr->thermal_controller.advanceFanControlParameters.usPWMHigh =
+le16_to_cpu(fan_table->usPWMHigh);
+hwmgr->thermal_controller.advanceFanControlParameters.usTMax = 10900;
+hwmgr->thermal_controller.advanceFanControlParameters.ulCycleDelay = 100000;
+
+phm_cap_set(hwmgr->platform_descriptor.platformCaps,
+    PHM_PlatformCaps_MicrocodeFanControl);
+}
+
+if (2 <= fan_table->ucFanTableFormat) {
+const ATOM_PPLIB_FANTABLE2 *fan_table2 =
+(const ATOM_PPLIB_FANTABLE2 *)(((unsigned long)powerplay_table) +
+       le16_to_cpu(powerplay_table3->usFanTableOffset));
+hwmgr->thermal_controller.advanceFanControlParameters.usTMax =
+le16_to_cpu(fan_table2->usTMax);
+}
+
+if (3 <= fan_table->ucFanTableFormat) {
+const ATOM_PPLIB_FANTABLE3 *fan_table3 =
+(const ATOM_PPLIB_FANTABLE3 *) (((unsigned long)powerplay_table) +
+le16_to_cpu(powerplay_table3->usFanTableOffset));
+
+hwmgr->thermal_controller.advanceFanControlParameters.ucFanControlMode =
+fan_table3->ucFanControlMode;
+
+if ((3 == fan_table->ucFanTableFormat) &&
+    (0x67B1 == adev->pdev->device))
+hwmgr->thermal_controller.advanceFanControlParameters.usDefaultMaxFanPWM =
+47;
+else
+hwmgr->thermal_controller.advanceFanControlParameters.usDefaultMaxFanPWM =
+le16_to_cpu(fan_table3->usFanPWMMax);
+
+hwmgr->thermal_controller.advanceFanControlParameters.usDefaultFanOutputSensitivity =
+4836;
+hwmgr->thermal_controller.advanceFanControlParameters.usFanOutputSensitivity =
+le16_to_cpu(fan_table3->usFanOutputSensitivity);
+}
+
+if (6 <= fan_table->ucFanTableFormat) {
+const ATOM_PPLIB_FANTABLE4 *fan_table4 =
+(const ATOM_PPLIB_FANTABLE4 *)(((unsigned long)powerplay_table) +
+       le16_to_cpu(powerplay_table3->usFanTableOffset));
+
+phm_cap_set(hwmgr->platform_descriptor.platformCaps,
+    PHM_PlatformCaps_FanSpeedInTableIsRPM);
+
+hwmgr->thermal_controller.advanceFanControlParameters.usDefaultMaxFanRPM =
+le16_to_cpu(fan_table4->usFanRPMMax);
+}
+
+if (7 <= fan_table->ucFanTableFormat) {
+const ATOM_PPLIB_FANTABLE5 *fan_table5 =
+(const ATOM_PPLIB_FANTABLE5 *)(((unsigned long)powerplay_table) +
+       le16_to_cpu(powerplay_table3->usFanTableOffset));
+
+if (0x67A2 == adev->pdev->device ||
+    0x67A9 == adev->pdev->device ||
+    0x67B9 == adev->pdev->device) {
+phm_cap_set(hwmgr->platform_descriptor.platformCaps,
+    PHM_PlatformCaps_GeminiRegulatorFanControlSupport);
+hwmgr->thermal_controller.advanceFanControlParameters.usFanCurrentLow =
+le16_to_cpu(fan_table5->usFanCurrentLow);
+hwmgr->thermal_controller.advanceFanControlParameters.usFanCurrentHigh =
+le16_to_cpu(fan_table5->usFanCurrentHigh);
+hwmgr->thermal_controller.advanceFanControlParameters.usFanRPMLow =
+le16_to_cpu(fan_table5->usFanRPMLow);
+hwmgr->thermal_controller.advanceFanControlParameters.usFanRPMHigh =
+le16_to_cpu(fan_table5->usFanRPMHigh);
+}
+}
+}
+}

 return 0;
 }
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C5c05d069b0e04d822a1608d896ff5c89%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637425370804495239%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=inchXNJJ9G5l8tyMG%2FPRHR7yXBU%2FB3btNQwIGFI4uQ8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
