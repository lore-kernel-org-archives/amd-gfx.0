Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203FDC3DA78
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 00:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 612B710E0B9;
	Mon, 16 Jan 2023 00:36:30 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6608310E0B9
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 00:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a00qqmxnl7lr/QJwaYkwh5H4enc11ypjDce6H5wUDcitXs4/Z/FZ0eZhVZe45Ngz/veBQzHZQpJe53Zm/tyYB61V3njVQ5nHGgxbGAlByA/JdmTi7msk1VtzQVHPVGFyhULbZ3POzaIOw5baFwrcdcxT/LOOn3TBYqDccXGpr5eMim9wrIpO6oKnO2c5bJ9RcBhRZTwFpM+730JkPRjaYbh3C4iXEZaUf+o2lFxJH+EehMxenYLKRFQBqRlM9PU9lh+2kFuXLe+uUgF6UF86VeF5vo8v+CSH6W2Lk6dt0LfYCRC01aKdTkp41aRHJPs4qZtS4kxVZbG1GZSxQhtb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQWMmrAJctCzIU51lcr4cc7OSsghHqw7Kz+QTdvAo/Q=;
 b=hlO6+Wj7ImwkgdDxh7LnoZYZkVEL6BGxIWkaRE+lz952Redp/SY3PyX7+hhcaK0vR8i67dKS0FUCZuoKu9Xk0oSYcC9d50PSR0AmVPT2lWEFilavL7wzPUj6JsixMmWjCj00W48DhCyVwxtQZUWpM67qzT0CeT6ZRHJ34KjoDAgqeTYkSaE62AtN0n9JdzyLndRmR33g6vk6C9yEyWrTqst2uxHW6sBnlp/Zd013Lm5MPUBx81q3oLtKrx2iQnjoYm4tTG05JeDZyZW57R6MbW+pvmcGEVazVGd0f3kd92U+RKNVzdIEfMq4F4/QRDsWrLk7J2PMdKZl9so/nSwyng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQWMmrAJctCzIU51lcr4cc7OSsghHqw7Kz+QTdvAo/Q=;
 b=kGh3JCwX1xEdvipE9Zk8vraHamwfTwTvNKgu9H7T978VkoYm/CHdzPQhDFWTkTpbeM4pEgmethlN9Slz3G20M6CGNrAetRFrEbPwlvkw4TtD68d6PzF60c/OamPlpJIjpz/IY8P5T/2BJyIX+4idDc82FxPhgCtduVmFj8Gqmq0=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 16 Jan
 2023 00:36:24 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::956e:e4cf:6a8d:3f13]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::956e:e4cf:6a8d:3f13%7]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 00:36:19 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amd: Adjust legacy IP discovery for
 Picasso/Raven/Raven2
Thread-Topic: [PATCH 1/3] drm/amd: Adjust legacy IP discovery for
 Picasso/Raven/Raven2
