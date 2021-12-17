Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBDDC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 17:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C045710E966;
	Fri, 17 Dec 2021 17:43:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE3E110E966
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 17:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZnMGA/fZZqYVX38Q0uDOTIXf2w94n2iPC9yWQbcpKK5utxtZlWhXLfgyStLkoc69DLdHBy6bzUeXYtBa87r2Ncf6e3VzYRd2XDWUIbfTw8WE63HNGm7CKDnZuAuf7By4vPjH5yZDMmB31ZJ+BvtIzvsfz+CrVMQWF6pCie9pZeJaNfHGI+6lpDVdjEpIlupEGgJlvhDOiUCsU0pXkUxOYXqj1CSBl5APXSEQulLsHd/uvhb1JjN1nwyHeMNhlMBbU0hYNLcJrNNfkKcLTfJobOfg6czYSzRDltOefk0QU2abKMS3XPzW21onqn/2c0kZ6JB8JU84rES7ejOAKvx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSykO2F6JSbNRzei3BSKi6G91EAbJtNwhun3xye//VU=;
 b=V721IOXDBE3QbQIdszAInLJEOQ5priDoAOatVzcKDCLfNZ6GNgkdU0APxuw5yzxtMnEbEX1big0PMvV3ItpQrVmMTpmQMBmaUkHbDKTvOWn7Dh0o+StzfWqjsFB3Z2qCDV4VTl1LTXPEiSLa1p5Tu17X0yrxKcFooJzkn8Xke4kEQBjxlyY/MPOqne8u3ZQBuJENY08METWbVpzabR1MBtIqhc5Nw62YDiGZbbkKHTivtvtUF0f2BjxBhFdOqck8buF5mqK0BmEanAezjrt6rkwbPlwzIg1IF7dVyZJTZ7njcpx1iXuoOUGfPqfhUG+c0DhnADdLUUsSbvxK7bk+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSykO2F6JSbNRzei3BSKi6G91EAbJtNwhun3xye//VU=;
 b=KD5Sqsu4HOh6OvZzNaIioH924XEBCIt4PFJfLQLAVUaGWPvXe8CyszS6Zu+N/JRWimZlzrA1MVuwdE8zkuEsEOHJjEDcgLb1bpjilPKDHhGVIIkgvPTvWEivYarW4RYBorx4719zaL8Xc/l2ay4nyLxByqmdL5+vAUHdO8rNuCo=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 17:43:53 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65%9]) with mapi id 15.20.4801.014; Fri, 17 Dec 2021
 17:43:53 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
Thread-Topic: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
Thread-Index: AQHX81s+viMSmZNfy0GpPt2Lcg6/maw29IVe
Date: Fri, 17 Dec 2021 17:43:53 +0000
Message-ID: <BL1PR12MB51441AFB92D6513493B6DEB1F7789@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211217153131.321226-1-kent.russell@amd.com>
 <20211217153131.321226-4-kent.russell@amd.com>
