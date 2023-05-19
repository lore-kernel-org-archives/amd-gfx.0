Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95ACCC77B73
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 02:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89DE310E5A0;
	Fri, 19 May 2023 02:36:05 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E15110E5A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 02:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L39rFzA+EdbbqWnq71s0w4pi22kQJpRbaYaCS6Z2t3V5VMkImo2/pam+9ZhzPh6S3cgSczlpWSxfprBbEjv9mwdfn61n/rWSGpTIrF/G8LLQZ5ltnZ18XCB0Q+WO/vrp7N0UhSlTOwwpmk3zOzwhQME5q+AVXuKOnTMMt8BSUY792jdqDfa9JYo9DL8VsfjYBC9MoyzYEALdDu1FO5dfcADp9WMeKoJII8XIIr/9FWJp3AzCbRiNq5K13J3gJFqoNDpw6K/ZzlAmoCRuyc4o/GdKqae2yP0sdoIp94BDlGS3uqcikV8SH7t5d2iXFQ0uceoAcy1K615d+vQ+ntSz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzIS0YlBZmnStqaMbXd0f2wLouBrJVqOHITXAsYERYc=;
 b=BPp20lWL83k4QYaj7CeCb66wfazgfjF/0UVK/c57BlbAa81Fb1O/wUFgA3r/71TdEWesJmsPZeZcKsV5ULhclWZ3SatWp4k5gk/aoMlEMLgSsjLNSh9VF423N8xu8r9GW8srShknua3qGfry2d8YL++EgiFt2GNxLmBbUuirMrWf92fFfnYmKfGMtxJLGRebZk+FpUfU45JREZ6eF4EvBh/GPLwuDCqXsIaf1U+cnzJB/t6rVcsU4jL4TFUB0FV8oxW8UY5BUm7jShJgNA405V0zDqSklXxtTavrUSDiSHXyensNWZreXL2IEbZjB6ELqA6eg3CrdMDuB4DMbw5cOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzIS0YlBZmnStqaMbXd0f2wLouBrJVqOHITXAsYERYc=;
 b=gFpQ16LLY7zDne9nFJ3srW+4PhWrXYzYCrXVyEmlZ0z29MgAs+aaBUi74LhQ7GQ4AYO3v5dRYqg83hfO/QKBm36SiQFnaWccl1dsK1hyb+/rG+mJK/kMSeLIQahOP+Nv16+wA8gWdQxxFd3UOo+HzhrfM/IXV4iinGjnhudS7EE=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 02:36:00 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::c2b1:bc20:6312:8877]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::c2b1:bc20:6312:8877%7]) with mapi id 15.20.6411.017; Fri, 19 May 2023
 02:36:00 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdmgpu: don't enable secure display on incompatible
 platforms
Thread-Topic: [PATCH] drm/amdmgpu: don't enable secure display on incompatible
 platforms
