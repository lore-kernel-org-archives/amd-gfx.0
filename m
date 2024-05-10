Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ABFC25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 14:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B94FB10E115;
	Fri, 10 May 2024 14:16:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a4K/k7fn";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38B0A10E115
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 14:16:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKSh6rg13UpHYIw5eIRahy0kTbO6NUxEZyopzLtALcUWzLmM3g84cCjp2PhVyoCSb3iLSOXPysLH8rRWi9wVrQAsDXjOds6NvKNoJBOzoqTpmKcCJVG+9kZVIh8+yEX+S06w8+F3AyDzrzCvrH9c2LBgUQWZjSNQLHhVLAIRhYQvyLT1ORjcJOaz8Sj74pbIFrG0r1T35hsxMZ+7wncu8ifNjsjasOErf56ZHgrBY2ISrrSxSbP0RWVs+8pSc+WOCTKk4ThTvHl4xSUXUGBTOyQ5+1HZlK4SrIT1oS4+A2Ys8dJBAJIlviTRXBpf9ynuzNpUW7w/DBOVUyOKo4u8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcHT/mhQBohlaLCczvBAnMjusd6dklTCkaEfJI19rCE=;
 b=AxZOeAwPFrfvM4DCcEepBAEv1mV+jF4z29XfChB9dpa5QDMlxVpCbA6qzr6/PUoMRR/PPhNH3XqRriNl06/cJIfe5LlvDj184xasbRSbvXTKhBy2mjg2t2RLTLPR0RlYDsfkliS9L3XUOZRTsKCX2Was3XrOpK/WvnBvfNixU4aX9jN3HCtDGVk4BePEsGbuIm7LMlASP4zdASrHHRnbKpt471vjdkY1vMGYkeOXQ84yIwbul8YhyIr14Fwn9r1Y8FTSkw7/knNPLxjvVxBeV6/URvqP0xVywowwyxVPf+66eaUWS69FwIjcB8iDEo0IZKnOCYVMs+YhiUMjqopTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcHT/mhQBohlaLCczvBAnMjusd6dklTCkaEfJI19rCE=;
 b=a4K/k7fndRRpauYMapKlEg5BddGnrLKmYfZw/uEF9/IlxxQkS5MlktBvMlE3wJr8aFUWZZnGU+W0efi7tUcQuIv8UfTXSRDnfbqwJLttvwMmgvv6moYD6AFo+HSEVn3o6oshHyOERWx3t4pQBBtfsqnqdEtR8YXAW6VAH7/jSlk=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51; Fri, 10 May
 2024 14:16:36 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%6]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 14:16:36 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "Somasekharan, Sreekant"
 <Sreekant.Somasekharan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Somasekharan, Sreekant"
 <Sreekant.Somasekharan@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: RE: [PATCH 1/2] drm/amdkfd: Remove bo NULL check in
 gmc_v12_0_get_vm_pte() function
Thread-Topic: [PATCH 1/2] drm/amdkfd: Remove bo NULL check in
 gmc_v12_0_get_vm_pte() function
Thread-Index: AQHaopZuPc1QhqbgJk2IBWRg4HINh7GQcyVAgAAQ3JA=
Date: Fri, 10 May 2024 14:16:36 +0000
Message-ID: <BL1PR12MB5898563994AEE3121824E61985E72@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20240510045541.533908-1-sreekant.somasekharan@amd.com>
 <BL1PR12MB5898A0A3EAF7FDF26A20F12F85E72@BL1PR12MB5898.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5898A0A3EAF7FDF26A20F12F85E72@BL1PR12MB5898.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6534a26e-8720-42af-9415-4354a3f82008;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T13:15:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|CH2PR12MB4152:EE_
