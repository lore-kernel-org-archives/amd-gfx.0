Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13183C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 10:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8DC710E5CA;
	Thu, 20 Mar 2025 10:20:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0IEWty7I";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3AB010E5CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 10:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y53jtHAu4hRlkqGS6y6BeHMYIdj6JrnSlo79rCgU1wK12S7M+c85uKUi6xJ0B/EJQPokf2h7+OymSbq6g6i79rBOFly5x1b6S4C8vvUta9dcK/ymIdZCTltMUNLBNQz2xuruUo/TDpboFt8O+2Lp+2BpMNuphKLC2llClO6+DNg6lOnhQTP7mycdjnEQDpthZmniKPGL+ei17uc9rocoC1W6RsAA+IgBbAjhoAGViGBXiXWwvdrno8i4LS99YlxjQ9TlKSm1AhbuS6en6iZ3nBgXpORPGnd/WgSmyfAOcdioujC3/5E2cit5813/0h6TWbHNSg62kHCMuESky310yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKPJg/6rJKLfNQSF0t/tUkKg6KX0PHFPustjgaYBG30=;
 b=QbDsSzfdwPfVZa8EbFugrrcsvp0p8kVVd/sbVncL1xcGlKu15Y91tbYBYXoxI6DqGgNIRawBKir+fAv7OlNuudN7+S6kS7992RKMJKtVhE2DDOh4svNRAs5vuuMQoUHsQX8nZbTUgiJJ4f5vGcjJ9OoDtoqXWjM8rVHoUZrXrmLQ0CQOEWO7ERfkNcZ4LOZ4Ka/l1tIrZLu98j545QfKj4XIKecJl4XsrtgNBYSvwi/Hj5989M8XWKL+xUcU980gANWD42PUgx2lIlkV6NesvhOrSWoIqBNM/x2OXcf/EO1g5us/NNAayqSx+Qs47FrDR6dfSO2CaEjDBeI/EjXxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKPJg/6rJKLfNQSF0t/tUkKg6KX0PHFPustjgaYBG30=;
 b=0IEWty7IJn+YKFlOW5ILr/K2QoWcJD2NtJogbawQeetaOCKm8ybcuGqa2Vl6R4oCM5K+g45tHI/l2xsEQjc+tyMb/gOxieYZpwpYCtkwjF2F84kruORW/oMCMJxPuxsZSLJRI06Ns5/B9GzIA/17fTmpvKZWRgIasq+F6ntdPpI=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.36; Thu, 20 Mar 2025 10:20:29 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 10:20:29 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu/mes: drop MES 10.x leftovers
Thread-Topic: [PATCH 3/4] drm/amdgpu/mes: drop MES 10.x leftovers
Thread-Index: AQHbmQJqUzdwrQR5W0eqcfzgsoAeA7N70VTA
Date: Thu, 20 Mar 2025 10:20:29 +0000
Message-ID: <DS7PR12MB600576745E8FB11AC61BE0E3FBD82@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250319190850.3899718-1-alexander.deucher@amd.com>
 <20250319190850.3899718-3-alexander.deucher@amd.com>