Thread-Index: AQHZifSl8OIK6PmY00Gft3+xNGuR2q9g4PVA
Date: Fri, 19 May 2023 02:35:59 +0000
Message-ID: <BL1PR12MB52374073897357464A0CFA22F07C9@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20230519015251.1057627-1-jesse.zhang@amd.com>
In-Reply-To: <20230519015251.1057627-1-jesse.zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=746437df-2aab-40b2-b9ca-97a7582574a3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-19T02:34:29Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5237:EE_|PH7PR12MB7454:EE_
x-ms-office365-filtering-correlation-id: 7afec232-322a-4638-a783-08db5811c838
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZC+7bZmdLzW8ft+BP3tJB3q5xVOwwhnJNPNiUKcceNAV9sDrGMYEuoE1Z42C2q8qmcc7X6RFDKXN2YBm/i/rTJOrWKY3s3KPVEebK9ks0qXRrWU/e9KTZh4EcZ4L6/9reINgG7FsE1Qx0RUs5Y4ZqrdiOZ+G5+yD5BH+BQIKf1lY4MLIyGNAjNz88UVPNDCXUV5pdyCq+qYiHx4Z4aHByV8+WQpJCbRtI04MoP0WvYf9sTKWxb3nMpFoPLbWSyGuC1D8h0lTOueyA6uCYDkbQV77H+CV/0nLBmKB5bJc4cLJI0VdK0Un1sYWH5KrJB/n4XVCvGlaQFn28w/QR6CGXHw/BSpEsoK496DUI0E4QjLDgk2M1DiojetNzU2CnnGsVUkFIYyQNcZVerqDaLwB62d1ridqOa9K3gVp11kmKCrKr0XneyK3500mkjaWWYJHDl2UamMfdbnrZxbe/ufrVyGMFAOne6OAWfBxyktXs1PhLTWIirc8bcdmPbTG/q6RBxcwnptPo3P/j4CxUbo/rslYb++6umQlX/GZ6uFcqmfY9aDG+TEtgdWisNFCs2eDfZfw4fD0thkv7UOaaMPll1oh92jZfOTe3ClsgBHA/s19kD2x+Rl9P9l2VOz167h9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199021)(316002)(2906002)(478600001)(52536014)(41300700001)(8676002)(8936002)(6636002)(4326008)(54906003)(110136005)(71200400001)(64756008)(66556008)(66946007)(76116006)(66446008)(66476007)(5660300002)(38070700005)(7696005)(26005)(53546011)(9686003)(6506007)(122000001)(186003)(55016003)(38100700002)(83380400001)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I8Jjo/P1sPuIyAJnqzimSwWVai55fRTZSo1vEkOWlkZLAyFCQztxFVCWFqKT?=
 =?us-ascii?Q?J4Dww+OlklWi05tC1YyLFYxAqldVEc++YR4OImmKZfgbNnoTNENaOXg82hsn?=
 =?us-ascii?Q?3H3gPs3U/1jvsxZD4Glxhynin/QV8yaVsETAG51THwnwwMdxNDIOWYONZzIi?=
 =?us-ascii?Q?GRgIqPA5PZVNGMQfDuyRl0LLC42hDqGZFJCmxgq9coFKZgQcOLYEWkwMXs5e?=
 =?us-ascii?Q?DZPhWwTu8DZ8eRhC6JtGi8Yr3u2FTBozIZJp/p2WYN+vyPPCKSX/fchwXtaL?=
 =?us-ascii?Q?fqTCDeCwwxIQqf8le0S2PWcBxkYqCe6cyrJCocRBHFgX/6MRqH2kisONu7ND?=
 =?us-ascii?Q?e4VgirNADWhqZAwAQetoeoLnSSKdqrhXNHgcxrKRwqEksDz1kKJejAtVGJk3?=
 =?us-ascii?Q?dCj/Uw98dVahW7G3IaUj2zvUGT0a4QC45wquA/1tl3HaH7WK4H8tCoDQAj4a?=
 =?us-ascii?Q?RZ6+kQZLkPXo6dnD0aVA2rYB//8jZQ8HRA1ZZSioz8UiYgS8R0Uad8w7z092?=
 =?us-ascii?Q?YECJX+RTDCFYvuUx3/LhfQbiv7IlTojLWUEuo7h6GkVgXS2L5En3YS7Neea1?=
 =?us-ascii?Q?8gh7H/cT2/jZ55JScchWR4ELpoFOSFGpX0WG01/Ye7FVeiAYxpnyciI4vTAs?=
 =?us-ascii?Q?fx7Zgm+7bKAGBw5e4XaPTm2X+MhXggN3mnl54/tj8tYoHerts0WofncO7FYE?=
 =?us-ascii?Q?BjqMO6K0sbNb2/e8RzTgxOqWjgLfhi5yrq1TqE1t9s3KFs03JANaT5vrYr4e?=
 =?us-ascii?Q?t18F4xC3T5eTiagS6EqWusIaZ0TLuBPQ+LZcOtRw2erVqpmefspwgMT/kyKJ?=
 =?us-ascii?Q?i7jXKvw9wYdG6b41qlQloMcQ837f3A/SGEZ+YzVyCY/5i2I3Kiof8tgC87Gd?=
 =?us-ascii?Q?kAgBiMs+cYwDxequnC3b7kmjFVFU4M0Nb80iZm11axhmc/dtKNLdEb8GxNQH?=
 =?us-ascii?Q?1/xCqHGnNxasDXAdl7AzKz2iHNhPbPbez9RKvnlL4Ye+BelxPdAQ+oRskfQJ?=
 =?us-ascii?Q?yoiF8vx84YCMPSkIsl31k8oTOOgmFzNZdTQP0Ojab9gFCWdjYW+oO1rjgjG3?=
 =?us-ascii?Q?vE7aCmAPMw/mLATQvD0Y8WQEp62LymUciWbhltRQiwgHga3Ve2M1iXVlbk0A?=
 =?us-ascii?Q?ezLK+/5eqbMIFueo+EpRy5qSwbPj6gpiSSnabWUyPoT6jlQ3CcYrxQd5ugBC?=
 =?us-ascii?Q?fNN5IaEOh/Cm8b4YbzUnWgX3E1lzLILlobuOOpGJPulsUaBbT55pm/yM3NsP?=
 =?us-ascii?Q?HwO8mnFOBFTh0URQlZYWHzi4oxp+oge378/PRA3VVVkdr6hd/0/KCz2z3SrR?=
 =?us-ascii?Q?ivYDKNAQlFupz/CxMDXOcOqtf7Re6Cp+VPqbo3hbyD6i2dFqf6iCBOHNmI/t?=
 =?us-ascii?Q?d/mnuukQBQnPjZuQfMdc84vXCLGcl8OeFvgdmw0bhd8xFGVe7V5o8O5+OGjv?=
 =?us-ascii?Q?i/O0mtEHpuw3St/hSFwd0aI8X9hKTbJDA0H3p2pymukJCKBREyhRofOmFjmg?=
 =?us-ascii?Q?Z73rsEpdsVNLWkGZzqAaMz8SLNfexeu1iCwzceAzRpSIJY82ojsCnIC35zuc?=
 =?us-ascii?Q?4/nOgXJ9ch23wF1VcLg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afec232-322a-4638-a783-08db5811c838
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 02:35:59.9799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnPqPqwI7NUS2T6B4q9Vk17rQGnhGZqzY80FnT1e6D9IfEE+FbVNH2VX3U7ktXcC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454
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
Cc: "Zhang, Jesse\(Jie\)" <Jesse.Zhang@amd.com>, "Shavakh,
 Shadi" <Shadi.Shavakh@amd.com>, "Strauss, Andrew" <Andrew.Strauss@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Just a nit-pick for "drm/amdgpu".
