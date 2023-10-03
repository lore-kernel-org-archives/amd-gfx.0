Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED94EE75455
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 12:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4B5A10E090;
	Tue,  3 Oct 2023 12:58:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 587B210E04E
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 12:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zl4kiIchHqBQTCMg+l+EmCTuuKyrqHaELz/9doBRgtpsfENiZV/oJyGhbjqb6DpqDuRuUT83aPOTI1nmdMDiAtL3yUJT6B4EQE1BNNoLSx+gDX4LjPuBhNMH1cEz6rOT7hr0QeDhFricjm/WuNQk41sSTZ7QZHu0Ul9OeoU7sHhms51RYHWJO/SL9Kc9+wYQfVM7gb1H4nnUqr+7QB5I55RheT233mDk5c2dEV2KLH1sUH9vEyrOA6V8jm88k08t9UlTtXLjfFrtfsj+ziZZfWmEM9VPKbvnRgHhieG8bs0q6gAgFyTh3as+OB2NW9yMXS64oRC4pu/rg/oS3buHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GLqT1C2rmTEXbma6hVTpi+B7Ayi02gCaW7/g5HPPnM=;
 b=ifSI0hmYBONXZOh4bDWvAEWwHCb7OyqGR/P5TvyL+mm9dog4PDoMi+LqxBZQjkgNuf2PUmV1h/2K9tnYcEbZ7uVwpIHSlBVOCDvThVK6fO/l3um++v2DpLE0xu0kQcKPDiZqxilYGibPBy/XtL6PmGb+zjOr9DOqGL4pMIk1xgXbF+pTib7nZ4AuErJ7YYIlOEowoKpUMHQ6kwdk342cSmmU5pVn+JwFmunJfM1IExvhYZkpTXyEut9XQ7VcY8Wqz2RymJ73CHjb/DjxSAnGRG89fsN5BLxCgnD22ZQgaR+EvlRgg5FItGejmlUsp7p7u01vX0r3qLxQXBX2xEoUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GLqT1C2rmTEXbma6hVTpi+B7Ayi02gCaW7/g5HPPnM=;
 b=AUPGki2/azw4AcKKzReOWMHiukvf83DqzTZriY5DjqpYT6N2kOBbyCCUDgWOKgtr6Cj8cHRVI9EPHAXuQA5ls55OmI49ecQ3DeSTCIrlEQ+GG1CFBilIxnKqb9E0K6BEI2ZXbxH+teaHJZ9WTOt1685CMX4kWz3kmysJN6036dY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB5879.namprd12.prod.outlook.com (2603:10b6:510:1d7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Tue, 3 Oct
 2023 12:58:04 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%7]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 12:58:04 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/3] drm/amd: Move evict resources suspend step to
 prepare()
Thread-Topic: [PATCH v2 2/3] drm/amd: Move evict resources suspend step to
 prepare()
Thread-Index: AQHZ9ZAQTQEtfo/dPkOaZTLUpkz1i7A4Bz8Q
Date: Tue, 3 Oct 2023 12:58:04 +0000
Message-ID: <BL1PR12MB51448F08D484175DE8D4C8BDF7C4A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231002224449.95565-1-mario.limonciello@amd.com>
 <20231002224449.95565-3-mario.limonciello@amd.com>
