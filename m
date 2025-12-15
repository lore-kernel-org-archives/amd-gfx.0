Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C264D5B16C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 14:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0856A10E4F0;
	Mon, 15 Dec 2025 14:10:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eeY0dX0N";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA0310E4F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 14:10:23 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-34b3f61fd0cso282857a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 06:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765807823; x=1766412623; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hG37jU+EVKOozE2AaXJAFfrXUNC3UTy0+8dD6MtFnLI=;
 b=eeY0dX0NOUPfdIckbFI/u0USLHy1M0YxW0WvxkYu3Gyr1Zyu5PNiHWHRI2iwwdJHjM
 IJcbUe+fnwj+FT6Jbo74mHzyExdIbfJWIHHZ0TKCvQVnH9C7S/yN3yzESGdHqtuWQTVL
 SD69/rBU2sQxQY5f6qYik/rKNbC+ZM5Dw+QSGRxPxquKrT3WvIfMTvPCR8KvE9wOYNT5
 kUIad9FkbJ8qDory/jQF8R1nQgRMBOx6g3SrWy0PSz8kEhIlZ3q52iZF0SmvJEgPGMxg
 uVEJNcylZvPPFz2+fcsCgaCU7go9rA6wK5kGwk81kD7jpXfWDs7yDz1Lj0vCXlCgMVg8
 f9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765807823; x=1766412623;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hG37jU+EVKOozE2AaXJAFfrXUNC3UTy0+8dD6MtFnLI=;
 b=aES1ZAfGdTQ0B4hfqBnfmylbIDtl9DPNkJ6jlxzR0wuUUhzNzMYQ1i5vE4HihhS3Ye
 TMkozsidRueUwtgLp+ik1yXhprtraxn4mmQT3BKZmHEdWnVtghadhkzvHnHSy+vzvqTH
 moA9RxZ51v0Z9hD4al/RhOvgvum4QdvTBy0NK10o4KVYDQg0F/W7Wn8w/Fjqv0aViFwm
 gmcPdeoAXzGueHS3yE7owsERIAFeURn2fg77LpZaPLLgsFS0Tz11po5A5uiFU53gJS5g
 1XeHVIi3o9qEECVUBc2rIggZcN4Wke5fMea7Jq1OPnXPmy+MHX6K8z6ttD0pZFZJL7gT
 KYog==
X-Gm-Message-State: AOJu0Yxlj+Rdy2PR5oGpSTGORP8MnbkbTcVDEQu3YeGJ+Y6/LNcr8Wpf
 GGRqmkKSACLA/ml4AAAVIw/t1oL6Lkf4Dx2P5G7bnOwd/z6u3AekJ+Nm20PuxXSY7DredXx8Ka9
 FCxwivwwFwOtA4mSleQv95ALkvPzgwNFzhA==
X-Gm-Gg: AY/fxX5ad+DOB2Sqworfg9bRndP3UvCheOyoHb1MHnKv2OlB7jGvWv870K8tAp7UWsH
 4sCHHn0WFoF8U975CXKAyYm2GnPXyyG9G0jJc29agJlM8sdqxVIIrlqmrTTYpClyWPwkAg5TwcN
 +UtQa9Y+VvHAYRIEV+tBmofYRPUC6PuyVhmMuRN7PtFZdld5keV05dDmpppF2V7U52rGGFncHse
 XLW94qTJgHdNIpV3TFoZLaJlEMl515bFV/0UUJD9lpxTfZRavGtgNC44NEe23yjTdjaoAvh
X-Google-Smtp-Source: AGHT+IF5N13nGo8DKqJ0f0Z8RNlB65Eqglm2Ajg6FzGEZWkTLp8YGbWCORG970ZMjj7NYIk8G/+kiZbxoCuwRcpZDdk=
X-Received: by 2002:a05:7022:3a0d:b0:11e:3e9:3ea4 with SMTP id
 a92af1059eb24-11f34c52cc5mr4328302c88.6.1765807822938; Mon, 15 Dec 2025
 06:10:22 -0800 (PST)
MIME-Version: 1.0
References: <20251215033640.729151-1-likun.gao@amd.com>
 <DM4PR12MB5181DEE123782697DB04D57CEFADA@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5181DEE123782697DB04D57CEFADA@DM4PR12MB5181.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Dec 2025 09:10:10 -0500
X-Gm-Features: AQt7F2ocOpkkniZg764f_Q_uHL19W3QATWsgjrxL_U3FtuTPGgDNFpdFPQvPpOY
Message-ID: <CADnq5_Pu9sik5_YxifhmmgM=ExBzJvO27Xz351pkaXAAmJFuGg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove frame cntl for gfx v12
To: "Gao, Likun" <Likun.Gao@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Dec 14, 2025 at 10:44=E2=80=AFPM Gao, Likun <Likun.Gao@amd.com> wro=
te:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> From: Likun Gao <Likun.Gao@amd.com>
>
> Remove emit_frame_cntl function for gfx v12, which is not support.
>
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index b4dd954363ee..12a429fb1409 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -278,7 +278,6 @@ static void gfx_v12_0_select_se_sh(struct amdgpu_devi=
ce *adev, u32 se_num,
>                                    u32 sh_num, u32 instance, int xcc_id);=
  static u32 gfx_v12_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *a=
dev);
>
> -static void gfx_v12_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, boo=
l start, bool secure);  static void gfx_v12_0_ring_emit_wreg(struct amdgpu_=
ring *ring, uint32_t reg,
>                                      uint32_t val);
>  static int gfx_v12_0_wait_for_rlc_autoload_complete(struct amdgpu_device=
 *adev); @@ -4629,16 +4628,6 @@ static int gfx_v12_0_ring_preempt_ib(struct=
 amdgpu_ring *ring)
>         return r;
>  }
>
> -static void gfx_v12_0_ring_emit_frame_cntl(struct amdgpu_ring *ring,
> -                                          bool start,
> -                                          bool secure)
> -{
> -       uint32_t v =3D secure ? FRAME_TMZ : 0;
> -
> -       amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> -       amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
> -}
> -
>  static void gfx_v12_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t =
reg,
>                                      uint32_t reg_val_offs)
>  {
> @@ -5515,7 +5504,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_rin=
g_funcs_gfx =3D {
>         .emit_cntxcntl =3D gfx_v12_0_ring_emit_cntxcntl,
>         .init_cond_exec =3D gfx_v12_0_ring_emit_init_cond_exec,
>         .preempt_ib =3D gfx_v12_0_ring_preempt_ib,
> -       .emit_frame_cntl =3D gfx_v12_0_ring_emit_frame_cntl,
>         .emit_wreg =3D gfx_v12_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v12_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v12_0_ring_emit_reg_write_reg_wa=
it,
> --
> 2.34.1
>
