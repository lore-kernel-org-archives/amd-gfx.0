Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5D3C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 12:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E1D910E6D5;
	Tue, 16 Jul 2024 12:39:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lePKgenf";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6265810E6D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 12:39:46 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-7163489149eso3944164a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 05:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721133586; x=1721738386; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4MZRHF1edB5CArxovEyZKWyEf/eV704DA+0VHa4/Jo=;
 b=lePKgenfVHZ4hJpxzpUfDXIGBq6VNXBqWPRWfrakNdHUDUIYC9nIhbEzcOo5KxZwZM
 EwOfdJVeP/GF4UOqX/2FYVLzd1+kXZOf2WOclghwp0erV27I94HwzRijZCo7nzKXyxgZ
 DE6BIkD15Dn2YS3vKkemBC13mIeIz0PvIH6C6zxHoFjF4fN35MMHZNV9Q7yPUbm/y6fg
 VxzVun1YdlKLpMKR4GIaEXZktnmDc39oaM8UZn/VeChcZHrA3OCRgV6pEEtdm5IDE94S
 7aWQBD56rDR+Qum5F8YwjrpIdfZVurGvVJDILAvbpCuDaRF20pQIidNWc7UtYMtFm8o8
 cNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721133586; x=1721738386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E4MZRHF1edB5CArxovEyZKWyEf/eV704DA+0VHa4/Jo=;
 b=hCQ/5FCZXn9l5sM9+glc1Kt2MteH/F9n+WeyotllLBHgOCUrAJ8XgqemRjomf1+JR+
 B+RDZXNGnVm57Evh2lh3/2S2qnTS3CWT4Rj/osH/SETG1p4EWOuE1r2XfKAPXgkhKEW3
 N9xjhUBQ7rXpc2VMH6ApJ3VJRllcVf1shi74LwBZU9Me/oX5qiejpra8niofhesNzCxH
 C2yNkr98ibkJKM63CwXe4MV3OWhums8M2eonqMMVnbHH0acFO2UaFUR1MU4BQ7jJp2Ls
 wTLjnC9NHpoCYynbodVnOXT58IocubpbPYcUc8VZP/WCTu0M2HEmpAsqtosx3/EWPE3S
 MoPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiPHfcJ+yR/bJxWTqFBpQWtDS1jHN0636Ln0D3aPz/1W3CRZ/g3+l+eb8CrCMbuuotyWcDPpZwSXgMbbTdGUXryYJyP3ufXo3DU3Bb1Q==
X-Gm-Message-State: AOJu0Yybog2qgW000KKz3KJDFTxAEa7nhh8FIwhcLoyDgmzzJ3nbYruJ
 brWIqmiybYSU3jYUaZBfdqMO+8rGj2MGGXVd0ALcVWaUZ42IlIhhsxFz1T0ttVrcEA33efIIlDn
 vgKG9GvHZjtqpTQh0dSmuruCXV1w=
X-Google-Smtp-Source: AGHT+IHfvdMRLT0hZJaftOEqoMJ4d3KTcYXugkHNlK5SsmQoipPcKnoaPZ2EDNjbpLWXzIv2MJTFr1pU6dXmr+N1PDE=
X-Received: by 2002:a05:6a21:32a7:b0:1c3:ac70:f579 with SMTP id
 adf61e73a8af0-1c3f129782amr2410799637.38.1721133585670; Tue, 16 Jul 2024
 05:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240716111940.932516-1-sunil.khatri@amd.com>
 <20240716111940.932516-6-sunil.khatri@amd.com>
In-Reply-To: <20240716111940.932516-6-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jul 2024 08:39:34 -0400
Message-ID: <CADnq5_NDpNKe5ZpW2+PwYmAbT-B2kaUT-w-6L38-Zm6L263m3g@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] drm/amdgpu: add print support for sdma_v_5_0
 ip_dump
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Jul 16, 2024 at 7:20=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Add support for ip dump for sdma_v_5_0 in devcoredump.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_0.c
> index cb324a90b310..d5f0dc132a47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1778,6 +1778,27 @@ static void sdma_v5_0_get_clockgating_state(void *=
handle, u64 *flags)
>                 *flags |=3D AMD_CG_SUPPORT_SDMA_LS;
>  }
>
> +static void sdma_v5_0_print_ip_state(void *handle, struct drm_printer *p=
)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +       int i, j;
> +       uint32_t reg_count =3D ARRAY_SIZE(sdma_reg_list_5_0);
> +       uint32_t instance_offset;
> +
> +       if (!adev->sdma.ip_dump)
> +               return;
> +
> +       drm_printf(p, "num_instances:%d\n", adev->sdma.num_instances);
> +       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +               instance_offset =3D i * reg_count;
> +               drm_printf(p, "\nInstance:%d\n", i);
> +
> +               for (j =3D 0; j < reg_count; j++)
> +                       drm_printf(p, "%-50s \t 0x%08x\n", sdma_reg_list_=
5_0[j].reg_name,
> +                                  adev->sdma.ip_dump[instance_offset + j=
]);
> +       }
> +}
> +
>  static void sdma_v5_0_dump_ip_state(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> @@ -1816,6 +1837,7 @@ const struct amd_ip_funcs sdma_v5_0_ip_funcs =3D {
>         .set_powergating_state =3D sdma_v5_0_set_powergating_state,
>         .get_clockgating_state =3D sdma_v5_0_get_clockgating_state,
>         .dump_ip_state =3D sdma_v5_0_dump_ip_state,
> +       .print_ip_state =3D sdma_v5_0_print_ip_state,
>  };
>
>  static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs =3D {
> --
> 2.34.1
>
