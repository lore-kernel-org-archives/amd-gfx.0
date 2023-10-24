Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76056C00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 14:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4B1C10E002;
	Tue, 24 Oct 2023 14:45:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A352410E002
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 14:45:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/pNiKk977YsUjIOuHG1Zr4mrLf3KEez2axT6HNAgMRIvciS26EmXSh3x3fWmEHCkjESGEK0NySuzsOfe2uwqrZt9p8mVTAh+fso84M7Lb8xXyC4ScbZu3Xzhz8K5WWK+ehq3gVPszDCbD64EuQlO33f7oV8Sqtk8Dgvj79YXKsww2YDNhQbaPEuFXwC/T8s5Y3heo5/j0iDH+SXWb31cZ3wVZ0WKPNP0VN/4c3QN1NR9sVTHtKuKoKhmo6GCmujZI8HNM0NQRaqjroELtMnyhTiNIYGwM7i6zJGKXI4dCuMxupNtJfncYY/xevNQHK/mTS1z8zWWShbfEpvtwJuxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5XY43ll3AZ8KJOjBeHuf06M+MFH1q/Ul/CDcKfFgCc=;
 b=OqgGxx9/5eu2pihGIzizJ5Y3F6wOxEJjBE6YnTFSNPjeeNm9CFVEpICqSdrSe/CLEUw7s7+GcJ86nqHgRRDzYRe7R8yam7YdVjTVLGtgE5Bi3VFpbyYqrMn4BbQKmio4TiMxHVd10VBRp9NgUp0Lmm72HikLrK6NxwVxwEE5epXIdsEBrt2X4CJ4wVGbaBATiGdUcpUN+IdmZg9URnuy2KMs26r3BhpFLgcZIjjk/+UJzBP8/GnXIZPQRgT078RDL6bZiCdfUnC5UdmAfh1h23zzEZyPcpvmxaPw/uhm+56DOTV7uTnOmVADQmwtfvPa7mQZB8YUYZ7mizysLWT1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5XY43ll3AZ8KJOjBeHuf06M+MFH1q/Ul/CDcKfFgCc=;
 b=5M5eje5fzaHKrNj1P6v9D8jLL9YCiDKH2OQiAfE/eBG5pGHIfjyKcUhPaylOA6U0Q3pUFAC9GCBaZJZFFunUq/jaBb49H94T+DgjdL/PBxV3NFqOPUBbobk1Hkic6o3nRjqnT5krlGRsX8qIOgcJxPVIyOBj8ZzmnEU8jhlyd40=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by SA3PR12MB9091.namprd12.prod.outlook.com (2603:10b6:806:395::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 14:45:53 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::2f3f:cf6e:c3a5:90db]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::2f3f:cf6e:c3a5:90db%2]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 14:45:52 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Limonciello, 
 Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: avoid sending csib command when system
 resumes from S3
Thread-Topic: [PATCH 2/3] drm/amdgpu: avoid sending csib command when system
 resumes from S3
Thread-Index: AQHaBiKFCo2gSVkV40KVbBvDYGzZ9LBYaEuAgACcqiA=
Date: Tue, 24 Oct 2023 14:45:52 +0000
Message-ID: <CYYPR12MB865524EAFCA32ED8A7C6CFF29CDFA@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <9d71cec3a900bedfc4a9f2409a606405deb60985.1698114574.git.perry.yuan@amd.com>
 <c8aab746fe07c1385caa25afac8e69bfad2e693d.1698114574.git.perry.yuan@amd.com>
 <PH7PR12MB599773B103A677179EEBC4F182DFA@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB599773B103A677179EEBC4F182DFA@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fd716a7a-cabe-4bd2-8d85-ae865572e708;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-24T05:20:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|SA3PR12MB9091:EE_
