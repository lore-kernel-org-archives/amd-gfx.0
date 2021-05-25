Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45689C2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 08:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B1F6135F
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 08:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B1F6135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 390056E9BC;
	Tue, 25 May 2021 08:06:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DE496E9BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 08:06:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAfUvt0s1qwtfrTFDWB4zZH9IjuLso8/SBh3XUQ36owtB/0zuQqM/UuPELt87/R1mRR2k6FH/bjIArjvGAuEiFXH4ie5iM/ca5McLj8nW8eB/b66UwrmTUpmkoDwEGL+c90mRhgAYuLInE6o0t+TS6sJ1lVDThicRglz8953d35Z59nkNHTgr66nLfxXYXYBzxlXElX8Xwx59rmoOjFoYivpraVmpbsBDotmCgsdMDLpSi6+SnfjcWMlKc2mAUjdMGoL3csRfuOiSma+eac8c6zIiOnsxrvtw/CgDLAW4+KnsU7dNG7zgroIGyKsms+DsvUmb7Xhxup47Z5wwzpiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jX16iy36GINPYIm1DMnffSE98hBYs3/qIoKb4XmasVU=;
 b=jot+ftTGlJ/aoQdpN6HrDBz4zN5vQtQYNKUGAlkZchtHdZed3u0QtXDnhsJ+9rp3ClHwOqdQQw2/qIWF+LMB4qzQN4oMI5hlvSZ4UImqSyUe9QxEOTXT9/vu78pr38Kxf2R9XIM7Er6yvv3GK2hOVexa6WRzM7F7kJSAT7JJ/pszf2c/1/UlHTPQ4xavi2q9ybcnIJ58fl46bg2i5yGSugDyScHyp9v6h07RSQJPTaYwxluKPhVcx8N86p8S/W0+U2iGxFsY/cc9jfvUtDr8HdjoGjxDCyIL4wq5MHMs6cBHV3bAHBaUw6Zmck3duMGOVBLjZ6pbX+MIkyDAox5Osw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jX16iy36GINPYIm1DMnffSE98hBYs3/qIoKb4XmasVU=;
 b=gwTn3uwmVgy/gkJHyg85wbp2IXS+EbognuQm/WbN3YcUEry8wOQTB0l7Anvst9xcA7pkWmXNzmaWlX3mHWCIN+wKJL6lNX3rC7vrQARD4AEpwns4xnsWaSKqm9s6cNtn+BRhDftRZeqmTdPxWF4WkfY4sFDW/SwYqWOS1mmaRZw=
Received: from BY5PR12MB5557.namprd12.prod.outlook.com (2603:10b6:a03:1d4::18)
 by SJ0PR12MB5504.namprd12.prod.outlook.com (2603:10b6:a03:3ad::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 08:06:30 +0000
Received: from BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::b123:6491:dff1:e2b9]) by BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::b123:6491:dff1:e2b9%9]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 08:06:30 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: refine amdgpu_fru_get_product_info
Thread-Topic: [PATCH] drm/amdgpu: refine amdgpu_fru_get_product_info
Thread-Index: AQHXUTEkm/j8+fUpt06ADkkoRwCpSqrz0eGAgAADLXA=
Date: Tue, 25 May 2021 08:06:30 +0000
Message-ID: <BY5PR12MB55571600C28F85596F2B8292EA259@BY5PR12MB5557.namprd12.prod.outlook.com>
References: <20210525064222.32495-1-Jiansong.Chen@amd.com>
 <CY4PR12MB1287299074EFC87B16273934F1259@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287299074EFC87B16273934F1259@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-25T07:46:53Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e605f181-2930-407f-9d46-624a22a84d15;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7914f0ff-2d4d-474b-c3d7-08d91f5400f4
