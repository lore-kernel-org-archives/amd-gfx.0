Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6D9C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 01:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2828518A7A7;
	Fri, 22 Jul 2022 01:37:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E99D18B57E
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 01:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4ccPLGDoaBChFRTj8BvwLJU6Ww0qxkrTMQnr0EOIY/50dxhXW1/RGOa2u6dSO9ntNlUVVq9ETc1FC+PKZHvm5qIvFpB3+g61rzPH9QXqPLUU8V+dqCbdCxNrTXxsQWByTCZiDG84udj9QbrM2dnsO0G7600kOUUKPOVOHjqZZB+4SktQeMibTuiHr+VDUdWXY1/wWhDNnIf4deBHFyz4aDi2zEkHXygDSugQzfTMyzuj6kNpnOG5kwhHllZyrgHoY19v6xPhOjF0qa+P0IqKQ67Nr6tyLrCZ9baFHqQtxHfESooJEQJ16r6o8eYJNKZuoMuZbfrvUHq8X0/WiLiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDMJFIn3APuB9BUTGV9RLhCkCHw4jZQjXdAQFIIiyHY=;
 b=Rgcgyunt7IGpqXDHTzJEz1DgXTpLA7VGU/Ryc/RhbVD44fMTno5MHfbgTrd9KPnjDd3ZmB3gxm/kV5wby/+fox2lowesKo2eg1JnVRA5Hy+nBbHGK/SnnzEulc76xzXeTqxgxqh8I8MFcho0MjKxgK6HJPP5Ki2E6VeiY4L5FXzTdfAUlfBCOivND6C9HdsQuGvkkxvC8N/fCLA01dVu2lOEPimPHeB5TjdSX+IhUvYYipcOpnw4A8bgL15r7mE6ede/rT25jkIgbFg4RCPbe62jpapyE7rKvYqNVfgwZvJ0kLGtBBL4+PWVgnN9WLaMAYRS/mwlI7Sh3AoJd5ex7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDMJFIn3APuB9BUTGV9RLhCkCHw4jZQjXdAQFIIiyHY=;
 b=Qe8yPHYVtfHnxh31vigHWfwzvccOiNVO4m0Ie7h8IThjuWEYHV71rsSaB5eUSe2BYdy34t5LELMYdqP7mXwFbsLNvvFFSaG6icJfv9SWoqEsSLCJqTDc2by8hOAX67PgInnAi5DEwAke0b7UMBCP57QEizq2MKpGBpw8hpQP+sw=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by CH0PR12MB5154.namprd12.prod.outlook.com (2603:10b6:610:b9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 01:37:52 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::ccfc:c945:4212:711]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::ccfc:c945:4212:711%7]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 01:37:51 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Guo, Shikai" <Shikai.Guo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Add get_gfx_off_status interface
