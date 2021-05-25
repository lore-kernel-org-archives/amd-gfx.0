Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B58C2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 07:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72357610CE
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 07:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72357610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 185286E9B1;
	Tue, 25 May 2021 07:47:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC646E9B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 07:46:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ak1Y85akuyCV7zxkcM4RJWOWpDmJ3t8gUp0TfMSRLuMyb09NCRaJgSkgU7aszVbp7hIkiKngeFWIs4MVCNzMsRLooQTHlfXxFHMFcEHp3XBzPqBhGk8Kc8wuXhAOE6IFoNW3Ao6IDrZmopXM1krc0zPCEjMpqjtDNSqwuZ3e4tdnJJ8tCVW5qzkUERYDxy7CUh5LJ5J/eEua/649dNlvby6p4WEj9KkKcl03JsQLwlt+vspA7AkfOq9Nm9GhjXqtyvSsE1Rph0cRywGOPYoeFtoS6+VjgCmY/e4UTinXBvIQnr90lQlSotGcoHmO1Y5jyICxwPDh7Rsz2dFxHXH6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xs+X6K26lZCYWcQToXiS/9fk4RBCaYTj+3+jBYhIhc=;
 b=XISPMtBf7TG3PJbX9Dk0nO+biQwK/vpAFdYRzibgDxgFsCqjaBCsb0f6fUs9qkBCTAQjy0tI2Y+PMbD1em6CAMc63s3Z51t8QHpxGDH8V2DUo8F+mio0bPHQoPQ1vbrHMfIMivZsL3eTOrww2zc2MPlr2mJROiZeWOz+bbbgxa/SgFhaPsTcwx7xjhnFyGSggM38gKjLATrB1VoNVTWf1DG4mM3Hj7xyVw7WNZMdSUXnCtoHGmccnypvO9Kjy11BIFqPGzwc6/k5Tlqsmqa22W9lWiq8vXviQARZtuRfCYP6wAH7aokaE6i84CZEOONCw15j8xBdst5lS9LbnjrV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xs+X6K26lZCYWcQToXiS/9fk4RBCaYTj+3+jBYhIhc=;
 b=RApICE+7nY/UtzzC7tbJQOMXyno5AO5iCbZQIJVk5SrRtRuVVtc5xzC3XodTMFs5yzXD2qSK7NEyWHexmhz86SpJA52a+RDtmAlJQGvQ9Pt1X0+GZi4UB/hA627cTnFrC/+Rj7b0gl22TNXNF3VktosFGzP8NQpDG246e/geGIU=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1413.namprd12.prod.outlook.com (2603:10b6:903:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 07:46:56 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835%4]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 07:46:56 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: refine amdgpu_fru_get_product_info