x-ms-traffictypediagnostic: SJ0PR12MB5504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR12MB550446EE85E967148EB24EC0EA259@SJ0PR12MB5504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aG+Yu7fxALYm0uPiTcLWdwjM3U/N8gJ/3SIfAQP9SIkrK2d1698tZJVS11++eVAYOG4zIJyCkrxSIJFxexRTb3Sw+zbE7WKNMlDT4wR/q2PPaWidITG1ire3y7kE+C10Ozon5FhtZvTOMbyMzszWKEmk61dhaVCWsgKIaFKR+MyjohrtH/Q44uKUys6ZWtatZokllpDncvS6786n3dZ1ElFLrmz6EDi9vH/IieSu7mDLb6snad7VyOlrcyRFaXkEYKI7U+vhH8b04yjqQbfhvD5G09hFV8ynkw/NuuBVRCD4jY9GXlPL1jYJZeuhIlN0NA3v3WsqWhsrEBsr/MCQ5RyZJiCqFTZZpLAYZjDsHo8zTAiqjp14fAt3YUEJzJxhE/jMAZbkalvkRAwW67svMHzCp1/cVWPXxfxOIJzKph8mHjhzMJ4wmR/L7o1unn8CP4cE3laB+Tw2iVDpETyoVmhcFeeRgwMX9LYnWvKL5mbm1z2iYnrcPzNRC24m0kyWRG3eZXNy9ZZ7AojrnKgW+Trhz7qyHY4/24MlHqJ+8mLUVJmAh7yOYihBOhvCwUhHd59COEJwBXfyNeMwnebWObpI2tOmefaW8AgVuVp4K5zSnT3ctNIcqMsQbV1WJR6wtB4qlOnds4k0+eD/I7YCQg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(7696005)(53546011)(6506007)(478600001)(45080400002)(966005)(26005)(2906002)(186003)(38100700002)(316002)(52536014)(71200400001)(122000001)(86362001)(110136005)(5660300002)(83380400001)(9686003)(8936002)(66556008)(66446008)(64756008)(66476007)(55016002)(33656002)(76116006)(66946007)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?J02UVpgThQNkifDa+pNyBJX3tz5Wl0TvVqP5hDCfACiI1bqjhom73lDUPl6Q?=
 =?us-ascii?Q?ebfpA+OpeV1PXxZp/N25iPYLaKAPqMsiORkDTKQhn30woEJpeQqikPO7TZwe?=
 =?us-ascii?Q?lbvTebSvS6L+jVpVuKHkzflXnrgwHZnXkLC7V2FUpwBT4JkxLE/2wv/vFzwq?=
 =?us-ascii?Q?wMV+KSgB5+Usf10SeBZBQ17k9DFOerl5jLWg1t0fDtepfKFqfp7VYNX7NtW4?=
 =?us-ascii?Q?HKjZ1jkLXA2oW1HJD5tNXZp38HScXfuqJd1uH3Wh/VAsNgx5uMKuz9PPEzv8?=
 =?us-ascii?Q?yLC5xIeNBd1exf2i6PEIEkBecFw/Tb5lGGfvOXw55gLwY7IahkSVTEakFlcK?=
 =?us-ascii?Q?vQ7nq+R8Pz8dkU76gJff3J0kJ/+e5SGXPk7aZz5FBXlRr2BrGETI0FPPLLLl?=
 =?us-ascii?Q?Cijqrs5+VeM9CRqxBG7opqlMKwF6ZN5Aw0541Boj8X/2+l+ySwfF+KEmGcKs?=
 =?us-ascii?Q?NU3N/2Wgi2TVbd538eC84TNQkyssHd2hr4nwX2JJumYR24pls1Bo/cQfpZcR?=
 =?us-ascii?Q?Tw2HkfupPlepYGpx/Xko55y7GPJju7KXsoHOEoVbOCUSJ6CL00pSJV7AtG4d?=
 =?us-ascii?Q?iHzOn/6erw1/DeSkMq3Hl1tSxRk5I7Q54GzvsyhFasnkknmj51lk7TBXPjv+?=
 =?us-ascii?Q?D34ueVPPsxBPwOm9b4r1RuB5qA+xvCqx1wZXSn5+dJgvjYkyLGa+dM9rQmXl?=
 =?us-ascii?Q?OKQ1W/PJib5TZ7gyXO8/zZcc9oEIwpUOLa2m4ULriIqA/MS0C+d/pkURZAfR?=
 =?us-ascii?Q?5l8qVWhpDUi7QlgJMqBsyngqk8fOD+MKX18zPyckhvMPhlQBsNAA+uIKrdDz?=
 =?us-ascii?Q?ylg1dOGTnFm/jxk+Ca7AeSh7ICnmTxWUoY5mAMcu4Urr94s/S7Mnzzi5pl0u?=
 =?us-ascii?Q?XmQDzFU4xw6dfCfmq0BgjURRJCRVrre+8h1+Q/E6oEiDafraMjVsuhuJFhh0?=
 =?us-ascii?Q?WP2L7qnNqf3oqW4uqUJw8F4MlYLbtqxvgUCmZ4KZ+c0Bok9ROvSnvQLy6+Al?=
 =?us-ascii?Q?03ag/JJhmkaBcfm/MGQZZbEm5C9Cviy8Jm7yTgEIZhC41bx+EAY12uOiHPxz?=
 =?us-ascii?Q?8Pf/ga2Y5+q+kNQ2NkGmoU20xJaCQp5mdaeuvEB0K8X12CdmvSCrBv1p9AjZ?=
 =?us-ascii?Q?azyCKuEIZFIGonLgi/GWgt3oHO/FYGdprLRLEnHazIPLIsXc6nV+OF3fqxAQ?=
 =?us-ascii?Q?zhRcnlOYtGf9PGBgB0tJiulVTd9zVSwSUisxMdOgpZ1TYlbTkz4s6c6dTfJs?=
 =?us-ascii?Q?cthQzKKypwfQbTpD8iI/XLDKKnuTXGqnCqiNIBnEDuLUgOd2xBBL069thG0k?=
 =?us-ascii?Q?yMLuwE68oK6gD5kk8XGx5kcF?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7914f0ff-2d4d-474b-c3d7-08d91f5400f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 08:06:30.1678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+7gpGuq08Hbt54mRdEJmUdGKdKnp3FzNXHWpJse4tTOmjzA4b5TYyu5c+LuV2xHIaH7zbYfCOXfXiyAWO6vDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5504
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I think we still could keep them to be more informative for the moment.