In-Reply-To: <20250319190850.3899718-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=edbacffa-6740-4ec9-bac2-117572bd4788;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-20T10:20:24Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CY5PR12MB6575:EE_
x-ms-office365-filtering-correlation-id: 61ef20a6-50c3-4723-e564-08dd6798d6dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xPpCxRQhLaFF4nmhYz+X1zZzPOmfXwbPaCdk0uX5gjUVNSOzdtMmZ9X4t0zK?=
 =?us-ascii?Q?zpzjT/QiiA/GLp5Ygf+iKQnYyXGG4riocR3WmaweDdx/aenvgrruQfgDf7lH?=
 =?us-ascii?Q?tLy42awdJOYEKUcr9Az4tJUwTVZPxTH4F7OV0WqzTT3OLXAOYh2jUw4KuOaz?=
 =?us-ascii?Q?+5jsj/0veQhC0IPcaey0WX0mqtyPegf9YUJbW4SZbn8ruzBjAW5m3yzGFbE+?=
 =?us-ascii?Q?1+KJF3b7cw61z3wYExbzru9u1RKExEYhUjX/8J9Kg92aCViiWZhjMUJK7p8L?=
 =?us-ascii?Q?RNscXMvGfXWVOLK2btsF8U9UAAcltexS9mEh+Wxpx/Mi1pOPIN3MtLg0DQmN?=
 =?us-ascii?Q?QArHENONklJHlTnQrok6Wu/4KxRVE1jZWKBwgZNnkvqO3jFRI3OLqQY1MXnI?=
 =?us-ascii?Q?oVBK5VT/bOBJ24SNhk6VPktQX3PObmIKpK+nkBPcAAfTKo29v2bFJ1eqvm/g?=
 =?us-ascii?Q?A8svME9OR5ZJexXRUdHT9BxOQfT1kpfhtbaUJ5UF4PvjN2hMTNt4kLZ1cnSt?=
 =?us-ascii?Q?JkbTe0LsPme9H3J6BBDDgbEawUV0W+7K6vRn0YZDHsxZ/iq6yH4owFJ1sxxK?=
 =?us-ascii?Q?CuKbxPZKsFa0sv1EVRNqVmWaxpBSPfOxy5ii47bSUIu7+44TaaSmKBTIjsmV?=
 =?us-ascii?Q?Qs85cubxHJwR5jt/V1lLrugEYD/K//EZZ80/v/U2OMXrB13nlZMuhWD7idAF?=
 =?us-ascii?Q?JF/KUILziE8CZvNQcnzhioyaRmFcQNO/hkc8/nHcG5DWdtmKHJfhnie71zYm?=
 =?us-ascii?Q?r6p3Qe0zgY+YvXWtaZvWH9z7sVnmR8RDLiDEaUMeM5D6kxAddlmI2izJbM/z?=
 =?us-ascii?Q?/3kRspku73DMK78hzych/eiXM1aPs9Bp2tPLuacrbNR9zjuYaI7nXYg8fw+t?=
 =?us-ascii?Q?B0ONERXmAHlOWZz/KgeXU48e6IIQyIUqQrk5mG7JIR1TUhHvs7bKe9w573cZ?=
 =?us-ascii?Q?hpsovYJ6xtEdOxcjydRNthY6EWSn0N+KssuVEE2ho3TVF2HEEQkzuIDUc/GM?=
 =?us-ascii?Q?mIE8Z67r1gD6gZamdSVfx7hiL4/7ryvypbSBG9gnJciATjjZHE2Nsisd8Ec4?=
 =?us-ascii?Q?HJ8POkHmalWGFyPusf27qTovWDyUm1jl4Cqig2hoHBI8hLGNBERXMKCZE0lQ?=
 =?us-ascii?Q?zsycqIpeNxyHzY9pDijI877estvYRWfo4Bx2OLxNSDMN6aaE5plvQg3Rz+eD?=
 =?us-ascii?Q?obDw85J0bs3JNAOvKJ0UjpD3Ec5+3/jojgA89jfntRK6U8o765uOHo5Istw8?=
 =?us-ascii?Q?JvR1PdE3tPcAMx1wMlwOzUIZ6WyLy0yxLwe3/iHNTlN+KTqrFOh2PyJKeRBT?=
 =?us-ascii?Q?GjQ+0kJ2w2VdQuQglfaW3cH8984Bf2m/G6aTbMs1HIex35pg6NFp0GHAtaPg?=
 =?us-ascii?Q?FGkhnQ7yRiFvDMjIMkFsAu5Lk/SAyV0ObO5jxU38RDrwfTlWiZ8bx6pm9Y1J?=
 =?us-ascii?Q?iJlvxGrDIFXd/W6Inxff29t1383yyjGZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2i596sQvAmexzh5hAsIDI8uYxzdS4MxPAxvDBx9v/nWNE4l+NAMMprLrE/Hv?=
 =?us-ascii?Q?iPPpjzP9438CNqcm/0eGWFf0X5YebDfD3hdPUqdqt1S2hyGUBHdbZjlY+Vce?=
 =?us-ascii?Q?5RF/cI0VDuh/M3tqbtC4pYbqwr9of+lYQwBbJNVHTmdhWjKI3qQz2eYTcJa4?=
 =?us-ascii?Q?5DMLSnOkkQiZ1SCNNksYBsVdjwR6crwW17QrfxcJcfRPwztCEtUquEM/qVHK?=
 =?us-ascii?Q?cdM5RmLsU3+xKfkTf7ckFUFSuYMlwo+tRnw4BH9cMQ+H+PWMCpC7qA9ORJ6r?=
 =?us-ascii?Q?GjU7YJAT4GeqKthpRhYsRbElqo+Y/+hE5ySGqGP4rUQu2pVyCjURGK5OFcO2?=
 =?us-ascii?Q?knfgxBsFsiurFUzMWjV+YsXUZXDqqJBwSuxR87y8l0h1ttuPMlNUSeSb7pP+?=
 =?us-ascii?Q?FSD08IpbjsUC3qUX6PR/8CVlFN2DK2flAdC6jUslNAkuiZHojgkkd+6y3tiA?=
 =?us-ascii?Q?bQ+pidpm3Zb2J7/VYO3Yp+XOfW4tQij3fsaOaa2HEp/TvRmRGKijceu/saT0?=
 =?us-ascii?Q?qcdeucytS+LcUSdA/OFyXGo5fVwqrcH+pBLqYEzKxRkgjgqSS3SVGXQjaEGU?=
 =?us-ascii?Q?oMa8e7QOFeVeSfiPTHBiBOf/ScPHTWFGwDI4qDCReTZEPPewXT8f4Eg1WALQ?=
 =?us-ascii?Q?pEAZWtomJ4KgT5iLgyJeJrunR4axTYbCq0YYduDkFcpdm1/V1kjS8Moz1STA?=
 =?us-ascii?Q?hX+eFQP3zLK+rXXc3WBv1/gCW5EMIGBUM23p8fljqlUqv5C4NxIrfZAmdBCg?=
 =?us-ascii?Q?LxNSKFv/BRH3cxA1FQfU60c6f/EbcsvctZwCD6YcMX2rWlIdt4p88eWO5OOp?=
 =?us-ascii?Q?um8pmu2OZ98Kp7bVoTRWQe/xqI6rJpkMwi/4haIKykKHzsXVnn0esVnynHUx?=
 =?us-ascii?Q?IVMuPTvW4RtziwuCe5FUpH8nQMa6lXgzrx/O1X6RKFPqSzZmquHo5N3QUysf?=
 =?us-ascii?Q?rM/bYSeCfSEG/s0Oe3lX/sz9o5XPOq0LuIjpidI6hYGEXdtBiYVwWpSRYOPc?=
 =?us-ascii?Q?rh4s5uvgm+OPe2AwGdHMuw3LPBwlcIoTt9KBYZkidFMwJmDDjXkDPsH1bEtJ?=
 =?us-ascii?Q?GV4L/22BnHI9MmFx87BPciovL+F3cQNl+qipCPqEHbHFnt6Ttqe4ZcXL9buT?=
 =?us-ascii?Q?oBit4uBZWFTyCke5PA9wyAJdk0W8N1XFu1DTeljih6AcxPUXJshkYls6EGLA?=
 =?us-ascii?Q?1yfYV0kHpAj0NYhfhidmpr/FdKkQEnnnGjUDHq1oFT//qc5W2v22e0389J+o?=
 =?us-ascii?Q?XHes36Vn/tHHhueYYLOPkEGo+EmmwNJ5OIxhBKm/LIPKryhNSNBW9n9N5kME?=
 =?us-ascii?Q?vSYaO955CTF/SthMTrwARI9MOYaJVwVfbs44Xh9o1TZR5yAKYQUX6GtbiNO5?=
 =?us-ascii?Q?yFFEk2mAqiZjOqRUtx1QrL6PTrc0tC/bYyHKOzaH5N1KXeyNWb3dCByEbtmJ?=
 =?us-ascii?Q?jKgS/30HUtst7NLDP1oXNUOJormZ2FUDe1ne9UKEbdicOs/2LBBzPSA39or3?=
 =?us-ascii?Q?Y49ZTq4wCMg+W9zuv/rdZkm7FjcnokrUB5ZJ3TEG1O+KttP3/ttexGpGI6Mx?=
 =?us-ascii?Q?ZhpoVn4JejHHliF8mKg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ef20a6-50c3-4723-e564-08dd6798d6dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 10:20:29.3408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cdi54k49dk/SDfQkyNHJW44wY90W4vIEwC9XE0HoXdRrxV8zyS+TzMLbdovv4EAS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
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

[Public]

Acked-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, March 20, 2025 3:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 3/4] drm/amdgpu/mes: drop MES 10.x leftovers
>
> Leftover from MES bring up.  There is no production MES support for MES 1=
0.x.
> The rest of the MES 10.x code has already been removed so drop this.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index ac9b1708e20d8..fddec5d1f2444 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -136,11 +136,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>       }
>
>       for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
> -             if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) <
> -                 IP_VERSION(6, 0, 0))
> -                     adev->mes.sdma_hqd_mask[i] =3D i ? 0 : 0x3fc;
>               /* zero sdma_hqd_mask for non-existent engine */
> -             else if (adev->sdma.num_instances =3D=3D 1)
> +             if (adev->sdma.num_instances =3D=3D 1)
>                       adev->mes.sdma_hqd_mask[i] =3D i ? 0 : 0xfc;
>               else
>                       adev->mes.sdma_hqd_mask[i] =3D 0xfc;
> --
> 2.48.1

