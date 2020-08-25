Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364B2C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 03:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC922083B
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 03:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vE8vEBGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC922083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C7936E82D;
	Tue, 25 Aug 2020 03:39:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 554816E835
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 03:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lx+D0lZ7RLsDI/bCaMwbz6GyEW1yyTx0BItCi/q0XeBNq5o7t8LDQT1+XhxA27IDsUAhuoJQs2ZZjXz9Wk+vBH5mAeAkCExBnPUBqrcz7vcLHFnRFz6ktg8zh5GyVvGmzrTl5Fnh5Y+rJOdcbh5E0DyteeZG8SP6hnu5pVLyrn0Z0Jd8aYg/gmdSzfj3slmgdp/1C86uD6j3j7VaLfLj0jCzJSKyj2qqZIBXTK+9LH2do8/UQSbSIVxGDeRjYWNM3DHE+uYAeszkY/chL6c+W2XfYWx1ntQnBcWV3e552+cQQz1nv8vcJP/v/idZdJRQLeW0exJAmltXfyE3iYa4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfLNH0EQPk+pT76CsaMb1I0MTzT8kCbU8IXAc1+gz38=;
 b=W5QmeexGeXdyPbMZYfnWsgvNVEit+mJCls84g4U1mt7Lqjofqlcr7W6XZsEiMgqldxML+WzVrcocjtllmNctOMZDRxFOoGc5HLi109BC4PmThaW1tNSG68I6yCKNbcii+9xVSXn0Cr3BnLwwyBuUWJBktXLXhazwjgfJTP8xwrtWFH0KLh9JXE+5W4l/tPBvscCUurz5gkIH+z78AHStexTK/Nj4ZgL+s5t+G/A5pTzsqoAcq35NMYrDCTx08EmnjaupUhCB5lg1Nzj4Sv4HL9EWZ9lNaXVCbmZ3sUM2ttW8ruV1f2GDxvJ+6tENa5dGIp+muxW537alFFlKA8B1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfLNH0EQPk+pT76CsaMb1I0MTzT8kCbU8IXAc1+gz38=;
 b=vE8vEBGpnI6HrN9yOGpn1rohRxLEXtp1tGiwFktxC5bIKuttMlXYfW+inpX+P6/JxMg1QKZi7M9pgiGOI+yLoC+BtsGKNQw9BTtxeZmPT8a/Drp7XbmgBFKhbYlqtOBl6LOA4jimGJVZ2QR4CPEZ+MufQ3AUjuwENjZbPKNjOKk=
Received: from MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 by MN2PR12MB3984.namprd12.prod.outlook.com (2603:10b6:208:16f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 25 Aug
 2020 03:39:26 +0000
Received: from MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::9d0e:bc15:1b8f:84ad]) by MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::9d0e:bc15:1b8f:84ad%2]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 03:39:26 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: correct the thermal alert temperature limit
 settings
Thread-Topic: [PATCH] drm/amd/pm: correct the thermal alert temperature limit
 settings
Thread-Index: AQHWeotEvR/RQOMGLEmSfm+K/SXXK6lILWAQ
Date: Tue, 25 Aug 2020 03:39:25 +0000
Message-ID: <MN2PR12MB4175966E2D643254D4D05F828E570@MN2PR12MB4175.namprd12.prod.outlook.com>
References: <20200825025458.21396-1-evan.quan@amd.com>
In-Reply-To: <20200825025458.21396-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-25T03:39:19Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=691446c8-5504-48e6-820b-00001776d72a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-25T03:39:19Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7cd6ace7-7b47-485f-bed3-00004287afae
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 090468c9-d4a0-44b3-0bd1-08d848a876f9
x-ms-traffictypediagnostic: MN2PR12MB3984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB398411488DADD4A2D53F336B8E570@MN2PR12MB3984.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3HJjIDg4DpGOwrP5hmDq/JAyNUlAPe7aWPZs5024OWztb69oeHS0RN9aItv9u1yykCl6L8cE/I/2K4MK2RkUXEGL/Mlx7H4t2fBpJzl6Oj2d7BnFYlhw6anFEKvaDKI0BKTXVa7XEYwUBaQ17cdlO7XwsF+3FiIuSV8F2RqqIPyTRnAKFW6xr/kEzySL5Nqn84N8nCaZ8arnKBULfwmbqWSew9FdYuhTr1plNrtjMrzN5/ogIIEeboyO5D2pmJ+oMd5aqlHUlH8MQmdf12mlvA6NMnzisIrzYARNGlogtsShf7ylGMqfVq2U2qrYy+mtcteD8c42Rw7Qt5IxWgxbWg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4175.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(316002)(4326008)(53546011)(7696005)(6506007)(478600001)(26005)(15650500001)(55016002)(8676002)(9686003)(86362001)(52536014)(2906002)(33656002)(186003)(71200400001)(8936002)(83380400001)(5660300002)(64756008)(66556008)(66946007)(66476007)(76116006)(110136005)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: O2W4D1Q8T1XgZr/z7uuGiQc7mnys0hkr5SAkc2SLfqetTZTbMi6agqebpxx17LUaBzPaZK7AUUlRApGkxupEcSSxRrytjPb9t/CTd2g+wADikiCQr+9+NKkO7AO5+kP3N2HIIQrL1lwEBwiZLcamUIg2xgyVocwZYLfboBy07C19YoafTY9Bk5WXi19u5GYJWLXW1ZMxY5d57vGebtut5k02p+xRIJNiw8HU4bcaONaFQ+B9QGt8P9aElCTfUdGSjI0hL9+BGdSrvj+YjWeNUxcMNxHSBbzFdEvya5UGUkzlDkHM9bD3u/vXU+vPgTWgPUSChn1YmDMSaM65SaF36vFnNspi/M6SDKQnem7wOTyWA9oK5rUlBhReXk1bK72q1Xm7RkEYRTDQdjp+2ZNeV6A395uM09XHAhkqetz68fKlGohTqfo3lLTz1ObrOEtz3Dk/UI/GCWQPwFJj7vR4toeWPa/m+Y1hp4pe4fpyD7Snnvotjbwg58R3QJ2+uglBxbOKifO+xZLwIvTz2nFnIIpznHaqVVhf3Zsi35GOY8ISji6LbmQQzia38cTCUUnKaCk/TnQ+BOayGQeCy03/V2efWU24ryx/mRC43l4ZsSec9lv6EJPe6OOvgk6b23naFOi1gpLbrMAsDsODqTlzbA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4175.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090468c9-d4a0-44b3-0bd1-08d848a876f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 03:39:25.9877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/t7rrI8LUwn7ldCUDoylFE21nEe9YwXE+5z4iK1DCuyKYls1Jhb1o/Z4bRsOnqn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3984
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

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>



-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Tuesday, August 25, 2020 10:55 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: correct the thermal alert temperature limit settings

Do the maths in celsius degree. This can fix the issues caused by the changes below:

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
 
 	WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val); diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
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
+	val = CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, 
+low);
 	val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
 
 	WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
--
2.28.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