Thread-Topic: [PATCH] drm/amd/pm: Add get_gfx_off_status interface
Thread-Index: AQHYnN/8A9Bbk2w0P0KS2u/Y3hhPjq2JmVfg
Date: Fri, 22 Jul 2022 01:37:51 +0000
Message-ID: <BL1PR12MB5237A4AA3008DBC9460E9506F0909@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20220721085738.2528792-1-shikai.guo@amd.com>
In-Reply-To: <20220721085738.2528792-1-shikai.guo@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-22T01:31:23Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=edda8f85-b8a3-47a6-b494-2acd29e30479;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-22T01:37:46Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 80c34151-1e17-4edc-8c94-9bb476b2e5e8
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67b793ba-75f6-481a-4249-08da6b82cab0
x-ms-traffictypediagnostic: CH0PR12MB5154:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6KFQc3PkvG0kROLETd5vYFakr0CprmbCgOQ/VeLmzH5g/o8soBDG7jylOLsbwZI4Llo6CRjXWGls5mt0QASnEFiL1R2YEDdloTILEsgn93iR9LXygyR2cikWp132tKfLMKkWQHWwb9IHO0yOwUZM7rSw5usosc1t8tBnZxmRTOw/lhxgJ8Jc392Nmxg6pNQAYgwnr5ScC9TkRQHy9qg6AuHixTEVRCP+rkrS9BXoMdZwSAlFVIRMF13Um6VxDVtLeRWXE+mgUUD2/ynUEnBanFKrf4151Vzkuf8r8a46sdG0TU+5GLP5pqxgcu5jH8zwPWVDlXT0mMRGvDYcenBKMNusNx0ENJ/jrpm52d9PrmZ/U2tq5JSgbyxQCqhk/TlZANlgjDj2ojk+8lDNGrN8/kQ9t5Ixx45XuQIcAf6uwqXLHUjztH5mosvjYZ33AsbUYENY/FNsU5FKpf771VU/2pLYNGzyVRBbXOQfpSdATI86dGg+WDeM+f0BZskp7j79XbW4pNb++NyK237VbQewDTXDXUpBxZEP+fuzsSNza4oayJwiEhqzVE4xMT2Lcmrcftjrki5WNyrmPJBppRrUQv+jV+SE8UJ03fiG86a8my4L1/PKFWs2ke5OMDhzA/H/h/PnHJQfmVUYH0fx4kwY5RHXsGSn0BbHnsX0gw/bdXU9fkZBwUh6evC49S5Geb5t7eHfUv+QUECk0Zxa5aE57SThKBkrKMq0P4mPvinj0I+FJqXoNFmAXYgjSszne76TibGSXONIQAoXtIgrK3Ri7Iyj8fxA+xjzQSoyQu911rUfuB+zrTtLkpe9HkZIEApm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(86362001)(38070700005)(38100700002)(122000001)(33656002)(186003)(6506007)(83380400001)(7696005)(478600001)(71200400001)(41300700001)(2906002)(26005)(55016003)(53546011)(54906003)(110136005)(9686003)(316002)(66946007)(76116006)(8936002)(66556008)(4326008)(66446008)(8676002)(66476007)(5660300002)(52536014)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0HNvdpxZAdQ/i885yvnKn6R3Mic9dRQo71vWczIH0HXj1wjdWT80QwaJdD1O?=
 =?us-ascii?Q?hpe3gqN4f84Ry84Jfczksg4tP6uujWX8KkGHQ2HPZPxm9xe6K+tOtTvIRQTq?=
 =?us-ascii?Q?SRGrBOPTymo5YEvDFeHXGAfpzPurpbo3mzyD0FDUOIbsnS4RQTvJK8/TSG6f?=
 =?us-ascii?Q?G6HoNhOPi4w36kDQ03sVEvYNQecn9NTSpQK5x7P4d3KvJgCrXeTziU8FYFJI?=
 =?us-ascii?Q?9kFRpo7EXlbjhVrEIfbJUYHtjkcpBmRCTbWhNbbtNDOBgRhAm1y3oHwKwQdg?=
 =?us-ascii?Q?vHIikEHDEt6DFAyb5cvtdaQPRRyaFVmT/JPHIBZ0ZZBgmschtM6nkQ+zd5SV?=
 =?us-ascii?Q?Fdn8UOu0OYW0X1gmPIT4ahEljnYChKAtxebgDlhj6e9sldx17ty3ZS3Y04kI?=
 =?us-ascii?Q?yRAT0stpe2wq+96Ishwge7bPfUjFp8vn9B6A1jQvTrbCLq9vy9A1mTElu6z1?=
 =?us-ascii?Q?LEiKha4gNJV6eKHQcdI1nkOXeYoWITZzJuswtJ7O0qq3NUVKhz9yN82q3+MA?=
 =?us-ascii?Q?EyhD7l4rt0r/6JjUEyLpu3l/JGyy6RFRhHs9znvhlIcP0RD5jprcWGHidRYO?=
 =?us-ascii?Q?eYLqK5CKIXRzpqncE90HHaR9gPJQ9ho2FTaO+BS1fI8Uc21316xKj2wIwUru?=
 =?us-ascii?Q?51urEayN9ga7RLn/xgrv4dU0kCXovWu1SkQuxQ+n5Sa/4f+sf9Yyf22fj2jU?=
 =?us-ascii?Q?K1GWIPr8oPeYxSHq2PZhnYLC1yZV/nWoFtkIDhjcGAL92Ue7/ApkIctXWQcd?=
 =?us-ascii?Q?Y5mpC2wNi2Mp5xtmnFmtsDJ7tvbHBFDUB9ZqXK+b6l1Yjgx4G60lv/U+9TaP?=
 =?us-ascii?Q?kDosBSTE1CfDylhTOXX3R19qNlqjq00eziGIfnPhIAFZFuf2w5/V6YFwl7K6?=
 =?us-ascii?Q?+5lD/UlciMNZmX0JmAs/dKDCPnUm3h7tjLWTa5jaiPcQGJeZjx5QmmjIy4XE?=
 =?us-ascii?Q?UPjfo7aOGB52BLx4zRCkGrNf8/dhQHz92YY/JjZqZbtLaDd6YZyx7rinVmGm?=
 =?us-ascii?Q?fQTTfF7TJSSy0wBUO4yWY41eFoMO3rEB1Ue0ZSiCvRnccvc/6NS65JcF1YDg?=
 =?us-ascii?Q?0767yPoCyBD4qne5HeWcMbOzdYkIHpYUkEZQULYp3h/negoMwv7lWW/XZ/nA?=
 =?us-ascii?Q?GCisN+m4lY2Zrxf2KYr+v4+shrCJNqi+DMcie8jHgwAWO3BgU4wG7EQQCCIP?=
 =?us-ascii?Q?ntIRrDpJ+YH02Prd0fDy2Ce8Kt9nCmY/gMKdBs5tyoXo/iEUNqYUpzOBOuTS?=
 =?us-ascii?Q?qZxyo2k58RZp5a33NjhvkhpL88+/aCGYVGhWccN7r1SY8AMvdsunncmNeQBR?=
 =?us-ascii?Q?Jhue+84dUqo86lAS8M3hh51PmQKSAAkJ4Pkp5SYkbNlntz/8reuQ/HgWgHRG?=
 =?us-ascii?Q?NUq2lVXVRiPbk/9qZjLTkIkILnkgHdw5BVixUW0hNlbBmEIzt/5Og4q7tQlD?=
 =?us-ascii?Q?bR/Qhw/xOKaojKQo8pJmSwQP2jf2VUKlwUhHjRx+jqE6rNhakQOG1i1JhjGN?=
 =?us-ascii?Q?405sJvh0rqQiWzQGHMHDCnPLyx29p8hZZnZNee9JVMmYoBKd+LrqbGSUcODD?=
 =?us-ascii?Q?1ksZx95Y80oVVsIJoDE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b793ba-75f6-481a-4249-08da6b82cab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 01:37:51.6347 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZYTXWpu7Qx0NbSmclqvIHskfjpNHNEjL8ha1GhK9dezMcYxNtLnbNWiZfd+LLma
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5154
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Guo,
 Shikai" <Shikai.Guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Shikai,