Regards,
Jiansong
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Tuesday, May 25, 2021 3:47 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: refine amdgpu_fru_get_product_info

[AMD Public Use]

+	len = size;
 	/* Serial number should only be 16 characters. Any more,
 	 * and something could be wrong. Cap it at 16 to be safe
 	 */
-	if (size > 16) {
+	if (len >= sizeof(adev->serial)) {
 		DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely a mistake");
-		size = 16;
+		len = sizeof(adev->serial) - 1;
 	}

The hardcoded '16' in comment/warning printing needs to be dropped as well?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jiansong Chen
Sent: Tuesday, May 25, 2021 2:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: refine amdgpu_fru_get_product_info

1. eliminate potential array index out of bounds.
2. return meaningful value for failure.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I9be36eb2e42ee46cd00464b0f2c35a4e4ea213e3
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 42 ++++++++++---------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 8f4a8f8d8146..39b6c6bfab45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -101,7 +101,8 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,  int amdgpu_fru_get_product_info(struct amdgpu_device *adev)  {
 	unsigned char buff[34];
-	int addrptr = 0, size = 0;
+	int addrptr, size;
+	int len;
 
 	if (!is_fru_eeprom_supported(adev))
 		return 0;
@@ -109,7 +110,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	/* If algo exists, it means that the i2c_adapter's initialized */
 	if (!adev->pm.smu_i2c.algo) {
 		DRM_WARN("Cannot access FRU, EEPROM accessor not initialized");
-		return 0;
+		return -ENODEV;
 	}
 
 	/* There's a lot of repetition here. This is due to the FRU having @@ -128,7 +129,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
-		return size;
+		return -EINVAL;
 	}
 
 	/* Increment the addrptr by the size of the field, and 1 due to the @@ -138,43 +139,45 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product name, ret:%d", size);
-		return size;
+		return -EINVAL;
 	}
 
+	len = size;
 	/* Product name should only be 32 characters. Any more,
 	 * and something could be wrong. Cap it at 32 to be safe
 	 */
-	if (size > 32) {
+	if (len >= sizeof(adev->product_name)) {
 		DRM_WARN("FRU Product Number is larger than 32 characters. This is likely a mistake");
-		size = 32;
+		len = sizeof(adev->product_name) - 1;
 	}
 	/* Start at 2 due to buff using fields 0 and 1 for the address */
-	memcpy(adev->product_name, &buff[2], size);
-	adev->product_name[size] = '\0';
+	memcpy(adev->product_name, &buff[2], len);
+	adev->product_name[len] = '\0';
 
 	addrptr += size + 1;
 	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product number, ret:%d", size);
-		return size;
+		return -EINVAL;
 	}
 
+	len = size;
 	/* Product number should only be 16 characters. Any more,
 	 * and something could be wrong. Cap it at 16 to be safe
 	 */
-	if (size > 16) {
+	if (len >= sizeof(adev->product_number)) {
 		DRM_WARN("FRU Product Number is larger than 16 characters. This is likely a mistake");
-		size = 16;
+		len = sizeof(adev->product_number) - 1;
 	}
-	memcpy(adev->product_number, &buff[2], size);
-	adev->product_number[size] = '\0';
+	memcpy(adev->product_number, &buff[2], len);
+	adev->product_number[len] = '\0';
 
 	addrptr += size + 1;
 	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
 
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product version, ret:%d", size);
-		return size;
+		return -EINVAL;
 	}
 
 	addrptr += size + 1;
@@ -182,18 +185,19 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU serial number, ret:%d", size);
-		return size;
+		return -EINVAL;
 	}
 
+	len = size;
 	/* Serial number should only be 16 characters. Any more,
 	 * and something could be wrong. Cap it at 16 to be safe
 	 */
-	if (size > 16) {
+	if (len >= sizeof(adev->serial)) {
 		DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely a mistake");
-		size = 16;
+		len = sizeof(adev->serial) - 1;
 	}
-	memcpy(adev->serial, &buff[2], size);
-	adev->serial[size] = '\0';
+	memcpy(adev->serial, &buff[2], len);
+	adev->serial[len] = '\0';
 
 	return 0;
 }
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Cbdbb787390be4a0ced1408d91f484a39%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637575217617169235%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=1j3EvOZyffkoAPfbiJ5ofSn%2Fk4zzfvyoqBawIgP91LY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
