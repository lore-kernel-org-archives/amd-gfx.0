Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82BAC02182
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2025 00:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D39010E247;
	Thu, 23 Jan 2025 00:06:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QlFiAAhd";
	dkim-atps=neutral
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D6010E31D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2025 00:03:07 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-724d1726680so94365a34.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 16:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737590586; x=1738195386; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xLtm5KA9R2fCAvFQgsri1OhsHiHIe3dzi1E6K7fYE8M=;
 b=QlFiAAhdwCjeQXvmiOtmJk/jUVmZZlVLFA4Wp919LaQvLpaszyjPA/ry8AmskHdl6O
 nnS12BPFWXhuK7m02RL34qmQLlOvE4VgGHQu0/F/Rl2gGXpDASrYCayl0A/gQsYhhYux
 GjaVvkWhozNWPn+HiIP5td06cYUi2MQpk/llaubMzW18cDBvzYPWdOZ/RemOtJPpvFwG
 FQltMaUdhc5V6EJqd5tkJFff4PPTbaz/DG6Ccnbt4eFsiYkyF1ln83LXYqAfQi8qUsZz
 42KTp8u8YuX1M3UcoL/KZYql4FxJvMkaquG6ryRfbewRC5U2kv+sF9ME5WHwRrrfsJpP
 VIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737590586; x=1738195386;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xLtm5KA9R2fCAvFQgsri1OhsHiHIe3dzi1E6K7fYE8M=;
 b=L8DArfpJJHYocc5CrBPnsopXzE0dKSZtIxFw3kHBryFkA5VqTLlp3JS53yWlTvr0Mn
 Bq0MdDTchZXZxaqmUtLhtfNihpuPfxk6Y7tqD7+z/EM4fTRYuJoBmA1xyMB5JPqhNxob
 nxSQfyHB4DheCIhQVCu76rlzZC4cjM8RivUAu+gik/fTSRAcK53A+F3NDImH/NG240Xg
 dD8Bfjib8DU+f9JT95iA4HvxHH49eT79rmYUn3B8RVyo7i+5G6NmkiHxuffcFYFL97vS
 i/l3yu4eSYmFQ6DkTUxVWxiEF4cP+zyMD3UFDbuhdsP88RxuhYULfnzRsMFfGVKrXx7n
 hgLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgJsDy9k3RSdhcyN4ifHBIJyjHT8dAIjkbmyzz3VUG9TvB18DI3+TS3nub1S0+6nzBXngLipiE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwnLwavoXJz+RUAjDnTTvfphWGnrEfpBUt41fDTjGmucUMXePXc
 uqAEcQ2mXQKBM8q3Ui1nDCdp5UNJx72juSrh2ajixGQMRBX1XPeL6rn3Rjs+5L4JEbg6DGfKvl2
 fZgffI+bEs74MSFadq96XyY2dk/4=
X-Gm-Gg: ASbGncvCwt7Uv9mLWxsfMkp1kYTazgxG8yx6+Jp4uLesM/XTdxA2MYBUPh8ZeNKlszB
 gtckfNNpdJ2X62AjpZO5EXtTsXeONEBzQ2AMmaEg+pLVIkBng2jZVMyY78B9oOZWQ+MIPK+S3Yl
 Gfo5huu60=
X-Google-Smtp-Source: AGHT+IHX3ATf4sb4MU9TwwsNj/zfd6D8Ihpv2ESfuWI34QWYPZSu2FM+LThzhoID5CRL6Us3k/hHIKX8g2svvSqKzEc=
X-Received: by 2002:a05:6830:2a89:b0:71d:5117:c07f with SMTP id
 46e09a7af769-7249d99ddccmr15999205a34.0.1737590586370; Wed, 22 Jan 2025
 16:03:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <BN9PR12MB5257EC081CE5514FCCE7FC92FCE72@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257EC081CE5514FCCE7FC92FCE72@BN9PR12MB5257.namprd12.prod.outlook.com>
