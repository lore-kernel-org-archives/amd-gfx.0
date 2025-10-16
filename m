Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC89CCD199
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 15:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42FD510EA20;
	Thu, 16 Oct 2025 15:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bU8rE3Yb";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73CB410EA20
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 15:14:32 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-33badfbd87aso146429a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760627672; x=1761232472; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVvQpF3KUkgQgqgHgCcfJ87d8hinP61HM/9iAbZQFqY=;
 b=bU8rE3YbXlv8IB1xa/ARvEt8L9CJ8psRDHb/+A9yU6oeGG2po2uRByTiTn2z7l7gO2
 IzZS1BscsWoDsr9aCHg6MvvFWR418et71S7NL1ns81X7vU/0vB5v06Oji0UmfooJUmIB
 N5zrBgXOiXhmR7YMiEpqNnAxjj9M8jGyKYqU86zuYfSjodH2EBTsHPl2KTgSdnUcpTC3
 TaSooBhZr6zTQzjTJnyGq/Sd6Df5mD/xDiEumTFI2IS+VCh51SmdVSqU0Diwm5lDoPS3
 jIUpdIQ6aW+rDZ3qkXKggbFc+RVbeepNtt3D7BKnG9rztcnzNLqYA7z9LPcDVP2KWHL9
 tnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627672; x=1761232472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oVvQpF3KUkgQgqgHgCcfJ87d8hinP61HM/9iAbZQFqY=;
 b=dGMc+P6shuWpARsJqS6YywzQHq25SDHWhgVQCD8xcqBCcu82re6EUR69lQQ06wb1Zm
 5HKgE7+5eA36ebekkYkhp9qv7Xz7SitAocdtGpcpCD/yW5EvpJhyS/U4ORRLXMvYpt/L
 T4LJNB+B7FAH8LDDOK176TF8gLGtgdleEa0P9qwEhjnEV6Hn0CDfcHhnER4dBxl4b66e
 77p0eKC6X9YsNIwBIIV6AoIeryNGgXkI9oTGMLCx+v1TwTMMyrUKamisbzFamV3V3g3W
 /s+JjQjx6hYaCk6HrdxLSGXfTjVbUgSlbU4MnKV66DReLir25GsH3pH1dirtaG+c+AQB
 HG4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUli7O/ZWX6fUAR5RP9ME/D4g1YLvur+NyXutbwf/fa++ZxRw/rSAlKzi87FuCyH67pc6YqZHQP@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEBM2F4Wz9hPsTmsOznQaRj9uNCdoQc+MWvKHtIlpMAGL+IhDx
 Shh/S4gbPqk6AFFjn9m6OmxI+QGGUzScmv4yJDgD7w1IvXY9OnTe++zzopfBdX4f0B+DKjqg1vn
 RZliPGqCw3juDd9Tep1JnBaRhomnHspk=
X-Gm-Gg: ASbGncsJ9N5Z6C1dI2m6yAjj+AN4rTZ7dhFPjavSFQGzraKp9On+1NxezOT4PgR0AJe
 T6YgVnfOOVudH0yglmWvBYmzaSFMbKbxHBQPfNm2wyvj2RXffc+YiQ/0tFohm+V+r18439sXMKt
 2jxiArIxXg2B+Ti7S6jwASpqCPGguPs41QreFlnstijxdv+WjZuEaESAw2HSDrGpZ1f2Qnydu3J
 PE11zTdQESFrN8FAUtotJhQmL18/o6ZCe7kxttlbNLboSL800sU7bQhHcpo
X-Google-Smtp-Source: AGHT+IHbp2NMgIs2iY73afZL6KYX7WtdwmjlN8sdUmtFh2t7Hhd5s+vvkiHWkURSRQRwetSIBQ8CpqX3+mNI5Ia4NfE=
X-Received: by 2002:a17:903:1a44:b0:261:500a:5742 with SMTP id
 d9443c01a7336-290ccbcfca4mr1465225ad.10.1760627671869; Thu, 16 Oct 2025
 08:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20251016065117.2797-1-yangtiezhu@loongson.cn>
In-Reply-To: <20251016065117.2797-1-yangtiezhu@loongson.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Oct 2025 11:14:20 -0400
X-Gm-Features: AS18NWDHTf0fchEiv7DyM7xymsV74cPNgZ3lvBAsNy5WIQInxOVbTb-EMiRSddk
Message-ID: <CADnq5_Mhxr87tT+zT4absJrygQtsUXzwkQAR__ffwCpGCLERBw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amd: Fix set but not used warnings
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

Alex