In-Reply-To: <20211217153131.321226-4-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-17T17:43:52.921Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 5ef933d1-6417-01f7-d94a-e2bb77c28539
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8539c454-ddc7-4068-2329-08d9c184cb15
x-ms-traffictypediagnostic: BL1PR12MB5361:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5361032621B5407BEC38A448F7789@BL1PR12MB5361.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GrfgTr1TIVsY2+tGtYnK4LLIqID39tinqaAaAuvX7n1XuCu5EcF4DTy1LFiVj5xZl8NV2QLeTh5x4F8L3lpz6zmE+5SktUASVf8+v4GfbXIi74WnHj37XXxb6d30ZZr8qHd832fLNDAvCMO1wTZ6Xpd0reVM+GlxyYkEy5AcCZRUAsst9fWDlKc2PPjwV3VGLsYmboiDrvCSm+0I0aTnAHjm9NX3UN6XoB3A+n6XlX8zD8j+72uC1ULdS2Wy8TKgnNv6h+3lNIjcAqbc8Cu+zgImNN7eRsGHfrpK7lHj4nnY2ydIyRfsw9I1VdMR/6j029oZN3SEM1gDJGlci2wXFHiRMehrUwsuidthIhLo1LrMDk7urZRTlbsbR29xFZ6wi5nDZnBNUtE/AiZKZQ1S61/FrIZs9LbRaZO0tgHuTWHdjiQRPyg8+ZXlZUBoJ581RjIBWSS7JYFvxdfZ1/dHSgRBwNq+qY1OhwSOArF/SB6akdeYl94NW6fGDdSVN90mVqHqaK2RU6DjSo+A/JnIEKqQ7d1TjKwedYmnJpAS+cvesST3ouhssWRqwz5xeG5AEoAgzSo8BidCXUhbT19bgmsmfsEQilStPIMUv6uTb+dpw/HNPQXi5iJIqXA+Ib1bw4j9+H7idwE2Hiw9HxbFAs/gBqW/GDnimMIsqlBQTmPl2peo3grCPd2rALvyZoiNoFPX/TMjMKhQyhN0f9rJQQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(76116006)(316002)(66556008)(38100700002)(52536014)(186003)(2906002)(71200400001)(8676002)(83380400001)(66476007)(66946007)(26005)(508600001)(5660300002)(86362001)(33656002)(7696005)(55016003)(122000001)(110136005)(19627405001)(38070700005)(66446008)(53546011)(9686003)(64756008)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GCs1T7ABGr0MHGOjM4PJuu6raVDAQ6P+BFIIjsITcacvWcVR2ANc3f7L07o4?=
 =?us-ascii?Q?lyhbKu9BCuqY8KDEwQeYLXqX1ZqZOh4B4B1ws8G+GpKwFardjbm0BU+lJBHm?=
 =?us-ascii?Q?w7rrxunpUjefKhSewdEE7fiItRc8STTVP27FMsCWQbhyYjvuzlC/bkPHpDPY?=
 =?us-ascii?Q?3EaKRdsTSg/c5qdOW8fyBnpRADWE7fprTQEJw4EnhaoNiX2vsPdMXRMpPOBA?=
 =?us-ascii?Q?a7fNk6iRGbPJOWpggfgFx5vo5+FOzKZwKf9/aaDp3oKMZsu0nUl6z7IaOuwb?=
 =?us-ascii?Q?LOjhZWDAJYuiR9LJst2Xe8OjYBBP39+PViIpKft32lS8rCaITNUXQneXzHlj?=
 =?us-ascii?Q?rsEv9gnnMQ+QePsU0p+k2OluMC/5l7pHsz1ORnGaulVhE6lNCgZKBpIB1Khf?=
 =?us-ascii?Q?lG84ENYkuuNQe9sTTogJOWh7dGHOWqrT+TtQlEA25M9Hq3ydVsgcTH6XObga?=
 =?us-ascii?Q?cCvzBK1Zw8G/HpFTCzA62+A/Akip34cXkkM9UP/fU3ND+FrxgPfdrKiC44dT?=
 =?us-ascii?Q?Cqgf/yqvsZ46dcYXMvnoPF9st64VGyjrDUme3DWQqHBmsrYKFC630VRNAWCg?=
 =?us-ascii?Q?qNwzOCe3rHZuCeqvj/vts0kc5ZXs0/RisfSrfJCs2dMCU1csXthIQub9ZMEp?=
 =?us-ascii?Q?SHywtQiOjUlEG5hY/KbZVWCK1EWiSXa/n1fcpjfCStpSur8AbBUMh1+zMsqk?=
 =?us-ascii?Q?0/VEqR0o8OC5RztgTzS4RNhe1FwuRaTOowecbmnwENzvPv9SztCl1QSLWwGV?=
 =?us-ascii?Q?7hVXzbbgT/d+OoU9BqaU3nDGX50rVuu5w0ZzctFIIoBcZfpaSY8zuwk6UzTK?=
 =?us-ascii?Q?kmgkOA2JxALqWNZ5iV7wWVK+cQIB2zTwxuWnzy9riPnjMGVyUoutpXhQqohV?=
 =?us-ascii?Q?+eXZfOjOBb6+98zPHwVD7XJECnyyB50Ba5Frf4NJ5m30r8h165yr5bh3V5wB?=
 =?us-ascii?Q?AfVwLN781O6df7kezzzsl3YMwC9a/fI0yLeNonneJ0v6vt+/ShxBBbzqS8r5?=
 =?us-ascii?Q?eQlFWoxJctRQB8AKwHDdw+nzuyNIkRMi/020UCl8vsae6pEPqkWIZFy60M0u?=
 =?us-ascii?Q?IrGPHdxGurV/rCNzFQ4blS1H9nE9RUDWLLxSmqyYoazLatM/NQpVtrUNwBqp?=
 =?us-ascii?Q?/gpq18o5HFdqnQ8ExEiai6t5f3nmQpeuUPdBisU6o/csdlaurzZqgq/7hVCH?=
 =?us-ascii?Q?0zBnLmYpyqfGq+pYROFuyUMnOZ+u3dprIR4+7HFO15YjNQu5T9Rp+icextwr?=
 =?us-ascii?Q?TBgDF/Hsft0NSuxHTrDJQB6fGeZpLU8q2srHTnvm8++TM8IgvyH2JYNCmOVx?=
 =?us-ascii?Q?Rv2FGkMOgKCsncSkbgYbeuFK0M/Wv86kSfuzz0nleTo8hDJy/NXxSLR87JZR?=
 =?us-ascii?Q?tIZLmW4uTQuxgaHPnGCuxHj6CMzjuqzo2Hz/mFNppF+7TuUlzind0wnmHeLa?=
 =?us-ascii?Q?iBt6UYq8SN7EU0E7utgf0BaL920chLFaoM+ZYmwH21mSshVVsmuzs3HxJ2dX?=
 =?us-ascii?Q?IjQbePLQ/4pv5KBtj58ch1rO15EGSz8hZlgekpBnoetF+PZN9HEhsBue/AIp?=
 =?us-ascii?Q?WuTX8lpCEbZba2u+nxZcd8cd1lQBkPA6VkkKk4xz3luUoeJZrw0DeTjd9Yde?=
 =?us-ascii?Q?vBqjmSjTFLhOZzQp0LR6sXM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51441AFB92D6513493B6DEB1F7789BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8539c454-ddc7-4068-2329-08d9c184cb15
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 17:43:53.5390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SGB3Dxk79LtjRt7mrWMYXiM9w2PxcgAClpHwSRsZRoU9/bQK0XTteL4YqwNNpGSJNp687VVCQthvFZGA593+IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51441AFB92D6513493B6DEB1F7789BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Friday, December 17, 2021 10:31 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran

