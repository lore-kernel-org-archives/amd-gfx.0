Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E293AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 13:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F14931132B5;
	Tue, 26 Jul 2022 13:36:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D55210F83E
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 13:36:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqosKjuLhgrKCeKWBewfd3zvxgTuAXIwA3tpm2vk8/5HdOazWBXTTwuLtjTnwrdLdFH3GLXtRE3drHENA4YgnkP9ZNu6yFh1nL56ZBMIaA+yqVp1chljQXw/CAt90f+ZJfcxV5waxNDXNqS+vo5JwcyrSzAedFquUVSWWftdINU/NeZUHK0O6JnjEGJJOfTPazcSCN6tvXvbQEbacm0lHpTYoFSv4I2zF2B0c+7bytWew691/pIwowKgJqCjyrvCZNnF1C6epzkMxxyAmCiX+sCW33QxNQrgoDuGdCAckr4bU5BARqxEXzAXRrUD6u9zMqVOUZboIGiWRZxVGz/+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiD9vJLjiC1HtbKHyRdqQ3gvkrI2NXj0P7zCrS3ELCM=;
 b=cLRsV54bEZVcvu5R6rK3bxawXW2jyh0NN046Vu9W0/2BwyhMIU/g6VanF0lxuyQoYsxq5G9WKw+j48pUwTkJp6uDZarI641VBtTiirPwgc+sHdCewunU9OjcRO5JX/vIjlOzAGyLwsSMOnqaPV1d0Q0NIL48Sck8S6N7vElc2LqryhVjo7UiHPvQUOcvOdj4o3Z5rYljAXH//1Zh4bOFhF2g84IwQGHtIevuIq7c+nuBYf4p/UQGerUHAG2T21uoGC5vdtqoHbXI8kmrx7lgPMXMFkEFPBVc3d+kQbdLLYXJxs5k8zZOlHSRNqG9bdhMy7TTfqxIkp4PlWyHjuKiEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiD9vJLjiC1HtbKHyRdqQ3gvkrI2NXj0P7zCrS3ELCM=;
 b=jQaiHlWmj8lSx3bD65TfO0VI7JOd/sieUaq0pOwakmDTq6+0GMDXqVrmVmY5PTfeCkeYJ+zjbhiQ9HlpE5feJI7Z1mmpBIVyGptwfpdriCNanAbkGW9tL0fvZgufDwFdspqa0jZLAjE+W2CkCVJAeHflcTzPdEbdzgnwBtrgA5E=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.18; Tue, 26 Jul 2022 13:36:27 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::edf8:621:a15d:4447]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::edf8:621:a15d:4447%9]) with mapi id 15.20.5458.020; Tue, 26 Jul 2022
 13:36:26 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Guo, Shikai" <Shikai.Guo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/pm: Add get_gfx_off_status interface for
 yellow carp
Thread-Topic: [PATCH v2] drm/amd/pm: Add get_gfx_off_status interface for
 yellow carp
