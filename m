Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D57C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 19:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD32510E1AC;
	Fri, 10 Nov 2023 19:04:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A4210E1A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 19:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khH089QqAow3/cnLHo+0853Uius6hAkkB7e9G8/nuZn33njUxzN67jPupGhXee+ia9vrgeLopaKm2e6zyJBpQnp1yDCYyXd+OgWU8XII1TJUJ2g+lpir663O8mSBiX0ci+ojIpcy3YadLqKHEch6wV/jNDK6Am9FALMO7vc+v05Z06dJs208iaQ5TukadFo9q0Sdg9OwvHSrHwgm599+rrJsDQt3vlZoK4ibDjD17ejImShDGtdZNtPaJ2LnSz1AtTpMqw+txMct5k6M+WC4v5374tQQpZoOgIBNUkFUHI7AXtQR317DHO5KYeaoheYfAoP3fXNhctLZpSCrCoTWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rS99ZkZTHiisrLfVEoP7uQ6OvmNfn8JdarnwCTZ44dI=;
 b=bAPaBh5XR1GV6RghGO7x9ysSJJPx/MxGJd6KS62EGDe0jJEwsVD5G/ZKRaX2cfH8E3l6AXNTN5Ao2D+qGqvsaeOW++1xp1oFk51GKsynKZ4FNLv3P+tJv9XbThWyx/POUKFBVqZHmxxcEqMYhYGhedEEafP4RSeBqWXDGgq5ii8Q1EMbUym5esO9hjcCE7Q2Ae3qMV63PUN3ezf9gkYErD8YpC68yAQcJgJ1BYh3ZwDdc8gTFNcDLe++fhDRxmuTA5zo/GpCUcL26qkFQm2k0a/n8iHKi+RJSGDPHoOcI9RoEK8+cHHlsheeGScSTH6L7rnu0L2ztetSdDjE3oNeCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS99ZkZTHiisrLfVEoP7uQ6OvmNfn8JdarnwCTZ44dI=;
 b=DvH9mfa43Xm5YNqTurL2V4uRDcLY2gE5G9ULj9tAN9mSW3neUPviCKHFOIG4dikBXczXyKtx+EaZjvp2pbb3pD1OHrrLmozO1+94kgDO+uGegbKOv4Ic2wez+aPPtGulThBGTxmTGTP+wWJg91H6Q/x9AuOqMGc8KMHBOL1EHRI=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by SA1PR12MB8721.namprd12.prod.outlook.com (2603:10b6:806:38d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 19:04:10 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230%7]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 19:04:10 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 03/24] drm/amdkfd: enable pc sampling query
