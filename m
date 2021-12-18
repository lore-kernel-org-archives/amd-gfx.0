Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7D2C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Dec 2021 02:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F29BE10E327;
	Sat, 18 Dec 2021 02:48:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73AB310E327
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Dec 2021 02:48:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2tWVTtvLBAY1VJDm4uUTcIRuicYcF+QmbQUyntqSvqbZ/8XO7Fvv4FzAO/yoGLW10RLG0Asnfr3XVRC1hCOC3O5+yBf+TrfczF6PDsWhTM4NsMsD7IUEPPWKvDh2VwIlXsa8Or+DqAHrPebRNcX1qJ+3np+xu2/0YA4O2v2LlxC/hMVezJEI/f0SlKzlTkKjIkzLGR+QoDcEYz08yLDrq2QYc3nmsYGAIHIm+b4ghvMkPjT0ibu2fd2n28AuZF80SPpeiQ4oxTSFA0KQhkqqR8SIFwwSUoR9FRlWepV86rW04dSnxC8JYEtNQRjbzuYknK7pPiUbXclRhgfoXkv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6JPV2VykI/9d/cLKVXxUerLiSik/vp0FyF2jGssuO4=;
 b=DjGzWOEMx5ll/Xz+JUynpxf1L8mLRNnYXJl9MGpznQ0WJ90qwEH8GnBF73t4hZE+IJZDMyQ0zEOMpsbvAdPim9G42e8DDeAhvdvOs/khsja6nltk1d8wuRKHwn8DCN6c0+ev4nGS1zlUaGMc0HtyXIMFxSBxARRXBSO9EBe9kAl4hYWNVL/MFRb/VHGT6aLDhwcvd2Ealz6p0ZhSozHEYd7Kn6ut0GA1bovh92DdjVmGtt6cCsLkTAjS5Az87XathkhGS3GOSKu3xu8y2mAG6p0wnGvsS7AdVva735ljmQIAWqpGyTTMqaETI7VlVvgZ5Lds1FK3MMIMbOYNDZJfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6JPV2VykI/9d/cLKVXxUerLiSik/vp0FyF2jGssuO4=;
 b=xt5otaGOYdg+Ar2orUGWAIXMbvUZ1SMbpc/scIBbW1y6y8H/0BNRxEBLRWGzwbuzFONNlujwYYdczYv9aIi5dYApsPxVWtIltKsTI2nF3GNMOn5XmSz7nEMLpBfB4+veEgRopJKNLIM8Z1ojMlp+3PISh9LTL71hc8Uma0RXe/U=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Sat, 18 Dec 2021 02:48:50 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4801.017; Sat, 18 Dec 2021
 02:48:50 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
Thread-Topic: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
Thread-Index: AQHX81s+lUv+cpWIp0eCVc0h8kobxKw3jDFg
Date: Sat, 18 Dec 2021 02:48:50 +0000
Message-ID: <DM5PR12MB2469E515EFA5CD21D91C4C96F1799@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211217153131.321226-1-kent.russell@amd.com>
 <20211217153131.321226-4-kent.russell@amd.com>