x-ms-office365-filtering-correlation-id: 7bb0e9cc-c2f1-40bf-16dd-08dbd49fec1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rLukSeHlPywnwokn4u1504ZR0kZmLjKL8C7z2aLpvvG8MI9LNO6o/XzSSUcrYvQoMunhtMM+W7xtwEzlsVKnZ5sj2P1TVsbDWehVcyfYCMhMhOpKZwbGvSLFguD9S1xWfPJY/jG3SztHNwVlmKvZiNNKZ6wH6OcNNucvwCUB4IAmY0wYlhEzaXET3lKVRYQszCS32ZgCEI77kC+sTD7l4Al6D84oEmCssO6U68Ok9xRSxvNd00jsWL258ZfDNqj6G3z7NcI3Gpqc4YdCw+aMtoRi3kqbR/uHXytTafiTM/W9hpmICIVof85OKqGcoqMA9wXhm1bZ6GViaGI0+mRA7fkoL/pHAPHcaNcAun3HPjMiaUu0JCzl1llG6vSh3kUqmP/vekFw08xCucnO0940G25eIiIqzEywLWz3GpJQg4DgkWP0xge4WOAIdnwQKggvPYtjdgfYUVROM0UEFXaKfNI476mLXxLtNeMVzU/z5zFCS3Rn0ZVJkHEsPhTvD7uZtvLqmEOSRczyNU6/cKEZjLT4Ic0wr04czCGeVxWyR4OHJg1bbuIuoIuu6G13BrmnckiObhIH7GYgav38lRm7G/6GwIlrtUG8vxwddf8BQKugfyfCqvQcVekUGQRG3w2/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8655.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(366004)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38070700009)(55016003)(83380400001)(2906002)(71200400001)(8936002)(4326008)(52536014)(33656002)(8676002)(38100700002)(53546011)(122000001)(26005)(7696005)(9686003)(5660300002)(6636002)(6506007)(316002)(66446008)(478600001)(54906003)(86362001)(64756008)(66556008)(110136005)(76116006)(66946007)(41300700001)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D00VSLZrHnvBQ+nDd30RW35tIyPpYxplgDF/3rxr3PH7EfrUNUbHZMlGRnd7?=
 =?us-ascii?Q?dXAmD76ou3qJP1niAcoeXGNoZwx9Oz80EsKQE2wUhO58SJNb4AQ6cVDgw/TY?=
 =?us-ascii?Q?br42Z9nYtqxbbIfAZmDaBom3URCoEZXMn5FAjxxBhVEp55+GlxY+S//ATs1R?=
 =?us-ascii?Q?ytNQRklO1Rbmj2e38qTzudCpdUmdjUdl3L76M95WTp+O2Hs+F0XHh//3h8cE?=
 =?us-ascii?Q?Mo4UR1+GeJIL0LNMtEryj+nFc1MZ1v2QA6RIb7Is6yUm6w+M0bDKH4Z2ambo?=
 =?us-ascii?Q?lCcPw3r4uxIGAFA4OkpkviO67gU8aar+5ED+ls5TlFEvOT6lfM8t7NyRJmjY?=
 =?us-ascii?Q?Lj6DRCB3Rk7/YEFqFWC7DdYfOOQIFJsgNyxtVtdUaqtyuLMFVD6ro/vVvh1/?=
 =?us-ascii?Q?HlEkKCt7GSA1a1Dv/5t5TCBXVgVNO71AQr9YmAyLWmSWzHyr2Z/OU0azKm5F?=
 =?us-ascii?Q?WgPO8KjApss0LzF07MrTH8Wjyr5YBeymVJxP0bQCbTZduL+scT2dkb8T+ILp?=
 =?us-ascii?Q?1w8EsjqnWZ82FORhzBbVL6fAO5mOtPLCTUE9xM3PPQO65uHrW80IqVkC/P0j?=
 =?us-ascii?Q?u7BTGdb3FV53MpJC9N967kk+x4NiKOzeYUZXQIqU6IK9xNwxZ+zNShNPwRrq?=
 =?us-ascii?Q?OHA4/rJYn2D0fj6xox0NZUFVAA1Xp5pHgEdHtxrdnezp+FNbQx5b166+VcxX?=
 =?us-ascii?Q?gyKEi+FRSoi3mbNU+H2pgRIypU7aFnJbDCB4jJhKtnnbBPV4Cv/lhaf9l1fv?=
 =?us-ascii?Q?qlwHvWyHwDnNvS+XYCHIlym4U8hWzHL9vuoyB3/Uo/V+ffJqX0CHv4As2bND?=
 =?us-ascii?Q?jlOSCu80fSm0XXTXvjJ9YRC7Ww+V0hKxguIZEWq6Zq1tb9MGbuQ2oO6XSdmA?=
 =?us-ascii?Q?+PqrZBK+pBLOHDjtPbJ8G6pwS8iDVJOgYdGZKqoJv/0XpB6baDr5CwqnkrSp?=
 =?us-ascii?Q?2iEIKQMxn3PS+rPlcxawbZ6TVaocnmRJcAzXjviaOk8/ZgIXD5F5UUxx34/x?=
 =?us-ascii?Q?mEmQxb2MRLZhAOdhrxh/ffC+oM5IaMAUjrQAhpbUxwRE/kJfDnd9XzVZOmbO?=
 =?us-ascii?Q?DZi8vUxqh3NJ6cXbKhDoEbc89vv0MZje/sZc0tjdJeile/tpqpEhbH8N2hg5?=
 =?us-ascii?Q?5+KQOvDtyblW7FEmX4CI8QgG76676k+Xm/MuisFY5cUZytRvelY6CmBHLr9y?=
 =?us-ascii?Q?3SdXfLOHsOpdKPgyQ0Yg8EUTqAHUuyqMZgGsl+FM/QzBmq6GJaO2sYFzb5v4?=
 =?us-ascii?Q?TDw7R9bKMpWhHCqt6wSRoLbYYgCW30gwsHBBIrJcjy4XriRptEcDRnHXcX8k?=
 =?us-ascii?Q?c49LL12wAEXoM0liKmJukXCPR4UluJzVjkrJ43DrPtgqYRWJgWUq0u+LTJum?=
 =?us-ascii?Q?40YT8dpJt9MDl2h8UkuYJ+EE5hU2VaGnqJRfwiTqLvDtS+a4nFEdBbL1taFr?=
 =?us-ascii?Q?umdpnJs+5Gk3PxkHRb2eMUmNfjjrMtMLfovoktkTCSk+wJiCpxFXOEaBTKkC?=
 =?us-ascii?Q?b64HoLe8YuNVpv2Ae9AS3x5fWw2Q5/p5ks2IciS7BjppvJtMOt6U1enp+LO8?=
 =?us-ascii?Q?y86mloyJwukY4HCOibE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb0e9cc-c2f1-40bf-16dd-08dbd49fec1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 14:45:52.8938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1tLr2rg7JouX86tiqYtZbMmSq0+prA6ZiOqWUNr7BmHl8mMyvmaG4xWP8ebUZ4B+PCuUOyFz+3xLe+X+F+sXQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Kevin,


> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Tuesday, October 24, 2023 1:24 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: RE: [PATCH 2/3] drm/amdgpu: avoid sending csib command when
> system resumes from S3
>
> [AMD Official Use Only - General]
>
> -----Original Message-----
> From: Yuan, Perry <Perry.Yuan@amd.com>
> Sent: Tuesday, October 24, 2023 10:33 AM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: [PATCH 2/3] drm/amdgpu: avoid sending csib command when
> system resumes from S3
>
> Previously the CSIB command pocket was sent to GFX block while amdgpu
> driver loading or S3 resuming time all the time.
> As the CP protocol required, the CSIB is not needed to send again while G=
C is
> not powered down while resuming from aborted S3 suspend sequence.
>
> PREAMBLE_CNTL packet coming in the ring after PG event where the RLC
> already sent its copy of CSIB, send another CSIB pocket will cause Gfx IB
> testing timeout when system resume from S3.
>
> Add flag `csib_initialized` to make sure normal S3 suspend/resume will
> initialize csib normally, when system abort to S3 suspend and resume
> immediately because of some failed suspend callback, GPU is not power
> down at that time, so csib command is not needed to send again.
>
> Error dmesg log:
> amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB
> test failed on gfx_0.0.0 (-110).
> [drm:amdgpu_device_delayed_init_work_handler [amdgpu]] *ERROR* ib
> ring test failed (-110).
> PM: resume of devices complete after 2373.995 msecs
> PM: Finishing wakeup.
>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 +++++
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 29 ++++++++++++++++++----
> ---
>  3 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 44df1a5bce7f..e5d85ea26a5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1114,6 +1114,7 @@ struct amdgpu_device {
>         bool                            debug_vm;
>         bool                            debug_largebar;
>         bool                            debug_disable_soft_recovery;
> +       bool                            csib_initialized;
> [Kevin]:
> you'd better use space to instead of "tab" , to align with other field.

Cool, I didn`t notice that, changed in v2.
Thanks !

>
>  };
>
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *ade=
v,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 420196a17e22..a47c9f840754 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2468,6 +2468,11 @@ static int amdgpu_pmops_suspend_noirq(struct
> device *dev)
>         if (amdgpu_acpi_should_gpu_reset(adev))
>                 return amdgpu_asic_reset(adev);
>
> +       /* update flag to make sure csib will be sent when system
> +        * resume from normal S3
> +        */
> +       adev->csib_initialized =3D false;
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 6399bc71c56d..ab2e3e592dfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3481,6 +3481,7 @@ static uint64_t
> gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev);  static
> void gfx_v10_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
>                                    u32 sh_num, u32 instance, int xcc_id);=
  static u32
> gfx_v10_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev);
> +static int gfx_v10_0_wait_for_idle(void *handle);
>
>  static int gfx_v10_0_rlc_backdoor_autoload_buffer_init(struct
> amdgpu_device *adev);  static void
> gfx_v10_0_rlc_backdoor_autoload_buffer_fini(struct amdgpu_device
> *adev); @@ -5958,7 +5959,7 @@ static int
> gfx_v10_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
>         return 0;
>  }
>
> -static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
> +static int gfx_v10_csib_submit(struct amdgpu_device *adev)
>  {
>         struct amdgpu_ring *ring;
>         const struct cs_section_def *sect =3D NULL; @@ -5966,13 +5967,6 @=
@
> static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
>         int r, i;
>         int ctx_reg_offset;
>
> -       /* init the CP */
> -       WREG32_SOC15(GC, 0, mmCP_MAX_CONTEXT,
> -                    adev->gfx.config.max_hw_contexts - 1);
> -       WREG32_SOC15(GC, 0, mmCP_DEVICE_ID, 1);
> -
> -       gfx_v10_0_cp_gfx_enable(adev, true);
> -
>         ring =3D &adev->gfx.gfx_ring[0];
>         r =3D amdgpu_ring_alloc(ring, gfx_v10_0_get_csb_size(adev) + 4);
>         if (r) {
> @@ -6035,6 +6029,25 @@ static int gfx_v10_0_cp_gfx_start(struct
> amdgpu_device *adev)
>
>                 amdgpu_ring_commit(ring);
>         }
> +
> +       gfx_v10_0_wait_for_idle(adev);
> [kevin]:
> Do you forgot to check return value here?  If you want to ignore the retu=
rn
> result, you'd better put some comments here.
> Thanks.
>
> Best Regards,
> Kevin

It is better to add check, changed in v2.
Thanks.

>
> +       adev->csib_initialized =3D true;
> +
> +       return 0;
> +};
> +
> +static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev) {
> +       /* init the CP */
> +       WREG32_SOC15(GC, 0, mmCP_MAX_CONTEXT,
> +                    adev->gfx.config.max_hw_contexts - 1);
> +       WREG32_SOC15(GC, 0, mmCP_DEVICE_ID, 1);
> +
> +       gfx_v10_0_cp_gfx_enable(adev, true);
> +
> +       if (!adev->csib_initialized)
> +               gfx_v10_csib_submit(adev);
> +
>         return 0;
>  }
>
> --
> 2.34.1
>