With this fixed, Reviewed-by: Aaron Liu <aaron.liu@amd.com>

> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Friday, May 19, 2023 9:53 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Shavakh, Shadi <Shadi.Shavakh@amd.com>; Strauss, Andrew
> <Andrew.Strauss@amd.com>; amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie=
)
> <Jesse.Zhang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
> Subject: [PATCH] drm/amdmgpu: don't enable secure display on incompatible
> platforms
>
> [why]
> [drm] psp gfx command LOAD_TA(0x1) failed and response status is (0x7) [d=
rm]
> psp gfx command INVOKE_CMD(0x3) failed and response status is (0x4) amdgp=
u
> 0000:04:00.0: amdgpu: Secure display: Generic Failure.
>
> [how]
> don't enable secure display on incompatible platforms
>
> Suggested-by: Aaron Liu <aaron.liu@amd.com>
> Signed-off-by: Jesse zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v10_0.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> index e1b7fca09666..5f10883da6a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> @@ -57,7 +57,13 @@ static int psp_v10_0_init_microcode(struct psp_context
> *psp)
>       if (err)
>               return err;
>
> -     return psp_init_ta_microcode(psp, ucode_prefix);
> +     err =3D psp_init_ta_microcode(psp, ucode_prefix);
> +     if ((adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 1, 0)) &&
> +             (adev->pdev->revision =3D=3D 0xa1) &&
> +             (psp->securedisplay_context.context.bin_desc.fw_version >=
=3D
> 0x27000008)) {
> +             adev->psp.securedisplay_context.context.bin_desc.size_bytes=
 =3D
> 0;
> +     }
> +     return err;
>  }
>
>  static int psp_v10_0_ring_create(struct psp_context *psp,
> --
> 2.25.1

