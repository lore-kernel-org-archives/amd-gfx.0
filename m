Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10538C76195
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Mar 2023 02:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2801A10E050;
	Sat, 25 Mar 2023 02:10:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3461C10E050
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Mar 2023 02:10:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSyyKJxXTTUT16YcZvNRvBTUrrWH7PiLl5ttnLISOp3PWLx6i7DJXVEFfTNkvc2LkI5U3lV8ieFT51GpPFZBBHOUjSk2xrx0/jCwuPM/QeGrwgU5f2XRxt4JVssab1tIwauDEACOW1c265fi6FjrqQ53McnpSX+Ht2NAbV/ws5M+TLE+no97SVs46u0v3BtsGtOigeCWTCOVaCTtxOidaV174X4f6b6YuGrYWxD4ia8dvuuv9GqOfJl8ujZkwNBzUMLKRgKMcf8g1K30ryAgR8bxVFYsqPIufiQBbS8tymXeXhek8I8xsooVbsJWT5mGx4PUPPa23i+smL5aVIbXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzDcSWXY4VD/tOdMBeJ+MPhu90V5MeL5fGE4N/3Gx0g=;
 b=aHTFikwf6sCStHpyrsH24aIDuo3JMaMZJt27aS8aI+Jac1xbeWwn5a3mPw1O9JKpWjgYik3NVv3vDp8auA3vPohNK/ndAyui4e1qAU2qtAvC7M5mdBpHCtr7LED0WaE/2vxDNQqja6ACCL3UQK4u2J9thnrKYUcPSWfnQH09XehHXzkSiVmJUBrlPSSJFn4Zhme4QB86i8js4VPAYtiab6V0LVAOXFetpQt1D694T7JXCtP9549kkmD8hOG/YEMbc6myVV96NAluf+pdaMtkwVk0yPl2VQGWi8nb0Py9EgtBpXul7itdW/PzoEAfibTGC6X/1XqFMI2XFKNZgwzsvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzDcSWXY4VD/tOdMBeJ+MPhu90V5MeL5fGE4N/3Gx0g=;
 b=n+Qxi2IZ0xpe0BXiPRGRvaOImMZIRgO9JiTorHiGRMGMcqIDum7Yf5gmwvxdcl7zquR+vhKAiwKSu9wv1VTH1cJL75xzrV6umgI+0bthX05JtUll076U1wpFpsYWeF+79AQTehWNOKNsdlKSvECUI5jvFLD6w0I0FNO1GkmVwpc=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by PH7PR12MB6693.namprd12.prod.outlook.com (2603:10b6:510:1b0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sat, 25 Mar
 2023 02:10:13 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::2bd0:2a4:c590:40f2]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::2bd0:2a4:c590:40f2%6]) with mapi id 15.20.6178.038; Sat, 25 Mar 2023
 02:10:13 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: re-enable the gfx imu when smu resume
Thread-Topic: [PATCH] drm/amd/pm: re-enable the gfx imu when smu resume
Thread-Index: AQHZXh+B7xvV3d5R+USFW0xcMvXlaa8JhN8AgAE5ORA=
Date: Sat, 25 Mar 2023 02:10:13 +0000
Message-ID: <BY5PR12MB387348E49AB0FECB591D2D87F6859@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20230324070812.1304117-1-tim.huang@amd.com>
 <DM6PR12MB2619B6EE8AEC9FC8A9632D4BE4849@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619B6EE8AEC9FC8A9632D4BE4849@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=39c50ea7-c81f-4b18-b279-d0e948f9c3b6;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-25T01:57:49Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|PH7PR12MB6693:EE_