From: Mika Laitio <lamikr@gmail.com>
Date: Wed, 22 Jan 2025 16:02:55 -0800
X-Gm-Features: AbW1kva_T-VCF0XK6aZCsdcxtar1bxTbjXeSxyw-r2Tb3PasNb3Wq8mxzgGV8gA
Message-ID: <CAJ+8kEaedF+kBEc9gx0BNOsCYLcsYEK--gPma3iROLsoy3JcAA@mail.gmail.com>
Subject: Re: [RFC v2 00/15] Enhance device state machine to better support
 suspend/resume
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Cc: Jiang Liu <gerry@linux.alibaba.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "airlied@gmail.com" <airlied@gmail.com>, 
 "simona@ffwll.ch" <simona@ffwll.ch>, "Khatri, Sunil" <Sunil.Khatri@amd.com>, 
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, 
 "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "Russell,
 Kent" <Kent.Russell@amd.com>, 
 "shuox.liu@linux.alibaba.com" <shuox.liu@linux.alibaba.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="000000000000aa73c8062c545577"
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

--000000000000aa73c8062c545577
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is the latest version of this patch series (with possible fixes based on to
comments) however maintained/available on some git tree for testing?

On Sun, Jan 19, 2025 at 10:28=E2=80=AFPM Zhang, Hawking <Hawking.Zhang@amd.=
com>
wrote:

> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Thanks for the patches.
>
> We currently have no plans to include RAS programming as part of the
> device suspend/resume sequence. Instead, we are focusing on a series of
> clean up patches and a new RAS software module that will eliminate all
> legacy code/workarounds and also the changes you proposed here. It is not
> necessary to make this interim change in the upstream.
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: Jiang Liu <gerry@linux.alibaba.com>
> Sent: Monday, January 13, 2025 09:42
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <
> Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>;
> airlied@gmail.com; simona@ffwll.ch; Khatri, Sunil <Sunil.Khatri@amd.com>;
> Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>; Chen, Xiaogang <
> Xiaogang.Chen@amd.com>; Russell, Kent <Kent.Russell@amd.com>;
> shuox.liu@linux.alibaba.com; amd-gfx@lists.freedesktop.org
> Cc: Jiang Liu <gerry@linux.alibaba.com>
> Subject: [RFC v2 00/15] Enhance device state machine to better support
> suspend/resume
>
> Recently we were testing suspend/resume functionality with AMD GPUs, we
> have encountered several resource tracking related bugs, such as double
> buffer free, use after free and unbalanced irq reference count.
>
> We have tried to solve these issues case by case, but found that may not
> be the right way. Especially about the unbalanced irq reference count,
> there will be new issues appear once we fixed the current known issues.
> After analyzing related source code, we found that there may be some
> fundamental implementation flaws behind these resource tracking issues.
>
> The amdgpu driver has two major state machines to driver the device
> management flow, one is for ip blocks, the other is for ras blocks.
> The hook points defined in struct amd_ip_funcs for device setup/teardown
> are symmetric, but the implementation is asymmetric, sometime even
> ambiguous. The most obvious two issues we noticed are:
> 1) amdgpu_irq_get() are called from .late_init() but amdgpu_irq_put()
>    are called from .hw_fini() instead of .early_fini().
> 2) the way to reset ip_bloc.status.valid/sw/hw/late_initialized doesn't
>    match the way to set those flags.
>
> When taking device suspend/resume into account, in addition to device
> probe/remove, things get much more complex. Some issues arise because man=
y
> suspend/resume implementations directly reuse .hw_init/.hw_fini/ .late_in=
it
> hook points.
>
> So we try to fix those issues by two enhancements/refinements to current
> device management state machines.
>
> The first change is to make the ip block state machine and associated
> status flags work in stack-like way as below:
> Callbacks                    State after successfully execute callback
>                              AMDGPU_IP_STATE_INVALID
> .early_init()                AMDGPU_IP_STATE_EARLY
> .sw_init()                   AMDGPU_IP_STATE_SW
> .hw_init()                   AMDGPU_IP_STATE_HW
> .late_init()                 AMDGPU_IP_STATE_LATE
> .early_fini()                AMDGPU_IP_STATE_HW
> .hw_fini()                   AMDGPU_IP_STATE_SW
> .sw_fini()                   AMDGPU_IP_STATE_EARLY
> .late_fini()                 AMDGPU_IP_STATE_INVALID
>
> Also do the same thing for ras block state machine, though it's much more
> simpler.
>
> The second change is fine tune the overall device management work flow as
> below:
> 1. amdgpu_driver_load_kms()
>         amdgpu_device_init()
>                 amdgpu_device_ip_early_init()
>                         ip_blocks[i].early_init()
>                         ip_blocks[i].status.valid =3D true
>                 amdgpu_device_ip_init()
>                         amdgpu_ras_init()
>                         ip_blocks[i].sw_init()
>                         ip_blocks[i].status.sw =3D true
>                         ip_blocks[i].hw_init()
>                         ip_blocks[i].status.hw =3D true
>                 amdgpu_device_ip_late_init()
>                         ip_blocks[i].late_init()
>                         ip_blocks[i].status.late_initialized =3D true
>                         amdgpu_ras_late_init()
>                                 ras_blocks[i].ras_late_init()
>                                         amdgpu_ras_feature_enable_on_boot=
()
>
> 2. amdgpu_pmops_suspend()/amdgpu_pmops_freeze()/amdgpu_pmops_poweroff()
>         amdgpu_device_suspend()
>                 amdgpu_ras_early_fini()
>                         ras_blocks[i].ras_early_fini()
>                                 amdgpu_ras_feature_disable()
>                 amdgpu_ras_suspend()
>                         amdgpu_ras_disable_all_features()
> +++             ip_blocks[i].early_fini()
> +++             ip_blocks[i].status.late_initialized =3D false
>                 ip_blocks[i].suspend()
>
> 3. amdgpu_pmops_resume()/amdgpu_pmops_thaw()/amdgpu_pmops_restore()
>         amdgpu_device_resume()
>                 amdgpu_device_ip_resume()
>                         ip_blocks[i].resume()
>                 amdgpu_device_ip_late_init()
>                         ip_blocks[i].late_init()
>                         ip_blocks[i].status.late_initialized =3D true
>                         amdgpu_ras_late_init()
>                                 ras_blocks[i].ras_late_init()
>                                         amdgpu_ras_feature_enable_on_boot=
()
>                 amdgpu_ras_resume()
>                         amdgpu_ras_enable_all_features()
>
> 4. amdgpu_driver_unload_kms()
>         amdgpu_device_fini_hw()
>                 amdgpu_ras_early_fini()
>                         ras_blocks[i].ras_early_fini()
> +++             ip_blocks[i].early_fini()
> +++             ip_blocks[i].status.late_initialized =3D false
>                 ip_blocks[i].hw_fini()
>                 ip_blocks[i].status.hw =3D false
>
> 5. amdgpu_driver_release_kms()
>         amdgpu_device_fini_sw()
>                 amdgpu_device_ip_fini()
>                         ip_blocks[i].sw_fini()
>                         ip_blocks[i].status.sw =3D false
> ---                     ip_blocks[i].status.valid =3D false
> +++                     amdgpu_ras_fini()
>                         ip_blocks[i].late_fini()
> +++                     ip_blocks[i].status.valid =3D false
> ---                     ip_blocks[i].status.late_initialized =3D false
> ---                     amdgpu_ras_fini()
>
> The main changes include:
> 1) invoke ip_blocks[i].early_fini in amdgpu_pmops_suspend().
>    Currently there's only one ip block which provides `early_fini`
>    callback. We have add a check of `in_s3` to keep current behavior in
>    function amdgpu_dm_early_fini(). So there should be no functional
>    changes.
> 2) set ip_blocks[i].status.late_initialized to false after calling
>    callback `early_fini`. We have auditted all usages of the
>    late_initialized flag and no functional changes found.
> 3) only set ip_blocks[i].status.valid =3D false after calling the
>    `late_fini` callback.
> 4) call amdgpu_ras_fini() before invoking ip_blocks[i].late_fini.
>
> Then we try to refine each subsystem, such as nbio, asic etc, to follow
> the new design. Currently we have only taken the nbio and asic as example=
s
> to show the proposed changes. Once we have confirmed that's the right way
> to go, we will handle the lefting subsystems.
>
> This is in early stage and requesting for comments, any comments and
> suggestions are welcomed!
>
>
> v2:
> - remove patch 1 in v1, it already got merged
> - convert status bool flags for ip block into enum
> - introduce iterators to walk ip blocks
> - refine the way to define status markers
> - split amdgpu_dm related change into a dedicated patch
> - add patch 13 to walk ip blocks in reverse order when shutdown
>
> Jiang Liu (15):
>   drm/amdgpu: add helper functions to track status for ras manager
>   drm/amdgpu: add a flag to track ras debugfs creation status
>   drm/amdgpu: free all resources on error recovery path of
>     amdgpu_ras_init()
>   drm/amdgpu: introduce a flag to track refcount held for features
>   drm/amdgpu: enhance amdgpu_ras_block_late_fini()
>   drm/amdgpu: enhance amdgpu_ras_pre_fini() to better support SR
>   drm/admgpu: rename amdgpu_ras_pre_fini() to amdgpu_ras_early_fini()
>   drm/amdgpu: make IP block state machine works in stack like way
>   drm/amdgpu_dm: enhance amdgpu_dm_early_fini() for PM ops
>   drm/admgpu: make device state machine work in stack like way
>   drm/amdgpu: convert ip block bool flags into an enum
>   drm/amdgpu: introduce IP block iterators to reduce duplicated code
>   drm/amdgpu: walk IP blocks in reverse order when shutdown
>   drm/amdgpu/nbio: improve the way to manage irq reference count
>   drm/amdgpu/asic: make ip block operations symmetric by .early_fini()
>
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  46 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 109 +++-
>  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 504 +++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  10 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  18 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c      |  16 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 142 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  16 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  14 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |   2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c       |   2 +-
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c        |   1 +
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |   1 +
>  drivers/gpu/drm/amd/amdgpu/nv.c               |  14 +-
>  drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  50 +-
>  drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     |  51 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c            |  38 +-
>  drivers/gpu/drm/amd/amdgpu/soc21.c            |  35 +-
>  drivers/gpu/drm/amd/amdgpu/soc24.c            |  22 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |   2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  10 +-
>  32 files changed, 668 insertions(+), 460 deletions(-)
>
> --
> 2.43.5
>
>

