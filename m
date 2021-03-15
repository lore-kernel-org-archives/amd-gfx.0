Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A004DC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 09:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF2564E33
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 09:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF2564E33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B66FB89D77;
	Mon, 15 Mar 2021 09:25:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D70C289D77
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 09:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=me7z3T2KYTDDe0sYEqB2BlPlBza6Q2qY3cMHE2V4c+RnYokwzQLkI1iSBzVKX1krTmBTrjnzSY5KYdvIJUvqS4ExuapZwRq0HJURpGu5mja390qMcdkgvTZCJjJyDo+EqCl6RDYwPL1O2dIL5Ed3WRl8Aebyu3+x1HrZchxrUu1QQs67vUppuSL1BvRcqgP2pNm1rHJcMzu3yIFIJwA8e/d2j10+cqdNQb/CtBD2toK9l175fY9p7dZhusVji/fPlwRP4HpUetqlemMyoePggMiUWyn/ldrsd9sD2MmGLboWpFgy85Dh6fGn6q25QLwzNFPbuHwWriLGo0doPohSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yg2jN3q4nEwaC1mKj7AWu7O7xfkRhvqgED6SMsJ4CgY=;
 b=dnSEBm37a0fPSU06m+Fn1FZzBAwXI+GiYrLbZEhSN/4A0dfE38dBENjey0FypA6mB0s1CWeaJfS39L1KySpUKJksdouUN+9KOlfLoNdlS2ULXNV7LSXFS4Y/uuyQEQk7e0GJA6WlDpjsbdA2ghwou9urXdPYqFFLtyGlc4aklcg5xsdm4TVzyPNFwHTq2in7aMChKD91gaGMtFveDSlfn3XzUL+PtKmbJZySZfn1TlcxuolAC4bm04+xTVWnfNXj2HqnQlGapLVyoPp+F5GlCSlH1+YDlz7/c2OEng02VGEeH8UmFdf6GjTY3n6Q+s+MqyfQTLuiTvDhF9aSjE/Tuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yg2jN3q4nEwaC1mKj7AWu7O7xfkRhvqgED6SMsJ4CgY=;
 b=pu9Pzze7IwupWQUwLjyJGL0WLKY7eEh9q2eYKv7q9HZjVdBsQ5wfQ/8FqjJy8L9N+pb6QU0zdlOaXlDzmE+MQ/Pjepzy5WURwpkhvh/BQ1IZQtAdbIWmZEM/wFQpquDQ7DewI3BFOxHQb0JR1WV5sex91puz6zQ/CoIIwjS7XJU=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31; Mon, 15 Mar 2021 09:25:42 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 09:25:42 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Use dev_info if VFCT table not valid
