Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F135C28CF5
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 06:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BDB510E541;
	Wed, 26 Jan 2022 06:43:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4724210E541
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 06:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkcOXxvrbEvrkGi0BkUdV9ry7aDcpSVy7fqpGGsi2fvZxQMPuValcTceFMEpgtauHtAHZ867RmAieRASxWS/a7WDx7rtY+9PbGDVwhwzmWDygh/WOE6lnP3yOnG8Rj/f+i1RWqcB8cpJ+EbBJigBX8HqZJM1QiOnmdDM1CNpLoCU5jvTEzWM2fSGdYu8qy7ylVon4OQwnWQUZZcW9nXETXI7LHvHVCA9bBOz3xZPHa8ftBANhNWjzzFyfLXai1MxGibCW75E8oC6B/k8yCCdR3HcqrT2pi7msz8S8KURT7u5/hkyvRKOaKqy4b+r4iSefzx9RssBHtAd2bmIDOjxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZViZGxH7lR+ROx6MOOBVNNqDOT9942fliaebtbH7Vjw=;
 b=HWYM0rlmUPx7b+RNcj5MpvBrAiifIHK/9t+LEhSQDw5uPmbAX/Xe1fsEuL0Ter+x5Ba7GkaLnz53kEDYLlHtJYmS2ILLAg7mblKOkz0mt3dQISOQk7TztrY89Zcc+C+qFcefClSjy0mLlFE9nmk56tQuiUdYkLdnDGJkEelEAIUK1zgbZPka0U8K5SAR3xLFuv/nmfSjk4D1nnYMtFs9A95jpkpq/V6JPCcvAh4iDN8i8qswp4ofSxNH+3YMKC+QJPLGhwCQzceuOLUZ5yKMnSA15AG8AvWE+Veel5GmEHZP+iAVp6MQJz7kt8RHhc33sUyvf2eSOnY3zFmWet/Z/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZViZGxH7lR+ROx6MOOBVNNqDOT9942fliaebtbH7Vjw=;
 b=Tpx8/debC+5847AKqNk807zxr3o3VjmTpUmf07xYhWgoNi3K/LBwCVo47NcTL5eKaG0v9ObLYKChT/kD/6NGjIKkpNtO6YRiJ3rfU9hUyasxkcEYRyZQsGA4HYXFkhILoFD2pH+lGhegOLFoNJPGq3URB3agGrXy0U5NpqrMmS0=
Received: from DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15)
 by DM5PR12MB2551.namprd12.prod.outlook.com (2603:10b6:4:b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Wed, 26 Jan
 2022 06:43:39 +0000
Received: from DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::7dc0:b85f:5c9e:33be]) by DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::7dc0:b85f:5c9e:33be%6]) with mapi id 15.20.4888.020; Wed, 26 Jan 2022
 06:43:39 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix an error message in rmmod
Thread-Topic: [PATCH] drm/amdgpu: Fix an error message in rmmod
Thread-Index: AQHYEdLUqv+l+snVMkWySvGKcSJw8axzjpeAgABPAwCAAL9QMA==
Date: Wed, 26 Jan 2022 06:43:39 +0000
Message-ID: <DM4PR12MB52949E3762DF92C8C747ED8A95209@DM4PR12MB5294.namprd12.prod.outlook.com>
References: <20220125100321.450194-1-tianci.yin@amd.com>
 <SJ0PR12MB54888020E0D600D546BAC634825F9@SJ0PR12MB5488.namprd12.prod.outlook.com>
 <b5fab406-062f-1fdb-832b-1ba0249e1e10@amd.com>
