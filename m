Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6DBC25B4F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 06:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB8A10E4F8;
	Fri, 10 May 2024 06:53:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zh5EVQlo";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F0810E515
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 06:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZB9c2UBdBxl0I93YL8cIwJgSxD2tEkOptJHumRQDG8uIxDs2qR3sG5WXZbsd2aBlJk3NNWsj6rtThjSAmGV+Xyu668ldd5PBjNtY00+mNkiPAlQYnhzKoJaB1t/1+oGMsiM7BcKeAtDrxmaRLfAN/Wx4oKHi9CMNAeJNejmSWch84C0f7LLOwYkHSi1p4kOviYfbnrhvCsDjBj744lJMcDtkkcfcnhP5bZ0hfMkDrJv+ZT5Jz9mGsWFv0NUFMJKjmiQVLoOofydPhjZufQGIgbzNdpK8l2lJoSqJA4HJXTgm/BJdTDTA3dPha8Y9Hicgt8JzmCCfpaPtoZPCtDr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2es43OdKWAzt5ENyh5u9zWQrP1LS8QvyphpfUUU/dk=;
 b=cjscTh4/O06T5GGeTweNcGi/REAL7jpW3yeLH3RJqTFXJ6Gs81/W4Le+MNYme8x8k+fc7ae384KwYjqr6qOcUwvtWIcdWILpNOTH1xwtfp3OKiAu4Z3xNY8sFThVjBm8RIWmG0xm8CmMj+OSBadUdW5Oz8jzyeCU4+Eu8FkYckkzkfyYItV4qs7j2NM34zfdXbVH1zJVzz2NP7kHnc91MmTRsEwQcCW3l9I+5wzPVGXC5m9lyZaRF21cgh3SWbl9wSD/Kw8TmWKbEBRAeGjA94FZu8nAn5IeNmduRwpZcENOdyR2IBNDV1q0KSM8eIcABjfoc6UfiCtYBWG7cj5arA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2es43OdKWAzt5ENyh5u9zWQrP1LS8QvyphpfUUU/dk=;
 b=Zh5EVQloeJFTi0rgdrL6Hs8GSfLLewigkgOownjxihJQCnMmQn4ft7BS35o4hz+XBi6W5NgGzsQEb9m8a1lVrESgY1JAaKPBlrNAb5vHFv9tuUzGYIx3gPoBrrkjNPtwJEj9v0mC56uKPdROYuPMXTXk628kEbI0KveI6CGqkqA=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 06:53:00 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b%5]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 06:53:00 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 09/22] drm/amd/pm: check specific index for smu13
Thread-Topic: [PATCH 09/22] drm/amd/pm: check specific index for smu13
Thread-Index: AQHaooUzu1AEknjy00ygtPC6apsG9LGQA/OAgAAD3UA=
Date: Fri, 10 May 2024 06:52:41 +0000
Message-ID: <DM4PR12MB5152EF4BC7D6DF4817EA723DE3E72@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-9-jesse.zhang@amd.com>
 <CH3PR12MB8074AEA25927E3722561012AF6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB8074AEA25927E3722561012AF6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3ef11ab5-5bdf-4aff-a49a-495d6fa6cdb3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T05:52:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA1PR12MB8468:EE_
