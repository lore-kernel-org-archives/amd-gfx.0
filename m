Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74C9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 15:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6998E10E562;
	Tue, 14 Dec 2021 15:23:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D0310E55C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 15:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeSUOI9inMGNaK3/lrcbiJMM94GgRJPUPRx4I/JH531eqDX2IUoX5Qesut9tG3vTS1sEJs+ucm0rX1Ix2icwrjBPjSy5bjfXJ4UoCjGbuul/kr/e9AFYjmFBYvUo+JTQ4HjbieBlxrceYFsL/woXaDHDO3Pv53XHmpbE8swdF3SSdIadKxAOkHgbHXiOjsQebGRo9ck9QRnFYtGrafrOupVgT0egZDu64AbTZbMgcm/GtwfEPxyqOIRfOTzFsDpqKcmOK6hloigdfolupdtUpmPE49auXIWm7fdhjehTcWgzXz63Nl9ObnOeFrhAegBpebAyZQBBy6FOdHgFCrSHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c1OjgbtHVxXojPLqVI85j7ahMzS7ocu9MBYPvyzO7k=;
 b=C/U0i5QoHxnWgUKBneHdLEJMCMOQU4KbWcoKbPhVd+zIx80N41oYO/b2QVpXKOLMajZlNmjQsIK8y8idOvcXTSy5fyCZdB2v0OBluypmi+ffRAdSwoN6hw1kkQFem6uBbwbO/iWpVOVQDU2unhyMA7BYDvV7v40CtDgdg4V++qHuovhtiiw4WM2KP5apOnt4NJIhaCaQuBGAflYcmhhM2ORxjgwXbwYbeNxCIQ+/A3y5tSjuFKC27ECHrGQx+M+Fbh4f2JK9oS5bl+tCRy4KD3Ymp/HW80ghldhxiW8bOMKaJ7mgh2biDnZm1PAQ206eZ+byc4FqYMDccL12MVSTIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c1OjgbtHVxXojPLqVI85j7ahMzS7ocu9MBYPvyzO7k=;
 b=AFPDga2VE1thpIpR5FMPeBZqekQR2M6dC4Ef3A07kVh6dw6v3DoWcrcyqjs3hAQ0kSdnk91f++G2l69lPaYDQ7tT4TAMF5Z8scFjVofhqn2EJulpxitR29wgMsM5KgEd2pcicEcMaL66HUDkmJi1WSnTcMUWz1eXIQQxuqvjGcU=
Received: from DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21)
 by DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 15:23:26 +0000