Thread-Topic: [PATCH 03/24] drm/amdkfd: enable pc sampling query
Thread-Index: AQHaDldVWZ+tLxeLz0CHWDblmz248bBzt5ZQ
Date: Fri, 10 Nov 2023 19:04:10 +0000
Message-ID: <DM6PR12MB502116F5D7C47F8E75AC1E0A95AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-4-James.Zhu@amd.com>
In-Reply-To: <20231103131139.766920-4-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=32526434-e687-4922-a7f5-6f6dc943d9f2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-10T15:25:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5021:EE_|SA1PR12MB8721:EE_
x-ms-office365-filtering-correlation-id: 0e6c0505-cb24-40f8-e59d-08dbe21fd25d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LcCXtYJdKCRBvGnviJZLsfd9xcSdnJuNi4CZ6G7cIGezpDmq4ybufM0TkG4WOOzYLD0A9jpSWmz8x4tkDjeTQ460EqmjpOtFTUckJ59eLEzt/lc1Fkkka9NZWaJ8DpHv1pDrOuk30f3zfuCIJ1vYxLNNSyd6KR5Wy3c7iC1A+Zhd1L6+C0bF8IUm6bgmi3+9n+HAVO8pknbO1d3wzdp5sVeoKth8IgckBFgxzJ4t49BEpyU5CuXMjtodbMrPGxpO18Yya+HS1NSUuApbxR7h3ptxBo6LuALg3Whk0xYXOKEIZ1Aw6FtE4B0oZ17apxIg7WF3XS2EA/kGHs7tt7/wc2hMR5d6bmHwqqBNObvq9RAlWb019QEeabLFcHBoTol/vw6mqI/oUtOH+mfRHed1EFiOnOY8ag/Lafyfk9FHRuxilp2D6usW5nJB/+lEY7Mi0lNgih3go7urYhy0hMxi40EpI2Ltd91dQZ+JlzsPhrX4Jlvm6hSDk3QlEp3GAL1dr+3gjJKIdZ/z9OXItx+Ee3DlVQkDZUkb5InU+9G7ClTXgp1uvPrIU4ROLGte+TDlDvDLOHQsDSdDi43ESvI3v0kGtZrl1mvFMZ0J51tcBZC9NPLH0r6k1/F33Pn6qqIr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(33656002)(38070700009)(8936002)(83380400001)(316002)(26005)(66476007)(66446008)(64756008)(76116006)(66946007)(54906003)(110136005)(66556008)(2906002)(52536014)(4326008)(55016003)(5660300002)(478600001)(53546011)(8676002)(71200400001)(7696005)(6506007)(9686003)(122000001)(38100700002)(86362001)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Uc0c4GMOO7dYHsKLJCTXZt2y/nbobSkTRNntx1jr9oPWgUPv80+XV6Fvwdv?=
 =?us-ascii?Q?OpNWR5i2GVcrjIBIG+OlyFv8MN8HyvVS6ECimiCQD024nZo5uj5Jt4nin6Ve?=
 =?us-ascii?Q?92D1X5WTAWk/PNzH5SBFmDZ1xMCG2ZjVJUTFQI+/2jjdBTdnCAa0/ulAb572?=
 =?us-ascii?Q?SpXLpqkq4Rt+WEixYBVhgFcla3z+jNtPehTTr4YbGMa9ke2T3Z4tTxzOA4am?=
 =?us-ascii?Q?Jrv2S0zpALRwnXoVuBssMuaCLjfIKQae4uoT3aHf8vjl3LT6oqZcz1+ebu1/?=
 =?us-ascii?Q?x31dsgXMkTLCWcuW5a4i9g7SkrWPa5jjnAhe9QkI3KdrI7vLCRRfQagZy8bK?=
 =?us-ascii?Q?6H3b2r2/o+DKbkUILA8GocI1c7nzjRgY6LVKW8iNa2A1zI/L3mnqujr586tG?=
 =?us-ascii?Q?tJbOC4SoaiehjpOLywo3svcZ3WcqsZE9hO3efH8d8KcilijHWZ63fDjfcv4z?=
 =?us-ascii?Q?1ZcULeY9VT8YpWgo6kXKolGMDkVWPLaJuN5Cfb1V1qJ4dxai8Jy0zESLLwn2?=
 =?us-ascii?Q?hsQIorcb6jFVXIzhGrHiku0LP9WZQUaqOqmxx/Jvrq7xJPKnGuLDpqU5QF9a?=
 =?us-ascii?Q?a9p07Qs9tHsOTr7g3n/LwVtVQG1aEasDQcYWrUFHUpToVdtV2XOGcx8xI71M?=
 =?us-ascii?Q?nJswYIPO5H5IFy++CpNssXReUAa88T4ccPUskGhDySNTITpE0uHvYCSGp/p3?=
 =?us-ascii?Q?EFmrZ9a8SHTVXHtqsrY7Fgpb/n2y9wmMu0OhR7XNeuO78knwHY+tQjQUOCzI?=
 =?us-ascii?Q?jx88fdaKpb6ZaVoOG2Ju05oj2lQ0+jMdQfrUNpwK+qLFOxMbBNan+bhX+SOf?=
 =?us-ascii?Q?8YMoTaAW7lOHTqA1nqB8DVm3JqQVxt4/Qsa4xCov83/AVYUtpdozv/tODvOD?=
 =?us-ascii?Q?6ahixJh8uMiuO/ziP2ntRb0V5BJ7GngRyeHZdoDO8QJuZvhWJM41Q2r1M6nV?=
 =?us-ascii?Q?Wv+ujKLKbDCr5h3dgKQ+Jbbge5dxZ+FzSHln4xn+7to0IBGAoxs0M4sxe/8Q?=
 =?us-ascii?Q?qwrv0xBIxcUleJNMZZMf29L9Sna7Qmd4d4f5D8qqsLN0vjCD0BwMExYiLxPV?=
 =?us-ascii?Q?/4iXXUoC46qkIVqJMtEYmEobX3mLZeJXKwvb80b7SVoO8Ioee8YkMXuJN0Sm?=
 =?us-ascii?Q?a1oqgNmBb1AVoYXM2rLPbTmPGeTwwSLErQoEsrO6gjaREuBfJLCAiHLK7tPN?=
 =?us-ascii?Q?13oKIhpUcURWSsR2Xs+4HfkLtJKIT5J2qjACCtyD1FH+lb2rslYkQ/MEdD8Q?=
 =?us-ascii?Q?u8fwcDBU/Uk2nTnFThfrfAnTgSijO+gbL8/wPB3r7mZWPqb1t4CHaUukfW0a?=
 =?us-ascii?Q?xKekHz6V9JiZF9BseZu5eq7Sei7ZVHIamil0ZVHBJpgHBR0gS/ec5ROROAkF?=
 =?us-ascii?Q?XAAeC/FbpPejNjzZ4B3OYwkGmU8P3d/otYSB+c9z1n1lkQ0ojtlJjkNXcSF0?=
 =?us-ascii?Q?H6Q4sG4WPw3GVILhXEnyCUXbYykWF150wFpjQhhMauSjRcaaFcZRoHnSuA5+?=
 =?us-ascii?Q?tKR3U7sCTPKUVA5xj75eJf6v51pMnxwe7+3XLCnm87rIQdkX3Usd0+3knyoe?=
 =?us-ascii?Q?lL4pWDCKVkz5UEV0wVU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6c0505-cb24-40f8-e59d-08dbe21fd25d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 19:04:10.4078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WmY+0/WiDrfG9GQCvCyMCQ2JAN5IxBoQt0FE+8NlNLS3eBIhynE4hdeaIrvUyKYciQ7rRgAMudCkAZHyGQUamg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8721
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Greathouse,
 Joseph" <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Zhu, James <James.Zhu@amd.com>