In-Reply-To: <b5fab406-062f-1fdb-832b-1ba0249e1e10@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-26T06:43:38.343Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 10b3fc62-5e2f-a76e-5725-9fa58afe6a18
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b2aa1ee-440b-471e-757d-08d9e0972fca
x-ms-traffictypediagnostic: DM5PR12MB2551:EE_
x-microsoft-antispam-prvs: <DM5PR12MB255109B0EA6E6BAC0D7574CF95209@DM5PR12MB2551.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5pP47yPtrFmuGO/rGUvg8mfg9kRw3W6NBkSo77pVhcoKzJVPXVACbZ708ZPUCg4ziLKF9P0pakhrMG4NIF+QgWO5hP9XM3r5uA5EJuWhNbXmbpjx5Jug1Yjd1LwwSdoW0OxCMjvWD1Xw/rzyYQuw3s7LtnpYGMYsPgRLE4xIQNArKT/Hurn9dgslkvEovJcPPYuT7fAi1RGvnOaHvQRgwxc9XG6VYw7j9OX99k0NxHanScV81gbc7rBbn7Wuo9H5AfKI1ytiTKqecdcGwuVs6kaV8qPf9mOeLnVdzMs0HwSuCGLgEWQbsxzITgcNyoCrZtI4Swq1jZ8v/8Sdh5PrQGjeQJsgbKhlZhKjEviRWTxOmf2mr0NscZr0eJi5mQRKMRgs9xqB6H6I2+bYTS2itq337MoRc8e3DZwRFtr/6NDKWS91qKpcA0uVRgcW12knaZQb8qnuFiizpGytMYmDPFEolj5Prczx6ksJsuJ+Td7XXxiWL5K1HGFeKnwhkuukg2KgMk9GWLa2MRkhVOqb4gF6xssiovnLAgOpiZktUUGufyYWM+U/tPY3qY7kyBDSxKVN/ndJ/6iwwzx2IPhcGwvXy37gLmYtUqVzqx0WNRtV/jTYQZTJKjkzNvzGbSg0A6gJrcPalMQCmBv+33tPAqAg/L24TXLYOD6u7Ikri2QmHp+Gcb1PIFRIt5YY/lql3PzyPAoZSz+yJG/C51hOfQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5294.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(2906002)(91956017)(5660300002)(186003)(64756008)(38100700002)(55016003)(76116006)(83380400001)(8936002)(66946007)(53546011)(15650500001)(508600001)(6506007)(122000001)(7696005)(316002)(38070700005)(9686003)(33656002)(110136005)(8676002)(71200400001)(54906003)(66476007)(26005)(4326008)(86362001)(19627405001)(66556008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WH6YoxRHfE6pP1ZfP/WU9zN8m2XfyYMxRPbgpbtVKad8LPn4vUp5mMvXlEVC?=
 =?us-ascii?Q?JFLZ5hVHSHcibroxwR6y28Agnf+9CcR7C182odbWPhPCWdx+z911bu3zp6I+?=
 =?us-ascii?Q?Sx/L3c0zFdMB7tsQVNFRFh4Gif+3QTz65Bml/rxqAdQ1QxkeEWwUUB1NZCWP?=
 =?us-ascii?Q?TN73o5xNJkTmzReuPDfSSAsQ7O9V8ms1Zil/sN1E8Ik/1yFvWv4gn0Ce7Vi1?=
 =?us-ascii?Q?4HrAhRX49g1mqsJdluP3o1kpB9MxsKYsKptsAitv9Ce7AU/zg8QebzZy2E1o?=
 =?us-ascii?Q?nTQ4GYJUZ8q1UN53F9Xe+7b9U+Rpx+7gHuzY3la3m9PId4d+iUeKfRbWG91W?=
 =?us-ascii?Q?0+UAE0ZpNEb/DwDNxtzY3SRVlCWeraP+H8BBjTKQrdHgbAwI5pnuNkJB8YXn?=
 =?us-ascii?Q?5D1iyVQ0105VLsZn9SwC72bIBNkaY4isXe1uX1oIKeoR+OzI//G7ix9VbBiT?=
 =?us-ascii?Q?Fa/ABVdX2WyNXs9mEaK267dJ3IHOwf3P/HVSJum4jWoEHxvUjSM5rNGZXmzs?=
 =?us-ascii?Q?jf3Qe6s2CTwkauOSuBd2CuOk7YMDvj4UvnFAmkJQcRWqzOXjTZSFDDIbyYpe?=
 =?us-ascii?Q?KDyp681g5HR2qR5ENPILkJZ8vPxP5ZhrYZyK59ABltayD+LDeeR1UoRXzNB0?=
 =?us-ascii?Q?XbtOwyq6DhuOaZxmiZQQ3hWmo8YovlVFvhjRtJRKsgdQC805tFvBmhM5LpaP?=
 =?us-ascii?Q?pswHZEwB684BOcymDij8x6EzmF7JeXWNCjlIux23YUk5mfqE91kiLPTqxNpa?=
 =?us-ascii?Q?X+4xsXqpLG++sXKTAkeglst+bxnfvSE7BuevucEoPaU5hfnmJc++BmwUOX7d?=
 =?us-ascii?Q?fIfsmrKkiVhNecHZWMaxJ3Vl3k3Ld4XZ+CjIJtn9gPdGyB9JPmcObK4t6cjR?=
 =?us-ascii?Q?HzeyjZ7OkP308ifsMdjFD4axRMMKV7LgMIhOEXx0XFGzjF6l007lLD88w7bT?=
 =?us-ascii?Q?4o2K6LGwHb2/Bp1iu0YTAHp8vqnkO4GE2z/gh5BLLQ10r1TOwTZemdYXPqsQ?=
 =?us-ascii?Q?GsSCXLsC3sAKoe3NMp8b8dWWiqIvFNIEUgBDI3natx8N64+LVXvR/PHDbmJ3?=
 =?us-ascii?Q?E6GMVObiamUY2BgJ6Km1zIsaTbcAU+40qadMTlFQ8A1mivySBO/P3eXpbfh/?=
 =?us-ascii?Q?6tGoEr7/UPPuks74oC/kq68P9UWZ+x8KMU5zXWq1M/WXU89/QZ0y16eP3hzw?=
 =?us-ascii?Q?RQ75JA9FA6TOFghLm6DFV4QZ8Cp9rX/yCUwxg0rPiCDqrXTqGkT3cLKePqJp?=
 =?us-ascii?Q?+LV+39H1pI3n4/3adOYk9jRAIzAeUx6aOTIEb9g4QHLgfWVZoYDgR+c8jdZf?=
 =?us-ascii?Q?Dt1EpObcjPplOHQ630PxfBZpzjA22qMMP6cKkCBTktvNeA21G657veTLG7au?=
 =?us-ascii?Q?bhtDO1seVu0i69bWLvcsHer7YPR8ZevuxzUIEblzc3m+tq3G4AmLQh0ooksY?=
 =?us-ascii?Q?Ly/mXrWB7S0+RazWkTgDLIpHXg8wq/vqopaOpOsaNTWIpnsAZUKmspKR+hBT?=
 =?us-ascii?Q?5l1JuE8jIVvVXFt12BV77OB92uBCQZr6f14S5aaQAC6dSuFz/59yzDOqZqVg?=
 =?us-ascii?Q?yOI62OWN6z8mGk0n3nAgKvcHHHBj1ZkOyRbGXsasyZpBCy1f1htqacZ/q7AJ?=
 =?us-ascii?Q?iQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB52949E3762DF92C8C747ED8A95209DM4PR12MB5294namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2aa1ee-440b-471e-757d-08d9e0972fca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 06:43:39.4554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nkL89A5qioOCxhVtGoS5XpPOLhCv30U4C1L7xeDHuakrbcFlJzLfrM8D9orc0Cr851YZP+Wmb7KWL3u66Sn1TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2551
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB52949E3762DF92C8C747ED8A95209DM4PR12MB5294namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Thanks Kevin and Felix!

In gfxoff state, the dequeue request(by cp register writing) can't make gfx=
off exit, actually the cp is powered off and the cp register writing is inv=
alid, doorbell registers writing(regluar way) or directly request smu to di=
sable gfx powergate(by invoking amdgpu_gfx_off_ctrl) can trigger gfxoff exi=
t.

I have also tryed amdgpu_dpm_switch_power_profile(adev,PP_SMC_POWER_PROFILE=
_COMPUTE,false), but it has no effect.

[10386.162273] amdgpu: cp queue pipe 4 queue 0 preemption failed
[10671.225065] amdgpu: mmCP_HQD_ACTIVE : 0xffffffff
[10386.162290] amdgpu: mmCP_HQD_HQ_STATUS0 : 0xffffffff
[10386.162297] amdgpu: mmCP_STAT : 0xffffffff
[10386.162303] amdgpu: mmCP_BUSY_STAT : 0xffffffff
[10386.162308] amdgpu: mmRLC_STAT : 0xffffffff
[10386.162314] amdgpu: mmGRBM_STATUS : 0xffffffff
[10386.162320] amdgpu: mmGRBM_STATUS2: 0xffffffff

Thanks again!
Rico
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Tuesday, January 25, 2022 23:31
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yin, Tianci (Rico) <Tianci.=
Yin@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix an error message in rmmod

I have no objection to the change. It restores the sequence that was
used before e9669fb78262. But I don't understand why GFX_OFF is causing
a preemption error during module unload, but not when KFD is in normal
use. Maybe it's because of the compute power profile that's normally set
by amdgpu_amdkfd_set_compute_idle before we interact with the HWS.


Either way, the patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>



Am 2022-01-25 um 05:48 schrieb Wang, Yang(Kevin):
>
> [AMD Official Use Only]
>
>
> [AMD Official Use Only]
>
>
> the issue is introduced in following patch, so add following
> information is better.
> /fixes: (e9669fb78262) drm/amdgpu: Add early fini callback/
> /
> /
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
> /
> /
> Best Regards,
> Kevin
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> Tianci Yin <tianci.yin@amd.com>
> *Sent:* Tuesday, January 25, 2022 6:03 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Yin, Tianci
> (Rico) <Tianci.Yin@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> *Subject:* [PATCH] drm/amdgpu: Fix an error message in rmmod
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> [why]
> In rmmod procedure, kfd sends cp a dequeue request, but the
> request does not get response, then an error message "cp
> queue pipe 4 queue 0 preemption failed" printed.
>
> [how]
> Performing kfd suspending after disabling gfxoff can fix it.
>
> Change-Id: I0453f28820542d4a5ab26e38fb5b87ed76ce6930
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b75d67f644e5..77e9837ba342 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2720,11 +2720,11 @@ static int amdgpu_device_ip_fini_early(struct
> amdgpu_device *adev)
>                  }
>          }
>
> -       amdgpu_amdkfd_suspend(adev, false);
> -
>          amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>          amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>
> +       amdgpu_amdkfd_suspend(adev, false);
> +
>          /* Workaroud for ASICs need to disable SMC first */
>          amdgpu_device_smu_fini_early(adev);
>
> --
> 2.25.1
>