--000000000000aa73c8062c545577
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Is the latest version of this patch series (with possible =
fixes based on to comments) however maintained/available on some git tree f=
or testing?<br></div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jan 19, 2025 at 10:28=E2=80=AF=
PM Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhan=
g@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">[AMD Official Use Only - AMD Internal Distribution Only]<br>
<br>
Thanks for the patches.<br>
<br>
We currently have no plans to include RAS programming as part of the device=
 suspend/resume sequence. Instead, we are focusing on a series of clean up =
patches and a new RAS software module that will eliminate all legacy code/w=
orkarounds and also the changes you proposed here. It is not necessary to m=
ake this interim change in the upstream.<br>
<br>
Regards,<br>
Hawking<br>
<br>
-----Original Message-----<br>
From: Jiang Liu &lt;<a href=3D"mailto:gerry@linux.alibaba.com" target=3D"_b=
lank">gerry@linux.alibaba.com</a>&gt;<br>
Sent: Monday, January 13, 2025 09:42<br>
To: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com" tar=
get=3D"_blank">Alexander.Deucher@amd.com</a>&gt;; Koenig, Christian &lt;<a =
href=3D"mailto:Christian.Koenig@amd.com" target=3D"_blank">Christian.Koenig=
@amd.com</a>&gt;; Pan, Xinhui &lt;<a href=3D"mailto:Xinhui.Pan@amd.com" tar=
get=3D"_blank">Xinhui.Pan@amd.com</a>&gt;; <a href=3D"mailto:airlied@gmail.=
com" target=3D"_blank">airlied@gmail.com</a>; <a href=3D"mailto:simona@ffwl=
l.ch" target=3D"_blank">simona@ffwll.ch</a>; Khatri, Sunil &lt;<a href=3D"m=
ailto:Sunil.Khatri@amd.com" target=3D"_blank">Sunil.Khatri@amd.com</a>&gt;;=
 Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com" target=3D"_blank">Li=