Yellow carp's SMUIO is 13_0_1.=20
#define regSMUIO_GFX_MISC_CNTL                                             =
                             0x00c5

This register in your patch is from smuio_13_0_2_offset.h and this register=
's value is different to 13_0_1.
#define regSMUIO_GFX_MISC_CNTL                                             =
                             0x00d1


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> shikai.guo@amd.com
> Sent: Thursday, July 21, 2022 4:58 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Guo, Shikai
> <Shikai.Guo@amd.com>
> Subject: [PATCH] drm/amd/pm: Add get_gfx_off_status interface
>=20
> From: Shikai Guo <Shikai.Guo@amd.com>
>=20
> add get_gfx_off_status interface to yellow_carp_ppt_funcs structure.
>=20
> Signed-off-by: Shikai Guo <shikai.guo@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 30
> +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index 70cbc46341a3..2e39b629e7e6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -31,6 +31,7 @@
>  #include "smu_v13_0_1_ppsmc.h"
>  #include "smu_v13_0_1_pmfw.h"
>  #include "smu_cmn.h"
> +#include "asic_reg/smuio/smuio_13_0_2_offset.h"
>=20
>  /*
>   * DO NOT use these for err/warn/info/debug messages.
> @@ -42,6 +43,9 @@
>  #undef pr_info
>  #undef pr_debug
>=20
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK
> 	0x00000006L
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT
> 		0x1
> +
>  #define FEATURE_MASK(feature) (1ULL << feature)  #define
> SMC_DPM_FEATURE ( \
>  	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \ @@ -587,6 +591,31
> @@ static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
>  	return sizeof(struct gpu_metrics_v2_1);  }
>=20
> +/**
> + * yellow_carp_get_gfxoff_status - get gfxoff status
> + *
> + * @smu: smu_context pointer
> + *
> + * This function will be used to get gfxoff status
> + *
> + * Returns 0=3DGFXOFF(default).
> + * Returns 1=3DTransition out of GFX State.
> + * Returns 2=3DNot in GFXOFF.
> + * Returns 3=3DTransition into GFXOFF.
> + */
> +static uint32_t yellow_carp_get_gfxoff_status(struct smu_context *smu)
> +{
> +	uint32_t reg;
> +	uint32_t gfxOff_Status =3D 0;
> +	struct amdgpu_device *adev =3D smu->adev;
> +
> +	reg =3D RREG32_SOC15(SMUIO, 0, regSMUIO_GFX_MISC_CNTL);
> +	gfxOff_Status =3D (reg &
> SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK)
> +		>> SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT;
> +
> +	return gfxOff_Status;
> +}
> +
>  static int yellow_carp_set_default_dpm_tables(struct smu_context *smu)  =
{
>  	struct smu_table_context *smu_table =3D &smu->smu_table; @@ -
> 1186,6 +1215,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs
> =3D {
>  	.get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
>  	.set_driver_table_location =3D smu_v13_0_set_driver_table_location,
>  	.gfx_off_control =3D smu_v13_0_gfx_off_control,
> +	.get_gfx_off_status =3D yellow_carp_get_gfxoff_status,
>  	.post_init =3D yellow_carp_post_smu_init,
>  	.mode2_reset =3D yellow_carp_mode2_reset,
>  	.get_dpm_ultimate_freq =3D yellow_carp_get_dpm_ultimate_freq,
> --
> 2.25.1