Thread-Index: AQHYoLkUldQOnmjRV0ikGKLnEZsJkq2Qp2gw
Date: Tue, 26 Jul 2022 13:36:26 +0000
Message-ID: <DS7PR12MB6005E7632BF4601417A0ED41FB949@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20220726062905.3323207-1-shikai.guo@amd.com>
In-Reply-To: <20220726062905.3323207-1-shikai.guo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=32b7db4f-070d-4702-82d9-53ea592ea117;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-26T13:36:18Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f350a4b0-d4f3-4d3c-91b3-08da6f0bd708
x-ms-traffictypediagnostic: DM4PR12MB5248:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Qv78f4KvAdLFyNhkYtcnSkaRPMMddhvX+Iph4lHiYbBEhZAHsGb7we2+4Dc/KE92BxXZHb1a+zNJkE3Fk5hvO1r3ob+D3EX7zr+2ArC+qn953hlffxABqNEO3FWz3dyqArsc+ciEoum0gXOqUo9g99rh0LHWUELxrsREffyONov0dLTuy7cO7CuF+XcEeRvPAL/MyrFXidmUhIGjyTpQqZ7DOMDzjVVS4uAig2wbCXdQjq9L2s/VuJ7/AYxMkmWkrkMI6d7iCME9b62N4bvmNr3n5/iVtnZEZcIvfnjXwAb7V2+GONTvqCyrQ9zq4W4dcPpe29Db/JW19EEPbivo3Jx99elbgQho5QqRrSs6hIdSWKTSQH64E0x//g4UXgWyuxDWxb5hYGdo1EEVp92ZUCywNZGjlPz6c9gDNgsOYgGAPvlSZj/nv2Su0ZfTRo1YEj5beoZVy3fH0iyiEupG16p6/4ltqnU5CFlijFxZedwKJisa9KH/6o/k3jUZA5VszzJgtFzRhUT5waDdxE/SonFhG2bYJeb444shYX3m1spHNOGQH6RVdlAVDD4CQwRXuhDIPZGkNTpfH3wbQf57yRUEQEwvsWeKZ8vFPMMF/olrdb5heXmMd0HT+XMOd+3ZQeN6MxgfQmmAGjzkMBXikAt2l6VlvvPMh/4YX35b2RTaCgbJtbr6Y/poYwoQwQ24fc9GFNT5stvVo34+SNmOEiFNAZ1+7znrFdABJooGI8tUPCvJz7yHm5exhjE1t3oWyN7Y40ANuwJsYGpbEnLVsHH3wYsMAg74KIN6SjqHFJjF/aolVbviFMezPiZFI+t
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(54906003)(86362001)(110136005)(53546011)(122000001)(7696005)(6506007)(2906002)(66476007)(8676002)(64756008)(66446008)(71200400001)(38100700002)(66556008)(66946007)(33656002)(76116006)(41300700001)(4326008)(316002)(9686003)(26005)(83380400001)(38070700005)(52536014)(186003)(478600001)(8936002)(5660300002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ls8ZCbA8HAwyly8nLVvLb2s43rfbKZcwF6sntP0C2TrEoa+T2o6b8aH1GJy2?=
 =?us-ascii?Q?c+6b6nWPxCIAK/mjn8SmCUIjbljIxHqzK1HmyLjHQ/4v/QlX4yRZbJVdZnMz?=
 =?us-ascii?Q?7vGhTdOJ5Fbi/wgJ5cPj54PVMwTy9VFC+Q1uP9fYDpYDtt8hIvMUbcXnl6Zi?=
 =?us-ascii?Q?5+PyCzQs2WuhwhHcFyy8N0ULRq2WZ9VgpMeXhqx7vKmNAqY/8L51OPmiYvk4?=
 =?us-ascii?Q?dERN/N+8dOsBxnnXM7DSwwMbl+VxK+uzx7Lpc62nFlgCMgF28I5OhQfK/eUc?=
 =?us-ascii?Q?flwiOsSn2/hqVEUIoGGet9S8r6QGYe+a1u31f1YyEG0Bj8+XDnOK4B4cDHYu?=
 =?us-ascii?Q?Aq+x2JZvF40FPwd0Y76fNQGnyVn0xMyKZkYA6qpTK09ue61BCQQLZ1uMcle8?=
 =?us-ascii?Q?yXNbyLcsHUbg7QiY4Y7wHuXDOkmEaoDGxhEW5JH+kSaKfCZVngxM70uemIcg?=
 =?us-ascii?Q?KDr+cEQ0tXfzd8o95Ln84UjJbKC9xSLmvBtskUV0XlM36yWgQMlOMd5uMmjJ?=
 =?us-ascii?Q?G8nhRmVs4nHoVp7E4+ba0vY1tc2lfZnwgDX3QEnl8uKQzoyP/ou45KnT+Fbg?=
 =?us-ascii?Q?roAFmpvZv8fG/oAu+L6+sjFfecJmKjBgj7Yc3+/zHQmFYHQkzTYVQY6rArOl?=
 =?us-ascii?Q?j6axfXpWWSo4Rr42CZfQSGbZnnx2oh9rVp7R1/VrL1bJ70kFT3bCCGXoi5DB?=
 =?us-ascii?Q?uCjdbteIbeISWsd1g/mve8Tj3li9vF7JsKom8ClIS+ik+k5Wa/YUmZVSYihF?=
 =?us-ascii?Q?7FXgIIop2noi7gd4u1Khe7SUV75F2JGsQUFJcReknSkTy2GLgrwAYp3iudRH?=
 =?us-ascii?Q?qSt7WuKdDxXYigFemNv2JMc5w89snLHCBu/8zoIyYbN2HmEAb/LACJCHDkjY?=
 =?us-ascii?Q?opOiQLwPXvEiBDc2kDII4G6Cu78v5gyDZtNO9eRj80cTk60dVtL6tBovzzfw?=
 =?us-ascii?Q?gz/gwnxcZ3TTxnx8OYVHLKYX7NSRmzECGcFyJlVL97h5C3y1w2zlOZtzCG+A?=
 =?us-ascii?Q?9tvJWeWXin42Ub5+bESasy5t2wTR6O9lGq5vzPRBcysSCPqdmwzmQozqqK+w?=
 =?us-ascii?Q?RpT7rVJ8dW7lx4sNyb5F7KKz6gxWa1tLafi3QEqxYvoTQQR8CDrRjwQgZk0Z?=
 =?us-ascii?Q?F5epTxqQU4d5zctGKUKoaQMQMSOYOy69K9N8/W2FVNTNAOuq2jZtnbqoFK+B?=
 =?us-ascii?Q?vv26sXdmX/li1fRaylJCYkTWt4OY8qhUItRklmjIl6vhvOETKjD7f6GPIpJ/?=
 =?us-ascii?Q?+NSLk8fsdq6613Xt8e4AdOUs9NohYCBVEDuVbIF/innNk0kaSmC91q0ajgJK?=
 =?us-ascii?Q?ItBP1hlDf9S/8RtR6OhoizSK5R+01Jm5cnw74zW9r5LgCJ1qYE4vB3TD9lJo?=
 =?us-ascii?Q?ZczBXvIRonKZyDqgJhp3SW1naxG8OA73xRGgupRaA3kiPYey72yTW0SLUF6p?=
 =?us-ascii?Q?7qpayy4eSDTQOH0juiPFeyqBU+nY50SKmQXiVWGUfEytsMSecQGmnZ6MFik5?=
 =?us-ascii?Q?qhecK1jhvMLfwPoqclaRdJjGwBLXcvVEYeX0tmyaRWqouEk9Pc8/DVZ24ydc?=
 =?us-ascii?Q?dTgt2nKhS5rTMWzfrLk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f350a4b0-d4f3-4d3c-91b3-08da6f0bd708
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 13:36:26.8708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: piq6crsvuQKjrkbr1d10T5p9u6KxV8wjU2LyZc2UqKPE6NOBncbSItns5EnNnR73
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5248
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> shikai.guo@amd.com
> Sent: Tuesday, July 26, 2022 2:29 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Liu, Aaron
> <Aaron.Liu@amd.com>
> Subject: [PATCH v2] drm/amd/pm: Add get_gfx_off_status interface for
> yellow carp
>
> From: Shikai Guo <Shikai.Guo@amd.com>
>
> add get_gfx_off_status interface to yellow_carp_ppt_funcs structure.
>
> Signed-off-by: Shikai Guo <shikai.guo@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 31
> +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index 70cbc46341a3..04e56b0b3033 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -42,6 +42,11 @@
>  #undef pr_info
>  #undef pr_debug
>
> +#define regSMUIO_GFX_MISC_CNTL
>       0x00c5
> +#define regSMUIO_GFX_MISC_CNTL_BASE_IDX
>               0
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK
>       0x00000006L
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT          0x1L
> +
>  #define FEATURE_MASK(feature) (1ULL << feature)  #define
> SMC_DPM_FEATURE ( \
>       FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \ @@ -587,6 +592,31
> @@ static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
>       return sizeof(struct gpu_metrics_v2_1);  }
>
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
> +     uint32_t reg;
> +     uint32_t gfxoff_status =3D 0;
> +     struct amdgpu_device *adev =3D smu->adev;
> +
> +     reg =3D RREG32_SOC15(SMUIO, 0, regSMUIO_GFX_MISC_CNTL);
> +     gfxoff_status =3D (reg &
> SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK)
> +             >> SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT;
> +
> +     return gfxoff_status;
> +}
> +
>  static int yellow_carp_set_default_dpm_tables(struct smu_context *smu)  =
{
>       struct smu_table_context *smu_table =3D &smu->smu_table; @@ -
> 1186,6 +1216,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs
> =3D {
>       .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
>       .set_driver_table_location =3D smu_v13_0_set_driver_table_location,
>       .gfx_off_control =3D smu_v13_0_gfx_off_control,
> +     .get_gfx_off_status =3D yellow_carp_get_gfxoff_status,
>       .post_init =3D yellow_carp_post_smu_init,
>       .mode2_reset =3D yellow_carp_mode2_reset,
>       .get_dpm_ultimate_freq =3D yellow_carp_get_dpm_ultimate_freq,
> --
> 2.25.1