On Thu, Oct 16, 2025 at 3:06=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> There are many set but not used warnings under drivers/gpu/drm/amd when
> compiling with the latest upstream mainline GCC:
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:305:18: warning: variable =E2=
=80=98p=E2=80=99 set but not used [-Wunused-but-set-variable=3D]
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h:103:26: warning: variable =E2=
=80=98internal_reg_offset=E2=80=99 set but not used [-Wunused-but-set-varia=
ble=3D]
>   ...
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h:164:26: warning: variable =E2=
=80=98internal_reg_offset=E2=80=99 set but not used [-Wunused-but-set-varia=
ble=3D]
>   ...
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:445:13: warning:=
 variable =E2=80=98pipe_idx=E2=80=99 set but not used [-Wunused-but-set-var=
iable=3D]
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:875:21: warning:=
 variable =E2=80=98pipe_idx=E2=80=99 set but not used [-Wunused-but-set-var=
iable=3D]
>
> Remove the variables actually not used or add __maybe_unused attribute fo=
r
> the variables actually used to fix them, compile tested only.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c     | 4 +---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h      | 6 ++++--
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 9 +++------
>  3 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_gart.c
> index b2033f8352f5..83f3b94ed975 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -302,7 +302,6 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, u=
int64_t offset,
>                         int pages)
>  {
>         unsigned t;
> -       unsigned p;
>         int i, j;
>         u64 page_base;
>         /* Starting from VEGA10, system bit must be 0 to mean invalid. */
> @@ -316,8 +315,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, u=
int64_t offset,
>                 return;
>
>         t =3D offset / AMDGPU_GPU_PAGE_SIZE;
> -       p =3D t / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> -       for (i =3D 0; i < pages; i++, p++) {
> +       for (i =3D 0; i < pages; i++) {
>                 page_base =3D adev->dummy_page_addr;
>                 if (!adev->gart.ptr)
>                         continue;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index dc8a17bcc3c8..82624b44e661 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -100,7 +100,8 @@
>
>  #define SOC15_DPG_MODE_OFFSET(ip, inst_idx, reg)                        =
                       \
>         ({                                                               =
                       \
> -               uint32_t internal_reg_offset, addr;                      =
                       \
> +               /* To avoid a -Wunused-but-set-variable warning. */      =
                       \
> +               uint32_t internal_reg_offset __maybe_unused, addr;       =
                       \
>                 bool video_range, video1_range, aon_range, aon1_range;   =
                       \
>                                                                          =
                       \
>                 addr =3D (adev->reg_offset[ip##_HWIP][inst_idx][reg##_BAS=
E_IDX] + reg);           \
> @@ -161,7 +162,8 @@
>
>  #define SOC24_DPG_MODE_OFFSET(ip, inst_idx, reg)                        =
                       \
>         ({                                                               =
                       \
> -               uint32_t internal_reg_offset, addr;                      =
                       \
> +               /* To avoid a -Wunused-but-set-variable warning. */      =
                       \
> +               uint32_t internal_reg_offset __maybe_unused, addr;       =
                       \
>                 bool video_range, video1_range, aon_range, aon1_range;   =
                       \
>                                                                          =
                       \
>                 addr =3D (adev->reg_offset[ip##_HWIP][inst_idx][reg##_BAS=
E_IDX] + reg);           \
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/d=
rm/amd/display/dc/dc_dmub_srv.c
> index 53a088ebddef..6518d5639d66 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -442,7 +442,6 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool=
 should_manage_pstate, stru
>         int i =3D 0, k =3D 0;
>         int ramp_up_num_steps =3D 1; // TODO: Ramp is currently disabled.=
 Reenable it.
>         uint8_t visual_confirm_enabled;
> -       int pipe_idx =3D 0;
>         struct dc_stream_status *stream_status =3D NULL;
>
>         if (dc =3D=3D NULL)
> @@ -457,7 +456,7 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool=
 should_manage_pstate, stru
>         cmd.fw_assisted_mclk_switch.config_data.visual_confirm_enabled =
=3D visual_confirm_enabled;
>
>         if (should_manage_pstate) {
> -               for (i =3D 0, pipe_idx =3D 0; i < dc->res_pool->pipe_coun=
t; i++) {
> +               for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
>                         struct pipe_ctx *pipe =3D &context->res_ctx.pipe_=
ctx[i];
>
>                         if (!pipe->stream)
> @@ -472,7 +471,6 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool=
 should_manage_pstate, stru
>                                 cmd.fw_assisted_mclk_switch.config_data.v=
active_stretch_margin_us =3D dc->debug.fpo_vactive_margin_us;
>                                 break;
>                         }
> -                       pipe_idx++;
>                 }
>         }
>
> @@ -872,7 +870,7 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
>                 bool enable)
>  {
>         uint8_t cmd_pipe_index =3D 0;
> -       uint32_t i, pipe_idx;
> +       uint32_t i;
>         uint8_t subvp_count =3D 0;
>         union dmub_rb_cmd cmd;
>         struct pipe_ctx *subvp_pipes[2];
> @@ -899,7 +897,7 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
>
>         if (enable) {
>                 // For each pipe that is a "main" SUBVP pipe, fill in pip=
e data for DMUB SUBVP cmd
> -               for (i =3D 0, pipe_idx =3D 0; i < dc->res_pool->pipe_coun=
t; i++) {
> +               for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
>                         struct pipe_ctx *pipe =3D &context->res_ctx.pipe_=
ctx[i];
>                         pipe_mall_type =3D dc_state_get_pipe_subvp_type(c=
ontext, pipe);
>
> @@ -922,7 +920,6 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
>                                 populate_subvp_cmd_vblank_pipe_info(dc, c=
ontext, &cmd, pipe, cmd_pipe_index++);
>
>                         }
> -                       pipe_idx++;
>                 }
>                 if (subvp_count =3D=3D 2) {
>                         update_subvp_prefetch_end_to_mall_start(dc, conte=
xt, &cmd, subvp_pipes);
> --
> 2.42.0
>