This is supported, although the offset is different from VG20, so fix
that with a variable and enable getting the product name and serial
number from the FRU. Do this for all SKUs since all SKUs have the FRU

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
+       case CHIP_ALDEBARAN:
+               /* All Aldebaran SKUs have the FRU */
+               return true;
         default:
                 return false;
         }
@@ -91,6 +94,10 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *ad=
ev)
         unsigned char buff[PRODUCT_NAME_LEN+2];
         u32 addrptr;
         int size, len;
+       int offset =3D 2;
+
+       if (adev->asic_type =3D=3D CHIP_ALDEBARAN)
+               offset =3D 0;

         if (!is_fru_eeprom_supported(adev))
                 return 0;
@@ -137,7 +144,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)
                 len =3D PRODUCT_NAME_LEN - 1;
         }
         /* Start at 2 due to buff using fields 0 and 1 for the address */
-       memcpy(adev->product_name, &buff[2], len);
+       memcpy(adev->product_name, &buff[offset], len);
         adev->product_name[len] =3D '\0';

         addrptr +=3D size + 1;
@@ -155,7 +162,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)
                 DRM_WARN("FRU Product Number is larger than 16 characters.=
 This is likely a mistake");
                 len =3D sizeof(adev->product_number) - 1;
         }
-       memcpy(adev->product_number, &buff[2], len);
+       memcpy(adev->product_number, &buff[offset], len);
         adev->product_number[len] =3D '\0';

         addrptr +=3D size + 1;
@@ -182,7 +189,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)
                 DRM_WARN("FRU Serial Number is larger than 16 characters. =
This is likely a mistake");
                 len =3D sizeof(adev->serial) - 1;
         }
-       memcpy(adev->serial, &buff[2], len);
+       memcpy(adev->serial, &buff[offset], len);
         adev->serial[len] =3D '\0';

         return 0;
--
2.25.1


--_000_BL1PR12MB51441AFB92D6513493B6DEB1F7789BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kent Russell &lt;kent.russell=
@amd.com&gt;<br>
<b>Sent:</b> Friday, December 17, 2021 10:31 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;<br>
<b>Subject:</b> [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This is supported, although the offset is differen=
t from VG20, so fix<br>
that with a variable and enable getting the product name and serial<br>
number from the FRU. Do this for all SKUs since all SKUs have the FRU<br>
<br>
Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 13 ++++++++++---<br>
&nbsp;1 file changed, 10 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
index 5ed24701f9cf..80f43e69e659 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
@@ -56,6 +56,9 @@ static bool is_fru_eeprom_supported(struct amdgpu_device =
*adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ALDEBARAN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* All Aldebaran SKUs have the FRU */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -91,6 +94,10 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *ad=
ev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned char buff[PRODUCT=
_NAME_LEN+2];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 addrptr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int size, len;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int offset =3D 2;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_AL=
DEBARAN)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; offset =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!is_fru_eeprom_support=
ed(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -137,7 +144,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; len =3D PRODUCT_NAME_LEN - 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Start at 2 due to buff =
using fields 0 and 1 for the address */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(adev-&gt;product_name, &amp;bu=
ff[2], len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(adev-&gt;product_name, &amp;bu=
ff[offset], len);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;product_name[len]=
 =3D '\0';<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addrptr +=3D size + 1;<br>
@@ -155,7 +162,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_WARN(&quot;FRU Product Number is larger than 16 c=
haracters. This is likely a mistake&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; len =3D sizeof(adev-&gt;product_number) - 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(adev-&gt;product_number, &amp;=
buff[2], len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(adev-&gt;product_number, &amp;=
buff[offset], len);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;product_number[le=
n] =3D '\0';<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addrptr +=3D size + 1;<br>
@@ -182,7 +189,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_WARN(&quot;FRU Serial Number is larger than 16 ch=
aracters. This is likely a mistake&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; len =3D sizeof(adev-&gt;serial) - 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(adev-&gt;serial, &amp;buff[2],=
 len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(adev-&gt;serial, &amp;buff[off=
set], len);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;serial[len] =3D '=
\0';<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51441AFB92D6513493B6DEB1F7789BL1PR12MB5144namp_--