Thread-Topic: [PATCH v2] drm/amdgpu: Use dev_info if VFCT table not valid
Thread-Index: AQHXGXsnZ8SZy0jNKE+2B0xD+C+RsqqEx0Jg
Date: Mon, 15 Mar 2021 09:25:42 +0000
Message-ID: <DM6PR12MB4075A00E1452CE6B404CA858FC6C9@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210315091109.18574-1-Feifei.Xu@amd.com>
In-Reply-To: <20210315091109.18574-1-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-15T09:25:40Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=464bddfa-b8c0-4ba3-b9b5-fbbc2da339b0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73f5b198-9fcf-462e-195b-08d8e7944e17
x-ms-traffictypediagnostic: DM6PR12MB4353:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB435358C594C7E7ED985BAA58FC6C9@DM6PR12MB4353.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l6mebecDCAgJ/gqHef8pxPv9I0gUChpkiXHhR4L4uRP0wnhmEmK8xLWr2YLPwIOVNqK/hlA4m8YHkGy7tTK9qeEqhywUBZklsBe9ws1OTnfrW903gTlMLe54wSdsDM7no0f0+6kyJwYDSi0wLS42ffftwWgvm+UMVcx+Ue5IlZjpCtMlO+ojKh/Lda18mCWfdNmMEzuxAs70JbOl+mDOi7Yhc6w4UNUI1OgTDDK1sztT0NRQEBXIMfs9pM3TLYlDRIMj/spJenGaQYuSPVb5Kxq8qko59k++iS4ilIpiFWvdbsyNgWJJcxxsZm7pJX6HuERiSOBvqywhnQCGrzemLPXXofmui9Bj+Yhz9Yqq2mTX9AH9YKPmo14aOwD50IfHlAxEa5ncJFkFMTQ4LTGaR7FtnJ1Eng1G87w4pjBaZc5T2EIYd0gwuWUZgzUtJiT6yeX6/FG2tzE5IHVwn/o6WcJFzapdZKb1ry83IpocMgC1MyBNjVRQNtg+p8Y8Bmk7i7vtHAF2TJNSj2NGZwBGh0PUvPo2u5OPwfkaydMkHnw6O5FlFebmEh1WLNqYgk+U
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(186003)(316002)(66476007)(83380400001)(54906003)(110136005)(26005)(86362001)(52536014)(5660300002)(8936002)(76116006)(66946007)(71200400001)(2906002)(55016002)(4326008)(478600001)(33656002)(66446008)(64756008)(8676002)(6506007)(9686003)(53546011)(7696005)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TzUGGGu8xBerY7VaCFYHUF9CzY71h3h9mIVL4LZTPhMTvopv6hM2d4Glbj4s?=
 =?us-ascii?Q?mHg6ZnrwAGr7iB/AKwPDZ7hfFniKCOdnlZH3TdDrKkTndpp65mzhNH9wXUfa?=
 =?us-ascii?Q?kSelXiR+smkHEdGDH6AxovOxy7FHwhQe2iPd71lt+3APwsKvCSWLB8LPo5dN?=
 =?us-ascii?Q?hzdbS2rpW88i2Uem+DJ5A9NP8owMC4j9CaS1mS3u0TrUUauesYgc04uXRAjO?=
 =?us-ascii?Q?/QrU3jCMD7Aqwgs9cs7dxv0mkTbT0OgtTf1zm4qgXwTZYu0zxdlyG/EwQLYJ?=
 =?us-ascii?Q?FK2WAAzfEzkg89C/lJVBPmoNaXt7EtX3hpTdDtzbrQkPg3FiYQ8M54QJqxfR?=
 =?us-ascii?Q?nLuG76AnXcO1Wpap9nRMb+sk5YhJezltxHDHZ4I0VQlSybqyvshbDUgTGgTj?=
 =?us-ascii?Q?hMD481bWBWQArRG1uhKmMo986FKDPDvBX9h7NawtbMDh3EJOyTILJ+UeuWfw?=
 =?us-ascii?Q?MuqYOfHB1jy/KoZ+7kJgPkjwKKcHcRxRPZfEL8yLuDtDF39nIGloZX7T7CU4?=
 =?us-ascii?Q?ho+Ww6WXpM7Y07Asw2C0J3MEiOhVupu7n/pEaLVU+BrUPqTzM0Y3S81qydy9?=
 =?us-ascii?Q?kZLftaM1EuvBI8sF13cjQcKjRTRcPqGlqPZFBTLLKNj7UnLVQcrhAoO0qz3E?=
 =?us-ascii?Q?oFVWJMh42DQwGsbSFTqq7W2pSfSDLyRypiUtZH9nPnqIHL1QvuBSLsKkCzTN?=
 =?us-ascii?Q?3sQt3yqy/vvzQr9bNg9m/0ARwc979+58P+6zb52WHd+PcqDyDU+RMC2YyIV6?=
 =?us-ascii?Q?VosMa6aS4jeVm9I5MErq6/TCoZ5fP3QtqS01kp8b2jEPHXpWDI+eDEgASM0/?=
 =?us-ascii?Q?SACF3LbqTPQlb/Yyr7LDaTBa1COdQUhyw5BvzwvxWWS+S7QTNW8u8yX4Rvby?=
 =?us-ascii?Q?ZBXUEBXhjcu7qiZeOx/0U23UxovEs5EJEXMnNlMy76JORm+DonblkpRnsi6b?=
 =?us-ascii?Q?YVTuwwtdW1q03XMdpa8zfQO3DycwD6r3X31uiGVDKoJSoYMPUhwiz8cgUIWx?=
 =?us-ascii?Q?AdsHEB1d+4XFwhhs+iF5c6cyT6KatH4Q4XXfkpYBnGbwcaj/vX+7Nn5Dw6DV?=
 =?us-ascii?Q?I91bHNMJyP5HKfTCPqVNza5qBaT5c7PvcKl3PwX88jvTVSCRaOajBcHtAXLs?=
 =?us-ascii?Q?yMcqgwDhsKdFnkpNEmKb9TtH5JYrricaEsJIBRy/0HhWCduf8kTJ433Z7xBA?=
 =?us-ascii?Q?1ruk+UbSmhuFmfL4HgqOMl/X8zlZMyQyyveYKMsKMd/POMdcLNyEIyrN+mxj?=
 =?us-ascii?Q?zCQOw/HFv2xdEWuQNwSuUlmhe39VAnM+stbkPXQabJ6qJ9iOdXAu5kLKwGBZ?=
 =?us-ascii?Q?rUlPJ9MWq7UFxLnEiiEPVBN1?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f5b198-9fcf-462e-195b-08d8e7944e17
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 09:25:42.2983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4geo/E9yiuh3WayHhPticB1Kar3N4NF8cj3HW9jJ1bhH7dCy2PKS4ZSzq+JHyZhfSWfWBbVQvv1pkrYcBOrI/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com> 
Sent: Monday, March 15, 2021 17:11
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH v2] drm/amdgpu: Use dev_info if VFCT table not valid