jo.Lazar@amd.com</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhan=
g@amd.com" target=3D"_blank">Hawking.Zhang@amd.com</a>&gt;; Limonciello, Ma=
rio &lt;<a href=3D"mailto:Mario.Limonciello@amd.com" target=3D"_blank">Mari=
o.Limonciello@amd.com</a>&gt;; Chen, Xiaogang &lt;<a href=3D"mailto:Xiaogan=
g.Chen@amd.com" target=3D"_blank">Xiaogang.Chen@amd.com</a>&gt;; Russell, K=
ent &lt;<a href=3D"mailto:Kent.Russell@amd.com" target=3D"_blank">Kent.Russ=
ell@amd.com</a>&gt;; <a href=3D"mailto:shuox.liu@linux.alibaba.com" target=
=3D"_blank">shuox.liu@linux.alibaba.com</a>; <a href=3D"mailto:amd-gfx@list=
s.freedesktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a><br>
Cc: Jiang Liu &lt;<a href=3D"mailto:gerry@linux.alibaba.com" target=3D"_bla=
nk">gerry@linux.alibaba.com</a>&gt;<br>
Subject: [RFC v2 00/15] Enhance device state machine to better support susp=
end/resume<br>
<br>
Recently we were testing suspend/resume functionality with AMD GPUs, we hav=
e encountered several resource tracking related bugs, such as double buffer=
 free, use after free and unbalanced irq reference count.<br>
<br>
We have tried to solve these issues case by case, but found that may not be=
 the right way. Especially about the unbalanced irq reference count, there =
will be new issues appear once we fixed the current known issues. After ana=
lyzing related source code, we found that there may be some fundamental imp=
lementation flaws behind these resource tracking issues.<br>
<br>
The amdgpu driver has two major state machines to driver the device managem=
ent flow, one is for ip blocks, the other is for ras blocks.<br>
The hook points defined in struct amd_ip_funcs for device setup/teardown ar=
e symmetric, but the implementation is asymmetric, sometime even ambiguous.=
 The most obvious two issues we noticed are:<br>
1) amdgpu_irq_get() are called from .late_init() but amdgpu_irq_put()<br>
=C2=A0 =C2=A0are called from .hw_fini() instead of .early_fini().<br>
2) the way to reset ip_bloc.status.valid/sw/hw/late_initialized doesn&#39;t=
<br>
=C2=A0 =C2=A0match the way to set those flags.<br>
<br>
When taking device suspend/resume into account, in addition to device probe=
/remove, things get much more complex. Some issues arise because many suspe=
nd/resume implementations directly reuse .hw_init/.hw_fini/ .late_init hook=
 points.<br>