x-ms-office365-filtering-correlation-id: 16ded041-7f01-46b6-897e-08db2cd611b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3isrG89p/lyK2w/vqjv3eXbfIWDMLt2/R4qxVcB1M4d5c9TTQJo9e9A/6kUrlR8CiSDduyvds3Utg7cdYmYgBpOadfGx4lRiQiQfdPfMNuqck62Cmc5B+6/80Kku3S7wQXHe4AB5J8Yk+hk2fmM3vYJ+AuQzp/iPD9cPOXoJcpc9bds5p4v9Atau00nwHYm3THqWsICFQ25rGZx69yr/+EgQyqnBCy6pxZtJmN/cJGuhW+ybUFjf9zLxKtuxubOnpkp9ggJL1zyVqqp5HBjadUukK+B83T/VMJJqEU6UGfT1jDD6ogB1KKUPdVD3g9CGbefTzNo5b9nRygBpTjXuP84QTZt6L+m2iCAv++7R+4JaVJ9DvNu6EewT7R5F1rwDG6W1S0PgLmFY+O85QOeTphD2cepYV3+TBIBgY6np5x5/0akHJErdqRAlh20mbHm4Ny36DGxn5NCfIF5afGVWJdEbMGVlC6YQlhJBbgbIXdRbPYaypGrwS1uTzGcQnhHjMu9qt7EHpHLsuoQ9C9Ibu5ShU2ism44w15IEv49OhQEShUcSIwddGNCsopW5MDMuU266RXynSoIZNxgtqQ8S89sBEM/c0l3pBaKOZOoyJz7SmXOVlMrHuLpPH9JPOgzEoEuoLVW/vw65SBQMUkyQXjuRky4bT/xLzXe+J0VMPbVg0I7d43x7FrlWdvx82BW9T/VZ91M+R1xnIutU3Z1RGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199021)(478600001)(55016003)(38070700005)(66946007)(76116006)(64756008)(52536014)(66446008)(38100700002)(4326008)(66556008)(41300700001)(53546011)(54906003)(122000001)(66476007)(5660300002)(83380400001)(8936002)(316002)(9686003)(2906002)(71200400001)(6506007)(33656002)(26005)(8676002)(86362001)(7696005)(186003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KFhTWvcorV5JUh75bzCAcv3QjvF7rUJcLe71bOy+CrGS4KnFIgZxaIJ/B+JS?=
 =?us-ascii?Q?WORDXKG689GwjFDIBYcxN2tq6JdFPjoNLT0YpHIsImo3hoVQ8t0Yuu5Wuq9v?=
 =?us-ascii?Q?ll+zkwONqKIj3meUugw9ohZnOgMH/H+sNjPes1KbMWGGTtiEm4Z1CnQiXRTE?=
 =?us-ascii?Q?6WLQOUw+KQQ2Sgmh7jljtqs6VWxSBPJkcZxNSIl3cwoklbTBholJ0eytLYIw?=
 =?us-ascii?Q?JMukoeh2GhGCYbZhQ9E2VCFcJZTN9vUFU1Lto9CjJ9jsuTmE1ykUkodS5qTq?=
 =?us-ascii?Q?eZvIJhKLPvWJBnhsZzBpUkFb9WVANWCXYKvcjPL3IbDyMJh7YMpg9JIQnngi?=
 =?us-ascii?Q?3Lt3inOvFOOOld0twG979cLX9El2ozCW2IAz294OcTHijT+8KqS5v1bIw/GP?=
 =?us-ascii?Q?7hB0g7ji+iqmuzKuq9CIbGZpOQOVNT1jAKV8D/Eu85dFLzeJ0tb4osoyD0Vc?=
 =?us-ascii?Q?+3lmTNPkRMex+tn8CmuBqi+v177T9B0gfriFW0iwxP0mYtHCPpYRQVLmE9Qm?=
 =?us-ascii?Q?w/3ZYNV6kK5xu1frq2707xAdi1YnFSTVoTBzdu7HJPcNTcCWevBo7MsJatgO?=
 =?us-ascii?Q?F1Bk9pl9SzCPZBlYtlRz6MXm44VhPJL8zN1uVHd8+xUoLuMWVg7JqpsuiyaK?=
 =?us-ascii?Q?iuknF9k3R2xS7AmU+O+ZFkQz/cpsiClWXtdvJppxQis3uxeGuNj4+Va0R8g8?=
 =?us-ascii?Q?zrx4UFAUvHCJ2gDZ8o3ATBXUNKk817yZjusMizApGLtmnwwGAQOj9eULN+g/?=
 =?us-ascii?Q?px/i+88BylNJMvsOFtKNtBTQoF+C67G7h2TOOZGyHFvlyyzQegYzRe9hpfu0?=
 =?us-ascii?Q?pxM2Ti5fmWCT1dMPGYVPMhO+Omzn1fmVHmJ2A6iAMKLnAQRA4/JMolHvM+Qe?=
 =?us-ascii?Q?DNb0RghrOTbqg7bhNBUfU2v7ap7F9JbeySC1705Mv3wOX9QfIcyvvQg59eZa?=
 =?us-ascii?Q?8KcuqrAIALPxbtGWQou9o/fsra8+RlzYwegMsk2iErR6lXiTde8xogkMTvyP?=
 =?us-ascii?Q?Q4Su/Ctt5Yh7rlHGdd6nWcGAuitOG0vkiUnWFYVkh5BpVbzYzAwiQxHDAfI9?=
 =?us-ascii?Q?GkB8FojB5Wj/I4xlQvGgIVfdZvUMFKOXbeMIO0fWYtb4jgbTa5O8hxuW1na7?=
 =?us-ascii?Q?TEi+Ew4TMvrKW9+YknG0wQW0Zs1e7N1YFE6rjrhDkeht42XvlTl57VcNTJeR?=
 =?us-ascii?Q?jqHqC83vg8/GxeffoT5Jrn80xoI4cixdmqJb3VJR5mf2kUWVITN9KHUoJYwX?=
 =?us-ascii?Q?Kr4Skvhpb8QF6Ql8e8fEZee93FKWdDeLopYsWYDkEgnTFDdnMq1Wvi1W+MI8?=
 =?us-ascii?Q?yrAxOuQBNaK6KPlhkFSIznKYB3A1tHQbRPn6fmcUwqv01TZcAkvEzv3hBayp?=
 =?us-ascii?Q?LfL4xg+ypobLoBNGTcldAUeffHKNwjGu8PziNgXmzCP4o8Cy++0dvIxaZlBc?=
 =?us-ascii?Q?Fu0Xm3mR+05dtkYaf3L2Nbmttspja/F7i437fkAHRv98lL4nI3PqjyrXtKjP?=
 =?us-ascii?Q?QkLIpGvOSXOiVFIQInjKH36Oj66RXxBoJ3/hKpDMmPi9scol91maQePosM0U?=
 =?us-ascii?Q?rqbiphXcjWy+GUdCclpExd+YlxAZz/0bnOyoO580?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ded041-7f01-46b6-897e-08db2cd611b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2023 02:10:13.4125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBSjCaz3s3qV/Wnr6UoZsfJd0CHubLrqvBxwMJYhRzYlOq2xnS2YZRacBR4wj0r3UtPq0hiz7p0Zx6/igH7WtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Ma, Li" <Li.Ma@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, March 24, 2023 3:17 PM
To: Huang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Ma, Li <Li.Ma@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; H=
uang, Tim <Tim.Huang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: re-enable the gfx imu when smu resume

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tim
> Huang
> Sent: Friday, March 24, 2023 3:08 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Ma, Li <Li.Ma@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: [PATCH] drm/amd/pm: re-enable the gfx imu when smu resume
>
> If the gfx imu is poweroff when suspend, then it need to be re-enabled
> when resume.
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 40
> ++++++++++++++++-------
>  1 file changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b5d64749990e..94fe8593444a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -162,10 +162,15 @@ int smu_get_dpm_freq_range(struct smu_context
> *smu,
>
>  int smu_set_gfx_power_up_by_imu(struct smu_context *smu)  {
> -     if (!smu->ppt_funcs || !smu->ppt_funcs-
> >set_gfx_power_up_by_imu)
> -             return -EOPNOTSUPP;
>> This assumes that all APUs need to support the ->set_gfx_power_up_by_imu=
 int interface.
>> Otherwise, the driver loading will fail?
>>Is that expected?

>> Evan


Only the GFX11 APUs that have the IMU need to support the ->set_gfx_power_u=
p_by_imu interface.
Before it should be ok as it only be used for backdoor FW loading in imu_v1=
1_0.c, now It will be used for more case,
then return EOPNOTSUPP should not be expected. Thanks.

Tim

> +     int ret =3D 0;
> +     struct amdgpu_device *adev =3D smu->adev;
>
> -     return smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
> +     if (smu->ppt_funcs->set_gfx_power_up_by_imu) {
> +             ret =3D smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
> +             if (ret)
> +                     dev_err(adev->dev, "Failed to enable gfx imu!\n");
> +     }
> +     return ret;
>  }
>
>  static u32 smu_get_mclk(void *handle, bool low) @@ -196,6 +201,19 @@
> static u32 smu_get_sclk(void *handle, bool low)
>       return clk_freq * 100;
>  }
>
> +static int smu_set_gfx_imu_enable(struct smu_context *smu) {
> +     struct amdgpu_device *adev =3D smu->adev;
> +
> +     if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP)
> +             return 0;
> +
> +     if (amdgpu_in_reset(smu->adev) || adev->in_s0ix)
> +             return 0;
> +
> +     return smu_set_gfx_power_up_by_imu(smu); }
> +
>  static int smu_dpm_set_vcn_enable(struct smu_context *smu,
>                                 bool enable)
>  {
> @@ -1396,15 +1414,9 @@ static int smu_hw_init(void *handle)
>       }
>
>       if (smu->is_apu) {
> -             if ((smu->ppt_funcs->set_gfx_power_up_by_imu) &&
> -                             likely(adev->firmware.load_type =3D=3D
> AMDGPU_FW_LOAD_PSP)) {
> -                     ret =3D smu->ppt_funcs-
> >set_gfx_power_up_by_imu(smu);
> -                     if (ret) {
> -                             dev_err(adev->dev, "Failed to Enable gfx
> imu!\n");
> -                             return ret;
> -                     }
> -             }
> -
> +             ret =3D smu_set_gfx_imu_enable(smu);
> +             if (ret)
> +                     return ret;
>               smu_dpm_set_vcn_enable(smu, true);
>               smu_dpm_set_jpeg_enable(smu, true);
>               smu_set_gfx_cgpg(smu, true);
> @@ -1681,6 +1693,10 @@ static int smu_resume(void *handle)
>               return ret;
>       }
>
> +     ret =3D smu_set_gfx_imu_enable(smu);
> +     if (ret)
> +             return ret;
> +
>       smu_set_gfx_cgpg(smu, true);
>
>       smu->disable_uclk_switch =3D 0;
> --
> 2.25.1