Thread-Index: AQHZKRavN3QiarJbnEiAA5TPVQ0Jb66gMsyQ
Date: Mon, 16 Jan 2023 00:36:18 +0000
Message-ID: <BL1PR12MB523784C55C0A90967CEC0755F0C19@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20230115192144.4566-1-mario.limonciello@amd.com>
In-Reply-To: <20230115192144.4566-1-mario.limonciello@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5a3c7d36-b60e-4b42-b07f-0e48ae72d7b2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-16T00:35:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5237:EE_|BL1PR12MB5828:EE_
x-ms-office365-filtering-correlation-id: 3d8d5a09-3c66-421e-59bc-08daf759af17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VX3YuITYfs8U4PCZ7omJ5l0s+Xh1fiiyTr+2FSWRoX36wvNPUsTOhvdccZwp1ZZ2+gJN1lnc3vqc9F9ghr6VDwZh4WUMYBc0XV6UgpDTF7TtB8kthCujfG2AQcejUc5xBihoqsz0uRzAWAWiY6dbULKqlJnex61nz9LHkaIMUz9PjW2xn8K8ykacYSoNN/QGLAe1oEIrLUyyLLbA6Rux2HcxXlOw/odd3idsXDyKCak6NWsWQgtSliwNtvaqtTyO5yisDA4IlqhTHTVQrymS+EpaHFyC6HvLTF7KdRxFZ67UjU7kXf2tbeKfRHDA/pO/B0wsB25lVs5iTfERHYHxVZ8vPgW3y899t/HFavLTZBbIrmJNQv4QdCAoWTiEhV7MSs8BGSHmjIR5y4zLRjeHorD6XTZN3JO+/Cw7DEVEqMBSCghgck5XtvwEtqLxZx8FkjFDIx/eymZ8fM40x5KzfldygeZH7UAt2/bbuoaZMSpOmy9szXVCb8uuxh+n9tAWOoDQeADiJLt0awfjotUR1PSVBWNfOtfccZVU+biFzDODB8oUrwrPjscM8KElMjtDA1PHpa+C4lh9D1C5NFrlCwKwFudnmAMgJyiF/VOY7318aCm2xDFiI3TcRIkxKzhACTl8EBJJ37GxwmYaKq0l4yQNzPvyTYjpsuObTeP1ovjKFKwExUcP3P/erGdAlkqRb5wyQ0JAT/vgD0gFHGiTUw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(39850400004)(376002)(136003)(396003)(451199015)(9686003)(8936002)(26005)(71200400001)(2906002)(41300700001)(5660300002)(38070700005)(66446008)(66556008)(64756008)(8676002)(4326008)(66946007)(19627235002)(66476007)(76116006)(316002)(110136005)(7696005)(55016003)(38100700002)(122000001)(86362001)(186003)(33656002)(478600001)(83380400001)(52536014)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wmSwajBrSP5V2hOq3P/aJyzhDoASek2jV+B7BgnRINCplVepfwY1F7Uz5aZz?=
 =?us-ascii?Q?z+vkBXXpmcxB78xul7MT+Pqe+Fp049vkIOPMksW8LjGbLWIMAQxmhWr1Uyl8?=
 =?us-ascii?Q?FMPbyS1hCzqVgaIuYB/UR0HZdqJSKAgd1rT1vExvZD8jssocex0nLmCgK3IA?=
 =?us-ascii?Q?SR18/FVNI1M+UTY4r+n8w72xL0w6xfsdSbeFvZ/DACjC4Olc/hx3EWcbDbvU?=
 =?us-ascii?Q?qxEG96JKF/in1GryfGubRL4eDKinyP+oSH1TvfURfRTjapnFaGQiS6bhcJOM?=
 =?us-ascii?Q?IuDfKtjG8ymemnq3bfWZ4b4tNXcnEiuaOSBh3JNOP8pp4kVGHqL+nE4hf2jc?=
 =?us-ascii?Q?0yyqfEZvhdU5gfr5kumuGJegEpKlgNFG0glUs8w7MvZfgPRl6HRNz4LY2lY/?=
 =?us-ascii?Q?9t2GZokMJ1ogi1FsC7IZ5LQ0fmPwxJHfxygD4Xesud/vP39v2GMkLBIp/3Wt?=
 =?us-ascii?Q?BL+aLJkaaOTzuFyB1VrG+Mqnk5EuxuWj/ynvvBMbK63R9EHTBRcvxmbqw9mv?=
 =?us-ascii?Q?XKs/O9+9jPOGSzL9PmDSxTlqimker96fp0ByAAccaRn+OSfe5Qwropckr7cX?=
 =?us-ascii?Q?tlrvv2GlPBD7YNvg4DO9B7sVbgzkF5enkNJw7qZFKV3HxI/l/NmXHgPYwaBg?=
 =?us-ascii?Q?qu9cFyluDeks9irsQ20nrTQedEgs4Dcxs6M+kanuVJQvBNBjNMgqwqiTKKHs?=
 =?us-ascii?Q?yiFf1pzoZDZVPF5Xzqi0vLCC99bz8h3mbWeX4yq1oXzBAvce1aCknNMwKyeN?=
 =?us-ascii?Q?WKvg3bY6gineuZgedbc5vTrZlzmG4ED33jL+zQD/4lc76a2j6KHD1idRacUU?=
 =?us-ascii?Q?kKnP4pnaC+bZX0f6GECMDBVRF8e+T4w8TwdX+JZ3VNtBwpkU/gXnB1lQZJVm?=
 =?us-ascii?Q?QeBagv974pvhlck+DljqjSHNIOUzmDXHdi39enW9mYdbVnjDDoEyyweSKHqG?=
 =?us-ascii?Q?nRwPeL64wbUBVYaz0PCkmJA/82W/RS73cuourbLh5qtTWbB/W/6HmDeqB92j?=
 =?us-ascii?Q?n06A6Id5e8EdEB/CrzK+FvJw4Qj8lOm17cjOqIxzt/ysWkop5KbHiKiHRR8J?=
 =?us-ascii?Q?yVLmEI5SFuwrW9ID9+773wJPhmBH+k1J2S2u5mulBe9FCUHQJUWK/Agi4Iph?=
 =?us-ascii?Q?9ZXWzJJvFEug//JrrWwzkaA8V+sgCgGv1kEd7U2LDj9YLWBuKItu3BjzuYTL?=
 =?us-ascii?Q?isVFY8BEeyAfoxPGt2Gz5nqkDVEehJ4p5kJGYjHqTg8vxiwbtykM51tTEc/4?=
 =?us-ascii?Q?q7MzCETB/m2U7GoI8wtCDlzPEl8FeMKw0/fi55ayFJN2MiLNSOjQcwwm9alM?=
 =?us-ascii?Q?imQ3/xCfc3kOrX7FGMKHEcqS6hpFaH6J/Je6l79dw5Sp5JYl7Hhoxycc/mwp?=
 =?us-ascii?Q?LkBAvrf43iWtYGXeQBIGtLEyqPuMGYbx7Rk1dY8bG1nGyDged4CBa/YG9PB3?=
 =?us-ascii?Q?FHvX7XGQx4COhXV49ZJObpX9/L4w0TikXM5sGQsTivzkjf8xoWOMGUmJgRdY?=
 =?us-ascii?Q?piqFQces7gWOGmmFwSI/WIJXdvC1G8MfDslnO/UgCJJp12UMboYGoXE4m++w?=
 =?us-ascii?Q?D/6UDtc2fVhZa5ZEtvA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8d5a09-3c66-421e-59bc-08daf759af17
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 00:36:18.7415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/5gHFX9OYDT8GanVGH8TRo9OKURHYvGCEXEgbzglTi1+BDN3jIa625aMMeTviXg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828
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
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello
> Sent: Monday, January 16, 2023 3:22 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH 1/3] drm/amd: Adjust legacy IP discovery for
> Picasso/Raven/Raven2
>
> The switch/case statement currently combines 10.0.0 and 10.0.1, but
> 10.0.1 is only used for Raven 2.  So split the two cases up to make this =
clearer.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index c03824d0311bd..0d950ae14b27c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1074,15 +1074,11 @@ static const char
> *amdgpu_ucode_legacy_naming(struct amdgpu_device *adev, int bl
>                       }
>                       break;
>               case IP_VERSION(10, 0, 0):
> +                     if (adev->apu_flags & AMD_APU_IS_PICASSO)
> +                             return "picasso";
> +                     return "raven";
>               case IP_VERSION(10, 0, 1):
> -                     if (adev->asic_type =3D=3D CHIP_RAVEN) {
> -                             if (adev->apu_flags & AMD_APU_IS_RAVEN2)
> -                                     return "raven2";
> -                             else if (adev->apu_flags &
> AMD_APU_IS_PICASSO)
> -                                     return "picasso";
> -                             return "raven";
> -                     }
> -                     break;
> +                     return "raven2";
>               case IP_VERSION(11, 0, 0):
>                       return "navi10";
>               case IP_VERSION(11, 0, 2):
> --
> 2.25.1