In-Reply-To: <20231002224449.95565-3-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1c8ff2de-0720-47d0-9448-59dc4e732959;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-03T12:57:38Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB5879:EE_
x-ms-office365-filtering-correlation-id: 64f20ec4-025a-4141-57b8-08dbc4106219
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tjiknESpL+ySOloDUIXiKgdznP6UBE36kMsJA/qN5+YXzTlFELhbbNzqdJFvu9GDL9z6xpBSvpRoPTysOnMKsvwQSLR8R0/dQhDAP3YE4+uleHrC6GKUmZr5BF5bZizOVKTC8floCxKyO0DqEnQ1POowSNUj+46flIC9nyBA79RErPJFu36CFRbeo3O4JL/3DUzXuc9LzUOYaRHYERp98+cVXyLeWbNITaMFKz/KgoZ6dZckOg/lUcx9nmQ3p+Ud3MBW3gG9zdsQEFGdMBR2gwGa1MP/nwJqHW4UXpv4vS1A0paPjo1rDXLw/LB/F6oroEgSJsLrxlR6amtWbbHLxan2b3i3S3s+ZJ/vfDux+ewVAz8LAE2d+VUfE3qH2agheBcfOENof3C4tVxUWGwilXJEYbL+LZDnzDZpn2sAKCATsj8NUkE02rT0Amb0LXEaVgnZlmUkDdH7wFzB5WGyCfeLDeCYfxJAyfYGIWQ23UZgoye2oUjV/IBmhMh6M/c8ek/PN4wYXnHgEcD27U+UFpr+TOTSy1gByydJpl2TdX7bj1u67BmeqbAAqrWcqx6Dj4tfPYGnVyf87bOAY0EpfgguFALLNF8NIYEPn+ELmJc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(33656002)(41300700001)(15650500001)(86362001)(54906003)(64756008)(66446008)(66476007)(66556008)(53546011)(316002)(478600001)(66946007)(966005)(76116006)(110136005)(71200400001)(83380400001)(2906002)(4326008)(7696005)(6506007)(8936002)(8676002)(52536014)(5660300002)(122000001)(9686003)(38100700002)(38070700005)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LazazR4YyO5y5hk1fYlO7vi34CKJq8uXugTN74zhFNRQrsyPbUpKk9be/h8E?=
 =?us-ascii?Q?sckJsH/7Te3JnQqjwawmzzt7vFEyhnpWpKUHaQk+fO2eWTsv/gQtUSMYans0?=
 =?us-ascii?Q?HxL4BHUhccWWX/JnwOtd2XW36GLdtVCp9GWdTyLPYWmpNAgTHFDzzugZRrnH?=
 =?us-ascii?Q?s6N6fBtmDoapDF3rordxeM+4z9ZKcPpEIUhFWElFX5wQBipzl47uORGRIICm?=
 =?us-ascii?Q?YaIYNGm9FEkivhYTAzDvS1q1ZzGX4P+3EZykSGu1ofpgfgSofdOVlo0MMG1g?=
 =?us-ascii?Q?goY6R/bzuVS3ROZGopnCihDiXPIfW+CuxdH5zLpLiuH0M+xG675LKrSwnapJ?=
 =?us-ascii?Q?lfP5QGcR7g+Qc+INrL8RYD46rF3G8E+5r15o7tN2/lEwgCqJkaSCuasG8Izq?=
 =?us-ascii?Q?V6gKrSmsQRaPfgrPKqZq54OzuOffpiZ/XjFDnK49EB+G4rGb9jSriGXgkeGa?=
 =?us-ascii?Q?bb4QhXwzXaB9+S4RiKqDmgoWQRhzThxi2CzIwHG4kjuJyVIMH5BERJ3DGdKX?=
 =?us-ascii?Q?IES1uh+PvKI2O9pNduCYlq5saypWRRPz8wYRrQGgup7ulKfTSXcCS/g1csh3?=
 =?us-ascii?Q?Ny8YHuuMrh3/rxbs+GKOGDuH+u2Gd6/ep/aN71AP6LUlQ2yMdJGsmg5waTfB?=
 =?us-ascii?Q?m64yv9PWYnIUM1jIB9lwBrUY8BIcns+FZ6ShGu79PJvEia5qXcrhu3A6y+wS?=
 =?us-ascii?Q?4fnbWqgJp6GwkUNibz5ESzJ4aXA+7R+KzpqUji96gAAuo8Cdb2e6phxac9E/?=
 =?us-ascii?Q?LMVbGaElrOafnRMXvEUeP9SghJyPVXzbNvELNdXFFwYCnQ42i9BOO0z//WQo?=
 =?us-ascii?Q?lvDd43LQJmmRpTKo1p4wsrHsf1gN6lNBBT9kHsmyEzK8mBKu6QUqXxHqGT67?=
 =?us-ascii?Q?WnVZxjQKXRexqSJxFcknW4/W7yDHVbhRs86sGzf37UaaAO0XKTmgLF+R8Bhs?=
 =?us-ascii?Q?JNHeQTdWH/g+mQQMV9vVDOViu5JuL8SdAxYEX1zRv+gjefQqLjwxM70ITWR2?=
 =?us-ascii?Q?EllBlL1674Bs29sl/ybOq4cvCVeid6DqGYPotLTvyaBOAYPnm/eUBrO4tRtq?=
 =?us-ascii?Q?gn6WcgFEziYh2FSOW2RvwJxMPtiPmKoHik0tumy7D3y+SFWOKodI9hYQIliV?=
 =?us-ascii?Q?30XDlXjSS0+PLDIOUFVvlESF7k83vjcRb/yQ0vH/Z/KSNZcuJzEYfC8bepVt?=
 =?us-ascii?Q?rWKwBtsW4BACN8sS7s3iHRTviVbsCOntZK1oFSBlG+Aahbf49rQZk6fD5AWx?=
 =?us-ascii?Q?BjB72B2E1zoaDQh3Ux2aAHp4MYbIAghj3iGYDrmdSCzXbx/04oPeHwjul45/?=
 =?us-ascii?Q?+BV6g/j1cyMW3Ttx6uSg//WtD4DA3f4DJIrwdWfLGqtu02StjlgLO/91VD44?=
 =?us-ascii?Q?p3f04mJJuSdI3UnhbG/1qObDtHBlMUZHuj+biJ8Cw73f4/aT9EMrOvdsm/P/?=
 =?us-ascii?Q?NYooXXoF+FjN8FJHUrao2das9PReXtrRx5V/rP+0gUnx8qzpykgCO9qIUidF?=
 =?us-ascii?Q?pzURbAG+n6AUPCE90A+Qf6J8t4KcVv6i4hBNe+K3fKUmexWAlR/z9/l9MA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f20ec4-025a-4141-57b8-08dbc4106219
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 12:58:04.7353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/Ds9B0CVgaWBOsgNIblCc2Rb0w1mVVN6vJjO/PKBW9nqHpCjMvZLTt6AzvlXwEfOsvbtFKiIHgGgQLLH0VmmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello
> Sent: Monday, October 2, 2023 6:45 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH v2 2/3] drm/amd: Move evict resources suspend step to
> prepare()
>
> If the system is under high memory pressure, the resources may need to be
> evicted into swap instead.  If the storage backing for swap is offlined d=
uring
> the suspend() step then such a call may fail.
>
> So instead move this step into prepare(), while leaving all other steps t=
hat put
> the GPU into a low power state in suspend().
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c41d69e7a8f5..bb0e753fb6f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4276,6 +4276,11 @@ int amdgpu_device_prepare(struct drm_device
> *dev)
>       if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
>               return 0;
>
> +     /* Evict the majority of BOs before grabbing the full access */
> +     r =3D amdgpu_device_evict_resources(adev);
> +     if (r)
> +             return r;
> +
>       return 0;
>  }
>
> @@ -4297,13 +4302,6 @@ int amdgpu_device_suspend(struct drm_device
> *dev, bool fbcon)
>       if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
>               return 0;
>
> -     adev->in_suspend =3D true;

This shouldn't be dropped.

Alex

> -
> -     /* Evict the majority of BOs before grabbing the full access */
> -     r =3D amdgpu_device_evict_resources(adev);
> -     if (r)
> -             return r;
> -
>       if (amdgpu_sriov_vf(adev)) {
>               amdgpu_virt_fini_data_exchange(adev);
>               r =3D amdgpu_virt_request_full_gpu(adev, false);
> --
> 2.34.1