In-Reply-To: <20211217153131.321226-4-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-18T02:47:41Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9364864c-9d0f-4250-8ba3-66697997a24a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-18T02:48:48Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 6eeb76f6-5a68-4400-b0ce-d524038417a2
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dce582c7-dcfd-4bd7-739d-08d9c1d0ec24
x-ms-traffictypediagnostic: DM6PR12MB3468:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3468F1D4FF3F595B0123E44EF1799@DM6PR12MB3468.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ERKg+c9oNSF7EPjyNTV9YcyeGiZWDp4OEiBIIqsU++e75laD7tRuKQqL9vYQLS3dnmINAYqA7Nj2R9Qcch3fDMpMdJyabyJ38TqdDh/c9H/maU2Dzb9fHzuGp8nK00KA2//1wblPbPQiWn922FMA7+RS5WXejLKKp4F64Y2hWcxeNTlP+5FHPs3JocRtL+aPSjEOxnEvb9+QvFjnRqCW8MffBN+0D1hwe1hkfyJCxQI5sum+9i2O5y1qrIcsDiehoLgwPusQ9vdvdnbxTexCz+n2fLiXJzptWGbyAFrjitx/LtOPL40fRASFntvBcYLAImvWezPHfvHxeXeF2c9dwEu+LKr/LsoKSBIrZWw7j+Z1PJIE2WK5zR4bBhkHRt36Qunr1hLqYLH66xlF75vHc+GEcVL0ys290i3UFIhpgskKbhjsWPwsMH+NmZOIpRzuvRFf7yD+Cm6/SPEJ16940Kjhx1HCs4Ly+oVRk1/0NHA2TUaomSp58Tv++Qnk6AjIgCA18gj+stYs8wVApwq/+hXUajOz5LTcHXmBfGNgaqcdUOcPw8y4oP575LalYSSWm1OZbGGWK7GyTNJykz9SpVrxmc0uIUeEU6UDf7Ma5eek2LdorcUtmj1Gv32eoZgQt+7t/2dzSaZo32mkVEqlMCBzts2tD7l7waxHbILXiY2X6HzV6tAAiPQBL8mHLBb/cRDvjFK626zB7uUaVdDVIw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(8676002)(83380400001)(66446008)(2906002)(55016003)(66946007)(66476007)(38100700002)(64756008)(76116006)(122000001)(508600001)(5660300002)(6506007)(53546011)(33656002)(316002)(66556008)(9686003)(52536014)(4326008)(71200400001)(26005)(110136005)(8936002)(38070700005)(86362001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w0/vFtBxUDRnZ13sB/4Hsg4Sybd37ypj2mIUuvmK1QF/igY5dMbNKc4aIpu6?=
 =?us-ascii?Q?hFFpaWjpYopiSQAupFwEbhI4soBb/Qt61DXbRT6F3XkJh+tKkMifL+qeJRo9?=
 =?us-ascii?Q?V2sxfSEf1hny02YAXpkXfO1rL+xMk+QCMtFmAPF8XF3ph/ThJHSB9zhNb3xV?=
 =?us-ascii?Q?mH85Is3TnVQyr3XzbF18/HZ3Ez+1qu6oNUFJ/b6M9WK/iC/49Q1hPwCNo5vD?=
 =?us-ascii?Q?bUO7tnDDRbx0UB17OVPzmfTm/l/pQLwVhM49iyP8ADhZ4U+4+BXpP3zvuqAF?=
 =?us-ascii?Q?n2aVaYN0lU5/PmxWmcsGZW/1MieW03ihXdyet/WGV78ppU70SC+zPSa6y19u?=
 =?us-ascii?Q?ZrFB1JyfwUQh+GO2XphbdzGFASsqxyl9nO/16ZZ9Y8Nk17U0UB6Iwf+J/Ieq?=
 =?us-ascii?Q?HhI8I9OYEax+wQkApLiq5QTKwhzhfh6Z8XSPicjIRKTlIrGC+KsIdG+lvQ3y?=
 =?us-ascii?Q?4vga+mz6X1lOh3p/kccgq65TWY2qTieUOdD+/C2YskZa1MYDCDrJ7vqo/0tr?=
 =?us-ascii?Q?qy1mmsa4H1kGzm2KmAUv+czDDaaNz5QMN5xA7Kq7S35usU9oIDnhCSmy+MCI?=
 =?us-ascii?Q?8dJCOzzdoLM8XtffcmKm7Kd+KyCl5QmzspIEGFcIon7BW85HssW0P07LXhhu?=
 =?us-ascii?Q?Qmogt6ZEI0Snvqs4qHZCMq+TX/lKbkAywduBcf/f3nF2Vhm8Qs8RjETRo1JX?=
 =?us-ascii?Q?uGblzD6o+wOhj+cHZe2SgNEYWO2HR3pE2DPvILRnpASm9KxZzoFFMEeO6arS?=
 =?us-ascii?Q?G82M/4YdBn4FMDj8R7ecDLdVFxpQsf4UiPNGV3/1f7ZWKcsSCtmC9LpDZ/vC?=
 =?us-ascii?Q?1WsXqkm3u4cc0St3wYWJTxCUWtMBicL+1MJa4QjtPinJYD5cqwV8r3be00gI?=
 =?us-ascii?Q?uJIg1IxUPaPcNJVAh8urkml6aBkbMtv/rCgWCvCRdibqI2CVF0L6kJF4eMaP?=
 =?us-ascii?Q?UGockrNKFLWtT7Epsr8LCxOoYJpdtHHlkL0jCb6PReLnHceftxdaGgfh5SAx?=
 =?us-ascii?Q?MRuFePoNtfXf5+t+n02LPFpl45MS7duawLmgx/FAja7MlZW0gh7H8XYUAJIH?=
 =?us-ascii?Q?BDFxPRjGaUpOzsytc8zF1Rc7PYqFNY8yn31aBH+le0Xv1TINCHkju1xR09Jk?=
 =?us-ascii?Q?sPET38t5JrI8wp8ioQXkEiz3XeOwndlgReD+4UXEgDkb3oGcLkHZA/EssKtA?=
 =?us-ascii?Q?4afXSSmngNw5rlBPHkYtBpXi/9/lqpFAWEX77GHqhTy/AiSzbYvRux14kUSi?=
 =?us-ascii?Q?seoXegaFzsrsMI0NUUv2GW5c9X6R7dZp2QLGqR9IBaHaiuIjtV3LjT/TtxPZ?=
 =?us-ascii?Q?upzlvNj1suR/snPFE18WhefILT9nWwenoKeCpfrbVHe95adWEM4iM3yvRP8J?=
 =?us-ascii?Q?EFO5rJqjISmE7BEnCiy3gbBO0x+zrDOodKXgh/C/xCBNt3zoFqmKasA5bWRg?=
 =?us-ascii?Q?InoRBIw/zXot1GivJD/zsNfrI1Mlh+s8E5l4Qe28K7qsS7wRS9veORaom1Xn?=
 =?us-ascii?Q?opkbvVTNRRjWk81eLRwhIlpWGSf+vS3sAY07fhkayj8bwZSf81Rv3PZd5+RU?=
 =?us-ascii?Q?4LBZYPjGW0JQV3N0KmDhj1bKtv1zbSC6tHdYkC33mOLTVyEXMO+MYJ6VWbiZ?=
 =?us-ascii?Q?wrI973RgiA/55piSY3BOEu8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce582c7-dcfd-4bd7-739d-08d9c1d0ec24
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2021 02:48:50.7399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aYITTg4u2ONCUjpspG9TfKaJpuJf1xm7Mt6E82A/NbiRmn40Be+wMOab9NoBx73MJGFr82R80/fiqV0vuyGfyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi Kent,