--_000_DM4PR12MB52949E3762DF92C8C747ED8A95209DM4PR12MB5294namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks Kevin and Felix!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
In gfxoff state, the dequeue request(by cp register writing) can't make gfx=
off exit, actually the cp is powered off and the cp register writing is inv=
alid, doorbell registers writing(regluar way) or directly request smu to di=
sable gfx powergate(by invoking
 amdgpu_gfx_off_ctrl) can trigger gfxoff exit.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div>I have also tryed amdgpu_dpm_switch_power_profile(adev,PP_SMC_POWER_PR=
OFILE_COMPUTE,false), but it has no effect.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 10pt; color: rgb(237, 92, 87);">[10386.162273] am=
dgpu: cp queue pipe 4 queue 0 preemption failed</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 10pt; color: rgb(0, 0, 0);">[10671.225065] amdgpu=
: mmCP_HQD_ACTIVE : 0xffffffff</span><span style=3D"font-size: 10pt; color:=
 rgb(237, 92, 87);"><br>
</span>
<div><span style=3D"font-size: 10pt;">[10386.162290] amdgpu: mmCP_HQD_HQ_ST=
ATUS0 : 0xffffffff</span></div>
<div><span style=3D"font-size: 10pt;">[10386.162297] amdgpu: mmCP_STAT : 0x=
ffffffff</span></div>
<div><span style=3D"font-size: 10pt;">[10386.162303] amdgpu: mmCP_BUSY_STAT=
 : 0xffffffff</span></div>