Received: from DM6PR12MB2858.namprd12.prod.outlook.com
 ([fe80::74bb:cb46:f4ef:73e4]) by DM6PR12MB2858.namprd12.prod.outlook.com
 ([fe80::74bb:cb46:f4ef:73e4%3]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 15:23:26 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
Thread-Topic: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
Thread-Index: AQHX8Fh/92X1o8JYXkO3enQxghXMzawxUWMAgAAGGICAAMS84A==
Date: Tue, 14 Dec 2021 15:23:25 +0000
Message-ID: <DM6PR12MB2858493C6E0FD95B57E20B8185759@DM6PR12MB2858.namprd12.prod.outlook.com>
References: <20211213193402.96278-1-kent.russell@amd.com>
 <20211213193402.96278-4-kent.russell@amd.com>
 <DM5PR12MB24693785E4E9F4543D5D60EBF1759@DM5PR12MB2469.namprd12.prod.outlook.com>
 <DM5PR12MB2469E1497AC1CDE2E586F8A2F1759@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469E1497AC1CDE2E586F8A2F1759@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-14T03:16:28Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7f4e7385-27b9-4909-bf3c-1d032d7d88a5;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eae23dc8-183a-49fc-56c8-08d9bf15acb7
x-ms-traffictypediagnostic: DM5PR1201MB2491:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB2491F6D08337DED103541F3485759@DM5PR1201MB2491.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RuzlW6WdOn9HBhbvnMdClKc4iF2udqXSpQfJMQBmajQ1eVdB69338WEcqxZ3ip3wKZ2IMHxiDgB7z3gvGCjayawZDoWlNuTjsFuC6zu+4awgCkl76leIalhnmlG+bwa116IG+M17FS70KBUwFqwZuCXejRm7hv5kjP8QxSsmChwv3do32KNliH3/CwsJjNisQruM7Rz40Vq1ylGlSoT7hEKN8efa1DDbKw+t3eK8v+8AElSBQJtok0rQp0fxEdK0/aRL8TTr0genS0DQaEmqBp7kB72AHni6Dq1jindZ0ITJ7vogrcXan8WZUpuq6gMGWIivVYzJk1NRuJJU+92uxvJJwbxynvVEIm6+3KWH0BHYmhiwizaeaI7lj81SOidCrOHdJIKoOSv9qBuC4V23/k8FIavA+RytiJDucmygwbty/KT/SxEEGt/zbBpwVPJ9R2MM0yPUtq2YgM/c/l8OAhO25liV9MNfTJoIk4iAX/Cka28symLoFXkn+CosdKoFWDyQc2VXNV19k2sLu7p/BnJZ7aSEW+jeczlKd8hp5s+0X+BI2W90V4soXi2YI01ngis2+5OKaSA2l0/qL+LpDia7G5KR6zTRIKDefkpDNAn+Rn5dWTExvh9i2ZdWkwphRwVnbxBgD+zI99tw8IDVvFtXtJSLSbFd4f2I+gz3JdHo2tqk/g0pZtpFS9HGvvi3QpGN8Qeu9dRo9LA1xAgYsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2858.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(66446008)(66946007)(53546011)(66556008)(55016003)(64756008)(33656002)(7696005)(122000001)(8936002)(9686003)(71200400001)(38100700002)(5660300002)(66476007)(83380400001)(6506007)(508600001)(26005)(38070700005)(52536014)(8676002)(86362001)(316002)(2906002)(186003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hLmpv/AbEqCnTDFnVkOUxqBk/V7JqAOMFm5ZuXsCQxOrZ3DxAfd6hsFuBu5E?=
 =?us-ascii?Q?zOQwcjjG7/z4SbbnZ0/BVEh1VZKgijiz3rn//XCcIUffmjnZnrpe35CWRt5S?=
 =?us-ascii?Q?9dwOHgMuTVeS38pHESxnPT6es90ZnDwFhSJF1rkKdEbWmzt8heZ/AqnFP99y?=
 =?us-ascii?Q?rvDO3f6RcEDT4HVfPF4v60cvVoMgOuINQ9pKunt8MEsUyB3B0G62UErFwjUE?=
 =?us-ascii?Q?tiWBbqrMj+IntevwupX1gveCUS02vjqJbYVrFc/TJjUl5tNeOp4Lu3+0DkRT?=
 =?us-ascii?Q?dTfYd8VjfLM99y97oUM6j5Mw3OzV5jcSskg5Y5TO7rl3ZH90IBDxQfAKjsHy?=
 =?us-ascii?Q?xHAZkX/fN3Sh+rR68jjvGXzj765vdbSN6uZTE8meclivTp8Qbz1NWbHOfrP5?=
 =?us-ascii?Q?j2gepEdMUbj5b9qagsArEhu3gHsbReYEwJyC4+nEc2qtEjArEAadYKXlg1Wa?=
 =?us-ascii?Q?r7de/qn0zz9G2n0hw8HllwsrPbApFQXh5JtB6C26EWjJv6uwaIps1tM1wUPM?=
 =?us-ascii?Q?5mMzbtZMTAjOQfeljekNWa9oBKETLSRctvuHdDfGWbnWFWesFd6Abl37V81I?=
 =?us-ascii?Q?FiipPsZHEgB0PnD0vmvPB6lV5J+PZVzVwLqRB7TGmSi2q9tbOTPeGpk+VRPR?=
 =?us-ascii?Q?HBwDnxhQYyKlR/Zk30u4RgE5ArvLdtRZL7629O+ZNHqvvjzTH4kh7J4NfLeP?=
 =?us-ascii?Q?0H3LH+BIVMcoahbyKw0ah6ihMznaYFw9Je/oz/CqxErZ0IAZizg4foWKep08?=
 =?us-ascii?Q?+fqaYwlDcLgNYed1PeDfuC//5PTldkKrWRmYYY2878/TbO5iuifeAe91E+3Q?=
 =?us-ascii?Q?oPvdxS34BfxRBifQLq5WZbzci1yMcKW/b87ZzYSSV/XC3FmNDJRGuxTcObRk?=
 =?us-ascii?Q?vwwCwQz4YvQyegO7Py0YQm1MfGoUYIRMlE05l/+StkaoLnQSB6Np9MCq4Gu3?=
 =?us-ascii?Q?nrolJVnXDXO7hxYjCK/V9P75Uun0jti7X9AKIu56z2A6ztnSsZeSJnRqnq3K?=
 =?us-ascii?Q?QWhGtnzmCToRf3ABK3mHV/2FaHB5urwR837kNTo/8qviQgf7aFArz45xOOt6?=
 =?us-ascii?Q?NacI3wIT/8SNXtqKpGspY9N/xfN5bjWhzZ2qbhq7IYyhc9TFohEFefeQNgJg?=
 =?us-ascii?Q?Ij9IZxkdr0tVT7tyhoKsBGfMykb+uGENhYO2XWzN44Rcqh0t0dev7A0jh2be?=
 =?us-ascii?Q?QqvP90gFIUHlQT7Vy3GOMm3fCDsjfTUvnvAGqaNYI7tx0+krDJy3lonT6mgA?=
 =?us-ascii?Q?SYcqWmvDU0dDaq4L4JgoEkCjCKpk+JPmYwyzxuP0kCRHVKbmi5QZSigu5ShW?=
 =?us-ascii?Q?gVUCGvEuINcX54m7YqOyuDpvz5pi+g0bfJ6aFg7cAX2Js/ZwQz44Nw/irGb1?=
 =?us-ascii?Q?f2NZ7yyMNrmgGkQjD1mxIraA6i5dDdF8uAKS44900yTPJ1FBAlywZUiiK/T2?=
 =?us-ascii?Q?q0HYKyUrqblhonSykWcLilhBn1DARD/rdPClP3La4PuEpW3gqz4V4ZZsOu15?=
 =?us-ascii?Q?CX4E1aPpmCqKUIGNgZx6jH1ibpk+48k307U3BDlkxSu/n+9lO0KuRhntboTD?=
 =?us-ascii?Q?9MtVDTFc5bd47ahJIbzsVZ4JK/dVkpqXfc+yuaFg9DlgvH2dAXwcS9sJktZD?=
 =?us-ascii?Q?bHO9f8rgPnso6hIEgo5c/kM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae23dc8-183a-49fc-56c8-08d9bf15acb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 15:23:26.1111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPHVlezkBN3ChCHMHIITt6jXibkq3aLIl8sSLDLYGx3aDlxHfFRynkadWOwFLA2lNDQgm9azhbaM6xbXNq/40g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2491
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

I'm not aware of any Aldebaran SKUs that don't have the FRU, but I can look=
 into it before submitting this patch.

 Kent

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Monday, December 13, 2021 10:39 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>; Russell, Kent <Kent.Russell@amd.c=
om>;
> amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: RE: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
>=20
> [Public]
>=20
> BTW, does FRU exists on all the Aldebaran SKUs?
>=20
> This patch acks FRU's presence when it's Aldebaran. So if some Aldebaran =
SKUs do not have
> a FRU, some i2c access failures will be observed during boot up. This is =
not friendly to user.
>=20
> Please check Vega20 case we talked before, and there are some more strict=
 checks for FRU
> on several Vega20 SKUs.
>=20
> case CHIP_VEGA20:
> 		/* D161 and D163 are the VG20 server SKUs */
> 		if (strnstr(atom_ctx->vbios_version, "D161",
> 			    sizeof(atom_ctx->vbios_version)) ||
> 		    strnstr(atom_ctx->vbios_version, "D163",
> 			    sizeof(atom_ctx->vbios_version)))
> 			return true;
> 		else
> 			return false;
>=20
> Regards,
> Guchun
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, =
Guchun
> Sent: Tuesday, December 14, 2021 11:17 AM
> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: RE: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
>=20
> [Public]
>=20
> +	if (adev->asic_type =3D=3D CHIP_ALDEBARAN)
> +		offset =3D 0;
>=20
>  	if (!is_fru_eeprom_supported(adev))
>  		return 0;
>=20
> I assume the logic should be adjusted. It's better to put the asic_type c=
heck after
> is_fru_eeprom_supported.
>=20
> Regards,
> Guchun
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent R=
ussell
> Sent: Tuesday, December 14, 2021 3:34 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
>=20
> This is supported, although the offset is different from VG20, so fix tha=
t with a variable and
> enable getting the product name and serial number from the FRU.
>=20
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index b3b951fe0861..124376b666fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -56,6 +56,8 @@ static bool is_fru_eeprom_supported(struct amdgpu_devic=
e *adev)
>  			return true;
>  		else
>  			return false;
> +	case CHIP_ALDEBARAN:
> +		return true;
>  	default:
>  		return false;
>  	}
> @@ -91,6 +93,10 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *=
adev)
>  	unsigned char buff[66];
>  	u32 addrptr;
>  	int size, len;
> +	int offset =3D 2;
> +
> +	if (adev->asic_type =3D=3D CHIP_ALDEBARAN)
> +		offset =3D 0;
>=20
>  	if (!is_fru_eeprom_supported(adev))
>  		return 0;
> @@ -139,7 +145,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
>  		len =3D sizeof(adev->product_name) - 1;
>  	}
>  	/* Start at 2 due to buff using fields 0 and 1 for the address */
> -	memcpy(adev->product_name, &buff[2], len);
> +	memcpy(adev->product_name, &buff[offset], len);
>  	adev->product_name[len] =3D '\0';
>=20
>  	addrptr +=3D size + 1;
> @@ -157,7 +163,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
>  		DRM_WARN("FRU Product Number is larger than 16 characters. This is lik=
ely
> a mistake");
>  		len =3D sizeof(adev->product_number) - 1;
>  	}
> -	memcpy(adev->product_number, &buff[2], len);
> +	memcpy(adev->product_number, &buff[offset], len);
>  	adev->product_number[len] =3D '\0';
>=20
>  	addrptr +=3D size + 1;
> @@ -184,7 +190,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
>  		DRM_WARN("FRU Serial Number is larger than 16 characters. This is like=
ly a
> mistake");
>  		len =3D sizeof(adev->serial) - 1;
>  	}
> -	memcpy(adev->serial, &buff[2], len);
> +	memcpy(adev->serial, &buff[offset], len);
>  	adev->serial[len] =3D '\0';
>=20
>  	return 0;
> --
> 2.25.1