Some ASICs do not have GOP driver to copy vbios image into VFCT table. And it will go to next check.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index f454a6bd0ed6..a5e98d0142d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -320,7 +320,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 
 	adev->bios = kmalloc(size, GFP_KERNEL);
 	if (!adev->bios) {
-		DRM_ERROR("Unable to allocate bios\n");
+		dev_err(adev->dev, "Unable to allocate bios\n");
 		return false;
 	}
 
@@ -368,7 +368,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 		return false;
 	tbl_size = hdr->length;
 	if (tbl_size < sizeof(UEFI_ACPI_VFCT)) {
-		DRM_ERROR("ACPI VFCT table present but broken (too short #1)\n");
+		dev_info(adev->dev, "ACPI VFCT table present but broken (too short 
+#1),skipping\n");
 		return false;
 	}
 
@@ -381,13 +381,13 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 
 		offset += sizeof(VFCT_IMAGE_HEADER);
 		if (offset > tbl_size) {
-			DRM_ERROR("ACPI VFCT image header truncated\n");
+			dev_info(adev->dev, "ACPI VFCT image header truncated,skipping\n");
 			return false;
 		}
 
 		offset += vhdr->ImageLength;
 		if (offset > tbl_size) {
-			DRM_ERROR("ACPI VFCT image truncated\n");
+			dev_info(adev->dev, "ACPI VFCT image truncated,skipping\n");
 			return false;
 		}
 
@@ -410,7 +410,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 		}
 	}
 
-	DRM_ERROR("ACPI VFCT table present but broken (too short #2)\n");
+	dev_info(adev->dev, "ACPI VFCT table present but broken (too short 
+#2),skipping\n");
 	return false;
 }
 #else
@@ -457,7 +457,7 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
 		goto success;
 	}
 
-	DRM_ERROR("Unable to locate a BIOS ROM\n");
+	dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
 	return false;
 
 success:
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