+
+	if (adev->asic_type =3D=3D CHIP_ALDEBARAN)
+		offset =3D 0;
=20
 	if (!is_fru_eeprom_supported(adev))

I prefer to put 'adev->asic_type =3D=3D CHIP_ALDEBARAN' after calling is_fr=
u_eeprom_supported to make code logic cleaner. Without FRU support, we shou=
ld do nothing.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent Rus=
sell
Sent: Friday, December 17, 2021 11:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran

This is supported, although the offset is different from VG20, so fix that =
with a variable and enable getting the product name and serial number from =
the FRU. Do this for all SKUs since all SKUs have the FRU

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c
index 5ed24701f9cf..80f43e69e659 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -56,6 +56,9 @@ static bool is_fru_eeprom_supported(struct amdgpu_device =
*adev)
 			return true;
 		else
 			return false;
+	case CHIP_ALDEBARAN:
+		/* All Aldebaran SKUs have the FRU */
+		return true;
 	default:
 		return false;
 	}
@@ -91,6 +94,10 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *ad=
ev)
 	unsigned char buff[PRODUCT_NAME_LEN+2];
 	u32 addrptr;
 	int size, len;
+	int offset =3D 2;
+
+	if (adev->asic_type =3D=3D CHIP_ALDEBARAN)
+		offset =3D 0;
=20
 	if (!is_fru_eeprom_supported(adev))
 		return 0;
@@ -137,7 +144,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)
 		len =3D PRODUCT_NAME_LEN - 1;
 	}
 	/* Start at 2 due to buff using fields 0 and 1 for the address */
-	memcpy(adev->product_name, &buff[2], len);
+	memcpy(adev->product_name, &buff[offset], len);
 	adev->product_name[len] =3D '\0';
=20
 	addrptr +=3D size + 1;
@@ -155,7 +162,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)
 		DRM_WARN("FRU Product Number is larger than 16 characters. This is likel=
y a mistake");
 		len =3D sizeof(adev->product_number) - 1;
 	}
-	memcpy(adev->product_number, &buff[2], len);
+	memcpy(adev->product_number, &buff[offset], len);
 	adev->product_number[len] =3D '\0';
=20
 	addrptr +=3D size + 1;
@@ -182,7 +189,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)
 		DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely=
 a mistake");
 		len =3D sizeof(adev->serial) - 1;
 	}
-	memcpy(adev->serial, &buff[2], len);
+	memcpy(adev->serial, &buff[offset], len);
 	adev->serial[len] =3D '\0';
=20
 	return 0;
--
2.25.1