<div><span style=3D"font-size: 10pt;">[10386.162308] amdgpu: mmRLC_STAT : 0=
xffffffff</span></div>
<div><span style=3D"font-size: 10pt;">[10386.162314] amdgpu: mmGRBM_STATUS =
: 0xffffffff</span></div>
<span style=3D"font-size: 10pt;">[10386.162320] amdgpu: mmGRBM_STATUS2: 0xf=
fffffff</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 10pt;"></span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks again!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Tuesday, January 25, 2022 23:31<br>
<b>To:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Yin, Tianci (R=
ico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@=
lists.freedesktop.org&gt;<br>
<b>Cc:</b> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; Chen, Guch=
un &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix an error message in rmmod</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">I have no objection to the change. It restores the=
 sequence that was
<br>
used before e9669fb78262. But I don't understand why GFX_OFF is causing <br=
>
a preemption error during module unload, but not when KFD is in normal <br>
use. Maybe it's because of the compute power profile that's normally set <b=
r>
by amdgpu_amdkfd_set_compute_idle before we interact with the HWS.<br>
<br>
<br>
Either way, the patch is<br>
<br>
Acked-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
<br>
<br>
<br>
Am 2022-01-25 um 05:48 schrieb Wang, Yang(Kevin):<br>
&gt;<br>
&gt; [AMD Official Use Only]<br>
&gt;<br>
&gt;<br>
&gt; [AMD Official Use Only]<br>
&gt;<br>
&gt;<br>
&gt; the issue is introduced in following patch, so add following <br>
&gt; information is better.<br>
&gt; /fixes: (e9669fb78262) drm/amdgpu: Add early fini callback/<br>
&gt; /<br>
&gt; /<br>
&gt; Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;<br>
&gt; /<br>
&gt; /<br>
&gt; Best Regards,<br>
&gt; Kevin<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; on behal=
f of <br>
&gt; Tianci Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; *Sent:* Tuesday, January 25, 2022 6:03 PM<br>
&gt; *To:* amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
&gt; *Cc:* Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; Yin, Tianc=
i <br>
&gt; (Rico) &lt;Tianci.Yin@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.co=
m&gt;<br>
&gt; *Subject:* [PATCH] drm/amdgpu: Fix an error message in rmmod<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt;<br>
&gt; [why]<br>
&gt; In rmmod procedure, kfd sends cp a dequeue request, but the<br>
&gt; request does not get response, then an error message &quot;cp<br>
&gt; queue pipe 4 queue 0 preemption failed&quot; printed.<br>
&gt;<br>
&gt; [how]<br>
&gt; Performing kfd suspending after disabling gfxoff can fix it.<br>
&gt;<br>
&gt; Change-Id: I0453f28820542d4a5ab26e38fb5b87ed76ce6930<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; ---<br>
&gt; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--<br>
&gt; &nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index b75d67f644e5..77e9837ba342 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -2720,11 +2720,11 @@ static int amdgpu_device_ip_fini_early(struct =
<br>
&gt; amdgpu_device *adev)<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_suspend(adev, fals=
e);<br>
&gt; -<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_pg_=
state(adev, AMD_PG_STATE_UNGATE);<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_cg_=
state(adev, AMD_CG_STATE_UNGATE);<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_suspend(adev, fals=
e);<br>
&gt; +<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Workaroud for ASIC=
s need to disable SMC first */<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_smu_fin=
i_early(adev);<br>
&gt;<br>
&gt; -- <br>
&gt; 2.25.1<br>
&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB52949E3762DF92C8C747ED8A95209DM4PR12MB5294namp_--
