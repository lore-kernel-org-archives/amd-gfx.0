Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40630C49EA1
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 21:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF50C89A88;
	Tue,  6 Aug 2024 21:32:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CLvwHfb3";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ABA889A88
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 21:32:30 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-70d1cbbeeaeso838382b3a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Aug 2024 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722979950; x=1723584750; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hC5aNvzBWUcvOEbA6XrmTTbBl2dIr2ue0+sfYz+pHnY=;
 b=CLvwHfb3FAVcXwbgl2h47naJnCGQHegOhMFboXMhYYx07H2J+rJqXtCUEmydNICRtB
 yxtmUmIh1kEVAV1rF4OMwYCfVWCOMhZPfdj6EUvmr6lFCK2IVpXc3C+ATl5V4AER3Tn9
 81Fbih4H6KI6pQWQEBIy5lJaVPIDtdxny2Hmb5v+A1Tkym+dTcDRP7viPAv9mNbdt+t9
 ctxUcxZsvPxg6iJb6hXE2lG6M5pLQvy2wc+TwbGh0iA/ohpCkMtZIuUNCjAcJQN/d+OH
 u09/rex2uU8/tNei7MiFN+rSYpJ06waikMdfmAMI3zr1TNKiXtwVFAjAnUDaSzTPr/Ba
 rjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722979950; x=1723584750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hC5aNvzBWUcvOEbA6XrmTTbBl2dIr2ue0+sfYz+pHnY=;
 b=kP9QhEIsKV+Bu/cvQYPOtBkxjh4eNWA1vyps+Qobk0ADPiTXRyTq5OG+RAebraaPv6
 SbsffMfm/jZ72o0lDauz+CheS24XFfp8Yw7DN8yA8QVGCzESeLMa4GZiibMJDWReizZm
 WSy9fQBGGCm2kew1iQ8WCFhKfXLnQswOZGLG0szoS3rXCrsl/wrDsIaByB0SYtd/BrL/
 R5M9OLwSa5a26NTe0ApyFKtifvLkX51MTD3ip0gm1FWrMV6nWobVvbOiJdffU+jkrtzg
 x7D3DbvQcQLXMWp4ZkuiZW06CKavLYTno8rBRYqfQgRUvrh3MFx57R4lA6T3IhfsgSkR
 aiAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6FqTSr74UHGaWs9guJzl25/JL+mfLjDPU2HekSx0L7grEDfkXDoH+oZoP07pS/R1rHxq/T0tRRcsWktAFsHLk0ovhkBKYpb/ZBQJpig==
X-Gm-Message-State: AOJu0YwdJ23RSMTaUsm2kszyBPLxLRfjCO/kPu/xKqda/TitXLvy0sYK
 Wap/YxibcldBCfyQPxCTFGa5X9oKJWTW4iyUHLAwd2ElLPw46VsLXejT8TKCKVYhEuYCA72fb1J
 7rfS4JIUOIlUN6Le7XZzMWYY5lMS7fQ==
X-Google-Smtp-Source: AGHT+IFbS3SjMo0LFAcoYos9Hh9mufqfNgGB+a/sUhVWP2sPiASdbuTsmoAExErF7C6W1vVghAG2llYN1WL78FBFbNQ=
X-Received: by 2002:a05:6a20:9191:b0:1c4:8293:76d0 with SMTP id
 adf61e73a8af0-1c69953c7camr18409548637.4.1722979949930; Tue, 06 Aug 2024
 14:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240806081825.2422771-1-sunil.khatri@amd.com>
 <20240806081825.2422771-7-sunil.khatri@amd.com>
In-Reply-To: <20240806081825.2422771-7-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Aug 2024 17:32:18 -0400
Message-ID: <CADnq5_PgwrRWLCRGpx2JMW4TiAbbuWyX_3eAphHreocw1K61cQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/15] drm/amdgpu: add print support for vcn_v4_0_3 ip
 dump
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Tue, Aug 6, 2024 at 4:18=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> Add support for logging the registers in devcoredump
> buffer for vcn_v4_0_3.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 34 ++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index dd3baccb2904..033e5c88527c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1823,6 +1823,38 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu=
_device *adev)
>         adev->vcn.inst->irq.funcs =3D &vcn_v4_0_3_irq_funcs;
>  }
>
> +static void vcn_v4_0_3_print_ip_state(void *handle, struct drm_printer *=
p)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +       int i, j;
> +       uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_4_0_3);
> +       uint32_t inst_off, is_powered;
> +
> +       if (!adev->vcn.ip_dump)
> +               return;
> +
> +       drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (adev->vcn.harvest_config & (1 << i)) {
> +                       drm_printf(p, "\nHarvested Instance:VCN%d Skippin=
g dump\n", i);
> +                       continue;
> +               }
> +
> +               inst_off =3D i * reg_count;
> +               is_powered =3D (adev->vcn.ip_dump[inst_off] &
> +                               UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) =
!=3D 1;

Actually, we shouldn't be checking whether or not VCN is powered up
when we print the results.  We've already stored the registers so we
don't care if VCN is powered at this point or not.  VCN could be
powered down by the time we print this.  It would be better to just
store a flag to determine whether or not we logged the registers in
the first place, then use that to determine whether or not we print
anything.  Same comment for the other VCN print_ip_state callbacks.

Alex

> +
> +               if (is_powered) {
> +                       drm_printf(p, "\nActive Instance:VCN%d\n", i);
> +                       for (j =3D 0; j < reg_count; j++)
> +                               drm_printf(p, "%-50s \t 0x%08x\n", vcn_re=
g_list_4_0_3[j].reg_name,
> +                                          adev->vcn.ip_dump[inst_off + j=
]);
> +               } else {
> +                       drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> +               }
> +       }
> +}
> +
>  static void vcn_v4_0_3_dump_ip_state(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> @@ -1871,7 +1903,7 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_func=
s =3D {
>         .set_clockgating_state =3D vcn_v4_0_3_set_clockgating_state,
>         .set_powergating_state =3D vcn_v4_0_3_set_powergating_state,
>         .dump_ip_state =3D vcn_v4_0_3_dump_ip_state,
> -       .print_ip_state =3D NULL,
> +       .print_ip_state =3D vcn_v4_0_3_print_ip_state,
>  };
>
>  const struct amdgpu_ip_block_version vcn_v4_0_3_ip_block =3D {
> --
> 2.34.1
>