> Sent: Friday, November 3, 2023 9:11 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Greathouse, Joseph
> <Joseph.Greathouse@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Zhu,
> James <James.Zhu@amd.com>
> Subject: [PATCH 03/24] drm/amdkfd: enable pc sampling query
>
> From: David Yat Sin <david.yatsin@amd.com>
>
> Enable pc sampling to query system capability.
>
> Co-developed-by: James Zhu <James.Zhu@amd.com>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 54
> +++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> index a7e78ff42d07..49fecbc7013e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> @@ -25,10 +25,62 @@
>  #include "amdgpu_amdkfd.h"
>  #include "kfd_pc_sampling.h"
>
> +struct supported_pc_sample_info {
> +     uint32_t ip_version;
> +     const struct kfd_pc_sample_info *sample_info; };
> +
> +const struct kfd_pc_sample_info sample_info_hosttrap_9_0_0 =3D {
> +     0, 1, ~0ULL, 0, KFD_IOCTL_PCS_METHOD_HOSTTRAP,
> +KFD_IOCTL_PCS_TYPE_TIME_US };
> +
> +struct supported_pc_sample_info supported_formats[] =3D {
> +     { IP_VERSION(9, 4, 1), &sample_info_hosttrap_9_0_0 },
> +     { IP_VERSION(9, 4, 2), &sample_info_hosttrap_9_0_0 }, };
Nit pick, the "};" the next needs to be on the next line.

Regards,
David

> +
>  static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
>                                       struct kfd_ioctl_pc_sample_args __u=
ser
> *user_args)  {
> -     return -EINVAL;
> +     uint64_t sample_offset;
> +     int num_method =3D 0;
> +     int i;
> +
> +     for (i =3D 0; i < ARRAY_SIZE(supported_formats); i++)
> +             if (KFD_GC_VERSION(pdd->dev) =3D=3D
> supported_formats[i].ip_version)
> +                     num_method++;
> +
> +     if (!num_method) {
> +             pr_debug("PC Sampling not supported on GC_HWIP:0x%x.",
> +                     pdd->dev->adev->ip_versions[GC_HWIP][0]);
> +             return -EOPNOTSUPP;
> +     }
> +
> +     if (!user_args->sample_info_ptr) {
> +             user_args->num_sample_info =3D num_method;
> +             return 0;
> +     }
> +
> +     if (user_args->num_sample_info < num_method) {
> +             user_args->num_sample_info =3D num_method;
> +             pr_debug("Sample info buffer is not large enough, "
> +                      "ASIC requires space for %d kfd_pc_sample_info
> entries.", num_method);
> +             return -ENOSPC;
> +     }
> +
> +     sample_offset =3D user_args->sample_info_ptr;
> +     for (i =3D 0; i < ARRAY_SIZE(supported_formats); i++) {
> +             if (KFD_GC_VERSION(pdd->dev) =3D=3D
> supported_formats[i].ip_version) {
> +                     int ret =3D copy_to_user((void __user *) sample_off=
set,
> +                             supported_formats[i].sample_info,
> sizeof(struct kfd_pc_sample_info));
> +                     if (ret) {
> +                             pr_debug("Failed to copy PC sampling info t=
o
> user.");
> +                             return -EFAULT;
> +                     }
> +                     sample_offset +=3D sizeof(struct kfd_pc_sample_info=
);
> +             }
> +     }
> +
> +     return 0;
>  }
>
>  static int kfd_pc_sample_start(struct kfd_process_device *pdd)
> --
> 2.25.1

