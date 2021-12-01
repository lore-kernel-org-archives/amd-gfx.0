Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D641FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 02:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4427C6E20E;
	Wed,  1 Dec 2021 02:06:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93EB96E20E
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 02:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJW80/LV+Q9q6mzg3IexQOi8Wuj1jXV0Jr/g2lW+QC7pflgma06D+I/XTZTXyob1Y7eWy4bJSU1wXDwnVCOqu05RCWXEBGjeRdqqrISrWT6zsXcobdsUY+a7AX/URZMQjvbc7sbSPol56FIs8vkNkcpPZGbNQSCzwUI43LQ0SJoSnYtdjHkwXOfe0z9+cc00ITyfxvRr2EcW/KvebgAff30VNoqcNHiqkF8m/FrXj+EQiFSsHpimhno0dZ8EOePWtlPLWurcC2PuKIDSzmYj+oFqwQeq+Mq058y8V1Q5yX9M8g6eGHl249G5cMmCyhS5BDrCGLXMfgx4zfUJ2amxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcL/BBFFmf7vPpy58N9rLywSmFBjkKbUQcpX6VoDv4M=;
 b=I/j5tPQjnL/0QofWnQk9d/pC0O8vrS9ePDrhYFi0LwsjXDNNHs0o3ha3uFC+WclVrBvtUdX3KJ/11DXrPCfCf35w4IvJvyqRaTImHdtV5gcRx7nnnm/MC5wKXaLuGJyvwq8JosxQy1bvCYV1B603i7qZLm6I7LSCO1E/QXkZ84jwRgc0ha0e4zd8nxQ1JZE25d0x8twELEnNGwMFsgni9ctO2e0N3iKWJlU/ws1YzpbuMwFrhy4paK1/tKh0zvzp63ZxIBOOIzW7VguHqfqfQLl0jhpfDkmEdbSSwuco2VCMJatgGA64ui5G3ftI8SpzjZjZLJoEkIYVMDbfL1Ltlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcL/BBFFmf7vPpy58N9rLywSmFBjkKbUQcpX6VoDv4M=;
 b=2CQ7QvWpoLx+sMweNSvlRF4+BafNhaeZiIrgNvQPt98SJO+/8rYnYLg2k0DDFuV1oY0c0++pc4topfkcmu2w8UQExTMVvhC/L2/QscNv9lpDwTPeJbzRxrrA1JmThem6eJmovM33u5zPAIonTkP/pwSQBLl0lYwfi9WAChYEPWA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Wed, 1 Dec 2021 02:06:25 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4755.011; Wed, 1 Dec 2021
 02:06:25 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 02/17] drm/amd/pm: do not expose power implementation
 details to amdgpu_pm.c
Thread-Topic: [PATCH V2 02/17] drm/amd/pm: do not expose power implementation
 details to amdgpu_pm.c
Thread-Index: AQHX5b335IRYawD0YUmlickNUy7fQqwcCiwAgADY4OA=
Date: Wed, 1 Dec 2021 02:06:25 +0000
Message-ID: <DM6PR12MB26192D10C54DA15C24CADB07E4689@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211130074259.1271965-1-evan.quan@amd.com>
 <20211130074259.1271965-3-evan.quan@amd.com>
 <DM5PR12MB246917F74F37815313C6981FF1679@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB246917F74F37815313C6981FF1679@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-01T02:06:21Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=fd6a81a2-2259-43ce-9120-c791c99b37f1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53b41523-3234-4d22-6c71-08d9b46f2df0
x-ms-traffictypediagnostic: DM6PR12MB3179:
x-microsoft-antispam-prvs: <DM6PR12MB3179C64F53FD04001B77B910E4689@DM6PR12MB3179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nxUSlBYKUXUzKWsglJXiUnROox93ZR0RVAcISKOjWGn8MedsNasBxyYyTMdkF9kulJVB6BmkfcQ+1WZaIb8rBpZDTGF01JkJ439xO5+NJi9uEVZAvRd6yld+mhZ892WlHr9jt5nluTcU+0zk9y1ktodrzkSY/2ozqsgmM67JGfxU1LNbEb2gdvRIVGxOjtXYmnNntOlEtj58SDulsfzldsKVl279T9nerg3/blKbUuBYgmfit3EEKWq+Sk1RFcAZ4rTbQlzt+FI9uqtKqgJgDHPMsdmtLyPYwWAtIpztPWuSts5hXAgnWpPuDgg6ZARDXtoRSpwhk/RE+wVZIMkNf9PzkD+VuEqptbC7Vequp4wwc42z8xhHm6dq8lo5PiW+Rr4nz/qAm6QBhHlfXSE2k6kJfq/AMsIqJ0R34sgdtr/j3tnWnJBOCI+9l+LKaM7uDduCiNkUJ2GM8VzW9X1P8a78/9uwo8xuQEd7QctI6F/C6vT8UMIaUZ0VjNAWHwObPb5Gf3+lpl27L3oLI1ptad/BNrRs4kKVpCKrr0alyLmc0BVXyoEBBNm1D8BaJknp5JGAU5qJ50rjDva30lOp71xQGAepRPUuqJgiBsYqbVx4xMibae80OekDNGxu7w5Xohb2u2/rO2DRbu3OMe8v2CVUUb6DBsDtFOH33+MVoiKHX1Ui6P51TRYXEcP0y5Wwz7I1bWDUFitMLyKKFkK4mQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(2906002)(38070700005)(52536014)(66946007)(64756008)(8676002)(186003)(66446008)(7696005)(54906003)(30864003)(83380400001)(26005)(55016003)(4326008)(316002)(66476007)(66556008)(38100700002)(508600001)(6506007)(5660300002)(86362001)(53546011)(33656002)(71200400001)(76116006)(122000001)(8936002)(110136005)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q1z+W4XdmHaea1BSJ6HS35Gs4MFo7XEmw2URhZwbpb6G0yIlD6gMuwS9YIEP?=
 =?us-ascii?Q?rUWMGyBS5JlgamfiDZmMEiDpy8ZI8A+X5R+DI56tJcM3mUujrWElXoycRTPR?=
 =?us-ascii?Q?Oaj2ysN5lk7Jmv/LnbRlx33nPXCWgkvfCh1RPmICqevLUvkB4mINF9wAj1RV?=
 =?us-ascii?Q?EaybpDzhVwBPD16s39WRIiLOkGYgiyuWUAmLPwY6NVmYuVMtLCcLXe6oqgYN?=
 =?us-ascii?Q?14dBx3A0ngHlvuksu7lRmXPvxh1dk4F2u8Q24YE17LL0u5PiOxbLjRma19wo?=
 =?us-ascii?Q?kXlZERFWXH+ygiiyUu7mbePGTXuBW5sLPugsl2Qf9PvfHdYmb8BEhH/lLJRY?=
 =?us-ascii?Q?PQCCUl4lO7idtZZsL/VvwlApaYHFx3m28VmhSYj48tMblvwaQdyBMXuu6IzZ?=
 =?us-ascii?Q?+LhRMKS2UVI1DuO7TTAR4AWUhp//QZA8O6z96mbbLR5nRggNb+ZZkjZw/DfV?=
 =?us-ascii?Q?E8soQaojfydCDfD6L/FqMI4b/xLezTfJZa7PFLSI8Tm6VXLdWHamzQR26ajW?=
 =?us-ascii?Q?sSAyDq9JFyn1tTlgvFLh+PC6ehMOgxwky6SfWQufk8M9p21URD/n27dGis3n?=
 =?us-ascii?Q?btlJwUOGe1BsK6l6IDe2kvOfuwx+qjDsQdhuEDC/U/QOGBXXTRpxyCphM4Dn?=
 =?us-ascii?Q?ickAdaD+bfQsuMgkkhYktZ9Y/MFIFtZBsRorBSAbxoRVc9+NSQ9mx37T1qgD?=
 =?us-ascii?Q?7a+0abu5l3q+XLPBjxJgjJ7Ye41CLO5ulvSwkROg+B3MII7nOgSAUdTBGswa?=
 =?us-ascii?Q?yE1ZnQQysWtfSY0WW9WJRGMOYebrWlr7gPdg8JYaxcMojnUwVgfLOYmEIEj8?=
 =?us-ascii?Q?zD68M9XY8mS7/AgMHIdfhAw6Cu9Cc1F8xgo4EvWbAntAyGYVY6RCByeZBt8L?=
 =?us-ascii?Q?wuJ3O2lJXzrFXQpeZfvOYmmdZF5bEGlaW24s7ZwDrJ4ccmOwJegyHd0Nc5oF?=
 =?us-ascii?Q?mynQ7CjeMQfbqF36ZPJiMDt9m5bJuQ6meEBVhcj7B9XjKinN/elyRQtnOMEq?=
 =?us-ascii?Q?1LM2aI+aBHRqOu4UIC4fy0ZA97rJEY4juzWiPMLV1K4dusXiH3B9+hbRthlq?=
 =?us-ascii?Q?NAuyxm6Vmx4pgzJL1pA5wPPd3UVTqKhioyEf2T8jB1K4pevGdvnTRUbP+Okj?=
 =?us-ascii?Q?GH8RbzRyXZqzwS0ZqkQlgYNGQyIBkPZraU6Si3/1ru2q4Pe/1fOiQV79o9D4?=
 =?us-ascii?Q?IzVQ19kXT60FuS3jiPHxDW//5OC1b/4AQNZRjVjinb+QiSqYytJis1qG/CVF?=
 =?us-ascii?Q?QYRuwpu7TCxbt/JqmF1TeVWgCdDOKUpWukCjXXQ20aUO3ob+TAHyxf8mflEY?=
 =?us-ascii?Q?dVVZBywdL2mQ3tuWQbQjXfVj2XT+c500LAA+nIc7ZFcKDaDYNJJ+PPpCTtlA?=
 =?us-ascii?Q?dRm6+QsOKTekYHLI4w8KUFvIHrjuNYGNe7g+blh1LR79uO+AZ7ogxT0/UVG1?=
 =?us-ascii?Q?RM/ebimt1GTy+gcoQBUrjeXbeFddikNfZtIQ+qkw1ttY4am1ah5lORnMG6rX?=
 =?us-ascii?Q?XlxO1lZYxJ9IFzPF3emfpZzXFEV1WGLmCslAGTBbFSiAqEFycFOY20a8dDfR?=
 =?us-ascii?Q?HRGrcCW8PwCMSCtLMLg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b41523-3234-4d22-6c71-08d9b46f2df0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 02:06:25.1768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmVfrz+P+f0iIKIfSmjppnoNAbcENyozCGWpeA4w66+0YwQPgaX1b8BCSidoptIS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Tuesday, November 30, 2021 9:05 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Koenig,