x-ms-office365-filtering-correlation-id: 89d4e74e-be45-4044-01e8-08dc70fbcd53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?1Rh43GnmYKR+x3p2t+B9zmV1LJXZiwcuGSmaH9tMRgRpBsEJhxCNpN/mAFmX?=
 =?us-ascii?Q?Q5Hwf2+juZU5QfP6pHVfuIgu9rWEy3l92kBrltlu8uR3SyS7SKXfhVOAaQgY?=
 =?us-ascii?Q?qV+6QD2YmNwNaxxbm6U1d23/Fu9BwilEcFoGgO1LTZdxBmehrefe1qZqqeXd?=
 =?us-ascii?Q?oPxElDnj1cjvu+llYTxO38wFz7lyIZWXSqaqf9tnzQ5T1IIXYAYEPWmAQbqa?=
 =?us-ascii?Q?1u/IyKYQMYDX1GFTMNGWWYumqODuqlp5df4HyobFe4SXJT4FsmxjyAwdSLWy?=
 =?us-ascii?Q?r3ue7UCKdql++h5yG3oAW27zidJGGG0rUiUEdOOGKDvpJFBPwmNahY5YfHau?=
 =?us-ascii?Q?3gZtgmhV+2XW3632s6BoN3rStRtuUzgXUlwgTKTxNGe3vXaRWHTrutbk0gWH?=
 =?us-ascii?Q?ityr8Yb4ISJFYeMBqbyO+l9Z21HhT3D7SaSVEb2BnEoZRgtPdi6/mJMRr/A4?=
 =?us-ascii?Q?UbhnMZOPtJVdpHbey+KEB18JssqV2szX/LHPwTAIhKcPIXI0VeG9usnyzz3J?=
 =?us-ascii?Q?eHwPHBNKCWZ4Yma8IiYHltzFM31YzM+MhVT4QC3LxScpPS0L9gsRGFTHhMoN?=
 =?us-ascii?Q?MnVDwm+mHwkyPMsm1euKYkGVy/Z2V5Abhh573Vyp/Ak74Sfthjj5w9Axltn3?=
 =?us-ascii?Q?ASoCRF4FRpqmBOmeyLhatyCyzE5LsPTTDrQYd6dMdGHkOTF6gB60ZR/XVw8F?=
 =?us-ascii?Q?NwK7+DZzn5aV/fL85FFAiwx0O2CovEl5LzXqlyYOIcx02yqivJn9bIsb5aM4?=
 =?us-ascii?Q?VzYVN4OL2hfZKtaqaiguJcHM+GI0+V8F9nfSxKbB5x3y4I/9hgBZX/j/6emY?=
 =?us-ascii?Q?AtewrAB3CoA2eqKCTnCF6QMx+O0CBJdbMeflWN5P+XdMXqeYdThE6vvr7+Qk?=
 =?us-ascii?Q?z2/5LzP1CJcW7d9UamRgpwePqt1CX8P7JYnmdt66Ts+ImzKbmU3cbxKxVcVT?=
 =?us-ascii?Q?VqkTHnc4qo5WjlCfBUY/mG+YvDWLu2LUswFGC2WTUIGMHf6E8QPNe+vcmuS8?=
 =?us-ascii?Q?acXG7VtygmMjXm6i7zNBIstF9nLWp3DkwkuuFZMZpsZMZyg96/Ny91oKY44Q?=
 =?us-ascii?Q?67iib//2hqKezeVjcBDd/+3wxs8WsgHL8x7lGZwHepyeb6tEaU+Z/VXVcppd?=
 =?us-ascii?Q?iHoPwHNBqBMJIAHJ9WOH/hC3ZLsLLcZFCoVTrlDvbCzqzotE9P9B/0OSCiIH?=
 =?us-ascii?Q?6wIhKQujKyN0c3EjjcjqXB9IEG6O5y/xBlbE1FDRih0XIwwrlyNtWDwQrGUA?=
 =?us-ascii?Q?cUw4gaNchXheWzPkp4iOjWVF4swjbQD/C33epnlyNUWsra16+bRXRDr7J17H?=
 =?us-ascii?Q?b57YVngA2GSTcHVINlFLV9sWZD4NYklfOL6UPwx1hznhYw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B4dTW3hATNV3R9+k9xxj1rg7fjEqLzn+DTAqSA7ixi87JrxecQZ+4U0Uq7f6?=
 =?us-ascii?Q?9dRwWp3zbyX7jQyVyn9Ui1ihSv2k8G1ClbFpttocrTQLGBdO/WOyLLfh9mS8?=
 =?us-ascii?Q?9taJAtQq7W94zXr4Snp1FRTuT11raaTBE+YFrM2eaCNyi7RxdKulc92dayEZ?=
 =?us-ascii?Q?HYQP0MJiYrw9SPUkoxJnItoimgpvtOROT/jv68iQ/06LsrOwkXf+jsmZve6F?=
 =?us-ascii?Q?X9RADnM86OsHm/02nZkeGLMRTxesQpTv8Umt+JUH/taO14I2/ox3Tr41gTKg?=
 =?us-ascii?Q?pt5tnSKeKeZ9VcgTLdNKdBQBeYGlWIvUqf8g1NU6VCAU3JYbSTcRjj1tJL6k?=
 =?us-ascii?Q?IMN5DjUqBb2loaRIwDMdyVfk6DU4Nz4rLinyM624bBYT/kfKkQqrG3x2Y0BS?=
 =?us-ascii?Q?q4G51UAyjK77ig0cDl0aIy5TwY3bwLpPvrtSnsFbjqQBSOcChubFw88kADW6?=
 =?us-ascii?Q?pnMNRlerCnk9XXLYJQzcn89yGb4DR3zxUTZyJhs3Sk8ZanB/pWiYceMIXYyk?=
 =?us-ascii?Q?/GHyke8mN9nBENTDEwZeBGnvH0QrB78pY+/XwkRZCbzEy5t934LKLrF1P5b8?=
 =?us-ascii?Q?P0lckMcHQgy6jhf0/pS/NO0Ra4SbBTs2SJ8CZSt1sZU6r+syQkRqjqUFvGfP?=
 =?us-ascii?Q?PbuRA5Z1NqAE8Curt6U+9tLLF2+oiLC9jUX1BLiqsBb2mWsaOXzY2gYBglfp?=
 =?us-ascii?Q?cAFyCFA2W8hdsf1b80uSHKAN28rvdbUKJ1G8iG+wGX63NH6ce1iYASi81TWx?=
 =?us-ascii?Q?4CNxOwJ8ILryOZrMOrUC1mYSHTfP7Obm81/KugC0L5n5cShNTzpby+oj2SfO?=
 =?us-ascii?Q?RMBkl/ug/7pIlUbKPqFmdhgJ1SthEl18Jv1RC1zAZI3OZB1vkk2Pi/37ISAo?=
 =?us-ascii?Q?oC5RxNYGCxUCTKQkQ58zXk55GCJY4RdV04wJtChWvYHOWfDnUB2ZERX+bYf2?=
 =?us-ascii?Q?WjLl2p05j+/1h06zaWBsReF5QKOeWDDceyLB4a7RzgAtZamNfbZAv7rekvIi?=
 =?us-ascii?Q?FFwZo5FQlzX+VS2Eg/n/A6bGi6G2agPIyvO9qyqQQ2fGTChOnRWv+XP3Z+fO?=
 =?us-ascii?Q?UvQGZTcnViAWMWYs96UFZ5r8gMf27JrTsPN/2rtYqCwTapuNEsZ0tpNNiozN?=
 =?us-ascii?Q?kTRU0ofBjjKhdMUoLL9f6EDlA/aJSzTwaj6hAiBgZknlFQrfAcKj1CN5SJUX?=
 =?us-ascii?Q?O6nG5LDazVaq8c99qJu8faRcYURM3t/uEcxSov0QpdKo1/SjaLvXeqfC/SSF?=
 =?us-ascii?Q?1GjflqEtS4P3GgPA2I725vvD3/EFm55i08desnoW6GpJGIcVNva80YEAExwX?=
 =?us-ascii?Q?/BstDLxgYGwTqRYDBOmxSrGET8EYvW/pvmYGgS3VoHK+SWawszdkaszWsqig?=
 =?us-ascii?Q?5/ohUlLJIJnXBVxT6fmKsc/kwTI+Bw1zXHatTZAvrIhg17srh88THYDaLNqV?=
 =?us-ascii?Q?Ba0ENbqfy0rQZIOqLJMPyLFHvjljOFyuKeo0YGusctQ191ueWNP4By+AslAk?=
 =?us-ascii?Q?7lofBDwKtZAh78zNWCY7nz5s35ZtendIZSTI7Cl+2YQbyetPcBOKDVrauqP5?=
 =?us-ascii?Q?JahqhDfp5gJmiX5wT1I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d4e74e-be45-4044-01e8-08dc70fbcd53
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 14:16:36.3258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bSaeA+5bQUaBE7s//T0AMQFSrJHwhm2OzBtOok/JNoaQ/kTcbzSXDsZYqxlyi0Bzis84xlM50T9WM2cgJaDy+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4152
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

