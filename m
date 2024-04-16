Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093BAC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 14:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69B5311292C;
	Tue, 16 Apr 2024 14:26:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L8Wge/m4";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1728511292C
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 14:26:55 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2a4bdef3d8eso3321289a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 07:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713277614; x=1713882414; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7lakBM3JwHnEFNpea70uubvAPbYrhJDivAcQFRrcw9Q=;
 b=L8Wge/m407dOye12x289itnmDu5uFBjL5G1O2kxXez56fmuQVyKTxnncIB7d6kFHaA
 //pbVC4UfyG96CkvnVcQ3hEAYHz4oYGHL591zNS5tUlTC5M6FTzOOWxjQ13EcC6rYY7v
 ys9T2qcONEl6U3qK+znVZBTjLbP+kJ0QTtX01l987pE6rNvragnkdFTnNfSQe5SJSXOL
 pzk1Vr1pWaEN/TcrcA8xTFm16uK90nljXGvplGkS//B2Y6lqgWWwuikHEUk965N4lOZM
 TShpe97YuUl5ba78wo0160HrIHT+XwVMIvzYVob1nKK2mQ4IWGlEzhEwmZCJZGRO6noR
 tU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713277614; x=1713882414;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7lakBM3JwHnEFNpea70uubvAPbYrhJDivAcQFRrcw9Q=;
 b=UVVf4bL7xIjpf3Q3CmA/W0d6+h4Za0TfO+5lSO/K6Ew4EyDIrGWUxbQG+skywi4ujJ
 HvKxupUq6yF4RssOGTVVeQUztW6pmB48c7CgmB9Gj0Tk3O1MVjSUwKQL58JVIxU9xSkO
 QDFV4m3IzOGeADqRJ7tNMobW4aHvN8LJwowRELE6H5RKnZMW0ZwLyUXuVPHvS6oTNX9A
 yt6NGe7flhQbspO3TtjMz+yxxJD6QCQY7GCtEuk0G3mdVo/pKBzsz+dQJ9mBYOWpmH6D
 TeHCcjrdpNlg1OVTxPZUDT7K6fCCahRdRqXw/N33nC9k6zxVxR2A8cb1q5rOi3j2XJix
 kvmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrUnYGkTwp9JtmfRGL1KJX0v1UWVKMNqzQ/Ekfrzi2VkGziOMllfzwjmBKPLXunLbhbK18tNjcsTfEBCcpwhi9dryJAEixGA5aSWx07Q==
X-Gm-Message-State: AOJu0Yxlhjqlm3Ko+CSSzq+BYZKAVtL7jFmB4QWZ8hih+UfEIA9kC8eb
 PLTcbOelTxhkHxJhhVRKpR2/ISZ13vfmwRtV2zaRzixP4VVDGZYnqC9mFWaqwjfw02I8aMOUUGG
 yQJ/QpgMUIV6wy4bseSiXw+/XJzaurQ==
X-Google-Smtp-Source: AGHT+IHKQ2mex7EO5YLfcjs+aluUYZP2s5FOwAM3rzGb7BqSypyDx0HPW96z/byvFAFSKcMiBECemWR8SwknE44RrDk=
X-Received: by 2002:a17:90b:180a:b0:2a2:55de:93eb with SMTP id
 lw10-20020a17090b180a00b002a255de93ebmr10313579pjb.33.1713277614331; Tue, 16
 Apr 2024 07:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240416133423.3346-1-sunil.khatri@amd.com>
 <20240416133423.3346-4-sunil.khatri@amd.com>
In-Reply-To: <20240416133423.3346-4-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Apr 2024 10:26:42 -0400
Message-ID: <CADnq5_NMw0c5X4MqiFA6Zoyx2NFn1aKffjEun_w7onT6O10UUw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] drm/amdgpu: enable redirection of irq's for IH V6.0
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

On Tue, Apr 16, 2024 at 9:34=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Enable redirection of irq for pagefaults for specific
> clients to avoid overflow without dropping interrupts.
>
> So here we redirect the interrupts to another IH ring
> i.e ring1 where only these interrupts are processed.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/ih_v6_0.c
> index 26dc99232eb6..8869aac03b82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -346,6 +346,21 @@ static int ih_v6_0_irq_init(struct amdgpu_device *ad=
ev)
>                             DELAY, 3);
>         WREG32_SOC15(OSSSYS, 0, regIH_MSI_STORM_CTRL, tmp);
>
> +       /* Redirect the interrupts to IH RB1 fpr dGPU */

fpr -> for

Alex

> +       if (adev->irq.ih1.ring_size) {
> +               tmp =3D RREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_IN=
DEX);
> +               tmp =3D REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_INDEX, IND=
EX, 0);
> +               WREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_INDEX, tmp=
);
> +
> +               tmp =3D RREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_DA=
TA);
> +               tmp =3D REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA, CLIE=
NT_ID, 0xa);
> +               tmp =3D REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA, SOUR=
CE_ID, 0x0);
> +               tmp =3D REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA,
> +                                   SOURCE_ID_MATCH_ENABLE, 0x1);
> +
> +               WREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_DATA, tmp)=
;
> +       }
> +
>         pci_set_master(adev->pdev);
>
>         /* enable interrupts */
> --
> 2.34.1
>