x-ms-office365-filtering-correlation-id: 0f6947e8-6d1e-43fb-94f6-08dc70bdc9a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?isVeSJQ+IZzxeQ0mHwpNDUFfg9IvFNtvnBwiPQYuCktzYwWSFeyBDEy9OguA?=
 =?us-ascii?Q?CI3EV/Y1DBuXA/OD3+Gy8UCrnjK1UnT8UVssBZFmuO5heW3YDjnPtVqpyMgd?=
 =?us-ascii?Q?/6ISHzzJNY1+XoQ5bZJZgmsGMM1CIa+hbVmLwA1oLChCgh43BScxJOO42jDg?=
 =?us-ascii?Q?r2ZgVLGzGrD9Ld9ExRh2OcQm7G2kfa9DKC7Mxo3exjElX3SGT/0WLAn8waMT?=
 =?us-ascii?Q?xIa6Lc6OMTySgW+KzKSqRvOwDrKurB4qKp4SgcmnKq8L9iXz8UD5hLdZkaHY?=
 =?us-ascii?Q?DFnHU+0v6Pp/5iZA2xiLdkX9u+cam8tqMW/pDbQgOXNc2wLGKSePJyXEOwGp?=
 =?us-ascii?Q?VXBbSebmu+dhWkDD72+JdvzacPR2g66TFK4suiWLuYFbjz8VUcbR9tFI7SYn?=
 =?us-ascii?Q?XVHlOgw6towVvmvWmX52VzZBS8TfH36/35iBvd5ZpZj9vkZCM3klJ1WroJhO?=
 =?us-ascii?Q?drj/YZYJevNiqQoCbMOIXQLLlYpnpbPZcpiOfkBGYEehBFD2Qb45FGBOBmWU?=
 =?us-ascii?Q?AhI10o5jEa6P6IQ6aOpN1ybtyICTBZjhHtnX5suOovyMR4eTd1NSGV1axbZ3?=
 =?us-ascii?Q?0wSyXA9cgDT7faBYUNmfYFXWds9ldUvDaw5l6XmyzlwSGVkkpSwnROG4HVQF?=
 =?us-ascii?Q?cxHCcmzU2zqks5x7X/YkUUXauGD2KK8SsE+6TWq5fKHCMCEV432I6gyE/lCw?=
 =?us-ascii?Q?cDb8ACFUSsAa/O2uqHIq+320DybREzmfP2GOkvWMKpA+qTQPCTwdJhtsV1Dr?=
 =?us-ascii?Q?yxfyEBsGlu4XehVzOELoYzDMTxGSurXXBtJdSTQIGOc/ufot42WfE2w57YqQ?=
 =?us-ascii?Q?CD6QVD8cRR/IgD7qafWd23WgmRzl/anQOTYPjmw/i1tUQubulgh2GLGdfCmA?=
 =?us-ascii?Q?TKBL9cgtEtw12KAhrowzYo9fcn8FPqjOzFTMdcg/RKWegXBemN1RoANxCe1B?=
 =?us-ascii?Q?0YWyEEscd+VpL354qFALObfJKE+5EZnCPAWgQm0IeuCt8QADK5dDAr1K+uvn?=
 =?us-ascii?Q?xZ+dEl7t823JVPjEzNK9/LW/KTQXz3hXuNUXw0Zoo9PiT51rJuUmp54Rc5hX?=
 =?us-ascii?Q?8Jq8DhVtjngkbFJGYoPfSc0Qny5H5tdcLOr3iBIywbwIpLwlJVRNuYXdSX3h?=
 =?us-ascii?Q?HAwip7Kx3WsDo8OkcB38QtfO3OAjlog/i9/D4FIATMAk9/tyxEXOgZ8d4fR/?=
 =?us-ascii?Q?xXdO0vPZsff5AaSYs+k6HxZlsBg96NohIf3yvB4lVkHIJzjjMv9b5DHasQ8w?=
 =?us-ascii?Q?5df7DkbIU6PP2dFKiS+/o3sF7+7a/BhD/jgOfigerm5e6DUzREeTrNm2MTAo?=
 =?us-ascii?Q?9/OE0Jd8scddR6r/hG4LcaGx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x+dD3DulQcEIkXC0aMBLQ4jk8GLBdos36tTOgo0uKceEBpxgKwLQVVPYmCyI?=
 =?us-ascii?Q?kx9nskMGqR9V4Bw69ottcbo92g4V6Liy59Odl3ehwzn/kMrJ/Iibsfajdnr2?=
 =?us-ascii?Q?0yd35wPDChOrLSWutrvUV4DWUQJ54hIbdgPzTeOsV8RZuybG1EyfYeR2pRT/?=
 =?us-ascii?Q?HUxAnn8CYfK6lcgk6iaT40TaC4WYSeOMdl1cO0yd7AsKsR3+4D4PMlSfhinj?=
 =?us-ascii?Q?BaYe6kjUMecVJEZgJgGsiJmaJJdM4Aa9tje8XzBiubJVp9W1jAXr/Qo0fwbc?=
 =?us-ascii?Q?zjPix1jlpQ2hnnby+IDbSX9SZvvpTxc7Pg4tBHG1Z5E3LzDrFxW6+eIqpDfc?=
 =?us-ascii?Q?Hq5wHIk+IRXMr7Fy8VV2DXT02ubDgq+x37E/gsaJQP8brHzi8GCd68cZ0/g9?=
 =?us-ascii?Q?zrPAICtLR2hJfVS+gZVa97ITTc7sTy9yuNSr31Uc/ZQDUVuvqIipeJeu1ByX?=
 =?us-ascii?Q?lFYmcLEfB8brCxpM+pxK75HKpcQE4HFpYlh23flMfcCTMgFMDZLh/W/My2IU?=
 =?us-ascii?Q?XG2x0IrFNgycA7nptxIAZwnZ8n2EdOntR0rHuoNfpIa6OpIaIKCn5pakgOEO?=
 =?us-ascii?Q?BXUMCl5kIeROeNmvnMXfgBJ6yep7bmLdZdnmxi6LWfiJTTGBCjxQ1YPzoB6p?=
 =?us-ascii?Q?2QDZl7l6WI21mmC+8sma2bhn/ZIpTXBPRZNuCqu/2WEA6nvoBVeFx9JM2SG5?=
 =?us-ascii?Q?QIbJc2vPTBivjMKC4EkPfESeKBr5my1XUHAB5rIOAoZnNvqrgwMgF7L9dptz?=
 =?us-ascii?Q?LTgL9kodXgg/7XVOFNoK9J3jEnbmMlIv8nr3dTwsdePnL5HUUATzU3U1wztQ?=
 =?us-ascii?Q?JKCFdTmSDvEl4dQiA5Yifsm//K2WXJRDSn/qFFpaK4a5fmvzFK2BItb/paV6?=
 =?us-ascii?Q?QKw/hNatoczcjiwDx8G54qsxov6G5Icwn9aPO1NC36tdz0d7KZ467C97Lu+4?=
 =?us-ascii?Q?T4n3bVnuqEZJxqiVETB3W/ohDxHkw5Z2C0HO0GnJVi/YlUVdGfqVy54UWdUe?=
 =?us-ascii?Q?/QkyEDOGMlTLywFitVX+XsPQXJNQzf/a4GtFevRCcmktDGU01G+coX4htqrV?=
 =?us-ascii?Q?SEnyhLVzDkKztgikDXrosi+BTjDI5PoXEXodQx0ymWgG7dLzCjef4h90miJ/?=
 =?us-ascii?Q?u0pxJzLAX4ZFc2CtNfk551t/sJqWsbBY9fCXxRQ39PbirU+JBQ1uI5IhmY+D?=
 =?us-ascii?Q?WL0jnxCFeSaLxEyexuTmhKggSoJc4LrXVBEc3Xh90RuCoNm5QGynj2OFFRPZ?=
 =?us-ascii?Q?AvZZ5se1WX/00x7Z2ZAcP9UiAj4UCp7ptit9ajJgStrMbTVhBGG9q06n/T8S?=
 =?us-ascii?Q?Cmc/x+LI26lpHoyAuOxGiXvGeuCqhIjOaVFLXKJbMQXeJN8Kdr80WRPrUdDB?=
 =?us-ascii?Q?TO+baZ30G95HTIjRvhPig8aN9ANFYXyKuu8wxpKngWrOmYIOjMB7tG+MV3Tu?=
 =?us-ascii?Q?oQxxThtewpzKjRq3xh2TrIf6hndRrDTz7WemZqtuHgglXVK4lMx70IAVmpFk?=
 =?us-ascii?Q?gQPixE4RmUT1TrnMCZbEw+EkfNvghf8/qF3LAGrUA4f8fsUcmjiUGLETScfy?=
 =?us-ascii?Q?oaItEto7ywNUP6h3Rjw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6947e8-6d1e-43fb-94f6-08dc70bdc9a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 06:52:41.3901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9A/XoQJk8bFDC0191I/Q2N1hglwfK/fCr9DIjcxs2Ue7lbe1ieFqobDylcoaFMSu0XVo0pCphCLFhvNIsplNCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468
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

HI Tim

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Friday, May 10, 2024 2:37 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jess=
e(Jie) <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 09/22] drm/amd/pm: check specific index for smu13

[AMD Official Use Only - General]

Hi Jesse,

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jesse Zhang
> Sent: Friday, May 10, 2024 10:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 09/22] drm/amd/pm: check specific index for smu13
>
> Check for specific indexes that may be invalid values.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 051092f1b1b4..7c343dd12a7f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2336,6 +2336,8 @@ static int smu_v13_0_6_mode2_reset(struct
> smu_context *smu)
>
>       index =3D smu_cmn_to_asic_specific_index(smu,
> CMN2ASIC_MAPPING_MSG,
>
> SMU_MSG_GfxDeviceDriverReset);
> +     if (index < 0)
> +             ret =3D -EINVAL;

We should need to return the index here?
[Zhang, Jesse(Jie)] Thanks Tim. Yes, I will  another patch for it .

Tim

>
>       mutex_lock(&smu->message_lock);
>
> --
> 2.25.1