<br>
So we try to fix those issues by two enhancements/refinements to current de=
vice management state machines.<br>
<br>
The first change is to make the ip block state machine and associated statu=
s flags work in stack-like way as below:<br>
Callbacks=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 State after successfully execute callback<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMDGPU_IP_STATE_INVALID<br>
.early_init()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMDGPU=
_IP_STATE_EARLY<br>
.sw_init()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AMDGPU_IP_STATE_SW<br>
.hw_init()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AMDGPU_IP_STATE_HW<br>
.late_init()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0A=
MDGPU_IP_STATE_LATE<br>
.early_fini()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMDGPU=
_IP_STATE_HW<br>
.hw_fini()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AMDGPU_IP_STATE_SW<br>
.sw_fini()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AMDGPU_IP_STATE_EARLY<br>
.late_fini()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0A=
MDGPU_IP_STATE_INVALID<br>
<br>
Also do the same thing for ras block state machine, though it&#39;s much mo=
re simpler.<br>
<br>
The second change is fine tune the overall device management work flow as b=
elow:<br>
1. amdgpu_driver_load_kms()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_device_init()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_device_ip_ea=
rly_init()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ip_blocks[i].early_init()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ip_blocks[i].status.valid =3D true<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_device_ip_in=
it()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 amdgpu_ras_init()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ip_blocks[i].sw_init()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ip_blocks[i].status.sw =3D true<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ip_blocks[i].hw_init()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ip_blocks[i].status.hw =3D true<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_device_ip_la=
te_init()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ip_blocks[i].late_init()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ip_blocks[i].status.late_initialized =3D true<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 amdgpu_ras_late_init()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ras_blocks[i].ras_late_init()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_r=
as_feature_enable_on_boot()<br>
<br>
2. amdgpu_pmops_suspend()/amdgpu_pmops_freeze()/amdgpu_pmops_poweroff()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_device_suspend()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_ras_early_fi=
ni()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ras_blocks[i].ras_early_fini()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_ras_feature_disable()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_ras_suspend(=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 amdgpu_ras_disable_all_features()<br>
+++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ip_blocks[i].early_fini(=
)<br>
+++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ip_blocks[i].status.late=
_initialized =3D false<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip_blocks[i].suspen=
d()<br>
<br>
3. amdgpu_pmops_resume()/amdgpu_pmops_thaw()/amdgpu_pmops_restore()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_device_resume()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_device_ip_re=
sume()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ip_blocks[i].resume()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_device_ip_la=
te_init()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ip_blocks[i].late_init()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ip_blocks[i].status.late_initialized =3D true<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 amdgpu_ras_late_init()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ras_blocks[i].ras_late_init()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_r=
as_feature_enable_on_boot()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_ras_resume()=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 amdgpu_ras_enable_all_features()<br>
<br>
4. amdgpu_driver_unload_kms()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_device_fini_hw()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_ras_early_fi=
ni()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ras_blocks[i].ras_early_fini()<br>
+++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ip_blocks[i].early_fini(=
)<br>
+++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ip_blocks[i].status.late=
_initialized =3D false<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip_blocks[i].hw_fin=
i()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip_blocks[i].status=
.hw =3D false<br>
<br>
5. amdgpu_driver_release_kms()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_device_fini_sw()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_device_ip_fi=
ni()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ip_blocks[i].sw_fini()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ip_blocks[i].status.sw =3D false<br>
---=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ip_blocks[i].status.valid =3D false<br>
+++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0amdgpu_ras_fini()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ip_blocks[i].late_fini()<br>
+++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ip_blocks[i].status.valid =3D false<br>
---=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ip_blocks[i].status.late_initialized =3D false<br>
---=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0amdgpu_ras_fini()<br>
<br>
The main changes include:<br>
1) invoke ip_blocks[i].early_fini in amdgpu_pmops_suspend().<br>
=C2=A0 =C2=A0Currently there&#39;s only one ip block which provides `early_=
fini`<br>
=C2=A0 =C2=A0callback. We have add a check of `in_s3` to keep current behav=
ior in<br>
=C2=A0 =C2=A0function amdgpu_dm_early_fini(). So there should be no functio=
nal<br>
=C2=A0 =C2=A0changes.<br>
2) set ip_blocks[i].status.late_initialized to false after calling<br>
=C2=A0 =C2=A0callback `early_fini`. We have auditted all usages of the<br>
=C2=A0 =C2=A0late_initialized flag and no functional changes found.<br>
3) only set ip_blocks[i].status.valid =3D false after calling the<br>
=C2=A0 =C2=A0`late_fini` callback.<br>
4) call amdgpu_ras_fini() before invoking ip_blocks[i].late_fini.<br>
<br>
Then we try to refine each subsystem, such as nbio, asic etc, to follow the=
 new design. Currently we have only taken the nbio and asic as examples to =
show the proposed changes. Once we have confirmed that&#39;s the right way =
to go, we will handle the lefting subsystems.<br>
<br>
This is in early stage and requesting for comments, any comments and sugges=
tions are welcomed!<br>
<br>
<br>
v2:<br>
- remove patch 1 in v1, it already got merged<br>
- convert status bool flags for ip block into enum<br>
- introduce iterators to walk ip blocks<br>
- refine the way to define status markers<br>
- split amdgpu_dm related change into a dedicated patch<br>
- add patch 13 to walk ip blocks in reverse order when shutdown<br>
<br>
Jiang Liu (15):<br>
=C2=A0 drm/amdgpu: add helper functions to track status for ras manager<br>
=C2=A0 drm/amdgpu: add a flag to track ras debugfs creation status<br>
=C2=A0 drm/amdgpu: free all resources on error recovery path of<br>
=C2=A0 =C2=A0 amdgpu_ras_init()<br>
=C2=A0 drm/amdgpu: introduce a flag to track refcount held for features<br>
=C2=A0 drm/amdgpu: enhance amdgpu_ras_block_late_fini()<br>
=C2=A0 drm/amdgpu: enhance amdgpu_ras_pre_fini() to better support SR<br>
=C2=A0 drm/admgpu: rename amdgpu_ras_pre_fini() to amdgpu_ras_early_fini()<=
br>
=C2=A0 drm/amdgpu: make IP block state machine works in stack like way<br>
=C2=A0 drm/amdgpu_dm: enhance amdgpu_dm_early_fini() for PM ops<br>
=C2=A0 drm/admgpu: make device state machine work in stack like way<br>
=C2=A0 drm/amdgpu: convert ip block bool flags into an enum<br>
=C2=A0 drm/amdgpu: introduce IP block iterators to reduce duplicated code<b=
r>
=C2=A0 drm/amdgpu: walk IP blocks in reverse order when shutdown<br>
=C2=A0 drm/amdgpu/nbio: improve the way to manage irq reference count<br>
=C2=A0 drm/amdgpu/asic: make ip block operations symmetric by .early_fini()=
<br>
<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/aldebaran.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 46 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 109 +++-<br>
=C2=A0.../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c=C2=A0 |=C2=A0 =C2=A03 +-=
<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=C2=A0 =C2=A0 | 504 +++++++=
++---------<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_job.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 10 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A02 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 18 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
16 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A01 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A04 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 1=
42 +++--<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 16 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
14 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A02 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A02 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A02 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A01 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A01 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/nv.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 14 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c=C2=A0 =C2=A0|=C2=A0 50 +-=
<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
51 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/soc15.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 38 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/soc21.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 35 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/soc24.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 22 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +-<br>
=C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |=C2=A0 =C2=A03 +<br>
=C2=A0drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
10 +-<br>
=C2=A032 files changed, 668 insertions(+), 460 deletions(-)<br>
<br>
--<br>
2.43.5<br>
<br>
</blockquote></div>

--000000000000aa73c8062c545577--
