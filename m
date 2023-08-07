Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D90C04A6A
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 16:27:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B891010E2B7;
	Mon,  7 Aug 2023 16:27:13 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8540810E2B6;
 Mon,  7 Aug 2023 16:27:09 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-56cca35d8c3so2427194eaf.3; 
 Mon, 07 Aug 2023 09:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691425629; x=1692030429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xl2DiaD0s9sQaa1SCOAndOp0tHDVWN37eY0r1ePst1o=;
 b=njMVpHsYhL2VBL3zZH3RRrgun72OfQOP6X0/aLXBs7VpxEzzeikNKFDV/DhXnUZPNl
 MwGXg2CUpktyJhfFnHLruDoYJcUkhJtc6q1PWy6RoVTvpx7uMcGOT0D5IxClfxXHGTRw
 pZvRwx3fUB71Wmm07dOO9Fy+x3bKF3NOjkSZ/20uHbM9TixUA1CFQF22a/lHCQDFCvDa
 dhEKA1j309oMNL0AfuuhHPtjmkkgr4CVKr2xd2JVxS2aOp/p/Cc6S0LoYSCnAumbhhes
 TsRz60g/40cyiUrpeggAy/Y1oOBBbYZjyCQf7WPvEhlF1BZ0pgGLS+0zbuJiWKcWWBLa
 WytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691425629; x=1692030429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xl2DiaD0s9sQaa1SCOAndOp0tHDVWN37eY0r1ePst1o=;
 b=OjzjdFEuaXgSrwffVgfWOkwg2iGxPkhs2bPz9ROKSc4g7Q+6ulHMSrvV+q2aB9gxUJ
 ECIngTtQYPsuboHWvBYs56C4zx14H09OiBFgfIN24eNa5o+B5Kt2/NmbmPQ+vvI485Ru
 u8VDm1oPpCjOrV781r30JxY7hpH1GwgauUDKp9EZxnD5Rc2p5TwUH6x2H+Ie29vgvc7o
 ByS5gF11/nmj8prtWl+GvzphvnsdN6fiYamVo9HJkW0DCedbqeu7igh2WBfVwXYq2R76
 SWzEWFKlsXhzPhJPcS20jIroFrOTlU1Mr8CXvSbaM/ud4DgpLk6CD3mwMfE3xZ6ajN8j
 zsRg==
X-Gm-Message-State: AOJu0YxXqoSlM0DIH0/pTXoTdD84FzMiGwhuDg1zEVE5pSL6LkO328J9
 zx+5hGJwiy8bfi5AvBjl9gbIzZCiK8HAUZIwf1Y=
X-Google-Smtp-Source: AGHT+IGA12XTo+wO2CuNQhuwnZhSDv9RtIxAERcuRVoVohfV3PqzlU5Sf7PWlTaNdJ42RO4VAM7cuxqiEwxqdIKn5eQ=
X-Received: by 2002:a05:6870:148f:b0:1bb:c946:b80e with SMTP id
 k15-20020a056870148f00b001bbc946b80emr9673552oab.28.1691425628716; Mon, 07
 Aug 2023 09:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230801030851.5158-1-sunran001@208suo.com>
In-Reply-To: <20230801030851.5158-1-sunran001@208suo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Aug 2023 12:26:57 -0400
Message-ID: <CADnq5_OnifyV7Debd_GsGFA1yPkr454GLLb0d5Wsd00tg=V1aA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu10_hwmgr.c
To: Ran Sun <sunran001@208suo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com,
 airlied@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Mon, Jul 31, 2023 at 11:09=E2=80=AFPM Ran Sun <sunran001@208suo.com> wro=
te:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: spaces required around that '=3D' (ctx:VxW)
> ERROR: space required after that ',' (ctx:VxV)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drive=
rs/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 86d6e88c7386..02ba68d7c654 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -430,37 +430,37 @@ static int smu10_apply_state_adjust_rules(struct pp=
_hwmgr *hwmgr,
>  }
>
>  /* temporary hardcoded clock voltage breakdown tables */
> -static const DpmClock_t VddDcfClk[]=3D {
> +static const DpmClock_t VddDcfClk[] =3D {
>         { 300, 2600},
>         { 600, 3200},
>         { 600, 3600},
>  };
>
> -static const DpmClock_t VddSocClk[]=3D {
> +static const DpmClock_t VddSocClk[] =3D {
>         { 478, 2600},
>         { 722, 3200},
>         { 722, 3600},
>  };
>
> -static const DpmClock_t VddFClk[]=3D {
> +static const DpmClock_t VddFClk[] =3D {
>         { 400, 2600},
>         {1200, 3200},
>         {1200, 3600},
>  };
>
> -static const DpmClock_t VddDispClk[]=3D {
> +static const DpmClock_t VddDispClk[] =3D {
>         { 435, 2600},
>         { 661, 3200},
>         {1086, 3600},
>  };
>
> -static const DpmClock_t VddDppClk[]=3D {
> +static const DpmClock_t VddDppClk[] =3D {
>         { 435, 2600},
>         { 661, 3200},
>         { 661, 3600},
>  };
>
> -static const DpmClock_t VddPhyClk[]=3D {
> +static const DpmClock_t VddPhyClk[] =3D {
>         { 540, 2600},
>         { 810, 3200},
>         { 810, 3600},
> @@ -1358,7 +1358,7 @@ static int smu10_set_watermarks_for_clocks_ranges(s=
truct pp_hwmgr *hwmgr,
>         struct amdgpu_device *adev =3D hwmgr->adev;
>         int i;
>
> -       smu_set_watermarks_for_clocks_ranges(table,wm_with_clock_ranges);
> +       smu_set_watermarks_for_clocks_ranges(table, wm_with_clock_ranges)=
;
>
>         if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
>                 for (i =3D 0; i < NUM_WM_RANGES; i++)
> @@ -1461,7 +1461,7 @@ static int smu10_get_power_profile_mode(struct pp_h=
wmgr *hwmgr, char *buf)
>
>         phm_get_sysfs_buf(&buf, &size);
>
> -       size +=3D sysfs_emit_at(buf, size, "%s %16s %s %s %s %s\n",title[=
0],
> +       size +=3D sysfs_emit_at(buf, size, "%s %16s %s %s %s %s\n", title=
[0],
>                         title[1], title[2], title[3], title[4], title[5])=
;
>
>         for (i =3D 0; i <=3D PP_SMC_POWER_PROFILE_COMPUTE; i++)
> --
> 2.17.1
>