> Christian <Christian.Koenig@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: RE: [PATCH V2 02/17] drm/amd/pm: do not expose power
> implementation details to amdgpu_pm.c
>=20
> [Public]
>=20
> Two nit-picks.
>=20
> 1. It's better to drop "return" in amdgpu_dpm_get_current_power_state.
[Quan, Evan] I can do that.
>=20
> 2. In some functions, when function pointer is NULL, sometimes it returns=
 0,
> while in other cases, it returns -EOPNOTSUPP. Is there any cause for this=
?
[Quan, Evan] It is to stick with original logic. We might update them later=
(by new patches).
For this patch series, I would like to maintain minimum changes(avoid real =
logic change).

Thanks
Evan
>=20
> Regards,
> Guchun
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan
> Quan
> Sent: Tuesday, November 30, 2021 3:43 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Koenig,
> Christian <Christian.Koenig@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH V2 02/17] drm/amd/pm: do not expose power
> implementation details to amdgpu_pm.c
>=20
> amdgpu_pm.c holds all the user sysfs/hwmon interfaces. It's another
> client of our power APIs. It's not proper to spike into power
> implementation details there.
>=20
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I397853ddb13eacfce841366de2a623535422df9a
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 458 ++++++++++++++++++-
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 519 ++++++++--------------
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h   | 160 +++----
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |   3 -
>  4 files changed, 709 insertions(+), 431 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 9b332c8a0079..3c59f16c7a6f 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1453,7 +1453,9 @@ static void
> amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>  	if (equal)
>  		return;
>=20
> -	amdgpu_dpm_set_power_state(adev);
> +	if (adev->powerplay.pp_funcs->set_power_state)
> +		adev->powerplay.pp_funcs->set_power_state(adev-
> >powerplay.pp_handle);
> +
>  	amdgpu_dpm_post_set_power_state(adev);
>=20
>  	adev->pm.dpm.current_active_crtcs =3D adev-
> >pm.dpm.new_active_crtcs;
> @@ -1709,3 +1711,457 @@ int amdgpu_dpm_get_ecc_info(struct
> amdgpu_device *adev,
>=20
>  	return smu_get_ecc_info(&adev->smu, umc_ecc);
>  }
> +
> +struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct
> amdgpu_device *adev,
> +						     uint32_t idx)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_vce_clock_state)
> +		return NULL;
> +
> +	return pp_funcs->get_vce_clock_state(adev->powerplay.pp_handle,
> +					     idx);
> +}
> +
> +void amdgpu_dpm_get_current_power_state(struct amdgpu_device
> *adev,
> +					enum amd_pm_state_type *state)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_current_power_state) {
> +		*state =3D adev->pm.dpm.user_state;
> +		return;
> +	}
> +
> +	*state =3D pp_funcs->get_current_power_state(adev-
> >powerplay.pp_handle);
> +	if (*state < POWER_STATE_TYPE_DEFAULT ||
> +	    *state > POWER_STATE_TYPE_INTERNAL_3DPERF)
> +		*state =3D adev->pm.dpm.user_state;
> +
> +	return;
> +}
> +
> +void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
> +				enum amd_pm_state_type state)
> +{
> +	adev->pm.dpm.user_state =3D state;
> +
> +	if (adev->powerplay.pp_funcs->dispatch_tasks)
> +		amdgpu_dpm_dispatch_task(adev,
> AMD_PP_TASK_ENABLE_USER_STATE, &state);
> +	else
> +		amdgpu_pm_compute_clocks(adev);
> +}
> +
> +enum amd_dpm_forced_level
> amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +	enum amd_dpm_forced_level level;
> +
> +	if (pp_funcs->get_performance_level)
> +		level =3D pp_funcs->get_performance_level(adev-
> >powerplay.pp_handle);
> +	else
> +		level =3D adev->pm.dpm.forced_level;
> +
> +	return level;
> +}
> +
> +int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
> +				       enum amd_dpm_forced_level level)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (pp_funcs->force_performance_level) {
> +		if (adev->pm.dpm.thermal_active)
> +			return -EINVAL;
> +
> +		if (pp_funcs->force_performance_level(adev-
> >powerplay.pp_handle,
> +						      level))
> +			return -EINVAL;
> +	}
> +
> +	adev->pm.dpm.forced_level =3D level;
> +
> +	return 0;
> +}
> +
> +int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
> +				 struct pp_states_info *states)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_pp_num_states)
> +		return -EOPNOTSUPP;
> +
> +	return pp_funcs->get_pp_num_states(adev->powerplay.pp_handle,
> states);
> +}
> +
> +int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
> +			      enum amd_pp_task task_id,
> +			      enum amd_pm_state_type *user_state)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->dispatch_tasks)
> +		return -EOPNOTSUPP;
> +
> +	return pp_funcs->dispatch_tasks(adev->powerplay.pp_handle,
> task_id, user_state);
> +}
> +
> +int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_pp_table)
> +		return 0;
> +
> +	return pp_funcs->get_pp_table(adev->powerplay.pp_handle, table);
> +}
> +
> +int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
> +				      uint32_t type,
> +				      long *input,
> +				      uint32_t size)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_fine_grain_clk_vol)
> +		return 0;
> +
> +	return pp_funcs->set_fine_grain_clk_vol(adev-
> >powerplay.pp_handle,
> +						type,
> +						input,
> +						size);
> +}
> +
> +int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
> +				  uint32_t type,
> +				  long *input,
> +				  uint32_t size)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->odn_edit_dpm_table)
> +		return 0;
> +
> +	return pp_funcs->odn_edit_dpm_table(adev-
> >powerplay.pp_handle,
> +					    type,
> +					    input,
> +					    size);
> +}
> +
> +int amdgpu_dpm_print_clock_levels(struct amdgpu_device *adev,
> +				  enum pp_clock_type type,
> +				  char *buf)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->print_clock_levels)
> +		return 0;
> +
> +	return pp_funcs->print_clock_levels(adev->powerplay.pp_handle,
> +					    type,
> +					    buf);
> +}
> +
> +int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
> +				    uint64_t ppfeature_masks)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_ppfeature_status)
> +		return 0;
> +
> +	return pp_funcs->set_ppfeature_status(adev-
> >powerplay.pp_handle,
> +					      ppfeature_masks);
> +}
> +
> +int amdgpu_dpm_get_ppfeature_status(struct amdgpu_device *adev,
> char *buf)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_ppfeature_status)
> +		return 0;
> +
> +	return pp_funcs->get_ppfeature_status(adev-
> >powerplay.pp_handle,
> +					      buf);
> +}
> +
> +int amdgpu_dpm_force_clock_level(struct amdgpu_device *adev,
> +				 enum pp_clock_type type,
> +				 uint32_t mask)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->force_clock_level)
> +		return 0;
> +
> +	return pp_funcs->force_clock_level(adev->powerplay.pp_handle,
> +					   type,
> +					   mask);
> +}
> +
> +int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_sclk_od)
> +		return 0;
> +
> +	return pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
> +}
> +
> +int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_sclk_od)
> +		return -EOPNOTSUPP;
> +
> +	pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
> +
> +	if (amdgpu_dpm_dispatch_task(adev,
> +				     AMD_PP_TASK_READJUST_POWER_STATE,
> +				     NULL) =3D=3D -EOPNOTSUPP) {
> +		adev->pm.dpm.current_ps =3D adev->pm.dpm.boot_ps;
> +		amdgpu_pm_compute_clocks(adev);
> +	}
> +
> +	return 0;
> +}
> +
> +int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_mclk_od)
> +		return 0;
> +
> +	return pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
> +}
> +
> +int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t
> value)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_mclk_od)
> +		return -EOPNOTSUPP;
> +
> +	pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
> +
> +	if (amdgpu_dpm_dispatch_task(adev,
> +				     AMD_PP_TASK_READJUST_POWER_STATE,
> +				     NULL) =3D=3D -EOPNOTSUPP) {
> +		adev->pm.dpm.current_ps =3D adev->pm.dpm.boot_ps;
> +		amdgpu_pm_compute_clocks(adev);
> +	}
> +
> +	return 0;
> +}
> +
> +int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
> +				      char *buf)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_power_profile_mode)
> +		return -EOPNOTSUPP;
> +
> +	return pp_funcs->get_power_profile_mode(adev-
> >powerplay.pp_handle,
> +						buf);
> +}
> +
> +int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
> +				      long *input, uint32_t size)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_power_profile_mode)
> +		return 0;
> +
> +	return pp_funcs->set_power_profile_mode(adev-
> >powerplay.pp_handle,
> +						input,
> +						size);
> +}
> +
> +int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void
> **table)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_gpu_metrics)
> +		return 0;
> +
> +	return pp_funcs->get_gpu_metrics(adev->powerplay.pp_handle,
> table);
> +}
> +
> +int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
> +				    uint32_t *fan_mode)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_fan_control_mode)
> +		return -EOPNOTSUPP;
> +
> +	*fan_mode =3D pp_funcs->get_fan_control_mode(adev-
> >powerplay.pp_handle);
> +
> +	return 0;
> +}
> +
> +int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
> +				 uint32_t speed)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_fan_speed_pwm)
> +		return -EINVAL;
> +
> +	return pp_funcs->set_fan_speed_pwm(adev-
> >powerplay.pp_handle, speed);
> +}
> +
> +int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_device *adev,
> +				 uint32_t *speed)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_fan_speed_pwm)
> +		return -EINVAL;
> +
> +	return pp_funcs->get_fan_speed_pwm(adev-
> >powerplay.pp_handle, speed);
> +}
> +
> +int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_device *adev,
> +				 uint32_t *speed)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_fan_speed_rpm)
> +		return -EINVAL;
> +
> +	return pp_funcs->get_fan_speed_rpm(adev->powerplay.pp_handle,
> speed);
> +}
> +
> +int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_device *adev,
> +				 uint32_t speed)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_fan_speed_rpm)
> +		return -EINVAL;
> +
> +	return pp_funcs->set_fan_speed_rpm(adev->powerplay.pp_handle,
> speed);
> +}
> +
> +int amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
> +				    uint32_t mode)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_fan_control_mode)
> +		return -EOPNOTSUPP;
> +
> +	pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
> mode);
> +
> +	return 0;
> +}
> +
> +int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
> +			       uint32_t *limit,
> +			       enum pp_power_limit_level pp_limit_level,
> +			       enum pp_power_type power_type)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_power_limit)
> +		return -ENODATA;
> +
> +	return pp_funcs->get_power_limit(adev->powerplay.pp_handle,
> +					 limit,
> +					 pp_limit_level,
> +					 power_type);
> +}
> +
> +int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
> +			       uint32_t limit)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_power_limit)
> +		return -EINVAL;
> +
> +	return pp_funcs->set_power_limit(adev->powerplay.pp_handle,
> limit);
> +}
> +
> +int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev)
> +{
> +	if (!is_support_sw_smu(adev))
> +		return false;
> +
> +	return is_support_cclk_dpm(adev);
> +}
> +
> +int amdgpu_dpm_debugfs_print_current_performance_level(struct
> amdgpu_device *adev,
> +						       struct seq_file *m)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->debugfs_print_current_performance_level)
> +		return -EOPNOTSUPP;
> +
> +	pp_funcs->debugfs_print_current_performance_level(adev-
> >powerplay.pp_handle,
> +							  m);
> +
> +	return 0;
> +}
> +
> +int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
> +				       void **addr,
> +				       size_t *size)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_smu_prv_buf_details)
> +		return -ENOSYS;
> +
> +	return pp_funcs->get_smu_prv_buf_details(adev-
> >powerplay.pp_handle,
> +						 addr,
> +						 size);
> +}
> +
> +int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
> +{
> +	struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
> +
> +	if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
> +	    (is_support_sw_smu(adev) && adev->smu.is_apu) ||
> +		(!is_support_sw_smu(adev) && hwmgr->od_enabled))
> +		return true;
> +
> +	return false;
> +}
> +
> +int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
> +			    const char *buf,
> +			    size_t size)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_pp_table)
> +		return -EOPNOTSUPP;
> +
> +	return pp_funcs->set_pp_table(adev->powerplay.pp_handle,
> +				      buf,
> +				      size);
> +}
> +
> +int amdgpu_dpm_get_num_cpu_cores(struct amdgpu_device *adev)
> +{
> +	return adev->smu.cpu_core_num;
> +}
> +
> +void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev)
> +{
> +	if (!is_support_sw_smu(adev))
> +		return;
> +
> +	amdgpu_smu_stb_debug_fs_init(adev);
> +}
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 082539c70fd4..3382d30b5d90 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -34,7 +34,6 @@
>  #include <linux/nospec.h>
>  #include <linux/pm_runtime.h>
>  #include <asm/processor.h>
> -#include "hwmgr.h"
>=20
>  static const struct cg_flag_name clocks[] =3D {
>  	{AMD_CG_SUPPORT_GFX_FGCG, "Graphics Fine Grain Clock
> Gating"},
> @@ -132,7 +131,6 @@ static ssize_t amdgpu_get_power_dpm_state(struct
> device *dev,
>  {
>  	struct drm_device *ddev =3D dev_get_drvdata(dev);
>  	struct amdgpu_device *adev =3D drm_to_adev(ddev);
> -	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
>  	enum amd_pm_state_type pm;
>  	int ret;
>=20
> @@ -147,11 +145,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct
> device *dev,
>  		return ret;
>  	}
>=20
> -	if (pp_funcs->get_current_power_state) {
> -		pm =3D amdgpu_dpm_get_current_power_state(adev);
> -	} else {
> -		pm =3D adev->pm.dpm.user_state;
> -	}
> +	amdgpu_dpm_get_current_power_state(adev, &pm);
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
> @@ -191,19 +185,8 @@ static ssize_t amdgpu_set_power_dpm_state(struct
> device *dev,
>  		return ret;
>  	}
>=20
> -	if (is_support_sw_smu(adev)) {
> -		mutex_lock(&adev->pm.mutex);
> -		adev->pm.dpm.user_state =3D state;
> -		mutex_unlock(&adev->pm.mutex);
> -	} else if (adev->powerplay.pp_funcs->dispatch_tasks) {
> -		amdgpu_dpm_dispatch_task(adev,
> AMD_PP_TASK_ENABLE_USER_STATE, &state);
> -	} else {
> -		mutex_lock(&adev->pm.mutex);
> -		adev->pm.dpm.user_state =3D state;
> -		mutex_unlock(&adev->pm.mutex);
> +	amdgpu_dpm_set_power_state(adev, state);
>=20
> -		amdgpu_pm_compute_clocks(adev);
> -	}
>  	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>=20
> @@ -290,10 +273,7 @@ static ssize_t
> amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>  		return ret;
>  	}
>=20
> -	if (adev->powerplay.pp_funcs->get_performance_level)
> -		level =3D amdgpu_dpm_get_performance_level(adev);
> -	else
> -		level =3D adev->pm.dpm.forced_level;
> +	level =3D amdgpu_dpm_get_performance_level(adev);
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
> @@ -318,7 +298,6 @@ static ssize_t
> amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>  {
>  	struct drm_device *ddev =3D dev_get_drvdata(dev);
>  	struct amdgpu_device *adev =3D drm_to_adev(ddev);
> -	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
>  	enum amd_dpm_forced_level level;
>  	enum amd_dpm_forced_level current_level;
>  	int ret =3D 0;
> @@ -358,11 +337,7 @@ static ssize_t
> amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>  		return ret;
>  	}
>=20
> -	if (pp_funcs->get_performance_level)
> -		current_level =3D
> amdgpu_dpm_get_performance_level(adev);
> -	else
> -		current_level =3D adev->pm.dpm.forced_level;
> -
> +	current_level =3D amdgpu_dpm_get_performance_level(adev);
>  	if (current_level =3D=3D level) {
>  		pm_runtime_mark_last_busy(ddev->dev);
>  		pm_runtime_put_autosuspend(ddev->dev);
> @@ -390,25 +365,12 @@ static ssize_t
> amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>  		return -EINVAL;
>  	}
>=20
> -	if (pp_funcs->force_performance_level) {
> -		mutex_lock(&adev->pm.mutex);
> -		if (adev->pm.dpm.thermal_active) {
> -			mutex_unlock(&adev->pm.mutex);
> -			pm_runtime_mark_last_busy(ddev->dev);
> -			pm_runtime_put_autosuspend(ddev->dev);
> -			return -EINVAL;
> -		}
> -		ret =3D amdgpu_dpm_force_performance_level(adev, level);
> -		if (ret) {
> -			mutex_unlock(&adev->pm.mutex);
> -			pm_runtime_mark_last_busy(ddev->dev);
> -			pm_runtime_put_autosuspend(ddev->dev);
> -			return -EINVAL;
> -		} else {
> -			adev->pm.dpm.forced_level =3D level;
> -		}
> -		mutex_unlock(&adev->pm.mutex);
> +	if (amdgpu_dpm_force_performance_level(adev, level)) {
> +		pm_runtime_mark_last_busy(ddev->dev);
> +		pm_runtime_put_autosuspend(ddev->dev);
> +		return -EINVAL;
>  	}
> +
>  	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>=20
> @@ -421,7 +383,6 @@ static ssize_t amdgpu_get_pp_num_states(struct
> device *dev,
>  {
>  	struct drm_device *ddev =3D dev_get_drvdata(dev);
>  	struct amdgpu_device *adev =3D drm_to_adev(ddev);
> -	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
>  	struct pp_states_info data;
>  	uint32_t i;
>  	int buf_len, ret;
> @@ -437,11 +398,8 @@ static ssize_t amdgpu_get_pp_num_states(struct
> device *dev,
>  		return ret;
>  	}
>=20
> -	if (pp_funcs->get_pp_num_states) {
> -		amdgpu_dpm_get_pp_num_states(adev, &data);
> -	} else {
> +	if (amdgpu_dpm_get_pp_num_states(adev, &data))
>  		memset(&data, 0, sizeof(data));
> -	}
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
> @@ -463,7 +421,6 @@ static ssize_t amdgpu_get_pp_cur_state(struct
> device *dev,
>  {
>  	struct drm_device *ddev =3D dev_get_drvdata(dev);
>  	struct amdgpu_device *adev =3D drm_to_adev(ddev);
> -	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
>  	struct pp_states_info data =3D {0};
>  	enum amd_pm_state_type pm =3D 0;
>  	int i =3D 0, ret =3D 0;
> @@ -479,15 +436,16 @@ static ssize_t amdgpu_get_pp_cur_state(struct
> device *dev,
>  		return ret;
>  	}
>=20
> -	if (pp_funcs->get_current_power_state
> -		 && pp_funcs->get_pp_num_states) {
> -		pm =3D amdgpu_dpm_get_current_power_state(adev);
> -		amdgpu_dpm_get_pp_num_states(adev, &data);
> -	}
> +	amdgpu_dpm_get_current_power_state(adev, &pm);
> +
> +	ret =3D amdgpu_dpm_get_pp_num_states(adev, &data);
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>=20
> +	if (ret)
> +		return ret;
> +
>  	for (i =3D 0; i < data.nums; i++) {
>  		if (pm =3D=3D data.states[i])
>  			break;
> @@ -525,6 +483,7 @@ static ssize_t amdgpu_set_pp_force_state(struct
> device *dev,
>  	struct drm_device *ddev =3D dev_get_drvdata(dev);
>  	struct amdgpu_device *adev =3D drm_to_adev(ddev);
>  	enum amd_pm_state_type state =3D 0;
> +	struct pp_states_info data;
>  	unsigned long idx;
>  	int ret;
>=20
> @@ -533,41 +492,49 @@ static ssize_t amdgpu_set_pp_force_state(struct
> device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>=20
> -	if (strlen(buf) =3D=3D 1)
> -		adev->pp_force_state_enabled =3D false;
> -	else if (is_support_sw_smu(adev))
> -		adev->pp_force_state_enabled =3D false;
> -	else if (adev->powerplay.pp_funcs->dispatch_tasks &&
> -			adev->powerplay.pp_funcs->get_pp_num_states) {
> -		struct pp_states_info data;
> -
> -		ret =3D kstrtoul(buf, 0, &idx);
> -		if (ret || idx >=3D ARRAY_SIZE(data.states))
> -			return -EINVAL;
> +	adev->pp_force_state_enabled =3D false;
>=20
> -		idx =3D array_index_nospec(idx, ARRAY_SIZE(data.states));
> +	if (strlen(buf) =3D=3D 1)
> +		return count;
>=20
> -		amdgpu_dpm_get_pp_num_states(adev, &data);
> -		state =3D data.states[idx];
> +	ret =3D kstrtoul(buf, 0, &idx);
> +	if (ret || idx >=3D ARRAY_SIZE(data.states))
> +		return -EINVAL;
>=20
> -		ret =3D pm_runtime_get_sync(ddev->dev);
> -		if (ret < 0) {
> -			pm_runtime_put_autosuspend(ddev->dev);
> -			return ret;
> -		}
> +	idx =3D array_index_nospec(idx, ARRAY_SIZE(data.states));
>=20
> -		/* only set user selected power states */
> -		if (state !=3D POWER_STATE_TYPE_INTERNAL_BOOT &&
> -		    state !=3D POWER_STATE_TYPE_DEFAULT) {
> -			amdgpu_dpm_dispatch_task(adev,
> -
> 	AMD_PP_TASK_ENABLE_USER_STATE, &state);
> -			adev->pp_force_state_enabled =3D true;
> -		}
> -		pm_runtime_mark_last_busy(ddev->dev);
> +	ret =3D pm_runtime_get_sync(ddev->dev);
> +	if (ret < 0) {
>  		pm_runtime_put_autosuspend(ddev->dev);
> +		return ret;
> +	}
> +
> +	ret =3D amdgpu_dpm_get_pp_num_states(adev, &data);
> +	if (ret)
> +		goto err_out;
> +
> +	state =3D data.states[idx];
> +
> +	/* only set user selected power states */
> +	if (state !=3D POWER_STATE_TYPE_INTERNAL_BOOT &&
> +	    state !=3D POWER_STATE_TYPE_DEFAULT) {
> +		ret =3D amdgpu_dpm_dispatch_task(adev,
> +				AMD_PP_TASK_ENABLE_USER_STATE,
> &state);
> +		if (ret)
> +			goto err_out;
> +
> +		adev->pp_force_state_enabled =3D true;
>  	}
>=20
> +	pm_runtime_mark_last_busy(ddev->dev);
> +	pm_runtime_put_autosuspend(ddev->dev);
> +
>  	return count;
> +
> +err_out:
> +	pm_runtime_mark_last_busy(ddev->dev);
> +	pm_runtime_put_autosuspend(ddev->dev);
> +	return ret;
>  }
>=20
>  /**
> @@ -601,17 +568,13 @@ static ssize_t amdgpu_get_pp_table(struct device
> *dev,
>  		return ret;
>  	}
>=20
> -	if (adev->powerplay.pp_funcs->get_pp_table) {
> -		size =3D amdgpu_dpm_get_pp_table(adev, &table);
> -		pm_runtime_mark_last_busy(ddev->dev);
> -		pm_runtime_put_autosuspend(ddev->dev);
> -		if (size < 0)
> -			return size;
> -	} else {
> -		pm_runtime_mark_last_busy(ddev->dev);
> -		pm_runtime_put_autosuspend(ddev->dev);
> -		return 0;
> -	}
> +	size =3D amdgpu_dpm_get_pp_table(adev, &table);
> +
> +	pm_runtime_mark_last_busy(ddev->dev);
> +	pm_runtime_put_autosuspend(ddev->dev);
> +
> +	if (size <=3D 0)
> +		return size;
>=20
>  	if (size >=3D PAGE_SIZE)
>  		size =3D PAGE_SIZE - 1;
> @@ -642,15 +605,13 @@ static ssize_t amdgpu_set_pp_table(struct device
> *dev,
>  	}
>=20
>  	ret =3D amdgpu_dpm_set_pp_table(adev, buf, count);
> -	if (ret) {
> -		pm_runtime_mark_last_busy(ddev->dev);
> -		pm_runtime_put_autosuspend(ddev->dev);
> -		return ret;
> -	}
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>=20
> +	if (ret)
> +		return ret;
> +
>  	return count;
>  }
>=20
> @@ -866,46 +827,32 @@ static ssize_t
> amdgpu_set_pp_od_clk_voltage(struct device *dev,
>  		return ret;
>  	}
>=20
> -	if (adev->powerplay.pp_funcs->set_fine_grain_clk_vol) {
> -		ret =3D amdgpu_dpm_set_fine_grain_clk_vol(adev, type,
> -							parameter,
> -							parameter_size);
> -		if (ret) {
> -			pm_runtime_mark_last_busy(ddev->dev);
> -			pm_runtime_put_autosuspend(ddev->dev);
> -			return -EINVAL;
> -		}
> -	}
> +	if (amdgpu_dpm_set_fine_grain_clk_vol(adev,
> +					      type,
> +					      parameter,
> +					      parameter_size))
> +		goto err_out;
>=20
> -	if (adev->powerplay.pp_funcs->odn_edit_dpm_table) {
> -		ret =3D amdgpu_dpm_odn_edit_dpm_table(adev, type,
> -						    parameter,
> parameter_size);
> -		if (ret) {
> -			pm_runtime_mark_last_busy(ddev->dev);
> -			pm_runtime_put_autosuspend(ddev->dev);
> -			return -EINVAL;
> -		}
> -	}
> +	if (amdgpu_dpm_odn_edit_dpm_table(adev, type,
> +					  parameter, parameter_size))
> +		goto err_out;
>=20
>  	if (type =3D=3D PP_OD_COMMIT_DPM_TABLE) {
> -		if (adev->powerplay.pp_funcs->dispatch_tasks) {
> -			amdgpu_dpm_dispatch_task(adev,
> -
> AMD_PP_TASK_READJUST_POWER_STATE,
> -						 NULL);
> -			pm_runtime_mark_last_busy(ddev->dev);
> -			pm_runtime_put_autosuspend(ddev->dev);
> -			return count;
> -		} else {
> -			pm_runtime_mark_last_busy(ddev->dev);
> -			pm_runtime_put_autosuspend(ddev->dev);
> -			return -EINVAL;
> -		}
> +		if (amdgpu_dpm_dispatch_task(adev,
> +
> AMD_PP_TASK_READJUST_POWER_STATE,
> +					     NULL))
> +			goto err_out;
>  	}
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>=20
>  	return count;
> +
> +err_out:
> +	pm_runtime_mark_last_busy(ddev->dev);
> +	pm_runtime_put_autosuspend(ddev->dev);
> +	return -EINVAL;
>  }
>=20
>  static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
> @@ -928,8 +875,8 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct
> device *dev,
>  		return ret;
>  	}
>=20
> -	if (adev->powerplay.pp_funcs->print_clock_levels) {
> -		size =3D amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
> +	size =3D amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
> +	if (size > 0) {
>  		size +=3D amdgpu_dpm_print_clock_levels(adev, OD_MCLK,
> buf+size);
>  		size +=3D amdgpu_dpm_print_clock_levels(adev,
> OD_VDDC_CURVE, buf+size);
>  		size +=3D amdgpu_dpm_print_clock_levels(adev,
> OD_VDDGFX_OFFSET, buf+size);
> @@ -985,17 +932,14 @@ static ssize_t amdgpu_set_pp_features(struct
> device *dev,
>  		return ret;
>  	}
>=20
> -	if (adev->powerplay.pp_funcs->set_ppfeature_status) {
> -		ret =3D amdgpu_dpm_set_ppfeature_status(adev,
> featuremask);
> -		if (ret) {
> -			pm_runtime_mark_last_busy(ddev->dev);
> -			pm_runtime_put_autosuspend(ddev->dev);
> -			return -EINVAL;
> -		}
> -	}
> +	ret =3D amdgpu_dpm_set_ppfeature_status(adev, featuremask);
> +
>  	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>=20
> +	if (ret)
> +		return -EINVAL;
> +
>  	return count;
>  }
>=20
> @@ -1019,9 +963,8 @@ static ssize_t amdgpu_get_pp_features(struct
> device *dev,
>  		return ret;
>  	}
>=20
> -	if (adev->powerplay.pp_funcs->get_ppfeature_status)
> -		size =3D amdgpu_dpm_get_ppfeature_status(adev, buf);
> -	else
> +	size =3D amdgpu_dpm_get_ppfeature_status(adev, buf);
> +	if (size <=3D 0)
>  		size =3D sysfs_emit(buf, "\n");
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
> @@ -1080,9 +1023,8 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct
> device *dev,
>  		return ret;
>  	}
>=20
> -	if (adev->powerplay.pp_funcs->print_clock_levels)
> -		size =3D amdgpu_dpm_print_clock_levels(adev, type, buf);
> -	else
> +	size =3D amdgpu_dpm_print_clock_levels(adev, type, buf);
> +	if (size <=3D 0)
>  		size =3D sysfs_emit(buf, "\n");
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
> @@ -1151,10 +1093,7 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct
> device *dev,
>  		return ret;
>  	}
>=20
> -	if (adev->powerplay.pp_funcs->force_clock_level)
> -		ret =3D amdgpu_dpm_force_clock_level(adev, type, mask);
> -	else
> -		ret =3D 0;
> +	ret =3D amdgpu_dpm_force_clock_level(adev, type, mask);
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
> @@ -1305,10 +1244,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct
> device *dev,
>  		return ret;
>  	}
>=20
> -	if (is_support_sw_smu(adev))
> -		value =3D 0;
> -	else if (adev->powerplay.pp_funcs->get_sclk_od)
> -		value =3D amdgpu_dpm_get_sclk_od(adev);
> +	value =3D amdgpu_dpm_get_sclk_od(adev);
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
> @@ -1342,19 +1278,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct
> device *dev,
>  		return ret;
>  	}
>=20
> -	if (is_support_sw_smu(adev)) {
> -		value =3D 0;
> -	} else {
> -		if (adev->powerplay.pp_funcs->set_sclk_od)
> -			amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
> -
> -		if (adev->powerplay.pp_funcs->dispatch_tasks) {
> -			amdgpu_dpm_dispatch_task(adev,
> AMD_PP_TASK_READJUST_POWER_STATE, NULL);
> -		} else {
> -			adev->pm.dpm.current_ps =3D adev-
> >pm.dpm.boot_ps;
> -			amdgpu_pm_compute_clocks(adev);
> -		}
> -	}
> +	amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
> @@ -1382,10 +1306,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct
> device *dev,
>  		return ret;
>  	}
>=20
> -	if (is_support_sw_smu(adev))
> -		value =3D 0;
> -	else if (adev->powerplay.pp_funcs->get_mclk_od)
> -		value =3D amdgpu_dpm_get_mclk_od(adev);
> +	value =3D amdgpu_dpm_get_mclk_od(adev);
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
> @@ -1419,19 +1340,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct
> device *dev,
>  		return ret;
>  	}
>=20
> -	if (is_support_sw_smu(adev)) {
> -		value =3D 0;
> -	} else {
> -		if (adev->powerplay.pp_funcs->set_mclk_od)
> -			amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
> -
> -		if (adev->powerplay.pp_funcs->dispatch_tasks) {
> -			amdgpu_dpm_dispatch_task(adev,
> AMD_PP_TASK_READJUST_POWER_STATE, NULL);
> -		} else {
> -			adev->pm.dpm.current_ps =3D adev-
> >pm.dpm.boot_ps;
> -			amdgpu_pm_compute_clocks(adev);
> -		}
> -	}
> +	amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
> @@ -1479,9 +1388,8 @@ static ssize_t
> amdgpu_get_pp_power_profile_mode(struct device *dev,
>  		return ret;
>  	}
>=20
> -	if (adev->powerplay.pp_funcs->get_power_profile_mode)
> -		size =3D amdgpu_dpm_get_power_profile_mode(adev, buf);
> -	else
> +	size =3D amdgpu_dpm_get_power_profile_mode(adev, buf);
> +	if (size <=3D 0)
>  		size =3D sysfs_emit(buf, "\n");
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
> @@ -1545,8 +1453,7 @@ static ssize_t
> amdgpu_set_pp_power_profile_mode(struct device *dev,
>  		return ret;
>  	}
>=20
> -	if (adev->powerplay.pp_funcs->set_power_profile_mode)
> -		ret =3D amdgpu_dpm_set_power_profile_mode(adev,
> parameter, parameter_size);
> +	ret =3D amdgpu_dpm_set_power_profile_mode(adev, parameter,
> parameter_size);
>=20
>  	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
> @@ -1812,9 +1719,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct
> device *dev,
>  		return ret;
>  	}
>=20
> -	if (adev->powerplay.pp_funcs->get_gpu_metrics)
> -		size =3D amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
> -
> +	size =3D amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
>  	if (size <=3D 0)
>  		goto out;
>=20
> @@ -2053,7 +1958,6 @@ static int default_attr_update(struct
> amdgpu_device *adev, struct amdgpu_device_
>  {
>  	struct device_attribute *dev_attr =3D &attr->dev_attr;
>  	const char *attr_name =3D dev_attr->attr.name;
> -	struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
>  	enum amd_asic_type asic_type =3D adev->asic_type;
>=20
>  	if (!(attr->flags & mask)) {
> @@ -2076,9 +1980,7 @@ static int default_attr_update(struct
> amdgpu_device *adev, struct amdgpu_device_
>  			*states =3D ATTR_STATE_UNSUPPORTED;
>  	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
>  		*states =3D ATTR_STATE_UNSUPPORTED;
> -		if ((is_support_sw_smu(adev) && adev->smu.od_enabled)
> ||
> -		    (is_support_sw_smu(adev) && adev->smu.is_apu) ||
> -			(!is_support_sw_smu(adev) && hwmgr-
> >od_enabled))
> +		if (amdgpu_dpm_is_overdrive_supported(adev))
>  			*states =3D ATTR_STATE_SUPPORTED;
>  	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
>  		if (adev->flags & AMD_IS_APU || asic_type =3D=3D CHIP_VEGA10)
> @@ -2105,8 +2007,7 @@ static int default_attr_update(struct
> amdgpu_device *adev, struct amdgpu_device_
>  		if (!(asic_type =3D=3D CHIP_VANGOGH || asic_type =3D=3D
> CHIP_SIENNA_CICHLID))
>  			*states =3D ATTR_STATE_UNSUPPORTED;
>  	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
> -		if (!adev->powerplay.pp_funcs->get_power_profile_mode
> ||
> -		    amdgpu_dpm_get_power_profile_mode(adev, NULL) =3D=3D -
> EOPNOTSUPP)
> +		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) =3D=3D
> -EOPNOTSUPP)
>  			*states =3D ATTR_STATE_UNSUPPORTED;
>  	}
>=20
> @@ -2389,17 +2290,14 @@ static ssize_t
> amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>  		return ret;
>  	}
>=20
> -	if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -		return -EINVAL;
> -	}
> -
> -	pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);
> +	ret =3D amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>=20
>  	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>=20
> +	if (ret)
> +		return -EINVAL;
> +
>  	return sysfs_emit(buf, "%u\n", pwm_mode);
>  }
>=20
> @@ -2427,17 +2325,14 @@ static ssize_t
> amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>  		return ret;
>  	}
>=20
> -	if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -		return -EINVAL;
> -	}
> -
> -	amdgpu_dpm_set_fan_control_mode(adev, value);
> +	ret =3D amdgpu_dpm_set_fan_control_mode(adev, value);
>=20
>  	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>=20
> +	if (ret)
> +		return -EINVAL;
> +
>  	return count;
>  }
>=20
> @@ -2469,32 +2364,29 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct
> device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>=20
> +	err =3D kstrtou32(buf, 10, &value);
> +	if (err)
> +		return err;
> +
>  	err =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
>  	if (err < 0) {
>  		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  		return err;
>  	}
>=20
> -	pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);
> +	err =3D amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
> +	if (err)
> +		goto out;
> +
>  	if (pwm_mode !=3D AMD_FAN_CTRL_MANUAL) {
>  		pr_info("manual fan speed control should be enabled
> first\n");
> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -		return -EINVAL;
> +		err =3D -EINVAL;
> +		goto out;
>  	}
>=20
> -	err =3D kstrtou32(buf, 10, &value);
> -	if (err) {
> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -		return err;
> -	}
> -
> -	if (adev->powerplay.pp_funcs->set_fan_speed_pwm)
> -		err =3D amdgpu_dpm_set_fan_speed_pwm(adev, value);
> -	else
> -		err =3D -EINVAL;
> +	err =3D amdgpu_dpm_set_fan_speed_pwm(adev, value);
>=20
> +out:
>  	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>=20
> @@ -2523,10 +2415,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct
> device *dev,
>  		return err;
>  	}
>=20
> -	if (adev->powerplay.pp_funcs->get_fan_speed_pwm)
> -		err =3D amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
> -	else
> -		err =3D -EINVAL;
> +	err =3D amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
>=20
>  	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -2556,10 +2445,7 @@ static ssize_t
> amdgpu_hwmon_get_fan1_input(struct device *dev,
>  		return err;
>  	}
>=20
> -	if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
> -		err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
> -	else
> -		err =3D -EINVAL;
> +	err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
>=20
>  	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -2653,10 +2539,7 @@ static ssize_t
> amdgpu_hwmon_get_fan1_target(struct device *dev,
>  		return err;
>  	}
>=20
> -	if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
> -		err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
> -	else
> -		err =3D -EINVAL;
> +	err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
>=20
>  	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -2681,32 +2564,28 @@ static ssize_t
> amdgpu_hwmon_set_fan1_target(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>=20
> +	err =3D kstrtou32(buf, 10, &value);
> +	if (err)
> +		return err;
> +
>  	err =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
>  	if (err < 0) {
>  		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  		return err;
>  	}
>=20
> -	pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);
> +	err =3D amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
> +	if (err)
> +		goto out;
>=20
>  	if (pwm_mode !=3D AMD_FAN_CTRL_MANUAL) {
> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -		return -ENODATA;
> -	}
> -
> -	err =3D kstrtou32(buf, 10, &value);
> -	if (err) {
> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -		return err;
> +		err =3D -ENODATA;
> +		goto out;
>  	}
>=20
> -	if (adev->powerplay.pp_funcs->set_fan_speed_rpm)
> -		err =3D amdgpu_dpm_set_fan_speed_rpm(adev, value);
> -	else
> -		err =3D -EINVAL;
> +	err =3D amdgpu_dpm_set_fan_speed_rpm(adev, value);
>=20
> +out:
>  	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>=20
> @@ -2735,17 +2614,14 @@ static ssize_t
> amdgpu_hwmon_get_fan1_enable(struct device *dev,
>  		return ret;
>  	}
>=20
> -	if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -		return -EINVAL;
> -	}
> -
> -	pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);
> +	ret =3D amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>=20
>  	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>=20
> +	if (ret)
> +		return -EINVAL;
> +
>  	return sysfs_emit(buf, "%i\n", pwm_mode =3D=3D
> AMD_FAN_CTRL_AUTO ? 0 : 1);
>  }
>=20
> @@ -2781,16 +2657,14 @@ static ssize_t
> amdgpu_hwmon_set_fan1_enable(struct device *dev,
>  		return err;
>  	}
>=20
> -	if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -		return -EINVAL;
> -	}
> -	amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
> +	err =3D amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
>=20
>  	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>=20
> +	if (err)
> +		return -EINVAL;
> +
>  	return count;
>  }
>=20
> @@ -2926,7 +2800,6 @@ static ssize_t
> amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>  					enum pp_power_limit_level
> pp_limit_level)
>  {
>  	struct amdgpu_device *adev =3D dev_get_drvdata(dev);
> -	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
>  	enum pp_power_type power_type =3D to_sensor_dev_attr(attr)-
> >index;
>  	uint32_t limit;
>  	ssize_t size;
> @@ -2937,16 +2810,13 @@ static ssize_t
> amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>=20
> -	if ( !(pp_funcs && pp_funcs->get_power_limit))
> -		return -ENODATA;
> -
>  	r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
>  	if (r < 0) {
>  		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  		return r;
>  	}
>=20
> -	r =3D pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
> +	r =3D amdgpu_dpm_get_power_limit(adev, &limit,
>  				      pp_limit_level, power_type);
>=20
>  	if (!r)
> @@ -3001,7 +2871,6 @@ static ssize_t
> amdgpu_hwmon_set_power_cap(struct device *dev,
>  		size_t count)
>  {
>  	struct amdgpu_device *adev =3D dev_get_drvdata(dev);
> -	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
>  	int limit_type =3D to_sensor_dev_attr(attr)->index;
>  	int err;
>  	u32 value;
> @@ -3027,10 +2896,7 @@ static ssize_t
> amdgpu_hwmon_set_power_cap(struct device *dev,
>  		return err;
>  	}
>=20
> -	if (pp_funcs && pp_funcs->set_power_limit)
> -		err =3D pp_funcs->set_power_limit(adev-
> >powerplay.pp_handle, value);
> -	else
> -		err =3D -EINVAL;
> +	err =3D amdgpu_dpm_set_power_limit(adev, value);
>=20
>  	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -3303,6 +3169,7 @@ static umode_t hwmon_attributes_visible(struct
> kobject *kobj,
>  	struct device *dev =3D kobj_to_dev(kobj);
>  	struct amdgpu_device *adev =3D dev_get_drvdata(dev);
>  	umode_t effective_mode =3D attr->mode;
> +	uint32_t speed =3D 0;
>=20
>  	/* under multi-vf mode, the hwmon attributes are all not supported
> */
>  	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> @@ -3367,20 +3234,18 @@ static umode_t hwmon_attributes_visible(struct
> kobject *kobj,
>  	     attr =3D=3D &sensor_dev_attr_fan1_enable.dev_attr.attr))
>  		return 0;
>=20
> -	if (!is_support_sw_smu(adev)) {
> -		/* mask fan attributes if we have no bindings for this asic to
> expose */
> -		if ((!adev->powerplay.pp_funcs->get_fan_speed_pwm &&
> -		     attr =3D=3D &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't
> query fan */
> -		    (!adev->powerplay.pp_funcs->get_fan_control_mode &&
> -		     attr =3D=3D &sensor_dev_attr_pwm1_enable.dev_attr.attr))
> /* can't query state */
> -			effective_mode &=3D ~S_IRUGO;
> +	/* mask fan attributes if we have no bindings for this asic to expose
> */
> +	if (((amdgpu_dpm_get_fan_speed_pwm(adev, &speed) =3D=3D -EINVAL)
> &&
> +	      attr =3D=3D &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't quer=
y
> fan */
> +	    ((amdgpu_dpm_get_fan_control_mode(adev, &speed) =3D=3D -
> EOPNOTSUPP) &&
> +	     attr =3D=3D &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't
> query state */
> +		effective_mode &=3D ~S_IRUGO;
>=20
> -		if ((!adev->powerplay.pp_funcs->set_fan_speed_pwm &&
> -		     attr =3D=3D &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't
> manage fan */
> -		    (!adev->powerplay.pp_funcs->set_fan_control_mode &&
> -		     attr =3D=3D &sensor_dev_attr_pwm1_enable.dev_attr.attr))
> /* can't manage state */
> -			effective_mode &=3D ~S_IWUSR;
> -	}
> +	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) =3D=3D -EINVAL)
> &&
> +	      attr =3D=3D &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't
> manage fan */
> +	      ((amdgpu_dpm_set_fan_control_mode(adev, speed) =3D=3D -
> EOPNOTSUPP) &&
> +	      attr =3D=3D &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't
> manage state */
> +		effective_mode &=3D ~S_IWUSR;
>=20
>  	if (((adev->family =3D=3D AMDGPU_FAMILY_SI) ||
>  		 ((adev->flags & AMD_IS_APU) &&
> @@ -3397,22 +3262,20 @@ static umode_t hwmon_attributes_visible(struct
> kobject *kobj,
>  	    (attr =3D=3D &sensor_dev_attr_power1_average.dev_attr.attr))
>  		return 0;
>=20
> -	if (!is_support_sw_smu(adev)) {
> -		/* hide max/min values if we can't both query and manage
> the fan */
> -		if ((!adev->powerplay.pp_funcs->set_fan_speed_pwm &&
> -		     !adev->powerplay.pp_funcs->get_fan_speed_pwm) &&
> -		     (!adev->powerplay.pp_funcs->set_fan_speed_rpm &&
> -		     !adev->powerplay.pp_funcs->get_fan_speed_rpm) &&
> -		    (attr =3D=3D &sensor_dev_attr_pwm1_max.dev_attr.attr ||
> -		     attr =3D=3D &sensor_dev_attr_pwm1_min.dev_attr.attr))
> -			return 0;
> +	/* hide max/min values if we can't both query and manage the fan */
> +	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) =3D=3D -EINVAL)
> &&
> +	      (amdgpu_dpm_get_fan_speed_pwm(adev, &speed) =3D=3D -EINVAL)
> &&
> +	      (amdgpu_dpm_set_fan_speed_rpm(adev, speed) =3D=3D -EINVAL)
> &&
> +	      (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) =3D=3D -EINVAL))
> &&
> +	    (attr =3D=3D &sensor_dev_attr_pwm1_max.dev_attr.attr ||
> +	     attr =3D=3D &sensor_dev_attr_pwm1_min.dev_attr.attr))
> +		return 0;
>=20
> -		if ((!adev->powerplay.pp_funcs->set_fan_speed_rpm &&
> -		     !adev->powerplay.pp_funcs->get_fan_speed_rpm) &&
> -		    (attr =3D=3D &sensor_dev_attr_fan1_max.dev_attr.attr ||
> -		     attr =3D=3D &sensor_dev_attr_fan1_min.dev_attr.attr))
> -			return 0;
> -	}
> +	if ((amdgpu_dpm_set_fan_speed_rpm(adev, speed) =3D=3D -EINVAL)
> &&
> +	     (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) =3D=3D -EINVAL)
> &&
> +	     (attr =3D=3D &sensor_dev_attr_fan1_max.dev_attr.attr ||
> +	     attr =3D=3D &sensor_dev_attr_fan1_min.dev_attr.attr))
> +		return 0;
>=20
>  	if ((adev->family =3D=3D AMDGPU_FAMILY_SI ||	/* not implemented
> yet */
>  	     adev->family =3D=3D AMDGPU_FAMILY_KV) &&	/* not implemented
> yet */
> @@ -3542,14 +3405,15 @@ static void
> amdgpu_debugfs_prints_cpu_info(struct seq_file *m,
>  	uint16_t *p_val;
>  	uint32_t size;
>  	int i;
> +	uint32_t num_cpu_cores =3D
> amdgpu_dpm_get_num_cpu_cores(adev);
>=20
> -	if (is_support_cclk_dpm(adev)) {
> -		p_val =3D kcalloc(adev->smu.cpu_core_num, sizeof(uint16_t),
> +	if (amdgpu_dpm_is_cclk_dpm_supported(adev)) {
> +		p_val =3D kcalloc(num_cpu_cores, sizeof(uint16_t),
>  				GFP_KERNEL);
>=20
>  		if (!amdgpu_dpm_read_sensor(adev,
> AMDGPU_PP_SENSOR_CPU_CLK,
>  					    (void *)p_val, &size)) {
> -			for (i =3D 0; i < adev->smu.cpu_core_num; i++)
> +			for (i =3D 0; i < num_cpu_cores; i++)
>  				seq_printf(m, "\t%u MHz (CPU%d)\n",
>  					   *(p_val + i), i);
>  		}
> @@ -3677,27 +3541,11 @@ static int
> amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
>  		return r;
>  	}
>=20
> -	if (!adev->pm.dpm_enabled) {
> -		seq_printf(m, "dpm not enabled\n");
> -		pm_runtime_mark_last_busy(dev->dev);
> -		pm_runtime_put_autosuspend(dev->dev);
> -		return 0;
> -	}
> -
> -	if (!is_support_sw_smu(adev) &&
> -	    adev->powerplay.pp_funcs-
> >debugfs_print_current_performance_level) {
> -		mutex_lock(&adev->pm.mutex);
> -		if (adev->powerplay.pp_funcs-
> >debugfs_print_current_performance_level)
> -			adev->powerplay.pp_funcs-
> >debugfs_print_current_performance_level(adev, m);
> -		else
> -			seq_printf(m, "Debugfs support not implemented
> for this asic\n");
> -		mutex_unlock(&adev->pm.mutex);
> -		r =3D 0;
> -	} else {
> +	if (amdgpu_dpm_debugfs_print_current_performance_level(adev,
> m)) {
>  		r =3D amdgpu_debugfs_pm_info_pp(m, adev);
> +		if (r)
> +			goto out;
>  	}
> -	if (r)
> -		goto out;
>=20
>  	amdgpu_device_ip_get_clockgating_state(adev, &flags);
>=20
> @@ -3723,21 +3571,18 @@ static ssize_t
> amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
>  					 size_t size, loff_t *pos)
>  {
>  	struct amdgpu_device *adev =3D file_inode(f)->i_private;
> -	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> -	void *pp_handle =3D adev->powerplay.pp_handle;
>  	size_t smu_prv_buf_size;
>  	void *smu_prv_buf;
> +	int ret =3D 0;
>=20
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>=20
> -	if (pp_funcs && pp_funcs->get_smu_prv_buf_details)
> -		pp_funcs->get_smu_prv_buf_details(pp_handle,
> &smu_prv_buf,
> -						  &smu_prv_buf_size);
> -	else
> -		return -ENOSYS;
> +	ret =3D amdgpu_dpm_get_smu_prv_buf_details(adev, &smu_prv_buf,
> &smu_prv_buf_size);
> +	if (ret)
> +		return ret;
>=20
>  	if (!smu_prv_buf || !smu_prv_buf_size)
>  		return -EINVAL;
> @@ -3770,6 +3615,6 @@ void amdgpu_debugfs_pm_init(struct
> amdgpu_device *adev)
>=20
> &amdgpu_debugfs_pm_prv_buffer_fops,
>  					 adev->pm.smu_prv_buffer_size);
>=20
> -	amdgpu_smu_stb_debug_fs_init(adev);
> +	amdgpu_dpm_stb_debug_fs_init(adev);
>  #endif
>  }
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 7289d379a9fb..039c40b1d0cb 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -262,9 +262,6 @@ enum amdgpu_pcie_gen {
>  #define amdgpu_dpm_pre_set_power_state(adev) \
>  		((adev)->powerplay.pp_funcs-
> >pre_set_power_state((adev)->powerplay.pp_handle))
>=20
> -#define amdgpu_dpm_set_power_state(adev) \
> -		((adev)->powerplay.pp_funcs->set_power_state((adev)-
> >powerplay.pp_handle))
> -
>  #define amdgpu_dpm_post_set_power_state(adev) \
>  		((adev)->powerplay.pp_funcs-
> >post_set_power_state((adev)->powerplay.pp_handle))
>=20
> @@ -280,100 +277,13 @@ enum amdgpu_pcie_gen {
>  #define amdgpu_dpm_enable_bapm(adev, e) \
>  		((adev)->powerplay.pp_funcs->enable_bapm((adev)-
> >powerplay.pp_handle, (e)))
>=20
> -#define amdgpu_dpm_set_fan_control_mode(adev, m) \
> -		((adev)->powerplay.pp_funcs-
> >set_fan_control_mode((adev)->powerplay.pp_handle, (m)))
> -
> -#define amdgpu_dpm_get_fan_control_mode(adev) \
> -		((adev)->powerplay.pp_funcs-
> >get_fan_control_mode((adev)->powerplay.pp_handle))
> -
> -#define amdgpu_dpm_set_fan_speed_pwm(adev, s) \
> -		((adev)->powerplay.pp_funcs-
> >set_fan_speed_pwm((adev)->powerplay.pp_handle, (s)))
> -
> -#define amdgpu_dpm_get_fan_speed_pwm(adev, s) \
> -		((adev)->powerplay.pp_funcs-
> >get_fan_speed_pwm((adev)->powerplay.pp_handle, (s)))
> -
> -#define amdgpu_dpm_get_fan_speed_rpm(adev, s) \
> -		((adev)->powerplay.pp_funcs-
> >get_fan_speed_rpm)((adev)->powerplay.pp_handle, (s))
> -
> -#define amdgpu_dpm_set_fan_speed_rpm(adev, s) \
> -		((adev)->powerplay.pp_funcs-
> >set_fan_speed_rpm)((adev)->powerplay.pp_handle, (s))
> -
> -#define amdgpu_dpm_force_performance_level(adev, l) \
> -		((adev)->powerplay.pp_funcs-
> >force_performance_level((adev)->powerplay.pp_handle, (l)))
> -
> -#define amdgpu_dpm_get_current_power_state(adev) \
> -		((adev)->powerplay.pp_funcs-
> >get_current_power_state((adev)->powerplay.pp_handle))
> -
> -#define amdgpu_dpm_get_pp_num_states(adev, data) \
> -		((adev)->powerplay.pp_funcs->get_pp_num_states((adev)-
> >powerplay.pp_handle, data))
> -
> -#define amdgpu_dpm_get_pp_table(adev, table) \
> -		((adev)->powerplay.pp_funcs->get_pp_table((adev)-
> >powerplay.pp_handle, table))
> -
> -#define amdgpu_dpm_set_pp_table(adev, buf, size) \
> -		((adev)->powerplay.pp_funcs->set_pp_table((adev)-
> >powerplay.pp_handle, buf, size))
> -
> -#define amdgpu_dpm_print_clock_levels(adev, type, buf) \
> -		((adev)->powerplay.pp_funcs->print_clock_levels((adev)-
> >powerplay.pp_handle, type, buf))
> -
> -#define amdgpu_dpm_force_clock_level(adev, type, level) \
> -		((adev)->powerplay.pp_funcs->force_clock_level((adev)-
> >powerplay.pp_handle, type, level))
> -
> -#define amdgpu_dpm_get_sclk_od(adev) \
> -		((adev)->powerplay.pp_funcs->get_sclk_od((adev)-
> >powerplay.pp_handle))
> -
> -#define amdgpu_dpm_set_sclk_od(adev, value) \
> -		((adev)->powerplay.pp_funcs->set_sclk_od((adev)-
> >powerplay.pp_handle, value))
> -
> -#define amdgpu_dpm_get_mclk_od(adev) \
> -		((adev)->powerplay.pp_funcs->get_mclk_od((adev)-
> >powerplay.pp_handle))
> -
> -#define amdgpu_dpm_set_mclk_od(adev, value) \
> -		((adev)->powerplay.pp_funcs->set_mclk_od((adev)-
> >powerplay.pp_handle, value))
> -
> -#define amdgpu_dpm_dispatch_task(adev, task_id, user_state)
> 	\
> -		((adev)->powerplay.pp_funcs->dispatch_tasks)((adev)-
> >powerplay.pp_handle, (task_id), (user_state))
> -
>  #define amdgpu_dpm_check_state_equal(adev, cps, rps, equal) \
>  		((adev)->powerplay.pp_funcs->check_state_equal((adev)-
> >powerplay.pp_handle, (cps), (rps), (equal)))
>=20
> -#define amdgpu_dpm_get_vce_clock_state(adev, i)
> 	\
> -		((adev)->powerplay.pp_funcs->get_vce_clock_state((adev)-
> >powerplay.pp_handle, (i)))
> -
> -#define amdgpu_dpm_get_performance_level(adev)
> 		\
> -		((adev)->powerplay.pp_funcs-
> >get_performance_level((adev)->powerplay.pp_handle))
> -
>  #define amdgpu_dpm_reset_power_profile_state(adev, request) \
>  		((adev)->powerplay.pp_funcs-
> >reset_power_profile_state(\
>  			(adev)->powerplay.pp_handle, request))
>=20
> -#define amdgpu_dpm_get_power_profile_mode(adev, buf) \
> -		((adev)->powerplay.pp_funcs->get_power_profile_mode(\
> -			(adev)->powerplay.pp_handle, buf))
> -
> -#define amdgpu_dpm_set_power_profile_mode(adev, parameter, size) \
> -		((adev)->powerplay.pp_funcs->set_power_profile_mode(\
> -			(adev)->powerplay.pp_handle, parameter, size))
> -
> -#define amdgpu_dpm_set_fine_grain_clk_vol(adev, type, parameter, size)
> \
> -		((adev)->powerplay.pp_funcs->set_fine_grain_clk_vol(\
> -			(adev)->powerplay.pp_handle, type, parameter,
> size))
> -
> -#define amdgpu_dpm_odn_edit_dpm_table(adev, type, parameter, size) \
> -		((adev)->powerplay.pp_funcs->odn_edit_dpm_table(\
> -			(adev)->powerplay.pp_handle, type, parameter,
> size))
> -
> -#define amdgpu_dpm_get_ppfeature_status(adev, buf) \
> -		((adev)->powerplay.pp_funcs->get_ppfeature_status(\
> -			(adev)->powerplay.pp_handle, (buf)))
> -
> -#define amdgpu_dpm_set_ppfeature_status(adev, ppfeatures) \
> -		((adev)->powerplay.pp_funcs->set_ppfeature_status(\
> -			(adev)->powerplay.pp_handle, (ppfeatures)))
> -
> -#define amdgpu_dpm_get_gpu_metrics(adev, table) \
> -		((adev)->powerplay.pp_funcs->get_gpu_metrics((adev)-
> >powerplay.pp_handle, table))
> -
>  struct amdgpu_dpm {
>  	struct amdgpu_ps        *ps;
>  	/* number of valid power states */
> @@ -598,4 +508,74 @@ void amdgpu_dpm_gfx_state_change(struct
> amdgpu_device *adev,
>  				 enum gfx_change_state state);
>  int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
>  			    void *umc_ecc);
> +struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct
> amdgpu_device *adev,
> +						     uint32_t idx);
> +void amdgpu_dpm_get_current_power_state(struct amdgpu_device
> *adev, enum amd_pm_state_type *state);
> +void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
> +				enum amd_pm_state_type state);
> +enum amd_dpm_forced_level
> amdgpu_dpm_get_performance_level(struct amdgpu_device *adev);
> +int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
> +				       enum amd_dpm_forced_level level);
> +int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
> +				 struct pp_states_info *states);
> +int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
> +			      enum amd_pp_task task_id,
> +			      enum amd_pm_state_type *user_state);
> +int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char
> **table);
> +int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
> +				      uint32_t type,
> +				      long *input,
> +				      uint32_t size);
> +int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
> +				  uint32_t type,
> +				  long *input,
> +				  uint32_t size);
> +int amdgpu_dpm_print_clock_levels(struct amdgpu_device *adev,
> +				  enum pp_clock_type type,
> +				  char *buf);
> +int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
> +				    uint64_t ppfeature_masks);
> +int amdgpu_dpm_get_ppfeature_status(struct amdgpu_device *adev,
> char *buf);
> +int amdgpu_dpm_force_clock_level(struct amdgpu_device *adev,
> +				 enum pp_clock_type type,
> +				 uint32_t mask);
> +int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev);
> +int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t
> value);
> +int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev);
> +int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t
> value);
> +int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
> +				      char *buf);
> +int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
> +				      long *input, uint32_t size);
> +int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void
> **table);
> +int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
> +				    uint32_t *fan_mode);
> +int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
> +				 uint32_t speed);
> +int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_device *adev,
> +				 uint32_t *speed);
> +int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_device *adev,
> +				 uint32_t *speed);
> +int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_device *adev,
> +				 uint32_t speed);
> +int amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
> +				    uint32_t mode);
> +int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
> +			       uint32_t *limit,
> +			       enum pp_power_limit_level pp_limit_level,
> +			       enum pp_power_type power_type);
> +int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
> +			       uint32_t limit);
> +int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev);
> +int amdgpu_dpm_debugfs_print_current_performance_level(struct
> amdgpu_device *adev,
> +						       struct seq_file *m);
> +int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
> +				       void **addr,
> +				       size_t *size);
> +int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev);
> +int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
> +			    const char *buf,
> +			    size_t size);
> +int amdgpu_dpm_get_num_cpu_cores(struct amdgpu_device *adev);
> +void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev);
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ef7d0e377965..eaed5aba7547 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -470,9 +470,6 @@ bool is_support_cclk_dpm(struct amdgpu_device
> *adev)
>  {
>  	struct smu_context *smu =3D &adev->smu;
>=20
> -	if (!is_support_sw_smu(adev))
> -		return false;
> -
>  	if (!smu_feature_is_enabled(smu, SMU_FEATURE_CCLK_DPM_BIT))
>  		return false;
>=20
> --
> 2.29.0