Thread-Topic: [PATCH] drm/amdgpu: refine amdgpu_fru_get_product_info
Thread-Index: AQHXUTEpb7ugpWP92E2xe42V9EJh+arz0T3A
Date: Tue, 25 May 2021 07:46:55 +0000
Message-ID: <CY4PR12MB1287299074EFC87B16273934F1259@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210525064222.32495-1-Jiansong.Chen@amd.com>
In-Reply-To: <20210525064222.32495-1-Jiansong.Chen@amd.com>
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
x-ms-office365-filtering-correlation-id: 247b3204-98a1-4ce1-5c26-08d91f51450b
x-ms-traffictypediagnostic: CY4PR12MB1413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1413302E9FCC9E297D6B9778F1259@CY4PR12MB1413.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qq7CoiA312LdRQ1Q/FonaqhztSmIxk9yyVyNbDo5sTMCsCaXbuJCWPBlwDi22YAHk6V0b5I85+oDYS0ab0JDBHK7Q9QOcceKOr97jAv4qw309MkTcZrMOd7dhKubZtDjZy0zAyqgLtRJUz7cCVnmXaYJYdrD2Sx1y0YXsaBw6Ld16eYNozu6adJQnXN+IVNXADZYA6i3JQoFwwoJip6lHe/UYrRJHbp5qn4A90qbjECEPXQsaJmP15zwD2nwDrmcPku8pRuKf39yw6hW2bcdrQUbCDzmgxiSeOOEurIGRtC1L5xsKSVZ16hJ3UGRDsDwqpepN0gH3Qtx3UpFo7Qs8qpxP9Nc2wb+SAE3u6v8j6UykDxMzXdooGCxgIaqE9OaXC4TPTuAMr/bAV1QAKmMiR30KCgJyEIamy7U2tLCbC+3zfT0JbbHC90NM9ZJJ34w1NPK+rRMa5xBcqdGmNmgd+youXeF6mLDEYXFjVL2TXypyqxB0lQ0vhiBwckMKpdvHsDub1XXcsQqcbxywxP8XtFZTviUGcSJHgGbzjrNsHecJ/OfQSJveZNrmMkago0e0VdNf6yK57ptWY+jBPnHW3rXZR/hSBvPi6TNPUIYG3MOwO+Vx9wnIl8bXBTi4Oa5jyDbQVXXyjKHx889pGueFA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(76116006)(66446008)(66556008)(66946007)(52536014)(66476007)(64756008)(55016002)(26005)(33656002)(45080400002)(9686003)(8936002)(71200400001)(110136005)(5660300002)(316002)(6506007)(7696005)(53546011)(966005)(122000001)(83380400001)(38100700002)(86362001)(4326008)(478600001)(8676002)(186003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6SNXXfmQnQIGflZ2ydlSAEU8eZA25QjCMh0uFuonc8sNY+DPFnw6obrjIYzw?=
 =?us-ascii?Q?Z2S9wUcOeD7LeXuQsGJ8KwwLcpfgV8uVTYc2cvRbXz1p+JIP2LvOvEhBVudO?=
 =?us-ascii?Q?gTQrRk8AQqxLCf9Bw/CqagWFwkR9Hz573+oXafUuJBBl5WxAxAhvFu5JPeNC?=
 =?us-ascii?Q?OzPakKJI99GUn/qLU9QpV/PplZksbnlnt9heybehQg1Ts2kaW2S1tCZ77VWZ?=
 =?us-ascii?Q?brlB3hYpJiER9sJatKC7HgTU7gKW3PNIyCcNvZbv1oR/6Uuim/nHbaDMCuIO?=
 =?us-ascii?Q?5Gz8X6WhA7I7Fbeh2rYymecg7Kv18zHTX9N9/uAnalu3ebwaaxxd71Fzn0Sn?=
 =?us-ascii?Q?cZiWt81Rpm0T7jJeUmk/5ph5ngF1pfA0b4SAX4ki+5ezesI9XxOCEc1NiwQK?=
 =?us-ascii?Q?l3lZG5WX+C+xRm5X4R6dxP20uJLjLBoinrm5FwAHToP/e/sex0AOn9juTqJl?=
 =?us-ascii?Q?BHLVs6oiQJAgfDw/X+adhtKK+2tbwlHu6qP8jdMlblunzNLmdJfpSQVPZZTu?=
 =?us-ascii?Q?M+qvo7tAKQ6uLk/FswijSteDaqMpN+gj2wLPLcBBboQxF3nita2HXE1nduSy?=
 =?us-ascii?Q?1ryUZ6DDtukzTEiBVBue3+TtBc+1xBglpnCL3tvG7rtgkwY+iWFA+zSYc3Kh?=
 =?us-ascii?Q?SmXpM3nS3yLxrgv2ABcU7DZjB8CRmLcUMRZD7n2z3BKVZKdNa8sasM5e4n4P?=
 =?us-ascii?Q?48iX3BG1zQK6jdsl64ScXMqLLgAtTVgpIqgEbkSy89p8ru49pdVCuUjkcdp5?=
 =?us-ascii?Q?mhH374nxKrugTqx8lxnkB+SR+kVSPWhewiLbINHKomsCoXveShHEdT/0Zn3X?=
 =?us-ascii?Q?imT5zWGkePMmaFGQ+YkYIuRMCNKiWDmsezm7bs50nGhmtWlA8wkV5W1d9w9R?=
 =?us-ascii?Q?NG9nUkdWENH66S3KnZruyHRB2qalV0CwgSwgvPYyRC/JNBc0yA5F7rxKv0Br?=
 =?us-ascii?Q?pM4ppuvbJQvBSBwnF8+hXRlSNmRmAroZeKvzt4H3pRkO4m3b9dPpRkAHbHlz?=
 =?us-ascii?Q?D3G5L7QZkhzd8CNfTLUykzcuqjxs+Yc1bWkEKfysH1LiPAyH0apz+h4uR3Is?=
 =?us-ascii?Q?w3HQl3XNpXXHszvB1qfnJc5n5reCButm7ZRNDPAdORxvur38k/z/xS4kvHo6?=
 =?us-ascii?Q?N3nxo6QtXIvnOJUsLUIib9bcTHzonenyecqD2/w6eUf3OExrkbp68JdIqzl1?=
 =?us-ascii?Q?J/iLQMtJRAdsgUHScswhQes2PC2tfFTtFMnQl7500Gci4wmZeDhzRcV/dux5?=
 =?us-ascii?Q?ZvkpFdGyhPuUrElHTjUWgP5VtMGDYVGZyjKt1ILC548OzZFjQrc7HQXo4G3w?=
 =?us-ascii?Q?PTh/0vXzUNIDV2FzTFztNziU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247b3204-98a1-4ce1-5c26-08d91f51450b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 07:46:55.9101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7L/H9gSscX10G0uQwfdMusWyOiCMUaiTkfOo1vbdJ11DmAprvKGMi1v7rXQr5rSLNxOf9WMBRvkS8Dq53Zu7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1413
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
Cc: "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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