[AMD Official Use Only - General]

Never mind, we're good. This one is

Reviewed-by: Kent Russell <kent.russell@amd.com>


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Russel=
l,
> Kent
> Sent: Friday, May 10, 2024 9:16 AM
> To: Somasekharan, Sreekant <Sreekant.Somasekharan@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Somasekharan, Sreekant
> <Sreekant.Somasekharan@amd.com>; Dan Carpenter
> <dan.carpenter@linaro.org>
> Subject: RE: [PATCH 1/2] drm/amdkfd: Remove bo NULL check in
> gmc_v12_0_get_vm_pte() function
>
> [AMD Official Use Only - General]
>
> [AMD Official Use Only - General]
>
> Do we need to check whether bo is NULL in line 500 first? Or can it never=
 be
> NULL?
>
>  Kent
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Sreekant
> > Somasekharan
> > Sent: Friday, May 10, 2024 12:56 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Somasekharan, Sreekant
> > <Sreekant.Somasekharan@amd.com>; Dan Carpenter
> > <dan.carpenter@linaro.org>
> > Subject: [PATCH 1/2] drm/amdkfd: Remove bo NULL check in
> > gmc_v12_0_get_vm_pte() function
> >
> > Remove bo NULL check in amdgpu/gmc_v12_0.c:gmc_v12_0_get_vm_pte()
> > function
> > to fix smatch warning:
> >
> > 'drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c:518 gmc_v12_0_get_vm_pte()
> > warn: variable dereferenced before check 'bo' (see line 500)'
> >
> > Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
> > Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>

> > ---
> >  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > index 5dcd55d390d8..df0363ad1a51 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > @@ -511,16 +511,16 @@ static void gmc_v12_0_get_vm_pte(struct
> > amdgpu_device *adev,
> >               *flags &=3D ~AMDGPU_PTE_VALID;
> >       }
> >
> > -     if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> > +     if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> >                              AMDGPU_GEM_CREATE_UNCACHED))
> >               *flags =3D (*flags & ~AMDGPU_PTE_MTYPE_GFX12_MASK) |
> >                        AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
> >
> > -     if (bo && bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
> > +     if (bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
> >               *flags |=3D AMDGPU_PTE_DCC;
> >
> >       /* WA for HW bug */
> > -     if ((bo && is_system) || ((bo_adev !=3D adev) && coherent))
> > +     if (is_system || ((bo_adev !=3D adev) && coherent))
> >               *flags |=3D AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
> >
> >  }
> > --
> > 2.34.1

